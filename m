Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0F400C2B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhIDQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhIDQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 12:44:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58AC061575;
        Sat,  4 Sep 2021 09:43:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s10so4629921lfr.11;
        Sat, 04 Sep 2021 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wh1mYqXbigd70L6uyNc1nuoAq3q+tfDVrUyZbdPnbZg=;
        b=iXLM08nMa44bOzPVU5aaFVmqvZKrs+Ybnrz+NmNg88DHQv5tvS8yqQWkjL80Wqry1T
         ExBK71a+BdNdvsuJVFKy9eiahchEbwVZ4jrJxzuyxjjqOZwtW57wdrF1YEzTAli4ouNU
         OVDw1gYu+lRFtE8FF0msbNC6OdV9SwrDM1zF1Iy6fiCD6jsnMr7saeojM17d3QdPPWML
         ucxLHdZvULFpx/qqiBhryZ96yZNkS2CYPZVKXnIIhNxA3uj+cNXlbRaZEJIUYmY+9kPG
         TMXNq+W5dKR4BeXQ3wEs+1Ix/WRRjN54hXoKEJ8A4w6vI1GR5R+QJd3wFhP8jgmHAvDp
         B96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wh1mYqXbigd70L6uyNc1nuoAq3q+tfDVrUyZbdPnbZg=;
        b=QbAAUV2pqlZqSpxTWIl5CnY7O1pOoBmOgfzVi1PGZYvfqFNnqnMhsjmDV3NizRBFwX
         zcMMxID3xpoNCNDjho2+FPP8exiu76a2ePUZVoNNP9wWvrvMnPTqvlus8oKXwukG2yv+
         mPMaGtqebD94Tvp5MrI2uPk0VodCV/xS/A/PoZrT7uRhDqcU7+nctCqXLK/p/jn0Jb/k
         0AjcxI1fgP+Gm/ODRefLwKt+wC4HhoBX24EVuJR7TNlHA/jZdnjZt2wPvDMtK31gN/oJ
         TiLjRE0tMkVtSq8tsbPrgEyU2k6OyGr1ZQLcMBEMvlXsw1AHi87IpIgxp3MsBFOpymgD
         36ww==
X-Gm-Message-State: AOAM53278I/I0qXH7im7z3Zta6rDiuzjMGryI+RsihgnecS0U7q/1DFX
        1FKoDTpDd39k0CrbUreTM5q5uK8Qy5qerK6He+w=
X-Google-Smtp-Source: ABdhPJwZ+0KMEOizcDmymxx6a0MZNPjAp4tyydXooOiL8jAkWr0KSCGNISjKPFpo3S+RDol2iLdbQioP35eJnUnErmQ=
X-Received: by 2002:a05:6512:108d:: with SMTP id j13mr3483211lfg.113.1630773810406;
 Sat, 04 Sep 2021 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210904152946.32042-1-miles.chen@mediatek.com>
In-Reply-To: <20210904152946.32042-1-miles.chen@mediatek.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 Sep 2021 13:43:18 -0300
Message-ID: <CAOMZO5AE4uGXk47uhWKLch8RDmUrvvw0zDPM+wxgz4uWJD6eGA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: use module_platform_driver
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

On Sat, Sep 4, 2021 at 12:29 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> Replace builtin_platform_driver_probe with module_platform_driver_probe
> because CONFIG_CLK_IMX8QXP can be set to =m (kernel module).
>
> Fixes: c2cccb6d0b33 ("clk: imx: add imx8qxp clk driver")
> Fixes: 1e3121bfe51a ("clk: imx: add imx8qxp lpcg driver")

The correct Fixes tag would be:

Fixes: e0d0d4d86c766 ("clk: imx8qxp: Support building i.MX8QXP clock
driver as module")

Thanks
