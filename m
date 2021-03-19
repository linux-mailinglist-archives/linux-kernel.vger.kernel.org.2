Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18334194B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCSKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCSKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 130so33596253qkm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
        b=mxpQrZ8gNL/t8iySLxtG3kNdKlZSs0r0Mt6WLEJ+xYt02Sibhx2GhBYgVmtffTsidV
         JMdP9JdMDQvQn8+P4mVyA3o13U8KZbMz1nkqS+pCDmdzWF4u4/9ktQT+iEYs87nNGRls
         C/nYwV3ipvNG6nAKct925qTm/Y23zArUpvX8B3xQnnXBOTiVsx+0F/XZxatVGtzSGzCP
         yj84Uv06GMNVkldApWkew2knEXWSn68Hr7Sm4QQnevZPzERlCj0IJ2Zi8KiUi6rBlRsk
         ylcl/Ea5Z6tGxsVJI1nTKWoUNA7YEZ8o4MQawN9jDuAZJHlvglRxfhEvADdRt+TjzDvq
         1o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
        b=tJiUMM6yxtBDkyCsthnyXkyNsOd6olpWV9nQTEESdCPu+bl+FGbOX5gyMf0LXSGfRh
         bgf/cW/klf4PTD5b1jLbUufAGoO03YBhnNIPV9hDh6MGd8tFkFDnXPZJtvmQ60ZOWSRl
         PidbxzuAnxYhqQ6NeFOMbInecYKMZONSPiJggiQ3Kb0vOuHunGvRZR4/6RAHq2mL2+vJ
         8VAaSx+AJ0gNb/l5jU032ue2wSZjUhg+dndnjsOD1cekWOjLOAsz5/1hj0vR88j/WL74
         pzHoDKyecmi9eAp4RD+XoXwT6DhmqGBUm44Sf4UQXtCtBsDBoHTswr8/kFBTdRCVTCo9
         GGQA==
X-Gm-Message-State: AOAM530uIXQGoVXZRVx6nmBPcIOpKZuMrh8l3tyN8DWGjeYGj4pSc9tx
        6tZfbz5wV7YC92dQPZCWCMQ5nRWR20Cn
X-Google-Smtp-Source: ABdhPJxdeOyw7F8LEDXqPaxD4/XKhLFDVdrSX3/+Wq2Z6NaQDQAjwvxv64KJelAZOfkMtqhUmxag8EYto+fC
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:88:: with SMTP id
 n8mr8623708qvr.22.1616148129286; Fri, 19 Mar 2021 03:02:09 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:17 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-10-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 09/38] KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow the usage of code shared by the host and the hyp in
static inline library functions, allow the usage of kvm_nvhe_sym() at
EL2 by defaulting to the raw symbol name.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 78cd77990c9c..b4b3076a76fb 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -10,11 +10,15 @@
 #define __HYP_CONCAT(a, b)	a ## b
 #define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
  */
 #define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+#else
+#define kvm_nvhe_sym(sym)	sym
+#endif
 
 #ifdef LINKER_SCRIPT
 
-- 
2.31.0.rc2.261.g7f71774620-goog

