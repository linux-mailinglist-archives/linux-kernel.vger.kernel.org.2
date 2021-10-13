Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E00B42CECF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJMWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJMWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:44:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D40C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:42:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r2so3685066pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=ikDUwEUmpJmCVSQIH9hBnefZwbhJyu+GJCyEu9NTaJs=;
        b=Hd/H3KFp/4yGBMmwryOAkEPYdeTP4BbaqhKGktKMNViBXoGM9Gl+n56ukD4CCFVbPE
         snIwTENy+ZQ3gJ9KMn0mVtq7OQoFK5ukC1dLIuxOs55EloU5m+WZwJ3VS3Fj1yfW8zQg
         vO+pWYMoOLsmv7RPbav1f1EsxjHQVjYzQ8NVgP/ezKCFjuFED3qYiNeqNz9ysQfMVDMV
         zE2xlyyhvf4wwdzeL7H3Z7HLEFN63wsBo2Z30mDkNOwc6FeIWuYmSMncrut8MEFxwdEI
         3kCYPDaPDZpsejFLQhApDFiwKfEpwWhrpoyIrBK/nBHLWHq69pToXKKNaqeVeAUWQEn3
         FXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=ikDUwEUmpJmCVSQIH9hBnefZwbhJyu+GJCyEu9NTaJs=;
        b=igIS4ZjqaKyTs6itCb6Q/Q5tXFl2EUSTSIrpC6y4OlIbvVM1c+reDCziBdlvdftR/W
         eWRk22vdd5QzR9AWc/S8ktRRkjHajHrka60IpUAGhm+/yGshWzVNSPq0xIGFGk/yMt46
         8TFp0Hg+CV23llrVgtHIpskdvdfcMXAH3dawwUwE67XOlSTCHi/qhkoTGMeM1dq2wd6W
         A55J9i0RoIv70kHCC2M79uxWQ2/EzfGB61mQu4ZGRo4wj7sn/rNun6TVxlX58rdcozW/
         citQiEhR+6MundukNdesMz0iDt8pGjIRPUaWR7BytNgYCCpLK5b/s1IuopzwBPqQBnFN
         Pzcg==
X-Gm-Message-State: AOAM5307OTT/ZzMV7MOn3zqohgQjC38a/EG1lbvGMJrwqfgogU+zdlMF
        ArvCTLczacW8Dwo980TDebdujHBdXGQ=
X-Google-Smtp-Source: ABdhPJzATWJVdg4WASH91t96Id7+KqonCTO5VKc/vOBeSF7Qz2PP1ZXbU8wRYFdRvMkX4mn0TIdRhA==
X-Received: by 2002:a05:6a00:8d0:b0:44c:26e6:1c13 with SMTP id s16-20020a056a0008d000b0044c26e61c13mr2058175pfu.28.1634164930462;
        Wed, 13 Oct 2021 15:42:10 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id me18sm476240pjb.33.2021.10.13.15.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 15:42:09 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: mm: unnecessary COW phenomenon
Message-Id: <FFA0057D-1A17-4DF4-9550-A8CDEE9E0CE0@gmail.com>
Date:   Wed, 13 Oct 2021 15:42:08 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea, Peter, others,

I encountered many unnecessary COW operations on my development kernel
(based on Linux 5.13), which I did not see a report about and I am not
sure how to solve. An advice would be appreciated.

Commit 09854ba94c6aa ("mm: do_wp_page() simplification=E2=80=9D) =
prevents the reuse of
a page on write-protect fault if page_count(page) !=3D 1. In that case,
wp_page_reuse() is not used and instead the page is COW'd by =
wp_page_copy
(). wp_page_copy() is obviously much more expensive, not only because of =
the
copying, but also because it requires a TLB flush and potentially a TLB
shootodwn.

The scenario I encountered happens when I use userfaultfd, but =
presumably it
might happen regardless of userfaultfd (perhaps swap device with
SWP_SYNCHRONOUS_IO). It involves two page faults: one that maps a new
anonymous page as read-only and a second write-protect fault that =
happens
shortly after on the same page. In this case the page count is almost =
always
elevated and therefore a COW is needed.

[ The specific scenario that I have as as follows: I map a page to the
monitored process using UFFDIO_COPY (actually a variant I am working on) =
as
write-protected. Then, shortly after an write access to the page =
triggers a
page fault. The uffd monitor quickly resolves the page fault using
UFFDIO_WRITEPROTECT. The kernel keeps the page write protected in the =
page
tables but marked logically as uffd-unprotected and the page table is
retried. The retry triggers a COW. ]

It turns out that the elevated page count is due to the caching of the =
page in
the local LRU cache (by lru_cache_add() which is called by
lru_cache_add_inactive_or_unevictable() in the case userfaultfd). Since =
the
first fault happened shortly before the second write-protect fault, the =
LRU
cache was still not drained, so the page count was not decreased and a =
COW is
needed.

Calling lru_add_drain() during this flow resolves the issue most of the =
time.
Obviously, it needs to be called on the core that allocated (i.e., =
faulted
in) the page initially to work. It is possible to do it conditionally =
only if
the page-count is greater than 1.

My questions to you (if I may) are:

1. Am I missing something?
2. Should it happen in other cases, specifically SWP_SYNCHRONOUS_IO?
3. Do you have a better solution?

