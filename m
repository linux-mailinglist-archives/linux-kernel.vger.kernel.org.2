Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561A436957D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbhDWPCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbhDWPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53188C06134B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z6so8398814wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1aC/KYysf2u98efPHVNtXofbiGurQZJ94vgGaYPVJg=;
        b=QmScpSxyI1oavnoQSSBSQx41+9hh8Mc2tv53Rj9OJ80FrEVWiEdiz2JBRXPkMihOx4
         IjRaOUAbPH/qkETdMHd2+w6uuMTNuLTrwlHpUcVzO3rj7jj4VW1siB7uX4jWBORfN7AE
         KxdfrmXXEMQbE+tbU6gPL2PwAisRHrHMKCI9CgHnLxpZNskctk+rhQ3jXCFL/YjstSLz
         UB/nW1k5J1ATRsJ66lxqstEqQIBlionQ+WRulU4CAVSePli8xgv/iNCkVia76BDoZbIh
         rRmXWYhEd9zU6kmHVHC4BtotoedbiGVsC8nLLQwESaHH9Rg965gJBD0J+wl59c+1MM3W
         +/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1aC/KYysf2u98efPHVNtXofbiGurQZJ94vgGaYPVJg=;
        b=HWXC/A0TmX6JIIXyTgrD8t6TeF5A2XkFSyZHPe+0xz1f+oROAQ5Db30jjlW62i+q3j
         5kYU2yLyCx6xOM4NamZ7R7Z245PyR49USGA+XhdX/CRS7GB6YwkAOILd4kJIKcpOGOMs
         gu6kllRad2fVDFk1S1gTNd99cp6pm3Oa4pWeYhOvObl1kNwcXq3EaRFbAW0+5ebwAai2
         l9Vzqb8oNmVHQNIs4fmU7UFtHuY4DGfcRG9Zyh9uClYGGRSgfyprsbG7Sm/QfGXMphoj
         YdzRSi/ova+Joh3Ph37co1ui2atK6xXgNb0hQuvGrEEbISN8e/eovWFi33ihmXvKyszh
         fo4Q==
X-Gm-Message-State: AOAM5334j6hWTe6WviSyJv6q+rWQIR8aqPi/2KXRMwjy0OYSduXeJsVB
        bd4ixXgyDDfcVfQpcucHFQfJGZFqZSo=
X-Google-Smtp-Source: ABdhPJyGNH/J3++9XX7uONfOj3dr2AXWfImOu0o/+kw1tKVX02lNxyj70Y3cTvqtJMNsvgT44f/Kaw==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr4740001wmm.110.1619189994956;
        Fri, 23 Apr 2021 07:59:54 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id c6sm38529576wmr.0.2021.04.23.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 44/49] staging: rtl8723bs: remove commented out macro definition
Date:   Fri, 23 Apr 2021 16:58:35 +0200
Message-Id: <b1cb624374f6ae8adbb24e8e217966df3fd8c6f9.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out debug macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 1a52200e525c..cde4b1d6a4b7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-/* define _module_efuse_			BIT(27) */
 #define	_module_rtl8192c_xmit_c_ BIT(28)
 #define _module_hal_xmit_c_	BIT(28)
 #define _module_efuse_			BIT(29)
-- 
2.20.1

