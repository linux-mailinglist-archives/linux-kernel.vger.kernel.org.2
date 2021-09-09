Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710E404311
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbhIIBnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350466AbhIIBmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:42:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17730C061150
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:39:08 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z19-20020a631913000000b00252ede336caso161186pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lTqRO0idkBiaTW7ItUglmOAQqB88QiCZDRsI2c4OZ58=;
        b=dfmrkza0ggbmDEkjnJXOJPPETnwr63qICydj3Wpk8FVdGfgYnUe3tdRfwf43izmZlh
         JxSOd1JqW1MTS0/ZHkQAgMprhPbV4BSXeeIgbYbBKCA3AWlwrnCAMQOskkdJFtl3SpNS
         NYlk8NySDfFVwsWLNbt2aS2gMdiUIkjGqwUlX44XPD2fRg7V9U35AJtKn/mf6byslUqD
         NL5atvXUVIEsY54aZVVM2EKW1bkWeIMUnjVL5L817AjCF1JO7Y+b6N8XSmkYDpYuLgN4
         YHDXKEqFOETcnAtyGUP//89V6/7ir8IEwum8I50MTn0aWy8o2ROanviCskBO+Lby+UH4
         Dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lTqRO0idkBiaTW7ItUglmOAQqB88QiCZDRsI2c4OZ58=;
        b=KMh1cgq3hRG+m0rLSC2/RoSfY9MoU6QSs9d5hJTUqwf0jOD+Bs3Q1Xhvs5aDlWmaex
         p1AhCHRXo6X9XZ4U2LvWLboU3s1x9VdGBvGyX/aOgZaog5fmu9hxsvGtUek7p8N+aYO9
         6NqZvNXXsgARda/spCiP1HjREXAcTpaKNYGkmyuzLguCz1M0nAs4CTv3/WVJNlVGTA2m
         7m+0kWtzwpFlAQ5+OjBNp+MGllku3uARjBA+tKAkR5K/qTmQZbZOwfZ3d0zCzqwqcfjJ
         1OE34FbFGNXdnfi74QSrCFMoWOs/9KAuvKPP4Nn2Ude1vzdn7TZA6qdRuVA/Vy/QNggK
         flvw==
X-Gm-Message-State: AOAM5333mFgm/nLh5uGuEbaiReK8OUi6Aa6lszLVWiNhy9Bs5xoyShOX
        I1OalwZmsStk9WI2nOPNc9SIkxAzUfBw
X-Google-Smtp-Source: ABdhPJyc3BV8YSCcmMBcGFTF2wB4u0hyIS/oC54sk3TRAH4F3aSdUtllvTioIXtRosmVEfGWFTdqYH0KLtaf
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:38cc:: with SMTP id
 nn12mr608867pjb.139.1631151547473; Wed, 08 Sep 2021 18:39:07 -0700 (PDT)
Date:   Thu,  9 Sep 2021 01:38:18 +0000
In-Reply-To: <20210909013818.1191270-1-rananta@google.com>
Message-Id: <20210909013818.1191270-19-rananta@google.com>
Mime-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v4 18/18] KVM: selftests: vgic_init: Pull REDIST_REGION_ATTR_ADDR
 from vgic.h
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
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
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the definition of REDIST_REGION_ATTR_ADDR from vgic.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 623f31a14326..157fc24f39c5 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -13,11 +13,10 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "vgic.h"
 
 #define NR_VCPUS		4
 
-#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) (((uint64_t)(count) << 52) | \
-	((uint64_t)((base) >> 16) << 16) | ((uint64_t)(flags) << 12) | index)
 #define REG_OFFSET(vcpu, offset) (((uint64_t)vcpu << 32) | offset)
 
 #define GICR_TYPER 0x8
-- 
2.33.0.153.gba50c8fa24-goog

