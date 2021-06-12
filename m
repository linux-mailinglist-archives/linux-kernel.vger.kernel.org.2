Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9003A4E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFLJtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:49:11 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:42765 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhFLJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:49:06 -0400
Received: by mail-pg1-f175.google.com with SMTP id i34so4487761pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gA36+Qu/57nkq0Sk66RXctcjgNPtwynB7KTlt4954g0=;
        b=He2HYcJkeO+Y2a0BEPzP7w6zmV4ZaW0+JrvY3JJX2HgWx6kChAzLNMY3dPehnfmXmi
         wuK9Hs2J7MAu2n4MQEOOi9t4EO00T+l67LHxPjSpkLuvgpvnhB9H0k/ybFYXr2/ZuhJ0
         83nIrjv2Unnb920e0w9MkaK+FawhFDCgK8T5mTbfuIB1v6dpatuqaAMH7+dsMq/oomet
         8LaeK0tLyBRvM20bDRtg2h+Ks4QdsvpoCrHBG5uWJJxzjdAWf02bTvgXcaJdSTmHHymi
         OwoIwtAylFcX2ENm/UY07Op+QISCsf/y2k/FvKNQKWuNL7YU5lY/K+5bqIRGx6fxWdJN
         89bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gA36+Qu/57nkq0Sk66RXctcjgNPtwynB7KTlt4954g0=;
        b=UgFCPhSA+6Jr8XJ/HQygMda1JkMJE8utHshEU6HiUBwoWXu8a9dDAWf8TuwKMjDXCO
         U2ITixZlc7w7an3mdAdKK+iEo1mxBGl4VchJ263ZdyzzZAwI5qyxm2+LgZb4GT2SNTqD
         QoUpKvvfyChDvj6rPxxCqu/xEcZ7ld8oG0hsfkXA+2JJfTxFhgDG/y+P3XXlS4X1WpEU
         48SEi3nUKz0dCcUIkmAOwsqKW5ogk9ppiWe3ZGliWhS4wKD9DeHpnndQbHFRgUD7+d/z
         w+xGcAyFRHbKIf4E2yh5s7DWIzF2MEmqWDC8t5dwWLEtfpM4ruKZeY8LJEtN3lPURKz+
         lIiA==
X-Gm-Message-State: AOAM533/Etu4j4I8NYOSwThT8K96yVG6y1OsYHrZpD5Jkkegb4Y8xlcM
        qf33yBtz74rWigPIDrR5R/5Z8Q==
X-Google-Smtp-Source: ABdhPJzjvMIBpki2+QrmEYfAaapi7sVu+lRKjPmHd6xRamGe7Rxsj/7f5BJl9/x5reeW6ODPXTSFbQ==
X-Received: by 2002:a63:d08:: with SMTP id c8mr7964471pgl.248.1623491167246;
        Sat, 12 Jun 2021 02:46:07 -0700 (PDT)
Received: from localhost.tiktokd.org ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id t39sm6929557pfg.147.2021.06.12.02.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:46:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/3] Split huge PMD mapping of vmemmap pages
Date:   Sat, 12 Jun 2021 17:45:52 +0800
Message-Id: <20210612094555.71344-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the difficulty of code review in series[1]. We disable
huge PMD mapping of vmemmap pages when that feature is enabled. In this
series, we do not disable huge PMD mapping of vmemmap pages anymore. We
will split huge PMD mapping when needed. When HugeTLB pages are freed from
the pool we do not attempt coalasce and move back to a PMD mapping because
it is much more complex.

[1] https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun@bytedance.com/

Changelog in v2:
  1. Collect Review-by from Mike.
  2. Remove helpers used to preallocate/free page tables for HugeTLB pages.

  Thanks Mike's suggestions. It really eliminate a lot of code.

Muchun Song (3):
  mm: sparsemem: split the huge PMD mapping of vmemmap pages
  mm: sparsemem: use huge PMD mapping for vmemmap pages
  mm: hugetlb: introduce CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON

 Documentation/admin-guide/kernel-parameters.txt |  10 +-
 arch/x86/mm/init_64.c                           |   8 +-
 fs/Kconfig                                      |  10 ++
 include/linux/hugetlb.h                         |  25 +---
 include/linux/mm.h                              |   4 +-
 mm/hugetlb_vmemmap.c                            |  11 +-
 mm/memory_hotplug.c                             |   2 +-
 mm/sparse-vmemmap.c                             | 157 ++++++++++++++++++------
 8 files changed, 149 insertions(+), 78 deletions(-)

-- 
2.11.0

