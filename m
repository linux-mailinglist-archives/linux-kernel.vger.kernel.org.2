Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA9341A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCSKr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:47:56 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:53124 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhCSKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:47:27 -0400
Received: from ios.cs.uni-dortmund.de (ios.cs.uni-dortmund.de [129.217.43.100])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 12JAlMpE028261
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 11:47:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1616150845;
        bh=BwZJz0cE5k+Q6MBdGXKhYD0FJLyqwpkKpvSZDhKSzis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S3qZiY6wRhfDgU2a/+WAuyX+SyTu0nDQ89r+fKfs93XDj1q65dEn/jiYdMe9EP6Wb
         jXncNvJdsdeoSBg8rCmA1oHpcJQ4TQ9VLmKUBXc8Me0LDX+n+GAN8AZVRHYF1+sYBQ
         Wh/s/dcziF5GKjhgWrpCIPmlbB8l6OlqTFJ+9bfE=
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To:     jack@suse.cz
Cc:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Updated locking documentation for journal_head
Date:   Fri, 19 Mar 2021 11:47:20 +0100
Message-Id: <20210319104722.75467-1-alexander.lochmann@tu-dortmund.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9864e9792b56bce87b016582a8759890079f7766>
References: <9864e9792b56bce87b016582a8759890079f7766>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LockDoc's results show that t_list_lock has been
replaced by j_list_lock for b_next_transaction,
b_tnext, and b_tprev.
We, therefore, updated the documentation
accordingly.

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/journal-head.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/journal-head.h b/include/linux/journal-head.h
index 75bc56109031..d68ae72784eb 100644
--- a/include/linux/journal-head.h
+++ b/include/linux/journal-head.h
@@ -80,13 +80,13 @@ struct journal_head {
 	 * Pointer to the running compound transaction which is currently
 	 * modifying the buffer's metadata, if there was already a transaction
 	 * committing it when the new transaction touched it.
-	 * [t_list_lock] [b_state_lock]
+	 * [j_list_lock] [b_state_lock]
 	 */
 	transaction_t *b_next_transaction;
 
 	/*
 	 * Doubly-linked list of buffers on a transaction's data, metadata or
-	 * forget queue. [t_list_lock] [b_state_lock]
+	 * forget queue. [j_list_lock] [b_state_lock]
 	 */
 	struct journal_head *b_tnext, *b_tprev;
 
-- 
2.20.1

