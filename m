Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8332F233
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCESLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCESK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:10:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94467C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 10:10:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w9so3829304edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ubmhmztN8a8Hj0poOvVT8YbZJDxjF/QA8WxAgvM4BAo=;
        b=RBhZe6IVRoBkXgOGPTYenj14nkf3DHhFmd27DCVTFkVU37xSXaHheV4A5ZidTnyl+c
         9PmNMmT6d0zHwMt4ZLvLlJSfAB+19qZ7LLzmAJ0DTEq3wkzAgGmmBACA0BEGDuDKGrfL
         gBlrPMb9uw6/odrFxO6QyhTYJnzUlD8Srby/9uvPkn/7w76iFUucWWk4QmTo1ZGXG0cx
         I0Cx687AKLp9i6YdMeerGvdJal7MZCtMNIAuNKknOWPRmZxY3125ZkSBPsN4s8OTVtDn
         BdzbLS7ixDlZBVTvmdlECo54l/cu09xzKUNFFmgfFMpHL/M78+aoczP0vZ88aadDKIPo
         sILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ubmhmztN8a8Hj0poOvVT8YbZJDxjF/QA8WxAgvM4BAo=;
        b=nC1qmA2JQExjG/AWsFyK1rFHhrdJIqDWsr8lPw5PSasbUqlTs35iIZDlQYzig7p8b6
         Uts3Y7HhhUXxfXRS24R6cbO7E5X6utOxdJD82iz+Qrtz4ikgJBZJ8X4tghpYBRK+CLIf
         nVAF/Bv9uJ0J/wC/A10+7nMxVI84SP8TPecy+FEPZZ/BvNwFWFt2i1nSkWtjKsNYecQO
         Us7tUjT8knlfkdP475vfh00TccpebWBNUohNLqYtQ7tK15AKA/SssvKT8RZZ8Sp/4X21
         XK7Dzdb5A67iOrhFkvmeMiw+TrPPxjL8j9bn8zcMqatkHoMvbYTGyKYHOG8F7b9csUJY
         xoaA==
X-Gm-Message-State: AOAM530zb02KTG1kHSFIKXwsQ5uvO0Of29SM2u4lha+8kodL97P4BC3b
        4CSk4Zs40qWUJggfVhij9Gg=
X-Google-Smtp-Source: ABdhPJw/b0DZ2fi/I+8a78lVzCb51tukJxdYHo7pThM7/cl89xGGjztHp5x9jHdnZ2aTdv9RwsXdGA==
X-Received: by 2002:a50:8a90:: with SMTP id j16mr10103042edj.334.1614967854419;
        Fri, 05 Mar 2021 10:10:54 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id br13sm1953440ejb.87.2021.03.05.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:10:54 -0800 (PST)
Date:   Fri, 5 Mar 2021 23:10:44 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH] kvm: x86: use NULL instead of using plain integer as pointer
Message-ID: <20210305181044.GA489219@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warnings removed:
warning: Using plain integer as NULL pointer

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 884e5b3838c7..3e11065038e5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10570,7 +10570,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 			return (void __user *)hva;
 	} else {
 		if (!slot || !slot->npages)
-			return 0;
+			return NULL;
 
 		old_npages = slot->npages;
 		hva = slot->userspace_addr;
-- 
2.25.1

