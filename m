Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D54335A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhJSMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhJSMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:33 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B8C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:20 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so13916152edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xom4QB7AOMzMrKQIokAKkuFuVfZT5vZhj8rSYX3sNOQ=;
        b=UEBfi9pZv9JWQ9n6/h/iOXEYKZp+KAlUh2DKJbB4tCbbbpQt6Q9qFpuPdsiYcGSHx4
         LX6u3LKvK+ZLLiBEXefMFZZuJL/m57dP0wNf92XMwUS2Vc4dHj+r3kRAM+CL+lqpMimX
         354GwtJhsJ/BwC6r/0XdfiJNr9uoaPCzbdcNTOih4LRbc2iBl63nuNe9XPomDGTu4R52
         5h9hahfNMP9P3o1jfQpOzoMJ43rFPXjB2Uz7vART5kBtHnDArZemdhxKKysPgIU8UxyD
         IXWd2hd/An+PUfJ97+ttKWnIHwUIuxY1/PzKFQseQtOWrSYNG0vc08yZilX4NoOhQn46
         fInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xom4QB7AOMzMrKQIokAKkuFuVfZT5vZhj8rSYX3sNOQ=;
        b=NuwNQV4LLch89O01DXGCauebw7LxivT2RacskdkKRHSiPLOZ4aSSqeX2dgo9fHmHVZ
         xM+gGWrEgMt4xDES1rjA7KK5X9aDiIsXz2tcv50eVkNvz8KVcmiUwQK55xlc3mssphgP
         MYF/zeTrEJLhc0G3UF58C3KBL6lr2zY7LCJBGPFMXDvhSXTxxgyFMbj5QyhhkIlz04Uh
         L1UXn6nDgmXRilAfvRse+xWsT+xX9kdqZbk2xeZ89EJRPjktJ91iFUazUptnDoANKA/l
         FAScoW9X1Bt6hMfGsEe8myEJjw0vEcpSYv88P5wOOWvFLPONEOTNAHlJhDEpgUxcl3O9
         SXnQ==
X-Gm-Message-State: AOAM533+dALwltYdwD8i+gtFAqdQLlSQTI1M7LDdQu0BnIwJCJkAQELY
        B+fYY73IGCvhoyU3ccaNCTo/1yCgLSqc
X-Google-Smtp-Source: ABdhPJxpv/+Qrz1w29XpbnCupLR0QNbk4QaH0nM4qXe1dCgEnX/Y+92sdhWJIqq0OnYUXAbOKpiNqDTYPy5k
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:aa7:dbcf:: with SMTP id
 v15mr53721659edt.243.1634645598342; Tue, 19 Oct 2021 05:13:18 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:54 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-6-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 05/15] KVM: arm64: Hook up ->page_count() for hypervisor
 stage-1 page-table
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
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
index 9e5c92237a51..56343b1bb3a9 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -247,6 +247,7 @@ void __noreturn __pkvm_init_finalise(void)
 		.virt_to_phys	= hyp_virt_to_phys,
 		.get_page	= hpool_get_page,
 		.put_page	= hpool_put_page,
+		.page_count	= hyp_page_count,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.33.0.1079.g6e70778dc9-goog

