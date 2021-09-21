Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E153413D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhIUWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhIUWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:24:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D19C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:22:41 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bk33-20020a05620a1a2100b00432fff50d40so4019768qkb.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=SaTJOdYvXhQ8G/3tAOF5ENdnH5rnLN1tbst38ysy7nQ=;
        b=Itjz4JdPW3Xd6IJyxU+IgSdqBKiKWfONk5ZYvUFx1Qp7H03KTwkiFwOIHlfFvMXymt
         YwweDiNKHXnGRYXCFukOUTERGOQ/qEruVBMYQRHI7PdZqNHSw8roU14gT9Kor+4fUTT4
         TTZKHbsC3Qkywfp5SCnj6IAQonOjcdNizsj/2lnJCojdfgzHIZe5Squv9OS4bmW1W+A7
         ADEEyakQ4kMkMzhUJM+WDyEfP8Kmp6FAQWbK9AmNVrkP5//1yJS+vUOZz2gsLOeT5nFJ
         0uqiBfx8llKig/ymLOcBXfsc23k8km433C5Chi4dZ6WXvU1abTWhpdJAHraPS0n/IdU/
         ygWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=SaTJOdYvXhQ8G/3tAOF5ENdnH5rnLN1tbst38ysy7nQ=;
        b=AtMk/L9H+rjvGlQ24+1Al4B1cuVwIGVlrdViq2TknHGn4kxT/VupGS0HAaoA6XBOOa
         VRyB3RdIqQmFgwpd8dK7moeWoNZoVLA7PpxTawJvfmedXz5NqtjJ0x+g/Alhi3eRWbT8
         7fIMCNnh2JeEtqSKaKmHAGgjeZeAwLBAqq5Z4eInG15QOY2BBtnIN/zc66hrpxrPBhvD
         x2t9GirTNpDfV5zBW7IaTwbDOkctYQCIU555Zlc9JDyhRNHLQG7DIJHvvQxMdvfYDSta
         PQU9jR6g38iymbTCcZVQR+QJICsOnTfpBoCjHxfC91UCN23MZBEq0PGhRwlDyDzEXmow
         L7Lg==
X-Gm-Message-State: AOAM531377+0xZE8Nj9PPbwqcCWgltaRPamWN8tuZsUL3gyj5EsPCDGv
        AYhfsu+yNNAPh8+WoC4e9FobJMwVzKQ=
X-Google-Smtp-Source: ABdhPJyo44HrE4gOW7Ep84hk/WccjZLkWsXMwCnXGAAXHM3jyvouSWGzVSAWQqO9FfsVmAnvX6n2wTzz5ww=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a05:6902:124f:: with SMTP id
 t15mr42649007ybu.161.1632262960332; Tue, 21 Sep 2021 15:22:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 15:22:30 -0700
In-Reply-To: <20210921222231.518092-1-seanjc@google.com>
Message-Id: <20210921222231.518092-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210921222231.518092-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 1/2] KVM: arm64: Unconditionally include generic KVM's Kconfig
From:   Sean Christopherson <seanjc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally "source" the generic KVM Kconfig instead of wrapping it
with KVM=y.  A future patch will select HAVE_KVM so that referencing
HAVE_KVM in common kernel code doesn't break, and because KVM=y and
HAVE_KVM=n is weird.  Source the generic KVM Kconfig unconditionally so
that HAVE_KVM and KVM don't end up with a circular dependency.

Note, all but one of generic KVM's "configs" are of the HAVE_XYZ nature,
and the one outlier correctly takes a dependency on CONFIG_KVM, i.e. the
generic Kconfig is intended to be included unconditionally.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/Kconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a4eba0908bfa..c50f75cf76fe 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -4,6 +4,7 @@
 #
 
 source "virt/lib/Kconfig"
+source "virt/kvm/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -42,10 +43,4 @@ menuconfig KVM
 
 	  If unsure, say N.
 
-if KVM
-
-source "virt/kvm/Kconfig"
-
-endif # KVM
-
 endif # VIRTUALIZATION
-- 
2.33.0.464.g1972c5931b-goog

