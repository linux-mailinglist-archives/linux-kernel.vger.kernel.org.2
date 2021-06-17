Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468E93AAF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFQIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFQIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:48:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF38C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZl/Wka2k1ddujQH+TFRsFdpimwLd/Gy1bZGIFO9vgw=; b=M9U1xfKesPpxfW7j41eixKbnwb
        8p2j+GwHJo3jshsKXSpsdAqo1ZaoAugZIna6cjJbMxg8GuscfOm/7P/n4rWxbOaOOQszQU0BVUIZV
        4T6SVHvtd2YUwE401qrIFwm8FW6XBzoBVkHtZcMbp1ux1zH6KA/KrZHHJgHHQ0tBFtg2heCDgbNUM
        R0G/vhzqvSB1mbqa3i2aC96vnMf89kiXNFvVxHggge7YXuX/+B3PbS1lWCVURwBODi3NKTBhhNnml
        dhrtHa9TJX4nX16RQLszcwbAWH0Cg0caPpiL+kWQOYfSqZTlaEX7DHNm4yLcHFVZmuAHAJiFVIil+
        id8SQR3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltnei-008vvm-Hu; Thu, 17 Jun 2021 08:45:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0013300252;
        Thu, 17 Jun 2021 10:45:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76ACA2BF4234B; Thu, 17 Jun 2021 10:45:42 +0200 (CEST)
Date:   Thu, 17 Jun 2021 10:45:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Message-ID: <YMsLtseEHC8dWwag@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:41:19AM -0700, Andy Lutomirski wrote:
> mmgrab() and mmdrop() would be better if they were not full barriers.  As a
> trivial optimization,

> mmgrab() could use a relaxed atomic and mmdrop()
> could use a release on architectures that have these operations.

mmgrab() *is* relaxed, mmdrop() is a full barrier but could trivially be
made weaker once membarrier stops caring about it.

static inline void mmdrop(struct mm_struct *mm)
{
	unsigned int val = atomic_dec_return_release(&mm->mm_count);
	if (unlikely(!val)) {
		/* Provide REL+ACQ ordering for free() */
		smp_acquire__after_ctrl_dep();
		__mmdrop(mm);
	}
}

It's slightly less optimal for not being able to use the flags from the
decrement. Or convert the whole thing to refcount_t (if appropriate)
which already does something like the above.

