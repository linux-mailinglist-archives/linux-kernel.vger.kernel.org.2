Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43632CE2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhCDIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:12:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48048 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhCDIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:12:24 -0500
Date:   Thu, 4 Mar 2021 09:11:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614845503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jYmL6tKocsjyC4rjSC5WGE7I4DkGZTDpPk++ojLJow=;
        b=BFqd4k6qPfJviPCIOyx5g5/bi0ThwBTAE7Vj+umAG5oyk2OPEAaTeIJKVCvqzuXDPaBIEf
        8AVXR0QnTWpqicL1msn/eVZtF6c/XPlqtar/3uYTZNsccDdX/XsuybeWNiznCuJB2STEp8
        q0fu7QXfXizzWzW8P8pL1jlQme/jasg53EA+J+XcVJSKksnKsgCLarq3v0BXtOMqfIYetN
        8PZV8SY25+RAz2A73CPjF4UwhlUvH6Zr7P69epsYSaUPnX7Fu3LAXyxD+/ZlKyAaK5hl+6
        OKCPodua3nurJ4YKFjeOaXehosTs9Rh07/XiqK7LKdgwRzWaqnkQVGyOtqg/vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614845503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jYmL6tKocsjyC4rjSC5WGE7I4DkGZTDpPk++ojLJow=;
        b=KZB8s/JE8YNBlZ1iI5fHD4OXodiqjMb57mIEobXKNzYA0IzkZu0gwDsDcBLWhja2iPDYpF
        ov0sFvREKqg9SJCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
Message-ID: <20210304081142.digtkddajkadwwq5@linutronix.de>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
 <m1zgzj7uv2.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <m1zgzj7uv2.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-03 16:09:05 [-0600], Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>=20
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > Allow realtime tasks to cache one sigqueue in task struct. This avoids =
an
> > allocation which can increase the latency or fail.
> > Ideally the sigqueue is cached after first successful delivery and will=
 be
> > available for next signal delivery. This works under the assumption tha=
t the RT
> > task has never an unprocessed signal while a one is about to be queued.
> >
> > The caching is not used for SIGQUEUE_PREALLOC because this kind of sigq=
ueue is
> > handled differently (and not used for regular signal delivery).
>=20
> What part of this is about real time tasks?  This allows any task
> to cache a sigqueue entry.

It is limited to realtime tasks (SCHED_FIFO/RR/DL):

+static void __sigqueue_cache_or_free(struct sigqueue *q)
+{
=E2=80=A6
+	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
+		kmem_cache_free(sigqueue_cachep, q);
+}

> Either the patch is buggy or the description is.  Overall caching one
> sigqueue entry doesn't look insane. But it would help to have a clear
> description of what is going on.

Does this clear things up or is my logic somehow broken here?

> Eric

Sebastian
