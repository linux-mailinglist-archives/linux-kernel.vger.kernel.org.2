Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30A131CA61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBPMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhBPMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:07:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X/WM4gpCq38+r8+TMCsO1Va79XdhVsx1pfVAxEAW+9k=; b=S/pMKd6tMDEHWfDraK0mMktDS6
        +si9CmOwqFtm9rmEN0j9fWKYRH9/J95oi9mgcjOBvLp3ef9ewuOxvtkYRUQB06tVvPCFKivIEJbJp
        DYhslj2LIw+tErsYuuljO+0T3dxlJkk7FbZ50ojQfNcaPtq6/RWoFoZFZ6WzoshKybdOJf82of6ZU
        aE1jTj11TmoRcQS7aAaCY7+WOnrucThyM1uQTRLvB58h4YsevNrMMZndcJsk4RuXyUxjsVTAUJTKa
        pI3ZfoxRf5VGuuCFw85R2aEeuai9Yt7G+QiLYnbHz2RqPuDr2bnZq83ZgJJsArLvq5Y5bJict+pj6
        UxdLM4GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBz7J-00GpjJ-59; Tue, 16 Feb 2021 12:06:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8244A3011E6;
        Tue, 16 Feb 2021 13:06:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67EBB203EBF0C; Tue, 16 Feb 2021 13:06:08 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:06:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <YCu1MJxphH1CVlZy@hirez.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
>  void smp_call_function_many(const struct cpumask *mask,
>  			    smp_call_func_t func, void *info, bool wait)
>  {
> +	smp_call_function_many_cond(mask, func, info, wait ? SCF_WAIT : 0, NULL);

	wait*SCF_WAIT

is shorter and sometimes generates better code

>  }
>  EXPORT_SYMBOL(smp_call_function_many);
