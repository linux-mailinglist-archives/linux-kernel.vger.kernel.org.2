Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EF416627
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbhIWTs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242861AbhIWTs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC4D60F6F;
        Thu, 23 Sep 2021 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426415;
        bh=e2cGy5v9Wc5YPLr3GFpQPYFYrEHY3Ve7dQMsppfcNYc=;
        h=From:To:Cc:Subject:Date:From;
        b=fhr+Uih0+yxcvSfI/HJzO7A6prr76D7TuVjf9n/pje1qLxTXnXaiBzj30IKdtKMbA
         ygf0+o5esXUyNoqj5CPvGlxmeY3r1zW3umHyFkR22FyKpWo1+0+0OmjK8Ol/a9n4qY
         mWhRmYLSmrenLHyyoXPcqUX1SKn/96ZCiNPpvL4rbB+nYnMZYIfI//YhZp//v3W2K5
         zbexF+0YBVdq2emhbvC/kRLB/wsBwnaQC7S5/pb7mZmFKhrdqK/a7BgD+Km+L0xjUs
         2Vixh+Sb9hW3+3RStS6BiRFQrEyXGufe7mIt6laqcGwVQIJEDWiAaXwIGkojaZwGk3
         pKfeR5lh3YtcQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] misc: gehc: Add SPI ID table
Date:   Thu, 23 Sep 2021 20:46:09 +0100
Message-Id: <20210923194609.52647-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; h=from:subject; bh=e2cGy5v9Wc5YPLr3GFpQPYFYrEHY3Ve7dQMsppfcNYc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTNlT7CvtMog4tZf2t21YNIpdnoQ9IoOveeKZIoLl aJ6CfaKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzZUwAKCRAk1otyXVSH0PuxB/ 9RgEKK3qitLjci35fpOO6RwtE4C4Y5K/mbqHAWekDKmwm+DHQxLy0u4sB6t8FYs/l9Lp6yygB8Rv6N zjo3Q7U4n8AKFVvPrbHBiaXivExySgOM9gBe1VB7PTTJpOjV8T4674ZhZ2Jzvg0Uzp1Ied018Do4Tb EGb/QBpEN8BXURg/6Jpd6RX8dLiEl/+qE9F7LBTK9Pob0ohmA0ikphVEjsG3liO5v2h0eEbPyVvWKX K6iTJXCll2lRWmmtCRWFj20eG6/0d3zWfASVEyNKJYJAxXBqcrtXc9Ej0aDOLHaoGh8GNjGzR+K84C SY6+d+E+ghJNFrQufyGfLB8TnircVk
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding a SPI ID table entry
for the device name part of the compatible - currently only the full
compatible is listed which isn't very idiomatic and won't match the
modalias that is generated.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/misc/gehc-achc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
index 02f33bc60c56..4c9c5394da6f 100644
--- a/drivers/misc/gehc-achc.c
+++ b/drivers/misc/gehc-achc.c
@@ -539,6 +539,7 @@ static int gehc_achc_probe(struct spi_device *spi)
 
 static const struct spi_device_id gehc_achc_id[] = {
 	{ "ge,achc", 0 },
+	{ "achc", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, gehc_achc_id);
-- 
2.20.1

