Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE093B3573
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhFXSQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhFXSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK3peuD++IDsdruZsIC3KLTQe4djW8+2SfPfi+tnFco=;
        b=FCnXEK4DX+BLCqWs3NjQ4FgwsIOjcnXwNgkmlpvDxL6xsTqkt7psnwDzrhV6ju6ydZPGgk
        eK0D1GADDyFJjQx6ejIDZdDxiKKugxKotIzfMGkzpjBSQb4yGGlOK13L/KkFAFSjB0iFx2
        ZNnOVuuUl+ivubhvkS06LNUIPestxGA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-zCTR02EKP662ux3fpYXFBw-1; Thu, 24 Jun 2021 14:14:11 -0400
X-MC-Unique: zCTR02EKP662ux3fpYXFBw-1
Received: by mail-qt1-f199.google.com with SMTP id t6-20020ac80dc60000b029024e988e8277so7101194qti.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RK3peuD++IDsdruZsIC3KLTQe4djW8+2SfPfi+tnFco=;
        b=ZXg3jaqpaT0u7S/k6V9VSS+7bZ63TQxwCsDCex3Ode9k3Czh+c2Xbu+5z3CmeUmnlz
         MLbd6wa1X8OkM/ZU68SfgF7qVYBnwAzXw6/7a78EzoPCDVhYtzeJJInwq0DSUoVolOuo
         GPrJLhwWOfrLjEMea8KXumFY1RwIQcZM+l2kNe3E+NBUtbchZlGCvBbNPxPnzHotGWgf
         rjlKk35fy3xXKYD7YmDGKIaSw8FaDyWp9E4/RQUj9YGqYMCDbe6nHra62AEiMteI+9YH
         rfxLMsoxlya0s8Lx6xNAvg0TWTWVzRhkKfcsBr4xFPPQ5kDkgEKutzTtPkJ3diBL8j6w
         sgrA==
X-Gm-Message-State: AOAM530P6/1Af4GsfIfzwrjAOlAbOhvt//5fe0wiae9KI31sJTs15d+a
        Jh/HjkhEuRcxLbNUEKvV8rC4kwrc5oNAVEu9NzITe3YV1//e1Zsj+2KAXe/QgHFA1Jgn85D3Eqz
        kH4FGIdyCVVclasIjUxfOG/cf
X-Received: by 2002:a05:620a:414a:: with SMTP id k10mr6879289qko.37.1624558449862;
        Thu, 24 Jun 2021 11:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPfudshlkULqYiFpi8oeG5UyKIdtfiMvQjwTiVa7KxcRjj7roYy30ZxisLFXWhxkYMz9eKBA==
X-Received: by 2002:a05:620a:414a:: with SMTP id k10mr6879273qko.37.1624558449667;
        Thu, 24 Jun 2021 11:14:09 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b7sm2529301qti.21.2021.06.24.11.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:14:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 7/9] KVM: X86: MMU: Tune PTE_LIST_EXT to be bigger
Date:   Thu, 24 Jun 2021 14:13:54 -0400
Message-Id: <20210624181356.10235-8-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rmap array element only contains 3 entries.  However for EPT=N there
could have a lot of guest pages that got tens of even hundreds of rmap entry.

A normal distribution of a 6G guest (even if idle) shows this with rmap count
statistics:

Rmap_Count:     0       1       2-3     4-7     8-15    16-31   32-63   64-127  128-255 256-511 512-1023
Level=4K:       3089171 49005   14016   1363    235     212     15      7       0       0       0
Level=2M:       5951    227     0       0       0       0       0       0       0       0       0
Level=1G:       32      0       0       0       0       0       0       0       0       0       0

If we do some more fork some pages will grow even larger rmap counts.

This patch makes PTE_LIST_EXT bigger so it'll be more efficient for the general
use case of EPT=N as we do list reference less and the loops over PTE_LIST_EXT
will be slightly more efficient; but still not too large so less waste when
array not full.

It should not affecting EPT=Y since EPT normally only has zero or one rmap
entry for each page, so no array is even allocated.

With a test case to fork 500 child and recycle them ("./rmap_fork 500" [1]),
this patch speeds up fork time of about 22%.

    Before: 367.20 (+-4.58%)
    After:  302.00 (+-5.30%)

[1] https://github.com/xzpeter/clibs/commit/825436f825453de2ea5aaee4bdb1c92281efe5b3

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 80263ecb1de3..8888ae291cb9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -135,8 +135,8 @@ module_param(dbg, bool, 0644);
 
 #include <trace/events/kvm.h>
 
-/* make pte_list_desc fit well in cache line */
-#define PTE_LIST_EXT 3
+/* make pte_list_desc fit well in cache lines */
+#define PTE_LIST_EXT 15
 
 struct pte_list_desc {
 	u64 *sptes[PTE_LIST_EXT];
-- 
2.31.1

