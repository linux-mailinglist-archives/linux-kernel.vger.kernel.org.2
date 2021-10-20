Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694BF434762
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJTIzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJTIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:55:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2295C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:53:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 32EFD1F43F4A;
        Wed, 20 Oct 2021 09:53:29 +0100 (BST)
Date:   Wed, 20 Oct 2021 10:53:26 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: rawnand: nand_bbt: hide suspend/resume
 hooks while scanning bbt
Message-ID: <20211020105326.0dca864a@collabora.com>
In-Reply-To: <20211020084534.2472305-2-sean@geanix.com>
References: <20211020084534.2472305-1-sean@geanix.com>
        <20211020084534.2472305-2-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 10:45:31 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> The BBT scan logic use the MTD helpers before the MTD layer had a
> chance to initialize the device, and that leads to issues when
> accessing the uninitialized suspend lock. Let's temporarily set the
> suspend/resume hooks to NULL to skip the lock acquire/release step.
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Tested-by: Sean Nyekjaer <sean@geanix.com>

It's missing our Signed-off-by tags.

> ---
>  drivers/mtd/nand/raw/nand_bbt.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index b7ad030225f8..93d385703469 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -1397,8 +1397,28 @@ static int nand_create_badblock_pattern(struct nand_chip *this)
>   */
>  int nand_create_bbt(struct nand_chip *this)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(this);
> +	int (*suspend) (struct mtd_info *) = mtd->_suspend;
> +	void (*resume) (struct mtd_info *) = mtd->_resume;
>  	int ret;
>  
> +	/*
> +	 * The BBT scan logic use the MTD helpers before the MTD layer had a
> +	 * chance to initialize the device, and that leads to issues when
> +	 * accessing the uninitialized suspend lock. Let's temporarily set the
> +	 * suspend/resume hooks to NULL to skip the lock acquire/release step.
> +	 *
> +	 * FIXME: This is an ugly hack, so please don't copy this pattern to
> +	 * other MTD implementations. The proper fix would be to implement a
> +	 * generic BBT scan logic at the NAND level that's not using any of the
> +	 * MTD helpers to access pages. We also might consider doing a two
> +	 * step initialization at the MTD level (mtd_device_init() +
> +	 * mtd_device_register()) so some of the fields are initialized
> +	 * early.
> +	 */
> +	mtd->_suspend = NULL;
> +	mtd->_resume = NULL;
> +
>  	/* Is a flash based bad block table requested? */
>  	if (this->bbt_options & NAND_BBT_USE_FLASH) {
>  		/* Use the default pattern descriptors */
> @@ -1422,7 +1442,13 @@ int nand_create_bbt(struct nand_chip *this)
>  			return ret;
>  	}
>  
> -	return nand_scan_bbt(this, this->badblock_pattern);
> +	ret = nand_scan_bbt(this, this->badblock_pattern);
> +
> +	/* Restore the suspend/resume hooks. */
> +	mtd->_suspend = suspend;
> +	mtd->_resume = resume;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(nand_create_bbt);
>  

