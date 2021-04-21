Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEC366339
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDUA6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhDUA6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:58:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9586CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b17so28129530pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJh+f2OxJ6UeEIflR4yC1vPkkK4oSh0ENZ951FJONqo=;
        b=OLeReUbdv6OLeHCHtQq3H85lrpASJkCIjnry0RBvo10xtR/lhyQzxLB80qo0HcbSrY
         5iRH2XznC3iGJHWoJffrqvlZYppqiRGV2yiyT7mBc9M7D/7kxcxh1BWgpjZ7yFcc1Vs/
         e4t01oaV1qrIRraxBVSSwK1SjsZqP5fuf2YhVHn5Q3+c5lY4DFFnBmDTGCuVtVWkkVZH
         gXX1gpsWIoGMLho6zkdnVDi6aJZTNBqh7Bcad4aOKeYv2L5yErV5jBPP22x/omETQbBd
         meUhnieaiz+7B35WbVsQYds54/pQDt3Nl3auoMIzrjxW5h/UHlajYSm9SLoMnynp8+Fq
         ezqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJh+f2OxJ6UeEIflR4yC1vPkkK4oSh0ENZ951FJONqo=;
        b=SnejMpiayyGrjwPrDxz9p3n35RrUXRuIpIMkkbDDBs2eXLPl03QpsFLc0AT1GeIdpG
         9tbvOfrcUF54dpri7pQ2ThsIr7cLadjvcWEfYJ28JPf6iWQ3fQz1bMCJpC0QdVcoWOUU
         g4B9rLaZAsoj1ABjEvS2k7mmqL7u/XE+FvhWqdFAqChM1yWtyJ6Lz7hWV5OUQfOy7aQk
         be1utnjyZ0eenVzO2TTT4tE2H3KFaHOwN/H+9ova+lTcRKSDclfcf22Rxd43y64fxOW+
         z1ZGSF3/xf/IrTQP4q8xQT0D8F/r2RjNtZyzITuWYFDYVyRoWR24Z6qoFdJL751CyBaM
         cwJQ==
X-Gm-Message-State: AOAM530pL5TTsZI77uYF1zuDezBxZQnOGUKXX71M3UL4atiEZ+7gmo7J
        HnqNG24rpEz1sVpKZIxB5DBUdGNmrvCI3WI=
X-Google-Smtp-Source: ABdhPJz+2CnILAZSl5uyXJxgTccojcLpEzDQCZfgUMmoXaxCtx+4dHq0eDd/622C+gkAavKPcodGeg==
X-Received: by 2002:a65:5203:: with SMTP id o3mr19270273pgp.305.1618966659214;
        Tue, 20 Apr 2021 17:57:39 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id e13sm178278pfi.199.2021.04.20.17.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:57:38 -0700 (PDT)
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
Subject: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action Required MCE
Date:   Wed, 21 Apr 2021 09:57:25 +0900
Message-Id: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the series based on previous feedbacks/discussions.

Changelog v2 -> v3:
- 1/3 aligned returning code with "goto out" approach,
- 3/3 added one Tested-by tag,
- 3/3 fixed comment on kill_accessing_process().

Changelog v1 -> v2:
- 3/3 fixed on initializing local variables and calculation logic
  of error virtual address,

v1: https://lore.kernel.org/linux-mm/20210412224320.1747638-1-nao.horiguchi@gmail.com/
v2 (only 3/3 is posted): https://lore.kernel.org/linux-mm/20210419023658.GA1962954@u2004/

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

Aili Yao (1):
      mm,hwpoison: return -EHWPOISON when page already

Naoya Horiguchi (1):
      mm,hwpoison: add kill_accessing_process() to find error virtual address

Tony Luck (1):
      mm/memory-failure: Use a mutex to avoid memory_failure() races

 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 181 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 183 insertions(+), 16 deletions(-)
