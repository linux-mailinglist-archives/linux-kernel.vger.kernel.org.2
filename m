Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADA33AA10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCODh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhCODhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:37:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84615C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:37:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c6so8215174qtc.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsNszPZXedsfKo/NVYJH3mt7sz+6/7d3/2iK40T3H3E=;
        b=n4tbZ1hUmWc0FvQk9jHWHSZnJpStEDGWoPWQPelBX1kOfx+uHJaj3r7K2yC32VdJCN
         +dpp6Ef513EBFnSnjoRVA5/YaMVJV5BSfSPtf7j0h6x5D0WAhNNriiQYHOuRBzigD4ye
         fA0rd9g9ix6q5F+g6DfbF5lgFFexSs+L53W+4wSCP5hKap8BhKsztS4QRFQX7q4WqfpE
         q05wEA15tNQ0HtBd9+S6BvMJnUxAhfWbv6ENOnbe9WbZzODXHyHjGjXoP1saOr2kn4KP
         NnjTA9aFxVOqNYOgN2+c3ZGv96z0X681GnvfWvKxwLBqtZzmWPjezuM0275tnupLcuwF
         h+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsNszPZXedsfKo/NVYJH3mt7sz+6/7d3/2iK40T3H3E=;
        b=cxetqLZJhcTWCckQZe+hAiBuyPX2o9zZy5mdl7Ih1QJLa/tC8zgcxl460zdML+g1V5
         hjS4wuDKJFLxRQBH9N71F+YMjniutQrv+q+EryBi5BOElC+diVpwuRj1oGlyig8FWOJ+
         Hyv/E27LY4nZBAAbBAKe3FU09lzRVn5TSO8L7LpInDPG+IB/0nNsqas7lkf6Tzd3jjiz
         ZbdogdiBHMICwJ7Trk0V0nGbTySshB9tehqZLKMyHAXsnlBzVHB7hnv8qMtMmkuE9t38
         ekWRdfpVMuWnkMzNVd9Qp6vqVwF6ZtQS440a5spMJq4BcOvLDo7bK1EesLOG4af0Qz4A
         aAig==
X-Gm-Message-State: AOAM531TpcqWa9eEnU7qGMWVqI+vnvdraUQqiwBnnYbKBMF8q9AdmQVt
        c1/Vjkg1tclj1WXt8ePv5tNyj1F7vQmNkhGi
X-Google-Smtp-Source: ABdhPJzpYoy1WskwOMaatABheKu2F3MpLTCwIufz8o/2TUz+wcty9ZMoQUTgwT2g6edB7+o3vLy76Q==
X-Received: by 2002:a05:622a:193:: with SMTP id s19mr21275482qtw.366.1615779469848;
        Sun, 14 Mar 2021 20:37:49 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.217])
        by smtp.gmail.com with ESMTPSA id d70sm11906310qkg.30.2021.03.14.20.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:37:49 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        rppt@kernel.org, akpm@linux-foundation.org,
        christophe.leroy@csgroup.eu, oss@buserror.net, npiggin@gmail.com,
        unixbhaskar@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the file head_fsl_booke.S
Date:   Mon, 15 Mar 2021 09:07:32 +0530
Message-Id: <20210315033732.4173500-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/virutal/virtual/
s/mismach/mismatch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 As Randy pointed out I was changing the predefined macro name,so, reverted
 or leave it alone.
 Michael,sorry to run down a cold weave in your spine with my stupdity,this is
 okay.

 arch/powerpc/kernel/head_fsl_booke.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 3f4a40cccef5..a955403247f1 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -113,7 +113,7 @@ _ENTRY(_start);

 1:
 	/*
-	 * We have the runtime (virutal) address of our base.
+	 * We have the runtime (virtual) address of our base.
 	 * We calculate our shift of offset from a 64M page.
 	 * We could map the 64M page we belong to at PAGE_OFFSET and
 	 * get going from there.
@@ -497,7 +497,7 @@ END_BTB_FLUSH_SECTION
 #endif
 #endif

-	bne	2f			/* Bail if permission/valid mismach */
+	bne	2f			/* Bail if permission/valid mismatch */

 	/* Jump to common tlb load */
 	b	finish_tlb_load
@@ -592,7 +592,7 @@ END_BTB_FLUSH_SECTION
 #endif
 #endif

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Jump to common TLB load point */
 	b	finish_tlb_load
--
2.30.2

