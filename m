Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4E331C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCIBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 20:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCIBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 20:18:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06995C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 17:18:17 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t26so7632337pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqD+DZIvHH7YPw/1ZQENRDv1EsYaakuAnsa/AEKRf3Q=;
        b=Hrd6e8WCMifdZ5q39xonuKO7wCdvps+knxuDZjQRUGo4Sa5bQqMQwdCdDA3qTX8VLe
         lGL2w+htvYCpJV3ywJ32OvbKNakp/5ewTHmzSaPEZE/1Z3/wQTLbgdqC9x2VF0dIbNjw
         /cWaA6UF7O5ACS8s1s2HXi0PONVQzQ/oksG/jTqVopWo8FtaaXZb4/zk937T0GIlQENa
         W43x8ESwo1iWhhOqJ56y2O6ybA+fgIGZhQFGyf3P3g6Dqo1B7yjy99sYgAsEScRqHz/N
         /FSIrzxfF4LLZcIEKdGMtud+pcR3V5E5LDoYeb4MN1+hW2hiYcFx+3q65dhX11fwQXxB
         jPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqD+DZIvHH7YPw/1ZQENRDv1EsYaakuAnsa/AEKRf3Q=;
        b=HdbFHcS19zRyymEL03sgbMzG+aRE0qMauAYjOEhuxw7hS3EGcf6LrZWchp+xqwXD6X
         GDKQzwb7Jcqf23CdLEtL3ygFdkRG68sHSErYB2Qqd1K+H97CXZFYxRZWaSA8hO3QkcWV
         0sILTHrx5/6ImV2lc7hxzH+d17j6DONquIwVwK4o9Og4Ye0rEqAR5OdH8TVHNjFCggNT
         WueCieVVW+woslik4YwEXPaFUlBGdp65G/Jc4OTBUeCATXZgBa4CQjU2a/bHv6159fO8
         fr1QOSmMSBUdBYV+iVvk1uRTLVJ/ty9Jp7ipIpeMejk9gZ84Wqe55X4N7Zz8hPMazlgY
         I4Dg==
X-Gm-Message-State: AOAM533hu19yWFH7YPpR/4H3j16vFyTnr7lz73rXX7LBwum10tGRs9o1
        QDeIqEBs+g3l+LbA8GMxDFVteQ==
X-Google-Smtp-Source: ABdhPJy7Ui7Qq3O0g/aUgGaVF5rUnu8j0o48Uh+0gjg+aUV2HzJKBQOLppPZFevCD9/SPhC6qkp77w==
X-Received: by 2002:a63:225f:: with SMTP id t31mr14760442pgm.371.1615252696330;
        Mon, 08 Mar 2021 17:18:16 -0800 (PST)
Received: from google.com ([2620:15c:f:10:8:847a:d8b5:e2cc])
        by smtp.gmail.com with ESMTPSA id y194sm1255599pfb.21.2021.03.08.17.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 17:18:15 -0800 (PST)
Date:   Mon, 8 Mar 2021 17:18:09 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v4 00/11] KVM: VMX: Clean up Hyper-V PV TLB flush
Message-ID: <YEbM0SYpnfcTnfdA@google.com>
References: <20210305183123.3978098-1-seanjc@google.com>
 <f1edcb01-41f5-d26f-e8d6-0dbd09a1eb89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1edcb01-41f5-d26f-e8d6-0dbd09a1eb89@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021, Paolo Bonzini wrote:
> On 05/03/21 19:31, Sean Christopherson wrote:
> > Sean Christopherson (11):
> >    KVM: x86: Get active PCID only when writing a CR3 value

...

> Huh, I was sure I had queued this already for 5.12.  Well, done so now.

Maybe this series is cursed.  The first patch got mangled and broke SME.
It shows up as two commits with the same changelog, so maybe you intended to
split the patch and things went sideways?

Anyways, commit a16241ae56fa ("KVM: x86: Get active PCID only when writing a
CR3 value") breaks SME and PCID.  The kvm/queue code looks like this:


	cr3 = __sme_set(root_hpa);
	if (npt_enabled) {
		svm->vmcb->control.nested_cr3 = root_hpa;
		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);

		/* Loading L2's CR3 is handled by enter_svm_guest_mode.  */
		if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
			return;
		cr3 = vcpu->arch.cr3;
	}

	svm->vmcb->save.cr3 = cr3;
	vmcb_mark_dirty(svm->vmcb, VMCB_CR);

but it should look like this:

	if (npt_enabled) {
		svm->vmcb->control.nested_cr3 = __sme_set(root);
		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);

		/* Loading L2's CR3 is handled by enter_svm_guest_mode.  */
		if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
			return;
		cr3 = vcpu->arch.cr3;
	} else if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
		cr3 = __sme_set(root);
	} else {
		cr3 = root;
	}

	svm->vmcb->save.cr3 = cr3;
	vmcb_mark_dirty(svm->vmcb, VMCB_CR);

I'll generate a delta patch, and test and post, just in case there is other
stuff that got lost.
