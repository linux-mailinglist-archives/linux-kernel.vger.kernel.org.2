Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA0E413958
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhIUSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhIUSAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:00:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E7C061764
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:58:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u27so5305970edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAQRdwZvo2PetrPwhyKMwT+BuxI4DnqIBXzomVmIPyk=;
        b=On/Dn8tx/v50MV2F7jYvu9mHnR2YMXX6YhAjyA/4oJaV5ksGOqBGnJj/B7tNt4Ey/f
         Pen2Mf6N2f3vm202OlQrQS3KQ05uXwE4E+8y9hDupn5bEB9EmxKPzAxkn6UTLNlYDdXw
         9VsL/RYoq4lUVdjOQBuq3Z8PtcSepcuVdchGpxagti5Cr87VxdKYVUG/lCfehD43oK7b
         Zws+lKlwLF5LYSKrKuvR4QA0XRaPKxz2wmvkU+uuQX3xnIxM3n+DN/RF9pCZB4J0dAY+
         EnJIH7Xu2rWzR7OjF6un1fm7toyXdY80oevroiabWjQxsXfQ+cn2lDeLSqK6nLKJvUFl
         U6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAQRdwZvo2PetrPwhyKMwT+BuxI4DnqIBXzomVmIPyk=;
        b=RN7iuVqiDPnOS3n1QX8E3oMROOYcUQ3NmxMyJj8INdcTHLNHM3w7J9u4WU5XSaZ+i2
         m4Jv3gRxc+uCIGZhiXSBszAeCGFLOfoSykQiA+fiipPZ+awwkb5HwprhNQGhowXWWhUi
         FdcYIPeIozYjDlj//6b5hJ91pxrEux+mIWbkryiBK04ezXlmeJZDO1w/cUixb5WXALNF
         MH1+Yp2Zu0DzNEzrq3+LZoa96Io4yURYBriL+KphZS0Hp2fzsZnQqzy5PD2rlv+rxp6x
         xSj1mThBLw5Jy3tXal/uuAplD3M8ZIs7XR9JDNl9WFJbMrHXUfXY6E1oB8IdRE4twUhn
         DB+Q==
X-Gm-Message-State: AOAM530KHxKetfKDWBfnwhYEZVazWlczJzwnVu9RuuPdk7LfgCD1zpvQ
        XH7Sfbp5qN6HFIMT44DtoP/AMcwMjRLVTyXqTUcLcw==
X-Google-Smtp-Source: ABdhPJznYRxLTR6o/CkFNOjLf/fUaZlmzxO+9yhzzY+5mAgEfBvS37qhJqGOmP9mnMfBIjdns7G47CJBoywmnt8OwYs=
X-Received: by 2002:a17:907:9908:: with SMTP id ka8mr37799779ejc.164.1632247124920;
 Tue, 21 Sep 2021 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210920190350.3860821-1-willmcvicker@google.com>
 <20210920190350.3860821-2-willmcvicker@google.com> <a8d40b96-bcb2-5eb6-b0e5-c20c14471c8a@kernel.org>
 <CAMuHMdWdHF49qj+qV-DnbDDv14J3y98TPHd_6y_i7o7_azhErg@mail.gmail.com> <2c8a79f7-711a-b075-745f-ea77b82a1117@canonical.com>
In-Reply-To: <2c8a79f7-711a-b075-745f-ea77b82a1117@canonical.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Tue, 21 Sep 2021 10:58:28 -0700
Message-ID: <CABYd82bzKh=QQHyk-kPXekzCKx+Uy-z2TY5qAQQNfuew=h=O-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] clk: samsung: change COMMON_CLK_SAMSUNG default
 config logic
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 1:35 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 21/09/2021 09:50, Geert Uytterhoeven wrote:
> > On Tue, Sep 21, 2021 at 9:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 20/09/2021 21:03, Will McVicker wrote:
> >>> COMMON_CLK_SAMSUNG is selected by ARCH_EXYNOS which forces this config
> >>> to be built-in when ARCH_EXYNOS is enabled. Switch the logic to use a
> >>> "default y if ARCH_EXYNOS" to provide flexibilty for vendors to disable
> >>> or modularize this driver.
> >>
> >> The clock drivers are essential, you cannot disable them for a generic
> >> kernel supporting ARCH_EXYNOS. Such kernel won't work properly on platforms.
> >
> > Obviously it's not gonna work if the clock driver is not enabled
> > at all.  But does it work if you make the clock driver modular, and
> > put it with all other essential driver modules in initramfs?  Debugging
> > would be hard, as the serial console driver also relies on clocks
> > and PM Domains etc.
>
> The kernel could boot without clock drivers (default settings from
> bootloader), probe clocks from initramfs and proceed with rootfs from
> eMMC/SD/net.
>
> In theory.
>
> However I have no reports that it ever worked. If there is such working
> upstream configuration, I don't mind here. Just please explain this in
> the commit msg.
>
> >
> > If not, this patch should be NAKed, until it works with a modular
> > clock driver.
> >
> > If yes, perhaps another line should be added (_before_ the other line)?
> >
> >   + default m if ARCH_EXYNOS && MODULES
> >     default y if ARCH_EXYNOS
> >
> > However, many developers may want MODULES=y, but not want to bother
> > with an initramfs.  So perhaps we need a new symbol
> > MINIMUM_GENERIC_KERNEL or so, protected by EXPERT, and make the
> > driver default to m if that is enabled?
>
> Yeah, that's indeed a problem to solve. For most users (and distros)
> building kernel for Exynos this should be built-in by default.
>
> Anyway, the option is non-selectable so it cannot be converted to "m" or
> disabled. And this is claimed in the commit msg:
> "provide flexibilty for vendors to disable or modularize this driver."
>
> The commit does not achieve it.
>
> Best regards,
> Krzysztof

Thanks for the reviews! As Lee has explained in his replies, the
intent of this series is to provide config flexibility to create a
defconfig that allows us to move out SoC specific drivers in order to
create a generic kernel that can be used across multiple devices with
different SoCs. I'm sorry I added confusion by mentioning
modularization. All of these drivers that I am modifying in this
series can be modularized which is an ongoing effort, but is not
addressed here and I don't believe that modularizing them should be a
requirement before supporting enabling/disabling them.

I will update the series with my patch that refactors the Samsung SoC
drivers menuconfig to make these visible as well.

Thanks,
Will
