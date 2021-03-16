Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92F333CB30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhCPBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhCPBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:55:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF73C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:55:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t37so10773616pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5q/FUsghTIcsJ8LEI0rH+7iHgVJefL/qNsLbH3bIMyE=;
        b=DZn7Td2xbVs8NZjEwSGxuiKun0khhEHJLByCFwgBrC582ZQ9KrrdSYCJ/+9C+7Oecx
         AbbWxLiut0bGD3Dzwg25jQAb2gBCbt91q84fKL9Bqza7Ma+uXuyBSq11/zCPR7MDMJb4
         otUSpsaGolGGcBJPqvtxYEvSwBS6xpOfRjZ8T50HP1cO+EXJcDd+1pV1yQWANINMAssm
         hmTciRg3y6HssOmgIedl5hpKeaZoY8OB8pfnIutck/idiqOpx22iQqI3xGc0u0tY5pPO
         wg9u2cauXGiWuoP7/aBROyxW2LOG6DGIITXwSv1hiKidX5d1gvre+H8cZeNUdN8zHqyR
         Nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5q/FUsghTIcsJ8LEI0rH+7iHgVJefL/qNsLbH3bIMyE=;
        b=U8xGc1Kb24eUZHdZw5BYcEjES7XRu4Qt912J7sUqx7f543iHgOM6XHN9LdfUypnOBT
         jPl7NXGQy1YgLAW8ASQAlYXtrCXajSJo9tcvUX/ZIgJzyaUIvtKVjFGbHIubZrSFWk6v
         4swYpvezrIKJ4U0De24ER0Aoe8tjmwYc5Jof5JqyjQSKJOZ6t2G7x634FdEUog2YVs8h
         6UYeqHakYNN4HHjU8hGInImFi4sU/D3QybjH06te6b4O5e/bVmEukwXZ2Tir914DdTmV
         Nm1E6HjkFEZJaKp9Ox1DdFl8GPniHSFgI0zMnbN94rz3Nx3t5GYaZTy6N9CRnzTu/sA1
         aAxQ==
X-Gm-Message-State: AOAM53355ZmH7CcxBoKONRZJxQAMVHjhiJXLa/RsRS4nt6LSNnVi0cc7
        /2kp1ATuqOZXfzK2iheG9SAhKw==
X-Google-Smtp-Source: ABdhPJwIqVw4yhW+idQ908m9N/zKI/xk+pVeWaj6BxEcrOYB6QD8dBl3skulZ7CbQFh2JIUVGij92A==
X-Received: by 2002:a63:fa02:: with SMTP id y2mr1672518pgh.412.1615859702050;
        Mon, 15 Mar 2021 18:55:02 -0700 (PDT)
Received: from localhost.localdomain ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id y17sm865180pju.50.2021.03.15.18.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:55:01 -0700 (PDT)
From:   Jiuyang Liu <liu@jiuyang.me>
Cc:     Andrew Waterman <waterman@eecs.berkeley.edu>,
        Jiuyang Liu <liu@jiuyang.me>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bug Fix for last patch
Date:   Tue, 16 Mar 2021 01:53:25 +0000
Message-Id: <20210316015328.13516-1-liu@jiuyang.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210310062250.74583-1-liu@jiuyang.me>
References: <20210310062250.74583-1-liu@jiuyang.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise, Andrew gave me feedbacks, and pointed two bugs in
last patch.
1. asid should be thread safe, which is not the intent.
2. asid extracting logic was wrong.

This patch fixes these bugs.

Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
---
 arch/riscv/include/asm/tlbflush.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 4b25f51f163d..1f9b62b3670b 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,10 +22,14 @@ static inline void local_flush_tlb_page(unsigned long addr)
 	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
 }
 
-static unsigned long asid;
+static inline unsigned long get_current_asid(void)
+{
+	return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
+}
+
 static inline void local_flush_tlb_asid(void)
 {
-	asid = csr_read(CSR_SATP) | (SATP_ASID_MASK << SATP_ASID_SHIFT);
+	unsigned long asid = get_current_asid();
 	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
 }
 
-- 
2.30.2

