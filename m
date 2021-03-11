Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73493376AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhCKPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233985AbhCKPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615475751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePysAuoR5eyBTRsoJfPDxFlLe0KkuV0VsDp7AuSD5rQ=;
        b=Yggf9v73xm+yyXA9n1IaJznoTR51VqpWA3lXpO+ElpDFuK/r+wh1sNt5urzYZ79B4aj07V
        4d6icIaQqbuOq2+S66ExbQ9bXkK8IjciVC+EOrUgBFLk+pT1YI5m4kdyH27dUgEbM/qMxX
        wTwz57CUiOBBrYnHRujVivir0LoTqms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-BDRL-dPEOEeqA8yh9ity2A-1; Thu, 11 Mar 2021 10:15:47 -0500
X-MC-Unique: BDRL-dPEOEeqA8yh9ity2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5CD1802B7E;
        Thu, 11 Mar 2021 15:15:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.196.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 47333610A8;
        Thu, 11 Mar 2021 15:15:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Mar 2021 16:15:45 +0100 (CET)
Date:   Thu, 11 Mar 2021 16:15:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210311151542.GB15552@redhat.com>
References: <20210309203919.15920-1-jnewsome@torproject.org>
 <m1blbqmy2u.fsf@fess.ebiederm.org>
 <4d9006b4-b65a-6ce0-b367-971f29de1f21@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9006b4-b65a-6ce0-b367-971f29de1f21@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Jim Newsome wrote:
>
> On 3/10/21 16:40, Eric W. Biederman wrote:
>
> >> +static int do_wait_pid(struct wait_opts *wo)
> >> +{
> >> +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
> >                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This is subtle change in behavior.
> >
> > Today on the task->children list we only place thread group leaders.
>
> Shouldn't we allow waiting on clone children if __WALL or __WCLONE is set?

Don't confuse clone child with child's sub-thread.

Oleg.

