Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09144BDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhKJJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKJJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:40:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B2C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:37:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c8so7898074ede.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChO8dXpRdBd9VPlzr8T0hSf0ouf3LTb8saLsKMYhRk4=;
        b=UfVlQOF9esGlpotawOMw8sCJXrWktXR4niiMHxuRJefTcqgU80GQ6kzs5ECZH3qpzf
         i4aT+SI4vgLm8Idj8TtlkXWeyPt/2baUP+CfNZ26E7mOQpMcW349C03zuhxYN+J7Ba8s
         FJ0RA2xwLkErE+oQyI24cWBdAVrSdRdmHCUYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ChO8dXpRdBd9VPlzr8T0hSf0ouf3LTb8saLsKMYhRk4=;
        b=PKmuoStpgjCFhbAy9juvsW+NLlcjDn9XSFVaMSrJ64Iw7iRzzgOOu5iZqoz/Zb5jx9
         k3gmZ6InlZuTCFB0m20XmUU9tDBW+Gbq62lRcDjskerUX/DVrfQWFvn/kohsUyLlo41D
         5JiVgbWi8YsZgFQO/no0T8xStUy32uUsi5bHC9/QpGj6LauTS5P6a+PS0J2vKxWdzKMB
         T80M3az/SbBPZdHq2kOvsptHEU8vCgYQ+JVntUK3p3uexlLpWWONF2r0VPOmawfUdmus
         5YAoCEQC/TD2D67LOMCG4H/tb/N0UE1C1uP8/IJqFtogj1iz8cD4Zasew4EKy20gNSYR
         DMOg==
X-Gm-Message-State: AOAM533KF5ZDGMqoKkNqQmOIw3NsrBKjPaBL6MtdgYB85mzEMF7Iusfu
        bGnykGnt5G9pv4oGQEePVxxHZQ==
X-Google-Smtp-Source: ABdhPJyGmVdvVE9HpSMVH29kiytl0Kpov+cLP0PHo9fDDLP7o0Z/i8nHJ+2xuA+4OI9gr/xkt5MRMA==
X-Received: by 2002:a17:907:7094:: with SMTP id yj20mr18988259ejb.265.1636537049013;
        Wed, 10 Nov 2021 01:37:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y6sm12917452edc.17.2021.11.10.01.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 01:37:28 -0800 (PST)
Date:   Wed, 10 Nov 2021 10:37:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, mkoutny@suse.com
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <YYuS1uNhxWOEX1Ci@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Anton Vorontsov <anton@enomsg.org>, Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, mkoutny@suse.com
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <20211109213847.GY174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109213847.GY174703@worktop.programming.kicks-ass.net>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 10:38:47PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 09, 2021 at 12:06:48PM -0800, Sultan Alsawaf wrote:
> > Hi,
> > 
> > I encountered a printk deadlock on 5.13 which appears to still affect the latest
> > kernel. The deadlock occurs due to printk being used while having the current
> > CPU's runqueue locked, and the underlying framebuffer console attempting to lock
> > the same runqueue when printk tries to flush the log buffer.
> 
> Yes, that's a known 'feature' of some consoles. printk() is in the
> process of being reworked to not call con->write() from the printk()
> calling context, which would go a long way towards fixing this.

I'm a bit out of the loop but from lwn articles my understanding is that
part of upstreaming from -rt we no longer have the explicit "I'm a safe
console for direct printing" opt-in. Which I get from a backwards compat
pov, but I still think for at least fbcon we really should never attempt a
direct printk con->write, it's just all around terrible.

And it's getting worse by the year:
- direct scanout displays (i.e. just a few mmio writes and it will show
  up) are on the way out at least in laptops, everyone gets self-refresh
  (dp psr) under software control, so without being able to kick a kthread
  off nothing shows up except more oopses

- because of the impendence mismatch between fbdev and drm-kms we even go
  ever more this direction for dumb framebuffers, including the firmware
  boot-up framebuffer simpledrm. This could perhaps be fixed with a new
  dedicate console driver directly on top of drm-kms, but that's on the
  wishlist for years and I don't see anyone typing that.

So yeah for fbcon at least I think we really should throw out direct
con->write from printk completely.

Also adding John Ogness.
-Daniel

> 
> >   #27 [ffffc900005b8e28] enqueue_task_fair at ffffffff8129774a  <-- SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
> >   #28 [ffffc900005b8ec0] activate_task at ffffffff8125625d
> >   #29 [ffffc900005b8ef0] ttwu_do_activate at ffffffff81257943
> >   #30 [ffffc900005b8f28] sched_ttwu_pending at ffffffff8125c71f <-- locks this CPU's runqueue
> >   #31 [ffffc900005b8fa0] flush_smp_call_function_queue at ffffffff813c6833
> >   #32 [ffffc900005b8fd8] generic_smp_call_function_single_interrupt at ffffffff813c7f58
> >   #33 [ffffc900005b8fe0] __sysvec_call_function_single at ffffffff810f1456
> >   #34 [ffffc900005b8ff0] sysvec_call_function_single at ffffffff831ec1bc
> >   --- <IRQ stack> ---
> >   #35 [ffffc9000019fda8] sysvec_call_function_single at ffffffff831ec1bc
> >       RIP: ffffffff831ed06e  RSP: ffffed10438a6a49  RFLAGS: 00000001
> >       RAX: ffff888100d832c0  RBX: 0000000000000000  RCX: 1ffff92000033fd7
> >       RDX: 0000000000000000  RSI: ffff888100d832c0  RDI: ffffed10438a6a49
> >       RBP: ffffffff831ec166   R8: dffffc0000000000   R9: 0000000000000000
> >       R10: ffffffff83400e22  R11: 0000000000000000  R12: ffffffff831ed83e
> >       R13: 0000000000000000  R14: ffffc9000019fde8  R15: ffffffff814d4d9d
> >       ORIG_RAX: ffff88821c53524b  CS: 0001  SS: ef073a2
> >   WARNING: possibly bogus exception frame
> > ----------------------->8-----------------------
> > 
> > The catalyst is that CONFIG_SCHED_DEBUG is enabled and the tmp_alone_branch
> > assertion fails (Peter, is this bad?).
> 
> Yes, that's not good. IIRC Vincent and Michal were looking at that code
> recently.
> 
> > I'm not sure what the *correct* solution is here (don't use printk while having
> > a runqueue locked? don't use schedule_work() from the fbcon path? tell printk
> > to use one of its lock-less backends?), so I've cc'd all the relevant folks.
> 
> I'm a firm believer in early_printk serial consoles.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
