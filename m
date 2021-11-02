Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD824427D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhKBHLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhKBHLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:11:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9611C061226
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BsH/mBpcqv7w6TuVFr3mzaete7qiq1JiF6BOIhgRhGI=; b=w6mmrMSlOrykAlAYkrTfpQcRlu
        kXgrAHmGMXqrfqr0Ta9NEVS702hid3ERidMUVIsrihOr46jnpuabzRGem5qjSzTsmIvsEfLDbT+rm
        gbNCb+JNCuWIUjBWFCyRhYXuFlRoj6IvwI01+bUsCzmG0fl3iEPSh8lIMxjqABPlR2A0eBPsAjfv5
        Mgnotlkt+imvBw4dU5SwVX0inmEKUC90p6cFpQ6mc+jVsSHrOLkEQ6fYxEijxQbG96NTodq3Q6Egy
        USFbc/WIA0HCOs5+lkZmIHwSlSezH7nhKhb9XLzC15q+7vUqX0rqtySNllfn8V6WVSfd9Mh0HjVH3
        sCxVon4Q==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnuO-000iRg-Dc; Tue, 02 Nov 2021 07:08:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/29] drm/i915/gvt: pass a struct intel_vgpu to the vfio read/write helpers
Date:   Tue,  2 Nov 2021 08:05:58 +0100
Message-Id: <20211102070601.155501-27-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the structure we actually care about instead of deriving it from
the mdev_device in the lower level code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 021cd8328db32..d3e0a3f5559db 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -989,10 +989,9 @@ static int intel_vgpu_aperture_rw(struct intel_vgpu *vgpu, u64 off,
 	return 0;
 }
 
-static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
+static ssize_t intel_vgpu_rw(struct intel_vgpu *vgpu, char *buf,
 			size_t count, loff_t *ppos, bool is_write)
 {
-	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
 	int ret = -EINVAL;
@@ -1038,9 +1037,8 @@ static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
 	return ret == 0 ? count : ret;
 }
 
-static bool gtt_entry(struct mdev_device *mdev, loff_t *ppos)
+static bool gtt_entry(struct intel_vgpu *vgpu, loff_t *ppos)
 {
-	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	struct intel_gvt *gvt = vgpu->gvt;
 	int offset;
@@ -1060,6 +1058,7 @@ static bool gtt_entry(struct mdev_device *mdev, loff_t *ppos)
 static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 			size_t count, loff_t *ppos)
 {
+	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int done = 0;
 	int ret;
 
@@ -1068,10 +1067,10 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 
 		/* Only support GGTT entry 8 bytes read */
 		if (count >= 8 && !(*ppos % 8) &&
-			gtt_entry(mdev, ppos)) {
+			gtt_entry(vgpu, ppos)) {
 			u64 val;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, false);
 			if (ret <= 0)
 				goto read_err;
@@ -1083,7 +1082,7 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 		} else if (count >= 4 && !(*ppos % 4)) {
 			u32 val;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, false);
 			if (ret <= 0)
 				goto read_err;
@@ -1095,7 +1094,7 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 		} else if (count >= 2 && !(*ppos % 2)) {
 			u16 val;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, false);
 			if (ret <= 0)
 				goto read_err;
@@ -1107,7 +1106,7 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 		} else {
 			u8 val;
 
-			ret = intel_vgpu_rw(mdev, &val, sizeof(val), ppos,
+			ret = intel_vgpu_rw(vgpu, &val, sizeof(val), ppos,
 					false);
 			if (ret <= 0)
 				goto read_err;
@@ -1134,6 +1133,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 				const char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int done = 0;
 	int ret;
 
@@ -1142,13 +1142,13 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 
 		/* Only support GGTT entry 8 bytes write */
 		if (count >= 8 && !(*ppos % 8) &&
-			gtt_entry(mdev, ppos)) {
+			gtt_entry(vgpu, ppos)) {
 			u64 val;
 
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, true);
 			if (ret <= 0)
 				goto write_err;
@@ -1160,7 +1160,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, true);
 			if (ret <= 0)
 				goto write_err;
@@ -1172,7 +1172,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val,
+			ret = intel_vgpu_rw(vgpu, (char *)&val,
 					sizeof(val), ppos, true);
 			if (ret <= 0)
 				goto write_err;
@@ -1184,7 +1184,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, &val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, &val, sizeof(val),
 					ppos, true);
 			if (ret <= 0)
 				goto write_err;
-- 
2.30.2

