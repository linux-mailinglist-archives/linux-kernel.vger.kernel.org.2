Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21EA43693C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhJURoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhJURoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:44:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A009611F2;
        Thu, 21 Oct 2021 17:41:47 +0000 (UTC)
Date:   Thu, 21 Oct 2021 13:41:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Fix selftest config check for function graph
 start up test
Message-ID: <20211021134146.2c6f69fb@gandalf.local.home>
In-Reply-To: <YXGZogzuH5cv1UnF@krava>
References: <20211021123729.23be20c4@gandalf.local.home>
        <YXGZogzuH5cv1UnF@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 18:47:30 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> oops, I assumed id depended on CONFIG_DYNAMIC_FTRACE,
> but did not check..

And I need to make a v2....

My cross compile tests are now failing :-/

  /work/build/trace/nobackup/cross-linux.git/kernel/trace/trace_selftest.c:787:32: warning: 'trace_direct_tramp' defined but not used [-Wunused-function]


New patch on its way.

-- Steve
