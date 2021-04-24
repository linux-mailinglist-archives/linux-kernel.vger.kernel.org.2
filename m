Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B67369DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhDXArt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhDXArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:47:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C627AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v63-20020a252f420000b02904ecfc17c803so15026548ybv.18
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=RHGsqWwH1zxHj0xIe8K4VtoI6F8/53X2i4hvFea/Jtc=;
        b=OPjwaJ3YTXeq24If+8hQOW0VyJ+bADxa0ZRW5sPafB80mG4gzK4fam3t9CjRIQWl7T
         wGw7HJd4vszwt8ioG7VoGFwsLhoabf0qd/kaDt6vxb6365MyOLPhCdgvplw3BaMQ2qs8
         No6dsSgvzPfQcYF09OgMhnG4ahp0tp7RHLuXXmJ8jKSi2UmICvWZbzP2d/nJLz71SmY9
         lWxco2nnDLF9nUs8asjapZgxqWC9N3Z/d9gP+9Gmrj6EzMj0uHmP/G6vRkJPYNyoVxgz
         5l+Kvb6xbV4lSKxLTbI/+68iCD6p8msMn5HQemfW0SzONRC/SXhKoPbgtQYkTQWLFvJy
         O2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=RHGsqWwH1zxHj0xIe8K4VtoI6F8/53X2i4hvFea/Jtc=;
        b=i0CSVQ4Exb3crp2LWlCl/mrQ5oCjhc4aq72+OVstEBoTu76IleNJq77nQokRSXLdHN
         lcn+doMxvn/9+hH1tX4P8kam/ged5ndm6aaE6NL55caeT3ekb4/BSCRPKFXAuWpNxo4y
         WLPRuu2QEQd/Yn9fmrwl81/zwJurFkt8e6E3XmcS8diZhf6AVSFvtTCJMoFHkfQvqFLd
         fZ5Xj+iHRFgG8Lxy6DPAPShv8nxRwcqBavMDxCwcxnIIQmM633hI2g4E5/CfQJd7qpKz
         3LzvV64oxIWgneDn+ljmDjkPOQI1l7r7s1OktoyuqXlodV8oNxGQ4lNQU0AqaRK3bmDE
         8+Jw==
X-Gm-Message-State: AOAM530oqrcb4/WfgH5oVOa1eDdj50Xs7ujv9OceTO9ApjZLqFJPaT9s
        0OAMCXYokHFRhRSq6bC6dW1I4+hhC4Q=
X-Google-Smtp-Source: ABdhPJzX+waosmfrUN513JsYHxpFuDWHWvyn4N/ji2D0vC9EQhyeKOU7/v4bDJ04Jc3LfwehTPEuiQqvW2Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:ac9b:: with SMTP id x27mr8963271ybi.120.1619225222104;
 Fri, 23 Apr 2021 17:47:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:03 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 01/43] KVM: nVMX: Set LDTR to its architecturally defined
 value on nested VM-Exit
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set L1's LDTR on VM-Exit per the Intel SDM:

  The host-state area does not contain a selector field for LDTR. LDTR is
  established as follows on all VM exits: the selector is cleared to
  0000H, the segment is marked unusable and is otherwise undefined
  (although the base address is always canonical).

This is likely a benign bug since the LDTR is unusable, as it means the
L1 VMM is conditioned to reload its LDTR in order to function properly on
bare metal.

Fixes: 4704d0befb07 ("KVM: nVMX: Exiting from L2 to L1")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 00339d624c92..32126fa0c4d8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4276,6 +4276,10 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	};
 	vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
 
+	memset(&seg, 0, sizeof(seg));
+	seg.unusable = 1;
+	vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
+
 	kvm_set_dr(vcpu, 7, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

