Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE88744ACB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbhKILhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbhKILhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:37:20 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B82C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:34:35 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bf8so15168355oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJvoZMaaDiqQDQzmQKxU7aL1Rgs77zOyF+qBbYMPai4=;
        b=ibWeio9MhAbFBMtbEQiWYGtyoUNI2wGwaiB/Cg+427BrHvgtSDRUW5gDCClC3hCcLn
         0HnANAGOM2wRQZIbHQsIOJDEhxwHLDwPRLxUm4yvmIe4FIOWkDKUHiJEZKBG6fl/QWul
         qX9/8nHQ5u9FrKDFujOXwOsES7LbHEjOxtPxvTVmgvjrePUf0FznxdT1zflk7ca3kk36
         0EQpWHsYulFHFaOfX2jHVJoxSU2Ki7ebnmIdXo2g/GrSNHUL00Y/D2AKgZj90f5okAqE
         SH/F/fy6rg74jts0jJcKSKjKVqeGqqKRjQJ6WU6M9p2hRNCWmhRbBUr1MB6e9hyf51SR
         s0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJvoZMaaDiqQDQzmQKxU7aL1Rgs77zOyF+qBbYMPai4=;
        b=Vbm3ZVLdzDXQyg6ob8/VfyN4PGg5RjReVw2e9pM27B3h1ZPItjQlBMHLYDjN4Jfs6W
         GOcWS1DUrmbsDROu/WP6B4SHDGpeFhV9rL443TM1nbrSR+C5z3GPGswjJSWJ3dbvCoaD
         sdrDaMSc0r1o2EnxD7ue5LOyH+f79xVtysSGGvIu3PdiAdTOgJ7DUsKVodCZHmTr1vZJ
         LW/0/4nlGm+wk08b8hgwQumUQ4+eK5YdPC5zOL6Lp9VgnwV7KvHnQV/du0K+/zLV/hIV
         gVih1Gub3U4/reqJs8E0kPbrJV5KEHaYjokmhMNAmyu5T2+uHWR1BInqGvzytJx5TWXy
         LU0A==
X-Gm-Message-State: AOAM531t6lVSXIQam//GgmpoD+hFT8tnPYxHydaNplfYV3z/kxWtNFNe
        GRIT2vvjA36dE4tywGMlfOyg03cvfQWPo8YI/gZyFw==
X-Google-Smtp-Source: ABdhPJy/RETaWdANM3tucuwvOzEk6ouGG2eWkyABK9KYywpBeBb3elcEuOEvVyLatP3WRod1SZHwHhkYlC6A0sQeZAU=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5145143oih.162.1636457674579;
 Tue, 09 Nov 2021 03:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20211105124242.27288-1-andriy.shevchenko@linux.intel.com> <20211105124242.27288-17-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211105124242.27288-17-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:34:23 +0100
Message-ID: <CACRpkdb2Z23AOSfEWjFHL5RdErEh8r9xUypWWyV2LUNhRw-q5w@mail.gmail.com>
Subject: Re: [PATCH v1 17/19] pinctrl: st: Switch to use devm_kasprintf_strarray()
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
>
> As a side effect, add check for the memory allocation failures and
> cleanup it either in error case or when driver is unloading.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
