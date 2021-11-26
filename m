Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C942645F56F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbhKZTwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbhKZTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:50:02 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA758C0613F4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:31:22 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso15312849ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wv3BLho2y9EtK0wC9Saxjj7vsHzwleZn1+op7zj3BY=;
        b=YmZLYl4ZN+yyneLk+PL9l5sy1QMXJK3rtr4xmEguYxpFd5X4Bb8GaAeO/nGt2gdq65
         9uRFRh7BpLy7rSzZdhFzJdSRdHw1X0hOcrV/OCpAifKju7FT3PlG1EgjbJvtaBhp4/ot
         PZGLAXhd+7DVbyrBpA86VYpRC4SwU6c2w+gfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wv3BLho2y9EtK0wC9Saxjj7vsHzwleZn1+op7zj3BY=;
        b=bE8NcSB4YgG6DUs0BOHhD9Q2KUERW+qCS43cgMXIINtv2wwwRbTVJmiVeV0gZnPEaq
         YIgfSLXaUw+ll5nqeZZG0xmAttpfE2NttsQQux6mdIUmCPNDlTkVpx22BoT+Jl8gNzvc
         d8XqgXiOWxaGiSFW0vTOeiK/OyR/gid6fTPbgV4lK0EKO/u1vmBwCFPegctZmtLI36OY
         nNPy4xhQWIMfBTSIXcPdY3hCLEFT9+jHPTQJbj1Db7AkvOrDRtEteSsXMjcI+ygV2JgA
         HlYKhvFWg6iCFWKP5C58JoB93APEOjAuh+6za+Qu/tsvgtNpM6OxVlkZQgwyy/mDfJ0o
         Krlw==
X-Gm-Message-State: AOAM531pe2+SaWEjgJhI7B3I1zUtOjPkrVMdeAS4vcGm9Jv/lMyNCwmT
        HufR5rS1DBNcrpu5pT0nkW7uWxOJH2XMwJA=
X-Google-Smtp-Source: ABdhPJzr9FQVd//p1Zquq46d7N7KNXi9mBpDiHY+TqCDu3EFaH1k8Fip7XgsOH53/7uWyRVm1FbJig==
X-Received: by 2002:a9d:7d04:: with SMTP id v4mr30740597otn.180.1637955082042;
        Fri, 26 Nov 2021 11:31:22 -0800 (PST)
Received: from fedora.. (99-13-229-45.lightspeed.snjsca.sbcglobal.net. [99.13.229.45])
        by smtp.gmail.com with ESMTPSA id w22sm1110562ooc.47.2021.11.26.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 11:31:21 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@atishpatra.org>, anup.patel@wdc.com,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] MAINTAINERS: Update Atish's email address
Date:   Fri, 26 Nov 2021 11:31:11 -0800
Message-Id: <20211126193111.559874-1-atishp@atishpatra.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am no longer employed by western digital. Update my email address to
personal one and add entries to .mailmap as well.

Signed-off-by: Atish Patra <atishp@atishpatra.org>
---
 .mailmap    | 3 +++
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 14314e3c5d5e..5878de9783e4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -50,6 +50,9 @@ Archit Taneja <archit@ti.com>
 Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
 Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
+Atish Patra <atish.patra@wdc.com>
+Atish Patra <atishp@atishpatra.org>
+Atish Patra <atishp@rivosinc.com>
 Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..b22af4edcd08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10434,7 +10434,7 @@ F:	arch/powerpc/kvm/
 
 KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
 M:	Anup Patel <anup.patel@wdc.com>
-R:	Atish Patra <atish.patra@wdc.com>
+R:	Atish Patra <atishp@atishpatra.org>
 L:	kvm@vger.kernel.org
 L:	kvm-riscv@lists.infradead.org
 L:	linux-riscv@lists.infradead.org
-- 
2.33.1

