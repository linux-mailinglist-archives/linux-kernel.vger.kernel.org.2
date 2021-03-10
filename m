Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E80334BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhCJWmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhCJWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:42:14 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:42:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c16so9252445ply.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jiNIsn8dDvvgor6dAKRTzz8LRo1SUw/7m6o11+C+WCA=;
        b=GAUFbW76BrbQVqz2/ystvzhUmQg1abnUMOcKIMlY5Dkm5JhX8eh7gngQ2vQh4i6MEm
         4sWhE4HSYPI0a3TR6iQrw46C9V87aEUY2AI/Dmnt08tbR0PZBFnb4bdy1MBKXGRe6h0w
         MD7eKsgWCPdaxh6bTPnXHynC/oNArw83IApM786O8nMZW/WmXHLxHGqA6V+thcHtCT18
         6i04z28zh/HIzsyQhGxESjealKlzjFByCSRvc+kZm3m/UwjqMJ/FLDywy+gSo2zIz7li
         2sUFCw6dmQV7A9aPpI66mSz8lKul3B6QwmWz+eDSHeLJKEDV9oNseLiiu5LGlgNCdTfg
         /bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jiNIsn8dDvvgor6dAKRTzz8LRo1SUw/7m6o11+C+WCA=;
        b=OD/rulFwo9w7E3mdvGSc3r5ZVRHJu/nadR9JlkZbTRqoPLzB1VIVKTkaKiYH2zqfD4
         cEwqrCZpOYwY7Qpx3z5eCc6FsiW1Df7K8BLwvTSJlrsPbb5sLDeVxcnIMWwiKydZqox4
         4xphAAqCHI4u9bKVsf+rVXDFmO5nm2mlkOvCvT7ioMVNC9c37ZBGOQxdj4ig019FCo2Z
         1zEmhRF3HT9IiTUMA0Z6wXrCE3bCDeUmNsTYpaHRfpZ4tlxKgyPdQxZBG4j2Dg8IsP8t
         RbJuHc7KE1jGLb+11J6rgt0vL28fbnOLpUnCkWxGQ5YHSg3sEdsxv+CSjPjvaUsUTEO4
         1Kfg==
X-Gm-Message-State: AOAM5312KEzodjJdEUajiM5IuSffwx4EuJksDRbx3rIwys+ecU1+Op+m
        5l3xE6H4NiIPihZ/2Wqi6iZ1TA==
X-Google-Smtp-Source: ABdhPJxnW49iZHHaYZqqEhgnp+6p5k49+dCkjnWrk3NWfDOT7zKcl/OMF3S5aiwi1TwhLofgVy/WiA==
X-Received: by 2002:a17:902:dac2:b029:e6:30a6:4c06 with SMTP id q2-20020a170902dac2b02900e630a64c06mr5317671plx.65.1615416133733;
        Wed, 10 Mar 2021 14:42:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:6ded:c9f:3996:6bc8])
        by smtp.gmail.com with ESMTPSA id m6sm464741pff.197.2021.03.10.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:42:13 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:42:09 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20210310224209.otjkhwng4hlislnj@google.com>
References: <20210225112122.2198845-1-arnd@kernel.org>
 <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
 <1614559739.p25z5x88wl.astroid@bobo.none>
 <3o63p7pp-50o9-2789-s3qo-99pp5nrnnoqp@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3o63p7pp-50o9-2789-s3qo-99pp5nrnnoqp@syhkavp.arg>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-10, Nicolas Pitre wrote:
>On Mon, 1 Mar 2021, Nicholas Piggin wrote:
>
>> Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
>> > Unlike what Nick expected in his submission, I now think the annotations
>> > will be needed for LTO just like they are for --gc-sections.
>>
>> Yeah I wasn't sure exactly what LTO looks like or how it would work.
>> I thought perhaps LTO might be able to find dead code with circular /
>> back references, we could put references from the code back to these
>> tables or something so they would be kept without KEEP. I don't know, I
>> was handwaving!
>>
>> I managed to get powerpc (and IIRC x86?) working with gc sections with
>> those KEEP annotations, but effectiveness of course is far worse than
>> what Nicolas was able to achieve with all his techniques and tricks.
>>
>> But yes unless there is some other mechanism to handle these tables,
>> then KEEP probably has to stay. I suggest this wants a very explicit and
>> systematic way to handle it (maybe with some toolchain support) rather
>> than trying to just remove things case by case and see what breaks.
>>
>> I don't know if Nicolas is still been working on his shrinking patches
>> recenty but he probably knows more than anyone about this stuff.
>
>Looks like not much has changed since last time I played with this stuff.
>
>There is a way to omit the KEEP() on tables, but something must create a
>dependency from the code being pointed to by those tables to the table
>entries themselves. I did write my findings in the following article
>(just skip over the introductory blurb):
>
>https://lwn.net/Articles/741494/

Hey, this article taught me R_*_NONE which motivated me to add various R_*_NONE
support to LLVM 9!

In the weekend I noticed that with binutils>=2.26, one can use
.reloc ., BFD_RELOC_NONE, target
(https://sourceware.org/bugzilla/show_bug.cgi?id=27530 ).
I implemented it for many targets in LLVM, but that will require 13.0.0.

>Once that dependency is there, then the KEEP() may go and
>garbage-collecting a function will also garbage-collect the table entry
>automatically.
>
>OTOH this trickery is not needed with LTO as garbage collection happens
>at the source code optimization level. The KEEP() may remain in that
>case as unneeded table entries will simply not be created in the first
>place.

For Thin LTO, --gc-sections is still very useful.
I have more notes in https://maskray.me/blog/2021-02-28-linker-garbage-collection#link-time-optimization .
