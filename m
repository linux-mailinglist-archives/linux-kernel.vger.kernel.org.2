Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61B36FCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhD3OrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhD3OqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C6C061360
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id di13so674990edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ge3P0WNdYY2EQIE5X7at+1ZyKJ0Q7vBILrEN41L9FQE=;
        b=BypFmereVEcLcMqhVCWFrGj+x295WiPf9AZ/WGDCvLLdPgeUeJNn0Mzj0cDRpWwme7
         CEypNEWsDvNIYebXW1RA7O33k7Wvffimj46NFMQgY6ukdHe3cNZFc0FUnXibrTZe0Cwr
         CVFeZgjr04Z2q6n31MPIQr5RYiXnzkivFgHFDbOokwpYHCPg3Xez4uDD6/8j07mMXvyj
         crKgTKh+kbNnPEm+U1m5S3sNfBkjSjlijgt9XTiiX+ix4Ayjg5RdJQZLcSsSIKkt8qwu
         C1D1KIbKnVDiq/kA45DzMVOkyvfxRtFC3GeKAcFfx2GtZncz3KP9N9HAQJkcx3K3wnlb
         dH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge3P0WNdYY2EQIE5X7at+1ZyKJ0Q7vBILrEN41L9FQE=;
        b=tIgUblK6t5YsZ5TFERZ1eYvDBMoQ3nVwY1aeJNvHRGIdylmVNj44XUAyPhb4Bys3nJ
         AxYGTgPJ26NGO9H1oN7U8J4u4Pvs6QKmx7zi+06oByx6leoWqCpA1/B47Yw4VH1/c91c
         mTH21om6fqGGfvPJ6pa7c1P+2Co9UynUstOWPAbEefz+OPg3fXSFCwdC1RNqMT69rcTZ
         JIJyvCpXBK9ADL87dH6E9yD+eV+piwklgEyCZaOAoAKhJ2vlJ1uOcOqduQOYXGYY0FZn
         atY49o7nTpAv+NLg+24pPomEEfMj/N3Km4X0XmSqSHqR99nBxSNhNCQVaZA6W8RmIi1s
         Th3A==
X-Gm-Message-State: AOAM530zxEmdt1NWOAYyQhgtrdqsw8yMeMsTYhXiNaMhMwl/M2CaLCIB
        BD0+eKg6px6ajG4oLIAHPOvM338qfa0=
X-Google-Smtp-Source: ABdhPJxkDFc2AI+0XKPQuItfPN7FciugkKCOoI0R6fp80xyF2z6IQMijI5vOcHzJWNEdM8XX8F8tgQ==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr6491360eds.166.1619793905279;
        Fri, 30 Apr 2021 07:45:05 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id p21sm1508769edw.18.2021.04.30.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/43] staging: rtl8723bs: remove obsolete debug macros
Date:   Fri, 30 Apr 2021 16:44:04 +0200
Message-Id: <a2fad07a6c1c625333c02f59ae4d8cf3e08ec779.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete debug macros.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index c4616a69425d..db9d8a529877 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -78,22 +78,6 @@ enum {
 	BTC_CHIP_MAX
 };
 
-/*  following is for BTC_MSG_INTERFACE */
-#define INTF_INIT	BIT0
-#define INTF_NOTIFY	BIT2
-
-/*  following is for BTC_ALGORITHM */
-#define ALGO_BT_RSSI_STATE				BIT0
-#define ALGO_WIFI_RSSI_STATE			BIT1
-#define ALGO_BT_MONITOR					BIT2
-#define ALGO_TRACE						BIT3
-#define ALGO_TRACE_FW					BIT4
-#define ALGO_TRACE_FW_DETAIL			BIT5
-#define ALGO_TRACE_FW_EXEC				BIT6
-#define ALGO_TRACE_SW					BIT7
-#define ALGO_TRACE_SW_DETAIL			BIT8
-#define ALGO_TRACE_SW_EXEC				BIT9
-
 /*  following is for wifi link status */
 #define WIFI_STA_CONNECTED				BIT0
 #define WIFI_AP_CONNECTED				BIT1
-- 
2.20.1

