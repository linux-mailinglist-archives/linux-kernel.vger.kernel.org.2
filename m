Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398DC427381
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbhJHWPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243594AbhJHWPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4532360FDC;
        Fri,  8 Oct 2021 22:13:50 +0000 (UTC)
Date:   Fri, 8 Oct 2021 18:13:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <20211008181348.4c2488b7@gandalf.local.home>
In-Reply-To: <robbat2-20211007T172058-955036195Z@orbis-terrarum.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
        <20210907212426.73ed81d1@rorschach.local.home>
        <20211007071151.GL174703@worktop.programming.kicks-ass.net>
        <20211007092358.65152792@gandalf.local.home>
        <robbat2-20211007T172058-955036195Z@orbis-terrarum.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 17:26:04 +0000
"Robin H. Johnson" <robbat2@gentoo.org> wrote:

> I was trying to think further what would make sense for the constant.
> - What are the negative impacts of a too-large value?
> - Is there demand for more reconfigurability? 
> - Should PERF_MAX_TRACE_SIZE be a knob in Kconfig?

One thing you haven't discussed was, have you hit this warning, and if so,
what were you doing?

-- Steve
