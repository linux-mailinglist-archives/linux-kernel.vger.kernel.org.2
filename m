Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14488410BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhISNOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:14:20 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:40806 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhISNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:14:18 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id AA625BF2678;
        Sun, 19 Sep 2021 15:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1632057171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/joGQdNC2N2dNh84qcUkN4z807uaMjxshBBAeQbTcZg=;
        b=cw6S0SRniqaNmiqXzJQXeculZrOiEv6N3ufqssUSvlXSBjgcCFPJdsiz5iA7+q/4w/l/5z
        HBGP7hCqMFOQQFyqEQCqKg1a4WdWXjTkVlaeVli4WZ647YocRaTECmPIYZDHJ8Gqy+nuXU
        GU7wBKxFb5fFyHS1PX/XZUSYFeaIo9w=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [RFC v2 PATCH 1/3] mm: add PG2KB/KB2PG helper macros
Date:   Sun, 19 Sep 2021 15:12:46 +0200
Message-Id: <20210919131248.489798-2-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919131248.489798-1-oleksandr@natalenko.name>
References: <20210919131248.489798-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 include/linux/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 00bb2d938df4..0a7e950ac8aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -98,6 +98,9 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/page.h>
 #include <asm/processor.h>
 
+#define PG2KB(x)	((x) << (PAGE_SHIFT - 10))
+#define KB2PG(x)	((x) >> (PAGE_SHIFT - 10))
+
 /*
  * Architectures that support memory tagging (assigning tags to memory regions,
  * embedding these tags into addresses that point to these memory regions, and
-- 
2.33.0

