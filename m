Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F178F424D37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbhJGGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbhJGGV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:21:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A874C061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 23:19:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so20254734lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pbt0M1pfebFlXF5gGyoPFy/r4iSAUgGDM1yjl8UFi1s=;
        b=mm+XH+Tb9gnmJRPx/G9P0Y606Qd51LNtkhCrsau62ZJrgUSfYMrPtKYE6WePjzCEen
         B4COrh9PSi75LfF9U0jgulJsvyGECR8lFXFwScyqwE7F5BaW+gFp3oLS3wyn5DgmV92P
         ol6QoXhbsqm22YeUx/CRC1PkPnCZEakgA+88yplcG8pvQbFFl8dICKisaM77yethRrDw
         ++8Dxwm9kx2AG7hqEBT13zgBw3uimZSzgCEhmIG4YOdtmrC/pxb3rXL4D5g9WWrTxDFW
         SbLJ1FawIXo+Aj+H6YBZPLN7qYSVPemgUgSXCEH4oUGM98JMK/hPtRVI2NipK1DLLvox
         PEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pbt0M1pfebFlXF5gGyoPFy/r4iSAUgGDM1yjl8UFi1s=;
        b=vGA5HgTdM7p40fdPtqbaw+4kPV8LB+nXqpsJxzdDX+PBCkOlxqGPduKcdZRzzF/JEr
         UZGMuILVhX2K2IRqo4B0ABmU09ZP5wgZWITjrNHCs05/5FH8igoCb67+hcVFcIcYTdi4
         AO2iLJKxEZSkgJUxnCBOkZcdWryhDtX7q0l4eKYs8r9B3pXbkBiVtMGLyC5fmiblL9G1
         uMuAvl0k58u0jUFIxWAbqgYdSQ81yeJMR1vExbLh/oX8Cbjk5mLg4SozuuvvJCB+Jzrn
         dX7V7wt3XnQ7vuxl+X0LmryCggwmjPFPZP6d261ArvZCUQjqZSqEtzJzKIbNTl11eVGl
         rYlw==
X-Gm-Message-State: AOAM532fOHILPKTRLdb/2nVRiw+MxUFfg2mY19YDVHmSsICXyOz2OFPi
        dM2xKJVRN23+aMN0iPVF6zA=
X-Google-Smtp-Source: ABdhPJziLnJtfIU4RXcVvsu+d9g0wj22SYNyeiQwIm8KZ4b+hkCi+TvSjK9GeCoSC8wzifkc+AmK0Q==
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr2598683lfe.140.1633587571776;
        Wed, 06 Oct 2021 23:19:31 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx52mygz59ds--wvhkvy-3.rev.dnainternet.fi. [2001:14ba:14f3:6500:b4cf:46ff:fe51:3222])
        by smtp.gmail.com with ESMTPSA id h10sm978046lfp.187.2021.10.06.23.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:19:31 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Axtens <dja@axtens.net>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        clang-built-linux@googlegroups.com, hca@linux.ibm.com,
        jarmo.tiitto@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, masahiroy@kernel.org, maskray@google.com,
        morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
        oberpar@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        samitolvanen@google.com, torvalds@linux-foundation.org,
        wcw@google.com, will@kernel.org
Subject: Re: ARCH_WANTS_NO_INSTR (Re: [GIT PULL] Clang feature updates for v5.14-rc1)
Date:   Thu, 07 Oct 2021 09:19:29 +0300
Message-ID: <1803114.lsCNsgVnni@hyperiorarchmachine>
In-Reply-To: <20211005143003.GC6678@C02TD0UTHF1T.local>
References: <202106281231.E99B92BB13@keescook> <20211005131015.3153458-1-dja@axtens.net> <20211005143003.GC6678@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland wrote tiistaina 5. lokakuuta 2021 17.30.03 EEST:
> On Wed, Oct 06, 2021 at 12:10:15AM +1100, Daniel Axtens wrote:
> > Hi,
> 
> Hi Daniel,
> 
> > Apologies, I can't find the original email for this:
> > >      Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
> > 
> > which is now commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR
> > and
> > CC_HAS_NO_PROFILE_FN_ATTR"). It doesn't seem to show up on Google, this 
was
> > the best I could find.
> 
> Unless I've misunderstood, the commit title was rewritten when the patch
> was applied, from the third link in commit 51c2ee6d121c. For reference,
> those three links are:
> 
>   Link:
> https://lore.kernel.org/lkml/YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net
> / Link:
> https://lore.kernel.org/lkml/YMcssV%2Fn5IBGv4f0@hirez.programming.kicks-ass.n
> et/ Link:
> https://lore.kernel.org/r/20210621231822.2848305-4-ndesaulniers@google.com

Hello, Kees and others cc'd !
I got above mail, and went through an rabbit hole of lkml messages since I was 
involved with the clang-pgo feature.

I'll like to know what is the current situation about GCOV and PGO?

I saw that for-next/clang/pgo had some new interesting patches applied.
Would it be good time now to continue make instrumented kernel?

Background:
I essentially stopped my work at the point where Peter Z noted -fprofile-
generate breaks the kernel+gcov and noinstr needs to be fixed.

My situation here is that I have very old non-public PGO hacks that date back 
to v4.11 - v4.19 era using GCOV subsystem and now with the newer clang-pgo 
patches that are in usable state.

These previous attempts all broke apart because of the noinstr not doing it's 
job with -fprofile-generate: the compiler could generate a call to gcov/pgo 
profiler hook in wrong place (in interrupt context, If I remember) and the 
kernel was doomed.

One thing has not changed over the years: I still don't have a single CPU that 
has hardware PMU capable of LBR and generating AutoFDO profiles. :(

So I have written code/hacks now for two subsystems to gain profile data for 
PGO. In the end, I don't care from what instrumented kernel pipes I have to 
pull the data out, and what format it is in, as long as the compiler accepts 
it. :-P
PS: gcov-pgo had waayy too many pipes for doing just pgo. /s

Well, that was my past on this PGO topic.

Thanks all,
-Jarmo Tiitto


