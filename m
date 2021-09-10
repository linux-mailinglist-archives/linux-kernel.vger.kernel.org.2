Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E09406AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhIJLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:37:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35674 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:37:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9B6020061;
        Fri, 10 Sep 2021 11:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631273753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2U6FvYLow74Hanu1/xbaQi9/pD51ihI7LomCd82Koc=;
        b=jituyff69IGj8vx3My6wYSDyaixrFPy4oqB+l/3hkoQgrLJN7YEuVZ4qvfyJCpBNTI9LUR
        t43nmEW2fR10hc31kk5qely8svMvJ8Yyu3lIOdmOteIf7QKL+hYBkrBVufoSKmYirfal9Y
        l16A5d189WcFIWmYirnmXGRXIg3clPY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8293513D34;
        Fri, 10 Sep 2021 11:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h2VRHxlDO2EcNQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 10 Sep 2021 11:35:53 +0000
Date:   Fri, 10 Sep 2021 13:35:52 +0200
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
Subject: Re: [RFC PATCH v2 5/5] sched/fair: Simplify ancestor enqueue loops
Message-ID: <20210910113552.GA30004@blackbody.suse.cz>
References: <20210819175034.4577-1-mkoutny@suse.com>
 <20210819175034.4577-6-mkoutny@suse.com>
 <CAKfTPtDwOGu9kkMdXDx=+mGVGq_EmF0wgLen7hYO+VEy+j6rig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDwOGu9kkMdXDx=+mGVGq_EmF0wgLen7hYO+VEy+j6rig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:04:02PM +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> These multiple break loops have been done to make unthrottle_cfs_rq,
> throttle_cfs_rq, enqueue_task_fair and dequeue_task_fair to follow the
> same pattern 

Ah, I watched only the unthrottle_cfs_rq and enqueue_task_fair pair and
missed the consistency with the other two.

> and I don't see any good reason to break this

Isn't this a good reason
>  21 insertions(+), 36 deletions(-)
?

(The stats are with a grain of salt, I'd need to recheck how these stats
would hold if throttle_cfs_rq, dequeue_task_fair would be modified too +
they look a bit better because of the loop from 1/5.)

Michal
