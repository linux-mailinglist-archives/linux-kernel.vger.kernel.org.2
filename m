Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97D23D3142
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhGWAp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhGWAp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:45:28 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 705A860EBA;
        Fri, 23 Jul 2021 01:26:02 +0000 (UTC)
Date:   Thu, 22 Jul 2021 21:26:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-ID: <20210722212600.5447342d@rorschach.local.home>
In-Reply-To: <20210723102211.a9e0a5cfeb912384a0774145@kernel.org>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
        <20210723102211.a9e0a5cfeb912384a0774145@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 10:22:11 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> But anyway, maybe I need this weekend to make a time.
> So, as far as it works OK, I'm OK for this patch.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks! I'll probably wont apply it till next week anyway because I'm
currently debugging other issues :-p

> 
> BTW, please update the ftracetest testcases for hist triggers.

Will do!

Thanks for the review.

-- Steve
