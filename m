Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9534B790
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhC0OZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0OYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:24:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E0C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so8389209wra.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WT7bGwSghAjHu48FM8xKdMZBcfSGTZoPSSqssnK7fBk=;
        b=sXFlBcGZRQxYQA1xjCwLstPexDL8Uajz/3PxyyhoK09RkN2FHKkhqFoQC/5Qq8UGep
         HK6WrUKmD5hehZjwn9DESPP/3Xxl9E3qInOaI4YUnXg3HGPhGvwHT5+4ZSXBXl6fwe74
         khkLfp3G7Px3iGH1xkq1usMnNlp+Xx8769/lXTfasGTEjK+BNnzj4c2LJXH8LgPuf91c
         QCZosmF/vNpwObXNmegGFCnAB0CCDpOwv73My1jsQ5V4UXGl5sHWCQ0ljdR5zqz1CHaL
         dwlWG8xe0ll00h+AWZ9HO/zyGRTgoz9hoZhp7ibbdnbg4lTI7Uiw6VcIN0BkogiAMuox
         h8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WT7bGwSghAjHu48FM8xKdMZBcfSGTZoPSSqssnK7fBk=;
        b=p4ydRyf4wCeh3rytAGa+40rG+xpXhEB1zHAiOV7Pu62e8HQkHS95RqhcmLg7NW/rpI
         n7FeaMVGMcG2F5h2RnS0LOklkXUMJd2OQlUQmGFdeP4wbeUcM1Hs1Mbk0XD9RqyJnyS4
         bAMpg0WYFt/Tuk16qT9zUkoAmfkCHqXG75uWr4WnFD4Q6zerNRVzqaCOGPZ51b5iQkJu
         CWAiu781lF2eFr9yBXCoXxFyTskql2w1aH1HqmQFNPDMkFUjy697K1Ak1aZH7Tgei45W
         ykYcyQH6GYZOmPfuckD9QTFEF7RLbaY1jy0BjPcqX6G+SIlMsKX5fhfqmjZJMyz9Cwqy
         Sggw==
X-Gm-Message-State: AOAM530B+CpeFAWH0GPvDZUBMreC0N4G1IH367XEuDSqbCCxqLy8uUIm
        lxpeIJaitn76PdhxFprxMNM=
X-Google-Smtp-Source: ABdhPJzvpg4I+QUPi0fZP8l2kAhg+G1eI+xRRf2zOEacl4G9yq7TvXMTWkdcOk2XI9l173JPR8Psrw==
X-Received: by 2002:a5d:6106:: with SMTP id v6mr8209410wrt.268.1616855087878;
        Sat, 27 Mar 2021 07:24:47 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id y8sm16448208wmi.46.2021.03.27.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 04/20] staging: rtl8723bs: remove unused macros in include/hal_com_reg.h
Date:   Sat, 27 Mar 2021 15:24:03 +0100
Message-Id: <4a5f1016f46ded3fe9b96a85aff3a5a320e29ab9.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove declarations of unused macros in include/hal_com_reg.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index b555826760d0..2cd18eb57244 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -707,14 +707,6 @@ Default: 00b.
 
 
 /*  ALL CCK Rate */
-#define	RATE_ALL_CCK				RATR_1M | RATR_2M | RATR_55M | RATR_11M
-#define	RATE_ALL_OFDM_AG			RATR_6M | RATR_9M | RATR_12M | RATR_18M | RATR_24M |\
-						RATR_36M | RATR_48M | RATR_54M
-#define	RATE_ALL_OFDM_1SS			RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
-						RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7
-#define	RATE_ALL_OFDM_2SS			RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
-						RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15
-
 #define RATE_BITMAP_ALL			0xFFFFF
 
 /*  Only use CCK 1M rate for ACK */
-- 
2.20.1

