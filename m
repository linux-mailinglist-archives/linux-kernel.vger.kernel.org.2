Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68580354EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhDFIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhDFIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:45:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B38C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:45:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b14so21429779lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n4FEsffBOj3g2bz2GH2q2OLx2NIGrN5f+d8qx4lm1yU=;
        b=mRWM/BesbkyYZZ2NY8NNKYQSc/3wq4Us74TFMclZBnXibkZzsiB/CkBLjVpPQ2+GPk
         bZndGYvRwL3moaUf7t9T4CGcli/JQC7Ka57OCwm5aPF0XQ5xhWyh0BhJYKLysXt/lcXq
         fBrILiMVhjvCfnz/JStdAgQ7v1zAdyL7wqX5kfZJoOsZ3AS7ISe68w5ofvd0wz4+DTvE
         KyhcrD+wVZv1N8NhZCboA4A/4zx5JnKACDCdLzqrFQXgEtl4ZjkXbynGwipKX1FE3FsA
         MZJAww/Q2ZLGfElBBZC5rEgR76sFidg1+Vv7m5fz16ioEdgKG1M74jIcbV+2k5v8TKfK
         Nk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n4FEsffBOj3g2bz2GH2q2OLx2NIGrN5f+d8qx4lm1yU=;
        b=NyYwVfpQvYHCD3lnzjKt0QACySb5r6C3d3X+OTnwhHUwvxm7fLj18xSbes+rji0WyE
         MXVloZyPvPRoCGkEoGLSiMT7QACUXhkR79cuVTIlYk2pPtwXrOSYgZEzI+2z/HVS51Cs
         EQQvjqgg7BA44bw3tNP/frKxkfeR69HzX6+GHzij+RyDRfWY5AnUAIL1psHWUPgqEyhC
         4Rz7CfLRqyoqwIASo9SBm/gnxuWRESz59jyOYkLpQvnUmgLbgHSxTYblfvVa8Hqz+0gj
         mDTI6mTtgQmJp+MkFVfVywiGq/Xrqpv2nqLbOC9LI4FfkKvIwpOLmIrwTJxT3JRdPhHp
         J7yQ==
X-Gm-Message-State: AOAM530CXBfY6yJBGdJlmEZmg7YMvSvqqih1hW0UAX6kt1koxcJ3K4Nq
        vaoqiwjMIYf2GQgE4Mz/M3Q=
X-Google-Smtp-Source: ABdhPJxLkkeKgWNv7c28s1HLhUrkvqrM61v5NG0JkhLXKM+ElPtqyx/5Qx4ZCAtINvdrVACZ4S7jkw==
X-Received: by 2002:a05:6512:39cd:: with SMTP id k13mr3000947lfu.449.1617698725653;
        Tue, 06 Apr 2021 01:45:25 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id w21sm2078138lfk.171.2021.04.06.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:45:25 -0700 (PDT)
Date:   Tue, 6 Apr 2021 14:45:24 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 2/4] staging: rtl8712: match parentheses alignment
Message-ID: <664f324330611a78e184a203ece38d4facc9d791.1617697237.git.zhansayabagdaulet@gmail.com>
References: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match next line with open parentheses by adding tabs/spaces
to conform with Linux kernel coding style.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 22 +++++++++++-----------
 drivers/staging/rtl8712/rtl871x_xmit.h |  2 +-
 drivers/staging/rtl8712/xmit_osdep.h   |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 17d4a261dea0..f4b871637795 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -69,7 +69,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 	for (i = 0; i < NR_RECVFRAME; i++) {
 		INIT_LIST_HEAD(&(precvframe->u.list));
 		list_add_tail(&(precvframe->u.list),
-				 &(precvpriv->free_recv_queue.queue));
+			      &(precvpriv->free_recv_queue.queue));
 		r8712_os_recv_resource_alloc(padapter, precvframe);
 		precvframe->u.hdr.adapter = padapter;
 		precvframe++;
@@ -175,7 +175,7 @@ sint r8712_recvframe_chkmic(struct _adapter *adapter,
 			if (bmic_err) {
 				if (prxattrib->bdecrypted)
 					r8712_handle_tkip_mic_err(adapter,
-						(u8)is_multicast_ether_addr(prxattrib->ra));
+								  (u8)is_multicast_ether_addr(prxattrib->ra));
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
@@ -191,14 +191,14 @@ sint r8712_recvframe_chkmic(struct _adapter *adapter,
 
 /* decrypt and set the ivlen,icvlen of the recv_frame */
 union recv_frame *r8712_decryptor(struct _adapter *padapter,
-			    union recv_frame *precv_frame)
+				  union recv_frame *precv_frame)
 {
 	struct rx_pkt_attrib *prxattrib = &precv_frame->u.hdr.attrib;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	union recv_frame *return_packet = precv_frame;
 
 	if ((prxattrib->encrypt > 0) && ((prxattrib->bdecrypted == 0) ||
-	    psecuritypriv->sw_decrypt)) {
+					 psecuritypriv->sw_decrypt)) {
 		psecuritypriv->hw_decrypted = false;
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
@@ -252,7 +252,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 			} else {
 				/*free this frame*/
 				r8712_free_recvframe(precv_frame,
-					 &adapter->recvpriv.free_recv_queue);
+						     &adapter->recvpriv.free_recv_queue);
 				prtnframe = NULL;
 			}
 		} else {
@@ -274,7 +274,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 }
 
 static sint recv_decache(union recv_frame *precv_frame, u8 bretry,
-		  struct stainfo_rxcache *prxcache)
+			 struct stainfo_rxcache *prxcache)
 {
 	sint tid = precv_frame->u.hdr.attrib.priority;
 	u16 seq_ctrl = ((precv_frame->u.hdr.attrib.seq_num & 0xffff) << 4) |
@@ -393,7 +393,7 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 			return _FAIL;
 		/* check BSSID */
 		if (is_zero_ether_addr(pattrib->bssid) ||
-		     is_zero_ether_addr(mybssid) ||
+		    is_zero_ether_addr(mybssid) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN)))
 			return _FAIL;
 		if (bmcast)
@@ -443,20 +443,20 @@ static sint sta2ap_data_frame(struct _adapter *adapter,
 }
 
 static sint validate_recv_ctrl_frame(struct _adapter *adapter,
-			      union recv_frame *precv_frame)
+				     union recv_frame *precv_frame)
 {
 	return _FAIL;
 }
 
 static sint validate_recv_mgnt_frame(struct _adapter *adapter,
-			      union recv_frame *precv_frame)
+				     union recv_frame *precv_frame)
 {
 	return _FAIL;
 }
 
 
 static sint validate_recv_data_frame(struct _adapter *adapter,
-			      union recv_frame *precv_frame)
+				     union recv_frame *precv_frame)
 {
 	int res;
 	u8 bretry;
@@ -602,7 +602,7 @@ int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	psnap_type = ptr + pattrib->hdrlen + pattrib->iv_len + SNAP_SIZE;
 	/* convert hdr + possible LLC headers into Ethernet header */
 	if ((!memcmp(psnap, (void *)rfc1042_header, SNAP_SIZE) &&
-	    (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_IPX, 2)) &&
+	     (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_IPX, 2)) &&
 	    (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
 	     !memcmp(psnap, (void *)bridge_tunnel_header, SNAP_SIZE)) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 1fb395c9d068..2e6afc7bb0a1 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -280,7 +280,7 @@ void r8712_xmit_direct(struct _adapter *padapter, struct xmit_frame *pxmitframe)
 void r8712_xmit_bh(struct tasklet_struct *t);
 
 void xmitframe_xmitbuf_attach(struct xmit_frame *pxmitframe,
-			struct xmit_buf *pxmitbuf);
+			      struct xmit_buf *pxmitbuf);
 
 #include "rtl8712_xmit.h"
 
diff --git a/drivers/staging/rtl8712/xmit_osdep.h b/drivers/staging/rtl8712/xmit_osdep.h
index 21f6b31e0f50..b76021b568f8 100644
--- a/drivers/staging/rtl8712/xmit_osdep.h
+++ b/drivers/staging/rtl8712/xmit_osdep.h
@@ -37,16 +37,16 @@ struct xmit_buf;
 int r8712_xmit_entry(_pkt *pkt, struct  net_device *pnetdev);
 void r8712_SetFilter(struct work_struct *work);
 int r8712_xmit_resource_alloc(struct _adapter *padapter,
-			   struct xmit_buf *pxmitbuf);
+			      struct xmit_buf *pxmitbuf);
 void r8712_xmit_resource_free(struct _adapter *padapter,
-			   struct xmit_buf *pxmitbuf);
+			      struct xmit_buf *pxmitbuf);
 
 void r8712_set_qos(struct pkt_file *ppktfile,
-		    struct pkt_attrib *pattrib);
+		   struct pkt_attrib *pattrib);
 void _r8712_open_pktfile(_pkt *pktptr, struct pkt_file *pfile);
 uint _r8712_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
 sint r8712_endofpktfile(struct pkt_file *pfile);
 void r8712_xmit_complete(struct _adapter *padapter,
-			     struct xmit_frame *pxframe);
+			 struct xmit_frame *pxframe);
 
 #endif
-- 
2.25.1

