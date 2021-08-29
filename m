Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6353FAA6F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhH2J0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2J0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC3C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so24023700ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssZbkXOIC8Nc+zuDyC8swwWy/mmc9lT9t9cyKL316Ho=;
        b=dOtYhdlQsClPRuAS4N13+n5zgEgSGoDsxsEsSGOTnh2nJvDF6kMdVxJ8JqwEsgpjyp
         YPbBN6NKzI617+WRtYiBm52gRaikB7yCWncuBG2+d6Uuf7AtthzD5cVW1Tl3fkrphCBq
         GX1P8SB2nQ6ZtWShMujhqcr3Q77Ke3/0BIEH+8IKkK8MLfXKpcfg3KfAzNdauFYkWPWB
         /eEbEvBIAsiegsvf+BINH60b8EmF7yGrgcoeLnyVHuqv9PkBof0Tu/D/e0MYguRdIGkd
         bgZS/UStu/ikMuIPrKhxURIGzYS18k333wbNpYQLm2wpM2vmPxqsBw33Q33rkZCncjyo
         WpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssZbkXOIC8Nc+zuDyC8swwWy/mmc9lT9t9cyKL316Ho=;
        b=djABnvFKOL2zhb9GIgPDbEXKfbahPFMKbxCCVT0rRq04E6sBHLIh6J7YL4RtKFy6RH
         9YUImBmCSqKq47gv78hVEjvbu15RNu8rBtUdnyuNSQoKB05l5/YslIQygVQeKNIwquMQ
         jvxPsMNLXGAdDbJuPTA7IyLXjmxBhPzkCtNIXookJzH6XgtyDM4tJItCqhHSkiQvWbEB
         OgnmIkingP+R1ZVZ2xk7mrSh2yGgMS3cTF0mh5795QFrVw/CDMGnF1cYCKrNU8Evqrza
         1r/dC9gAEUJcxsN+NyO+FHqb2EwlxC01dxd1yiu/6t+gfPrUyjXZO+cdCxHCN8r5kos/
         1oXw==
X-Gm-Message-State: AOAM530+UE7Q1i2vKCfVTCOoSI+8Z9AUbUO1Yx5l8eVxBZ+1q5mF+56p
        CyNrQhE0fs3JltQurY1QP6s=
X-Google-Smtp-Source: ABdhPJxuz0SCg+0G9G78XYDNCr6JniNYVg/mYCJdp5hKRjU82zeR98CSKeZuhbYmuLOVVgRPi0eQeA==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr19410856ejb.39.1630229124427;
        Sun, 29 Aug 2021 02:25:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id d23sm5814414edt.39.2021.08.29.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: remove get_bsstype()
Date:   Sun, 29 Aug 2021 11:24:59 +0200
Message-Id: <20210829092502.3658-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829092502.3658-1-straube.linux@gmail.com>
References: <20210829092502.3658-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function get_bsstype() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 10 ----------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 57330b3a66d7..bc10a08d01e6 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -363,16 +363,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	SetBWMode(padapter, bwmode, channel_offset);
 }
 
-int get_bsstype(unsigned short capability)
-{
-	if (capability & BIT(0))
-		return WIFI_FW_AP_STATE;
-	else if (capability & BIT(1))
-		return WIFI_FW_ADHOC_STATE;
-	else
-		return 0;
-}
-
 __inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
 {
 	return pnetwork->MacAddress;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index fe3a32f17308..c6b17da73c5f 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -473,7 +473,6 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame,
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 		    struct adapter *adapter, bool update_ie);
 
-int get_bsstype(unsigned short capability);
 u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork);
 u16 get_beacon_interval(struct wlan_bssid_ex *bss);
 
-- 
2.32.0

