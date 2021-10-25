Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4843A7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhJYXIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhJYXIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:08:49 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FCEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:06:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635203185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W7Hn/Kt83t0S+ch17NbGso0OFLyAMY1uK7iOcfzdyao=;
        b=a2yVwxZLr9Jvl+2vNVK4+BBs3RKPGnDKm0E1MzT4fssceZ3fMqaYrZ7rGp1wnuZk1SXWif
        kcOHKLioOWYZW35q4/ID7CV20mWJOE8zQQLpUdtTzKg1KUKvuG1oKFrXtJZFiaVQyxZsRY
        j4cB/nCk48Oqno5CyOv6DNPVcTwOVkE=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] mm/hwpoison: fix unpoison_memory()
Date:   Tue, 26 Oct 2021 08:04:59 +0900
Message-Id: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated unpoison fix patchset (sorry for long blank time since v1).

Main purpose of this series is to sync unpoison code to recent changes
around how hwpoison code takes page refcount.  Unpoison should work or
simply fail (without crash) if impossible.

The recent works of keeping hwpoison pages in shmem pagecache introduce
a new state of hwpoisoned pages, but unpoison for such pages is not
supported yet with this series.

It seems that soft-offline and unpoison can be used as general purpose
page offline/online mechanism (not in the context of memory error). I
think that we need some additional works to realize it because currently
soft-offline and unpoison are assumed not to happen so frequently
(print out too many messages for aggressive usecases). But anyway this
could be another interesting next topic.

v1: https://lore.kernel.org/linux-mm/20210614021212.223326-1-nao.horiguchi@gmail.com/

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (4):
      mm/hwpoison: mf_mutex for soft offline and unpoison
      mm/hwpoison: remove race consideration
      mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
      mm/hwpoison: fix unpoison_memory()

 include/linux/mm.h         |   3 +-
 include/linux/page-flags.h |   4 ++
 include/ras/ras_event.h    |   2 -
 mm/memory-failure.c        | 166 ++++++++++++++++++++++++++++-----------------
 mm/page_alloc.c            |  23 +++++++
 5 files changed, 130 insertions(+), 68 deletions(-)
