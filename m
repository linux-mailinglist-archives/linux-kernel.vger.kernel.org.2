Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5F3F2324
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhHSWex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhHSWes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:34:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4EEC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:34:12 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g17-20020a056a00079100b003e1010a1ad4so3673310pfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bOOZsm5TnyY2OqO/UzAmnygEQIpds7n6pzsOsSOKjBo=;
        b=erQKmqzaST94afktv4i+np16BCzAXEK8mkPkEZqUXWbY2IpGlSRHpoHtvLy20knfB5
         MUa8wp5F7LZCR2p6/9cEOCAK204tRAaWU8Mt4CZxiiAEVQMxrttwaZDW2IVdfs5oStPm
         XNE8g1p4Pw2Zh408n+CKCdw7JRte0Yb3UZD7swn8yWDhv1GF87O20lxAJhlxkWVEKI8A
         EuDbz/VdjS8po5swSsNyTmYYrJ3WzOiAetCp4cz+HcHI3aIb3l/lGHcVuHh5lAFaRhf3
         AGGbkZ975qoY1uuyFtWjQ20PyjzCR2QDiQ/G7f+Xn3t+wH/tZIdPvlkEJUNuzIZajPnK
         I+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bOOZsm5TnyY2OqO/UzAmnygEQIpds7n6pzsOsSOKjBo=;
        b=uiMJMQw1ZGl55cCSrrn6IaRPZg24VcVXQB6VC6RrxXK2MbSU2ZBfCVydoUYxQnB9dg
         bgS6ABCZPzRlY0tvs7xuRNgwr9DgKiBkyaJ8rJxpVdoxA2Zc+cXNd5l5TqTH96gJlJzX
         a2mF5oMl667M6QiUn5NfA4owCG/QA994x5UyynDnl1XXALmhyzRDZivVZb/d7XlVftas
         OwWf8eGTOGnnH0ZzuYTNE/ZLlJDe2EhKm0b01Mv37CJhkx0MD/c+FiKTQV3IZZIx+aGJ
         zqYcMywkaZsj6DkHIyJveitVsDwAJFHsWIkVCM5pZXrh3fLsCy6yofoom6+MGyHMLWk/
         pAJw==
X-Gm-Message-State: AOAM530sUwfjyebTakC5QoezVYTV5ZyQpbCuLITdADbGK+vOLaUKxsZ8
        Cd7j8yFZvaPTmogOuk7dJY8E4ItWAD5p
X-Google-Smtp-Source: ABdhPJznI71qPa7ZgpjTnaFxnj7Q9vZ3kYUNCCBWfozdXUGInR1VVtDc+5il7yJQk0NRx7nt4l7r7n7cAXKl
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:396:: with SMTP id
 ga22mr142795pjb.0.1629412451137; Thu, 19 Aug 2021 15:34:11 -0700 (PDT)
Date:   Thu, 19 Aug 2021 22:34:06 +0000
Message-Id: <20210819223406.1132426-1-rananta@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] KVM: arm64: Ratelimit error log during guest debug exception
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Potentially, the guests could trigger a debug exception that's
outside the exception class range. This could lead to an
excessive syslog flooding. Hence, ratelimit the error message.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/handle_exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 04ebab299aa4..c7cec7ffe93c 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -134,7 +134,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
 	case ESR_ELx_EC_BRK64:
 		break;
 	default:
-		kvm_err("%s: un-handled case esr: %#08x\n",
+		kvm_pr_unimpl("%s: un-handled case esr: %#08x\n",
 			__func__, (unsigned int) esr);
 		ret = -1;
 		break;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

