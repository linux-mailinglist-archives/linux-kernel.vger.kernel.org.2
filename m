Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651F2450015
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhKOIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:43:59 -0500
Received: from out0.migadu.com ([94.23.1.103]:20119 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236727AbhKOIn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:43:26 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636965625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vPKc0J0OTU/aNWayUNR4Hp99A8Hk13iS7YS1//ccMM8=;
        b=Z1IO+OoRYKg5uzm6nC1VIZpgmkEdg5mhq7yzc9kvbmwKD9UaRjTgzVxEQLZKmXWzt1opSl
        hiQlJk6Ryocau7zezjWnzA0EWamL/Q+g7L1pZN7GmqxsLuxDydlj5yajmnnW14uJdfX8fz
        8m29UubgbtdeGr/FW/b23EsOoCQXtPA=
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
Subject: [PATCH v4 0/3] mm/hwpoison: fix unpoison_memory()
Date:   Mon, 15 Nov 2021 17:40:03 +0900
Message-Id: <20211115084006.3728254-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the unpoison patchset based on feedbacks for v3.

I fixed a typo in patch description and closed raced in
unpoison_taken_off_page() reported by Yang Shi.  As for the build
failure reported from build bot, I commented about disabling
X86_SUPPORTS_MEMORY_FAILURE for i386 at first, but I'm not 100% sure
that someone could use the subsystem for 32 bit system, so I shift to
the easier way (setting MAGIC_HWPOISON to 32-bit integer value).

----- (cover letter copied from v2) -----
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
v2: https://lore.kernel.org/linux-mm/20211025230503.2650970-1-naoya.horiguchi@linux.dev/
v3: https://lore.kernel.org/linux-mm/20211105055058.3152564-1-naoya.horiguchi@linux.dev/

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (3):
      mm/hwpoison: mf_mutex for soft offline and unpoison
      mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
      mm/hwpoison: fix unpoison_memory()

 include/linux/mm.h         |   3 +-
 include/linux/page-flags.h |   4 ++
 include/ras/ras_event.h    |   2 -
 mm/memory-failure.c        | 171 ++++++++++++++++++++++++++++-----------------
 mm/page_alloc.c            |  27 +++++++
 5 files changed, 139 insertions(+), 68 deletions(-)
