Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687941C136
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244958AbhI2JCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbhI2JC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:02:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC28C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pHipk2Cz3G9EnP66HxC1PEdxlMMCy85ylZCusFz7JX8=; b=L2xBKMCBCbqkPhULXQnAf/DB/B
        bROMSR+f43tHOq/eYeFHLkKZn1Pk/y5gW3IrCVfl7d6eN4psA+tO/5zk5f6KFbGjDxVOU+fN6MVY9
        +uCWD0iwIlzcIMeEqIylwygihyu/69yJlPiF/7DoovPPq5tws71ZfddvLvr7I6KMu//PQuXXUiKYZ
        3SeOrI0MoGwFyYPSltKq8xVFNlaI8W1mKyE91ZVyi9vagKB4SbAezx4crOIMzohhzv6twbfoxL+98
        mZ1Bp5eC48Jte5ZUkraixWMamffwPKDEPZhM1SOK6mnP3LusiK/LfUUSaggTQrThqws3VSMxUG6Wx
        y7jpSh/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVVS5-006g5d-O5; Wed, 29 Sep 2021 09:00:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0128E30029A;
        Wed, 29 Sep 2021 11:00:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DC2D2DC92D0A; Wed, 29 Sep 2021 11:00:32 +0200 (CEST)
Date:   Wed, 29 Sep 2021 11:00:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVQrMHXBzEpJmqRy@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
 <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
 <YU3xLNJsSjIEpocT@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU3xLNJsSjIEpocT@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 08:39:24AM -0700, Luck, Tony wrote:

> If you have ctags installed then a ctrl-] on that
> __fixup_pasid_exception() will take you to the function with
> the comments. No electron microscope needed.

I to use ctags, but when reading the #GP handler, this is a whole
different file. Also, I don't find any of those comments explaining the
not-our-#GP-but-harmless-cycle issue.

The current->has_valid_pasid one comes close, but just misses it. But
really the place to put this is in the #GP handler itself so we don't
have to dig through every call there to figure out how it's supposed to
work.

> +
> +/*
> + * Try to figure out if there is a PASID MSR value to propagate to the
> + * thread taking the #GP.
> + */
> +bool __fixup_pasid_exception(void)
> +{
> +       u32 pasid;
> +
> +       /*
> +        * This function is called only when this #GP was triggered from user
> +        * space. So the mm cannot be NULL.
> +        */
> +       pasid = current->mm->pasid;
> +
> +       /* If no PASID is allocated, there is nothing to propagate. */
> +       if (pasid == PASID_DISABLED)
> +               return false;
> +
> +       /*
> +        * If the current task already has a valid PASID MSR, then the #GP
> +        * fault must be for some non-ENQCMD related reason.
> +        */
> +       if (current->has_valid_pasid)
> +               return false;
> +
> +       /* Fix up the MSR by the PASID in the mm. */
> +       fpu__pasid_write(pasid);
> +       current->has_valid_pasid = 1;
> +
> +       return true;
> +}
> 
> -Tony
