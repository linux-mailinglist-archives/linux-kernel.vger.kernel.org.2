Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7357A32D7DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhCDQd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237815AbhCDQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZUXTrjCiBnFBfW3I1AJm2v8RBKCC0eFrzGXvwdchW8I=;
        b=Vq7dMBd5/37pyKP4CDv5u7k3OQuVBdZfCSMwEvguDrHYKV+2Wb+ISwT02XUSHQpd9qRLeM
        vA+FKxzde6kY2ZuKAdJVH1gFFWVqyeXNDO1k4FYbbFe/zs8F4zMGLUSFyZhBaq0ae8ZPyK
        BFIYhbETVl+7Afdrf0YaN54LpdaxjP4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-CNdN2SOAOyuNoKEs3_saSA-1; Thu, 04 Mar 2021 11:31:43 -0500
X-MC-Unique: CNdN2SOAOyuNoKEs3_saSA-1
Received: by mail-qt1-f200.google.com with SMTP id r1so19320050qtu.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUXTrjCiBnFBfW3I1AJm2v8RBKCC0eFrzGXvwdchW8I=;
        b=eLDxNp+KRAc5od6y8aP/hkbAeFcuGhUD6djdVX0VhMj2t/O12EyMR3Yl9NJieoLwwl
         lr+PHQa6QmZsnFnUx7dM2MfUWBpoAWjAzWAoa+o3upxeNhIu/rRRTybFfD0XYsV3jDf4
         FYh6k1tm7wNczAqKY5ALgy3CF8rZmJ5MpwtOnEyqEmL81JiqhC03HlDCFPhZFz3ZV/KU
         ++Djf3RQNiJZab85rnwA3O/anF5cRfj+SYYB2Z8e1od4+P35pE4lm96jXKV3QbY0sqs+
         UzktOatrGPS7pEDtfkDbGuFPPsBQq3q7dRVdFg43DxsZGEjmr/dpKOZsCMp7782dw3fs
         EAww==
X-Gm-Message-State: AOAM532j97DbhavjmS1ZV95GQ7z3ZufsbpyuVSbLuhBIUsPlLlJrOE85
        HlFPupS4JJFCnZytDRt0PUauBW5kWPKWz2UCt79nHxBe/ZuK7J9TYmem82iutcY2audY277Ilj9
        LJ2HJvPRtMWg0Sfhe2VZ1Hr88
X-Received: by 2002:a05:620a:887:: with SMTP id b7mr4600091qka.215.1614875503059;
        Thu, 04 Mar 2021 08:31:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRwA8NqRHMC76ampCa9culrt7kttzspJbhFtBwbLgYJh88JCUd4TvyBMqBdtoeCEtTi0yNxg==
X-Received: by 2002:a05:620a:887:: with SMTP id b7mr4600063qka.215.1614875502794;
        Thu, 04 Mar 2021 08:31:42 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id r2sm51753qti.4.2021.03.04.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:31:42 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        peterx@redhat.com
Subject: [PATCH v2 0/4] man2: udpate mm/userfaultfd manpages to latest
Date:   Thu,  4 Mar 2021 11:31:36 -0500
Message-Id: <20210304163140.543171-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 changes:=0D
- Fix wordings as suggested [MikeR]=0D
- convert ".BR" to ".B" where proper for the patchset [Alex]=0D
- rearrange a few lines in the last two patches where they got messed up=0D
- document more things, e.g. UFFDIO_COPY_MODE_WP; and also on how to resolv=
e a=0D
  wr-protect page fault.=0D
=0D
There're two features missing in current manpage, namely:=0D
=0D
  (1) Userfaultfd Thread-ID feature=0D
  (2) Userfaultfd write protect mode=0D
=0D
There's also a 3rd one which was just contributed from Axel - Axel, I think=
 it=0D
would be great if you can add that part too, probably after the whole=0D
hugetlbfs/shmem minor mode reaches the linux master branch.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (4):=0D
  userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs=0D
  userfaultfd.2: Add write-protect mode=0D
  ioctl_userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs=0D
  ioctl_userfaultfd.2: Add write-protect mode docs=0D
=0D
 man2/ioctl_userfaultfd.2 |  81 ++++++++++++++++++++++++++--=0D
 man2/userfaultfd.2       | 111 ++++++++++++++++++++++++++++++++++++++-=0D
 2 files changed, 187 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

