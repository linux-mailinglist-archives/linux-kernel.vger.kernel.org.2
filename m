Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D053B2FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhFXN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:29:49 -0400
Received: from m12-11.163.com ([220.181.12.11]:36113 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXN3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=J6Rv1
        vitNS/ydVeecRoabdFzPLloPhSPNL18OjlxdpE=; b=RAA0dZrWaZ6N/EwtaDsBq
        OONyW2w4/o3qMtph3mDhdHJumwGDDWdwnqeSY6cGsJ3zDr90B7PlvsMj/B3WFSNb
        mcAv2xup81YhQihC6jfnUGWyQFP7BszFn2mT/BUpgsxVU48znCNkzt18vUw/615n
        8B0qq6iElvg7EsZUmPK2sc=
Received: from jiangzhipeng.ccdomain.com (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowADXxIz+h9RgLhCijg--.21206S2;
        Thu, 24 Jun 2021 21:27:22 +0800 (CST)
From:   jzp0409 <jzp0409@163.com>
To:     minchan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "edison.jiang" <jiangzhipeng@yulong.com>
Subject: [PATCH] zram: correct zram Spelling mistakes
Date:   Thu, 24 Jun 2021 21:25:57 +0800
Message-Id: <20210624132558.1401-1-jzp0409@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADXxIz+h9RgLhCijg--.21206S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy8KFykXw45tw4rAr17GFg_yoWfXFbEvF
        4Ut3Wvv3yrZF13Zr4UCFs5CFyYqa1xKr15Gr95Xr45Z3y5Aa1xA3WDGrW5Zr17uFWv9rZx
        uF93Xry2krnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1NzV7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: hm2sikiqz6il2tof0z/xtbB9wq7hl2MZXeLZAAAss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "edison.jiang" <jiangzhipeng@yulong.com>

only correct spelling mistake

Signed-off-by: edison.jiang <jiangzhipeng@yulong.com>
---
 Documentation/ABI/testing/sysfs-block-zram | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 14b2bf2..61eab8e 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -62,7 +62,7 @@ Date:		August 2015
 Contact:	Minchan Kim <minchan@kernel.org>
 Description:
 		The compact file is write-only and trigger compaction for
-		allocator zrm uses. The allocator moves some objects so that
+		allocator zram uses. The allocator moves some objects so that
 		it could free fragment space.
 
 What:		/sys/block/zram<id>/io_stat
-- 
1.9.1

