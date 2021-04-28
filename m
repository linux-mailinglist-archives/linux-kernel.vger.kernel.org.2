Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7B36E1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhD1WwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhD1WwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pooU5ZMLKkXMJLA5e7oiaebU/wArQl02uO8h9xkGhvk=;
        b=W/qoCp2ljA9BwMDaKe9QGQWdD94XfF0Bljx1r4ES8ywW7p3pyU25Gfl90x9tDnYw2WyG2s
        3LwU69oJ8FschS+8C/nrx9phk+ksvFJ1D52P5iCdKTjU+uPq8TQQQe8eTJUReGRraExcG+
        ORgD35e9qEDs9zJJ4VunNbRdTApAlMo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-YU3LN2tgPKeoiCeTkFJGww-1; Wed, 28 Apr 2021 18:51:13 -0400
X-MC-Unique: YU3LN2tgPKeoiCeTkFJGww-1
Received: by mail-qt1-f197.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so18431040qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pooU5ZMLKkXMJLA5e7oiaebU/wArQl02uO8h9xkGhvk=;
        b=J9iBAHWH+txfRC2cghYqNPeEUqYEHm/bGM98TP+4ZrU8Dbn0JNU8TAVQVfrfek+zEs
         a4zpYO5tqnSKcP13kRdUOh5UV9BCFapaBDQaTM6/+4cKWukFI7r67ZRuLD9O/dzY+Lbg
         lbPIfXLFOR6KlsCHq+jXH/GPovI3zDSmQMLWFEtMUuxgzFX0atGIznx0NjvXZ6RSCLn9
         vNMiiEIwVefJcZvZYdIQVz2TmkBlZMyJ4ObnxUDUhMiFCKIauwOnAU+Mqu+h5sKe6c+W
         0IRzbb+koDSeJyu7GydamvcfpOeP9J1wEP1Zf8l3MhXtnDVRrZZtBCQ+TWXqCAl61qbt
         g0YA==
X-Gm-Message-State: AOAM5333pdw5UyaMpL5hQ2CHT4ugFKEeb0NZVebJMrA+z3p3irOpsZca
        uGulyg30EdZ3M8dbIeP27YqW5TP4jOQfcp+JUchnRCA4W9PUvy2oiaH0nsvvVsde9h+mhekd4n8
        XBqTybq1D/MS/dFUiNK26D3r+
X-Received: by 2002:a37:e508:: with SMTP id e8mr32053928qkg.82.1619650273233;
        Wed, 28 Apr 2021 15:51:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz6tneTK/gPqfHFunV9HPSIM2btpZ/L7qjW7iOF1MGO7e05kOtYMYLy8fnSNLgrS4EN38Ecw==
X-Received: by 2002:a37:e508:: with SMTP id e8mr32053911qkg.82.1619650272985;
        Wed, 28 Apr 2021 15:51:12 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 0/6] mm/uffd: Misc fix for uffd-wp and one more test
Date:   Wed, 28 Apr 2021 18:50:24 -0400
Message-Id: <20210428225030.9708-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on (mostly) v5.12-rc8-mmots-2021-04-21-23-08.  It trie=
s to=0D
fix some corner case bugs for uffd-wp on either thp or fork().  Then it=0D
introduced a new test with pagemap/pageout.=0D
=0D
Patch layout:=0D
=0D
Patch 1:    cleanup for THP, it'll slightly simplify the follow up patches=
=0D
Patch 2-4:  misc fixes for uffd-wp here and there; please refer to each pat=
ch=0D
Patch 5:    add pagemap support for uffd-wp=0D
Patch 6:    add pagemap/pageout test for uffd-wp=0D
=0D
The last test introduced can also verify some of the fixes in previous patc=
hes,=0D
as the test will fail without the fixes.  However it's not easy to verify a=
ll=0D
the changes in patch 2-4, but hopefully they can still be properly reviewed=
.=0D
=0D
Note that if considering the ongoing uffd-wp shmem & hugetlbfs work, patch =
5=0D
will be incomplete as it's missing e.g. hugetlbfs part or the special swap =
pte=0D
detection.  However that's not needed in this series, and since that series=
 is=0D
still during review, this series does not depend on that one (the last test=
=0D
only runs with anonymous memory, not file-backed).  So this series can be=0D
merged even before that series.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (6):=0D
  mm/thp: Simplify copying of huge zero page pmd when fork=0D
  mm/userfaultfd: Fix uffd-wp special cases for fork()=0D
  mm/userfaultfd: Fix a few thp pmd missing uffd-wp bit=0D
  mm/userfaultfd: Fail uffd-wp registeration if not supported=0D
  mm/pagemap: Export uffd-wp protection information=0D
  userfaultfd/selftests: Add pagemap uffd-wp test=0D
=0D
 Documentation/admin-guide/mm/pagemap.rst |   2 +=0D
 fs/proc/task_mmu.c                       |   9 ++=0D
 fs/userfaultfd.c                         |   9 +-=0D
 include/linux/huge_mm.h                  |   2 +-=0D
 include/linux/swapops.h                  |   2 +=0D
 mm/huge_memory.c                         |  36 +++---=0D
 mm/memory.c                              |  25 ++--=0D
 tools/testing/selftests/vm/userfaultfd.c | 154 +++++++++++++++++++++++=0D
 8 files changed, 206 insertions(+), 33 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

