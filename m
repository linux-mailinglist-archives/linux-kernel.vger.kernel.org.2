Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0731E42C316
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhJMO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:28:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhJMO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:28:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7744921963;
        Wed, 13 Oct 2021 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634135205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMu5WsltBSxCakMJcGg6n0yfN/pBnvFmXIBjYygrFJM=;
        b=JNZmW3+sfkxw2zvc+FCxwg6d0Xr7FyW09kyooDQsj3ro3TM5r58LTcVPyB/qEziIrHihT+
        v+0IwrKSHeBce/z7z2TEXO224e8HS5S/RPRRPBUGc6iJxUTIylaSfic22fYYt79XrgtRED
        7fYb0WpOfu72fPjCkwIlfg12A8203Mc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CE2213CEC;
        Wed, 13 Oct 2021 14:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 17U7EqXsZmHoTwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 13 Oct 2021 14:26:45 +0000
Date:   Wed, 13 Oct 2021 16:26:43 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list
 presence
Message-ID: <20211013142643.GA48428@blackbody.suse.cz>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:57:17AM +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> Furthermore, list_del_leaf_cfs_rq() starts with the same test on of
> cfs_rq->on_list.

Yes, the same check but synchronized with rq->lock.

> The problem is that the cfs_rq can be added during or
> after the test. Removing it should not be enough because we do the
> same test under rq lock which only ensures that both the test and the
> add on the list will not happen simultaneously.

This is what I overlooked when I was looking for explanation of the UAF
on the leaf list.

> This seems to closes the race window in your case but this could still
> happen AFAICT.

You seem to be right.
Hopefully, I'll be able to collect more data evaluating this.

> What about  your patchset about adding a cfs in the list only when
> there is a runnable task ?

The patches I had sent previously [1] avoid adding cfs_rq to the list
when it's under a throttled ancestor (namely 4/5). The runnable
condition is rather orthogonal. (Not sure it's the patchset you were
referring to.)


> Wouldn't this fix the problem ?

FWIW, the "reliable" fix so far is a revert of the commit a7b359fc6a37
("sched/fair: Correctly insert cfs_rq's to list on
unthrottle"). Therefore my hypothesis about racy adding from
tg_unthrottle_up(), so I think the other patches won't affect the issue.

Thanks for your feedback. Let me examine the problem some more before
continuing with this patch.

Michal


[1] https://lore.kernel.org/all/20210819175034.4577-1-mkoutny@suse.com/
