Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6157333642
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhCJHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhCJHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:18:38 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15FDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:18:38 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t85so6154393pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1acND1EREShANGQfwTUC3wDcACmmIdncq6Z3tdRoug=;
        b=rSiSDLTTO9OyRJIiTzqs3PDPucfdAk0ncz5n2faubnnBgfgUvMRwjMsv/j/NvS9xQx
         ByRkaPxGurJ9JJnwecL2xl9lHke8Ug8+pTkcQyVJoIDtxUkH835i1JGhTntyrmu+N2ZI
         axXrUUVs8wsOh9dN9P3e5mgDExYlY2t2FhlGmDEU2WcHoi8JYsAfPtNmdBvM2BB7OPdj
         9iULE8ql83rs2lo11YrMBzgTHlbJlTWPLNWUldQGWtvklZaZfoyPw3y3Yrr6BFBsDYkX
         DZ3xSkyNCQrxVy2Uq8sGjdeencQAnAZpRodlUPwG71WoEp0/yZV1rwrpV/sCF6/POSP1
         MLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1acND1EREShANGQfwTUC3wDcACmmIdncq6Z3tdRoug=;
        b=RPy5oAzVODhHGMH3Cncq1h6a2dHboVwdYzlJqgAKpTgbfERf4kX3LujwREquvQQ99i
         aKS24iBdnct17lw0P5qbga3+uFLEQvt+HwHG7T9cN9E+bOJodFX2gr854FSQpbUKOKw9
         SRGhJvjZvgqIumoCkQxkNgd7bWa/OlnB9KeSCgEvmosUhn5ORlyVkr4xF6Cj4HDlMdNB
         5RwAfePziu/5ENcymMWaMdcCnOWDLGFMvONijHuAuNPCck/fMBkirfnKy5L0LRA4av6H
         qWKd+7N5XfmhdCYHfwEuJJVY/PNkNIBgOPIy9m+Kz2wYMOhjNBJ70CWXgCdV0AbzKyyA
         MyMA==
X-Gm-Message-State: AOAM533eElGmxstAFNJlBkxauP87Tx/hNI7xFy/AUmjJNTQrqsGAd9YE
        eSmSp/IEquvTBbnJqdHdCZWPkA==
X-Google-Smtp-Source: ABdhPJy+OheNUvM+6s60FDsLzV3hWPRHVS82OY7G2q1EtiK/mjCuYid1SfjT7rtQym2PnN0KU9IB6A==
X-Received: by 2002:a63:e42:: with SMTP id 2mr1680025pgo.100.1615360718314;
        Tue, 09 Mar 2021 23:18:38 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h15sm2828868pfo.20.2021.03.09.23.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:18:37 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for arm64
Date:   Wed, 10 Mar 2021 15:15:32 +0800
Message-Id: <20210310071535.35245-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on the series of "Free some vmemmap pages of HugeTLB
page". More details can refer to the below link.

  https://lkml.kernel.org/r/20210308102807.59745-1-songmuchun@bytedance.com

I often received some feedback (We want to test this feature on arm64) before.
Because the previous code has been reviewed for 18 versions and is merged
into mm tree, I think that it is time to release this patchset. If you want
to test then you can start now :-). And I also hope someone can review this.

Thanks.

Muchun Song (3):
  mm: bootmem_info: mark register_page_bootmem_info_section __init
  mm: hugetlb: introduce arch_free_vmemmap_page
  arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB

 arch/arm64/mm/mmu.c   | 5 +++++
 arch/x86/mm/init_64.c | 5 +++++
 fs/Kconfig            | 4 ++--
 mm/bootmem_info.c     | 4 ++--
 mm/sparse-vmemmap.c   | 9 +++++++--
 5 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.11.0

