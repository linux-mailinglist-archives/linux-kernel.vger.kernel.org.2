Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B58413CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhIUVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:41:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhIUVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:41:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E305F22231;
        Tue, 21 Sep 2021 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632260426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1pf8A2LEZRnJDCFgdhhV4jNvAnQNjTPCx0npuMr8mUk=;
        b=ppozAP9lWLzVJ/wRYAeyuzxOkkAMPOQorJ+TVuX22Rd/h2kfDW1qOVQE+j0WIO3LWfwfWl
        79qDAwxGfP2lBu089g/VcrakJ+cp6qg4uu9gP++0GOuqTF4+Sx80MyESrTWgbAowIl6p1x
        q0ZKsKtfhl2JoyHg/aftoNGoCkw71Cs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E9B713BF7;
        Tue, 21 Sep 2021 21:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S6aMHUpRSmHNIgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 21 Sep 2021 21:40:26 +0000
Date:   Tue, 21 Sep 2021 23:40:25 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Odin Ugedal <odin@uged.al>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list
 maintenance
Message-ID: <YUpRSXslUE+oKQEm@blackbook>
References: <20210819175034.4577-1-mkoutny@suse.com>
 <20210819175034.4577-5-mkoutny@suse.com>
 <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
 <20210914092207.GA23743@blackbody.suse.cz>
 <CAKfTPtDw6_iMxGyCK8vrwgV-zMyHtNKBksxs3OpbpK=houzp2g@mail.gmail.com>
 <CAKfTPtC5+4gf_R0bAVHe+0Fw6dQYQ_a-f529H9s4KLpm40X9Ng@mail.gmail.com>
 <CAFpoUr3APdFordH+1XjHPWP5FtKuQBAXSRTt4arruMkQcx2ufg@mail.gmail.com>
 <CAFpoUr1S4N1g_pP2d9_EMFn3zuwQejsxkBbCd5LTQ-KuwOXbLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFpoUr1S4N1g_pP2d9_EMFn3zuwQejsxkBbCd5LTQ-KuwOXbLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 08:21:50PM +0100, Odin Ugedal <odin@uged.al> wrote:
> With the changes in PATCH 1 of this series [0],

That patch is an independent fix of the described bug.

> I think this logic needs to be updated as well (or correct me if I am
> wrong).

I might be dense, what update are you referring to? (The adding to the
list in tg_unthrottle_up() is already guarded by
cfs_rq->throttle_count.)

> Did a quick look now, and it looks like there are some conflicts with
> the linus' tree when applying the series as well, but didn't look that
> deep into what caused it (for ref I tested on v5.15-rc2).

This v2 was based on v5.14-rc6 back then and yes when I was rebasing
(locally), I had to resolve conflicts because of SCHED_IDLE for cgroups.

> Not sure how you want to structure this patch series as all the
> patches kinda depend on each other, since you sent the updated one
> separately (and I am fairly new to kernel development, so I have no
> idea), while patch 1 is fixing a "real" issue that we probably want to
> get fixed as soon as possible.

I put the patch first in the series to be backport friendly but then I
decided to send v3 of just that one patch, exactly for the reason of
making the fix earlier.
I may get down to addressing feedback of the remaining patches (v2, 2--5)
only later. Thanks for your comments and patience :-)

Michal
