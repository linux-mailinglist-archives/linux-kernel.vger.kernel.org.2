Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975AE341966
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhCSKDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhCSKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:03:02 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:01 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id x9so21391985wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n6oA03qLjjcwBcDPSDV80wKa+1IBsnhq2bkZWDiODR0=;
        b=TBtrGf5J9GSkUt3b2QMHJgjotxPiRgZJPd7t0Rl9i8F+OSnh0QlipR4VWyCkBIBE1/
         w9n80rWnVXqQOCU+0BPNn93dUIAuOiwEl2SSrONUZWjNuUoC48DwYVV4Vc+pka17RdJw
         YwmYzsL/FA1poINK+D45uXb7866EOkTqngIueW545/vd60y59pVB5ZY8OJKdD/6QdQtQ
         Zu4vGCwDv3N/+AtOwtettFL0mhuTkxWJdfksr/cQjWHTNgy959u6NYrmBz4cD2xUxXh2
         BxJpKQ/VN+NwtBQpqQ3eJ8xZshcVIw5cHOeZbiN/Wsffafzm+SDb4bZYqzX2kBVYdqWD
         ITXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n6oA03qLjjcwBcDPSDV80wKa+1IBsnhq2bkZWDiODR0=;
        b=n33gSF15A1ht3MagMj/JLq/DUKm795NyA0DxSxiDE7KyHwVx9AkL0GiEmT94JzFNEj
         9kbDdHzBWCvkkQ5AsttWGNQViPq/5h6q+HwaNC0B5nTl7aVJa7y32YUe/m/j5WMmUSGb
         xogPk5DDDNWch3ipJ2siFqhybNZHfn2ujm3vJmdiYo7aFjNlnzYSSUCxwgC1ibrHqgp1
         Xlh2Wd0XiuZ35npYBPdALRBDwxYrpAwsVdnXlvGCjLwqpUQqN/42n91SO9qVC5LDYUyL
         wvgcHOZSsEeMWEfpGv7r6uFju6slwE5hpXYjCVNYHhC6tKuwWuuGbRzggXFqKGp7rICk
         C8aQ==
X-Gm-Message-State: AOAM533NzwONMNWSfpna2SGiD2QhUUVT4Q+TRAbCcJzJtZi8FJyEErre
        FRblt0jfb9gZVpFAQ34CBNkFYwiFaKN6
X-Google-Smtp-Source: ABdhPJwV6AcbNU8vjqv/vxj6ZmaNuK9vPiNcReyF8MlFlNm0j8dC0O+RJqRpgMWskICkLeA+1c+B+RkdnB4S
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:4e12:: with SMTP id
 g18mr2881922wmh.56.1616148180533; Fri, 19 Mar 2021 03:03:00 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:41 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-34-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 33/38] KVM: arm64: Introduce KVM_PGTABLE_S2_IDMAP stage 2 flag
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new stage 2 configuration flag to specify that all mappings
in a given page-table will be identity-mapped, as will be the case for
the host. This allows to introduce sanity checks in the map path and to
avoid programming errors.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 2 ++
 arch/arm64/kvm/hyp/pgtable.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 55452f4831d2..c3674c47d48c 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -60,9 +60,11 @@ struct kvm_pgtable_mm_ops {
  * enum kvm_pgtable_stage2_flags - Stage-2 page-table flags.
  * @KVM_PGTABLE_S2_NOFWB:	Don't enforce Normal-WB even if the CPUs have
  *				ARM64_HAS_STAGE2_FWB.
+ * @KVM_PGTABLE_S2_IDMAP:	Only use identity mappings.
  */
 enum kvm_pgtable_stage2_flags {
 	KVM_PGTABLE_S2_NOFWB			= BIT(0),
+	KVM_PGTABLE_S2_IDMAP			= BIT(1),
 };
 
 /**
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b22b4860630c..c37c1dc4feaf 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -760,6 +760,9 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.arg		= &map_data,
 	};
 
+	if (WARN_ON((pgt->flags & KVM_PGTABLE_S2_IDMAP) && (addr != phys)))
+		return -EINVAL;
+
 	ret = stage2_set_prot_attr(pgt, prot, &map_data.attr);
 	if (ret)
 		return ret;
-- 
2.31.0.rc2.261.g7f71774620-goog

