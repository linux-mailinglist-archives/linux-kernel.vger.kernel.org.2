Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343BE44405C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhKCLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:13:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:13:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0579D1FD4C;
        Wed,  3 Nov 2021 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635937838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqTFYVPEJHUUFz1K4JpGQHNHu3HXx46Z0gT7uGeWIJk=;
        b=ZnH1ic3Vv22wURax8liabigAOQ8BTnK37dsrYEsO2i51QuWrVnJtUMKspAbxnmonxIs4B0
        o7tOOcNiOR5jpKgg86VytWOKUIx8f0qJSe6802OtGriUEsRNadKn0Ss/kDgvA4zHvHy9Vd
        E0RVSdyKMPdc7xUzf6MwWFFoKV0cBF4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D002813CCA;
        Wed,  3 Nov 2021 11:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t3xHMi1ugmHEKgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 03 Nov 2021 11:10:37 +0000
Date:   Wed, 3 Nov 2021 12:10:36 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: task_group unthrottling and removal race (was Re: [PATCH]
 sched/fair: Use rq->lock when checking cfs_rq list) presence
Message-ID: <20211103111036.GA10034@blackbody.suse.cz>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
 <20211013142643.GA48428@blackbody.suse.cz>
 <20211102160228.GA57072@blackbody.suse.cz>
 <73b4bddb-335b-1f25-a203-199be546e44a@grsecurity.net>
 <e2bcfc90-18b6-8da5-517c-023d2242ba97@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2bcfc90-18b6-8da5-517c-023d2242ba97@grsecurity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:51:12AM +0100, Mathias Krause <minipli@grsecurity.net> wrote:
> Adding synchronize_rcu() here will ensure all concurrent RCU "readers"
> will have finished what they're doing, so we can unlink safely. That
> was, apparently, the missing piece.

What reader(s) are you referring to here? The
list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
throttled_list) in distribute_cfs_runtime()?

I'm think (not sure) that wouldn't work since the unthrottle_cfs_rq can
still be called after this synchronize_rcu() but before
free_fair_sched_group().

(But if you considered update_blocked_averages() as the reader(s) and
synchronize_rcu() within free_fair_sched_group(), that may ensure UBA
won't step on a free'd cfs_rq (+unlinking would need to happen only in
free_fair_sched_group() too.))

Michal
