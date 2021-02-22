Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1161C321F76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhBVSzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhBVSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:53:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:52:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id w36so7437835lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1cztlrje5NbBmRurH/8h7VfCSrwP1g9XSZwlCeLi8Y=;
        b=iBBmq/nIHfHcq9G8y27Mt3bk7XbyFS8LFxcMFQk55sGvFzNK7K5SEZlbiRcTnb6qqX
         z4qYC1z51DwpClOU0u4CutVnG69lhauXToz55bHV7kcKvIydfWA5FOFDLKMxOIiRP2cN
         YmqDBmRR94dhsNrbNy+ie34ZUPrtRz8ep/c64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1cztlrje5NbBmRurH/8h7VfCSrwP1g9XSZwlCeLi8Y=;
        b=LWPBPTCogvCCfpF/6d7fhWOYvwRuDjuhuL1RRsEENpygENWIPr2JcLnmBHe1f5J9Rk
         E0g5/GKvHmiKE1SWhQ5eM4SUsnKnMnYIi1dXrvRa7IA9b2iU5mo5SuKQOmEyE90v7kw1
         IkznjeWO4e1PRQDyVIJnHmSeIJbOiBEfeD7OAeB5CYxDsjDGn33L+5aIPr30RYoaMGGF
         as4jY44+xIKCmRcjuKXbdlwb1jD4AG+Bx65xPl0I4nLeeB6tng+gGiaGeZn4zvNxPCHz
         fl4NFLegT9Fg+xYGYaj/lfTS/kOW/pnBvcz08q6+MStIY5x6eyR3ELdH9IIcP5jICn+u
         XDWw==
X-Gm-Message-State: AOAM532gpGzQ7YZvql55KaH6HjbUxYsOfOeWYX9TbaHGbK+jHkHCSitf
        TkbSd+8s12+EkZS8XvLnVgeNIeS5xixKmQ==
X-Google-Smtp-Source: ABdhPJx5Zn9X9LGo1PI3u7y6wuUC2pv71AUNvExo2vZfQUk7jerG6vEys8t16rWvmEoI01g8qLVweA==
X-Received: by 2002:a05:6512:114e:: with SMTP id m14mr13511947lfg.617.1614019947150;
        Mon, 22 Feb 2021 10:52:27 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m11sm1215922lfp.54.2021.02.22.10.52.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:52:26 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id j19so7306121lfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:52:25 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr14136524lfu.253.1614019945405;
 Mon, 22 Feb 2021 10:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20210222173541.GA1677515@robh.at.kernel.org>
In-Reply-To: <20210222173541.GA1677515@robh.at.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 10:52:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi60wC2z0yTo+B81x8HNu2HVJ6mSFHJC3xpKJOW9_EV_g@mail.gmail.com>
Message-ID: <CAHk-=wi60wC2z0yTo+B81x8HNu2HVJ6mSFHJC3xpKJOW9_EV_g@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v5.12
To:     Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 9:35 AM Rob Herring <robh@kernel.org> wrote:
>
> Please pull DT updates for v5.12.

Ugh.

This causes "git status" to be unhappy, because there's a new
generated file (scripts/dtc/fdtoverlay) without a gitignore entry.

This was added by commit 79edff12060f ("scripts/dtc: Update to
upstream version v1.6.0-51-g183df9e9c2b9"), and then enabled in commit
0da6bcd9fcc0 ("scripts: dtc: Build fdtoverlay tool"). But it was
already referenced before it was even added (by commit b775f49fbc8b:
"scripts: dtc: Fetch fdtoverlay.c from external DTC project", which
didn't actually fetch that thing at all!)

And that commit 79edff12060f is all kinds of strange anyway, in that
it *claims* to have taken some (other) gitignore updates from the
upstream dtc code, but it very clearly does no such thing.

So I have to say - that whole thing was done very very badly. Actively
incorrect commit messages, complete mess about when things were added,
and the end result isn't great.

Sadly, I only noticed after I had pulled and pushed out.

Please fix. Not just the current mess with the incomplete .gitignore
file, but the whole clearly broken workflow.

               Linus
