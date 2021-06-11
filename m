Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9674D3A4845
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFKSFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhFKSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E96C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a11so6959484wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Z9xbKcjNBzLb1KfYDQdBtJ51TDjtc3qg1B8l/KPwIM=;
        b=DG7Ze6VRkwe58W0gef/yy7gFihNFgKh1j1wRxvmcicJ+YBNMe/Ofyog1k99MT52Sf/
         4ubSmrHcuBAY65u/DVgsXT9U/KyuinD+/5b6GL7YIu10/wEOi6YMkoGXD8603w/mH74V
         Zf3JEZLzgHrbAYJAJRNtwq7tPtgUgP1/D2LtMQEfBo6XaALJv/8uDrL2OqiQ5gFTizkT
         a9COb9emAiovNJsGVR/zHN3TPihN73Cv7zTUyfEDAplcFAuSYkFcDUqX0/QhFtybzJLF
         khhsTxEHcHRvBtzi/Mme3DLtjWELOLNQcHN7ceH1hQqZALNuRSzbq0OxpVkPD2qdGMl5
         m0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Z9xbKcjNBzLb1KfYDQdBtJ51TDjtc3qg1B8l/KPwIM=;
        b=BzW3mz3QVhznAY49z9yqQ3renrFhWnIflY00Ea23AnGOiUtfVgvOS4qXqHoxV6ZJBq
         TKaikeNBhYgvvjxhQ/+7lW4UuRzlkqrO5LwyngndZcARxS5Mj5mUSkQpkVVXpVocUxVz
         MKs94JdP9A4iaOdjGy8y1SRqhy71w6Nh0hS0aw4TLki/XHyWFtJ35hiyjrphuLUuIHcX
         x5fjWl0+K9bOtz+Ac4Isc0ZIwr04yNEi18JqBt3Xs/I5MZmfmuwHnbK/87x6du63T5ki
         8jzInLxClDnB2ZjyVZd8NA2jioAUr76wjl4s9jrNSWk69WQCtw4XssUxTXH/t8w2/L49
         F+2Q==
X-Gm-Message-State: AOAM530MiBccvKRE0u0opWyFklTUydGikos9hH7/Wq4ht8DMTOMDE4dT
        cyVGJ6UhsbJlE+0trfl9vBD1gL8oQk7BdAzK
X-Google-Smtp-Source: ABdhPJwu5aadOsN5SbfJ4OMyCi5BzSusvtpfrgzi2098V2sbhwfinksn/GZk2lbCb5A1NQ5iwglNHQ==
X-Received: by 2002:a5d:452e:: with SMTP id j14mr431026wra.117.1623434572191;
        Fri, 11 Jun 2021 11:02:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 03/23] arm/elf: Remove needless ifdef CONFIG_MMU
Date:   Fri, 11 Jun 2021 19:02:22 +0100
Message-Id: <20210611180242.711399-4-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_VDSO depends on MMU, after removing ARCH_HAS_SETUP_ADDITIONAL_PAGES
definition, the guards are excessive.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/include/asm/elf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index a7cd90b3a779..47347d7412ec 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -137,7 +137,6 @@ extern int arm_elf_read_implies_exec(int);
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
-#ifdef CONFIG_MMU
 #ifdef CONFIG_VDSO
 #define ARCH_DLINFO						\
 do {								\
@@ -145,6 +144,5 @@ do {								\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
 #endif
-#endif
 
 #endif
-- 
2.31.1

