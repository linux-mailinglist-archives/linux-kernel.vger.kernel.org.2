Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D142E504
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhJOAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhJOAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:07:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD01C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:05:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so34339468lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyeBxkJaDbc+4fPGxJhXcqmLf5DNIy9LiPlsBIJe85g=;
        b=Fimni7tEOV364jXYswz7+nOWndf8KSQUiv90DX1/pfZFbM2foqRbU/zhX+5Hs6wOQc
         sBLkm/YRLMmYkVr5PjRQ2rrJ6LCkNPwMqGEBQwGm/uP/M2vUv/BF4K9eL/kbKaiz4DnB
         IS2MbTs7x8eJsq13nU6Y9lHmwEeWveINWhaN6FqDVJUNXNkPOH4Kol2JTU9r3SjDNlzI
         mPuRw5DEY9js4aA48QYoSjxrQmsuEDJq/FXveH/VC2PDfWHGf7aALL0Lm1bwduscBl7m
         lGubJCfevKNowAo4H2ecAdqI1gdxIdDNiQEkMXy204qHFBKDlCxbT4eSs77f4GopQrUt
         af8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyeBxkJaDbc+4fPGxJhXcqmLf5DNIy9LiPlsBIJe85g=;
        b=ViYJKn+gWHl9xgHHr+bPYy4b4FoFPSkAE0dRigD8B9eEeoQbI94jKX8IkcYUBm6M5P
         ojZa2Nwn0SiRO13JsmiEqJAibYBYuWhEDoU13jgVxCsHzjBGSJ0K7MvIH627etML+fv5
         +A0UZ1B7FOcGXEtJjAHcK3clc1dmYPYbNf1fxACqcY/G0si1Nupgr7VMq3f1Wd/UtHlg
         gZZ1gacrfVL9mdFub9NMPhUZb5odQIhvDmX9dE+ClJZL65CDA8gRp7r1cmYjAoh41K14
         u9R/EOOlCjK6B0+POZVtB8qV7D3RJmHCVuU85ngrz+VxrO+JN3fTQYLbmPOqC8Z6/W4T
         kceA==
X-Gm-Message-State: AOAM532zBk2yMWhSBEtXXk7E1mOd7Ib2IDxrfXm2gudWg0bTflhiRisM
        dv4ePv+JsRq4R5eRimKiBfqBOVVKxmPMjmxPTpvZHA5oRIRmeg==
X-Google-Smtp-Source: ABdhPJzXCIXgrgOSgb9hqJ4HdB4HO4YozpMsj35G4z/PPah5OQ/08kuRGD6s0oQsyzCm2uxMhola9HZkdLhnaNbZs+I=
X-Received: by 2002:a05:651c:b08:: with SMTP id b8mr3425936ljr.515.1634256316386;
 Thu, 14 Oct 2021 17:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <TU4PR8401MB10550DE1D599CC98E80BDCD1ABB89@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <TU4PR8401MB10550DE1D599CC98E80BDCD1ABB89@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 14 Oct 2021 17:05:05 -0700
Message-ID: <CALAqxLXP0yDdpq_90M4Qg18WGJJELmmFBQjXCONC8tZLv-b6Mg@mail.gmail.com>
Subject: Re: Is CLOCKS_MASK macro obsolete?
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kani, Toshi" <toshi.kani@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 4:46 PM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
>
> The CLOCKS_MASK macro in include/uapi/linux/time.h seems broken; it's ORing together
> two numbered values, one of which is 0. Perhaps these clock IDs started as a bitmask?
> CLOCKS_MASK doesn't appear to be used anywhere in the kernel; nor does the adjacent
> CLOCKS_MONO.
>
> Should those macros be deleted?

As for CLOCKS_MASK, the earliest reference I can find is here:
  https://elixir.bootlin.com/linux/v2.5.69/source/include/linux/time.h#L246

Right before the 2.6 release. Seems to have come in with this patch:
  https://lore.kernel.org/lkml/3E9B4DCD.3070204@mvista.com/
But even there, it doesn't make sense as a mask.

There was even a patch to remove it:
 https://lore.kernel.org/lkml/20050113132641.GA4380@elf.ucw.cz/

Then it took its current form with this:
  https://lore.kernel.org/lkml/20050919184842.2.patchmail@tglx.tec.linutronix.de/

So, yea, I suspect it can be dropped as it really doesn't make much
sense, so I don't think it's likely used anywhere in a useful way.
(Though it is referenced in some docs -
https://github.com/Abdullah-Younus/E-Project/blob/35e2d915dd17d7cd14618af8d727b2874c4cae37/doc-html/doc/rtl/linux/clocks_mask.html)

For CLOCKS_MONO, the main risk is breaking existing userland code that
uses it at build time. But as the fix changing to CLOCK_MONOTONIC
seems not too difficult, it's probably ok.

thanks
-john
