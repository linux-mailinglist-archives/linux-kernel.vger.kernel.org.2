Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67873CDA28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbhGSOeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 10:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242934AbhGSO1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5EBA611C1;
        Mon, 19 Jul 2021 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626707273;
        bh=eyhrDi3gUAam2qacXv6Di8YUNYqq+9qs1tRhUQL/saw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWkURaRtYnSyhclvdITUKzUJ3lP3z8Nf1que5+u+iuE3dY0HM685mDbiAMaWSbHU7
         GUW6Id0G3jMtXhdGr9ZCUVARSqB/nyk9jKJz3nTbBc3M7IaYORZo+CST/O03fJkzg6
         De05oAFO03dNAvRY4dI3qd66SkjX5tXV/WTkuuQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 093/245] iio: adis_buffer: do not return ints in irq handlers
Date:   Mon, 19 Jul 2021 16:50:35 +0200
Message-Id: <20210719144943.421952875@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144940.288257948@linuxfoundation.org>
References: <20210719144940.288257948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit d877539ad8e8fdde9af69887055fec6402be1a13 ]

On an IRQ handler we should not return normal error codes as 'irqreturn_t'
is expected.

Not necessarily stable material as the old check cannot fail, so it's a bug
we can not hit.

Fixes: ccd2b52f4ac69 ("staging:iio: Add common ADIS library")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20210422101911.135630-2-nuno.sa@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/adis_buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 9de553e8c214..625f54d9e382 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -83,9 +83,6 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	if (!adis->buffer)
-		return -ENOMEM;
-
 	if (adis->data->has_paging) {
 		mutex_lock(&adis->txrx_lock);
 		if (adis->current_page != 0) {
-- 
2.30.2



