Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6E3A20EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFIXpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFIXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:45:06 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B592C0613A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 16:43:11 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h20-20020ac87d540000b0290249d0777b80so2376834qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ActxyiNIAcKHyidC7LFkIvgoRqVhbyRGA66pjNXcgQE=;
        b=m07n+P+gFAsAJyhYlFLQ9ZQrL75NF7caFSlvPHloWwX3zHtXO4cbiRRCpbNQ0CVclM
         Cx5o6D+MnSCtYDGyj8nYX4pcYiYc5I9DceQ2rAA4KmVGM5o02u+qlo9IuiS+LTQ5NQN9
         J7/Sy+zysap40wxcRdjNFLQs40StLgmMm5U4OjYIGZF5rMyYp7UcvaQUeVK6ma1h3pk5
         iE5z3JUX0ZWsaLac5W/G7x1ieWfyUeCY7ymkW4rtzvWmNBlYJ+aARI1a+ujs2PhEIvg/
         JVkDI5PXrVqVJjwDq/ZVqMr7jglH3bUMKpTLUb+idz2IpfjW2fs0pmFhDFBqD2WPUUYU
         5XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ActxyiNIAcKHyidC7LFkIvgoRqVhbyRGA66pjNXcgQE=;
        b=lzeCQ02J7O+Q6XAw14kQOX/ir/5HTeZFYam3BEAOyIdnAAkxaioRfyXI5TaMbniWbK
         kMjHa7O7NpUZYfKP3zfs+yrqE/lsRcI6TxGZ4r4rBBuPXdkN+7W2lmHqSoUuiTZYoxYu
         cspB7e/Xdy5RXIZAZk9BVuSHbhHVhyi237SYLxE9u7NYdnTak3yHeBUTHVxFtkpavOU1
         /OzN8afJMAycGXrtCc/pw5oTXoHf88A8Ukly9GkdWD9W7/Uz3Yr4NT1myd+AaPHTUbxB
         nrnm5EcYFH0NmJWD+8HwVZVHJm3zAmxoJf3i8Uqdsrxqsa/oANHSxBgQMQXgsSH8S8VD
         Y/Og==
X-Gm-Message-State: AOAM530JgWEdaR9+ymDTCvA+epnhhUWhypmsNJvx9ih/4b9KAqpqbGaQ
        3o6AoNQ0oQpLXHqbyKIdrvZ896Ps4Bg=
X-Google-Smtp-Source: ABdhPJzmrF3mElvNIB2Fkk21bCN8biEs9twT/HY2vEYwJLImwQzdCDYt5p3QSFOLneMFNnnfPZroTu4kslw=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:8daf:e5e:ae50:4f28])
 (user=seanjc job=sendgmr) by 2002:a0c:eda5:: with SMTP id h5mr2604134qvr.26.1623282190465;
 Wed, 09 Jun 2021 16:43:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 16:42:32 -0700
In-Reply-To: <20210609234235.1244004-1-seanjc@google.com>
Message-Id: <20210609234235.1244004-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210609234235.1244004-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 12/15] KVM: x86: Defer MMU sync on PCID invalidation
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer the MMU sync on PCID invalidation so that multiple sync requests in
a single VM-Exit are batched.  This is a very minor optimization as
checking for unsync'd children is quite cheap.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9620d8936dc4..d3a2a3375541 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1096,7 +1096,7 @@ static void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid)
 	 * happen anyway before switching to any other CR3.
 	 */
 	if (kvm_get_active_pcid(vcpu) == pcid) {
-		kvm_mmu_sync_roots(vcpu);
+		kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 	}
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

