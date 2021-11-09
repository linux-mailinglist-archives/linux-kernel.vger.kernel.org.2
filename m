Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655744B2F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbhKIS7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhKIS7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:59:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741FC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u3FQPPMTwKhIwI4dCTCxShL7v0DIZcxjmFUSnXqOhSM=; b=an2LWyWTsLNHAU3v9uYogWfVbN
        E1OYqIrizTLqSaoInwXrDRQPKlaAX+hHZy7sXTM/VuqLvoQ7K7CcNRHeWSMOl1jUZGOsW9vUAJM2s
        LwkYyZ+bv9Sd7iGdAJONNFIInG7deBx2BTFNUJ5PTrpTYN4M6ue5Vvcfi/TXkcGI+cra01DHk6JWe
        VuJMrKRpv03P/sMx7dAUYN6XY1OJuzvjpm9biqka9DSexYoALAU5+vkP619vrr7cY1o7roJOc5fW5
        8zu1KtfRNJuqluXlvOTNLWQ4GVibO4mfHYAZP28+U3qW0nn55LzOx5Gx2aSNxSIcDyum3b8j5Bzj4
        NVDa3Tkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWHv-00F76z-SZ; Tue, 09 Nov 2021 18:56:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30F753000DD;
        Tue,  9 Nov 2021 19:56:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 144DC212EE599; Tue,  9 Nov 2021 19:56:07 +0100 (CET)
Date:   Tue, 9 Nov 2021 19:56:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 4/7] static_call: fix broken static_call_query() for
 non-exported keys
Message-ID: <YYrER2TBtzOb6A2f@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109164549.1724710-5-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:45:46PM +0100, Ard Biesheuvel wrote:
> static_call_query() accesses the func member of the static call key
> directly, which means that it is broken for cases where it is used from
> a module and the key resides elsewhere and is not exported.
> 

Arguably when the module can't change the value, it shouldn't be having
any interest in obtaining said value either.

I really think you're exporting too much. Modules aren't good, they
deserve to suffer.
