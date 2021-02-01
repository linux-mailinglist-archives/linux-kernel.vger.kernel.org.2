Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1925E30AE59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhBARsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231263AbhBARrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612201571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VfUBcVN+F0E8rTua72rmnICLf8P5E2zL5CUVGrND8uw=;
        b=M70+qB9HPdv9fE0JLTKe0bPvvKyyvmrfCYHKqF9hEQajN6hvY/XFzUJKcgM7sJZAtc2tqi
        Nm8XWKmdgp4DtkY5X/C3LPXuApj6RGITGiW79VFzsmv6U4M3YafqJxcCyNWTmeknJlaxqZ
        Oon1fes/O0HSI2W1GzTGP1IZ2XIx9Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-ooFoLXvXPHGibIddd5SOug-1; Mon, 01 Feb 2021 12:46:07 -0500
X-MC-Unique: ooFoLXvXPHGibIddd5SOug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6CF3801817;
        Mon,  1 Feb 2021 17:46:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 460171975E;
        Mon,  1 Feb 2021 17:45:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  1 Feb 2021 18:46:05 +0100 (CET)
Date:   Mon, 1 Feb 2021 18:45:55 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
Message-ID: <20210201174555.GA17819@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow I forgot about this problem. Let me resend the last version
based on discussion with Linus. IIRC he was agree with this series.

And let me remind why 3/4 temporary adds the "transient" TS_COMPAT_RESTART
flag killed by the next patch: to simplify the backporting. 1-3 can fix
the problem without breaking the kABI.

Oleg.
---
 arch/x86/include/asm/processor.h   |  9 ---------
 arch/x86/include/asm/thread_info.h | 15 ++++++++++++++-
 arch/x86/kernel/signal.c           | 24 +-----------------------
 fs/select.c                        | 10 ++++------
 include/linux/restart_block.h      |  1 +
 include/linux/thread_info.h        | 13 +++++++++++++
 kernel/futex.c                     |  3 +--
 kernel/time/alarmtimer.c           |  2 +-
 kernel/time/hrtimer.c              |  2 +-
 kernel/time/posix-cpu-timers.c     |  2 +-
 10 files changed, 37 insertions(+), 44 deletions(-)

