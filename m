Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9335AF8C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhDJSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 14:22:55 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:46702 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 14:22:54 -0400
Received: by mail-io1-f49.google.com with SMTP id j26so9239345iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 11:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Byz/Sc22eLv5OrE3COYJ5OikDlNUAwwd8T2iK8Gi2u4=;
        b=SWY1ti2s5TcmRbvh2WgfUQQsofC+pPUq6pj+xmKh5uCU6QOgtdeJIUr5BGBxWpoKfI
         GmPCJziwjLjGdSz0Okzxp+D1qoBoEkntaJpkOa1ZfzXZFyxnAUrUvQ3yqTRcnLifPXIC
         4UUwy/lgINhXu33vGGEe9MQuAjmVoqHvqPJcYQitx+GQXPxG3L7O5lIFjJRkwZheBPgw
         rPXK986TINZbxtr5An599x9HBN2dKuDeqw09UL+l2AQAHeQcnMKoFUh7x9UBvv9otF4c
         VDpsNDHGviwVA2C3wwBeUE/6ouyy6qZoUqgWZ/lw912zMmj23OkhcwCw/lTgVP7LYIRS
         UiCQ==
X-Gm-Message-State: AOAM53366c2GOMqYAt3SaEU72oDoHiOtMb5Mo2Yf1hSIeMhZ2mS1Bh6R
        NVm2HqmwZLIFHCxvomk3/HU=
X-Google-Smtp-Source: ABdhPJwQiUBpl3ntjXx+9mtQ5U7RER/yw5mFR+uR/u1yf0x4DTbMlUUN4KM5c7+dO6XkEMLihJpnpA==
X-Received: by 2002:a05:6602:179e:: with SMTP id y30mr2649047iox.130.1618078957570;
        Sat, 10 Apr 2021 11:22:37 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id o6sm2977907ioa.21.2021.04.10.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 11:22:37 -0700 (PDT)
Date:   Sat, 10 Apr 2021 18:22:35 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.12-rc7
Message-ID: <YHHs618ESvKhYeeM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request contains a fix for sporadically failing atomic percpu
allocations. I only caught it recently while I was reviewing a new
series [1] and simultaneously saw reports by btrfs in xfstests [2] and
[3].

In v5.9, memcg accounting was extended to percpu done by adding a second
type of chunk. I missed an interaction with the free page float count
used to ensure we can support atomic allocations. If 1 type of chunk has
no free pages, but the other has enough to satisfy the free page float
requirement, we will not repopulate the free pages for the former type
of chunk. This led to sporadically failing atomic allocations.

[1] https://lore.kernel.org/linux-mm/20210324190626.564297-1-guro@fb.com/
[2] https://lore.kernel.org/linux-mm/20210401185158.3275.409509F4@e16-tech.com/
[3] https://lore.kernel.org/linux-mm/CAL3q7H5RNBjCi708GH7jnczAOe0BLnacT9C+OBgA-Dx9jhB6SQ@mail.gmail.com/

Thanks,
Dennis

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.12-fixes

for you to fetch changes up to 0760fa3d8f7fceeea508b98899f1c826e10ffe78:

  percpu: make pcpu_nr_empty_pop_pages per chunk type (2021-04-09 13:58:38 +0000)

----------------------------------------------------------------
Roman Gushchin (1):
      percpu: make pcpu_nr_empty_pop_pages per chunk type

 mm/percpu-internal.h |  2 +-
 mm/percpu-stats.c    |  9 +++++++--
 mm/percpu.c          | 14 +++++++-------
 3 files changed, 15 insertions(+), 10 deletions(-)
