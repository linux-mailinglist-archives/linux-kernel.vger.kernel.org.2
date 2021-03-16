Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0733DC46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhCPSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236066AbhCPSKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615918233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=va6P0xFjxjiydWkW6mpPyLH4JcckNuT7gN3PQvMk5W0=;
        b=h1Zp4o3JPNX0OThs/oTROaPFldkzs9zmCkIf0O6ulYScNZXb63JtZkTDpK2mbeARFpWPZM
        MfPa9Ez2U0XQg8VKtS28qOtpNCKuuhyu5gfu8X4XSV6h2G7BZpD+SAWGE2drZNMI+jwZDJ
        CebCmjFm94XxtH+aDGFic/hZYF/D/YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-2eo_5XkGNYCAzazGqgkDMQ-1; Tue, 16 Mar 2021 14:10:31 -0400
X-MC-Unique: 2eo_5XkGNYCAzazGqgkDMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C8D84E20A;
        Tue, 16 Mar 2021 18:10:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7A56A5C1A3;
        Tue, 16 Mar 2021 18:10:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 Mar 2021 19:10:29 +0100 (CET)
Date:   Tue, 16 Mar 2021 19:10:22 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
Message-ID: <20210316181022.GA25986@redhat.com>
References: <20210201174555.GA17819@redhat.com>
 <20210203231944.GA17467@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203231944.GA17467@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04, Oleg Nesterov wrote:
>
> It seems that nobody objects,
>
> Andrew, Andy, Thomas, how do you think this series should be routed?

ping...

What can I do to finally get this merged?

Should I resend once again? Whom?


> On 02/01, Oleg Nesterov wrote:
> >
> > Somehow I forgot about this problem. Let me resend the last version
> > based on discussion with Linus. IIRC he was agree with this series.
> >
> > And let me remind why 3/4 temporary adds the "transient" TS_COMPAT_RESTART
> > flag killed by the next patch: to simplify the backporting. 1-3 can fix
> > the problem without breaking the kABI.
> >
> > Oleg.
> > ---
> >  arch/x86/include/asm/processor.h   |  9 ---------
> >  arch/x86/include/asm/thread_info.h | 15 ++++++++++++++-
> >  arch/x86/kernel/signal.c           | 24 +-----------------------
> >  fs/select.c                        | 10 ++++------
> >  include/linux/restart_block.h      |  1 +
> >  include/linux/thread_info.h        | 13 +++++++++++++
> >  kernel/futex.c                     |  3 +--
> >  kernel/time/alarmtimer.c           |  2 +-
> >  kernel/time/hrtimer.c              |  2 +-
> >  kernel/time/posix-cpu-timers.c     |  2 +-
> >  10 files changed, 37 insertions(+), 44 deletions(-)

