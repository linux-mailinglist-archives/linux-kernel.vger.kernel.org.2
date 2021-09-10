Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E456406AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhIJLg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:36:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:36:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 13D0820060;
        Fri, 10 Sep 2021 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631273746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zcbvus5WA0+0z24tstC+hoTCjs3/w77jO9Kk7LmE44w=;
        b=accfizHeK35x//PabQEWdEL0MaQmdN/eNtI66epTYgHerUKhebZi7evLgBghkZVToEJA+8
        t1T+XQMPY8rgLvCCPiUhEODpMmUfyQMjF55S1+OBDg3brXARmihcmtRV6X3HY5Lw8K0KZ4
        rdOtJzEwKQZeNJWDVM4YhIx3DEaH5L8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D322E13D34;
        Fri, 10 Sep 2021 11:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bwKHMRFDO2EINQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 10 Sep 2021 11:35:45 +0000
Date:   Fri, 10 Sep 2021 13:35:44 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [RFC PATCH v2 1/5] sched/fair: Add ancestors of unthrottled
 undecayed cfs_rq
Message-ID: <20210910113544.GB24156@blackbody.suse.cz>
References: <20210819175034.4577-1-mkoutny@suse.com>
 <20210819175034.4577-2-mkoutny@suse.com>
 <CAKfTPtDkOcAwQtfHhQ_OZH7UZ0fDuhqoNrGLPFO3ikkWMPuSFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDkOcAwQtfHhQ_OZH7UZ0fDuhqoNrGLPFO3ikkWMPuSFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent.

Thank you for looking into this!

On Thu, Sep 09, 2021 at 03:57:37PM +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > +               /* Nothing to run but something to decay? Complete the branch */
> > +               if (cfs_rq->on_list)
> 
> Could you use !cfs_rq_is decayed(cfs_rq) ?

What needs to be checked here is whether the list was modified by adding
the cfs_rq (and branch needs closing).

It'd appear that the equal condition like in tg_unthrottle_up() would
make do, i.e.
	!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running
but the unthrottle_cfs_rq() can be called under a still throttled
ancestor (i.e. throttle_count not dropping to zero) and in such a case
cfs_rq should not be added to the list yet.

Therefore, mere !cfs_rq_is_decayed(cfs_rq) doesn't seem correct to me.

> > +                       for_each_sched_entity(se) {
> > +                               if (list_add_leaf_cfs_rq(group_cfs_rq(se)))
> > +                                       break;
> > +                       }
> > +               assert_list_leaf_cfs_rq(rq);
> 
> Instead of adding  a loop here you should better jump to unthrottle_throttle ?

Oh, that looks a bit clumsy now (it's an artifact I've left when
reordering the patch in the series to be backport-friendly). 
Jump to unthrottle_throttle seems easier indeed, there would be just the
additional check
	if (rq->curr == rq->idle && rq->cfs.nr_running)
. Besides unnecessary work, it should be harmless.

Is the jump the preferred form?

Michal
