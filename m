Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3345B6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhKXIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:50:01 -0500
Received: from mx24.baidu.com ([111.206.215.185]:34130 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233104AbhKXItv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:49:51 -0500
Received: from BC-Mail-HQEx02.internal.baidu.com (unknown [172.31.51.58])
        by Forcepoint Email with ESMTPS id 729E2E0CD168CBB24FE2;
        Wed, 24 Nov 2021 16:46:40 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEx02.internal.baidu.com (172.31.51.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 24 Nov 2021 16:46:40 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 24 Nov 2021 16:46:39 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v2 3/3] MAINTAINERS: Add the driver info of the ZHOUYI AI accelerator
Date:   Wed, 24 Nov 2021 16:46:17 +0800
Message-ID: <20211124084620.628-4-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211124084620.628-1-caihuoqing@baidu.com>
References: <20211124084620.628-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex25.internal.baidu.com (172.31.51.19) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
such as Allwinner R329 SOC.
Add the driver info of ZHOUYI NPU to MAINTAINERS file.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f32c7d733255..5d231aadaa3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18163,6 +18163,12 @@ M:	Forest Bond <forest@alittletooquiet.net>
 S:	Odd Fixes
 F:	drivers/staging/vt665?/
 
+STAGING - ARM ZHOUYI NPU SUPPORT
+M:	Cai Huoqing <caihuoqing@baidu.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/staging/zynpu/
+
 STAGING SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	linux-staging@lists.linux.dev
-- 
2.25.1

