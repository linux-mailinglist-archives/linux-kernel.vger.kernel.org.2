Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFB44ACBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbhKILiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbhKILiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:38:00 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FBC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:35:14 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u74so11951085oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2pAd4bAvLGuQHlmvNN+h2TrmSqORB/og4IefjMu/Gs=;
        b=oeBZnU3MNAghzjyLIb+fM7Irgkj3AauRHUnUS9LblIjn/HL/tpUBDV4ZYfAfSiBivY
         f2Ooq2zZvyRjQykYk2jrIrnXytZnVmx3pmJ7cP3XrQdBrqFTVMKjjm/9LROvnpeG4s6R
         ZC3XFcnEK6V2y+vFLNbGJlxgqlKt/oOrjg1pqxQn5BWklsQBh4sg+99rG5PuQ2YCb4Uj
         S+Cpvf9CPwkp32bMJe9Jk+y+lG5z5tjx2uGFGBBe/7UZU6FTzAAYks78FbC79IeVdjSG
         wjVKRCfbkDZtVon7tBp0LZBnLgm8eVTxAGO+wskKug5AJrfa9LZwzG2igXTZbgv5k6vE
         bZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2pAd4bAvLGuQHlmvNN+h2TrmSqORB/og4IefjMu/Gs=;
        b=vwJKb8kbdLzHddK/QzwNtKNHNyxrXoDQKRHmvJlVX8Nopy+sCGVdUL0flLWIVjZfIn
         5MllQmof1VacFWtD2FY2f2+Uuf6hR2YlCow9K2PoCXTLK/kX3xuzlV9MXGRSQ1tPcDQo
         vFogYC9DO0MjdBss97gfLyTVLmgvstpuQ1xDw2Cfw72NiIHiOcMcYxNaspmSBenRSbX/
         39atnrvWNjIKHqVx1ayF91AZfutZlceCl3qIx0Tf3A+UI63/ApwIQaMCZ65Xy6V0wXVs
         HKktHbXJCsek01hpqOPTqRo9KVR8RccAyzLo4OKxPjzU8J5LVLy+UkJ/0kwdx/SLN4bz
         qznQ==
X-Gm-Message-State: AOAM531nuAnEsb6kOL/YahfqxVcFSZu1qOxU2d9GcnMbvl0c/3Rplj4F
        g2I24LnwtZfoZkxE0nZckqYsgfEz9WjbD+8h6YyBDA==
X-Google-Smtp-Source: ABdhPJx4OlotCLYJPZy+X0p8zFLUTXcqcM/xCAFKp3eZ4QqsYKNx7VufYAbkVJoBzN16IyIl2/T2UCY/eqmhbavLu80=
X-Received: by 2002:a54:4791:: with SMTP id o17mr5249862oic.114.1636457713735;
 Tue, 09 Nov 2021 03:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20211105124242.27288-1-andriy.shevchenko@linux.intel.com> <20211105124242.27288-19-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211105124242.27288-19-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:35:02 +0100
Message-ID: <CACRpkda47wek7EEhs-ecaij_OX4i7EZ+nvxa=VxHH+krgVYg+g@mail.gmail.com>
Subject: Re: [PATCH v1 19/19] gpio: mockup: Switch to use kasprintf_strarray()
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

> Since we have a generic helper, switch the module to use it.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
