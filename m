Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA22841698D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbhIXBnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:43:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF155C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:42:06 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so8249971pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ORLoDwYkLfIrLpsZJ93a9BMaEAtpfd6ZNV/QACoSGM=;
        b=kGn+VnYOFLKDNYQeIdVs1vsyuMRKxXM32mjCOAMwPXQ6CSr1cDCpnJ2/cvTVFo64el
         xKogHaE4lyyLC5ohZ8i4RZg/DXDkVmfJqSQW2tVU0guYN/jus4j9Iffq2r1XVBm9O2kR
         TjWxFQxoruek/4j1purIlGktRuFRW6CB1M5zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ORLoDwYkLfIrLpsZJ93a9BMaEAtpfd6ZNV/QACoSGM=;
        b=iQ8Y1N64x4kluMuq63c7UIsYxraLs9zKc6mviG4x+bpeXI0U4XcV9vQXzdSR1y1sCT
         DfBapqTExmRvVgn3rLMerI9UKaszBZc1l7Jm4M/5N9pYtmodb8FR0CluK4ZUKnvE+QMd
         9WiYj5O2hsIGKRCU9bdqc/pcquvwosRvN6hfj+6mEOpYXWZjdTn+Q7CjaR2TkOp9Wux3
         x18HDT5J1Bvj4djmirGMgiy58fW7It3TUDsYWMa+q0AI5RQ6Hx2TlK3PwlAx2RAd/Rdl
         ZKYOmGu33W/++loVcsYJFzSfjqmM9L4M9tl2j8XU6DrMufovVdXvhHuGUFSWFV69munk
         wMXA==
X-Gm-Message-State: AOAM5320r2S+1zdrtcIUL/5wLmP0JpAYH8vgVk1l6/c46pLu9x+hn5ON
        ijyRLD2pym5ou1x7uxCmkLCLnA==
X-Google-Smtp-Source: ABdhPJw1YIgvBZx0VZcCKhFUeMoCnW/1b5IFR30q00vXp1qtIjJqmzAs4GJ46rjwV6eKs/sQMcOiOw==
X-Received: by 2002:a63:7807:: with SMTP id t7mr1604036pgc.474.1632447726198;
        Thu, 23 Sep 2021 18:42:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n41sm7023117pfv.108.2021.09.23.18.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:42:05 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:42:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109231839.33EF45C785@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924013408.mqw42x4lhqeq5ios@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924013408.mqw42x4lhqeq5ios@shells.gnugeneration.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:34:08PM -0700, Vito Caputo wrote:
> On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > entrypoint address in the current task struct for get_wchan() to
> > > access, whenever userspace enters the kernel?
> > 
> > wchan is supposed to show where the kernel is at the instant the
> > get_wchan() happens. (i.e. recording it at syscall entry would just
> > always show syscall entry.)
> > 
> 
> And you have the syscall # onhand when performing the syscall entry,
> no?
> 
> The point is, if the alternative is to always get 0 from
> /proc/PID/wchan when a process is sitting in ioctl(), I'd be perfectly
> happy to get back sys_ioctl.  I'm under the impression there's quite a
> bit of vendor-specific flexibility here in terms of how precise WCHAN
> is.

Oh, yeah, if you're happy with syscall-level granularity, that'd be
totally fine by me too.

> If it's possible to preserve the old WCHAN precision I'm all for it.
> But if we've become so paranoid about leaking anything about the
> kernel to userspace that this is untenable, even if it just spits out
> the syscall being performed that has value.

I'd like to find a middle ground -- wchan has always seemed like a info
leak, even with only symbols. And it doesn't help that walking the stack
from outside the current task is difficult. :)

-Kees

-- 
Kees Cook
