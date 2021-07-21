Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34F73D154B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhGURCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhGURCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:02:14 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C2C061575;
        Wed, 21 Jul 2021 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TjEvLNNHsaSMgTUGcuTFfcltWUToJtf32CG/+sem9oM=; b=RWW2ghceWcYcdYf59J7wku4SgX
        asTxnafzEldcqxfOMw1hGEdAJbe/ScWiax0dQA7D85esoVmpNgp8d4+5kXxKOvvLby8ISnjRMFJXW
        HpX2W4ASw/7bu60u3IoHBLTlRxbEyA1chCshKjtqylSh896BX9g7YHb7zYSUGLBDYkgUwNoAphm/7
        CBk3LLu6hK8QLzH0PGJDJkrVlqZVHCbe9yav+wQ+dQPlIFCGpZP5SRe7miyZOr4cYWO+lNXjDL9rv
        79wdYqYXlLNb52v/tXFO+VlJeXhMkMkk0lNl6C0tWfeFIvsTOiHpDKFpTY7m7HsMTo4/UE+KIukTK
        TdpPnndg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:61963 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1m6GF5-00034t-Ej; Wed, 21 Jul 2021 19:42:47 +0200
Subject: Re: [PATCH v2 3/3] drm/panel: Add ilitek ili9341 panel driver
To:     dillon.minfei@gmail.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     dianders@chromium.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
 <1626853288-31223-4-git-send-email-dillon.minfei@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <8e091b9c-764d-d410-559e-3c5e25de2a3c@tronnes.org>
Date:   Wed, 21 Jul 2021 19:42:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1626853288-31223-4-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 21.07.2021 09.41, skrev dillon.minfei@gmail.com:
> From: Dillon Min <dillon.minfei@gmail.com>
> 
> This driver combine tiny/ili9341.c mipi_dbi_interface driver
> with mipi_dpi_interface driver, can support ili9341 with serial
> mode or parallel rgb interface mode by register configuration.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> ---

> +static const struct of_device_id ili9341_of_match[] = {
> +	{
> +		.compatible = "st,sf-tc240t-9370-t",
> +		.data = &ili9341_stm32f429_disco_data,
> +	},
> +	{
> +		/* porting from tiny/ili9341.c
> +		 * for original mipi dbi compitable
> +		 */
> +		.compatible = "adafruit,yx240qv29",

I don't understand this, now there will be 2 drivers that support the
same display?

AFAICT drm/tiny/ili9341.c is just copied into this driver, is the plan
to remove the tiny/ driver? If so I couldn't see this mentioned anywhere.

Noralf.

> +		.data = NULL,
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, ili9341_of_match);
