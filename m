Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2F32D99B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhCDSqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhCDSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:46:28 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A708C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:45:48 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x7so5068247plg.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FHJbv/IQitHrDrqVV5Zv3feuTlL4Ima66irM/2+LBrM=;
        b=wRgnh5UtXhuDMEX4WcxzBYAuLiE44UoxjjEiFelNA/MY0cFHVj48pME9fSr35jrMFE
         tSuyPw2CTDTdDIuy2+baTjYoz/wY8tQa6exgABVRCswBJrn+hjSwzUZWXny19wggiVrw
         ivQTLxairGocBLde57e2olP4slyQ5tt92+sSshb63VLs1P9CrtqXtbWWE4wQEonyL86d
         uOhNhNe3NpndX/wFly+2qibRgAe2Q1QOjFOJNAJ6S1weKBl9tZmhscVg489lt3wLn8wB
         IlD2/WxJkMUZ/Nvsb6yivdGf5ni3Beh+AXoUzorwOrU/794T4T4gKoxVoQDad1XkunUz
         wRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FHJbv/IQitHrDrqVV5Zv3feuTlL4Ima66irM/2+LBrM=;
        b=eIQAjXeqMMEcSIAyt9f8VD4j92DERJ3/mdDdY8suIxGDOgkwXNx6fN32VYzVxUmuqg
         IgDUl7e2+kBPp+24PORmRsZDWesCq0oFcjSxS4DevzoYDUpFp/srtwhvPwh/S4L2GE0y
         t4bMKuOM65QxRhaPpUlBzUdCfeqSNlgzTrfg1wn6YBtcoBY3Ce9lLY+WTXAW48r20szt
         /y9q7YjkrLjF3UJOxyy3czcNbkCB5sZio7ekuMSUDP5c2G/JMN4VOKffylDofalBtuL+
         RzqBig5y5q/9jTAHeZLtg4fUBaLsEmw6EkEsEzTebO/SxdoPXGEnkF+n0qGrQPRW+txF
         FstA==
X-Gm-Message-State: AOAM532JmBk7RNPk3FNlecs4y3GT/1PkYac8jqCoOh5eUiZAXjCmgxEU
        49yjgnJG8Qx6DRzX5BPwk/WivCkY25snZv+9xnI=
X-Google-Smtp-Source: ABdhPJwfgFOcLFg9DksNl5+x+5Ik41PWFI2fJWyTU8ahVjM+/AOUwJrkCCQX7ndFdpkYHpBGBfgJrt3sQ6pNyQya1sQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c931:40c9:b7a5:6cc8])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:1b46:: with SMTP id
 nv6mr5948244pjb.45.1614883547630; Thu, 04 Mar 2021 10:45:47 -0800 (PST)
Date:   Thu,  4 Mar 2021 10:45:44 -0800
Message-Id: <20210304184544.2014171-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] KVM: arm64: Disable LTO in hyp
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
linker errors:

  ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
  relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
  [-1048576, 1048575]; references hyp_panic
  >>> defined in vmlinux.o

  ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
  relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
  [-1048576, 1048575]; references hyp_panic
  >>> defined in vmlinux.o

As LTO is not really necessary for the hypervisor code, disable it for
the hyp directory to fix the build.

Link: https://github.com/ClangBuiltLinux/linux/issues/1317
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 687598e41b21..e8116016e6a8 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -11,3 +11,6 @@ subdir-ccflags-y := -I$(incdir)				\
 		    $(DISABLE_STACKLEAK_PLUGIN)
 
 obj-$(CONFIG_KVM) += vhe/ nvhe/ pgtable.o
+
+# Disable LTO for the files in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))

base-commit: f69d02e37a85645aa90d18cacfff36dba370f797
-- 
2.30.1.766.gb4fecdf3b7-goog

