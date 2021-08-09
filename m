Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E03E48B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhHIPZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhHIPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:31 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6CC06179B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:10 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so5452262wri.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Io0EDWR3PIis5nkH0gOz1mjrCvg673G9g4IXwa5GIus=;
        b=jfaqF6Wq0Q9e4kkR+jmQAYTa2BnTkBr9q1lmRTdsQdJw/Lh0h/noCoRqRFHW979Vpn
         FDKKbqzoWj8dqTthh4xSOmxkqcsPWcuNm+/ndBqE4q2EeOVzZY5mqOV525AiuZvLD4vO
         sS+vwhpt6tu/ukL509vBuZlbxwKpNeB2AAN77VyY2yLrcUYdbxSOO5/Yxf4wwTvU8W1N
         AmTljU+kIMZA+bYoLJRjetYMG/tcu4In0+GCs4r0zidT6ZPDR4xX/vsgr9gTLMWH1g8h
         xAk0qlE1XeZybchFEHU0YlCCJpuW++Vrxa1Y0KQ43VfgFVirxcu6/bwjge3Al4LJOlkE
         Jf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Io0EDWR3PIis5nkH0gOz1mjrCvg673G9g4IXwa5GIus=;
        b=AHYFclIA2h/9DKLrH0SBONEqgOpXdh6DhY4mWc//5a1xdqt/wVohc43L+WSbEeoaNh
         tqM7+8WaNDF4ldl0iVxOcZBJ64Ek6fL18qaST2Rm+h2P1Zb38sSpzh2RdX4QEDv0fwl4
         qz1uDPkoa/+D71GQB09ROEraSycDggfJ4z5LXbIJP17ZVSckp6I97ly2Jc6C1yWZGRpt
         p98Nwx2RLawCrhdRfvLtRMI8HLCqH7AOA91ZuDJAhonZlhCz4suSZ6dB6kq20Mx3oVXT
         OwbZxiwNrZblI8Y4Cab/yJngOVxKJGlNGswlPvcc6WX9iqMM0MWcRi3GtH5dCfbzalHh
         PnWg==
X-Gm-Message-State: AOAM532ZenXeTUB8TtYcKVUrSdrQQSjVXf7CyTC7O7X13t5cxwM6pYP1
        OChJWfAmuu0qvd/GF5lFBPueADt2jDUU
X-Google-Smtp-Source: ABdhPJz9dh/8xSQuBObFyZiVhTM2lFEjdAUdZfHfPEw63Mx6TEFaOYVnO3fFNdHkbUVeYnSFomkPJvPUytlF
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:600c:410b:: with SMTP id
 j11mr34327897wmi.27.1628522709110; Mon, 09 Aug 2021 08:25:09 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:35 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-9-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 08/21] KVM: arm64: Don't overwrite software bits with owner id
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

We will soon start annotating page-tables with new flags to track shared
pages and such, and we will do so in valid mappings using software bits
in the PTEs, as provided by the architecture. However, it is possible
that we will need to use those flags to annotate invalid mappings as
well in the future, similar to what we do to track page ownership in the
host stage-2.

In order to facilitate the annotation of invalid mappings with such
flags, it would be preferable to re-use the same bits as for valid
mappings (bits [58-55]), but these are currently used for ownership
encoding. Since we have plenty of bits left to use in invalid
mappings, move the ownership bits further down the PTE to avoid the
conflict.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 59a394d82de3..1ee1168ac32d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -46,7 +46,7 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
+#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
 #define KVM_MAX_OWNER_ID		1
 
 struct kvm_pgtable_walk_data {
-- 
2.32.0.605.g8dce9f2422-goog

