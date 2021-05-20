Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB81138A02E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhETIvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:51:41 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:58273 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhETIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:51:40 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 552A21A52
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:50:18 +0100 (IST)
Received: (qmail 9881 invoked from network); 20 May 2021 08:50:17 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:50:17 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 11/14] mm/swap: Make swap_address_space an inline function
Date:   Thu, 20 May 2021 09:48:06 +0100
Message-Id: <20210520084809.8576-12-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning in page_mapping() for allnoconfig

  mm/util.c:700:15: warning: variable ‘entry’ set but not used [-Wunused-but-set-variable]
     swp_entry_t entry;
                 ^~~~~

swap_address is a #define on !CONFIG_SWAP configurations. Make the helper
an inline function to suppress the warning, add type checking and to apply
any side-effects in the parameter list.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/swap.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 144727041e78..216462c78a91 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -526,7 +526,11 @@ static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 	return NULL;
 }
 
-#define swap_address_space(entry)		(NULL)
+static inline struct address_space *swap_address_space(swp_entry_t entry)
+{
+	return NULL;
+}
+
 #define get_nr_swap_pages()			0L
 #define total_swap_pages			0L
 #define total_swapcache_pages()			0UL
-- 
2.26.2

