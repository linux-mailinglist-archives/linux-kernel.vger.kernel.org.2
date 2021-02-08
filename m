Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46E312E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhBHKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhBHKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:01:24 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7EC061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D5tWWKHXqUG5EZDch0gesu7dkFX2RCXASBX8rVKzm1I=; b=1PpLDVWrRhmvcYo+GoCCpTy6YJ
        TaR35nwyQXshfjB8vqBMMbArydQmgYItuZDGJQyRR2GxVgn3cGh7b1Fd8g+hbqTFf/KJtuO2E1umC
        cnJyxZTjtLzuOGyfL9pFSyD1yf7MK9hXdc+sZa7slLX1jCXRekp0/bUb5kbpOFTerFpWqYMGgYC01
        mW8sEAiG96XkK6gNMWUcl2tIJQAMLYo0nOGDMFAPJJppgHzAqmGFE6qVpBPuMHmVifdrl2rV0gY60
        cjX78vQeoAlcG0xeheg6Fq6jo05KjZS03hJMIROMTgczc4H6QpYR3VbaGhDwzdu51Xh/eY2SZ21BF
        VRjPzqIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l93LH-0001cF-64; Mon, 08 Feb 2021 10:00:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C25823012DF;
        Mon,  8 Feb 2021 11:00:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3D132BF2D62E; Mon,  8 Feb 2021 11:00:20 +0100 (CET)
Date:   Mon, 8 Feb 2021 11:00:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 04/26] x86/tdx: Get TD execution environment information
 via TDINFO
Message-ID: <YCELtLeZnax8JNMU@hirez.programming.kicks-ass.net>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a5757dafc54932a6661fc94f51e413467b61fecf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5757dafc54932a6661fc94f51e413467b61fecf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:38:21PM -0800, Kuppuswamy Sathyanarayanan wrote:
> +/*
> + * TDCALL instruction is newly added in TDX architecture,
> + * used by TD for requesting the host VMM to provide
> + * (untrusted) services.
> + */
> +#define TDCALL	".byte 0x66,0x0f,0x01,0xcc"

This needs a binutils version number.
