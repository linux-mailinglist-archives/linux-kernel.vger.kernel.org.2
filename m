Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D23B0E37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhFVUI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhFVUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949AC06124A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id jm5-20020ad45ec50000b0290219dc9a1ab8so271032qvb.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Us7g2LrA6zTO1V2suFv+B2vlLNMpe1oaQuMfK8vdQCI=;
        b=TUb8fWA/yF3VIfLaoQHAUeM2ulIxxiS1PqoX0WhJNlxWtvOaGLYmdF2b4cV9dG4Jpg
         9lUh+Oq9t4S8Ef4QF+fybrTcshF+xbnsjekL4ioiuuTBahaezRMoIFmaYc6XTFi9Bu9Y
         YNtaDSgItefAoBEzn60QfL6qubNMNS1YSN8hqDBmixVKPVVWqjNCHoGqxPLswfKPaESL
         xNUvJjSmyVPxE9YLtW4ih7ApiKGG0SDehAKUaEe4u559uj3E1JQUqnAOuQIopoeCRz6Z
         6i+iYHoQ78I09JDti/XPkUSKopeuHQM+t8e0Aq4kuWBk0vp7us30O/t4VyVjqNhZIMMk
         QMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Us7g2LrA6zTO1V2suFv+B2vlLNMpe1oaQuMfK8vdQCI=;
        b=BCKBNkVHJFdPRFd5gl0zqwlhACjUVgZMCr18Kcd8Vut0aFY/u50feyU8VJ9w9Ri1CQ
         yvEjqM4qwoEXWERqxZdMGl2FLz34rgKJbEipFyN/Qjl3/F1un/I8YYidi/5s6QAVqJnS
         RCi6ggkoXBTVDpxhoMxVRKzqr3BqRnyyWJWo0YzBPwCeRO9rXJfdHmPHEwOVy53Nf3xf
         R5N1mbxUnqYbJfKNzStwUsY7UmKvKaN69ccPvMkp5sgIM59euS6KUv254RP0y9tmM6oB
         1bd70z4kHhb0fd8qR0/caChxTcMRRMaicNKO1k9ohEXL2GooDcqzYruCrkqe16MDt7Eb
         03dA==
X-Gm-Message-State: AOAM532lfqnaTsoPuAiGu1x8w8KITKG3F0u9RzUWWCzjPAi4CNg4lhbw
        X8RASXG5nLHxgoPG3RDnhxSqHaLur/A=
X-Google-Smtp-Source: ABdhPJxC4PjZa2jCNtJDQye/LjZHZEwh0rx/QCZVl6R/D1/KtarJjPFYR4+zCXHUPLEihcrfSNva/sKG+RA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a5b:f0a:: with SMTP id x10mr7006948ybr.447.1624392355319;
 Tue, 22 Jun 2021 13:05:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:17 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 07/19] KVM: selftests: Lower the min virtual address for misc
 page allocations
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the minimum virtual address of page allocations from 0x10000 to
KVM_UTIL_MIN_VADDR (0x2000).  Both values appear to be completely
arbitrary, and reducing the min to KVM_UTIL_MIN_VADDR will allow for
additional consolidation of code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c45e8c492627..26db0e6aa329 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1296,7 +1296,7 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
  */
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages)
 {
-	return vm_vaddr_alloc(vm, nr_pages * getpagesize(), 0x10000, 0, 0);
+	return vm_vaddr_alloc(vm, nr_pages * getpagesize(), KVM_UTIL_MIN_VADDR, 0, 0);
 }
 
 /*
-- 
2.32.0.288.g62a8d224e6-goog

