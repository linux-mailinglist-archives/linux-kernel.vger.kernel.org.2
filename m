Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8C37AD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhEKRzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhEKRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620755636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMmnYi2R2rpijnadia4P/sKG3RmewE+fpb6vPJAQNH4=;
        b=ZiiAoLYF0/wwuWwZzzDeAk027Az9FnVUVoRP2WgEdjawXdF5rVJNXX1kiHlnMHq9GW/Rk+
        EWCpr3FhnLwf0fRBY5JI26yvdjwWH5V/HHdSAFyZq0s/ofxUP0BSC3sOZIqNF3wi9e32aP
        4fQKM+om6wfc0WzJZOMT2ZUf0yOebOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-0Ghno32cNDCf2rniGd5djw-1; Tue, 11 May 2021 13:53:55 -0400
X-MC-Unique: 0Ghno32cNDCf2rniGd5djw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55ED3106BB24;
        Tue, 11 May 2021 17:53:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8EAF2B431;
        Tue, 11 May 2021 17:53:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 May 2021 19:53:52 +0200 (CEST)
Date:   Tue, 11 May 2021 19:53:42 +0200
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
Message-ID: <20210511175341.GA14488@redhat.com>
References: <20210511165626.GA13720@redhat.com>
 <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Linus Torvalds wrote:
>
> On Tue, May 11, 2021 at 9:56 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > This patch makes ptrace() fail in this case until debugger does wait()
> > and consumes PTHREAD_EVENT_EXEC which reports old_pid.
>
> I'm ok with the patch, just wondering which way it's supposed to come
> to me. Should I just apply it directly?

would be nice!

> That said, why this:
>
> > +       rcu_read_lock();
> > +       pid = task_pid_nr_ns(task, task_active_pid_ns(task->parent));
> > +       rcu_read_unlock();
>
> I don't see why the RCU read lock would be needed? task_pid_nr_ns()
> does any required locking itself, afaik.
>
> And even if it wasn't, this all happens with siglock held, can
> anything actually change.

... and with tasklist_lock held.

Hmm. Linus, I am shy to admit I can't answer immediately, I'll recheck
tomorrow after sleep. But it seems you are right.

Thanks!

Oleg.

