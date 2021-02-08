Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D6313AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhBHR30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbhBHP2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:28:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC10F64DE7;
        Mon,  8 Feb 2021 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612797377;
        bh=6azHOLKJoxj32u/s0uGAKRAmiGdNWbS8QZEo4uz3+W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4qSb+GJ2Rs/FD7TRwD36kqEym6NVrFNTxqyUW4uvSNlbjvx4IMxh0HPvlVIRbBmX
         zVP3jo+keyu7Km9D4WUgU6ucrSyUtmqbVtXDcfepruAXN70fLUCGATzMhn8u67N19F
         1/+lnpfdnsRv7h2KMZEDMF5G1vqSoxO+6eyHOqOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.10 088/120] KVM: SVM: Treat SVM as unsupported when running as an SEV guest
Date:   Mon,  8 Feb 2021 16:01:15 +0100
Message-Id: <20210208145821.904984276@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208145818.395353822@linuxfoundation.org>
References: <20210208145818.395353822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit ccd85d90ce092bdb047a7f6580f3955393833b22 upstream.

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
Message-Id: <20210202212017.2486595-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/svm.c    |    5 +++++
 arch/x86/mm/mem_encrypt.c |    1 +
 2 files changed, 6 insertions(+)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -438,6 +438,11 @@ static int has_svm(void)
 		return 0;
 	}
 
+	if (sev_active()) {
+		pr_info("KVM is unsupported when running as an SEV guest\n");
+		return 0;
+	}
+
 	return 1;
 }
 
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -351,6 +351,7 @@ bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
+EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
 bool noinstr sev_es_active(void)


