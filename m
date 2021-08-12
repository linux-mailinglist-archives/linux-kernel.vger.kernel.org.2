Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEE3E9B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhHLAZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhHLAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:25:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D06FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h9so7859378ejs.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmbSK95IAXEHKOt1kFCKjuXIU0Vg0AxKnCR0OMtOosc=;
        b=uQsRNUOtNpDlm5YjMZSJUpsgXBGHfU5ek4Lr9ER4BypV31RqEUsZjgIz6fCRMTmiCG
         UHyoD1QX+v4XukF3/PnBrWHYKaJlxggrkoI3vNPpP3sNob0zXQmVrssO3uvNnCLxyepe
         FuU3JS9vHK/zDhqCDAtWWIt5OrTU9MX483kuOOdQtgKR+4kA2w35FX/Jjl+3NFNfM7Og
         w891xqXLDyyLqsT1eDdLuO0Ebbfff6eTgjr1Cen2oBp4FGLg/gLfpK5doBkpiZTBrpWf
         jesESAM6fUUSxVuYRfrVcJHraL+CNuIKhsJe32uc3IQSl0r3O9FQmJZrALnupuzrfh60
         CFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmbSK95IAXEHKOt1kFCKjuXIU0Vg0AxKnCR0OMtOosc=;
        b=JbyUugtxApbDy3qCBUQ5K4nChlZxxgeAa9d2gqjL63TfezG+Kb+Qbj9gtcH49IHcwf
         xHFzPRLXBW1Y/djASVlymoY/tUCitu6qb/RJ7AoO00Hs3uM9wgj3zgIX5UEyifjwYiiH
         OdZK1SZg/vzQ1MxoCM1IGH0CrQe+cNGh7RZC6M0FQLLfwq/i2qdBhMd+sdgYTf96aWw/
         BcAVZnh3KypDI/QeS9eK6CdbY5p6XZv1I7R/Nep/WqtJthwUqxf1+fzidjAIDfBtdzHi
         DxoS8y3Fp2OoSxmLkT72FYL/mMiykbpiui2TrNXplHw/dZghnkaHgwsqwQcAtOLYNNsy
         wA1w==
X-Gm-Message-State: AOAM533UegXASiaFLB0H7dXi6Ku+mXKYWIZaYRwUzCwYuULAWwYrHbec
        CrVG3vqmXlagZFZILh9dr9U=
X-Google-Smtp-Source: ABdhPJw9mXgJSEtM9MlQP0B2I/hzUHPv9plSLllnMWJs+Vr07CXo/TZcW+asNngCgiLiRx80n2VLTQ==
X-Received: by 2002:a17:906:150c:: with SMTP id b12mr1075003ejd.275.1628727930172;
        Wed, 11 Aug 2021 17:25:30 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id l20sm265048ejb.23.2021.08.11.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 17:25:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: Remove code related to unsupported channels
Date:   Thu, 12 Aug 2021 02:25:18 +0200
Message-Id: <20210812002519.23678-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812002519.23678-1-fmdefrancesco@gmail.com>
References: <20210812002519.23678-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all code related to unsupported channel
bandwidths. rtl8188eu* NICs work only on 20 and
40 Mhz channels.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h    | 3 ---
 drivers/staging/r8188eu/include/rtw_rf.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index a1f8c7fe595c..4dadb22bcc89 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -567,9 +567,6 @@ enum odm_security {
 enum odm_bw {
 	ODM_BW20M		= 0,
 	ODM_BW40M		= 1,
-	ODM_BW80M		= 2,
-	ODM_BW160M		= 3,
-	ODM_BW10M		= 4,
 };
 
 /*  ODM_CMNINFO_BOARD_TYPE */
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index 0f790da7e0aa..48129da9c93f 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -97,9 +97,6 @@ enum rf90_radio_path {
 enum ht_channel_width {
 	HT_CHANNEL_WIDTH_20 = 0,
 	HT_CHANNEL_WIDTH_40 = 1,
-	HT_CHANNEL_WIDTH_80 = 2,
-	HT_CHANNEL_WIDTH_160 = 3,
-	HT_CHANNEL_WIDTH_10 = 4,
 };
 
 /*  */
-- 
2.32.0

