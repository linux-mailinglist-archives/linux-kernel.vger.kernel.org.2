Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82763FD6B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhIAJWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbhIAJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:22:50 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E419C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 02:21:52 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 84F25BC74ED;
        Wed,  1 Sep 2021 11:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1630488110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TXpryOL6VSO9ITcKmr0S/fF3J09GeRCANFPAKsu45ZY=;
        b=nbd9fnXVBJas6fBLM2u7Cl5iI6ipsyCds4K4K7l0KElUcUzkA0mjAoP/9EZq0SsqVZmJuo
        JrX/WVjfkCY4Ni1j+8iGiOafcTfJ2XM9FURaQ2dPlL9h64jrSZd+s4nHQ8OTI7P+D060BQ
        oM3zRQwK58ahSYXodFgpPMyT0wo2UO0=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [RFC PATCH 0/1] mm: provide one common K(x) macro
Date:   Wed,  1 Sep 2021 11:21:48 +0200
Message-Id: <20210901092149.994791-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on discussion with Miaohe Lin [1].

There are various places where the K(x) macro is defined, sometimes
under different names, sometimes it is just open-coded. In this RFC I
suggest providing a common K(x) definition that replaces existing ones.

For that, a new header, mm_tools.h, is created. I couldn't find a more
appropriate place for K(x). Probably, an existing header like mm_inline.h
would work as well. I tried placing this macro under mm.h, but then it
conflicts with uapi/linux/keyboard.h.

In case this approach is acceptable, replacing open-coded variants would
be done in a separate patch. For now, I'm using `git grep -nE
'<<\s?\(PAGE_SHIFT\s?\-\s?10\)'` to find such places.

Also note, here I do not touch files under arch/ like
arch/arc/include/asm/arcregs.h where PAGES_TO_KB() is defined, or
arch/powerpc/platforms/pseries/cmm.c with PAGES2KB() as well as
arch/s390/appldata/appldata_mem.c with P2K() as I'm not sure if it is
appropriate to include another header file there.

The patch is based on top of next-20210831 and is compile-tested using
allyesconfig.

Please let me know what you think.

Thanks.

[1] https://lore.kernel.org/linux-mm/9161665.bUqNH3lxUD@natalenko.name/

Oleksandr Natalenko (1):
  mm: provide one common K(x) macro

 drivers/base/node.c                 |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c |  5 ++---
 drivers/xen/xen-balloon.c           | 11 +++++------
 include/linux/mm_tools.h            |  9 +++++++++
 include/trace/events/writeback.h    | 19 +++++++++----------
 kernel/debug/kdb/kdb_main.c         |  2 +-
 mm/backing-dev.c                    |  3 +--
 mm/memcontrol.c                     |  2 +-
 mm/oom_kill.c                       |  3 +--
 mm/page_alloc.c                     |  3 +--
 10 files changed, 31 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/mm_tools.h

-- 
2.33.0

