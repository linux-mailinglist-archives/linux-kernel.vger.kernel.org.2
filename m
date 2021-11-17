Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A2454D67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhKQSvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbhKQSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:51:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:48:39 -0800 (PST)
Received: from zn.tnic (p200300ec2f13a3006247e0a9efb398e6.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a300:6247:e0a9:efb3:98e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 124E51EC01A9;
        Wed, 17 Nov 2021 19:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637174917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=17gz2w0y3TP/PTBQBFjireJkhyX578vdKPKJtyIzJOA=;
        b=fNjUVvpT6STyPFt6MTQFZrVib/hNemH3Hdeye9qfdDZx4M+DG8FelM+pdFKi1nTb1359fv
        Q9bvxInSPZuHPEM/mwV+15SHF8FjtFHw1Ic3tFmruTZCTyNXh03Zo+DMhswDCzu/UMR/Fo
        12vhYTaP0pZgitTqj0dWN52vpDO/57Y=
Date:   Wed, 17 Nov 2021 19:48:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <YZVOfGtHyiZg1pIP@zn.tnic>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:46:30AM -0800, Sathyanarayanan Kuppuswamy wrote:
> TDX has a requirement to use HLT paravirt calls (which is currently
> listed under PARAVIRT_XXL). Once we submit a patch to move it
> under CONFIG_PARAVIRT, we will drop this dependency.

You already have this patch in some set:

https://lore.kernel.org/r/20211009053747.1694419-2-sathyanarayanan.kuppuswamy@linux.intel.com

So what's this churn for?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
