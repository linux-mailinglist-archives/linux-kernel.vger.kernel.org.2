Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003DA4347B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJTJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:16:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:16:07 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 498E71F43FBF;
        Wed, 20 Oct 2021 10:13:52 +0100 (BST)
Date:   Wed, 20 Oct 2021 11:13:47 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211020111347.627159a2@collabora.com>
In-Reply-To: <20211020084534.2472305-3-sean@geanix.com>
References: <20211020084534.2472305-1-sean@geanix.com>
        <20211020084534.2472305-3-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 10:45:32 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

>  static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
> @@ -1257,6 +1259,8 @@ int mtd_erase(struct mtd_info *mtd, sruct erase_info *instr)
>  
>  	ledtrig_mtd_activity();
>  
> +	mtd_start_access(master);
> +
>  	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION) {
>  		adjinstr.addr = (loff_t)mtd_div_by_eb(instr->addr, mtd) *
>  				master->erasesize;
> @@ -1278,6 +1282,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>  		}
>  	}
>  
> +	mtd_end_access(master);
> +

The section covered in mtd_erase() is too broad. Put the start/end
calls around the ->_erase() call.

>  	return ret;
>  }



> @@ -1576,7 +1604,6 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
>  		ret_code = mtd_read_oob_std(mtd, from, ops);
>  
>  	mtd_update_ecc_stats(mtd, master, &old_stats);
> -

Unrelated line removal. Please drop this change.

>  	/*
>  	 * In cases where ops->datbuf != NULL, mtd->_read_oob() has semantics
>  	 * similar to mtd->_read(), returning a non-negative integer
> @@ -1615,7 +1642,9 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
>  	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>  		return mtd_io_emulated_slc(mtd, to, false, ops);
>  
> -	return mtd_write_oob_std(mtd, to, ops);
> +	ret = mtd_write_oob_std(mtd, to, ops);
> +
> +	return ret;

Ditto, you can keep the 'return mtd_write_oob_std(mtd, to, ops);' here.

>  }
>  EXPORT_SYMBOL_GPL(mtd_write_oob);


> +static inline void mtd_start_access(struct mtd_info *master)
> +{
> +	WARN_ON_ONCE(master != mtd_get_master(master));
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

Please keep the tests consistent:

		wait_event(master->master.resume_wq, !master->master.suspended);

> +	}
> +}
> +
