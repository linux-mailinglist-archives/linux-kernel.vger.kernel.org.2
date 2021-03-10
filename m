Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA13339DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCJKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhCJKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:22:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE277C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c1dSdngbby5wMSRQlaNZcuWULVXSILfowsqxzDo6joU=; b=TNVFzqOQlsR2qBo7UCt3+wWpmm
        vTX278P9elr9j8335LznMpmwRdrwT8CjFl/ynuwTUTevpQWpRtD9zSKdEcovXMWbFa5lsQG76B/c2
        kh4i11L92CBXpacl5tKDcLg0vMW2B9eI3OR0r6slEo328ttmzhW6wWKY+dLfGbU5+TeaJsrh9he5Q
        oqxVveOMZR08I8Z1LOdSMpgxzyNkHTrKXP7pbjOXhN6v8aymh47y9mGelXpYWYhjijzL4suQJ9nzY
        Z6dGmDLS5Lk3/uFYq4K3B6BSN74nslYG4ATBCepY3rK6TiW+DSrniQlyn1kQlm8yPWWKhO0Ce78ZT
        r2f/ITnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJvzN-003A8s-Gd; Wed, 10 Mar 2021 10:22:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC037300455;
        Wed, 10 Mar 2021 11:22:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A28F234E3604; Wed, 10 Mar 2021 11:22:48 +0100 (CET)
Date:   Wed, 10 Mar 2021 11:22:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
 <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
 <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
 <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:03:10AM +0100, Peter Zijlstra wrote:
> -void __init arch_init_ideal_nops(void)
> -{
> -	switch (boot_cpu_data.x86_vendor) {
> -	case X86_VENDOR_INTEL:
> -		/*
> -		 * Due to a decoder implementation quirk, some
> -		 * specific Intel CPUs actually perform better with
> -		 * the "k8_nops" than with the SDM-recommended NOPs.
> -		 */
> -		if (boot_cpu_data.x86 == 6 &&
> -		    boot_cpu_data.x86_model >= 0x0f &&
> -		    boot_cpu_data.x86_model != 0x1c &&
> -		    boot_cpu_data.x86_model != 0x26 &&
> -		    boot_cpu_data.x86_model != 0x27 &&
> -		    boot_cpu_data.x86_model < 0x30) {
> -			ideal_nops = k8_nops;
> -		} else if (boot_cpu_has(X86_FEATURE_NOPL)) {
> -			   ideal_nops = p6_nops;
> -		} else {
> -#ifdef CONFIG_X86_64
> -			ideal_nops = k8_nops;
> -#else
> -			ideal_nops = intel_nops;
> -#endif
> -		}
> -		break;
> -
> -	case X86_VENDOR_HYGON:
> -		ideal_nops = p6_nops;
> -		return;
> -
> -	case X86_VENDOR_AMD:
> -		if (boot_cpu_data.x86 > 0xf) {
> -			ideal_nops = p6_nops;
> -			return;
> -		}
> -
> -		fallthrough;
> -
> -	default:
> -#ifdef CONFIG_X86_64
> -		ideal_nops = k8_nops;
> -#else
> -		if (boot_cpu_has(X86_FEATURE_K8))
> -			ideal_nops = k8_nops;
> -		else if (boot_cpu_has(X86_FEATURE_K7))
> -			ideal_nops = k7_nops;
> -		else
> -			ideal_nops = intel_nops;
> -#endif
> -	}
> -}

After this FEATURE_NOPL is unused except for required-features for
x86_64. FEATURE_K8 is only used for PTI and FEATURE_K7 is unused.

AFAICT this negatively affects lots of 32bit (DONTCARE) and 32bit on
64bit CPUs (CARELESS) and early AMD (K8) which is from 2003 and almost
2 decades old by now (SHRUG).

Everything x86_64 since AMD K10 (2007) was using p6_nops.

And per FEATURE_NOPL being required for x86_64, all those CPUs can use
p6_nops. So stop caring about NOPs, simplify things and get on with life
:-)
