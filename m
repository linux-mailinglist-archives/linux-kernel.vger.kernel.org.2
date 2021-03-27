Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8B34B79C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhC0OZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhC0OZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B79C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4418998wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=885GSipY1kCFpE3eLNTvvoQV/RnDLTkm99NiTmTY1Go=;
        b=H8Rx4t6EE3uuA+lfZIYcpJUU3hbjYYt+8LTKPq2FG/YMBb307Fg5lhx18esCxrte6B
         5eTkQOjvHmLKe74M0o66K3i2X5YfxsCe11v8H+zyQHenvNbZe4oMV1HVlbqbFHU89blb
         vwJioT/b472uyNc8BT7HjO05PEPIVtA8E2iC3t5eehhEupPEBx0C+Ic1CST166xDKriJ
         riBggXj2FHTClnB1mxlguA2BGOZrmjGYy8HWKvXvrtWC6ps61sZOVz8kkval3p2+tVdb
         RAzzlLEY9s+/nZfpOMOkRlROan118b42wlPj+4HWdgzsImmruOmeHxR46R4UFZh60+DE
         /IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=885GSipY1kCFpE3eLNTvvoQV/RnDLTkm99NiTmTY1Go=;
        b=C+irvENtNqyY06OIgiHY13zK0mYkGrKKl3c1U/vPQ5V4Rx+Zd2TrFuLreetzQGnd/4
         gHeNTQUqSi4vXwx4+Bjqry1dZot589V23pGmSWi12r0SbcFnw+cLti4YBvft8ypvcXxH
         6J9NvPMfvFTTPnNamMTli8JZAKWSooF9sWgZkyudeNmogYs3xEELnyscFkuhisdIbMAp
         UV3EoeX1+7pBkD2EZUImneoYVotM9B0q8KjoCvJ7f4k9GTTj5/KVJ5HsTlu3ziAOGMsy
         L5i4+wT5BstLsJeR6TZrQzSsUVfWvRnXzJmL7t9U4aHdBW/aFJkTYCGfb7d09WitaN9N
         lgiA==
X-Gm-Message-State: AOAM530qThlCJ6LKTaqYyjYDND4dG8bij4glqMiGJlF23LSqfzNBmZKR
        3j7k1yuQb4LurZZcpDCVxk4=
X-Google-Smtp-Source: ABdhPJw2nZxF2zM8bs17NCy5BvC6PXFVxHgKbRrK93V1nn8cVmr+1sqSor43c195LSpbHr0vPuJAZw==
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr17243310wmq.7.1616855111596;
        Sat, 27 Mar 2021 07:25:11 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id w22sm16400905wmi.22.2021.03.27.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 14/20] staging: rtl8723bs: add spaces around operator in include/rtw_pwrctrl.h
Date:   Sat, 27 Mar 2021 15:24:13 +0100
Message-Id: <d0695bf94766ee68aba70daaa1cdefff64c38b62.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch warning:

add a space around that '*'

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 6b2be97c2c07..b052b86944c4 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -89,7 +89,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };
 
-#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */
+#define LPS_DELAY_TIME	(1 * HZ) /*  1 sec */
 
 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
-- 
2.20.1

