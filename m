Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFC3FADC3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhH2S1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhH2S1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:27:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34DC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:26:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m10-20020a25d40a000000b00598bbbf467dso9596204ybf.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ES6xeSpSzV2YKHVRVxZoTVRqNIvGyeamoedzW1dJrvM=;
        b=TWaLCwibnvZ4QgEUDk+VX8xko244251Xt+26UeFqjbE5yihNK9hZkV50XHM7Jehtm/
         eBYwDRc10MmQxG5BbJnaaNO/yJFhYHMkIffSDTUhSHQ09w5ADGgLNke5VhQ+jTMCOl1c
         QhV+svgHpWF9X1W3bMR1ShLnQ2eRrXlrCLqYTyEVA4mV2kPjtmJg2uwtqjo6Ws0iA12Z
         qIHuV7kf3aeRNI4vkq058dcVMlDPV1cNaFOwkung732fj05ZvGNcXwx8WEgzn7CuM3mq
         SYRYvLdviinRgLeWWz6Qxd5yqak25GvbQKEXfQFmU2dT3NVZux1jZSg+dkSwAhDBKMxe
         Hz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ES6xeSpSzV2YKHVRVxZoTVRqNIvGyeamoedzW1dJrvM=;
        b=AafdnuNuDEUaaPxJEsbYFZV9yfDTFgCm8vvB//0yUcZ1JYuCvrYhDRFiHyvQhTywgB
         aqXZP2wwQxTWpNo8tDlRlS+aH6jWTN7/3UE/BQgxjg0IHo7RLpZVFAXIWTATmfN+x6vz
         f+E4ZVYF8wedBShUounI8zizRwzD9Q4DIY2fp3DgyA3pIkQ1lMZFJu+SRQe74LP1Tdw4
         rQ5Wp5SuLYqYD7+AQasA4ZIRJeXCZAktBicg17GIsXe439+o2+md5byDvtps7WtPLLtO
         gldqkKZdFTcIlFdOOsFP92NFRzmg3t4Q5jVAdZVx9WMCGmOY8Vwapl1fkcMA6wbYofoD
         63rg==
X-Gm-Message-State: AOAM533fbkLzqFGP0UvtdwS4Uv3Nwpb+ev3TMESviD0Icoj9j+H+oxql
        Z7YHTykNZTrtec+nTg943i2c3gSyUhUe
X-Google-Smtp-Source: ABdhPJydK/qZns+rLh37YkyaCJUZMkiNEJYCYteJ9vdBtM+LsrdU05PG45D72/z4MCnXv/IRNVJzCwPByfCm
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a25:4441:: with SMTP id
 r62mr17734678yba.10.1630261606042; Sun, 29 Aug 2021 11:26:46 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 29 Aug 2021 18:26:40 +0000
In-Reply-To: <20210829182641.2505220-1-mizhang@google.com>
Message-Id: <20210829182641.2505220-2-mizhang@google.com>
Mime-Version: 1.0
References: <20210829182641.2505220-1-mizhang@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2 1/2] selftests: KVM: align guest physical memory base
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

