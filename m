Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314873723AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhECXo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhECXoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620085441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3fYq5mzdiVLYR3uQAPzvtmbf3ClYTT9NmMwFA9WuD6A=;
        b=D+e523EiQOkLQRDLJRQapQ6k6ftjZpPyrDJcio03nvwWS14VtzkmVn9IfEc7aoVgUBlYK6
        iAIKi9M9TpK60B6UQJknIypPPP0wK21CNqD99Fbm4/bvdocwOmyy/GtcusAOwQEXYTWOs5
        vl8QWEg/ZmflbAkD/br8XMNnBzmER9A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-MbMXyXbuN7-vYb-8mBmYNg-1; Mon, 03 May 2021 19:43:59 -0400
X-MC-Unique: MbMXyXbuN7-vYb-8mBmYNg-1
Received: by mail-qk1-f197.google.com with SMTP id g184-20020a3784c10000b02902e385de9adaso6360217qkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 16:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fYq5mzdiVLYR3uQAPzvtmbf3ClYTT9NmMwFA9WuD6A=;
        b=hTWTBcT2LO4WVebCrHUbbYGobFVLWVshQcdRFkXd3g2YvIA8KStJOckBSDNW8QZKdg
         fv3Ze4k0vskeJMIBPDI7KL9C8N5DcdBQYPxFxpLGrolfUHthVq6hTCK2yYIw9FUB5RTW
         ZRFYpr37tmX6rjq29LrQl1U5auovXn7Tx0dAY1PCOqjeZdoMxmywVKKJ2KWuC8XO9ggd
         KwXKwEY9gySazKGbCw1zi/AneHAQpvy1JACCD6ze2mHjI0zuBbe5F8liBeey/JhdIliL
         sS/905eMhDV/bMESdizRZQXuJojtELqac7uhIopm5GbeDZVwY3I4evy/f3GsJXxUwAeI
         HGRA==
X-Gm-Message-State: AOAM531EhzIaqtQ6kKErds4m20vJIzOIyKDB1fEUIaZQuJVBu8z7HFCy
        oZwZZ/mKj38SrrpFPE7rSlhApFTYpHSrw4BjXu28PBCImFXDjKX/HO4JH1ZZFEG+XYHcncNXFMo
        fA931GldXJ6xaeqhHLua6Ka3Z
X-Received: by 2002:a05:622a:1353:: with SMTP id w19mr19450485qtk.220.1620085439446;
        Mon, 03 May 2021 16:43:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxTyuLUzDxfS+UClhTwGlq0AuDhUV/Ozzsq4b3IVfnQWYBAv7mJo9VQwKl+d/SYCj1EIDB4w==
X-Received: by 2002:a05:622a:1353:: with SMTP id w19mr19450461qtk.220.1620085439211;
        Mon, 03 May 2021 16:43:59 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 189sm7126903qkh.99.2021.05.03.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 16:43:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v2 0/2] mm/hugetlb: Fix issues on file sealing and fork
Date:   Mon,  3 May 2021 19:43:54 -0400
Message-Id: <20210503234356.9097-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:=0D
- Move seal check to be after setting VM_HUGETLB [Mike]=0D
- Rewrite commit message for patch 2, explaining more on why it got broken=
=0D
- Add r-bs for Mike=0D
=0D
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
 mm/hugetlb.c         |  1 +=0D
 mm/shmem.c           | 22 ++++------------------=0D
 4 files changed, 42 insertions(+), 18 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

