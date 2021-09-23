Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357AB416122
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbhIWOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:38:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhIWOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:38:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632407811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qk5SWtvWztav1d34rimp+axwz2uAlkSCirHPCi6SGlY=;
        b=g7Ek/TeFULsF7sK6OQfwNWOX61vf8REKAJRK7IzhTXeBgOdV/Diko4a0P5+bQYnb07elR0
        s4ILsOk9KJsvfxL22o7/g/MPCbxlEvFa+0QeN91yGuF2dmYeNYy/k9vC84EJ3Hoajn2v1K
        WcIiM/nIav37yMi6oFosTp93wFq+qzFfi9tdwoG8pSEvXFOO1X/YqGOdx8LPLEujT54F4o
        q6zuR8YcaHraOlkIYkj8tThSId7POAlsuQKadr1x777hR72nYITCYMG88C0BOJO3ug0Tqe
        sx8fGggxr6c3LRp2oSd86MaIK+H9fpdZZbmCCoQF9W1A7ELAXs+fs/abt7khnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632407811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qk5SWtvWztav1d34rimp+axwz2uAlkSCirHPCi6SGlY=;
        b=H6dvkkN47bCyZzwlY0JUFQ7uATY2ql1mGO4cHSy6395KBmgE8LpdjVgsY+g0mML0arQgcv
        ryxelQSmTKi+KUCQ==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <20210920192349.2602141-6-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
Date:   Thu, 23 Sep 2021 16:36:50 +0200
Message-ID: <87y27nfjel.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20 2021 at 19:23, Fenghua Yu wrote:
>  
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +void pasid_put(struct task_struct *tsk, struct mm_struct *mm);
> +#else
> +static inline void pasid_put(struct task_struct *tsk, struct mm_struct *mm) { }
> +#endif

This code is again defining that PASID is entirely restricted to
INTEL. It's true, that no other vendor supports this, but PASID is
a non-vendor specific concept.

Sticking this into INTEL code means that any other PASID implementation
has to rip it out again from INTEL code and make it a run time property.

The refcounting issue should be the same for all PASID mechanisms which
attach PASID to a mm. What's INTEL specific about that?

So can we pretty please do that correct right away?

Thanks,

        tglx
