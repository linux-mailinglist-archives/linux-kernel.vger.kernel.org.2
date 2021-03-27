Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1434B794
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhC0OZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0OYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:24:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CEC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b9so8356538wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//9hLhfyOWBWZCb8GsLQLBDmUYE2F7RU23TdKixYDIs=;
        b=jcG/0LsekPPFmtrj9C0P4JXamKqEAQTh9UHvBNNmpa50s+Lr/sKvjy4fnVtoA4mWhc
         NIEhOK8l0piQMXiouAG1CYLsN8QD7c5gwZwaZKnu6XvvzXuKsDYoepCQ0G9MBqL7TIpm
         Ki5zKERHB1puRu+exz2ZABNv7HBhIhUxuFFq46j5yfSDHxeTNV7maH9qBKEoNATHzL6C
         +zdhGWe0DbRsRrJoS7K/1TuntL6TEykrSF55Qwa7dRbJYQiqVQ3XVFV8wDyzPxHp4Uq5
         Hufd53bUOANCZZ7gERyWlcPqUxxYz3w2Mf8vaFg49xN/NGnR8TNRgMS6WneUJWMoWd5y
         vEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//9hLhfyOWBWZCb8GsLQLBDmUYE2F7RU23TdKixYDIs=;
        b=N0wgB5yDfjNXEPbgkp9gHXfu02wdFF1uvSYQMx9jHcJ21Y48jatqlSaFr3ZM9jdV/I
         domOLVMUyUw4VXUu/nsKbngCqceZBuD3IfryBKMR8L7Kg7Bie0a6m7z4mhz0ax2VeRZU
         xSqxq5BeTnZAnWFpF4bbuibS0KdhYrvdlD/XojQ+lMR1zyBebDFMEzxEEsw3IBJcXseN
         2eFSt9fCAiJetFWpz1mxdKhqQ+4c3m+OdwwDmE88xIfS8MkVuXQq/sXBfUOlpZt6ktsn
         DspB/uHD+dYchafoike4EMXHLk7jqw+RHxi15aCp+z1Yhla4W5Q2e8zUhK7RwTfj1R4G
         Mmgw==
X-Gm-Message-State: AOAM531Vtvq8JJaxJLCU4AZnbDo/ANKdzCwzS+xr8nSlD+TREIeP0fkL
        Rrwmyj97Vh6CsxoWnh9cvBM=
X-Google-Smtp-Source: ABdhPJxcsDBGoQU+53G2YZTvgEVGVGwsKXx30cbMRRbcThogKjNvDm/QGZD06xfJup19xtaNXKgtcQ==
X-Received: by 2002:a05:6000:1149:: with SMTP id d9mr19553487wrx.347.1616855091938;
        Sat, 27 Mar 2021 07:24:51 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id f2sm17541572wmp.20.2021.03.27.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 06/20] staging: rtl8723bs: put parentheses on macros with complex values in include/hal_data.h
Date:   Sat, 27 Mar 2021 15:24:05 +0100
Message-Id: <22c4bc695d3600fcaec18949c7521fa38aa4f4a0.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with complex values should be enclosed in parentheses
49: FILE: drivers/staging/rtl8723bs/include/hal_data.h:49:
+#define CHANNEL_MAX_NUMBER
               14+24+21        /*  14 is the max channel number */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index 93ee20e8e860..655528ab8c7c 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -46,7 +46,7 @@ enum rt_ampdu_burst {
 	RT_AMPDU_BURST_8723B	= 7,
 };
 
-#define CHANNEL_MAX_NUMBER		14+24+21	/*  14 is the max channel number */
+#define CHANNEL_MAX_NUMBER		(14+24+21)	/*  14 is the max channel number */
 #define CHANNEL_MAX_NUMBER_2G		14
 #define CHANNEL_MAX_NUMBER_5G		54			/*  Please refer to "phy_GetChnlGroup8812A" and "Hal_ReadTxPowerInfo8812A" */
 #define CHANNEL_MAX_NUMBER_5G_80M	7
-- 
2.20.1

