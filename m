Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0013A0811
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhFHX6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFHX6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:58:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5267C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 16:56:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q5so23394489wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrK/aPrNzIFJiEaYMtY8iTDy66rvrONlTw4MuPTSoTA=;
        b=esjQjQ76R9dklmDiKkWkttOIpiS6EJVNa/jHJDbss1qkPfuiYZ0qEw4bjsTCiE7h3B
         UTHoUw6m01JrzmvlV3V1jUzQFjC/Eqtom/dAqAV9O26BfPA9IiAKM9it31MxxdI/WOiv
         GQyzlxyHp28QcCfEVMb969nvRqDb7GS93fvXp/YDrNDtXh9o5Za6LHJy3ACplWF7dBIJ
         SnZoTkFaTOEORDqvwd0pjoswQA1uPYipCoRgjzOA7MT+d7teyWQqc71vcCpsNLf962m4
         +FTW4tUZWjnXwHkIThuS0YmSErcl7E5Uzus4n0bc412OXmR26koTAt0FHHsHGnjWBDnY
         thYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrK/aPrNzIFJiEaYMtY8iTDy66rvrONlTw4MuPTSoTA=;
        b=Nddk3N3xvZN7oriJFXfBw1IJjtEHLLwqfad3BLPsPgEONwgrOLcvPbYtyKUbkvCIfq
         ilnZUELazI3lpR1H3B847/q3PWt1SKDqv9PRDHjNA9TEwYCV2SbmpNzRTveguiHfTyYH
         MS9Q00RzC/XsUZ/sYz4stNiXRNejdguDsN/iCEo7UKU5wRa//lFBf3FFNDck0HU7iMu7
         jw+oKH7gZlux8IZp6nSBS22wbrZk8iHpFe2OhyCmiZIIVbPfhp00B4j0lJ5HtmaglDJj
         yVGdlKnVatLhTh+T5/GJv4EE3qCN2bpwvzcI6sR7cWFI+UxlLFyAuII/X8uSknqXgzr2
         ygPg==
X-Gm-Message-State: AOAM532RVJdrL2UngZqRO1HY3pz/ZH0DGBWRyvI5bOr4EdIVcbdA8042
        /qrAK5YhCVBAuP1swoHOrN3Ufg==
X-Google-Smtp-Source: ABdhPJy1zD6K/6MbeOOBR6pqA31/kEQRBXrBFHBNVRnV+5WMfN4OU7j5brEPpNfyXp/dxq7VAeRVfw==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr11679736wri.261.1623196573624;
        Tue, 08 Jun 2021 16:56:13 -0700 (PDT)
Received: from localhost.localdomain (82-132-233-125.dab.02.net. [82.132.233.125])
        by smtp.gmail.com with ESMTPSA id d3sm20702254wrs.41.2021.06.08.16.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:56:13 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: replace two ODM_RT_TRACE calls in hal/phy.c
Date:   Wed,  9 Jun 2021 00:56:09 +0100
Message-Id: <20210608235609.6726-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Within rtl88eu_dm_txpower_track_adjust function, retrieve the struct
net_device pointer, and replace both calls to the ODM_RT_TRACE macro
with equivalent netdev_dbg calls, as well as modifying layout, wording
and spacing slightly. The purpose of this, and patches like it, is to
eventually remove the need for include/odm_debug.h, which is an overly
complex way of printing debug/tracing information about the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/phy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index a664bff370bb..a8caf618f588 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -301,11 +301,12 @@ void rtl88eu_dm_txpower_track_adjust(struct odm_dm_struct *dm_odm, u8 type,
 				     u8 *direction, u32 *out_write_val)
 {
 	u8 pwr_value = 0;
+	struct net_device *pnetdev = dm_odm->Adapter->pnetdev;
+
 	/*  Tx power tracking BB swing table. */
 	if (type == 0) { /* For OFDM adjust */
-		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			     ("BbSwingIdxOfdm = %d BbSwingFlagOfdm=%d\n",
-			     dm_odm->BbSwingIdxOfdm, dm_odm->BbSwingFlagOfdm));
+		netdev_dbg(pnetdev, "%s(): BbSwingIdxOfdm = %d BbSwingFlagOfdm = %d\n",
+			   __func__, dm_odm->BbSwingIdxOfdm, dm_odm->BbSwingFlagOfdm);
 
 		if (dm_odm->BbSwingIdxOfdm <= dm_odm->BbSwingIdxOfdmBase) {
 			*direction = 1;
@@ -318,9 +319,8 @@ void rtl88eu_dm_txpower_track_adjust(struct odm_dm_struct *dm_odm, u8 type,
 		}
 
 	} else if (type == 1) { /* For CCK adjust. */
-		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			     ("dm_odm->BbSwingIdxCck = %d dm_odm->BbSwingIdxCckBase = %d\n",
-			     dm_odm->BbSwingIdxCck, dm_odm->BbSwingIdxCckBase));
+		netdev_dbg(pnetdev, "%s(): BbSwingIdxCck = %d BbSwingIdxCckBase = %d\n",
+			   __func__, dm_odm->BbSwingIdxCck, dm_odm->BbSwingIdxCckBase);
 
 		if (dm_odm->BbSwingIdxCck <= dm_odm->BbSwingIdxCckBase) {
 			*direction = 1;
-- 
2.30.2

