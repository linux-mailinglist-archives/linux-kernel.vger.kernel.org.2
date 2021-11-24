Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934E345CC21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhKXSgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242504AbhKXSgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:36:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB7860FE8;
        Wed, 24 Nov 2021 18:33:08 +0000 (UTC)
Date:   Wed, 24 Nov 2021 13:33:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [GIT PULL] tracing/uprobe: Fix uprobe_perf_open probes
 iteration
Message-ID: <20211124133306.0ae5b752@gandalf.local.home>
In-Reply-To: <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
References: <20211124100956.6905a198@gandalf.local.home>
        <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 10:27:27 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Now, I may be entirely off my meds here, and maybe there is something
> I'm missing, but I _think_ the attached patch should work, and avoid
> all that indirection through 'pos' that you don't care about and that
> seems to just have been a mistake.
>

Masami and Jiri,

This is your code. Would this be a legitimate clean up?

-- Steve
