Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7B36773A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhDVCMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhDVCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19269C061346
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so18237855ybp.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=9FTkqe36BRI/gipCYRepnZSpLm1Jj8+DXD4OAejjwDk=;
        b=tdxpEit4hTqZAjq5Uan7G+ZYbUeY8vleV7S9D2L82o0kqTm6weZ4AScDOZBS5fUsX7
         JAOT/zpBZjmIV6mzN18RQNjdo/vVSaVzqQVn6WmkwoiFHVtPxzVRM6J5zRb7263SaoXJ
         LqMvRrK4DI7UIVZQoPjpcqTBJq+77NFStU04xT3TNg/QcFa5L0zww7BRNpajztD0z/Pp
         Ov+dbCiKHg6BYdpC72RYwjmApHXfwkDFhc5hS2LkMqDb7GSFUVHpCa7xXyt8ickY6xc4
         q5y7TXuOg8SaMCUrSVKaS0jhEzWRFsz1tYTH7pk5ArOjbFV6tDSj5ir2ZF8+PoMeSG6V
         HSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=9FTkqe36BRI/gipCYRepnZSpLm1Jj8+DXD4OAejjwDk=;
        b=IzDa3l4EFV32lfdcssOt7/NLVyLaw7o3YUdt52P1jFld4Fon0i3eFC5uBF7r7ti3bE
         tU/Yr9Mw2YTAX0bbCeU3LZxKRhtG7Qe/gTBtjoyidKboVX0Qy4Uh1j0YTV7e4gBDEl/m
         AdsTy+8qHw8VNfygsrZrkoW7PnmNau4qNYVcVNEHPnNjo7gcORs0rwKNAgFx/9Q5eTFW
         EbxCPsysmA6ubacR1RfbjAnjUpwxIr6eohwp5qpphczWbIftfP8QQmb0R5c16m+7dlle
         zOv0WdJWMPux7MIzGGtQHlz7deh0KGz5WGEA64yJJudKOfuIREM0+D6zY0wgbLRLyaaP
         cmCA==
X-Gm-Message-State: AOAM533CnkuIen//sU2C/FFgiFJz6LEOJUJaHtRQy0/vQB9Q7d380Hpv
        +dg3T+mVyBUEZSCx7dUjYJ7VpqHoaCc=
X-Google-Smtp-Source: ABdhPJymK9oWkzr6AMQs+TKPEE8KeRfEhEYo3VfkZ+3meOKRYTJVn6Nr5G1dVUnbbIk6dGl60Dv1Hx7tAW8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:d4d2:: with SMTP id m201mr1276145ybf.301.1619057512219;
 Wed, 21 Apr 2021 19:11:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:21 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 11/15] KVM: SVM: Explicitly check max SEV ASID during sev_hardware_setup()
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

Query max_sev_asid directly after setting it instead of bouncing through
its wrapper, svm_sev_enabled().  Using the wrapper is unnecessary
obfuscation.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bd26e564549c..8efbd23f771b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1799,8 +1799,7 @@ void __init sev_hardware_setup(void)
 
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
-
-	if (!svm_sev_enabled())
+	if (!max_sev_asid)
 		goto out;
 
 	/* Minimum ASID value that should be used for SEV guest */
-- 
2.31.1.498.g6c1eba8ee3d-goog

