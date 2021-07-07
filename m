Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAC3BE41E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGGINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhGGINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:13:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3978C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 01:10:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d2so2050453wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gHdncZ3P6g+2TaLtcRB/ZmZ7HXwhAytQ4tmQta2m+MU=;
        b=MvO+u35OJmERKJ4gc+iV4WAlyRMoy478j0l8ySQomx+lEB8AwVW1YMgq/zNC1rQwA7
         vjJPwDurT2RK/xUMSu08apSf6kY/hkFFhKshJ8R6jsnk7mrTAdvJEaLcVSTohmrUAC8g
         0sO21eDU6P98sh9p9Wu8xl78g51IEMUST4t8oCn+HcrzPN8ZDUk13FU8A3yaLiFliuNf
         gc15nKZ5NwyB8aQAMac3LojbUDZEgqDkA0csi/oe65QbPs9BOEfAgMooFFB9/1Y1r3wH
         h5/cpOsodj3ErYkfXSN/QFv+gJ2bQpgLvWTZ2865ZPNksK5aPsOY6TM7g6UhjZV9sF3C
         e9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gHdncZ3P6g+2TaLtcRB/ZmZ7HXwhAytQ4tmQta2m+MU=;
        b=XmP0hxF/AD0iRhMu05KdryqS6AoqedQMN4M5wO5m7s6rPNdTq0Nyl37a1zNenY4lVE
         AotAvUzP1i2sAAhR4MiM8ppkc0rIx2nX8BlfZ8SSqlXi50dlWMSAgjTHuDnYCA2HtMFe
         mEnR+JGsDrRYPt5PIfR4CcFBk8Y+ftrZDaod3uYE6odFufzgecL8AderF2LDJ1pJUXZs
         RMmYGul+W62sDUAeSf7jt8EFVL/gV1/uoUlqPayUmhkMX/dcF7hUHRYOqYM89YdUovoe
         txpCZsoWIgvUTrC2D0t8IEm5fAlSmr4em6mqYJP8e+5KWV1xHyMmCRqg9mf+yXNerLvn
         z6zA==
X-Gm-Message-State: AOAM533nQFzYrk6sm6PqGzbClPVBsRI9VdSTLfVeKtzNiJdsVNGO8Hcn
        c/pVvyc469LAM3zhdp6pjXoNopMBXAg=
X-Google-Smtp-Source: ABdhPJzMYUG12wdghVjhXd0fZicDKq0UvJWHRzrB/+FckHEeGScLJ4/rUcg0m5tacWWG+WP1RcIhVg==
X-Received: by 2002:a5d:6e81:: with SMTP id k1mr26452325wrz.144.1625645443442;
        Wed, 07 Jul 2021 01:10:43 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id w9sm18616575wmc.19.2021.07.07.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 01:10:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 7 Jul 2021 10:10:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <YOVhgNRjEWSnjfcg@gmail.com>
References: <202106281231.E99B92BB13@keescook>
 <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook>
 <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAKwvOdkcKU4K9LWTymmzi_c0wKPTQjWEbNu04WOd6D-EcnWDSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkcKU4K9LWTymmzi_c0wKPTQjWEbNu04WOd6D-EcnWDSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> > And I really hate how pretty much all of the PGO support seems to be 
> > just about this inferior method of getting the data.
> 
> Right now we're having trouble with hardware performance counters on 
> non-intel chips; I don't think we have working LBR equivalents on AMD 
> until zen3, and our ETM based samples on ARM are hung up on a few last 
> minute issues requiring new hardware (from multiple different chipset 
> vendors).
> 
> It would be good to have some form profile based optimizations that 
> aren't architecture or microarchitecture dependent.

That doesn't excuse using an inferior tooling ABI design though. By your 
own description proper hardware LBR support on the platforms you care most 
about is either there or close - yet the whole Clang PGO feature is 
designed around software based compiler instrumentation? That's backwards.

The right technical solution to integrate the clang-pgo software 
instrumetnation would be to implement a minimal software-LBR PMU 
functionality on top of the clang-pgo engine, and use unified perf tooling 
to process the branch tracing/profiling information.

In the main PGO thread PeterZ made a couple of technical suggestions about 
how this can be done using the existing hardware LBR interfaces of perf, 
but we are flexible if the design is sane and are open to improvements.

I.e. try to commonalize the tooling data as soon as possible - not very 
late as in the current proposal, exposing a whole stack of APIs and ABIs to 
clang-pgo specific interfaces.

The "LBR data unification" approach has numerous short term and long term 
advantages:

 - Hardware assisted LBR tracing support out of the box on two major 
   hardware platforms (Power and x86), and on some ARM platforms "soon", 
   maybe sooner than this feature trickles down to distributions to begin 
   with.

 - GCC won't have to reinvent the wheel - they only need to make sure they 
   can generate the minimal LBR data. In that sense perf is an 
   'independent' tooling facility they might be more comfortable working 
   with as well, than a 'competing' compiler project.

 - There's even a chance that existing instrumentation can be reused - or a 
   relatively self-contained compiler plugin can generate it.

 - Lower maintenance overhead, lower risk of subsystem obsolescence.

Binding this feature to clang-pgo on the ABI level is not a good move for 
the Linux kernel IMO.

So until this is implemented properly, or adequate explanation is given why 
I'm wrong:

   NACKED-by: Ingo Molnar <mingo@kernel.org>

Both for the core kernel and x86 bits.

Please preserve this NAK and mention it prominently in future iterations of 
this feature. Please Cc: me on future postings.

Thanks,

	Ingo
