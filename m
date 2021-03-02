Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC232ADC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837965AbhCBWNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:13:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1836003AbhCBTfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614713637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmNG084vr8wcNMhIQ/4A1wyri1Ohcyg2X+xeBuspiq8=;
        b=HAnQWvXLi+M6fPIHvS8ngwDzY1cPhUPcwe64Kov67F3AuNtOkswWWVUS2VJvf+CEPf5AC4
        JIB0z1pFfKpOGUGYu9iQ3z6dqn9SoV57uNTe4y/s1CNcp9GE22d415EEqJjoZVwMYgyY5V
        48hIPkkmwuTaDkwcaw1DX5lar54RkSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-HqkNnvKBPZWpt7ZgE3G7iw-1; Tue, 02 Mar 2021 14:33:56 -0500
X-MC-Unique: HqkNnvKBPZWpt7ZgE3G7iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D3618B613D;
        Tue,  2 Mar 2021 19:33:54 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93DE660CC5;
        Tue,  2 Mar 2021 19:33:54 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
Subject: [PATCH 19/23] KVM: SVM: Skip intercepted PAUSE instructions after emulation
Date:   Tue,  2 Mar 2021 14:33:39 -0500
Message-Id: <20210302193343.313318-20-pbonzini@redhat.com>
In-Reply-To: <20210302193343.313318-1-pbonzini@redhat.com>
References: <20210302193343.313318-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Skip PAUSE after interception to avoid unnecessarily re-executing the
instruction in the guest, e.g. after regaining control post-yield.
This is a benign bug as KVM disables PAUSE interception if filtering is
off, including the case where pause_filter_count is set to zero.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210205005750.3841462-10-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3725a4636930..1c62d3ec7e53 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2982,7 +2982,7 @@ static int pause_interception(struct kvm_vcpu *vcpu)
 		grow_ple_window(vcpu);
 
 	kvm_vcpu_on_spin(vcpu, in_kernel);
-	return 1;
+	return kvm_skip_emulated_instruction(vcpu);
 }
 
 static int invpcid_interception(struct kvm_vcpu *vcpu)
-- 
2.26.2


