Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07413117C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBFA1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhBEMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:22:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51548C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z36dGRbCFgguUnQEKpJ8pVZDMMQJKuRXuXoi8kLH0Sg=; b=YNB2B2U8IV+7Ad6RFC+Ve1ryQk
        98FiMbAiOrlSRFPURjQYnet3Liuta3LH2ZmCImVxPlLVmcPbmcsUAFtDR3OXG/IM2mwvxVo03wBQp
        +kr/rj4W/tuEXEs53nM5semPwXtDkvioNiRAWG9rpqDL8R5qVKqwEle7um6OMJ4vv4jxlSbqQ6GRF
        EsU/+MbdYNnMUkT11hciY7DjP2fOEXbWO+gR1E357EQGgp8p8Qe8NmPA4jGzOPAEOE4D2Tpb4ExNi
        b4UI7k3ZyKbYHRFBtwHdNo1q/NoQZP5MBhYIXrBi8J4RYFrAK+rJ3DtMc4ZtiG3ZsZOHA+AJxAbf1
        qiwTaB1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l807E-0003qE-LI; Fri, 05 Feb 2021 12:21:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 063963059DD;
        Fri,  5 Feb 2021 13:21:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA3322BBE1CB0; Fri,  5 Feb 2021 13:21:34 +0100 (CET)
Date:   Fri, 5 Feb 2021 13:21:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 2/2] x86: add extra serialization for
 non-serializing MSRs
Message-ID: <YB04TgBo4P7n7s4X@hirez.programming.kicks-ass.net>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
 <20200305174708.F77040DD@viggo.jf.intel.com>
 <f37ecf01-3167-f12e-d9d0-b55c44b80c29@citrix.com>
 <CALCETrXMhe3ULF9UDc1=8CKVfKqneCxJ2wYmCdKPpntkkMNGWg@mail.gmail.com>
 <YB0XonRIr1GcCy6M@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB0XonRIr1GcCy6M@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:02:10AM +0100, Peter Zijlstra wrote:

> And presumably it is still allowed to do that when we write it like:
> 
> 	mov	$1, ([x])
> 	mfence
> 	wrmsr
> 
> because, mfence only has dependencies to memops and (fast) wrmsr is not
> a memop.
> 
> Which then brings us to:
> 
> 	mov	$1, ([x])
> 	mfence
> 	lfence
> 	wrmsr
> 
> In this case, the lfence acts like the newly minted ifence (see
> spectre), and will block execution of (any) later instructions until
> completion of all prior instructions. This, and only this ensures the
> wrmsr happens after the mfence, which in turn ensures the store to x is
> globally visible.

Note that I too do have a few questions.

Supposedly MFENCE is our LOAD/STORE completion fence of choice, and this
obviously works with MMIO, since that's memops. The MMIO write of the
buffer address to the DMA device must happen after completion of the
previous data writes etc..

But what about the legacy IN/OUT ports? Are those memops? If not, we
might need additional LFENCEs there too.

Also, would SFENCE+LFENCE be sufficient for the WRMSR case? AFAIU SFENCE
is the store completion barrier and should be strong enough to flush all
store buffers. If not, why not?

