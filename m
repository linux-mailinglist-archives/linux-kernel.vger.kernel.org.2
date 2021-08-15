Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B43EC900
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhHOMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhHOMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:32:12 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3BC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:31:41 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B95F980661;
        Sun, 15 Aug 2021 14:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629030698;
        bh=nQY6qqdT6huVToGeMTGVRdsLDdRQvPBapmnRWJDxrts=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RU1j9tOFbT4v0es7JJsrpsjGP24guhL+lFpp0jXf884nwY2A+ZWA6x1jU7ImskAyS
         T08wcKxuXfivJpQlZ5Icx8dUte2j09TATb7ZxVUgKsAQr7ioCPUMsvEx5MXZIXIE1m
         UhJCG2xTDao5iSPGV8e/B22Lz5oNXRF0WktNGgFnMJL/CNFmojJ/yp8uiG/31+lWi+
         8LcMUN17oP9pLeDQHD7pUXa57dmfF+luSsXxpSR+/fFpea8FiAtwyOBDT4vfsLMBvj
         0rDqMVhsDmNdlPqwtNyNI2exqt+DAk5RXxneenQRZAGYtVKBYViNXGYEuUPZZlE9NJ
         Lrw/jgB+UG8PA==
Subject: Re: Revert "video: fbdev: mxsfb: Remove driver"
To:     Alistair Francis <alistair23@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Sam Ravnborg <sam@ravnborg.org>
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <d983217b-e117-361c-0306-b131695bb93f@denx.de>
Date:   Sun, 15 Aug 2021 14:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 2:16 PM, Alistair Francis wrote:
> Hello,
> 
> Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
> mxsfb fbdev driver.
> 
> I am now working on getting mainline Linux running on the reMarkable 2
> eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
> controller on the i.MX SoC, but instead uses the LCD controller.
> 
> eInk panels are complex to control and require writing temperature
> dependent waveforms. As these waveforms are proprietary [2] the rM
> team runs closed source software called SWTCON in userspace to control
> the panel [3].
> 
> This closed source software expects the fbdev mxsfb driver and it
> doesn't work with the DRM mxsfb driver (at least not that I can get it
> to).
> 
> The NXP fork of Linux also re-adds the fbdev driver [4], so they also
> see some uses for it.
> 
> I was wondering if the community would be open to re-adding the fbdev
> mxsfb driver to mainline? It could be re-added with a different
> dt-binding so that it is not used by default and only enabled for
> boards when required (like for the rM2).
> 
> 1: https://remarkable.com/store/remarkable-2
> 2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
> 3: https://remarkablewiki.com/tech/rm2_framebuffer
> 4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0

+CC Sam.

What sort of special thing does your proprietary userspace do that 
cannot be added to the DRM driver or the fbdev emulation (if needed) ?
