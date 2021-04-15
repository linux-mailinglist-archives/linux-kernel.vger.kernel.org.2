Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88850360695
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDOKH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhDOKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:07:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113CCC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so22738124wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFAMp/tJSwgmo4xDcL/XkCGjvOXExZ4h5M6fYiNEoIA=;
        b=rKBbOPEk2Cgpo0nAqQl9TlarieMnK/GgzcTlp7qoG7udCobGRlqDFc/oRxGZNBU4cC
         qXpvAh6r5ILVpYlwKcdKSwrbaiFabeezATu006KfEj8dnb3IYsamEJfpMzG9pNkMnaT8
         yWmGTVPZwyldudotvCI5Fkc4mc3Gh60rO/ZCDsdP/N97zb7EtOVgN0G2kOKgdpXfHlVm
         FU4EtY/7UNDTe7+7xbDHrtQbUdhHjkIkrcd6k6Lb5PwUOweaZR3SFBCGhyg1pogdr4vK
         PQcwDUF83eSCKjIQ50DH8s1pe74vZ17TlU/ZOITyDxDqdJn85UAu+iwzXeHDHkw7vp+b
         z8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFAMp/tJSwgmo4xDcL/XkCGjvOXExZ4h5M6fYiNEoIA=;
        b=dlHHjeZiVXYybO62dI1ZwaYZ3GJsrHF9BUlmpwfJmQ7jq+1XThgLbrShpcrfwL7ntg
         IbT+tWZzxnSnufuINxudVHdAdsHgZeUYeRbL470RfkIAnyeu5DV1/byQTC1Q0KW5W1r0
         J/F5GgehSXgGAhdj4fKO1P5DbncrlHTLIYj3we0JVPdlpwjxelVCek7pI+hSMHbBCJ0t
         3W/eSS4xh4nDEVicqCFAfVUzmTmrst+Lgbbg6Mnr2pfBBbdcHL0NouoyAtMB0YWS4A3/
         hs6u9V7kDchIAH68TtZsEeuyXoZP42PfWse1siS883ucmQRdB3vXxXeEPBzXWaJjmu0s
         B6uQ==
X-Gm-Message-State: AOAM531h+5xxrQdv4/CMlAZrfBup9O5bm9EyA9ViWf1E1vi+h1BXceSC
        PEmMXotjJgtyv3+h0c/6cDNTpnDGx5A=
X-Google-Smtp-Source: ABdhPJz935YMigtl2i4TUgElWqksJSsOO2OoN1IYcW9qxbUcHOaoqiZb6F4bpSZzyPvB4qUHqVbetg==
X-Received: by 2002:adf:b650:: with SMTP id i16mr2671795wre.189.1618481250630;
        Thu, 15 Apr 2021 03:07:30 -0700 (PDT)
Received: from agape ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id l9sm1827460wmq.2.2021.04.15.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:07:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8723bs: fix code indent issue
Date:   Thu, 15 Apr 2021 12:07:20 +0200
Message-Id: <2e0ba5214df41de7e46b8df4e62d2f38acea92ec.1618480688.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618480688.git.fabioaiuto83@gmail.com>
References: <cover.1618480688.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issues:

ERROR: code indent should use tabs where possible
887: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:1145:
+^I^I           "%s: ### ERROR #### driver in IPS
+		####ERROR###!!!\n",$

ERROR: code indent should use tabs where possible
888: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:1146:
+^I^I           __func__);$

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 2c04a9e37bc5..160f624612c7 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1142,8 +1142,8 @@ static void rtw_suspend_normal(struct adapter *padapter)
 
 	if ((rtw_hal_check_ips_status(padapter)) || (adapter_to_pwrctl(padapter)->rf_pwrstate == rf_off))
 		netdev_dbg(padapter->pnetdev,
-		           "%s: ### ERROR #### driver in IPS ####ERROR###!!!\n",
-		           __func__);
+			   "%s: ### ERROR #### driver in IPS ####ERROR###!!!\n",
+			   __func__);
 
 	rtw_dev_unload(padapter);
 
-- 
2.20.1

