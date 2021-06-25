Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A93B46AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFYPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhFYPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624635147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pptgt+0cg64XdyXM9V3421uGBBdkZsSuTXz3mJfy9p8=;
        b=hkcCjioxaqPpDG/Rmp76C1djB1LWo+MHv241j3LvIHqQWmDDSTdw4lsn9PKHA3sn/nOzFZ
        Xk6fgVP2JHBHKEcyOeQPBjYGPM9Au7Fa1ICgHhLyDn/7RdidE/pz+OxIm3rqEJSu2JmA4w
        PW+fkBy3dSYm9ab0K6Ey0OSVYwGbkto=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-b7yq_GCPPWW6iSVoek4_xQ-1; Fri, 25 Jun 2021 11:32:26 -0400
X-MC-Unique: b7yq_GCPPWW6iSVoek4_xQ-1
Received: by mail-il1-f197.google.com with SMTP id g14-20020a926b0e0000b02901bb2deb9d71so6376429ilc.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pptgt+0cg64XdyXM9V3421uGBBdkZsSuTXz3mJfy9p8=;
        b=eN1UN4dfOlK+aTOE3vKdq8LP5QvEvNwL7sd3P6pe08Fbm37943YDw3FbfI2qCvHsRt
         CGoGjYCfFblxLNh+ihMGoEXdvSmwutw0OTWvGfzFMG3q32XEXtC8zsM+A98sbxh3nr7m
         kr+hfXh8KPKYoNk733uSnczXDDJvRudnd6EiL4S+QsUUkrMUFdyLcwpWyJ09oMFsrTFS
         IcMgYsJoIDkrFrls6P2CJOp2N0XhrWBQ0pEKn2QpBAvUepwrYj7veKA82OLl8/a0ieIO
         8YMsnaaZVGerX4+JXjvDERYn8dt7gUoroMBD5vFOmRt/tQV/Y8UXrkzbK5sXFSn9bHMb
         /y3g==
X-Gm-Message-State: AOAM532l6clv1WSQoPDJdy5YU5sSaipS3PgEN2k82mF5FVT/lRuCTTYc
        FmxTBCOaQXBi2Islpd4BDkgA2g2/2Y1yjpuLXPY6quTn/eWprn+sCA9WbILoi24jSprSo7g1GWY
        i+NXS32N+7a5rqa2f/Onm1ccKz1PBnl1w9rfGWKFXv0m/Bq+tNdOFeV4D43CzuIurgia768bdfg
        ==
X-Received: by 2002:a6b:8ec2:: with SMTP id q185mr9021654iod.22.1624635145426;
        Fri, 25 Jun 2021 08:32:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7vAtxUZdoN7t8hc5kr55b1s/kxAsmrBzk8buzgMj/tXFmxxm0ycrEYreLFaAKnJgoOKf43w==
X-Received: by 2002:a6b:8ec2:: with SMTP id q185mr9021634iod.22.1624635145225;
        Fri, 25 Jun 2021 08:32:25 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id s8sm3668772ilj.51.2021.06.25.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:32:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 5/9] KVM: X86: Introduce kvm_mmu_slot_lpages() helpers
Date:   Fri, 25 Jun 2021 11:32:10 -0400
Message-Id: <20210625153214.43106-6-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625153214.43106-1-peterx@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kvm_mmu_slot_lpages() to calculcate lpage_info and rmap array size.
The other __kvm_mmu_slot_lpages() can take an extra parameter of npages rather
than fetching from the memslot pointer.  Start to use the latter one in
kvm_alloc_memslot_metadata().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d83ccf35ce99..b64708f9f27d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -301,6 +301,20 @@ static struct kmem_cache *x86_fpu_cache;
 
 static struct kmem_cache *x86_emulator_cache;
 
+static inline unsigned long
+__kvm_mmu_slot_lpages(struct kvm_memory_slot *slot, unsigned long npages,
+		      int level)
+{
+	return gfn_to_index(slot->base_gfn + npages - 1,
+			    slot->base_gfn, level) + 1;
+}
+
+static inline unsigned long
+kvm_mmu_slot_lpages(struct kvm_memory_slot *slot, int level)
+{
+	return __kvm_mmu_slot_lpages(slot, slot->npages, level);
+}
+
 /*
  * When called, it means the previous get/set msr reached an invalid msr.
  * Return true if we want to ignore/silent this failed msr access.
@@ -11388,8 +11402,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		int lpages;
 		int level = i + 1;
 
-		lpages = gfn_to_index(slot->base_gfn + npages - 1,
-				      slot->base_gfn, level) + 1;
+		lpages = __kvm_mmu_slot_lpages(slot, npages, level);
 
 		linfo = kvcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
 		if (!linfo)
-- 
2.31.1

