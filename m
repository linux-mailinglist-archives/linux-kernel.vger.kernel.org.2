Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191DD44BE46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKJKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:10:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41954 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhKJKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:10:26 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636538858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H3iJsYLymZGZdTTPIwaF3WwOUQj7EWnfPhR6PY5oWA=;
        b=i97ffLNgZOCzWFBRclG7GYiqXi7MHOrZxbOXgJo0pTV9VaaVPhnG7NnoN6yM3YQF/vW6FC
        /3gyS9iBsC5urXBvXaYF49NEiCksYHVOTalS1S/1WP1VfMlkHIkSawA/Ap8njZ2dqksKpL
        LqdnqRoK4lkmtv0Nz56XOk+A2fQ6Qr/lejEAUjmBko0vER8YoFp+rdooaaLKYDMEXhtJoH
        jx7lE1sPblbEaXau0X5Qe99u1WmUZbWkd/MsTkgcxhkOaB1uhw+41/cBH3eVL3dFXAOQqw
        J6WbiaGNlGR9igGy7y9MoRYhexo0UfhlV76JID34cVRgrVSIGg+lt80o8j0N5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636538858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H3iJsYLymZGZdTTPIwaF3WwOUQj7EWnfPhR6PY5oWA=;
        b=ee6Y2TYLMpo7uGsr+qYoymWA2RnXgQ7bpfSm69n5Kv+JYUF4RpPSJ2gC9dckYjRQ6jAAGr
        HFIj1zE58dGl46AA==
To:     Daniel Vetter <daniel@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
In-Reply-To: <YYuS1uNhxWOEX1Ci@phenom.ffwll.local>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <20211109213847.GY174703@worktop.programming.kicks-ass.net>
 <YYuS1uNhxWOEX1Ci@phenom.ffwll.local>
Date:   Wed, 10 Nov 2021 11:13:37 +0106
Message-ID: <87fss4wcgm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-10, Daniel Vetter <daniel@ffwll.ch> wrote:
> I'm a bit out of the loop but from lwn articles my understanding is
> that part of upstreaming from -rt we no longer have the explicit "I'm
> a safe console for direct printing" opt-in. Which I get from a
> backwards compat pov, but I still think for at least fbcon we really
> should never attempt a direct printk con->write, it's just all around
> terrible.

Right now we don't have an explicit "I'm a safe console for direct
printing" option. Right now all printing is direct. But it sounds to me
that we should add this console flag when we introduce kthread printers.

> So yeah for fbcon at least I think we really should throw out direct
> con->write from printk completely.

Even after we introduce kthread printers, there will still be situations
where direct printing is used: booting (before kthreads exist) and
shutdown/suspend/crash situations, when the kthreads may not be
active.

I will introduce a console flag so that consoles can opt-out for direct
printing. (opt-out rather than opt-in is probably easier, since there
are only a few that would need to opt-out).

Since kthread printers do not yet exist (hoping to get them in for
5.17), I am not sure how we should address the reported bug for existing
kernels.

John Ogness
