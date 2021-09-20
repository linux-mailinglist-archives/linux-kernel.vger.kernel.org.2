Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DB411992
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhITQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:18:19 -0400
Received: from phobos.denx.de ([85.214.62.61]:54364 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242910AbhITQQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:16:24 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 918D080EEA;
        Mon, 20 Sep 2021 18:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632154496;
        bh=yS7en13J7rnW4XQUJmNyAzrBQGHNd4sbRM9BKk+8/RQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0Usi7mEBrbAF92TAqjuUGCtU+1XQG2HXo0deDO7YIQiCqI+kuDmP2ro1lWIRqGm/b
         5lZ68/WOSVpFnkjXQ6jWvoNZd0nYBwAkDVkDb7lBz4PzleNNmnS+Pk5T7JUXJisbCT
         JD+aqUPdiSVBdbeNN1yzHyHvD0O46N19UJWqBBC926MfphR3li+vReIXuyQMNVGGKz
         mA7IgKlLk5zYU/SNin00Wnm7vENzT9N2eS+/7zwE6G11EuFYyjGyv++7/nhUI/RgLF
         JfnIGhwYBLV6Z7ese3U96jBbLmlklms13sjVCz778wKbyl3JlPSeUEVXb1vTguw5DT
         0xlmz0lRyVvrQ==
Subject: Re: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver as
 module
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "andreas@kemnade.info" <andreas@kemnade.info>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "pzimmermann@dh-electronics.com" <pzimmermann@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-6-marcel@ziswiler.com>
 <dc987232-8687-a3cc-cc44-9e82e94ddd52@denx.de>
 <b399f461991b3dc6ba3d3332a054e7feea1d37f1.camel@toradex.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <f4d57f8e-2c84-0abb-7031-1f878eb28c08@denx.de>
Date:   Mon, 20 Sep 2021 18:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b399f461991b3dc6ba3d3332a054e7feea1d37f1.camel@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 5:55 PM, Marcel Ziswiler wrote:
> On Mon, 2021-09-20 at 16:52 +0200, Marek Vasut wrote:
>> On 9/20/21 4:49 PM, Marcel Ziswiler wrote:
>>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> Build CONFIG_IMX_SDMA as a module to avoid the following boot issue:
>>>
>>> [    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
>>>    imx/sdma/sdma-imx6q.bin failed with error -2
>>> [    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
>>>    for: imx/sdma/sdma-imx6q.bin
>>
>> Isn't there some ROM-side SDMA firmware baked into the MX6 which is used
>> as a fallback if loading newer one from filesystem fails ? I suspect the
>> default ROM firmware might be buggy.
> 
> I'm not so sure about this. At least it seems to fail if no external firmware can be loaded.

See e.g. SDMA chapter in MX6SDLRM or similar, it does talk about 4k boot 
ROM, which contains scripts and utilities later referenced by scripts in 
RAM. It might be worth looking into that a bit further, but that seems 
like a separate topic from this patch.
