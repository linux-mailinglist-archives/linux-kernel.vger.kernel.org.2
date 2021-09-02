Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8033C3FF4BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbhIBUSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhIBUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630613845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cD1W3dntLgg1x3vkXVCT9JGKq3SQlkeHYUmqX0fImm4=;
        b=Ar5X45d9UPWK1VBEFq7oD6rOUK6Nv1a05LNAyynB+0DXb1s0wZApRWq/O9uSm747L2IjB3
        9Zvi3iG5tbN8MchpkmN2GDuBjd6pmJssNEkuFfnqeqIM3XqUs2PMwXAeCtfI5GOeD7N/Td
        3GxUCEdNVS02fTRYZDlSf0zB81b3fiI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-JSZjy7V6P3aP_Jw4IAMXdA-1; Thu, 02 Sep 2021 16:17:24 -0400
X-MC-Unique: JSZjy7V6P3aP_Jw4IAMXdA-1
Received: by mail-qt1-f197.google.com with SMTP id m6-20020ac807c6000000b0029994381c5fso2822775qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cD1W3dntLgg1x3vkXVCT9JGKq3SQlkeHYUmqX0fImm4=;
        b=J8MhkG+n2mee5F4kKogX7PRuKs2uKXkcxwCxl+iGCMldNEo2I2uwqQV1QKxyz4l1lq
         GLgozDSoUXf9p0oyD3ntyijwq4XCHTMAQTmsTPekUWdnKSRKg3tYqD9P4CnqybwdIQyU
         T/d58L85PjQAmxyyBpWwt+NPIN5wtjC5vptDipYz1mvxaCFiiy9WvkeVzm0YxTNwS5B7
         jpMcyD+qy8Quler8WrH2O3GJ/2tliRttXyOuuMgAM16/Md5K+P46/6g5YFZc0xR4i3vI
         0SAsuD1C8ItcmmzvB/bfF08hCZeHnuwS91WE8Uxo7EmlbhwTt/E2A8fbaZBhohKSG2Ny
         u63Q==
X-Gm-Message-State: AOAM532MqasmbnII2iqrn8R4cYUspCLYRxxxuNFq5Dv2tdKtL90oHm8F
        hfBqzYpXXMoc0GZWThFWTSTBkPnfgEpZNLOgcWzsEneTljP1moZnF2TglkmKR+2Y+KzkE1+thPG
        w+tS2+CRUZ81EDFKf61eHtviuNa26Yk2KkZCfUA7xVdoa/V6kVbKitkILa82DrGlzznGWS1CAVg
        ==
X-Received: by 2002:ac8:a0a:: with SMTP id b10mr167553qti.164.1630613844063;
        Thu, 02 Sep 2021 13:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/2PxgUG48VI5CyWpSrsgmcN4+bm4tOjKozx0or1bv7gKrDgWp7u41BOWsDuMOfcRu4ITTeA==
X-Received: by 2002:ac8:a0a:: with SMTP id b10mr167496qti.164.1630613843647;
        Thu, 02 Sep 2021 13:17:23 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id m8sm2219962qkk.130.2021.09.02.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:17:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 0/5] mm: A few cleanup patches around zap, shmem and uffd
Date:   Thu,  2 Sep 2021 16:17:16 -0400
Message-Id: <20210902201721.52796-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Based on tag v5.14, but it should still apply to -mm too.  If not, I can
 repost anytime]

Hugh,

So I found one thing that I feel like a bug of commit 22061a1ffabdb9c3, but I'm
not sure.  If that's the case, patch 5 of this series may be the fix for it.

The problem is unmap_mapping_page() in current tree is calling
unmap_mapping_range_tree() with a details pointer, while by default when detail
pointer is specified, it means "we want to skip zapping swap entries".

I didn't mention this in v1 simply because I thought it was fine, e.g., swap
entry won't be kept in shmem ptes so skipped is okay (it is never okay with
shmem uffd-wp but uffd-wp code is not landed yet).  However I just remembered
there could also be e.g. shmem migration entries if I'm not wrong.  From that
pov, skipping swap entries for unmap_mapping_page() seems wrong.  Would you
please help check?

It'll be great if you can comment on patch 1 too, to see whether that's okay
and what I could have been missing there (e.g., if you have other concern on
breaking stuff, I'll be happy to test).

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

 include/linux/mm.h | 33 ++++++++++++++++++--
 mm/memory.c        | 76 +++++++++++++++++++---------------------------
 mm/shmem.c         |  1 -
 mm/userfaultfd.c   |  3 +-
 4 files changed, 62 insertions(+), 51 deletions(-)

-- 
2.31.1

