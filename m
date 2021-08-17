Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC73EF608
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhHQXSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhHQXSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629242269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqLeheCmzUoPSckkbkHc4q/EKrZdzeXZx6eM4WD1qck=;
        b=BQEHbxvN+OGh51mixhh8+5YWwTz/1Uc0gXfWCrKfXezVq7AnPr6FdQSocGL+XWjnLissR5
        SebfyWuvRat2dpYlOnuJL3hN+prqt7wLYaudKx2PDxWZKypLfvbn0LIXzq7ko85N81oQFU
        RPNHomG1UD4t3LOV2gL/ALs43gg7RUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-cxAPWYwxPOWuRvO00cBsHg-1; Tue, 17 Aug 2021 19:17:45 -0400
X-MC-Unique: cxAPWYwxPOWuRvO00cBsHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE9D61009600;
        Tue, 17 Aug 2021 23:17:43 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3057719D9B;
        Tue, 17 Aug 2021 23:17:37 +0000 (UTC)
Date:   Wed, 18 Aug 2021 01:17:34 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
Message-ID: <20210817231734.GA4449@asgard.redhat.com>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
 <20210817151542.GA1665@asgard.redhat.com>
 <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 05:52:43PM +0200, Peter Zijlstra wrote:
> Urgh... lemme guess, your HP BIOS is funny and reports more possible
> CPUs than you actually have resulting in cpu_possible_mask !=
> cpu_online_mask. Alternatively, you booted with nr_cpus= or something
> daft like that.

Yep, it seems to be the case:

    # cat /sys/devices/system/cpu/possible
    0-7
    # cat /sys/devices/system/cpu/online
    0-3

> 
> That code does for_each_possible_cpus(i) { rq_lock_irq(cpu_rq(i)); },
> which, because of core-sched, needs rq->core set-up, but because these
> CPUs have never been online, that's not done and *BOOM*.
> 
> Or something like that.. I'll try and have a look tomorrow, I'm in dire
> need of sleep.
> 

