Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7F355A34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbhDFRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232593AbhDFRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617729813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRqtUNrfsS+HN0qfeBVlZNBL6W5/ImsXWPSzbVRKt/s=;
        b=RO4IpaVKqPxsFdb7Wx/Yi0Y76KDQ7oRpyPP5ID4Kt7VhSqFKNEwBg29t7BCxu1fAZsiTvk
        Zh81qSwPIWiC3WBnn1h6ef5angQooYzyCBYocoSKqP4QoaNU2B0Ev/HnqBfNnsbeHs9RO5
        OPHqCRiANgI8YGr4U1e3Iv5SWPZBrkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-KqAku7wLMu2Mn_cMrPZxxQ-1; Tue, 06 Apr 2021 13:23:29 -0400
X-MC-Unique: KqAku7wLMu2Mn_cMrPZxxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1D3E1007468;
        Tue,  6 Apr 2021 17:23:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4F74410016DB;
        Tue,  6 Apr 2021 17:23:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Apr 2021 19:23:27 +0200 (CEST)
Date:   Tue, 6 Apr 2021 19:23:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hillf Danton <hdanton@sina.com>, Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: perf_mmap_close() -> put_event() -> event.destroy() can deadlock
Message-ID: <20210406172322.GA13270@redhat.com>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
 <20210328025217.7312-1-hdanton@sina.com>
 <20210401092907.1098-1-hdanton@sina.com>
 <20210402074636.1270-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402074636.1270-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song, Peter, please take a look.

On 04/02, Hillf Danton wrote:
>
> On Thu, 1 Apr 2021 12:53:26  Oleg Nesterov wrote:
> >
> >Hmm, please correct me, but I don't think so. I think mmap_lock -> dup_mmap_sem
> >is not possible.
> >
> Given perf_trace_destroy() in the report, it is a couple of steps in the
> subsequent call chain that it likely takes to reach uprobe_unregister().
>
> perf_trace_destroy()
>   perf_trace_event_unreg(p_event)
>     tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
>       trace_uprobe_register()

Well, this is not possible, perf_trace_destroy() is only used by perf_tracepoint
pmu. But you are right anyway, event.destroy == perf_uprobe_destroy can lead to
uprobe_unregister(). Thanks.

-------------------------------------------------------------------------------

So. perf_mmap_close() does put_event(event) with mm->mmap_lock held. This can
deadlock if event->destroy == perf_uprobe_destroy: perf_trace_event_close/unreg
takes dup_mmap_sem.


perf_mmap_close() was added by 9bb5d40cd93c9 ("perf: Fix mmap() accounting hole")
and this commit doesn't look right anyway, I'll write another email. However, it
seems that this particular problem was added later by 33ea4b24277b0 ("perf/core:
Implement the 'perf_uprobe' PMU").

Oleg.

