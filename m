Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81743E042
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJ1LzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:55:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37848 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:55:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19SBqmBx082029;
        Thu, 28 Oct 2021 06:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635421968;
        bh=IIk2BYwoSFmaOoCl5dWf0j6fUMWqnlg4MOquPzsW8z8=;
        h=From:To:CC:Subject:Date;
        b=AsTFaVx3zpeUnsC/TLIoGMxjxRe+1DizB+mXRYpiq+WfnESnyc13WbJi498MJe4ih
         kOzvVUwSrGEMYRLBnHvg8/mE2P+5G+MMCLARqZQdzl9pUFIOWrQmru4gwlUE7cTmle
         3+Exf7HX4TBO5226FNlN49iwaTnrdeQksue0Wx8c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19SBqmtH047661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Oct 2021 06:52:48 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Oct 2021 06:52:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Oct 2021 06:52:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19SBqlFq026755;
        Thu, 28 Oct 2021 06:52:47 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <thierry.reding@gmail.com>
CC:     <sam@ravnborg.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <nikhil.nd@ti.com>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH] drm/panel: simple: Initialize bpc in RK101II01D-CT panel descriptor
Date:   Thu, 28 Oct 2021 17:22:42 +0530
Message-ID: <20211028115242.28539-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize bpc while creating panel_desc structure for RK101II01D-CT

Below warning is triggered since bpc is not being initialized

WARNING: CPU: 2 PID: 47 at drivers/gpu/drm/panel/panel-simple.c:614
panel_simple_probe+0x1b0/0x3c8

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dde033066f3d..32f775db5cb7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3027,6 +3027,7 @@ static const struct drm_display_mode rocktech_rk101ii01d_ct_mode = {
 
 static const struct panel_desc rocktech_rk101ii01d_ct = {
 	.modes = &rocktech_rk101ii01d_ct_mode,
+	.bpc = 8,
 	.num_modes = 1,
 	.size = {
 		.width = 217,
-- 
2.17.1

