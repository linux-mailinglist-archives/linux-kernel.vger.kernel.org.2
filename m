Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B43F4CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhHWOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhHWOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:55:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:54:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so8938181pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=obYIRXgSO0GwMLAUweSJ4HRzBn9VIUKmHS4nKha0Yl8=;
        b=bbk4GWgPPVzX1+EljNQUw3WHDke4VhXX2zo97ZY03BtE/zkP0CaBqFvFUOeYKzSIW/
         vQ9ix5lmk1Y0xmm1P/eoFo+W4Ry2krg9+Zapl5yEOz9bex/fOD+m4RGcb+9s+xlvEM90
         UcHhbCXBSA18pCEpoOO5K7/DONrpzmZM5ISRpR04WMhZkpYjzrgmnddot6zKIW9xtNgB
         9U/5sT41az4VB2on6ufMHwVTr4MUxU5iF53QXJNhvRvfiptl5KmNgM50gGKzGESeM1Qs
         laQbCGGLbdQfoKCZsoxmtaG5j4NQCbl0q8MH+fMC8OlPGD18g+311U/PlVs1FD7hSkRk
         7GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=obYIRXgSO0GwMLAUweSJ4HRzBn9VIUKmHS4nKha0Yl8=;
        b=Tjop5QvriUBMj/H06Bcp93A8tUZJ/W5oQeLuZStQec+qOXSbJZUoyai6judvYSqwxB
         mrQx70mmQxgkHjh2jWJT37i+nAuoSR0wDCJfG4SI7sRISbASGEb74M7MG+zaNxvscTQR
         XneeTOFe3EENZCK76jViIreBFib1GiiCUorhNt5MzN9zB9QamHBc6tDhrwFK4g1UO8Za
         05gx5r7PoCedVmKVDDU4fq4/pw8YG+QC4PBeYczAl9IO0dxzBVnqLfeyZmwJ6Q0vVz3a
         QBiu6p2h8hpkobzRs8RThL5V7f3iFitDI6J5xIxIHzdHc3mEYlz9FjTB9EB3Pdw0/0fH
         7UVw==
X-Gm-Message-State: AOAM531OGRkeg05swm1M5zkjCHseAM3OFeb1byexvlUDqJIl7vIbWIm2
        Mn+zJwYpDUzJiMPBws023dlLFPOj/OUapA==
X-Google-Smtp-Source: ABdhPJz2e1DUUo1+QF/L15glM7FbjSy1ZU1B0V9RzZITuE0z8r6iPe0A5tl8hUYutzDTDoxWz1v00A==
X-Received: by 2002:a17:902:b612:b029:12c:e9e5:b1bf with SMTP id b18-20020a170902b612b029012ce9e5b1bfmr29278818pls.54.1629730465884;
        Mon, 23 Aug 2021 07:54:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id pc11sm19519859pjb.17.2021.08.23.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:54:25 -0700 (PDT)
Date:   Mon, 23 Aug 2021 22:54:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Li Huafei <lihuafei1@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf auxtrace arm: Support
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210823145417.GA169379@leoy-ThinkPad-X240s>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-4-leo.yan@linaro.org>
 <6ce4057a-57cf-501d-6449-2069cd00ba57@arm.com>
 <20210823133043.GF100516@leoy-ThinkPad-X240s>
 <20210823133918.GP22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823133918.GP22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, Aug 23, 2021 at 02:39:18PM +0100, Russell King (Oracle) wrote:
> On Mon, Aug 23, 2021 at 09:30:43PM +0800, Leo Yan wrote:
> > On Mon, Aug 23, 2021 at 01:23:42PM +0100, James Clark wrote:

[...]

> > > For x86, it's possible to include tools/include/asm/atomic.h, but that doesn't
> > > include arch/arm/include/asm/atomic.h and there are some other #ifdefs that might
> > > make it not so easy for Arm. Just wondering if you considered trying to include the
> > > existing one? Or decided that it was easier to duplicate it?
> > 
> > Good finding!
> > 
> > With you reminding, I recognized that the atomic operations for
> > arm/arm64 should be improved for user space program.  So far, perf tool
> > simply uses the compiler's atomic implementations (from
> > asm-generic/atomic-gcc.h) for arm/arm64; but for a more reliable
> > implementation, I think we should improve the user space program with
> > architecture's atomic instructions.
> 
> No we should not. Sometimes, what's in the kernel is for the kernel's
> use only, and not for userspace's use. That may be because what works
> in kernel space does not work in userspace.
> 
> For example, the ARMv6+ atomic operations can be executed in userspace
> _provided_ they are only used on memory which has an exclusive monitor.
> They can't be used on anything that is not "normal memory".

Okay, IIUC, the requirement for "normal memory" and exclusive monitor
should also apply on aarch64 for ldrex/strex, Load-Acquire and
Store-Release instructions, etc.  Otherwise, it's heavily dependent on
the exclusive monitors outside the cache coherency domain (but this is
out of the scopes for CPU).

perf tool is very likely to map memory with "normal memory" but we
cannot say it's always true.

So I agree there have risk for exporting the aarch32/aarch64 atomic
headers to user space.

> Prior to
> ARMv6, the atomic operations rely on disabling interrupts. That
> facility is simply not available to userspace, so these must not be
> made available to userspace.
> 
> The same applies to bitops.
> 
> We've been here before in the past, when the kernel headers were not
> separated from the user ABI headers, and people would write programs
> that included e.g. bitops.h on x86 because they had optimised bitops
> code. This made the userspace programs very non-portable - without
> re-implementing userspace versions of this stuff in every userspace
> program that did this stuff.
> 
> So no, having experienced the effects of this kind of thing in the
> past, the kernel should _not_ export architecture specific code in
> header files to userspace.
> 
> Also, it should be pointed out that by doing so, you create a licensing
> issue. If the code is GPLv2, and you build your program such that it
> incorporates GPLv2 code, then if the userspace program is not GPLv2
> compliant, you have a licensing problem, and in effect the program
> can be distributed.
> 
> Please do not go down this route.

Thanks a lot for the suggestion and quick response.

Leo
