Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF132F7A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCFB7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCFB7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:59:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AFC061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:59:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 131so4599102ybp.16
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GYKlgQQb+tgxYyD6lWu46KFZO1gmh9XQODRE3jBWgGI=;
        b=PVxOjQAnAOyeuHVNTR7gC9ojxFYfgpZB7UJvC6WtTb9nkQPYxN5hpQICQUmLcpFWot
         YkGCGT8d6pGB24pFYonzrQ0xQhe25U6Oje4gbSUGVJIM48O3nmvCrJGm6Ngj4L7ovY61
         R3eifXN5npvoTjRPqixNwpSC527yQVSaabnAxuJrOyEoFjJgYRXdYxH6alXOEpda39/j
         CXtswgLdGIZfj5T421PzaJs7nMsjBHpoIoqAEcNIsuPdKmG85+YESGSgFg6AB+OVN09y
         4sMQa0hZ1xkRdZmlUmBAcZoDQXXNuXXcKb4myYRVpLslKX7FUWm2W7bNlXt1+f6p36WR
         edSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GYKlgQQb+tgxYyD6lWu46KFZO1gmh9XQODRE3jBWgGI=;
        b=i5yMlulFZ5YkkDPvAFJQ5iUOaF+16vxi45SV62tGTUjRVj0+oYRn/E3sdPe5HhO2TO
         R9rp5lHMfe7/9Qi//AOiBtR5VKvJZWPEFoiS/Ev9gVmV7q2xHu5ASPLOGpBwtnKGJEg+
         p6hiazgAMk0VPWnx4aZov1Xao/wOp4vw+H9vtB6cE/YqN7Rq2FUGKjxNQekGZk4nhr5Q
         FzFocGHIbvi25QAUSf+godQUNcB4lsMddgLF/r/M+Ks6bz/aYzAuwOhg3RZM0CnJOwdK
         tSf4LZ9P2643eHzfXNUjB+ld7I/tTGtLDOTLgCh7gdAQdmU/WHAfyxn20HJM9H6YgLnF
         YG/Q==
X-Gm-Message-State: AOAM533Z/qAHOw7crz49RQV/8b73kaj496Pl1puzN3u5xs8E0nOpgQCT
        BeYoyk0INoxk81ZvS/VLbaHKCgHFIQQ=
X-Google-Smtp-Source: ABdhPJw2mHHXiYmpH6YFA4t+9E7EC5CURGdf/90XCBO4sHBL9KjhQJMsD9SGIbB8ckqFeVS7N4tA6MDEQcY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:fc04:f9df:1efb:bf0c])
 (user=seanjc job=sendgmr) by 2002:a5b:847:: with SMTP id v7mr17865054ybq.354.1614995961684;
 Fri, 05 Mar 2021 17:59:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Mar 2021 17:58:53 -0800
In-Reply-To: <20210306015905.186698-1-seanjc@google.com>
Message-Id: <20210306015905.186698-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210306015905.186698-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 02/14] KVM: SVM: Free sev_asid_bitmap during init if SEV
 setup fails
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

Free sev_asid_bitmap if the reclaim bitmap allocation fails, othwerise
KVM will unnecessarily keep the bitmap when SEV is not fully enabled.

Freeing the page is also necessary to avoid introducing a bug when a
future patch eliminates svm_sev_enabled() in favor of using the global
'sev' flag directly.  While sev_hardware_enabled() checks max_sev_asid,
which is true even if KVM setup fails, 'sev' will be true if and only
if KVM setup fully succeeds.

Fixes: 33af3a7ef9e6 ("KVM: SVM: Reduce WBINVD/DF_FLUSH invocations")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 874ea309279f..5533f37ce50e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1349,8 +1349,11 @@ void __init sev_hardware_setup(void)
 		goto out;
 
 	sev_reclaim_asid_bitmap = bitmap_zalloc(max_sev_asid, GFP_KERNEL);
-	if (!sev_reclaim_asid_bitmap)
+	if (!sev_reclaim_asid_bitmap) {
+		bitmap_free(sev_asid_bitmap);
+		sev_asid_bitmap = NULL;
 		goto out;
+	}
 
 	pr_info("SEV supported: %u ASIDs\n", max_sev_asid - min_sev_asid + 1);
 	sev_supported = true;
-- 
2.30.1.766.gb4fecdf3b7-goog

