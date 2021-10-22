Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9C436FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhJVCDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhJVCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:03:07 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7BC061224;
        Thu, 21 Oct 2021 19:00:48 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 86736B5D;
        Thu, 21 Oct 2021 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1634868048;
        bh=ywEBrdGbkyi0QJnFE8aQ/OJz+ZBKYfFbMIxjCGa0a6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2/S3A/W/JaKiShxEXetHUItCy/+sBkAcB5xLHm4tyjmabYHNOz9U8/A5M1LzWwIW
         ricK/uahG5gtjO5pOnXZZBD/XUJZsN3ZWiha2w8Ozz4XTx3UKbCziVpsgZPmxyR4yP
         I2mIzeFcQlU0iAilWPibes2OI83hj6YYmIpsRQxY=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH 5/5] of: platform: instantiate reserved devices
Date:   Thu, 21 Oct 2021 19:00:32 -0700
Message-Id: <20211022020032.26980-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022020032.26980-1-zev@bewilderbeest.net>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with a "reserved" status will now be passed through to
of_device_add() along with "okay" ones so that the driver core is
aware of their existence and drivers can be explicitly bound to them
when appropriate.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 74afbb7a4f5e..060e1e9058c2 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -170,7 +170,7 @@ static struct platform_device *of_platform_device_create_pdata(
 {
 	struct platform_device *dev;
 
-	if (!of_device_is_available(np) ||
+	if ((!of_device_is_available(np) && !of_device_is_reserved(np)) ||
 	    of_node_test_and_set_flag(np, OF_POPULATED))
 		return NULL;
 
-- 
2.33.1

