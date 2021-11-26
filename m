Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40E45E39B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhKZAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351977AbhKZANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:13:10 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD0C06175A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:09:58 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso11683871otf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neIFIYHPjOUpNL3YRDeMbxvyjnBJ6P4UgTI+o3qYdYw=;
        b=tYYZaYR1+CccW6lhfaeZQ0QneHWCZxskvvmMmnwLYww8cUcnOjMq6uoaEQljsIyIKS
         BjtbswgDTARHt9oqn+Rsq5qvggq6vBcE6UPAWnlFACFr8k3ln9GU1JfVtatcTwcPd5Ew
         fKZfJqnaB3nf44Lx3HlDJaUE5nhT9Nd/RVbBUZMtUphqHDasHVCQ/WwB9FxwD5tiLUF/
         TukWZvO9qdQF2J8jN9Fh4yNE2KbIc6TG/AEsVsiGMOnbxPW/mrY4kOMaG0wenzjggFMO
         HDqxDLtMYiZ3+7j734mCPMdvVO+Dl61pA/A7bw6NRNheu4laChJcK2caBAJDUcoezex9
         DPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neIFIYHPjOUpNL3YRDeMbxvyjnBJ6P4UgTI+o3qYdYw=;
        b=MPGOs9tPyMALg+bRCQK7LwJHqxnBZAMapdHQrk25P08W7juUskX/ylFS3agsbnEuTA
         lkUNz/pWeTqSO82JG3u4miJgYmML1YYnnhMORQGwyJKqmEdkI8Ivi2p5tokygYoeac08
         12DzIpMtxK6dRliHfljxKYCTP+2PT2K55itINS+G5kdWUDwsHxzIWM2Sc/Dk4e+k3KZX
         RgO4H7rroCN89dQ1fIsjwuURtH8zEz1BtrZEhWwMGJuKoTdwQ33Ss6boqx1G4K3ajiaI
         7GrTIxjFpiUstASsmKwAGJvWcq+1dY0cxMVj99586cEigtxI5kSQRVnDwOLCB7euFhrG
         W5ew==
X-Gm-Message-State: AOAM533aeCofy2wTEJqaiLBP0vLWnRbHwEGAYWX/FE5ly3otnazeKePn
        tyV4FJnsiS7IX50EwsbshEDzmS5Npq1eG7WdOvpZSg==
X-Google-Smtp-Source: ABdhPJwgWT/e+0czvS3idqkKSoKYVIDQJsSLxdv8T3m5T5PstA7wAP74pbo77sscXIt8r/ICaUlySf3h3M1mipxTuu8=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr25707913otg.179.1637885398027;
 Thu, 25 Nov 2021 16:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20211123155144.21708-1-lakshmi.sowjanya.d@intel.com> <20211123155144.21708-2-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20211123155144.21708-2-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Nov 2021 01:09:46 +0100
Message-ID: <CACRpkdbOG7AiZxMoP9azYzHBEeOvNVWt9-ArYiP=BBswydRDqQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
To:     lakshmi.sowjanya.d@intel.com
Cc:     linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        tamal.saha@intel.com, pandith.n@intel.com,
        kenchappa.demakkanavar@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi!

Thanks for your patch!

On Tue, Nov 23, 2021 at 4:51 PM <lakshmi.sowjanya.d@intel.com> wrote:
>
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Add Device Tree bindings documentation and an entry in MAINTAINERS file
> for Intel Thunder Bay SoC's pin controller.
>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

This patch must be Cc to devicetree@vger.kernel.org so the DT binding
maintainers can look at it, can you resend it?

Yours,
Linus Walleij
