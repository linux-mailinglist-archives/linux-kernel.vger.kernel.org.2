Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D739AEC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFCXjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:39:43 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35524 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:39:42 -0400
Received: by mail-pg1-f173.google.com with SMTP id o9so3537666pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyWrZ/fldASwaRIjyLrjp+HYBRR0gb/AZVj+sEux4qw=;
        b=VfPcGKLKcV1UvPky+z40TYyNslXUcxSrzTqzkRD4JUSH9hyXVkG1StNSaAXCILipA5
         TrUq6lZF/QJobkfPwLmx0cmU0zoTUkDw2m8h88Twv9wAFbZdowb8t8cOZAqHb2A+B1UW
         49U8c02lu2656N3PIQdQ+hXh11/3kT9L15UKUXSUQX1p2m3K0Js8nTCaRqmkwZufsA3i
         sQum8nq7IoFwWcD2X4Jf94veDKfTqYVoeqeR48QrmoPmCbNfJzDKjIG6NiC4nhRy90VZ
         A5D+YhquxcedYb/fCRYMR5a8ZWWuVeNH2qstkH7G52Kv2tLyLi0waEA0FJrgds9Yy+RM
         3BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyWrZ/fldASwaRIjyLrjp+HYBRR0gb/AZVj+sEux4qw=;
        b=bFzCm/7hfx+d23bOLegeJ92BHLcGgUPkVutkzn2hw7sq1rTkV6fi/pf7/BqtGOB7Cv
         7zQ0HG5JNznWRT3f/J3GrU5E4hq305AvLFBddkj+eEi7VT1gVKAeHcpFN42sIdTtJAFK
         5xGEyMea4JOePkbogzziCRx607VZUUYvAAds/Qz2thY2XgNir/Wiqka4GxvaffdZ7j/Z
         MpRKHfQpECKcrLR21gFWVpC3iH5tHNflYV6LfLJZ4SQCmezYiqEP8n+CbIbaRFAqNfq6
         uLA4UDAljFE0qjD+n2ivipzy6lha6tItSzWfQT68PldKXzd5XZQw7qVLBQ5HQnYeHYbC
         YbAA==
X-Gm-Message-State: AOAM533NXhpFX52AFxPJQI/LQMq6lwPPxnrFEWJVjP1B7gMNH2M+Hhaq
        cHh7+9pqb+1SIytRNmWSqw==
X-Google-Smtp-Source: ABdhPJx2dbTC9BXjmrf0FMu9CyUelUCkfndfRJhPix6D8xCGbCIJV9f0o9a2eDgk/lk2ZHA4/7+K0g==
X-Received: by 2002:a05:6a00:1c4d:b029:2e9:c839:d2d with SMTP id s13-20020a056a001c4db02902e9c8390d2dmr1577514pfw.5.1622763401249;
        Thu, 03 Jun 2021 16:36:41 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id gg22sm3009818pjb.17.2021.06.03.16.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:36:41 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] hwpoison: fix race with hugetlb page allocation
Date:   Fri,  4 Jun 2021 08:36:30 +0900
Message-Id: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the v6 of the fix of the race between get_hwpoison_page and hugetlb
page allocation.

Thanks,
Naoya Horiguchi

v5: https://lore.kernel.org/linux-mm/20210518231259.2553203-1-nao.horiguchi@gmail.com/T/#u
---
Summary:

Naoya Horiguchi (2):
      mm,hwpoison: fix race with hugetlb page allocation
      mm,hwpoison: make get_hwpoison_page() call get_any_page()

 include/linux/hugetlb.h |   6 ++
 mm/hugetlb.c            |  17 ++++
 mm/memory-failure.c     | 219 +++++++++++++++++++++++++++++-------------------
 3 files changed, 157 insertions(+), 85 deletions(-)
