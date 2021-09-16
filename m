Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABB040D0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhIPASd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhIPASc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:18:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D365610A2;
        Thu, 16 Sep 2021 00:17:11 +0000 (UTC)
Date:   Wed, 15 Sep 2021 20:17:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 3/3] bootconfig: Free xbc_data in xbc_destroy_all()
Message-ID: <20210915201709.1406426a@oasis.local.home>
In-Reply-To: <20210916090503.c9d8209e8c88e9c4c7d3072c@kernel.org>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
        <163171199244.590070.6356174550728998874.stgit@devnote2>
        <20210915102354.2841798d@oasis.local.home>
        <20210916090503.c9d8209e8c88e9c4c7d3072c@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 09:05:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Ah, it is my policy that the error or information message is shown
> by caller (since caller can also ignore that, e.g. passing the
> testing data), not from the library code.
> I learned that from perf-probe and ftrace, sometimes the library
> code reused in unexpected way. So I decided to decouple the
> generating error message and showing it.

OK, then we can just pass the number of nodes allocated via a pointer
to an integer.

Thanks!

-- Steve
