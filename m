Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79AD42C386
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhJMOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:41:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhJMOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:41:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F4E821983;
        Wed, 13 Oct 2021 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634135942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWjI5Tz5XS1VTE5npqHgDWB1ZpB318WTRerazdffcaQ=;
        b=j51RubDuioGfP1sJScdghFAyWtCz3Be3evD8eHu71hqNwJdwBSxAulbL0eukekIjoSdV0V
        uu+wiyfYvXDaTWnzfTtxJa1bzeD8Hc747OBQd2SNC6I9+izYUDk/MS8irMRJpH6mRShNi6
        5twVUjN/LZJFDMTsVl5cBARoFqKxc2A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FE5613D04;
        Wed, 13 Oct 2021 14:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P/8ID4bvZmE1VgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 13 Oct 2021 14:39:02 +0000
Date:   Wed, 13 Oct 2021 16:39:01 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Odin Ugedal <odin@uged.al>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list
 presence
Message-ID: <20211013143900.GB48428@blackbody.suse.cz>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:12:08PM +0100, Odin Ugedal <odin@uged.al> wrote:
> To be 100% clear, this can only happen when a control group is
> throttled while it has load
> (cfs_rq_is_decayed(cfs_rq) is false); and then its unthrottling race
> with its deletion?
> Is that a correct understanding Michal?

Yes, that's my working hypothesis but Vincent found a loophole in the
proposed fix under this assumption.


> Do you agree that that will also solve the problem Michal,
> or am I missing something obvious here?

It's not easy for me to verify this with a reproducer and as suggested
by your discomfort, let's dismiss this idea for the time being.

Michal
