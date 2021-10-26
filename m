Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0455F43BC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbhJZV3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239576AbhJZV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:29:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1545160F9B;
        Tue, 26 Oct 2021 21:26:39 +0000 (UTC)
Date:   Tue, 26 Oct 2021 17:26:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <20211026172637.65f576c3@gandalf.local.home>
In-Reply-To: <YXhx1N1/xe/v3wrI@hirez.programming.kicks-ass.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
        <20210907212426.73ed81d1@rorschach.local.home>
        <20211007071151.GL174703@worktop.programming.kicks-ass.net>
        <20211007092358.65152792@gandalf.local.home>
        <20211026164343.2e1754bd@gandalf.local.home>
        <YXhx1N1/xe/v3wrI@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 23:23:32 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Do you have any real issue if I just take this patch set through my tree?  
> 
> No real objections; just weary, huge events like that are fairly sucky
> for performance.

OK. Then I'll just take this in, and let people have sucky performance if
they want huge events ;-)

-- Steve
