Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506942C580
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhJMQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhJMQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:59 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5307C061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c14-20020a37e10e000000b0045f3f44539eso2228102qkm.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kINe0IWr90RBHgOAjYvlhVKzPYz79JHCEDd5CCbeejk=;
        b=OsS0vN4gyNtNRBwMG8bFigYCqkq3NooTKR7YjqqinRU1RPJxKLUz47JA1C3v8vh/1I
         yfLpGr6j0uvRc5U+NVL8ceUMekYzc6PXHJPkoBCbo1LcBSWP61RnabYuvsYnc/ELrilQ
         u1wd9tD4HSNnUO/mKylza3pmeVGPserwu8e5b/QisNp5m8+YGH/CKaDdVOS8tLMBDbgt
         MpYKA1gHhlXQUV9f7nJf/mP68j2oIb0ukvdNI9FTnhBF2i3H4OLN/A8vej7da8eZuWaI
         wwUjRR5U0HVYHzA3Xes9MbWGfxBccnUtmJ2XCEdoCqEeznbLJ/RjkfghxkDOCf3POi/I
         wnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kINe0IWr90RBHgOAjYvlhVKzPYz79JHCEDd5CCbeejk=;
        b=pXK7IwCvmhv5Y7c7Gk9bR6FLBT2V/giG8agYc4T7lCl8WrxtnwNTIlsMDhFke3fySj
         2LBMCp/eWW+k1M4QThnPqQ/shsSlikx8aOkWPjFaOG8/2xjhY9ZcBgsTJKMWg0THw9Pb
         0wcm7n1UNmOIPyXDMjCS1d0ByaWLoiSBHsgMFVJThcbsQpXBprx+wAwtW+xwUo/Y2a1y
         ezG5TDAP/cjHazzFzRxiK1XL4nU5OTisNd+5bhbo7V5nVRgftmxN+eRUnK/GXofY0ZT8
         dkOhANuKNCEPhMfx4xEvWa9iA/GzDe/lfAmv+Q7DGI+Y3n6FOCc7nIjfu0TAwP93t0dj
         gi4Q==
X-Gm-Message-State: AOAM530bTxG5FAU6V9tzgw1gmkRIGdkAoPoaahCAT0Gk25EpQGnSz60c
        iW9+H0iY+EcWzaRhZAAU1iEtvuknEPz7
X-Google-Smtp-Source: ABdhPJzDyz3x0TsxSS86fGtgHfDEAddB8Qdemu3K02NrgNa0NMLZw6aQqeBbr2Pk48QMxkVNxj6evJ7yA3g9
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:ac8:5994:: with SMTP id
 e20mr43717qte.331.1634140734872; Wed, 13 Oct 2021 08:58:54 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:24 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-10-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 09/16] KVM: arm64: Hook up ->page_count() for hypervisor
 stage-1 page-table
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

kvm_pgtable_hyp_unmap() relies on the ->page_count() function callback
being provided by the memory-management operations for the page-table.

Wire up this callback for the hypervisor stage-1 page-table.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index ad89801dfed7..98b39facae04 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -246,6 +246,7 @@ void __noreturn __pkvm_init_finalise(void)
 		.virt_to_phys	= hyp_virt_to_phys,
 		.get_page	= hpool_get_page,
 		.put_page	= hpool_put_page,
+		.page_count	= hyp_page_count,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.33.0.882.g93a45727a2-goog

