Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED8844C0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhKJMIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhKJMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:08:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDFC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:05:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y196so1926573wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gp5rF8yIUfEk3D/39XMLxjenQ09E3dvkpobT9kmUxww=;
        b=ZuAmRBXN2yYIdS8TNdXiMd17bwWuChKDUIB39IGbVqOmwPMTWW2J+8zM8U0imxsSWS
         i8cUQSDUb4YHT/+J1gIPjm9BT1TjMmnvh3QUZi7piLSZtDRkDE2lP5bievtqDB4FYL6q
         Fx3SGkbL1FxMKm6wqTiG2bYP0B/X++d12o83uKYNIEC8jmU+iYTbuZ22fGSIufC3khgG
         z2BQAlOx4a7yaDEOb8HCcwp5SUT13zdLbiyVkgGq2jRbNizN3pawUwumkSdF614u+dS1
         9khpn3xwORMRYJRJ4tPt6R1l3pFDr+P4iU+Y0FJjPSLY9rNrHgFYh/Ek7PHKvqSj5k2e
         J17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gp5rF8yIUfEk3D/39XMLxjenQ09E3dvkpobT9kmUxww=;
        b=VysOjLyolNwpGw6VHbk77KW6ywsMSZiJYFdGeUVDOsdupAifdfEqAN4BSsm01bZ2bK
         +wNR+xMfmT6mRqS0qptlVbmYxPCBiGxb3jm0gEIn5Aw2yOiwcVQMY+asaER1tD2UxTWS
         xlYk9Oh97AeDjQ7SCN7XHCi0/ehoqoOUKzIIM/Xz+FgJnoJWZX6oAVTTyE7fxaNeJOYR
         KqiRUhvM7WS6hwOurRQBcIxaM19xDWQF+e6n1cMl9pk03Lq/lc2eb41zK+duvKmcBZcV
         Ohi09O9vaz30qCOAb+9v11DQrg/ZCIYNHHnbPg5gSZFzVmGNgaxxKqxUHeVtN2VGv4FF
         U/Dw==
X-Gm-Message-State: AOAM530C0DAJNrJDojw7syFW4FYXf4Bs6mCWIg1gOTe2YRg2Rk9Vzra0
        Ezy9fu0o03sVlu7ewHIXSaarxv2C9PSDCA==
X-Google-Smtp-Source: ABdhPJyHB1Cmc0IyyFsJN+8na5IKBcgh2XeNV67jprvvWNgmkAoKH7FEF1/MMcCL/n5MB/rlEuiKrA==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr15700347wme.18.1636545922081;
        Wed, 10 Nov 2021 04:05:22 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:51e4:1de2:67ff:91bd])
        by smtp.gmail.com with ESMTPSA id r68sm372697wmr.45.2021.11.10.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:05:21 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:05:18 +0000
From:   Quentin Perret <qperret@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call
 trampolines
Message-ID: <YYu1fgvkN/ukqGkQ@google.com>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-3-ardb@kernel.org>
 <YYq1/a10XGBthteg@FVFF77S0Q05N>
 <CAMj1kXHrTjxWWX0cfF1Bx58aTR9Fp=xkfhizkWnQRjYtRm879w@mail.gmail.com>
 <YYrFvXg12eANs0gz@google.com>
 <YYuoawC2CpornRSG@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuoawC2CpornRSG@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wednesday 10 Nov 2021 at 11:09:40 (+0000), Mark Rutland wrote:
> Hi,
> 
> On Tue, Nov 09, 2021 at 07:02:21PM +0000, Quentin Perret wrote:
> > On Tuesday 09 Nov 2021 at 19:09:21 (+0100), Ard Biesheuvel wrote:
> > > Android relies heavily on tracepoints for vendor hooks, and given the
> > > performance impact of CFI on indirect calls, there has been interest
> > > in enabling static calls to replace them.
> 
> Hhmm.... what exactly is a "vendor hook" in this context, and what is it doing
> with a tracepoint? From an upstream perspective that sounds somewhat fishy
> usage.

Right, 'vendor hooks' are an ugly Android-specific hack that I hope we
will be able to get rid off overtime. And I don't think upstream should
care about any of this TBH. But it's not the only use-case in Android
for having modules attached to tracepoints, and the other is a bit more
relevant to upstream. So I'd day it makes sense to have that discussion
here.

Specifically, we've got a bunch of 'empty' tracepoints *upstream* in e.g.
the scheduler that don't have any trace events associated with them (see
the exported TPs at the top of kernel/sched/core.c for instance).
They're exported with no in-kernel user on purpose. The only reason they
exist is to allow people to attach modules to them, and do whatever they
need from there (collect stats, write to the trace buffer, ...). That
way the kernel doesn't commit to any userspace ABI, and the maintenance
burden falls on whoever maintains the module instead.

But nowadays virtually every vendor/OEM in the Android world attaches to
those TPs, in production, to gather stats and whatnot. And given that
some of them are hooked in scheduler hot paths, we'd really like those
to be low overhead. I wouldn't be surprised if other distros get the
same issues at some point FWIW -- they all collect SCHED_DEBUG stats and
such.

> 
> > > Quentin, anything to add here?
> > 
> > Yes, Android should definitely benefit from static calls.
> > 
> > Modules attaching to tracepoints cause a measurable overhead w/ CFI as
> > the jump target is a bit harder to verify if it is not in-kernel.
> 
> Where does that additional overhead come from when the target is not in-kernel?
> 
> I hope that I am wrong in understanding that __cfi_slowpath_diag() means we're
> always doing an out-of-line check when calling into a module?

Nope, I think you're right.

> If that were the case, that would seem to be a much more general problem with
> the current clang CFI scheme, and my fear here is that we're adding fragility
> and complexity in specific plces to work around general problems with the CFI
> scheme.

Right, no objection from me if we want to optimize the CFI slowpath
instead if we can find a way to do that.

A few thoughts:

 - attaching and detaching to TPs is a very infrequent operation, so
   having to do CFI checks (however cheap) before every call is a bit
   sad as the target doesn't change;

 - so far the CFI overhead has been visible in practice mainly for
   tracepoints and not really anywhere else. The cost of a
   kernel-to-module indirect calls for e.g. driver operations seems to
   often (though not always) be somewhat small compared to the work
   done by the driver itself. And I think that module-to-kernel calls
   should be mostly unaffected as we will either resolve them with
   PC-relative instructions if within range, or via the module PLT
   which doesn't include CFI checks IIRC.

Thanks,
Quentin
