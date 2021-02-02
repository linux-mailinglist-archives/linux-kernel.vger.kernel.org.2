Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5830CB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhBBT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233025AbhBBTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612293831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdRo3+F70po29fse+ZS87tnszTwmf70tXILypMqRVvI=;
        b=hB8HcjjpHKU66Ab4ruF69VuJvTodB75imtgkvj9gX1rFpycjoUG3n0qbGOliR3JjQVBTIU
        EOdyMqcO8DEhIMwWO9NC4Sof6TF4reGmId2M0cq1+Zhe6RxeS6h+yFXljrZSm/6+2TNeUr
        Iw/ldQ5y+nw4h3STXoMs1tNQgdln+0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-mEJcPiv4MzCV85IS6QOqFA-1; Tue, 02 Feb 2021 14:23:48 -0500
X-MC-Unique: mEJcPiv4MzCV85IS6QOqFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9735583758;
        Tue,  2 Feb 2021 19:23:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id A113E60C5F;
        Tue,  2 Feb 2021 19:23:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  2 Feb 2021 20:23:38 +0100 (CET)
Date:   Tue, 2 Feb 2021 20:23:34 +0100
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
Message-ID: <20210202192333.GC20059@redhat.com>
References: <20210201174555.GA17819@redhat.com>
 <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
 <CAHk-=wjJerA3xGtK8HdEcdAnmaaTz-iVvc_xqokzNTBivKomVQ@mail.gmail.com>
 <20210202155548.GB20059@redhat.com>
 <CAHk-=wit0wigE-D=r08=HyB4qSK-=+So8y9boeoc_o6Yavb_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wit0wigE-D=r08=HyB4qSK-=+So8y9boeoc_o6Yavb_qg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02, Linus Torvalds wrote:
>
> On Tue, Feb 2, 2021 at 7:56 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > There is the "erestartsys-trap-debugger" test in ptrace-tests suite.
> > Do you mean you want another test in tools/testing/selftests/ptrace ?
>
> No, I guess it's fine if it's caught by the ptrace test suite - we'll
> hopefully get fairly timely "guys, you broke it" reports.
>
> Is that ptrace erestartsys-trap-debugger.c test new, or has it just
> always failed? Or is the problem that it is so expected to fail that
> we wouldn't get reports of it anyway (this clearly fell off your radar
> for a long time)?

No, this test-case is very old. It used to work when this
get_nr_restart_syscall() logic was based on the test_thread_flag(TIF_IA32)
check.

Then it started to fail somewhere 2-3 years ago, and to be honest I didn't
even try to find which exactly patch broke this test. Because this logic
was always wrong anyway, even if this test-case used to work.

I sent v1 soon after this bug was reported, but every time I was too lazy,
that is why this (minor) problem is still not fixed. So, in short, this is
my fault in any case.

Oleg.

