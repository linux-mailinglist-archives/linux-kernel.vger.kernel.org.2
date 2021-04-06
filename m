Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A06355BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhDFSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:55:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbhDFSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:55:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lTqqo-0000lW-EP; Tue, 06 Apr 2021 18:54:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Juerg Haefliger <juergh@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Mark M . Hoffman" <mhoffman@lightlink.com>,
        linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  hwmon: (dme1737): Add missing null check on return from platform_get_resource
Date:   Tue,  6 Apr 2021 19:54:58 +0100
Message-Id: <20210406185458.433826-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to platform_get_resource can potentially return a NULL pointer
on failure, so add this check and return -EINVAL if it fails.

Addresses-Coverity: ("Dereference null return")
Fixes: e95c237d78c0 ("hwmon: (dme1737) Add sch311x support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/dme1737.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index c1e4cfb40c3d..a2157872e126 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2633,6 +2633,8 @@ static int dme1737_isa_probe(struct platform_device *pdev)
 	int err;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res)
+		return -EINVAL;
 	if (!devm_request_region(dev, res->start, DME1737_EXTENT, "dme1737")) {
 		dev_err(dev, "Failed to request region 0x%04x-0x%04x.\n",
 			(unsigned short)res->start,
-- 
2.30.2

