Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2C39540D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 04:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEaCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 22:54:27 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:54529
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhEaCyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 22:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjS1bvSaDM96/g9vuwaJ+bD2GK0Lis8zOESMaAjTTu2BMXgP221kM/xrJLkgyIJsFP7ZIf7jnDQmVKa7J2M+m5sdIocpG8lGhbsSCGuINc0h4lr8zlc/PxPgTVYfuyFZb7AuOAqp12QlXMN7om8UqBU7ISI4BwtM4sjwj4FM5tIl561FBLBkbf2S3KQvESi5zPmN56b/cU7RGzZbgbag0AZuqyD0pevjymNjRPuOc0k83eG/nKAeQCVMYL4wFwLoSho3fWP2izF7rKEg9VNCVOsXi2ilULUo7NqUDs9aH/Hgj+b+LtCSkPY5huFZjrLdpFO8BTHpjXYL8W8Xjm5irQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1QS2N6OxeQSgTPmRauMB9hyftsk01KidLQXSM9gaMY=;
 b=hsN3dLERLcNWSP97CdpA7VtBEA5TXLhtmD+vTYf9a5ENVLnP5BSL1gvMc7KvPtWUNT575lDBKZL+T2b7PyfY0p9vZHrAba9N42FtFUXPGTgcpqc8eXLWAEs5jLLgtJACCcIuGbc71ZcWYrWC2xnW1bbqJ5aQhWGrR65zuemM8Mfia9lTHcuTozkALii6/6LNlwiEoWiSSGmTKsxqEu6zXlNs5clrLRLTz+GA0Ex+9e70xnqtLPGqTPhwvDaDOYGcLENLjywOF0O3oWUluqvAV7sYaHzWiz74j6SXW/k8NipRJhV6ziqfH3dWx8ocSgxrN5wBpV1caXIkVq+Frbzaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1QS2N6OxeQSgTPmRauMB9hyftsk01KidLQXSM9gaMY=;
 b=Q7annSVTn4BIlyV4mEt847Xq6C8mVS88cTKqTBjhl2bTws70b83HBb2omGDTHeYr7hyLZqBypHd+wQvKwOEX2Wam0DO5uChnWK5Hxuhq/roIhc+Xq3VAhw5hSbmETo/wFmhitXbVaCFdUUoA/NgIfIkLo+zFUKs9joIIPZQUchE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR0401MB2546.eurprd04.prod.outlook.com (2603:10a6:203:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 02:52:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c5c1:3625:26e4:4276]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c5c1:3625:26e4:4276%5]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 02:52:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] media: imx: imx8q: add v4l2 m2m video codec driver
Date:   Mon, 31 May 2021 10:51:11 +0800
Message-Id: <f7f9295d20e489ab7585b12faa4a413403e0df2d.1622429026.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622429025.git.ming.qian@nxp.com>
References: <cover.1622429025.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.70]
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 02:52:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0082c20-9528-477a-7d77-08d923df1632
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2546899B17BFB6DB22903050E73F9@AM5PR0401MB2546.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:217;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JThpHh4XhomuP0nKzZY244sYgKRh5ebmQZsIb8v2dEqO/cAwWXfhKcaltRKw+ibhc/7p22jteMZ+iMOltoVHWu/EGp1hDCNOUHPUbv7ObjLMqSxGalGuAlJSlWGQ1kTE3i6vtZ7wGqWsh0kRkwp0qqmSqNUlle316Yiy0Ipe6tut4K2/dDAYNk71ijYe9mFPT8brU0Pa6+rY7IV56T7qxeNswQ0L48WxIrmCqQitOIVPLu5w5UrMaQFdNdLs5fnvd+Vrcr7hSyiHXUhQylDwpmcHAIZaJZfEyVXfrBfAVvun0b3T2fpaZsR9fuA9peEXBshKxPekAhnvJXVuILrOMXsj8W34hhPQGa85194rtpe6qNob2BvC8ZZzsJAhAX0iew90z+9+BOb+6kAbxO99VqVfxlv+EpFbxNJmjm+OfPEQl1Sgk0nwm+wiTDQjP6P3nrKc0LibzGRecoDNm7/Qrn9EG6+YaIsubSfUlRi0R5wvatRHoe7lU//it2T5wuswsa8MpFyvtjov5zgvPIUbNNVr0dMtwcv+Ec5N021eJmBB2QFXNfXn+ERUFAScqAZMxu8K80LHXe/8IPGArchnIyhYp17OnrlppJ5B7OOggnnh78rOXNhFOgbxJr9qmMkhgpyVSTM1D68jF5UHePbdiea4+3/W/bhe+ErzMxyW5/dcjVCRHFUpf/OAHI6KB2Xn35JkccqfJ+IuY/Bb/SEiMxFUfLyl+14Cr9I6pWVgAx9T0xwEFzHdWj/FrcPJo3ZgUCJEAFoVJM/5dS3sSVXkoU6am6g9Lh/N4QOCOWa4wHb9PUqrxCOBGzXY5R7bv9ZyRJbSKohPrXusahgiVTlXqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(5660300002)(4326008)(83380400001)(6666004)(966005)(36756003)(16526019)(66946007)(66476007)(66556008)(38350700002)(86362001)(38100700002)(44832011)(186003)(7696005)(2616005)(478600001)(30864003)(8676002)(6486002)(316002)(956004)(2906002)(26005)(7416002)(8936002)(52116002)(461764006)(32563001)(579004)(569008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?okZXQJCFpNq0opMrYg+6RH3FjPD2dgsPsXIvsX7izx8EKA1TJiazpk/MRWfb?=
 =?us-ascii?Q?pJ+YH/QBMibBLSXu4cJ6ryD3BHEazwMYn3tlNc114PwbmwKx5vywzR/3JxAH?=
 =?us-ascii?Q?eHDohlnjh9++3zKDXk1cUXTMx74b5mwJk42UphOWlgz/8nR2cWRZratSmSVM?=
 =?us-ascii?Q?yPytDdXOYwDeBug9kFbmd1jCH9OyyM+5j4x1zWjhiWouorZ72eA131Ka+Uy2?=
 =?us-ascii?Q?delB+ag9/p3rDExtgNSh90xTvEmg5p/asx89i4ef3kKPQdCYtuWBUbDUIUGz?=
 =?us-ascii?Q?iSDP6c8Xjr58AIdCOSHYCBh6Hhga7YA8XLO/+aK9OYthu3g9jl/Bqg3s/n7l?=
 =?us-ascii?Q?tFT703M0q6CeryfyLYA93StnPirWhgaikxj2701pzgOWGDci/zNIyu+lAa0D?=
 =?us-ascii?Q?/5TbLynhisaSm0EKYyWhju69JwC8ZxCHSbZu6RG5MHOVimZKMCHSz0DTc3eX?=
 =?us-ascii?Q?2me6KAnrZIMQq0Kz51nTnpqxmESyvKt08eREVN5y3abD5fsgpWh3M/CRAjOj?=
 =?us-ascii?Q?0zo0VnfOCfok90dsFrTdr885JcYiQ8VxmWCWckOsoZOPypiif94gBbf8eH9j?=
 =?us-ascii?Q?l3wK6XNCrhFQIIK1JDv6XdaKs6JgPeiYMrpA9hw+wfkCGxbAhTG77GA5G8AM?=
 =?us-ascii?Q?C8xJq8CnW/7BCDVgNjms+Zr/RH/irfys3RxZx79uwDY24reWsBqh43t7+yXx?=
 =?us-ascii?Q?TtQoOM63hg73d7F42jen6vFC2/VH97a7IiDi4o/6to5VhuDb67g593EmAaB8?=
 =?us-ascii?Q?iGtE8l1FF1RR7k2d7/aDZ9dt5QWq6ieedtjOSfl0udce9XhSaYAVnUQ+bjhT?=
 =?us-ascii?Q?5OK9U0MQyYvaJikJloJDCQAX8XilznmfM9gR19VMIBFQ8XaXDqSFvOpUINzR?=
 =?us-ascii?Q?WnbTm6SRbyxOTymhhzgxEYehW+BpCpysOyikuClCyPmi5+uDolx8u9uU2D5M?=
 =?us-ascii?Q?FTL6Ye2md3V5LouIHRq/h7Z3lb2R/4NqHQDRJW9E1pwuSD+LGj6CNmYykbbE?=
 =?us-ascii?Q?hhNzN95jMAt4WZm1DkASc+xueJgohV08/1oviZ2ReEXODLlXPImVjBAM06EY?=
 =?us-ascii?Q?9twE9V4JYwe6L55ASHKn6mQ4lURNhEeZvj03D21yWpRxtZU9Q7TX0iAOYW1Q?=
 =?us-ascii?Q?Ao6RvbK69QcDl70FnHj+nWzMVMfko0YRSU6VepUGHd14g+iTVt1kfxjNJ23N?=
 =?us-ascii?Q?FgLSd1TA0H+M0sf3kyVP0/372d2Jk1P50sZh5kGFfLoDGgI/UrA5ow+PUjpL?=
 =?us-ascii?Q?xUWccFaGAmtmTHdOEE9iILX9DKrpu7Ji0FwTaA9kINULyx3yIFAW0hireLet?=
 =?us-ascii?Q?k2GcpFaW2rQKls85HYx7wKQu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0082c20-9528-477a-7d77-08d923df1632
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 02:52:11.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl/a9xQuUer+m9uR+mirQQbP3SakJhF6tGU5Vn62HKHFlcVJNAO5OBBy+963cBkcIHR459lwJXhV+UcHsIKFgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX8Q SoCs feature a powerful video processing unit able to decode many
foramts and encode H.264.

This Driver is for this IP that is based on t he v4l2 mem2mem framework.

Supported SoCs are: IMX8QXP, IMX8QM

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/imx/Kconfig            |   19 +
 drivers/media/platform/imx/Makefile           |    1 +
 drivers/media/platform/imx/vpu-8q/Makefile    |   23 +
 drivers/media/platform/imx/vpu-8q/vdec.c      | 1783 +++++++++++++++++
 drivers/media/platform/imx/vpu-8q/venc.c      | 1411 +++++++++++++
 drivers/media/platform/imx/vpu-8q/vpu.h       |  339 ++++
 drivers/media/platform/imx/vpu-8q/vpu_cmds.c  |  443 ++++
 drivers/media/platform/imx/vpu-8q/vpu_cmds.h  |   34 +
 drivers/media/platform/imx/vpu-8q/vpu_codec.h |   77 +
 drivers/media/platform/imx/vpu-8q/vpu_color.c |  201 ++
 drivers/media/platform/imx/vpu-8q/vpu_core.c  |  923 +++++++++
 drivers/media/platform/imx/vpu-8q/vpu_core.h  |   26 +
 drivers/media/platform/imx/vpu-8q/vpu_dbg.c   |  505 +++++
 drivers/media/platform/imx/vpu-8q/vpu_defs.h  |  194 ++
 .../media/platform/imx/vpu-8q/vpu_dev_imx8q.c |   82 +
 drivers/media/platform/imx/vpu-8q/vpu_drv.c   |  248 +++
 .../media/platform/imx/vpu-8q/vpu_helpers.c   |  405 ++++
 .../media/platform/imx/vpu-8q/vpu_helpers.h   |   80 +
 drivers/media/platform/imx/vpu-8q/vpu_imx8q.c |  227 +++
 drivers/media/platform/imx/vpu-8q/vpu_imx8q.h |  125 ++
 drivers/media/platform/imx/vpu-8q/vpu_log.h   |   53 +
 .../media/platform/imx/vpu-8q/vpu_malone.c    | 1744 ++++++++++++++++
 .../media/platform/imx/vpu-8q/vpu_malone.h    |   51 +
 drivers/media/platform/imx/vpu-8q/vpu_mbox.c  |  135 ++
 drivers/media/platform/imx/vpu-8q/vpu_mbox.h  |   25 +
 drivers/media/platform/imx/vpu-8q/vpu_msgs.c  |  420 ++++
 drivers/media/platform/imx/vpu-8q/vpu_msgs.h  |   23 +
 drivers/media/platform/imx/vpu-8q/vpu_rpc.c   |  266 +++
 drivers/media/platform/imx/vpu-8q/vpu_rpc.h   |  472 +++++
 drivers/media/platform/imx/vpu-8q/vpu_v4l2.c  |  730 +++++++
 drivers/media/platform/imx/vpu-8q/vpu_v4l2.h  |   56 +
 .../media/platform/imx/vpu-8q/vpu_windsor.c   | 1253 ++++++++++++
 .../media/platform/imx/vpu-8q/vpu_windsor.h   |   48 +
 include/linux/imx_vpu.h                       |   19 +
 include/uapi/linux/imx_vpu.h                  |  120 ++
 37 files changed, 12565 insertions(+)
 create mode 100644 drivers/media/platform/imx/Kconfig
 create mode 100644 drivers/media/platform/imx/Makefile
 create mode 100644 drivers/media/platform/imx/vpu-8q/Makefile
 create mode 100644 drivers/media/platform/imx/vpu-8q/vdec.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/venc.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_cmds.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_cmds.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_codec.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_color.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_core.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_core.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_dbg.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_defs.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_dev_imx8q.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_drv.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_helpers.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_helpers.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_imx8q.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_imx8q.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_log.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_malone.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_malone.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_mbox.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_mbox.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_msgs.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_msgs.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_rpc.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_rpc.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_v4l2.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_v4l2.h
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_windsor.c
 create mode 100644 drivers/media/platform/imx/vpu-8q/vpu_windsor.h
 create mode 100644 include/linux/imx_vpu.h
 create mode 100644 include/uapi/linux/imx_vpu.h

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a3cb104956d5..27e67cb1abb5 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -168,6 +168,8 @@ config VIDEO_TI_CAL
 	  In TI Technical Reference Manual this module is referred as
 	  Camera Interface Subsystem (CAMSS).
 
+source "drivers/media/platform/imx/Kconfig"
+
 endif # V4L_PLATFORM_DRIVERS
 
 menuconfig V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 62b6cdc8c730..e564c0089012 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -80,3 +80,5 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
 obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 
 obj-y					+= sunxi/
+
+obj-y					+= imx/
diff --git a/drivers/media/platform/imx/Kconfig b/drivers/media/platform/imx/Kconfig
new file mode 100644
index 000000000000..40cceb2cb526
--- /dev/null
+++ b/drivers/media/platform/imx/Kconfig
@@ -0,0 +1,19 @@
+#
+# Codec configuration
+#
+
+config MXC_VPU_8Q
+	tristate "Support for MXC 8Q VPU(Video Processing Unit) Codec"
+	depends on ARCH_MXC
+	depends on MEDIA_SUPPORT
+	depends on VIDEO_DEV
+	depends on VIDEO_V4L2
+	select V4L2_MEM2MEM_DEV
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	default y
+	help
+	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
+	  It accelerates encoding and decoding operations on
+	  various NXP SoCs.
+	  To compile this driver as a module choose m here.
diff --git a/drivers/media/platform/imx/Makefile b/drivers/media/platform/imx/Makefile
new file mode 100644
index 000000000000..214f43ca390c
--- /dev/null
+++ b/drivers/media/platform/imx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MXC_VPU_8Q) += vpu-8q/
diff --git a/drivers/media/platform/imx/vpu-8q/Makefile b/drivers/media/platform/imx/vpu-8q/Makefile
new file mode 100644
index 000000000000..ecc74b63d536
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for NXP VPU driver
+
+vpu-8q-dev-objs += vpu_drv.o \
+			vpu_dev_imx8q.o
+
+vpu-8q-core-objs += vpu_core.o \
+			vpu_mbox.o \
+			vpu_v4l2.o \
+			vpu_helpers.o \
+			vpu_cmds.o \
+			vpu_msgs.o \
+			vpu_rpc.o \
+			vpu_imx8q.o \
+			vpu_windsor.o \
+			vpu_malone.o \
+			vpu_color.o \
+			vdec.o  \
+			venc.o \
+			vpu_dbg.o
+
+obj-$(CONFIG_MXC_VPU_8Q) += vpu-8q-dev.o
+obj-$(CONFIG_MXC_VPU_8Q) += vpu-8q-core.o
diff --git a/drivers/media/platform/imx/vpu-8q/vdec.c b/drivers/media/platform/imx/vpu-8q/vdec.c
new file mode 100644
index 000000000000..7231e2554a76
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vdec.c
@@ -0,0 +1,1783 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#define TAG		"DEC"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+#include <linux/imx_vpu.h>
+#include "vpu.h"
+#include "vpu_defs.h"
+#include "vpu_core.h"
+#include "vpu_helpers.h"
+#include "vpu_v4l2.h"
+#include "vpu_cmds.h"
+#include "vpu_rpc.h"
+#include "vpu_log.h"
+
+#define VDEC_FRAME_DEPTH		256
+
+struct vdec_fs_info {
+	char name[8];
+	u32 type;
+	u32 max_count;
+	u32 req_count;
+	u32 count;
+	u32 index;
+	u32 size;
+	struct vpu_buffer buffer[32];
+	u32 tag;
+};
+
+struct vdec_t {
+	u32 seq_hdr_found;
+	struct vpu_buffer udata;
+	struct vpu_decode_params params;
+	struct vpu_dec_codec_info codec_info;
+	enum vpu_codec_state state;
+
+	struct vpu_vb2_buffer *slots[VB2_MAX_FRAME];
+	u32 req_frame_count;
+	struct vdec_fs_info mbi;
+	struct vdec_fs_info dcp;
+	u32 seq_tag;
+
+	u32 decoded_frame_count;
+	u32 display_frame_count;
+	u32 eos_received;
+	u32 eos_subscribed;
+	u32 source_change;
+	u32 drain;
+	u32 ts_pre_count;
+	u32 frame_depth;
+	s64 ts_start;
+	s64 ts_input;
+	s64 timestamp;
+};
+
+static const struct vpu_format vdec_formats[] = {
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
+	{
+		.name = "NXP Tiled NV12 Format",
+		.pixfmt = V4L2_PIX_FMT_NT8,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
+	{
+		.name = "NXP Tiled 10bit Format",
+		.pixfmt = V4L2_PIX_FMT_NT10,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H264,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H264_MVC,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_HEVC,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_MPEG2,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_MPEG4,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.name = "AVS",
+		.pixfmt = V4L2_PIX_FMT_AVS,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_XVID,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_JPEG,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.name = "VP6",
+		.pixfmt = V4L2_PIX_FMT_VP6,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_VP8,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.name = "SPK",
+		.pixfmt = V4L2_PIX_FMT_SPK,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H263,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{0, 0, 0, 0},
+};
+
+static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_inst *inst = ctrl_to_inst(ctrl);
+	struct vdec_t *vdec = inst->priv;
+
+	switch (ctrl->id) {
+	case V4L2_CID_DIS_REORDER:
+		vdec->params.b_dis_reorder = ctrl->val;
+		break;
+	case V4L2_CID_NON_FRAME:
+		vdec->params.b_non_frame = ctrl->val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops vdec_ctrl_ops = {
+	.s_ctrl = vdec_op_s_ctrl,
+	.g_volatile_ctrl = vpu_helper_g_volatile_ctrl,
+};
+
+static struct v4l2_ctrl_config vdec_custom_cfg[] = {
+	{
+		.id = V4L2_CID_DIS_REORDER,
+		.name = "frame disable reoder ctrl",
+		.ops = &vdec_ctrl_ops,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.min = 0,
+		.max = 1,
+		.step = 1,
+		.def = 0,
+	},
+	{
+		.id = V4L2_CID_NON_FRAME,
+		.name = "stream input mode, is non frame or not",
+		.ops = &vdec_ctrl_ops,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.min = 0,
+		.max = 1,
+		.step = 1,
+		.def = 0,
+	},
+	{0, 0, 0, 0},
+};
+
+static int vdec_ctrl_init(struct vpu_inst *inst)
+{
+	struct v4l2_ctrl *ctrl;
+	int i;
+	int ret;
+
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 20);
+	if (ret)
+		return ret;
+
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+			V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+			V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	for (i = 0; i < ARRAY_SIZE(vdec_custom_cfg); i++)
+		ctrl = v4l2_ctrl_new_custom(&inst->ctrl_handler,
+					    &vdec_custom_cfg[i], NULL);
+
+	ret = v4l2_ctrl_handler_setup(&inst->ctrl_handler);
+	if (ret) {
+		inst_err(inst, "setup ctrls fail, ret = %d\n", ret);
+		v4l2_ctrl_handler_free(&inst->ctrl_handler);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int vdec_handle_eos(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_queue *dst_q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+
+	if (!vdec->eos_received)
+		return 0;
+
+	if (!vdec->eos_subscribed)
+		return 0;
+
+	if (!list_empty(&dst_q->done_list))
+		return 0;
+
+	dst_q->last_buffer_dequeued = true;
+	vpu_notify_eos(inst);
+	vdec->eos_received--;
+
+	return 0;
+}
+
+static void vdec_handle_resolution_change(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_queue *q;
+
+	if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		return;
+	if (!vdec->source_change)
+		return;
+
+	q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	if (!list_empty(&q->done_list))
+		return;
+
+	vdec->source_change--;
+	vpu_notify_source_change(inst);
+}
+
+static int vdec_update_state(struct vpu_inst *inst,
+		enum vpu_codec_state state, u32 force)
+{
+	struct vdec_t *vdec = inst->priv;
+	enum vpu_codec_state pre_state = inst->state;
+
+	if (state == VPU_CODEC_STATE_SEEK) {
+		if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+			vdec->state = inst->state;
+		else
+			vdec->state = VPU_CODEC_STATE_ACTIVE;
+	}
+	if (inst->state != VPU_CODEC_STATE_SEEK || force)
+		inst->state = state;
+	else if (state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		vdec->state = VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE;
+
+	inst_dbg(inst, LVL_FLOW, "state : %d -> %d\n", pre_state, inst->state);
+
+	if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		vdec_handle_resolution_change(inst);
+
+	return 0;
+}
+
+static int vdec_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, "vpu B0", sizeof(cap->driver));
+	strscpy(cap->card, "imx vpu decoder", sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: imx8q-vpu", sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int vdec_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec = inst->priv;
+	const struct vpu_format *fmt;
+	const char *descr = NULL;
+	int ret = -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (!V4L2_TYPE_IS_OUTPUT(f->type) && vdec->seq_hdr_found) {
+		if (f->index == 0) {
+			f->pixelformat = inst->cap_format.pixfmt;
+			f->flags = inst->cap_format.flags;
+			descr = inst->cap_format.name;
+			ret = 0;
+		}
+	} else {
+		fmt = vpu_helper_enum_format(inst, f->type, f->index);
+		memset(f->reserved, 0, sizeof(f->reserved));
+		if (!fmt)
+			goto exit;
+
+		f->pixelformat = fmt->pixfmt;
+		f->flags = fmt->flags;
+		descr = fmt->name;
+		ret = 0;
+	}
+	if (descr && strlen(descr))
+		strscpy(f->description, descr, sizeof(f->description));
+
+exit:
+	mutex_unlock(&inst->lock);
+	return ret;
+}
+
+static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec = inst->priv;
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	struct vpu_format *cur_fmt;
+	int i;
+
+	cur_fmt = vpu_get_format(inst, f->type);
+
+	pixmp->pixelformat = cur_fmt->pixfmt;
+	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->width = cur_fmt->width;
+	pixmp->height = cur_fmt->height;
+	pixmp->field = cur_fmt->field;
+	pixmp->flags = cur_fmt->flags;
+	for (i = 0; i < pixmp->num_planes; i++) {
+		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
+		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+	}
+
+	f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
+	f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
+	f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
+	f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+
+	inst_dbg(inst, LVL_DEBUG, "%s g_fmt: %c%c%c%c %dx%d %d,%d, %d,%d\n",
+			vpu_type_name(f->type),
+			f->fmt.pix_mp.pixelformat,
+			f->fmt.pix_mp.pixelformat >> 8,
+			f->fmt.pix_mp.pixelformat >> 16,
+			f->fmt.pix_mp.pixelformat >> 24,
+			f->fmt.pix_mp.width,
+			f->fmt.pix_mp.height,
+			pixmp->plane_fmt[0].sizeimage,
+			pixmp->plane_fmt[1].sizeimage,
+			pixmp->plane_fmt[0].bytesperline,
+			pixmp->plane_fmt[1].bytesperline);
+
+	return 0;
+}
+
+static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_try_fmt_common(inst, f);
+
+	mutex_lock(&inst->lock);
+	if (vdec->seq_hdr_found) {
+		f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
+		f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
+		f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
+		f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+	} else {
+		f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
+		f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+		f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+		f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	}
+	mutex_unlock(&inst->lock);
+
+	return 0;
+}
+
+static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	const struct vpu_format *fmt;
+	struct vpu_format *cur_fmt;
+	struct vb2_queue *q;
+	struct vdec_t *vdec;
+	int i;
+
+	vdec = inst->priv;
+	q = v4l2_m2m_get_vq(inst->m2m_ctx, f->type);
+	if (!q)
+		return -EINVAL;
+	if (vb2_is_streaming(q))
+		return -EBUSY;
+
+	fmt = vpu_try_fmt_common(inst, f);
+	if (!fmt)
+		return -EINVAL;
+
+	cur_fmt = vpu_get_format(inst, f->type);
+
+	mutex_lock(&inst->lock);
+	cur_fmt->pixfmt = fmt->pixfmt;
+	cur_fmt->type = fmt->type;
+	if (V4L2_TYPE_IS_OUTPUT(f->type) || vdec->seq_hdr_found <= 0) {
+		cur_fmt->num_planes = fmt->num_planes;
+		cur_fmt->flags = fmt->flags;
+		cur_fmt->width = pixmp->width;
+		cur_fmt->height = pixmp->height;
+		for (i = 0; i < fmt->num_planes; i++) {
+			cur_fmt->sizeimage[i] = pixmp->plane_fmt[i].sizeimage;
+			cur_fmt->bytesperline[i] = pixmp->plane_fmt[i].bytesperline;
+		}
+		if (pixmp->field != V4L2_FIELD_ANY)
+			cur_fmt->field = pixmp->field;
+	} else {
+		pixmp->num_planes = cur_fmt->num_planes;
+		pixmp->width = cur_fmt->width;
+		pixmp->height = cur_fmt->height;
+		for (i = 0; i < pixmp->num_planes; i++) {
+			pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
+			pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+		}
+		pixmp->field = cur_fmt->field;
+	}
+	if (V4L2_TYPE_IS_OUTPUT(f->type))
+		vdec->params.codec_format = cur_fmt->pixfmt;
+	else
+		vdec->params.output_format = cur_fmt->pixfmt;
+
+	if (!vdec->seq_hdr_found) {
+		vdec->codec_info.color_primaries = f->fmt.pix_mp.colorspace;
+		vdec->codec_info.transfer_chars = f->fmt.pix_mp.xfer_func;
+		vdec->codec_info.matrix_coeffs = f->fmt.pix_mp.ycbcr_enc;
+		vdec->codec_info.full_range = f->fmt.pix_mp.quantization;
+
+		inst->crop.left = 0;
+		inst->crop.top = 0;
+		inst->crop.width = cur_fmt->width;
+		inst->crop.height = cur_fmt->height;
+	} else {
+		f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
+		f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
+		f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
+		f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+	}
+
+	mutex_unlock(&inst->lock);
+
+	inst_dbg(inst, LVL_FLOW, "%s s_fmt: %c%c%c%c %dx%d %u,%u, %u,%u\n",
+			vpu_type_name(f->type),
+			f->fmt.pix_mp.pixelformat,
+			f->fmt.pix_mp.pixelformat >> 8,
+			f->fmt.pix_mp.pixelformat >> 16,
+			f->fmt.pix_mp.pixelformat >> 24,
+			f->fmt.pix_mp.width,
+			f->fmt.pix_mp.height,
+			pixmp->plane_fmt[0].sizeimage,
+			pixmp->plane_fmt[1].sizeimage,
+			pixmp->plane_fmt[0].bytesperline,
+			pixmp->plane_fmt[1].bytesperline);
+
+	return 0;
+}
+
+static int vdec_g_selection(struct file *file, void *fh,
+					struct v4l2_selection *s)
+{
+	struct vpu_inst *inst = to_inst(file);
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
+			s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+			s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
+			s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		if (!V4L2_TYPE_IS_OUTPUT(s->type))
+			return -EINVAL;
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->out_format.width;
+		s->r.height = inst->out_format.height;
+		break;
+	case V4L2_SEL_TGT_CROP:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		if (!V4L2_TYPE_IS_OUTPUT(s->type))
+			return -EINVAL;
+		s->r = inst->crop;
+		break;
+	case V4L2_SEL_TGT_COMPOSE:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+		if (V4L2_TYPE_IS_OUTPUT(s->type))
+			return -EINVAL;
+		s->r = inst->crop;
+		break;
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+		if (V4L2_TYPE_IS_OUTPUT(s->type))
+			return -EINVAL;
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->cap_format.width;
+		s->r.height = inst->cap_format.height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+
+	return 0;
+}
+
+static int vdec_drain(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (!vdec->drain)
+		return 0;
+
+	if (v4l2_m2m_num_src_bufs_ready(inst->m2m_ctx))
+		return 0;
+
+	if (!vdec->params.frame_count) {
+		vpu_notify_eos(inst);
+		return 0;
+	}
+
+	vpu_iface_add_scode(inst, SCODE_PADDING_EOS);
+	vdec->params.end_flag = 1;
+	vpu_iface_set_decode_params(inst, &vdec->params, 1);
+	vdec->drain = 0;
+	inst_dbg(inst, LVL_FLOW, "append eos\n");
+
+	return 0;
+}
+
+static int vdec_cmd_stop(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst_dbg(inst, LVL_FLOW, "stop cmd\n");
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT) {
+		vpu_notify_eos(inst);
+	} else {
+		mutex_lock(&inst->lock);
+		vdec->drain = 1;
+		vdec_drain(inst);
+		mutex_unlock(&inst->lock);
+	}
+
+	return 0;
+}
+
+static int vdec_cmd_reset(struct vpu_inst *inst)
+{
+	inst_dbg(inst, LVL_FLOW, "reset cmd\n");
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	if (vb2_is_streaming(v4l2_m2m_get_src_vq(inst->m2m_ctx)))
+		return -EINVAL;
+	if (vb2_is_streaming(v4l2_m2m_get_dst_vq(inst->m2m_ctx)))
+		return -EINVAL;
+	vpu_session_stop(inst);
+
+	return 0;
+}
+
+static int vdec_decoder_cmd(struct file *file,
+		void *fh,
+		struct v4l2_decoder_cmd *cmd)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
+	if (ret)
+		return ret;
+
+	switch (cmd->cmd) {
+	case V4L2_DEC_CMD_STOP:
+		vdec_cmd_stop(inst);
+		break;
+	case V4L2_DEC_CMD_RESET:
+		vdec_cmd_reset(inst);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int vdec_subscribe_event(struct v4l2_fh *fh,
+		const struct v4l2_event_subscription *sub)
+{
+	struct vpu_inst *inst = container_of(fh, struct vpu_inst, fh);
+	struct vdec_t *vdec = inst->priv;
+
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		vdec->eos_subscribed = true;
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subscribe(fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	case V4L2_EVENT_SKIP:
+	case V4L2_EVENT_CODEC_ERROR:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vdec_unsubscribe_event(struct v4l2_fh *fh,
+				const struct v4l2_event_subscription *sub)
+{
+	struct vpu_inst *inst = container_of(fh, struct vpu_inst, fh);
+	struct vdec_t *vdec = inst->priv;
+	int ret;
+
+	ret = v4l2_event_unsubscribe(fh, sub);
+	if (ret)
+		return ret;
+
+	if (sub->type == V4L2_EVENT_EOS)
+		vdec->eos_subscribed = false;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops vdec_ioctl_ops = {
+	.vidioc_querycap               = vdec_querycap,
+	.vidioc_enum_fmt_vid_cap       = vdec_enum_fmt,
+	.vidioc_enum_fmt_vid_out       = vdec_enum_fmt,
+	.vidioc_g_fmt_vid_cap_mplane   = vdec_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane   = vdec_g_fmt,
+	.vidioc_try_fmt_vid_cap_mplane = vdec_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane = vdec_try_fmt,
+	.vidioc_s_fmt_vid_cap_mplane   = vdec_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane   = vdec_s_fmt,
+	.vidioc_g_selection            = vdec_g_selection,
+	.vidioc_try_decoder_cmd        = v4l2_m2m_ioctl_try_decoder_cmd,
+	.vidioc_decoder_cmd            = vdec_decoder_cmd,
+	.vidioc_subscribe_event        = vdec_subscribe_event,
+	.vidioc_unsubscribe_event      = vdec_unsubscribe_event,
+	.vidioc_reqbufs                = vpu_v4l2_ioctl_reqbufs,
+	.vidioc_create_bufs	       = vpu_v4l2_ioctl_create_bufs,
+	.vidioc_prepare_buf	       = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_querybuf               = v4l2_m2m_ioctl_querybuf,
+	.vidioc_qbuf                   = vpu_v4l2_ioctl_qbuf,
+	.vidioc_expbuf                 = v4l2_m2m_ioctl_expbuf,
+	.vidioc_dqbuf                  = vpu_v4l2_ioctl_dqbuf,
+	.vidioc_streamon               = vpu_v4l2_ioctl_streamon,
+	.vidioc_streamoff              = vpu_v4l2_ioctl_streamoff,
+};
+
+static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (vdec->ts_pre_count >= vdec->frame_depth)
+			return false;
+		return true;
+	}
+
+	if (vdec->req_frame_count || vdec->eos_received)
+		return true;
+
+	return false;
+}
+
+static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_dec_pic_info *info = arg;
+	struct vpu_vb2_buffer *vpu_buf;
+	int ret = 0;
+
+	if (!info || info->id >= ARRAY_SIZE(vdec->slots))
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	vpu_buf = vdec->slots[info->id];
+	if (!vpu_buf) {
+		inst_err(inst, "decoded invalid frame[%d]\n", info->id);
+		ret = -EINVAL;
+		goto exit;
+	}
+	if (vpu_buf->state == VPU_BUF_STATE_DECODED)
+		inst_dbg(inst, LVL_INFO, "buf[%d] has been decoded\n", info->id);
+	vpu_buf->state = VPU_BUF_STATE_DECODED;
+	vdec->decoded_frame_count++;
+	if (vdec->ts_pre_count >= info->consumed_count)
+		vdec->ts_pre_count -= info->consumed_count;
+	else
+		vdec->ts_pre_count = 0;
+exit:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static struct vpu_vb2_buffer *vdec_find_buffer(struct vpu_inst *inst, u32 luma)
+{
+	struct vdec_t *vdec = inst->priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vdec->slots); i++) {
+		if (!vdec->slots[i])
+			continue;
+		if (luma == vdec->slots[i]->luma)
+			return vdec->slots[i];
+	}
+
+	return NULL;
+}
+
+static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+
+	if (!frame)
+		return;
+
+	mutex_lock(&inst->lock);
+	vpu_buf = vdec_find_buffer(inst, frame->luma);
+	mutex_unlock(&inst->lock);
+	if (!vpu_buf) {
+		inst_err(inst, "can't find buffer, id = %d, addr = 0x%x\n",
+				frame->id, frame->luma);
+		return;
+	}
+	if (frame->skipped) {
+		inst_dbg(inst, LVL_DEBUG, "frame skip\n");
+		vpu_notify_skip(inst);
+		return;
+	}
+
+	vbuf = &vpu_buf->m2m_buf.vb;
+	if (vbuf->vb2_buf.index != frame->id)
+		inst_err(inst, "buffer id(%d, %d) dismatch\n",
+				vbuf->vb2_buf.index, frame->id);
+
+	if (vpu_buf->state != VPU_BUF_STATE_DECODED)
+		inst_err(inst, "buffer(%d) ready without decoded\n", frame->id);
+	vpu_buf->state = VPU_BUF_STATE_READY;
+	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0]);
+	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1]);
+	vbuf->vb2_buf.timestamp = frame->timestamp;
+	vbuf->field = inst->cap_format.field;
+	inst_dbg(inst, LVL_TS, "[OUTPUT TS]%32lld\n", frame->timestamp);
+
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+	mutex_lock(&inst->lock);
+	vdec->timestamp = frame->timestamp;
+	vdec->display_frame_count++;
+	mutex_unlock(&inst->lock);
+	inst_dbg(inst, LVL_DEBUG, "decoded : %d, display : %d\n",
+			vdec->decoded_frame_count, vdec->display_frame_count);
+}
+
+static void vdec_stop_done(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	mutex_lock(&inst->lock);
+	vdec_update_state(inst, VPU_CODEC_STATE_DEINIT, 0);
+	vdec->seq_hdr_found = 0;
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_init_fmt(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst->out_format.width = vdec->codec_info.decoded_width;
+	inst->out_format.height = vdec->codec_info.decoded_height;
+	inst->cap_format.width = vdec->codec_info.decoded_width;
+	inst->cap_format.height = vdec->codec_info.decoded_height;
+	inst->cap_format.pixfmt = vdec->codec_info.pixfmt;
+	inst->cap_format.bytesperline[0] = vdec->codec_info.bytesperline[0];
+	inst->cap_format.bytesperline[1] = vdec->codec_info.bytesperline[1];
+	inst->cap_format.sizeimage[0] = vdec->codec_info.sizeimage[0];
+	inst->cap_format.sizeimage[1] = vdec->codec_info.sizeimage[1];
+	if (vdec->codec_info.progressive)
+		inst->cap_format.field = V4L2_FIELD_NONE;
+	else
+		inst->cap_format.field = V4L2_FIELD_INTERLACED;
+	if (vdec->codec_info.color_primaries == V4L2_COLORSPACE_DEFAULT)
+		vdec->codec_info.color_primaries = V4L2_COLORSPACE_REC709;
+	if (vdec->codec_info.transfer_chars == V4L2_XFER_FUNC_DEFAULT)
+		vdec->codec_info.transfer_chars = V4L2_XFER_FUNC_709;
+	if (vdec->codec_info.matrix_coeffs == V4L2_YCBCR_ENC_DEFAULT)
+		vdec->codec_info.matrix_coeffs = V4L2_YCBCR_ENC_709;
+	if (vdec->codec_info.full_range == V4L2_QUANTIZATION_DEFAULT)
+		vdec->codec_info.full_range = V4L2_QUANTIZATION_LIM_RANGE;
+}
+
+static void vdec_init_crop(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst->crop.left = vdec->codec_info.offset_x;
+	inst->crop.top = vdec->codec_info.offset_y;
+	inst->crop.width = vdec->codec_info.width;
+	inst->crop.height = vdec->codec_info.height;
+}
+
+static void vdec_init_mbi(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vdec->mbi.size = vdec->codec_info.mbi_size;
+	vdec->mbi.max_count = ARRAY_SIZE(vdec->mbi.buffer);
+	scnprintf(vdec->mbi.name, sizeof(vdec->mbi.name), "mbi");
+	vdec->mbi.type = MEM_RES_MBI;
+	vdec->mbi.tag = vdec->seq_tag;
+}
+
+static void vdec_init_dcp(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vdec->dcp.size = vdec->codec_info.dcp_size;
+	vdec->dcp.max_count = ARRAY_SIZE(vdec->dcp.buffer);
+	scnprintf(vdec->dcp.name, sizeof(vdec->dcp.name), "dcp");
+	vdec->dcp.type = MEM_RES_DCP;
+	vdec->dcp.tag = vdec->seq_tag;
+}
+
+static void vdec_request_one_fs(struct vdec_fs_info *fs)
+{
+	WARN_ON(!fs);
+
+	fs->req_count++;
+	if (fs->req_count > fs->max_count) {
+		vpu_err("error:request %s over %d\n", fs->name, fs->max_count);
+		fs->req_count = fs->max_count;
+	}
+}
+
+static int vdec_alloc_fs_buffer(struct vpu_inst *inst, struct vdec_fs_info *fs)
+{
+	struct vpu_buffer *buffer;
+
+	if (!inst || !fs || !fs->size)
+		return -EINVAL;
+
+	if (fs->count >= fs->req_count)
+		return -EINVAL;
+
+	buffer = &fs->buffer[fs->count];
+	if (buffer->virt && buffer->length >= fs->size)
+		return 0;
+
+	vpu_free_dma(buffer);
+	buffer->length = fs->size;
+	return vpu_alloc_dma(inst->core, buffer);
+}
+
+static void vdec_alloc_fs(struct vpu_inst *inst, struct vdec_fs_info *fs)
+{
+	int ret;
+
+	while (fs->count < fs->req_count) {
+		ret = vdec_alloc_fs_buffer(inst, fs);
+		if (ret)
+			break;
+		fs->count++;
+	}
+}
+
+static void vdec_clear_fs(struct vdec_fs_info *fs)
+{
+	u32 i;
+
+	if (!fs)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(fs->buffer); i++)
+		vpu_free_dma(&fs->buffer[i]);
+	memset(fs, 0, sizeof(*fs));
+}
+
+static int vdec_response_fs(struct vpu_inst *inst, struct vdec_fs_info *fs)
+{
+	struct vpu_fs_info info;
+	int ret;
+
+	if (fs->index >= fs->count)
+		return 0;
+
+	memset(&info, 0, sizeof(info));
+	info.id = fs->index;
+	info.type = fs->type;
+	info.tag = fs->tag;
+	info.luma_addr = fs->buffer[fs->index].phys;
+	info.luma_size = fs->buffer[fs->index].length;
+	ret = vpu_session_alloc_fs(inst, &info);
+	if (ret)
+		return ret;
+
+	fs->index++;
+	return 0;
+}
+
+static int vdec_response_frame_abnormal(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_fs_info info;
+
+	if (!vdec->req_frame_count)
+		return 0;
+
+	memset(&info, 0, sizeof(info));
+	info.type = MEM_RES_FRAME;
+	info.tag = vdec->seq_tag + 0xf0;
+	vpu_session_alloc_fs(inst, &info);
+	vdec->req_frame_count--;
+
+	return 0;
+}
+
+static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vbuf)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vpu_fs_info info;
+	int ret;
+
+	if (inst->state != VPU_CODEC_STATE_ACTIVE)
+		return -EINVAL;
+
+	if (!vdec->req_frame_count)
+		return -EINVAL;
+
+	if (!vbuf)
+		return -EINVAL;
+
+	if (vdec->slots[vbuf->vb2_buf.index]) {
+		inst_err(inst, "repeat alloc fs %d\n", vbuf->vb2_buf.index);
+		return -EINVAL;
+	}
+
+	inst_dbg(inst, LVL_DEBUG, "inst->state = %d, alloc fs %d, tag = 0x%x\n",
+		inst->state, vbuf->vb2_buf.index, vdec->seq_tag);
+	vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+	memset(&info, 0, sizeof(info));
+	info.id = vbuf->vb2_buf.index;
+	info.type = MEM_RES_FRAME;
+	info.tag = vdec->seq_tag;
+	info.luma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 0);
+	info.luma_size = inst->cap_format.sizeimage[0];
+	info.chroma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
+	info.chromau_size = inst->cap_format.sizeimage[1];
+	info.bytesperline = inst->cap_format.bytesperline[0];
+	ret = vpu_session_alloc_fs(inst, &info);
+	if (ret)
+		return ret;
+
+	vpu_buf->tag = info.tag;
+	vpu_buf->luma = info.luma_addr;
+	vpu_buf->chroma_u = info.chromau_size;
+	vpu_buf->chroma_v = 0;
+	vpu_buf->state = VPU_BUF_STATE_INUSE;
+	vdec->slots[info.id] = vpu_buf;
+	vdec->req_frame_count--;
+
+	return 0;
+}
+
+static void vdec_response_fs_request(struct vpu_inst *inst, bool force)
+{
+	struct vdec_t *vdec = inst->priv;
+	int i;
+	int ret;
+
+	if (force) {
+		for (i = vdec->req_frame_count; i > 0; i--)
+			vdec_response_frame_abnormal(inst);
+		return;
+	}
+
+	for (i = vdec->req_frame_count; i > 0; i--) {
+		ret = vpu_process_capture_buffer(inst);
+		if (ret)
+			break;
+		if (vdec->eos_received)
+			break;
+	}
+
+	for (i = vdec->mbi.index; i < vdec->mbi.count; i++) {
+		if (vdec_response_fs(inst, &vdec->mbi))
+			break;
+		if (vdec->eos_received)
+			break;
+	}
+	for (i = vdec->dcp.index; i < vdec->dcp.count; i++) {
+		if (vdec_response_fs(inst, &vdec->dcp))
+			break;
+		if (vdec->eos_received)
+			break;
+	}
+}
+
+static void vdec_response_fs_release(struct vpu_inst *inst, u32 id, u32 tag)
+{
+	struct vpu_fs_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.id = id;
+	info.tag = tag;
+	vpu_session_release_fs(inst, &info);
+}
+
+static void vdec_recycle_buffer(struct vpu_inst *inst, struct vb2_v4l2_buffer *vbuf)
+{
+	if (!inst || !vbuf)
+		return;
+
+	if (vbuf->vb2_buf.state != VB2_BUF_STATE_ACTIVE)
+		return;
+	if (vpu_find_buf_by_idx(inst, vbuf->vb2_buf.type, vbuf->vb2_buf.index))
+		return;
+	v4l2_m2m_buf_queue(inst->m2m_ctx, vbuf);
+}
+
+static void vdec_clear_slots(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vdec->slots); i++) {
+		if (!vdec->slots[i])
+			continue;
+
+		vpu_buf = vdec->slots[i];
+		vbuf = &vpu_buf->m2m_buf.vb;
+		if (vpu_buf->tag == vdec->seq_tag)
+			inst_dbg(inst, LVL_WARN, "clear slot[%d], %d, %d\n",
+				i,
+				vdec->slots[i]->state,
+				vbuf->vb2_buf.state);
+
+		vdec_response_fs_release(inst, i, vpu_buf->tag);
+		vdec_recycle_buffer(inst, vbuf);
+		vdec->slots[i]->state = VPU_BUF_STATE_IDLE;
+		vdec->slots[i] = NULL;
+	}
+}
+
+static void vdec_event_seq_hdr(struct vpu_inst *inst,
+				struct vpu_dec_codec_info *hdr)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	mutex_lock(&inst->lock);
+	memcpy(&vdec->codec_info, hdr, sizeof(vdec->codec_info));
+
+	inst_dbg(inst, LVL_FLOW, "%d x %d, crop : (%d, %d) %d x %d\n",
+			vdec->codec_info.decoded_width,
+			vdec->codec_info.decoded_height,
+			vdec->codec_info.offset_x,
+			vdec->codec_info.offset_y,
+			vdec->codec_info.width,
+			vdec->codec_info.height);
+	vdec_init_fmt(inst);
+	vdec_init_crop(inst);
+	inst->min_buffer_cap = hdr->num_ref_frms + hdr->num_dpb_frms;
+	vdec_init_mbi(inst);
+	vdec_init_dcp(inst);
+	if (!vdec->seq_hdr_found) {
+		vdec->seq_tag = vdec->codec_info.tag;
+		vpu_notify_source_change(inst);
+	}
+	if (vdec->seq_tag != vdec->codec_info.tag) {
+		vdec_response_fs_request(inst, true);
+		inst_dbg(inst, LVL_DEBUG, "seq tag change: %d -> %d\n",
+				vdec->seq_tag, vdec->codec_info.tag);
+	}
+	vdec->seq_hdr_found++;
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_event_resolution_change(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst_dbg(inst, LVL_FLOW, "resolution change\n");
+	mutex_lock(&inst->lock);
+	vdec->seq_tag = vdec->codec_info.tag;
+	vdec_clear_fs(&vdec->mbi);
+	vdec_clear_fs(&vdec->dcp);
+	vdec_clear_slots(inst);
+	vdec_init_mbi(inst);
+	vdec_init_dcp(inst);
+	vdec_update_state(inst, VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE, 0);
+	vdec->source_change++;
+	vdec_handle_resolution_change(inst);
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_event_req_fs(struct vpu_inst *inst, struct vpu_fs_info *fs)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (!fs)
+		return;
+
+	mutex_lock(&inst->lock);
+
+	switch (fs->type) {
+	case MEM_RES_FRAME:
+		vdec->req_frame_count++;
+		break;
+	case MEM_RES_MBI:
+		vdec_request_one_fs(&vdec->mbi);
+		break;
+	case MEM_RES_DCP:
+		vdec_request_one_fs(&vdec->dcp);
+		break;
+	default:
+		break;
+	}
+
+	vdec_alloc_fs(inst, &vdec->mbi);
+	vdec_alloc_fs(inst, &vdec->dcp);
+
+	vdec_response_fs_request(inst, false);
+
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_evnet_rel_fs(struct vpu_inst *inst, struct vpu_fs_info *fs)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+
+	if (!fs || fs->id >= ARRAY_SIZE(vdec->slots))
+		return;
+	if (fs->type != MEM_RES_FRAME)
+		return;
+
+	if (fs->id >= vpu_get_num_buffers(inst, inst->cap_format.type)) {
+		inst_err(inst, "invalid fs(%d) to release\n", fs->id);
+		return;
+	}
+
+	mutex_lock(&inst->lock);
+	vpu_buf = vdec->slots[fs->id];
+	vdec->slots[fs->id] = NULL;
+
+	if (!vpu_buf) {
+		inst_dbg(inst, LVL_DEBUG, "fs[%d] has bee released\n", fs->id);
+		goto exit;
+	}
+
+	if (vpu_buf->state == VPU_BUF_STATE_DECODED) {
+		inst_dbg(inst, LVL_DEBUG, "this frame is skipped\n");
+		vpu_notify_skip(inst);
+	}
+
+	vdec_response_fs_release(inst, fs->id, vpu_buf->tag);
+	vbuf = &vpu_buf->m2m_buf.vb;
+	if (vpu_buf->state != VPU_BUF_STATE_READY)
+		vdec_recycle_buffer(inst, vbuf);
+
+	vpu_buf->state = VPU_BUF_STATE_IDLE;
+	vpu_process_capture_buffer(inst);
+
+exit:
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_event_eos(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst_dbg(inst, LVL_FLOW, "eos\n");
+	mutex_lock(&inst->lock);
+	vdec->eos_received++;
+	vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
+	vpu_process_capture_buffer(inst);
+	vdec_handle_eos(inst);
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_event_notify(struct vpu_inst *inst, u32 event, void *data)
+{
+	switch (event) {
+	case VPU_MSG_ID_SEQ_HDR_FOUND:
+		vdec_event_seq_hdr(inst, data);
+		break;
+	case VPU_MSG_ID_RES_CHANGE:
+		vdec_event_resolution_change(inst);
+		break;
+	case VPU_MSG_ID_FRAME_REQ:
+		vdec_event_req_fs(inst, data);
+		break;
+	case VPU_MSG_ID_FRAME_RELEASE:
+		vdec_evnet_rel_fs(inst, data);
+		break;
+	case VPU_MSG_ID_PIC_EOS:
+		vdec_event_eos(inst);
+		break;
+	default:
+		break;
+	}
+}
+
+static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_v4l2_buffer *vbuf;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vpu_rpc_buffer_desc desc;
+	s64 timestamp;
+	u32 free_space;
+	int ret;
+
+	vbuf = to_vb2_v4l2_buffer(vb);
+	vpu_buf = to_vpu_vb2_buffer(vbuf);
+	inst_dbg(inst, LVL_DEBUG, "dec output [%d] %d : %ld\n",
+		vbuf->sequence, vb->index, vb2_get_plane_payload(vb, 0));
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return -EINVAL;
+
+	if (inst->state == VPU_CODEC_STATE_STARTED)
+		vdec_update_state(inst, VPU_CODEC_STATE_ACTIVE, 0);
+
+	ret = vpu_iface_get_stream_buffer_desc(inst, &desc);
+	if (ret)
+		return ret;
+
+	free_space = vpu_helper_get_free_space(inst);
+	if (free_space < vb2_get_plane_payload(vb, 0) + 0x40000)
+		return -ENOMEM;
+
+	timestamp = vb->timestamp;
+	if (timestamp >= 0 && vdec->ts_start < 0)
+		vdec->ts_start = timestamp;
+	if (vdec->ts_input < timestamp)
+		vdec->ts_input = timestamp;
+
+	ret = vpu_iface_input_frame(inst, vb);
+	if (ret < 0)
+		return -ENOMEM;
+
+	inst_dbg(inst, LVL_TS, "[INPUT  TS]%32lld\n", vb->timestamp);
+	vdec->ts_pre_count++;
+	vdec->params.frame_count++;
+
+	v4l2_m2m_src_buf_remove_by_buf(inst->m2m_ctx, vbuf);
+	vpu_buf->state = VPU_BUF_STATE_IDLE;
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+
+	if (vdec->drain)
+		vdec_drain(inst);
+
+	return 0;
+}
+
+static int vdec_process_capture(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_v4l2_buffer *vbuf;
+	int ret;
+
+	if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		return -EINVAL;
+
+	vbuf = to_vb2_v4l2_buffer(vb);
+
+	if (vdec->eos_received) {
+		if (vdec->eos_subscribed) {
+			vdec_handle_eos(inst);
+		} else {
+			vb2_set_plane_payload(vb, 0, 0);
+			vb2_set_plane_payload(vb, 1, 0);
+			vbuf->flags |= V4L2_BUF_FLAG_LAST;
+			v4l2_m2m_dst_buf_remove_by_buf(inst->m2m_ctx, vbuf);
+			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+			vdec->eos_received--;
+		}
+		return 0;
+	}
+
+	ret = vdec_response_frame(inst, vbuf);
+	if (ret)
+		return ret;
+	v4l2_m2m_dst_buf_remove_by_buf(inst->m2m_ctx, vbuf);
+	return 0;
+}
+
+static void vdec_on_queue_emtpy(struct vpu_inst *inst, u32 type)
+{
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return;
+
+	mutex_lock(&inst->lock);
+	vdec_handle_resolution_change(inst);
+	vdec_handle_eos(inst);
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_abort(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_rpc_buffer_desc desc;
+	int ret;
+
+	inst_dbg(inst, LVL_FLOW, "abort, inst->state = %d\n", inst->state);
+	mutex_lock(&inst->lock);
+	vpu_iface_add_scode(inst, SCODE_PADDING_ABORT);
+	vdec->params.end_flag = 1;
+	vpu_iface_set_decode_params(inst, &vdec->params, 1);
+	mutex_unlock(&inst->lock);
+
+	vpu_session_abort(inst);
+
+	mutex_lock(&inst->lock);
+	ret = vpu_iface_get_stream_buffer_desc(inst, &desc);
+	if (!ret)
+		vpu_iface_update_stream_buffer(inst, desc.rptr, 1);
+	mutex_unlock(&inst->lock);
+
+	vpu_session_rst_buf(inst);
+	mutex_lock(&inst->lock);
+	inst_dbg(inst, LVL_FLOW, "input : %d, decoded : %d, display : %d\n",
+			vdec->params.frame_count,
+			vdec->decoded_frame_count,
+			vdec->display_frame_count);
+	vdec->params.end_flag = 0;
+	vdec->drain = 0;
+	vdec->ts_pre_count = 0;
+	vdec->timestamp = VPU_INVALID_TIMESTAMP;
+	vdec->ts_start = VPU_INVALID_TIMESTAMP;
+	vdec->ts_input = VPU_INVALID_TIMESTAMP;
+	vdec->params.frame_count = 0;
+	vdec->decoded_frame_count = 0;
+	vdec->display_frame_count = 0;
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_release(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst_dbg(inst, LVL_FLOW, "release\n");
+	mutex_lock(&inst->lock);
+	vdec_clear_slots(inst);
+	mutex_unlock(&inst->lock);
+	if (inst->state != VPU_CODEC_STATE_DEINIT)
+		vpu_session_stop(inst);
+	vdec_clear_fs(&vdec->mbi);
+	vdec_clear_fs(&vdec->dcp);
+	vpu_free_dma(&vdec->udata);
+	vpu_free_dma(&inst->stream_buffer);
+	mutex_lock(&inst->lock);
+	vdec_update_state(inst, VPU_CODEC_STATE_DEINIT, 1);
+	mutex_unlock(&inst->lock);
+}
+
+static void vdec_cleanup(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec;
+
+	if (!inst)
+		return;
+
+	vdec = inst->priv;
+	if (vdec)
+		vfree(vdec);
+	inst->priv = NULL;
+	vfree(inst);
+}
+
+static void vdec_init_params(struct vdec_t *vdec)
+{
+	vdec->params.frame_count = 0;
+	vdec->params.end_flag = 0;
+}
+
+static int vdec_start(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	int stream_buffer_size;
+	int ret;
+
+	if (inst->state != VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	inst_dbg(inst, LVL_FLOW, "start\n");
+	vdec->udata.length = 0x1000;
+	ret = vpu_alloc_dma(inst->core, &vdec->udata);
+	if (ret) {
+		inst_err(inst, "alloc udata fail\n");
+		goto error;
+	}
+
+	vpu_iface_init_instance(inst);
+	stream_buffer_size = vpu_iface_get_stream_buffer_size(inst->core);
+	if (stream_buffer_size > 0) {
+		inst->stream_buffer.length = stream_buffer_size;
+		ret = vpu_alloc_dma(inst->core, &inst->stream_buffer);
+		if (ret) {
+			inst_err(inst, "alloc stream buffer fail\n");
+			goto error;
+		}
+		inst->use_stream_buffer = true;
+		vpu_iface_config_stream_buffer(inst, &inst->stream_buffer);
+	}
+
+	vdec->params.udata.base = vdec->udata.phys;
+	vdec->params.udata.size = vdec->udata.length;
+	ret = vpu_iface_set_decode_params(inst, &vdec->params, 0);
+	if (ret) {
+		inst_err(inst, "set decode params fail\n");
+		goto error;
+	}
+
+	vdec_init_params(vdec);
+	ret = vpu_session_start(inst);
+	if (ret) {
+		inst_err(inst, "start fail\n");
+		goto error;
+	}
+
+	vdec_update_state(inst, VPU_CODEC_STATE_STARTED, 0);
+
+	return 0;
+error:
+	vpu_free_dma(&vdec->udata);
+	vpu_free_dma(&inst->stream_buffer);
+	return ret;
+}
+
+static int vdec_start_session(struct vpu_inst *inst, u32 type)
+{
+	struct vdec_t *vdec = inst->priv;
+	int ret = 0;
+
+	mutex_lock(&inst->lock);
+	if (inst->state == VPU_CODEC_STATE_DEINIT) {
+		if (V4L2_TYPE_IS_OUTPUT(type)) {
+			ret = vdec_start(inst);
+			if (ret)
+				goto exit;
+		}
+	}
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (inst->state == VPU_CODEC_STATE_SEEK)
+			vdec_update_state(inst, vdec->state, 1);
+		vdec->eos_received = 0;
+		vpu_process_output_buffer(inst);
+	} else {
+		if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+			vdec_update_state(inst, VPU_CODEC_STATE_ACTIVE, 0);
+		vpu_process_capture_buffer(inst);
+	}
+	if (inst->state == VPU_CODEC_STATE_ACTIVE)
+		vdec_response_fs_request(inst, false);
+
+exit:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vdec_stop_session(struct vpu_inst *inst, u32 type)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		mutex_lock(&inst->lock);
+		vdec_update_state(inst, VPU_CODEC_STATE_SEEK, 0);
+		vdec->drain = 0;
+		mutex_unlock(&inst->lock);
+	} else {
+		if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+			vdec_abort(inst);
+
+		mutex_lock(&inst->lock);
+		vdec->eos_received = 0;
+		vdec_clear_slots(inst);
+		mutex_unlock(&inst->lock);
+	}
+
+	return 0;
+}
+
+static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i)
+{
+	struct vdec_t *vdec = inst->priv;
+	int num = -1;
+
+	switch (i) {
+	case 0:
+		num = scnprintf(str, size,
+				"req_frame_count = %d\ninterlaced = %d\n",
+				vdec->req_frame_count,
+				vdec->codec_info.progressive ? 0 : 1);
+		break;
+	case 1:
+		num = scnprintf(str, size,
+				"mbi: size = 0x%x request = %d, alloc = %d, response = %d\n",
+				vdec->mbi.size,
+				vdec->mbi.req_count,
+				vdec->mbi.count,
+				vdec->mbi.index);
+		break;
+	case 2:
+		num = scnprintf(str, size,
+				"dcp: size = 0x%x request = %d, alloc = %d, response = %d\n",
+				vdec->dcp.size,
+				vdec->dcp.req_count,
+				vdec->dcp.count,
+				vdec->dcp.index);
+		break;
+	case 3:
+		num = scnprintf(str, size, "input_frame_count = %d\n", vdec->params.frame_count);
+		break;
+	case 4:
+		num = scnprintf(str, size, "decoded_frame_count = %d\n", vdec->decoded_frame_count);
+		break;
+	case 5:
+		num = scnprintf(str, size, "display_frame_count = %d\n", vdec->display_frame_count);
+		break;
+	case 6:
+		num = scnprintf(str, size, "drain = %d, eos = %d, source_change = %d\n",
+				vdec->drain, vdec->eos_received, vdec->source_change);
+		break;
+	case 7:
+		num = scnprintf(str, size, "ts_pre_count = %d, frame_depth = %d\n",
+				vdec->ts_pre_count, vdec->frame_depth);
+		break;
+	case 8:
+		num = scnprintf(str, size, "b_dis_reorder = %d, b_non_frame = %d\n",
+				vdec->params.b_dis_reorder,
+				vdec->params.b_non_frame);
+		break;
+	case 9:
+	{
+		s64 timestamp = vdec->timestamp;
+		s64 ts_start = vdec->ts_start;
+		s64 ts_input = vdec->ts_input;
+
+		num = scnprintf(str, size, "timestamp = %9lld.%09lld(%9lld.%09lld, %9lld.%09lld)\n",
+				timestamp / NSEC_PER_SEC,
+				timestamp % NSEC_PER_SEC,
+				ts_start / NSEC_PER_SEC,
+				ts_start % NSEC_PER_SEC,
+				ts_input / NSEC_PER_SEC,
+				ts_input % NSEC_PER_SEC);
+	}
+		break;
+	default:
+		break;
+	}
+
+	return num;
+}
+
+static struct vpu_inst_ops vdec_inst_ops = {
+	.ctrl_init = vdec_ctrl_init,
+	.check_ready = vdec_check_ready,
+	.buf_done = vdec_buf_done,
+	.get_one_frame = vdec_frame_decoded,
+	.stop_done = vdec_stop_done,
+	.event_notify = vdec_event_notify,
+	.release = vdec_release,
+	.cleanup = vdec_cleanup,
+	.start = vdec_start_session,
+	.stop = vdec_stop_session,
+	.process_output = vdec_process_output,
+	.process_capture = vdec_process_capture,
+	.on_queue_empty = vdec_on_queue_emtpy,
+	.get_debug_info = vdec_get_debug_info,
+};
+
+static void vdec_init(struct file *file)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec;
+	struct v4l2_format f;
+
+	vdec = inst->priv;
+	vdec->frame_depth = VDEC_FRAME_DEPTH;
+	vdec->timestamp = VPU_INVALID_TIMESTAMP;
+	vdec->ts_start = VPU_INVALID_TIMESTAMP;
+	vdec->ts_input = VPU_INVALID_TIMESTAMP;
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	vdec_s_fmt(file, &inst->fh, &f);
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	vdec_s_fmt(file, &inst->fh, &f);
+}
+
+int vdec_open(struct file *file)
+{
+	struct vpu_inst *inst;
+	struct vdec_t *vdec;
+	int ret;
+
+	inst = vzalloc(sizeof(*inst));
+	if (!inst)
+		return -ENOMEM;
+
+	vdec = vzalloc(sizeof(*vdec));
+	if (!vdec) {
+		vfree(inst);
+		return -ENOMEM;
+	}
+
+	inst->ops = &vdec_inst_ops;
+	inst->formats = vdec_formats;
+	inst->type = VPU_CORE_TYPE_DEC;
+	inst->priv = vdec;
+
+	ret = vpu_v4l2_open(file, inst);
+	if (ret) {
+		vdec_cleanup(inst);
+		return ret;
+	}
+
+	vdec_init(file);
+
+	return 0;
+}
+
+__poll_t vdec_poll(struct file *file, poll_table *wait)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vb2_queue *src_q, *dst_q;
+	__poll_t ret;
+
+	ret = v4l2_m2m_fop_poll(file, wait);
+	src_q = v4l2_m2m_get_src_vq(inst->m2m_ctx);
+	dst_q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	if (vb2_is_streaming(src_q) && !vb2_is_streaming(dst_q))
+		ret &= (~EPOLLERR);
+
+	return ret;
+}
+
+static const struct v4l2_file_operations vdec_fops = {
+	.owner = THIS_MODULE,
+	.open = vdec_open,
+	.release = vpu_v4l2_close,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vdec_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+};
+
+int vdec_create_video_device(struct vpu_dev *vpu)
+{
+	struct video_device *vdec;
+	int ret;
+
+	if (!vpu)
+		return -EINVAL;
+
+	if (vpu->vdev_dec)
+		return 0;
+
+	vdec = video_device_alloc();
+	if (!vdec) {
+		vpu_err("alloc vpu decoder video device fail\n");
+		return -ENOMEM;
+	}
+	strscpy(vdec->name, "imx-vpu-decoder", sizeof(vdec->name));
+	vdec->release = video_device_release;
+	vdec->fops = &vdec_fops;
+	vdec->ioctl_ops = &vdec_ioctl_ops;
+	vdec->vfl_dir = VFL_DIR_M2M;
+	vdec->v4l2_dev = &vpu->v4l2_dev;
+	vdec->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
+
+	ret = video_register_device(vdec, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		video_device_release(vdec);
+		return ret;
+	}
+	video_set_drvdata(vdec, vpu);
+	vpu->vdev_dec = vdec;
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/venc.c b/drivers/media/platform/imx/vpu-8q/venc.c
new file mode 100644
index 000000000000..32af6ab5202c
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/venc.c
@@ -0,0 +1,1411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"ENC"
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/videodev2.h>
+#include <linux/ktime.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+#include <linux/imx_vpu.h>
+#include "vpu.h"
+#include "vpu_defs.h"
+#include "vpu_core.h"
+#include "vpu_helpers.h"
+#include "vpu_v4l2.h"
+#include "vpu_cmds.h"
+#include "vpu_rpc.h"
+#include "vpu_log.h"
+
+#define VENC_OUTPUT_ENABLE	(1 << 0)
+#define VENC_CAPTURE_ENABLE	(1 << 1)
+#define VENC_ENABLE_MASK	(VENC_OUTPUT_ENABLE | VENC_CAPTURE_ENABLE)
+#define VENC_MAX_BUF_CNT	8
+
+struct venc_t {
+	struct vpu_encode_params params;
+	u32 request_key_frame;
+	u32 input_ready;
+	u32 cpb_size;
+	bool bitrate_change;
+
+	struct vpu_buffer enc[VENC_MAX_BUF_CNT];
+	struct vpu_buffer ref[VENC_MAX_BUF_CNT];
+	struct vpu_buffer act[VENC_MAX_BUF_CNT];
+	struct list_head frames;
+	u32 frame_count;
+	u32 encode_count;
+	u32 ready_count;
+	u32 enable;
+	u32 stopped;
+
+	u32 skipped_count;
+	u32 skipped_bytes;
+
+	wait_queue_head_t wq;
+};
+
+struct venc_frame_t {
+	struct list_head list;
+	struct vpu_enc_pic_info info;
+	u32 bytesused;
+	s64 timestamp;
+};
+
+static const struct vpu_format venc_formats[] = {
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H264,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
+	},
+	{0, 0, 0, 0},
+};
+
+static int venc_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, "imx vpu encoder", sizeof(cap->driver));
+	strscpy(cap->card, "imx vpu encoder", sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: imx8q-vpu", sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_format *fmt;
+
+	memset(f->reserved, 0, sizeof(f->reserved));
+	fmt = vpu_helper_enum_format(inst, f->type, f->index);
+	if (!fmt)
+		return -EINVAL;
+
+	f->pixelformat = fmt->pixfmt;
+	f->flags = fmt->flags;
+	if (fmt->name && strlen(fmt->name))
+		strscpy(f->description, fmt->name, sizeof(f->description));
+
+	return 0;
+}
+
+static int venc_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	struct vpu_inst *inst = to_inst(file);
+
+	if (!fsize || fsize->index)
+		return -EINVAL;
+
+	if (!vpu_helper_find_format(inst, 0, fsize->pixel_format))
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise.max_width = inst->core->res->max_width;
+	fsize->stepwise.max_height = inst->core->res->max_height;
+	fsize->stepwise.min_width = inst->core->res->min_width;
+	fsize->stepwise.min_height = inst->core->res->min_height;
+	fsize->stepwise.step_width = inst->core->res->step_width;
+	fsize->stepwise.step_height = inst->core->res->step_height;
+
+	return 0;
+}
+
+static int venc_enum_frameintervals(struct file *file, void *fh, struct v4l2_frmivalenum *fival)
+{
+	struct vpu_inst *inst = to_inst(file);
+
+	if (!fival || fival->index)
+		return -EINVAL;
+
+	if (!vpu_helper_find_format(inst, 0, fival->pixel_format))
+		return -EINVAL;
+
+	if (!fival->width || !fival->height)
+		return -EINVAL;
+
+	if (fival->width < inst->core->res->min_width ||
+		fival->width > inst->core->res->max_width ||
+		fival->height < inst->core->res->min_height ||
+		fival->height > inst->core->res->max_height)
+		return -EINVAL;
+
+	fival->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
+	fival->stepwise.min.numerator = 1;
+	fival->stepwise.min.denominator = USHRT_MAX;
+	fival->stepwise.max.numerator = USHRT_MAX;
+	fival->stepwise.max.denominator = 1;
+	fival->stepwise.step.numerator = 1;
+	fival->stepwise.step.denominator = 1;
+
+	return 0;
+}
+
+static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	struct vpu_format *cur_fmt;
+	int i;
+
+	cur_fmt = vpu_get_format(inst, f->type);
+
+	pixmp->pixelformat = cur_fmt->pixfmt;
+	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->width = cur_fmt->width;
+	pixmp->height = cur_fmt->height;
+	pixmp->field = cur_fmt->field;
+	pixmp->flags = cur_fmt->flags;
+	for (i = 0; i < pixmp->num_planes; i++) {
+		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
+		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+	}
+
+	f->fmt.pix_mp.colorspace = venc->params.color.primaries;
+	f->fmt.pix_mp.xfer_func = venc->params.color.transfer;
+	f->fmt.pix_mp.ycbcr_enc = venc->params.color.matrix;
+	f->fmt.pix_mp.quantization = venc->params.color.full_range;
+
+	return 0;
+}
+
+static int venc_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+
+	vpu_try_fmt_common(inst, f);
+
+	return 0;
+}
+
+static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_format *fmt;
+	struct vpu_format *cur_fmt;
+	struct vb2_queue *q;
+	struct venc_t *venc = inst->priv;
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	int i;
+
+	q = v4l2_m2m_get_vq(inst->m2m_ctx, f->type);
+	if (!q)
+		return -EINVAL;
+	if (vb2_is_streaming(q))
+		return -EBUSY;
+
+	fmt = vpu_try_fmt_common(inst, f);
+	if (!fmt)
+		return -EINVAL;
+
+	cur_fmt = vpu_get_format(inst, f->type);
+
+	cur_fmt->pixfmt = fmt->pixfmt;
+	cur_fmt->num_planes = fmt->num_planes;
+	cur_fmt->type = fmt->type;
+	cur_fmt->flags = fmt->flags;
+	cur_fmt->width = pix_mp->width;
+	cur_fmt->height = pix_mp->height;
+	for (i = 0; i < fmt->num_planes; i++) {
+		cur_fmt->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
+		cur_fmt->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
+	}
+
+	if (pix_mp->field != V4L2_FIELD_ANY)
+		cur_fmt->field = pix_mp->field;
+
+	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
+		venc->params.input_format = cur_fmt->pixfmt;
+		venc->params.src_stride = cur_fmt->bytesperline[0];
+		venc->params.src_width = cur_fmt->width;
+		venc->params.src_height = cur_fmt->height;
+		venc->params.crop.left = 0;
+		venc->params.crop.top = 0;
+		venc->params.crop.width = cur_fmt->width;
+		venc->params.crop.height = cur_fmt->height;
+	} else {
+		venc->params.codec_format = cur_fmt->pixfmt;
+		venc->params.out_width = cur_fmt->width;
+		venc->params.out_height = cur_fmt->height;
+	}
+
+	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
+		if (!vpu_color_check_primaries(pix_mp->colorspace)) {
+			venc->params.color.primaries = pix_mp->colorspace;
+			vpu_color_get_default(venc->params.color.primaries,
+						&venc->params.color.transfer,
+						&venc->params.color.matrix,
+						&venc->params.color.full_range);
+		}
+		if (!vpu_color_check_transfers(pix_mp->xfer_func))
+			venc->params.color.transfer = pix_mp->xfer_func;
+		if (!vpu_color_check_matrix(pix_mp->ycbcr_enc))
+			venc->params.color.matrix = pix_mp->ycbcr_enc;
+		if (!vpu_color_check_full_range(pix_mp->quantization))
+			venc->params.color.full_range = pix_mp->quantization;
+	}
+
+	pix_mp->colorspace = venc->params.color.primaries;
+	pix_mp->xfer_func = venc->params.color.transfer;
+	pix_mp->ycbcr_enc = venc->params.color.matrix;
+	pix_mp->quantization = venc->params.color.full_range;
+
+	return 0;
+}
+
+static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+
+	if (!parm)
+		return -EINVAL;
+
+	if (!vpu_helper_check_type(inst, parm->type))
+		return -EINVAL;
+
+	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	parm->parm.capture.readbuffers = 0;
+	timeperframe->numerator = venc->params.frame_rate_num;
+	timeperframe->denominator = venc->params.frame_rate_den;
+
+	return 0;
+}
+
+static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+
+	if (!parm)
+		return -EINVAL;
+
+	if (!vpu_helper_check_type(inst, parm->type))
+		return -EINVAL;
+
+	if (!timeperframe->numerator)
+		timeperframe->numerator = venc->params.frame_rate_num;
+	if (!timeperframe->denominator)
+		timeperframe->denominator = venc->params.frame_rate_den;
+
+	venc->params.frame_rate_num = timeperframe->numerator;
+	venc->params.frame_rate_den = timeperframe->denominator;
+
+	vpu_helper_calc_coprime(&venc->params.frame_rate_num,
+				&venc->params.frame_rate_den);
+
+	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	memset(parm->parm.capture.reserved,
+			0, sizeof(parm->parm.capture.reserved));
+
+	return 0;
+}
+
+static int venc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->out_format.width;
+		s->r.height = inst->out_format.height;
+		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r = venc->params.crop;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int venc_valid_crop(struct venc_t *venc, struct vpu_core *core)
+{
+	struct v4l2_rect *rect = NULL;
+	u32 min_width;
+	u32 min_height;
+	u32 src_width;
+	u32 src_height;
+
+	rect = &venc->params.crop;
+	min_width = core->res->min_width;
+	min_height = core->res->min_height;
+	src_width = venc->params.src_width;
+	src_height = venc->params.src_height;
+
+	if (rect->width == 0 || rect->height == 0)
+		return -EINVAL;
+	if (rect->left > src_width - min_width ||
+		rect->top > src_height - min_height)
+		return -EINVAL;
+
+	rect->width = min(rect->width, src_width - rect->left);
+	rect->width = max_t(u32, rect->width, min_width);
+
+	rect->height = min(rect->height, src_height - rect->top);
+	rect->height = max_t(u32, rect->height, min_height);
+
+	return 0;
+}
+
+static int venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_core_resources *res = inst->core->res;
+	struct venc_t *venc = inst->priv;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+	if (s->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	venc->params.crop.left = ALIGN(s->r.left, res->step_width);
+	venc->params.crop.top = ALIGN(s->r.top, res->step_height);
+	venc->params.crop.width = ALIGN(s->r.width, res->step_width);
+	venc->params.crop.height = ALIGN(s->r.height, res->step_height);
+	if (venc_valid_crop(venc, inst->core)) {
+		venc->params.crop.left = 0;
+		venc->params.crop.top = 0;
+		venc->params.crop.width = venc->params.src_width;
+		venc->params.crop.height = venc->params.src_height;
+	}
+
+	inst->crop = venc->params.crop;
+
+	return 0;
+}
+
+static int venc_response_eos(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+	int ret;
+
+	if (inst->state != VPU_CODEC_STATE_DRAIN)
+		return 0;
+
+	if (v4l2_m2m_num_src_bufs_ready(inst->m2m_ctx))
+		return 0;
+
+	if (!venc->input_ready)
+		return 0;
+
+	venc->input_ready = false;
+	inst_dbg(inst, LVL_FLOW, "stop\n");
+	ret = vpu_session_stop(inst);
+	if (ret)
+		return ret;
+	inst->state = VPU_CODEC_STATE_STOP;
+	wake_up_all(&venc->wq);
+
+	return 0;
+}
+
+static int venc_request_eos(struct vpu_inst *inst)
+{
+	mutex_lock(&inst->lock);
+	inst->state = VPU_CODEC_STATE_DRAIN;
+	venc_response_eos(inst);
+	mutex_unlock(&inst->lock);
+
+	return 0;
+}
+
+static int venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
+{
+	int ret;
+
+	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
+	if (ret)
+		return ret;
+
+	if (cmd->cmd == V4L2_ENC_CMD_STOP) {
+		struct vpu_inst *inst = to_inst(file);
+
+		if (inst->state == VPU_CODEC_STATE_DEINIT)
+			vpu_notify_eos(inst);
+		else
+			venc_request_eos(inst);
+	}
+
+	return 0;
+}
+
+static int venc_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_ioctl_ops venc_ioctl_ops = {
+	.vidioc_querycap               = venc_querycap,
+	.vidioc_enum_fmt_vid_cap       = venc_enum_fmt,
+	.vidioc_enum_fmt_vid_out       = venc_enum_fmt,
+	.vidioc_enum_framesizes        = venc_enum_framesizes,
+	.vidioc_enum_frameintervals    = venc_enum_frameintervals,
+	.vidioc_g_fmt_vid_cap_mplane   = venc_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane   = venc_g_fmt,
+	.vidioc_try_fmt_vid_cap_mplane = venc_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane = venc_try_fmt,
+	.vidioc_s_fmt_vid_cap_mplane   = venc_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane   = venc_s_fmt,
+	.vidioc_g_parm                 = venc_g_parm,
+	.vidioc_s_parm                 = venc_s_parm,
+	.vidioc_g_selection            = venc_g_selection,
+	.vidioc_s_selection            = venc_s_selection,
+	.vidioc_try_encoder_cmd        = v4l2_m2m_ioctl_try_encoder_cmd,
+	.vidioc_encoder_cmd            = venc_encoder_cmd,
+	.vidioc_subscribe_event        = venc_subscribe_event,
+	.vidioc_unsubscribe_event      = v4l2_event_unsubscribe,
+	.vidioc_reqbufs                = vpu_v4l2_ioctl_reqbufs,
+	.vidioc_querybuf               = v4l2_m2m_ioctl_querybuf,
+	.vidioc_create_bufs	       = vpu_v4l2_ioctl_create_bufs,
+	.vidioc_prepare_buf	       = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_qbuf                   = vpu_v4l2_ioctl_qbuf,
+	.vidioc_expbuf                 = v4l2_m2m_ioctl_expbuf,
+	.vidioc_dqbuf                  = vpu_v4l2_ioctl_dqbuf,
+	.vidioc_streamon               = vpu_v4l2_ioctl_streamon,
+	.vidioc_streamoff              = vpu_v4l2_ioctl_streamoff,
+};
+
+static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_inst *inst = ctrl_to_inst(ctrl);
+	struct venc_t *venc = inst->priv;
+	int ret = 0;
+
+	mutex_lock(&inst->lock);
+	switch (ctrl->id) {
+	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
+		venc->params.profile = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
+		venc->params.level = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
+		venc->params.rc_mode = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_BITRATE:
+		if (ctrl->val != venc->params.bitrate)
+			venc->bitrate_change = true;
+		venc->params.bitrate = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_GOP_SIZE:
+		venc->params.gop_length = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_B_FRAMES:
+		venc->params.bframes = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP:
+		venc->params.i_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP:
+		venc->params.p_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP:
+		venc->params.b_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
+		venc->request_key_frame = 1;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE:
+		venc->cpb_size = ctrl->val * 1024;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
+		venc->params.sar.enable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC:
+		venc->params.sar.idc = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH:
+		venc->params.sar.width = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT:
+		venc->params.sar.height = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops venc_ctrl_ops = {
+	.s_ctrl = venc_op_s_ctrl,
+	.g_volatile_ctrl = vpu_helper_g_volatile_ctrl,
+};
+
+static int venc_ctrl_init(struct vpu_inst *inst)
+{
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 20);
+	if (ret)
+		return ret;
+
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+			~((1 << V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
+			  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
+			  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_HIGH)),
+			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
+
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_LEVEL,
+			V4L2_MPEG_VIDEO_H264_LEVEL_5_1,
+			0x0,
+			V4L2_MPEG_VIDEO_H264_LEVEL_4_0);
+
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
+			V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
+			0x0,
+			V4L2_MPEG_VIDEO_BITRATE_MODE_CBR);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_BITRATE,
+			BITRATE_MIN,
+			BITRATE_MAX,
+			BITRATE_STEP,
+			BITRATE_DEFAULT);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_GOP_SIZE, 0, (1 << 16) - 1, 1, 30);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_B_FRAMES, 0, 4, 1, 0);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP, 1, 51, 1, 26);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP, 1, 51, 1, 28);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP, 1, 51, 1, 30);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE, 64, 10240, 1, 1024);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE, 0, 1, 1, 1);
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC,
+			V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED,
+			0x0,
+			V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_1x1);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH,
+			0, USHRT_MAX, 1, 1);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT,
+			0, USHRT_MAX, 1, 1);
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_HEADER_MODE,
+			V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
+			~(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
+			V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
+
+	ret = v4l2_ctrl_handler_setup(&inst->ctrl_handler);
+	if (ret) {
+		inst_err(inst, "setup ctrls fail, ret = %d\n", ret);
+		v4l2_ctrl_handler_free(&inst->ctrl_handler);
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool venc_check_ready(struct vpu_inst *inst, unsigned int type)
+{
+	struct venc_t *venc = inst->priv;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (vpu_helper_get_free_space(inst) < venc->cpb_size)
+			return false;
+		return venc->input_ready;
+	}
+
+	return true;
+}
+
+static u32 venc_get_enable_mask(u32 type)
+{
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return VENC_OUTPUT_ENABLE;
+	else
+		return VENC_CAPTURE_ENABLE;
+}
+
+static void venc_set_enable(struct venc_t *venc, u32 type, int enable)
+{
+	u32 mask = venc_get_enable_mask(type);
+
+	if (enable)
+		venc->enable |= mask;
+	else
+		venc->enable &= ~mask;
+}
+
+static u32 venc_get_enable(struct venc_t *venc, u32 type)
+{
+	return venc->enable & venc_get_enable_mask(type);
+}
+
+static void venc_input_done(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+
+	mutex_lock(&inst->lock);
+	venc->input_ready = true;
+	vpu_process_output_buffer(inst);
+	venc_response_eos(inst);
+	mutex_unlock(&inst->lock);
+}
+
+/*
+ * It's hardware limitation, that there may be several bytes
+ * redundant data at the beginning of frame.
+ * For android platform, the redundant data may cause cts test fail
+ * So driver will strip them
+ */
+static int venc_precheck_encoded_frame(struct vpu_inst *inst, struct venc_frame_t *frame)
+{
+	struct venc_t *venc;
+	int skipped;
+
+	if (!inst || !frame || !frame->bytesused)
+		return -EINVAL;
+
+	venc = inst->priv;
+	skipped = vpu_helper_find_startcode(&inst->stream_buffer,
+				inst->cap_format.pixfmt,
+				frame->info.wptr - inst->stream_buffer.phys,
+				frame->bytesused);
+	if (skipped > 0) {
+		frame->bytesused -= skipped;
+		frame->info.wptr = vpu_helper_step_walk(&inst->stream_buffer,
+						frame->info.wptr, skipped);
+		venc->skipped_bytes += skipped;
+		venc->skipped_count++;
+	}
+
+	return 0;
+}
+
+static int venc_get_one_encoded_frame(struct vpu_inst *inst,
+					struct venc_frame_t *frame,
+					struct vb2_v4l2_buffer *vbuf)
+{
+	struct venc_t *venc = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+
+	if (!vbuf)
+		return -EAGAIN;
+
+	if (!venc_get_enable(inst->priv, vbuf->vb2_buf.type)) {
+		inst_dbg(inst, LVL_DEBUG,
+				"type %d is disabled, frame sequence %d\n",
+				vbuf->vb2_buf.type, frame->info.frame_id);
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return 0;
+	}
+	vpu_buf = to_vpu_vb2_buffer(vbuf);
+	if (frame->bytesused > vbuf->vb2_buf.planes[0].length) {
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return -ENOMEM;
+	}
+
+	venc_precheck_encoded_frame(inst, frame);
+
+	if (frame->bytesused) {
+		u32 rptr = frame->info.wptr;
+		void *dst = vb2_plane_vaddr(&vbuf->vb2_buf, 0);
+
+		vpu_helper_copy_from_stream_buffer(&inst->stream_buffer,
+			&rptr, frame->bytesused, dst);
+		vpu_iface_update_stream_buffer(inst, rptr, 0);
+	}
+	vb2_set_plane_payload(&vbuf->vb2_buf, 0, frame->bytesused);
+	vbuf->sequence = frame->info.frame_id;
+	vbuf->vb2_buf.timestamp = frame->info.timestamp;
+	vbuf->flags |= frame->info.pic_type;
+	vpu_buf->state = VPU_BUF_STATE_IDLE;
+	inst_dbg(inst, LVL_TS, "[OUTPUT TS]%32lld\n", frame->info.timestamp);
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+	venc->ready_count++;
+
+	if (vbuf->flags & V4L2_BUF_FLAG_KEYFRAME)
+		inst_dbg(inst, LVL_DEBUG, "[%d]Iframe\n", frame->info.frame_id);
+
+	return 0;
+}
+
+static int venc_get_encoded_frames(struct vpu_inst *inst)
+{
+	struct venc_t *venc;
+	struct venc_frame_t *frame;
+	struct venc_frame_t *tmp;
+
+	if (!inst || !inst->priv)
+		return -EINVAL;
+
+	venc = inst->priv;
+	list_for_each_entry_safe(frame, tmp, &venc->frames, list) {
+		if (venc_get_one_encoded_frame(inst, frame,
+					v4l2_m2m_dst_buf_remove(inst->m2m_ctx)))
+			break;
+		list_del_init(&frame->list);
+		vfree(frame);
+	}
+
+	return 0;
+}
+
+static int venc_frame_encoded(struct vpu_inst *inst, void *arg)
+{
+	struct vpu_enc_pic_info *info = arg;
+	struct venc_frame_t *frame;
+	struct venc_t *venc;
+	int ret = 0;
+
+	if (!inst || !info)
+		return -EINVAL;
+	venc = inst->priv;
+	frame = vzalloc(sizeof(*frame));
+	if (!frame)
+		return -ENOMEM;
+
+	memcpy(&frame->info, info, sizeof(frame->info));
+	frame->bytesused = info->frame_size;
+
+	mutex_lock(&inst->lock);
+	list_add_tail(&frame->list, &venc->frames);
+	venc->encode_count++;
+	venc_get_encoded_frames(inst);
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static void venc_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
+{
+	struct vb2_v4l2_buffer *vbuf;
+	struct vpu_vb2_buffer *vpu_buf;
+
+	if (!inst || !frame)
+		return;
+
+	inst_dbg(inst, LVL_DEBUG, "buf done : type = %d, sequence = %d\n",
+			frame->type, frame->sequence);
+
+	mutex_lock(&inst->lock);
+	if (!venc_get_enable(inst->priv, frame->type)) {
+		inst_dbg(inst, LVL_DEBUG,
+				"type %d is disabled, frame sequence %d\n",
+				frame->type, frame->sequence);
+		goto exit;
+	}
+	vbuf = vpu_find_buf_by_sequence(inst, frame->type, frame->sequence);
+	if (!vbuf) {
+		inst_err(inst, "can't find buf: type %d, sequence %d\n",
+				frame->type, frame->sequence);
+		goto exit;
+	}
+
+	vpu_buf = to_vpu_vb2_buffer(vbuf);
+	vpu_buf->state = VPU_BUF_STATE_IDLE;
+	if (V4L2_TYPE_IS_OUTPUT(frame->type))
+		v4l2_m2m_src_buf_remove_by_buf(inst->m2m_ctx, vbuf);
+	else
+		v4l2_m2m_dst_buf_remove_by_buf(inst->m2m_ctx, vbuf);
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+exit:
+	mutex_unlock(&inst->lock);
+}
+
+static int venc_append_empty_frame(struct vpu_inst *inst)
+{
+	struct venc_frame_t *frame;
+	struct venc_t *venc;
+
+	if (!inst || !inst->priv)
+		return -EINVAL;
+
+	venc = inst->priv;
+	frame = vzalloc(sizeof(*frame));
+	if (!frame)
+		return -ENOMEM;
+
+	frame->bytesused = 0;
+	frame->info.pic_type = V4L2_BUF_FLAG_LAST;
+	frame->info.frame_id = inst->sequence;
+
+	mutex_lock(&inst->lock);
+	list_add_tail(&frame->list, &venc->frames);
+	venc_get_encoded_frames(inst);
+	mutex_unlock(&inst->lock);
+
+	return 0;
+}
+
+static void venc_stop_done(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+
+	inst_dbg(inst, LVL_FLOW, "append empty frame\n");
+	venc_append_empty_frame(inst);
+
+	mutex_lock(&inst->lock);
+	venc->stopped = true;
+	mutex_unlock(&inst->lock);
+
+	wake_up_all(&venc->wq);
+}
+
+static void venc_event_notify(struct vpu_inst *inst, u32 event, void *data)
+{
+}
+
+static void venc_release(struct vpu_inst *inst)
+{
+}
+
+static void venc_cleanup(struct vpu_inst *inst)
+{
+	struct venc_t *venc;
+
+	if (!inst)
+		return;
+
+	venc = inst->priv;
+	if (venc)
+		vfree(venc);
+	inst->priv = NULL;
+	vfree(inst);
+}
+
+static int venc_start_session(struct vpu_inst *inst, u32 type)
+{
+	struct venc_t *venc = inst->priv;
+	int stream_buffer_size;
+	int ret;
+
+	mutex_lock(&inst->lock);
+	venc_set_enable(venc, type, 1);
+	if ((venc->enable & VENC_ENABLE_MASK) != VENC_ENABLE_MASK) {
+		mutex_unlock(&inst->lock);
+		return 0;
+	}
+	mutex_unlock(&inst->lock);
+
+	vpu_iface_init_instance(inst);
+	stream_buffer_size = vpu_iface_get_stream_buffer_size(inst->core);
+	if (stream_buffer_size > 0) {
+		inst->stream_buffer.length = max_t(u32, stream_buffer_size, venc->cpb_size * 3);
+		ret = vpu_alloc_dma(inst->core, &inst->stream_buffer);
+		if (ret)
+			goto error;
+
+		inst->use_stream_buffer = true;
+		vpu_iface_config_stream_buffer(inst, &inst->stream_buffer);
+	}
+
+	ret = vpu_iface_set_encode_params(inst, &venc->params, 0);
+	if (ret)
+		goto error;
+	ret = vpu_session_configure_codec(inst);
+	if (ret)
+		goto error;
+
+	inst->state = VPU_CODEC_STATE_CONFIGURED;
+	/*vpu_iface_config_memory_resource*/
+
+	/*config enc expert mode parameter*/
+	ret = vpu_iface_set_encode_params(inst, &venc->params, 1);
+	if (ret)
+		goto error;
+
+	ret = vpu_session_start(inst);
+	if (ret)
+		goto error;
+	inst->state = VPU_CODEC_STATE_STARTED;
+
+	mutex_lock(&inst->lock);
+	venc->bitrate_change = false;
+	venc->input_ready = true;
+	venc->frame_count = 0;
+	venc->encode_count = 0;
+	venc->ready_count = 0;
+	venc->stopped = false;
+	vpu_process_output_buffer(inst);
+	if (venc->frame_count == 0)
+		inst_err(inst, "there is no input when starting\n");
+	mutex_unlock(&inst->lock);
+
+	return 0;
+error:
+	mutex_lock(&inst->lock);
+	venc_set_enable(venc, type, 0);
+	inst->state = VPU_CODEC_STATE_DEINIT;
+	mutex_unlock(&inst->lock);
+
+	vpu_free_dma(&inst->stream_buffer);
+	return ret;
+}
+
+static void venc_cleanup_mem_resource(struct vpu_inst *inst)
+{
+	struct venc_t *venc;
+	u32 i;
+
+	WARN_ON(!inst || !inst->priv || !inst->core);
+
+	venc = inst->priv;
+
+	for (i = 0; i < ARRAY_SIZE(venc->enc); i++)
+		vpu_free_dma(&venc->enc[i]);
+	for (i = 0; i < ARRAY_SIZE(venc->ref); i++)
+		vpu_free_dma(&venc->ref[i]);
+	for (i = 0; i < ARRAY_SIZE(venc->act); i++)
+		vpu_free_dma(&venc->act[i]);
+}
+
+static void venc_request_mem_resource(struct vpu_inst *inst,
+				u32 enc_frame_size,
+				u32 enc_frame_num,
+				u32 ref_frame_size,
+				u32 ref_frame_num,
+				u32 act_frame_size,
+				u32 act_frame_num)
+{
+	struct venc_t *venc;
+	u32 i;
+	int ret;
+
+	WARN_ON(!inst || !inst->priv || !inst->core);
+
+	venc = inst->priv;
+
+	if (enc_frame_num > ARRAY_SIZE(venc->enc)) {
+		inst_err(inst, "enc num(%d) is out of range\n", enc_frame_num);
+		return;
+	}
+	if (ref_frame_num > ARRAY_SIZE(venc->ref)) {
+		inst_err(inst, "ref num(%d) is out of range\n", ref_frame_num);
+		return;
+	}
+	if (act_frame_num > ARRAY_SIZE(venc->act)) {
+		inst_err(inst, "act num(%d) is out of range\n", act_frame_num);
+		return;
+	}
+
+	for (i = 0; i < enc_frame_num; i++) {
+		venc->enc[i].length = enc_frame_size;
+		ret = vpu_alloc_dma(inst->core, &venc->enc[i]);
+		if (ret) {
+			venc_cleanup_mem_resource(inst);
+			return;
+		}
+	}
+	for (i = 0; i < ref_frame_num; i++) {
+		venc->ref[i].length = ref_frame_size;
+		ret = vpu_alloc_dma(inst->core, &venc->ref[i]);
+		if (ret) {
+			venc_cleanup_mem_resource(inst);
+			return;
+		}
+	}
+	for (i = 0; i < act_frame_num; i++) {
+		venc->act[i].length = act_frame_size;
+		ret = vpu_alloc_reserved_dma(inst->core, &venc->act[i]);
+		if (ret) {
+			venc_cleanup_mem_resource(inst);
+			return;
+		}
+	}
+
+	for (i = 0; i < enc_frame_num; i++)
+		vpu_iface_config_memory_resource(inst, MEM_RES_ENC, i, &venc->enc[i]);
+	for (i = 0; i < ref_frame_num; i++)
+		vpu_iface_config_memory_resource(inst, MEM_RES_REF, i, &venc->ref[i]);
+	for (i = 0; i < act_frame_num; i++)
+		vpu_iface_config_memory_resource(inst, MEM_RES_ACT, i, &venc->act[i]);
+}
+
+static void venc_cleanup_frames(struct venc_t *venc)
+{
+	struct venc_frame_t *frame;
+	struct venc_frame_t *tmp;
+
+	if (!list_empty(&venc->frames))
+		vpu_dbg(LVL_DEBUG, "Warning some encoded frames are dropped\n");
+
+	list_for_each_entry_safe(frame, tmp, &venc->frames, list) {
+		list_del_init(&frame->list);
+		vfree(frame);
+	}
+}
+
+static int venc_stop_session(struct vpu_inst *inst, u32 type)
+{
+	struct venc_t *venc = inst->priv;
+
+	mutex_lock(&inst->lock);
+	venc_set_enable(venc, type, 0);
+	if (venc->enable & VENC_ENABLE_MASK) {
+		mutex_unlock(&inst->lock);
+		return 0;
+	}
+	mutex_unlock(&inst->lock);
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	if (inst->state != VPU_CODEC_STATE_STOP)
+		venc_request_eos(inst);
+
+	if (!wait_event_timeout(venc->wq, venc->stopped, VPU_TIMEOUT)) {
+		set_bit(inst->id, &inst->core->hang_mask);
+		vpu_session_debug(inst);
+	}
+
+	inst->state = VPU_CODEC_STATE_DEINIT;
+
+	mutex_lock(&inst->lock);
+	venc_cleanup_frames(inst->priv);
+	mutex_unlock(&inst->lock);
+
+	vpu_free_dma(&inst->stream_buffer);
+	venc_cleanup_mem_resource(inst);
+
+	return 0;
+}
+
+static int venc_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct venc_t *venc = inst->priv;
+	struct vb2_v4l2_buffer *vbuf;
+	struct vpu_vb2_buffer *vpu_buf = NULL;
+	u32 flags;
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return -EINVAL;
+
+	vbuf = to_vb2_v4l2_buffer(vb);
+	vpu_buf = to_vpu_vb2_buffer(vbuf);
+	if (inst->state == VPU_CODEC_STATE_STARTED)
+		inst->state = VPU_CODEC_STATE_ACTIVE;
+
+	flags = vbuf->flags;
+	if (venc->request_key_frame) {
+		vbuf->flags |= V4L2_BUF_FLAG_KEYFRAME;
+		venc->request_key_frame = 0;
+	}
+	if (venc->bitrate_change) {
+		vpu_session_update_parameters(inst, &venc->params);
+		venc->bitrate_change = false;
+	}
+	inst_dbg(inst, LVL_TS, "[INPUT  TS]%32lld\n", vb->timestamp);
+	vpu_iface_input_frame(inst, vb);
+	vbuf->flags = flags;
+	venc->input_ready = false;
+	venc->frame_count++;
+	vpu_buf->state = VPU_BUF_STATE_INUSE;
+
+	return 0;
+}
+
+static int venc_process_capture(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct venc_t *venc;
+	struct venc_frame_t *frame = NULL;
+	struct vb2_v4l2_buffer *vbuf;
+	int ret;
+
+	venc = inst->priv;
+	if (list_empty(&venc->frames))
+		return -EINVAL;
+
+	frame = list_first_entry(&venc->frames, struct venc_frame_t, list);
+	vbuf = to_vb2_v4l2_buffer(vb);
+	v4l2_m2m_dst_buf_remove_by_buf(inst->m2m_ctx, vbuf);
+	ret = venc_get_one_encoded_frame(inst, frame, vbuf);
+	if (ret)
+		return ret;
+
+	list_del_init(&frame->list);
+	vfree(frame);
+	return 0;
+}
+
+static int venc_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i)
+{
+	struct venc_t *venc = inst->priv;
+	int num = -1;
+
+	switch (i) {
+	case 0:
+		num = scnprintf(str, size, "profile = %d\n", venc->params.profile);
+		break;
+	case 1:
+		num = scnprintf(str, size, "level = %d\n", venc->params.level);
+		break;
+	case 2:
+		num = scnprintf(str, size, "fps = %d/%d\n",
+				venc->params.frame_rate_num,
+				venc->params.frame_rate_den);
+		break;
+	case 3:
+		num = scnprintf(str, size, "%d x %d -> %d x %d\n",
+				venc->params.src_width,
+				venc->params.src_height,
+				venc->params.out_width,
+				venc->params.out_height);
+		break;
+	case 4:
+		num = scnprintf(str, size, "(%d, %d)  %d x %d\n",
+				venc->params.crop.left,
+				venc->params.crop.top,
+				venc->params.crop.width,
+				venc->params.crop.height);
+		break;
+	case 5:
+		num = scnprintf(str, size,
+				"enable = 0x%x, input = %d, encode = %d, ready = %d, stopped = %d\n",
+				venc->enable,
+				venc->frame_count, venc->encode_count,
+				venc->ready_count,
+				venc->stopped);
+		break;
+	case 6:
+		num = scnprintf(str, size, "gop = %d\n", venc->params.gop_length);
+		break;
+	case 7:
+		num = scnprintf(str, size, "bframes = %d\n", venc->params.bframes);
+		break;
+	case 8:
+		num = scnprintf(str, size, "rc: mode = %d, bitrate = %d, qp = %d\n",
+				venc->params.rc_mode,
+				venc->params.bitrate,
+				venc->params.i_frame_qp);
+		break;
+	case 9:
+		num = scnprintf(str, size, "sar: enable = %d, idc = %d, %d x %d\n",
+				venc->params.sar.enable,
+				venc->params.sar.idc,
+				venc->params.sar.width,
+				venc->params.sar.height);
+
+		break;
+	case 10:
+		num = scnprintf(str, size,
+				"colorspace: primaries = %d, transfer = %d, matrix = %d, full_range = %d\n",
+				venc->params.color.primaries,
+				venc->params.color.transfer,
+				venc->params.color.matrix,
+				venc->params.color.full_range);
+		break;
+	case 11:
+		num = scnprintf(str, size, "skipped: count = %d, bytes = %d\n",
+				venc->skipped_count, venc->skipped_bytes);
+		break;
+	default:
+		break;
+	}
+
+	return num;
+}
+
+static struct vpu_inst_ops venc_inst_ops = {
+	.ctrl_init = venc_ctrl_init,
+	.check_ready = venc_check_ready,
+	.input_done = venc_input_done,
+	.get_one_frame = venc_frame_encoded,
+	.buf_done = venc_buf_done,
+	.stop_done = venc_stop_done,
+	.event_notify = venc_event_notify,
+	.release = venc_release,
+	.cleanup = venc_cleanup,
+	.start = venc_start_session,
+	.mem_request = venc_request_mem_resource,
+	.stop = venc_stop_session,
+	.process_output = venc_process_output,
+	.process_capture = venc_process_capture,
+	.get_debug_info = venc_get_debug_info,
+};
+
+static void venc_init(struct file *file)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc;
+	struct v4l2_format f;
+	struct v4l2_streamparm parm;
+
+	venc = inst->priv;
+	venc->params.qp_min = 1;
+	venc->params.qp_max = 51;
+	venc->params.qp_min_i = 1;
+	venc->params.qp_max_i = 51;
+	venc->params.bitrate_max = BITRATE_MAX;
+	venc->params.bitrate_min = BITRATE_MIN;
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f.fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	venc_s_fmt(file, &inst->fh, &f);
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	venc_s_fmt(file, &inst->fh, &f);
+
+	memset(&parm, 0, sizeof(parm));
+	parm.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	parm.parm.capture.timeperframe.numerator = 1;
+	parm.parm.capture.timeperframe.denominator = 30;
+	venc_s_parm(file, &inst->fh, &parm);
+}
+
+int venc_open(struct file *file)
+{
+	struct vpu_inst *inst;
+	struct venc_t *venc;
+	int ret;
+
+	inst = vzalloc(sizeof(*inst));
+	if (!inst)
+		return -ENOMEM;
+
+	venc = vzalloc(sizeof(*venc));
+	if (!venc) {
+		vfree(inst);
+		return -ENOMEM;
+	}
+
+	inst->ops = &venc_inst_ops;
+	inst->formats = venc_formats;
+	inst->type = VPU_CORE_TYPE_ENC;
+	inst->priv = venc;
+	INIT_LIST_HEAD(&venc->frames);
+	init_waitqueue_head(&venc->wq);
+
+	ret = vpu_v4l2_open(file, inst);
+	if (ret) {
+		vfree(venc);
+		vfree(inst);
+		return ret;
+	}
+
+	venc_init(file);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations venc_fops = {
+	.owner = THIS_MODULE,
+	.open = venc_open,
+	.release = vpu_v4l2_close,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = v4l2_m2m_fop_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+};
+
+int venc_create_video_device(struct vpu_dev *vpu)
+{
+	struct video_device *venc;
+	int ret;
+
+	if (!vpu)
+		return -EINVAL;
+
+	if (vpu->vdev_enc)
+		return 0;
+
+	venc = video_device_alloc();
+	if (!venc) {
+		vpu_err("alloc vpu encoder video device fail\n");
+		return -ENOMEM;
+	}
+	strscpy(venc->name, "imx-vpu-encoder", sizeof(venc->name));
+	venc->release = video_device_release;
+	venc->fops = &venc_fops;
+	venc->ioctl_ops = &venc_ioctl_ops;
+	venc->vfl_dir = VFL_DIR_M2M;
+	venc->v4l2_dev = &vpu->v4l2_dev;
+	venc->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
+
+	ret = video_register_device(venc, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		video_device_release(venc);
+		return ret;
+	}
+	video_set_drvdata(venc, vpu);
+	vpu->vdev_enc = venc;
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu.h b/drivers/media/platform/imx/vpu-8q/vpu.h
new file mode 100644
index 000000000000..af82e4bec108
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_H
+#define _IMX_VPU_H
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-mem2mem.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+#include <linux/kfifo.h>
+
+#define VPU_TIMEOUT		msecs_to_jiffies(1000)
+#define VPU_INST_NULL_ID	(-1L)
+#define VPU_MSG_BUFFER_SIZE	(8192)
+
+enum imx_plat_type {
+	IMX8QXP = 0,
+	IMX8QM  = 1,
+	IMX8DM,
+	IMX8DX,
+	PLAT_TYPE_RESERVED
+};
+
+enum vpu_core_type {
+	VPU_CORE_TYPE_ENC = 0,
+	VPU_CORE_TYPE_DEC = 0x10,
+};
+
+struct vpu_dev;
+struct vpu_resources {
+	enum imx_plat_type plat_type;
+	u32 mreg_base;
+	int (*setup)(struct vpu_dev *vpu);
+	int (*setup_encoder)(struct vpu_dev *vpu);
+	int (*setup_decoder)(struct vpu_dev *vpu);
+	int (*reset)(struct vpu_dev *vpu);
+};
+
+struct vpu_buffer {
+	void *virt;
+	dma_addr_t phys;
+	u32 length;
+	u32 bytesused;
+	struct device *dev;
+};
+
+struct vpu_dev {
+	void __iomem *base;
+	struct platform_device *pdev;
+	struct device *dev;
+	struct mutex lock;
+	const struct vpu_resources *res;
+	struct list_head cores;
+	struct vpu_buffer memory;
+
+	struct v4l2_device v4l2_dev;
+	struct video_device *vdev_dec;
+	struct video_device *vdev_enc;
+
+	struct delayed_work watchdog_work;
+	void (*get_vpu)(struct vpu_dev *vpu);
+	void (*put_vpu)(struct vpu_dev *vpu);
+	void (*get_enc)(struct vpu_dev *vpu);
+	void (*put_enc)(struct vpu_dev *vpu);
+	void (*get_dec)(struct vpu_dev *vpu);
+	void (*put_dec)(struct vpu_dev *vpu);
+	atomic_t ref_vpu;
+	atomic_t ref_enc;
+	atomic_t ref_dec;
+
+	struct dentry *debugfs;
+};
+
+struct vpu_format {
+	const char *name;
+	u32 pixfmt;
+	unsigned int num_planes;
+	u32 type;
+	u32 flags;
+	u32 width;
+	u32 height;
+	u32 sizeimage[VIDEO_MAX_PLANES];
+	u32 bytesperline[VIDEO_MAX_PLANES];
+	u32 field;
+};
+
+struct vpu_core_resources {
+	enum vpu_core_type type;
+	const char *fwname;
+	u32 stride;
+	u32 max_width;
+	u32 min_width;
+	u32 step_width;
+	u32 max_height;
+	u32 min_height;
+	u32 step_height;
+	bool use_reserved_mem;
+	bool standalone;
+};
+
+struct vpu_mbox {
+	char name[20];
+	struct mbox_client cl;
+	struct mbox_chan *ch;
+	bool block;
+};
+
+enum vpu_core_state {
+	VPU_CORE_DEINIT = 0,
+	VPU_CORE_ACTIVE,
+	VPU_CORE_SNAPSHOT,
+	VPU_CORE_HANG
+};
+
+struct vpu_core {
+	void __iomem *base;
+	struct platform_device *pdev;
+	struct device *dev;
+	struct device *parent;
+	struct device *pd;
+	struct device_link *pd_link;
+	struct mutex lock;
+	struct mutex cmd_lock;
+	struct list_head list;
+	enum vpu_core_type type;
+	u32 id;
+	const struct vpu_core_resources *res;
+	unsigned long instance_mask;
+	u32 supported_instance_count;
+	unsigned long hang_mask;
+	u32 request_count;
+	struct list_head instances;
+	enum vpu_core_state state;
+	u32 fw_version;
+
+	struct vpu_buffer fw;
+	struct vpu_buffer rpc;
+	struct vpu_buffer log;
+
+	struct vpu_mbox tx_type;
+	struct vpu_mbox tx_data;
+	struct vpu_mbox rx;
+	unsigned long cmd_seq;
+
+	wait_queue_head_t ack_wq;
+	struct completion cmp;
+	struct workqueue_struct *workqueue;
+	struct work_struct msg_work;
+	struct delayed_work msg_delayed_work;
+	struct kfifo msg_fifo;
+	void *msg_buffer;
+	unsigned int msg_buffer_size;
+
+	struct vpu_dev *vpu;
+	void *iface;
+
+	struct dentry *debugfs;
+	struct dentry *debugfs_fwlog;
+};
+
+enum vpu_codec_state {
+	VPU_CODEC_STATE_DEINIT = 1,
+	VPU_CODEC_STATE_CONFIGURED,
+	VPU_CODEC_STATE_START,
+	VPU_CODEC_STATE_STARTED,
+	VPU_CODEC_STATE_ACTIVE,
+	VPU_CODEC_STATE_SEEK,
+	VPU_CODEC_STATE_STOP,
+	VPU_CODEC_STATE_DRAIN,
+	VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE,
+};
+
+struct vpu_frame_info {
+	u32 type;
+	u32 id;
+	u32 sequence;
+	u32 luma;
+	u32 chroma_u;
+	u32 chroma_v;
+	u32 data_offset;
+	u32 flags;
+	u32 skipped;
+	s64 timestamp;
+};
+
+struct vpu_inst;
+struct vpu_inst_ops {
+	int (*ctrl_init)(struct vpu_inst *inst);
+	int (*start)(struct vpu_inst *inst, u32 type);
+	int (*stop)(struct vpu_inst *inst, u32 type);
+	int (*abort)(struct vpu_inst *inst);
+	bool (*check_ready)(struct vpu_inst *inst, unsigned int type);
+	void (*buf_done)(struct vpu_inst *inst, struct vpu_frame_info *frame);
+	void (*event_notify)(struct vpu_inst *inst, u32 event, void *data);
+	void (*release)(struct vpu_inst *inst);
+	void (*cleanup)(struct vpu_inst *inst);
+	void (*mem_request)(struct vpu_inst *inst,
+				u32 enc_frame_size,
+				u32 enc_frame_num,
+				u32 ref_frame_size,
+				u32 ref_frame_num,
+				u32 act_frame_size,
+				u32 act_frame_num);
+	void (*input_done)(struct vpu_inst *inst);
+	void (*stop_done)(struct vpu_inst *inst);
+	int (*process_output)(struct vpu_inst *inst, struct vb2_buffer *vb);
+	int (*process_capture)(struct vpu_inst *inst, struct vb2_buffer *vb);
+	int (*get_one_frame)(struct vpu_inst *inst, void *info);
+	void (*on_queue_empty)(struct vpu_inst *inst, u32 type);
+	int (*get_debug_info)(struct vpu_inst *inst, char *str, u32 size, u32 i);
+};
+
+struct vpu_inst {
+	struct list_head list;
+	struct mutex lock;
+	struct mutex ioctl_sync;
+	struct vpu_core *core;
+	int id;
+
+	struct v4l2_fh fh;
+	struct v4l2_m2m_dev *m2m_dev;
+	struct v4l2_m2m_ctx *m2m_ctx;
+	struct v4l2_ctrl_handler ctrl_handler;
+	atomic_t ref_count;
+	int (*release)(struct vpu_inst *inst);
+
+	enum vpu_codec_state state;
+	enum vpu_core_type type;
+
+	struct workqueue_struct *workqueue;
+	struct work_struct msg_work;
+	struct kfifo msg_fifo;
+	u8 msg_buffer[VPU_MSG_BUFFER_SIZE];
+
+	struct vpu_buffer stream_buffer;
+	bool use_stream_buffer;
+
+	struct list_head cmd_q;
+	void *pending;
+
+	struct vpu_inst_ops *ops;
+	const struct vpu_format *formats;
+	struct vpu_format out_format;
+	struct vpu_format cap_format;
+	u32 min_buffer_cap;
+	u32 min_buffer_out;
+
+	struct v4l2_rect crop;
+	u32 colorspace;
+	u8 ycbcr_enc;
+	u8 quantization;
+	u8 xfer_func;
+	u32 sequence;
+	u32 extra_size;
+
+	u32 flows[16];
+	u32 flow_idx;
+
+	pid_t pid;
+	pid_t tgid;
+	struct dentry *debugfs;
+
+	void *priv;
+};
+
+#define call_vop(inst, op, args...)					\
+	((inst)->ops->op ? (inst)->ops->op(inst, ##args) : 0)		\
+
+enum {
+	VPU_BUF_STATE_IDLE = 0,
+	VPU_BUF_STATE_INUSE,
+	VPU_BUF_STATE_DECODED,
+	VPU_BUF_STATE_READY,
+	VPU_BUF_STATE_SKIP,
+	VPU_BUF_STATE_ERROR
+};
+
+struct vpu_vb2_buffer {
+	struct v4l2_m2m_buffer m2m_buf;
+	dma_addr_t luma;
+	dma_addr_t chroma_u;
+	dma_addr_t chroma_v;
+	unsigned int state;
+	u32 tag;
+};
+
+void vpu_writel(struct vpu_dev *vpu, u32 reg, u32 val);
+u32 vpu_readl(struct vpu_dev *vpu, u32 reg);
+
+static inline struct vpu_vb2_buffer *to_vpu_vb2_buffer(struct vb2_v4l2_buffer *vbuf)
+{
+	struct v4l2_m2m_buffer *m2m_buf = container_of(vbuf, struct v4l2_m2m_buffer, vb);
+
+	return container_of(m2m_buf, struct vpu_vb2_buffer, m2m_buf);
+}
+
+static inline const char *vpu_core_type_desc(enum vpu_core_type type)
+{
+	return type == VPU_CORE_TYPE_ENC ? "encoder" : "decoder";
+}
+
+static inline struct vpu_inst *to_inst(struct file *filp)
+{
+	return container_of(filp->private_data, struct vpu_inst, fh);
+}
+
+#define ctrl_to_inst(ctrl)	\
+	container_of((ctrl)->handler, struct vpu_inst, ctrl_handler)
+
+int venc_create_video_device(struct vpu_dev *vpu);
+int vdec_create_video_device(struct vpu_dev *vpu);
+
+struct vpu_inst *vpu_inst_get(struct vpu_inst *inst);
+void vpu_inst_put(struct vpu_inst *inst);
+struct vpu_core *vpu_request_core(struct vpu_dev *vpu, enum vpu_core_type type);
+void vpu_release_core(struct vpu_core *core);
+int vpu_inst_register(struct vpu_inst *inst);
+int vpu_inst_unregister(struct vpu_inst *inst);
+
+int vpu_inst_create_dbgfs_file(struct vpu_inst *inst);
+int vpu_inst_remove_dbgfs_file(struct vpu_inst *inst);
+int vpu_core_create_dbgfs_file(struct vpu_core *core);
+int vpu_core_remove_dbgfs_file(struct vpu_core *core);
+void vpu_inst_record_flow(struct vpu_inst *inst, u32 flow);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_cmds.c b/drivers/media/platform/imx/vpu-8q/vpu_cmds.c
new file mode 100644
index 000000000000..eb4c2bb08451
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_cmds.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#define TAG		"CMD"
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/vmalloc.h>
+#include "vpu.h"
+#include "vpu_defs.h"
+#include "vpu_cmds.h"
+#include "vpu_rpc.h"
+#include "vpu_mbox.h"
+#include "vpu_log.h"
+
+struct vpu_cmd_request {
+	u32 request;
+	u32 response;
+	u32 handled;
+};
+
+struct vpu_cmd_t {
+	struct list_head list;
+	u32 id;
+	struct vpu_cmd_request *request;
+	struct vpu_rpc_event *pkt;
+	unsigned long key;
+};
+
+static struct vpu_cmd_request vpu_cmd_requests[] = {
+	{
+		.request = VPU_CMD_ID_CONFIGURE_CODEC,
+		.response = VPU_MSG_ID_MEM_REQUEST,
+		.handled = 1,
+	},
+	{
+		.request = VPU_CMD_ID_START,
+		.response = VPU_MSG_ID_START_DONE,
+		.handled = 0,
+	},
+	{
+		.request = VPU_CMD_ID_STOP,
+		.response = VPU_MSG_ID_STOP_DONE,
+		.handled = 0,
+	},
+	{
+		.request = VPU_CMD_ID_ABORT,
+		.response = VPU_MSG_ID_ABORT_DONE,
+		.handled = 0,
+	},
+	{
+		.request = VPU_CMD_ID_RST_BUF,
+		.response = VPU_MSG_ID_BUF_RST,
+		.handled = 1,
+	},
+};
+
+int vpu_cmd_send(struct vpu_core *core, struct vpu_rpc_event *pkt)
+{
+	int ret = 0;
+
+	WARN_ON(!core || !pkt);
+
+	ret = vpu_iface_send_cmd(core, pkt);
+	if (ret)
+		return ret;
+
+	/*write cmd data to cmd buffer before trigger a cmd interrupt*/
+	mb();
+	vpu_mbox_send_type(core, COMMAND);
+
+	return ret;
+}
+
+struct vpu_cmd_t *vpu_alloc_cmd(struct vpu_inst *inst, u32 id, void *data)
+{
+	struct vpu_cmd_t *cmd;
+	int i;
+	int ret;
+
+	cmd = vzalloc(sizeof(*cmd));
+	if (!cmd)
+		return NULL;
+
+	cmd->pkt = vzalloc(sizeof(*cmd->pkt));
+	if (!cmd->pkt) {
+		vfree(cmd);
+		return NULL;
+	}
+
+	cmd->id = id;
+	ret = vpu_iface_pack_cmd(inst->core, cmd->pkt, inst->id, id, data);
+	if (ret) {
+		inst_err(inst, "iface pack cmd(%d) fail\n", id);
+		vfree(cmd->pkt);
+		vfree(cmd);
+		return NULL;
+	}
+	for (i = 0; i < ARRAY_SIZE(vpu_cmd_requests); i++) {
+		if (vpu_cmd_requests[i].request == id) {
+			cmd->request = &vpu_cmd_requests[i];
+			break;
+		}
+	}
+
+	return cmd;
+}
+
+void vpu_free_cmd(struct vpu_cmd_t *cmd)
+{
+	if (!cmd)
+		return;
+	if (cmd->pkt)
+		vfree(cmd->pkt);
+	vfree(cmd);
+}
+
+int vpu_session_process_cmd(struct vpu_inst *inst, struct vpu_cmd_t *cmd)
+{
+	int ret;
+
+	if (!inst || !cmd || !cmd->pkt)
+		return -EINVAL;
+
+	inst_dbg(inst, LVL_CMD, "send cmd(%d)\n", cmd->id);
+	vpu_iface_pre_send_cmd(inst);
+	ret = vpu_cmd_send(inst->core, cmd->pkt);
+	if (!ret) {
+		vpu_iface_post_send_cmd(inst);
+		vpu_inst_record_flow(inst, cmd->id);
+	} else {
+		inst_err(inst, "iface send cmd(%d) fail\n", cmd->id);
+	}
+
+	return ret;
+}
+
+void vpu_process_cmd_request(struct vpu_inst *inst)
+{
+	struct vpu_cmd_t *cmd;
+	struct vpu_cmd_t *tmp;
+
+	if (!inst || inst->pending)
+		return;
+
+	list_for_each_entry_safe(cmd, tmp, &inst->cmd_q, list) {
+		list_del_init(&cmd->list);
+		if (vpu_session_process_cmd(inst, cmd))
+			inst_err(inst, "process cmd(%d) fail\n", cmd->id);
+		if (cmd->request) {
+			inst->pending = (void *)cmd;
+			break;
+		}
+		vpu_free_cmd(cmd);
+	}
+}
+
+int vpu_request_cmd(struct vpu_inst *inst, u32 id, void *data,
+		unsigned long *key, int *sync)
+{
+	struct vpu_core *core;
+	struct vpu_cmd_t *cmd;
+
+	if (!inst || !inst->core)
+		return -EINVAL;
+
+	core = inst->core;
+	cmd = vpu_alloc_cmd(inst, id, data);
+	if (!cmd)
+		return -ENOMEM;
+
+	mutex_lock(&core->cmd_lock);
+	cmd->key = core->cmd_seq++;
+	if (key)
+		*key = cmd->key;
+	if (sync)
+		*sync = cmd->request ? true : false;
+	list_add_tail(&cmd->list, &inst->cmd_q);
+	vpu_process_cmd_request(inst);
+	mutex_unlock(&core->cmd_lock);
+
+	return 0;
+}
+
+void vpu_clear_pending(struct vpu_inst *inst)
+{
+	if (!inst || !inst->pending)
+		return;
+
+	vpu_free_cmd(inst->pending);
+	wake_up_all(&inst->core->ack_wq);
+	inst->pending = NULL;
+}
+
+bool vpu_check_response(struct vpu_cmd_t *cmd, u32 response, u32 handled)
+{
+	struct vpu_cmd_request *request;
+
+	if (!cmd || !cmd->request)
+		return false;
+
+	request = cmd->request;
+	if (request->response != response)
+		return false;
+	if (request->handled != handled)
+		return false;
+
+	return true;
+}
+
+int vpu_response_cmd(struct vpu_inst *inst, u32 response, u32 handled)
+{
+	struct vpu_core *core;
+
+	if (!inst || !inst->core)
+		return -EINVAL;
+
+	core = inst->core;
+	mutex_lock(&core->cmd_lock);
+	if (vpu_check_response(inst->pending, response, handled))
+		vpu_clear_pending(inst);
+
+	vpu_process_cmd_request(inst);
+	mutex_unlock(&core->cmd_lock);
+
+	return 0;
+}
+
+void vpu_clear_request(struct vpu_inst *inst)
+{
+	struct vpu_cmd_t *cmd;
+	struct vpu_cmd_t *tmp;
+
+	mutex_lock(&inst->core->cmd_lock);
+	if (inst->pending)
+		vpu_clear_pending(inst);
+
+	list_for_each_entry_safe(cmd, tmp, &inst->cmd_q, list) {
+		list_del_init(&cmd->list);
+		vpu_free_cmd(cmd);
+	}
+	mutex_unlock(&inst->core->cmd_lock);
+}
+
+static bool check_is_responsed(struct vpu_inst *inst, unsigned long key)
+{
+	struct vpu_core *core = inst->core;
+	struct vpu_cmd_t *cmd;
+	bool flag = true;
+
+	mutex_lock(&core->cmd_lock);
+	cmd = inst->pending;
+	if (cmd && key == cmd->key) {
+		flag = false;
+		goto exit;
+	}
+	list_for_each_entry(cmd, &inst->cmd_q, list) {
+		if (key == cmd->key) {
+			flag = false;
+			break;
+		}
+	}
+exit:
+	mutex_unlock(&core->cmd_lock);
+
+	return flag;
+}
+
+static int sync_session_response(struct vpu_inst *inst, unsigned long key)
+{
+	struct vpu_core *core;
+	long ret;
+
+	if (!inst || !inst->core)
+		return -EINVAL;
+
+	core = inst->core;
+	ret = wait_event_timeout(core->ack_wq,
+			check_is_responsed(inst, key),
+			VPU_TIMEOUT);
+
+	if (!check_is_responsed(inst, key)) {
+		inst_err(inst, "sync session timeout\n");
+		set_bit(inst->id, &core->hang_mask);
+		mutex_lock(&inst->core->cmd_lock);
+		vpu_clear_pending(inst);
+		mutex_unlock(&inst->core->cmd_lock);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vpu_session_send_cmd(struct vpu_inst *inst, u32 id, void *data)
+{
+	struct vpu_core *core;
+	unsigned long key;
+	int sync = false;
+	int ret = -EINVAL;
+
+	WARN_ON(!inst || !inst->core || inst->id < 0);
+	core = inst->core;
+
+	ret = vpu_request_cmd(inst, id, data, &key, &sync);
+	if (!ret && sync)
+		ret = sync_session_response(inst, key);
+
+	if (ret)
+		inst_err(inst, "send cmd(%d) fail\n", id);
+
+	return ret;
+}
+
+int vpu_session_configure_codec(struct vpu_inst *inst)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_CONFIGURE_CODEC, NULL);
+}
+
+int vpu_session_start(struct vpu_inst *inst)
+{
+	inst_dbg(inst, LVL_FLOW, "send start cmd\n");
+
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_START, NULL);
+}
+
+int vpu_session_stop(struct vpu_inst *inst)
+{
+	inst_dbg(inst, LVL_FLOW, "send stop cmd\n");
+
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_STOP, NULL);
+}
+
+int vpu_session_encode_frame(struct vpu_inst *inst, s64 timestamp)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_FRAME_ENCODE, &timestamp);
+}
+
+int vpu_session_alloc_fs(struct vpu_inst *inst, struct vpu_fs_info *fs)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_FS_ALLOC, fs);
+}
+
+int vpu_session_release_fs(struct vpu_inst *inst, struct vpu_fs_info *fs)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_FS_RELEASE, fs);
+}
+
+int vpu_session_abort(struct vpu_inst *inst)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_ABORT, NULL);
+}
+
+int vpu_session_rst_buf(struct vpu_inst *inst)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_RST_BUF, NULL);
+}
+
+int vpu_session_fill_timestamp(struct vpu_inst *inst, struct vpu_ts_info *info)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_TIMESTAMP, info);
+}
+
+int vpu_session_update_parameters(struct vpu_inst *inst, void *arg)
+{
+	if (inst->type & VPU_CORE_TYPE_DEC)
+		vpu_iface_set_decode_params(inst, arg, 1);
+	else
+		vpu_iface_set_encode_params(inst, arg, 1);
+
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_UPDATE_PARAMETER, arg);
+}
+
+int vpu_session_debug(struct vpu_inst *inst)
+{
+	return vpu_session_send_cmd(inst, VPU_CMD_ID_DEBUG, NULL);
+}
+
+int vpu_core_snapshot(struct vpu_core *core)
+{
+	struct vpu_inst *inst;
+	int ret;
+
+	WARN_ON(!core || list_empty(&core->instances));
+
+	inst = list_first_entry(&core->instances, struct vpu_inst, list);
+
+	reinit_completion(&core->cmp);
+	ret = vpu_session_send_cmd(inst, VPU_CMD_ID_SNAPSHOT, NULL);
+	if (ret)
+		return ret;
+	ret = wait_for_completion_timeout(&core->cmp, VPU_TIMEOUT);
+	if (!ret) {
+		vpu_err("core[%d] snapshot timeout\n", core->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vpu_core_sw_reset(struct vpu_core *core)
+{
+	struct vpu_rpc_event pkt;
+	int ret;
+
+	WARN_ON(!core);
+
+	memset(&pkt, 0, sizeof(pkt));
+	vpu_iface_pack_cmd(core, &pkt, 0, VPU_CMD_ID_FIRM_RESET, NULL);
+
+	reinit_completion(&core->cmp);
+	mutex_lock(&core->cmd_lock);
+	ret = vpu_cmd_send(core, &pkt);
+	mutex_unlock(&core->cmd_lock);
+	if (ret)
+		return ret;
+	ret = wait_for_completion_timeout(&core->cmp, VPU_TIMEOUT);
+	if (!ret) {
+		vpu_err("core[%d] sw reset timeout\n", core->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_cmds.h b/drivers/media/platform/imx/vpu-8q/vpu_cmds.h
new file mode 100644
index 000000000000..fa114ed5ba7d
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_cmds.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_CMDS_H
+#define _IMX_VPU_CMDS_H
+
+int vpu_session_configure_codec(struct vpu_inst *inst);
+int vpu_session_start(struct vpu_inst *inst);
+int vpu_session_stop(struct vpu_inst *inst);
+int vpu_session_abort(struct vpu_inst *inst);
+int vpu_session_rst_buf(struct vpu_inst *inst);
+int vpu_session_encode_frame(struct vpu_inst *inst, s64 timestamp);
+int vpu_session_alloc_fs(struct vpu_inst *inst, struct vpu_fs_info *fs);
+int vpu_session_release_fs(struct vpu_inst *inst, struct vpu_fs_info *fs);
+int vpu_session_fill_timestamp(struct vpu_inst *inst, struct vpu_ts_info *info);
+int vpu_session_update_parameters(struct vpu_inst *inst, void *arg);
+int vpu_core_snapshot(struct vpu_core *core);
+int vpu_core_sw_reset(struct vpu_core *core);
+int vpu_response_cmd(struct vpu_inst *inst, u32 response, u32 handled);
+void vpu_clear_request(struct vpu_inst *inst);
+int vpu_session_debug(struct vpu_inst *inst);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_codec.h b/drivers/media/platform/imx/vpu-8q/vpu_codec.h
new file mode 100644
index 000000000000..1f1e6866d88d
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_codec.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_CODEC_H
+#define _IMX_VPU_CODEC_H
+
+struct vpu_encode_params {
+	u32 input_format;
+	u32 codec_format;
+	u32 profile;
+	u32 tier;
+	u32 level;
+	u32 frame_rate_num;
+	u32 frame_rate_den;
+	u32 src_stride;
+	u32 src_width;
+	u32 src_height;
+	struct v4l2_rect crop;
+	u32 out_width;
+	u32 out_height;
+
+	u32 gop_length;
+	u32 bframes;
+
+	u32 rc_mode;
+	u32 bitrate;
+	u32 bitrate_min;
+	u32 bitrate_max;
+
+	u32 i_frame_qp;
+	u32 p_frame_qp;
+	u32 b_frame_qp;
+	u32 qp_min;
+	u32 qp_max;
+	u32 qp_min_i;
+	u32 qp_max_i;
+
+	struct {
+		u32 enable;
+		u32 idc;
+		u32 width;
+		u32 height;
+	} sar;
+
+	struct {
+		u32 primaries;
+		u32 transfer;
+		u32 matrix;
+		u32 full_range;
+	} color;
+};
+
+struct vpu_decode_params {
+	u32 codec_format;
+	u32 output_format;
+	u32 b_dis_reorder;
+	u32 b_non_frame;
+	u32 frame_count;
+	u32 end_flag;
+	struct {
+		u32 base;
+		u32 size;
+	} udata;
+};
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_color.c b/drivers/media/platform/imx/vpu-8q/vpu_color.c
new file mode 100644
index 000000000000..62030a3db0ee
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_color.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"COLOR"
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <media/v4l2-device.h>
+#include "vpu.h"
+#include "vpu_helpers.h"
+
+static const u8 colorprimaries[] = {
+	0,
+	V4L2_COLORSPACE_REC709,        /*Rec. ITU-R BT.709-6*/
+	0,
+	0,
+	V4L2_COLORSPACE_470_SYSTEM_M, /*Rec. ITU-R BT.470-6 System M*/
+	V4L2_COLORSPACE_470_SYSTEM_BG,/*Rec. ITU-R BT.470-6 System B, G*/
+	V4L2_COLORSPACE_SMPTE170M,    /*SMPTE170M*/
+	V4L2_COLORSPACE_SMPTE240M,    /*SMPTE240M*/
+	V4L2_COLORSPACE_GENERIC_FILM, /*Generic film*/
+	V4L2_COLORSPACE_BT2020,       /*Rec. ITU-R BT.2020-2*/
+	V4L2_COLORSPACE_ST428         /*SMPTE ST 428-1*/
+};
+
+static const u8 colortransfers[] = {
+	0,
+	V4L2_XFER_FUNC_709,      /*Rec. ITU-R BT.709-6*/
+	0,
+	0,
+	V4L2_XFER_FUNC_GAMMA22,  /*Rec. ITU-R BT.470-6 System M*/
+	V4L2_XFER_FUNC_GAMMA28,  /*Rec. ITU-R BT.470-6 System B, G*/
+	V4L2_XFER_FUNC_709,      /*SMPTE170M*/
+	V4L2_XFER_FUNC_SMPTE240M,/*SMPTE240M*/
+	V4L2_XFER_FUNC_LINEAR,   /*Linear transfer characteristics*/
+	0,
+	0,
+	V4L2_XFER_FUNC_XVYCC,    /*IEC 61966-2-4*/
+	V4L2_XFER_FUNC_BT1361,   /*Rec. ITU-R BT.1361-0 extended colour gamut*/
+	V4L2_XFER_FUNC_SRGB,     /*IEC 61966-2-1 sRGB or sYCC*/
+	V4L2_XFER_FUNC_709,      /*Rec. ITU-R BT.2020-2 (10 bit system)*/
+	V4L2_XFER_FUNC_709,      /*Rec. ITU-R BT.2020-2 (12 bit system)*/
+	V4L2_XFER_FUNC_SMPTE2084,/*SMPTE ST 2084*/
+	V4L2_XFER_FUNC_ST428,    /*SMPTE ST 428-1*/
+	V4L2_XFER_FUNC_HLG       /*Rec. ITU-R BT.2100-0 hybrid log-gamma (HLG)*/
+};
+
+static const u8 colormatrixcoefs[] = {
+	0,
+	V4L2_YCBCR_ENC_709,             /*Rec. ITU-R BT.709-6*/
+	0,
+	0,
+	V4L2_YCBCR_ENC_BT470_6M,        /*Title 47 Code of Federal Regulations*/
+	V4L2_YCBCR_ENC_601,             /*Rec. ITU-R BT.601-7 625*/
+	V4L2_YCBCR_ENC_601,             /*Rec. ITU-R BT.601-7 525*/
+	V4L2_YCBCR_ENC_SMPTE240M,       /*SMPTE240M*/
+	0,
+	V4L2_YCBCR_ENC_BT2020,          /*Rec. ITU-R BT.2020-2*/
+	V4L2_YCBCR_ENC_BT2020_CONST_LUM /*Rec. ITU-R BT.2020-2 constant*/
+};
+
+u32 vpu_color_cvrt_primaries_v2i(u32 primaries)
+{
+	return VPU_ARRAY_FIND(colorprimaries, primaries);
+}
+
+u32 vpu_color_cvrt_primaries_i2v(u32 primaries)
+{
+	return VPU_ARRAY_AT(colorprimaries, primaries);
+}
+
+u32 vpu_color_cvrt_transfers_v2i(u32 transfers)
+{
+	return VPU_ARRAY_FIND(colortransfers, transfers);
+}
+
+u32 vpu_color_cvrt_transfers_i2v(u32 transfers)
+{
+	return VPU_ARRAY_AT(colortransfers, transfers);
+}
+
+u32 vpu_color_cvrt_matrix_v2i(u32 matrix)
+{
+	return VPU_ARRAY_FIND(colormatrixcoefs, matrix);
+}
+
+u32 vpu_color_cvrt_matrix_i2v(u32 matrix)
+{
+	return VPU_ARRAY_AT(colormatrixcoefs, matrix);
+}
+
+u32 vpu_color_cvrt_full_range_v2i(u32 full_range)
+{
+	return (full_range == V4L2_QUANTIZATION_FULL_RANGE);
+}
+
+u32 vpu_color_cvrt_full_range_i2v(u32 full_range)
+{
+	if (full_range)
+		return V4L2_QUANTIZATION_FULL_RANGE;
+
+	return V4L2_QUANTIZATION_LIM_RANGE;
+}
+
+int vpu_color_check_primaries(u32 primaries)
+{
+	return vpu_color_cvrt_primaries_v2i(primaries) ? 0 : -EINVAL;
+}
+
+int vpu_color_check_transfers(u32 transfers)
+{
+	return vpu_color_cvrt_transfers_v2i(transfers) ? 0 : -EINVAL;
+}
+
+int vpu_color_check_matrix(u32 matrix)
+{
+	return vpu_color_cvrt_matrix_v2i(matrix) ? 0 : -EINVAL;
+}
+
+int vpu_color_check_full_range(u32 full_range)
+{
+	int ret = -EINVAL;
+
+	switch (full_range) {
+	case V4L2_QUANTIZATION_FULL_RANGE:
+	case V4L2_QUANTIZATION_LIM_RANGE:
+		ret = 0;
+		break;
+	default:
+		break;
+
+	}
+
+	return ret;
+}
+
+int vpu_color_get_default(u32 primaries,
+		u32 *ptransfers, u32 *pmatrix, u32 *pfull_range)
+{
+	u32 transfers;
+	u32 matrix;
+	u32 full_range;
+
+	switch (primaries) {
+	case V4L2_COLORSPACE_REC709:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_709;
+		full_range = V4L2_QUANTIZATION_LIM_RANGE;
+		break;
+	case V4L2_COLORSPACE_470_SYSTEM_M:
+	case V4L2_COLORSPACE_470_SYSTEM_BG:
+	case V4L2_COLORSPACE_SMPTE170M:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_601;
+		full_range = V4L2_QUANTIZATION_LIM_RANGE;
+		break;
+	case V4L2_COLORSPACE_SMPTE240M:
+		transfers = V4L2_XFER_FUNC_SMPTE240M;
+		matrix = V4L2_YCBCR_ENC_SMPTE240M;
+		full_range = V4L2_QUANTIZATION_LIM_RANGE;
+		break;
+	case V4L2_COLORSPACE_BT2020:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_BT2020;
+		full_range = V4L2_QUANTIZATION_LIM_RANGE;
+		break;
+	default:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_709;
+		full_range = V4L2_QUANTIZATION_LIM_RANGE;
+		break;
+	}
+
+	if (ptransfers)
+		*ptransfers = transfers;
+	if (pmatrix)
+		*pmatrix = matrix;
+	if (pfull_range)
+		*pfull_range = full_range;
+
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_core.c b/drivers/media/platform/imx/vpu-8q/vpu_core.c
new file mode 100644
index 000000000000..b498409d8c53
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_core.c
@@ -0,0 +1,923 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"CORE"
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <linux/firmware.h>
+#include "vpu.h"
+#include "vpu_defs.h"
+#include "vpu_mbox.h"
+#include "vpu_msgs.h"
+#include "vpu_rpc.h"
+#include "vpu_log.h"
+#include "vpu_cmds.h"
+
+unsigned int vpu_dbg_level = LVL_ERR | LVL_WARN | LVL_INFO;
+module_param(vpu_dbg_level, uint, 0644);
+
+void csr_writel(struct vpu_core *core, u32 reg, u32 val)
+{
+	writel(val, core->base + reg);
+}
+
+u32 csr_readl(struct vpu_core *core, u32 reg)
+{
+	return readl(core->base + reg);
+}
+
+static int vpu_core_load_firmware(struct vpu_core *core)
+{
+	const struct firmware *pfw = NULL;
+	int ret = 0;
+
+	WARN_ON(!core || !core->res || !core->res->fwname);
+	if (!core->fw.virt) {
+		core_err(core, "firmware buffer is not ready\n");
+		return -EINVAL;
+	}
+
+	ret = request_firmware(&pfw, core->res->fwname, core->dev);
+	core_dbg(core, LVL_DEBUG, "request_firmware %s : %d\n", core->res->fwname, ret);
+	if (ret) {
+		core_err(core, "request firmware %s failed, ret = %d\n",
+				core->res->fwname, ret);
+		return ret;
+	}
+
+	if (core->fw.length < pfw->size) {
+		core_err(core, "firmware buffer size want %ld, but %d\n",
+				pfw->size, core->fw.length);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	memset_io(core->fw.virt, 0, core->fw.length);
+	memcpy(core->fw.virt, pfw->data, pfw->size);
+	core->fw.bytesused = pfw->size;
+	ret = vpu_iface_on_firmware_loaded(core);
+exit:
+	release_firmware(pfw);
+	pfw = NULL;
+
+	return ret;
+}
+
+static int vpu_core_wait_boot_done(struct vpu_core *core)
+{
+	int ret;
+	u32 fw_version;
+
+	ret = wait_for_completion_timeout(&core->cmp, VPU_TIMEOUT);
+	if (!ret) {
+		core_err(core, "boot timeout\n");
+		return -EINVAL;
+	}
+
+	fw_version = vpu_iface_get_version(core);
+	core_dbg(core, LVL_WARN, "firmware version : %d.%d.%d\n",
+			(fw_version >> 16) & 0xff,
+			(fw_version >> 8) & 0xff,
+			fw_version & 0xff);
+	core->supported_instance_count = vpu_iface_get_max_instance_count(core);
+	core->fw_version = fw_version;
+
+	return 0;
+}
+
+static int vpu_core_boot(struct vpu_core *core, bool load)
+{
+	int ret;
+
+	WARN_ON(!core);
+
+	if (!core->res->standalone)
+		return 0;
+
+	core_dbg(core, LVL_WARN, "boot\n");
+	reinit_completion(&core->cmp);
+	if (load) {
+		ret = vpu_core_load_firmware(core);
+		if (ret)
+			return ret;
+	}
+
+	vpu_iface_boot_core(core);
+	return vpu_core_wait_boot_done(core);
+}
+
+static int vpu_core_shutdown(struct vpu_core *core)
+{
+	if (!core->res->standalone)
+		return 0;
+	return vpu_iface_shutdown_core(core);
+}
+
+static int vpu_core_restore(struct vpu_core *core)
+{
+	if (!core->res->standalone)
+		return 0;
+	return vpu_iface_restore_core(core);
+}
+
+static int __vpu_alloc_dma(struct device *dev, struct vpu_buffer *buf)
+{
+	gfp_t gfp = GFP_KERNEL | GFP_DMA32;
+
+	WARN_ON(!dev || !buf);
+
+	if (!buf->length)
+		return 0;
+
+	buf->virt = dma_alloc_coherent(dev, buf->length, &buf->phys, gfp);
+	if (!buf->virt)
+		return -ENOMEM;
+
+	buf->dev = dev;
+
+	return 0;
+}
+
+void vpu_free_dma(struct vpu_buffer *buf)
+{
+	WARN_ON(!buf);
+
+	if (!buf->virt || !buf->dev)
+		return;
+
+	dma_free_coherent(buf->dev, buf->length, buf->virt, buf->phys);
+	buf->virt = NULL;
+	buf->phys = 0;
+	buf->length = 0;
+	buf->bytesused = 0;
+	buf->dev = NULL;
+}
+
+int vpu_alloc_dma(struct vpu_core *core, struct vpu_buffer *buf)
+{
+	WARN_ON(!core || !buf);
+
+	return __vpu_alloc_dma(core->dev, buf);
+}
+
+int vpu_alloc_reserved_dma(struct vpu_core *core, struct vpu_buffer *buf)
+{
+	WARN_ON(!core || !buf);
+
+	if (!core->vpu || !core->vpu->memory.phys || !core->res)
+		return -EINVAL;
+
+	if (!core->res->use_reserved_mem)
+		return -EINVAL;
+
+	return __vpu_alloc_dma(core->vpu->dev, buf);
+}
+
+struct vpu_core *vpu_core_find_next_by_type(struct vpu_dev *vpu, u32 type)
+{
+	struct vpu_core *c;
+
+	WARN_ON(!vpu);
+
+	list_for_each_entry(c, &vpu->cores, list) {
+		if (c->type == type)
+			return c;
+	}
+
+	return NULL;
+}
+
+int vpu_core_check_fmt(struct vpu_core *core, u32 pixelfmt)
+{
+	if (!core)
+		return -EINVAL;
+
+	if (vpu_iface_check_format(core, pixelfmt))
+		return 0;
+
+	return -EINVAL;
+}
+
+static void vpu_core_check_hang(struct vpu_core *core)
+{
+	if (core->hang_mask)
+		core->state = VPU_CORE_HANG;
+}
+
+struct vpu_core *vpu_core_find_proper_by_type(struct vpu_dev *vpu, u32 type)
+{
+	struct vpu_core *core = NULL;
+	int request_count = INT_MAX;
+	struct vpu_core *c;
+
+	WARN_ON(!vpu);
+
+	list_for_each_entry(c, &vpu->cores, list) {
+		core_dbg(c, LVL_DEBUG, "instance_mask = 0x%lx, state = %d\n",
+				c->instance_mask,
+				c->state);
+		if (c->type != type)
+			continue;
+		if (c->state == VPU_CORE_DEINIT) {
+			core = c;
+			break;
+		}
+		vpu_core_check_hang(c);
+		if (c->state != VPU_CORE_ACTIVE)
+			continue;
+		if (c->request_count < request_count) {
+			request_count = c->request_count;
+			core = c;
+		}
+		if (!request_count)
+			break;
+	}
+
+	return core;
+}
+
+static bool vpu_core_is_exist(struct vpu_dev *vpu, struct vpu_core *core)
+{
+	struct vpu_core *c;
+
+	list_for_each_entry(c, &vpu->cores, list) {
+		if (c == core)
+			return true;
+	}
+
+	return false;
+}
+
+static void vpu_core_get_vpu(struct vpu_core *core)
+{
+	core->vpu->get_vpu(core->vpu);
+	if (core->type == VPU_CORE_TYPE_ENC)
+		core->vpu->get_enc(core->vpu);
+	if (core->type == VPU_CORE_TYPE_DEC)
+		core->vpu->get_dec(core->vpu);
+}
+
+int vpu_core_register(struct device *dev, struct vpu_core *core)
+{
+	struct vpu_dev *vpu = dev_get_drvdata(dev);
+	int ret = 0;
+
+	core_dbg(core, LVL_DEBUG, "register core\n");
+	if (vpu_core_is_exist(vpu, core))
+		return 0;
+
+	core->workqueue = alloc_workqueue("vpu", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	if (!core->workqueue) {
+		core_err(core, "fail to alloc workqueue\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&core->msg_work, vpu_msg_run_work);
+	INIT_DELAYED_WORK(&core->msg_delayed_work, vpu_msg_delayed_work);
+	core->msg_buffer_size = roundup_pow_of_two(VPU_MSG_BUFFER_SIZE);
+	core->msg_buffer = vzalloc(core->msg_buffer_size);
+	if (!core->msg_buffer) {
+		core_err(core, "failed allocate buffer for fifo\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+	ret = kfifo_init(&core->msg_fifo, core->msg_buffer, core->msg_buffer_size);
+	if (ret) {
+		core_err(core, "failed init kfifo\n");
+		goto error;
+	}
+
+	list_add_tail(&core->list, &vpu->cores);
+
+	vpu_core_get_vpu(core);
+
+	if (core->type == VPU_CORE_TYPE_ENC && !vpu->vdev_enc)
+		venc_create_video_device(vpu);
+	if (core->type == VPU_CORE_TYPE_DEC && !vpu->vdev_dec)
+		vdec_create_video_device(vpu);
+
+	return 0;
+error:
+	if (core->msg_buffer) {
+		vfree(core->msg_buffer);
+		core->msg_buffer = NULL;
+	}
+	if (core->workqueue) {
+		destroy_workqueue(core->workqueue);
+		core->workqueue = NULL;
+	}
+	return ret;
+}
+
+static void vpu_core_put_vpu(struct vpu_core *core)
+{
+	if (core->type == VPU_CORE_TYPE_ENC)
+		core->vpu->put_enc(core->vpu);
+	if (core->type == VPU_CORE_TYPE_DEC)
+		core->vpu->put_dec(core->vpu);
+	core->vpu->put_vpu(core->vpu);
+}
+
+int vpu_core_unregister(struct device *dev, struct vpu_core *core)
+{
+	struct vpu_dev *vpu = dev_get_drvdata(dev);
+
+	list_del_init(&core->list);
+
+	vpu_core_put_vpu(core);
+	core->vpu = NULL;
+	vfree(core->msg_buffer);
+	core->msg_buffer = NULL;
+
+	if (core->workqueue) {
+		cancel_work_sync(&core->msg_work);
+		cancel_delayed_work_sync(&core->msg_delayed_work);
+		destroy_workqueue(core->workqueue);
+		core->workqueue = NULL;
+	}
+
+	if (vpu_core_find_next_by_type(vpu, core->type))
+		return 0;
+
+	if (core->type == VPU_CORE_TYPE_ENC)
+		video_unregister_device(vpu->vdev_enc);
+	if (core->type == VPU_CORE_TYPE_DEC)
+		video_unregister_device(vpu->vdev_dec);
+
+	return 0;
+}
+
+int vpu_core_acquire_instance(struct vpu_core *core)
+{
+	int id;
+
+	WARN_ON(!core);
+
+	id = ffz(core->instance_mask);
+	if (id >= core->supported_instance_count)
+		return -EINVAL;
+
+	set_bit(id, &core->instance_mask);
+
+	return id;
+}
+
+void vpu_core_release_instance(struct vpu_core *core, int id)
+{
+	WARN_ON(!core);
+
+	if (id < 0 || id >= core->supported_instance_count)
+		return;
+
+	clear_bit(id, &core->instance_mask);
+}
+
+struct vpu_inst *vpu_inst_get(struct vpu_inst *inst)
+{
+	if (!inst)
+		return NULL;
+
+	atomic_inc(&inst->ref_count);
+
+	return inst;
+}
+
+void vpu_inst_put(struct vpu_inst *inst)
+{
+	if (!inst)
+		return;
+	if (atomic_dec_and_test(&inst->ref_count)) {
+		if (inst->release)
+			inst->release(inst);
+	}
+}
+
+struct vpu_core *vpu_request_core(struct vpu_dev *vpu, enum vpu_core_type type)
+{
+	struct vpu_core *core = NULL;
+	int ret;
+
+	mutex_lock(&vpu->lock);
+
+	core = vpu_core_find_proper_by_type(vpu, type);
+	if (!core)
+		goto exit;
+
+	core_dbg(core, LVL_DEBUG, "is found\n");
+	mutex_lock(&core->lock);
+	pm_runtime_get_sync(core->dev);
+
+	if (core->state == VPU_CORE_DEINIT) {
+		ret = vpu_core_boot(core, true);
+		if (ret) {
+			pm_runtime_put_sync(core->dev);
+			mutex_unlock(&core->lock);
+			core = NULL;
+			goto exit;
+		}
+		core->state = VPU_CORE_ACTIVE;
+	}
+
+	core->request_count++;
+
+	mutex_unlock(&core->lock);
+exit:
+	mutex_unlock(&vpu->lock);
+
+	return core;
+}
+
+void vpu_release_core(struct vpu_core *core)
+{
+	if (!core)
+		return;
+
+	mutex_lock(&core->lock);
+	pm_runtime_put_sync(core->dev);
+	if (core->request_count)
+		core->request_count--;
+	mutex_unlock(&core->lock);
+}
+
+int vpu_inst_register(struct vpu_inst *inst)
+{
+	struct vpu_core *core;
+	int ret = 0;
+
+	WARN_ON(!inst || !inst->core);
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+	if (inst->id >= 0 && inst->id < core->supported_instance_count)
+		goto exit;
+
+	ret = vpu_core_acquire_instance(core);
+	if (ret < 0)
+		goto exit;
+
+	inst->id = ret;
+	list_add_tail(&inst->list, &core->instances);
+	ret = 0;
+	inst->pid = current->pid;
+	inst->tgid = current->tgid;
+	vpu_inst_create_dbgfs_file(inst);
+exit:
+	mutex_unlock(&core->lock);
+
+	if (ret)
+		core_err(core, "register instance fail\n");
+	return ret;
+}
+
+int vpu_inst_unregister(struct vpu_inst *inst)
+{
+	struct vpu_core *core;
+
+	WARN_ON(!inst);
+
+	core = inst->core;
+
+	vpu_clear_request(inst);
+	mutex_lock(&core->lock);
+	if (inst->id >= 0 && inst->id < core->supported_instance_count) {
+		vpu_inst_remove_dbgfs_file(inst);
+		list_del_init(&inst->list);
+		vpu_core_release_instance(core, inst->id);
+		inst->id = VPU_INST_NULL_ID;
+	}
+	vpu_core_check_hang(core);
+	if (core->state == VPU_CORE_HANG && !core->instance_mask) {
+		core_dbg(core, LVL_WARN, "reset hang core\n");
+		if (!vpu_core_sw_reset(core)) {
+			core->state = VPU_CORE_ACTIVE;
+			core->hang_mask = 0;
+		}
+	}
+	mutex_unlock(&core->lock);
+
+	return 0;
+}
+
+struct vpu_inst *vpu_core_find_instance(struct vpu_core *core, u32 index)
+{
+	struct vpu_inst *inst = NULL;
+	struct vpu_inst *tmp;
+
+	mutex_lock(&core->lock);
+	if (!test_bit(index, &core->instance_mask))
+		goto exit;
+	list_for_each_entry(tmp, &core->instances, list) {
+		if (tmp->id == index) {
+			inst = vpu_inst_get(tmp);
+			break;
+		}
+	}
+exit:
+	mutex_unlock(&core->lock);
+
+	return inst;
+}
+
+static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
+{
+	struct device_node *node;
+	struct resource res;
+	u32 log_buf_offset = 0;
+
+	of_property_read_u32(np, "id", &core->id);
+
+	node = of_parse_phandle(np, "boot-region", 0);
+	if (!node) {
+		core_err(core, "boot-region of_parse_phandle error\n");
+		return -ENODEV;
+	}
+	if (of_address_to_resource(node, 0, &res)) {
+		core_err(core, "boot-region of_address_to_resource error\n");
+		return -EINVAL;
+	}
+	core->fw.phys = res.start;
+	core->fw.length = resource_size(&res);
+	core_dbg(core, LVL_INFO, "boot-region : <0x%llx, 0x%llx>\n",
+			res.start, resource_size(&res));
+
+	node = of_parse_phandle(np, "rpc-region", 0);
+	if (!node) {
+		core_err(core, "rpc-region of_parse_phandle error\n");
+		return -ENODEV;
+	}
+	if (of_address_to_resource(node, 0, &res)) {
+		core_err(core, "rpc-region of_address_to_resource error\n");
+		return -EINVAL;
+	}
+	core->rpc.phys = res.start;
+	core->rpc.length = resource_size(&res);
+	core_dbg(core, LVL_DEBUG, "rpc-region : <0x%llx, 0x%llx>\n",
+			res.start, resource_size(&res));
+
+	core->fw.virt = ioremap_wc(core->fw.phys, core->fw.length);
+	core->rpc.virt = ioremap_wc(core->rpc.phys, core->rpc.length);
+	memset_io(core->rpc.virt, 0, core->rpc.length);
+
+	if (vpu_iface_check_memory_region(core,
+				core->rpc.phys,
+				core->rpc.length) != VPU_CORE_MEMORY_UNCACHED) {
+		core_err(core, "rpc region<0x%llx, 0x%x> isn't uncached\n",
+				core->rpc.phys,
+				core->rpc.length);
+		return -EINVAL;
+	}
+
+	of_property_read_u32(np, "print-offset", &log_buf_offset);
+	if (log_buf_offset && log_buf_offset < core->rpc.length) {
+		core->log.phys = core->rpc.phys + log_buf_offset;
+		core->log.length = core->rpc.length - log_buf_offset;
+		core->log.virt = core->rpc.virt + log_buf_offset;
+		core_dbg(core, LVL_DEBUG, "log-region : <0x%llx, 0x%x>\n",
+				core->log.phys, core->log.length);
+		core->rpc.length = log_buf_offset;
+	}
+
+	return 0;
+}
+
+static int vpu_core_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vpu_core *core;
+	struct vpu_dev *vpu = dev_get_drvdata(dev->parent);
+	struct vpu_shared_addr *iface;
+	u32 iface_data_size;
+	struct resource *r;
+	int ret;
+
+	vpu_dbg(LVL_WARN, "core %s probe\n", pdev->dev.of_node->name);
+	if (!vpu)
+		return -EINVAL;
+	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+
+	core->pdev = pdev;
+	core->dev = dev;
+	platform_set_drvdata(pdev, core);
+	core->vpu = vpu;
+	INIT_LIST_HEAD(&core->instances);
+	mutex_init(&core->lock);
+	mutex_init(&core->cmd_lock);
+	init_completion(&core->cmp);
+	init_waitqueue_head(&core->ack_wq);
+	core->state = VPU_CORE_DEINIT;
+
+	core->res = of_device_get_match_data(dev);
+	if (!core->res)
+		return -ENODEV;
+
+	core->type = core->res->type;
+	ret = vpu_core_parse_dt(core, dev->of_node);
+	if (ret)
+		return ret;
+
+	if (core->res->use_reserved_mem) {
+		if (!vpu->memory.phys) {
+			core_err(core, "vpu don't have reserved memory\n");
+			return -EINVAL;
+		}
+		if (vpu_iface_check_memory_region(core,
+			vpu->memory.phys,
+			vpu->memory.length) != VPU_CORE_MEMORY_UNCACHED) {
+			core_err(core,
+				"reserved mem<0x%llx, 0x%x> isn't uncached\n",
+				vpu->memory.phys,
+				vpu->memory.length);
+			return -EINVAL;
+		}
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		core_err(core, "fail to get core reg\n");
+		return -EINVAL;
+	}
+	core->base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(core->base))
+		return PTR_ERR(core->base);
+	core_dbg(core, LVL_WARN, "reg : <0x%llx, 0x%llx>\n", r->start, resource_size(r));
+
+	if (!vpu_iface_check_codec(core)) {
+		core_err(core, "is not supported\n");
+		return -EINVAL;
+	}
+
+	ret = vpu_mbox_init(core);
+	if (ret)
+		return ret;
+
+	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
+	if (!iface)
+		return -ENOMEM;
+
+	iface_data_size = vpu_iface_get_data_size(core);
+	if (iface_data_size) {
+		iface->priv = devm_kzalloc(dev, iface_data_size, GFP_KERNEL);
+		if (!iface->priv)
+			return -ENOMEM;
+	}
+
+	ret = vpu_iface_init(core, iface, &core->rpc, core->fw.phys);
+	if (ret) {
+		core_err(core, "init iface fail, ret = %d\n", ret);
+		return ret;
+	}
+
+	vpu_iface_config_system(core, vpu->res->mreg_base, vpu->base);
+	vpu_iface_set_log_buf(core, &core->log);
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret) {
+		pm_runtime_put_noidle(dev);
+		pm_runtime_set_suspended(dev);
+		goto err_runtime_disable;
+	}
+
+	if (vpu_iface_get_power_state(core))
+		ret = vpu_core_restore(core);
+	if (ret)
+		goto err_core_boot;
+
+	ret = vpu_core_register(dev->parent, core);
+	if (ret)
+		goto err_core_register;
+	core->parent = dev->parent;
+
+	pm_runtime_put_sync(dev);
+	vpu_core_create_dbgfs_file(core);
+
+	return 0;
+
+err_core_register:
+	vpu_core_shutdown(core);
+err_core_boot:
+	pm_runtime_put_sync(dev);
+err_runtime_disable:
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int vpu_core_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vpu_core *core = platform_get_drvdata(pdev);
+	int ret;
+
+	vpu_core_remove_dbgfs_file(core);
+	ret = pm_runtime_get_sync(dev);
+	WARN_ON(ret < 0);
+
+	vpu_core_shutdown(core);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	vpu_core_unregister(core->parent, core);
+	iounmap(core->fw.virt);
+	iounmap(core->rpc.virt);
+	mutex_destroy(&core->lock);
+	mutex_destroy(&core->cmd_lock);
+
+	return 0;
+}
+
+static int __maybe_unused vpu_core_runtime_resume(struct device *dev)
+{
+	struct vpu_core *core = dev_get_drvdata(dev);
+
+	return vpu_mbox_request(core);
+}
+
+static int __maybe_unused vpu_core_runtime_suspend(struct device *dev)
+{
+	struct vpu_core *core = dev_get_drvdata(dev);
+
+	vpu_mbox_free(core);
+	return 0;
+}
+
+static void vpu_core_cancel_work(struct vpu_core *core)
+{
+	struct vpu_inst *inst = NULL;
+
+	cancel_work_sync(&core->msg_work);
+	cancel_delayed_work_sync(&core->msg_delayed_work);
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(inst, &core->instances, list)
+		cancel_work_sync(&inst->msg_work);
+	mutex_unlock(&core->lock);
+}
+
+static void vpu_core_resume_work(struct vpu_core *core)
+{
+	struct vpu_inst *inst = NULL;
+	unsigned long delay = msecs_to_jiffies(10);
+
+	queue_work(core->workqueue, &core->msg_work);
+	queue_delayed_work(core->workqueue, &core->msg_delayed_work, delay);
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(inst, &core->instances, list)
+		queue_work(inst->workqueue, &inst->msg_work);
+	mutex_unlock(&core->lock);
+}
+
+static int __maybe_unused vpu_core_resume(struct device *dev)
+{
+	struct vpu_core *core = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (!core->res->standalone)
+		return 0;
+
+	mutex_lock(&core->lock);
+	pm_runtime_get_sync(dev);
+	vpu_core_get_vpu(core);
+	if (core->state != VPU_CORE_SNAPSHOT)
+		goto exit;
+
+	if (!vpu_iface_get_power_state(core)) {
+		if (!list_empty(&core->instances)) {
+			ret = vpu_core_boot(core, false);
+			if (ret) {
+				core_err(core, "%s boot fail\n", __func__);
+				core->state = VPU_CORE_DEINIT;
+				goto exit;
+			}
+			core->state = VPU_CORE_ACTIVE;
+		} else {
+			core->state = VPU_CORE_DEINIT;
+		}
+	} else {
+		if (!list_empty(&core->instances)) {
+			ret = vpu_core_sw_reset(core);
+			if (ret) {
+				core_err(core, "%s sw_reset fail\n", __func__);
+				core->state = VPU_CORE_HANG;
+				goto exit;
+			}
+		}
+		core->state = VPU_CORE_ACTIVE;
+	}
+
+exit:
+	pm_runtime_put_sync(dev);
+	mutex_unlock(&core->lock);
+
+	vpu_core_resume_work(core);
+	return ret;
+}
+
+static int __maybe_unused vpu_core_suspend(struct device *dev)
+{
+	struct vpu_core *core = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (!core->res->standalone)
+		return 0;
+
+	mutex_lock(&core->lock);
+	if (core->state == VPU_CORE_ACTIVE) {
+		if (!list_empty(&core->instances)) {
+			ret = vpu_core_snapshot(core);
+			if (ret) {
+				mutex_unlock(&core->lock);
+				return ret;
+			}
+		}
+
+		core->state = VPU_CORE_SNAPSHOT;
+	}
+	mutex_unlock(&core->lock);
+
+	vpu_core_cancel_work(core);
+
+	mutex_lock(&core->lock);
+	vpu_core_put_vpu(core);
+	mutex_unlock(&core->lock);
+	return ret;
+}
+
+static const struct dev_pm_ops vpu_core_pm_ops = {
+	SET_RUNTIME_PM_OPS(vpu_core_runtime_suspend, vpu_core_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(vpu_core_suspend, vpu_core_resume)
+};
+
+static struct vpu_core_resources imx8q_enc = {
+	.type = VPU_CORE_TYPE_ENC,
+	.fwname = "vpu/vpu_fw_imx8_enc.bin",
+	.stride = 16,
+	.max_width = 1920,
+	.max_height = 1920,
+	.min_width = 64,
+	.min_height = 48,
+	.step_width = 2,
+	.step_height = 2,
+	.use_reserved_mem = true,
+	.standalone = true,
+};
+
+static struct vpu_core_resources imx8q_dec = {
+	.type = VPU_CORE_TYPE_DEC,
+	.fwname = "vpu/vpu_fw_imx8_dec.bin",
+	.stride = 1,
+	.max_width = 8188,
+	.max_height = 8188,
+	.min_width = 16,
+	.min_height = 16,
+	.step_width = 1,
+	.step_height = 1,
+	.standalone = true,
+};
+
+static const struct of_device_id vpu_core_dt_match[] = {
+	{ .compatible = "nxp,imx8q-vpu-encoder", .data = &imx8q_enc },
+	{ .compatible = "nxp,imx8q-vpu-decoder", .data = &imx8q_dec },
+	{}
+};
+MODULE_DEVICE_TABLE(of, vpu_core_dt_match);
+
+static struct platform_driver imx_vpu_core_driver = {
+	.probe = vpu_core_probe,
+	.remove = vpu_core_remove,
+	.driver = {
+		.name = "imx-vpu-core",
+		.of_match_table = vpu_core_dt_match,
+		.pm = &vpu_core_pm_ops,
+	},
+};
+module_platform_driver(imx_vpu_core_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Linux VPU driver for Freescale i.MX/MXC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_core.h b/drivers/media/platform/imx/vpu-8q/vpu_core.h
new file mode 100644
index 000000000000..5d4cb56f3de1
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_core.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_CORE_H
+#define _IMX_VPU_CORE_H
+
+void csr_writel(struct vpu_core *core, u32 reg, u32 val);
+u32 csr_readl(struct vpu_core *core, u32 reg);
+int vpu_alloc_dma(struct vpu_core *core, struct vpu_buffer *buf);
+void vpu_free_dma(struct vpu_buffer *buf);
+int vpu_alloc_reserved_dma(struct vpu_core *core, struct vpu_buffer *buf);
+struct vpu_inst *vpu_core_find_instance(struct vpu_core *core, u32 index);
+int vpu_core_check_fmt(struct vpu_core *core, u32 pixelfmt);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_dbg.c b/drivers/media/platform/imx/vpu-8q/vpu_dbg.c
new file mode 100644
index 000000000000..480770068659
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_dbg.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"DEBUG"
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-device.h>
+#include <linux/debugfs.h>
+#include "vpu.h"
+#include "vpu_defs.h"
+#include "vpu_helpers.h"
+#include "vpu_cmds.h"
+#include "vpu_rpc.h"
+#include "vpu_log.h"
+
+struct print_buf_desc {
+	u32 start_h_phy;
+	u32 start_h_vir;
+	u32 start_m;
+	u32 bytes;
+	u32 read;
+	u32 write;
+	char buffer[0];
+};
+
+static char *vb2_stat_name[] = {
+	[VB2_BUF_STATE_DEQUEUED] = "dequeued",
+	[VB2_BUF_STATE_IN_REQUEST] = "in_request",
+	[VB2_BUF_STATE_PREPARING] = "preparing",
+	[VB2_BUF_STATE_QUEUED] = "queued",
+	[VB2_BUF_STATE_ACTIVE] = "active",
+	[VB2_BUF_STATE_DONE] = "done",
+	[VB2_BUF_STATE_ERROR] = "error",
+};
+
+static char *vpu_stat_name[] = {
+	[VPU_BUF_STATE_IDLE] = "idle",
+	[VPU_BUF_STATE_INUSE] = "inuse",
+	[VPU_BUF_STATE_DECODED] = "decoded",
+	[VPU_BUF_STATE_READY] = "ready",
+	[VPU_BUF_STATE_SKIP] = "skip",
+	[VPU_BUF_STATE_ERROR] = "error",
+};
+
+static int vpu_dbg_instance(struct seq_file *s, void *data)
+{
+	struct vpu_inst *inst = s->private;
+	char str[128];
+	int num;
+	struct vb2_queue *vq;
+	int i;
+
+	num = scnprintf(str, sizeof(str), "[%s]\n", vpu_core_type_desc(inst->type));
+	if (seq_write(s, str, num))
+		return 0;
+
+	num = scnprintf(str, sizeof(str), "tgig = %d,pid = %d\n", inst->tgid, inst->pid);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str), "state = %d\n", inst->state);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str),
+			"min_buffer_out = %d, min_buffer_cap = %d\n",
+			inst->min_buffer_out, inst->min_buffer_cap);
+	if (seq_write(s, str, num))
+		return 0;
+
+
+	vq = v4l2_m2m_get_src_vq(inst->m2m_ctx);
+	num = scnprintf(str, sizeof(str),
+			"output(%d) : fmt = %c%c%c%c %d x %d, %d;",
+			vb2_is_streaming(vq),
+			inst->out_format.pixfmt,
+			inst->out_format.pixfmt >> 8,
+			inst->out_format.pixfmt >> 16,
+			inst->out_format.pixfmt >> 24,
+			inst->out_format.width,
+			inst->out_format.height,
+			vq->last_buffer_dequeued);
+	if (seq_write(s, str, num))
+		return 0;
+	for (i = 0; i < inst->out_format.num_planes; i++) {
+		num = scnprintf(str, sizeof(str), " %d(%d)",
+				inst->out_format.sizeimage[i],
+				inst->out_format.bytesperline[i]);
+		if (seq_write(s, str, num))
+			return 0;
+	}
+	if (seq_write(s, "\n", 1))
+		return 0;
+
+	vq = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	num = scnprintf(str, sizeof(str),
+			"capture(%d): fmt = %c%c%c%c %d x %d, %d;",
+			vb2_is_streaming(vq),
+			inst->cap_format.pixfmt,
+			inst->cap_format.pixfmt >> 8,
+			inst->cap_format.pixfmt >> 16,
+			inst->cap_format.pixfmt >> 24,
+			inst->cap_format.width,
+			inst->cap_format.height,
+			vq->last_buffer_dequeued);
+	if (seq_write(s, str, num))
+		return 0;
+	for (i = 0; i < inst->cap_format.num_planes; i++) {
+		num = scnprintf(str, sizeof(str), " %d(%d)",
+				inst->cap_format.sizeimage[i],
+				inst->cap_format.bytesperline[i]);
+		if (seq_write(s, str, num))
+			return 0;
+	}
+	if (seq_write(s, "\n", 1))
+		return 0;
+	num = scnprintf(str, sizeof(str), "crop: (%d, %d) %d x %d\n",
+			inst->crop.left,
+			inst->crop.top,
+			inst->crop.width,
+			inst->crop.height);
+	if (seq_write(s, str, num))
+		return 0;
+
+	vq = v4l2_m2m_get_src_vq(inst->m2m_ctx);
+	for (i = 0; i < vq->num_buffers; i++) {
+		struct vb2_buffer *vb = vq->bufs[i];
+		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+		struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+		if (vb->state == VB2_BUF_STATE_DEQUEUED)
+			continue;
+		num = scnprintf(str, sizeof(str),
+				"output [%2d] state = %10s, %8s\n",
+				i, vb2_stat_name[vb->state],
+				vpu_stat_name[vpu_buf->state]);
+		if (seq_write(s, str, num))
+			return 0;
+	}
+
+	vq = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	for (i = 0; i < vq->num_buffers; i++) {
+		struct vb2_buffer *vb = vq->bufs[i];
+		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+		struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+		if (vb->state == VB2_BUF_STATE_DEQUEUED)
+			continue;
+		num = scnprintf(str, sizeof(str),
+				"capture[%2d] state = %10s, %8s\n",
+				i, vb2_stat_name[vb->state],
+				vpu_stat_name[vpu_buf->state]);
+		if (seq_write(s, str, num))
+			return 0;
+	}
+
+	num = scnprintf(str, sizeof(str), "sequence = %d\n", inst->sequence);
+	if (seq_write(s, str, num))
+		return 0;
+
+	if (inst->use_stream_buffer) {
+		num = scnprintf(str, sizeof(str), "stream_buffer = %d / %d, [0x%llx, 0x%llx]\n",
+				vpu_helper_get_used_space(inst),
+				inst->stream_buffer.length,
+				inst->stream_buffer.phys,
+				inst->stream_buffer.phys + inst->stream_buffer.length);
+		if (seq_write(s, str, num))
+			return 0;
+	}
+	num = scnprintf(str, sizeof(str), "kfifo len = 0x%x\n", kfifo_len(&inst->msg_fifo));
+	if (seq_write(s, str, num))
+		return 0;
+
+	num = scnprintf(str, sizeof(str), "flow :\n");
+	if (seq_write(s, str, num))
+		return 0;
+
+	mutex_lock(&inst->core->cmd_lock);
+	for (i = 0; i < ARRAY_SIZE(inst->flows); i++) {
+		u32 idx = (inst->flow_idx + i) % (ARRAY_SIZE(inst->flows));
+
+		if (!inst->flows[idx])
+			continue;
+		num = scnprintf(str, sizeof(str), "\t[%s]0x%x\n",
+				inst->flows[idx] >= VPU_MSG_ID_NOOP ? "M" : "C",
+				inst->flows[idx]);
+		if (seq_write(s, str, num)) {
+			mutex_unlock(&inst->core->cmd_lock);
+			return 0;
+		}
+	}
+	mutex_unlock(&inst->core->cmd_lock);
+
+	i = 0;
+	while (true) {
+		num = call_vop(inst, get_debug_info, str, sizeof(str), i++);
+		if (num <= 0)
+			break;
+		if (seq_write(s, str, num))
+			return 0;
+	}
+
+	return 0;
+}
+
+static int vpu_dbg_core(struct seq_file *s, void *data)
+{
+	struct vpu_core *core = s->private;
+	struct vpu_shared_addr *iface = core->iface;
+	char str[128];
+	int num;
+
+	num = scnprintf(str, sizeof(str), "[%s]\n", vpu_core_type_desc(core->type));
+	if (seq_write(s, str, num))
+		return 0;
+
+	num = scnprintf(str, sizeof(str), "boot_region  = <0x%08llx, 0x%x>\n",
+			core->fw.phys, core->fw.length);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str), "rpc_region   = <0x%08llx, 0x%x> used = 0x%x\n",
+			core->rpc.phys, core->rpc.length, core->rpc.bytesused);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str), "fwlog_region = <0x%08llx, 0x%x>\n",
+			core->log.phys, core->log.length);
+	if (seq_write(s, str, num))
+		return 0;
+
+	num = scnprintf(str, sizeof(str), "state = %d\n", core->state);
+	if (seq_write(s, str, num))
+		return 0;
+	if (core->state == VPU_CORE_DEINIT)
+		return 0;
+	num = scnprintf(str, sizeof(str), "fw version = %d.%d.%d\n",
+				(core->fw_version >> 16) & 0xff,
+				(core->fw_version >> 8) & 0xff,
+				core->fw_version & 0xff);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str), "instances = %d/%d (0x%02lx), %d\n",
+			hweight32(core->instance_mask),
+			core->supported_instance_count,
+			core->instance_mask,
+			core->request_count);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str), "kfifo len = 0x%x\n", kfifo_len(&core->msg_fifo));
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str),
+			"cmd_buf:[0x%x, 0x%x], wptr = 0x%x, rptr = 0x%x\n",
+			iface->cmd_desc->start,
+			iface->cmd_desc->end,
+			iface->cmd_desc->wptr,
+			iface->cmd_desc->rptr);
+	if (seq_write(s, str, num))
+		return 0;
+	num = scnprintf(str, sizeof(str),
+			"msg_buf:[0x%x, 0x%x], wptr = 0x%x, rptr = 0x%x\n",
+			iface->msg_desc->start,
+			iface->msg_desc->end,
+			iface->msg_desc->wptr,
+			iface->msg_desc->rptr);
+	if (seq_write(s, str, num))
+		return 0;
+
+	return 0;
+}
+
+static int vpu_dbg_fwlog(struct seq_file *s, void *data)
+{
+	struct vpu_core *core = s->private;
+	struct print_buf_desc *print_buf;
+	int length;
+	u32 rptr;
+	u32 wptr;
+	int ret = 0;
+
+	if (!core->log.virt || core->state == VPU_CORE_DEINIT)
+		return 0;
+
+	print_buf = core->log.virt;
+	rptr = print_buf->read;
+	wptr = print_buf->write;
+
+	if (rptr == wptr)
+		return 0;
+	else if (rptr < wptr)
+		length = wptr - rptr;
+	else
+		length = print_buf->bytes + wptr - rptr;
+
+	if (s->count + length >= s->size) {
+		s->count = s->size;
+		return 0;
+	}
+
+	if (rptr + length >= print_buf->bytes) {
+		int num = print_buf->bytes - rptr;
+
+		if (seq_write(s, print_buf->buffer + rptr, num))
+			ret = -1;
+		length -= num;
+		rptr = 0;
+	}
+
+	if (length) {
+		if (seq_write(s, print_buf->buffer + rptr, length))
+			ret = -1;
+		rptr += length;
+	}
+	if (!ret)
+		print_buf->read = rptr;
+
+	return 0;
+}
+
+static int vpu_dbg_inst_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, vpu_dbg_instance, inode->i_private);
+}
+
+static ssize_t vpu_dbg_inst_write(struct file *file,
+			const char __user *user_buf, size_t size, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct vpu_inst *inst = s->private;
+
+	vpu_session_debug(inst);
+
+	return size;
+}
+
+static ssize_t vpu_dbg_core_write(struct file *file,
+			const char __user *user_buf, size_t size, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct vpu_core *core = s->private;
+
+	pm_runtime_get_sync(core->dev);
+	mutex_lock(&core->lock);
+	if (core->state != VPU_CORE_DEINIT && !core->instance_mask) {
+		core_dbg(core, LVL_INFO, "reset core\n");
+		if (!vpu_core_sw_reset(core)) {
+			core->state = VPU_CORE_ACTIVE;
+			core->hang_mask = 0;
+		}
+	}
+	mutex_unlock(&core->lock);
+	pm_runtime_put_sync(core->dev);
+
+	return size;
+}
+
+static int vpu_dbg_core_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, vpu_dbg_core, inode->i_private);
+}
+
+static int vpu_dbg_fwlog_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, vpu_dbg_fwlog, inode->i_private);
+}
+
+static const struct file_operations vpu_dbg_inst_fops = {
+	.owner = THIS_MODULE,
+	.open = vpu_dbg_inst_open,
+	.release = single_release,
+	.read = seq_read,
+	.write = vpu_dbg_inst_write,
+};
+
+static const struct file_operations vpu_dbg_core_fops = {
+	.owner = THIS_MODULE,
+	.open = vpu_dbg_core_open,
+	.release = single_release,
+	.read = seq_read,
+	.write = vpu_dbg_core_write,
+};
+
+static const struct file_operations vpu_dbg_fwlog_fops = {
+	.owner = THIS_MODULE,
+	.open = vpu_dbg_fwlog_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+int vpu_inst_create_dbgfs_file(struct vpu_inst *inst)
+{
+	struct vpu_dev *vpu;
+	char name[64];
+
+	if (!inst || !inst->core || !inst->core->vpu)
+		return -EINVAL;
+
+	vpu = inst->core->vpu;
+	if (!vpu->debugfs)
+		return -EINVAL;
+
+	if (inst->debugfs)
+		return 0;
+
+	scnprintf(name, sizeof(name), "instance.%d.%d",
+			inst->core->id, inst->id);
+	inst->debugfs = debugfs_create_file((const char *)name,
+				VERIFY_OCTAL_PERMISSIONS(0644),
+				vpu->debugfs,
+				inst,
+				&vpu_dbg_inst_fops);
+	if (!inst->debugfs) {
+		vpu_err("vpu create debugfs %s fail\n", name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vpu_inst_remove_dbgfs_file(struct vpu_inst *inst)
+{
+	if (!inst)
+		return 0;
+
+	debugfs_remove(inst->debugfs);
+	inst->debugfs = NULL;
+
+	return 0;
+}
+
+int vpu_core_create_dbgfs_file(struct vpu_core *core)
+{
+	struct vpu_dev *vpu;
+	char name[64];
+
+	if (!core || !core->vpu)
+		return -EINVAL;
+
+	vpu = core->vpu;
+	if (!vpu->debugfs)
+		return -EINVAL;
+
+	if (!core->debugfs) {
+		scnprintf(name, sizeof(name), "core.%d", core->id);
+		core->debugfs = debugfs_create_file((const char *)name,
+					VERIFY_OCTAL_PERMISSIONS(0644),
+					vpu->debugfs,
+					core,
+					&vpu_dbg_core_fops);
+		if (!core->debugfs) {
+			vpu_err("vpu create debugfs %s fail\n", name);
+			return -EINVAL;
+		}
+	}
+	if (!core->debugfs_fwlog) {
+		scnprintf(name, sizeof(name), "fwlog.%d", core->id);
+		core->debugfs_fwlog = debugfs_create_file((const char *)name,
+					VERIFY_OCTAL_PERMISSIONS(0444),
+					vpu->debugfs,
+					core,
+					&vpu_dbg_fwlog_fops);
+		if (!core->debugfs_fwlog) {
+			vpu_err("vpu create debugfs %s fail\n", name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int vpu_core_remove_dbgfs_file(struct vpu_core *core)
+{
+	if (!core)
+		return 0;
+	debugfs_remove(core->debugfs);
+	core->debugfs = NULL;
+	debugfs_remove(core->debugfs_fwlog);
+	core->debugfs_fwlog = NULL;
+
+	return 0;
+}
+
+void vpu_inst_record_flow(struct vpu_inst *inst, u32 flow)
+{
+	if (!inst)
+		return;
+
+	inst->flows[inst->flow_idx] = flow;
+	inst->flow_idx = (inst->flow_idx + 1) % (ARRAY_SIZE(inst->flows));
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_defs.h b/drivers/media/platform/imx/vpu-8q/vpu_defs.h
new file mode 100644
index 000000000000..308f461486c0
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_defs.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_DEFS_H
+#define _IMX_VPU_DEFS_H
+
+enum MSG_TYPE {
+	INIT_DONE = 1,
+	PRC_BUF_OFFSET,
+	BOOT_ADDRESS,
+	COMMAND,
+	EVENT,
+};
+
+enum {
+	VPU_IRQ_CODE_BOOT_DONE = 0x55,
+	VPU_IRQ_CODE_SNAPSHOT_DONE = 0xa5,
+	VPU_IRQ_CODE_SYNC = 0xaa,
+};
+
+enum {
+	VPU_CMD_ID_NOOP = 0x0,
+	VPU_CMD_ID_CONFIGURE_CODEC,
+	VPU_CMD_ID_START,
+	VPU_CMD_ID_STOP,
+	VPU_CMD_ID_ABORT,
+	VPU_CMD_ID_RST_BUF,
+	VPU_CMD_ID_SNAPSHOT,
+	VPU_CMD_ID_FIRM_RESET,
+	VPU_CMD_ID_UPDATE_PARAMETER,
+	VPU_CMD_ID_FRAME_ENCODE,
+	VPU_CMD_ID_SKIP,
+	VPU_CMD_ID_PARSE_NEXT_SEQ,
+	VPU_CMD_ID_PARSE_NEXT_I,
+	VPU_CMD_ID_PARSE_NEXT_IP,
+	VPU_CMD_ID_PARSE_NEXT_ANY,
+	VPU_CMD_ID_DEC_PIC,
+	VPU_CMD_ID_FS_ALLOC,
+	VPU_CMD_ID_FS_RELEASE,
+	VPU_CMD_ID_TIMESTAMP,
+	VPU_CMD_ID_DEBUG
+};
+
+enum {
+	VPU_MSG_ID_NOOP = 0x100,
+	VPU_MSG_ID_RESET_DONE,
+	VPU_MSG_ID_START_DONE,
+	VPU_MSG_ID_STOP_DONE,
+	VPU_MSG_ID_ABORT_DONE,
+	VPU_MSG_ID_BUF_RST,
+	VPU_MSG_ID_MEM_REQUEST,
+	VPU_MSG_ID_PARAM_UPD_DONE,
+	VPU_MSG_ID_FRAME_INPUT_DONE,
+	VPU_MSG_ID_ENC_DONE,
+	VPU_MSG_ID_DEC_DONE,
+	VPU_MSG_ID_FRAME_REQ,
+	VPU_MSG_ID_FRAME_RELEASE,
+	VPU_MSG_ID_SEQ_HDR_FOUND,
+	VPU_MSG_ID_RES_CHANGE,
+	VPU_MSG_ID_PIC_HDR_FOUND,
+	VPU_MSG_ID_PIC_DECODED,
+	VPU_MSG_ID_PIC_EOS,
+	VPU_MSG_ID_FIFO_LOW,
+	VPU_MSG_ID_FIFO_HIGH,
+	VPU_MSG_ID_FIFO_EMPTY,
+	VPU_MSG_ID_FIFO_FULL,
+	VPU_MSG_ID_BS_ERROR,
+	VPU_MSG_ID_UNSUPPORTED,
+	VPU_MSG_ID_TIMESTAMP_INFO,
+
+	VPU_MSG_ID_FIRMWARE_XCPT,
+};
+
+enum VPU_ENC_MEMORY_RESOURSE {
+	MEM_RES_ENC,
+	MEM_RES_REF,
+	MEM_RES_ACT
+};
+
+enum VPU_DEC_MEMORY_RESOURCE {
+	MEM_RES_FRAME,
+	MEM_RES_MBI,
+	MEM_RES_DCP
+};
+
+enum VPU_SCODE_TYPE {
+	SCODE_PADDING_EOS = 1,
+	SCODE_PADDING_BUFFLUSH = 2,
+	SCODE_PADDING_ABORT = 3,
+	SCODE_SEQUENCE = 0x31,
+	SCODE_PICTURE = 0x32,
+	SCODE_SLICE = 0x33
+};
+
+struct vpu_pkt_mem_req_data {
+	u32 enc_frame_size;
+	u32 enc_frame_num;
+	u32 ref_frame_size;
+	u32 ref_frame_num;
+	u32 act_buf_size;
+	u32 act_buf_num;
+};
+
+struct vpu_enc_pic_info {
+	u32 frame_id;
+	u32 pic_type;
+	u32 skipped_frame;
+	u32 error_flag;
+	u32 psnr;
+	u32 frame_size;
+	u32 wptr;
+	u32 crc;
+	s64 timestamp;
+};
+
+struct vpu_dec_codec_info {
+	u32 pixfmt;
+	u32 num_ref_frms;
+	u32 num_dpb_frms;
+	u32 num_dfe_area;
+	u32 color_primaries;
+	u32 transfer_chars;
+	u32 matrix_coeffs;
+	u32 full_range;
+	u32 vui_present;
+	u32 progressive;
+	u32 width;
+	u32 height;
+	u32 decoded_width;
+	u32 decoded_height;
+	u32 frame_rate;
+	u32 dsp_asp_ratio;
+	u32 level_idc;
+	u32 bit_depth_luma;
+	u32 bit_depth_chroma;
+	u32 chroma_fmt;
+	u32 mvc_num_views;
+	u32 offset_x;
+	u32 offset_y;
+	u32 tag;
+	u32 sizeimage[VIDEO_MAX_PLANES];
+	u32 bytesperline[VIDEO_MAX_PLANES];
+	u32 mbi_size;
+	u32 dcp_size;
+};
+
+struct vpu_dec_pic_info {
+	u32 id;
+	u32 luma;
+	u32 start;
+	u32 end;
+	u32 pic_size;
+	u32 stride;
+	u32 skipped;
+	s64 timestamp;
+	u32 consumed_count;
+};
+
+struct vpu_fs_info {
+	u32 id;
+	u32 type;
+	u32 tag;
+	u32 luma_addr;
+	u32 luma_size;
+	u32 chroma_addr;
+	u32 chromau_size;
+	u32 chromav_addr;
+	u32 chromav_size;
+	u32 bytesperline;
+	u32 not_displayed;
+};
+
+struct vpu_ts_info {
+	s64 timestamp;
+	u32 size;
+};
+
+#define BITRATE_STEP		(1024)
+#define BITRATE_MIN		(16 * BITRATE_STEP)
+#define BITRATE_MAX		(240 * 1024 * BITRATE_STEP)
+#define BITRATE_DEFAULT		(2 * 1024 * BITRATE_STEP)
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_dev_imx8q.c b/drivers/media/platform/imx/vpu-8q/vpu_dev_imx8q.c
new file mode 100644
index 000000000000..e88b0693ea8e
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_dev_imx8q.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include "vpu.h"
+#include "vpu_imx8q.h"
+
+int vpu_imx8q_setup_dec(struct vpu_dev *vpu)
+{
+	const off_t offset = DEC_MFD_XREG_SLV_BASE + MFD_BLK_CTRL;
+
+	vpu_writel(vpu, offset + MFD_BLK_CTRL_MFD_SYS_CLOCK_ENABLE_SET, 0x1f);
+	vpu_writel(vpu, offset + MFD_BLK_CTRL_MFD_SYS_RESET_SET, 0xffffffff);
+
+	return 0;
+}
+
+int vpu_imx8q_setup_enc(struct vpu_dev *vpu)
+{
+	return 0;
+}
+
+int vpu_imx8q_setup(struct vpu_dev *vpu)
+{
+	const off_t offset = SCB_XREG_SLV_BASE + SCB_SCB_BLK_CTRL;
+	u32 read_data;
+
+	read_data = vpu_readl(vpu, offset + 0x108);
+
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_SCB_CLK_ENABLE_SET, 0x1);
+	vpu_writel(vpu, offset + 0x190, 0xffffffff);
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_XMEM_RESET_SET, 0xffffffff);
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_SCB_CLK_ENABLE_SET, 0xE);
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_CACHE_RESET_SET, 0x7);
+	vpu_writel(vpu, XMEM_CONTROL, 0x102);
+
+	read_data = vpu_readl(vpu, offset + 0x108);
+
+	return 0;
+}
+
+static int vpu_imx8q_reset_enc(struct vpu_dev *vpu)
+{
+	return 0;
+}
+
+static int vpu_imx8q_reset_dec(struct vpu_dev *vpu)
+{
+	const off_t offset = DEC_MFD_XREG_SLV_BASE + MFD_BLK_CTRL;
+
+	vpu_writel(vpu, offset + MFD_BLK_CTRL_MFD_SYS_RESET_CLR, 0xffffffff);
+
+	return 0;
+}
+
+int vpu_imx8q_reset(struct vpu_dev *vpu)
+{
+	const off_t offset = SCB_XREG_SLV_BASE + SCB_SCB_BLK_CTRL;
+
+	vpu_writel(vpu, offset + SCB_BLK_CTRL_CACHE_RESET_CLR, 0x7);
+	vpu_imx8q_reset_enc(vpu);
+	vpu_imx8q_reset_dec(vpu);
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_drv.c b/drivers/media/platform/imx/vpu-8q/vpu_drv.c
new file mode 100644
index 000000000000..acc69899a828
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_drv.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dma-map-ops.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <linux/of_reserved_mem.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <linux/debugfs.h>
+#include "vpu.h"
+#include "vpu_imx8q.h"
+
+void vpu_writel(struct vpu_dev *vpu, u32 reg, u32 val)
+{
+	writel(val, vpu->base + reg);
+}
+
+u32 vpu_readl(struct vpu_dev *vpu, u32 reg)
+{
+	return readl(vpu->base + reg);
+}
+
+static void vpu_dev_get(struct vpu_dev *vpu)
+{
+	if (atomic_inc_return(&vpu->ref_vpu) == 1 && vpu->res->setup)
+		vpu->res->setup(vpu);
+}
+
+static void vpu_dev_put(struct vpu_dev *vpu)
+{
+	atomic_dec(&vpu->ref_vpu);
+}
+
+static void vpu_enc_get(struct vpu_dev *vpu)
+{
+	if (atomic_inc_return(&vpu->ref_enc) == 1 && vpu->res->setup_encoder)
+		vpu->res->setup_encoder(vpu);
+}
+
+static void vpu_enc_put(struct vpu_dev *vpu)
+{
+	atomic_dec(&vpu->ref_enc);
+}
+
+static void vpu_dec_get(struct vpu_dev *vpu)
+{
+	if (atomic_inc_return(&vpu->ref_dec) == 1 && vpu->res->setup_decoder)
+		vpu->res->setup_decoder(vpu);
+}
+
+static void vpu_dec_put(struct vpu_dev *vpu)
+{
+	atomic_dec(&vpu->ref_dec);
+}
+
+static void vpu_init_reserved_memory(struct vpu_dev *vpu)
+{
+	struct device_node *node;
+	struct resource res;
+	int ret;
+
+	if (!vpu || !vpu->dev)
+		return;
+
+	node = of_parse_phandle(vpu->dev->of_node, "memory-region", 0);
+	if (!node)
+		return;
+	if (of_address_to_resource(node, 0, &res))
+		return;
+
+	ret = of_reserved_mem_device_init(vpu->dev);
+	if (ret) {
+		pr_err("vpu declare reserved dma fail, ret = %d\n", ret);
+		return;
+	}
+	vpu->memory.phys = res.start;
+	vpu->memory.length = resource_size(&res);
+}
+
+static int vpu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vpu_dev *vpu;
+	struct resource *r;
+	int ret;
+
+	vpu = devm_kzalloc(dev, sizeof(*vpu), GFP_KERNEL);
+	if (!vpu)
+		return -ENOMEM;
+
+	vpu->pdev = pdev;
+	vpu->dev = dev;
+	mutex_init(&vpu->lock);
+	INIT_LIST_HEAD(&vpu->cores);
+	platform_set_drvdata(pdev, vpu);
+	atomic_set(&vpu->ref_vpu, 0);
+	atomic_set(&vpu->ref_enc, 0);
+	atomic_set(&vpu->ref_dec, 0);
+	vpu->get_vpu = vpu_dev_get;
+	vpu->put_vpu = vpu_dev_put;
+	vpu->get_enc = vpu_enc_get;
+	vpu->put_enc = vpu_enc_put;
+	vpu->get_dec = vpu_dec_get;
+	vpu->put_dec = vpu_dec_put;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	vpu->base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(vpu->base))
+		return PTR_ERR(vpu->base);
+
+	vpu->res = of_device_get_match_data(dev);
+	if (!vpu->res)
+		return -ENODEV;
+
+	vpu_init_reserved_memory(vpu);
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret)
+		goto err_runtime_disable;
+
+	pm_runtime_put_sync(dev);
+
+	ret = v4l2_device_register(dev, &vpu->v4l2_dev);
+	if (ret)
+		goto err_vpu_deinit;
+
+	vpu->debugfs = debugfs_create_dir("vpu-8q", NULL);
+
+	return 0;
+
+err_vpu_deinit:
+err_runtime_disable:
+	pm_runtime_set_suspended(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int vpu_remove(struct platform_device *pdev)
+{
+	struct vpu_dev *vpu = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	WARN_ON(ret < 0);
+
+	debugfs_remove_recursive(vpu->debugfs);
+	vpu->debugfs = NULL;
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	v4l2_device_unregister(&vpu->v4l2_dev);
+	mutex_destroy(&vpu->lock);
+
+	return 0;
+}
+
+static int __maybe_unused vpu_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused vpu_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused vpu_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused vpu_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops vpu_pm_ops = {
+	SET_RUNTIME_PM_OPS(vpu_runtime_suspend, vpu_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(vpu_suspend, vpu_resume)
+};
+
+struct vpu_resources imx8qxp_res = {
+	.plat_type = IMX8QXP,
+	.mreg_base = 0x40000000,
+	.setup = vpu_imx8q_setup,
+	.setup_encoder = vpu_imx8q_setup_enc,
+	.setup_decoder = vpu_imx8q_setup_dec,
+	.reset = vpu_imx8q_reset
+};
+
+struct vpu_resources imx8qm_res = {
+	.plat_type = IMX8QM,
+	.mreg_base = 0x40000000,
+	.setup = vpu_imx8q_setup,
+	.setup_encoder = vpu_imx8q_setup_enc,
+	.setup_decoder = vpu_imx8q_setup_dec,
+	.reset = vpu_imx8q_reset
+};
+
+static const struct of_device_id vpu_dt_match[] = {
+	{ .compatible = "nxp,imx8qxp-vpu", .data = &imx8qxp_res },
+	{ .compatible = "nxp,imx8qm-vpu", .data = &imx8qm_res },
+	{}
+};
+MODULE_DEVICE_TABLE(of, vpu_dt_match);
+
+static struct platform_driver imx_vpu_driver = {
+	.probe = vpu_probe,
+	.remove = vpu_remove,
+	.driver = {
+		.name = "imx-vpu",
+		.of_match_table = vpu_dt_match,
+		.pm = &vpu_pm_ops,
+	},
+};
+module_platform_driver(imx_vpu_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Linux VPU driver for Freescale i.MX/MXC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_helpers.c b/drivers/media/platform/imx/vpu-8q/vpu_helpers.c
new file mode 100644
index 000000000000..c21da2f26163
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_helpers.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"HELPER"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_rpc.h"
+#include "vpu_helpers.h"
+#include "vpu_log.h"
+
+int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (array[i] == x)
+			return i;
+	}
+
+	return 0;
+}
+
+bool vpu_helper_check_type(struct vpu_inst *inst, u32 type)
+{
+	const struct vpu_format *pfmt;
+
+	for (pfmt = inst->formats; pfmt->pixfmt; pfmt++) {
+		if (vpu_core_check_fmt(inst->core, pfmt->pixfmt))
+			continue;
+		if (pfmt->type == type)
+			return true;
+	}
+
+	return false;
+}
+
+const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt)
+{
+	const struct vpu_format *pfmt;
+
+	if (!inst || !inst->formats)
+		return NULL;
+
+	if (vpu_core_check_fmt(inst->core, pixelfmt))
+		return NULL;
+
+	for (pfmt = inst->formats; pfmt->pixfmt; pfmt++) {
+		if (vpu_core_check_fmt(inst->core, pfmt->pixfmt))
+			continue;
+
+		if (pfmt->pixfmt == pixelfmt && (!type || type == pfmt->type))
+			return pfmt;
+	}
+
+	return NULL;
+}
+
+const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index)
+{
+	const struct vpu_format *pfmt;
+	int i = 0;
+
+	if (!inst || !inst->formats)
+		return NULL;
+
+	for (pfmt = inst->formats; pfmt->pixfmt; pfmt++) {
+		if (vpu_core_check_fmt(inst->core, pfmt->pixfmt))
+			continue;
+
+		if (pfmt->type == type) {
+			if (index == i)
+				return pfmt;
+			i++;
+		}
+	}
+
+	return NULL;
+}
+
+u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width)
+{
+	const struct vpu_core_resources *res;
+
+	if (!inst || !inst->core || !inst->core->res)
+		return width;
+
+	res = inst->core->res;
+	if (res->max_width)
+		width = clamp(width, res->min_width, res->max_width);
+	if (res->step_width)
+		width = ALIGN(width, res->step_width);
+
+	return width;
+}
+
+u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height)
+{
+	const struct vpu_core_resources *res;
+
+	if (!inst || !inst->core || !inst->core->res)
+		return height;
+
+	res = inst->core->res;
+	if (res->max_height)
+		height = clamp(height, res->min_height, res->max_height);
+	if (res->step_height)
+		height = ALIGN(height, res->step_height);
+
+	return height;
+}
+
+u32 vpu_helper_get_frame_size(u32 fmt, u32 width, u32 height)
+{
+	switch (fmt) {
+	case V4L2_PIX_FMT_NV12:
+		return ((width * 3) >> 1) * height;
+	default:
+		return width * height;
+	}
+}
+
+u32 vpu_helper_get_plane_size(u32 fmt, u32 width, u32 height, int plane_no, u32 stride)
+{
+	width = ALIGN(width, stride);
+
+	switch (fmt) {
+	case V4L2_PIX_FMT_NV12:
+		if (plane_no == 0)
+			return width * height;
+		else if (plane_no == 1)
+			return (width >> 1) * height;
+		else
+			return 0;
+	default:
+		if (plane_no == 0)
+			return width * height;
+		else
+			return 0;
+	}
+}
+
+u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
+					u32 *rptr, u32 size, void *dst)
+{
+	u32 offset;
+	u32 start;
+	u32 end;
+	void *virt;
+
+	if (!stream_buffer || !rptr || !dst)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	offset = *rptr;
+	start = stream_buffer->phys;
+	end = start + stream_buffer->length;
+	virt = stream_buffer->virt;
+
+	if (offset < start || offset > end) {
+		vpu_err("rptr 0x%x is out of range [0x%x, 0x%x]\n",
+				offset, start, end);
+		return -EINVAL;
+	}
+
+	if (offset + size <= end) {
+		memcpy(dst, virt + (offset - start), size);
+	} else {
+		memcpy(dst, virt + (offset - start), end - offset);
+		memcpy(dst + end - offset, virt, size + offset - end);
+	}
+
+	*rptr = vpu_helper_step_walk(stream_buffer, offset, size);
+	return size;
+}
+
+u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u32 size, void *src)
+{
+	u32 offset;
+	u32 start;
+	u32 end;
+	void *virt;
+
+	if (!stream_buffer || !wptr || !src)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	offset = *wptr;
+	start = stream_buffer->phys;
+	end = start + stream_buffer->length;
+	virt = stream_buffer->virt;
+	if (offset < start || offset > end) {
+		vpu_err("wptr 0x%x is out of range [0x%x, 0x%x]\n",
+				offset, start, end);
+		return -EINVAL;
+	}
+
+	if (offset + size <= end) {
+		memcpy(virt + (offset - start), src, size);
+	} else {
+		memcpy(virt + (offset - start), src, end - offset);
+		memcpy(virt, src + end - offset, size + offset - end);
+	}
+
+	*wptr = vpu_helper_step_walk(stream_buffer, offset, size);
+
+	return size;
+}
+
+u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u8 val, u32 size)
+{
+	u32 offset;
+	u32 start;
+	u32 end;
+	void *virt;
+
+	if (!stream_buffer || !wptr)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	offset = *wptr;
+	start = stream_buffer->phys;
+	end = start + stream_buffer->length;
+	virt = stream_buffer->virt;
+	if (offset < start || offset > end) {
+		vpu_err("wptr 0x%x is out of range [0x%x, 0x%x]\n",
+				offset, start, end);
+		return -EINVAL;
+	}
+
+	if (offset + size <= end) {
+		memset(virt + (offset - start), val, size);
+	} else {
+		memset(virt + (offset - start), val, end - offset);
+		memset(virt, val, size + offset - end);
+	}
+
+	offset += size;
+	if (offset >= end)
+		offset -= stream_buffer->length;
+
+	*wptr = offset;
+
+	return size;
+}
+
+u32 vpu_helper_get_free_space(struct vpu_inst *inst)
+{
+	struct vpu_rpc_buffer_desc desc;
+
+	if (vpu_iface_get_stream_buffer_desc(inst, &desc))
+		return 0;
+
+	if (desc.rptr > desc.wptr)
+		return desc.rptr - desc.wptr;
+	else if (desc.rptr < desc.wptr)
+		return (desc.end - desc.start + desc.rptr - desc.wptr);
+	else
+		return desc.end - desc.start;
+}
+
+u32 vpu_helper_get_used_space(struct vpu_inst *inst)
+{
+	struct vpu_rpc_buffer_desc desc;
+
+	if (vpu_iface_get_stream_buffer_desc(inst, &desc))
+		return 0;
+
+	if (desc.wptr > desc.rptr)
+		return desc.wptr - desc.rptr;
+	else if (desc.wptr < desc.rptr)
+		return (desc.end - desc.start + desc.wptr - desc.rptr);
+	else
+		return 0;
+}
+
+int vpu_helper_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_inst *inst = ctrl_to_inst(ctrl);
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
+		ctrl->val = inst->min_buffer_cap;
+		break;
+	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
+		ctrl->val = inst->min_buffer_out;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+u32 vpu_helper_calc_coprime(u32 *a, u32 *b)
+{
+	int m = *a;
+	int n = *b;
+
+	if (m == 0)
+		return n;
+	if (n == 0)
+		return m;
+
+	while (n != 0) {
+		int tmp = m % n;
+
+		m = n;
+		n = tmp;
+	}
+	*a = (*a) / m;
+	*b = (*b) / m;
+
+	return m;
+}
+
+#define READ_BYTE(buffer, pos)	(*(u8 *)((buffer)->virt + ((pos) % buffer->length)))
+int vpu_helper_find_startcode(struct vpu_buffer *stream_buffer,
+			u32 pixelformat, u32 offset, u32 bytesused)
+{
+	u32 start_code;
+	int start_code_size;
+	u32 val = 0;
+	int i;
+	int ret = -EINVAL;
+
+	if (!stream_buffer || !stream_buffer->virt)
+		return -EINVAL;
+
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_H264:
+		start_code_size = 4;
+		start_code = 0x00000001;
+		break;
+	default:
+		return 0;
+	}
+
+	for (i = 0; i < bytesused; i++) {
+		val = (val << 8) | READ_BYTE(stream_buffer, offset + i);
+		if (i < start_code_size - 1)
+			continue;
+		if (val == start_code) {
+			ret = i + 1 - start_code_size;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int vpu_find_dst_by_src(struct vpu_pair *pairs, u32 cnt, u32 src)
+{
+	u32 i;
+
+	if (!pairs || !cnt)
+		return -EINVAL;
+
+	for (i = 0; i < cnt; i++) {
+		if (pairs[i].src == src)
+			return pairs[i].dst;
+	}
+
+	return -EINVAL;
+}
+
+int vpu_find_src_by_dst(struct vpu_pair *pairs, u32 cnt, u32 dst)
+{
+	u32 i;
+
+	if (!pairs || !cnt)
+		return -EINVAL;
+
+	for (i = 0; i < cnt; i++) {
+		if (pairs[i].dst == dst)
+			return pairs[i].src;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_helpers.h b/drivers/media/platform/imx/vpu-8q/vpu_helpers.h
new file mode 100644
index 000000000000..3f0acda8522c
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_helpers.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_HELPERS_H
+#define _IMX_VPU_HELPERS_H
+
+struct vpu_pair {
+	u32 src;
+	u32 dst;
+};
+
+#define MAKE_TIMESTAMP(s, ns)		(((s32)(s) * NSEC_PER_SEC) + (ns))
+#define VPU_INVALID_TIMESTAMP		MAKE_TIMESTAMP(-1, 0)
+#define	VPU_ARRAY_AT(array, i)		(((i) < ARRAY_SIZE(array)) ? array[i] : 0)
+#define VPU_ARRAY_FIND(array, x)	vpu_helper_find_in_array_u8(array, ARRAY_SIZE(array), x)
+
+int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x);
+bool vpu_helper_check_type(struct vpu_inst *inst, u32 type);
+const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt);
+const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index);
+u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width);
+u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height);
+u32 vpu_helper_get_frame_size(u32 fmt, u32 width, u32 height);
+u32 vpu_helper_get_plane_size(u32 fmt, u32 width, u32 height, int plane_no, u32 stride);
+u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
+					u32 *rptr, u32 size, void *dst);
+u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u32 size, void *src);
+u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u8 val, u32 size);
+u32 vpu_helper_get_free_space(struct vpu_inst *inst);
+u32 vpu_helper_get_used_space(struct vpu_inst *inst);
+int vpu_helper_g_volatile_ctrl(struct v4l2_ctrl *ctrl);
+u32 vpu_helper_calc_coprime(u32 *a, u32 *b);
+void vpu_helper_get_kmp_next(const u8 *pattern, int *next, int size);
+int vpu_helper_kmp_search(u8 *s, int s_len, const u8 *p, int p_len, int *next);
+int vpu_helper_kmp_search_in_stream_buffer(struct vpu_buffer *stream_buffer,
+					u32 offset, int bytesused,
+					const u8 *p, int p_len, int *next);
+int vpu_helper_find_startcode(struct vpu_buffer *stream_buffer,
+			u32 pixelformat, u32 offset, u32 bytesused);
+
+static inline u32 vpu_helper_step_walk(struct vpu_buffer *stream_buffer, u32 pos, u32 step)
+{
+	pos += step;
+	if (pos > stream_buffer->phys + stream_buffer->length)
+		pos -= stream_buffer->length;
+
+	return pos;
+}
+
+int vpu_color_check_primaries(u32 primaries);
+int vpu_color_check_transfers(u32 transfers);
+int vpu_color_check_matrix(u32 matrix);
+int vpu_color_check_full_range(u32 full_range);
+u32 vpu_color_cvrt_primaries_v2i(u32 primaries);
+u32 vpu_color_cvrt_primaries_i2v(u32 primaries);
+u32 vpu_color_cvrt_transfers_v2i(u32 transfers);
+u32 vpu_color_cvrt_transfers_i2v(u32 transfers);
+u32 vpu_color_cvrt_matrix_v2i(u32 matrix);
+u32 vpu_color_cvrt_matrix_i2v(u32 matrix);
+u32 vpu_color_cvrt_full_range_v2i(u32 full_range);
+u32 vpu_color_cvrt_full_range_i2v(u32 full_range);
+int vpu_color_get_default(u32 primaries,
+		u32 *ptransfers, u32 *pmatrix, u32 *pfull_range);
+
+int vpu_find_dst_by_src(struct vpu_pair *pairs, u32 cnt, u32 src);
+int vpu_find_src_by_dst(struct vpu_pair *pairs, u32 cnt, u32 dst);
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_imx8q.c b/drivers/media/platform/imx/vpu-8q/vpu_imx8q.c
new file mode 100644
index 000000000000..ee1ed1b02256
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_imx8q.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"IMX8Q"
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_imx8q.h"
+#include "vpu_rpc.h"
+#include "vpu_log.h"
+
+#define IMX8Q_CSR_CM0Px_ADDR_OFFSET			0x00000000
+#define IMX8Q_CSR_CM0Px_CPUWAIT				0x00000004
+
+#ifdef CONFIG_IMX_SCU
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/svc/misc.h>
+
+#define VPU_DISABLE_BITS			0x7
+#define VPU_IMX_DECODER_FUSE_OFFSET		14
+#define VPU_ENCODER_MASK			0x1
+#define VPU_DECODER_MASK			0x3UL
+#define VPU_DECODER_H264_MASK			0x2UL
+#define VPU_DECODER_HEVC_MASK			0x1UL
+
+static u32 imx8q_fuse;
+
+struct vpu_sc_msg_misc {
+	struct imx_sc_rpc_msg hdr;
+	u32 word;
+} __packed;
+#endif
+
+int vpu_imx8q_set_system_cfg_common(struct vpu_rpc_system_config *config,
+		u32 regs, u32 core_id)
+{
+	if (!config)
+		return -EINVAL;
+
+	switch (core_id) {
+	case 0:
+		config->malone_base_addr[0] = regs + DEC_MFD_XREG_SLV_BASE;
+		config->num_malones = 1;
+		config->num_windsors = 0;
+		break;
+	case 1:
+		config->windsor_base_addr[0] = regs + ENC_MFD_XREG_SLV_0_BASE;
+		config->num_windsors = 1;
+		config->num_malones = 0;
+		break;
+	case 2:
+		config->windsor_base_addr[0] = regs + ENC_MFD_XREG_SLV_1_BASE;
+		config->num_windsors = 1;
+		config->num_malones = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (config->num_windsors) {
+		config->windsor_irq_pin[0x0][0x0] = WINDSOR_PAL_IRQ_PIN_L;
+		config->windsor_irq_pin[0x0][0x1] = WINDSOR_PAL_IRQ_PIN_H;
+	}
+
+	config->malone_base_addr[0x1] = 0x0;
+	config->hif_offset[0x0] = MFD_HIF;
+	config->hif_offset[0x1] = 0x0;
+
+	config->dpv_base_addr = 0x0;
+	config->dpv_irq_pin = 0x0;
+	config->pixif_base_addr = regs + DEC_MFD_XREG_SLV_BASE + MFD_PIX_IF;
+	config->cache_base_addr[0] = regs + MC_CACHE_0_BASE;
+	config->cache_base_addr[1] = regs + MC_CACHE_1_BASE;
+
+	return 0;
+}
+
+int vpu_imx8q_boot_core(struct vpu_core *core)
+{
+	csr_writel(core, IMX8Q_CSR_CM0Px_ADDR_OFFSET, core->fw.phys);
+	csr_writel(core, IMX8Q_CSR_CM0Px_CPUWAIT, 0);
+	return 0;
+}
+
+int vpu_imx8q_get_power_state(struct vpu_core *core)
+{
+	if (csr_readl(core, IMX8Q_CSR_CM0Px_CPUWAIT) == 1)
+		return 0;
+	return 1;
+}
+
+int vpu_imx8q_on_firmware_loaded(struct vpu_core *core)
+{
+	u8 *p;
+
+	p = core->fw.virt;
+	p[16] = core->vpu->res->plat_type;
+	p[17] = core->id;
+	p[18] = 1;
+
+	return 0;
+}
+
+u32 vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size)
+{
+	const struct vpu_rpc_region_t imx8q_regions[] = {
+		{0x00000000, 0x08000000, VPU_CORE_MEMORY_CACHED},
+		{0x08000000, 0x10000000, VPU_CORE_MEMORY_UNCACHED},
+		{0x10000000, 0x20000000, VPU_CORE_MEMORY_CACHED},
+		{0x20000000, 0x40000000, VPU_CORE_MEMORY_UNCACHED}
+	};
+	int i;
+
+	if (addr < base)
+		return VPU_CORE_MEMORY_INVALID;
+
+	addr -= base;
+	for (i = 0; i < ARRAY_SIZE(imx8q_regions); i++) {
+		const struct vpu_rpc_region_t *region = &imx8q_regions[i];
+
+		if (addr >= region->start && addr + size < region->end)
+			return region->type;
+	}
+
+	return VPU_CORE_MEMORY_INVALID;
+}
+
+#ifdef CONFIG_IMX_SCU
+u32 vpu_imx8q_get_fuse(void)
+{
+	static u32 fuse_got;
+	struct imx_sc_ipc *ipc;
+	struct vpu_sc_msg_misc msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	if (fuse_got)
+		return imx8q_fuse;
+
+	ret = imx_scu_get_handle(&ipc);
+	if (ret) {
+		vpu_err("error: scu get handle fail: %d\n", ret);
+		return 0;
+	}
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_OTP_FUSE_READ;
+	hdr->size = 2;
+
+	msg.word = VPU_DISABLE_BITS;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return 0;
+
+	imx8q_fuse = msg.word;
+	fuse_got = 1;
+	vpu_dbg(LVL_INFO, "imx8q fuse = 0x%x\n", imx8q_fuse);
+	return imx8q_fuse;
+}
+
+bool vpu_imx8q_check_codec(enum vpu_core_type type)
+{
+	u32 fuse = vpu_imx8q_get_fuse();
+
+	if (type == VPU_CORE_TYPE_ENC) {
+		if (fuse & VPU_ENCODER_MASK)
+			return false;
+	} else if (type == VPU_CORE_TYPE_DEC) {
+		fuse >>= VPU_IMX_DECODER_FUSE_OFFSET;
+		fuse &= VPU_DECODER_MASK;
+
+		if (fuse == VPU_DECODER_MASK)
+			return false;
+	}
+	return true;
+}
+
+bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt)
+{
+	u32 fuse = vpu_imx8q_get_fuse();
+
+	if (type == VPU_CORE_TYPE_DEC) {
+		fuse >>= VPU_IMX_DECODER_FUSE_OFFSET;
+		fuse &= VPU_DECODER_MASK;
+
+		if (fuse == VPU_DECODER_HEVC_MASK && pixelfmt == V4L2_PIX_FMT_HEVC)
+			return false;
+		if (fuse == VPU_DECODER_H264_MASK && pixelfmt == V4L2_PIX_FMT_H264)
+			return false;
+		if (fuse == VPU_DECODER_MASK)
+			return false;
+	}
+
+	return true;
+}
+#else
+bool vpu_imx8q_check_codec(enum vpu_core_type type)
+{
+	return true;
+}
+
+bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt)
+{
+	return true;
+}
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_imx8q.h b/drivers/media/platform/imx/vpu-8q/vpu_imx8q.h
new file mode 100644
index 000000000000..dfbce235641c
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_imx8q.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_8Q_H
+#define _IMX_VPU_8Q_H
+
+#define SCB_XREG_SLV_BASE                               0x00000000
+#define SCB_SCB_BLK_CTRL                                0x00070000
+#define SCB_BLK_CTRL_XMEM_RESET_SET                     0x00000090
+#define SCB_BLK_CTRL_CACHE_RESET_SET                    0x000000A0
+#define SCB_BLK_CTRL_CACHE_RESET_CLR                    0x000000A4
+#define SCB_BLK_CTRL_SCB_CLK_ENABLE_SET                 0x00000100
+
+#define XMEM_CONTROL                                    0x00041000
+
+#define	MC_CACHE_0_BASE					0x00060000
+#define	MC_CACHE_1_BASE					0x00068000
+
+#define DEC_MFD_XREG_SLV_BASE                           0x00180000
+#define ENC_MFD_XREG_SLV_0_BASE				0x00800000
+#define ENC_MFD_XREG_SLV_1_BASE				0x00A00000
+
+#define MFD_HIF                                         0x0001C000
+#define MFD_HIF_MSD_REG_INTERRUPT_STATUS                0x00000018
+#define MFD_SIF                                         0x0001D000
+#define MFD_SIF_CTRL_STATUS                             0x000000F0
+#define MFD_SIF_INTR_STATUS                             0x000000F4
+#define MFD_MCX                                         0x00020800
+#define MFD_MCX_OFF                                     0x00000020
+#define MFD_PIX_IF					0x00020000
+
+#define MFD_BLK_CTRL                                    0x00030000
+#define MFD_BLK_CTRL_MFD_SYS_RESET_SET                  0x00000000
+#define MFD_BLK_CTRL_MFD_SYS_RESET_CLR                  0x00000004
+#define MFD_BLK_CTRL_MFD_SYS_CLOCK_ENABLE_SET           0x00000100
+#define MFD_BLK_CTRL_MFD_SYS_CLOCK_ENABLE_CLR           0x00000104
+
+#define VID_API_NUM_STREAMS				8
+#define VID_API_MAX_BUF_PER_STR				3
+#define VID_API_MAX_NUM_MVC_VIEWS			4
+#define MEDIAIP_MAX_NUM_MALONES				2
+#define MEDIAIP_MAX_NUM_MALONE_IRQ_PINS			2
+#define MEDIAIP_MAX_NUM_WINDSORS			1
+#define MEDIAIP_MAX_NUM_WINDSOR_IRQ_PINS		2
+#define MEDIAIP_MAX_NUM_CMD_IRQ_PINS			2
+#define MEDIAIP_MAX_NUM_MSG_IRQ_PINS			1
+#define MEDIAIP_MAX_NUM_TIMER_IRQ_PINS			4
+#define MEDIAIP_MAX_NUM_TIMER_IRQ_SLOTS			4
+
+#define WINDSOR_PAL_IRQ_PIN_L				0x4
+#define WINDSOR_PAL_IRQ_PIN_H				0x5
+
+struct vpu_rpc_system_config {
+	u32 cfg_cookie;
+
+	u32 num_malones;
+	u32 malone_base_addr[MEDIAIP_MAX_NUM_MALONES];
+	u32 hif_offset[MEDIAIP_MAX_NUM_MALONES];
+	u32 malone_irq_pin[MEDIAIP_MAX_NUM_MALONES][MEDIAIP_MAX_NUM_MALONE_IRQ_PINS];
+	u32 malone_irq_target[MEDIAIP_MAX_NUM_MALONES][MEDIAIP_MAX_NUM_MALONE_IRQ_PINS];
+
+	u32 num_windsors;
+	u32 windsor_base_addr[MEDIAIP_MAX_NUM_WINDSORS];
+	u32 windsor_irq_pin[MEDIAIP_MAX_NUM_WINDSORS][MEDIAIP_MAX_NUM_WINDSOR_IRQ_PINS];
+	u32 windsor_irq_target[MEDIAIP_MAX_NUM_WINDSORS][MEDIAIP_MAX_NUM_WINDSOR_IRQ_PINS];
+
+	u32 cmd_irq_pin[MEDIAIP_MAX_NUM_CMD_IRQ_PINS];
+	u32 cmd_irq_target[MEDIAIP_MAX_NUM_CMD_IRQ_PINS];
+
+	u32 msg_irq_pin[MEDIAIP_MAX_NUM_MSG_IRQ_PINS];
+	u32 msg_irq_target[MEDIAIP_MAX_NUM_MSG_IRQ_PINS];
+
+	u32 sys_clk_freq;
+	u32 num_timers;
+	u32 timer_base_addr;
+	u32 timer_irq_pin[MEDIAIP_MAX_NUM_TIMER_IRQ_PINS];
+	u32 timer_irq_target[MEDIAIP_MAX_NUM_TIMER_IRQ_PINS];
+	u32 timer_slots[MEDIAIP_MAX_NUM_TIMER_IRQ_SLOTS];
+
+	u32 gic_base_addr;
+	u32 uart_base_addr;
+
+	u32 dpv_base_addr;
+	u32 dpv_irq_pin;
+	u32 dpv_irq_target;
+
+	u32 pixif_base_addr;
+
+	u32 pal_trace_level;
+	u32 pal_trace_destination;
+
+	u32 pal_trace_level1;
+	u32 pal_trace_destination1;
+
+	u32 uHeapBase;
+	u32 uHeapSize;
+
+	u32 cache_base_addr[2];
+};
+
+int vpu_imx8q_setup_dec(struct vpu_dev *vpu);
+int vpu_imx8q_setup_enc(struct vpu_dev *vpu);
+int vpu_imx8q_setup(struct vpu_dev *vpu);
+int vpu_imx8q_reset(struct vpu_dev *vpu);
+int vpu_imx8q_set_system_cfg_common(struct vpu_rpc_system_config *config,
+		u32 regs, u32 core_id);
+int vpu_imx8q_boot_core(struct vpu_core *core);
+int vpu_imx8q_get_power_state(struct vpu_core *core);
+int vpu_imx8q_on_firmware_loaded(struct vpu_core *core);
+u32 vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size);
+bool vpu_imx8q_check_codec(enum vpu_core_type type);
+bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_log.h b/drivers/media/platform/imx/vpu-8q/vpu_log.h
new file mode 100644
index 000000000000..c889ba7bd624
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_log.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_LOG_H
+#define _IMX_VPU_LOG_H
+
+#define LVL_ERR		(1 << 0)
+#define LVL_WARN	(1 << 1)
+#define LVL_INFO	(1 << 2)
+#define LVL_DEBUG	(1 << 3)
+#define LVL_IRQ		(1 << 4)
+#define LVL_CMD		(1 << 5)
+#define LVL_EVT		(1 << 6)
+#define LVL_CTRL	(1 << 7)
+#define LVL_TS		(1 << 8)
+#define LVL_FLOW	(1 << 13)
+
+extern unsigned int vpu_dbg_level;
+
+#ifdef TAG
+#define vpu_dbg(level, fmt, arg...) \
+	do { \
+		if ((vpu_dbg_level & (level)) || ((level) & LVL_ERR)) \
+			pr_info("[VPU "TAG"]"fmt, ## arg); \
+	} while (0)
+#else
+#define vpu_dbg(level, fmt, arg...) \
+	do { \
+		if ((vpu_dbg_level & (level)) || ((level) & LVL_ERR)) \
+			pr_info("[VPU]"fmt, ## arg); \
+	} while (0)
+#endif
+
+#define vpu_err(fmt, arg...)	vpu_dbg(LVL_ERR, fmt, ##arg)
+#define inst_dbg(inst, level, fmt, arg...)		\
+		vpu_dbg(level, "[%d:%d] "fmt, inst->core->id, inst->id, ## arg)
+#define inst_err(inst, fmt, arg...)	inst_dbg(inst, LVL_ERR, fmt, ## arg)
+#define core_dbg(core, level, fmt, arg...)		\
+		vpu_dbg(level, "[%d] %s "fmt, core->id, vpu_core_type_desc(core->type), ## arg)
+#define core_err(core, fmt, arg...)	core_dbg(core, LVL_ERR, fmt, ## arg)
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_malone.c b/drivers/media/platform/imx/vpu-8q/vpu_malone.c
new file mode 100644
index 000000000000..be67b491494f
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_malone.c
@@ -0,0 +1,1744 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"MALONE"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <linux/videodev2.h>
+#include <linux/imx_vpu.h>
+#include "vpu.h"
+#include "vpu_rpc.h"
+#include "vpu_defs.h"
+#include "vpu_helpers.h"
+#include "vpu_cmds.h"
+#include "vpu_log.h"
+#include "vpu_imx8q.h"
+#include "vpu_malone.h"
+
+#define CMD_SIZE			25600
+#define MSG_SIZE			25600
+#define CODEC_SIZE			0x1000
+#define JPEG_SIZE			0x1000
+#define SEQ_SIZE			0x1000
+#define GOP_SIZE			0x1000
+#define PIC_SIZE			0x1000
+#define QMETER_SIZE			0x1000
+#define DBGLOG_SIZE			0x10000
+#define DEBUG_SIZE			0x80000
+#define ENG_SIZE			0x1000
+#define MALONE_SKIPPED_FRAME_ID		0x555
+
+#define MALONE_TILE_W			8
+#define MALONE_TILE_H			128
+#define MALONE_ALIGN_W			(MALONE_TILE_W * 1)
+#define MALONE_ALIGN_H			(MALONE_TILE_H * 2)
+#define MALONE_ALIGN_LINE		(256)
+#define MALONE_ALIGN_MBI		0x800
+#define MALONE_DCP_CHUNK_BIT		16
+#define MALONE_DCP_SIZE_MAX		0x3000000
+#define MALONE_DCP_SIZE_MIN		0x100000
+#define MALONE_DCP_FIXED_MB_ALLOC	250
+
+#define CONFIG_SET(val, cfg, pos, mask)		\
+		(*(cfg) |= (((val) << (pos)) & (mask)))
+//x means source data , y means destination data
+#define STREAM_CONFIG_FORMAT_SET(x, y)		CONFIG_SET(x, y, 0, 0x0000000F)
+#define STREAM_CONFIG_STRBUFIDX_SET(x, y)	CONFIG_SET(x, y, 8, 0x00000300)
+#define STREAM_CONFIG_NOSEQ_SET(x, y)		CONFIG_SET(x, y, 10, 0x00000400)
+#define STREAM_CONFIG_DEBLOCK_SET(x, y)		CONFIG_SET(x, y, 11, 0x00000800)
+#define STREAM_CONFIG_DERING_SET(x, y)		CONFIG_SET(x, y, 12, 0x00001000)
+#define STREAM_CONFIG_IBWAIT_SET(x, y)		CONFIG_SET(x, y, 13, 0x00002000)
+#define STREAM_CONFIG_FBC_SET(x, y)		CONFIG_SET(x, y, 14, 0x00004000)
+#define STREAM_CONFIG_PLAY_MODE_SET(x, y)	CONFIG_SET(x, y, 16, 0x00030000)
+#define STREAM_CONFIG_ENABLE_DCP_SET(x, y)	CONFIG_SET(x, y, 20, 0x00100000)
+#define STREAM_CONFIG_NUM_STR_BUF_SET(x, y)	CONFIG_SET(x, y, 21, 0x00600000)
+#define STREAM_CONFIG_MALONE_USAGE_SET(x, y)	CONFIG_SET(x, y, 23, 0x01800000)
+#define STREAM_CONFIG_MULTI_VID_SET(x, y)	CONFIG_SET(x, y, 25, 0x02000000)
+#define STREAM_CONFIG_OBFUSC_EN_SET(x, y)	CONFIG_SET(x, y, 26, 0x04000000)
+#define STREAM_CONFIG_RC4_EN_SET(x, y)		CONFIG_SET(x, y, 27, 0x08000000)
+#define STREAM_CONFIG_MCX_SET(x, y)		CONFIG_SET(x, y, 28, 0x10000000)
+#define STREAM_CONFIG_PES_SET(x, y)		CONFIG_SET(x, y, 29, 0x20000000)
+#define STREAM_CONFIG_NUM_DBE_SET(x, y)		CONFIG_SET(x, y, 30, 0x40000000)
+#define STREAM_CONFIG_FS_CTRL_MODE_SET(x, y)	CONFIG_SET(x, y, 31, 0x80000000)
+
+enum vpu_malone_stream_input_mode {
+	INVALID_MODE = 0,
+	FRAME_LVL,
+	NON_FRAME_LVL
+};
+
+enum vpu_malone_format {
+	MALONE_FMT_NULL = 0x0,
+	MALONE_FMT_AVC  = 0x1,
+	MALONE_FMT_MP2  = 0x2,
+	MALONE_FMT_VC1  = 0x3,
+	MALONE_FMT_AVS  = 0x4,
+	MALONE_FMT_ASP  = 0x5,
+	MALONE_FMT_JPG  = 0x6,
+	MALONE_FMT_RV   = 0x7,
+	MALONE_FMT_VP6  = 0x8,
+	MALONE_FMT_SPK  = 0x9,
+	MALONE_FMT_VP8  = 0xA,
+	MALONE_FMT_HEVC = 0xB,
+	MALONE_FMT_LAST = MALONE_FMT_HEVC
+};
+
+enum {
+	VID_API_CMD_NULL              = 0x00,
+	VID_API_CMD_PARSE_NEXT_SEQ    = 0x01,
+	VID_API_CMD_PARSE_NEXT_I      = 0x02,
+	VID_API_CMD_PARSE_NEXT_IP     = 0x03,
+	VID_API_CMD_PARSE_NEXT_ANY    = 0x04,
+	VID_API_CMD_DEC_PIC           = 0x05,
+	VID_API_CMD_UPDATE_ES_WR_PTR  = 0x06,
+	VID_API_CMD_UPDATE_ES_RD_PTR  = 0x07,
+	VID_API_CMD_UPDATE_UDATA      = 0x08,
+	VID_API_CMD_GET_FSINFO        = 0x09,
+	VID_API_CMD_SKIP_PIC          = 0x0a,
+	VID_API_CMD_DEC_CHUNK         = 0x0b,
+	VID_API_CMD_START             = 0x10,
+	VID_API_CMD_STOP              = 0x11,
+	VID_API_CMD_ABORT             = 0x12,
+	VID_API_CMD_RST_BUF           = 0x13,
+	VID_API_CMD_FS_RELEASE        = 0x15,
+	VID_API_CMD_MEM_REGION_ATTACH = 0x16,
+	VID_API_CMD_MEM_REGION_DETACH = 0x17,
+	VID_API_CMD_MVC_VIEW_SELECT   = 0x18,
+	VID_API_CMD_FS_ALLOC          = 0x19,
+	VID_API_CMD_DBG_GET_STATUS    = 0x1C,
+	VID_API_CMD_DBG_START_LOG     = 0x1D,
+	VID_API_CMD_DBG_STOP_LOG      = 0x1E,
+	VID_API_CMD_DBG_DUMP_LOG      = 0x1F,
+	VID_API_CMD_YUV_READY         = 0x20,
+	VID_API_CMD_TS                = 0x21,
+
+	VID_API_CMD_FIRM_RESET        = 0x40,
+
+	VID_API_CMD_SNAPSHOT          = 0xAA,
+	VID_API_CMD_ROLL_SNAPSHOT     = 0xAB,
+	VID_API_CMD_LOCK_SCHEDULER    = 0xAC,
+	VID_API_CMD_UNLOCK_SCHEDULER  = 0xAD,
+	VID_API_CMD_CQ_FIFO_DUMP      = 0xAE,
+	VID_API_CMD_DBG_FIFO_DUMP     = 0xAF,
+	VID_API_CMD_SVC_ILP           = 0xBB,
+	VID_API_CMD_FW_STATUS         = 0xF0,
+	VID_API_CMD_INVALID           = 0xFF
+};
+
+enum {
+	VID_API_EVENT_NULL			= 0x00,
+	VID_API_EVENT_RESET_DONE		= 0x01,
+	VID_API_EVENT_SEQ_HDR_FOUND		= 0x02,
+	VID_API_EVENT_PIC_HDR_FOUND		= 0x03,
+	VID_API_EVENT_PIC_DECODED		= 0x04,
+	VID_API_EVENT_FIFO_LOW			= 0x05,
+	VID_API_EVENT_FIFO_HIGH			= 0x06,
+	VID_API_EVENT_FIFO_EMPTY		= 0x07,
+	VID_API_EVENT_FIFO_FULL			= 0x08,
+	VID_API_EVENT_BS_ERROR			= 0x09,
+	VID_API_EVENT_UDATA_FIFO_UPTD		= 0x0A,
+	VID_API_EVENT_RES_CHANGE		= 0x0B,
+	VID_API_EVENT_FIFO_OVF			= 0x0C,
+	VID_API_EVENT_CHUNK_DECODED		= 0x0D,
+	VID_API_EVENT_REQ_FRAME_BUFF		= 0x10,
+	VID_API_EVENT_FRAME_BUFF_RDY		= 0x11,
+	VID_API_EVENT_REL_FRAME_BUFF		= 0x12,
+	VID_API_EVENT_STR_BUF_RST		= 0x13,
+	VID_API_EVENT_RET_PING			= 0x14,
+	VID_API_EVENT_QMETER			= 0x15,
+	VID_API_EVENT_STR_FMT_CHANGE		= 0x16,
+	VID_API_EVENT_FIRMWARE_XCPT		= 0x17,
+	VID_API_EVENT_START_DONE		= 0x18,
+	VID_API_EVENT_STOPPED			= 0x19,
+	VID_API_EVENT_ABORT_DONE		= 0x1A,
+	VID_API_EVENT_FINISHED			= 0x1B,
+	VID_API_EVENT_DBG_STAT_UPDATE		= 0x1C,
+	VID_API_EVENT_DBG_LOG_STARTED		= 0x1D,
+	VID_API_EVENT_DBG_LOG_STOPPED		= 0x1E,
+	VID_API_EVENT_DBG_LOG_UPDATED		= 0x1F,
+	VID_API_EVENT_DBG_MSG_DEC		= 0x20,
+	VID_API_EVENT_DEC_SC_ERR		= 0x21,
+	VID_API_EVENT_CQ_FIFO_DUMP		= 0x22,
+	VID_API_EVENT_DBG_FIFO_DUMP		= 0x23,
+	VID_API_EVENT_DEC_CHECK_RES		= 0x24,
+	VID_API_EVENT_DEC_CFG_INFO		= 0x25,
+	VID_API_EVENT_UNSUPPORTED_STREAM	= 0x26,
+	VID_API_EVENT_STR_SUSPENDED		= 0x30,
+	VID_API_EVENT_SNAPSHOT_DONE		= 0x40,
+	VID_API_EVENT_FW_STATUS                 = 0xF0,
+	VID_API_EVENT_INVALID			= 0xFF
+};
+
+struct vpu_malone_buffer_desc {
+	struct vpu_rpc_buffer_desc buffer;
+	u32 low;
+	u32 high;
+};
+
+struct vpu_malone_str_buffer {
+	u32 wptr;
+	u32 rptr;
+	u32 start;
+	u32 end;
+	u32 lwm;
+};
+
+struct vpu_malone_picth_info {
+	u32 frame_pitch;
+};
+
+struct vpu_malone_table_desc {
+	u32 array_base;
+	u32 size;
+};
+
+struct vpu_malone_dbglog_desc {
+	u32 addr;
+	u32 size;
+	u32 level;
+	u32 reserved;
+};
+
+struct vpu_malone_frame_buffer {
+	u32 addr;
+	u32 size;
+};
+
+struct vpu_malone_udata {
+	u32 base;
+	u32 total_size;
+	u32 slot_size;
+};
+
+struct vpu_malone_buffer_info {
+	u32 stream_input_mode;
+	u32 stream_pic_input_count;
+	u32 stream_pic_parsed_count;
+	u32 stream_buffer_threshold;
+	u32 stream_pic_end_flag;
+};
+
+struct vpu_malone_encrypt_info {
+	u32 rec4key[8];
+	u32 obfusc;
+};
+
+struct malone_iface {
+	u32 exec_base_addr;
+	u32 exec_area_size;
+	struct vpu_malone_buffer_desc cmd_buffer_desc;
+	struct vpu_malone_buffer_desc msg_buffer_desc;
+	u32 cmd_int_enable[VID_API_NUM_STREAMS];
+	struct vpu_malone_picth_info stream_pitch_info[VID_API_NUM_STREAMS];
+	u32 stream_config[VID_API_NUM_STREAMS];
+	struct vpu_malone_table_desc codec_param_tab_desc;
+	struct vpu_malone_table_desc jpeg_param_tab_desc;
+	u32 stream_buffer_desc[VID_API_NUM_STREAMS][VID_API_MAX_BUF_PER_STR];
+	struct vpu_malone_table_desc seq_info_tab_desc;
+	struct vpu_malone_table_desc pic_info_tab_desc;
+	struct vpu_malone_table_desc gop_info_tab_desc;
+	struct vpu_malone_table_desc qmeter_info_tab_desc;
+	u32 stream_error[VID_API_NUM_STREAMS];
+	u32 fw_version;
+	u32 fw_offset;
+	u32 max_streams;
+	struct vpu_malone_dbglog_desc dbglog_desc;
+	struct vpu_rpc_buffer_desc api_cmd_buffer_desc[VID_API_NUM_STREAMS];
+	struct vpu_malone_udata udata_buffer[VID_API_NUM_STREAMS];
+	struct vpu_malone_buffer_desc debug_buffer_desc;
+	struct vpu_malone_buffer_desc eng_access_buff_desc[VID_API_NUM_STREAMS];
+	u32 encrypt_info[VID_API_NUM_STREAMS];
+	struct vpu_rpc_system_config system_cfg;
+	u32 api_version;
+	struct vpu_malone_buffer_info stream_buff_info[VID_API_NUM_STREAMS];
+};
+
+struct malone_jpg_params {
+	u32 rotation_angle;
+	u32 horiz_scale_factor;
+	u32 vert_scale_factor;
+	u32 rotation_mode;
+	u32 rgb_mode;
+	u32 chunk_mode; /* 0 ~ 1 */
+	u32 last_chunk; /* 0 ~ 1 */
+	u32 chunk_rows; /* 0 ~ 255 */
+	u32 num_bytes;
+	u32 jpg_crop_x;
+	u32 jpg_crop_y;
+	u32 jpg_crop_width;
+	u32 jpg_crop_height;
+	u32 jpg_mjpeg_mode;
+	u32 jpg_mjpeg_interlaced;
+};
+
+struct malone_codec_params {
+	u32 disp_imm;
+	u32 fourcc;
+	u32 codec_version;
+	u32 frame_rate;
+	u32 dbglog_enable;
+	u32 bsdma_lwm;
+	u32 bbd_coring;
+	u32 bbd_s_thr_row;
+	u32 bbd_p_thr_row;
+	u32 bbd_s_thr_logo_row;
+	u32 bbd_p_thr_logo_row;
+	u32 bbd_s_thr_col;
+	u32 bbd_p_thr_col;
+	u32 bbd_chr_thr_row;
+	u32 bbd_chr_thr_col;
+	u32 bbd_uv_mid_level;
+	u32 bbd_excl_win_mb_left;
+	u32 bbd_excl_win_mb_right;
+};
+
+struct malone_padding_scode {
+	u32 scode_type;
+	u32 pixelformat;
+	u32 data[2];
+};
+
+struct malone_fmt_mapping {
+	u32 pixelformat;
+	enum vpu_malone_format malone_format;
+};
+
+struct malone_scode_t {
+	struct vpu_inst *inst;
+	struct vb2_buffer *vb;
+	u32 wptr;
+	u32 need_data;
+};
+
+struct malone_scode_handler {
+	u32 pixelformat;
+	int (*insert_scode_seq)(struct malone_scode_t *scode);
+	int (*insert_scode_pic)(struct malone_scode_t *scode);
+};
+
+struct vpu_dec_ctrl {
+	struct malone_codec_params *codec_param;
+	struct malone_jpg_params *jpg;
+	void *seq_mem;
+	void *pic_mem;
+	void *gop_mem;
+	void *qmeter_mem;
+	void *dbglog_mem;
+	struct vpu_malone_str_buffer *str_buf[VID_API_NUM_STREAMS];
+	u32 buf_addr[VID_API_NUM_STREAMS];
+};
+
+u32 vpu_malone_get_data_size(void)
+{
+	return sizeof(struct vpu_dec_ctrl);
+}
+
+void vpu_malone_init_rpc(struct vpu_shared_addr *shared,
+			struct vpu_buffer *rpc, dma_addr_t boot_addr)
+{
+	struct malone_iface *iface;
+	struct vpu_dec_ctrl *hc;
+	unsigned long base_phy_addr;
+	unsigned long phy_addr;
+	unsigned long offset;
+	unsigned int i;
+
+	WARN_ON(!shared || !shared->priv);
+	WARN_ON(!rpc || !rpc->phys || !rpc->length || rpc->phys < boot_addr);
+
+	iface = rpc->virt;
+	base_phy_addr = rpc->phys - boot_addr;
+	hc = shared->priv;
+
+	shared->iface = iface;
+	shared->boot_addr = boot_addr;
+
+	iface->exec_base_addr = base_phy_addr;
+	iface->exec_area_size = rpc->length;
+
+	offset = sizeof(struct malone_iface);
+	phy_addr = base_phy_addr + offset;
+
+	shared->cmd_desc = &iface->cmd_buffer_desc.buffer;
+	shared->cmd_mem_vir = rpc->virt + offset;
+	iface->cmd_buffer_desc.buffer.start =
+	iface->cmd_buffer_desc.buffer.rptr =
+	iface->cmd_buffer_desc.buffer.wptr = phy_addr;
+	iface->cmd_buffer_desc.buffer.end = iface->cmd_buffer_desc.buffer.start + CMD_SIZE;
+	offset += CMD_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	shared->msg_desc = &iface->msg_buffer_desc.buffer;
+	shared->msg_mem_vir = rpc->virt + offset;
+	iface->msg_buffer_desc.buffer.start =
+	iface->msg_buffer_desc.buffer.wptr =
+	iface->msg_buffer_desc.buffer.rptr = phy_addr;
+	iface->msg_buffer_desc.buffer.end = iface->msg_buffer_desc.buffer.start + MSG_SIZE;
+	offset += MSG_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->codec_param_tab_desc.array_base = phy_addr;
+	hc->codec_param = rpc->virt + offset;
+	offset += CODEC_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->jpeg_param_tab_desc.array_base = phy_addr;
+	hc->jpg = rpc->virt + offset;
+	offset += JPEG_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->seq_info_tab_desc.array_base = phy_addr;
+	hc->seq_mem = rpc->virt + offset;
+	offset += SEQ_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->pic_info_tab_desc.array_base = phy_addr;
+	hc->pic_mem = rpc->virt + offset;
+	offset += PIC_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->gop_info_tab_desc.array_base = phy_addr;
+	hc->gop_mem = rpc->virt + offset;
+	offset += GOP_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->qmeter_info_tab_desc.array_base = phy_addr;
+	hc->qmeter_mem = rpc->virt + offset;
+	offset += QMETER_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	iface->dbglog_desc.addr = phy_addr;
+	iface->dbglog_desc.size = DBGLOG_SIZE;
+	hc->dbglog_mem = rpc->virt + offset;
+	offset += DBGLOG_SIZE;
+	phy_addr = base_phy_addr + offset;
+
+	for (i = 0; i < VID_API_NUM_STREAMS; i++) {
+		iface->eng_access_buff_desc[i].buffer.start =
+		iface->eng_access_buff_desc[i].buffer.wptr =
+		iface->eng_access_buff_desc[i].buffer.rptr = phy_addr;
+		iface->eng_access_buff_desc[i].buffer.end =
+			iface->eng_access_buff_desc[i].buffer.start + ENG_SIZE;
+		offset += ENG_SIZE;
+		phy_addr = base_phy_addr + offset;
+	}
+
+	for (i = 0; i < VID_API_NUM_STREAMS; i++) {
+		iface->encrypt_info[i] = phy_addr;
+		offset += sizeof(struct vpu_malone_encrypt_info);
+		phy_addr = base_phy_addr + offset;
+	}
+
+	rpc->bytesused = offset;
+}
+
+void vpu_malone_set_log_buf(struct vpu_shared_addr *shared,
+			struct vpu_buffer *log)
+{
+	struct malone_iface *iface;
+
+	WARN_ON(!shared || !log || !log->phys);
+	vpu_dbg(LVL_DEBUG, "set log area <0x%llx, 0x%x> (0x%lx)\n",
+			log->phys, log->length, shared->boot_addr);
+	iface = shared->iface;
+	iface->debug_buffer_desc.buffer.start =
+	iface->debug_buffer_desc.buffer.wptr =
+	iface->debug_buffer_desc.buffer.rptr = log->phys - shared->boot_addr;
+	iface->debug_buffer_desc.buffer.end = iface->debug_buffer_desc.buffer.start + log->length;
+}
+
+static u32 get_str_buffer_offset(u32 instance)
+{
+	return DEC_MFD_XREG_SLV_BASE + MFD_MCX + MFD_MCX_OFF * instance;
+}
+
+void vpu_malone_set_system_cfg(struct vpu_shared_addr *shared,
+				u32 regs_base, void __iomem *regs, u32 core_id)
+{
+	struct malone_iface *iface;
+	struct vpu_rpc_system_config *config;
+	struct vpu_dec_ctrl *hc;
+	int i;
+
+	WARN_ON(!shared || !shared->iface || !shared->core || !shared->priv);
+
+	iface = shared->iface;
+	config = &iface->system_cfg;
+	hc = shared->priv;
+
+	vpu_imx8q_set_system_cfg_common(config, regs_base, core_id);
+	for (i = 0; i < VID_API_NUM_STREAMS; i++) {
+		u32 offset = get_str_buffer_offset(i);
+
+		hc->buf_addr[i] = regs_base + offset;
+		hc->str_buf[i] = regs + offset;
+	}
+}
+
+u32 vpu_malone_get_version(struct vpu_shared_addr *shared)
+{
+	struct malone_iface *iface;
+
+	WARN_ON(!shared || !shared->iface);
+
+	iface = shared->iface;
+	return iface->fw_version;
+}
+
+int vpu_malone_get_stream_buffer_size(struct vpu_shared_addr *shared)
+{
+	return 0xc00000;
+}
+
+int vpu_malone_config_stream_buffer(struct vpu_shared_addr *shared,
+					u32 instance,
+					struct vpu_buffer *buf)
+{
+	struct malone_iface *iface;
+	struct vpu_dec_ctrl *hc;
+	struct vpu_malone_str_buffer *str_buf;
+
+	WARN_ON(!shared || !shared->iface || !shared->core || !shared->priv);
+
+	iface = shared->iface;
+	hc = shared->priv;
+	str_buf = hc->str_buf[instance];
+	str_buf->wptr = str_buf->rptr = str_buf->start = buf->phys;
+	str_buf->end = buf->phys + buf->length;
+	str_buf->lwm = 0x1;
+
+	iface->stream_buffer_desc[instance][0] = hc->buf_addr[instance];
+
+	return 0;
+}
+
+int vpu_malone_get_stream_buffer_desc(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_rpc_buffer_desc *desc)
+{
+	struct vpu_dec_ctrl *hc;
+	struct vpu_malone_str_buffer *str_buf;
+
+	WARN_ON(!shared || !shared->iface || !shared->core || !shared->priv);
+
+	hc = shared->priv;
+	str_buf = hc->str_buf[instance];
+
+	if (desc) {
+		desc->wptr = str_buf->wptr;
+		desc->rptr = str_buf->rptr;
+		desc->start = str_buf->start;
+		desc->end = str_buf->end;
+	}
+
+	return 0;
+}
+
+static void vpu_malone_update_wptr(struct vpu_malone_str_buffer *str_buf,
+					u32 wptr)
+{
+	u32 size = str_buf->end - str_buf->start;
+	u32 space = (str_buf->rptr + size - str_buf->wptr) % size;
+	u32 step = (wptr + size - str_buf->wptr) % size;
+
+	if (space && step > space)
+		vpu_err("update wptr from 0x%x to 0x%x, cross over rptr 0x%x\n",
+				str_buf->wptr, wptr, str_buf->rptr);
+
+	/*update wptr after data is written*/
+	mb();
+	str_buf->wptr = wptr;
+}
+
+static void vpu_malone_update_rptr(struct vpu_malone_str_buffer *str_buf,
+					u32 rptr)
+{
+	u32 size = str_buf->end - str_buf->start;
+	u32 space = (str_buf->wptr + size - str_buf->rptr) % size;
+	u32 step = (rptr + size - str_buf->rptr) % size;
+
+	if (step > space)
+		vpu_err("update rptr from 0x%x to 0x%x, cross over wptr 0x%x\n",
+				str_buf->rptr, rptr, str_buf->wptr);
+	/*update rptr after data is read*/
+	mb();
+	str_buf->rptr = rptr;
+}
+
+int vpu_malone_update_stream_buffer(struct vpu_shared_addr *shared,
+					u32 instance, u32 ptr, bool write)
+{
+	struct vpu_dec_ctrl *hc;
+	struct vpu_malone_str_buffer *str_buf;
+
+	WARN_ON(!shared || !shared->iface || !shared->core || !shared->priv);
+
+	hc = shared->priv;
+	str_buf = hc->str_buf[instance];
+
+	if (write)
+		vpu_malone_update_wptr(str_buf, ptr);
+	else
+		vpu_malone_update_rptr(str_buf, ptr);
+
+	return 0;
+}
+
+static struct malone_fmt_mapping fmt_mappings[] = {
+	{V4L2_PIX_FMT_H264,        MALONE_FMT_AVC},
+	{V4L2_PIX_FMT_H264_MVC,    MALONE_FMT_AVC},
+	{V4L2_PIX_FMT_HEVC,        MALONE_FMT_HEVC},
+	{V4L2_PIX_FMT_VC1_ANNEX_G, MALONE_FMT_VC1},
+	{V4L2_PIX_FMT_VC1_ANNEX_L, MALONE_FMT_VC1},
+	{V4L2_PIX_FMT_MPEG2,       MALONE_FMT_MP2},
+	{V4L2_PIX_FMT_MPEG4,       MALONE_FMT_ASP},
+	{V4L2_PIX_FMT_XVID,        MALONE_FMT_ASP},
+	{V4L2_PIX_FMT_H263,        MALONE_FMT_ASP},
+	{V4L2_PIX_FMT_AVS,         MALONE_FMT_AVS},
+	{V4L2_PIX_FMT_JPEG,        MALONE_FMT_JPG},
+	{V4L2_PIX_FMT_VP6,         MALONE_FMT_VP6},
+	{V4L2_PIX_FMT_VP8,         MALONE_FMT_VP8},
+	{V4L2_PIX_FMT_SPK,         MALONE_FMT_SPK},
+};
+
+static enum vpu_malone_format vpu_malone_format_remap(u32 pixelformat)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(fmt_mappings); i++) {
+		if (pixelformat == fmt_mappings[i].pixelformat)
+			return fmt_mappings[i].malone_format;
+	}
+
+	return MALONE_FMT_NULL;
+}
+
+static void vpu_malone_set_stream_cfg(struct vpu_shared_addr *shared,
+		u32 instance, enum vpu_malone_format malone_format)
+{
+	struct malone_iface *iface;
+	u32 *curr_str_cfg;
+
+	iface = shared->iface;
+	curr_str_cfg = &iface->stream_config[instance];
+
+	*curr_str_cfg = 0;
+	STREAM_CONFIG_FORMAT_SET(malone_format, curr_str_cfg);
+	STREAM_CONFIG_STRBUFIDX_SET(0, curr_str_cfg);
+	STREAM_CONFIG_NOSEQ_SET(0, curr_str_cfg);
+	STREAM_CONFIG_DEBLOCK_SET(0, curr_str_cfg);
+	STREAM_CONFIG_DERING_SET(0, curr_str_cfg);
+	STREAM_CONFIG_PLAY_MODE_SET(0x3, curr_str_cfg);
+	STREAM_CONFIG_FS_CTRL_MODE_SET(0x1, curr_str_cfg);
+	STREAM_CONFIG_ENABLE_DCP_SET(1, curr_str_cfg);
+	STREAM_CONFIG_NUM_STR_BUF_SET(1, curr_str_cfg);
+	STREAM_CONFIG_MALONE_USAGE_SET(1, curr_str_cfg);
+	STREAM_CONFIG_MULTI_VID_SET(0, curr_str_cfg);
+	STREAM_CONFIG_OBFUSC_EN_SET(0, curr_str_cfg);
+	STREAM_CONFIG_RC4_EN_SET(0, curr_str_cfg);
+	STREAM_CONFIG_MCX_SET(1, curr_str_cfg);
+	STREAM_CONFIG_PES_SET(0, curr_str_cfg);
+	STREAM_CONFIG_NUM_DBE_SET(1, curr_str_cfg);
+}
+
+static int vpu_malone_set_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_decode_params *params)
+{
+	struct malone_iface *iface;
+	struct vpu_dec_ctrl *hc;
+	enum vpu_malone_format malone_format;
+
+	iface = shared->iface;
+	hc = shared->priv;
+	malone_format = vpu_malone_format_remap(params->codec_format);
+	iface->udata_buffer[instance].base = params->udata.base;
+	iface->udata_buffer[instance].slot_size = params->udata.size;
+
+	vpu_malone_set_stream_cfg(shared, instance, malone_format);
+
+	if (malone_format == MALONE_FMT_JPG) {
+		//1:JPGD_MJPEG_MODE_A; 2:JPGD_MJPEG_MODE_B
+		hc->jpg[instance].jpg_mjpeg_mode = 1;
+		//0: JPGD_MJPEG_PROGRESSIVE
+		hc->jpg[instance].jpg_mjpeg_interlaced = 0;
+	}
+
+	hc->codec_param[instance].disp_imm = params->b_dis_reorder ? 1 : 0;
+	hc->codec_param[instance].dbglog_enable = 0;
+	iface->dbglog_desc.level = 0;
+
+	if (params->b_non_frame)
+		iface->stream_buff_info[instance].stream_input_mode = NON_FRAME_LVL;
+	else
+		iface->stream_buff_info[instance].stream_input_mode = FRAME_LVL;
+	iface->stream_buff_info[instance].stream_buffer_threshold = 0;
+	iface->stream_buff_info[instance].stream_pic_input_count = 0;
+
+	return 0;
+}
+
+static bool vpu_malone_is_non_frame_mode(struct vpu_shared_addr *shared,
+					u32 instance)
+{
+	struct malone_iface *iface;
+
+	iface = shared->iface;
+	if (iface->stream_buff_info[instance].stream_input_mode == NON_FRAME_LVL)
+		return true;
+
+	return false;
+}
+
+static int vpu_malone_update_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_decode_params *params)
+{
+	struct malone_iface *iface;
+
+	iface = shared->iface;
+
+	if (params->end_flag)
+		iface->stream_buff_info[instance].stream_pic_end_flag = params->end_flag;
+	params->end_flag = 0;
+
+	return 0;
+}
+
+int vpu_malone_set_decode_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_decode_params *params, u32 update)
+{
+	if (!params)
+		return -EINVAL;
+
+	if (!update)
+		return vpu_malone_set_params(shared, instance, params);
+	else
+		return vpu_malone_update_params(shared, instance, params);
+}
+
+static struct vpu_pair malone_cmds[] = {
+	{VPU_CMD_ID_START, VID_API_CMD_START},
+	{VPU_CMD_ID_STOP, VID_API_CMD_STOP},
+	{VPU_CMD_ID_ABORT, VID_API_CMD_ABORT},
+	{VPU_CMD_ID_RST_BUF, VID_API_CMD_RST_BUF},
+	{VPU_CMD_ID_SNAPSHOT, VID_API_CMD_SNAPSHOT},
+	{VPU_CMD_ID_FIRM_RESET, VID_API_CMD_FIRM_RESET},
+	{VPU_CMD_ID_FS_ALLOC, VID_API_CMD_FS_ALLOC},
+	{VPU_CMD_ID_FS_RELEASE, VID_API_CMD_FS_RELEASE},
+	{VPU_CMD_ID_TIMESTAMP, VID_API_CMD_TS},
+	{VPU_CMD_ID_DEBUG, VID_API_CMD_FW_STATUS},
+};
+
+static struct vpu_pair malone_msgs[] = {
+	{VPU_MSG_ID_RESET_DONE, VID_API_EVENT_RESET_DONE},
+	{VPU_MSG_ID_START_DONE, VID_API_EVENT_START_DONE},
+	{VPU_MSG_ID_STOP_DONE, VID_API_EVENT_STOPPED},
+	{VPU_MSG_ID_ABORT_DONE, VID_API_EVENT_ABORT_DONE},
+	{VPU_MSG_ID_BUF_RST, VID_API_EVENT_STR_BUF_RST},
+	{VPU_MSG_ID_PIC_EOS, VID_API_EVENT_FINISHED},
+	{VPU_MSG_ID_SEQ_HDR_FOUND, VID_API_EVENT_SEQ_HDR_FOUND},
+	{VPU_MSG_ID_RES_CHANGE, VID_API_EVENT_RES_CHANGE},
+	{VPU_MSG_ID_PIC_HDR_FOUND, VID_API_EVENT_PIC_HDR_FOUND},
+	{VPU_MSG_ID_PIC_DECODED, VID_API_EVENT_PIC_DECODED},
+	{VPU_MSG_ID_DEC_DONE, VID_API_EVENT_FRAME_BUFF_RDY},
+	{VPU_MSG_ID_FRAME_REQ, VID_API_EVENT_REQ_FRAME_BUFF},
+	{VPU_MSG_ID_FRAME_RELEASE, VID_API_EVENT_REL_FRAME_BUFF},
+	{VPU_MSG_ID_FIFO_LOW, VID_API_EVENT_FIFO_LOW},
+	{VPU_MSG_ID_BS_ERROR, VID_API_EVENT_BS_ERROR},
+	{VPU_MSG_ID_UNSUPPORTED, VID_API_EVENT_UNSUPPORTED_STREAM},
+	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_EVENT_FIRMWARE_XCPT},
+};
+
+static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
+					struct vpu_fs_info *fs)
+{
+	const u32 fs_type[] = {
+		[MEM_RES_FRAME] = 0,
+		[MEM_RES_MBI] = 1,
+		[MEM_RES_DCP] = 2,
+	};
+
+	pkt->hdr.num = 7;
+	pkt->data[0] = fs->id | (fs->tag << 24);
+	pkt->data[1] = fs->luma_addr;
+	if (fs->type == MEM_RES_FRAME) {
+		/*
+		 * if luma_addr equal to chroma_addr,
+		 * means luma(plane[0]) and chromau(plane[1]) used the
+		 * same fd -- usage of NXP codec2. Need to manually
+		 * offset chroma addr.
+		 */
+		if (fs->luma_addr == fs->chroma_addr)
+			fs->chroma_addr = fs->luma_addr + fs->luma_size;
+		pkt->data[2] = fs->luma_addr + fs->luma_size / 2;
+		pkt->data[3] = fs->chroma_addr;
+		pkt->data[4] = fs->chroma_addr + fs->chromau_size / 2;
+		pkt->data[5] = fs->bytesperline;
+	} else {
+		pkt->data[2] = fs->luma_size;
+		pkt->data[3] = 0;
+		pkt->data[4] = 0;
+		pkt->data[5] = 0;
+	}
+	pkt->data[6] = fs_type[fs->type];
+}
+
+static void vpu_malone_pack_fs_release(struct vpu_rpc_event *pkt,
+					struct vpu_fs_info *fs)
+{
+	pkt->hdr.num = 1;
+	pkt->data[0] = fs->id | (fs->tag << 24);
+}
+
+static void vpu_malone_pack_timestamp(struct vpu_rpc_event *pkt,
+					struct vpu_ts_info *info)
+{
+	pkt->hdr.num = 3;
+	if (info->timestamp < 0) {
+		pkt->data[0] = (u32)-1;
+		pkt->data[1] = 0;
+	} else {
+		pkt->data[0] = info->timestamp / NSEC_PER_SEC;
+		pkt->data[1] = info->timestamp % NSEC_PER_SEC;
+	}
+	pkt->data[2] = info->size;
+}
+
+int vpu_malone_pack_cmd(struct vpu_rpc_event *pkt, u32 index, u32 id, void *data)
+{
+	int ret;
+
+	WARN_ON(!pkt);
+
+	ret = vpu_find_dst_by_src(malone_cmds, ARRAY_SIZE(malone_cmds), id);
+	if (ret < 0)
+		return ret;
+
+	pkt->hdr.id = ret;
+	pkt->hdr.num = 0;
+	pkt->hdr.index = index;
+
+	switch (id) {
+	case VPU_CMD_ID_FS_ALLOC:
+		vpu_malone_pack_fs_alloc(pkt, data);
+		break;
+	case VPU_CMD_ID_FS_RELEASE:
+		vpu_malone_pack_fs_release(pkt, data);
+		break;
+	case VPU_CMD_ID_TIMESTAMP:
+		vpu_malone_pack_timestamp(pkt, data);
+		break;
+	}
+
+	pkt->hdr.index = index;
+	return 0;
+}
+
+int vpu_malone_convert_msg_id(u32 id)
+{
+	return vpu_find_src_by_dst(malone_msgs, ARRAY_SIZE(malone_msgs), id);
+}
+
+void vpu_malone_init_seq_hdr(struct vpu_dec_codec_info *info)
+{
+	const u32 align_width = MALONE_ALIGN_W;
+	const u32 align_height = MALONE_ALIGN_H;
+	u32 width;
+	u32 height;
+	u32 bytesperline;
+	u32 chunks = info->num_dfe_area >> MALONE_DCP_CHUNK_BIT;
+
+	width = ALIGN(info->decoded_width, align_width);
+	height = ALIGN(info->decoded_height, align_height);
+	if (!info->progressive)
+		height = ALIGN(info->decoded_height, align_height * 2);
+
+	bytesperline = DIV_ROUND_UP((width * info->bit_depth_luma), BITS_PER_BYTE);
+	bytesperline = ALIGN(bytesperline, MALONE_ALIGN_LINE);
+
+	info->bytesperline[0] = bytesperline;
+	info->bytesperline[1] = bytesperline;
+	info->sizeimage[0] = bytesperline * height;
+	info->sizeimage[1] = (bytesperline * height) >> 1;
+	info->mbi_size = (info->sizeimage[0] + info->sizeimage[1]) >> 2;
+	info->mbi_size = ALIGN(info->mbi_size, MALONE_ALIGN_MBI);
+
+	info->dcp_size = MALONE_DCP_SIZE_MAX;
+	if (chunks) {
+		u32 mb_num;
+		u32 mb_w;
+		u32 mb_h;
+
+		mb_w = DIV_ROUND_UP(info->decoded_width, 16);
+		mb_h = DIV_ROUND_UP(info->decoded_height, 16);
+		mb_num = mb_w * mb_h;
+		info->dcp_size = mb_num * MALONE_DCP_FIXED_MB_ALLOC * chunks;
+		info->dcp_size = clamp_t(u32, info->dcp_size,
+					MALONE_DCP_SIZE_MIN, MALONE_DCP_SIZE_MAX);
+	}
+
+	info->decoded_width = width;
+	info->decoded_height = height;
+}
+
+static void vpu_malone_unpack_seq_hdr(struct vpu_rpc_event *pkt,
+					struct vpu_dec_codec_info *info)
+{
+	info->num_ref_frms = pkt->data[0];
+	info->num_dpb_frms = pkt->data[1];
+	info->num_dfe_area = pkt->data[2];
+	info->progressive = pkt->data[3];
+	info->width = pkt->data[5];
+	info->height = pkt->data[4];
+	info->decoded_width = pkt->data[12];
+	info->decoded_height = pkt->data[11];
+	info->frame_rate = pkt->data[8];
+	info->dsp_asp_ratio = pkt->data[9];
+	info->level_idc = pkt->data[10];
+	info->bit_depth_luma = pkt->data[13];
+	info->bit_depth_chroma = pkt->data[14];
+	info->chroma_fmt = pkt->data[15];
+	info->color_primaries = vpu_color_cvrt_primaries_i2v(pkt->data[16]);
+	info->transfer_chars = vpu_color_cvrt_transfers_i2v(pkt->data[17]);
+	info->matrix_coeffs = vpu_color_cvrt_matrix_i2v(pkt->data[18]);
+	info->full_range = vpu_color_cvrt_full_range_i2v(pkt->data[19]);
+	info->vui_present = pkt->data[20];
+	info->mvc_num_views = pkt->data[21];
+	info->offset_x = pkt->data[23];
+	info->offset_y = pkt->data[25];
+	info->tag = pkt->data[27];
+	if (info->bit_depth_luma > 8)
+		info->pixfmt = V4L2_PIX_FMT_NT10;
+	else	/* fix me: should set to V4L2_PIX_FMT_NT8 for NXP Tiled NV12 Format in future*/
+		info->pixfmt = V4L2_PIX_FMT_NV12;
+	vpu_malone_init_seq_hdr(info);
+}
+
+static void vpu_malone_unpack_pic_info(struct vpu_rpc_event *pkt,
+					struct vpu_dec_pic_info *info)
+{
+	info->id = pkt->data[7];
+	info->luma = pkt->data[0];
+	info->start = pkt->data[10];
+	info->end = pkt->data[12];
+	info->pic_size = pkt->data[11];
+	info->stride = pkt->data[5];
+	info->consumed_count = pkt->data[13];
+	if (info->id == MALONE_SKIPPED_FRAME_ID)
+		info->skipped = 1;
+	else
+		info->skipped = 0;
+}
+
+static void vpu_malone_unpack_req_frame(struct vpu_rpc_event *pkt,
+					struct vpu_fs_info *info)
+{
+	info->type = pkt->data[1];
+}
+
+static void vpu_malone_unpack_rel_frame(struct vpu_rpc_event *pkt,
+					struct vpu_fs_info *info)
+{
+	info->id = pkt->data[0];
+	info->type = pkt->data[1];
+	info->not_displayed = pkt->data[2];
+}
+
+static void vpu_malone_unpack_buff_rdy(struct vpu_rpc_event *pkt,
+					struct vpu_dec_pic_info *info)
+{
+	info->id = pkt->data[0];
+	info->luma = pkt->data[1];
+	info->stride = pkt->data[3];
+	if (info->id == MALONE_SKIPPED_FRAME_ID)
+		info->skipped = 1;
+	else
+		info->skipped = 0;
+	info->timestamp = MAKE_TIMESTAMP(pkt->data[9], pkt->data[10]);
+}
+
+int vpu_malone_unpack_msg_data(struct vpu_rpc_event *pkt, void *data)
+{
+	if (!pkt || !data)
+		return -EINVAL;
+
+	switch (pkt->hdr.id) {
+	case VID_API_EVENT_SEQ_HDR_FOUND:
+		vpu_malone_unpack_seq_hdr(pkt, data);
+		break;
+	case VID_API_EVENT_PIC_DECODED:
+		vpu_malone_unpack_pic_info(pkt, data);
+		break;
+	case VID_API_EVENT_REQ_FRAME_BUFF:
+		vpu_malone_unpack_req_frame(pkt, data);
+		break;
+	case VID_API_EVENT_REL_FRAME_BUFF:
+		vpu_malone_unpack_rel_frame(pkt, data);
+		break;
+	case VID_API_EVENT_FRAME_BUFF_RDY:
+		vpu_malone_unpack_buff_rdy(pkt, data);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct malone_padding_scode padding_scodes[] = {
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H264,        {0x0B010000, 0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H264_MVC,    {0x0B010000, 0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_HEVC,        {0x4A010000, 0x20}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VC1_ANNEX_G, {0x0a010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VC1_ANNEX_L, {0x0a010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_MPEG2,       {0xCC010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_AVS,         {0xCC010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_MPEG4,       {0xb1010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_XVID,        {0xb1010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VP6,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0xefff0000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264,        {0x0B010000, 0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264_MVC,    {0x0B010000, 0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_HEVC,        {0x4A010000, 0x20}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VC1_ANNEX_G, {0x0a010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VC1_ANNEX_L, {0x0a010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_MPEG2,       {0xb7010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_AVS,         {0xb1010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_MPEG4,       {0xb1010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_XVID,        {0xb1010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VP6,         {0x34010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0x0, 0x0}},
+	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264,        {0x15010000, 0x0}},
+	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264_MVC,    {0x15010000, 0x0}},
+};
+static const struct malone_padding_scode padding_scode_dft = {0x0, 0x0};
+
+static const struct malone_padding_scode *get_padding_scode(u32 type, u32 fmt)
+{
+	const struct malone_padding_scode *s;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(padding_scodes); i++) {
+		s = &padding_scodes[i];
+
+		if (s->scode_type == type && s->pixelformat == fmt)
+			return s;
+	}
+
+	if (type != SCODE_PADDING_BUFFLUSH)
+		return &padding_scode_dft;
+
+	return NULL;
+}
+
+static int vpu_malone_add_padding_scode(struct vpu_buffer *stream_buffer,
+			struct vpu_malone_str_buffer *str_buf,
+			u32 pixelformat, u32 scode_type)
+{
+	u32 wptr;
+	u32 size;
+	u32 total_size = 0;
+	const struct malone_padding_scode *ps;
+	const u32 padding_size = 4096;
+	int ret;
+
+	ps = get_padding_scode(scode_type, pixelformat);
+	if (!ps)
+		return -EINVAL;
+
+	wptr = str_buf->wptr;
+	size = ALIGN(wptr, 4) - wptr;
+	if (size)
+		vpu_helper_memset_stream_buffer(stream_buffer, &wptr, 0, size);
+	total_size += size;
+
+	size = sizeof(ps->data);
+	ret = vpu_helper_copy_to_stream_buffer(stream_buffer, &wptr, size, (void *)ps->data);
+	if (ret < size)
+		return -EINVAL;
+	total_size += size;
+
+	size = padding_size - sizeof(ps->data);
+	vpu_helper_memset_stream_buffer(stream_buffer, &wptr, 0, size);
+	total_size += size;
+
+	vpu_malone_update_wptr(str_buf, wptr);
+	return total_size;
+}
+
+int vpu_malone_add_scode(struct vpu_shared_addr *shared,
+				u32 instance,
+				struct vpu_buffer *stream_buffer,
+				u32 pixelformat,
+				u32 scode_type)
+{
+	struct vpu_dec_ctrl *hc;
+	struct vpu_malone_str_buffer *str_buf;
+	int ret = -EINVAL;
+
+	WARN_ON(!shared || !shared->iface || !shared->core || !shared->priv);
+
+	hc = shared->priv;
+	str_buf = hc->str_buf[instance];
+
+	switch (scode_type) {
+	case SCODE_PADDING_EOS:
+	case SCODE_PADDING_ABORT:
+	case SCODE_PADDING_BUFFLUSH:
+		ret = vpu_malone_add_padding_scode(stream_buffer,
+				str_buf, pixelformat, scode_type);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+#define MALONE_PAYLOAD_HEADER_SIZE		16
+#define MALONE_CODEC_VERSION_ID			0x1
+#define MALONE_CODEC_ID_VC1_SIMPLE		0x10
+#define MALONE_CODEC_ID_VC1_MAIN		0x11
+#define MALONE_CODEC_ID_ARV8			0x28
+#define MALONE_CODEC_ID_ARV9			0x29
+#define MALONE_CODEC_ID_VP6			0x36
+#define MALONE_CODEC_ID_VP8			0x36
+#define MALONE_CODEC_ID_DIVX3			0x38
+#define MALONE_CODEC_ID_SPK			0x39
+
+#define MALONE_VP8_IVF_SEQ_HEADER_LEN		32
+#define MALONE_VP8_IVF_FRAME_HEADER_LEN		8
+
+#define MALONE_VC1_RCV_CODEC_V1_VERSION		0x85
+#define MALONE_VC1_RCV_CODEC_V2_VERSION		0xC5
+#define MALONE_VC1_RCV_NUM_FRAMES		0xFF
+#define MALONE_VC1_RCV_SEQ_EXT_DATA_SIZE	4
+#define MALONE_VC1_RCV_SEQ_HEADER_LEN		20
+#define MALONE_VC1_RCV_PIC_HEADER_LEN		4
+#define MALONE_VC1_NAL_HEADER_LEN		4
+#define MALONE_VC1_CONTAIN_NAL(data)		((data & 0x00FFFFFF) == 0x00010000)
+
+
+static void set_payload_hdr(u8 *dst, u32 scd_type, u32 codec_id,
+		u32 buffer_size, u32 width, u32 height)
+{
+	unsigned int payload_size;
+	/* payload_size = buffer_size + itself_size(16) - start_code(4) */
+	payload_size = buffer_size + 12;
+
+	dst[0] = 0x00;
+	dst[1] = 0x00;
+	dst[2] = 0x01;
+	dst[3] = scd_type;
+
+	/* length */
+	dst[4] = ((payload_size>>16)&0xff);
+	dst[5] = ((payload_size>>8)&0xff);
+	dst[6] = 0x4e;
+	dst[7] = ((payload_size>>0)&0xff);
+
+	/* Codec ID and Version */
+	dst[8] = codec_id;
+	dst[9] = MALONE_CODEC_VERSION_ID;
+
+	/* width */
+	dst[10] = ((width>>8)&0xff);
+	dst[11] = ((width>>0)&0xff);
+	dst[12] = 0x58;
+
+	/* height */
+	dst[13] = ((height>>8)&0xff);
+	dst[14] = ((height>>0)&0xff);
+	dst[15] = 0x50;
+}
+
+static void set_vp8_ivf_seqhdr(u8 *dst, u32 width, u32 height)
+{
+	/* 0-3byte signature "DKIF" */
+	dst[0] = 0x44;
+	dst[1] = 0x4b;
+	dst[2] = 0x49;
+	dst[3] = 0x46;
+	/* 4-5byte version: should be 0*/
+	dst[4] = 0x00;
+	dst[5] = 0x00;
+	/* 6-7 length of Header */
+	dst[6] = MALONE_VP8_IVF_SEQ_HEADER_LEN;
+	dst[7] = MALONE_VP8_IVF_SEQ_HEADER_LEN >> 8;
+	/* 8-11 VP8 fourcc */
+	dst[8] = 0x56;
+	dst[9] = 0x50;
+	dst[10] = 0x38;
+	dst[11] = 0x30;
+	/* 12-13 width in pixels */
+	dst[12] = width;
+	dst[13] = width >> 8;
+	/* 14-15 height in pixels */
+	dst[14] = height;
+	dst[15] = height >> 8;
+	/* 16-19 frame rate */
+	dst[16] = 0xe8;
+	dst[17] = 0x03;
+	dst[18] = 0x00;
+	dst[19] = 0x00;
+	/* 20-23 time scale */
+	dst[20] = 0x01;
+	dst[21] = 0x00;
+	dst[22] = 0x00;
+	dst[23] = 0x00;
+	/* 24-27 number frames */
+	dst[24] = 0xdf;
+	dst[25] = 0xf9;
+	dst[26] = 0x09;
+	dst[27] = 0x00;
+	/* 28-31 reserved */
+}
+
+static void set_vp8_ivf_pichdr(u8 *dst, u32 frame_size)
+{
+	/*
+	 * firmware just parse 64-bit timestamp(8 bytes).
+	 * As not transfer timestamp to firmware, use default value(ZERO).
+	 * No need to do anything here
+	 */
+}
+
+static void set_vc1_rcv_seqhdr(u8 *dst, u8 *src, u32 width, u32 height)
+{
+	u32 frames = MALONE_VC1_RCV_NUM_FRAMES;
+	u32 ext_data_size = MALONE_VC1_RCV_SEQ_EXT_DATA_SIZE;
+
+	/* 0-2 Number of frames, used default value 0xFF */
+	dst[0] = frames;
+	dst[1] = frames >> 8;
+	dst[2] = frames >> 16;
+
+	/* 3 RCV version, used V1 */
+	dst[3] = MALONE_VC1_RCV_CODEC_V1_VERSION;
+
+	/* 4-7 extension data size */
+	dst[4] = ext_data_size;
+	dst[5] = ext_data_size >> 8;
+	dst[6] = ext_data_size >> 16;
+	dst[7] = ext_data_size >> 24;
+	/* 8-11 extension data */
+	dst[8] = src[0];
+	dst[9] = src[1];
+	dst[10] = src[2];
+	dst[11] = src[3];
+
+	/* height */
+	dst[12] = height;
+	dst[13] = (height >> 8) & 0xff;
+	dst[14] = (height >> 16) & 0xff;
+	dst[15] = (height >> 24) & 0xff;
+	/* width */
+	dst[16] = width;
+	dst[17] = (width >> 8) & 0xff;
+	dst[18] = (width >> 16) & 0xff;
+	dst[19] = (width >> 24) & 0xff;
+}
+
+static void set_vc1_rcv_pichdr(u8 *dst, u32 buffer_size)
+{
+	dst[0] = buffer_size;
+	dst[1] = buffer_size >> 8;
+	dst[2] = buffer_size >> 16;
+	dst[3] = buffer_size >> 24;
+}
+
+static void create_vc1_nal_pichdr(u8 *dst)
+{
+	/* need insert nal header: special ID */
+	dst[0] = 0x0;
+	dst[1] = 0x0;
+	dst[2] = 0x01;
+	dst[3] = 0x0D;
+}
+
+static int vpu_malone_insert_scode_seq(struct malone_scode_t *scode, u32 codec_id, u32 ext_size)
+{
+	u8 hdr[MALONE_PAYLOAD_HEADER_SIZE];
+	int ret;
+
+	set_payload_hdr(hdr,
+			SCODE_SEQUENCE,
+			codec_id,
+			ext_size,
+			scode->inst->out_format.width,
+			scode->inst->out_format.height);
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(hdr),
+						hdr);
+	return ret;
+}
+
+static int vpu_malone_insert_scode_pic(struct malone_scode_t *scode, u32 codec_id, u32 ext_size)
+{
+	u8 hdr[MALONE_PAYLOAD_HEADER_SIZE];
+	int ret;
+
+	set_payload_hdr(hdr,
+			SCODE_PICTURE,
+			codec_id,
+			ext_size + vb2_get_plane_payload(scode->vb, 0),
+			scode->inst->out_format.width,
+			scode->inst->out_format.height);
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(hdr),
+						hdr);
+	return 0;
+}
+
+static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
+{
+	struct vb2_v4l2_buffer *vbuf;
+	u8 nal_hdr[MALONE_VC1_NAL_HEADER_LEN];
+	u32 *data = NULL;
+
+	vbuf = to_vb2_v4l2_buffer(scode->vb);
+	data = vb2_plane_vaddr(scode->vb, 0);
+
+	if (vbuf->sequence == 0 || (vbuf->flags & V4L2_BUF_FLAG_CODECCONFIG))
+		return 0;
+	if (MALONE_VC1_CONTAIN_NAL(*data))
+		return 0;
+
+	create_vc1_nal_pichdr(nal_hdr);
+	return vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(nal_hdr),
+						nal_hdr);
+}
+
+static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
+{
+	int ret;
+	int size = 0;
+	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
+
+	scode->need_data = 0;
+
+	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE,
+					  sizeof(rcv_seqhdr));
+	if (ret < 0)
+		return ret;
+	size = ret;
+
+	set_vc1_rcv_seqhdr(rcv_seqhdr,
+			   vb2_plane_vaddr(scode->vb, 0),
+			   scode->inst->out_format.width,
+			   scode->inst->out_format.height);
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(rcv_seqhdr),
+						rcv_seqhdr);
+
+	if (ret < 0)
+		return ret;
+	size += ret;
+	return size;
+}
+
+static int vpu_malone_insert_scode_vc1_l_pic(struct malone_scode_t *scode)
+{
+	int ret;
+	int size = 0;
+	u8 rcv_pichdr[MALONE_VC1_RCV_PIC_HEADER_LEN];
+
+	ret = vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_VC1_SIMPLE,
+					  sizeof(rcv_pichdr));
+	if (ret < 0)
+		return ret;
+	size = ret;
+
+	set_vc1_rcv_pichdr(rcv_pichdr, vb2_get_plane_payload(scode->vb, 0));
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(rcv_pichdr),
+						rcv_pichdr);
+	if (ret < 0)
+		return ret;
+	size += ret;
+	return size;
+}
+
+static int vpu_malone_insert_scode_vp6_seq(struct malone_scode_t *scode)
+{
+	return vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VP6, 0);
+}
+
+static int vpu_malone_insert_scode_vp6_pic(struct malone_scode_t *scode)
+{
+	return vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_VP6, 0);
+}
+
+static int vpu_malone_insert_scode_vp8_seq(struct malone_scode_t *scode)
+{
+	int ret;
+	int size = 0;
+	u8 ivf_hdr[MALONE_VP8_IVF_SEQ_HEADER_LEN];
+
+	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VP8, sizeof(ivf_hdr));
+	if (ret < 0)
+		return ret;
+	size = ret;
+
+	set_vp8_ivf_seqhdr(ivf_hdr,
+			scode->inst->out_format.width,
+			scode->inst->out_format.height);
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(ivf_hdr),
+						ivf_hdr);
+	if (ret < 0)
+		return ret;
+	size += ret;
+
+	return size;
+}
+
+static int vpu_malone_insert_scode_vp8_pic(struct malone_scode_t *scode)
+{
+	int ret;
+	int size = 0;
+	u8 ivf_hdr[MALONE_VP8_IVF_FRAME_HEADER_LEN] = {0};
+
+	ret = vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_VP8, sizeof(ivf_hdr));
+	if (ret < 0)
+		return ret;
+	size = ret;
+
+	set_vp8_ivf_pichdr(ivf_hdr, vb2_get_plane_payload(scode->vb, 0));
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+						&scode->wptr,
+						sizeof(ivf_hdr),
+						ivf_hdr);
+	if (ret < 0)
+		return ret;
+	size += ret;
+
+	return size;
+}
+
+static int vpu_malone_insert_scode_spk_seq(struct malone_scode_t *scode)
+{
+	return vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_SPK, 0);
+}
+
+static int vpu_malone_insert_scode_spk_pic(struct malone_scode_t *scode)
+{
+	return vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_SPK, 0);
+}
+
+static const struct malone_scode_handler scode_handlers[] = {
+	{
+		/* fix me, need to swap return operation after gstreamer swap */
+		.pixelformat = V4L2_PIX_FMT_VC1_ANNEX_L,
+		.insert_scode_seq = vpu_malone_insert_scode_vc1_l_seq,
+		.insert_scode_pic = vpu_malone_insert_scode_vc1_l_pic,
+	},
+	{
+		.pixelformat = V4L2_PIX_FMT_VC1_ANNEX_G,
+		.insert_scode_pic = vpu_malone_insert_scode_vc1_g_pic,
+	},
+	{
+		.pixelformat = V4L2_PIX_FMT_VP6,
+		.insert_scode_seq = vpu_malone_insert_scode_vp6_seq,
+		.insert_scode_pic = vpu_malone_insert_scode_vp6_pic,
+	},
+	{
+		.pixelformat = V4L2_PIX_FMT_VP8,
+		.insert_scode_seq = vpu_malone_insert_scode_vp8_seq,
+		.insert_scode_pic = vpu_malone_insert_scode_vp8_pic,
+	},
+	{
+		.pixelformat = V4L2_PIX_FMT_SPK,
+		.insert_scode_seq = vpu_malone_insert_scode_spk_seq,
+		.insert_scode_pic = vpu_malone_insert_scode_spk_pic,
+	},
+};
+
+const struct malone_scode_handler *get_scode_handler(u32 pixelformat)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(scode_handlers); i++) {
+		if (scode_handlers[i].pixelformat == pixelformat)
+			return &scode_handlers[i];
+	}
+
+	return NULL;
+}
+
+static int vpu_malone_insert_scode(struct malone_scode_t *scode, u32 type)
+{
+	const struct malone_scode_handler *handler;
+	int ret = 0;
+
+	if (!scode || !scode->inst || !scode->vb)
+		return 0;
+
+	scode->need_data = 1;
+	handler = get_scode_handler(scode->inst->out_format.pixfmt);
+	if (!handler)
+		return 0;
+
+	switch (type) {
+	case SCODE_SEQUENCE:
+		if (handler->insert_scode_seq)
+			ret = handler->insert_scode_seq(scode);
+		break;
+	case SCODE_PICTURE:
+		if (handler->insert_scode_pic)
+			ret = handler->insert_scode_pic(scode);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer *str_buf,
+				struct vpu_inst *inst, struct vb2_buffer *vb,
+				u32 disp_imm)
+{
+	struct malone_scode_t scode;
+	struct vb2_v4l2_buffer *vbuf;
+	u32 wptr;
+	int size = 0;
+	int ret = 0;
+
+	wptr = str_buf->wptr;
+
+	/*add scode: SCODE_SEQUENCE, SCODE_PICTURE, SCODE_SLICE*/
+	vbuf = to_vb2_v4l2_buffer(vb);
+	scode.inst = inst;
+	scode.vb = vb;
+	scode.wptr = wptr;
+	scode.need_data = 1;
+	if (vbuf->sequence == 0 || (vbuf->flags & V4L2_BUF_FLAG_CODECCONFIG))
+		ret = vpu_malone_insert_scode(&scode, SCODE_SEQUENCE);
+
+	if (ret < 0)
+		return -ENOMEM;
+	size += ret;
+	wptr = scode.wptr;
+	if (!scode.need_data) {
+		vpu_malone_update_wptr(str_buf, wptr);
+		return size;
+	}
+
+	ret = vpu_malone_insert_scode(&scode, SCODE_PICTURE);
+	if (ret < 0)
+		return -ENOMEM;
+	size += ret;
+	wptr = scode.wptr;
+
+	ret = vpu_helper_copy_to_stream_buffer(&inst->stream_buffer,
+						&wptr,
+						vb2_get_plane_payload(vb, 0),
+						vb2_plane_vaddr(vb, 0));
+	if (ret < vb2_get_plane_payload(vb, 0))
+		return -ENOMEM;
+	size += ret;
+
+	vpu_malone_update_wptr(str_buf, wptr);
+
+	if (disp_imm && !(vbuf->flags & V4L2_BUF_FLAG_CODECCONFIG)) {
+		ret = vpu_malone_add_scode(inst->core->iface,
+					     inst->id,
+					     &inst->stream_buffer,
+					     inst->out_format.pixfmt,
+					     SCODE_PADDING_BUFFLUSH);
+		if (ret < 0)
+			return ret;
+		size += ret;
+	}
+
+	return size;
+}
+
+static int vpu_malone_input_stream_data(struct vpu_malone_str_buffer *str_buf,
+				struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf;
+	u32 wptr;
+	int ret = 0;
+
+	wptr = str_buf->wptr;
+	vbuf = to_vb2_v4l2_buffer(vb);
+	ret = vpu_helper_copy_to_stream_buffer(&inst->stream_buffer,
+						&wptr,
+						vb2_get_plane_payload(vb, 0),
+						vb2_plane_vaddr(vb, 0));
+	if (ret < vb2_get_plane_payload(vb, 0))
+		return -ENOMEM;
+
+	vpu_malone_update_wptr(str_buf, wptr);
+
+	return ret;
+}
+
+static int vpu_malone_input_ts(struct vpu_inst *inst, s64  timestamp, u32 size)
+{
+	struct vpu_ts_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.timestamp = timestamp;
+	info.size = size;
+
+	return vpu_session_fill_timestamp(inst, &info);
+}
+
+int vpu_malone_input_frame(struct vpu_shared_addr *shared,
+			struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct vpu_dec_ctrl *hc;
+	struct vb2_v4l2_buffer *vbuf;
+	struct vpu_malone_str_buffer *str_buf;
+	u32 disp_imm = 0;
+	u32 size;
+	int ret;
+
+	WARN_ON(!shared || !shared->iface || !shared->core || !shared->priv);
+	hc = shared->priv;
+	str_buf = hc->str_buf[inst->id];
+	disp_imm = hc->codec_param[inst->id].disp_imm;
+
+	if (vpu_malone_is_non_frame_mode(shared, inst->id))
+		ret = vpu_malone_input_stream_data(str_buf, inst, vb);
+	else
+		ret = vpu_malone_input_frame_data(str_buf, inst, vb, disp_imm);
+	if (ret < 0)
+		return ret;
+	size = ret;
+
+	/*
+	 * if buffer only contain codec data, and the timestamp is invalid,
+	 * don't put the invalid timestamp to resync
+	 * merge the data to next frame
+	 */
+	vbuf = to_vb2_v4l2_buffer(vb);
+	if ((vbuf->flags & V4L2_BUF_FLAG_CODECCONFIG) && (s64)vb->timestamp < 0) {
+		inst->extra_size += size;
+		return 0;
+	}
+	if (inst->extra_size) {
+		size += inst->extra_size;
+		inst->extra_size = 0;
+	}
+
+	ret = vpu_malone_input_ts(inst, vb->timestamp, size);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static bool vpu_malone_check_ready(struct vpu_shared_addr *shared, u32 instance)
+{
+	struct malone_iface *iface;
+	struct vpu_rpc_buffer_desc *desc;
+	u32 size;
+	u32 rptr;
+	u32 wptr;
+	u32 used;
+
+	iface = shared->iface;
+	desc = &iface->api_cmd_buffer_desc[instance];
+	size = desc->end - desc->start;
+	rptr = desc->rptr;
+	wptr = desc->wptr;
+	used = (wptr + size - rptr) % size;
+	if (!size || used < size / 2)
+		return true;
+
+	vpu_dbg(LVL_DEBUG, "[%d]api cmd used = %d/%d\n", instance, used, size);
+
+	return false;
+}
+
+bool vpu_malone_is_ready(struct vpu_shared_addr *shared, u32 instance)
+{
+	u32 cnt = 0;
+
+	while (!vpu_malone_check_ready(shared, instance)) {
+		if (cnt > 30)
+			return false;
+		mdelay(1);
+		cnt++;
+	}
+	return true;
+}
+
+int vpu_malone_pre_cmd(struct vpu_shared_addr *shared, u32 instance)
+{
+	if (!vpu_malone_is_ready(shared, instance)) {
+		vpu_err("[%d] is not ready\n", instance);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vpu_malone_post_cmd(struct vpu_shared_addr *shared, u32 instance)
+{
+	struct malone_iface *iface;
+	struct vpu_rpc_buffer_desc *desc;
+
+	iface = shared->iface;
+	desc = &iface->api_cmd_buffer_desc[instance];
+	desc->wptr++;
+	if (desc->wptr == desc->end)
+		desc->wptr = desc->start;
+
+	return 0;
+}
+
+int vpu_malone_init_instance(struct vpu_shared_addr *shared, u32 instance)
+{
+	struct malone_iface *iface;
+	struct vpu_rpc_buffer_desc *desc;
+
+	iface = shared->iface;
+	desc = &iface->api_cmd_buffer_desc[instance];
+	desc->wptr = desc->rptr;
+	if (desc->wptr == desc->end)
+		desc->wptr = desc->start;
+
+	return 0;
+}
+
+u32 vpu_malone_get_max_instance_count(struct vpu_shared_addr *shared)
+{
+	struct malone_iface *iface = shared->iface;
+
+	return iface->max_streams;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_malone.h b/drivers/media/platform/imx/vpu-8q/vpu_malone.h
new file mode 100644
index 000000000000..3e637374bc44
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_malone.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_MALONE_H
+#define _IMX_VPU_MALONE_H
+
+u32 vpu_malone_get_data_size(void);
+void vpu_malone_init_rpc(struct vpu_shared_addr *shared,
+			struct vpu_buffer *rpc, dma_addr_t boot_addr);
+void vpu_malone_set_log_buf(struct vpu_shared_addr *shared,
+			struct vpu_buffer *log);
+void vpu_malone_set_system_cfg(struct vpu_shared_addr *shared,
+				u32 regs_base, void __iomem *regs, u32 core_id);
+u32 vpu_malone_get_version(struct vpu_shared_addr *shared);
+int vpu_malone_get_stream_buffer_size(struct vpu_shared_addr *shared);
+int vpu_malone_config_stream_buffer(struct vpu_shared_addr *shared,
+					u32 instance, struct vpu_buffer *buf);
+int vpu_malone_get_stream_buffer_desc(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_rpc_buffer_desc *desc);
+int vpu_malone_update_stream_buffer(struct vpu_shared_addr *shared,
+					u32 instance, u32 ptr, bool write);
+int vpu_malone_set_decode_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_decode_params *params, u32 update);
+int vpu_malone_pack_cmd(struct vpu_rpc_event *pkt, u32 index, u32 id, void *data);
+int vpu_malone_convert_msg_id(u32 msg_id);
+int vpu_malone_unpack_msg_data(struct vpu_rpc_event *pkt, void *data);
+int vpu_malone_add_scode(struct vpu_shared_addr *shared,
+				u32 instance,
+				struct vpu_buffer *stream_buffer,
+				u32 pixelformat,
+				u32 scode_type);
+int vpu_malone_input_frame(struct vpu_shared_addr *shared,
+			struct vpu_inst *inst, struct vb2_buffer *vb);
+bool vpu_malone_is_ready(struct vpu_shared_addr *shared, u32 instance);
+int vpu_malone_pre_cmd(struct vpu_shared_addr *shared, u32 instance);
+int vpu_malone_post_cmd(struct vpu_shared_addr *shared, u32 instance);
+int vpu_malone_init_instance(struct vpu_shared_addr *shared, u32 instance);
+u32 vpu_malone_get_max_instance_count(struct vpu_shared_addr *shared);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_mbox.c b/drivers/media/platform/imx/vpu-8q/vpu_mbox.c
new file mode 100644
index 000000000000..c20aebb16991
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_mbox.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"MBOX"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include "vpu.h"
+#include "vpu_mbox.h"
+#include "vpu_msgs.h"
+#include "vpu_log.h"
+
+static void vpu_mbox_rx_callback(struct mbox_client *cl, void *msg)
+{
+	struct vpu_mbox *rx = container_of(cl, struct vpu_mbox, cl);
+	struct vpu_core *core = container_of(rx, struct vpu_core, rx);
+
+	vpu_isr(core, *(u32 *)msg);
+}
+
+static int vpu_mbox_request_channel(struct device *dev, struct vpu_mbox *mbox)
+{
+	struct mbox_chan *ch;
+	struct mbox_client *cl;
+
+	if (!dev || !mbox)
+		return -EINVAL;
+	if (mbox->ch)
+		return 0;
+
+	cl = &mbox->cl;
+	cl->dev = dev;
+	if (mbox->block) {
+		cl->tx_block = true;
+		cl->tx_tout = 1000;
+	} else {
+		cl->tx_block = false;
+	}
+	cl->knows_txdone = false;
+	cl->rx_callback = vpu_mbox_rx_callback;
+
+	ch = mbox_request_channel_byname(cl, mbox->name);
+	if (IS_ERR(ch)) {
+		vpu_err("Failed to request mbox chan %s, ret : %ld\n",
+				mbox->name, PTR_ERR(ch));
+		return PTR_ERR(ch);
+	}
+
+	mbox->ch = ch;
+	return 0;
+}
+
+int vpu_mbox_init(struct vpu_core *core)
+{
+	WARN_ON(!core);
+
+	scnprintf(core->tx_type.name, sizeof(core->tx_type.name) - 1, "tx0");
+	core->tx_type.block = true;
+
+	scnprintf(core->tx_data.name, sizeof(core->tx_data.name) - 1, "tx1");
+	core->tx_data.block = false;
+
+	scnprintf(core->rx.name, sizeof(core->rx.name) - 1, "rx");
+	core->rx.block = true;
+
+	return 0;
+}
+
+int vpu_mbox_request(struct vpu_core *core)
+{
+	int ret;
+
+	WARN_ON(!core);
+
+	ret = vpu_mbox_request_channel(core->dev, &core->tx_type);
+	if (ret)
+		goto error;
+	ret = vpu_mbox_request_channel(core->dev, &core->tx_data);
+	if (ret)
+		goto error;
+	ret = vpu_mbox_request_channel(core->dev, &core->rx);
+	if (ret)
+		goto error;
+
+	vpu_dbg(LVL_DEBUG, "mbox request\n");
+	return 0;
+error:
+	vpu_mbox_free(core);
+	return ret;
+}
+
+void vpu_mbox_free(struct vpu_core *core)
+{
+	WARN_ON(!core);
+
+	mbox_free_channel(core->tx_type.ch);
+	mbox_free_channel(core->tx_data.ch);
+	mbox_free_channel(core->rx.ch);
+	core->tx_type.ch = NULL;
+	core->tx_data.ch = NULL;
+	core->rx.ch = NULL;
+	vpu_dbg(LVL_DEBUG, "mbox free\n");
+}
+
+void vpu_mbox_send_type(struct vpu_core *core, u32 type)
+{
+	mbox_send_message(core->tx_type.ch, &type);
+}
+
+void vpu_mbox_send_msg(struct vpu_core *core, u32 type, u32 data)
+{
+	mbox_send_message(core->tx_data.ch, &data);
+	mbox_send_message(core->tx_type.ch, &type);
+}
+
+void vpu_mbox_enable_rx(struct vpu_dev *dev)
+{
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_mbox.h b/drivers/media/platform/imx/vpu-8q/vpu_mbox.h
new file mode 100644
index 000000000000..60fb797ccb0c
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_mbox.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_MBOX_H
+#define _IMX_VPU_MBOX_H
+
+int vpu_mbox_init(struct vpu_core *core);
+int vpu_mbox_request(struct vpu_core *core);
+void vpu_mbox_free(struct vpu_core *core);
+void vpu_mbox_send_msg(struct vpu_core *core, u32 type, u32 data);
+void vpu_mbox_send_type(struct vpu_core *core, u32 type);
+void vpu_mbox_enable_rx(struct vpu_dev *dev);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_msgs.c b/drivers/media/platform/imx/vpu-8q/vpu_msgs.c
new file mode 100644
index 000000000000..cbd15e384922
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_msgs.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"MSG"
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_rpc.h"
+#include "vpu_mbox.h"
+#include "vpu_defs.h"
+#include "vpu_cmds.h"
+#include "vpu_v4l2.h"
+#include "vpu_log.h"
+
+#define VPU_PKT_HEADER_LENGTH		3
+
+struct vpu_msg_handler {
+	u32 id;
+	void (*done)(struct vpu_inst *inst, struct vpu_rpc_event *pkt);
+};
+
+void vpu_session_handle_start_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	WARN_ON(!inst || !inst->core);
+
+	inst_dbg(inst, LVL_FLOW, "start done\n");
+}
+
+void vpu_session_handle_mem_request(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	struct vpu_pkt_mem_req_data req_data;
+
+	WARN_ON(!inst || !inst->core || !inst->ops);
+
+	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&req_data);
+	inst_dbg(inst, LVL_FLOW, "mem request event : %d:%d %d:%d %d:%d\n",
+				req_data.enc_frame_size,
+				req_data.enc_frame_num,
+				req_data.ref_frame_size,
+				req_data.ref_frame_num,
+				req_data.act_buf_size,
+				req_data.act_buf_num);
+	call_vop(inst, mem_request,
+				req_data.enc_frame_size,
+				req_data.enc_frame_num,
+				req_data.ref_frame_size,
+				req_data.ref_frame_num,
+				req_data.act_buf_size,
+				req_data.act_buf_num);
+}
+
+void vpu_session_handle_stop_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	WARN_ON(!inst || !inst->core);
+
+	inst_dbg(inst, LVL_FLOW, "stop done\n");
+
+	call_vop(inst, stop_done);
+}
+
+void vpu_session_handle_seq_hdr(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	struct vpu_dec_codec_info info;
+
+	WARN_ON(!inst || !inst->core);
+
+	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
+	call_vop(inst, event_notify, VPU_MSG_ID_SEQ_HDR_FOUND, &info);
+}
+
+void vpu_session_handle_resolution_change(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	WARN_ON(!inst || !inst->core);
+
+	call_vop(inst, event_notify, VPU_MSG_ID_RES_CHANGE, NULL);
+}
+
+void vpu_session_handle_enc_frame_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	struct vpu_enc_pic_info info;
+
+	WARN_ON(!inst || !inst->core);
+
+	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
+	inst_dbg(inst, LVL_DEBUG, "frame id = %d, wptr = 0x%x, size = %d\n",
+			info.frame_id, info.wptr, info.frame_size);
+	call_vop(inst, get_one_frame, &info);
+}
+
+void vpu_session_handle_frame_request(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	struct vpu_fs_info fs;
+
+	vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
+	call_vop(inst, event_notify, VPU_MSG_ID_FRAME_REQ, &fs);
+}
+
+void vpu_session_handle_frame_release(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+
+	WARN_ON(!inst || !inst->core);
+
+	if (inst->core->type == VPU_CORE_TYPE_ENC) {
+		struct vpu_frame_info info;
+
+		memset(&info, 0, sizeof(info));
+		vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info.sequence);
+		inst_dbg(inst, LVL_DEBUG, "frame release:%d\n", info.sequence);
+		info.type = inst->out_format.type;
+		call_vop(inst, buf_done, &info);
+	} else if (inst->core->type == VPU_CORE_TYPE_DEC) {
+		struct vpu_fs_info fs;
+
+		vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
+		call_vop(inst, event_notify, VPU_MSG_ID_FRAME_RELEASE, &fs);
+	}
+}
+
+void vpu_session_handle_input_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+
+	WARN_ON(!inst || !inst->core);
+
+	inst_dbg(inst, LVL_DEBUG, "frame input done\n");
+	call_vop(inst, input_done);
+}
+
+void vpu_session_handle_pic_decoded(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	struct vpu_dec_pic_info info;
+
+	WARN_ON(!inst || !inst->core);
+
+	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
+	call_vop(inst, get_one_frame, &info);
+}
+
+void vpu_session_handle_pic_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	struct vpu_dec_pic_info info;
+	struct vpu_frame_info frame;
+
+	WARN_ON(!inst || !inst->core);
+
+	memset(&frame, 0, sizeof(frame));
+	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
+	if (inst->core->type == VPU_CORE_TYPE_DEC)
+		frame.type = inst->cap_format.type;
+	frame.id = info.id;
+	frame.luma = info.luma;
+	frame.skipped = info.skipped;
+	frame.timestamp = info.timestamp;
+
+	call_vop(inst, buf_done, &frame);
+}
+
+void vpu_session_handle_eos(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	call_vop(inst, event_notify, VPU_MSG_ID_PIC_EOS, NULL);
+}
+
+void vpu_session_handle_error(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	call_vop(inst, event_notify, VPU_MSG_ID_UNSUPPORTED, NULL);
+	vpu_notify_codec_error(inst);
+}
+
+void vpu_session_handle_firmware_xcpt(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	char *str = (char *)pkt->data;
+
+	inst_err(inst, "%s firmware xcpt: %s\n",
+			vpu_core_type_desc(inst->core->type), str);
+	call_vop(inst, event_notify, VPU_MSG_ID_FIRMWARE_XCPT, NULL);
+	set_bit(inst->id, &inst->core->hang_mask);
+	vpu_notify_codec_error(inst);
+}
+
+struct vpu_msg_handler handlers[] = {
+	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
+	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
+	{VPU_MSG_ID_MEM_REQUEST, vpu_session_handle_mem_request},
+	{VPU_MSG_ID_SEQ_HDR_FOUND, vpu_session_handle_seq_hdr},
+	{VPU_MSG_ID_RES_CHANGE, vpu_session_handle_resolution_change},
+	{VPU_MSG_ID_FRAME_INPUT_DONE, vpu_session_handle_input_done},
+	{VPU_MSG_ID_FRAME_REQ, vpu_session_handle_frame_request},
+	{VPU_MSG_ID_FRAME_RELEASE, vpu_session_handle_frame_release},
+	{VPU_MSG_ID_ENC_DONE, vpu_session_handle_enc_frame_done},
+	{VPU_MSG_ID_PIC_DECODED, vpu_session_handle_pic_decoded},
+	{VPU_MSG_ID_DEC_DONE, vpu_session_handle_pic_done},
+	{VPU_MSG_ID_PIC_EOS, vpu_session_handle_eos},
+	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
+	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
+};
+
+int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *msg)
+{
+	int ret;
+	u32 msg_id;
+	struct vpu_msg_handler *handler = NULL;
+	unsigned int i;
+
+	ret = vpu_iface_convert_msg_id(inst->core, msg->hdr.id);
+	if (ret < 0)
+		return -EINVAL;
+
+	msg_id = ret;
+	inst_dbg(inst, LVL_EVT, "receive event(%d)\n", msg_id);
+
+	for (i = 0; i < ARRAY_SIZE(handlers); i++) {
+		if (handlers[i].id == msg_id) {
+			handler = &handlers[i];
+			break;
+		}
+	}
+
+	if (handler && handler->done)
+		handler->done(inst, msg);
+
+	vpu_response_cmd(inst, msg_id, 1);
+
+	return 0;
+}
+
+static bool vpu_inst_receive_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	u32 bytes = sizeof(struct vpu_rpc_event_header);
+	u32 ret;
+
+	memset(pkt, 0, sizeof(*pkt));
+	if (kfifo_len(&inst->msg_fifo) < bytes)
+		return false;
+
+	ret = kfifo_out(&inst->msg_fifo, pkt, bytes);
+	if (ret != bytes)
+		return false;
+
+	if (pkt->hdr.num > 0) {
+		bytes = pkt->hdr.num * sizeof(u32);
+		ret = kfifo_out(&inst->msg_fifo, pkt->data, bytes);
+		if (ret != bytes)
+			return false;
+	}
+
+	return true;
+}
+
+void vpu_inst_run_work(struct work_struct *work)
+{
+	struct vpu_inst *inst = container_of(work, struct vpu_inst, msg_work);
+	struct vpu_rpc_event pkt;
+
+	while (vpu_inst_receive_msg(inst, &pkt))
+		vpu_session_handle_msg(inst, &pkt);
+}
+
+void vpu_inst_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	u32 bytes;
+	u32 id = pkt->hdr.id;
+	int ret;
+
+	if (!inst->workqueue) {
+		vpu_session_handle_msg(inst, pkt);
+		return;
+	}
+
+	bytes = sizeof(pkt->hdr) + pkt->hdr.num * sizeof(u32);
+	ret = kfifo_in(&inst->msg_fifo, pkt, bytes);
+	if (ret != bytes)
+		vpu_err("[%d:%d]overflow: %d\n", inst->core->id, inst->id, id);
+	queue_work(inst->workqueue, &inst->msg_work);
+}
+
+int vpu_handle_msg(struct vpu_core *core)
+{
+	struct vpu_rpc_event pkt;
+	struct vpu_inst *inst;
+	int ret;
+
+	memset(&pkt, 0, sizeof(pkt));
+	while (!vpu_iface_receive_msg(core, &pkt)) {
+		vpu_dbg(LVL_DEBUG, "event index = %d, id = %d, num = %d\n",
+				pkt.hdr.index, pkt.hdr.id, pkt.hdr.num);
+
+		ret = vpu_iface_convert_msg_id(core, pkt.hdr.id);
+		if (ret < 0)
+			continue;
+
+		inst = vpu_core_find_instance(core, pkt.hdr.index);
+		if (inst) {
+			vpu_response_cmd(inst, ret, 0);
+			mutex_lock(&core->cmd_lock);
+			vpu_inst_record_flow(inst, ret);
+			mutex_unlock(&core->cmd_lock);
+
+			vpu_inst_handle_msg(inst, &pkt);
+			vpu_inst_put(inst);
+		}
+		memset(&pkt, 0, sizeof(pkt));
+	}
+
+	return 0;
+}
+
+int vpu_isr_thread(struct vpu_core *core, u32 irq_code)
+{
+	WARN_ON(!core);
+
+	vpu_dbg(LVL_DEBUG, "core[%d] irq code = 0x%x\n", core->id, irq_code);
+	switch (irq_code) {
+	case VPU_IRQ_CODE_SYNC:
+		vpu_mbox_send_msg(core, PRC_BUF_OFFSET, core->rpc.phys - core->fw.phys);
+		vpu_mbox_send_msg(core, BOOT_ADDRESS, core->fw.phys);
+		vpu_mbox_send_msg(core, INIT_DONE, 2);
+		break;
+	case VPU_IRQ_CODE_BOOT_DONE:
+		break;
+	case VPU_IRQ_CODE_SNAPSHOT_DONE:
+		break;
+	default:
+		vpu_handle_msg(core);
+		break;
+	}
+
+	return 0;
+}
+
+static void vpu_core_run_msg_work(struct vpu_core *core)
+{
+	const unsigned int SIZE = sizeof(u32);
+
+	while (kfifo_len(&core->msg_fifo) >= SIZE) {
+		u32 data;
+
+		if (kfifo_out(&core->msg_fifo, &data, SIZE) == SIZE)
+			vpu_isr_thread(core, data);
+	}
+}
+
+void vpu_msg_run_work(struct work_struct *work)
+{
+	struct vpu_core *core = container_of(work, struct vpu_core, msg_work);
+	unsigned long delay = msecs_to_jiffies(10);
+
+	vpu_core_run_msg_work(core);
+	queue_delayed_work(core->workqueue, &core->msg_delayed_work, delay);
+}
+
+void vpu_msg_delayed_work(struct work_struct *work)
+{
+	struct vpu_core *core;
+	struct delayed_work *dwork;
+	u32 bytes = sizeof(bytes);
+	u32 i;
+
+	if (!work)
+		return;
+
+	dwork = to_delayed_work(work);
+	core = container_of(dwork, struct vpu_core, msg_delayed_work);
+	if (kfifo_len(&core->msg_fifo) >= bytes)
+		vpu_core_run_msg_work(core);
+
+	bytes = sizeof(struct vpu_rpc_event_header);
+	for (i = 0; i < core->supported_instance_count; i++) {
+		struct vpu_inst *inst = vpu_core_find_instance(core, i);
+
+		if (!inst)
+			continue;
+
+		if (inst->workqueue && kfifo_len(&inst->msg_fifo) >= bytes)
+			queue_work(inst->workqueue, &inst->msg_work);
+
+		vpu_inst_put(inst);
+	}
+}
+
+
+int vpu_isr(struct vpu_core *core, u32 irq)
+{
+	WARN_ON(!core);
+
+	vpu_dbg(LVL_DEBUG, "core[%d] irq code = 0x%x\n", core->id, irq);
+	switch (irq) {
+	case VPU_IRQ_CODE_SYNC:
+		break;
+	case VPU_IRQ_CODE_BOOT_DONE:
+		complete(&core->cmp);
+		break;
+	case VPU_IRQ_CODE_SNAPSHOT_DONE:
+		complete(&core->cmp);
+		break;
+	default:
+		break;
+	}
+
+	if (kfifo_in(&core->msg_fifo, &irq, sizeof(irq)) != sizeof(irq))
+		vpu_err("[%d]overflow: %d\n", core->id, irq);
+	queue_work(core->workqueue, &core->msg_work);
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_msgs.h b/drivers/media/platform/imx/vpu-8q/vpu_msgs.h
new file mode 100644
index 000000000000..4bcf7be34097
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_msgs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_MSGS_H
+#define _IMX_VPU_MSGS_H
+
+int vpu_isr(struct vpu_core *core, u32 irq);
+void vpu_inst_run_work(struct work_struct *work);
+void vpu_msg_run_work(struct work_struct *work);
+void vpu_msg_delayed_work(struct work_struct *work);
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_rpc.c b/drivers/media/platform/imx/vpu-8q/vpu_rpc.c
new file mode 100644
index 000000000000..6d701cacdb11
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_rpc.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"RPC"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/svc/misc.h>
+#include "vpu.h"
+#include "vpu_rpc.h"
+#include "vpu_imx8q.h"
+#include "vpu_windsor.h"
+#include "vpu_malone.h"
+#include "vpu_log.h"
+
+u32 vpu_iface_check_memory_region(struct vpu_core *core, dma_addr_t addr, u32 size)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->check_memory_region)
+		return VPU_CORE_MEMORY_INVALID;
+
+	return ops->check_memory_region(core->fw.phys, addr, size);
+}
+
+u32 vpu_rpc_check_buffer_space(struct vpu_rpc_buffer_desc *desc, bool write)
+{
+	u32 ptr1;
+	u32 ptr2;
+	u32 size;
+
+	WARN_ON(!desc);
+
+	size = desc->end - desc->start;
+	if (write) {
+		ptr1 = desc->wptr;
+		ptr2 = desc->rptr;
+	} else {
+		ptr1 = desc->rptr;
+		ptr2 = desc->wptr;
+	}
+
+	if (ptr1 == ptr2) {
+		if (!write)
+			return 0;
+		else
+			return size;
+	}
+
+	return (ptr2 + size - ptr1) % size;
+}
+
+int vpu_rpc_send_cmd_buf(struct vpu_shared_addr *shared,
+			struct vpu_rpc_event *cmd)
+{
+	struct vpu_rpc_buffer_desc *desc;
+	u32 space = 0;
+	u32 *data;
+	u32 wptr;
+	u32 i;
+
+	WARN_ON(!shared || !shared->cmd_mem_vir || !cmd);
+
+	desc = shared->cmd_desc;
+	space = vpu_rpc_check_buffer_space(desc, true);
+	if (space < (((cmd->hdr.num + 1) << 2) + 16)) {
+		vpu_err("Cmd Buffer is no space for [%d] %d\n",
+				cmd->hdr.index, cmd->hdr.id);
+		return -EINVAL;
+	}
+	wptr = desc->wptr;
+	data = (u32 *)(shared->cmd_mem_vir + desc->wptr - desc->start);
+	*data = 0;
+	*data |= ((cmd->hdr.index & 0xff) << 24);
+	*data |= ((cmd->hdr.num & 0xff) << 16);
+	*data |= (cmd->hdr.id & 0x3fff);
+	wptr += 4;
+	data++;
+	if (wptr >= desc->end) {
+		wptr = desc->start;
+		data = shared->cmd_mem_vir;
+	}
+
+	for (i = 0; i < cmd->hdr.num; i++) {
+		*data = cmd->data[i];
+		wptr += 4;
+		data++;
+		if (wptr >= desc->end) {
+			wptr = desc->start;
+			data = shared->cmd_mem_vir;
+		}
+	}
+
+	/*update wptr after data is written*/
+	mb();
+	desc->wptr = wptr;
+
+	return 0;
+}
+
+bool vpu_rpc_check_msg(struct vpu_shared_addr *shared)
+{
+	struct vpu_rpc_buffer_desc *desc;
+	u32 space = 0;
+	u32 msgword;
+	u32 msgnum;
+
+	WARN_ON(!shared || !shared->msg_desc);
+
+	desc = shared->msg_desc;
+	space = vpu_rpc_check_buffer_space(desc, 0);
+	space = (space >> 2);
+
+	if (space) {
+		msgword = *(u32 *)(shared->msg_mem_vir + desc->rptr - desc->start);
+		msgnum = (msgword & 0xff0000) >> 16;
+		if (msgnum <= space)
+			return true;
+	}
+
+	return false;
+}
+
+int vpu_rpc_receive_msg_buf(struct vpu_shared_addr *shared, struct vpu_rpc_event *msg)
+{
+	struct vpu_rpc_buffer_desc *desc;
+	u32 *data;
+	u32 msgword;
+	u32 rptr;
+	u32 i;
+
+	WARN_ON(!shared || !shared->msg_desc || !msg);
+
+	if (!vpu_rpc_check_msg(shared))
+		return -EINVAL;
+
+	desc = shared->msg_desc;
+	data = (u32 *)(shared->msg_mem_vir + desc->rptr - desc->start);
+	rptr = desc->rptr;
+	msgword = *data;
+	data++;
+	rptr += 4;
+	if (rptr >= desc->end) {
+		rptr = desc->start;
+		data = shared->msg_mem_vir;
+	}
+
+	msg->hdr.index = (msgword >> 24) & 0xff;
+	msg->hdr.num = (msgword >> 16) & 0xff;
+	msg->hdr.id = msgword & 0x3fff;
+
+	for (i = 0; i < msg->hdr.num; i++) {
+		msg->data[i] = *data;
+		data++;
+		rptr += 4;
+		if (rptr >= desc->end) {
+			rptr = desc->start;
+			data = shared->msg_mem_vir;
+		}
+	}
+
+	/*update rptr after data is read*/
+	mb();
+	desc->rptr = rptr;
+
+	return 0;
+}
+
+struct vpu_iface_ops imx8q_rpc_ops[] = {
+	[VPU_CORE_TYPE_ENC] = {
+		.check_codec = vpu_imx8q_check_codec,
+		.check_fmt = vpu_imx8q_check_fmt,
+		.boot_core = vpu_imx8q_boot_core,
+		.get_power_state = vpu_imx8q_get_power_state,
+		.on_firmware_loaded = vpu_imx8q_on_firmware_loaded,
+		.get_data_size = vpu_windsor_get_data_size,
+		.check_memory_region = vpu_imx8q_check_memory_region,
+		.init_rpc = vpu_windsor_init_rpc,
+		.set_log_buf = vpu_windsor_set_log_buf,
+		.set_system_cfg = vpu_windsor_set_system_cfg,
+		.get_version = vpu_windsor_get_version,
+		.send_cmd_buf = vpu_rpc_send_cmd_buf,
+		.receive_msg_buf = vpu_rpc_receive_msg_buf,
+		.pack_cmd = vpu_windsor_pack_cmd,
+		.convert_msg_id = vpu_windsor_convert_msg_id,
+		.unpack_msg_data = vpu_windsor_unpack_msg_data,
+		.config_memory_resource = vpu_windsor_config_memory_resource,
+		.get_stream_buffer_size = vpu_windsor_get_stream_buffer_size,
+		.config_stream_buffer = vpu_windsor_config_stream_buffer,
+		.get_stream_buffer_desc = vpu_windsor_get_stream_buffer_desc,
+		.update_stream_buffer = vpu_windsor_update_stream_buffer,
+		.set_encode_params = vpu_windsor_set_encode_params,
+		.input_frame = vpu_windsor_input_frame,
+		.get_max_instance_count = vpu_windsor_get_max_instance_count,
+	},
+	[VPU_CORE_TYPE_DEC] = {
+		.check_codec = vpu_imx8q_check_codec,
+		.check_fmt = vpu_imx8q_check_fmt,
+		.boot_core = vpu_imx8q_boot_core,
+		.get_power_state = vpu_imx8q_get_power_state,
+		.on_firmware_loaded = vpu_imx8q_on_firmware_loaded,
+		.get_data_size = vpu_malone_get_data_size,
+		.check_memory_region = vpu_imx8q_check_memory_region,
+		.init_rpc = vpu_malone_init_rpc,
+		.set_log_buf = vpu_malone_set_log_buf,
+		.set_system_cfg = vpu_malone_set_system_cfg,
+		.get_version = vpu_malone_get_version,
+		.send_cmd_buf = vpu_rpc_send_cmd_buf,
+		.receive_msg_buf = vpu_rpc_receive_msg_buf,
+		.get_stream_buffer_size = vpu_malone_get_stream_buffer_size,
+		.config_stream_buffer = vpu_malone_config_stream_buffer,
+		.set_decode_params = vpu_malone_set_decode_params,
+		.pack_cmd = vpu_malone_pack_cmd,
+		.convert_msg_id = vpu_malone_convert_msg_id,
+		.unpack_msg_data = vpu_malone_unpack_msg_data,
+		.get_stream_buffer_desc = vpu_malone_get_stream_buffer_desc,
+		.update_stream_buffer = vpu_malone_update_stream_buffer,
+		.add_scode = vpu_malone_add_scode,
+		.input_frame = vpu_malone_input_frame,
+		.pre_send_cmd = vpu_malone_pre_cmd,
+		.post_send_cmd = vpu_malone_post_cmd,
+		.init_instance = vpu_malone_init_instance,
+		.get_max_instance_count = vpu_malone_get_max_instance_count,
+	},
+};
+
+struct vpu_iface_ops *vpu_iface_get(struct vpu_core *core)
+{
+	struct vpu_iface_ops *rpc_ops = NULL;
+	u32 size = 0;
+
+	WARN_ON(!core || !core->vpu || !core->vpu->res);
+
+	switch (core->vpu->res->plat_type) {
+	case IMX8QXP:
+	case IMX8QM:
+		rpc_ops = imx8q_rpc_ops;
+		size = ARRAY_SIZE(imx8q_rpc_ops);
+		break;
+	default:
+		return NULL;
+	}
+
+	if (core->type >= size)
+		return NULL;
+
+	return &rpc_ops[core->type];
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_rpc.h b/drivers/media/platform/imx/vpu-8q/vpu_rpc.h
new file mode 100644
index 000000000000..a874817a4021
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_rpc.h
@@ -0,0 +1,472 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_RPC_H
+#define _IMX_VPU_RPC_H
+
+#include <media/videobuf2-core.h>
+#include "vpu_codec.h"
+
+struct vpu_rpc_buffer_desc {
+	u32 wptr;
+	u32 rptr;
+	u32 start;
+	u32 end;
+};
+
+struct vpu_shared_addr {
+	void *iface;
+	struct vpu_rpc_buffer_desc *cmd_desc;
+	void *cmd_mem_vir;
+	struct vpu_rpc_buffer_desc *msg_desc;
+	void *msg_mem_vir;
+
+	unsigned long boot_addr;
+	struct vpu_core *core;
+	void *priv;
+};
+
+struct vpu_rpc_event_header {
+	u32 index;
+	u32 id;
+	u32 num;
+};
+
+struct vpu_rpc_event {
+	struct vpu_rpc_event_header hdr;
+	u32 data[256];
+};
+
+struct vpu_iface_ops {
+	bool (*check_codec)(enum vpu_core_type type);
+	bool (*check_fmt)(enum vpu_core_type type, u32 pixelfmt);
+	u32 (*get_data_size)(void);
+	u32 (*check_memory_region)(dma_addr_t base, dma_addr_t addr, u32 size);
+	int (*boot_core)(struct vpu_core *core);
+	int (*shutdown_core)(struct vpu_core *core);
+	int (*restore_core)(struct vpu_core *core);
+	int (*get_power_state)(struct vpu_core *core);
+	int (*on_firmware_loaded)(struct vpu_core *core);
+	void (*init_rpc)(struct vpu_shared_addr *shared,
+			struct vpu_buffer *rpc, dma_addr_t boot_addr);
+	void (*set_log_buf)(struct vpu_shared_addr *shared,
+			struct vpu_buffer *log);
+	void (*set_system_cfg)(struct vpu_shared_addr *shared,
+			u32 regs_base, void __iomem *regs, u32 index);
+	void (*set_stream_cfg)(struct vpu_shared_addr *shared, u32 index);
+	u32 (*get_version)(struct vpu_shared_addr *shared);
+	u32 (*get_max_instance_count)(struct vpu_shared_addr *shared);
+	int (*get_stream_buffer_size)(struct vpu_shared_addr *shared);
+	int (*send_cmd_buf)(struct vpu_shared_addr *shared,
+			struct vpu_rpc_event *cmd);
+	int (*receive_msg_buf)(struct vpu_shared_addr *shared,
+			struct vpu_rpc_event *msg);
+	int (*pack_cmd)(struct vpu_rpc_event *pkt, u32 index, u32 id, void *data);
+	int (*convert_msg_id)(u32 msg_id);
+	int (*unpack_msg_data)(struct vpu_rpc_event *pkt, void *data);
+	int (*input_frame)(struct vpu_shared_addr *shared,
+			struct vpu_inst *inst, struct vb2_buffer *vb);
+	int (*config_memory_resource)(struct vpu_shared_addr *shared,
+					u32 instance,
+					u32 type,
+					u32 index,
+					struct vpu_buffer *buf);
+	int (*config_stream_buffer)(struct vpu_shared_addr *shared,
+					u32 instance,
+					struct vpu_buffer *buf);
+	int (*update_stream_buffer)(struct vpu_shared_addr *shared,
+					u32 instance, u32 ptr, bool write);
+	int (*get_stream_buffer_desc)(struct vpu_shared_addr *shared,
+					u32 instance,
+					struct vpu_rpc_buffer_desc *desc);
+	int (*set_encode_params)(struct vpu_shared_addr *shared,
+			u32 instance,
+			struct vpu_encode_params *params, u32 update);
+	int (*set_decode_params)(struct vpu_shared_addr *shared,
+			u32 instance,
+			struct vpu_decode_params *params, u32 update);
+	int (*add_scode)(struct vpu_shared_addr *shared,
+				u32 instance,
+				struct vpu_buffer *stream_buffer,
+				u32 pixelformat,
+				u32 scode_type);
+	int (*pre_send_cmd)(struct vpu_shared_addr *shared, u32 instance);
+	int (*post_send_cmd)(struct vpu_shared_addr *shared, u32 instance);
+	int (*init_instance)(struct vpu_shared_addr *shared, u32 instance);
+};
+
+enum {
+	VPU_CORE_MEMORY_INVALID = 0,
+	VPU_CORE_MEMORY_CACHED,
+	VPU_CORE_MEMORY_UNCACHED
+};
+
+struct vpu_rpc_region_t {
+	dma_addr_t start;
+	dma_addr_t end;
+	dma_addr_t type;
+};
+
+struct vpu_iface_ops *vpu_iface_get(struct vpu_core *core);
+u32 vpu_iface_check_memory_region(struct vpu_core *core, dma_addr_t addr, u32 size);
+
+static inline bool vpu_iface_check_codec(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->check_codec)
+		return ops->check_codec(core->type);
+
+	return true;
+}
+
+static inline bool vpu_iface_check_format(struct vpu_core *core, u32 pixelfmt)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->check_fmt)
+		return ops->check_fmt(core->type, pixelfmt);
+
+	return true;
+}
+
+static inline int vpu_iface_boot_core(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->boot_core)
+		return ops->boot_core(core);
+	return 0;
+}
+
+static inline int vpu_iface_get_power_state(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->get_power_state)
+		return ops->get_power_state(core);
+	return 1;
+}
+
+static inline int vpu_iface_shutdown_core(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->shutdown_core)
+		return ops->shutdown_core(core);
+	return 0;
+}
+
+static inline int vpu_iface_restore_core(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->restore_core)
+		return ops->restore_core(core);
+	return -EINVAL;
+}
+
+static inline int vpu_iface_on_firmware_loaded(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (ops && ops->on_firmware_loaded)
+		return ops->on_firmware_loaded(core);
+
+	return 0;
+}
+
+static inline u32 vpu_iface_get_data_size(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->get_data_size)
+		return 0;
+
+	return ops->get_data_size();
+}
+
+static inline int vpu_iface_init(struct vpu_core *core,
+				struct vpu_shared_addr *shared,
+				struct vpu_buffer *rpc,
+				dma_addr_t boot_addr)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->init_rpc)
+		return -EINVAL;
+
+	ops->init_rpc(shared, rpc, boot_addr);
+	core->iface = shared;
+	shared->core = core;
+	if (rpc->bytesused > rpc->length)
+		return -ENOSPC;
+	return 0;
+}
+
+static inline int vpu_iface_set_log_buf(struct vpu_core *core,
+					struct vpu_buffer *log)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops)
+		return -EINVAL;
+
+	if (ops->set_log_buf)
+		ops->set_log_buf(core->iface, log);
+
+	return 0;
+}
+
+static inline int vpu_iface_config_system(struct vpu_core *core,
+		u32 regs_base, void __iomem *regs)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops)
+		return -EINVAL;
+	if (ops->set_system_cfg)
+		ops->set_system_cfg(core->iface, regs_base, regs, core->id);
+
+	return 0;
+}
+
+static inline int vpu_iface_get_stream_buffer_size(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->get_stream_buffer_size)
+		return 0;
+
+	return ops->get_stream_buffer_size(core->iface);
+}
+
+static inline int vpu_iface_config_stream(struct vpu_inst *inst)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops)
+		return -EINVAL;
+	if (ops->set_stream_cfg)
+		ops->set_stream_cfg(inst->core->iface, inst->id);
+	return 0;
+}
+
+static inline int vpu_iface_send_cmd(struct vpu_core *core, struct vpu_rpc_event *cmd)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->send_cmd_buf)
+		return -EINVAL;
+
+	return ops->send_cmd_buf(core->iface, cmd);
+}
+
+static inline int vpu_iface_receive_msg(struct vpu_core *core, struct vpu_rpc_event *msg)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->receive_msg_buf)
+		return -EINVAL;
+
+	return ops->receive_msg_buf(core->iface, msg);
+}
+
+static inline int vpu_iface_pack_cmd(struct vpu_core *core,
+					struct vpu_rpc_event *pkt,
+					u32 index, u32 id, void *data)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->pack_cmd)
+		return -EINVAL;
+	return ops->pack_cmd(pkt, index, id, data);
+}
+
+static inline int vpu_iface_convert_msg_id(struct vpu_core *core, u32 msg_id)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->convert_msg_id)
+		return -EINVAL;
+
+	return ops->convert_msg_id(msg_id);
+}
+
+static inline int vpu_iface_unpack_msg_data(struct vpu_core *core,
+						struct vpu_rpc_event *pkt, void *data)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->unpack_msg_data)
+		return -EINVAL;
+
+	return ops->unpack_msg_data(pkt, data);
+}
+
+static inline int vpu_iface_input_frame(struct vpu_inst *inst,
+						struct vb2_buffer *vb)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	if (!ops || !ops->input_frame)
+		return -EINVAL;
+
+	return ops->input_frame(inst->core->iface, inst, vb);
+}
+
+static inline int vpu_iface_config_memory_resource(struct vpu_inst *inst,
+			u32 type, u32 index, struct vpu_buffer *buf)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->config_memory_resource)
+		return -EINVAL;
+
+	return ops->config_memory_resource(inst->core->iface,
+					inst->id,
+					type, index, buf);
+}
+
+static inline int vpu_iface_config_stream_buffer(struct vpu_inst *inst,
+						struct vpu_buffer *buf)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->config_stream_buffer)
+		return -EINVAL;
+
+	return ops->config_stream_buffer(inst->core->iface, inst->id, buf);
+}
+
+static inline int vpu_iface_update_stream_buffer(struct vpu_inst *inst,
+						u32 ptr, bool write)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->update_stream_buffer)
+		return -EINVAL;
+
+	return ops->update_stream_buffer(inst->core->iface, inst->id, ptr, write);
+}
+
+static inline int vpu_iface_get_stream_buffer_desc(struct vpu_inst *inst,
+					struct vpu_rpc_buffer_desc *desc)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->get_stream_buffer_desc)
+		return -EINVAL;
+
+	if (!desc)
+		return 0;
+
+	return ops->get_stream_buffer_desc(inst->core->iface, inst->id, desc);
+}
+
+static inline u32 vpu_iface_get_version(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->get_version)
+		return 0;
+
+	return ops->get_version(core->iface);
+}
+
+static inline u32 vpu_iface_get_max_instance_count(struct vpu_core *core)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(core);
+
+	if (!ops || !ops->get_max_instance_count)
+		return 0;
+
+	return ops->get_max_instance_count(core->iface);
+}
+
+static inline int vpu_iface_set_encode_params(struct vpu_inst *inst,
+				struct vpu_encode_params *params, u32 update)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->set_encode_params)
+		return -EINVAL;
+
+	return ops->set_encode_params(inst->core->iface, inst->id, params, update);
+}
+
+static inline int vpu_iface_set_decode_params(struct vpu_inst *inst,
+				struct vpu_decode_params *params, u32 update)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->set_decode_params)
+		return -EINVAL;
+
+	return ops->set_decode_params(inst->core->iface, inst->id, params, update);
+}
+
+static inline int vpu_iface_add_scode(struct vpu_inst *inst, u32 scode_type)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (!ops || !ops->add_scode)
+		return -EINVAL;
+
+	return ops->add_scode(inst->core->iface, inst->id,
+				&inst->stream_buffer,
+				inst->out_format.pixfmt,
+				scode_type);
+}
+
+static inline int vpu_iface_pre_send_cmd(struct vpu_inst *inst)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (ops && ops->pre_send_cmd)
+		return ops->pre_send_cmd(inst->core->iface, inst->id);
+	return 0;
+}
+
+static inline int vpu_iface_post_send_cmd(struct vpu_inst *inst)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (ops && ops->post_send_cmd)
+		return ops->post_send_cmd(inst->core->iface, inst->id);
+	return 0;
+}
+
+static inline int vpu_iface_init_instance(struct vpu_inst *inst)
+{
+	struct vpu_iface_ops *ops = vpu_iface_get(inst->core);
+
+	WARN_ON(inst->id < 0);
+	if (ops && ops->init_instance)
+		return ops->init_instance(inst->core->iface, inst->id);
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_v4l2.c b/drivers/media/platform/imx/vpu-8q/vpu_v4l2.c
new file mode 100644
index 000000000000..c3953165d08a
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_v4l2.c
@@ -0,0 +1,730 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"V4L2"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+#include <linux/imx_vpu.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_v4l2.h"
+#include "vpu_msgs.h"
+#include "vpu_helpers.h"
+#include "vpu_log.h"
+
+dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no)
+{
+	return vb2_dma_contig_plane_dma_addr(vb, plane_no) +
+			vb->planes[plane_no].data_offset;
+}
+
+unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no)
+{
+	if (plane_no >= vb->num_planes)
+		return 0;
+	return vb2_plane_size(vb, plane_no) - vb->planes[plane_no].data_offset;
+}
+
+void vpu_v4l2_set_error(struct vpu_inst *inst)
+{
+	struct vb2_queue *src_q;
+	struct vb2_queue *dst_q;
+
+	src_q = v4l2_m2m_get_src_vq(inst->m2m_ctx);
+	dst_q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	if (src_q)
+		src_q->error = 1;
+	if (dst_q)
+		dst_q->error = 1;
+}
+
+int vpu_notify_eos(struct vpu_inst *inst)
+{
+	const struct v4l2_event ev = {
+		.id = 0,
+		.type = V4L2_EVENT_EOS
+	};
+
+	inst_dbg(inst, LVL_FLOW, "notify eos event\n");
+	v4l2_event_queue_fh(&inst->fh, &ev);
+
+	return 0;
+}
+
+int vpu_notify_source_change(struct vpu_inst *inst)
+{
+	const struct v4l2_event ev = {
+		.id = 0,
+		.type = V4L2_EVENT_SOURCE_CHANGE,
+		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION
+	};
+
+	inst_dbg(inst, LVL_FLOW, "notify source change event\n");
+	v4l2_event_queue_fh(&inst->fh, &ev);
+	return 0;
+}
+
+int vpu_notify_skip(struct vpu_inst *inst)
+{
+	const struct v4l2_event ev = {
+		.id = 0,
+		.type = V4L2_EVENT_SKIP,
+		.u.data[0] = 0xff,
+	};
+
+	inst_dbg(inst, LVL_FLOW, "notify skip event\n");
+	v4l2_event_queue_fh(&inst->fh, &ev);
+
+	return 0;
+}
+
+int vpu_notify_codec_error(struct vpu_inst *inst)
+{
+	const struct v4l2_event ev = {
+		.id = 0,
+		.type = V4L2_EVENT_CODEC_ERROR,
+	};
+
+	inst_dbg(inst, LVL_FLOW, "notify error event\n");
+	v4l2_event_queue_fh(&inst->fh, &ev);
+	vpu_v4l2_set_error(inst);
+
+	return 0;
+}
+
+const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst,
+		 struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	u32 type = f->type;
+	u32 stride;
+	u32 bytesperline;
+	u32 sizeimage;
+	const struct vpu_format *fmt;
+	int i;
+
+	fmt = vpu_helper_find_format(inst, type, pixmp->pixelformat);
+	if (!fmt) {
+		fmt = vpu_helper_enum_format(inst, type, 0);
+		if (!fmt)
+			return NULL;
+		pixmp->pixelformat = fmt->pixfmt;
+	}
+
+	stride = inst->core->res->stride;
+	pixmp->width = vpu_helper_valid_frame_width(inst, pixmp->width);
+	pixmp->height = vpu_helper_valid_frame_height(inst, pixmp->height);
+	pixmp->flags = fmt->flags;
+	pixmp->num_planes = fmt->num_planes;
+	if (pixmp->field == V4L2_FIELD_ANY)
+		pixmp->field = V4L2_FIELD_NONE;
+	for (i = 0; i < pixmp->num_planes; i++) {
+		bytesperline = ALIGN(pixmp->width, stride);
+		sizeimage = vpu_helper_get_plane_size(pixmp->pixelformat,
+				pixmp->width, pixmp->height, i, stride);
+		if ((s32)(pixmp->plane_fmt[i].bytesperline) <= 0)
+			pixmp->plane_fmt[i].bytesperline = bytesperline;
+		if ((s32)(pixmp->plane_fmt[i].sizeimage) <= 0)
+			pixmp->plane_fmt[i].sizeimage = sizeimage;
+		if (pixmp->plane_fmt[i].bytesperline < bytesperline)
+			pixmp->plane_fmt[i].bytesperline = bytesperline;
+		if (pixmp->plane_fmt[i].sizeimage <= sizeimage)
+			pixmp->plane_fmt[i].sizeimage = sizeimage;
+	}
+
+	return fmt;
+}
+
+static bool vpu_check_ready(struct vpu_inst *inst, u32 type)
+{
+	if (!inst)
+		return false;
+	if (inst->state == VPU_CODEC_STATE_DEINIT || inst->id < 0)
+		return false;
+	if (!inst->ops->check_ready)
+		return true;
+	return call_vop(inst, check_ready, type);
+}
+
+int vpu_process_output_buffer(struct vpu_inst *inst)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vpu_vb2_buffer *vpu_buf = NULL;
+
+	if (!inst)
+		return -EINVAL;
+
+	if (!vpu_check_ready(inst, inst->out_format.type))
+		return -EINVAL;
+
+	v4l2_m2m_for_each_src_buf(inst->m2m_ctx, buf) {
+		vpu_buf = container_of(buf, struct vpu_vb2_buffer, m2m_buf);
+		if (vpu_buf->state == VPU_BUF_STATE_IDLE)
+			break;
+		vpu_buf = NULL;
+	}
+
+	if (!vpu_buf)
+		return -EINVAL;
+
+	inst_dbg(inst, LVL_DEBUG, "frame id = %d / %d\n",
+			vpu_buf->m2m_buf.vb.sequence, inst->sequence);
+	return call_vop(inst, process_output, &vpu_buf->m2m_buf.vb.vb2_buf);
+}
+
+int vpu_process_capture_buffer(struct vpu_inst *inst)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vpu_vb2_buffer *vpu_buf = NULL;
+
+	if (!inst)
+		return -EINVAL;
+
+	if (!vpu_check_ready(inst, inst->cap_format.type))
+		return -EINVAL;
+
+	v4l2_m2m_for_each_dst_buf(inst->m2m_ctx, buf) {
+		vpu_buf = container_of(buf, struct vpu_vb2_buffer, m2m_buf);
+		if (vpu_buf->state == VPU_BUF_STATE_IDLE)
+			break;
+		vpu_buf = NULL;
+	}
+	if (!vpu_buf)
+		return -EINVAL;
+
+	return call_vop(inst, process_capture, &vpu_buf->m2m_buf.vb.vb2_buf);
+}
+
+struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst,
+						u32 type, u32 sequence)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vb2_v4l2_buffer *vbuf = NULL;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		v4l2_m2m_for_each_src_buf(inst->m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->sequence == sequence)
+				break;
+			vbuf = NULL;
+		}
+	} else {
+		v4l2_m2m_for_each_dst_buf(inst->m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->sequence == sequence)
+				break;
+			vbuf = NULL;
+		}
+	}
+
+	return vbuf;
+}
+
+struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst,
+						u32 type, u32 idx)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vb2_v4l2_buffer *vbuf = NULL;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		v4l2_m2m_for_each_src_buf(inst->m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->vb2_buf.index == idx)
+				break;
+			vbuf = NULL;
+		}
+	} else {
+		v4l2_m2m_for_each_dst_buf(inst->m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->vb2_buf.index == idx)
+				break;
+			vbuf = NULL;
+		}
+	}
+
+	return vbuf;
+}
+
+int vpu_get_num_buffers(struct vpu_inst *inst, u32 type)
+{
+	struct vb2_queue *q;
+
+	if (!inst || !inst->m2m_ctx)
+		return -EINVAL;
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		q = v4l2_m2m_get_src_vq(inst->m2m_ctx);
+	else
+		q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+
+	return q->num_buffers;
+}
+
+static void vpu_m2m_device_run(void *priv)
+{
+}
+
+static void vpu_m2m_job_abort(void *priv)
+{
+	struct vpu_inst *inst = priv;
+
+	v4l2_m2m_job_finish(inst->m2m_dev, inst->m2m_ctx);
+}
+
+static const struct v4l2_m2m_ops vpu_m2m_ops = {
+	.device_run = vpu_m2m_device_run,
+	.job_abort = vpu_m2m_job_abort
+};
+
+static int vpu_vb2_queue_setup(struct vb2_queue *vq,
+				unsigned int *buf_count,
+				unsigned int *plane_count,
+				unsigned int psize[],
+				struct device *allocators[])
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(vq);
+	struct vpu_format *cur_fmt;
+	int i;
+
+	cur_fmt = vpu_get_format(inst, vq->type);
+
+	if (*plane_count) {
+		if (*plane_count != cur_fmt->num_planes)
+			return -EINVAL;
+		for (i = 0; i < cur_fmt->num_planes; i++) {
+			if (psize[i] < cur_fmt->sizeimage[i])
+				return -EINVAL;
+		}
+	}
+
+	*plane_count = cur_fmt->num_planes;
+	for (i = 0; i < cur_fmt->num_planes; i++)
+		psize[i] = cur_fmt->sizeimage[i];
+
+	inst_dbg(inst, LVL_FLOW, "%s queue setup : %u; %u, %u\n",
+			vpu_type_name(vq->type),
+			*buf_count,
+			psize[0], psize[1]);
+
+	return 0;
+}
+
+static int vpu_vb2_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+	vpu_buf->state = VPU_BUF_STATE_IDLE;
+
+	return 0;
+}
+
+static void vpu_vb2_buf_cleanup(struct vb2_buffer *vb)
+{
+}
+
+static int vpu_vb2_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+	struct vpu_format *cur_fmt;
+	u32 i;
+
+	cur_fmt = vpu_get_format(inst, vb->type);
+	if (vb->num_planes != cur_fmt->num_planes)
+		return -EINVAL;
+	for (i = 0; i < cur_fmt->num_planes; i++) {
+		if (vpu_get_vb_length(vb, i) < cur_fmt->sizeimage[i]) {
+			inst_err(inst, "%s buf[%d] is invalid\n",
+					vpu_type_name(vb->type),
+					vb->index);
+			vpu_buf->state = VPU_BUF_STATE_ERROR;
+		}
+	}
+
+	return 0;
+}
+
+static void vpu_vb2_buf_finish(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_queue *q = vb->vb2_queue;
+
+	if (vbuf->flags & V4L2_BUF_FLAG_LAST)
+		vpu_notify_eos(inst);
+
+	if (list_empty(&q->done_list))
+		call_vop(inst, on_queue_empty, q->type);
+}
+
+void vpu_vb2_buffers_return(struct vpu_inst *inst,
+		unsigned int type, enum vb2_buffer_state state)
+{
+	struct vb2_v4l2_buffer *buf;
+
+	if (!inst || !inst->m2m_ctx)
+		return;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		while ((buf = v4l2_m2m_src_buf_remove(inst->m2m_ctx)))
+			v4l2_m2m_buf_done(buf, state);
+	} else {
+		while ((buf = v4l2_m2m_dst_buf_remove(inst->m2m_ctx)))
+			v4l2_m2m_buf_done(buf, state);
+	}
+}
+
+static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(q);
+
+	vpu_inst_get(inst);
+	inst_dbg(inst, LVL_FLOW, "%s start streaming : %d\n",
+			vpu_type_name(q->type), q->num_buffers);
+	call_vop(inst, start, q->type);
+	vb2_clear_last_buffer_dequeued(q);
+
+	return 0;
+}
+
+static void vpu_vb2_stop_streaming(struct vb2_queue *q)
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(q);
+
+	inst_dbg(inst, LVL_FLOW, "%s stop streaming\n", vpu_type_name(q->type));
+
+	call_vop(inst, stop, q->type);
+
+	mutex_lock(&inst->lock);
+	vpu_vb2_buffers_return(inst, q->type, VB2_BUF_STATE_ERROR);
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		inst->sequence = 0;
+	mutex_unlock(&inst->lock);
+
+	vpu_inst_put(inst);
+}
+
+static void vpu_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+
+	inst_dbg(inst, LVL_DEBUG, "%s buf queue\n", vpu_type_name(vb->type));
+
+	mutex_lock(&inst->lock);
+
+	if (V4L2_TYPE_IS_OUTPUT(vb->type)) {
+		vbuf->sequence = inst->sequence++;
+		if ((s64)vb->timestamp < 0)
+			vb->timestamp = VPU_INVALID_TIMESTAMP;
+	}
+
+	v4l2_m2m_buf_queue(inst->m2m_ctx, vbuf);
+	vpu_process_output_buffer(inst);
+	vpu_process_capture_buffer(inst);
+
+	mutex_unlock(&inst->lock);
+}
+
+static struct vb2_ops vpu_vb2_ops = {
+	.queue_setup        = vpu_vb2_queue_setup,
+	.buf_init           = vpu_vb2_buf_init,
+	.buf_cleanup        = vpu_vb2_buf_cleanup,
+	.buf_prepare        = vpu_vb2_buf_prepare,
+	.buf_finish         = vpu_vb2_buf_finish,
+	.start_streaming    = vpu_vb2_start_streaming,
+	.stop_streaming     = vpu_vb2_stop_streaming,
+	.buf_queue          = vpu_vb2_buf_queue,
+};
+
+static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq,
+			  struct vb2_queue *dst_vq)
+{
+	struct vpu_inst *inst = priv;
+	int ret;
+
+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	src_vq->ops = &vpu_vb2_ops;
+	src_vq->mem_ops = &vb2_dma_contig_memops;
+	if (inst->type == VPU_CORE_TYPE_DEC && inst->use_stream_buffer)
+		src_vq->mem_ops = &vb2_vmalloc_memops;
+	src_vq->drv_priv = inst;
+	src_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
+	src_vq->allow_zero_bytesused = 1;
+	src_vq->min_buffers_needed = 1;
+	src_vq->dev = inst->core->dev;
+	ret = vb2_queue_init(src_vq);
+	if (ret)
+		return ret;
+
+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	dst_vq->ops = &vpu_vb2_ops;
+	dst_vq->mem_ops = &vb2_dma_contig_memops;
+	if (inst->type == VPU_CORE_TYPE_ENC && inst->use_stream_buffer)
+		dst_vq->mem_ops = &vb2_vmalloc_memops;
+	dst_vq->drv_priv = inst;
+	dst_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
+	dst_vq->allow_zero_bytesused = 1;
+	dst_vq->min_buffers_needed = 1;
+	dst_vq->dev = inst->core->dev;
+	ret = vb2_queue_init(dst_vq);
+	if (ret) {
+		vb2_queue_release(src_vq);
+		return ret;
+	}
+
+	return 0;
+}
+
+int vpu_v4l2_ioctl_reqbufs(struct file *file, void *priv,
+		struct v4l2_requestbuffers *rb)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	mutex_lock(&inst->ioctl_sync);
+	ret = v4l2_m2m_ioctl_reqbufs(file, priv, rb);
+	mutex_unlock(&inst->ioctl_sync);
+
+	return ret;
+}
+
+int vpu_v4l2_ioctl_create_bufs(struct file *file, void *priv,
+		struct v4l2_create_buffers *create)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	mutex_lock(&inst->ioctl_sync);
+	ret = v4l2_m2m_ioctl_create_bufs(file, priv, create);
+	mutex_unlock(&inst->ioctl_sync);
+
+	return ret;
+}
+
+int vpu_v4l2_ioctl_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	mutex_lock(&inst->ioctl_sync);
+	ret = v4l2_m2m_ioctl_qbuf(file, priv, buf);
+	mutex_unlock(&inst->ioctl_sync);
+
+	return ret;
+}
+
+int vpu_v4l2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	mutex_lock(&inst->ioctl_sync);
+	ret = v4l2_m2m_ioctl_dqbuf(file, priv, buf);
+	mutex_unlock(&inst->ioctl_sync);
+
+	return ret;
+}
+
+int vpu_v4l2_ioctl_streamon(struct file *file, void *priv,
+		enum v4l2_buf_type type)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	ret = vpu_inst_register(inst);
+	if (ret)
+		return ret;
+
+	mutex_lock(&inst->ioctl_sync);
+	ret = v4l2_m2m_ioctl_streamon(file, priv, type);
+	mutex_unlock(&inst->ioctl_sync);
+
+	return ret;
+}
+
+int vpu_v4l2_ioctl_streamoff(struct file *file, void *priv,
+		enum v4l2_buf_type type)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	mutex_lock(&inst->ioctl_sync);
+	ret = v4l2_m2m_ioctl_streamoff(file, priv, type);
+	mutex_unlock(&inst->ioctl_sync);
+
+	return ret;
+}
+
+static int vpu_v4l2_release(struct vpu_inst *inst)
+{
+	struct vpu_core *core = inst->core;
+
+	inst_dbg(inst, LVL_FLOW, "%s\n", __func__);
+
+	vpu_release_core(core);
+
+	if (inst->workqueue) {
+		cancel_work_sync(&inst->msg_work);
+		destroy_workqueue(inst->workqueue);
+		inst->workqueue = NULL;
+	}
+	if (inst->m2m_ctx) {
+		v4l2_m2m_ctx_release(inst->m2m_ctx);
+		inst->m2m_ctx = NULL;
+	}
+	if (inst->m2m_dev) {
+		v4l2_m2m_release(inst->m2m_dev);
+		inst->m2m_dev = NULL;
+	}
+
+	v4l2_ctrl_handler_free(&inst->ctrl_handler);
+	mutex_destroy(&inst->lock);
+	mutex_destroy(&inst->ioctl_sync);
+	v4l2_fh_del(&inst->fh);
+	v4l2_fh_exit(&inst->fh);
+
+	call_vop(inst, cleanup);
+
+	return 0;
+}
+
+int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
+{
+	struct vpu_dev *vpu = video_drvdata(file);
+	struct video_device *vdev;
+	struct vpu_core *core = NULL;
+	int ret = 0;
+
+	WARN_ON(!file || !inst || !inst->ops);
+
+	if (inst->type == VPU_CORE_TYPE_ENC)
+		vdev = vpu->vdev_enc;
+	else
+		vdev = vpu->vdev_dec;
+
+	mutex_init(&inst->lock);
+	mutex_init(&inst->ioctl_sync);
+	INIT_LIST_HEAD(&inst->cmd_q);
+
+	inst->id = VPU_INST_NULL_ID;
+	inst->release = vpu_v4l2_release;
+	inst->core = vpu_request_core(vpu, inst->type);
+
+	core = inst->core;
+	if (!core) {
+		vpu_err("there is no core for %s\n",
+			vpu_core_type_desc(inst->type));
+		return -EINVAL;
+	}
+
+	inst->min_buffer_cap = 2;
+	inst->min_buffer_out = 2;
+
+	ret = call_vop(inst, ctrl_init);
+	if (ret)
+		goto error;
+
+	inst->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
+	if (IS_ERR(inst->m2m_dev)) {
+		vpu_err("v4l2_m2m_init fail\n");
+		ret = PTR_ERR(inst->m2m_dev);
+		goto error;
+	}
+
+	inst->m2m_ctx = v4l2_m2m_ctx_init(inst->m2m_dev,
+					inst, vpu_m2m_queue_init);
+	if (IS_ERR(inst->m2m_ctx)) {
+		vpu_err("v4l2_m2m_ctx_init fail\n");
+		ret = PTR_ERR(inst->m2m_dev);
+		goto error;
+	}
+
+	v4l2_fh_init(&inst->fh, vdev);
+	v4l2_fh_add(&inst->fh);
+	inst->fh.ctrl_handler = &inst->ctrl_handler;
+	inst->fh.m2m_ctx = inst->m2m_ctx;
+	file->private_data = &inst->fh;
+	inst->state = VPU_CODEC_STATE_DEINIT;
+	inst->workqueue = alloc_workqueue("vpu_inst", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	if (inst->workqueue) {
+		INIT_WORK(&inst->msg_work, vpu_inst_run_work);
+		ret = kfifo_init(&inst->msg_fifo,
+				inst->msg_buffer,
+				roundup_pow_of_two(sizeof(inst->msg_buffer)));
+		if (ret) {
+			destroy_workqueue(inst->workqueue);
+			inst->workqueue = NULL;
+		}
+	}
+	atomic_set(&inst->ref_count, 0);
+	vpu_inst_get(inst);
+	vpu_dbg(LVL_FLOW, "open, tgid = %d, pid = %d\n", inst->tgid, inst->pid);
+
+	return 0;
+error:
+	if (inst->m2m_ctx) {
+		v4l2_m2m_ctx_release(inst->m2m_ctx);
+		inst->m2m_ctx = NULL;
+	}
+	if (inst->m2m_dev) {
+		v4l2_m2m_release(inst->m2m_dev);
+		inst->m2m_dev = NULL;
+	}
+	v4l2_ctrl_handler_free(&inst->ctrl_handler);
+	vpu_release_core(inst->core);
+
+	return ret;
+}
+
+int vpu_v4l2_close(struct file *file)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vb2_queue *src_q;
+	struct vb2_queue *dst_q;
+
+	inst_dbg(inst, LVL_FLOW, "close\n");
+	src_q = v4l2_m2m_get_src_vq(inst->m2m_ctx);
+	dst_q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	mutex_lock(&inst->ioctl_sync);
+	if (vb2_is_streaming(src_q))
+		v4l2_m2m_streamoff(file, inst->m2m_ctx, src_q->type);
+	if (vb2_is_streaming(dst_q))
+		v4l2_m2m_streamoff(file, inst->m2m_ctx, dst_q->type);
+	mutex_unlock(&inst->ioctl_sync);
+
+	call_vop(inst, release);
+	vpu_inst_unregister(inst);
+	vpu_inst_put(inst);
+
+	return 0;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_v4l2.h b/drivers/media/platform/imx/vpu-8q/vpu_v4l2.h
new file mode 100644
index 000000000000..4b187dc24d48
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_v4l2.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_V4L2_H
+#define _IMX_VPU_V4L2_H
+
+int vpu_v4l2_open(struct file *file, struct vpu_inst *inst);
+int vpu_v4l2_close(struct file *file);
+int vpu_v4l2_ioctl_reqbufs(struct file *file, void *priv, struct v4l2_requestbuffers *rb);
+int vpu_v4l2_ioctl_create_bufs(struct file *file, void *priv, struct v4l2_create_buffers *create);
+int vpu_v4l2_ioctl_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf);
+int vpu_v4l2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *buf);
+int vpu_v4l2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type type);
+int vpu_v4l2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type type);
+
+const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f);
+int vpu_process_output_buffer(struct vpu_inst *inst);
+int vpu_process_capture_buffer(struct vpu_inst *inst);
+struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst, u32 type, u32 sequence);
+struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst, u32 type, u32 idx);
+void vpu_v4l2_set_error(struct vpu_inst *inst);
+int vpu_notify_eos(struct vpu_inst *inst);
+int vpu_notify_source_change(struct vpu_inst *inst);
+int vpu_notify_skip(struct vpu_inst *inst);
+int vpu_notify_codec_error(struct vpu_inst *inst);
+void vpu_vb2_buffers_return(struct vpu_inst *inst,
+		unsigned int type, enum vb2_buffer_state state);
+int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
+
+dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no);
+unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no);
+static inline struct vpu_format *vpu_get_format(struct vpu_inst *inst, u32 type)
+{
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return &inst->out_format;
+	else
+		return &inst->cap_format;
+}
+
+static inline char *vpu_type_name(u32 type)
+{
+	return V4L2_TYPE_IS_OUTPUT(type) ? "output" : "capture";
+}
+
+#endif
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_windsor.c b/drivers/media/platform/imx/vpu-8q/vpu_windsor.c
new file mode 100644
index 000000000000..646b6040e798
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_windsor.c
@@ -0,0 +1,1253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define TAG		"WINDSOR"
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include "vpu.h"
+#include "vpu_rpc.h"
+#include "vpu_defs.h"
+#include "vpu_helpers.h"
+#include "vpu_cmds.h"
+#include "vpu_v4l2.h"
+#include "vpu_log.h"
+#include "vpu_imx8q.h"
+#include "vpu_windsor.h"
+
+#define CMD_SIZE				2560
+#define MSG_SIZE				25600
+#define WINDSOR_USER_DATA_WORDS			16
+#define WINDSOR_MAX_SRC_FRAMES			0x6
+#define WINDSOR_MAX_REF_FRAMES			0x3
+#define WINDSOR_BITRATE_UNIT			1024
+#define WINDSOR_H264_EXTENDED_SAR		255
+
+enum {
+	GTB_ENC_CMD_NOOP        = 0x0,
+	GTB_ENC_CMD_STREAM_START,
+	GTB_ENC_CMD_FRAME_ENCODE,
+	GTB_ENC_CMD_FRAME_SKIP,
+	GTB_ENC_CMD_STREAM_STOP,
+	GTB_ENC_CMD_PARAMETER_UPD,
+	GTB_ENC_CMD_TERMINATE,
+	GTB_ENC_CMD_SNAPSHOT,
+	GTB_ENC_CMD_ROLL_SNAPSHOT,
+	GTB_ENC_CMD_LOCK_SCHEDULER,
+	GTB_ENC_CMD_UNLOCK_SCHEDULER,
+	GTB_ENC_CMD_CONFIGURE_CODEC,
+	GTB_ENC_CMD_DEAD_MARK,
+	GTB_ENC_CMD_FIRM_RESET,
+	GTB_ENC_CMD_FW_STATUS,
+	GTB_ENC_CMD_RESERVED
+};
+
+enum {
+	VID_API_EVENT_UNDEFINED = 0x0,
+	VID_API_ENC_EVENT_RESET_DONE = 0x1,
+	VID_API_ENC_EVENT_START_DONE,
+	VID_API_ENC_EVENT_STOP_DONE,
+	VID_API_ENC_EVENT_TERMINATE_DONE,
+	VID_API_ENC_EVENT_FRAME_INPUT_DONE,
+	VID_API_ENC_EVENT_FRAME_DONE,
+	VID_API_ENC_EVENT_FRAME_RELEASE,
+	VID_API_ENC_EVENT_PARA_UPD_DONE,
+	VID_API_ENC_EVENT_MEM_REQUEST,
+	VID_API_ENC_EVENT_FIRMWARE_XCPT,
+	VID_API_ENC_EVENT_RESERVED
+};
+
+enum {
+	MEDIAIP_ENC_PIC_TYPE_B_FRAME = 0,
+	MEDIAIP_ENC_PIC_TYPE_P_FRAME,
+	MEDIAIP_ENC_PIC_TYPE_I_FRAME,
+	MEDIAIP_ENC_PIC_TYPE_IDR_FRAME,
+	MEDIAIP_ENC_PIC_TYPE_BI_FRAME
+};
+
+struct windsor_iface {
+	u32 exec_base_addr;
+	u32 exec_area_size;
+	struct vpu_rpc_buffer_desc cmd_buffer_desc;
+	struct vpu_rpc_buffer_desc msg_buffer_desc;
+	u32 cmd_int_enable[VID_API_NUM_STREAMS];
+	u32 fw_version;
+	u32 mvd_fw_offset;
+	u32 max_streams;
+	u32 ctrl_iface[VID_API_NUM_STREAMS];
+	struct vpu_rpc_system_config system_config;
+	u32 api_version;
+	struct vpu_rpc_buffer_desc log_buffer_desc;
+};
+
+struct windsor_ctrl_iface {
+	u32 enc_yuv_buffer_desc;
+	u32 enc_stream_buffer_desc;
+	u32 enc_expert_mode_param;
+	u32 enc_param;
+	u32 enc_mem_pool;
+	u32 enc_encoding_status;
+	u32 enc_dsa_status;
+};
+
+struct vpu_enc_yuv_desc {
+	u32 frame_id;
+	u32 luma_base;
+	u32 chroma_base;
+	u32 param_idx;
+	u32 key_frame;
+};
+
+struct vpu_enc_calib_params {
+	u32 use_ame;
+
+	u32 cme_mvx_max;
+	u32 cme_mvy_max;
+	u32 ame_prefresh_y0;
+	u32 ame_prefresh_y1;
+	u32 fme_min_sad;
+	u32 cme_min_sad;
+
+	u32 fme_pred_int_weight;
+	u32 fme_pred_hp_weight;
+	u32 fme_pred_qp_weight;
+	u32 fme_cost_weight;
+	u32 fme_act_thold;
+	u32 fme_sad_thold;
+	u32 fme_zero_sad_thold;
+
+	u32 fme_lrg_mvx_lmt;
+	u32 fme_lrg_mvy_lmt;
+	u32 fme_force_mode;
+	u32 fme_force4mvcost;
+	u32 fme_force2mvcost;
+
+	u32 h264_inter_thrd;
+
+	u32 i16x16_mode_cost;
+	u32 i4x4_mode_lambda;
+	u32 i8x8_mode_lambda;
+
+	u32 inter_mod_mult;
+	u32 inter_sel_mult;
+	u32 inter_bid_cost;
+	u32 inter_bwd_cost;
+	u32 inter_4mv_cost;
+	s32 one_mv_i16_cost;
+	s32 one_mv_i4x4_cost;
+	s32 one_mv_i8x8_cost;
+	s32 two_mv_i16_cost;
+	s32 two_mv_i4x4_cost;
+	s32 two_mv_i8x8_cost;
+	s32 four_mv_i16_cost;
+	s32 four_mv_i4x4_cost;
+	s32 four_mv_i8x8_cost;
+
+	u32 intra_pred_enab;
+	u32 intra_chr_pred;
+	u32 intra16_pred;
+	u32 intra4x4_pred;
+	u32 intra8x8_pred;
+
+	u32 cb_base;
+	u32 cb_size;
+	u32 cb_head_room;
+
+	u32 mem_page_width;
+	u32 mem_page_height;
+	u32 mem_total_size;
+	u32 mem_chunk_phys_addr;
+	u32 mem_chunk_virt_addr;
+	u32 mem_chunk_size;
+	u32 mem_y_stride;
+	u32 mem_uv_stride;
+
+	u32 split_wr_enab;
+	u32 split_wr_req_size;
+	u32 split_rd_enab;
+	u32 split_rd_req_size;
+};
+
+struct vpu_enc_config_params {
+	u32 param_change;
+	u32 start_frame;
+	u32 end_frame;
+	u32 userdata_enable;
+	u32 userdata_id[4];
+	u32 userdata_message[WINDSOR_USER_DATA_WORDS];
+	u32 userdata_length;
+	u32 h264_profile_idc;
+	u32 h264_level_idc;
+	u32 h264_au_delimiter;
+	u32 h264_seq_end_code;
+	u32 h264_recovery_points;
+	u32 h264_vui_parameters;
+	u32 h264_aspect_ratio_present;
+	u32 h264_aspect_ratio_sar_width;
+	u32 h264_aspect_ratio_sar_height;
+	u32 h264_overscan_present;
+	u32 h264_video_type_present;
+	u32 h264_video_format;
+	u32 h264_video_full_range;
+	u32 h264_video_colour_descriptor;
+	u32 h264_video_colour_primaries;
+	u32 h264_video_transfer_char;
+	u32 h264_video_matrix_coeff;
+	u32 h264_chroma_loc_info_present;
+	u32 h264_chroma_loc_type_top;
+	u32 h264_chroma_loc_type_bot;
+	u32 h264_timing_info_present;
+	u32 h264_buffering_period_present;
+	u32 h264_low_delay_hrd_flag;
+	u32 aspect_ratio;
+	u32 test_mode;                  // Automated firmware test mode
+	u32 dsa_test_mode;              // Automated test mode for the DSA.
+	u32 fme_test_mode;              // Automated test mode for the fme
+	u32 cbr_row_mode;               //0: FW mode; 1: HW mode
+	u32 windsor_mode;               //0: normal mode; 1: intra only mode; 2: intra+0MV mode
+	u32 encode_mode;                // H264, VC1, MPEG2, DIVX
+	u32 frame_width;                // display width
+	u32 frame_height;               // display height
+	u32 enc_frame_width;            // encoding width, should be 16-pix align
+	u32 enc_frame_height;           // encoding height, should be 16-pix aligned
+	u32 frame_rate_num;
+	u32 frame_rate_den;
+	u32 vi_field_source;
+	u32 vi_frame_width;
+	u32 vi_frame_height;
+	u32 crop_frame_width;
+	u32 crop_frame_height;
+	u32 crop_x_start_posn;
+	u32 crop_y_start_posn;
+	u32 mode422;
+	u32 mode_yuy2;
+	u32 dsa_luma_en;
+	u32 dsa_chroma_en;
+	u32 dsa_ext_hfilt_en;
+	u32 dsa_di_en;
+	u32 dsa_di_top_ref;
+	u32 dsa_vertf_disable;
+	u32 dsa_disable_pwb;
+	u32 dsa_hor_phase;
+	u32 dsa_ver_phase;
+	u32 dsa_iac_enable;
+	u32 iac_sc_threshold;
+	u32 iac_vm_threshold;
+	u32 iac_skip_mode;
+	u32 iac_grp_width;
+	u32 iac_grp_height;
+	u32 rate_control_mode;
+	u32 rate_control_resolution;
+	u32 buffer_size;
+	u32 buffer_level_init;
+	u32 buffer_I_bit_budget;
+	u32 top_field_first;
+	u32 intra_lum_qoffset;
+	u32 intra_chr_qoffset;
+	u32 inter_lum_qoffset;
+	u32 inter_chr_qoffset;
+	u32 use_def_scaling_mtx;
+	u32 inter_8x8_enab;
+	u32 inter_4x4_enab;
+	u32 fme_enable_qpel;
+	u32 fme_enable_hpel;
+	u32 fme_nozeromv;
+	u32 fme_predmv_en;
+	u32 fme_pred_2mv4mv;
+	u32 fme_smallsadthresh;
+	u32 ame_en_lmvc;
+	u32 ame_x_mult;
+	u32 cme_enable_4mv;
+	u32 cme_enable_1mv;
+	u32 hme_enable_16x8mv;
+	u32 hme_enable_8x16mv;
+	u32 cme_mv_weight;
+	u32 cme_mv_cost;
+	u32 ame_mult_mv;
+	u32 ame_shift_mv;
+	u32 hme_forceto1mv_en;
+	u32 hme_2mv_cost;
+	u32 hme_pred_mode;
+	u32 hme_sc_rnge;
+	u32 hme_sw_rnge;
+	u32 output_format;
+	u32 timestamp_enab;
+	u32 initial_pts_enab;
+	u32 initial_pts;
+};
+
+struct vpu_enc_static_params {
+	u32 param_change;
+	u32 gop_length;
+	u32 rate_control_bitrate;
+	u32 rate_control_bitrate_min;
+	u32 rate_control_bitrate_max;
+	u32 rate_control_content_models;
+	u32 rate_control_iframe_maxsize;
+	u32 rate_control_qp_init;
+	u32 rate_control_islice_qp;
+	u32 rate_control_pslice_qp;
+	u32 rate_control_bslice_qp;
+	u32 adaptive_quantization;
+	u32 aq_variance;
+	u32 cost_optimization;
+	u32 fdlp_mode;
+	u32 enable_isegbframes;
+	u32 enable_adaptive_keyratio;
+	u32 keyratio_imin;
+	u32 keyratio_imax;
+	u32 keyratio_pmin;
+	u32 keyratio_pmax;
+	u32 keyratio_bmin;
+	u32 keyratio_bmax;
+	s32 keyratio_istep;
+	s32 keyratio_pstep;
+	s32 keyratio_bstep;
+	u32 enable_paff;
+	u32 enable_b_frame_ref;
+	u32 enable_adaptive_gop;
+	u32 enable_closed_gop;
+	u32 open_gop_refresh_freq;
+	u32 enable_adaptive_sc;
+	u32 enable_fade_detection;
+	s32 fade_detection_threshold;
+	u32 enable_repeat_b;
+	u32 enable_low_delay_b;
+};
+
+struct vpu_enc_dynamic_params {
+	u32 param_change;
+	u32 rows_per_slice;
+	u32 mbaff_enable;
+	u32 dbf_enable;
+	u32 field_source;
+	u32 gop_b_length;
+	u32 mb_group_size;
+	u32 cbr_rows_per_group;
+	u32 skip_enable;
+	u32 pts_bits_0_to_31;
+	u32 pts_bit_32;
+	u32 rm_expsv_cff;
+	u32 const_ipred;
+	s32 chr_qp_offset;
+	u32 intra_mb_qp_offset;
+	u32 h264_cabac_init_method;
+	u32 h264_cabac_init_idc;
+	u32 h264_cabac_enable;
+	s32 alpha_c0_offset_div2;
+	s32 beta_offset_div2;
+	u32 intra_prefresh_y0;
+	u32 intra_prefresh_y1;
+	u32 dbg_dump_rec_src;
+};
+
+struct vpu_enc_expert_mode_param {
+	struct vpu_enc_calib_params calib_param;
+	struct vpu_enc_config_params config_param;
+	struct vpu_enc_static_params static_param;
+	struct vpu_enc_dynamic_params dynamic_param;
+};
+
+enum MEDIAIP_ENC_FMT {
+	MEDIAIP_ENC_FMT_H264 = 0,
+	MEDIAIP_ENC_FMT_VC1,
+	MEDIAIP_ENC_FMT_MPEG2,
+	MEDIAIP_ENC_FMT_MPEG4SP,
+	MEDIAIP_ENC_FMT_H263,
+	MEDIAIP_ENC_FMT_MPEG1,
+	MEDIAIP_ENC_FMT_SHORT_HEADER,
+	MEDIAIP_ENC_FMT_NULL
+};
+
+enum MEDIAIP_ENC_PROFILE {
+	MEDIAIP_ENC_PROF_MPEG2_SP = 0,
+	MEDIAIP_ENC_PROF_MPEG2_MP,
+	MEDIAIP_ENC_PROF_MPEG2_HP,
+	MEDIAIP_ENC_PROF_H264_BP,
+	MEDIAIP_ENC_PROF_H264_MP,
+	MEDIAIP_ENC_PROF_H264_HP,
+	MEDIAIP_ENC_PROF_MPEG4_SP,
+	MEDIAIP_ENC_PROF_MPEG4_ASP,
+	MEDIAIP_ENC_PROF_VC1_SP,
+	MEDIAIP_ENC_PROF_VC1_MP,
+	MEDIAIP_ENC_PROF_VC1_AP
+};
+
+enum MEDIAIP_ENC_BITRATE_MODE {
+	MEDIAIP_ENC_BITRATE_MODE_VBR          = 0x00000001,
+	MEDIAIP_ENC_BITRATE_MODE_CBR          = 0x00000002,
+	MEDIAIP_ENC_BITRATE_MODE_CONSTANT_QP  = 0x00000004
+};
+
+struct vpu_enc_memory_resource {
+	u32 phys;
+	u32 virt;
+	u32 size;
+};
+
+struct vpu_enc_param {
+	enum MEDIAIP_ENC_FMT codec_mode;
+	enum MEDIAIP_ENC_PROFILE profile;
+	u32 level;
+
+	struct vpu_enc_memory_resource enc_mem_desc;
+
+	u32 frame_rate;
+	u32 src_stride;
+	u32 src_width;
+	u32 src_height;
+	u32 src_offset_x;
+	u32 src_offset_y;
+	u32 src_crop_width;
+	u32 src_crop_height;
+	u32 out_width;
+	u32 out_height;
+	u32 iframe_interval;
+	u32 bframes;
+	u32 low_latency_mode;
+
+	enum MEDIAIP_ENC_BITRATE_MODE  bitrate_mode;
+	u32 target_bitrate;
+	u32 max_bitrate;
+	u32 min_bitrate;
+	u32 init_slice_qp;
+};
+
+struct vpu_enc_mem_pool {
+	struct vpu_enc_memory_resource enc_frames[WINDSOR_MAX_SRC_FRAMES];
+	struct vpu_enc_memory_resource ref_frames[WINDSOR_MAX_REF_FRAMES];
+	struct vpu_enc_memory_resource act_frame;
+};
+
+struct vpu_enc_encoding_status {
+	u32   frame_id;
+	u32   error_flag;   //Error type
+	u32   mb_y;
+	u32   mb_x;
+	u32   reserved[12];
+
+};
+
+struct vpu_enc_dsa_status {
+	u32   frame_id;
+	u32   dsa_cyle;
+	u32   mb_y;
+	u32   mb_x;
+	u32   reserved[4];
+};
+
+struct vpu_enc_ctrl {
+	struct vpu_enc_yuv_desc *yuv_desc;
+	struct vpu_rpc_buffer_desc *stream_desc;
+	struct vpu_enc_expert_mode_param *expert;
+	struct vpu_enc_param *param;
+	struct vpu_enc_mem_pool *pool;
+	struct vpu_enc_encoding_status *status;
+	struct vpu_enc_dsa_status *dsa;
+};
+
+struct vpu_enc_host_ctrls {
+	struct vpu_enc_ctrl ctrls[VID_API_NUM_STREAMS];
+};
+
+struct windsor_pic_info {
+	u32 frame_id;
+	u32 pic_encod_done;
+	u32 pic_type;
+	u32 skipped_frame;
+	u32 error_flag;
+	u32 psnr;
+	u32 flush_done;
+	u32 mb_y;
+	u32 mb_x;
+	u32 frame_size;
+	u32 frame_enc_ttl_cycles;
+	u32 frame_enc_ttl_frm_cycles;
+	u32 frame_enc_ttl_slc_cycles;
+	u32 frame_enc_ttl_enc_cycles;
+	u32 frame_enc_ttl_hme_cycles;
+	u32 frame_enc_ttl_dsa_cycles;
+	u32 frame_enc_fw_cycles;
+	u32 frame_crc;
+	u32 num_interrupts_1;
+	u32 num_interrupts_2;
+	u32 poc;
+	u32 ref_info;
+	u32 pic_num;
+	u32 pic_activity;
+	u32 scene_change;
+	u32 mb_stats;
+	u32 enc_cache_count0;
+	u32 enc_cache_count1;
+	u32 mtl_wr_strb_cnt;
+	u32 mtl_rd_strb_cnt;
+	u32 str_buff_wptr;
+	u32 diagnosticEvents;
+	u32 proc_iacc_tot_rd_cnt;
+	u32 proc_dacc_tot_rd_cnt;
+	u32 proc_dacc_tot_wr_cnt;
+	u32 proc_dacc_reg_rd_cnt;
+	u32 proc_dacc_reg_wr_cnt;
+	u32 proc_dacc_rng_rd_cnt;
+	u32 proc_dacc_rng_wr_cnt;
+	s32 tv_s;
+	u32 tv_ns;
+};
+
+u32 vpu_windsor_get_data_size(void)
+{
+	return sizeof(struct vpu_enc_host_ctrls);
+}
+
+static struct vpu_enc_yuv_desc *get_yuv_desc(struct vpu_shared_addr *shared,
+						u32 instance)
+{
+	struct vpu_enc_host_ctrls *hcs = shared->priv;
+
+	return hcs->ctrls[instance].yuv_desc;
+}
+
+static struct vpu_enc_mem_pool *get_mem_pool(struct vpu_shared_addr *shared,
+						u32 instance)
+{
+	struct vpu_enc_host_ctrls *hcs = shared->priv;
+
+	return hcs->ctrls[instance].pool;
+}
+
+static struct vpu_rpc_buffer_desc *get_stream_buf_desc(struct vpu_shared_addr *shared,
+							u32 instance)
+{
+	struct vpu_enc_host_ctrls *hcs = shared->priv;
+
+	return hcs->ctrls[instance].stream_desc;
+}
+
+static struct vpu_enc_expert_mode_param *get_expert_param(struct vpu_shared_addr *shared,
+							u32 instance)
+{
+	struct vpu_enc_host_ctrls *hcs = shared->priv;
+
+	return hcs->ctrls[instance].expert;
+}
+
+static struct vpu_enc_param *get_enc_param(struct vpu_shared_addr *shared,
+						u32 instance)
+{
+	struct vpu_enc_host_ctrls *hcs = shared->priv;
+
+	return hcs->ctrls[instance].param;
+}
+
+static u32 get_ptr(u32 ptr)
+{
+	return (ptr | 0x80000000);
+}
+
+void vpu_windsor_init_rpc(struct vpu_shared_addr *shared,
+			struct vpu_buffer *rpc, dma_addr_t boot_addr)
+{
+	unsigned long base_phy_addr;
+	unsigned long phy_addr;
+	unsigned long offset;
+	struct windsor_iface *iface;
+	struct windsor_ctrl_iface *ctrl;
+	struct vpu_enc_host_ctrls *hcs;
+	unsigned int i;
+
+	WARN_ON(!shared || !shared->priv);
+	WARN_ON(!rpc || !rpc->phys || !rpc->length || rpc->phys < boot_addr);
+
+	base_phy_addr = rpc->phys - boot_addr;
+	iface = rpc->virt;
+	shared->iface = iface;
+	shared->boot_addr = boot_addr;
+	hcs = shared->priv;
+
+	iface->exec_base_addr = base_phy_addr;
+	iface->exec_area_size = rpc->length;
+
+	offset = sizeof(struct windsor_iface);
+	phy_addr = base_phy_addr + offset;
+	shared->cmd_desc = &iface->cmd_buffer_desc;
+	shared->cmd_mem_vir = rpc->virt + offset;
+	iface->cmd_buffer_desc.start =
+	iface->cmd_buffer_desc.rptr =
+	iface->cmd_buffer_desc.wptr = phy_addr;
+	iface->cmd_buffer_desc.end = iface->cmd_buffer_desc.start + CMD_SIZE;
+
+	offset += CMD_SIZE;
+	phy_addr = base_phy_addr + offset;
+	shared->msg_desc = &iface->msg_buffer_desc;
+	shared->msg_mem_vir = rpc->virt + offset;
+	iface->msg_buffer_desc.start =
+	iface->msg_buffer_desc.wptr =
+	iface->msg_buffer_desc.rptr = phy_addr;
+	iface->msg_buffer_desc.end = iface->msg_buffer_desc.start + MSG_SIZE;
+
+	offset += MSG_SIZE;
+	for (i = 0; i < ARRAY_SIZE(iface->ctrl_iface); i++) {
+		iface->ctrl_iface[i] = base_phy_addr + offset;
+		offset += sizeof(struct windsor_ctrl_iface);
+	}
+	for (i = 0; i < ARRAY_SIZE(iface->ctrl_iface); i++) {
+		ctrl = rpc->virt + (iface->ctrl_iface[i] - base_phy_addr);
+
+		ctrl->enc_yuv_buffer_desc = base_phy_addr + offset;
+		hcs->ctrls[i].yuv_desc = rpc->virt + offset;
+		offset += sizeof(struct vpu_enc_yuv_desc);
+
+		ctrl->enc_stream_buffer_desc = base_phy_addr + offset;
+		hcs->ctrls[i].stream_desc = rpc->virt + offset;
+		offset += sizeof(struct vpu_rpc_buffer_desc);
+
+		ctrl->enc_expert_mode_param = base_phy_addr + offset;
+		hcs->ctrls[i].expert = rpc->virt + offset;
+		offset += sizeof(struct vpu_enc_expert_mode_param);
+
+		ctrl->enc_param = base_phy_addr + offset;
+		hcs->ctrls[i].param = rpc->virt + offset;
+		offset += sizeof(struct vpu_enc_param);
+
+		ctrl->enc_mem_pool = base_phy_addr + offset;
+		hcs->ctrls[i].pool = rpc->virt + offset;
+		offset += sizeof(struct vpu_enc_mem_pool);
+
+		ctrl->enc_encoding_status = base_phy_addr + offset;
+		hcs->ctrls[i].status = rpc->virt + offset;
+		offset += sizeof(struct vpu_enc_encoding_status);
+
+		ctrl->enc_dsa_status = base_phy_addr + offset;
+		hcs->ctrls[i].dsa = rpc->virt + offset;
+		offset += sizeof(struct vpu_enc_dsa_status);
+	}
+
+	rpc->bytesused = offset;
+}
+
+void vpu_windsor_set_log_buf(struct vpu_shared_addr *shared,
+			struct vpu_buffer *log)
+{
+	struct windsor_iface *iface;
+
+	WARN_ON(!shared || !log || !log->phys);
+
+	vpu_dbg(LVL_DEBUG, "set log area <0x%llx, 0x%x> (0x%lx)\n",
+			log->phys, log->length, shared->boot_addr);
+	iface = shared->iface;
+	iface->log_buffer_desc.start =
+	iface->log_buffer_desc.wptr =
+	iface->log_buffer_desc.rptr = log->phys - shared->boot_addr;
+	iface->log_buffer_desc.end = iface->log_buffer_desc.start + log->length;
+}
+
+void vpu_windsor_set_system_cfg(struct vpu_shared_addr *shared,
+				u32 regs_base, void __iomem *regs, u32 core_id)
+{
+	struct windsor_iface *iface;
+	struct vpu_rpc_system_config *config;
+
+	WARN_ON(!shared || !shared->iface);
+
+	iface = shared->iface;
+	config = &iface->system_config;
+
+	vpu_imx8q_set_system_cfg_common(config, regs_base, core_id);
+}
+
+int vpu_windsor_get_stream_buffer_size(struct vpu_shared_addr *shared)
+{
+	return 0x300000;
+}
+
+static struct vpu_pair windsor_cmds[] = {
+	{VPU_CMD_ID_CONFIGURE_CODEC, GTB_ENC_CMD_CONFIGURE_CODEC},
+	{VPU_CMD_ID_START, GTB_ENC_CMD_STREAM_START},
+	{VPU_CMD_ID_STOP, GTB_ENC_CMD_STREAM_STOP},
+	{VPU_CMD_ID_FRAME_ENCODE, GTB_ENC_CMD_FRAME_ENCODE},
+	{VPU_CMD_ID_SNAPSHOT, GTB_ENC_CMD_SNAPSHOT},
+	{VPU_CMD_ID_FIRM_RESET, GTB_ENC_CMD_FIRM_RESET},
+	{VPU_CMD_ID_UPDATE_PARAMETER, GTB_ENC_CMD_PARAMETER_UPD},
+	{VPU_CMD_ID_DEBUG, GTB_ENC_CMD_FW_STATUS}
+};
+
+static struct vpu_pair windsor_msgs[] = {
+	{VPU_MSG_ID_RESET_DONE, VID_API_ENC_EVENT_RESET_DONE},
+	{VPU_MSG_ID_START_DONE, VID_API_ENC_EVENT_START_DONE},
+	{VPU_MSG_ID_STOP_DONE, VID_API_ENC_EVENT_STOP_DONE},
+	{VPU_MSG_ID_FRAME_INPUT_DONE, VID_API_ENC_EVENT_FRAME_INPUT_DONE},
+	{VPU_MSG_ID_ENC_DONE, VID_API_ENC_EVENT_FRAME_DONE},
+	{VPU_MSG_ID_FRAME_RELEASE, VID_API_ENC_EVENT_FRAME_RELEASE},
+	{VPU_MSG_ID_MEM_REQUEST, VID_API_ENC_EVENT_MEM_REQUEST},
+	{VPU_MSG_ID_PARAM_UPD_DONE, VID_API_ENC_EVENT_PARA_UPD_DONE},
+	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_ENC_EVENT_FIRMWARE_XCPT},
+};
+
+int vpu_windsor_pack_cmd(struct vpu_rpc_event *pkt, u32 index, u32 id, void *data)
+{
+	int ret;
+	s64 timestamp;
+
+	WARN_ON(!pkt);
+
+	ret = vpu_find_dst_by_src(windsor_cmds, ARRAY_SIZE(windsor_cmds), id);
+	if (ret < 0)
+		return ret;
+	pkt->hdr.id = ret;
+	pkt->hdr.num = 0;
+	pkt->hdr.index = index;
+	if (id == VPU_CMD_ID_FRAME_ENCODE) {
+		pkt->hdr.num = 2;
+		timestamp = *(s64 *)data;
+		if (timestamp < 0) {
+			pkt->data[0] = (u32)-1;
+			pkt->data[1] = 0;
+		} else {
+			pkt->data[0] = timestamp / NSEC_PER_SEC;
+			pkt->data[1] = timestamp % NSEC_PER_SEC;
+		}
+	}
+
+	return 0;
+}
+
+int vpu_windsor_convert_msg_id(u32 id)
+{
+	return vpu_find_src_by_dst(windsor_msgs, ARRAY_SIZE(windsor_msgs), id);
+}
+
+static void vpu_windsor_unpack_pic_info(struct vpu_rpc_event *pkt, void *data)
+{
+	struct vpu_enc_pic_info *info = data;
+	struct windsor_pic_info *windsor = (struct windsor_pic_info *)pkt->data;
+
+	info->frame_id = windsor->frame_id;
+	switch (windsor->pic_type) {
+	case MEDIAIP_ENC_PIC_TYPE_I_FRAME:
+	case MEDIAIP_ENC_PIC_TYPE_IDR_FRAME:
+		info->pic_type = V4L2_BUF_FLAG_KEYFRAME;
+		break;
+	case MEDIAIP_ENC_PIC_TYPE_P_FRAME:
+		info->pic_type = V4L2_BUF_FLAG_PFRAME;
+		break;
+	case MEDIAIP_ENC_PIC_TYPE_B_FRAME:
+		info->pic_type = V4L2_BUF_FLAG_BFRAME;
+		break;
+	default:
+		break;
+	}
+	info->skipped_frame = windsor->skipped_frame;
+	info->error_flag = windsor->error_flag;
+	info->psnr = windsor->psnr;
+	info->frame_size = windsor->frame_size;
+	info->wptr = get_ptr(windsor->str_buff_wptr);
+	info->crc = windsor->frame_crc;
+	info->timestamp = MAKE_TIMESTAMP(windsor->tv_s, windsor->tv_ns);
+}
+
+static void vpu_windsor_unpack_mem_req(struct vpu_rpc_event *pkt, void *data)
+{
+	struct vpu_pkt_mem_req_data *req_data = data;
+
+	req_data->enc_frame_size = pkt->data[0];
+	req_data->enc_frame_num = pkt->data[1];
+	req_data->ref_frame_size = pkt->data[2];
+	req_data->ref_frame_num = pkt->data[3];
+	req_data->act_buf_size = pkt->data[4];
+	req_data->act_buf_num = 1;
+}
+
+int vpu_windsor_unpack_msg_data(struct vpu_rpc_event *pkt, void *data)
+{
+	if (!pkt || !data)
+		return -EINVAL;
+
+	switch (pkt->hdr.id) {
+	case VID_API_ENC_EVENT_FRAME_DONE:
+		vpu_windsor_unpack_pic_info(pkt, data);
+		break;
+	case VID_API_ENC_EVENT_MEM_REQUEST:
+		vpu_windsor_unpack_mem_req(pkt, data);
+		break;
+	case VID_API_ENC_EVENT_FRAME_RELEASE:
+		*(u32 *)data = pkt->data[0];
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
+				u32 instance,
+				struct vb2_buffer *vb)
+{
+	struct vpu_enc_yuv_desc *desc;
+	struct vb2_v4l2_buffer *vbuf;
+
+	WARN_ON(!shared || !vb || instance >= VID_API_NUM_STREAMS);
+
+	desc = get_yuv_desc(shared, instance);
+
+	vbuf = to_vb2_v4l2_buffer(vb);
+	vpu_dbg(LVL_DEBUG, "fill yuv with id : %d\n", vbuf->sequence);
+	desc->frame_id = vbuf->sequence;
+	if (vbuf->flags & V4L2_BUF_FLAG_KEYFRAME)
+		desc->key_frame = 1;
+	else
+		desc->key_frame = 0;
+	desc->luma_base = vpu_get_vb_phy_addr(vb, 0);
+	desc->chroma_base = vpu_get_vb_phy_addr(vb, 1);
+
+	return 0;
+}
+
+int vpu_windsor_input_frame(struct vpu_shared_addr *shared,
+			struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	vpu_windsor_fill_yuv_frame(shared, inst->id, vb);
+	return vpu_session_encode_frame(inst, vb->timestamp);
+}
+
+int vpu_windsor_config_memory_resource(struct vpu_shared_addr *shared,
+					u32 instance,
+					u32 type,
+					u32 index,
+					struct vpu_buffer *buf)
+{
+	struct vpu_enc_mem_pool *pool;
+	struct vpu_enc_memory_resource *res;
+
+	WARN_ON(!shared || !buf || instance >= VID_API_NUM_STREAMS);
+
+	pool = get_mem_pool(shared, instance);
+
+	switch (type) {
+	case MEM_RES_ENC:
+		res = &pool->enc_frames[index];
+		break;
+	case MEM_RES_REF:
+		res = &pool->ref_frames[index];
+		break;
+	case MEM_RES_ACT:
+		res = &pool->act_frame;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	res->phys = buf->phys;
+	res->virt = buf->phys - shared->boot_addr;
+	res->size = buf->length;
+
+	vpu_dbg(LVL_DEBUG, "[%d] type = %d, phys = 0x%x, size = 0x%x\n",
+			instance, type, res->phys, res->size);
+
+	return 0;
+}
+
+int vpu_windsor_config_stream_buffer(struct vpu_shared_addr *shared,
+					u32 instance,
+					struct vpu_buffer *buf)
+{
+	struct vpu_rpc_buffer_desc *desc;
+	struct vpu_enc_expert_mode_param *expert;
+
+	desc = get_stream_buf_desc(shared, instance);
+	expert = get_expert_param(shared, instance);
+
+	desc->start = desc->wptr = desc->rptr = buf->phys;
+	desc->end = buf->phys + buf->length;
+
+	vpu_dbg(LVL_DEBUG, "stream_buf:[0x%x, 0x%x]\n", desc->start, desc->end);
+
+	expert->calib_param.mem_chunk_phys_addr = 0;
+	expert->calib_param.mem_chunk_virt_addr = 0;
+	expert->calib_param.mem_chunk_size = 0;
+	expert->calib_param.cb_base = buf->phys;
+	expert->calib_param.cb_size = buf->length;
+
+	return 0;
+}
+
+static void vpu_windsor_update_wptr(struct vpu_rpc_buffer_desc *desc, u32 wptr)
+{
+	u32 pre_wptr = get_ptr(desc->wptr);
+	u32 new_wptr = get_ptr(wptr);
+	u32 rptr = get_ptr(desc->rptr);
+	u32 size = get_ptr(desc->end) - get_ptr(desc->start);
+	u32 space = (rptr + size - pre_wptr) % size;
+	u32 step = (new_wptr + size - pre_wptr) % size;
+
+	if (space && step > space)
+		vpu_err("update wptr from 0x%x to 0x%x, cross over rptr 0x%x\n",
+				pre_wptr, new_wptr, rptr);
+
+	desc->wptr = wptr;
+}
+
+static void vpu_windsor_update_rptr(struct vpu_rpc_buffer_desc *desc, u32 rptr)
+{
+	u32 pre_rptr = get_ptr(desc->rptr);
+	u32 new_rptr = get_ptr(rptr);
+	u32 wptr = get_ptr(desc->wptr);
+	u32 size = get_ptr(desc->end) - get_ptr(desc->start);
+	u32 space = (wptr + size - pre_rptr) % size;
+	u32 step = (new_rptr + size - pre_rptr) % size;
+
+	if (step > space)
+		vpu_err("update rptr from 0x%x to 0x%x, cross over wptr 0x%x\n",
+				pre_rptr, new_rptr, wptr);
+
+	desc->rptr = rptr;
+}
+
+int vpu_windsor_update_stream_buffer(struct vpu_shared_addr *shared,
+					u32 instance, u32 ptr, bool write)
+{
+	struct vpu_rpc_buffer_desc *desc;
+
+	desc = get_stream_buf_desc(shared, instance);
+
+	/*update wptr/rptr after data is written or read*/
+	mb();
+	if (write)
+		vpu_windsor_update_wptr(desc, ptr);
+	else
+		vpu_windsor_update_rptr(desc, ptr);
+
+	return 0;
+}
+
+int vpu_windsor_get_stream_buffer_desc(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_rpc_buffer_desc *desc)
+{
+	struct vpu_rpc_buffer_desc *rpc_desc;
+
+	rpc_desc = get_stream_buf_desc(shared, instance);
+	if (desc) {
+		desc->wptr = get_ptr(rpc_desc->wptr);
+		desc->rptr = get_ptr(rpc_desc->rptr);
+		desc->start = get_ptr(rpc_desc->start);
+		desc->end = get_ptr(rpc_desc->end);
+	}
+
+	return 0;
+}
+
+u32 vpu_windsor_get_version(struct vpu_shared_addr *shared)
+{
+	struct windsor_iface *iface;
+
+	WARN_ON(!shared || !shared->iface);
+
+	iface = shared->iface;
+	return iface->fw_version;
+}
+
+static int vpu_windsor_set_frame_rate(struct vpu_enc_expert_mode_param *expert,
+				struct vpu_encode_params *params)
+{
+	expert->config_param.frame_rate_num = params->frame_rate_num;
+	expert->config_param.frame_rate_den = params->frame_rate_den;
+
+	return 0;
+}
+
+static int vpu_windsor_set_format(struct vpu_enc_param *param, u32 pixelformat)
+{
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_H264:
+		param->codec_mode = MEDIAIP_ENC_FMT_H264;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vpu_windsor_set_profile(struct vpu_enc_param *param, u32 profile)
+{
+	switch (profile) {
+	case V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE:
+		param->profile = MEDIAIP_ENC_PROF_H264_BP;
+		break;
+	case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
+		param->profile = MEDIAIP_ENC_PROF_H264_MP;
+		break;
+	case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH:
+		param->profile = MEDIAIP_ENC_PROF_H264_HP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const u32 h264_level[] = {
+	[V4L2_MPEG_VIDEO_H264_LEVEL_1_0] = 10,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_1B]  = 14,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_1_1] = 11,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_1_2] = 12,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_1_3] = 13,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_2_0] = 20,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_2_1] = 21,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_2_2] = 22,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_3_0] = 30,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_3_1] = 31,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_3_2] = 32,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_4_0] = 40,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_4_1] = 41,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_4_2] = 42,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_5_0] = 50,
+	[V4L2_MPEG_VIDEO_H264_LEVEL_5_1] = 51
+};
+
+static int vpu_windsor_set_level(struct vpu_enc_param *param, u32 level)
+{
+
+	if (level >= ARRAY_SIZE(h264_level))
+		return -EINVAL;
+
+	param->level = h264_level[level];
+
+	return 0;
+}
+
+static int vpu_windsor_set_size(struct vpu_enc_param *windsor,
+				struct vpu_encode_params *params)
+{
+	windsor->src_stride = params->src_stride;
+	windsor->src_width = params->src_width;
+	windsor->src_height = params->src_height;
+	windsor->src_offset_x = params->crop.left;
+	windsor->src_offset_y = params->crop.top;
+	windsor->src_crop_width = params->crop.width;
+	windsor->src_crop_height = params->crop.height;
+	windsor->out_width = params->out_width;
+	windsor->out_height = params->out_height;
+
+	vpu_dbg(LVL_DEBUG, "%d %dx%d (%d,%d) %dx%d, %dx%d\n",
+			windsor->src_stride,
+			windsor->src_width,
+			windsor->src_height,
+			windsor->src_offset_x,
+			windsor->src_offset_y,
+			windsor->src_crop_width,
+			windsor->src_crop_height,
+			windsor->out_width,
+			windsor->out_height);
+	return 0;
+}
+
+static int vpu_windsor_set_gop(struct vpu_enc_param *param, u32 gop)
+{
+	param->iframe_interval = gop;
+
+	return 0;
+}
+
+static int vpu_windsor_set_bframes(struct vpu_enc_param *param, u32 bframes)
+{
+	if (bframes) {
+		param->low_latency_mode = 0;
+		param->bframes = bframes;
+	} else {
+		param->low_latency_mode = 1;
+		param->bframes = 0;
+	}
+
+	if (param->low_latency_mode)
+		vpu_dbg(LVL_DEBUG, "low latency mode\n");
+
+	return 0;
+}
+
+static int vpu_windsor_set_bitrate_mode(struct vpu_enc_param *param, u32 mode)
+{
+	switch (mode) {
+	case V4L2_MPEG_VIDEO_BITRATE_MODE_VBR:
+		param->bitrate_mode = MEDIAIP_ENC_BITRATE_MODE_CONSTANT_QP;
+		break;
+	case V4L2_MPEG_VIDEO_BITRATE_MODE_CBR:
+		param->bitrate_mode = MEDIAIP_ENC_BITRATE_MODE_CBR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u32 vpu_windsor_bitrate(u32 bitrate)
+{
+	return DIV_ROUND_CLOSEST(bitrate, WINDSOR_BITRATE_UNIT);
+}
+
+static int vpu_windsor_set_bitrate(struct vpu_enc_param *windsor,
+				struct vpu_encode_params *params)
+{
+	windsor->target_bitrate = vpu_windsor_bitrate(params->bitrate);
+	windsor->min_bitrate = vpu_windsor_bitrate(params->bitrate_min);
+	windsor->max_bitrate = vpu_windsor_bitrate(params->bitrate_max);
+
+	return 0;
+}
+
+static int vpu_windsor_set_qp(struct vpu_enc_expert_mode_param *expert,
+			struct vpu_encode_params *params)
+{
+	expert->static_param.rate_control_islice_qp = params->i_frame_qp;
+	expert->static_param.rate_control_pslice_qp = params->p_frame_qp;
+	expert->static_param.rate_control_bslice_qp = params->b_frame_qp;
+
+	return 0;
+}
+
+static int vpu_windsor_set_sar(struct vpu_enc_expert_mode_param *expert,
+			struct vpu_encode_params *params)
+{
+	expert->config_param.h264_aspect_ratio_present = params->sar.enable;
+	if (params->sar.idc == V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED)
+		expert->config_param.aspect_ratio = WINDSOR_H264_EXTENDED_SAR;
+	else
+		expert->config_param.aspect_ratio = params->sar.idc;
+	expert->config_param.h264_aspect_ratio_sar_width = params->sar.width;
+	expert->config_param.h264_aspect_ratio_sar_height = params->sar.height;
+
+
+	return 0;
+}
+
+static int vpu_windsor_set_color(struct vpu_enc_expert_mode_param *expert,
+			struct vpu_encode_params *params)
+{
+	expert->config_param.h264_video_type_present = 1;
+	expert->config_param.h264_video_format = 5;
+	expert->config_param.h264_video_colour_descriptor = 1;
+	expert->config_param.h264_video_colour_primaries =
+		vpu_color_cvrt_primaries_v2i(params->color.primaries);
+	expert->config_param.h264_video_transfer_char =
+		vpu_color_cvrt_transfers_v2i(params->color.transfer);
+	expert->config_param.h264_video_matrix_coeff =
+		vpu_color_cvrt_matrix_v2i(params->color.matrix);
+	expert->config_param.h264_video_full_range =
+		vpu_color_cvrt_full_range_v2i(params->color.full_range);
+	return 0;
+}
+
+static int vpu_windsor_update_bitrate(struct vpu_shared_addr *shared,
+				u32 instance, struct vpu_encode_params *params)
+{
+	struct vpu_enc_param *windsor;
+	struct vpu_enc_expert_mode_param *expert;
+
+	windsor = get_enc_param(shared, instance);
+	expert = get_expert_param(shared, instance);
+
+	if (windsor->bitrate_mode != MEDIAIP_ENC_BITRATE_MODE_CBR)
+		return 0;
+	if (params->rc_mode != V4L2_MPEG_VIDEO_BITRATE_MODE_CBR)
+		return 0;
+	if (vpu_windsor_bitrate(params->bitrate) == windsor->target_bitrate)
+		return 0;
+
+	vpu_windsor_set_bitrate(windsor, params);
+	expert->static_param.rate_control_bitrate = windsor->target_bitrate;
+	expert->static_param.rate_control_bitrate_min = windsor->min_bitrate;
+	expert->static_param.rate_control_bitrate_max = windsor->max_bitrate;
+
+	return 0;
+}
+
+static int vpu_windsor_set_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_encode_params *params)
+{
+	struct vpu_enc_param *windsor;
+	int ret;
+
+	windsor = get_enc_param(shared, instance);
+
+	if (params->input_format != V4L2_PIX_FMT_NV12)
+		return -EINVAL;
+
+	ret = vpu_windsor_set_format(windsor, params->codec_format);
+	if (ret)
+		return ret;
+	vpu_windsor_set_profile(windsor, params->profile);
+	vpu_windsor_set_level(windsor, params->level);
+	vpu_windsor_set_size(windsor, params);
+	vpu_windsor_set_gop(windsor, params->gop_length);
+	vpu_windsor_set_bframes(windsor, params->bframes);
+	vpu_windsor_set_bitrate_mode(windsor, params->rc_mode);
+	vpu_windsor_set_bitrate(windsor, params);
+	windsor->init_slice_qp = params->i_frame_qp;
+
+	if (!params->frame_rate_num)
+		return -EINVAL;
+	windsor->frame_rate = params->frame_rate_den / params->frame_rate_num;
+
+	return 0;
+}
+
+static int vpu_windsor_update_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_encode_params *params)
+{
+	struct vpu_enc_expert_mode_param *expert;
+
+	expert = get_expert_param(shared, instance);
+
+	vpu_windsor_set_frame_rate(expert, params);
+	vpu_windsor_set_qp(expert, params);
+	vpu_windsor_set_sar(expert, params);
+	vpu_windsor_set_color(expert, params);
+	vpu_windsor_update_bitrate(shared, instance, params);
+	/*expert->config_param.iac_sc_threshold = 0;*/
+
+	return 0;
+}
+
+int vpu_windsor_set_encode_params(struct vpu_shared_addr *shared,
+		u32 instance, struct vpu_encode_params *params, u32 update)
+{
+	if (!params)
+		return -EINVAL;
+
+	if (!update)
+		return vpu_windsor_set_params(shared, instance, params);
+	else
+		return vpu_windsor_update_params(shared, instance, params);
+}
+
+u32 vpu_windsor_get_max_instance_count(struct vpu_shared_addr *shared)
+{
+	struct windsor_iface *iface;
+
+	WARN_ON(!shared || !shared->iface);
+
+	iface = shared->iface;
+
+	return iface->max_streams;
+}
diff --git a/drivers/media/platform/imx/vpu-8q/vpu_windsor.h b/drivers/media/platform/imx/vpu-8q/vpu_windsor.h
new file mode 100644
index 000000000000..a5f6421fce1f
--- /dev/null
+++ b/drivers/media/platform/imx/vpu-8q/vpu_windsor.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef _IMX_VPU_WINDSOR_H
+#define _IMX_VPU_WINDSOR_H
+
+u32 vpu_windsor_get_data_size(void);
+void vpu_windsor_init_rpc(struct vpu_shared_addr *shared,
+			struct vpu_buffer *rpc, dma_addr_t boot_addr);
+void vpu_windsor_set_log_buf(struct vpu_shared_addr *shared,
+			struct vpu_buffer *log);
+void vpu_windsor_set_system_cfg(struct vpu_shared_addr *shared,
+				u32 regs_base, void __iomem *regs, u32 core_id);
+int vpu_windsor_get_stream_buffer_size(struct vpu_shared_addr *shared);
+int vpu_windsor_pack_cmd(struct vpu_rpc_event *pkt,
+			u32 index, u32 id, void *data);
+int vpu_windsor_convert_msg_id(u32 msg_id);
+int vpu_windsor_unpack_msg_data(struct vpu_rpc_event *pkt, void *data);
+int vpu_windsor_config_memory_resource(struct vpu_shared_addr *shared,
+			u32 instance, u32 type, u32 index,
+			struct vpu_buffer *buf);
+int vpu_windsor_config_stream_buffer(struct vpu_shared_addr *shared,
+			u32 instance, struct vpu_buffer *buf);
+int vpu_windsor_update_stream_buffer(struct vpu_shared_addr *shared,
+			u32 instance, u32 ptr, bool write);
+int vpu_windsor_get_stream_buffer_desc(struct vpu_shared_addr *shared,
+			u32 instance, struct vpu_rpc_buffer_desc *desc);
+u32 vpu_windsor_get_version(struct vpu_shared_addr *shared);
+int vpu_windsor_set_encode_params(struct vpu_shared_addr *shared,
+			u32 instance,
+			struct vpu_encode_params *params,
+			u32 update);
+int vpu_windsor_input_frame(struct vpu_shared_addr *shared,
+			struct vpu_inst *inst, struct vb2_buffer *vb);
+u32 vpu_windsor_get_max_instance_count(struct vpu_shared_addr *shared);
+
+#endif
diff --git a/include/linux/imx_vpu.h b/include/linux/imx_vpu.h
new file mode 100644
index 000000000000..46aa2464e6fe
--- /dev/null
+++ b/include/linux/imx_vpu.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2021 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef __LINUX_IMX_VPU_H
+#define __LINUX_IMX_VPU_H
+
+#include <uapi/linux/imx_vpu.h>
+
+#endif
diff --git a/include/uapi/linux/imx_vpu.h b/include/uapi/linux/imx_vpu.h
new file mode 100644
index 000000000000..330082d1c13f
--- /dev/null
+++ b/include/uapi/linux/imx_vpu.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright 2018-2020 NXP
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef _UAPI__LINUX_IMX_VPU_H
+#define _UAPI__LINUX_IMX_VPU_H
+
+#include <linux/videodev2.h>
+#include <linux/v4l2-controls.h>
+
+/*imx v4l2 controls & extension controls*/
+
+//ctrls & extension ctrls definitions
+#define V4L2_CID_NON_FRAME		(V4L2_CID_USER_IMX_BASE)
+#define V4L2_CID_DIS_REORDER		(V4L2_CID_USER_IMX_BASE + 1)
+#define V4L2_CID_ROI_COUNT		(V4L2_CID_USER_IMX_BASE + 2)
+#define V4L2_CID_ROI			(V4L2_CID_USER_IMX_BASE + 3)
+#define V4L2_CID_IPCM_COUNT		(V4L2_CID_USER_IMX_BASE + 4)
+#define V4L2_CID_IPCM			(V4L2_CID_USER_IMX_BASE + 5)
+#define V4L2_CID_HDR10META		(V4L2_CID_USER_IMX_BASE + 6)
+#define V4L2_CID_SECUREMODE		(V4L2_CID_USER_IMX_BASE + 7)
+#define V4L2_CID_SC_ENABLE		(V4L2_CID_USER_IMX_BASE + 8)
+
+#define V4L2_MAX_ROI_REGIONS		8
+struct v4l2_enc_roi_param {
+	struct v4l2_rect rect;
+	__u32 enable;
+	__s32 qp_delta;
+	__u32 reserved[2];
+};
+
+struct v4l2_enc_roi_params {
+	__u32 num_roi_regions;
+	struct v4l2_enc_roi_param roi_params[V4L2_MAX_ROI_REGIONS];
+	__u32 config_store;
+	__u32 reserved[2];
+};
+
+#define V4L2_MAX_IPCM_REGIONS		2
+struct v4l2_enc_ipcm_param {
+	struct v4l2_rect rect;
+	__u32 enable;
+	__u32 reserved[2];
+};
+struct v4l2_enc_ipcm_params {
+	__u32 num_ipcm_regions;
+	struct v4l2_enc_ipcm_param ipcm_params[V4L2_MAX_IPCM_REGIONS];
+	__u32 config_store;
+	__u32 reserved[2];
+};
+
+struct v4l2_hdr10_meta {
+	__u32 hasHdr10Meta;
+	__u32 redPrimary[2];
+	__u32 greenPrimary[2];
+	__u32 bluePrimary[2];
+	__u32 whitePoint[2];
+	__u32 maxMasteringLuminance;
+	__u32 minMasteringLuminance;
+	__u32 maxContentLightLevel;
+	__u32 maxFrameAverageLightLevel;
+};
+
+/*imx v4l2 command*/
+#define V4L2_DEC_CMD_IMX_BASE		(0x08000000)
+#define V4L2_DEC_CMD_RESET		(V4L2_DEC_CMD_IMX_BASE + 1)
+
+/*imx v4l2 event*/
+//error happened in dec/enc
+#define V4L2_EVENT_CODEC_ERROR		(V4L2_EVENT_PRIVATE_START + 1)
+//frame loss in dec/enc
+#define V4L2_EVENT_SKIP			(V4L2_EVENT_PRIVATE_START + 2)
+//crop area change in dec, not reso change
+#define V4L2_EVENT_CROPCHANGE		(V4L2_EVENT_PRIVATE_START + 3)
+//some options can't be handled by codec, so might be ignored or updated. But codec could go on.
+#define V4L2_EVENT_INVALID_OPTION	(V4L2_EVENT_PRIVATE_START + 4)
+
+/*imx v4l2 warning msg, attached with event V4L2_EVENT_INVALID_OPTION*/
+enum {
+	UNKONW_WARNING = -1,		//not known warning type
+	RIOREGION_NOTALLOW,		//(part of)roi region can not work with media setting and be ignored by enc
+	IPCMREGION_NOTALLOW,		//(part of)ipcm region can not work with media setting and be ignored by enc
+	LEVEL_UPDATED,			//current level cant't work with media setting and be updated by enc
+};
+
+/*  Flags for 'flags' field */
+/* Buffer only contains codec config data, eg. sps and pps*/
+#define V4L2_BUF_FLAG_CODECCONFIG	0x00200000
+
+/* imx v4l2 formats */
+/*raw formats*/
+#define V4L2_PIX_FMT_BGR565		v4l2_fourcc('B', 'G', 'R', 'P') /* 16  BGR-5-6-5 */
+#define V4L2_PIX_FMT_NV12X		v4l2_fourcc('N', 'V', 'X', '2') /* Y/CbCr 4:2:0 for 10bit */
+#define V4L2_PIX_FMT_DTRC		v4l2_fourcc('D', 'T', 'R', 'C') /* 8bit tile output, uncompressed */
+#define V4L2_PIX_FMT_P010		v4l2_fourcc('P', '0', '1', '0')	/* ms p010, data stored in upper 10 bits of 16 */
+#define V4L2_PIX_FMT_TILEX		v4l2_fourcc('D', 'T', 'R', 'X') /* 10 bit tile output, uncompressed */
+#define V4L2_PIX_FMT_RFC		v4l2_fourcc('R', 'F', 'C', '0') /* 8bit tile output, with rfc*/
+#define V4L2_PIX_FMT_RFCX		v4l2_fourcc('R', 'F', 'C', 'X') /* 10 bit tile output, with rfc */
+#define V4L2_PIX_FMT_411SP		v4l2_fourcc('4', '1', 'S', 'P') /* YUV 411 Semi planar */
+#define V4L2_PIX_FMT_NT8		v4l2_fourcc('N', 'A', '1', '2') /* NXP Tiled NV12 Format*/
+#define V4L2_PIX_FMT_NT10		v4l2_fourcc('N', 'T', '1', '2') /* NXP Tiled 10 bit Format*/
+
+/*codec format*/
+#define V4L2_PIX_FMT_AV1		v4l2_fourcc('A', 'V', '1', '0')	/* av1 */
+#define V4L2_PIX_FMT_RV			v4l2_fourcc('R', 'V', '0', '0')	/* rv  */
+#define V4L2_PIX_FMT_AVS		v4l2_fourcc('A', 'V', 'S', '0')	/* avs */
+#define V4L2_PIX_FMT_VP6		v4l2_fourcc('V', 'P', '6', '0') /* vp6 */
+#define V4L2_PIX_FMT_SPK		v4l2_fourcc('S', 'P', 'K', '0') /* spk */
+
+/*codec formats*/
+#endif	//#ifndef _UAPI__LINUX_IMX_VPU_H
-- 
2.31.1

