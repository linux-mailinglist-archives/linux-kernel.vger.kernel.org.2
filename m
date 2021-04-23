Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36D7369561
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbhDWPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243114AbhDWPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c4so9801955wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYEtVs71demyjHNP7zVoWDRnn91iokd22i1cMtV03Xk=;
        b=dTFDOVUhCQy/HyZI45D/BRGsGYn7pPNKhW0rjzitmxWCiHZGwjhGtsYbP0KvpSZjFG
         ia9lz7GVujnpkyw+xpAAYjXvhBdbh1BVf1cvMhN2tG6bnIovqsk6JA3CCzOIP2Y956hH
         /4ZzsC/hMFx7RdFzpxz32qCeVYyLHX+tsdG2FlKgamN4xvIP1i6/A4nf30qyZbztwPOi
         FwbEgMmE6KyWaC4xNZaaENRLi1mG48n+RdWOrH6ihEmpjHtquXQz03VcQWBosYZHqKQt
         2wZgGoX3Rm5s1rw3pG3kxBQjHtoyiPUeH9NuqfaueM4swuXrM7mpYfZ9L1bY6lzHDJV0
         ny/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYEtVs71demyjHNP7zVoWDRnn91iokd22i1cMtV03Xk=;
        b=fqWAuPyw+4X7qR0Pm+pakaRVolxqJu1KLLYBw++ZqYhXY7FADhHFzFosVifLD02Z+R
         JWFsJoofN+WrZs86x1k3iA7/DWQiG7RhPtxKFmsGNg3K+QSQzSmBWrK5/ybB4WIQZw1z
         Fsecvl03bNXWiOF0sdeaJ5zZBGs4zIJPAo1iM0U6lpzSo5a6ubUCGYdt3wWdEAXrL9IX
         JagMl1li7YGKY8n4pOgIxA8hN4NXFauaQ/iXm5Blria1l+ygUK96rnaoHyC0fQ7an7hp
         ANMqz4W0Zxh11NviDX3c60zPJfK6O1JZB4WpgKM0oCMP01Thzq9gZarStSILvi8wn8cM
         8uqA==
X-Gm-Message-State: AOAM5312O8a4p0eZJ5+lGY568NdwaQaql9NR+dYa8jwKF8rfOmQxFvsa
        Te3W22XPmW9uUXXUb1oVReINipgOgqk=
X-Google-Smtp-Source: ABdhPJwR972YNryguem4qNYhTf7ipjU9t2KZfvCsg+GRcCleP6kgvUTGKZiRZDwYpKiEulOAARcF0w==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr5259719wri.211.1619189962771;
        Fri, 23 Apr 2021 07:59:22 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id 2sm10781344wmi.19.2021.04.23.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 25/49] staging: rtl8723bs: remove obsolete _IO_OSDEP_C_ debug macro definition
Date:   Fri, 23 Apr 2021 16:58:16 +0200
Message-Id: <a2d3a6e3523b06ab706d3c137a9703705dabc1c7.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove _IO_OSDEP_C_ debug macro definition
untied to any tracing component.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 7206fdfbe12d..470edb0b655b 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_io_osdep_c_		BIT(10)
 #define _module_os_intfs_c_			BIT(11)
 #define _module_rtl871x_security_c_		BIT(12)
 #define _module_rtl871x_eeprom_c_			BIT(13)
@@ -33,9 +32,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _IO_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_io_osdep_c_
-#elif defined _OS_INTFS_C_
+#if defined _OS_INTFS_C_
 	#define	_MODULE_DEFINE_	_module_os_intfs_c_
 #elif defined _RTW_SECURITY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_security_c_
-- 
2.20.1

