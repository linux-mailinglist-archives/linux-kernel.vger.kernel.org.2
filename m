Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9C354EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbhDFIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbhDFIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:45:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09960C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:45:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a1so15563341ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q8poru9A3hWLZTxGl7RMJTZmQhNBYI0YiTv60kbCOfc=;
        b=nrIoxXpe40DGcIFOjnCJXz5ZUABv1ihdHsn0TMarsOE0SgMeIOC8dNrKFEWkFYRlUJ
         XJ22hBzYsvKEM65p9uUQlHaxcgFyjEpW7MHAcXOWgviwp/HXc4pzNDPpqk89SDq5LYYE
         0xWKq52vgIO4a+n8Z8yJd21AoW/7uquDJeCh+t8UuGfieW//WFrd1LvtaX8o22xKvP8s
         bDp3RFemUJqifYATDHGHXCsfs5On/PANMjWR81pJj/jF+S3eDlavy6B2iz+jPGeoNC76
         dJtNDLu72TKkl3A4NEL4U3XINjmmXfuPBEr97u4M8TEU5y/AMGR7FWpDTThWmc2EhvD0
         BalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q8poru9A3hWLZTxGl7RMJTZmQhNBYI0YiTv60kbCOfc=;
        b=tAqdfDIzyvLD5LDTBO1HH7s9NSAtwQPiZE2weSJgidm8o+THz9cWl281EKbhtXzoxY
         58RPQ5FIECNvyLnd0hLhlOoQTUofjl6kC2Df0vB8NeGXx3OAgaLBaVOuJrwQONEw81ra
         2GcCLSiZhWiIuq44Z8S/wBhQsqDQyCJBScD354X9vEZT2MSlAvDPtnU93B9NsL14x9Gj
         L1FsGc61cxkGOMT59fkTrDaPqy74GLiqRzQiQoy+nee6Xs+mSqK/abnKQRpVuBzqkhSx
         g50O+besLPRl/w2fqY9fJFfBcjiOd28t1RBiRJD7JSfZtBo8pwMuMLuB/4rKVMluG/ME
         IQAw==
X-Gm-Message-State: AOAM531uxzV2PhN4LE+8opQ7vfOE3aw7vWzqgFG8Fh8dnuUaufL0YhMx
        VtO6tqkkrWLWxTRiZzpiHM0=
X-Google-Smtp-Source: ABdhPJzhq/QUfr29t0zaWePucTIlJugoSix4+11GRzoUqruLaWODKuebxPOvuDLgtO5MBKzStwrG5A==
X-Received: by 2002:a2e:302:: with SMTP id 2mr19319901ljd.159.1617698724508;
        Tue, 06 Apr 2021 01:45:24 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id d8sm2130411ljc.129.2021.04.06.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:45:24 -0700 (PDT)
Date:   Tue, 6 Apr 2021 14:45:23 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 1/4] staging: rtl8712: add spaces around operators
Message-ID: <1fa63e851a6fa403798b95b64d9147c9b3b02c93.1617697237.git.zhansayabagdaulet@gmail.com>
References: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around operators to adhere to Linux kernel coding style.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  4 ++--
 drivers/staging/rtl8712/rtl871x_security.h    |  4 ++--
 drivers/staging/rtl8712/rtl871x_xmit.h        | 10 +++++-----
 drivers/staging/rtl8712/wifi.h                |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 60dd798a6e51..6b3c5914efb4 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -144,7 +144,7 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		for (i = 0; i < wpa_len; i++) {
 			n += scnprintf(buf + n, MAX_WPA_IE_LEN - n,
 						"%02x", wpa_ie[i]);
-			if (n == MAX_WPA_IE_LEN-1)
+			if (n == MAX_WPA_IE_LEN - 1)
 				break;
 		}
 		memset(iwe, 0, sizeof(*iwe));
@@ -164,7 +164,7 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		for (i = 0; i < rsn_len; i++) {
 			n += scnprintf(buf + n, MAX_WPA_IE_LEN - n,
 						"%02x", rsn_ie[i]);
-			if (n == MAX_WPA_IE_LEN-1)
+			if (n == MAX_WPA_IE_LEN - 1)
 				break;
 		}
 		memset(iwe, 0, sizeof(*iwe));
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index b2dda16cbd0a..8461b7f05359 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -101,7 +101,7 @@ struct security_priv {
 	union pn48 Grprxpn;		/* PN48 used for Grp Key recv. */
 	u8 wps_hw_pbc_pressed;/*for hw pbc pressed*/
 	u8 wps_phase;/*for wps*/
-	u8 wps_ie[MAX_WPA_IE_LEN<<2];
+	u8 wps_ie[MAX_WPA_IE_LEN << 2];
 	int wps_ie_len;
 	u8	binstallGrpkey;
 	u8	busetkipkey;
@@ -185,7 +185,7 @@ do {\
 	txpn._byte_.TSC5 = iv[7];\
 } while (0)
 
-#define ROL32(A, n) (((A) << (n)) | (((A)>>(32-(n)))  & ((1UL << (n)) - 1)))
+#define ROL32(A, n) (((A) << (n)) | (((A) >> (32 - (n)))  & ((1UL << (n)) - 1)))
 #define ROR32(A, n) ROL32((A), 32 - (n))
 
 struct mic_data {
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index cc58c7216935..1fb395c9d068 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -42,7 +42,7 @@ do { \
 	pattrib_iv[1] = txpn._byte_.TSC1;\
 	pattrib_iv[2] = txpn._byte_.TSC2;\
 	pattrib_iv[3] = ((keyidx & 0x3) << 6);\
-	txpn.val = (txpn.val == 0xffffff) ? 0 : (txpn.val+1);\
+	txpn.val = (txpn.val == 0xffffff) ? 0 : (txpn.val + 1);\
 } while (0)
 
 /* Fixed the Big Endian bug when doing the Tx.
@@ -53,13 +53,13 @@ do { \
 	pattrib_iv[0] = txpn._byte_.TSC1;\
 	pattrib_iv[1] = (txpn._byte_.TSC1 | 0x20) & 0x7f;\
 	pattrib_iv[2] = txpn._byte_.TSC0;\
-	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3)<<6);\
+	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3) << 6);\
 	pattrib_iv[4] = txpn._byte_.TSC2;\
 	pattrib_iv[5] = txpn._byte_.TSC3;\
 	pattrib_iv[6] = txpn._byte_.TSC4;\
 	pattrib_iv[7] = txpn._byte_.TSC5;\
 	txpn.val = txpn.val == 0xffffffffffffULL ? 0 : \
-	(txpn.val+1);\
+	(txpn.val + 1);\
 } while (0)
 
 #define AES_IV(pattrib_iv, txpn, keyidx)\
@@ -67,13 +67,13 @@ do { \
 	pattrib_iv[0] = txpn._byte_.TSC0;\
 	pattrib_iv[1] = txpn._byte_.TSC1;\
 	pattrib_iv[2] = 0;\
-	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3)<<6);\
+	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3) << 6);\
 	pattrib_iv[4] = txpn._byte_.TSC2;\
 	pattrib_iv[5] = txpn._byte_.TSC3;\
 	pattrib_iv[6] = txpn._byte_.TSC4;\
 	pattrib_iv[7] = txpn._byte_.TSC5;\
 	txpn.val = txpn.val == 0xffffffffffffULL ? 0 : \
-	(txpn.val+1);\
+	(txpn.val + 1);\
 } while (0)
 
 struct hw_xmit {
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index f941efb1f4e2..a5992818bc5a 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -26,7 +26,7 @@ enum WIFI_FRAME_TYPE {
 	WIFI_MGT_TYPE  =	(0),
 	WIFI_CTRL_TYPE =	(BIT(2)),
 	WIFI_DATA_TYPE =	(BIT(3)),
-	WIFI_QOS_DATA_TYPE	= (BIT(7)|BIT(3)),	/*!< QoS Data */
+	WIFI_QOS_DATA_TYPE	= (BIT(7) | BIT(3)),	/*!< QoS Data */
 };
 
 enum WIFI_FRAME_SUBTYPE {
-- 
2.25.1

