Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B701C3EA590
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhHLNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhHLNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:22:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516BC00EAB0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:21:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 203-20020a1c00d40000b02902e6a4e244e4so4555882wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZVGRDskmDYPzdeftiEChxL+8pjCbPwDx5dz49Ifopg=;
        b=Q0PCtmR0L6F5btX+R5Hfv9xq5MzN6nGw6J5iuD8a/favIQ5eYGtcvjbNnHrOrwxeRC
         ogScilg8e2dVTmhL3Gs2f3JUuA3uwSEPGA3ANRBMxg2L+QBzWoBkCN+8DKj2/M7S1NZ2
         y5IVFrblsZNGCmQUagP8A57ywq5Mf8IV60ER0w0/GisQQ+/Huyy3sMZDrlmEgBEajExs
         2dzdACx51jp1spYesfW2Q6/ZRvIUtE95aAGs9QMG04lqGPeUB42NYHWPHDhS7FOEiW4k
         kILqb+4bbgpd6f+r0783O7CWJRf90RBR+fQRJpryNEMOKk1dvYEtGaqAtDvj611Ekhm9
         bNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZVGRDskmDYPzdeftiEChxL+8pjCbPwDx5dz49Ifopg=;
        b=MEuMwlAYYbnMbgasPh/2yWqygR9XoCrbLGBCg8RuZ/wSf4obIQXzSjBwyp/2mFdwAp
         +8LJBRdfEdSgI+G40wfslUFpg78nbvrWyC8ywWVpdPdK/dBRI1skAtAQqGttLU6oEVsQ
         2Mc7i+dINmYR7c2ww+PPXeLvIl8gjxxg1REBFi7P25/DIm5pyg5SYAZRMMfPFx4lJTEG
         bgWVE772+a4Wzw63y6GN6iUaOGddUeITl3D4bAOf24YXZcCMEp/QfUdzILic3dKl0Abc
         PchHq2eA4P6phOr8pzey9xl2xDoXBi9enVu76SSdM9OCN4tj5RRgVjWuWlVKke1wOMvI
         ZpAw==
X-Gm-Message-State: AOAM530kal4h/FIaUo4uEWyxxB22SPi/O+6brcLDMt4jVgzrz5YuXdbj
        tFWIbMRHcP7S9oX8+tdvHdc=
X-Google-Smtp-Source: ABdhPJzp3tkIzXP6JNiRSbT++SHr3fYHl/ylsd2avLoJ9AHERWYyqr2mcU0dd5Ig+zKdFBaMKOkmGA==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr4052145wmk.96.1628774507441;
        Thu, 12 Aug 2021 06:21:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id f2sm2041006wru.31.2021.08.12.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:21:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: replace custom hwaddr_aton_i() with mac_pton()
Date:   Thu, 12 Aug 2021 15:20:57 +0200
Message-Id: <20210812132057.22579-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom hwaddr_aton_i() with mac_pton() in core/ioctl_linux.c
and remove the now unused functions hwaddr_aton_i() and hex2num_i().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 40 +-------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d059b738b348..38ee41f9d2ba 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -89,44 +89,6 @@ static const char * const iw_operation_mode[] = {
 	"Secondary", "Monitor"
 };
 
-static int hex2num_i(char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if (c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return -1;
-}
-
-/**
- * hwaddr_aton - Convert ASCII string to MAC address
- * @txt: MAC address as a string (e.g., "00:11:22:33:44:55")
- * @addr: Buffer for the MAC address (ETH_ALEN = 6 bytes)
- * Returns: 0 on success, -1 on failure (e.g., string not a MAC address)
- */
-static int hwaddr_aton_i(const char *txt, u8 *addr)
-{
-	int i;
-
-	for (i = 0; i < 6; i++) {
-		int a, b;
-
-		a = hex2num_i(*txt++);
-		if (a < 0)
-			return -1;
-		b = hex2num_i(*txt++);
-		if (b < 0)
-			return -1;
-		*addr++ = (a << 4) | b;
-		if (i < 5 && *txt++ != ':')
-			return -1;
-	}
-
-	return 0;
-}
-
 void indicate_wx_scan_complete_event(struct adapter *padapter)
 {
 	union iwreq_data wrqu;
@@ -2512,7 +2474,7 @@ static int rtw_get_ap_info(struct net_device *dev,
 	while (phead != plist) {
 		pnetwork = container_of(plist, struct wlan_network, list);
 
-		if (hwaddr_aton_i(data, bssid)) {
+		if (!mac_pton(data, bssid)) {
 			DBG_88E("Invalid BSSID '%s'.\n", (u8 *)data);
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			return -EINVAL;
-- 
2.32.0

