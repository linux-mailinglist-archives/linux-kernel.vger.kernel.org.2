Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4941179A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhITOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:54:09 -0400
Received: from phobos.denx.de ([85.214.62.61]:50482 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235913AbhITOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:54:07 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 952278032E;
        Mon, 20 Sep 2021 16:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632149559;
        bh=mWel+Ll5MqcCfFYbNd4hHyMgPVHWMoQLTKADiaroKSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hgjsoXaW0rdyvdHPkxZz7CYCHBOVKu2+0O0Kzj6BroZbCfffsHJTcKpDgo4wILG6D
         RMPEQ7HQrCPucikaA108bBN/IXoS+hi5e+lsGTaiCzByrqtYDEP/GdMFoXobtnYWPF
         mJX0Ou/CvhfeX1CYaFq5g8S86/hoSe6HlYKKU+PFHUEX2s4EZ77h3We6rKyFjWmGsG
         quk7rpy1OgkNwf4EVbf5M1cTJNDuaXtMhJhl14Pc9OvLixtzp3pm+k8zco7ILIu/UR
         h9JymzNUg4iKYUCTauMMYaDL+enLm/W/GSVWapQ8IkzrarAY7ud1ob+M47NZuolioX
         p66V4IbZwuPtg==
Subject: Re: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver as
 module
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-6-marcel@ziswiler.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <dc987232-8687-a3cc-cc44-9e82e94ddd52@denx.de>
Date:   Mon, 20 Sep 2021 16:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920144938.314588-6-marcel@ziswiler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 4:49 PM, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build CONFIG_IMX_SDMA as a module to avoid the following boot issue:
> 
> [    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
>   imx/sdma/sdma-imx6q.bin failed with error -2
> [    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
>   for: imx/sdma/sdma-imx6q.bin

Isn't there some ROM-side SDMA firmware baked into the MX6 which is used 
as a fallback if loading newer one from filesystem fails ? I suspect the 
default ROM firmware might be buggy.
