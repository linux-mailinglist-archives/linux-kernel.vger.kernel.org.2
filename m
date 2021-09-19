Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D55410BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhISNKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhISNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:10:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981DC061574;
        Sun, 19 Sep 2021 06:08:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z24so28705723lfu.13;
        Sun, 19 Sep 2021 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcEPIoY3k9qxwzfdbDZ//w0r6omQmazpmeVbRNF7nXY=;
        b=JJs/uDbuZx9ziCsrmOLjR1FRXWtqpGf5BPRXv0OR6GFJSBHEW2nz1iHCETGUvOx60N
         fAlSOyQdA8YDMaDkKbczLwlT5Uw2T9OsyxkkfasL+UBrm2TR3jDBYbndutNUdnxTgNaw
         aK1WoVCc03/VstHzetMCwjeoew3X6ULBkY9rZBWTEpYXe+0zz4TeDW2tswLdA22+0N61
         2dfd1AGMYyDJVKbNuZn3AIrzebktRvltL/M7rzYSdO6ukwwM0fYAlqc8c3s/viWCd4DG
         LUyYo0w9YhWzXi3yIeCMKYoUKxrNhqEXuPj2vIThICS72IUXPlvOTUkynu0mnUefSkh6
         7iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcEPIoY3k9qxwzfdbDZ//w0r6omQmazpmeVbRNF7nXY=;
        b=PqwfR9dNiDbnduuWh73yHWmdvrHymxVHbc1t4v9bdmJbbhW8WXUu1PW9lYQ2GUnrIi
         6VUc2hettkuVz+7lCG92RLkFctjXStkzKlDNQgrHbNg6yBY9yfoyErsSCVR0K6ZYrVeJ
         hQOzFf/NKgAUU2XQhKbtAuxiRUM/qbI5aBeYWdoijDPFBqLrxNEiwo5g/w/5Yt2027WX
         JztwX/CweC8Qv/2ioa8hX07DutMWxhcNSesfedlsCWotQjvxo41EJsQFb8PL67vnltn5
         kfeg9VwG6X8Qzet8+FL08Nj1lU2w4GTIz2Zzzg8Qijk9WZAMmCRbNfgEjGlF7i3V9auO
         OLNQ==
X-Gm-Message-State: AOAM530i3kuUaKfPCc8iQnh5ldZYjsE5sv0+TJKgfq3NENfC+VcNuW4q
        Xwf374LMaUcwLjiye8kjLWE02yRnQNnUUEJ2G0c=
X-Google-Smtp-Source: ABdhPJw0yMEOciph+9m0mW+B1kRsaoDRQrf4o3kqOIn+JngAM+OCnsUKGDQMueSz5SFxdiPXSxSaF/l2frY5Ov4RP2k=
X-Received: by 2002:a2e:6e06:: with SMTP id j6mr18269887ljc.382.1632056914152;
 Sun, 19 Sep 2021 06:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
In-Reply-To: <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 19 Sep 2021 10:08:22 -0300
Message-ID: <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Sun, Sep 19, 2021 at 7:10 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> Meanwhile I figured out that in ci_hdrc_imx_probe() the "fsl,usbphy"
> node is not found [1]. But I do not understand why.
>
> The following failure leads to the return code of -19 (ENODEV) and
> sets the pyh to NULL:
> "failed to get fsl,usbphy phandle in /soc@0/bus@32c00000/usb@32e40000 node"

Since commit:
commit 78e80c4b4238c1f5642b975859664fced4f9c69e
Author: Marek Vasut <marex@denx.de>
Date:   Wed Jul 21 18:39:55 2021 +0200

    arm64: dts: imx8m: Replace deprecated fsl,usbphy DT props with phys

    The fsl,usbphy DT property is deprecated, replace it with phys DT
    property and specify #phy-cells. No functional change.

    Signed-off-by: Marek Vasut <marex@denx.de>
    Cc: Fabio Estevam <festevam@gmail.com>
    Cc: NXP Linux Team <linux-imx@nxp.com>
    Cc: Shawn Guo <shawnguo@kernel.org>
    To: linux-arm-kernel@lists.infradead.org
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Don't we need to search for 'phys' too?

Does this patch help?
https://pastebin.com/raw/yZKz1huL
