Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257E23A4847
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFKSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFKSFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2996C061283
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f2so6951517wri.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv1oOT7C4SvfVScA5OsmG0Bg/0buHsM+uDbdtIhh8hg=;
        b=TfjPUHiiIaTiInxzuqqFvMKVKQMum8fo+r0CFrnXATaosLR7VuHv9ihm4u+mXuKLb4
         LLbSFpuw8J4in/6tDmsMdYbje8pMu2cLz9GQoz76/cZo74fvYlXywk0CUbG+ppHk+TA1
         dxNnWpLnMSUbsPhLpcd2zTbdRpbwZaw0va5mC74l/8kMEk3nqqDH5tGzlkcsd//XkkkD
         URX8zN02sAPbC159BcujK5K/dbRHY3g9PFJhh37093WeK52tiYD1tYDgxbDFjjgjKW0o
         VpEal+ayUyLh3HotgJuwYFwbkAkZHqWsEHZge5uQjJC8FvS8DNZWANKVQ8IM8NiRU92B
         6lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv1oOT7C4SvfVScA5OsmG0Bg/0buHsM+uDbdtIhh8hg=;
        b=f+XKmmB7fU9z63AIN5uIFcUo2oO9b11J334OBnQuOh+MbTaS9e3NVGJAEil8BuUjoc
         zKRHd4GUdPNbFpff8y4SP7wrl1fBZr/UhzhxIJv2oKDgN5HstddXW1q5DU25uWYmjgqZ
         jIuzuxTBsAw+ceOFBCiyvxV0lbtr8oQhg/rEAG+osHK8dIP7M/9D6DWSBV9nhtf4Tv62
         OYLprI/roeWmwm/TutT0MhHezBqsnqN2bwGJk30AEkY9TdtlBdu8iG5glgnAX9qCfKvg
         RRYuppg917YDYb2Z40ueE1kaq/uCjlUI0xaP4KdHmZFbY9OuPZc3yi/LifW5xRnkUzDy
         E8rw==
X-Gm-Message-State: AOAM5312v6X0yvvTnL/MOnCxoHnDpP2VUaL4LNAlIMhu4kLPb1dq9GUg
        OfnJXPZSPCUyxvACQxQ4Fl7VwgEwgzUbx2dA
X-Google-Smtp-Source: ABdhPJwt5OAuskYJjJE8BX+VI3KPYNJUqpfn+N/q6xU8DoEe3ZlGotdtl6C7C6eegqTsHUuUSBSuQA==
X-Received: by 2002:adf:f985:: with SMTP id f5mr1224955wrr.201.1623434588299;
        Fri, 11 Jun 2021 11:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:07 -0700 (PDT)
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v3 12/23] sparc/vdso: Remove vdso pointer from mm->context
Date:   Fri, 11 Jun 2021 19:02:31 +0100
Message-Id: <20210611180242.711399-13-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used any more: now sysinfo_ehdr is passed back from
arch_setup_additional_pages() to set AT_SYSINFO_EHDR tag.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sparc/include/asm/mmu_64.h | 1 -
 arch/sparc/vdso/vma.c           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 7e2704c770e9..8e7892890d14 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -111,7 +111,6 @@ typedef struct {
 	unsigned long		thp_pte_count;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
 	struct hv_tsb_descr	tsb_descr[MM_NUM_TSBS];
-	void			*vdso;
 	bool			adi;
 	tag_storage_desc_t	*tag_store;
 	spinlock_t		tag_lock;
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index ae635893f9b3..94a43e01d2ac 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -414,7 +414,6 @@ static int map_vdso(const struct vdso_image *image,
 		ret = PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
 	} else {
-		current->mm->context.vdso = (void __user *)text_start;
 		*sysinfo_ehdr = text_start;
 	}
 
-- 
2.31.1

