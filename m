Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E400D33EC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCQJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCQJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D5C061762
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so1004657wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bN4fpSzo8exezj3x7f+Hv5XSvvEKZvIRblLuzQg15wk=;
        b=VkIJrz36/HXe6e+FwdGdkS73nKnV9YjVMOH/+Im9wrZJGKMfaBStj8UO2zNOyszrOp
         Ed2mZ2zpbuY9dhE691tTGxUlMhqhqIT7skBo/1fYeJMmJW2DK3sEAELLkp/LYusolm3f
         qmZfeXwtXHlClMgZj0QD9srG9K1zDtA0c4OpcnrMWuCaABq1Qe3zprGSzyW3T9HfqgD6
         44cy8CqbD9mS+An7QASyBFPFeIjJP43lZxtQ7/HuaaNM32FNB3qvIZiFbpxsZf3+amiX
         ncJ7V/aBdKh6lDFrfxoYDitOTcj1HNcfYzrYqjLmEVIbkKmmgN40lGxV7OKQkupECLlJ
         8EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bN4fpSzo8exezj3x7f+Hv5XSvvEKZvIRblLuzQg15wk=;
        b=QzBE4jg7K/6Uhh+zVvD49Dmb8WZ9QkoxbNjT5tlHAf0q25rUn17bnx93xeM4ohzcu1
         DI34jrq1e7wMuDrwp9QYggQgNKvqbnViOpRkleEsqNtJBhh82qMhHnGHrbuvC1Asi/k4
         T7dUc7cCf+Glz3qGLHozAKTO3xqYwFCgtC7pRWPKyxHE9CyOBHoTFO6Jy+G2r4m+d0sX
         eEyxoVq/1oE5WnJ7DjcXQSvLizV62b29FYChWgzERyfkVfVasJqSNGi9tLlWbxPuEF0w
         L9XFMCoIG7FaODEudejRK83/rJV6uChtr6Or1vWRPzbfPqV/cL7QH4207uzOjFYaYyQO
         yq2Q==
X-Gm-Message-State: AOAM532bE7pEXUyhRADbjbZmtxj0M7ozJm/9eSyj2GfISfAS3NlvlArt
        gItov+yU/lzV8YTtF1YUSsmtqw==
X-Google-Smtp-Source: ABdhPJzdUfSyxp16Fxr4les5oIJRzRmIzCuQsiDIzk7b0x1kydxLSr8PnX+L9g67uz/0ILyGmTdSGQ==
X-Received: by 2002:a5d:5906:: with SMTP id v6mr3335177wrd.137.1615972289312;
        Wed, 17 Mar 2021 02:11:29 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Leonard N. Zubkoff" <lnz@dandelion.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/8] scsi: BusLogic: Supply __printf(x, y) formatting for blogic_msg()
Date:   Wed, 17 Mar 2021 09:11:18 +0000
Message-Id: <20210317091125.2910058-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/scsi/BusLogic.c:51:
 drivers/scsi/BusLogic.c: In function ‘blogic_msg’:
 drivers/scsi/BusLogic.c:3591:2: warning: function ‘blogic_msg’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Cc: Khalid Aziz <khalid@gonehiking.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/BusLogic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index ccb061ab0a0ad..0ac3f713fc212 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3578,7 +3578,7 @@ Target	Requested Completed  Requested Completed  Requested Completed\n\
 /*
   blogic_msg prints Driver Messages.
 */
-
+__printf(2, 4)
 static void blogic_msg(enum blogic_msglevel msglevel, char *fmt,
 			struct blogic_adapter *adapter, ...)
 {
-- 
2.27.0

