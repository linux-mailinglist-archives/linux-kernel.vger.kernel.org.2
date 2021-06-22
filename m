Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1273B0E22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhFVUIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhFVUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:00 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB5C061760
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:42 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q207-20020a3743d80000b02903ab34f7ef76so19508004qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=yS607YMkjceC4JgRruoi4/ygC1MkOaxs5bVEaulz0tc=;
        b=RIuUzkEVhRmNz0bDMwt1Z7pVdRtVEUhMXcjZ7o9biugvOtkiRE/17qM9Mjf4lPrxcx
         uzG6uMvMFR27JmMJPdJgpsm8KGgsvU/nkBMb4DbjBsvCEXuL/Ts6tjsqt2fxWMW+ksw2
         ElNOe83RDiz4i2QX1I8edZtLEJEIcUmRNJbKaIKONoXRNZ2LNP2797wJItihUjdHHHwP
         28NZ8q3rtcrKoYiADETzXnKPwfRZr9EiFdXL+vT6sb+ctvAqqSR3IpOzkcuUrUJFWUoG
         /wvMbzoSy6zvAtZO30oQP2uYoCgUVGtZ6vvlB5M5bo7C5BoWu8LqIy2IWiHEAC9wAob6
         pm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=yS607YMkjceC4JgRruoi4/ygC1MkOaxs5bVEaulz0tc=;
        b=MKt+U+BtGuy5Qd0rJU/68/Vm22J3qM5/cuf6ba5fUW9LU29QaUb6h2UdA3k18nsqZZ
         NQeW75dNGGCadsi8rKy7ZU0z3JtG/GeCwe0acOVFs4uQ2ptO1dz3lOb+Lm9WVdA6MDej
         gluv8RtLDlsSSE7aoT7c5aJc7IPSAiY5cg7xXEL1k/INFJPncduBJ9g5SNNQp+4uvNvS
         UEtVtDZDhDY7oeC5Bi3BoDCswyLVzwFelpYwhtvY7bdcSHyYS/W35m6uYXiCrtP7WPKn
         HHeHiJ+8OpusidJp/AxKnh4RksbFF1xoS+R83FBIAnXp75IpGpERUE4DD6l1PjXQdyD5
         1O3A==
X-Gm-Message-State: AOAM531qGJUiT1F+oX42ei6Xap6GVmUDFO7MG/u/nbM7z0AQqD4pVZsU
        a/BWH9k/uh/4tEnWMCiVCaTCKWvlE4U=
X-Google-Smtp-Source: ABdhPJzkhqdyZ2pHk6tsLg53zmI8hJ/HdjKmFlDkPze3Xe8cBtlmbSVriL31WeiVmbQff0jNMVxSqPMUY8U=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a0c:f805:: with SMTP id r5mr554023qvn.31.1624392341779;
 Tue, 22 Jun 2021 13:05:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:11 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 01/19] KVM: selftests: Remove errant asm/barrier.h include to
 fix arm64 build
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

Drop an unnecessary include of asm/barrier.h from dirty_log_test.c to
allow the test to build on arm64.  arm64, s390, and x86 all build cleanly
without the include (PPC and MIPS aren't supported in KVM's selftests).

arm64's barrier.h includes linux/kasan-checks.h, which is not copied
into tools/.

  In file included from ../../../../tools/include/asm/barrier.h:8,
                   from dirty_log_test.c:19:
     .../arm64/include/asm/barrier.h:12:10: fatal error: linux/kasan-checks.h: No such file or directory
     12 | #include <linux/kasan-checks.h>
        |          ^~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

Fixes: 84292e565951 ("KVM: selftests: Add dirty ring buffer test")
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 81edbd23d371..b4d24f50aca6 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
-#include <asm/barrier.h>
 #include <linux/atomic.h>
 
 #include "kvm_util.h"
-- 
2.32.0.288.g62a8d224e6-goog

