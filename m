Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205033FAA6E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhH2J0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhH2J0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE488C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u3so23958717ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KAggIOTRw7mP2XUPqwInFJGQ6kfnxU40BL5VQ+AlEk=;
        b=k30t/3q9ZtaJPU/sfCDPcGhM84f72gpfO/FXJZx+MdR2LkYRQI1ym0gbMXx54oJ+4i
         9UH+JyHEYEJ8HF5SL1htl0z7CHD/gc51xNiK5uw7Nbljz70i4eJIVKk2nvkEEzFqJp7s
         ZKD7EEJnvlneX5Fm4Eqt+TSpokdxrv2JBv6UQgPBR/dhtbfzoO2iJ51isIpYFH8TvLdk
         M6bsnjhSbYWqiWItql8zgCgFTUHj9g4BU5CeDcS4NmTvL7sOrTFleSAF6tPp1oM3gGaA
         zQvdD8uwCkBFGJ433jjbsLjVidbI7VaOUpIPAjEoJPb3l/utu6qGF/BYLYY0k2B5NXAA
         rMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KAggIOTRw7mP2XUPqwInFJGQ6kfnxU40BL5VQ+AlEk=;
        b=f+gRpRa/QFnvK9ZNQbuQlt5F5rtFsqquAsMKT6dG5S3YxGgBMJsdwXSEvwZHmd1Big
         jAC2C2f2Wlp5duJSJLBuKBqfPwnR0sY95G1nA3HlOxbBlfUX9T+D8eDWx4BChiAmL6Vr
         Dia11veDg9uXkeYw0WuKowFWkMuZiuQ6c98Rl1s26aNux+SMeQ3vQ1pLImAXnhMHpLlu
         a3X28ybhZc12WAZn5Wvuv55X5h/C+//3bxsXeH49NN2IcH1145MXTxEix26ZKQuxHR1K
         upVKvEfvPlNXu6OYg45Rkevbqu5KbgtZqs3O0uv85N++W2yn0RHgM5flNhcqhTtQMxta
         aJWA==
X-Gm-Message-State: AOAM532zY7WI1s2QX12ZAgLRbHtKaCwHInDiOeWQisO9caUr69VrO6ni
        pHbHPVXGI0rArbteWZn5sr0=
X-Google-Smtp-Source: ABdhPJx3wILaXTg8gN4iOYXb5vCuPtRH0GP96eNh1yHKAn8siVFstp/p93CdT+Q9BezPubxiJgH+ug==
X-Received: by 2002:a17:906:9b1:: with SMTP id q17mr19132695eje.546.1630229121574;
        Sun, 29 Aug 2021 02:25:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id d23sm5814414edt.39.2021.08.29.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: remove rtw_get_oper_choffset()
Date:   Sun, 29 Aug 2021 11:24:58 +0200
Message-Id: <20210829092502.3658-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829092502.3658-1-straube.linux@gmail.com>
References: <20210829092502.3658-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_get_oper_choffset() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e13e4dd189be..57330b3a66d7 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -309,11 +309,6 @@ inline void rtw_set_oper_bw(struct adapter *adapter, u8 bw)
 	adapter->mlmeextpriv.oper_bwmode = bw;
 }
 
-inline u8 rtw_get_oper_choffset(struct adapter *adapter)
-{
-	return adapter->mlmeextpriv.oper_ch_offset;
-}
-
 inline void rtw_set_oper_choffset(struct adapter *adapter, u8 offset)
 {
 	adapter->mlmeextpriv.oper_ch_offset = offset;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index b3ca9f3fba7f..fe3a32f17308 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -448,7 +448,6 @@ void Set_MSR(struct adapter *padapter, u8 type);
 u8 rtw_get_oper_ch(struct adapter *adapter);
 void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
 void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
-u8 rtw_get_oper_choffset(struct adapter *adapter);
 void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
 
 void set_channel_bwmode(struct adapter *padapter, unsigned char channel,
-- 
2.32.0

