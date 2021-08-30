Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557A93FB07F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhH3Epd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhH3Ep3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:45:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE8C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 21:44:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id c2-20020a63d5020000b029023ae853b72cso2286607pgg.18
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 21:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ES6xeSpSzV2YKHVRVxZoTVRqNIvGyeamoedzW1dJrvM=;
        b=ggumJgtmYk4ICrDAo34PyEkyOB9BcpVRP/TC2VOFMMHFgPyeJ6ene36dscpJ+3jo0F
         wrORXhiGU0yYpwFLI7ktQUHCP8dTJmrWMQxK4TMgMClwsIhRtNtXFmz2imGAIdrTZGv9
         u3p8KOzq9YD0PHCJJHPWfHUs+IMfgQDMxaGHITmvq/+vip82rPCmA+s/kodmsb5sgezk
         RQ8ikKxOw4PTmUHeEtVKtpjiG0iq7x4pJrq62tGhCBTIoluGCM2DkVvadk6+VZX/a2gv
         0Iu6f3z2ZnnkhLAbuY/vp01O4YzxNEEcJRPmBFlZW1DMyavMYKorys9KgNaOdBI1kTzF
         Rgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ES6xeSpSzV2YKHVRVxZoTVRqNIvGyeamoedzW1dJrvM=;
        b=W5QwcTs58VKNbwFmbP9FU7TcmyAfpSdZiDMFTsFUfM34EFZqRv+iUxtTylR7Gx+Mgj
         dBnyJUhFguj+w9S5ykf5gWxBDFPd5V96D0sana6eeFuqzCrieJMetta2O/guJjfqoeCx
         1L8XBcccV7eLQKQ2dwCfRfSx8kOFjb5/PjuJXyf3UAG4z0KOvVCzEmkp8dPU5zPVsp3v
         m4SP+iOyufBQOTYfY8MwcfjxpHe6m6kRnv9HSsPWiURKNpp0/aacSddEoxjxobxem9E3
         v8FExoWvLyCDnxBobwGhHa2z732Rn2gADcs9T/DOSi4ScLjgRzKlBblnk2UcD8oG0b3D
         5YcA==
X-Gm-Message-State: AOAM5303Df8zxoqHwB7l8AR+zLN8HEgXLETqsXfG2D8NXXoUqzzL+esO
        WifI3YuA11QOC6RAc5AbkdlY1mjXX9jb
X-Google-Smtp-Source: ABdhPJxeVvBApvmT3usQS4rQRRCqak/ucOyMJ/k6Uswl2w4Y4XMMj59Dgb6v//OKwT8DV/cxPVKnNaI0my7P
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:6503:b0:138:8a3a:9949 with SMTP id
 b3-20020a170902650300b001388a3a9949mr17621298plk.49.1630298676148; Sun, 29
 Aug 2021 21:44:36 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 30 Aug 2021 04:44:24 +0000
In-Reply-To: <20210830044425.2686755-1-mizhang@google.com>
Message-Id: <20210830044425.2686755-2-mizhang@google.com>
Mime-Version: 1.0
References: <20210830044425.2686755-1-mizhang@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v3 1/2] selftests: KVM: align guest physical memory base
 address to 1GB
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing selftest library function always allocates GPA range that aligns
to the end of GPA address space, ie., the allocated GPA range guarantees to
end at the last available GPA. This ends up with the fact that selftest
programs cannot control the alignment of the base GPA. Depending on the
size of the allocation, the base GPA may align only on a 4K based
bounday.

The alignment of base GPA sometimes creates problems for dirty logging
selftest where a 2MB-aligned or 1GB-aligned base GPA is needed to
create NPT/EPT mappings for hugepages.

So, fix this issue and ensure all GPA allocation starts from a 1GB bounary
in all architectures.

Cc: Sean Christopherson <seanjc@google.com>
Cc: David Matlack <dmatlack@google.com>
Cc: Jing Zhang <jingzhangos@google.com>
Cc: Peter Xu <peterx@redhat.com>

Suggested-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/lib/perf_test_util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 0ef80dbdc116..96c30b8d6593 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -93,10 +93,10 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      perf_test_args.guest_page_size;
 	guest_test_phys_mem &= ~(perf_test_args.host_page_size - 1);
-#ifdef __s390x__
-	/* Align to 1M (segment size) */
-	guest_test_phys_mem &= ~((1 << 20) - 1);
-#endif
+
+	/* Align to 1G for all architectures */
+	guest_test_phys_mem &= ~((1 << 30) - 1);
+
 	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
 
 	/* Add extra memory slots for testing */
-- 
2.33.0.259.gc128427fd7-goog

