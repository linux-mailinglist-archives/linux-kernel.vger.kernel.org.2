Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305C544BEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhKJKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:48:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:48:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE4A31FD3F;
        Wed, 10 Nov 2021 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636541111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUpTvZNhgXgXObp506QhXsYR81By+iDPFzAbaJOpy7E=;
        b=TnHZI7aCI7ViBAvgZ+UQC9O8UDlyQVUJBgV0QPZ0nOaVXq6ntU/j3fSteNuQoFjxEp4pqA
        sB7sLjxYQF6EqJg+SNCJbDVuQgSjEdwqUYMaWjVeLKGDZj1qhnwUo1wveJNtfIjldukL/C
        KQp3O7Wh6+WSEy66KMHjfi9VSa6x7u0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A92A13BEA;
        Wed, 10 Nov 2021 10:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JyhlGbeii2GhQAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 10 Nov 2021 10:45:11 +0000
Date:   Wed, 10 Nov 2021 11:45:10 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Mel Gorman <mgorman@suse.de>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <20211110104510.GB20566@blackbody.suse.cz>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <20211109213847.GY174703@worktop.programming.kicks-ass.net>
 <CAKfTPtC_A-_sfQ+rm440oHwd2gUZ222FMwsi-JTkyLPc-x0qrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC_A-_sfQ+rm440oHwd2gUZ222FMwsi-JTkyLPc-x0qrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:00:35AM +0100, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> Is it the same SCHED_WARN_ON(rq->tmp_alone_branch !=
> &rq->leaf_cfs_rq_list); that generates the deadlock on v5.15 too ?
> 
> one remaining tmp_alone_branch warning has been fixed in v5.15 with
> 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")

AFAIK, the warning is typically triggered on v5.13 when CPU throttling is
employeed. The cfs_rq list is mis-ordered but it shouldn't be fatal.
But the throttling currently (since v5.13 too) also exposes a race on
task_group removal that can lead to corrupting the cfs_rq list (another
thread [1], I'll leave this thread for printk (non)-locking).

HTH,
Michal

[1] https://lore.kernel.org/r/20211011172236.11223-1-mkoutny@suse.com/
