Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0232CA44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhCDCBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhCDCBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614823191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sq1tD+qIhDKcPVuMY+0/NbRCjsPd/XcDmOMne5PWlg4=;
        b=fGsacpWQ7nepgTlIU1stf73W1Q7OGHBR5WuqXZ/XkuoyfX7/1xwU72Mw9PLmwgBIPh8AdH
        KOcUAP5mGAuYsYwKts1rtrbKo/+1coHluumLtWn/a0jXNeItt8vVFpqdZVvMiGZ6llZ5b7
        0FcXUka8ZQ/z5Tta56I6uftzKQxM6EQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-FjrZ0Jo4Oya6aVl93_XSlw-1; Wed, 03 Mar 2021 20:59:50 -0500
X-MC-Unique: FjrZ0Jo4Oya6aVl93_XSlw-1
Received: by mail-qv1-f70.google.com with SMTP id d15so19194297qvn.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 17:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sq1tD+qIhDKcPVuMY+0/NbRCjsPd/XcDmOMne5PWlg4=;
        b=OasrwG/q/fDV+W9pU3pDnz5sBd6PFnfIRoRDERqrdpo6AB3SWPl7ZYFsg9DcOvFg/Z
         PQduKGyB4oZHDLgJpJER5e2Yt0HFUKWwdeCe1+uYywICWifZy7Vs2zBCOZkazx97FkzS
         0CHTRrf8iPbDit0puBy9GPh9I7/JyXpYM5PxMd81j33zvMJyb851wEgUkuXqMNObP2+9
         r/jLOfFnmvG5QlHX7hfAec+lOLXOzL/AdhzCoV7upVPGp33XarqQww6EExu7ltStbYdV
         QfqnLnG72UNU0sNePH+VTQtO6ngeW5BmHWyoqZo/jZqqj1AtkxTwFzgKkZfWQxf4lW7g
         0sXQ==
X-Gm-Message-State: AOAM532HegWKr63BTftfClDaey0scSoW6try6YnY47noh+JgVGngPMRO
        a4KUIv2isEH7ZRmY1XoSvzOvIEpbTiZPs/OS51+CLmRv046L+mGPlsYBmiPRAZYlHs1iNBVqjNV
        NU98cQyGHIcZs4VOI/CrVwrTu
X-Received: by 2002:ad4:4745:: with SMTP id c5mr1962090qvx.39.1614823189977;
        Wed, 03 Mar 2021 17:59:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKaFDzEco3K3IFwsQ3Nb0GPSDjOHiuxrPj551VzvZ2UgpYay1hmhbaX+t8O6dQd61O4MxVUA==
X-Received: by 2002:ad4:4745:: with SMTP id c5mr1962074qvx.39.1614823189755;
        Wed, 03 Mar 2021 17:59:49 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b7sm18610766qkj.115.2021.03.03.17.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:59:49 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 0/4] man2: udpate mm/userfaultfd manpages to latest
Date:   Wed,  3 Mar 2021 20:59:43 -0500
Message-Id: <20210304015947.517713-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 man2/ioctl_userfaultfd.2 |  76 +++++++++++++++++++++++++++--=0D
 man2/userfaultfd.2       | 100 ++++++++++++++++++++++++++++++++++++++-=0D
 2 files changed, 171 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

