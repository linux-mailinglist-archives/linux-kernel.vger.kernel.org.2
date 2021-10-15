Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934F242E970
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhJOG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:57:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58324 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhJOG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:57:24 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 651671F4502B;
        Fri, 15 Oct 2021 07:55:17 +0100 (BST)
Date:   Fri, 15 Oct 2021 08:55:11 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: core: protect access to MTD devices while in
 suspend
Message-ID: <20211015085511.0e2ac916@collabora.com>
In-Reply-To: <20211011115253.38497-2-sean@geanix.com>
References: <20211011115253.38497-1-sean@geanix.com>
        <20211011115253.38497-2-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 13:52:51 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

>  struct mtd_info {
> @@ -476,10 +478,49 @@ static inline u32 mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
>  	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
>  }
>  
> +static inline void mtd_start_access(struct mtd_info *mtd)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);

mtd_start_{access,end}() should only be called on master devices, so I
guess you can drop the mtd_get_master() call and use mtd directly.
Maybe add a WARN_ON_ONCE(mtd != mtd_get_master(mtd)) so we can
easily catch silly mistakes.

> +
> +	/*
> +	 * Don't take the suspend_lock on devices that don't
> +	 * implement the suspend hook. Otherwise, lockdep will
> +	 * complain about nested locks when trying to suspend MTD
> +	 * partitions or MTD devices created by gluebi which are
> +	 * backed by real devices.
> +	 */
> +	if (!master->_suspend)
> +		return;
> +
> +	/*
> +	 * Wait until the device is resumed. Should we have a
> +	 * non-blocking mode here?
> +	 */
> +	while (1) {
> +		down_read(&master->master.suspend_lock);
> +		if (!master->master.suspended)
> +			return;
> +
> +		up_read(&master->master.suspend_lock);
> +		wait_event(master->master.resume_wq, master->master.suspended == 0);
> +	}
> +}
> +
> +static inline void mtd_end_access(struct mtd_info *mtd)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +
> +	if (!master->_suspend)
> +		return;
> +
> +	up_read(&master->master.suspend_lock);
> +}
> +
>  static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
>  				     loff_t ofs, size_t len)
>  {
>  	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>  
>  	if (!master->_max_bad_blocks)
>  		return -ENOTSUPP;
> @@ -487,8 +528,12 @@ static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
>  	if (mtd->size < (len + ofs) || ofs < 0)
>  		return -EINVAL;
>  
> -	return master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
> -				       len);
> +	mtd_start_access(mtd);
> +	ret = master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
> +				      len);
> +	mtd_end_access(mtd);

Please pass the master to those functions, there's no point walking the
parent chain again in the start/end_access() functions if you already
have the master retrieved in the caller. Oh, and there seems to be a
common pattern here, so maybe it's worth adding those macros:

#define mtd_no_suspend_void_call(master, method, ...) \
	mtd_start_access(master); \
	master->method(master, __VA_ARGS__); \
	mtd_end_access(master);

#define mtd_no_suspend_ret_call(ret, master, method, ...) \
	mtd_start_access(master); \
	ret = master->method(master, __VA_ARGS__); \
	mtd_end_access(master);

I don't really like the helper names, so feel free to propose something
else.

> +
> +	return ret;
>  }
>  

