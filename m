Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E156C367739
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhDVCMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhDVCMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08384C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v63-20020a252f420000b02904ecfc17c803so6919649ybv.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JHbuQrNkzeI4uiSZh8d5FcAVg1KlkglBUSOXfqeZhfc=;
        b=RnV4nf0LiQL9TsSTqL5iIWZhIEMKV0vCEiMQfxGopn+W1EJau7WDNvSYw531Bjir+5
         kF71VBrI1n5wZyA6QKlLy8+an8OhPh0ds04k0pCehyJ3QpOfjBMyVsut/xrv3FFtJxlC
         JEGfU5FBlBbEsLRzkChZmZbyIR8VFgOC4rlqIw/tIdqi52GvqrG8RbytSab/j19fEXBk
         B+6FmGM0L9/CExENZLIQ0ufNCtBLmouoPpu2S+rn4C9ufdMJOtCNHRR+PNdsIBy9JXDM
         D/CRJ8NO0D70Vo7Nc9bH4JqX6/hTvOERAFq0lIkNj5HvVAg3xB8AEfHoXmhGn5+DPRDU
         6ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JHbuQrNkzeI4uiSZh8d5FcAVg1KlkglBUSOXfqeZhfc=;
        b=meusdxwi9WCfyTMLLVR2q+lDIvr9S66iFBzB3Cq6bgc6UFwher55fz33Oid4vERRXu
         75f9ausvSf1AdgvxJxVgF5rstN05aNbM90xPufzzpA9o/JLxhjMErd3HGdFvgiMdkE/1
         6/qZxwM8FgeQa+O7M7zMEh0upsKFiZMEQYgD8m20EwAfzjMEk1WuSelcLc+SCWvCxZH3
         Fnj/z1+fU+VriyHnY+7nFUT+JLqK3vNbFlWJXeT/pjfwGgY/dh61PX2QZ6c9Bcv61wbK
         oz6pTdaYhU+ZrLg68Z11R20loIXhMxz2mwlvZSfJTy0PLBCITsMNTwBM4WwPPvAKhCC5
         RQjQ==
X-Gm-Message-State: AOAM533Q+aXlkMeeLkML+cUqM5rZftInySLYGbw2NvcR+ctLzd8zXcty
        ozuLBMHeZh/CWAax632eSo4s/6lQZjs=
X-Google-Smtp-Source: ABdhPJw7AZDdGW1eVxKGQQDJ8spbCCOdp1UZp8R/ZFYEgoh+V9CQXsrVtgmY1rjouW2qNG6twxb0bQ12b8g=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:d44d:: with SMTP id m74mr1360567ybf.389.1619057508142;
 Wed, 21 Apr 2021 19:11:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:19 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 09/15] KVM: SVM: Enable SEV/SEV-ES functionality by default
 (when supported)
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

Enable the 'sev' and 'sev_es' module params by default instead of having
them conditioned on CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT.  The extra
Kconfig is pointless as KVM SEV/SEV-ES support is already controlled via
CONFIG_KVM_AMD_SEV, and CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT has the
unfortunate side effect of enabling all the SEV-ES _guest_ code due to
it being dependent on CONFIG_AMD_MEM_ENCRYPT=y.

Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2fe545102d12..bd26e564549c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -30,11 +30,11 @@
 
 #ifdef CONFIG_KVM_AMD_SEV
 /* enable/disable SEV support */
-static bool sev_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+static bool sev_enabled = true;
 module_param_named(sev, sev_enabled, bool, 0444);
 
 /* enable/disable SEV-ES support */
-static bool sev_es_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+static bool sev_es_enabled = true;
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
 #else
 #define sev_enabled false
-- 
2.31.1.498.g6c1eba8ee3d-goog

