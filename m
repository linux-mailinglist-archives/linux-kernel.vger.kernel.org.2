Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F643408E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhCRP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhCRP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g25so3851607wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAVWeRHn9iAhdC0Ut9ovsSctOKr2pG4p/gzTEx4WbI8=;
        b=j2DXa2DI74N+aQrXQSHLIpCDHPMQt4hlnxM+MVvUCGs5TNa/Rk6BAL3EBnN8s6fpaM
         0fcXFln6o14dED+EUK/x0BLwvEXwxp46G1YCiQTnwYbjnfOPtupc+dlWh2Zm1R+sdBcj
         t1jtWgfBZsi9dacz5YcmdasoIYMW1spr4Y/s+j3n43OpnOERlkMXCZ8WmtTosfbpyFlr
         xmUvl2sITTAa3WTOvWDdyRQuWb9p8EZ4kh4ZHs8EXqvpoU1SB3YM3d7CF7B+o0bZ50u3
         gBeoKtCj8y4ZtAW5TlqPdgFkrH8AAPUb064ORefJ5aTofV0loTdiXbhpUGmPU3PDDPlX
         meYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAVWeRHn9iAhdC0Ut9ovsSctOKr2pG4p/gzTEx4WbI8=;
        b=N7e5tz39PXySJeB6bnbPHxJ/RT+Hnf3QtLVBi/kawfkbKcz0P013HDYAu8VijsZixE
         hzZ3z27j/lhrjocfbBvNhtGSUrBRjeZoIDBpZ3w/MjnwJ73o19A7HoRdHNZnQ51dLfpO
         5oR1laXyjEtxPtKVp7ef3FQzPvFpZu3u12QE25blXIu0JCruXcqdDNWloCfQiSmJZGob
         XZL3CAKlX03O8dDS0pZkHnsbpTl8NZlFqTIpxXipaq1aDW5Zy3uc5VXN7PpK4rx61Jbe
         jA0ynRwH6U1Zec2ySeosJqyf7ifpUNv0+l1mxY2MaBkY0w1YejVmKsUVuj3KpBz5tH3t
         Ksug==
X-Gm-Message-State: AOAM532rqvpCNZxXfIM8xeNWbSKH2hgSH7nAajseTImZX+3xvtNMD84u
        5MnWjEB6ZtNjYGglVG/LlRk=
X-Google-Smtp-Source: ABdhPJyZeVHONd+40V8pCLPwRvYiiCs/Th4yfBMQ07+RNCceL5dWFGLP11cl9mKBM9QbqOPGuNvpAw==
X-Received: by 2002:a05:600c:49aa:: with SMTP id h42mr4277827wmp.49.1616081241221;
        Thu, 18 Mar 2021 08:27:21 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id w131sm2768807wmb.8.2021.03.18.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 15/15] staging: rtl8723bs: remove unnecessary logging in os_dep/wifi_regd.c
Date:   Thu, 18 Mar 2021 16:26:10 +0100
Message-Id: <20210318152610.16758-16-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
153: FILE: drivers/staging/rtl8723bs/os_dep/wifi_regd.c:153:
+	DBG_8192C("%s\n", __func__);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index b3d87a971398..93a35b94d8bc 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -150,7 +150,5 @@ void rtw_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct rtw_regulatory *reg = NULL;
 
-	DBG_8192C("%s\n", __func__);
-
 	_rtw_reg_notifier_apply(wiphy, request, reg);
 }
-- 
2.20.1

