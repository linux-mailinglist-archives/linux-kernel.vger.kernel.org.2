Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98924370796
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEAOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 10:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhEAOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 10:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619880077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YnWb2IPj59++E0ETRcLd7/SnBjta6bFGoaxLShBdHqM=;
        b=es7+bN8wlWsss+DV6DdLNbQ3LdELz8r8WrF6PTyasvD/zGAb2Co/faQgY6PSWwM1LgStpu
        lTCts/uIwJ/alStYBaRXyKMyKh92hEU9SapkxsqnWWioBV7K9oE8vYg4ctUOyq1w18Q+x4
        UWhPnKufvcLHDOupmouHVNsLx0NFQ1E=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-kk3wWE0HPsCzf94gEYXoCg-1; Sat, 01 May 2021 10:41:15 -0400
X-MC-Unique: kk3wWE0HPsCzf94gEYXoCg-1
Received: by mail-io1-f69.google.com with SMTP id z25-20020a05660200d9b02903de90ff885fso574717ioe.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 07:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnWb2IPj59++E0ETRcLd7/SnBjta6bFGoaxLShBdHqM=;
        b=bf/OBpyvx6mHxXy5Sz5vuB17O6q/GDCYuDBRfq9AF98iD0qS67NMHazeTrvMteFpYY
         8+hw9RceFvio+AbwGTsr0qq5RqNBO/4lCQ96KOMxHzD5zRsLRxmdAf2GE3KRAznV2x6F
         CO+4fLkJuiw9jeQ3+XNF1TopRCt6U9blCEfebKZEdC6zgrwW03qGw9fhybjLARpD2dQZ
         qLG82NxKKQwRLgC4tQheVJQg/dNia6KwH2I2wxobApRmGtoZHqO776UtQ+B21AdOroxl
         iEP5NW4/lWBm2zCXxaBJKaNx3f8UoWDcq7vn2OoJCHWl2a5zoLSr6N1wORG+GZdSsuz3
         Sa1Q==
X-Gm-Message-State: AOAM530R1aJRU1txeGMeBN2NbK88Cta78ze7NfeHd+7fVqZNPwm0xfbC
        DdN1nyHTSdhMQdx5Pmzf69/IAIsJAE46nmqHyPp/+d60v/DNqaUe68rYbtQcQVZLLyYRgHYBcGE
        xyTTWjbKscfM2PTLr5o25Sqv3
X-Received: by 2002:a5d:80d5:: with SMTP id h21mr7790083ior.11.1619880075174;
        Sat, 01 May 2021 07:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk5BPbkl7SuSYEyonzwXYuuG8gmydSHTQr3+3evv96mDR8iybcSTj18drwijRs3fWsXT+7ig==
X-Received: by 2002:a5d:80d5:: with SMTP id h21mr7790067ior.11.1619880074946;
        Sat, 01 May 2021 07:41:14 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id k2sm2649343ilq.71.2021.05.01.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 07:41:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 0/2] mm/hugetlb: Fix issues on file sealing and fork
Date:   Sat,  1 May 2021 10:41:08 -0400
Message-Id: <20210501144110.8784-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh reported issue with F_SEAL_FUTURE_WRITE not applied correctly to=0D
hugetlbfs, which I can easily verify using the memfd_test program, which se=
ems=0D
that the program is hardly run with hugetlbfs pages (as by default shmem).=
=0D
=0D
Meanwhile I found another probably even more severe issue on that hugetlb f=
ork=0D
won't wr-protect child cow pages, so child can potentially write to parent=
=0D
private pages.  Patch 2 addresses that.=0D
=0D
After this series applied, "memfd_test hugetlbfs" should start to pass.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (2):=0D
  mm/hugetlb: Fix F_SEAL_FUTURE_WRITE=0D
  mm/hugetlb: Fix cow where page writtable in child=0D
=0D
 fs/hugetlbfs/inode.c |  5 +++++=0D
 include/linux/mm.h   | 32 ++++++++++++++++++++++++++++++++=0D
 mm/hugetlb.c         |  2 ++=0D
 mm/shmem.c           | 22 ++++------------------=0D
 4 files changed, 43 insertions(+), 18 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

