Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7662930E72F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhBCXVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:21:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233195AbhBCXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612394395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uu0Ziq0pBjAAZtjbVAqvEmIBT/+LT7ks6xYBOetg6qA=;
        b=L+Flx32aKS3Yqgyq71yg0AK6fqarB+npGYI4BQ9juw97EyPrenLpq9GkTpYWCvWBIorbBJ
        5s7Jrc6qasIWDdMu04q3pCGctZyxxqXU6wePIJNoVzWIwxmMX6S9IuyJNM6UT6WedQBTpJ
        2vwOm18YjMXu95TZVsMau9gw14965OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-l_bpQiEsOoObVTA5gGAqVg-1; Wed, 03 Feb 2021 18:19:53 -0500
X-MC-Unique: l_bpQiEsOoObVTA5gGAqVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93B9D107ACE6;
        Wed,  3 Feb 2021 23:19:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id EC8E219C66;
        Wed,  3 Feb 2021 23:19:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  4 Feb 2021 00:19:51 +0100 (CET)
Date:   Thu, 4 Feb 2021 00:19:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
Message-ID: <20210203231944.GA17467@redhat.com>
References: <20210201174555.GA17819@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201174555.GA17819@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that nobody objects,

Andrew, Andy, Thomas, how do you think this series should be routed?

On 02/01, Oleg Nesterov wrote:
>
> Somehow I forgot about this problem. Let me resend the last version
> based on discussion with Linus. IIRC he was agree with this series.
>
> And let me remind why 3/4 temporary adds the "transient" TS_COMPAT_RESTART
> flag killed by the next patch: to simplify the backporting. 1-3 can fix
> the problem without breaking the kABI.
>
> Oleg.
> ---
>  arch/x86/include/asm/processor.h   |  9 ---------
>  arch/x86/include/asm/thread_info.h | 15 ++++++++++++++-
>  arch/x86/kernel/signal.c           | 24 +-----------------------
>  fs/select.c                        | 10 ++++------
>  include/linux/restart_block.h      |  1 +
>  include/linux/thread_info.h        | 13 +++++++++++++
>  kernel/futex.c                     |  3 +--
>  kernel/time/alarmtimer.c           |  2 +-
>  kernel/time/hrtimer.c              |  2 +-
>  kernel/time/posix-cpu-timers.c     |  2 +-
>  10 files changed, 37 insertions(+), 44 deletions(-)

