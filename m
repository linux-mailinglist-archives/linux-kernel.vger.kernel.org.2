Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8344D32B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhKKIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:30:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhKKIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:30:52 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636619281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhZvEsWQota4q77s+urSnI/dc/KS4PVviHnz9T+ZBLI=;
        b=zxeCK3x2qPG1H0FI+d02YQKAzXvODf+N0FcmajK0bIiT8YksXK+jPHZUr7Fkt5Mg2OI1IU
        m3MHqGYDTcBazKiapSpDkUw8XEyrrij2XvCgNYrr8A4px09a2Usk1mK3l75kJjzg53s/03
        osCXpF71fnqT5SBQA1ZUCJkdMP71du3egG24JgIZ5+EYHp56OQTPWlQDmwqzkQRU6BTe6w
        aY7bVT8Wuzi9KSHnQplpL+pW4esIhhednxIDnttsR+xbrHS6xInlKOp8EFEpX0cJx4r+p3
        ITSc2lUk65ua42lYTvllKvP8YnO1906EZ9cA2UVKx7DwliS0PIEgErwSFPfpnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636619281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhZvEsWQota4q77s+urSnI/dc/KS4PVviHnz9T+ZBLI=;
        b=8olYsRkMhkQVAaV/05y5wam89kU1Av69szldbJaSE09rlzjgSzB6WcLdDEC0HqXeSstmKA
        vBAGvvTfgD+XjHCA==
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <YYwlnEQO0raDwS86@sultan-box.localdomain>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <20211109213847.GY174703@worktop.programming.kicks-ass.net>
 <YYuS1uNhxWOEX1Ci@phenom.ffwll.local>
 <87fss4wcgm.fsf@jogness.linutronix.de>
 <YYwlnEQO0raDwS86@sultan-box.localdomain>
Date:   Thu, 11 Nov 2021 09:34:00 +0106
Message-ID: <87k0hfqepb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-10, Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> On Wed, Nov 10, 2021 at 11:13:37AM +0106, John Ogness wrote:
>> Even after we introduce kthread printers, there will still be
>> situations where direct printing is used: booting (before kthreads
>> exist) and shutdown/suspend/crash situations, when the kthreads may
>> not be active.
>
> Although I'm unaware of any ongoing kthread printer work, I'm curious
> to know how a kthread approach wouldn't employ a try_to_wake_up() from
> directly inside printk(), since the try_to_wake_up() hit from inside
> the fbcon code is what caused my deadlock.

The kthread approach triggers irq_work from printk(). The kthread
printer is then woken from the irq_work.

John Ogness
