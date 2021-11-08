Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506F7449B87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhKHST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235228AbhKHST1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:19:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8E561359;
        Mon,  8 Nov 2021 18:16:42 +0000 (UTC)
Date:   Mon, 8 Nov 2021 13:16:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211108131639.33a4f186@gandalf.local.home>
In-Reply-To: <20211108171336.GA1690@kbox>
References: <20211104170433.2206-1-beaub@linux.microsoft.com>
        <20211104170433.2206-3-beaub@linux.microsoft.com>
        <20211107233115.1f77e93c4bdf3ff649be99c1@kernel.org>
        <20211108171336.GA1690@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 09:13:36 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:


> Does that mean the decoders in eprobes/histogram don't check event
> record sizes before accessing the data? Shouldn't that get fix
> centrally? That would mean a loaded module could do the same thing
> (user_events only works if the user has access to tracefs, so it's not
> like it's open to all users).

There's checks to make sure everything fits in eprobes and kprobes. If it
doesn't then the event is simply dropped.

For example, if you look at __eprobe_trace_func() in trace_eprobe.c, you'll
see that it calls get_eprobe_size(), which goes through and just reads what
it is about to accept. Then it reserves the amount of data on the ring
buffer, and then calls store_trace_args() which also passes in the size
that it found, in case things change. If it's too big, it only records what
it originally intended.

-- Steve
