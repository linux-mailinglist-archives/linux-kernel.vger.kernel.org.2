Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DA44B2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbhKITDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbhKITDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:03:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CAC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/bL3lEQeIXXgPfYvJavQSRTtLUG54fTvn98bwFpiOQU=; b=dyOXL4oXlW7Pu17rgPu5KCFTNI
        +Ji+D/wZTs3iZFvOT8sJH+L8iLBXh2CB/IepPSstux8Hh8UNXp/YUZwqljdoawu6CwyPKOori7mmn
        /+4OxWtyEbYKxSfIo053BFcS8d5FjnII0BOZyj47a8KpGYsauNDwnH3Y5zJAgmJanarOyVGqSfxFL
        2Zg9DXDUOVBuPxq0YUVsmlIrjWwVYeexmT2Iq/WmLkMEwql+EHTd99f7x6Uqlr9MPrhSb78jKkDoW
        sYDCYKs2DMOTYlE9q6+xJTJpg8Y0oXXPVcVYHdhwkRdmrGegvuofSl0wT8FOC/letGH1/L8JjOPDq
        pJFst40Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWLp-00F79T-N0; Tue, 09 Nov 2021 19:00:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EA6A3000DD;
        Tue,  9 Nov 2021 20:00:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B74A212EE599; Tue,  9 Nov 2021 20:00:09 +0100 (CET)
Date:   Tue, 9 Nov 2021 20:00:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 6/7] static_call: rename EXPORT_ macros to be more
 self-explanatory
Message-ID: <YYrFOZT+6bNTfP+t@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109164549.1724710-7-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:45:48PM +0100, Ard Biesheuvel wrote:
> So let's rename these macros to
> 
>   EXPORT_STATIC_CALL        -> EXPORT_STATIC_CALL_FOR_UPDATE
>   EXPORT_STATIC_CALL_TRAMP  -> EXPORT_STATIC_CALL
> 

Ok, let's pain this shed a bit.

How about:

	EXPORT_STATIC_CALL_RW
	EXPORT_STATIC_CALL_RO

respectively. OR.. alternatively, have both:

	EXPORT_STATIC_CALL_KEY
	EXPORT_STATIC_CALL_TRAMP

and those that want to export both get to use both.
