Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7D3C54C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354391AbhGLIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345320AbhGLHZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:25:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60EA613C7;
        Mon, 12 Jul 2021 07:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626074541;
        bh=p8MZCwApEeJkSMpx58w+IZ/YfyUklulrNMrzGhhLz0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNvHs52GXSvTjUQ2Ows2F9mBcGclvE7AuR1yEySq944+drikRGI36bz8qZF1GfRZs
         nNdSDGG8VOffI/bLNidw61MfR52HjocCNlRU1MD9YyvCvOdZXKStUhwRGXCv/gsm3y
         SdBpNL3DV6KtTRJ4JdtqNxl2R8FSgIOZelT3YDXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 613/700] iio: adc: at91-sama5d2: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Mon, 12 Jul 2021 08:11:36 +0200
Message-Id: <20210712061041.131606093@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060924.797321836@linuxfoundation.org>
References: <20210712060924.797321836@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 8f884758966259fa8c50c137ac6d4ce9bb7859db ]

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of this function.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20210613152301.571002-2-jic23@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a7826f097b95..d356b515df09 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -403,7 +403,8 @@ struct at91_adc_state {
 	struct at91_adc_dma		dma_st;
 	struct at91_adc_touch		touch_st;
 	struct iio_dev			*indio_dev;
-	u16				buffer[AT91_BUFFER_MAX_HWORDS];
+	/* Ensure naturally aligned timestamp */
+	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.
-- 
2.30.2



