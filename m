Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844A537ADCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhEKSH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231462AbhEKSH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620756410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USTqRYanuUHDJqRaoZLu8zaZBUsx9OAiBJ2fe+smg+A=;
        b=Hppjy0JoddzxKgd6DiG6e4sHzUpYDmK/jUlS4qyHzAQNgPGuCkjQDSLFBrWCkBm/sSIs5t
        3SV0aZV9NKhXMhKqeYowgQ2u+3MeG/gjbLWheyYWv/GrOQlEhT7AojjZ1apM4xsqlffX+v
        fZ9W25/YS9qgOe+RTJibDUMMvb+oHwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-3Xs3_rFcNle9Hw53x2hC4Q-1; Tue, 11 May 2021 14:06:46 -0400
X-MC-Unique: 3Xs3_rFcNle9Hw53x2hC4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 738D0106BB29;
        Tue, 11 May 2021 18:06:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id BDF3A9CA0;
        Tue, 11 May 2021 18:06:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 May 2021 20:06:38 +0200 (CEST)
Date:   Tue, 11 May 2021 20:06:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND2] ptrace: make ptrace() fail if the tracee changed
 its pid unexpectedly
Message-ID: <20210511180627.GB14488@redhat.com>
References: <20210511165626.GA13720@redhat.com>
 <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com>
 <20210511175341.GA14488@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511175341.GA14488@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Oleg Nesterov wrote:
>
> On 05/11, Linus Torvalds wrote:
>
> > That said, why this:
> >
> > > +       rcu_read_lock();
> > > +       pid = task_pid_nr_ns(task, task_active_pid_ns(task->parent));
> > > +       rcu_read_unlock();
> >
> > I don't see why the RCU read lock would be needed? task_pid_nr_ns()
> > does any required locking itself, afaik.
> >
> > And even if it wasn't, this all happens with siglock held, can
> > anything actually change.
>
> ... and with tasklist_lock held.
>
> Hmm. Linus, I am shy to admit I can't answer immediately, I'll recheck
> tomorrow after sleep. But it seems you are right.

most probably to protect task->parent, not sure, this was 6 month ago...
but in this case we can use "current". I'll recheck.

> Thanks!

Oleg.

