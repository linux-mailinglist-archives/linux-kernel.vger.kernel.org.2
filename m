Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0680F3E48C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhHIP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbhHIPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:43 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6BC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q10-20020a05622a04cab0290267bc0213a9so7866744qtx.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PF2it3NjGIyKq5ORZJDtBzFFsiYhiJLkV2yaXKhO9X4=;
        b=ftXs+EPnLTaD5rCUC9K5I63oGlpyo8cK1JWBx8UMjZ9M93skpv50giZG25JXZCnqR3
         P4/bzs5IMikwsrEoPn4s5CIbKMUP2g9FrdX9jEn37cKvQer2/nFU7JUQGu84PZkYKdGE
         gpcZQBLTk7tFHRo7TSjmGRlJsxEFHP4XQsoDp4RyZR5TldotXatjcdMTOVVOTTnD+PyE
         eJg9fO9N/IZNYFbV/fpOFXkoJkn69ctU91Sa2C5RC/VOqM5oXnCCBiwB7oQviBUSERLr
         uASVreo2KG9expDo8/UU/xVSjkvRLYkgukVyElK5YqFZ7V2OhNzd0/5x5vxtQw21L+ex
         2/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PF2it3NjGIyKq5ORZJDtBzFFsiYhiJLkV2yaXKhO9X4=;
        b=TCDz3sC8lObi6pr+A4/9XAl69NQ6Ht2JTw8mTo6UMuQOVvzDyuXtmtb4M3l4skypnz
         2DT8bjof6T4RwDnaGr4aUwFjOe7TBQEbWNbjEwl3112NMG5SyOmkPS9/POO4wBq+CUul
         dJK7+8PpmRKS0SFMQ1gVaAfJrUxvc+Gu9fqPYoA5/FEvPnBMK8DtcuNLxLY5JiitMuC+
         NHoMm0QrmlVX3pLpk+HXY0eFhM3SwjnVCI2h57u5uJ16VGbaZFt3c9KjsN3YlV+XEhcC
         tPIM5iRJ0pY43KFpliutXtNXWWGLraH2s8Y01FCwjNT0+Vg2Jb1iXLuwPMT82ylId9iO
         JQZw==
X-Gm-Message-State: AOAM5311YuBTuaxwXpnWqx6nIqvcZz+VtW2FNn46OnryVdtVU2CfXs6g
        zLWs8VhuIDh3gnGOOiS1JXMzRSSJFAMx
X-Google-Smtp-Source: ABdhPJykT3ZqBNKwN2TK8pulE0GyjvqWRyK+t1M7X0TDYfKeIo+MjBoUBZPBPTR6JMY1GKpSBOFS/zgqRiv2
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:10e6:: with SMTP id
 q6mr24439882qvt.11.1628522721784; Mon, 09 Aug 2021 08:25:21 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:41 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-15-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 14/21] KVM: arm64: Expose pkvm_hyp_id
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow references to the hypervisor's owner id from outside
mem_protect.c.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 2 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 0849ee8fa260..23316a021880 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -46,6 +46,8 @@ struct host_kvm {
 };
 extern struct host_kvm host_kvm;
 
+extern const u8 pkvm_hyp_id;
+
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index f95a5a4aa09c..ee255171945c 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -31,7 +31,7 @@ static struct hyp_pool host_s2_pool;
 u64 id_aa64mmfr0_el1_sys_val;
 u64 id_aa64mmfr1_el1_sys_val;
 
-static const u8 pkvm_hyp_id = 1;
+const u8 pkvm_hyp_id = 1;
 
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
-- 
2.32.0.605.g8dce9f2422-goog

