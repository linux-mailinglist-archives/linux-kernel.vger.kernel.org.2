Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBAC31E7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhBRJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhBRIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:10:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A28C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JQSdrZUamhWWmhOXjwsNODrAJM4mXE0YH7XG0t8R7oY=; b=nqtRoCKBj3TmRlUoyDfm6rCRir
        4U8/bZbUP4ajf3c+RXpFfDI8kkKqXhkmIz9G8Qpg+dtloTZAUDoZKJSc7wpgxxMHlLVD997LMIXkq
        sIHldRORw+YAleEW7sQdPVkqGwe85X2FR/sRretjFF21lJWdnvRm5dztYH7nMigM3pLiWTbA0o6Im
        +QqpWz8SMwWk6gNS+yNGpPJsdesBbMQV5dfM8rSmYOS5WVjODDsUhn0IOvddp8V1KU2Ax3xyVRL8P
        jGzxTeoAIOAD/nu7TmkU56ykeAxB+31BoHhb0phQmusjcb/sKwEfZlbWNVC8YCG9KcYlo2klN0Gpb
        +yxse6hA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCeNN-001PRj-QK; Thu, 18 Feb 2021 08:09:30 +0000
Date:   Thu, 18 Feb 2021 08:09:29 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <20210218080929.GA335524@infradead.org>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-2-namit@vmware.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
> +/*
> + * Flags to be used as scf_flags argument of smp_call_function_many_cond().
> + */
> +#define SCF_WAIT	(1U << 0)	/* Wait until function execution completed */
> +#define SCF_RUN_LOCAL	(1U << 1)	/* Run also locally if local cpu is set in cpumask */

Can you move the comments on top of the defines to avoid the crazy
long lines?

> +	if (cpu_online(this_cpu) && !oops_in_progress && !early_boot_irqs_disabled)

Another pointlessly overly long line, with various more following.

>  EXPORT_SYMBOL(on_each_cpu_cond_mask);

This isn't used by any modular code, so maybe throw in a patch to drop
the export?
