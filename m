Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF744AD03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhKIL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbhKIL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:58:42 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F36C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:55:57 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u74so12038753oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmxUA056LoQ6k99jaGWjOIpUmiYexsv2HwljU2EFRE0=;
        b=N9hW88pun/80QDT7+KjR303qqqT4zVYIi+XRWtMn/4HiWTRgNwQWFEERAYSeVCzeRF
         kMxi2K6lIYVaaHWO4taF6dKSBiuaKVmm4RDBwFFcfG2cswNYdyCL0pthAVHfmisINLCR
         6iDMG7zRPO6TlFu1GMsAM4jSgn1ubQ6dzE/afRQ2FbMOZw8nLuwqSuI2Dofftp5b85HY
         ziTe4PApDuFjJjBGBLgkYNM6pFW84mHZkhmgISQqiqZMAbKkrpJ8hZtJQEwjKj0DdL9e
         oeUydszlDQXa0HRP0GeJczKTSN9jJPsxDUwpSocuXAjRlry/9KcWFtAxyoHU/dz6D5Kg
         GGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmxUA056LoQ6k99jaGWjOIpUmiYexsv2HwljU2EFRE0=;
        b=nOoVckpcf3aaWsuvS550o/05GQVSmM2mdm4XWl0OSNXGdBb+IwxCbCtXCEC0CzgW9O
         didjcLuNFHbhSR/hFLLfFhfPxZXbuzLclbXqPrvrjQm+PGXc0lRBswcZxluNPlL+paCy
         pplK1cn79ZYbSnmEgpiRZo6UO78U8VmCrigerCWwLE+rjEScdVC39u1KUAq3XOcD0E3L
         o1yoCEBBu/npfaHnreDyCBk3h36qHXuBt+gbUZxihl5zbPUdTrKSUN4mshrIbmXDwAca
         JadByGDYs+WI0tYMDywEWn2iainVruzwnfCyvO6wGlryZ88KhUWMUXg0iv1Xz0jqH4TE
         RVxQ==
X-Gm-Message-State: AOAM530THo2VJAPmDMHNCK/jCvwXiTTqe0CugV8cWgOaGFz/tU2m5TxH
        /U5KZ3TZcIuWx7L6mVU1MubWTdtADGx5RFN9XyeByw==
X-Google-Smtp-Source: ABdhPJx0fwGz0nnYBXwkfboQajG0B+6ZNJQLSjASSX+GWOr9XfINOwcTdLMikJbS4mJSmY4hzz/NoIV7GnSrek6EKQs=
X-Received: by 2002:a54:4791:: with SMTP id o17mr5362981oic.114.1636458956589;
 Tue, 09 Nov 2021 03:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20211105124242.27288-1-andriy.shevchenko@linux.intel.com>
 <20211105124242.27288-14-andriy.shevchenko@linux.intel.com>
 <4b3f1ee1179dd6d4b010cb110b38d26e7d91c19f.camel@perches.com>
 <CAHp75Ve0Bv9VsWFFZxL9wYk=Z_Mm7nat-vf7g8HHTiROi7EY=Q@mail.gmail.com>
 <103d7321a2d18e44fb8c01483b1197766aff645a.camel@perches.com> <YYjtLGlSCDPM4UVL@smile.fi.intel.com>
In-Reply-To: <YYjtLGlSCDPM4UVL@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:55:44 +0100
Message-ID: <CACRpkdZQsR1yisaCgmSDfG8OtkYgu1tWPBa_mw25o++suLjf4A@mail.gmail.com>
Subject: Re: [PATCH v1 14/19] pinctrl: st: Use temporary variable for struct device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 10:26 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > IMO: the strarray variants introduction and use should be a separate
> > patchset from the rest.
>
> It will add unnecessary churn. Yeah, I have planned to send just that, but then
> it took more and more cleanups and I have to stop at some point, the code there
> is bad (historically or by other reasons, dunno).

I trust your judgement and taste to a large extent so this will not be
necessary. I can queue the whole series in pinctrl when you
think it's mature.

The library bits I kind of feel uncertain about who maintains, but I might just
apply it.

Yours,
Linus Walleij
