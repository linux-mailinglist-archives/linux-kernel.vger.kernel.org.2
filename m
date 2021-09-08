Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2C9403DA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349647AbhIHQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343833AbhIHQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9VEB0mabxX6H0IauzWOmg7fC92taQHzVcX3Un2fABB0=;
        b=ZTWv2+xvvXB2OFINbjJLgLUGGFnLhJADVeuPuT6OTGFA4BjO+Q7rZNyZ885GzOAvFtExhh
        nDEq7SVFSVQWybjEHCe3RGGSEGDL6vn6jo0zjRTteHqy3qF2txsq/M41gxlrgp9L9p1Qy0
        7cNhLRNjrq7+AtxTHv9vrUpBkgQ4268=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-8wOG7SWNM_-vartw87f0Rg-1; Wed, 08 Sep 2021 12:35:22 -0400
X-MC-Unique: 8wOG7SWNM_-vartw87f0Rg-1
Received: by mail-io1-f69.google.com with SMTP id e2-20020a056602044200b005c23c701e26so2193169iov.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9VEB0mabxX6H0IauzWOmg7fC92taQHzVcX3Un2fABB0=;
        b=PcFNYxcmiYsxehu+EA47tqHy5j7hjnzA3gxKTYa3SPNWzKydXknh4xh8lHQwGDpwNa
         WDMSzGCWoq0q5iRfFCOfrexoDuF7jVTERPREXLdEv+f4xQhMt6HrFAM7fMZMOpLh3Ws0
         F3wgL1GmcQyhMxX2PNi6qbKBhKAPvRU29/EsdsjF74GPOEM+oNIfweSMFCfpcxRSYf9q
         TNAtCcoN5nKsAsys5hZEoyeIf6GAiVByNW1JRqzFUfu1M2cZJu1KHZbfGFfoWcSP1pno
         CGSrykX28lpJnWRTrfXz4r18R//82mCfxD9udz0WIaBpNcSOxknRh3r7srgTAomA0rV3
         F/jQ==
X-Gm-Message-State: AOAM5338fIJSeiEgPMxjuVUXkBnSLoFCWkjtP15KsvKujerY7D3tndMx
        zhHwwZiedSKP7azS7tmRUxXhABvDns7mjchZxz7avH4IO8BwY+gPs2A17ujR+GWe1AadU6uKFyo
        OcS9QbfnHgDR2c3kuLdwniMrIrjBAR+kWXtesZb81IOIVAO6C0A1rBr69qYCXHmSgShSd5TzYbw
        ==
X-Received: by 2002:a6b:14f:: with SMTP id 76mr594888iob.211.1631118919527;
        Wed, 08 Sep 2021 09:35:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0/FEqnBC9+7xMfSY1XzYnMfc5+o2WWR+2kVyCZ7N3zjAkhmv3GEWNQ5jVL7+vq0H9XCy2xQ==
X-Received: by 2002:a6b:14f:: with SMTP id 76mr594849iob.211.1631118919137;
        Wed, 08 Sep 2021 09:35:19 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id b10sm1336961ils.13.2021.09.08.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:35:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com
Subject: [PATCH v3 0/5] mm: A few cleanup patches around zap, shmem and uffd
Date:   Wed,  8 Sep 2021 12:35:11 -0400
Message-Id: <20210908163516.214441-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Based on linus/master, commit ac08b1c68d1b which should contain the recent -mm
 pull, if not applicable, I can repost anytime]

v3:
- Patch "mm: Add zap_skip_check_mapping() helper"
  - In zap_skip_check_mapping() check zap_mapping first [Alistair]
- Patch "mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags":
  - Fix English errors in commit message [David]
  - Drop paragraph mentioning commit 22061a1ffabd in commit msg
  - Set ZAP_FLAG_SKIP_SWAP for unmap_mapping_page() too
- Pick up r-bs

v2:
- Patch "mm: Clear vmf->pte after pte_unmap_same() returns"
  - Remove one comment [David]
- Collect r-b for patch 2/3
- Rewrite the last two patches to drop ZAP_FLAG_CHECK_MAPPING, dropping
  Alistair's r-b on patch 5 because it changed [David, Matthew]

===== v1 cover letter =====

I picked up these patches from uffd-wp v5 series here:

https://lore.kernel.org/lkml/20210715201422.211004-1-peterx@redhat.com/

IMHO all of them are very nice cleanups to existing code already, they're all
small and self-contained.  They'll be needed by uffd-wp coming series.  I would
appreciate if they can be accepted earlier, so as to not carry them over always
with the uffd-wp series.

I removed some CC from the uffd-wp v5 series to reduce the noise, and added a
few more into it.

Reviews are greatly welcomed, thanks.

Peter Xu (5):
  mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
  mm: Clear vmf->pte after pte_unmap_same() returns
  mm: Drop first_index/last_index in zap_details
  mm: Add zap_skip_check_mapping() helper
  mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags

 include/linux/mm.h | 34 +++++++++++++++++++--
 mm/memory.c        | 76 +++++++++++++++++++---------------------------
 mm/shmem.c         |  1 -
 mm/userfaultfd.c   |  3 +-
 4 files changed, 63 insertions(+), 51 deletions(-)

-- 
2.31.1

