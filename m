Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438BC3FD7AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhIAK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhIAK23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:28:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38FDC061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 03:27:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w7so2251212pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdLWPNlr2o2VGQKs6yMiulbcewjUkJEpjEDyxs856Jo=;
        b=HQh5dd3NEOPvmgmvw5Hm2HI//JYez9GvSeWCvLHE/l7cDlybq6m5QB/DQw2oFnbUyX
         6lqNLpQ7aR/qL9dBjLIPOvIQwlCE2UuJGeK1E6qBpZyGk7N0i4Nnvzg2aAAtEV6Y+0mi
         RhEQkI2zxhc/clSNpvArSD/j/fqeSH6Zz6uThMdrOdyV8vWmGjT7wioKUr02+NeDOyad
         dDw4gKSKZFnmmeZ+Sdx8alU22hPKmQJbhBzyreDjkQ3XREdtwb08Xld6QaL49vOyH+JI
         zMtp3UOu7lCzZreZaPiCdMz6P3BlzfYjs59ljp1Rad46Jrkc/ytjyoTa8O71uRlhAKgP
         Vevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdLWPNlr2o2VGQKs6yMiulbcewjUkJEpjEDyxs856Jo=;
        b=hql9ROW51gQCQK0SQdc0hsH8908GVkUPrrzwj0yfIJrezVgTD7oaJMlgu7ksIsGaha
         j8d0BydkWBwox5qjG7NjQebVnFEVV79ouEpm5iBmjXL+D/zkYTgzlDtS+7FVqh3GAnLh
         kLkiPYQx+6oUIOh9etszXKdnLkdMjUczAFgGyB6F4SOp9xdjE5za6f//16wU0R7hxruE
         3OHA3KLvR/bxojqrn3+jQlDiMLN4WsSbmnb5gb7c5ezJPVPKA0X6qM5Cf9ia4krCvytS
         PH8TL1m3AFGTlDVr4W5Oix5POVWl7kzmC+NYdGVqgMel6FeiVZxQSrOYVFMA458O62fC
         iKOA==
X-Gm-Message-State: AOAM530pQsAzUQwr8dzQvh3N/hpQJTzIaKqaUMWzC8ef67ie9lmnig0a
        2BB/jy2hGSTMhrUuN2U4IeMw5A==
X-Google-Smtp-Source: ABdhPJxwN7E+eBlVRqTpWQPGRAkwixB/l2TIHvOUXhSDO+sI8n8sfWMEdbyDMhle95rN6O8ZZqsmHg==
X-Received: by 2002:a63:515f:: with SMTP id r31mr31104283pgl.41.1630492052286;
        Wed, 01 Sep 2021 03:27:32 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i10sm5291497pfk.87.2021.09.01.03.27.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:27:31 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, vbabka@suse.cz
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/2] Do some code cleanups related to mm
Date:   Wed,  1 Sep 2021 18:27:20 +0800
Message-Id: <20210901102722.47686-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series aims to do some code cleanups related to mm.

This series is based on next-20210827.

Comments and suggestions are welcome.

Thanks,
Qi.

Changelog in v2 -> v3:
 - Move the declaration of pmd_install() to mm/internal.h

Changelog in v1 -> v2:
 - Fix some typo and code style problems.

Qi Zheng (2):
  mm: introduce pmd_install() helper
  mm: remove redundant smp_wmb()

 mm/filemap.c        | 11 ++-----
 mm/internal.h       |  1 +
 mm/memory.c         | 86 ++++++++++++++++++++++++-----------------------------
 mm/sparse-vmemmap.c |  2 +-
 4 files changed, 43 insertions(+), 57 deletions(-)

-- 
2.11.0

