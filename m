Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF230C4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhBBP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235956AbhBBP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612281373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMVq+R+i9hW5bLC6dIIBNMl7jqxvev5dpa5RYgbRR+w=;
        b=O29VON3JRqfybfKt0ED82zWvmflV0YczKEHZZjz4HMpFyWi8nYl1oPU/wirx526b1dusZN
        sYgcLF/LiUPnhlUxazPArMddjMMREnwoeq68RUz5Dw9vVuOMMovk7HsR22Kb1x25vI6u2D
        dEePIyPWo7NtzN9BZzOl5pE5T6+JGcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-4FoYhtNvOM6H-80hKkWf4w-1; Tue, 02 Feb 2021 10:56:09 -0500
X-MC-Unique: 4FoYhtNvOM6H-80hKkWf4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28A85192D793;
        Tue,  2 Feb 2021 15:56:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id CBD695FC19;
        Tue,  2 Feb 2021 15:55:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  2 Feb 2021 16:56:07 +0100 (CET)
Date:   Tue, 2 Feb 2021 16:55:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
Message-ID: <20210202155548.GB20059@redhat.com>
References: <20210201174555.GA17819@redhat.com>
 <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
 <CAHk-=wjJerA3xGtK8HdEcdAnmaaTz-iVvc_xqokzNTBivKomVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJerA3xGtK8HdEcdAnmaaTz-iVvc_xqokzNTBivKomVQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Linus Torvalds wrote:
>
> On Mon, Feb 1, 2021 at 10:18 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Yeah, looks sane to me.
>
> Oh, and in a perfect world we'd have a test for this condition too, no?

There is the "erestartsys-trap-debugger" test in ptrace-tests suite.
Do you mean you want another test in tools/testing/selftests/ptrace ?

Oleg.

