Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C3366B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhDUNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240295AbhDUNDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 687E061466;
        Wed, 21 Apr 2021 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010161;
        bh=w5cntnSQSLZYATigOln5iqK+yz1jM039eB5lvhRRzGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBE6yPwmxenq4IRTOdhKQGuvu/ztAaKMJknDyQKccNkOA9+xeGE909n5+Tulnm2e8
         NXt+x/4u470c7DXbz5YkOPJhy2Q/isUXS+E6fs+pykNqnQokGVtBZL9peu+i2RA8QC
         saRdrDkj+1tucXSEFxIbLc5CcgBTiX8cbqUx10sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 010/190] Revert "media: camss: Fix a reference count leak."
Date:   Wed, 21 Apr 2021 14:58:05 +0200
Message-Id: <20210421130105.1226686-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d0675b67b42eb4f1a840d1513b5b00f78312f833.

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
 drivers/media/platform/qcom/camss/camss-csiphy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 509c9a59c09c..a5d717d022a5 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -174,10 +174,8 @@ static int csiphy_set_power(struct v4l2_subdev *sd, int on)
 		int ret;
 
 		ret = pm_runtime_get_sync(dev);
-		if (ret < 0) {
-			pm_runtime_put_sync(dev);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = csiphy_set_clock_rates(csiphy);
 		if (ret < 0) {
-- 
2.31.1

