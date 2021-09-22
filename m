Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7617D41511D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhIVUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbhIVUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i23so10504488wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+dEWMM/zGaE6TM2CitTWll6Tvzxft0TYYb+WjePX1I=;
        b=c37srSmBpa/JZSZ5pPIA0nQ9FGWDlZ8OuG2sbSzK9sZxMjdpGXbOI6inO6LiYJj4kp
         sLI7zVE09Nry7nu0w+XcgjjYk34xYNEwkwsr19Tx6e0ofklLa0GVRmBOuXV3/b4iSzKa
         Wjr1pRz4WfrVVMcIrpGin5LtzAHCY8qK6eeAb7TOoocvZCv87bqqA9DkreBkc6PWxk/R
         s36TPltEjD+6iNeupzfMubvI/hBYytLPQV2+eDOz4cBXrdwxnsXCsc/wkc1hcuiRdYAS
         1hMnEkAZu1FbBweqBn5LisEXBEICvSZ0KR4KIDAyI5rzciCtJhGrfRTc0J8oLgTd5s6Q
         nwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+dEWMM/zGaE6TM2CitTWll6Tvzxft0TYYb+WjePX1I=;
        b=nN1CZq3RfS/Z7FPlF6H7ci+pwjsZ8vWxuXwpNp9PK9o1kAIk+Ceoi0ByF895auBQ51
         oaU5vb2n7zfHBJ9mMZ05nKsfnccf6N0YFZBOD3G7ComDZoNAHM6z/FZ+lv50tSrJ5w9N
         4nYpShk3/sWIz2cBSZMyePRqMnCJdAEWSvolRpolEgKhC9LxkDosWkOax9vg6LC5qG2X
         hf62p5h2j6PGNDbu3sLtkinBMiYuOpbteh6ffJTyql6255R8JJDArO8wLBhiv8Lu2CBM
         sPOgnHnQYQOo3o/mpamEjsm+YjMywpIGB7B7snQhfK3xvIoUDFKhPQVSXHw6Sd3HbC1a
         SQsA==
X-Gm-Message-State: AOAM530+tnG6c9ElDDUEA+zgKdghJMvvwH24usxWPnqNGnHNuCiTG79A
        ZqPRPCx9meb6vi5mfZpMLSzKZjw4tCuAMQ==
X-Google-Smtp-Source: ABdhPJwUct/TnzwO51pBxFwC0u4c2ToywlDl3bHqW/jqFm3m3ALLHQMH+VA2EU6sIAdLKdiWhUnzlA==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr841214wmg.37.1632341160963;
        Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 41/47] staging: r8188eu: remove enum secondary_ch_offset
Date:   Wed, 22 Sep 2021 22:04:14 +0200
Message-Id: <20210922200420.9693-42-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum secondary_ch_offset is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index f0d5a640143f..b2b0d8ee903f 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1089,13 +1089,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len,
 		     unsigned char *source, unsigned int *frlen);
 u8 *rtw_set_ie(u8 *pbuf, int index, uint len, u8 *source, uint *frlen);
-
-enum secondary_ch_offset {
-	SCN = 0, /* no secondary channel */
-	SCA = 1, /* secondary channel above */
-	SCB = 3,  /* secondary channel below */
-};
-
 u8 *rtw_get_ie(u8 *pbuf, int index, int *len, int limit);
 
 void rtw_set_supported_rate(u8 *SupportedRates, uint mode);
-- 
2.33.0

