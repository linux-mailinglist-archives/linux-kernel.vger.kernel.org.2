Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47131445F80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 06:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKEFzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 01:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhKEFzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 01:55:20 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 22:52:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636091557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YSyrIh8bSiwYOiiRxY8T5Sx3HuohXJJhjpAaVHHzT98=;
        b=NnQtiGWIQIEfl1BM4CtRl5sZi9C/m3xNOaM6t1IkoUd1mOMOyIFyrkX7EuVTlvQ/+KQnu7
        miuOzfiApmfgIjN+FqarHeIOvHkOVxLjOpoaXOk9kOac6LFVazXuVP7p87pIW5+5EsboX/
        BEuHBW8jddN7nGiprj+w9dj4GkkSxHg=
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
Subject: [PATCH v3 0/3] mm/hwpoison: fix unpoison_memory()
Date:   Fri,  5 Nov 2021 14:50:55 +0900
Message-Id: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the unpoison patchset based ou discussions over v2.
Please see individual patches for details of updates.

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
 mm/memory-failure.c        | 169 ++++++++++++++++++++++++++++-----------------
 mm/page_alloc.c            |  23 ++++++
 5 files changed, 133 insertions(+), 68 deletions(-)
