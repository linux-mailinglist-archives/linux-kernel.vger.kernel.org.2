Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B10366C29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbhDUNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241188AbhDUNIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F106561463;
        Wed, 21 Apr 2021 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010473;
        bh=80aKVgLdz41+Z5RfLfXJKYSqdI865GMdvqKF5ralkeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NROUx2x1hTCgQ5GIAVQOcdgDhAMPEiroWdgsWwcl9rV9uKkGyIn7skZU7K0tffP+u
         1vRB/hdfoU4q9tBm+BDR2J8o21ZaYJm+eDFeu54dPDbfMUt8n6heeyzt1ay/eoyvzz
         l+tMz1ZjJ7Eovf7azkaFsrXAHogai7NI5mu95p9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 114/190] Revert "staging: rtl8188eu: Fix potential NULL pointer dereference of kcalloc"
Date:   Wed, 21 Apr 2021 14:59:49 +0200
Message-Id: <20210421130105.1226686-115-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7671ce0d92933762f469266daf43bd34d422d58c.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c    |  9 ++-------
 drivers/staging/rtl8188eu/include/rtw_xmit.h |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c    | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_xmit.h |  2 +-
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 317355f830cb..580a3678acc6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -174,9 +174,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	res = rtw_alloc_hwxmits(padapter);
-	if (res == _FAIL)
-		goto exit;
+	rtw_alloc_hwxmits(padapter);
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1505,7 +1503,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-s32 rtw_alloc_hwxmits(struct adapter *padapter)
+void rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1514,8 +1512,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
 				     sizeof(struct hw_xmit), GFP_KERNEL);
-	if (!pxmitpriv->hwxmits)
-		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1523,7 +1519,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 	hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
 	hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
 	hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
-	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
index 456fd52717f3..59490a447382 100644
--- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
@@ -330,7 +330,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
 s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
-s32 rtw_alloc_hwxmits(struct adapter *padapter);
+void rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 41632fa0b3c8..9b1b8add34e1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -248,9 +248,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		}
 	}
 
-	res = rtw_alloc_hwxmits(padapter);
-	if (res == _FAIL)
-		goto exit;
+	rtw_alloc_hwxmits(padapter);
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1990,7 +1988,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-s32 rtw_alloc_hwxmits(struct adapter *padapter)
+void rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -2001,8 +1999,10 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = rtw_zmalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry);
 
-	if (!pxmitpriv->hwxmits)
-		return _FAIL;
+	if (pxmitpriv->hwxmits == NULL) {
+		DBG_871X("alloc hwxmits fail!...\n");
+		return;
+	}
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -2027,7 +2027,7 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 	} else {
 	}
 
-	return _SUCCESS;
+
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index c04318573f8f..9f25ff77aa2c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -483,7 +483,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
 
 
-s32 rtw_alloc_hwxmits(struct adapter *padapter);
+void rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 
 
-- 
2.31.1

