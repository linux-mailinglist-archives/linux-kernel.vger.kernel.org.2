Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6834345EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCWM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhCWM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h13so23327504eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19IRUc5+ZB5fvu32721d6m/+pb2FwSn7JGumPUCdqeA=;
        b=Ygjjhgvl78RcNFPtaR3HwKk4TODDWtrX1LMPQmeA974UcsZTwzEvOe4tZfycjw3Hl3
         +RsNbOHBBGevua7JUAwlJXpfcDv6W3UiY7Lq2005RLp790DhV6lDgPcjvuh/LPFHx5xI
         i/ISVoDaLOGU2sO3JZFFnztC2eouEBJ1cDGr88cU0gcBqAtb3UbZbCSJYjZo/lHesxIN
         a2yeBUhtgXwkiqUHZTlC7+SXmLen3seNE0Yojzjg1YiASkUpg4KclsX3fQQfQTEtMiBA
         MLdzUsn2sPa9EsWuPHZ6YTUX/e5lKFnDtLc2y6bQXqBe0BbvHhmn/BS18c6uq59AEkHt
         XV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19IRUc5+ZB5fvu32721d6m/+pb2FwSn7JGumPUCdqeA=;
        b=bkMLqoS8iSThqdeJ/4Lwt4TRG17q+HdPpCXUwir32jvmJi82FOLo8pofOX80UQ8KNC
         MWp81WLUIabH3Vkm+Fa97hI6H9QtoZSUeOsTdXEID2F5Smf0M9lv5cD99zlS4F0ezTyB
         4OC7ifVN9wfxuYhk6XQebtwXTH4veT/fCGogTtMD+smxiIoZ49qXv7X2dCjemrJThzIS
         oowvLdh4YX1uRtSbxbi94LQE1B5aFKPc55DFrStohQ5i/gcUAVND2tew8xYJ9z5uBOP7
         CG1MIM7VYVfvbaOaTZwZ5fmlF9td2uttcUxHqkabxSj+ZWUZRQ3b3Wy6PY01TeJ9E7cx
         nx6Q==
X-Gm-Message-State: AOAM530sTf8Mr0S/Ow4/L/GBol1A2YyMSELB8SROaydihGTFX5C5Tgs9
        kTlb3OqUeiD+o7jXqxcBGP8=
X-Google-Smtp-Source: ABdhPJwf7l8iikvh8N4tE++kVgRui37jnS3XosQGbCYcxCDvMUkAGI8e5BH2yIQIuECzy4hBzlX1IQ==
X-Received: by 2002:aa7:db53:: with SMTP id n19mr4616284edt.330.1616504297222;
        Tue, 23 Mar 2021 05:58:17 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id lu5sm11283699ejb.97.2021.03.23.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 2/9] staging: rtl8723bs: moved function prototype out of core/rtw_ioctl_set.c and core/rtw_mlme.c
Date:   Tue, 23 Mar 2021 13:56:29 +0100
Message-Id: <da654adf1295123adca07e3e5809e256dd4def69.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
+u8 rtw_do_join(struct adapter *padapter);

WARNING: externs should be avoided in .c files
15: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:15:
+extern u8 rtw_do_join(struct adapter *padapter);

moved function prototype in include/rtw_ioctl_set.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c         | 2 --
 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index cb14855742f7..7d858cae2395 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -37,7 +37,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 	return ret;
 }
 
-u8 rtw_do_join(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head	*plist, *phead;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 95cfef118a94..1ee86ec2dee7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -12,8 +12,6 @@
 #include <hal_btcoex.h>
 #include <linux/jiffies.h>
 
-extern u8 rtw_do_join(struct adapter *padapter);
-
 int	rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
index d6d3c39a69c6..31424bf2d926 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
@@ -22,6 +22,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
 u8 rtw_validate_bssid(u8 *bssid);
 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 
+u8 rtw_do_join(struct adapter *padapter);
+
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
 
 #endif
-- 
2.20.1

