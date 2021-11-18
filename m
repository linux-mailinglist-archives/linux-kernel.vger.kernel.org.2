Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB39455CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhKRNso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:48:44 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51676
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231620AbhKRNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:48:43 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD1B23F177
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637243142;
        bh=E5afg8WmlGtk4nlRrcUCYbfcd8G0y9QjJNdLIwaQXOs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RP3cqsX+Nt3vT6wz0IMY0dSwrp6C452vmZz3ehWnisfMVrS1UDGXo11VokBXKPgr3
         j7oZEw3ayUDTpaLrU9gYqaIUl4RVVQ61XKiqot9Ebu+MuO/Y4rb4v6eJ1OJ396M6Nv
         YlHFXpu39r6r0VDzu2skNKl0a7KtVBjJGhQA3YpUt3fuHUJSUpT4il9TaziuQ8hETK
         4ikII13TLsexIaZHXdpRjPFVNPIVgByWgtNM01TwyZ6gcSVUnbugRXWl/dkte/TsLK
         dBHvJKtA4oUpu0czewf2DSv0lyU0FdpDDQjWPDlCvTxdUXe8oCLBbe9e5vamjhYnvX
         TTQvMQE/EU5kA==
Received: by mail-wm1-f71.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so3127915wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 05:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5afg8WmlGtk4nlRrcUCYbfcd8G0y9QjJNdLIwaQXOs=;
        b=cYIKcvvFSH10KVlSifce7ZB5mCdSS6DBCPdqGv9JKjSKl36CVBQBR27eY5PG3fyH1x
         bj9A0j+uPIA6uDYBg3YF/9y5E7+TJbh4hPnm9Q7B6wyHFVWIACCBg6MX2Q4gP2qH/vDN
         DMshrgzsfdER8nBByDUVwJ3ufGkGTOTTtOhZJzqCdYEB7FybkNBDmUOzRtey/Rs7cc8S
         VGpjfm3NX9+Mg6DbOKoY2zEJEnt4Pg5aUw2lJD+t2QPyE/HFgtiQXlyz6Ntf30cqgTea
         gJ5clh7TM/gJ9gEK/pCYKm9pLCcFgee6swiI0xWhJXTb8XzCVcnIhZs7LiqV7jHMFWqB
         5Y+A==
X-Gm-Message-State: AOAM530yjtscNvjcU+eg+lsHA16G3i6FfvKGA2bXGVd50W2kMUFK+GOE
        +HiOwNFdUNT5KVfe5OxEsQQGZog/ACqpe1qT+r6+k6/j7AwgxcIMUC5E711cBQVuESgvYjptcz9
        MpYR+aXu0UILODKn1mvAKwtbi03x8M2pe+c6cSyaa6Q==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr31013729wri.382.1637243142156;
        Thu, 18 Nov 2021 05:45:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrUjKxkyIXJibXWfGPfPjjB4sv+qvr6o+Qli9e3LePqiDavDp4jzO0IjGcGoUVGkj+CxhYIw==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr31013696wri.382.1637243141978;
        Thu, 18 Nov 2021 05:45:41 -0800 (PST)
Received: from alex.. (11.169.185.81.rev.sfr.net. [81.185.169.11])
        by smtp.gmail.com with ESMTPSA id t8sm3087064wrv.30.2021.11.18.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:45:41 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH] riscv: Make vmalloc/vmemmap end equal to the start of the next region
Date:   Thu, 18 Nov 2021 14:45:39 +0100
Message-Id: <20211118134539.137212-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to define VMALLOC_END equal to the start of the next region
*minus one* which is inconsistent with the use of this define in the
core code (for example, see the definitions of VMALLOC_TOTAL and
is_vmalloc_addr).

And then make the definition of VMEMMAP_END consistent with VMALLOC_END
and all other regions actually.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/include/asm/pgtable.h | 4 ++--
 arch/riscv/mm/fault.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d34f3a7a9701..5155048274c2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -25,7 +25,7 @@
 #endif
 
 #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_END      PAGE_OFFSET
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
 
 #define BPF_JIT_REGION_SIZE	(SZ_128M)
@@ -53,7 +53,7 @@
 #define VMEMMAP_SHIFT \
 	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
-#define VMEMMAP_END	(VMALLOC_START - 1)
+#define VMEMMAP_END	VMALLOC_START
 #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
 
 /*
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index aa08dd2f8fae..41ae0aa8f2b8 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -235,7 +235,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
-	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END))) {
+	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
 		vmalloc_fault(regs, code, addr);
 		return;
 	}
-- 
2.32.0

