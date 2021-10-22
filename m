Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE019437B15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhJVQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:49:04 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:36493 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhJVQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:49:01 -0400
Received: by mail-oo1-f42.google.com with SMTP id r1-20020a4a9641000000b002b6b55007bfso1287106ooi.3;
        Fri, 22 Oct 2021 09:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuHQiLwPgttoOSo35Yoz+xfshr3vSEDmXHMRu5gDvdg=;
        b=xk3LwFXLi+XyE5OvJ8zrznfW2w/Kg6HTcWfVVL2p8W31iBR/Z1S2cSQIWPRUKONkgY
         XwLkX1HekocmHUK2KYMDSitttg7+TlD/YavERvPwAaDSRUn/fpnj4X0auSfH9c1HFTpx
         P33xhuWZ8opj5pMoFBzqLnuDDDeTnpEAvBeJ29zri5FrTVQO5/tyrr1uoPuDVcyXxvlw
         19SBl0mMFCOnXwzvPVw3t9bAkkfTNr5nSyGVHZSowUtBQ7TFqxVk0qik5pv40m2meJfK
         ARAvxPEWuhmbwHkLK7aOqwAST1ZXhh3CDni/mbCP3kPBT45d7yCDLzQONHeMharrrQzo
         4y+A==
X-Gm-Message-State: AOAM530z81/PrlQtbgZCXEr5Ky+YHGU+sAxCN8Qvbdw7aetBJVH+xOic
        +cM/brc+/LvVCEDg52rpg81Pl9XA4A==
X-Google-Smtp-Source: ABdhPJwdkqIjz3u70oRhHx+Nlg8ZTF3HYJi7eA/BwU9GXmptBIgeOHch9VMD6eRIBwk+AaFuZE8EbQ==
X-Received: by 2002:a4a:d48c:: with SMTP id o12mr799385oos.55.1634921203721;
        Fri, 22 Oct 2021 09:46:43 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id j15sm1095583otp.27.2021.10.22.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:46:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     x86@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] x86: of: Kill unused early_init_dt_scan_chosen_arch()
Date:   Fri, 22 Oct 2021 11:46:42 -0500
Message-Id: <20211022164642.2815706-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no callers for early_init_dt_scan_chosen_arch(), so remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/x86/kernel/devicetree.c | 5 -----
 include/linux/of_fdt.h       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 3aa1e99df2a9..5cd51f25f446 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -31,11 +31,6 @@ char __initdata cmd_line[COMMAND_LINE_SIZE];
 
 int __initdata of_ioapic;
 
-void __init early_init_dt_scan_chosen_arch(unsigned long node)
-{
-	BUG();
-}
-
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	BUG();
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index cf6a65b94d40..cf48983d3c86 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -65,7 +65,6 @@ extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
-extern void __init early_init_dt_scan_chosen_arch(unsigned long node);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
-- 
2.32.0

