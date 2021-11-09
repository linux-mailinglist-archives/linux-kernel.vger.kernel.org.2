Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70B44ACC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbhKILo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbhKILo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:44:58 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D13C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:42:12 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r26so11875914oiw.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhp9TzcF0FJk80drP2WtwN9HUs+vg3LkkMoIt6RpEF4=;
        b=olwR8eKIQydywoP9wwQ49hUplsRYThhLBucewwDhwt7sW0N8FghwRqb2YTfFmmQaAM
         eoOHY/s2eMATsA0TyHJz6KNPgGrwLjAq1yAYu3pqPbg4ILcyfhlt4XBS1maL5zZGM8SB
         /J5eUploIL+HdOCmiSCrzSExX+tnB8XZ/yeaby54qp5/GAhldTb++/1lgFAWnNT/gozP
         A2+m2Aa9liTusE9rl+++t+wQUwKU9sndyzWTo28y3+L8i4AZgXoGb1JB+PIGHFMdTkAd
         +CWj2/pK7Czc/z1j0ov7mWhnuifK7Zecv6IVdudLEJIIlnN8ttiE2Awf1Uu/iQgP0MQ+
         A4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhp9TzcF0FJk80drP2WtwN9HUs+vg3LkkMoIt6RpEF4=;
        b=NnZV3XrjE8gNNAreupZWAL2sO8it76N9mrfmEZCl45oDTxn5kTUrRFScTUmfIMrpR0
         MOeRe3eRVF61Eddc4CffRfqJm+3RyT375Wwn+1calxrb9ZNRZ+dPGGv06OuUihXbp/3Z
         P8n88kxdt3Tw4yoVmC0Se+ISEo/czvpR0IRdKoGxgTB9Bm9LYzBXsEXX4AXRTG5zf3C0
         BZdyY/04gcY4sjqvy5k75NFmGTZXoilfNvjIJJVV/V5V5rlDmGAaDf2ujxKqJJy2+Omz
         PZyI7LqOQw/aZkyligYlYPUFqpPxJLIwmAROqKA+IYdWZBleg98jw8YVW6ZLpFab8huR
         WwtQ==
X-Gm-Message-State: AOAM531TOGrSq+B9r8pFZyFNBixgsG6lW6XSr18biwITlLT502t2OPaL
        O0IpcHW2A7NIekhti22o7aD6/haGfovCDDCdJCW05A==
X-Google-Smtp-Source: ABdhPJyPHpmLKJWvNf4h7ERinzV0bNLNBoF0liQERhWM5bH4q3Bh9XBTTXD2QUAOEmTu+PDwzljjIN9g/NSOLBZiY0c=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5187977oih.162.1636458132308;
 Tue, 09 Nov 2021 03:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20211105124242.27288-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211105124242.27288-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:42:00 +0100
Message-ID: <CACRpkdZ2-MRY_L2J4RvKDNW1yyThg7KUFbd80ZMpRY209RNxnw@mail.gmail.com>
Subject: Re: [PATCH v1 01/19] lib/string_helpers: Introduce kasprintf_strarray()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
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

On Fri, Nov 5, 2021 at 1:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have a few users already that basically want to have array of
> sequential strings to be allocated and filled.
>
> Provide a helper for them (basically adjusted version from gpio-mockup.c).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fulfils Rusty Russell's API design hierarchy requirements
and help people to make less mistakes so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
