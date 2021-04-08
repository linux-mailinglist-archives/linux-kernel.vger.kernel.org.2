Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4E358FDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhDHWjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhDHWjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4608861165;
        Thu,  8 Apr 2021 22:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921550;
        bh=gk0/WM+LjsudNKIrB192MNlb53DHiAudfB1DSdmLnCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEClg+4i0g4bRn4khiQfp56ESPUHDzF2gxpwRlNbKpArVScx4ppng2WJzjaDJmOpZ
         jRj/jWSZllxPXhYwV09wDUoiJTb5xSsx5xDIaiHIVlT5UQxdNm7kEgPlWgsCUWPzat
         yt3/RspwDgfhmTUBrOvt5nfYI0XtBfdLA481DbJuAogEqRPOEAv2XfnrWzoOJDPgnX
         KKuc50xyefXIZiwg4vlm0Ti/8aPIHau6aouMVQ3iKqFRzEKVtic+nFttS27KWH/Ttm
         7t9IhGqGsTQRQq3WLgovAe3IidNllMLZGMetLYDjyuX9LFy2AJ3g906kV3+yALC8sS
         63NiWgyE7cfRA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/5] srcu: Unconditionally embed struct lockdep_map
Date:   Fri,  9 Apr 2021 00:38:58 +0200
Message-Id: <20210408223902.6405-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408223902.6405-1-frederic@kernel.org>
References: <20210408223902.6405-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct lockdep_map is empty when CONFIG_DEBUG_LOCK_ALLOC=n. We can
remove the ifdeffery while adding the lockdep map in struct srcu_struct
without risking consuming space in the off-case. This will also simplify
further manipulations on this field.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/srcutree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..cb1f4351e8ba 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -82,9 +82,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 };
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
-- 
2.25.1

