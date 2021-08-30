Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A369A3FB5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhH3MQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbhH3MQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46646C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v10so22146822wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eF8hUMXIhBsRJkAF7DIG+jKUHZ6c4iXSE2pyRmvKCds=;
        b=mvf86/q93n6Lwm976tOSViTKEdu5SNinrbjpM4CzmDzRbbAoIfZWDuFvZvUMWiJeZm
         9us4DgjI0GC1+A2zqv01WzST5eBV50kELy14PoJ8hoN1gcZNCBnlDlfx/ysEZP0DJ6Sp
         RgCPntLM/QJzNZGTSCTHNnWz95y33xR7tlrbFM51JEwYq449oU1yNzpDbB1e3APRTCHZ
         n7LLp+Uhi1C6XBNtjoPnCcoEm7lJ3boh+drWY3nv3791KUUIs/mcdZxHmwkWb5iMUi/i
         X6JhIn7BSVJMzDolEqzoxVfGm9Fx1Y+hsE3eUqSMBOpJdrvDpJ/6aOwTrUdno71shKd3
         2svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eF8hUMXIhBsRJkAF7DIG+jKUHZ6c4iXSE2pyRmvKCds=;
        b=UAEeobta832G9Cq+V3r3rRTSM0Fa3qEJP6qZJhmKubnG57Vg+dGnkE1EW6TvcHDstl
         uSn1GO0yA3nyLk/7KMQE2QrRUHwoT48v76eFEclKN9Php1Z4b0LHgX9SO4c+HG2Ap1lF
         v1cN1KZKfER0IzrPthNzdnCFg5jqcEPt11+Hj7C3w2O89iXfZBDbmSXjHIWDA/bQ3Ru6
         d19scFhAaqT+MRvuCiNKjaggpHMq4xsJE7zmjO9P+3t7tNmVrtbrl95M4Mvv/ao0Cq1N
         6BLO6mgjTA9ctVM6ADM0sSHFcfiFzjqk7oBBgYuKSVrwXn9xr5Ku+dGlze6o4TiXKmk1
         JBrQ==
X-Gm-Message-State: AOAM532ZRh7CpEj+m4ktnxkXVlhoA+uaKTgrqfiZ8BJTZH0DZ5ElNB7y
        YmxjyX4glrpd7I9UU6gci6fpERJOl0ubCw==
X-Google-Smtp-Source: ABdhPJyl3rAxqQrt5eRZv/pCgx/o50rAK3ATJtra8lZGmZT/6G2AX7ysZFK5u2hfnEKl8rfd0oxfjA==
X-Received: by 2002:a05:6000:343:: with SMTP id e3mr17514382wre.96.1630325743933;
        Mon, 30 Aug 2021 05:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/8] staging: r8188eu: use ETH_ALEN
Date:   Mon, 30 Aug 2021 14:15:03 +0200
Message-Id: <20210830121508.6411-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ETH_ALEN instead of hard-coding the value for the mac_addr buffer
in struct eeprom_priv.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index fb591a764dac..d0c812cf5cc2 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -99,7 +99,7 @@ struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		bloadfile_fail_flag;
 	u8		bloadmac_fail_flag;
-	u8		mac_addr[6] __aligned(2); /* PermanentAddress */
+	u8		mac_addr[ETH_ALEN] __aligned(2); /* PermanentAddress */
 	u16		channel_plan;
 	u8		EepromOrEfuse;
 	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
-- 
2.33.0

