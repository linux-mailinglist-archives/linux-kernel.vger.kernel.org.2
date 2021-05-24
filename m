Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3090038E6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhEXMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhEXMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:39:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:37:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e17so10136047pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4dVLGHWu3In2mmlnxf97heOuU6nZM6itV2qQ+TUyo4=;
        b=vwef9bUvnLU0oebljZhynCRmnyNDr1NElN7oXxz43eVPEzP5Ssyd21VDykwUpQ6641
         PJ93QVLFVfCkAVCvhs+a337kkIOxE4wT2jXgDUtkxjcnKRCUe4LaIijW6cJrEXcXlMtU
         ozkseNUylXYrVRXlk0nw+yv2j6NCUWL5mVXZ1+3l7nwGBvf04hNSZMDLUAy1YwhLnjwr
         dZDUNRdl7zt2mYVyKEQa/ygEX0RwGauo/sxCAz4VaxqcX0cWeMjExvo5PwPPG2g2i9FG
         hvgj4tGG3XFoNCl050KcFmjEPtpkke5kslUM6UCag3Mb0od1NhROrH8iLTwdk5zwJauw
         UEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4dVLGHWu3In2mmlnxf97heOuU6nZM6itV2qQ+TUyo4=;
        b=rqyJi0pYCmCNyhY+Qsm/uUiXrVXif98AkpeG9lGKGweUs8bkInW59dMkQiHwHRazw7
         HaT/RxOYQxwczsXuiaFEq+hXvxRRmNdDgdmSukNT0dwapsTavrh0umnD/2uSgPKEA0LR
         OzNNbMcG88nAryMeq6Zm3aXa+U/Wl2W4H6QKl8+nybstd4mQ5lSKknbk+t5p+vJSvxSm
         5EQbJtf2/bk+TTAZn4KwqB3HF9y3OEo8G8t/5TP6bnuvGMNc2uRkp7GOV+YikFLQ9zlm
         7tCpCPAQtXDnPSbe2YsBAeQ+hL+E8aEREdAQ0Rlk3VFSE6fk2FJ9/ybyHL2VxNdWol9g
         fuQQ==
X-Gm-Message-State: AOAM5324BpW2alMLeK90vYgDt/YcSv/pP9JilXmRLDNT1mhuPD8pTYQ8
        oFeMeJUc3bNcaCvlrtuLqKLseYRObkCJHB0R
X-Google-Smtp-Source: ABdhPJxmH1MIMprnrunYaUYr0IaXdQOMax4tzuj/gM/XO4si6GFEOFVkKSvZwn/TB4Q53y39IBK19w==
X-Received: by 2002:a63:79c5:: with SMTP id u188mr13347009pgc.198.1621859872034;
        Mon, 24 May 2021 05:37:52 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 35sm11215006pgq.91.2021.05.24.05.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:37:51 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt4831: Add missing .owner field in regulator_desc
Date:   Mon, 24 May 2021 20:37:35 +0800
Message-Id: <20210524123735.2363676-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rt4831-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
index e3aaac90d238..676b0419e48f 100644
--- a/drivers/regulator/rt4831-regulator.c
+++ b/drivers/regulator/rt4831-regulator.c
@@ -108,6 +108,7 @@ static const struct regulator_desc rt4831_regulator_descs[] = {
 		.bypass_reg = RT4831_REG_DSVEN,
 		.bypass_val_on = DSV_MODE_BYPASS,
 		.bypass_val_off = DSV_MODE_NORMAL,
+		.owner = THIS_MODULE,
 	},
 	{
 		.name = "DSVP",
@@ -125,6 +126,7 @@ static const struct regulator_desc rt4831_regulator_descs[] = {
 		.enable_mask = RT4831_POSEN_MASK,
 		.active_discharge_reg = RT4831_REG_DSVEN,
 		.active_discharge_mask = RT4831_POSADEN_MASK,
+		.owner = THIS_MODULE,
 	},
 	{
 		.name = "DSVN",
@@ -142,6 +144,7 @@ static const struct regulator_desc rt4831_regulator_descs[] = {
 		.enable_mask = RT4831_NEGEN_MASK,
 		.active_discharge_reg = RT4831_REG_DSVEN,
 		.active_discharge_mask = RT4831_NEGADEN_MASK,
+		.owner = THIS_MODULE,
 	}
 };
 
-- 
2.25.1

