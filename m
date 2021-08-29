Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFEB3FAA6D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhH2J0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbhH2J0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F6C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so16766585edi.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLylW8qLXz2u7LloJuD10wtdquAh4p5+/9Dglkl7ulk=;
        b=fSxJf6cdNzwvC3nmK+eoy/xckDnU6+8D41lcV4YcWa/B6T+jvGRxH/JftMNHoSCBWA
         cnpB2mhfgd4P9UD6gSepQtNvdbiE76Gf5SyByErW6hFzk/7QDjUhKhBEzVOfDmLIQfFi
         c1fy0x7SQ+/tXpVcmWe7ULxjE3ivEhJOpy5tbmlUgxbjf3G1ZBWeYT0y8TGIKe5LtQGh
         Nie3Cg3wZuBb2OOOqJOpkFNs2kTuqafekT934co/H/q6H+GKZYVRzx1dvwEAWeJqphRn
         BGH7KAmy44/iSZ/p/pmH2tZ8c+7zsjXBJlGfJkL47mIkCvHEGCpY4vaTesRAVcft9nL/
         JTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLylW8qLXz2u7LloJuD10wtdquAh4p5+/9Dglkl7ulk=;
        b=CY3KvyksB/Oyy4yGoVEd+t1cNhCSQNjCfqrk+eBUh2aijLiI6xtivYjqstfuFzQzl1
         LOs26sBVcMJuZ/sAA0gMHpIF2u5wfi0j+QBDcw/K7yPREQ+cQcHmeIZoM9laTSZxHx2i
         8FhQMhLTfE3/SO4jl0A4kWAoNGhkqiuSLweZTsRTupfafmQyy7hmxM43tQyWIPsK4oah
         zu/g/IGZhf69cK0UhZzfCyU199yuPBoYsoI0BB0j4osNHuUfWuFvEFVuz3Hdbyn1NJHo
         ppCYyggwvWbtGsY9X8lb9tDIpGl4chLDr4A0EYRP9bf268VoFN0cSFaLiN3E8jQDAjG9
         Cj5w==
X-Gm-Message-State: AOAM531ZXX8pcKey1NtIJYVBaSMlzYdufYrZIufvXdrchSdGqxHunq4M
        D/34o6OEawlPrBuzTIDfM3w=
X-Google-Smtp-Source: ABdhPJyAIYZ2bmENyN5L+vT1PpXgrIJeVCeIYA2bO78EB3VLw35iGIwalyvU5ugzJoxvpVbrLU4MKA==
X-Received: by 2002:a50:eacc:: with SMTP id u12mr10582779edp.140.1630229120664;
        Sun, 29 Aug 2021 02:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id d23sm5814414edt.39.2021.08.29.02.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: remove rtw_get_oper_bw()
Date:   Sun, 29 Aug 2021 11:24:57 +0200
Message-Id: <20210829092502.3658-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829092502.3658-1-straube.linux@gmail.com>
References: <20210829092502.3658-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_get_oper_bw() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index a3a5e1c64c4a..e13e4dd189be 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -304,11 +304,6 @@ inline void rtw_set_oper_ch(struct adapter *adapter, u8 ch)
 	adapter->mlmeextpriv.oper_channel = ch;
 }
 
-inline u8 rtw_get_oper_bw(struct adapter *adapter)
-{
-	return adapter->mlmeextpriv.oper_bwmode;
-}
-
 inline void rtw_set_oper_bw(struct adapter *adapter, u8 bw)
 {
 	adapter->mlmeextpriv.oper_bwmode = bw;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index d2f4d3ce7b90..b3ca9f3fba7f 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -447,7 +447,6 @@ void Set_MSR(struct adapter *padapter, u8 type);
 
 u8 rtw_get_oper_ch(struct adapter *adapter);
 void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
-u8 rtw_get_oper_bw(struct adapter *adapter);
 void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
 u8 rtw_get_oper_choffset(struct adapter *adapter);
 void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
-- 
2.32.0

