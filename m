Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019673E2F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbhHFSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhHFSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:41:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A160C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 11:40:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f42so19671086lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69V6KKkgWzEBiZIQgvdTp0NmV5ZX1LzETCEV4m2kGqo=;
        b=KtOqfKNkEoGjVedOW2BhzUrB+PNz4Xk5oVoR617A7ucdO1FL33Buih8QR0erzQI9Hr
         /wrJBN/8JzIqQRsgexNOouMOsMR3zMpts7obYBRV2wTnl1DAS+HA8wHJPBHQ5DBiE8MO
         AetrRG37NQQIL3/wgFLnK4K2CZivkpxenNwBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69V6KKkgWzEBiZIQgvdTp0NmV5ZX1LzETCEV4m2kGqo=;
        b=sGSuZW1RyU5TIn2KNJLl6DdF7/Sc/Nh18PlHF0Dfq/mAm7HMA6wXHooK/P0/Hcvktj
         EytobhlMvaWHx9vwZdwx4Ca5oAiKXhFC5+uPFxL2VfA59de5c6qO3r+gDKrIU+tya36L
         VgBK0uZDU903V7T2gShvk5CDlo2Mh9mDYCtDRoEGNT3NNDOLozHzIMjWYGooEXkpJtQG
         0NVUI4t0lDDftxRvPp8jbzCOcakyqb05If8NI3LxYG0VhSqHRwwwOnWRhJVGxjYj1LwR
         WHir0D8eWewgWUdHoO9C/0gknMT+WBUOKigvY1CLkyLRtlEJh3uNKU+frYPq5zGmUl0P
         KJOA==
X-Gm-Message-State: AOAM533hcrj0spCe0pogy+r6xS/jXm8dZbl3OyVtnMvty32AE4v8PPu3
        9FLLh+MGQV+7w2Fmu0UfZ546WlhC8U1rlXAv
X-Google-Smtp-Source: ABdhPJyvJIh1HSmRCJb7HBNZtmMFD49/o/bmoqfVjuXB3cAS7oY2Lxzhdu5SGLf6/MOLmh/BGgqmHg==
X-Received: by 2002:a05:6512:5c5:: with SMTP id o5mr8990057lfo.93.1628275250619;
        Fri, 06 Aug 2021 11:40:50 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h4sm906539lft.184.2021.08.06.11.40.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 11:40:50 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m9so13167426ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 11:40:49 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr7216070ljg.251.1628275249417;
 Fri, 06 Aug 2021 11:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210806135331.GA2951@willie-the-truck>
In-Reply-To: <20210806135331.GA2951@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Aug 2021 11:40:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNiAtCUqeCAcq+GKjmOXFfLCYA84TpeeL2085c+BdmQQ@mail.gmail.com>
Message-ID: <CAHk-=whNiAtCUqeCAcq+GKjmOXFfLCYA84TpeeL2085c+BdmQQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc5
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 6:53 AM Will Deacon <will@kernel.org> wrote:
>
> Please pull these arm64 fixes for -rc5. It's all pretty minor but the
> main fix is sorting out how we deal with return values from 32-bit system
> calls as audit expects error codes to be sign-extended to 64 bits

I've pulled this, but that change looks _really_ odd.

First you seem to intentionally *zero-extend* the error value when you
actually set it in pt_regs, and then you sign-extend them when reading
them.

So the rules seem entirely arbitrary: oen place says "upper 32 bits
need to be clear" and another place says "upper 32 bits need to be
sign-extended".

Why this insanity? Why not make the rule be that the upper 32 bits are
always just sign-extended?

           Linus
