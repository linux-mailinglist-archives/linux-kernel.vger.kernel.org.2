Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77D84601BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 22:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356386AbhK0VtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 16:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356270AbhK0VrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:47:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A8C061748
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 13:43:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F03160ECA
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 21:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC808C53FAD;
        Sat, 27 Nov 2021 21:43:54 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:43:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [GIT PULL] tracing: Two event pid filtering bug fixes
Message-ID: <20211127164353.7f231758@oasis.local.home>
In-Reply-To: <20211127164120.1eb79c1a@oasis.local.home>
References: <20211127132822.5d4d2a8b@gandalf.local.home>
        <20211127164120.1eb79c1a@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 16:41:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> And of course since I only tested "trace only this pid" case, and not
> the "trace everything but this pid" case, the above has a bug (which
> the ktest bot just told me about), and my tests missed it.

I'm giving a talk on Friday at Embedded Fest about all these features,
and I would like my examples to work on mainline Linux. ;-)

I found that my talks usually give some "crazy use cases" which tend to
find bugs in the code :-p

-- Steve
