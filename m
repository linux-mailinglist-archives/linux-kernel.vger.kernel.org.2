Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42730E322
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhBCTQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:16:40 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:40198 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhBCTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:16:39 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 76DB380F7;
        Wed,  3 Feb 2021 11:15:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 76DB380F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612379737;
        bh=0Ba7wQq+yd6bEiZD4x7v1uhSeliXjYFVZHpW3ghfO8A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VFCBhBrhqzAbYbEpixHoudazsIRp1p81UVJi7Dd0UfXWSm8NWtbcRdEjhEsASwcCs
         yga43ggw301N2cyeSNN90zCtrvp+Vbcms0XgqoXSHEvtHR82UV8UH7jdnmQBMUQJpT
         bA+lRF7u+hKas5mDDq5U1RyJlYBkewLP/nxnz5NU=
Subject: Re: [PATCH] misc: bcm-vk: Fix a couple error codes in probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        James Hu <james.hu@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YBpyEbmz00rjvT9S@mwanda>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <55880105-a097-0268-de54-478d7dbae084@broadcom.com>
Date:   Wed, 3 Feb 2021 11:15:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBpyEbmz00rjvT9S@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan,

On 2021-02-03 6:42 a.m., Dan Carpenter wrote:
> These errors should return negative error codes instead of returning
> success.
Do you have a script running to report such issues or just manually reviewing
to find such paths?
>
> Fixes: 064ffc7c3939 ("misc: bcm-vk: add autoload support")
> Fixes: 522f692686a7 ("misc: bcm-vk: add Broadcom VK driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index c3d2bba68ef1..a82a8927d92b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -1358,6 +1358,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
>  		if (!vk->bar[i]) {
>  			dev_err(dev, "failed to remap BAR%d\n", i);
> +			err = -ENOMEM;
>  			goto err_iounmap;
>  		}
>  	}
> @@ -1463,7 +1464,8 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
>  	if (auto_load) {
>  		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
> -			if (bcm_vk_trigger_autoload(vk))
> +			err = bcm_vk_trigger_autoload(vk);
> +			if (err)
>  				goto err_bcm_vk_tty_exit;
>  		} else {
>  			dev_err(dev,

