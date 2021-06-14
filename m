Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3F3A6E21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhFNSXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhFNSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:23:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1811EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:21:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09b9000b7fffe760596043.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:b7f:ffe7:6059:6043])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F0CF1EC0258;
        Mon, 14 Jun 2021 20:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623694861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cKjQp42PFiwr+aeArBdrcqWG95zW7bcdl06547szsq8=;
        b=LGBedPDAYh6kdviOu9pXa1cKgFA/yl3aOKAHDI4XFOiun+pUL5uXBuz83RW5CM4LBdHalo
        bT6246lqiG5P6Sdg4Y+WLnZQiHkB+XT4eefGgIke9UcOgwQmxLgE6K3VN6Hjd02nfT80w5
        yHzPPMoTHnl0yb/oKk5fj7BK5K/Q40A=
Date:   Mon, 14 Jun 2021 20:20:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <YMeeBJKJhddzReGe@zn.tnic>
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com>
 <20210614162018.GD68749@worktop.programming.kicks-ass.net>
 <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:05:35AM -0700, Nick Desaulniers wrote:
> __attribute__((no_instrument_function)) is already wired to not emit
> calls to mcount()/fentry().  I think extending it to also apply to
> coverage (-fprofile-arcs) and instrumentation based profiling
> (-fprofile-generate) is reasonable.

Is anyone going to ping the gcc folks so that they do it too or should
we open a bug over there simply?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
