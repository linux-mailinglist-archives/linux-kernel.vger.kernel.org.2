Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE39C3CBABF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGPQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:54:06 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56661 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhGPQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:54:05 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 46A79C0004;
        Fri, 16 Jul 2021 16:51:09 +0000 (UTC)
Date:   Fri, 16 Jul 2021 18:51:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] Input: adc-keys - drop bogus __refdata annotation
Message-ID: <YPG4/N9nVuPvEuqq@piout.net>
References: <7091e8213602be64826fd689a7337246d218f3b1.1626255421.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7091e8213602be64826fd689a7337246d218f3b1.1626255421.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2021 11:38:33+0200, Geert Uytterhoeven wrote:
> As the ADC ladder input driver does not have any code or data located in
> initmem, there is no need to annotate the adc_keys_driver structure with
> __refdata.  Drop the annotation, to avoid suppressing future section
> warnings.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I must admit I can't remember why I used that annotation...

> ---
>  drivers/input/keyboard/adc-keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
> index 6d5be48d1b3d7988..bf72ab8df817756f 100644
> --- a/drivers/input/keyboard/adc-keys.c
> +++ b/drivers/input/keyboard/adc-keys.c
> @@ -193,7 +193,7 @@ static const struct of_device_id adc_keys_of_match[] = {
>  MODULE_DEVICE_TABLE(of, adc_keys_of_match);
>  #endif
>  
> -static struct platform_driver __refdata adc_keys_driver = {
> +static struct platform_driver adc_keys_driver = {
>  	.driver = {
>  		.name = "adc_keys",
>  		.of_match_table = of_match_ptr(adc_keys_of_match),
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
