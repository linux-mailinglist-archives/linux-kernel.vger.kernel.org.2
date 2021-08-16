Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79043ED78B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhHPNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239510AbhHPNfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:35:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 458A26054F;
        Mon, 16 Aug 2021 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629120908;
        bh=WUjMNw3qQEQzUL6zMadYc3si628avB9ntZHJcU/VT/E=;
        h=From:To:Cc:Subject:Date:From;
        b=bQmMZmyhySiPGAk/DuWTWM7P68G7jXNMGbfSWuFWHL/BjXff7RvIykTJZfU/pi3SX
         44Wn9Mn03Nv5fainZmbtOZGIWM4bi9m+bwxZIX+aOIA3hJLdD3y6XPm7WSDiWapvtI
         g7BZSVmiCQqBxDyLhCQZ8Qx87bmg9WpFbL602Xy8Zl/RxgIDYYyrjTSQBpRKTqM/nZ
         hes1y/90c+KA5ZszHXYoYMIUrx/H3y9tWbJ0HdD7UbvQF4U7eZylNowOv973PrDLsN
         rWbHvxqITuKH7SVy1D+wH00ILecoNv5rOJ+jWDQ+HhW4gcSAK4rtTo4JHm+ZJ9etyo
         LC5d3AaLBwiFg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmflags.h: add missing __GFP_ZEROTAGS and __GFP_SKIP_KASAN_POISON names
Date:   Mon, 16 Aug 2021 16:35:02 +0300
Message-Id: <20210816133502.590-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Add missing names of __GFP_ZEROTAGS and __GFP_SKIP_KASAN_POISON flags to
__def_gfpflag_names.

Fixes: 013bb59dbb7c ("arm64: mte: handle tags zeroing at page allocation time")
Fixes: c275c5c6d50a ("kasan: disable freed user page poisoning with HW tags")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/trace/events/mmflags.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 390270e00a1d..f160484afc5c 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -48,7 +48,9 @@
 	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
 	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
-	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"}\
+	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
+	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
+	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-- 
2.28.0

