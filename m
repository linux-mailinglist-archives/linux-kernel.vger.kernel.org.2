Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7D3B0E23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhFVUIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhFVUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:00 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2BC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g4-20020ac80ac40000b029024ead0ebb62so388011qti.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hi30iliBhkAnFjVQGfRe6RHZWepvmSRCUakfKckCqbM=;
        b=k/vhZ1jxqpyyIEKCNuzMe0574525FVTHK4QigXQgKwai31yEBv39kpcLweu6pwYLRm
         lst5WPifvcQo2hGVM4xvmz8G1PnemYb3ZrGdfusS+p5bFCrmJVBdG7l1kXLpA3MOzH6V
         ywCyeDKgQ/SeTkThZKZp9dOJw1uVH1/1TF8vbMBWhVteXC6+1dkuKvTIOAfTPyowNavk
         Tb8IIqnFozfIElklBrEUaqIMg1y649il8p54UdHmTlI6lFV0TsjDCrC3j+dQBsX5uV7k
         Vvd9Sch8laDHhS9BfI5XeZCYNO5RHClLsn9RDOrnvXp7nrqxyQLiZguQVEvap1PL8/Wu
         FHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hi30iliBhkAnFjVQGfRe6RHZWepvmSRCUakfKckCqbM=;
        b=MAJj3LWuy0dwce359KqTMZKez+6J+Xj2tNwJ5g3WUHf5zpYgMqXtNSf7OAx/7BnSg6
         1gQaS5qfds+45RbhWQmSxB9fqNsJJoIoeWi3JxpJfwyUKlAaSZ7TizlmJ0iFSzsfYQ3j
         51SP+BRC616cTL+vPsmYfIL87YF/jVtjM2Aoct8zqpAfKW2n/L/0fEI9VAffizrW1Nvr
         nzxGkNh0SkkezgtYiKG+Shcg9zdfGr/NmmCNci8gwdSecu2sA41ZgO8GvkRR7aI1gh4v
         ip3FcVug8yVYkXK8MKagZPynhKum3KzGr7Qu/z9yQKwsDZ9q3UNnkM0hcjgyGztQBz6P
         8Sqw==
X-Gm-Message-State: AOAM530Jtp8CJOLmmAKWBrnECAVocJ52EklLOf9TbC0gXzKLhlmA57ZD
        8rjx5FT2zFIOHsdDdRkPh0F7Fw0YOYA=
X-Google-Smtp-Source: ABdhPJyrWpJw0uxqpzJ1buWayqGNsYIC+WmjBQKTc313FqfCu6zlVnjb0w73e9Lh/6t5je8haz3J6xPWdfc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a25:2bc1:: with SMTP id r184mr7183467ybr.51.1624392343844;
 Tue, 22 Jun 2021 13:05:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:12 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 02/19] KVM: selftests: Zero out the correct page in the
 Hyper-V features test
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

Fix an apparent copy-paste goof in hyperv_features where hcall_page
(which is two pages, so technically just the first page) gets zeroed
twice, and hcall_params gets zeroed none times.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 9947ef63dfa1..030c9447cb90 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -630,7 +630,7 @@ int main(void)
 	memset(addr_gva2hva(vm, hcall_page), 0x0, 2 * getpagesize());
 
 	hcall_params = vm_vaddr_alloc(vm, getpagesize(), 0x20000, 0, 0);
-	memset(addr_gva2hva(vm, hcall_page), 0x0, getpagesize());
+	memset(addr_gva2hva(vm, hcall_params), 0x0, getpagesize());
 
 	vcpu_args_set(vm, VCPU_ID, 2, addr_gva2gpa(vm, hcall_page), hcall_params);
 	vcpu_enable_cap(vm, VCPU_ID, &cap);
-- 
2.32.0.288.g62a8d224e6-goog

