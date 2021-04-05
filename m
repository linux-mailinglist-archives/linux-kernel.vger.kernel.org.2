Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464DA3545A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhDEQu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhDEQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4FBC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so11439688wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCYHSEy1io8xFVxyrWex3dyAIrjV7+IJ4+JqgLgs0zw=;
        b=qQSyg2q01F6yDrjYTle1Kdz1JwLwHSzOH2mg1gKfm4peiSbjIz8afnseqJsgJ6Jalp
         ziN05anLcYWqatdTTRQKhcVjkX8Yn1bUqsxfFll/bViuuUFYLurJ2jaHUXzoUtKemEpe
         0NfgIJRghUUWi28IoE3DgpDPXGikdNMUIY9HEQ4IXqf98r9uzAOAGCINdykQRA3RpIHJ
         BMsDBJTt/rZiE2QV3Q0nPqJfifv66+w2PK0RAxAFiQfqYe+mmhWxrMsLZn9s0fFS0XTb
         E9orE8CIF8jbfDYRYSRJ8V9HIqMv8JFKNhd8D6vrpV+Ul9S0H2ovDIBIbmjDdlI6Z8YE
         udxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCYHSEy1io8xFVxyrWex3dyAIrjV7+IJ4+JqgLgs0zw=;
        b=RUPbzz3ZAT4xaPalRAu8fa/rhqtBo5wRa1OENGTyvYebIV2mCRV2Qqocg860IJux/0
         swwFs3o0RhqrAn61L9pQuZTR+5i5ocP9knHSn8CbxI1Tw/d5sA09R5v6FtGSyfQ8cud3
         Eta9Kk09WQkYSA9ndfpvKPK6R0w7E/SW151OwRZXj2w0ewCnd7Cmv6GIsvJ5uU+EPw3a
         bGIaNZEkvaRLJEzTmtcmWDuUDTD6wjL9jTcbnhc1pq+Xr0wFSgaw7UcPNyCwAz8Ytn1m
         VNByKr3EyrYsleycN17rS0glLN6FZoXw5TFyqAxDM2baEvJVkUVRBBMHwSwBnbBoWG/J
         ezpA==
X-Gm-Message-State: AOAM530BU19qPqTgT4WhZMLDRVKI3YC0N3QrqwKLe1/GcZ2Iva3snl57
        lZ3FDp8Q8BTKUVQtM/8hlrw=
X-Google-Smtp-Source: ABdhPJxsOuSp62aYgTRm2QTuMAgH1WxIjLBgEOoD5ORPkqaadoRcfR9lEn65jtqmUMfMuFbxceX9GA==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr6737473wrm.222.1617641416610;
        Mon, 05 Apr 2021 09:50:16 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id h14sm34304597wrq.45.2021.04.05.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/10] staging: rtl8723bs: remove RT_TRACE log definitions
Date:   Mon,  5 Apr 2021 18:49:50 +0200
Message-Id: <163c0f17c88dc8977103a0971c50f4769ad78173.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove RT_TRACE log definitions.

Remove all of the RT_TRACE logs in hal/ and os_dep/ file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d3c77798a5eb..6639d79cd7ec 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,8 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define RT_TRACE(_Comp, _Level, Fmt) do {} while (0)
-
 #define DBG_871X(x, ...) do {} while (0)
 #define MSG_8192C(x, ...) do {} while (0)
 #define DBG_8192C(x, ...) do {} while (0)
@@ -216,22 +214,6 @@
 #endif /* defined(_dbgdump) */
 #endif /* DEBUG */
 
-#ifdef DEBUG_RTL871X
-
-#if	defined(_dbgdump) && defined(_MODULE_DEFINE_)
-
-	#undef RT_TRACE
-	#define RT_TRACE(_Comp, _Level, Fmt)\
-	do {\
-		if ((_Comp & GlobalDebugComponents) && (_Level <= GlobalDebugLevel)) {\
-			_dbgdump("%s [0x%08x,%d]", DRIVER_PREFIX, (unsigned int)_Comp, _Level);\
-			_dbgdump Fmt;\
-		} \
-	} while (0)
-
-#endif /* defined(_dbgdump) && defined(_MODULE_DEFINE_) */
-#endif /* DEBUG_RTL871X */
-
 void dump_drv_version(void *sel);
 void dump_log_level(void *sel);
 
-- 
2.20.1

