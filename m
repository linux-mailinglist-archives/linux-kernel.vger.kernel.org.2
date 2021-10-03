Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ABD42016B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJCMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhJCMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:13:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B66C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 05:11:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b8so18847871edk.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+KoS1PIk4Hjw1f3/vpoXHDDfc1MtDGrhUPwAgZC71pI=;
        b=A+DFnt0e89m6bMBafkXai1T0kadk234pwyZkGN5zx5/CWtKl86H6EDnUAVvatazt/h
         Ywg198cng2o0h5z/bkURAw07DrqnYxbmsEURNursIZy9/D+R6vN5mCNWywX2bT1QWve5
         DsSYdifU1gntnhZS5Fdb/oLfytmcpcVsMJos3sjHKdjq2jPzgAs4m3cgbi3Iiz7iO01L
         HdLgMpmnSaCgSbelBRYu1OkQxei76OxFOwwfH+kJJbPsKDfbyCbuEMUhL4y/qoF8V5hF
         BKjme5pSsALPqieRNQ5KoHNTNFrV/CaXODl+cYWicT8LjhFbziAXpqyUdVPlR/0HdSQb
         7Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+KoS1PIk4Hjw1f3/vpoXHDDfc1MtDGrhUPwAgZC71pI=;
        b=U8q3QBd+VVz5fHDpzLWKuqlZeZ7+WOA1bEQUtGFLeYhG5pt8VHQkSMvwz5dXK5htZb
         KWDiZlbsK/ytejxPluLDRKqSVgTIze5JL67Id2HEItsGrJrlMT5eeAsBTDFF+xvsfL8t
         1HxpomDz/WcjQnKjFbgzmRO0Fo465wr8u5aTP2rC3wlWBhDvwd2c4PH+81sKQJ4l6Cdp
         XJoPGpY5X4nKYiWgXY3jwMRDFAs5600TxfrOq/TLOeeaMEErBkz6Han8/d5i5DSU2D5e
         VFogcmwGawqX5RecgglkQenz0mE3cRh8KU+M4+j1I2+IEQIyeW6QeSJWGOmmXPzbChYC
         FoXw==
X-Gm-Message-State: AOAM533lQJEipjC/VeQjPcKwQT34qz4B76B0xJxtmtFAPXalfAbNwstz
        SRfWGjaP0WoM2tSn1dsG1eXKCnA75A==
X-Google-Smtp-Source: ABdhPJz0w48RAAp0ZaZx/Q5ts4+bLqAl0KLW/+ad8f0fW0OCUYSvwHDDkW2mw2n2cmpUhRcvZ9SK/Q==
X-Received: by 2002:a17:906:6d9a:: with SMTP id h26mr10726330ejt.96.1633263086214;
        Sun, 03 Oct 2021 05:11:26 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.147])
        by smtp.gmail.com with ESMTPSA id i10sm5930971edl.15.2021.10.03.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:11:25 -0700 (PDT)
Date:   Sun, 3 Oct 2021 15:11:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: fix overflow in total mapping size calculation
Message-ID: <YVmd7D0M6G/DcP4O@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel assumes that ELF program headers are ordered by mapping address,
but doesn't enforce it. It is possible to make mapping size extremely huge
by simply shuffling first and last PT_LOAD segments.

As long as PT_LOAD segments do not overlap, it is silly to require
sorting by v_addr anyway because mmap() doesn't care.

Don't assume PT_LOAD segments are sorted and calculate min and max
addresses correctly.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -93,7 +93,7 @@ static int elf_core_dump(struct coredump_params *cprm);
 #define ELF_CORE_EFLAGS	0
 #endif
 
-#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
+#define ELF_PAGESTART(_v) ((_v) & ~(int)(ELF_MIN_ALIGN-1))
 #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
 #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
 
@@ -399,22 +399,21 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
-static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
+static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
-	int i, first_idx = -1, last_idx = -1;
+	elf_addr_t min_addr = -1;
+	elf_addr_t max_addr = 0;
+	bool pt_load = false;
+	int i;
 
 	for (i = 0; i < nr; i++) {
-		if (cmds[i].p_type == PT_LOAD) {
-			last_idx = i;
-			if (first_idx == -1)
-				first_idx = i;
+		if (phdr[i].p_type == PT_LOAD) {
+			min_addr = min(min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
+			max_addr = max(max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);
+			pt_load = true;
 		}
 	}
-	if (first_idx == -1)
-		return 0;
-
-	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
-				ELF_PAGESTART(cmds[first_idx].p_vaddr);
+	return pt_load ? (max_addr - min_addr) : 0;
 }
 
 static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
