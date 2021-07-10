Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4873C34EB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhGJOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhGJOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 10:53:24 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C365C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 07:50:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so12843562otp.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lbla4VodnreXg6/dXZ6FxtjQ2ib4Axn3SfhOGkpK3dE=;
        b=TbL8L6jCrFrzJuliPGfBgIP2hh0f6nZkAkrCveeK/sgO2Qh50bFG93sKXuKMASFV2r
         DtjcTKnL96GegkQmDWbihMJevUthNsPsKf9dpDD1lAWyc520VDg+i2J0/4gfYtCMSsWR
         Hs2QejuaLZYZS3gxTwAAN4NsCi2YklPvyK2GAl+ie+i5p2fgBHeANxrZ4/y4olmCYbHH
         3cofa13uS54DWpA1i2rAA1eqiZuaNmN+3xhJ9LQAskhsBqOlhABamBEPrb2GJdSP6OKT
         23tVzD4Fgvl0vbzXFi0FNDzE5OuEnAMOd8NqwBVtbL59bcpeyRARg2VKtCtvIo8mzFTq
         +mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Lbla4VodnreXg6/dXZ6FxtjQ2ib4Axn3SfhOGkpK3dE=;
        b=Z7KlvLukPeP07yEwW9s8idEXL+Xw/+919r0oqfgKiC9U9rq+ke4yVH8/uW5chPyBPW
         0tFOQAxj29hvWHiSdGpcHHuI0vmsB6zA545Bx3NX850iR3dc2aRvsUWgt++9W/chzKH6
         YuioSZZwzyx19PhJsms3l4azndrPCRPHXDePxJ3cUT6RK2RumtcGjUTojDjanOrNYKYt
         xSkOH1emyncSOjXs6WS6R0ZgZfSbIuxwJ3Z7L+4fEZPM9YxG38MCBfgKVj1LXkfDCmOR
         c6r5zk8VdaJ3o9IQ4RJVDcP692ZTn1p6oM3EY/fQwjJPP4PnSPJwF5BHQw3R0L842yCi
         zJ9g==
X-Gm-Message-State: AOAM531tb20aaU/nVnNfvJUguR7PGc+pBBuY/LdYvKeb3/LjIKdU22wx
        BtLYwjWffENuG/nxZ8VNOKo=
X-Google-Smtp-Source: ABdhPJyQCFtZ3Zsfh/AJ4TSgYomNTaXy4VMlBBqR8/YMOE68IgvjN1NAGWWbA4MV/JRD/igjn07NBQ==
X-Received: by 2002:a9d:2f0:: with SMTP id 103mr32533721otl.174.1625928637724;
        Sat, 10 Jul 2021 07:50:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n20sm1822663otj.11.2021.07.10.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 07:50:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ARC: Fix CONFIG_STACKDEPOT
Date:   Sat, 10 Jul 2021 07:50:33 -0700
Message-Id: <20210710145033.2804047-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_STACKDEPOT results in the following build error.

arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
stackdepot.c:(.text+0x456): undefined reference to `__irqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x456): undefined reference to `__irqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x476): undefined reference to `__irqentry_text_end'
arc-elf-ld: stackdepot.c:(.text+0x476): undefined reference to `__irqentry_text_end'
arc-elf-ld: stackdepot.c:(.text+0x484): undefined reference to `__softirqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x484): undefined reference to `__softirqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x48c): undefined reference to `__softirqentry_text_end'
arc-elf-ld: stackdepot.c:(.text+0x48c): undefined reference to `__softirqentry_text_end'

Other architectures address this problem by adding IRQENTRY_TEXT and
SOFTIRQENTRY_TEXT to the text segment, so do the same here.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arc/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index e2146a8da195..529ae50f9fe2 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -88,6 +88,8 @@ SECTIONS
 		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 	}
-- 
2.25.1

