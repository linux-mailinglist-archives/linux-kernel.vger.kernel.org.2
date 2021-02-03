Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE030E4C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBCVLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhBCVKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612386520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TNWACLsdv3x1bUbvJdGKEfoXIQ+IjxeD0ZZzcQWojo0=;
        b=YWd7y6XdNRYBFybk8Y6G7P/lYrKRAjxa5tXdDwFa5ovxiwZ7VVjFaAD+FkgIWY+uO/AV/Z
        arigFayGECdK80Y2649du3GiXrY9NrjPL6ZNNvtKgI4ung5mDAnC2o84H8+7Az5UofZ0w0
        iSpoh7o4Q9d2rAdSR89Cp+GF3u6fZIQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-cujoklxGMiqWlx5QmSTZ7g-1; Wed, 03 Feb 2021 16:08:36 -0500
X-MC-Unique: cujoklxGMiqWlx5QmSTZ7g-1
Received: by mail-qk1-f199.google.com with SMTP id g80so666225qke.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TNWACLsdv3x1bUbvJdGKEfoXIQ+IjxeD0ZZzcQWojo0=;
        b=bPSdcOKYQxW4ENLMaSvLKxKh/XhneKTaEJhXvGY6tp0SG+rtdr/e5rWaV5YgNRC27k
         jqFvn351shkGiNeepNnSs7eyMA8SS/g1h10hBG/ViJPZFAR3GZE9C18Ss0N5Wftm+J/4
         tp4jz3I0k2zNigpuWCofp1TaOR9U8o51GEGmizA9QcNlgjVZRnGZLS7/S1D9//LuvD3R
         tsqEDoGvtYfsCdqnnawJavmx6qdupv2H0GIXagpuddIkrJAfSr8DuKsOeJsKp7/nxDGb
         SqeBrJCWuj2CEOBV9cn72+f42hnahLddmnJzSSfsB2GKugGDdLAywdf627CVv0un39xh
         6A+A==
X-Gm-Message-State: AOAM5319roSVQZV6P3/y4ueJJtWJ8P1PZIf8aoOG11N6oq/IvzWApG63
        Xsf99EslON869WUbQ/p9Ln5oxfsa9nDdXEIhqPPEH47TkAb4671qXVstAulvfirkkrn4hiM6C3V
        vFEtKl6ULbt7WU2/iNatItoiXK5zZMM13Jo7eXFQ7GedWaslQKixnAHRLi9r2OUWKoVA3tZvVxQ
        ==
X-Received: by 2002:a37:8dc7:: with SMTP id p190mr4405783qkd.308.1612386515763;
        Wed, 03 Feb 2021 13:08:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWJrU+fowec9PCAB1r46ozvnVAjrHd4MVk+0npIFwtKWt4j/MtEJeFldA6yj6yzHAmK8jpQA==
X-Received: by 2002:a37:8dc7:: with SMTP id p190mr4405737qkd.308.1612386515452;
        Wed, 03 Feb 2021 13:08:35 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id t6sm2507659qti.2.2021.02.03.13.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:08:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>, peterx@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] mm/hugetlb: Early cow on fork, and a few cleanups
Date:   Wed,  3 Feb 2021 16:08:28 -0500
Message-Id: <20210203210832.113685-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/mm.h |  21 ++++++++=0D
 mm/huge_memory.c   |   8 +--=0D
 mm/hugetlb.c       | 129 ++++++++++++++++++++++++++++++++++-----------=0D
 mm/internal.h      |   5 --=0D
 mm/memory.c        |   7 +--=0D
 5 files changed, 123 insertions(+), 47 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

