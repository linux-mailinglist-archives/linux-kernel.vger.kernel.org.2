Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3757366BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhDUNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240880AbhDUNF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 450A9614A7;
        Wed, 21 Apr 2021 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010323;
        bh=N6L4un44SRtl6mVFQS/awvX20+NhfvEx630PeXwuqIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMrXo6/rTDsyyz1ksL7wBZdkSq+GOSLx6jBWeBkdpqC6roJei4sORvbSmN1cYz5q0
         Q+bohUA1iQ2LOjxcT81rSa4RxD4C0DsviA104GbJCKj9vH2SWdIgkEeBVr80zrLtkI
         LErssIU40ab7m4bLuzo8GUurDMHlMK6x36Q32uQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 094/190] Revert "iio: adc: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:29 +0200
Message-Id: <20210421130105.1226686-95-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 13814627c9658cf8382dd052bc251ee415670a55.

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
 drivers/iio/adc/mxs-lradc-adc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 30e29f44ebd2..7f327ae95739 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -456,8 +456,6 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 
 	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
 				      iio->id);
-	if (!trig)
-		return -ENOMEM;
 
 	trig->dev.parent = adc->dev;
 	iio_trigger_set_drvdata(trig, iio);
-- 
2.31.1

