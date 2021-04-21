Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A77366C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbhDUNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241617AbhDUNJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 658F86148E;
        Wed, 21 Apr 2021 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010514;
        bh=NL/FvtLF2xja/XQx0lXWzcV2m/s8o4G1C3XYDMvHdkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fc1L71pQPurC+vc2ASVRU8Fka8a1td9UvEUyJcdlH2PIXVDu6Bhpq1DyBmLbNZcve
         miHnb94JXgqJ+sHzvpKtJi3ubDn9zDcxCHWt5ZkQXlMpSOhkc8F19HULovaqoSBtCe
         2sNz6ykrLxvSSwkbep9ZZTnvMT4Smk7J71ovj76g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 164/190] Revert "iio: ad9523: fix a missing check of return value"
Date:   Wed, 21 Apr 2021 15:00:39 +0200
Message-Id: <20210421130105.1226686-165-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ae0b3773721f08526c850e2d8dec85bdb870cd12.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/frequency/ad9523.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index bdb0bc3b12dd..91eb47e27db0 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -944,14 +944,11 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		}
 	}
 
-	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN) {
-		ret = ad9523_write(indio_dev,
+	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN)
+		ad9523_write(indio_dev,
 			     AD9523_CHANNEL_CLOCK_DIST(i),
 			     AD9523_CLK_DIST_DRIVER_MODE(TRISTATE) |
 			     AD9523_CLK_DIST_PWR_DOWN_EN);
-		if (ret < 0)
-			return ret;
-	}
 
 	ret = ad9523_write(indio_dev, AD9523_POWER_DOWN_CTRL, 0);
 	if (ret < 0)
-- 
2.31.1

