Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC6441CAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbhI2RRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:17:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244648AbhI2RRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:17:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632935754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sWWcnqFRj6zAdMYEtH1XJ/oTMuUhVW1AUdTmaVur7iM=;
        b=I+VUN/NO1vuxg+Pjaj8NRFrhYq8XGcu1jaIKvk85LuwNRoAx/Coz54CjHgN3arWWAj3bNg
        +GjgtYsxpX+j8gP3aNjsx16XhaDNcCEdikGgs87YD4sMWRm4V/mjNkOZry8//CVn1gp2zJ
        wEbK1WfQmideZAl0wwjvCcf/JMa1dtnF+TJc/mWR7+u8mDadL9shQ8EfosbIMFv5J+Tuye
        rmn5G44VX+ujVE7tjF5yY3PkKVBFpK2sBdh1NEMDZEuClioQsr0xtrXRExLZRN13IDWN4D
        nrpi/DSXSNZEI0nUQcARd1/FnAz+ZbmpTbmhEu+0Xmu3oZTxrLHC2bn/gNhjaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632935754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sWWcnqFRj6zAdMYEtH1XJ/oTMuUhVW1AUdTmaVur7iM=;
        b=bQbMHfGUYpufXmcUgOg7LH/S9ywiZ5cAMhdRpm4DuazNhhpeW0HP/J4ta6RZJtsEj/+oHg
        PICI3Mv2scapi+CQ==
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
Date:   Wed, 29 Sep 2021 19:15:53 +0200
Message-ID: <877dez8fqu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29 2021 at 09:59, Andy Lutomirski wrote:
> On 9/29/21 05:28, Thomas Gleixner wrote:
>> Looking at that patch again, none of this muck in fpu__pasid_write() is
>> required at all. The whole exception fixup is:
>> 
>>      if (!user_mode(regs))
>>               return false;
>> 
>>      if (!current->mm->pasid)
>>               return false;
>> 
>>      if (current->pasid_activated)
>>      	     return false;
>
> <-- preemption or BH here: kaboom.

Sigh, this had obviously to run in the early portion of #GP, i.e. before
enabling interrupts.

For me that's more than obvious and I apologize that I failed to mention
it.

>> 
>>      wrmsrl(MSR_IA32_PASID, current->mm->pasid);
>
> This needs the actual sane fpstate writing helper -- see other email.

And with that there is no fpstate write helper required at all.

Stop this overengineering madness already.

Thanks,

        tglx
