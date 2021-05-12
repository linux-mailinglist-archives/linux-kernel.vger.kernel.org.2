Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D3237B7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELIXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:23:45 -0400
Received: from mail.thorsis.com ([92.198.35.195]:33649 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhELIXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:23:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 76CE01CB9;
        Wed, 12 May 2021 10:22:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LWs2yfX3cEE8; Wed, 12 May 2021 10:22:34 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 348FF297F; Wed, 12 May 2021 10:22:32 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: thorsis.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Wed, 12 May 2021 10:22:22 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ubifs: fix snprintf() checking
Message-ID: <YJuQPqyKYJZQbHqJ@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: Dan Carpenter <dan.carpenter@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YJouQKMQZe1I2kkg@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJouQKMQZe1I2kkg@mwanda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Tue, May 11, 2021 at 10:12:00AM +0300 schrieb Dan Carpenter:
> The snprintf() function returns the number of characters (not
> counting the NUL terminator) that it would have printed if we
> had space.
> 
> This buffer has UBIFS_DFS_DIR_LEN characters plus one extra for
> the terminator.  Printing UBIFS_DFS_DIR_LEN is okay but anything
> higher will result in truncation.  Thus the comparison needs to be
> change from == to >.
> 
> These strings are compile time constants so this patch doesn't
> affect runtime.
> 
> Fixes: ae380ce04731 ("UBIFS: lessen the size of debugging info data structure")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mtd/ubi/debug.c | 2 +-
>  fs/ubifs/debug.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index ac2bdba8bb1a..3c0c8eca4d51 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -511,7 +511,7 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
>  
>  	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
>  		     ubi->ubi_num);
> -	if (n == UBI_DFS_DIR_LEN) {
> +	if (n > UBI_DFS_DIR_LEN) {
>  		/* The array size is too small */
>  		return -EINVAL;
>  	}
> diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> index 1bbb9fe661b1..fc718f6178f2 100644
> --- a/fs/ubifs/debug.c
> +++ b/fs/ubifs/debug.c
> @@ -2824,7 +2824,7 @@ void dbg_debugfs_init_fs(struct ubifs_info *c)
>  
>  	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
>  		     c->vi.ubi_num, c->vi.vol_id);
> -	if (n == UBIFS_DFS_DIR_LEN) {
> +	if (n > UBIFS_DFS_DIR_LEN) {
>  		/* The array size is too small */
>  		return;
>  	}

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex
