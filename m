Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80430F7DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhBDQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238013AbhBDQ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:28:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E75564F42;
        Thu,  4 Feb 2021 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612456055;
        bh=HBfKOV5RuyAgb5pTWas7BF7KjE/lHPDguTOnk70YnVY=;
        h=From:To:Cc:Subject:Date:From;
        b=L6HVI76SKfA6rUAHHdliYYmHKGgOnYsB3U+ov725YoRCXoJ5/7McpUummzwSBHTFx
         voruiXeWZI7U6RGjngkLdRgITl9HafC0KjwdrsdGWT8ccnBeg6h8vZWjXoKMPKTXPT
         ghR1FseJRVOFv6vxZmapc8EdJK4EaGKzId+YgJIBT4EU75HszSH6vopVTFxHxY/pAv
         d3JYw+b/bHh1EkHGMFL/D5iuzSETyVU31w7sflWrIF8GOkQxFlaFncKwKwUgs2Gb3S
         hcZQ+QKCRikBbMtM9rWLPPI8MdvDVtuA9jRUHBhRg59NgyyHxO+krvwg2US0RHZ8AV
         jVUl+xJTyLZqQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt665x: fix alignment constraints
Date:   Thu,  4 Feb 2021 17:27:17 +0100
Message-Id: <20210204162731.3132069-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

multiple structures contains a ieee80211_rts structure, which is required to
have at least two byte alignment, but are annotated with a __packed attribute
to force single-byte alignment:

staging/vt6656/rxtx.h:98:1: warning: alignment 1 of 'struct vnt_rts_g' is less than 2 [-Wpacked-not-aligned]
staging/vt6656/rxtx.h:106:1: warning: alignment 1 of 'struct vnt_rts_ab' is less than 2 [-Wpacked-not-aligned]
staging/vt6656/rxtx.h:116:1: warning: alignment 1 of 'struct vnt_cts' is less than 2 [-Wpacked-not-aligned]

I see no reason why the structure itself would be misaligned, and all members
have at least two-byte alignment within the structure, so use the same
constraint on the sturcture itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vt6655/rxtx.h | 8 ++++----
 drivers/staging/vt6656/rxtx.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.h
index 464dd89078b2..e7061d383306 100644
--- a/drivers/staging/vt6655/rxtx.h
+++ b/drivers/staging/vt6655/rxtx.h
@@ -111,7 +111,7 @@ struct vnt_rts_g {
 	__le16 duration_bb;
 	u16 reserved;
 	struct ieee80211_rts data;
-} __packed;
+} __packed __aligned(2);
 
 struct vnt_rts_g_fb {
 	struct vnt_phy_field b;
@@ -125,14 +125,14 @@ struct vnt_rts_g_fb {
 	__le16 rts_duration_ba_f1;
 	__le16 rts_duration_aa_f1;
 	struct ieee80211_rts data;
-} __packed;
+} __packed __aligned(2);
 
 struct vnt_rts_ab {
 	struct vnt_phy_field ab;
 	__le16 duration;
 	u16 reserved;
 	struct ieee80211_rts data;
-} __packed;
+} __packed __aligned(2);
 
 struct vnt_rts_a_fb {
 	struct vnt_phy_field a;
@@ -141,7 +141,7 @@ struct vnt_rts_a_fb {
 	__le16 rts_duration_f0;
 	__le16 rts_duration_f1;
 	struct ieee80211_rts data;
-} __packed;
+} __packed __aligned(2);
 
 /* CTS buffer header */
 struct vnt_cts {
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index 6ca2ca32d036..f23440799443 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -95,7 +95,7 @@ struct vnt_rts_g {
 	u16 wReserved;
 	struct ieee80211_rts data;
 	struct vnt_tx_datahead_g data_head;
-} __packed;
+} __packed __aligned(2);
 
 struct vnt_rts_ab {
 	struct vnt_phy_field ab;
@@ -103,7 +103,7 @@ struct vnt_rts_ab {
 	u16 wReserved;
 	struct ieee80211_rts data;
 	struct vnt_tx_datahead_ab data_head;
-} __packed;
+} __packed __aligned(2);
 
 /* CTS buffer header */
 struct vnt_cts {
@@ -113,7 +113,7 @@ struct vnt_cts {
 	struct ieee80211_cts data;
 	u16 reserved2;
 	struct vnt_tx_datahead_g data_head;
-} __packed;
+} __packed __aligned(2);
 
 union vnt_tx_data_head {
 	/* rts g */
-- 
2.29.2

