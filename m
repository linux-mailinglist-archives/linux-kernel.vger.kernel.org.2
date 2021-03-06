Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0862132F7A5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCFB7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCFB7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:59:20 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A0C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:59:19 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o7so3262936qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=y0THIMpkur6+/Bj9ZSP2+9NkkxbkY6p2tIHGIaTzjYc=;
        b=RR2ofdzqdDJEfpTGPYWFAR7FmrxgkujmTTyYhg52C+RbNDiSQzJ9/Oeb3G9OGauPfz
         N4kGHVOi3Bqz/6k7gjCL0LaoFw+APfHFKLdiuEnWWjADJb36zLj9VId0gTDMOiL4fXVl
         6Ghu7Ij4ubMWSj/FlDEjAICmgKVn19fIxE2cJ+OTIgUPiUDTx9Q10ybvgKxzKVZHTP2p
         VGTY51Aqv9c57vA3IP0HxZOAFzw7FT/FsjRubwbpyh/Xe5C/nl+K47BncBiyqSIWFfnF
         57ByUAWrmTAp+uQ8G24U91WjUK+3aKgKGQGLaFX+atulVwAZXqla6Yb99NZgZj2td2kp
         Kuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=y0THIMpkur6+/Bj9ZSP2+9NkkxbkY6p2tIHGIaTzjYc=;
        b=s5Ay+5TRgVYglx/iY2Rgba9dNDEz70PI0orVtY3XXgn9Aq/l7xoYSbByQgkZpKirlJ
         qvcZXMft7Qd4LXWy9wGeulAFrtngoOSxvsv5EE5P4XO8+eEGWY1XhkKwSE7qh6tIQc5j
         KXo+Stbmr2eoCUiJpDwD6f1E6U5o+zxLgdGgA74QQGFM080cSpY4JXZtdkAWzHZ8EeD9
         c7UmtlnbnA2izWHhvj0kN+O5A2Jd/dobxF+jPgpyM+lGK4V6THknhGPwWrnaXkCVh2ER
         edb6zG147EIaCdPzVi7klLjCmK0aydRbin9rdL2usTvhxai+qYZXtlmRU6YyzQxUjXrl
         kucQ==
X-Gm-Message-State: AOAM532iTVlG22/J2HNjKJzXzMYcLXqnDWL/xKvXMs90Ik7rUYl1EJY3
        Yg5J+2vb4g+AdqO3H/bYfwUlFLPOM/U=
X-Google-Smtp-Source: ABdhPJy/04xIWQKM5doZWovlhW61e9m2oWCL5ySlbjt0CJz1yHoHULQZJBmHs8UshbQDP6IXBQNDFKyyYJE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:fc04:f9df:1efb:bf0c])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr11880770qvb.5.1614995959126; Fri, 05 Mar 2021 17:59:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Mar 2021 17:58:52 -0800
In-Reply-To: <20210306015905.186698-1-seanjc@google.com>
Message-Id: <20210306015905.186698-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210306015905.186698-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 01/14] KVM: SVM: Zero out the VMCB array used to track SEV
 ASID association
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
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero out the array of VMCB pointers so that pre_sev_run() won't see
garbage when querying the array to detect when an SEV ASID is being
associated with a new VMCB.  In practice, reading random values is all
but guaranteed to be benign as a false negative (which is extremely
unlikely on its own) can only happen on CPU0 on the first VMRUN and would
only cause KVM to skip the ASID flush.  For anything bad to happen, a
previous instance of KVM would have to exit without flushing the ASID,
_and_ KVM would have to not flush the ASID at any time while building the
new SEV guest.

Cc: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Fixes: 70cd94e60c73 ("KVM: SVM: VMRUN should use associated ASID when SEV is enabled")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c636021b066b..01ce8ac77a07 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -568,9 +568,8 @@ static int svm_cpu_init(int cpu)
 	clear_page(page_address(sd->save_area));
 
 	if (svm_sev_enabled()) {
-		sd->sev_vmcbs = kmalloc_array(max_sev_asid + 1,
-					      sizeof(void *),
-					      GFP_KERNEL);
+		sd->sev_vmcbs = kcalloc(max_sev_asid + 1, sizeof(void *),
+					GFP_KERNEL);
 		if (!sd->sev_vmcbs)
 			goto free_save_area;
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

