Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449143A836D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFOO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:58:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62259 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFOO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623768948; x=1655304948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCSBWCd9y3u28sVrm1BLjrVo0HqwCjNjR5EU+qadJNU=;
  b=foLGwVEc41rF9NgTJ2LHhX+DpcCFJlTczpM07CFAWiXOWI3GwTvOhnF9
   ujmW9KQuQzt06++lHJdN2m5Ufd8GkaK444uOzoKdaJTvJkOf/5bQu66fR
   bDgJNCNLajtOmnqaJymYJDx9jnLzdpQntqXYImDM5zgFpe53wrtwVBXSG
   gmYISzIdApkEpUDJQU2QM3jq2DJ6EuVaVb+qcArvJsS6hjjOBk6L0YE3x
   f+Mp6IVABWBIMlLszkk5qHOWpj6goPGUalwK1VHXmj0BBs1FndwgCnKkc
   YH0NDgU9ipDXqjJZH7TW/t+W6z+mpymlvRWdad2NkPofJ6LP2zbnXDPKu
   A==;
IronPort-SDR: 65oorxr89VZjt8V0drlw2m3ZixDuXyuGfvsh7l0FUR9yBW+EB9jcpf0xqGu+r2r8cirovv05LD
 /XG1YCOSz1guuA0dwVNK46tWPBWCfsVNzGIDno+fbRcEkE2L9Y47Ktnp6uMOp/Kyoh/tHw1yD0
 j3gwS2wMDcRxp0a3CQxJrpI305VhMjVNy2XO2XZeVjTDtVC86OkEoE0YmKxeMiMA1Rt4BuaUOx
 SEIgQP7UdkcerdEn8nh5EVRYg78vT9qIayIaon9VXBufoJN+iDnF54NOt4jvUkdvtI396v1G1S
 rTo=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="171974932"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 22:55:37 +0800
IronPort-SDR: mPlODiiUgELKVP7a7FAJ0sJLrejQTjq1N9Ek9E8vvcR6puWkV7n2uqpIguN02BiVJVRP+jh0pW
 Zkp4RO60tyNYfdF+9whg6dqtQIsQGkFcqolu39qs+RCR+dYwjCC7ddlcL2mPu7kV3k05lVqZuo
 j9NMCkhNVV1j5wbXZrGR37paWFF5y89CfIXv5Wiz+JVeQP6568Jy9j82cKRrzCVPiHAT1GN9Gt
 XF5bAehPXvZw8sP6WunoxXit4rj2TWarRLVCBAtnlcvjdmIhQFhx8AIPdFh5kZyxJhLd5whj3v
 GZwNSG99TUt6WQdwS1tJxBbP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:33:08 -0700
IronPort-SDR: ouP7EHUD5it43OozKwz8H4QlWmHCeQ9Lb4jurBBoUzJ5PTn6/4ZftFPScRj9nX9aDJ5zEhoZ+t
 tD5314L5AibnFqgYChmk/E3rURLjSFg+jpa/CCxBgdAtWY16oSBldjqmoCTruYq9UGo8JMJQSn
 /wMG96mt/+PdlsJLbZhKaM1TBGb2LMf9zeex6oGVRj8jADmYv23gGScsGft2k4s9eGADHEr3vA
 ij2LCANqwoQWGLpwVa4r83GcYl2urgSkGLSKg8M8h+1AtvJmfFL0c5rduWmx10eP4l9f2BQCJ2
 thQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2021 07:55:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Huilong Deng <denghuilong@cdjrlc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 3/3] mcb: Remove trailing semicolon in macros
Date:   Tue, 15 Jun 2021 23:55:30 +0900
Message-Id: <fe520620eeddaa2ed8c669125f9b673c89d6b5a5.1623768541.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623768541.git.johannes.thumshirn@wdc.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huilong Deng <denghuilong@cdjrlc.com>

Macros should not use a trailing semicolon.

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 include/linux/mcb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index 71dd10a3d928..f6efb16f9d1b 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -120,7 +120,7 @@ extern int __must_check __mcb_register_driver(struct mcb_driver *drv,
 	__mcb_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 extern void mcb_unregister_driver(struct mcb_driver *driver);
 #define module_mcb_driver(__mcb_driver)		\
-	module_driver(__mcb_driver, mcb_register_driver, mcb_unregister_driver);
+	module_driver(__mcb_driver, mcb_register_driver, mcb_unregister_driver)
 extern void mcb_bus_add_devices(const struct mcb_bus *bus);
 extern int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev);
 extern struct mcb_bus *mcb_alloc_bus(struct device *carrier);
-- 
2.31.1

