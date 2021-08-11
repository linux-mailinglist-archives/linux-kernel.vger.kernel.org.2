Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22EE3E9304
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhHKNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:49:35 -0400
Received: from mail.djl.id.au ([51.161.134.216]:59726 "EHLO mail.djl.id.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231799AbhHKNtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:49:32 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 09:49:32 EDT
Received: from desktop (unknown [1.145.53.183])
        by mail.djl.id.au (Postfix) with ESMTPSA id 4CC8520B64;
        Wed, 11 Aug 2021 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=djl.id.au; s=2021042801;
        t=1628689277; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=aRyA00S4X5p3+7ZrmTyjDWwd0nEXuT1ptgeoX5ewrO0=;
        b=AaI6EmShLoMGLZjFeK04jG1uBT/ZI6h6E7Evxpl3uJNRi/eIj7y7hQTXTVfIf1wHKDgXtP
        o7qmZ2uNHWroyGsJfFdZUbFS5XKGN7g3kpmA85INtKwolpai4Hwx8sPl1vkY036tLQozXk
        LhKReAMe8oRcMQWsTjvkZhp8wqZXbTQ=
From:   Dee-Jay Anthony Logozzo <dj@djl.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dee-Jay Anthony Logozzo <dj@djl.id.au>
Subject: [PATCH] staging: gdm724x: Place macro argument within parentheses
Date:   Wed, 11 Aug 2021 23:41:32 +1000
Message-Id: <20210811134132.5240-1-dj@djl.id.au>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the macro arguments within parentheses to avoid precedence issues.
This solves the following checkpatch.pl warnings

CHECK: Macro argument 'len' may be better as '(len)' to avoid precedence issues
+#define ND_NLMSG_S_LEN(len)    (len + ND_IFINDEX_LEN)

CHECK: Macro argument 'nlh' may be better as '(nlh)' to avoid precedence issues
+#define ND_NLMSG_R_LEN(nlh)    (nlh->nlmsg_len - ND_IFINDEX_LEN)

Signed-off-by: Dee-Jay Anthony Logozzo <dj@djl.id.au>
---
 drivers/staging/gdm724x/netlink_k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
index 7902e52a699b..8f39cc5617aa 100644
--- a/drivers/staging/gdm724x/netlink_k.c
+++ b/drivers/staging/gdm724x/netlink_k.c
@@ -19,8 +19,8 @@ static DEFINE_MUTEX(netlink_mutex);
 #define ND_NLMSG_SPACE(len)	(NLMSG_SPACE(len) + ND_IFINDEX_LEN)
 #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
 						  ND_IFINDEX_LEN))
-#define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
-#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
+#define ND_NLMSG_S_LEN(len)	((len) + ND_IFINDEX_LEN)
+#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)
 #define ND_NLMSG_IFIDX(nlh)	NLMSG_DATA(nlh)
 #define ND_MAX_MSG_LEN		(1024 * 32)
 
-- 
2.31.1

