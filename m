Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924A63B0E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhFVUIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhFVUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52019C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:58 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y35-20020a0cb8a30000b0290270c2da88e8so304314qvf.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=g+L06HpH5qB/hdPw6Qw10O0ltqfkEfqbD0xNTcKTGXs=;
        b=sgSTa0wqdAVJ7yyWVZx4egcKlcIz7e4wDm2G2W7yXfcy9//Whu1kCZVgZvuatE6hxx
         WbOzXEwVmdsnUeENd3eob8mb0xRbaAxSLIFt7M17oY99ZjuXc88oDxMfr+q5GnDuwgMM
         GvzsV1PIG7mn4azu/2y17rnEXcdlPuZzLp3R0DIREDxbP3QGOuTXoZQGTKCoMnIm1CXF
         OinEjsa/mRwk1+Zf6ZkeJ8Q+C818AWXOyg3nu4Poh3IvJJi1MTia/zss0eulbSvvyu5h
         ZH3cpUVrRoajD90suM86OGrUPwilOiWqL78ilzCL9ZFYXIMEbI60VMFp71hz0pKJQytg
         Dk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=g+L06HpH5qB/hdPw6Qw10O0ltqfkEfqbD0xNTcKTGXs=;
        b=GjJ0fHxkBC35KbOG/6Lu1XXvhPYsHx/6lTZAVs7RnV7y7CyskL85JFcIZqfsRPPLV1
         0JL9BNDyG4ADX2efQYhd/Mb6w9K2f6PDc+6RmKZ+jpntj63KNlRMmYL9VcbuG5sTSNYB
         UJLwE9EyggFC1zpYwwv6Jy08PcBavIIZ2tOrO38uY26sdg5AlXb3GwHYiurMjUmq/62I
         E+kGPq9Zqa0CkNpwMrylc2j4I4O9+BpLKzkC4M8VvDjtbt41/VguCfsNIzv0kRLKhVjP
         gh6talziJqLkgpoS2UZkiNvJ6sh29ch1GxC1H9118KTgzws5L2Yi2UGJIPu4nSPa1O3b
         m6iA==
X-Gm-Message-State: AOAM530FJvdNxE2NxhVu/jR8aMhIJX+Omok9NipHj3F3ebTZBVk3ihND
        VnU9zOplQU2HbwVA6Q1RQWCK9uJH0Kw=
X-Google-Smtp-Source: ABdhPJwZG6rPwBU1XuAHdFRt0GoGXoH1n5oGeVto4RXr1qkIZktgq0K2WnxgvQrwI8jkGwr16QdHCxvbJ9Y=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a25:cf92:: with SMTP id f140mr6593986ybg.38.1624392357413;
 Tue, 22 Jun 2021 13:05:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:18 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 08/19] KVM: selftests: Use alloc_page helper for x86-64's
 GDT/ITD/TSS allocations
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

Switch to the vm_vaddr_alloc_page() helper for x86-64's "kernel"
allocations now that the helper uses the same min virtual address as the
open coded versions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index b1fb4c60dd73..afe15a238a81 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -521,8 +521,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
 {
 	if (!vm->gdt)
-		vm->gdt = vm_vaddr_alloc(vm, getpagesize(),
-			KVM_UTIL_MIN_VADDR, 0, 0);
+		vm->gdt = vm_vaddr_alloc_page(vm);
 
 	dt->base = vm->gdt;
 	dt->limit = getpagesize();
@@ -532,8 +531,7 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 				int selector)
 {
 	if (!vm->tss)
-		vm->tss = vm_vaddr_alloc(vm, getpagesize(),
-			KVM_UTIL_MIN_VADDR, 0, 0);
+		vm->tss = vm_vaddr_alloc_page(vm);
 
 	memset(segp, 0, sizeof(*segp));
 	segp->base = vm->tss;
@@ -1220,8 +1218,8 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
 	extern void *idt_handlers;
 	int i;
 
-	vm->idt = vm_vaddr_alloc(vm, getpagesize(), 0x2000, 0, 0);
-	vm->handlers = vm_vaddr_alloc(vm, 256 * sizeof(void *), 0x2000, 0, 0);
+	vm->idt = vm_vaddr_alloc_page(vm);
+	vm->handlers = vm_vaddr_alloc_page(vm);
 	/* Handlers have the same address in both address spaces.*/
 	for (i = 0; i < NUM_INTERRUPTS; i++)
 		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
-- 
2.32.0.288.g62a8d224e6-goog

