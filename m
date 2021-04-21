Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4B366B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhDUNDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240296AbhDUNDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1367E6142F;
        Wed, 21 Apr 2021 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010156;
        bh=u68x7azCAbb/Rtd+3COaHr4WH7/KClgmgKz5Cdlph7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsgikjCDeCfjTE4Czw7qXxAHstPVh+MdhIwWgwu45UyYz/VSR0h0C59VxmVaEjTy1
         2WyyQF8toV6V5FMMmcyeSrbRfH+4Y1Nkxfefg0mJJ3zQy3FW6BmLjYRwioFr8hQG8D
         tfwK+doV/nwAbLXADo9n8ySjRyI47htB3fvMFaJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 008/190] Revert "media: stm32-dcmi: Fix a reference count leak"
Date:   Wed, 21 Apr 2021 14:58:03 +0200
Message-Id: <20210421130105.1226686-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 88f50a05f907d96a27a9ce3cc9e8cbb91a6f0f22.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index d9b4ad0abf0c..37a10885d79b 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -727,7 +727,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret < 0) {
 		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync (%d)\n",
 			__func__, ret);
-		goto err_pm_put;
+		goto err_release_buffers;
 	}
 
 	ret = media_pipeline_start(&dcmi->vdev->entity, &dcmi->pipeline);
@@ -848,6 +848,8 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 err_pm_put:
 	pm_runtime_put(dcmi->dev);
+
+err_release_buffers:
 	spin_lock_irq(&dcmi->irqlock);
 	/*
 	 * Return all buffers to vb2 in QUEUED state.
-- 
2.31.1

