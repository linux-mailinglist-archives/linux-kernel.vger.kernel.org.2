Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141AD35D3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbhDLX2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244732AbhDLX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618270079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B3MciDovAET7AdKaJb34X6uAEc0eUn8r5vV5LysAEI0=;
        b=Fz1YrF9QH8bw1O9dsL3Biwn7wRVd9ycfDrSFrSVjxNPLrd6MLrUDcl6rNulzV5VfDRTICw
        9pDi9qxEYYGmacx6cE+Nrr11b9wPBChP3qzf7eFsPVxT5bj+v9BmrhiYjngAbHEX0z3AAu
        PNbulcSPdfoKYBoI6iO6tMgIPKYeUYY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-bmmwlZyEMv2gGs497nqK8w-1; Mon, 12 Apr 2021 19:27:56 -0400
X-MC-Unique: bmmwlZyEMv2gGs497nqK8w-1
Received: by mail-qk1-f199.google.com with SMTP id 79so3491958qkm.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3MciDovAET7AdKaJb34X6uAEc0eUn8r5vV5LysAEI0=;
        b=a6ux8mIiqE9d6DsrB8CPYMij/FmBknmbo5VFEcykp6JeLM806W4HC7olTFYEo9oN42
         aGtDnHRm7njyUr2mSQOXgqdCMv0GlVg6QkKn23B+tUXvvosDLlol1Wx3zQ6U6s3OMi4x
         TsKePn95BfjgZDIOsw5wmUvE1S8aBKbxbLJ4mQiMZaf6g6YIUPwcvWBKhEHWVJ5Fs3N4
         5bPyCs3wwshUkuvt4TuAZ7KTkYrm48/I/Tz6E7ps++PoNE4Ycl8QE4ezvJb2zviwBcw/
         pLglnOpkAtJJoPJmDju5gzEmXotJCrwNXalN4A3PLu4pu+q5utK80hpFBOqc4Cduc1UG
         pxdQ==
X-Gm-Message-State: AOAM531ap86kK0KHF3fTO+tj5ynbtMzulPULxZmnUtabAvKIXCqw2wS7
        dGMhNrH/CHl6o3CIb1g8O1UJZQeZ27WwrPFHJC+PKJC5B4qO0QduhOGBJ2GSchRiY2t4rJK9sp2
        TCVDw5nPXNs4WN3bs0FR2Vvup
X-Received: by 2002:ac8:4899:: with SMTP id i25mr15885739qtq.59.1618270075672;
        Mon, 12 Apr 2021 16:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9oKrYFJovLvCdWOPw1lzMa5WybRJob4vZYvb0D1NdJvR0XacKd6O0BbBXdl435m22pa3oug==
X-Received: by 2002:ac8:4899:: with SMTP id i25mr15885710qtq.59.1618270075445;
        Mon, 12 Apr 2021 16:27:55 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id y29sm8958925qtm.13.2021.04.12.16.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:27:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 0/5] userfaultfd/selftests: A few cleanups
Date:   Mon, 12 Apr 2021 19:27:48 -0400
Message-Id: <20210412232753.1012412-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:=0D
- rebase to v5.12-rc7-mmots-2021-04-11-20-49=0D
- collect r-bs from Axel=0D
=0D
I wanted to cleanup userfaultfd.c fault handling for a long time. If it's n=
ot=0D
cleaned, when the new code grows the file it'll also grow the size that nee=
ds=0D
to be cleaned...  This is my attempt to cleanup the userfaultfd selftest on=
=0D
fault handling, to use an err() macro instead of either fprintf() or perror=
()=0D
then another exit() call.=0D
=0D
The huge cleanup is done in the last patch.  The first 4 patches are some o=
ther=0D
standalone cleanups for the same file, so I put them together.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (5):=0D
  userfaultfd/selftests: Use user mode only=0D
  userfaultfd/selftests: Remove the time() check on delayed uffd=0D
  userfaultfd/selftests: Dropping VERIFY check in locking_thread=0D
  userfaultfd/selftests: Only dump counts if mode enabled=0D
  userfaultfd/selftests: Unify error handling=0D
=0D
 tools/testing/selftests/vm/userfaultfd.c | 649 ++++++++---------------=0D
 1 file changed, 208 insertions(+), 441 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

