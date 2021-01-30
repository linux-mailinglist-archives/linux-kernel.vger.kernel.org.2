Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636A3096B3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhA3QYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhA3Om4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:42:56 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B605264E10;
        Sat, 30 Jan 2021 14:42:12 +0000 (UTC)
Date:   Sat, 30 Jan 2021 09:42:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5] tracepoint: Do not fail unregistering a probe due to
 memory failure
Message-ID: <20210130094211.719f03a6@oasis.local.home>
In-Reply-To: <20210130093626.0b7b3b1b@oasis.local.home>
References: <20210127170721.58bce7cc@gandalf.local.home>
        <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
        <20210130093626.0b7b3b1b@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021 09:36:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Do you still have the same crash with v3 (that's the one I'm going to
> go with for now.)
> 
>  https://lore.kernel.org/r/20201118093405.7a6d2290@gandalf.local.home

Just curious, does the following patch fix it for v5?

-- Steve

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 7261fa0f5e3c..cf3a6d104fdb 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -306,6 +306,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 			tp->unregfunc();
 
 		static_key_disable(&tp->key);
+		tracepoint_synchronize_unregister();
 		rcu_assign_pointer(tp->funcs, tp_funcs);
 	} else {
 		rcu_assign_pointer(tp->funcs, tp_funcs);
