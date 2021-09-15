Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3340CC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhIOSQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhIOSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631729700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ea19EVT7+ENaTSXfaPbkEFbFvLGTZXZZbGxxKzThbk=;
        b=VBYj6F8x9qMkz1io7vUPF3Ryg+YZPNdz+4Wn+03lViQo0nW9PIQpmeSUsEW5JuVLIeTk3F
        wGd2PiLFy4zlXeucvzXgXoEMOg/6GpF80CWswYJZ6TzsuIhLc5suCbrzwX1WlBGxwNrn3o
        d563gnVmXVwRWi6DTJqTCbwYgPfi47A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-xxJA00I7Pw-SN5wgpDq7FQ-1; Wed, 15 Sep 2021 14:14:59 -0400
X-MC-Unique: xxJA00I7Pw-SN5wgpDq7FQ-1
Received: by mail-qk1-f199.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so6033734qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ea19EVT7+ENaTSXfaPbkEFbFvLGTZXZZbGxxKzThbk=;
        b=RgN90B3qMrso1ha2FgIOLTNloipPxPw/9xtYi+7FdoyvzmEqrT9yGUN8SQErHRSMti
         9n3hkuJ36xAR4ZOIxzom2fJIiRV6iAhCkkPvT48oO6n7q9/ID6Sr4Ebd+QAmUbA9/T47
         2nooQn2/lq2rOyur3kzS3PMGRkHL1Uh0E9JBg3QA3Iw3fbQ4Sq1IrE2R0biQqYg3lv8L
         0lhEjwGsmYPORXwM9UeFP5NmBC5wK2wD94en82PKf0us+6xb5bOPZ2asPK8+9vNgrdPu
         vFkC+qCJ4D/AGgVH6beiFXgMRzM/lXTAdUTL7KMkvRcmYTpcL7w+Vk5jQsxegwwc+Gy+
         VHbg==
X-Gm-Message-State: AOAM530wJ+iksUuwvecTAN2LIUDhMzisRHlRI6xGNKJr9vCw5AL0XxGk
        av0KwDcMk2o/fTzU2x7nuuR96zF5N4FSElp2toBs61G8LQHP40EpG6hVwNPLf7SmXgPSY+iq6j1
        +lxRFEVXl/PuqoP9YqsKR5iOr
X-Received: by 2002:a37:a302:: with SMTP id m2mr1249718qke.155.1631729698826;
        Wed, 15 Sep 2021 11:14:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygAcwZ/9mrp33dvqbsNgM5BPn8uy9tVqgDqOBo2NkpqqmgJlMiHUZcL8gmQBvWnC27q6/KRg==
X-Received: by 2002:a37:a302:: with SMTP id m2mr1249691qke.155.1631729698554;
        Wed, 15 Sep 2021 11:14:58 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id n18sm578663qkn.63.2021.09.15.11.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:14:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 0/4] mm: A few cleanup patches around zap, shmem and uffd
Date:   Wed, 15 Sep 2021 14:14:52 -0400
Message-Id: <20210915181456.10739-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Based on v5.14-rc1]

Hi, Andrew,

I dropped patch 5 and will do it later when it justifies itself better.  Each
patch of this series now contains at least 1 R-b, would you consider merge it?

Thanks,

v4:
- Patch "mm: Drop first_index/last_index in zap_details"
  - Put first_index and last_index into two lines [Liam]
- Pick up r-bs
- Drop patch 5 for future

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

Peter Xu (4):
  mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
  mm: Clear vmf->pte after pte_unmap_same() returns
  mm: Drop first_index/last_index in zap_details
  mm: Add zap_skip_check_mapping() helper

 include/linux/mm.h | 18 ++++++++++--
 mm/memory.c        | 72 +++++++++++++++++++---------------------------
 mm/shmem.c         |  1 -
 mm/userfaultfd.c   |  3 +-
 4 files changed, 46 insertions(+), 48 deletions(-)

-- 
2.31.1

