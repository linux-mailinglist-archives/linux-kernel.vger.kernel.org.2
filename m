Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB036B442
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDZNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhDZNtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:49:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F8D61359;
        Mon, 26 Apr 2021 13:49:00 +0000 (UTC)
Date:   Mon, 26 Apr 2021 09:48:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <loda.chou@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] sched: remove the redundant 'success' in the sched
 tracepoint
Message-ID: <20210426094859.03980728@gandalf.local.home>
In-Reply-To: <ff7cb99e1a4c36582f5ab081f0aa6ed633db4305.camel@mediatek.com>
References: <20210422122226.9415-1-ed.tsai@mediatek.com>
        <20210422114629.2b1ea3ad@gandalf.local.home>
        <0fd8e103cc2886724979f7d93066b86b773032eb.camel@mediatek.com>
        <20210425175426.23f292a9@oasis.local.home>
        <ff7cb99e1a4c36582f5ab081f0aa6ed633db4305.camel@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 14:18:31 +0800
Ed Tsai <ed.tsai@mediatek.com> wrote:

> Thx Steve, this change work fine to me on the trace-cmd and systrace.
> It's a simple patch to clean code. Revert it if break user experience.

I'll take it for the next merge window. I don't want to introduce a
possible regression during the current merge window.

-- Steve
