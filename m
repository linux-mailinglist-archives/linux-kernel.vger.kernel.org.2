Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E845A515
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhKWOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbhKWOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:18:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4EEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gM4GtrWrBn42Otmn0FKXFiDWIvzqFS9dwIhMsy4qveo=; b=rLPbYJCzmx1dLcfoc4GqV8BZj6
        xaAYVq7+WXKpkH5J6tcSkWoJLHv3w/gcs5Vn6tbbjAxPs4fwkHzEuh5YAXcxzIqj3E/sjIvPNfAca
        4Huw+nFKRhDfP9RHgud4yzeuO5guMfINqPEgJI/xjsMKnd/oKw5iahUAB84FRmxU4ZOI+73K3+7L2
        XV6/NLVHAwLmWFqlVo+VD4lx+Dx+qj5XwP+OceqYxqKsCMDdllpdx0/7uZmNFsyh2nMGrneml9WS1
        AKSIMKKdTbcNE0CzXIG7bXIx3dkfZJg0V6pDCU8WDlwBPpoV0uj5pONtcBAOgABHymSVRLT8gmkUG
        bAf7pUqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpWZJ-00F62d-Kl; Tue, 23 Nov 2021 14:14:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8BD4300230;
        Tue, 23 Nov 2021 15:14:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABEED2C36EB84; Tue, 23 Nov 2021 15:14:45 +0100 (CET)
Date:   Tue, 23 Nov 2021 15:14:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com
Subject: Re: [RFC][PATCH 1/6] x86: Annotate _THIS_IP_
Message-ID: <YZz3VUh2czlD1aWQ@hirez.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.025419814@infradead.org>
 <20211123135348.GE37253@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123135348.GE37253@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:53:49PM +0000, Mark Rutland wrote:
> On Mon, Nov 22, 2021 at 06:03:02PM +0100, Peter Zijlstra wrote:
> > In order to find _THIS_IP_ code references in objtool, annotate them.
> 
> Just to check my understanding, IIUC this is because in later patches
> you'll look at text relocations to spot missing ENDBRs, and when doing
> so you need to filter out _THIS_IP_ instances, since those don't need an
> ENDBR. Is that right?
> 
> Just checking I haven't missed some other concern that might apply to
> arm64's BTI (Branch Target Identifier), which are analagous to ENDBR.

Correct; since _THIS_IP_ is never used for control flow (afaik, let's
hope to $deity etc..) we can ignore any relocation resulting from it
(lots!).


