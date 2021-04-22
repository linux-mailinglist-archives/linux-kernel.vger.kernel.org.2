Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B0236775F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhDVCWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhDVCWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:22:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F1C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u73-20020a25ab4f0000b0290410f38a2f81so18096025ybi.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=S/gdc/KPJQxXmxISBs1in1L8dT4ZjfjiXiG2Z4o7inw=;
        b=edfyNDAfRzkyrqiUAUJ07/phuYREeNXJb43J5+fNz3oqXwMMMrufgK5rmZprOH5Aji
         g9JWJ284jHbbeUlp4j9//gscxXo5H3+kVl/4DHB83adoMshbKlGZIUYJEpMFzfKy/Qqh
         CN9jOX0Aa9nJagqnJBz+i6DNzzSGnZvYUXmkaVPBnVYSzbhITj6YpuL8rowDGBIo8I3l
         EWq9Sb8eNRVJ5S55G605S8cJRQ/+/qONV6jEBozZC/d4OHwr8NWEIX0nG8ficzR6FPcz
         q6o1TDgHGjKOB6vgCYglvEr8ar7BLxGF/d/xnkE7MNLYkJwvC5VhWprH1dgwQr3BDEJT
         0Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=S/gdc/KPJQxXmxISBs1in1L8dT4ZjfjiXiG2Z4o7inw=;
        b=CeL4zNLeuCLcf6HGJN9ffUBIfoVgTtS9Q9XOo1nVlgFmPfaK+4fZ+qtR+Z5SKoaGtL
         OYKpx+zIE+9EG1roJUBmlFwpwLoDDGtO2Yi+mUl88NWR8aCfNHJEK5g/MxF7o1oiRkbC
         iz2SXAudeGfWOr6i/kyRBXeIvQ5dJZsXkLp3ByPT6DHuwX8lrybBKHlCMTlws995j++V
         fkvJzsNbVd4+klWQ3mlW3qU+WmMXUJ6PXPN/K9J6iHzejGQ41Do440wKlUb+Bi450lS4
         lfjaBFqiAk7C6WIQl9VCaDPcNLOLDhZS4r3jGnZvGwjYpWj9vy+TF2HXD+fHSHaAh/k2
         ezqw==
X-Gm-Message-State: AOAM530hFb+x1O9fHdxmH0CpZcx38MHwg/Lg0EkYvEHmn8eOpFuEFRdD
        V6+ch7DJqs/qYnykcSUvu+2d32qIi3g=
X-Google-Smtp-Source: ABdhPJzhRsVtk2eJrm0tONdcH5S8p/3//CBgI9jMbFawrOKcua/SVngwCpua6QFNe41fYo+ga9uA8WH511Y=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:d051:: with SMTP id h78mr1432744ybg.497.1619058102136;
 Wed, 21 Apr 2021 19:21:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:21:24 -0700
In-Reply-To: <20210422022128.3464144-1-seanjc@google.com>
Message-Id: <20210422022128.3464144-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210422022128.3464144-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 5/9] KVM: nVMX: Truncate bits 63:32 of VMCS field on nested
 check in !64-bit
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop bits 63:32 of the VMCS field encoding when checking for a nested
VM-Exit on VMREAD/VMWRITE in !64-bit mode.  VMREAD and VMWRITE always
use 32-bit operands outside of 64-bit mode.

The actual emulation of VMREAD/VMWRITE does the right thing, this bug is
purely limited to incorrectly causing a nested VM-Exit if a GPR happens
to have bits 63:32 set outside of 64-bit mode.

Fixes: a7cde481b6e8 ("KVM: nVMX: Do not forward VMREAD/VMWRITE VMExits to L1 if required so by vmcs12 vmread/vmwrite bitmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8b111682fe5c..0e580305a1ee 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5743,7 +5743,7 @@ static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 
 	/* Decode instruction info and find the field to access */
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	field = kvm_register_read(vcpu, (((vmx_instruction_info) >> 28) & 0xf));
+	field = kvm_register_readl(vcpu, (((vmx_instruction_info) >> 28) & 0xf));
 
 	/* Out-of-range fields always cause a VM exit from L2 to L1 */
 	if (field >> 15)
-- 
2.31.1.498.g6c1eba8ee3d-goog

