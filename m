Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43E369576
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhDWPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbhDWPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDFC06138E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso1404914wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSLHJhjopzWcP47W8szCHSpkYXOdx6ZRmSWKH8NfH8Q=;
        b=P/4SuNpHsZtkzBkhjsGruXATGeJnp88z6zBpYdr6+hAX0cWkz0b0b/eiLL+OOJEYcA
         5sJHcdiB8KXaHDhOty9DgPvRVwzPSo5b5eefBWEvo3cBzDH0tZp50lyKqmKTq5TzzU3K
         BzNAAAOEoKHq/oIjhhRFrwhA0Irsj+zq266XkOUMvGmY1XNu7LPl/6jjsnnZCLsgZoWg
         YQNadi9u5YuJekZgZnq8q9wjbrbT5YL/ssPyEwUtSvWO6L2T9emM4pjE+q4RzKJPO4NM
         Va5cBCfuRYEZ7VNUj+nHGbYxNqpJdEi+Cnfkr63j8ny8CmwvMS+F7J4tURwQBxK9IXs2
         ggNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSLHJhjopzWcP47W8szCHSpkYXOdx6ZRmSWKH8NfH8Q=;
        b=OwkPVyH8/psNflkqcttZa1KbPcxbEx2sCpkxfbV1uCLNhKEMykoJdWgedYNNlHk0Eh
         DopOXku29u2G5cyLKsuSBeASkBSLOfclMDYTGfP0VS46TKvtb2Gb5STqtb4iKkkpWQz3
         ygiYBfXEUN851QTV9Y2n9YPtYxTlozSN8rDsZdfq5i/t6HHX0bpf77LIdktcJ08UrnpO
         m2EMlx0ydpLGLP08IphG2sHZVwlxeDHIS4RdDwtSdql9dTOWV/EHsCulxU+dd11P9juY
         Q2B7SXxE168jc3c7oTWJJqw2pnTgv1zvayV6AveGDL9Mdzx3+6Jkn/cdwRciionHS2FO
         XrjQ==
X-Gm-Message-State: AOAM532K4XstJFAfC1kafxsWKA3wY64AHEvQdx9xrVXg5+M5nJ8T3rgN
        XQfyVytJ9QLHswOPNX0TW8N3wPNCIRI=
X-Google-Smtp-Source: ABdhPJyOZza0PkYCghAHvjGwJTe0pNCXkAk+ZgtDvDd+G2iEnbmHl5p77ZlgMIDm3bDNcTQ3AkUP8g==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr4717857wmi.29.1619189993474;
        Fri, 23 Apr 2021 07:59:53 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id z18sm11341658wrr.9.2021.04.23.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 43/49] staging: rtl8723bs: remove unused macros tied to _RTL8712_CMD_C_ definition
Date:   Fri, 23 Apr 2021 16:58:34 +0200
Message-Id: <17f32db57ee14170c53df113370f185d841f00c9.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to
_RTL8712_CMD_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 550cff9b1147..1a52200e525c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl8712_cmd_c_		BIT(26)
 /* define _module_efuse_			BIT(27) */
 #define	_module_rtl8192c_xmit_c_ BIT(28)
 #define _module_hal_xmit_c_	BIT(28)
@@ -17,9 +16,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL8712_CMD_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
-#elif defined _RTL8192C_XMIT_C_
+#if defined _RTL8192C_XMIT_C_
 	#define	_MODULE_DEFINE_	1
 #elif defined _RTL8723AS_XMIT_C_
 	#define	_MODULE_DEFINE_	1
-- 
2.20.1

