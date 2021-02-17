Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7A31DD64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhBQQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:32:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232759AbhBQQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8AAWQzQ4/CdL2KkeRSZXE51wd9zmuk6qWVztCiHi//g=;
        b=CQceEvGlqHHV9jnvuD2tKCOBPph7O5DAWFkWDzojTqF7P97b77eisieO0966Sg0RbuTTnO
        TqBipnYe6UZLbo0sbvRcpQyWhxP7Y9CzgRZ0V7KWhnE0ehO0u45MICXCIo3JDQx3dUHd/Y
        nUAU12NaR2RS+nvkueKG6/n89/wawSc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-J-VbdyiIPTiGOwFtbmffXA-1; Wed, 17 Feb 2021 11:31:05 -0500
X-MC-Unique: J-VbdyiIPTiGOwFtbmffXA-1
Received: by mail-qv1-f69.google.com with SMTP id k4so7662814qvf.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8AAWQzQ4/CdL2KkeRSZXE51wd9zmuk6qWVztCiHi//g=;
        b=RjClwqcpCQruCRcpt2DgFeE5cjjC943DrhprjXcI2bLkVjixj/gHJ/rj8hWeX7V1OS
         /Qi26RuutOAlRDL+SAartcIEVwLddPpkWewTs2w1ljtToQyLDT0nE/PLdPfqYQhht0Bs
         uJZjyrpEgdEZZ8iafB8Nbqzc+uIIHCOoOXaxKBpEXRh07zOh/cVJ5FoRu4IE45cTeaOw
         vObccGw+IAfQ6QIZmYIPgC1JXk9HSWeiA6GA1En26YnyvequeJOqyatkWdTWkZLopms9
         6VuRtrAaIbXmeftYhF+mbQj6qGoXi5aXKmJCB8P4CfjAWk3DgKeEGfzE4JhFcSq9zGIk
         cCwg==
X-Gm-Message-State: AOAM5311HsMcNO9BovVZb280vWMC50sm6OpBHVpyuF2EFWd2hzXPhSX2
        k6U8UfO9YpTD1PNYMkYquzO4g6aP1JYdGt3gKBz1cGxTjLrUxg2ASp9ZFs+ljxpmLFhnw8qHhZi
        Sjp6RezuhG7bMjycYy5bubL5L8Vkgsp8MaSSI4vcqDOoG3vP5b5nI1EEmO3RX20gWxWd2Rln8sQ
        ==
X-Received: by 2002:a0c:dc8e:: with SMTP id n14mr34564qvk.6.1613579464319;
        Wed, 17 Feb 2021 08:31:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwY+ynxFfjY7nkB88CerCDQdVqSoB87GQyX3clxID0Vtz7rAhk7euXUgwNUQMp5UuJaLnvT0g==
X-Received: by 2002:a0c:dc8e:: with SMTP id n14mr34530qvk.6.1613579464005;
        Wed, 17 Feb 2021 08:31:04 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z37sm399902qth.87.2021.02.17.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:31:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
Date:   Wed, 17 Feb 2021 11:30:58 -0500
Message-Id: <20210217163102.13436-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to disable huge pmd unshare of hugetlbfs backed memory fo=
r=0D
uffd-wp.  Although uffd-wp of hugetlbfs is still during rfc stage, the idea=
 of=0D
this series may be needed for multiple tasks (Axel's uffd minor fault serie=
s,=0D
and Mike's soft dirty series), so I picked it out from the larger series.=0D
=0D
References works:=0D
=0D
Uffd shmem+hugetlbfs rfc:=0D
https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/=0D
=0D
Uffd minor mode for hugetlbfs:=0D
https://lore.kernel.org/lkml/20210212215403.3457686-1-axelrasmussen@google.=
com/=0D
=0D
Soft dirty for hugetlbfs:=0D
https://lore.kernel.org/lkml/20210211000322.159437-1-mike.kravetz@oracle.co=
m/=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (4):=0D
  hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()=0D
  hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled=0D
  mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h=0D
  hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp=0D
=0D
 arch/arm64/mm/hugetlbpage.c   |  7 ++---=0D
 arch/ia64/mm/hugetlbpage.c    |  3 +-=0D
 arch/mips/mm/hugetlbpage.c    |  4 +--=0D
 arch/parisc/mm/hugetlbpage.c  |  2 +-=0D
 arch/powerpc/mm/hugetlbpage.c |  3 +-=0D
 arch/s390/mm/hugetlbpage.c    |  2 +-=0D
 arch/sh/mm/hugetlbpage.c      |  2 +-=0D
 arch/sparc/mm/hugetlbpage.c   |  1 +=0D
 fs/userfaultfd.c              | 57 +++++++++++++++++++++++++++++++++++=0D
 include/linux/hugetlb.h       | 15 +++++++--=0D
 include/linux/userfaultfd_k.h |  9 ++++++=0D
 mm/hugetlb.c                  | 43 +++++++++++++-------------=0D
 mm/userfaultfd.c              |  2 +-=0D
 13 files changed, 115 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

