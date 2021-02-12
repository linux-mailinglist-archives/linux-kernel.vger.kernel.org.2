Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86485319783
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBLAfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBLAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:34:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 16:34:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v17so7907951ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=mCXu5yp4jt72DPFHwJr3l/cPyL+1tdNvx3HP8ciMZWI=;
        b=RshVkD31psjo3jq+kYicv60lao/jr62jKHN2nE2Km3dgWhxiOFwNwBGR3QLrHh57SW
         woR27bU2e+0N1jGoWbr6rGWZqjU7zbNFtlhpWBZYEFQbiYFr9cwXpxuPD4ah2sdbwOpa
         Hg0bAmmnqLLSSzgfyKCybkVkaD18EEJ7coY3Vu6jbMadehLOHoCuk4Wwo5NbwenkMk5Z
         6FwlZnXstpupgjO3zONOzZeQJ0LTwaXvRSQZp5fEcyq+5wr2NPPQRSD1qtQqjdHRDX4I
         zWdA5LN6UcRjhICwjkqnkVEwycpYvfk+6o6Lu8HMAMvcOrkq4xUY4gWeb84/Lja0XWXt
         rzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=mCXu5yp4jt72DPFHwJr3l/cPyL+1tdNvx3HP8ciMZWI=;
        b=WvD0dPZgyfPq9kSjaozA4OhPCxstYXt57VlcFpqmEOqIr+Urz1oPjMMGdnjhmagurD
         RzuwDxF6jAVpaqy/qxuv4eqMbkynzezvl6LAdg32OfLQpjGfIj/GoJC1C2CWkgj0TP9j
         EiOC9XM8k47EaixD34TLDj9neGaVJRraawz6zilouMnYZhnqp+s9cbwTi3v6RSaQimPa
         jyqfWWx/YbJdN14bK6NmmUh0wW2/Te4Ce7jdoFIljmElCf8i5ESQrkgI+ECDT0HJcX81
         d1CFGsqMo1FJ3Hf7ooySDdsr2dhKgHUqq7OfSbfe79ew2dSTDC4xBIxqeWJpYXtSwUv5
         3GYA==
X-Gm-Message-State: AOAM532QRXC4uM/uFlbhWTOboF+zfa+PezqOE37lk3mHIaXA23ufkKgw
        8egduKA+QEVrY5aOSoUXyKEQZhuRrzM=
X-Google-Smtp-Source: ABdhPJy7Cv4THKPOAN1VWhlB1DO4+fYemdbGtP0zVuWGIArV8rDPD59/g6CUVkC1S257vurJ/1bme+JFcjo=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f588:a708:f347:3ebb])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:: with SMTP id
 k6mr757884ybt.52.1613090054147; Thu, 11 Feb 2021 16:34:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Feb 2021 16:34:08 -0800
Message-Id: <20210212003411.1102677-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 0/3] KVM: x86: SVM INVPCID fix, and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an INVPCID bug on SVM where it fails to injected a #UD when INVPCID is
supported but not exposed to the guest.  Do a bit of cleanup in patch 02
now that both VMX and SVM support PCID/INVPCID.

Patch 03 address KVM behavior that has long confused the heck out of me.
KVM currently allows enabling INVPCID if and only if PCID is also enabled
for the guest, the justification being that the guest will see incorrect
fault behavior (#UD instead of #GP) due to the way the VMCS control works.

But that makes no sense, because nothing is forcing KVM to disable INVCPID
in the VMCS when PCID is disabled.  AFACIT, the myth was the result of a
bug in the original _submission_, not even the original _commit_ was buggy.

Digging back, the very original submission had this code, where
vmx_pcid_supported() was further conditioned on EPT being enabled.  This
would lead to the buggy scenario of unexpected #UD, as a host with PCID
and INVCPID would fail to enable INVPCID if EPT was disabled.

> > +	if (vmx_pcid_supported()) {
> > +		exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
> > +		if (exec_control & SECONDARY_EXEC_ENABLE_INVPCID) {
> > +			best = kvm_find_cpuid_entry(vcpu, 0x1, 0);
> > +			if (best && (best->ecx & bit(X86_FEATURE_PCID)))
> > +				vmx->invpcid_enabled = true;
> > +			else {
> > +				exec_control &= ~SECONDARY_EXEC_ENABLE_INVPCID;
> > +				vmcs_write32(SECONDARY_VM_EXEC_CONTROL,
> > +						exec_control);
> > +				best = kvm_find_cpuid_entry(vcpu, 0x7, 0);
> > +				best->ecx &= ~bit(X86_FEATURE_INVPCID);
> > +			}
> > +		}
> > +	}

The incorrect behavior is especially problematic now that SVM also
supports INVCPID, as KVM allows !PCID && INVPCID on SVM but not on VMX.

Patches to fix kvm-unit-tests are also incoming...

Sean Christopherson (3):
  KVM: SVM: Intercept INVPCID when it's disabled to inject #UD
  KVM: x86: Advertise INVPCID by default
  KVM: VMX: Allow INVPCID in guest without PCID

 arch/x86/kvm/cpuid.c   |  2 +-
 arch/x86/kvm/svm/svm.c | 11 ++++-------
 arch/x86/kvm/vmx/vmx.c | 14 ++------------
 3 files changed, 7 insertions(+), 20 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

