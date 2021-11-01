Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6C44144B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKAHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhKAHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:43:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F64C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 00:41:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8FA071F42B21;
        Mon,  1 Nov 2021 07:41:06 +0000 (GMT)
Date:   Mon, 1 Nov 2021 08:40:59 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211101084059.5b703b8b@collabora.com>
In-Reply-To: <20211026055551.3053598-4-sean@geanix.com>
References: <20211026055551.3053598-1-sean@geanix.com>
        <20211026055551.3053598-4-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 07:55:50 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> @@ -1406,6 +1423,7 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
>  		    const u_char *buf)
>  {
>  	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>  
>  	*retlen = 0;
>  	if (!master->_panic_write)
> @@ -1419,8 +1437,12 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
>  	if (!master->oops_panic_write)
>  		master->oops_panic_write = true;
>  
> -	return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
> -				    retlen, buf);
> +	mtd_start_access(master);
> +	ret = master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
> +				   retlen, buf);
> +	mtd_end_access(master);
> +
> +	return ret;
>  }

I suspect panic_write should be an exception, otherwise a panic in the
suspend path would never be able to write its data to the flash.
