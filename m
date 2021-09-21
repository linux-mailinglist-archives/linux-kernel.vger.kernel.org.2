Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7314413D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhIUWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhIUWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:24:12 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:22:43 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e8-20020a0cf348000000b0037a350958f2so6767799qvm.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fe6asXWFzX1XFZzq1x4wsBW8hMTSeHYjNsqHVsCHq7g=;
        b=eV+o7MHP7TJ1wHQqCm2Wyy5n+IVG3LKtSt+UgnoNnssmXw3fD0cefPXnelgq+GjVjr
         9g2hKWvcT6KUhIKypS3wC+X2NLUqbxUgLQR19KNtifP2rjqKyR6MXfYtUCH5/7QswDxf
         FOyLvSgu1SgP/xkZYIUffAaQ7zeFu85jIXz8vchCoJu5QIuscL4HPLnEqgX34hHtDWMA
         xrTIHe/h9QmhXMbrbQkNoklcocbevjzN6q0aDxhtulnOO9ApjUqn+pRM44+YdHHEb1ee
         2L4nQWKAeliciloIFeM553LJHMQvjZTnA/Q+IJHnh5eAVzCDELMxtKFLAZLw7x5OUTOp
         u/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fe6asXWFzX1XFZzq1x4wsBW8hMTSeHYjNsqHVsCHq7g=;
        b=MCQccAtg+eaOKIl3xKn4LWGjEOcO/SPHdWy82R6gh+OHeOiJYDPKKd1np1hTds4N/0
         xQU1C49i9/be4LZJ9AckmeMPbowhbPhh2y1xMZ8ts1ukRzCYKCAqsujaHWyNK2pxOvBc
         u0HJmf/eTYDilbEGSJ9IwCsVTxjDE0HYVKX3WbXOUYU8ZHjt/4jUNRHspGrH5XYvyyl9
         6UuRS6MBsQA+whHO+mpPx7Rb33dEZgHpga8z4VH57waBxT2Qv6inPXa2FCuZqP7D33iy
         w3bV+44rh02N3a9RDtRwzMRUqSNFpGuqB2CTj9crbbNRhydOX5YhXdEs+snZ1NOJrpnZ
         8nyg==
X-Gm-Message-State: AOAM5317N3GvNpb3dgjDFqDVUOkSIH39RvomQjwNtVfC/N46Vn+PQ0ss
        5PobzgbPVGqvignyd6rblhNKenzBciw=
X-Google-Smtp-Source: ABdhPJx8/aQldYVlTK2IJCFfsX+ImwbCtnIVcIzBZCgyIrvMxEU+TrcEbmTAAYdj+46Ml9lwoGi29S9f6xs=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a25:ad25:: with SMTP id y37mr40583994ybi.407.1632262962301;
 Tue, 21 Sep 2021 15:22:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 15:22:31 -0700
In-Reply-To: <20210921222231.518092-1-seanjc@google.com>
Message-Id: <20210921222231.518092-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210921222231.518092-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 2/2] KVM: arm64: Depend on HAVE_KVM => OF instead of directly
 on OF
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

Select HAVE_KVM if the KVM dependency is met (OF / Open Firmware), and
make KVM depend on HAVE_KVM instead of directly on OF.  This fixes the
oddity where arm64 configs can end up with KVM=y and HAVE_KVM=n, and will
hopefully prevent breakage if there are future users of HAVE_KVM.

Note, arm64 unconditionally selects OF, and has always done so (see
commit 8c2c3df31e3b ("arm64: Build infrastructure").  Keep the somewhat
pointless HAVE_KVM dependency on OF to document that KVM requires Open
Firmware support.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/Kconfig     | 1 +
 arch/arm64/kvm/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5b13a932561..38c0f36a5ed4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -187,6 +187,7 @@ config ARM64
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KVM if OF
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index c50f75cf76fe..e1e400bd8de5 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -20,7 +20,7 @@ if VIRTUALIZATION
 
 menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
-	depends on OF
+	depends on HAVE_KVM
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
-- 
2.33.0.464.g1972c5931b-goog

