Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA56B412ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhIUGsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhIUGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:48:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3724AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:46:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w11so3173175plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1yv0YD1p8/r7hGH7jOiQD60zt6r6Sa+YFTXmu6GaNM=;
        b=d+IkiQxcb0/TAQhEFcSzVDTGsu7GhCriwCojht4gK8z4Z0Kyb3hItyEmT2WzWvkztX
         SbVlDqRjLVuvu5D10R/sybP6Mh7Pv+0+i9VwHnIA3Wu47E6MaCiI8lohcYHe9hslsUR5
         Mi+eRtfh55KfJPDAUwvfogCGT26q+8N3FaVsK+qvkbdF9W+7ctgc50LCdu8ksC3vWqf/
         xo1hhjF5MGGRP48/3Pa7P1JArH8odNqUXARE2byE3DXPa409581SsPzJhgXhgdRrgQo6
         zhhbsJOwQo0srHI8F+01pCBGrbtQUMDTuP3DszimDhdLKxKoYOUyehTTDZYkOJxD3KUp
         79fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1yv0YD1p8/r7hGH7jOiQD60zt6r6Sa+YFTXmu6GaNM=;
        b=HClXzf9dGuYhQ/psnqfYrrpKHaxovxGuLiGW44laj/GkfkoeHanAKzRtid7T5wAM31
         Gp2mBpTXSS0ruQNF5sZQCP6c4fG6DfE//fL2OHdNKddwl4Tim0dPaxhMpypWvG2N6DdR
         LC29PhjK5lZSifGYSkULzJYu8Fvy3AgOqS8ZV3HL3LVL4DvzIknQrA/RzkHs9uF9nSyX
         6qAzKsUv854i70QZJTpERaERnIF7MUozxMcOChFXPiqux/pWpm61+AFEmAweMQnI4K/l
         I8DwdEh7T9F4ruxybCwh4a/qNCyQSdXmqDx+MHwq6vPlKXYefdI78CJ5SWtKCpAZgztS
         t9bw==
X-Gm-Message-State: AOAM531moCp61pO7WuoH7yhG72Ye8xtOmjgjkoLqnCgiZefJJmx5xST1
        NnIwe8tuRikzk6cRKH/2/Pdww3EIQq96Rt02
X-Google-Smtp-Source: ABdhPJwNnKhLZFlV2OBG9HRT6TYafMJOwcWNaAmwYxpMuUys54yJQKyASKBXHroL1BGHYRTrWw3VvQ==
X-Received: by 2002:a17:903:4112:b0:13a:7afa:f9c4 with SMTP id r18-20020a170903411200b0013a7afaf9c4mr26020393pld.66.1632206792766;
        Mon, 20 Sep 2021 23:46:32 -0700 (PDT)
Received: from ownia.. ([103.97.201.35])
        by smtp.gmail.com with ESMTPSA id a1sm1413101pjg.0.2021.09.20.23.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 23:46:32 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
Subject: [PATCH v2 0/2] mm/debug: sync up latest migrate_reason to migrate_reason_names
Date:   Tue, 21 Sep 2021 14:45:51 +0800
Message-Id: <20210921064553.293905-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After related migrate page updates, sync up latest migrate_reason to
migrate_reason_names, page_owner use it to parse the page migrate
reason.

Changes in V2:
-- sync up MR_CONTIG_RANGE
-- split patchset for stable kernel

Weizhao Ouyang (2):
  mm/debug: sync up MR_CONTIG_RANGE and MR_LONGTERM_PIN
  mm/debug: sync up latest migrate_reason to migrate_reason_names

 include/linux/migrate.h | 6 +++++-
 mm/debug.c              | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.30.2

