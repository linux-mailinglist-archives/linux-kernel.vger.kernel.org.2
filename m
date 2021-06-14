Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F453A5B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhFNCOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhFNCOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:14:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92770C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g4so8866616pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQnybCIkX2nlwJQ89tO2iOaMNTDW/dZcZ/YUuyKE+JM=;
        b=dboEhjcUsrGWHDsB4gZx0K17gVrE8vYYHbocPhRD1C+3zDTTZoYiM7y5R/I+lKxBpq
         dPiBvn+5PF3B4IY7xy79asZZEvTj92v85KGjQFsJMrp83/xeYmODXycgIoDkDqePs8Bz
         LSzxwcsmXZS9MBUSsqUcxGvHyC6sENC1YN1uHqOCIABgUGdAuDKrEZR4YCmEYod+LY75
         1alzg5gyNGCpioQL4AOmoxa4pcTHb27GaYPX92BLObuUzzzTkP3nUfbExvvtii1AEdvO
         Ii2TE0tdpQfrGV0p27go35g6fxfCF02Jd5CgENt5C5TSrBgZl08D5pXusmD9rGTm7zwf
         0QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQnybCIkX2nlwJQ89tO2iOaMNTDW/dZcZ/YUuyKE+JM=;
        b=eV8ZsP+oeowg5C2eSYt5FSRcr5wn0XXB3nkC/TRXrmMR7Ol9IY8ZxDJdELsTjAjXG1
         SbMQaCgsde2zGSR3kjYMuVkJc48PER2i+D5My+MeEhI6tWbZC2SRkqDlkIH/k2FXfRTi
         RUrBielXWqzg2CG2qPyRgX6cUFA5LHno8OqhlNMKlahspYggL1PcStvsfCRlTNI6opQu
         aVMTogGvMk+pTsrhCbTIq9dDK8dZKWprbcRXZi6VjMOZsSFADf2rTaeSZL8uS4Vp67cJ
         WBCT+5F3O9r1cJOe2pmfWIpMsE9fqnGXUwqvifBjjRibr1NC8FImikpjOKOKgGr/sy3+
         MUFA==
X-Gm-Message-State: AOAM5317JynIVWyV8HG/vnGWTWrsuRwnvix/pBhHESKpwZka1WtEUfTr
        gijs0LQHRNWCKjUGuXUlPA==
X-Google-Smtp-Source: ABdhPJyhzSQEB1ODo82x1PnndemLBZxpkBIIv8tiryw0zjoY7SA5yX4sOfXeuyewMRHwrmY4TGhCTQ==
X-Received: by 2002:a17:902:d4d0:b029:113:fb3d:3644 with SMTP id o16-20020a170902d4d0b0290113fb3d3644mr14578776plg.58.1623636745667;
        Sun, 13 Jun 2021 19:12:25 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:25 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] mm/hwpoison: fix unpoison_memory()
Date:   Mon, 14 Jun 2021 11:12:06 +0900
Message-Id: <20210614021212.223326-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is suggesting to adjust unpoison_memory() to the new way of
isolation and refcounting of hwpoisoned pages.

As mentioned in [1], NR_FREE_PAGES is incremented via newly added function
undoing take_page_off_buddy(), so the counter is consistent with this series.

It depends on some other hwpoison-related patches (not mainlined but in linux-mm),
so I listed the dependencies here:

  - mm/hwpoison: do not lock page again when me_huge_page() successfully recovers
  - mm/memory-failure: make sure wait for page writeback in memory_failure
  - mm,hwpoison: make get_hwpoison_page() call get_any_page()
  - mm,hwpoison: fix race with hugetlb page allocation
  - mm,hwpoison: Send SIGBUS with error virutal address
  - mm,hwpoison: Return -EHWPOISON to denote that the page has already been poisoned
  - mm/memory-failure: Use a mutex to avoid memory_failure() races

Or GitHub branch I pushed for easy patch access might be helpful for reviewers.

  git fetch https://github.com/nhoriguchi/linux hwpoison

[1] https://lore.kernel.org/linux-mm/20210527003436.GA3543069@hori.linux.bs1.fc.nec.co.jp/

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (6):
      mm/hwpoison: mf_mutex for soft offline and unpoison
      mm/hwpoison: remove race consideration
      mm/hwpoison: introduce MF_MSG_PAGETABLE
      mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
      mm/hwpoison: make some kernel pages handlable
      mm/hwpoison: fix unpoison_memory()

 include/linux/mm.h         |   4 +-
 include/linux/page-flags.h |   4 ++
 include/ras/ras_event.h    |   3 +-
 mm/memory-failure.c        | 176 +++++++++++++++++++++++++--------------------
 mm/page_alloc.c            |  19 +++++
 5 files changed, 126 insertions(+), 80 deletions(-)
