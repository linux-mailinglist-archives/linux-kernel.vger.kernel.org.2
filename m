Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69E3FB9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhH3QDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbhH3QDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:03:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC44C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:02:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q21so8806071plq.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hNk/SrVEmg7Gzq5MxNtJIEjH5tFYQ/WLaoYBWOwLSUQ=;
        b=r3TF70SGQCmi1RFWL7Q87qJS+315SjC061HqKVTQ/zRP825EgMFQzFKjVuOBTjgQl4
         wFe7OGI2Z9Gcsel7FzhRA7dIl6cutqUTKLG/d1Y6x5au16uCFGay/QaxzSdsiNUd6fla
         4WCPm1yXTeBjozce64gtHh1Fkcw7ewtoXNGagU0hl5LIe2pVEnAR7ReePHrDKCpBiXlw
         GJOsIRWyZidSNDJuOLEkFqp90C6QWLcYG6T13atodtyyZhE8bpI6ScewMPjm75zu5Z/O
         Q5YqgAA8CQXlh6PTuCFL+qbT68K5/kKLI2u6Bbg/07pVr9vof1ir8sXsKID//9eGavhU
         r9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hNk/SrVEmg7Gzq5MxNtJIEjH5tFYQ/WLaoYBWOwLSUQ=;
        b=ek3NRvF7mLgbOgUM7yl27DFF2P4Eb4PBQJSTqpUlv7eBefXDdjqjYKOVr6W9+BGido
         5zPti2w490Fw1euIpxrCGQJcQoTygk3kly0mBrDgHfBDDt86P0JwYBzLMxA4aHVsWUVD
         k8V5mEELhCL20Pyy8Tf423rgUaqSEYEciFPPwgq/80MoLE21KfJFSMaqkOfzIQ0/ZP63
         hYyuRYhHd4trLwR1gsTdFItqjp/sit/pkwMajBsedkXDetwRlYrxuUQojgrDxRyj6SxC
         yTzcWk3QpUpVe2BlmxPn6amSBc3yOPn8SaHses5y3PBFK4LvAr+v5owfKC09cTcqdKX+
         iQEA==
X-Gm-Message-State: AOAM532c2BjYq30J82XoJk83vfuvP/nr20ALCpBZK6MCmyk8LcZsJYBo
        gL3LH36S+AjLbaQTsUvWnIY0
X-Google-Smtp-Source: ABdhPJx4DxXGLG7em8lQRLdFAzcH7JiTibGi2elZTt3jtjjRILnfiRYLKK11DdVYUjWbHna22/ipwA==
X-Received: by 2002:a17:90a:1b07:: with SMTP id q7mr27310433pjq.100.1630339346870;
        Mon, 30 Aug 2021 09:02:26 -0700 (PDT)
Received: from localhost.localdomain ([175.157.63.238])
        by smtp.gmail.com with ESMTPSA id t186sm15451666pfb.53.2021.08.30.09.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:02:26 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     airlied@redhat.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] GPU:DRM: returning ENOMEM
Date:   Mon, 30 Aug 2021 21:32:07 +0530
Message-Id: <20210830160207.23936-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210828154027.8198-1-asha.16@itfac.mrt.ac.lk>
References: <20210828154027.8198-1-asha.16@itfac.mrt.ac.lk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check the return value and pass the proper error code.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/gpu/drm/udl/udl_connector.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
index cdc1c42e1669..857d2c97ef0e 100644
--- a/drivers/gpu/drm/udl/udl_connector.c
+++ b/drivers/gpu/drm/udl/udl_connector.c
@@ -23,7 +23,7 @@ static int udl_get_edid_block(void *data, u8 *buf, unsigned int block,
 
 	read_buff = kmalloc(2, GFP_KERNEL);
 	if (!read_buff)
-		return -1;
+		return -ENOMEM;
 
 	for (i = 0; i < len; i++) {
 		int bval = (i + block * EDID_LENGTH) << 8;
@@ -31,11 +31,16 @@ static int udl_get_edid_block(void *data, u8 *buf, unsigned int block,
 				      usb_rcvctrlpipe(udl->udev, 0),
 					  (0x02), (0x80 | (0x02 << 5)), bval,
 					  0xA1, read_buff, 2, HZ);
-		if (ret < 1) {
+		if (ret == 0) {
+			DRM_ERROR("Reading EDID block %d returned empty result\n", i);
+			kfree(read_buff);
+			return -EINVAL;
+		} else if (ret < 0) {
 			DRM_ERROR("Read EDID byte %d failed err %x\n", i, ret);
 			kfree(read_buff);
-			return -1;
+			return ret;
 		}
+
 		buf[i] = read_buff[1];
 	}
 
-- 
2.17.1

