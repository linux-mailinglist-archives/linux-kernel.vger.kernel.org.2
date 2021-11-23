Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAD459947
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhKWAqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhKWAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637628196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlocHmIkf6Tvlam5MDqbE9SuPM4p6BSyREYIzmK+cwY=;
        b=IZo6Vz0guevCpBgHcIqAaai5yrYXzrR98IgLUuLe3UZngabP1htqU2Gahytd6U1Grkoj2L
        3UFQuhbLW/IgV0oTdQi5xRx5d4wIM0yRR7IZi7s/gJ5VaBglAbP8ZCFEspoz/jCgxctndC
        3ftU7YzAue2um9DQ9KeHczTXdbvro2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-U1050QLkPZ2ZgNxgV0ilmA-1; Mon, 22 Nov 2021 19:43:13 -0500
X-MC-Unique: U1050QLkPZ2ZgNxgV0ilmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF448066F2;
        Tue, 23 Nov 2021 00:43:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E24F56A93;
        Tue, 23 Nov 2021 00:43:11 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, stable@vger.kernel.org
Subject: [PATCH 1/4] KVM: x86: ignore APICv if LAPIC is not enabled
Date:   Mon, 22 Nov 2021 19:43:08 -0500
Message-Id: <20211123004311.2954158-2-pbonzini@redhat.com>
In-Reply-To: <20211123004311.2954158-1-pbonzini@redhat.com>
References: <20211123004311.2954158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize the condition for the two calls to kvm_x86_sync_pir_to_irr.
The one in the reenter-guest fast path invoked the callback
unconditionally even if LAPIC is disabled.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5a403d92833f..441f4769173e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9849,7 +9849,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
-		if (vcpu->arch.apicv_active)
+		if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
 			static_call(kvm_x86_sync_pir_to_irr)(vcpu);
 
 		if (unlikely(kvm_vcpu_exit_request(vcpu))) {
-- 
2.27.0


