Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EE30CDDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBBVVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBBVVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:21:03 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:20:23 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s66so18492232qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=SP8qMh2H5uKuGn56qQjTuaPHFsmbyYN2PVhXxr1Wb/c=;
        b=YVgAKVM6kkOctLgE8nCs1fKIlb2yjj7CHd7ZMzDwOLNGOg1gcc+QG4XlrVvzxeuREC
         HkE9XpZMfHkIW7M4bCKkSL6+T/I6pQxZNTkrJM5DakqOV6JzTqAy4Psv7jKepBs0oe3a
         gDFm/OJb00IflpNMMsyTFxsLIOCNRY7szyP5S6fYR3BfiGTnNErkeOIOsPzHHA2jrca5
         JSk8w+37IPlIoCohYf3ch4DQ3Ky47ODPI2Z4XOUVC+hODwpX7HnCjZp6fYslyiVovG4Y
         SeAFKRo9WIdo2FDDnBsEcQ/uEp4sNO+T9uzu2/vKM/rSrLjNKDxDCTI6lNHjZbAlsyw8
         GMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=SP8qMh2H5uKuGn56qQjTuaPHFsmbyYN2PVhXxr1Wb/c=;
        b=RSaPKNo1f93FkKZ8MOEhZD/ElvHSIVLIafXuhzwG+J98cW8FDySrPqFNhT0IW6JE6z
         TUVQ+eSIvcc9+9lIxzt/wkRILGYtGNOQgV2xRohOFazDmh5jJAwT1xdcXFuLbnL6RPoQ
         wJZcUd+wEtHAXJ+PC9Pn2+FssuXTMliYICe64U9jyPR9r7NdyQzAoV2EUmdsw5TfEryV
         s71dmxyKqIsVlhwhmUAZ0uFtUEcnOtt5GMQRfHYh6wbooELZaxy23OfsaoqnZqHSaA9/
         QJotypNdl/GWyNBBQQu4apYpEl/40Rm57RGl6+AwFggpwJmgRJpakop4DY3mflqYt3WG
         eCJA==
X-Gm-Message-State: AOAM5331gZ4NqaIOtl05cbC/KOXaCMqj1RQfoGbu1SoUWL6bTXnO0LXW
        lNDPo1qFd3il9yRHimQygIXnvI2btzA=
X-Google-Smtp-Source: ABdhPJzUzodN3KIBXul52n7bnjL2mGC4zihxwheFohK7KbF/xI/u+9+F9g5XC3z/JC0BgE/yM8E65dhtlMc=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e1bc:da69:2e4b:ce97])
 (user=seanjc job=sendgmr) by 2002:a05:6214:403:: with SMTP id
 z3mr74190qvx.42.1612300822251; Tue, 02 Feb 2021 13:20:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Feb 2021 13:20:17 -0800
Message-Id: <20210202212017.2486595-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] KVM: SVM: Treat SVM as unsupported when running as an SEV guest
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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

Don't let KVM load when running as an SEV guest, regardless of what
CPUID says.  Memory is encrypted with a key that is not accessible to
the host (L0), thus it's impossible for L0 to emulate SVM, e.g. it'll
see garbage when reading the VMCB.

Technically, KVM could decrypt all memory that needs to be accessible to
the L0 and use shadow paging so that L0 does not need to shadow NPT, but
exposing such information to L0 largely defeats the purpose of running as
an SEV guest.  This can always be revisited if someone comes up with a
use case for running VMs inside SEV guests.

Note, VMLOAD, VMRUN, etc... will also #GP on GPAs with C-bit set, i.e. KVM
is doomed even if the SEV guest is debuggable and the hypervisor is willing
to decrypt the VMCB.  This may or may not be fixed on CPUs that have the
SVME_ADDR_CHK fix.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

FWIW, I did get nested SVM working on SEV by decrypting all structures
that are shadowed by L0, albeit with many restrictions.  So even though
there's unlikely to be a legitimate use case, I don't think KVM (as L0)
needs to be changed to disallow nSVM for SEV guests, userspace is
ultimately the one that should hide SVM from L1.

 arch/x86/kvm/svm/svm.c    | 5 +++++
 arch/x86/mm/mem_encrypt.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 687876211ebe..9fb367cb4f15 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -448,6 +448,11 @@ static int has_svm(void)
 		return 0;
 	}
 
+	if (sev_active()) {
+		pr_info("KVM is unsupported when running as an SEV guest\n");
+		return 0;
+	}
+
 	return 1;
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c79e5736ab2b..c3d5f0236f35 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -382,6 +382,7 @@ bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
+EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
 bool noinstr sev_es_active(void)
-- 
2.30.0.365.g02bc693789-goog

