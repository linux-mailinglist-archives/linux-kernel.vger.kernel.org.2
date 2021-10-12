Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7763D42A906
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhJLQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhJLQFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:05:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEA560F23;
        Tue, 12 Oct 2021 16:03:11 +0000 (UTC)
Date:   Tue, 12 Oct 2021 12:03:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-ID: <20211012120310.2f742adb@gandalf.local.home>
In-Reply-To: <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 23:31:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, this seems something wrong. Via dynamic_events interface, all the
> events must be parsed equaly. If you have to pass the attached "system/event"
> that's something wrong. The dynamic_events interface will accept 
> 
> -:[GROUP/]EVENT [optional arguments]
> 
> Or
> 
> !e:[GROUP/]EVENT [optional arguments]
> 
> What did you expect other that these syntax?

But there are non "optional arguments".

To create the event probe, we need to send:

  e:[GROUP/]EVENT system/event [optional arguments]

Where the "system/event" is what we attach to. Similar to adding a function
or address to kprobes. Do you not need to add that for deleting a kprobe?

That is, if I create a kprobe with:

  p:myprobe schedule > dynamic_events

To remove it, don't we need to have:

  -:myprobe schedule >> dynamic_events

?

-- Steve
