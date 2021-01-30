Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A84309626
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhA3PKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 10:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhA3O7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:59:35 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6045364DF5;
        Sat, 30 Jan 2021 14:36:28 +0000 (UTC)
Date:   Sat, 30 Jan 2021 09:36:26 -0500
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
Message-ID: <20210130093626.0b7b3b1b@oasis.local.home>
In-Reply-To: <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
References: <20210127170721.58bce7cc@gandalf.local.home>
        <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021 23:30:18 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> I still need the following chunk (same "if (it_func_ptr)" as in the v2's 
> reply) in order to stop crashes:
> 
> 

And this is on powerpc, correct?

Do you still have the same crash with v3 (that's the one I'm going to
go with for now.)

 https://lore.kernel.org/r/20201118093405.7a6d2290@gandalf.local.home

Thanks,

-- Steve
