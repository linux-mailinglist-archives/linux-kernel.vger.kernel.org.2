Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC43E84B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhHJUxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233977AbhHJUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628628794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3di0QaOUckRmitQhTtcBV0ekLOQzuzFQOsa3ZnBBrRg=;
        b=Obs6LzhaBMxOKcXS9UNfFnxniKcNqAn5dXH6s0aFqVhmgSRBhhjN5pm96+nRGHiMNbf/ZI
        UnxEzQWwzSNmzYfqQddpTqmUnPkARO4Hv52s/1PeDJS0amigqbKUk8/uI1g9Noudu+FEVL
        u/IhT7TYc049LejhUyhT0oOXuizr/Dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-7ROqt4BhP8ykQktgeQhihQ-1; Tue, 10 Aug 2021 16:53:10 -0400
X-MC-Unique: 7ROqt4BhP8ykQktgeQhihQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39FC4100CF6E;
        Tue, 10 Aug 2021 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C47F69CBA;
        Tue, 10 Aug 2021 20:53:05 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v4 03/16] KVM: x86/mmu: add comment explaining arguments to kvm_zap_gfn_range
Date:   Tue, 10 Aug 2021 23:52:38 +0300
Message-Id: <20210810205251.424103-4-mlevitsk@redhat.com>
In-Reply-To: <20210810205251.424103-1-mlevitsk@redhat.com>
References: <20210810205251.424103-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment makes it clear that the range of gfns that this
function receives is non inclusive.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3080e25c8a3a..d4e22a9635a9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5647,6 +5647,10 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 	kvm_mmu_uninit_tdp_mmu(kvm);
 }
 
+/*
+ * Invalidate (zap) SPTEs that cover GFNs from gfn_start and up to gfn_end
+ * (not including it)
+ */
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 {
 	struct kvm_memslots *slots;
-- 
2.26.3

