Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060F3FFC02
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhICIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348135AbhICIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:32:25 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B612C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:31:24 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 00DCC5C1FB7;
        Fri,  3 Sep 2021 10:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1630657403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=649dDLEsTpY20f1ujpD4Ab5GxIseeAzBCbsCN967yd0=;
        b=mD90OOChPsCYRklb3tv2eE3zeOCpGUJuCBEyZoaA69+HCnicdvw0D/XfIykaJsH3jR+rpx
        Z3l/XhF+SIfc+qvE7IYiICPo0lV2CDB64S1Uyb9QXiNkLPoHo+qJXuT0rU6J9nCG5RGW5a
        GALTdK7nKYlDJLtBytORL7Wptov1jzI=
MIME-Version: 1.0
Date:   Fri, 03 Sep 2021 10:23:22 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: vf610: Make use of the helper function
 devm_platform_ioremap_resource()
In-Reply-To: <20210901074245.9583-1-caihuoqing@baidu.com>
References: <20210901074245.9583-1-caihuoqing@baidu.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <26cdf34dbda1327f60da32b9c29130a6@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 09:42, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Acked-by: Stefan Agner <stefan@agner.ch>

> ---
>  drivers/mtd/nand/raw/vf610_nfc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index 40d70f991d89..a2b89b75073f 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -807,7 +807,6 @@ static const struct nand_controller_ops
> vf610_nfc_controller_ops = {
>  static int vf610_nfc_probe(struct platform_device *pdev)
>  {
>  	struct vf610_nfc *nfc;
> -	struct resource *res;
>  	struct mtd_info *mtd;
>  	struct nand_chip *chip;
>  	struct device_node *child;
> @@ -831,8 +830,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	if (irq <= 0)
>  		return -EINVAL;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nfc->regs = devm_ioremap_resource(nfc->dev, res);
> +	nfc->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(nfc->regs))
>  		return PTR_ERR(nfc->regs);
