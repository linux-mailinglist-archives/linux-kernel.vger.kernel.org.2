Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310C83D5692
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhGZIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhGZIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:54 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9396C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:23 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id d14-20020adfe2ce0000b029013a357d7bdcso4464293wrj.18
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xLHFWhuaosj6mgx+BXw5wN11Ic3FuxfIig998pTjIIc=;
        b=L9NlMkGjnx/9vx5Zya428co80U3Z2zbDCQLn8xzTXUsTLyQSWWGmcSo3KOQsDM9tun
         gkbXLLdNGv/H8zmepyiFOjmTJqSPwxzvWiQDZNMPxesdKwZv63J00lJ050+AyLJd7prc
         LCNMi7oofPMTRj12y9X8R1JJKUERjyj7lY2e1qtZZoW7qVzrFyBgCRtzYMz46yZKycjG
         HDlP7DcejUKaphuW7w1QCXKWochGfRtFuNGEH3poHzXLjIKnBbNe3p1nQ5KItcuF8gub
         YwRPeAdiLvNHz/owaoGbrv/kYiCdNGXorjPhq74Rczi8BB7POlnwIJyUdI33/SvPcmUF
         8ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xLHFWhuaosj6mgx+BXw5wN11Ic3FuxfIig998pTjIIc=;
        b=r4qKakx6lr5mzHOYKdxqeV0C5G9c+ZKMPnNsiP/ycX4lPbC3vT1WuGle3eDxD/viLF
         zrSGHly7zTKROdB+WKzllBSC2RJQ89JNqJwLzRr0kbCqXoGSw/zuswS3o6CN4q+ceaIY
         IXWGuxDNFqa55wA0Dwvlm75kKaBft7v8ixObPjo5G6+oUahb2QEi53T6velUUgalsJ/r
         X+QE0Xg9pNiY5aRpCjD2QhvP3uo1wetY6oJ5KpB+prGN972oS+LOrN8DTnJ2qAKn9mhx
         iTVzOOjmX+VHjFL0kMLIIZYGwvKXMi0hZmZ+Qu506EXTQ7fUtThhhv+SGaHaHo8/tXi0
         XeyA==
X-Gm-Message-State: AOAM532IpAdiG4OALaXcq6gZGaNsnGwweXs0gulJRWlsp2Mn65+W0QrQ
        938ZkexQdfOc1E3/BF3IG9lXfCRDxkTb
X-Google-Smtp-Source: ABdhPJxgHTVLPDvaEjvcrmQ9zRhiX1DsEcG3LQTts/yU9YAi0Km3deA725PoMri/xgk5EjXL/D8h91KlNlZc
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6000:2a1:: with SMTP id
 l1mr17703329wry.128.1627291762209; Mon, 26 Jul 2021 02:29:22 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:54 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-6-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 05/16] KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ignored bits for both stage-1 and stage-2 page and block
descriptors are in [55:58], so rename KVM_PTE_LEAF_ATTR_S2_IGNORED to
make it applicable to both. And while at it, since these bits are more
commonly known as 'software' bits, rename accordingly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 55199e579863..516c1b8ce6b8 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -39,6 +39,8 @@
 
 #define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 51)
 
+#define KVM_PTE_LEAF_ATTR_HI_SW		GENMASK(58, 55)
+
 #define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
 
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
@@ -47,8 +49,6 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_PTE_LEAF_ATTR_S2_IGNORED	GENMASK(58, 55)
-
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
 #define KVM_MAX_OWNER_ID		1
 
-- 
2.32.0.432.gabb21c7263-goog

