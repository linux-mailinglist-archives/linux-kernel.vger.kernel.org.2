Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C264B3B5CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhF1KrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232774AbhF1KrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624877081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2nBh0NtyYrXL+NooeJ5MdvvI5b6MBXLjInX6gyozG8=;
        b=KPEK8KTWXqcbqYb2TLgI8UFfw6VOZsAy/1yV76NnHmq/ZNuqyBNs68DyuyZ9vwKX8OJAtW
        qdXXD739Cwaes7KZz8IFiheCEQ3PIvAiM7VmMNqcjVEbtWrqlcytO7g9hT/Wq6IOqxw6zh
        ejKQqs0Zx5yqV9t2jZ54tm9lV/HiQTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-cuP_DbspOsqs4kTvtLVFJw-1; Mon, 28 Jun 2021 06:44:38 -0400
X-MC-Unique: cuP_DbspOsqs4kTvtLVFJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64397100C664;
        Mon, 28 Jun 2021 10:44:37 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 556D05C1CF;
        Mon, 28 Jun 2021 10:44:31 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] KVM: nSVM: Check the value written to MSR_VM_HSAVE_PA
Date:   Mon, 28 Jun 2021 12:44:20 +0200
Message-Id: <20210628104425.391276-2-vkuznets@redhat.com>
In-Reply-To: <20210628104425.391276-1-vkuznets@redhat.com>
References: <20210628104425.391276-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APM states that #GP is raised upon write to MSR_VM_HSAVE_PA when
the supplied address is not page-aligned or is outside of "maximum
supported physical address for this implementation".
page_address_valid() check seems suitable. Also, forcefully page-align
the address when it's written from VMM.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8834822c00cd..b6f85fd19f96 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2941,7 +2941,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			svm_disable_lbrv(vcpu);
 		break;
 	case MSR_VM_HSAVE_PA:
-		svm->nested.hsave_msr = data;
+		if (!msr->host_initiated && !page_address_valid(vcpu, data))
+			return 1;
+
+		svm->nested.hsave_msr = data & PAGE_MASK;
 		break;
 	case MSR_VM_CR:
 		return svm_set_vm_cr(vcpu, data);
-- 
2.31.1

