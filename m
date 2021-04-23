Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E236956F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbhDWPBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243278AbhDWPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94736C06135F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p6so42040291wrn.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AedyWXn8rMwjV4hec6YOWAkym+19jwGe7xRprf/SrlY=;
        b=VR2/iVh+OKq5WiGouAt5aXvKhf5vcMLxXKHFMo9pfEiVt3aMXHbNgtZY3AytegT6m1
         gkEWfZHR0epxqkTPSOg3NS6D/P5OlzJe1QqOSXhU6vAldKw0qUpnvbXXL0Ro126tfuOu
         H6YUSryQo51LErS44nTQbgypr8JpnuOivY2+v+aouhJoSU9ND/CX7Rvmcu+LKVJhRXzC
         ttBXrFcJOA+9w4bZiMWUB2gbTZ8db97j3GuJnqHVks0BGxajcZ/kGpEgh4r4JnlmsxZa
         eGn7BJaH5gd7ZmjgogVyGTvE9SksTb3FKQnknehVNKm8Q8DOPYlZM0LNxbaVHpUBSPdE
         OH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AedyWXn8rMwjV4hec6YOWAkym+19jwGe7xRprf/SrlY=;
        b=KANv0cjdecsIPbrADmQTDneUcXaFDLwBCNOu3TFS0VtWfqY/rpMAinKrfQbc5pUGLW
         plRR6k80T7OozSRFZU7DSUkSevrOIOj9gw9+T8TejWY98fTv9t65fYfRpXF05aHqsczl
         flGmhVDSo7436w/dw9FW5hDQehKVmFP+1aKsC+jyQ9+RRqrNAV7Ayqh64vV/lyZXNhHY
         6CMbpuOaL57rPvvhy2nTwLw3WDwX97K43xV/MTp1ocPJ4CuwTDslSbJlgm5Rd/bSIUYy
         4skEEPWA1TtdHoBtKDzMWLXki0raXev2SU+hUbnbI3q8Cy5WeSHi4zmP1+c8Ub5Dj9Qw
         tJHg==
X-Gm-Message-State: AOAM533hsLlPGn2kR9n0+mI/YXyF5tjCRePFIe5Mn3gu4PQ2cyDdHP2U
        ekT6dmb7C7meGKLiso2WdwDxJf1LSoQ=
X-Google-Smtp-Source: ABdhPJxh5AACHSLvbosz1i/MgdiUIrD9Ja44VesSJQeHn8ZB3FHg/wRDX84/E5ikZ50v/IQERVBH2g==
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr5404617wrd.159.1619189982965;
        Fri, 23 Apr 2021 07:59:42 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id c77sm8014287wme.37.2021.04.23.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 37/49] staging: rtl8723bs: remove unused debug macros tied to _HCI_OPS_C_ definition
Date:   Fri, 23 Apr 2021 16:58:28 +0200
Message-Id: <67c04ee5a9f5b0651369abe7284aa188c4e05301.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
_HCI_OPS_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 130cfe3d2032..3becb1b8d15e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_ops_c_			BIT(21)
 #define _module_osdep_service_c_			BIT(22)
 #define _module_mp_			BIT(23)
 #define _module_hci_ops_os_c_			BIT(24)
@@ -22,9 +21,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HCI_OPS_C_
-	#define	_MODULE_DEFINE_	_module_hci_ops_c_
-#elif defined _SDIO_OPS_C_
+#if defined _SDIO_OPS_C_
 	#define	_MODULE_DEFINE_ 1
 #elif defined _OSDEP_SERVICE_C_
 	#define	_MODULE_DEFINE_	_module_osdep_service_c_
-- 
2.20.1

