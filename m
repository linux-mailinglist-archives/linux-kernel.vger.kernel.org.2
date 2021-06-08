Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B184639F580
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFHLsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:48:35 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56965 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhFHLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:48:32 -0400
Received: by mail-qk1-f201.google.com with SMTP id h4-20020a05620a2444b02903aacdbd70b7so2966454qkn.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ht6ZsPME0dKrsaoX0sOEJfkD40JHGHh+tjBgtM1a8+s=;
        b=Qo1Sme4AtGquqBbZ3++fnxMhekv/Q/MZQsj0pdKrYdhOBKiGTd8NVlwwFib6WIoU58
         F/EuzAQZ227O9LOmq4TCiKU/lJ8OrmXe6Y0du8LPrkFaVPb0SGCrPQJv74dFr1t0hqw8
         fy3V1IQhwl0eJmdKIpBflmQh37xHque8Fsm6v0wEp/y/OgDqet2jyq2u4FWH0X8QyMPE
         8EBHAgM2ApfYABHvqv9V/vrHhpzSbPnhcEwwZjjctlPFZTxsppMlccDEn5h8VEiJGS/5
         JaBuvCt6pEeETZ4wx1vNc3NkTiRSK/5Rul/LHPAj4crdEwXvDQar9+UrZw0QonuKMKSv
         EAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ht6ZsPME0dKrsaoX0sOEJfkD40JHGHh+tjBgtM1a8+s=;
        b=LdAN1cj+MgaUFP6sNneffCQWOa5hHzz8f1BZ4ruTZTE98s6bZoXhndUPX3nEsnoymQ
         zasAibb01bRzzPEzFJ6mdz1tR7N1kflyw2I/zRJCsUKKcs/MrKYnjr29Bk+w5S1ENtbt
         3UwWD7+lsZLKiQVH2WQ23/AXGf5aLoQ6kIhhvjACHZoS+ZqMEMI1FdYIiYdM4+8kL8tr
         V871GUn5iOfwcCb5MD/ZbniiKBZ5ItVjabbpCVw5dJU5TpNGbO+aEEYGpsrVJWsC/pg2
         m3bgyVk8MNvsyxuUGiQ4RtHHngDIG5AaYR6A7Q4whyi501Eh8RwvpYMKLe1tGGJRnTEz
         WeaA==
X-Gm-Message-State: AOAM533ZTqqBzI4Hvh2JTBr6VCib64te6sJxiN2zIFhczFDpwsEN6NOf
        yiu/knG9xUf1qOYelkO9r5uoesB5F4S9
X-Google-Smtp-Source: ABdhPJwKoD8tOLvO/LYUpyfEnSdl9NSUO/u5qM43SN4f3kxfrNxeCZtg5Givdh9sHlYANNlP3HYBgBNwoPfX
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4241:: with SMTP id
 l1mr22892455qvq.2.1623152739555; Tue, 08 Jun 2021 04:45:39 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:18 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-8-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 7/7] KVM: arm64: Use less bits for hyp_page refcount
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp_page refcount is currently encoded on 4 bytes even though we
never need to count that many objects in a page. Make it 2 bytes to save
some space in the vmemmap.

As overflows are more likely to happen as well, make sure to catch those
with a BUG in the increment function.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 3fe34fa30ea4..592b7edb3edb 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 struct hyp_page {
-	unsigned int refcount;
+	unsigned short refcount;
 	unsigned short order;
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index be07055bbc10..41fc25bdfb34 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -146,6 +146,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 
 static inline void hyp_page_ref_inc(struct hyp_page *p)
 {
+	BUG_ON(p->refcount == USHRT_MAX);
 	p->refcount++;
 }
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

