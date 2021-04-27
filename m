Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF436BF50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhD0Gas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhD0Gaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:30:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6484BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:30:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e15so3880606pfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aGegkQjwMUtviPo4UcR/9R+s7d5J718KkDbEu1QhUk=;
        b=CdiuVYnDc91r61NEtGapjJljYlO6Cd42QkAJrkzxP4qI4NX0MGCtEjsQSFAlJGCDfW
         yrKsNFg+BtTyE/E+KzuZMT/+wGbZ//XwLlzZOc85UGL8AQvPWmOQpyMwysYSE7dgjXvJ
         rIOi8H81LuWlqxKiRLwr+aJ3wIDW5dnDVQu6CXljR+hEV5BU4S9/p0L3fakfmWRT83X/
         GbO+3Sc6VLNxln6+RU+23c405JPfltlmUHMM+mDLp7w8m/Hpjgd9Mlo3snQx7ecIDIaj
         PbD/AcKqDMylOjYTZHdZQ5GSvwBqv6b1KyWIH1XgMvso/kvOMSl6Rm1sNjG8I/XM7519
         S9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aGegkQjwMUtviPo4UcR/9R+s7d5J718KkDbEu1QhUk=;
        b=d0TrYEHgxrJ0xqQyhBt212ISl4OQBsVbjg5AU2faqs/gz+kLH6lX8Yowl1l/h43EMu
         jzELOluQuBA07mpQYOKf4b9mkwlcCUQUXbZ8nafNLTREBtE+ALWNyrH0xN6VK1uv759F
         JU0LP6EnBCnvfffpKA/yqjuZYm7iD+PQI9n354c9vbAEN3FWhc2iRWKfMpptQP+I73oo
         veqc0gEjjSn7I2WDRB5HHAnnN9gFbkdyYbErl4G1VuOpctnXH1gEclGphjnFz4IdJQhf
         +h+Myw7AeYyjEX5tE068o6QmMOZqpbAXPOgOOxeOUR6hhlhkyRqJHHwQrjVZf3Xf68gD
         xtJw==
X-Gm-Message-State: AOAM531rprauIeEZlghjW4cnY2kICtrqdVQk+SJOWk078SMEWt+gLSEh
        V6yJypV/g+dL+w7mu0viUw==
X-Google-Smtp-Source: ABdhPJy+4jrpHRzv4G0DfeIpR7zDwKuyJ02LQ3bcrMhY9YU8x0b/rNrCUOYiv08hdfOERrIitLtNAQ==
X-Received: by 2002:a62:b606:0:b029:222:7cab:5b1 with SMTP id j6-20020a62b6060000b02902227cab05b1mr20977812pff.32.1619505003866;
        Mon, 26 Apr 2021 23:30:03 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id t9sm902704pgg.6.2021.04.26.23.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 23:30:03 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm,hwpoison: fix sending SIGBUS for Action Required MCE
Date:   Tue, 27 Apr 2021 15:29:51 +0900
Message-Id: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the series based on Boris's review.  I folded 2/3 and 3/3
into one patch, updated description, added some refactored and rebased
onto v5.12.  There's no essential change in how the problem is solved.

v1: https://lore.kernel.org/linux-mm/20210412224320.1747638-1-nao.horiguchi@gmail.com/
v2 (only 3/3 is posted): https://lore.kernel.org/linux-mm/20210419023658.GA1962954@u2004/
v3: https://lore.kernel.org/linux-mm/20210421005728.1994268-1-nao.horiguchi@gmail.com/

Thanks,
Naoya Horiguchi

--- quote from cover letter of v1 ---

I wrote this patchset to materialize what I think is the current
allowable solution mentioned by the previous discussion [1].
I simply borrowed Tony's mutex patch and Aili's return code patch,
then I queued another one to find error virtual address in the best
effort manner.  I know that this is not a perfect solution, but
should work for some typical case.

[1]: https://lore.kernel.org/linux-mm/20210331192540.2141052f@alex-virtual-machine/
---
Summary:

Naoya Horiguchi (1):
      mm,hwpoison: send SIGBUS when the page has already been poisoned

Tony Luck (1):
      mm/memory-failure: Use a mutex to avoid memory_failure() races

 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 180 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 182 insertions(+), 16 deletions(-)
