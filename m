Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E768315CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhBJB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhBJAWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:22:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E691C061756
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:21:23 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k22so232151pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 16:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xpBrTHZJIfUTFMKDRSVnPUYodzY0EXGoifdbMVRjzIA=;
        b=Oluwae3WirHiapSlTkfy5plypAC2akuWcS9Qathv2uBak2h0Gny5J29+LM3LBM6LIs
         JcSO7/q7D1wm6ZhXz6sjvYEU6h4bnNoJ2yeFrnQQxXhhZpps7MT66zfPAwfQfb872hr4
         Zh7Gt6vc0eXc1ihLVl/y/PRPJc63GhR78fG98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpBrTHZJIfUTFMKDRSVnPUYodzY0EXGoifdbMVRjzIA=;
        b=Tr33jX0Rw0VV0e89cl11Zh7cVS4Zuf8ux8btRVa5F99If13KkbnnHkCZfi3slcrxto
         SjcDiu/rbJPNqv8GUVjwGaVBd7ASZSFT+EY7w4EqbK6atfP+TDbK28Dop8v/5gje2M00
         ip/OR57Bx1GbHCOlI4ROmTTUtRLfQ+irMbKF1oYRCcpj1UHn633kLXCsFSer17eYU89w
         cDjnClvp4FeE0jZ52T3RoouysHHR53V2HTVJIs46b1UeyfiroF0oLNN1Kdky8q59VT/Q
         A5raTlN5fUAgEhNTJyrpSbpdeKzM/tWcU9gyo6eObmiXFGCbdlmlPiePc/has8kwypIb
         CpxQ==
X-Gm-Message-State: AOAM53362dgshYHKuL+6vk6OmXBf1LRVZhC9IonIgrqkza8gtVsRCShT
        TcBBYAaMyyTu+zrDaWZUElR9Hg==
X-Google-Smtp-Source: ABdhPJzvf+2hew5QPgnesF4IH4Hhhn4vQPmx4QJHyUuL7XeHDIfu8nzvXSS7HmfQ0gEKaxwvUtpo5w==
X-Received: by 2002:a17:90a:be03:: with SMTP id a3mr446982pjs.55.1612916482662;
        Tue, 09 Feb 2021 16:21:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n12sm87531pff.29.2021.02.09.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:21:22 -0800 (PST)
Date:   Tue, 9 Feb 2021 16:21:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Rybainin <ryabinin.a.a@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        dvyukov@google.com
Subject: Re: [PATCH] ubsan: Require GCC-8+ or Clang to use UBSAN
Message-ID: <202102091619.8D6D5B4@keescook>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <YAAj9aAcPsV9I6UL@hirez.programming.kicks-ass.net>
 <e291008b-6b4d-9da4-1353-0762bc68e8ea@virtuozzo.com>
 <20210118175337.rnh2b6vdnqw3ue63@treble>
 <20210209182423.te43h3mmhtvwi2d7@treble>
 <e47d2395-8b54-bbb4-a3fb-e428c99edf22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e47d2395-8b54-bbb4-a3fb-e428c99edf22@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:17:57AM +0300, Andrey Rybainin wrote:
> >>>> Subject: ubsan: Require GCC-8+ or Clang to use UBSAN
> >>>>
> >>>> Just like how we require GCC-8.2 for KASAN due to compiler bugs, require
> >>>> a sane version of GCC for UBSAN.
> >>>>
> >>>> Specifically, before GCC-8 UBSAN doesn't respect -fwrapv and thinks
> >>>> signed arithmetic is buggered.
> >>>
> >>> Actually removing CONFIG_UBSAN_SIGNED_OVERFLOW would give us the same
> >>> effect without restricting GCC versions.
> >>
> >> Is that preferable?  Always happy to remove code, just need some
> >> justification behind it.
> > 
> > Is Peter's patch acceptable or do you want to do something else?
> 
> I do prefer to just remove the code, I'll send the patch shortly.

I have a specific goal of getting both signed and unsigned overflow
detection working sanely, so removing this entirely from the kernel
really makes working on that difficult. :)

I view the primary problem as compiler-specific. I'd much rather we
correctly mask against versions (or better yet, behaviors).

-- 
Kees Cook
