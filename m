Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B1410D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhISTfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhISTfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 15:35:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64CC061574;
        Sun, 19 Sep 2021 12:33:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so57902148lfu.5;
        Sun, 19 Sep 2021 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//B2Hpu5/xauwOgPmPqTbeXr4ZLTN1upLRNXP06hC5k=;
        b=CrdjAQ29/2mBLcHoxHfe5NgsXwjJG9Qgh+ch5j0CME2xdxBqrsjG3dPUzD+Z07ed53
         1QjzzYiu2mHyibLs4hm6axPRYW5mtSWcG+ZwiDums+XpJeai2Jy94VRDNb4x8gQA/n1h
         Xyska+4NuQjuKnWO0Bg9BOFclhpZBubpzG7L+MUgHIBLVc12ESF7v2BcV74xRFu2QYmm
         HpS/iIgHY172AxyDvrEZpzKL5SUDef0XJQHLmElmIaLCVlat+Thgipu9/nrn6ua8nFEY
         aM46fLV28RtXxSQ4ldIeTDHb04UsefGKdmVm7O7P0bzy156w5vvvgwUMl+2hUxEukX3N
         H6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//B2Hpu5/xauwOgPmPqTbeXr4ZLTN1upLRNXP06hC5k=;
        b=zf4WCIER8LrzUiMC8cmuDaKHxtm4FPk5EKWevV/1i5yxp3kvU6ymW5oipbr4JwBnnG
         RdYNx+lnJnJLQkqwHEJnfukwBgBNzjoiKSj7f1xBPaOycTtVlCCVeecfVs8rP9WqjOi1
         S2uE9t5yYS8iduTYjdf2OZqw43g4/LlQ1T6unnyrcSRcteqQTZ4RAIXDDzvHmXH1dKW+
         3FwBGZXvsNau9wRmk+ixGmbNW9OW985cN+kySzH12g4K+wyyz3l65Q6pWodR+8WoJWSK
         WOURGsXSWvM/alXx/u9dJ+xdkc/7rE9sQWUftpOafW+VBYO3BnESSF9FYHSzie+kTJV4
         oTFA==
X-Gm-Message-State: AOAM531MYnDSSLuzK1c5MWVd693bUb8CfP47SsIM+72OpjzmXdxZmfDE
        wi1SpK9siMJwdNt/9+zq7JNTCdqfzNmxvTtIWUI=
X-Google-Smtp-Source: ABdhPJyBFKyPjSZOjN7+JdMHrm34Qy8/BBDj+DOvZMwbs4xSIbJuxHKBUemWC8uLafvxaLRxBjR0y3IFkdCey3klyD0=
X-Received: by 2002:a2e:99d8:: with SMTP id l24mr9113575ljj.294.1632080036090;
 Sun, 19 Sep 2021 12:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com> <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
In-Reply-To: <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Sun, 19 Sep 2021 21:33:45 +0200
Message-ID: <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Fabio Estevam <festevam@gmail.com>
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

Hi Fabio,

Am So., 19. Sept. 2021 um 15:08 Uhr schrieb Fabio Estevam <festevam@gmail.com>:
>
> Hi Heiko,
>
> On Sun, Sep 19, 2021 at 7:10 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> > Meanwhile I figured out that in ci_hdrc_imx_probe() the "fsl,usbphy"
> > node is not found [1]. But I do not understand why.
> >
> > The following failure leads to the return code of -19 (ENODEV) and
> > sets the pyh to NULL:
> > "failed to get fsl,usbphy phandle in /soc@0/bus@32c00000/usb@32e40000 node"
>
> Since commit:
> commit 78e80c4b4238c1f5642b975859664fced4f9c69e
> Author: Marek Vasut <marex@denx.de>
> Date:   Wed Jul 21 18:39:55 2021 +0200
>
>     arm64: dts: imx8m: Replace deprecated fsl,usbphy DT props with phys
>
>     The fsl,usbphy DT property is deprecated, replace it with phys DT
>     property and specify #phy-cells. No functional change.
>
>     Signed-off-by: Marek Vasut <marex@denx.de>
>     Cc: Fabio Estevam <festevam@gmail.com>
>     Cc: NXP Linux Team <linux-imx@nxp.com>
>     Cc: Shawn Guo <shawnguo@kernel.org>
>     To: linux-arm-kernel@lists.infradead.org
>     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>
> Don't we need to search for 'phys' too?
>
> Does this patch help?
> https://pastebin.com/raw/yZKz1huL

I can confirm that on the next-20210915 (that includes commit
78e80c4b4238c1f5642b975859664fced4f9c69e) your provided patch solves
the problem.

But is it explainable that in the version before the commit
78e80c4b4238c1f5642b975859664fced4f9c69e the problem occurs in the
form I reported?

-- 
Heiko
