Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63532A962
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575200AbhCBSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578855AbhCBP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:03 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76163C061D7D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:27 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a1so5188468qkn.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T621CrLzDVvHMT7g1JI2svAdR9qKxB9zRXJEq9CxOEU=;
        b=JhVB1bpGiYn1jRzMxn5C86Cv84iFwqhC6iR5apn3eWaYAhiRMUSeUiA/loGNHC6UEZ
         WXJ7G+oIo0kRVVksB+BCF8QFW7BhegDukCh8s7n3swxcqA2kN9JLclL0IFaqfGiqGYZw
         wMwnC0Nm6lKe/+9njbqaVCvnF2gW6ls0LuTrHRUJwjGtQbiS/ziLG8McYhBEndabj5u4
         lXqBAEzmTjgHHDB+UnlVBrk5jiudORfTBxu2CTEnE8ITDIwRVAd2UVMEl4YPH6u1i4cw
         18SIyImxlr2wYX1yNBmi2YQPDuGfAGwYpUaQcVzbN2FuvEq9+DGEN/acYO9wm5gY3URn
         WgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T621CrLzDVvHMT7g1JI2svAdR9qKxB9zRXJEq9CxOEU=;
        b=sKJXQc/LM1oT5LVRF2FPfhj6q3kjr+2b69fxRFCTwSD+bgfy9chg1gPs5YWF6d7o7I
         EvNh/pxP2UzSj7qz+ENp5GzJYFV5yYF4erKNcZfaCpTVoywG+iZnQLGXtMYDB1ThFwwB
         s1bd6GBH3n7Edz7Zy6k4SKkLo1CEErVO64x7+jooskHoFwr3PKB509HWUqSdWKA7AUgk
         odFeewTqIJ9e/sxQzBCHDBoIJBH2KU8yteCogTcuZ9JkI4HG0puPEX8kOWDSMuiLYxhh
         DZH0eTJCVfJWsW8hL8uuejHuOL48Kql/fVqknrp+q0xQoKkmbPTjkA3yeDb1rP+cZX97
         LoRA==
X-Gm-Message-State: AOAM532EXnTyDk9Ttx2GOcp3II58RvvJt3FPCX8y6Bqu8cxdCQlQ2HRZ
        6OcuJHEEDckxSdSAfeG+O0TqRu3y9+w4
X-Google-Smtp-Source: ABdhPJz1Cnzac8s5SYaMmUMvh8VTsVMc6vRSeZjJ+2CAkCroHCAupXgtoMWTtWwTuJftkM7mvaKD3quAWmDb
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:b7a7:: with SMTP id
 l39mr3898578qve.56.1614697226584; Tue, 02 Mar 2021 07:00:26 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:39 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-10-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 09/32] KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
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
2.30.1.766.gb4fecdf3b7-goog

