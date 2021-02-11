Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21B0319191
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBKRvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:51:13 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:50985 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBKRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:15:05 -0500
Received: from ios.cs.uni-dortmund.de (ios.cs.uni-dortmund.de [129.217.43.100])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 11BHEAdV016868
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 18:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1613063654;
        bh=cRlXnHwY14ELXw7p0vlEY02Qm8KGsrh+EUzurnNU9XM=;
        h=From:To:Cc:Subject:Date;
        b=BviBf1zEby2NRW00ZsPsL8NdDjK72d8zQmzJY+HU/k4tSZ7n5Zl2hYKpfGHhyvA/V
         nhY41Y15aPIlIoSUrBhZ0BxB8tC1CbyF6BSKkNyLcStwbZldSWQTzEGwJbA1HWkg2/
         g5oYU/d7kwHN0OSY9ja3uqmMnguOkwviRJ2Z7gVc=
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Updated locking documentation for transaction_t
Date:   Thu, 11 Feb 2021 18:14:10 +0100
Message-Id: <20210211171410.17984-1-alexander.lochmann@tu-dortmund.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some members of transaction_t are allowed to be read without
any lock being held if accessed from the correct context.
We used LockDoc's findings to determine those members.
Each member of them is marked with a short comment:
"no lock needed for jbd2 thread".

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/jbd2.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..1f19d19f6435 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -594,18 +594,18 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* Number of buffers on the t_buffers list [j_list_lock] */
+	/* Number of buffers on the t_buffers list [j_list_lock, no locks needed for jbd2 thread] */
 	int			t_nr_buffers;
 
 	/*
 	 * Doubly-linked circular list of all buffers reserved but not yet
-	 * modified by this transaction [j_list_lock]
+	 * modified by this transaction [j_list_lock, no locks needed for jbd2 thread]
 	 */
 	struct journal_head	*t_reserved_list;
 
 	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
-	 * transaction [j_list_lock]
+	 * transaction [j_list_lock, no locks needed for jbd2 thread]
 	 */
 	struct journal_head	*t_buffers;
 
@@ -631,7 +631,7 @@ struct transaction_s
 	/*
 	 * Doubly-linked circular list of metadata buffers being shadowed by log
 	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
-	 * list match each other one for one at all times. [j_list_lock]
+	 * list match each other one for one at all times. [j_list_lock, no locks needed for jbd2 thread]
 	 */
 	struct journal_head	*t_shadow_list;
 
-- 
2.20.1

