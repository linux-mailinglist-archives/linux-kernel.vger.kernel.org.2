Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863A936FCB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhD3Opp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhD3OpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24FC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so105674771ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBMRL9okd6exFYzTetsEZ3MsVPUnPB4cIvHOO2Zf8iE=;
        b=bf7XtLmZ3a4j+WmxKgSroJgvhYtqdydN8eGUU3bLRx4+nLTGSFujzRAOSNmzeVIz9A
         cDRi7AnXPXYR9BwyoNhcrtna34dV7hxCQSVA2rW0N440dcPBWFVFD0X7COB2+vEntow4
         GXUYGDKbA6y6/zyWL8zLJ1N8I8ei5EXHIlWKH7ifKUgbzf/+w681Gf9ACs+g13tmP4Im
         mLFTtyjXsA7L8dEa7lZykACJBILat+ImFEA4PpJLpK6wtILPnyM+A+xM0gNK/vAEl9MO
         W52aDsZMYp30mfFPbCWiYfVb6+MSufFjfRykdTnaDWFO9XD3aWs0WowRiLEa3BpfZCbr
         lUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBMRL9okd6exFYzTetsEZ3MsVPUnPB4cIvHOO2Zf8iE=;
        b=aRLrg5az8TzT/69zDaxNw11VeoGBVmNEN5uJNIp9UXTnTP8TovME5uqC9K+F+pDz83
         EH56xLKp1JPMWcsQnWqWPZxK2kEBrPMpbkR4iMB4fwJhWQrxtaCANOvvlHy+MAT2/XWA
         Y4ryyYSwtNM/8mliVF2KAx2wHR4PLgTVkbkwU+r1QzfvAXs6bH+AK+6OdcjRmfux8l66
         V3QNPcEOtmmIpTmQc4Xj2AaFMsX6okXnuoNHyrZYbl+84wH56FyoX4BP3qH7v7WU1Fmd
         sLg7ykfjmIch7IthtVytfWDv6XlRc8QDKsobL3jytwRnIcRepmqZDrya6W5ptG+j1kOa
         PTFw==
X-Gm-Message-State: AOAM530nVmyRuHvYqTxDBsJpL8xu7lx6JplzQpasHZRdz6GVhIRq1g3b
        UcuasEEAWX989n5n3A03v4IqyAFk45c=
X-Google-Smtp-Source: ABdhPJwvCC9wvGum1WaZzQWVctF4kGFrfEKzOGnvOaG2yRNK0cj5FIx6a7Eo/bBcAXSE8yn6ALxlHA==
X-Received: by 2002:a17:906:a006:: with SMTP id p6mr4792278ejy.350.1619793872782;
        Fri, 30 Apr 2021 07:44:32 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id o13sm2084553ejx.86.2021.04.30.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/43] staging: rtl8723bs: remove unused ODM_dbg_trace macro
Date:   Fri, 30 Apr 2021 16:43:42 +0200
Message-Id: <00ffa6097928ef93cd1ef31d1b96f968d5b2b874.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_trace macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 58de4d16335e..cd68c583699a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -96,11 +96,9 @@
 #endif
 
 #if DBG
-#define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 #else
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
-#define ODM_dbg_trace(str)				no_printk("%s", str)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

