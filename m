Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3BC44C207
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhKJNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhKJNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:24:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD627C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:21:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1948927wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nSHeg+VR13aOu2Z2zxGZikb83vMLSFkcE3p79Vw4NM=;
        b=Cj8Du9IdyEn04AQkfT9B2aGGW1ckXszoFiPpaRwkZUM74Wnatk1LUBoSWNcHkQbc0o
         a5Szh5GJJCfZD99PEeQcu6ygFoVYpy1wakuwo5WZogubUzcRUbYUnC2e5PkgzY2KxFfb
         6r0CPx4+c7BWPN594V90wjF+d6WPBaLtZBnO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9nSHeg+VR13aOu2Z2zxGZikb83vMLSFkcE3p79Vw4NM=;
        b=thukzkVPoMo6HCGEnXOLML0gWzoiMW5pIxH75GaggGw8y+O4MiDSzjXk04Gc0qllk0
         +Y4SOyjF4A4k72h3wvdxPF37/srK4PIwnqLTnk3H/V658X4kw4GzXP90bac6IFKtHtGl
         xMNvc2IrkI+47HUCSSB6HAM/8JPIXlolwiIWfP5FOnjcwegSSK95U4iPsTGQqO1jkL+x
         Egym13JLufD+Hw7ryApJzOI6H9VepwmDiwvyEGKoftFxqDe/T19ynfJCzdH1HpFCPS2v
         HU0hgc4qJPxVmngTsEhMA4qOO7qP211cpPSZWOItj75XH5buPnWJPp/euPGB3HqRQy76
         neTQ==
X-Gm-Message-State: AOAM531yh3hSeOtZJra9waTqCUvzJ91WTyRzbH408G4ATGl+gC3jsMDG
        kmtEXHjceSyls0VbSj9TpycmiQ==
X-Google-Smtp-Source: ABdhPJzk6gaBdUKVq9eBgi4VIxdWtfAgmKffHb3oaPOsqV9BA2PTcP8EqDE+NI+N0VcNuqObmk/fgg==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr16319206wma.30.1636550494461;
        Wed, 10 Nov 2021 05:21:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l11sm22401680wrp.61.2021.11.10.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 05:21:33 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:21:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
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
        Mel Gorman <mgorman@suse.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <YYvHW1OpN1L2uInb@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <YYuj/rT+EO3K0LsK@alley>
 <YYuq5d7MYL2wxlOd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuq5d7MYL2wxlOd@hirez.programming.kicks-ass.net>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:20:05PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 10, 2021 at 11:50:38AM +0100, Petr Mladek wrote:
> > On Tue 2021-11-09 12:06:48, Sultan Alsawaf wrote:
> > > Hi,
> > > 
> > > I encountered a printk deadlock on 5.13 which appears to still affect the latest
> > > kernel. The deadlock occurs due to printk being used while having the current
> > > CPU's runqueue locked, and the underlying framebuffer console attempting to lock
> > > the same runqueue when printk tries to flush the log buffer.
> > > 
> > > I'm not sure what the *correct* solution is here (don't use printk while having
> > > a runqueue locked? don't use schedule_work() from the fbcon path? tell printk
> > > to use one of its lock-less backends?), so I've cc'd all the relevant folks.
> > 
> > At the moment, printk_deferred() could be used here. It defers the
> > console handling via irq_work().
> 
> I think I've rejected that patch at least twice now :-) John's printk
> stuff will really land real soon now, right.

Yeah whacking all affected prinkt callers just because of fbcon does not
sound like a good idea to me either.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
