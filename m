Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D9446784
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhKERGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhKERGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:06:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D424C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:03:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d24so14770770wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fa68RjXL17wDE1QyhO5seUbk5qDTftp8+YWtD/apyUc=;
        b=tt0tD/smNU82N7aK6fgkDyJfNbm7G+VHUcvOix0J+VSv0mCfr2jplb83M6Tee4F7LP
         toZwm0wG4K5Sg+T6FBEG4OvgedTwb+UqJD1j6cIUcK/QEQ3X6Dx6j2haFILWTEpo3PDh
         IgDq69mMEgA8rapLOOG0qPWBA6G4qxSQGNRcf1wocSsMuuajHIwU7kFu34+bJkZjk2c6
         lD1BxdWupTcK6vakstPLLstzutuIftYqRrtG3D5MQDukN4Epk2FYVtyaN6VBTUOpOGRD
         GFT9qeE6nti6Sh0zcNTAw33+XI8mfxYzf4HlGOa+vjrRX5WhpOZ6GtBjrOoL3tngYxFQ
         8MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fa68RjXL17wDE1QyhO5seUbk5qDTftp8+YWtD/apyUc=;
        b=HvOzkNHNm7VFrnVjB98LqcGhQnlWJmiqfJW/betnG83arLLY95PSYurEqkAW8SgxwH
         uCsDkohA+/pVXibqgQYHh69SZ8wP7pL0NFyXeIEfEUhRBhuFbps7f1Mgy31L/GTG9V3Z
         6gbWk//KNC2lkJ6pqAdWhDnUMDcCE/jPkCK+MQrptBcGN36pgnJiPGEZNwO1Au/SjBhG
         VYbxuWQHF6uFwPTi0fBoxHIeBYYzgvcvLtNdvYoSB7wZBBpewGtjetoxYQqHZrc18Iz2
         gATDfh+d589nWOE5nkzXKJuqbAVMG0Wn3kBMnbXxcbxPc+YkcbLsIH/HiTDohBoT6bK3
         8eRg==
X-Gm-Message-State: AOAM532wSLWQTz/W2woley9i5UI9/DBf+0j5sILoZHrSsskkiZBy+vJv
        5VUX46BIIUOnqR54javDfKKlLQ==
X-Google-Smtp-Source: ABdhPJzqHkogUpOzCOGYezL7RVKkr8uk721WIoYd7cVs4VEI8w3NOselEPKeURJeWzbwpbO5lcHj3w==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr53269340wrm.259.1636131816659;
        Fri, 05 Nov 2021 10:03:36 -0700 (PDT)
Received: from localhost ([91.75.210.37])
        by smtp.gmail.com with ESMTPSA id n1sm6539893wmq.6.2021.11.05.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 10:03:35 -0700 (PDT)
Date:   Fri, 5 Nov 2021 21:03:28 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, sboyd@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rosted@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] possible deadlock in ktime_get_coarse_ts64
Message-ID: <20211105170328.fjnzr6bnbca7mdfq@amnesia>
References: <00000000000013aebd05cff8e064@google.com>
 <87lf224uki.ffs@tglx>
 <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:53:06AM -0700, Alexei Starovoitov wrote:
> On Fri, Nov 5, 2021 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > >
> > > -> #0 (tk_core.seq.seqcount){----}-{0:0}:
> > >        check_prev_add kernel/locking/lockdep.c:3051 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3174 [inline]
> > >        validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
> > >        __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
> > >        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
> > >        seqcount_lockdep_reader_access+0xfe/0x230 include/linux/seqlock.h:103
> > >        ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
> > >        ktime_get_coarse include/linux/timekeeping.h:120 [inline]
> > >        ktime_get_coarse_ns include/linux/timekeeping.h:126 [inline]
> >
> > --> this call is invalid
> >
> > >        ____bpf_ktime_get_coarse_ns kernel/bpf/helpers.c:173 [inline]
> > >        bpf_ktime_get_coarse_ns+0x7e/0x130 kernel/bpf/helpers.c:171
> > >        bpf_prog_a99735ebafdda2f1+0x10/0xb50
> > >        bpf_dispatcher_nop_func include/linux/bpf.h:721 [inline]
> > >        __bpf_prog_run include/linux/filter.h:626 [inline]
> > >        bpf_prog_run include/linux/filter.h:633 [inline]
> > >        BPF_PROG_RUN_ARRAY include/linux/bpf.h:1294 [inline]
> > >        trace_call_bpf+0x2cf/0x5d0 kernel/trace/bpf_trace.c:127
> > >        perf_trace_run_bpf_submit+0x7b/0x1d0 kernel/events/core.c:9708
> > >        perf_trace_lock+0x37c/0x440 include/trace/events/lock.h:39
> > >        trace_lock_release+0x128/0x150 include/trace/events/lock.h:58
> >
> > Timestamps from within a tracepoint can only be taken with:
> >
> >          1) jiffies
> >          2) sched_clock()
> >          3) ktime_get_*_fast_ns()
> >
> > Those are NMI safe and can be invoked from anywhere.
> >
> > All other time getters which have to use the timekeeping seqcount
> > protection are prone to live locks and _cannot_ be used from
> > tracepoints ever.
> 
> Obviously.
> That helper was added for networking use cases and accidentally
> enabled for tracing.

Sorry for that.
I'm preparing a patch that will forbid using bpf_ktime_get_coarse_ns()
helper in BPF_LINK_TYPE_RAW_TRACEPOINT.



-- 

Dmitrii Banshchikov
