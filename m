Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62424313FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhBHUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbhBHSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:22:25 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2EC0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:21:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l3so6647149oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/6qzm5KZjVpY/QzjBwjI8Vq6UfMUyCiZgQDTe4g04Js=;
        b=bxtDkLUWrKlJbPvM+jLfS8mCKCZwiI+jYVHmSbVHEdnMKKDWCwbDMx1u4JoCotMd86
         jpuHSVKLSdvYumtDRShyyRZWBOz6z1cwykOVpK90620JyQF79VJvkofMNFqpManNxZgK
         Ahm5BbXg9l8iodZB4CVJrKOEOct471xOuycq1+AMk7eywGux9yzCV47I2NLgn/HZKsA5
         Sy7fyEHXNhuJ/CE8ZxFso48MhgXsCdXqseuYphZGyOxMJ2ZSYXdt/j/v914THaZ7hNZY
         ywfaUDikqO1A3vCqtSn1xr0qTN1DunOOYGtqk90yICZeJ3xg/Bq2w6K+racW4OerdImi
         APlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6qzm5KZjVpY/QzjBwjI8Vq6UfMUyCiZgQDTe4g04Js=;
        b=n1dK2HPHPaKzRh841/0B4+pwHmUwtmUyMxVGRi5boG8n/VcAziQ6FF1XBllY4ssxLj
         dFOkHu/4DNCQP6Ec7Zdn+PCIvEXztaKIB0wCsn+3nthPEtNhWZU1GBY0Ntj0ezGUY/Gk
         S3Bh8v886Mp2z2LHx5imO8kBXsrOnJZ/zrWWsEv9wkMTIYADqkIEZLalD/W3wOJ4TPvq
         lsJMw5XPE5JVxOhB9HfvOf0CDKNJV4s++iS6F7JCVIqaznCIS9fLyBQ24Z3eMKMgNXH/
         Ar5vfmAQ2BpZpjzr6prMEVvrvKX+GF9EnSyEJTwv1YYJ32pAbFnIKpCaLvIciIzK2PT3
         BRtA==
X-Gm-Message-State: AOAM532BAdAlBvxbOSTjAh0h48sT9ovCfzgu7cS049z3MTQsqZWE5Xyk
        FXJuNuyAUT5bw6+zUCfXUHAV6A==
X-Google-Smtp-Source: ABdhPJzFxujF8FdJ9rDgJh66bsfw8Jea1OwoyzKak4GDomOyVWtD7WQiDcq3QdmAsvzxsDQBvxe4Qg==
X-Received: by 2002:aca:7541:: with SMTP id q62mr15579oic.143.1612808485225;
        Mon, 08 Feb 2021 10:21:25 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t2sm3937004otj.47.2021.02.08.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:21:24 -0800 (PST)
Date:   Mon, 8 Feb 2021 12:21:22 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [GIT PULL 2/3] ARM: dts: samsung: DTS for v5.12
Message-ID: <YCGBIvRfoP0BeyrP@builder.lan>
References: <20210125191240.11278-1-krzk@kernel.org>
 <20210125191240.11278-3-krzk@kernel.org>
 <20210206134531.l5vpzlmev4v3f3uo@kozik-lap>
 <CAK8P3a0Kgn9PTHjsU7MbJPC8vatvb9KYJJKWxrx7zQzTNgK10g@mail.gmail.com>
 <CAMuHMdWZ8QmiQCmiW9AvCpviNZeuaxThSo_4Xb2DGEs9hMTKMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWZ8QmiQCmiW9AvCpviNZeuaxThSo_4Xb2DGEs9hMTKMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 06 Feb 13:47 CST 2021, Geert Uytterhoeven wrote:

> Hi Arnd,
> 
> On Sat, Feb 6, 2021 at 3:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > That said, I'm still not happy about the patch we discussed in the
> > other email thread[1] and I'd like to handle it a little more strictly in
> > the future, but I agree this wasn't obvious and we have been rather
> > inconsistent about it in the past, with some platform maintainers
> > handling it way more strictly than others.
> >
> > I've added the devicetree maintainers and a few other platform
> > maintainers to Cc here, maybe they can provide some further
> > opinions on the topic so we can come to an approach that
> > works for everyone.
> >
> > My summary of the thread in [1] is there was a driver bug that
> > required a DT binding change. Krzysztof and the other involved
> > parties made sure the driver handles it in a backward-compatible
> > way (an old dtb file will still run into the bug but keep working
> > with new kernels), but decided that they did not need to worry
> > about the opposite case (running an old kernel with an updated
> > dtb). I noticed the compatibility break and said that I would
> > prefer this to be done in a way that is compatible both ways,
> > or at the minimum be alerted about the binding break in the
> > pull request, with an explanation about why this had to be done,
> > even when we don't think anyone is going to be affected.
> >
> > What do others think about this? Should we generally assume
> > that breaking old kernels with new dtbs is acceptable, or should
> > we try to avoid it if possible, the same way we try to avoid
> > breaking new kernels with old dtbs? Should this be a platform
> > specific policy or should we try to handle all platforms the same
> > way?
> 
> For Renesas SoCs, we typically only consider compatibility of new
> kernels with old DTBs, not the other way around.
> However, most DTB updates are due to new hardware support, so using the
> new DTB with an old kernel usually just means no newly documented
> hardware, or new feature, is being used by the old kernel.
> 

This is the case for the Qualcomm tree as well, it's expected that a new
kernel should work with older DT. But, while we don't actively try to
break it, there are plenty of examples where we don't/can't give the
promise in the other direction.

These examples ranges from advancements in power management
(implementation and binding) to DT validation forcing deprecation and
adoption of new bindings.

Regards,
Bjorn
