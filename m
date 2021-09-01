Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466BA3FE44D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhIAU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhIAU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630529788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WGwsIlLycH7PSrcqVoUAvpDy7fMTYvx3ViNhs8JGlmY=;
        b=Zw3bNk9isrPX7dMWPakpp1k72c8CS8LFGsZzJMaydx484Qc5+5VHMGZSClocpvfefy3VJ7
        gKxi8GOsqAPsf4+GPA0F2UMvNBnk0hBsEn4ABsNn+91ebg6oRyf7E/r3LLoXMN+7I4fig/
        7TbPKFgZhKy3yhV4d+8dScZe+HFoptU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-9CCoAESSNRW18s6mzk8cmA-1; Wed, 01 Sep 2021 16:56:27 -0400
X-MC-Unique: 9CCoAESSNRW18s6mzk8cmA-1
Received: by mail-qv1-f71.google.com with SMTP id e14-20020a056214162e00b00375ec21dd99so918923qvw.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGwsIlLycH7PSrcqVoUAvpDy7fMTYvx3ViNhs8JGlmY=;
        b=jOFTfXLEC01+OAttr7ShHkgT8aPi/wS1Iw+5h6EmwUt+4I4U4et++gfeOZxQYWQreC
         Q7nqCGbIRG9VdGIJkUIT862A0z5efo9/Oq3Jhqk7f4VEyiaA3+88YRnBW9V/PfqCzyfM
         URINp9Wk+Zn+wuChFchmPMIzFJpoBx5oPEZRHIM/ezSN65CaV3OI3LhOJAxUF5IOpuRd
         /vTdAE9Xx8oDRIT7igBHgSxfTbjR2qDj2A/fYPeEtOcXFVO1Uc447Mg5rtngccT3uTPQ
         f0v3/chvz440i4oba62upk0iE+ip7h+f00hR5NB2M1SYljXw5VbTdkGbYzLmWIRSSAJJ
         4fXg==
X-Gm-Message-State: AOAM533B7KWxF11FS02QRf9umTtexV4rNFlfjDxc4G3yrhADSBiBXuAj
        NLxlijIiUgbqsQv+EpX839ezg7ZygexVU6Sq9tmpfPbrAvT4J669oUm1P2ouVbuU275XH/atih7
        QKb8XogqpIk0FOLkj3ego8Xj1HkO8oP+AoCTH15ZGF81wh7qXAV0cRfyoAZj+MzmAm0OfedYsNg
        ==
X-Received: by 2002:ac8:7245:: with SMTP id l5mr1401046qtp.206.1630529786273;
        Wed, 01 Sep 2021 13:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQTH3Fbbl+hADtQgnXA4liiinZEcwP8pJ7XE5SqXNAMbWQnOnFMhl0uVFwdcXf9zgb09DAWQ==
X-Received: by 2002:ac8:7245:: with SMTP id l5mr1401003qtp.206.1630529785880;
        Wed, 01 Sep 2021 13:56:25 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f3sm624865qti.65.2021.09.01.13.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:56:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 0/5] mm: A few cleanup patches around zap, shmem and uffd
Date:   Wed,  1 Sep 2021 16:56:17 -0400
Message-Id: <20210901205622.6935-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Based on tag v5.14, but it should still apply to -mm too.  If not, I can
 repost anytime]

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
  mm: Introduce zap_details.zap_flags
  mm: Introduce ZAP_FLAG_SKIP_SWAP

 include/linux/mm.h | 33 +++++++++++++++++--
 mm/memory.c        | 82 +++++++++++++++++++++-------------------------
 mm/shmem.c         |  1 -
 mm/userfaultfd.c   |  3 +-
 4 files changed, 68 insertions(+), 51 deletions(-)

-- 
2.31.1

