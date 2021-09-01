Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE52B3FE4A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbhIAVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbhIAVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:15:27 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:14:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso890153qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Isvx4DjIyZ95UhyLPtghW+KyLIgzd4+t6VBStaNZel4=;
        b=qyxdd1Im2YrMFUu2970w/b6BrYgp0K2RtFaSPBbFajB/Z4ILFmH5RtNIhZahtm5Owk
         aezBt9A1JRyOWIRSYlCyfnap0LuVFZ7p20vC3ErhfaylqfBt3hKgkpE6HkPGooQtsfS2
         DI8qbreTIGfFkQ04tVXq7jD6kr9SV0BoxM5RCoRCzxeNpi21SrJ2DUoVDXg/xrRkEeJ0
         bXprxLBdvjeVfEFi6WQvG3MoEvTutHilR+thPeWgioFEqV+DY0IcuYzJuK95PjuHGUAR
         CyVYsF8IsaDRkVxuM2uo4sczHkZ4yguHAb1PkC10Tdr6G6RJxMBQY+tGevXPPcPsVhK5
         OlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Isvx4DjIyZ95UhyLPtghW+KyLIgzd4+t6VBStaNZel4=;
        b=WDzxj9Em8Cf78MHS/vnn1P0pgvuUJawNP7YMPJu5hpcAnsW+WkGXsaZ+CqjcJe50kK
         IUwmJlIUN6Hn9y2WPo7ycbhwxA5A9DXruGRrVlSzBgLO9RdhX4T05dhPAXxOnVnkxSyS
         DPzdKtIPYxK2QghRohF5GmpfHqi3xIxXCIsV8pWAlWD5EmxYJfnfmw+RI9aE8Vxc9oIk
         qQP8FAgC+m193fOD9aTeusnAMPMsPFcTBGeBsjwVKFy3Ww1gHDgNewnS2T4sx6J2njDx
         koUlFT9IHHTrupECK097ALQe1VaEjs2imHQbyKqaZR/VBICeQBvS1qx+1jNOp684jepO
         MiBg==
X-Gm-Message-State: AOAM531sqFCcUkA1OB30Jf30LN/aSbG50PcF624FX0mwMex6deT/gMTv
        pJYmvTR6KdwYg22o7BvZT4yR4rSqVCKR
X-Google-Smtp-Source: ABdhPJwlth2Eo5IAldYMKFCB7G6X17abdCy5ScWqLZRgKQwhrRMlUTBR9716k8Lrh7gJV88fgE5xC5aFUA+J
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a0c:9c4d:: with SMTP id
 w13mr1802546qve.43.1630530867766; Wed, 01 Sep 2021 14:14:27 -0700 (PDT)
Date:   Wed,  1 Sep 2021 21:14:03 +0000
In-Reply-To: <20210901211412.4171835-1-rananta@google.com>
Message-Id: <20210901211412.4171835-4-rananta@google.com>
Mime-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 03/12] KVM: arm64: selftests: Add support for cpu_relax
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the guest helper routine, cpu_relax(), to yield
the processor to other tasks.

The function was derived from
arch/arm64/include/asm/vdso/processor.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/include/aarch64/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 082cc97ad8d3..78df059dc974 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -191,6 +191,11 @@ asm(
 	val;								  \
 })
 
+static inline void cpu_relax(void)
+{
+	asm volatile("yield" ::: "memory");
+}
+
 #define isb()		asm volatile("isb" : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
-- 
2.33.0.153.gba50c8fa24-goog

