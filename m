Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4765A339F6B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhCMRPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:14:59 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90373C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:14:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n17so9806490plc.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nT5JOdOGE7vNld2SAFCD+UmB6bIy2oklK2SEW9uMfXY=;
        b=vUD0Sa1mRkMVokQLx+Lx3h7Xtf1LWgIJDCvxT6YzknQPco05uk/KjoWZ2/+jWbeUs5
         OKqea6iQk9/r5DmQYba32Qc/vlcwaWwxqXnaCYw1g8d1T2ZkoZoBATQKAMLfrcl8A2H0
         cUQX7R7KP4xp/2yUABFlbyAcK77YbJb4tlO3S5ChB6Y8Pl2qS3VIoLu38FoH+u1AlFGp
         gnqf3tz5LOimQnYSlEQgx5kpoKYyRtA/xUUy8HzfLKTGYm6+nhMYdgcGxWayJNLME5PG
         h12u89fNPW5As7OVUBlO6obOCuhiDpeednd3NcHlJIfrNIpCTSRhs7ftOOsqwF8ggqh1
         dXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nT5JOdOGE7vNld2SAFCD+UmB6bIy2oklK2SEW9uMfXY=;
        b=ZakznqO6re3NohgnwEX0asqrKj80rAjvFnfKoJ4uUbQva5jj+DhxynfCsc/+KqdQqL
         51fnt7Ha0CjhOCqUHuNkNt1Tc2LIr2ERCWGqfdj+XJra6YUgHwUE7dPTnOkaa3Mu5l62
         th+RbjbVkVc3dSNs4VSyS3O/NGgr6Sdw8Tuzz3Sxsnxq+cUVKgmxXK/TATcUeFj1aVjl
         pLND4bGS6UaIc1T1ikWsajCEdcJrBiHCE/BF/aLXgeyZCoRdAJGqLKqwKVuAVKINdWql
         U+9rgwLig+zPjRDk00ps1mjLOSpS6hcIArUxAr6K0Z2cvm6xbzvtVJIljtnSqMoU1/pU
         1qCg==
X-Gm-Message-State: AOAM530f+kEiTMUMOuxd9YVDE+8zYgOn5p+LshnaAUoA4e+1RDprTHys
        RRsgH03i2CTB0kv+UYbkhG4=
X-Google-Smtp-Source: ABdhPJxJl5D2JQCsAaB8jLtVXXjSpWNcdqH1RLejHHAhCK/jkKJcSQ30ND2y9AuUFp98xrLPE8lqIw==
X-Received: by 2002:a17:903:22c1:b029:e6:8800:37c7 with SMTP id y1-20020a17090322c1b02900e6880037c7mr3929904plg.61.1615655699049;
        Sat, 13 Mar 2021 09:14:59 -0800 (PST)
Received: from shreya-VirtualBox ([49.207.200.51])
        by smtp.gmail.com with ESMTPSA id q205sm9456552pfc.126.2021.03.13.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 09:14:58 -0800 (PST)
Date:   Sat, 13 Mar 2021 22:44:53 +0530
From:   Shreya <shreya.ajithchb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        d.straghkov@ispras.ru, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, bkkarthik@pesu.pes.edu
Subject: [PATCH] staging:rtl8723bs:core:rtw_wlan_util:fixed indentation
 coding style issue
Message-ID: <20210313171453.GA2640@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the indentation of the else part of the conditional statement.

Signed-off-by: Shreya Ajith <shreya.ajithchb@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 975f2830e29e..4b5afaeac916 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1760,7 +1760,7 @@ void update_wireless_mode(struct adapter *padapter)
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
-	 else
+	else
 		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
 }
 
-- 
2.25.1

