Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACBA3ECFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhHPHzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:55:07 -0400
Received: from mx21.baidu.com ([220.181.3.85]:45016 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234599AbhHPHyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:54:55 -0400
Received: from BC-Mail-Ex29.internal.baidu.com (unknown [172.31.51.23])
        by Forcepoint Email with ESMTPS id DA07F2016C24D9212EC2;
        Mon, 16 Aug 2021 15:54:12 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex29.internal.baidu.com (172.31.51.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 16 Aug 2021 15:54:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 16 Aug 2021 15:54:12 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <dan.carpenter@oracle.com>, <greg@kroah.com>,
        <yangyingliang@huawei.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] staging: r8188eu: Remove the dependency on ipx.h
Date:   Mon, 16 Aug 2021 15:54:06 +0800
Message-ID: <20210816075406.938-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex22.internal.baidu.com (172.31.51.16) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit <47595e32869f> ("<MAINTAINERS: Mark some staging directories>")
indicated the ipx network layer as obsolete in Jan 2018,
updated in the MAINTAINERS file

now, after being exposed for 3 years to refactoring,
so to remove the dependency on ipx.h

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 24 ++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 63a4cabdd3a8..173679709e70 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -5,7 +5,6 @@
 
 #include "../include/linux/if_arp.h"
 #include "../include/net/ip.h"
-#include "../include/net/ipx.h"
 #include "../include/linux/atalk.h"
 #include "../include/linux/udp.h"
 #include "../include/linux/if_pppox.h"
@@ -37,6 +36,29 @@
 #define MAGIC_CODE_LEN	2
 #define WAIT_TIME_PPPOE	5	/*  waiting time for pppoe server in sec */
 
+#define IPX_NODE_LEN	6
+struct ipx_address {
+	__be32  net;
+	__u8    node[IPX_NODE_LEN];
+	__be16  sock;
+};
+
+struct ipxhdr {
+	__be16			ipx_checksum __packed;
+#define IPX_NO_CHECKSUM	cpu_to_be16(0xFFFF)
+	__be16			ipx_pktsize __packed;
+	__u8			ipx_tctrl;
+	__u8			ipx_type;
+#define IPX_TYPE_UNKNOWN	0x00
+#define IPX_TYPE_RIP		0x01	/* may also be 0 */
+#define IPX_TYPE_SAP		0x04	/* may also be 0 */
+#define IPX_TYPE_SPX		0x05	/* SPX protocol */
+#define IPX_TYPE_NCP		0x11	/* $lots for docs on this (SPIT) */
+#define IPX_TYPE_PPROP		0x14	/* complicated flood fill brdcast */
+	struct ipx_address	ipx_dest __packed;
+	struct ipx_address	ipx_source __packed;
+};
+
 /*-----------------------------------------------------------------
   How database records network address:
 	   0    1    2    3    4    5    6    7    8    9   10
-- 
2.25.1

