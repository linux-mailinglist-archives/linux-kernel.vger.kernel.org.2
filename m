Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792433FE13B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbhIARjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344571AbhIARjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630517897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovzfigQ9PjumMi6vv/w8A1YnKSQyDl5eGNpklc8y6No=;
        b=V3TDEpT3IuWaKkxiiB/W/KUd12D/Lq+VXHoJQfkLXug4dKTkfZsaHX5MYsqKT2Q1oQ9CYA
        LP4WwC3um/kMar0wvHieowBMkgbZeH2kc4T/OO1K8oO8AoczvNwHSnIkY5I62IiGSWSjfG
        ntQBU2cABvtjuQ/TcBHmhDO5cfJ91fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-9TQ3AenOOs-ms0RjhFq3lg-1; Wed, 01 Sep 2021 13:38:16 -0400
X-MC-Unique: 9TQ3AenOOs-ms0RjhFq3lg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EE37802921;
        Wed,  1 Sep 2021 17:38:15 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D7F5FC23;
        Wed,  1 Sep 2021 17:38:07 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 983C64175292; Wed,  1 Sep 2021 14:32:04 -0300 (-03)
Date:   Wed, 1 Sep 2021 14:32:04 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Lal <nilal@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 8/8] mm: vmstat_refresh: avoid queueing work item if
 cpu stats are clean
Message-ID: <20210901173204.GA48995@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.948424573@fuller.cnet>
 <CAFki+LkNcwFATSth4cvU=-7aBZjaLLNU6UFWYv1DxkeYwkeuSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFki+LkNcwFATSth4cvU=-7aBZjaLLNU6UFWYv1DxkeYwkeuSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:05:55AM -0400, Nitesh Lal wrote:
> Hi Marcelo,
> 
> On Tue, Aug 24, 2021 at 11:42 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > It is not necessary to queue work item to run refresh_vm_stats
> > on a remote CPU if that CPU has no dirty stats and no per-CPU
> > allocations for remote nodes.
> >
> > This fixes sosreport hang (which uses vmstat_refresh) with
> > spinning SCHED_FIFO process.
> >
> 
> I was still able to reproduce the sosreport hang with this patchset and I
> am wondering if that is because right now we do vmstat_sync and then cancel
> any pending jobs on a CPU in the context of one task.

Hi Nitesh,

Did you use chisol (with proper flags) and the modified oslat?

Tested with "echo 1 > /proc/sys/vmstat_refresh" and it was successful
(no hangs).

> However, while this task is running another process can come in and can
> dirty the stats resulting in vmstat job getting placed on CPUs running
> SCHED_FIFO tasks.
> Am I missing something?
> What we can probably do is to communicate that a CPU is running on task
> isolation mode to any other process that is trying to run and schedule
> jobs there.

No, that can happen. Can use sched notifiers to handle this problem.
Good point.

