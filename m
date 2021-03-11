Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12B5337687
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhCKPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233653AbhCKPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615475321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IFWYhD9CU20v8ei34Kb0a/fhBTuOkSBPR6E61Sn0QqY=;
        b=Z1IkIk8vcCF6fsyFmQ3/28livMbN0+FgcV2XZzlo8u767JtGy2FJvfQ8+L84fEjQTwFICq
        gowyk3cDvPpNaJJEvVmgbquCkMaw/CI/5neR1hkTccndvxRuA4ohXQ7LsHmqxfWPwb68jw
        RFO5Ao1/5I75H1+UKY0T513gvQO4b8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-HoocUpZ1OeOl3es7JcJG3w-1; Thu, 11 Mar 2021 10:08:39 -0500
X-MC-Unique: HoocUpZ1OeOl3es7JcJG3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4394A19057C8;
        Thu, 11 Mar 2021 15:08:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.196.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6BA5A60C9B;
        Thu, 11 Mar 2021 15:08:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Mar 2021 16:08:23 +0100 (CET)
Date:   Thu, 11 Mar 2021 16:08:21 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jim Newsome <jnewsome@torproject.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210311150820.GA15552@redhat.com>
References: <20210309203919.15920-1-jnewsome@torproject.org>
 <m1blbqmy2u.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1blbqmy2u.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Eric W. Biederman wrote:
>
> Jim Newsome <jnewsome@torproject.org> writes:
>
> > +static int do_wait_pid(struct wait_opts *wo)
> > +{
> > +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is subtle change in behavior.
>
> Today on the task->children list we only place thread group leaders.

Aaah, yes, thanks Eric!

> So the code either needs a thread_group_leader filter on target before
> the ptrace=0 case or we need to use "pid_task(wo->wo_pid, PIDTYPE_TGID)"
> and "pid_task(wo->wo_pid, PIDTYPE_PID)" for the "ptrace=1" case.

Agreed,

> I would like to make thread_group_leaders go away

Hmm, why?

Oleg.

