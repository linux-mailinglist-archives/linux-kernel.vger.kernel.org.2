Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF83B5794
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhF1DDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1DDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:03:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E06BC061574;
        Sun, 27 Jun 2021 20:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=i5WxxZc8tT6cAucoU1opsevqwz38zO18+wH7avWZ1ME=; b=LoTq6T4vTYCjcuEk8An7PXx+ki
        EVh7Fj0g6XxkO9VUNH7eNpn8zk5yMoXfjwGYgnljQaDCpu1eIDJsDVnYkRghwnYSa1Zhw0/WrEyeq
        NjIeBFdB8JJ1cZpyiP6u40xYkGAoC8GzQARnuGo3Q1z9d9hBGqGBCVdxeEZ9bhyd4N2r92Et4TurM
        +rUv8r/4EWLnIyBYUFnKpU17zg4rkg4ctAwhgEb9Wma9UNHte8Xtb1pJn+B60drnJap5KwjFgzgR9
        j8sJCoKj6IrzPvUvoR1pBT8vvHSJH0iXAk2uuHA/nkmivkwcRVNTc8vGGLBMcaWj/SowDAlXEPo6i
        wVDF0cQQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxhWV-006bE9-S0; Mon, 28 Jun 2021 03:01:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH] hexagon: cmpxchg: fix comment after rename of a documentation file
Date:   Sun, 27 Jun 2021 20:01:22 -0700
Message-Id: <20210628030122.11180-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment text after the rename of a document file from .txt to .rst.

Fixes: 387b14684f94 ("docs: locking: convert docs to ReST and rename to *.rst")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 arch/hexagon/include/asm/cmpxchg.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210625.orig/arch/hexagon/include/asm/cmpxchg.h
+++ linux-next-20210625/arch/hexagon/include/asm/cmpxchg.h
@@ -46,7 +46,7 @@ static inline unsigned long __xchg(unsig
 	sizeof(*(ptr))))
 
 /*
- *  see rt-mutex-design.txt; cmpxchg supposedly checks if *ptr == A and swaps.
+ *  see rt-mutex-design.rst; cmpxchg supposedly checks if *ptr == A and swaps.
  *  looks just like atomic_cmpxchg on our arch currently with a bunch of
  *  variable casting.
  */
