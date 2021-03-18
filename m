Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEF3408D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhCRP1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhCRP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76740C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t9so5960228wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6RdrbDpubj6J5vihjKmeNa/I/cW+KIcqKlP2w3YSfo=;
        b=lvF9CcQ+nh1eANtGR5piZmX0xhis2WOD6zBSg9SKnsI7XBn6LgdobHwd0l4QC7lkoh
         c/QFA4xOXQubE/HFiK0EbWTigASycwilxjnM12ZGC8LAPEbK8Xh1z4UE0UFsFsY6mtvU
         26UngOeNhrq0LLc2lXEO/AhlokAW52hXaIDdweaLS1C1qG5Osxo6q4/ghvt1l4kfynBe
         eo1NCz5Hw0gFKm/Jn3o0yg+QMR2JNlMNwnrDO2NBfIrM4RWDuUT2v4rPlNSBsPFQlTZs
         ywaA0dN4XTFJayEjmZtc7XeGCjkX/ry/LYKaoGIVy93bkGKhYQXawbW/TqYDMfPqmCTA
         hBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6RdrbDpubj6J5vihjKmeNa/I/cW+KIcqKlP2w3YSfo=;
        b=gqL3ArGWFz+7AoP63+L5L7JX0hgnLX+e7nV9/RPQ6KprdqPtMZMRfwElUU/h28AIZe
         C87fCyaPnM4pyUYN69EOYHDdYSGweaM7HDfKRQWLTDE4LkATI8g/oI8jl2VI1mctpVMA
         xQyyj0DmYpBdDGvA3eBVVY7vuSXyAz89TqH/8tKNJdkSSa18VvEC69QUa+hG/SxtkZjk
         ye87EsUSoOcroWrqgiSJIU4lRvUhpAJ10U23IFlhmhJMLh/TTB+t2+qTHvyQNgxuIBun
         ahaLEcaD3BoK5t7Kqod2/JBUqN9n5Q+P21agZoFZIAGt21A9ZLYk/L+9SQU2JvAdjIqK
         gduQ==
X-Gm-Message-State: AOAM5304eGLd23SZJL6R1+48ctaUz9VHIMU96+IFhzWnzrQfl+aNOsAp
        aEFM93ogfgfYDCbH54WY+cQ=
X-Google-Smtp-Source: ABdhPJyPvjHE8/FdBrvCRu7ytikvoXLXmpU6f0uCgm+JB7WnjzrhdQaBNKASegFTO95V108U7HaD5g==
X-Received: by 2002:adf:84e6:: with SMTP id 93mr9793845wrg.376.1616081219262;
        Thu, 18 Mar 2021 08:26:59 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id s83sm2626320wms.16.2021.03.18.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:26:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/15] staging: rtl8723bs: remove unnecessary logging in hal/HalBtcOutSrc.h
Date:   Thu, 18 Mar 2021 16:26:01 +0100
Message-Id: <20210318152610.16758-7-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
126: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:126:
+		DbgPrint("%s(): ", __func__);\

and remove the whole unused containing macro BTC_PRINT_F

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index c38baf2bc412..aac8e8ed080d 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -120,14 +120,6 @@ extern u32 		GLBtcDbgType[];
 		DbgPrint printstr;\
 }
 
-#define BTC_PRINT_F(dbgtype, dbgflag, printstr)\
-{\
-	if (GLBtcDbgType[dbgtype] & dbgflag) {\
-		DbgPrint("%s(): ", __func__);\
-		DbgPrint printstr;\
-	} \
-}
-
 #define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr)\
 {\
 	if (GLBtcDbgType[dbgtype] & dbgflag) {\
-- 
2.20.1

