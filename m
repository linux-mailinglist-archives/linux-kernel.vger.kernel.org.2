Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7536955F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbhDWPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbhDWO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E8C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g9so32692335wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT7xLGR/u98oUeFxtP8FIkbPXzcjRalBgVrGk8h35HY=;
        b=mlrh+t1+toJD+jvvYVxjAwWpjhowFNzMA6Pq+99h7jrnxG9gUpps/g2fyDgvAbaWXz
         zLnVRkV1PURSJzPfKtczN8wAXLi9h8QxW0vr56qS/H61mfP9Sxg3V+chWYTilNYSURYt
         MMU9jxbdV9nyct0jqH/tTtqU30wq0wa2UIBZITgYJ4yky0RA8F9FBq7J8fSrz/pGchkg
         9LbhvZbNV4peYTxU0fj3RaJaHXRjuzZX5otk5ko+frBWZaOAx97trf3QuuiyVp728FDG
         2FhqsBBWxN5N1FaDVo3WMluOSzHQPUhj3hf8k6oLJrLZkWFXTRUqBrAp11CAIUxJz00J
         NtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT7xLGR/u98oUeFxtP8FIkbPXzcjRalBgVrGk8h35HY=;
        b=YpK9PDR3dS7qq9rMoCB1kkDRhWT39whWWpYKc3ZMpIfoHXKAr4Cwke9DiaHKaBId1W
         DFBJIqPY9DMreNT6mYbA7SY89PLKeyACUmrZMHVfsHDKE9eF+w6E3EnddNG7J8sY3euK
         lUPDp5LUEUoLjOGFAQYI+c+dKhy2oQec/LKd+dqO/LbNXQWQoeDP2kgdImnIt9/WZ4ib
         GGuTnm1E4Mr6tfIaWH8YGHMoq/Kbx3yt/cnxfzPmzhkvvOnWKsCvStzcMT2OB97fllCK
         RR7t5JPeRYa0pTbMOhWKV5DMktoBTzGpKDhF+uX3Cfb5YoS7Ag4xl15K/dIs4bosD+r9
         2nvw==
X-Gm-Message-State: AOAM533/BEF0IU6Be5QW08z75Np0DdUdBba8Da8sM42M6iRs9zT3gUJa
        aENhCraBZiVwvsRzMnHhoXWAT5tRrq0=
X-Google-Smtp-Source: ABdhPJwyqPevWd+FJFUXDiBY0cbq0n1y7jtD7eSQyCVrztIZRxneeF5GW391yxNp86CiEFIywfGE2g==
X-Received: by 2002:a5d:69d0:: with SMTP id s16mr5286531wrw.102.1619189959406;
        Fri, 23 Apr 2021 07:59:19 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id l13sm9356780wrt.14.2021.04.23.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 23/49] staging: rtl8723bs: remove obsolete debug macro definitions
Date:   Fri, 23 Apr 2021 16:58:14 +0200
Message-Id: <dccf1519d6da1d646d493bbbefe7cab45954b539.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definition untied to any tracing component.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index bb56d38e6b7a..6e6dea4779d9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_cmd_osdep_c_		BIT(8)
 #define _module_rtl871x_io_c_				BIT(9)
 #define _module_io_osdep_c_		BIT(10)
 #define _module_os_intfs_c_			BIT(11)
@@ -35,9 +34,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _CMD_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
-#elif defined _RTW_IO_C_
+#if defined _RTW_IO_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
 #elif defined _IO_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_io_osdep_c_
-- 
2.20.1

