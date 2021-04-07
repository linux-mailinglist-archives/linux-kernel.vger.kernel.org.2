Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AA3356F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbhDGOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhDGOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:52:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A6EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qrs4g4y7pUiMXOP2oCKKvcPXzqp0XPDWJESZj/qqlBY=; b=GdiW0JU2jUF96T7IuZ6E39ZyzP
        364aw6St8b2gy7ozm69nzmi0veJzF7p1mhZ2nNfzvcUMxsmAz3UqMnGJm2GFDKz0MuSysdO4PxN+m
        YYu1pr/6bHuhNP0UZ8n5vxYwcNULuACliglbM74ZVAshIalk8/uqkmXeFLz3ZPkoeY0A8NIYH2AiD
        +kVXzpkmpNpI99mivkHuGW8w9O/8KN0I4VJOAffwGkKdpGAHoI9dMB6GulIeo8FsX1LESC0F+kp6e
        uVInVlFz1G1gyb/rWm4Nhd+Rj2NF1WQb83VIKvleOBA07bDkR66zFbGEZkwVDrstlyD6KuxLddP8i
        mdoT1I0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU9U4-00EcYB-Ph; Wed, 07 Apr 2021 14:49:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75C66300BD2;
        Wed,  7 Apr 2021 16:48:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67F822BBEA8E3; Wed,  7 Apr 2021 16:48:44 +0200 (CEST)
Date:   Wed, 7 Apr 2021 16:48:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/37] x86/mm: attempt speculative mm faults first
Message-ID: <YG3GTI8j1ohk4NhS@hirez.programming.kicks-ass.net>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-12-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-12-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:36PM -0700, Michel Lespinasse wrote:
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1219,6 +1219,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	struct mm_struct *mm;
>  	vm_fault_t fault;
>  	unsigned int flags = FAULT_FLAG_DEFAULT;
> +	struct vm_area_struct pvma;

That's 200 bytes on-stack... I suppose that's just about acceptible, but
perhaps we need a comment in struct vm_area_struct to make people aware
this things lives on-stack and size really is an issue now.

