Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E832356114
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbhDGBxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347839AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C87C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=NVL7JPD4xKaWrJCrCCQAhxOaIfpgRthzGvlvMAcHMhY=;
 b=OESJ03wes2NwJiVPB7yoVDujCoaMAblbZeph6lEd4X/+SlFZQRQ4XSY8m+asM02bxuSyh
 JWXeIWR0c/wMGsPBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=NVL7JPD4xKaWrJCrCCQAhxOaIfpgRthzGvlvMAcHMhY=;
 b=NNc+BYnodpTFTj+++F+FgTCacE2ASOXUqbP91WbtiNnglS6UaYxtuEGt+wSqU2Blxqvdl
 vlnWo0J0DnkKTLm9oabmwHdK/K8/u/6GOD3CN9KYd6gcN983vIxvIcUWdB0+umwetM+RNiq
 Q4y/Yah0dxXG6hwrUQpaG8j0Mdsh9eBGK3GUFwrsFLgtiyxoartjV2cLKdWQibkgRzkzF6f
 tbbCTYe1r/njg5mU7JFS/OZ7Z38g/uRJzwbh4mIxv/M1GNvyUS86YzzPLbjVGRzzXG+IncQ
 EN/IYPAxtrN4Wr4ECCqxohOG16G6xNiN8qL8r5T8FqrcOgwBH8BorhL2AFAA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 6B2A61601D1;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 5C25B19F30B; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 01/37] mmap locking API: mmap_lock_is_contended returns a bool
Date:   Tue,  6 Apr 2021 18:44:26 -0700
Message-Id: <20210407014502.24091-2-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mmap_lock_is_contended to return a bool value, rather than an
int which the callers are then supposed to interpret as a bool. This
is to ensure consistency with other mmap lock API functions (such as
the trylock functions).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mmap_lock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0540f0156f58..4e27f755766b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -171,9 +171,9 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
-static inline int mmap_lock_is_contended(struct mm_struct *mm)
+static inline bool mmap_lock_is_contended(struct mm_struct *mm)
 {
-	return rwsem_is_contended(&mm->mmap_lock);
+	return rwsem_is_contended(&mm->mmap_lock) != 0;
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
-- 
2.20.1

