Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C70C3B2FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFXNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhFXNHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:07:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321BA613F3;
        Thu, 24 Jun 2021 13:05:02 +0000 (UTC)
Date:   Thu, 24 Jun 2021 09:05:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, dvyukov@google.com, elver@google.com
Subject: Re: [PATCH v2 00/24] objtool/x86: noinstr vs PARAVIRT
Message-ID: <20210624090500.3214d7d2@oasis.local.home>
In-Reply-To: <20210624094059.886075998@infradead.org>
References: <20210624094059.886075998@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 11:40:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Steve, can I please delete TRACE_BRANCH_PROFILING and PROFILE_ALL_BRANCHES already?

The TRACE_BRANCH_PROFILING, I never used, so I'm happy to delete it,
but I still use the PROFILE_ALL_BRANCHES.

But I'm curious, what's the issue with the PROFILE_ALL_BRANCHES?

You can make it ignore files, by simply adding a:

#define DISABLE_BRANCH_PROFILING

at the top of the file (before any of the includes).

So if your issue is that it makes it hard for some code, simply add
that to the top of the file, and it should just work.

-- Steve
