Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4406944BEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhKJKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:47:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A35C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:44:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 133so1761931wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=p35G3ijWYSUCO76ZEBrzccMf7240Z+98t5Me52oGPwQ=;
        b=IbF5MqhTtHW6snonBwLIrT+7aciMv/DVbtIJrIF+PIQqh6aSvt9j57AKt4wyV+ZDBD
         pIt2OlK+LFmEOGeAKY49BIb7entn9QskIGwyLrGOIHRQDgDLNBZHd5y6ru/Htz4y5IIq
         /FJjYb5t8SnSfjm8gi6LqKRLmgR72Vq79tB90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=p35G3ijWYSUCO76ZEBrzccMf7240Z+98t5Me52oGPwQ=;
        b=ATWF/S9knQTdLzSHwH4RSvlX8vn5Xr8gH69Foog7gbdP1hH7xi2axdDLHOcu94QjyN
         gSLEYTPzj23S5ssgqULfTzGHlna0AMk6WcdAJ2I/ilYLK1yUVwphGGWjI8NTefkv5DV1
         yNFv/ehhPCa0Moyt/0p3DQ5XxpUuRtsSVY/KYESYSOz2KQ035s/WxnvRPHtcBYqZIDgk
         WAKKfz1c3k0blVMnKhJVsSdpuWoPruyXsQG3jHfBklo7BQSkX0qed1h9YrXnMDf8OgHq
         gVAHL67OsQKovdprgiiKwUefTvLgV5VCG+5geeKV667UdtIjUF1LZkR6EKyVEn6HETa8
         Q34g==
X-Gm-Message-State: AOAM5300bUomRcoygu9yfQzidrokw7FzM/7IZb3tFnEOEITC0mhhPY5w
        5Sa8WQegfLkJIRF++zn1KHY/gA==
X-Google-Smtp-Source: ABdhPJzH6O4jsCGRpjkebrKGva92XLIAnPh2IE1dOn2/jVwMLzYzmdkh44S5Z0sZdH5khZ2i/ETk/A==
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr15214691wmq.191.1636541056794;
        Wed, 10 Nov 2021 02:44:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a9sm22383643wrt.66.2021.11.10.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 02:44:16 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:44:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <YYuifp8voMuTtMh3@phenom.ffwll.local>
Mail-Followup-To: John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Anton Vorontsov <anton@enomsg.org>, Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
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
 <YYuS1uNhxWOEX1Ci@phenom.ffwll.local>
 <87fss4wcgm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fss4wcgm.fsf@jogness.linutronix.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:13:37AM +0106, John Ogness wrote:
> On 2021-11-10, Daniel Vetter <daniel@ffwll.ch> wrote:
> > I'm a bit out of the loop but from lwn articles my understanding is
> > that part of upstreaming from -rt we no longer have the explicit "I'm
> > a safe console for direct printing" opt-in. Which I get from a
> > backwards compat pov, but I still think for at least fbcon we really
> > should never attempt a direct printk con->write, it's just all around
> > terrible.
> 
> Right now we don't have an explicit "I'm a safe console for direct
> printing" option. Right now all printing is direct. But it sounds to me
> that we should add this console flag when we introduce kthread printers.

Ah I wasnt' clear whether this was merged already or not yet.

> > So yeah for fbcon at least I think we really should throw out direct
> > con->write from printk completely.
> 
> Even after we introduce kthread printers, there will still be situations
> where direct printing is used: booting (before kthreads exist) and
> shutdown/suspend/crash situations, when the kthreads may not be
> active.
> 
> I will introduce a console flag so that consoles can opt-out for direct
> printing. (opt-out rather than opt-in is probably easier, since there
> are only a few that would need to opt-out).

Yeah opt-out for fbcon sounds good to me, and then across the board (even
when the kthread is not yet or no longer running, it really doesn't make
anything better). Maybe with a fbcon module (or system wide
force_direct_printk) option to disable that flag in case someone needs
it.

> Since kthread printers do not yet exist (hoping to get them in for
> 5.17), I am not sure how we should address the reported bug for existing
> kernels.

I think we just can't. This thing keeps popping up in all kinds of places,
and in some cases it's really not possible to fix it. Like in
oops_in_progress we can just give up, but for normal printk from funny
places we'd corrupt the console (plus there's no flag to even detect these
cases), since we really need to launch these work_struct to get stuff to
the screen.

I think in the past we sometimes managed to work around the issue by
moving the printk outside of locks, but that's rarely a good idea just
because fbcon.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
