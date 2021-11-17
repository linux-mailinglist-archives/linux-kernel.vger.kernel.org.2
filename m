Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2F454D43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhKQSi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhKQSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:38:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A023AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJvkS8r5o1AyR1YgZkApy8/O4Nbq/ZCO+OvQEiK8wHA=; b=SFokFvocv88lS0yYpjm3lCcEQN
        lEzojFvqJrIro8ggJ/xEt3w5kJ+huKvbt8LHF61SRtvnlzATyeDA1PuY8iAjSWM9TmNNzctrGa/Qo
        gguuYXyWcw11moICHwexINPuQBXoJAtkYqhzTuh/2OPg26r26sMGS3MPHLpBvTrLla6YCJRLSwTxz
        lCpwfq3fZoc9dmKXIFB7R083LojgbMjgHW2JtA2lW9mqtaEZDdH6La8UjpiJ4eJdYTFeJvC5W7DrT
        WApJPaBp7tBSXbvcY9Sn2epW7JiZ1QWVc7LevH2Ga3bEUwOPlhFTniLJxYmLLpYNH6oerujVNAv+j
        QyHpkZ5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnPlu-007qXK-L0; Wed, 17 Nov 2021 18:35:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC77D300093;
        Wed, 17 Nov 2021 19:35:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAF6E2C8F4FF0; Wed, 17 Nov 2021 19:35:01 +0100 (CET)
Date:   Wed, 17 Nov 2021 19:35:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 09:14:39PM +0300, Kirill A. Shutemov wrote:
> TDX is going to use CONFIG_PARAVIRT_XXL

*AARGGHHH*. srlsy? We were trying to cut back on that insanity, not
proliferate it.

