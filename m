Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF89942E19C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhJNSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231202AbhJNSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634237313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=390oXOAx8xu4/KUEBxfvh8/zjlryT8/NcisAwMW9dms=;
        b=WuBYlt/662IpK7uaqwDY7VQv206ZcXFQxMV3GNt0XtEBqZ6OPalY+ATf6UxAQzAC/BiD/q
        zwfisfviQdRqM0GUGfJxUV4v+rRpiZg2jMP6lxCC2C4MvVhU16+zb3NW1qmNdDOCNCjV9p
        AgL1Zf7aIWquWCSdmSEpImpz6ZiY1gY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-XSB9vOf8MGKsA5-mv0P-vA-1; Thu, 14 Oct 2021 14:48:32 -0400
X-MC-Unique: XSB9vOf8MGKsA5-mv0P-vA-1
Received: by mail-qt1-f199.google.com with SMTP id 12-20020aed208c000000b002a78b33ad97so5096450qtb.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=390oXOAx8xu4/KUEBxfvh8/zjlryT8/NcisAwMW9dms=;
        b=1F5NGQUEtIBdn7dyHDKu40AZKhn0RSKyJxmXWTvZ9qobv8HVnCiuQ/UTBakWb3g+kM
         pnMgS9EFVdi2rtaY0muwtjs0LZgL6c57DPp7Mzy/3CPSqVSu19jU+ejICDst/bd4stKz
         mmrq0JFZv+vRuoqd7rRiLdOkXONrXSJAFqxX4A4LjQgc/ytToFE/OK60aWuHobnR07We
         7Oa6WRlroOtYQd3Y+K5unwcP0P8vDQsHFuRhkDpFrygZmruOmzbZ76orjPw2LKV/HgQ2
         pUGaPnX6uJbD7X+mjh9lXG/IxALV7k2SwM6xdxfgRphEy5P1m1EgIRAvIN2s9qSni6pJ
         H3+g==
X-Gm-Message-State: AOAM531bUnZtQEHdNvBeQzzvF4YIcPAtudwkinkOU7COp6n2dO9ToVEA
        NkqTqzEfNIgfs+8YBguXPZEPH3f2TFMdJQHAR97s1PNyKG58bqIkHEMh9wx5TUTKGcEAOhQwISm
        zZp+9L4qEcKyZ+rGmh+hTMZeV
X-Received: by 2002:a37:c90:: with SMTP id 138mr6072543qkm.255.1634237311718;
        Thu, 14 Oct 2021 11:48:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytP+DvZn3EfxUM7dsxKpelaHBNmMC9oJwTycXxdHYSXFOFWt9jMdlMXSlEI0NyE7E7s7Jegg==
X-Received: by 2002:a37:c90:: with SMTP id 138mr6072528qkm.255.1634237311500;
        Thu, 14 Oct 2021 11:48:31 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id g5sm1601735qkm.112.2021.10.14.11.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:48:31 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:48:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        jannh@google.com, linux-kernel@vger.kernel.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, vgupta@kernel.org,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <20211014184825.2vre4bt3fojcfdka@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
 <20211014180307.GB39276@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014180307.GB39276@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 07:03:07PM +0100, Mark Rutland wrote:
> On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 08, 2021 at 01:40:52PM +0100, Mark Rutland wrote:
> > > [Adding Josh, since there might be a concern here from a livepatch pov]
> > > 
> > 
> > > > +static unsigned long __get_wchan(struct task_struct *p)
> > > > +{
> > > > +	unsigned long entry = 0;
> > > > +
> > > > +	stack_trace_save_tsk(p, &entry, 1, 0);
> > > 
> > > This assumes stack_trace_save_tsk() will skip sched functions, but I
> > > don't think that's ever been a requirement? It's certinaly not
> > > documented anywhere that I could find, and arm64 doesn't do so today,
> > > and this patch causes wchan to just log `__switch_to` for everything.
> > 
> > Confused, arm64 has arch_stack_walk() and should thus use
> > kernel/stacktrace.c's stack_trace_consume_entry_nosched.
> 
> Looking at this arm64's *current* get_wchan() unwinds once before
> checking in_sched_functions(), so it skips __switch_to(). As of this
> patch, we check in_sched_functions() first, which stops the unwind
> immediately as __switch_to() isn't marked as __sched.
> 
> I think x86 gets away with this because switch_to() is asm, and that
> tail-calls __switch_to() when returning.
> 
> Does switch_to() and below need to be marked __sched?

Yes, I would think so, for arches where they otherwise show up on the
stacktrace.

-- 
Josh

