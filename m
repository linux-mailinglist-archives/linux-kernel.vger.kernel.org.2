Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31744224F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhJEL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhJEL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:26:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00CC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2G6TJ80fE3ZRcTQr8pZQn2p5sAs/HIJkcuih26ApsG4=; b=B2f/EdpvIFQV22yYWIjsFB9M1e
        Uug0kKT8Tyw4EFkRAXVRvcUudfl0xA79Oaz6KZ+YXBa3lfQIS2AZYv2F/71RA+OvawCaywAbj9Gvj
        1JQVVEjMU4egoJbFXcB6mGPsrVpEir3TbC9rblo4ulfeYaJGvIAf9cvCYkomEjmSrvC2S88jDz1C4
        OCH0otJ3YLWMLGUHB3EXwpYUXTyiMxIj8v0cyFMnf01a7nujsjAvFzbXvEdMCgbKHAG+a79vKa6y0
        NaZhbWJUOnPgasumLgyjn5BLAtnpDrhXeX33YwOonN0zpn5V2/TFTiN1AkRLw6c/uYxzgIqf4cJ68
        s//WT/zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXiXv-000LRa-9Z; Tue, 05 Oct 2021 11:24:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA2F93002DE;
        Tue,  5 Oct 2021 13:23:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9FE92038E1F9; Tue,  5 Oct 2021 13:23:42 +0200 (CEST)
Date:   Tue, 5 Oct 2021 13:23:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org,
        len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 15/29] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Message-ID: <YVw1vvy0QUKcKaxU@hirez.programming.kicks-ass.net>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <20211001223728.9309-16-chang.seok.bae@intel.com>
 <87o884fh3g.ffs@tglx>
 <87ilybg5ta.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilybg5ta.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:49:05AM +0200, Thomas Gleixner wrote:
> So this gives us two options:
> 
>    1) Bitmap with proper sanity checks
> 
>       reject (1 << 17) and (1 << 18)
>       grant (1 << 17 | 1 << 18)
> 
>       but for sanity sake and also for ease of filtering, we want to
>       restrict a permission request to one functional block at a time.
> 
>       #define X86_XCOMP_AMX	(1 << 17 | 1 << 18)
>       #define X86_XCOMP_XYZ1    (1 << 19)
> 
>       But that gets a bit odd when there is a component which depends on
>       others:
> 
>       #define X86_XCOMP_XYZ2    (1 << 19 | 1 << 20)
> 
>    2) Facility based numerical interface, i.e.
> 
>       #define X86_XCOMP_AMX	1
>       #define X86_XCOMP_XYZ1    2
>       #define X86_XCOMP_XYZ2    3
> 
>       is way simpler to understand IMO.

I'm thinking 2 makes most sense. Perhaps we could use the highest
feature number involved in the facility to denote it? The rationale
being that we don't have to invent yet another enumeration and it's
easier to figure out what's what.
