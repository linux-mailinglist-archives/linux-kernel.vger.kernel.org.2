Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B631C46C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBOXfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:35:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C19C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:34:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v62so1411459wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vI8JdaSS9zdDAWHOcspY9UNl4U9Js3cPyIJf1LWX3B8=;
        b=Us7HfrIoFHiDnL3ZEqru1GgLfPjfSBLpa4GVf1f3KViGAug0FIpahUGbsreEZyC8Jn
         v8t71R6n3nkzSk3LHlaDyhyFP/XAEhOqYusE74SzC2iv35V1uet9R+EhAKdKHbNcYwHK
         A6wTn4hiYImgF6Lz5AcOg0l54TxwK0zqguklk9AKMOD5hY7MLss+5CPZUuJ/Ssn6BR1a
         115fNDKR6jYiFjbA9IhOIPPYzF95YBP0vKD+nEpYCZNstii7IU9Nm5k0c4niWJRS5/Ve
         hkM9BOL0CbqI2q69Ik39VaqGYczxh0n4jBQ2ltZWGgETWKxEkr9KXCuj3ZHceJChkqvn
         y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vI8JdaSS9zdDAWHOcspY9UNl4U9Js3cPyIJf1LWX3B8=;
        b=VmBHVDPpcba72LEET606+pb7ij13Gzed6I+jb1G10r9KT07f9J/U7X9ThSrUwWNrxc
         FyH/qA3CpqHcSzAo6B+zj6AJcFOYZSck0kcawknfhrYCdQuUkRhp/L5DXFZGTOWm94J1
         KGj9fK0TOVHe9XpRVaBqCcFMNncNn3ksL4eatcCKh29oBGgN5q2qYoNwApXeL0cwDVwR
         1PcCQJ7KFk2Ff1dwtZBMp9Z648CgSLRQ9N2k8iNz/P5ICKwAuhfeQIx/H8YEhMQPkOs+
         6sM3pD2RdSDoVZ3MCUC+DIGK2FIAcFQx8dkU2h9uVpYlfmZtzvnJe4xch/E9IgGcbmg4
         IOXw==
X-Gm-Message-State: AOAM5332rV7Vnu8ZbJPJYF2i7FYEW6QzgcdnDnVG8pe616AZS4uoolCy
        EnHm3/EZU9IRJtNmF8oja33yJQ==
X-Google-Smtp-Source: ABdhPJyFcwiE8p+3EjGfOvsoLk878M0ieL1Ui8l2qy7QH41JsAQpkCNjeKN5JPdLUIClBGPd8BMWyg==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr959984wmg.12.1613432083782;
        Mon, 15 Feb 2021 15:34:43 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id y16sm21691445wrw.46.2021.02.15.15.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:34:43 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     ross.schm.dev@gmail.com, matthew.v.deangelis@gmail.com,
        pterjan@google.com, vkor@vkten.in, amarjargal16@gmail.com,
        foxhlchen@gmail.com, insafonov@gmail.com, yujian.wu1@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/recv_linux.c
Date:   Mon, 15 Feb 2021 23:34:35 +0000
Message-Id: <20210215233440.80617-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210215233440.80617-1-phil@philpotter.co.uk>
References: <20210215233440.80617-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_COUNTER macro calls from os_dep/recv_linux.c, as the
corresponding variables are only ever written to and not used. This
makes the code cleaner, and is necessary prior to removing the
DBG_COUNTER definition itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index ac35277fbacd..f52802f24466 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -124,18 +124,14 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 
 					_rtw_xmit_entry(pkt, pnetdev);
 
-					if (bmcast && pskb2) {
+					if (bmcast && pskb2)
 						pkt = pskb2;
-						DBG_COUNTER(padapter->rx_logs.os_indicate_ap_mcast);
-					} else {
-						DBG_COUNTER(padapter->rx_logs.os_indicate_ap_forward);
+					else
 						return;
-					}
 				}
 			} else {
 				/*  to APself */
 				/* DBG_871X("to APSelf\n"); */
-				DBG_COUNTER(padapter->rx_logs.os_indicate_ap_self);
 			}
 		}
 
@@ -153,10 +149,6 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 #endif /* CONFIG_TCP_CSUM_OFFLOAD_RX */
 
 		ret = rtw_netif_rx(padapter->pnetdev, pkt);
-		if (ret == NET_RX_SUCCESS)
-			DBG_COUNTER(padapter->rx_logs.os_netif_ok);
-		else
-			DBG_COUNTER(padapter->rx_logs.os_netif_err);
 	}
 }
 
@@ -246,8 +238,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 	_pkt *skb;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
 
-	DBG_COUNTER(padapter->rx_logs.os_indicate);
-
 	precvpriv = &(padapter->recvpriv);
 	pfree_recv_queue = &(precvpriv->free_recv_queue);
 
@@ -293,7 +283,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 	/* enqueue back to free_recv_queue */
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	DBG_COUNTER(padapter->rx_logs.os_indicate_err);
 	return _FAIL;
 }
 
-- 
2.29.2

