Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40930FCF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhBDTdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236879AbhBDOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZuE5C480kPs7RukduSN3hJlKKW4l1ob8mkB2FAPdH0s=;
        b=eMtsQ5eaPWbIGHzGpDLULFFHrfqA3AG/HbqUDwBFYfjPTDo88tlbqjgPqciZ60bRT18gNO
        PQCohmKJDutiDWQqt6+dKjlApKMh0cL2ibQTZRSwMguUbl/+tAJp1vRFLhV5PJlz4dkpo1
        EsjwBfiNSarUw6eInOwOcbTFoVVZnp4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-KqQt9e1QPWaeJCpEiW1bGA-1; Thu, 04 Feb 2021 09:50:36 -0500
X-MC-Unique: KqQt9e1QPWaeJCpEiW1bGA-1
Received: by mail-qk1-f199.google.com with SMTP id p185so2827304qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuE5C480kPs7RukduSN3hJlKKW4l1ob8mkB2FAPdH0s=;
        b=iSBdqE/cuPmfM0kLvbJ3XZtkVBYUKG6wKhFuNA202TgQmMXbXUGvme3EGokn5ylnbN
         W5oYvzV1C0L8pmPimL7UtUk7C56AG1xq8jqFpImXb0618i+sCJUBJrjGBzhfcW10loD8
         LSrlGwff9FvRECJU0WhTZn7DG3WH2jEbre6DMG+86uc9t9i7kLmBokjdho+ADWUziLvA
         pHXndSVkrfS3z2/YWfVt3x2cnxE33z6/CON/rDtLZDlIwiYYIXIgIAsZ0wKyF5Xu460B
         ONX5QDa9fpIGVHMRjUE0Ewhve+KOUFjmwMarzCntPA+FTFNMuylB4e4lCP1DZEDpTHRp
         5WtA==
X-Gm-Message-State: AOAM532/13VdaPs2LT05OshLDHPhy7pzNXifaOLv9/79WIhDE9k5+daW
        H4vN4HgHL8aZmxbss0ZRrnmvFMvS+ghJJkRa/b5jCY6lMQc4+Ne4gF0s+crrbZ0qVPym2Ft3ulL
        ej5dqQshuPaqvoHmVLMXkoc9y
X-Received: by 2002:ac8:5707:: with SMTP id 7mr7409519qtw.365.1612450235974;
        Thu, 04 Feb 2021 06:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWT2mtcic850Ww5E2xfzUAOlINS7TedhA/LzchazLXr02rlTqNLnn2cmt9+GtU9HzHoQRmng==
X-Received: by 2002:ac8:5707:: with SMTP id 7mr7409494qtw.365.1612450235720;
        Thu, 04 Feb 2021 06:50:35 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id e14sm4697589qte.18.2021.02.04.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:50:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/4] mm/hugetlb: Early cow on fork, and a few cleanups
Date:   Thu,  4 Feb 2021 09:50:29 -0500
Message-Id: <20210204145033.136755-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:=0D
- pass in 1 to alloc_huge_page() last param [Mike]=0D
- reduce comment, unify the comment in one place [Linus]=0D
- add r-bs for Mike and Miaohe=0D
=0D
As reported by Gal [1], we still miss the code clip to handle early cow for=
=0D
hugetlb case, which is true.  Again, it still feels odd to fork() after usi=
ng a=0D
few huge pages, especially if they're privately mapped to me..  However I d=
o=0D
agree with Gal and Jason in that we should still have that since that'll=0D
complete the early cow on fork effort at least, and it'll still fix issues=
=0D
where buffers are not well under control and not easy to apply MADV_DONTFOR=
K.=0D
=0D
The first two patches (1-2) are some cleanups I noticed when reading into t=
he=0D
hugetlb reserve map code.  I think it's good to have but they're not necess=
ary=0D
for fixing the fork issue.=0D
=0D
The last two patches (3-4) is the real fix.=0D
=0D
I tested this with a fork() after some vfio-pci assignment, so I'm pretty s=
ure=0D
the page copy path could trigger well (page will be accounted right after t=
he=0D
fork()), but I didn't do data check since the card I assigned is some rando=
m=0D
nic.  Gal, please feel free to try this if you have better way to verify th=
e=0D
series.=0D
=0D
  https://github.com/xzpeter/linux/tree/fork-cow-pin-huge=0D
=0D
Please review, thanks!=0D
=0D
[1] https://lore.kernel.org/lkml/27564187-4a08-f187-5a84-3df50009f6ca@amazo=
n.com/=0D
=0D
Peter Xu (4):=0D
  hugetlb: Dedup the code to add a new file_region=0D
  hugetlg: Break earlier in add_reservation_in_range() when we can=0D
  mm: Introduce page_needs_cow_for_dma() for deciding whether cow=0D
  hugetlb: Do early cow when page pinned on src mm=0D
=0D
 include/linux/mm.h |  21 +++++++++=0D
 mm/huge_memory.c   |   8 +---=0D
 mm/hugetlb.c       | 114 +++++++++++++++++++++++++++++++++------------=0D
 mm/internal.h      |   5 --=0D
 mm/memory.c        |   7 +--=0D
 5 files changed, 108 insertions(+), 47 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

