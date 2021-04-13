Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC635E851
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhDMVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232049AbhDMVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618349527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X9n1E547QdNccpSIMLIADrczPbqaZ7pVhiltEhbynkc=;
        b=XbfUbc5FT7EZuwwBKlpcjLoDq/gb0XmqbB49l3x4HGyRClQA0WwrQ+fCaDC1YREw+boDro
        tTKQNvffnSKPL71OfPnzAYADjjdszpwyv97skKwqq1Mn94Y4mvuyQs05Oc1AbAqIyw89BZ
        rLEFBXifWpDOxNenKBBzk2eru9HzCjg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-BP4eEZmrNSWtNuVQCBYKEA-1; Tue, 13 Apr 2021 17:32:05 -0400
X-MC-Unique: BP4eEZmrNSWtNuVQCBYKEA-1
Received: by mail-qk1-f199.google.com with SMTP id c9so5165545qkm.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9n1E547QdNccpSIMLIADrczPbqaZ7pVhiltEhbynkc=;
        b=Da5lrP32phKAF4pVMk3FVzLGynUMG8Sc2tFAnSCPHuAHpYG6AZ79qAJ6FRqqUWclmw
         pR7F+AdOJvpHo2Pomebql68VRYer0fX/v/emX15KuDKONTR/6gWm1JIH9niXSPOR1+nH
         FgOBZa4M4i/oR9Dn0UfdqOFeX9IYzygFB5eeQ8sHkftWtgiId4GUB1E5MmFkdTglt/rc
         fEQZ+689mSEFG81fui2Eib/L2K8yQ8TWXkRvLYy+TZ8X0szvorNBHqFDAThxcZQ9l5Hk
         QyAK32n7gn3RRVGMwoEsWQNus/8no2O221VlLA7+cXxKzj6USkZsbo8xSaezHznE5VpX
         ZeQA==
X-Gm-Message-State: AOAM532PBcW3l6c2ddWPmkuqED+riTw/JyfJfagQ97EgedwOF9Om6sIc
        4I44Iw2vp3bQJw0iQSVsK6iQDNg172q5gRVRurZKm76EEA5TRBcck4x7Bs3Isgfv+5fh0GcW+C4
        MD9WAjAt2MxMP5M9B9Rb8+hPd
X-Received: by 2002:ac8:44d0:: with SMTP id b16mr31954827qto.217.1618349524961;
        Tue, 13 Apr 2021 14:32:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznkq3rW5DaJa1Xdbc667bf5oyHfTaHrjWtksTxRiuG7nmFsesX3SMukmeDtdVuqt8keqbQqw==
X-Received: by 2002:ac8:44d0:: with SMTP id b16mr31954804qto.217.1618349524674;
        Tue, 13 Apr 2021 14:32:04 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id u126sm7626604qkd.80.2021.04.13.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:32:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH] kvm/selftests: Fix race condition with dirty_log_test
Date:   Tue, 13 Apr 2021 17:32:02 -0400
Message-Id: <20210413213202.22766-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug that can trigger with e.g. "taskset -c 0 ./dirty_log_test" or
when the testing host is very busy.

The issue is when the vcpu thread got the dirty bit set but got preempted by
other threads _before_ the data is written, we won't be able to see the latest
data only until the vcpu threads do VMENTER. IOW, the guest write operation and
dirty bit set cannot guarantee atomicity. The race could look like:

    main thread                            vcpu thread
    ===========                            ===========
    iteration=X
                                           *addr = X
                                           (so latest data is X)
    iteration=X+1
    ...
    iteration=X+N
                                           guest executes "*addr = X+N"
                                             reg=READ_ONCE(iteration)=X+N
                                             host page fault
                                               set dirty bit for page "addr"
                                             (_before_ VMENTER happens...
                                              so *addr is still X!)
                                           vcpu thread got preempted
    get dirty log
    verify data
      detected dirty bit set, data is X
      not X+N nor X+N-1, data too old!

This patch closes this race by allowing the main thread to give the vcpu thread
chance to do a VMENTER to complete that write operation.  It's done by adding a
vcpu loop counter (must be defined as volatile as main thread will do read
loop), then the main thread can guarantee the vcpu got at least another VMENTER
by making sure the guest_vcpu_loops increases by 2.

Dirty ring does not need this since dirty_ring_last_page would already help
avoid this specific race condition.

Cc: Andrew Jones <drjones@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 54 +++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index bb2752d78fe3..557b1d9bd70c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -160,6 +160,10 @@ static bool dirty_ring_vcpu_ring_full;
  * verifying process, we let it pass.
  */
 static uint64_t dirty_ring_last_page;
+/*
+ * Record how many loops the guest vcpu thread has went through
+ */
+static volatile uint64_t guest_vcpu_loops;
 
 enum log_mode_t {
 	/* Only use KVM_GET_DIRTY_LOG for logging */
@@ -526,6 +530,7 @@ static void *vcpu_worker(void *data)
 			assert(sig == SIG_IPI);
 		}
 		log_mode_after_vcpu_run(vm, ret, errno);
+		guest_vcpu_loops++;
 	}
 
 	pr_info("Dirtied %"PRIu64" pages\n", pages_count);
@@ -565,7 +570,12 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 			matched = (*value_ptr == iteration ||
 				   *value_ptr == iteration - 1);
 
-			if (host_log_mode == LOG_MODE_DIRTY_RING && !matched) {
+			if (matched)
+				continue;
+
+			/* Didn't match..  Let's figure out what's wrong.. */
+			switch (host_log_mode) {
+			case LOG_MODE_DIRTY_RING:
 				if (*value_ptr == iteration - 2 && min_iter <= iteration - 2) {
 					/*
 					 * Short answer: this case is special
@@ -608,6 +618,48 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 					 */
 					continue;
 				}
+				break;
+			case LOG_MODE_DIRTY_LOG:
+			case LOG_MODE_CLEAR_LOG:
+				if (!matched) {
+					/*
+					 * This fixes a bug that can trigger with
+					 * e.g. "taskset -c 0 ./dirty_log_test" or when
+					 * the testing host is very busy, when the vcpu
+					 * thread got the dirty bit set but got
+					 * preempted by other threads _before_ the data
+					 * is written, so we won't be able to see the
+					 * latest data only until the vcpu threads do
+					 * VMENTER and the write finally lands to the
+					 * memory.  So when !matched happened, we give
+					 * the vcpu thread _one_ more chance to do a
+					 * VMENTER so as to flush the written data.  We
+					 * do that by observing guest_vcpu_loops to
+					 * increase +2: as +1 is not enough to
+					 * guarantee a complete VMENTER.
+					 *
+					 * Dirty ring does not need this since
+					 * dirty_ring_last_page would already help
+					 * avoid it.
+					 */
+					uint64_t current_loop = guest_vcpu_loops;
+
+					/*
+					 * Wait until the vcpu thread at least
+					 * completes one VMENTER again.  the
+					 * usleep() gives the vcpu thread a
+					 * better chance to be scheduled earlier.
+					 */
+					while (guest_vcpu_loops <= current_loop + 2)
+						usleep(1);
+					/* Recalculate */
+					matched = (*value_ptr == iteration ||
+						   *value_ptr == iteration - 1);
+				}
+				break;
+			default:
+				/* Just to avoid some strict compile warning */
+				break;
 			}
 
 			TEST_ASSERT(matched,
-- 
2.26.2

