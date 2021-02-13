Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D2F31A93B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBMBG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhBMBGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:06:10 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EEAC061786
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:30 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id z19so1036563qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OtznJizRN0hv7fVgLX6rnwrrxkCPL4lVRSWsCFjNnfE=;
        b=t56RiT1euE1E7CnLH3sOlDJSwYjYPxoxi/65GUwODU+vZGxsdYuG5+JudpeiQbYM/C
         ZFbuxsVlODgPdGNe/ORKCDGDUs6vPLRE4eEUhTNPQMTF/7ka0IiZrgOjzUUfSW1pCy8F
         yQexKIkRIlzOiBzSslW2f8bGyujBRRESZvdG1tDQJEuEA1sb+qmvq0d+f+dWDsOh887m
         rICHWD3PzXVRf37UTmBrWq6W5h+X1QzvK6HHtVDPG/lCd16qAg2vUCA4GEUP1MpAPHb1
         2CwxXyh/k7TV8L3H8XmmhMcOgp4UegSpqOBvho3GdgNScCjqgwBzUv3s+SCQmCUIax6N
         ISVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OtznJizRN0hv7fVgLX6rnwrrxkCPL4lVRSWsCFjNnfE=;
        b=Do70bg5tSvCTiareANAvwgYdlBcOxqZhbvQg4TJIs2WklKrZnJp35crHianLbHS65U
         /qc5QlIGsmT7RbD3EN5gyPQXiA7/asMiunsTZ9cVvb+iec3cjD7GOEyUgABsDLk5A4eZ
         KD3nFfHzYIgJoDNV0ANtY0KWfEUa+bMVerXLrnvUD6ZZRO18j1dWW7wPkxZXMMiqT2nS
         BfHd6rdmyWsA3BqV6TrLV7ecxmWpSJJzG8dQoArshA0Myu3DuluCWJM4nZ584T4gG8wZ
         40YACGLbJ97umSfw10Q7zMsxmZ17SYaeRbNEuBi5K/zxVR0fMqgTfwCNT6zodKdSk6Ok
         tZ6g==
X-Gm-Message-State: AOAM530Rh/vs4bmDtdIkYKF4wOSILbSOa+hy+9j5kza0ixnywia5xLnW
        rzdjCJuGh2cTbYZVJo++oDsdcHygJlU=
X-Google-Smtp-Source: ABdhPJyHJCYOfqtyA0CEPVTw5ctoK1eVWrcbTWX8UBaNeZKIu8zioYMpaKyl/EHcdeGYZhRTW+srES5FTOQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a05:6214:20a1:: with SMTP id
 1mr5147613qvd.30.1613178329654; Fri, 12 Feb 2021 17:05:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 17:05:10 -0800
In-Reply-To: <20210213010518.1682691-1-seanjc@google.com>
Message-Id: <20210213010518.1682691-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210213010518.1682691-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 1/9] KVM: x86: Remove emulator's broken checks on CR0/CR3/CR4 loads
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

Remove the emulator's checks for illegal CR0, CR3, and CR4 values, as
the checks are redundant, outdated, and in the case of SEV's C-bit,
broken.  The emulator manually calculates MAXPHYADDR from CPUID and
neglects to mask off the C-bit.  For all other checks, kvm_set_cr*() are
a superset of the emulator checks, e.g. see CR4.LA57.

Fixes: a780a3ea6282 ("KVM: X86: Fix reserved bits check for MOV to CR3")
Cc: Babu Moger <babu.moger@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 68 +-----------------------------------------
 1 file changed, 1 insertion(+), 67 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index f7970ba6219f..f4273b8e31fa 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4230,75 +4230,9 @@ static int check_cr_read(struct x86_emulate_ctxt *ctxt)
 
 static int check_cr_write(struct x86_emulate_ctxt *ctxt)
 {
-	u64 new_val = ctxt->src.val64;
-	int cr = ctxt->modrm_reg;
-	u64 efer = 0;
-
-	static u64 cr_reserved_bits[] = {
-		0xffffffff00000000ULL,
-		0, 0, 0, /* CR3 checked later */
-		CR4_RESERVED_BITS,
-		0, 0, 0,
-		CR8_RESERVED_BITS,
-	};
-
-	if (!valid_cr(cr))
+	if (!valid_cr(ctxt->modrm_reg))
 		return emulate_ud(ctxt);
 
-	if (new_val & cr_reserved_bits[cr])
-		return emulate_gp(ctxt, 0);
-
-	switch (cr) {
-	case 0: {
-		u64 cr4;
-		if (((new_val & X86_CR0_PG) && !(new_val & X86_CR0_PE)) ||
-		    ((new_val & X86_CR0_NW) && !(new_val & X86_CR0_CD)))
-			return emulate_gp(ctxt, 0);
-
-		cr4 = ctxt->ops->get_cr(ctxt, 4);
-		ctxt->ops->get_msr(ctxt, MSR_EFER, &efer);
-
-		if ((new_val & X86_CR0_PG) && (efer & EFER_LME) &&
-		    !(cr4 & X86_CR4_PAE))
-			return emulate_gp(ctxt, 0);
-
-		break;
-		}
-	case 3: {
-		u64 rsvd = 0;
-
-		ctxt->ops->get_msr(ctxt, MSR_EFER, &efer);
-		if (efer & EFER_LMA) {
-			u64 maxphyaddr;
-			u32 eax, ebx, ecx, edx;
-
-			eax = 0x80000008;
-			ecx = 0;
-			if (ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx,
-						 &edx, true))
-				maxphyaddr = eax & 0xff;
-			else
-				maxphyaddr = 36;
-			rsvd = rsvd_bits(maxphyaddr, 63);
-			if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
-				rsvd &= ~X86_CR3_PCID_NOFLUSH;
-		}
-
-		if (new_val & rsvd)
-			return emulate_gp(ctxt, 0);
-
-		break;
-		}
-	case 4: {
-		ctxt->ops->get_msr(ctxt, MSR_EFER, &efer);
-
-		if ((efer & EFER_LMA) && !(new_val & X86_CR4_PAE))
-			return emulate_gp(ctxt, 0);
-
-		break;
-		}
-	}
-
 	return X86EMUL_CONTINUE;
 }
 
-- 
2.30.0.478.g8a0d178c01-goog

