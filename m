Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CBA3101FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhBEBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhBEA7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:59:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E845C0617AA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:58:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 78so1487221ybn.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xmoOsBXeKXyFHJhpz5rFcXr9QRcBzbbStA2Fiq93tIU=;
        b=wCMPxs0PrpuNr8nfx/4FS1qEX8ZzYAe7KC0Uo6nkACkwu8rj47EqilzFxXE090d0y1
         la8uV57prnbyjLMr6TODEjeCwNOXG9JOh4S69cQYJAYkAfJi0LbQ8gMwijcbP70AS2rd
         D0hKwhwWoEFZNLTp1+H6o/GZ/SmVPmW0D5GGPsv1dfSgCzGcVLYda7FFjxp4qV2e1cwp
         WDrsNp9dAUAcxvmsCq7qU12BXdgH+2HOY2wMITvkwhbJbFgzFdfAEXt0r0uJFq6vPGSz
         fpNf+Svt+/LmDpGgNv3WdJ+Y9t94ogGLFgB6sBSWrQ3Kgfz2Jb+YzB9PKhe8EU7QnDFW
         9Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xmoOsBXeKXyFHJhpz5rFcXr9QRcBzbbStA2Fiq93tIU=;
        b=TCbqnlZP0q32R5pWpprL+fTeMkB11DRzkRGJAl2pi4wk71p3vHZINrmpG3WEWWbIAW
         XqR7CRLpQc3nITzNyWkFKQeWJ/0ugYFq9H5i3OJeOAHRduCzGlw4eyFBLgXijuklWN3X
         enxMNa94xVj3C//ywi6OwI/8gjBoDfQAbZRjJGAzl536KrCcKRWKVwYoRLkvm6dvpnJ7
         AxqmgbWTwhPull//6jBOdUg/YfBcl0jNW9t86kx5AFOTvaI7qBERlQptjD2D3CzxUd0B
         1259E64LNF4Jt42mdhm07GPOn35CueIonJndlffTtJyVgBHvEuX/L5erLedMvb9FMmTb
         DaDQ==
X-Gm-Message-State: AOAM5321Mjx+SxpkzBXhlh8B+RNZwmX4dQ+/ZEztWZ1P8NxI3qMH26Me
        bfYmisW8VKUqis4aeLFaW6c1ObuF0dY=
X-Google-Smtp-Source: ABdhPJx7UxzEEIY1n6OFyRn/JEvWsi7uz9xz7/HlcHEiBzyHXPLNwaVHL6yFNgHyJ8RziyoBtnA0PEZoI2c=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f16f:a28e:552e:abea])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:: with SMTP id
 k6mr2776341ybt.87.1612486681153; Thu, 04 Feb 2021 16:58:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Feb 2021 16:57:43 -0800
In-Reply-To: <20210205005750.3841462-1-seanjc@google.com>
Message-Id: <20210205005750.3841462-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210205005750.3841462-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 2/9] KVM: SVM: Remove an unnecessary forward declaration
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <trivial@kernel.org>
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

Drop a defunct forward declaration of svm_complete_interrupts().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3fac9e77cca3..8c2ed1633350 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -205,8 +205,6 @@ bool svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
 
-static void svm_complete_interrupts(struct vcpu_svm *svm);
-
 static unsigned long iopm_base;
 
 struct kvm_ldttss_desc {
-- 
2.30.0.365.g02bc693789-goog

