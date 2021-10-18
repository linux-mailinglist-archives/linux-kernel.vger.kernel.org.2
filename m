Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30276432259
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhJRPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:52 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64975
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233278AbhJRPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY9SXUqKFXKEX+UxJLK03ArojHnQyDULy43i7v7gisnqq8SqTcu/BftfmshxbkFAI3MP7chXKGp9kflOZ3lst0c1DXbTnAvcY+Pqzsawhfwp0UlHivYNz79whVDOZD92jQNQeVYo/82D5cdpxpKkoyzCN+okoe8BAB1NDA0YLu6r7ZnKnPAqm2THG3qw8ALbK8K/J3M5bJUaVEElWUNDOBd5x6Zifsc1eH970ZvU5bfA8OCJwADSmeDsB+d15GK+X7ilCKhrqgtij5fECw2YJ7TQJhm6UmaxyaWZsEtMRyVOCLKBrsUgxapGQR+ExYwXxrjpvv2874KhKEVDIPSTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YHX2Va3mQqA5nbAmSkfKu9CO5PX+4Y6J4vqIHOi2Io=;
 b=U4OQVYGEe9CVFMQXWAe1unSjLYac61Zdeoj/lezFfyfk+USd+y4DHubrUA8nw41gcbQojSxHRsGHTcCchVqV5CcKbeMp6DUnz7Et5lPtupwT86XmEl/Kt4UnrHIjwmzSgC0PvQSUnxnRVd8RS2awnTV7mUIpOlKu9w5liv+/B1ThbKvfFfXqlXkttUCNWiwUh47SS8WQWaaNOvei7zBhV2d4jtAZQLMLpw74GRel5TIKOSzWSBH1alFxkXKmuNM40SkTm+QUtiVX0C3HjA6IXOwuKHlGerhah+FoI48Ft6wqPxae3TIZGRDuUuZSkaCgiWu8F7uZ7IjktmkWMoimUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YHX2Va3mQqA5nbAmSkfKu9CO5PX+4Y6J4vqIHOi2Io=;
 b=Xdo+vzkdH/nEqUBHoP5/M0RQNsQo31ASmb09cY7vjg/6xli5bBI2kvRND7mbBAJq47v2sVTNmzRSeYF1JI7jcsSOTrTLZCjzsXVOCEPX47fxnSq+3EPlimjH8T7aB/2UuoPk1u01EjCSfQWt08Lp9E/GNJ0nE/f7VQLWndDOOTI=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7268.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:10:58 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:10:58 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     youri.querry_1@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/5] soc: fsl: dpio: fix kernel-doc warnings
Date:   Mon, 18 Oct 2021 18:10:32 +0300
Message-Id: <20211018151034.137918-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018151034.137918-1-ioana.ciornei@nxp.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13)
MIME-Version: 1.0
Received: from yoga-910.localhost (188.26.184.231) by AM8P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 15:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d63ed4d-d515-4f6d-474f-08d992497d21
X-MS-TrafficTypeDiagnostic: AM8PR04MB7268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7268F068FADAA853B4F2ADE8E0BC9@AM8PR04MB7268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rePaJockGkKve0A56fwlIu6AGNDsMdrSJnuQLz3QqZPTFNbqgEsywoRZJ57sDQ73Nd8TrbrDbjNCA4Ygx6prE2B/wTX2NGlyOVezLEkBqURcVH/HIT6cCD/SqGBHtce+ewyvSi8FqwHbfsehAeCRpganaDMnFf47zX4s9Jtvmi5ad2IUzFk9MlTYlx9EZ9Yy3MeSCsbZIUll5jYFnQDwOq15uzlwIYmrXj0kJybpUH5vkqVyPbzgaKW6xCPfwLZIbDYF0dxq510dBj2CfX7reWuUWwcKOGMJVvf++5t7q4zmU236b9BIPbl8SCjcGylYDDfXjzjtQLKcs/1AGNWvJWA5HxUrUFzEne8pZ0o6672s5fFKSixS9OiWXDxmd0ofuLQkcPc5uUJnq1oZL45JOiJanjJCfqYwkuIVIm/PFe9039HtW8uhLqMOTlCXodI1IeafzDHjSVIJdrRabMqkF4x6viDFxV4BbTtREkAq6sUP5I9ZDiT0dzYGDKXFHuQJiY43PmYSl4laMdBQFa+JCv1g19sKRU9jNBALsy8RX1Zjw1vtoHVMjWdDYSnuBaK/x9CXMX4HElpPbH5M6HTWe9/ldYhpTFksiir4O71lhS2mZYyaWAJjRTGTNfqzzOUXFgpe91MjERDaNFLVY+4CmKlPmT2YB7j7wbvmkRs/3OUiZN8sDtlGioZaLpBMUSQRO26n0/kb1UCDkN9QUbEueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(1076003)(83380400001)(66946007)(66476007)(2616005)(956004)(86362001)(6512007)(508600001)(30864003)(44832011)(6636002)(38100700002)(8936002)(186003)(4326008)(37006003)(8676002)(5660300002)(52116002)(2906002)(26005)(6506007)(38350700002)(6666004)(316002)(34206002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MW4YkIcZoI+x3aGYliT6g2ZcCMnjXoEPbtO0tyw9OWBpKI/i92BjG/SbWKEi?=
 =?us-ascii?Q?nDkIROixkKUFKiv34xHEC9X18aIA7i0O2uxBGZLO8rWauY3GWB13aJRRebe7?=
 =?us-ascii?Q?D3AewUaDbNd95xEpEXUdbUVzfv+tlBMpS99jg/yskfhqonvAkiRCDl/b8vJb?=
 =?us-ascii?Q?NYSWxxa/7WR4BZwU1pwZUhZyMciG4jhQ323Pl0ZB6XsMQUJGLz90eEdgeBsj?=
 =?us-ascii?Q?jH0rM4goXYaKTsqpw3sHkAmrPz5kCEW5whwCcMwiScVfwFXPO7wrMs64GrKK?=
 =?us-ascii?Q?UYBZ7uN1cvsljdDlyWfjpu3muhr8J1QeEWAIispGZbvzU8wq9JU/qD9mO+PS?=
 =?us-ascii?Q?2B9hpfOR7LpJcV0PmwL0kQ3Ewl6jbQSSjkpS/RSgyjaKN5ztIvWJGU1Eh+Cv?=
 =?us-ascii?Q?UZAXZ64/W65TWRuSdgpiIzrHgBkrLuF9KWt3Vv4eNva15e50+yCvvlLCTUMr?=
 =?us-ascii?Q?vNNA1vim48RRJynVANWRM57JCWtQ7tHL2Kh7UEvOxKzGDJjbGnmU7mCZ2YH4?=
 =?us-ascii?Q?0K2E6OgPfKxmpwZpVU9730XGDTVlvkkB8GTs2UWdMdS5vYX799wGS8ULk2D/?=
 =?us-ascii?Q?MkwfQP4w8HKA3kOdu5rDfAhRmOaJ308BjB4r8yL0sTaPxLbha1xL8dnLjs9D?=
 =?us-ascii?Q?JD+8xwblcW74xQETUosx1TJkmLq4A33Sk4nfEnORY7h41wPxrtX0Lew6Sl2F?=
 =?us-ascii?Q?V9Fn/JpZ/CPqYeWMlGzyU3bcfUbtFfEhkPhUtkUAm+MVFRg7XvtRpeIz8eD1?=
 =?us-ascii?Q?4sq9/30abCsyk/P9KyjFIULxplb2T8m72Z8phJjq8jevKpYVYxI6yG4Fvpdc?=
 =?us-ascii?Q?XXw250lSl388rVapBrnKXoxJP7v9xD/tVLytboG61d0wMOAq0ZHnFekvsAMM?=
 =?us-ascii?Q?mChwbmfxSypx6vSD2h35c2MlJ0/4uyrc1c/XjV4lh+D2WJXMzAfWJBjk8X01?=
 =?us-ascii?Q?z/F90XSvpe7qhai5IjMs/7u3MFi/IJPZirVHfv1b0qZkyUapGTI58pIEuqjI?=
 =?us-ascii?Q?+K/tS2okcYAz7T7wQwd3mlWoXn8eEmec9MuBZdp5m+Hrp4rH0B6e1BTtjSQL?=
 =?us-ascii?Q?sz7xVSb5mnnj/NrbH05RB/Rz8fPUPB8yzU7ifo4G1mCY1YkUrpIPU+o1/PN0?=
 =?us-ascii?Q?+S1M0ZOFKtv5ruCZYp/Mqy1x62RcO19mPTX/NGq1sDjJHGX2cAa1Rp4in1ux?=
 =?us-ascii?Q?vQUgE7bt65Mqbf2fFFbAsct3Nb5Z/hmuu0odIgKLvHu9N/veEHIYQn8Qgtl/?=
 =?us-ascii?Q?c7ILi/thDNHe//tYgykMR/zYngPBChk7Oy5AUwhFVRxQpOagm2w+qTeUfqkU?=
 =?us-ascii?Q?XQQNCoxluIeNfdJgwXVcqhll?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d63ed4d-d515-4f6d-474f-08d992497d21
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:10:58.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+mpDWUU5xDTpSVIfcMAisJL6wlihRfWDAkKel6Zh1I5au8SFHXmJj4kYqtftwvo9UwFguZ6/t00ux8ZB+754Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all the kernel-doc warnings in the dpio driver. These are not major
problems, but it's easier to spot problems in new code when we start
with a clean kernel-doc.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 40 +++++++++++++-------------
 drivers/soc/fsl/dpio/qbman-portal.c | 44 ++++++++++++++---------------
 drivers/soc/fsl/dpio/qbman-portal.h | 39 ++++++++++++++++---------
 3 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index db0d3910fee4..b166beb78ea5 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -96,7 +96,7 @@ static inline struct dpaa2_io *service_select(struct dpaa2_io *d)
  * dpaa2_io_service_select() - return a dpaa2_io service affined to this cpu
  * @cpu: the cpu id
  *
- * Return the affine dpaa2_io service, or NULL if there is no service affined
+ * Return: the affine dpaa2_io service, or NULL if there is no service affined
  * to the specified cpu. If DPAA2_IO_ANY_CPU is used, return the next available
  * service.
  */
@@ -128,7 +128,7 @@ static void dpaa2_io_dim_work(struct work_struct *w)
  * Activates a "struct dpaa2_io" corresponding to the given config of an actual
  * DPIO object.
  *
- * Return a valid dpaa2_io object for success, or NULL for failure.
+ * Return: a valid dpaa2_io object for success, or NULL for failure.
  */
 struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
 				 struct device *dev)
@@ -220,7 +220,7 @@ void dpaa2_io_down(struct dpaa2_io *d)
  *
  * @obj: the given DPIO object.
  *
- * Return IRQ_HANDLED for success or IRQ_NONE if there
+ * Return: IRQ_HANDLED for success or IRQ_NONE if there
  * were no pending interrupts.
  */
 irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
@@ -266,7 +266,7 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
  *
  * @d: the given DPIO object.
  *
- * Return the cpu associated with the DPIO object
+ * Return: the cpu associated with the DPIO object
  */
 int dpaa2_io_get_cpu(struct dpaa2_io *d)
 {
@@ -291,7 +291,7 @@ EXPORT_SYMBOL(dpaa2_io_get_cpu);
  *        in order for the object to be configured to produce the right
  *        notification fields to the DPIO service.
  *
- * Return 0 for success, or -ENODEV for failure.
+ * Return: 0 for success, or -ENODEV for failure.
  */
 int dpaa2_io_service_register(struct dpaa2_io *d,
 			      struct dpaa2_io_notification_ctx *ctx,
@@ -361,7 +361,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_deregister);
  * that source to allow it to produce another FQDAN/CDAN, that's what this
  * function achieves.
  *
- * Return 0 for success.
+ * Return: 0 for success.
  */
 int dpaa2_io_service_rearm(struct dpaa2_io *d,
 			   struct dpaa2_io_notification_ctx *ctx)
@@ -390,7 +390,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_rearm);
  * @fqid: the given frame queue id.
  * @s: the dpaa2_io_store object for the result.
  *
- * Return 0 for success, or error code for failure.
+ * Return: 0 for success, or error code for failure.
  */
 int dpaa2_io_service_pull_fq(struct dpaa2_io *d, u32 fqid,
 			     struct dpaa2_io_store *s)
@@ -421,7 +421,7 @@ EXPORT_SYMBOL(dpaa2_io_service_pull_fq);
  * @channelid: the given channel id.
  * @s: the dpaa2_io_store object for the result.
  *
- * Return 0 for success, or error code for failure.
+ * Return: 0 for success, or error code for failure.
  */
 int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
 				  struct dpaa2_io_store *s)
@@ -453,7 +453,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_pull_channel);
  * @fqid: the given frame queue id.
  * @fd: the frame descriptor which is enqueued.
  *
- * Return 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
+ * Return: 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
  * or -ENODEV if there is no dpio service.
  */
 int dpaa2_io_service_enqueue_fq(struct dpaa2_io *d,
@@ -482,7 +482,7 @@ EXPORT_SYMBOL(dpaa2_io_service_enqueue_fq);
  * @fd: the frame descriptor which is enqueued.
  * @nb: number of frames to be enqueud
  *
- * Return 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
+ * Return: 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
  * or -ENODEV if there is no dpio service.
  */
 int dpaa2_io_service_enqueue_multiple_fq(struct dpaa2_io *d,
@@ -512,7 +512,7 @@ EXPORT_SYMBOL(dpaa2_io_service_enqueue_multiple_fq);
  * @fd: the frame descriptor which is enqueued.
  * @nb: number of frames to be enqueud
  *
- * Return 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
+ * Return: 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
  * or -ENODEV if there is no dpio service.
  */
 int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
@@ -554,7 +554,7 @@ EXPORT_SYMBOL(dpaa2_io_service_enqueue_multiple_desc_fq);
  * @qdbin: the given queuing destination bin.
  * @fd: the frame descriptor which is enqueued.
  *
- * Return 0 for successful enqueue, or -EBUSY if the enqueue ring is not ready,
+ * Return: 0 for successful enqueue, or -EBUSY if the enqueue ring is not ready,
  * or -ENODEV if there is no dpio service.
  */
 int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d,
@@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_enqueue_qd);
  * @buffers: the buffers to be released.
  * @num_buffers: the number of the buffers to be released.
  *
- * Return 0 for success, and negative error code for failure.
+ * Return: 0 for success, and negative error code for failure.
  */
 int dpaa2_io_service_release(struct dpaa2_io *d,
 			     u16 bpid,
@@ -609,7 +609,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_release);
  * @buffers: the buffer addresses for acquired buffers.
  * @num_buffers: the expected number of the buffers to acquire.
  *
- * Return a negative error code if the command failed, otherwise it returns
+ * Return: a negative error code if the command failed, otherwise it returns
  * the number of buffers acquired, which may be less than the number requested.
  * Eg. if the buffer pool is empty, this will return zero.
  */
@@ -646,7 +646,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_acquire);
  * The size of the storage is "max_frames*sizeof(struct dpaa2_dq)".
  * The 'dpaa2_io_store' returned is a DPIO service managed object.
  *
- * Return pointer to dpaa2_io_store struct for successfully created storage
+ * Return: pointer to dpaa2_io_store struct for successfully created storage
  * memory, or NULL on error.
  */
 struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
@@ -716,7 +716,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_store_destroy);
  * the caller to always check for this. As such, "is_last" can be used to
  * differentiate between "end-of-empty-dequeue" and "still-waiting".
  *
- * Return dequeue result for a valid dequeue result, or NULL for empty dequeue.
+ * Return: dequeue result for a valid dequeue result, or NULL for empty dequeue.
  */
 struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_store *s, int *is_last)
 {
@@ -760,7 +760,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_store_next);
  * Knowing the FQ count at run-time can be useful in debugging situations.
  * The instantaneous frame- and byte-count are hereby returned.
  *
- * Return 0 for a successful query, and negative error code if query fails.
+ * Return: 0 for a successful query, and negative error code if query fails.
  */
 int dpaa2_io_query_fq_count(struct dpaa2_io *d, u32 fqid,
 			    u32 *fcnt, u32 *bcnt)
@@ -794,7 +794,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_query_fq_count);
  * @bpid: the index of buffer pool to be queried.
  * @num: the queried number of buffers in the buffer pool.
  *
- * Return 0 for a successful query, and negative error code if query fails.
+ * Return: 0 for a successful query, and negative error code if query fails.
  */
 int dpaa2_io_query_bp_count(struct dpaa2_io *d, u16 bpid, u32 *num)
 {
@@ -823,7 +823,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_query_bp_count);
  * @d: the given DPIO object
  * @irq_holdoff: interrupt holdoff (timeout) period in us
  *
- * Return 0 for success, or negative error code on error.
+ * Return: 0 for success, or negative error code on error.
  */
 int dpaa2_io_set_irq_coalescing(struct dpaa2_io *d, u32 irq_holdoff)
 {
@@ -863,7 +863,7 @@ EXPORT_SYMBOL(dpaa2_io_set_adaptive_coalescing);
  * dpaa2_io_get_adaptive_coalescing() - Query adaptive coalescing state
  * @d: the given DPIO object
  *
- * Return 1 when adaptive coalescing is enabled on the DPIO object and 0
+ * Return: 1 when adaptive coalescing is enabled on the DPIO object and 0
  * otherwise.
  */
 int dpaa2_io_get_adaptive_coalescing(struct dpaa2_io *d)
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index eeefd1f19f0c..3fd54611ed98 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -241,7 +241,7 @@ static inline u8 qm_cyc_diff(u8 ringsize, u8 first, u8 last)
  *                    QBMan portal descriptor.
  * @d: the given qbman swp descriptor
  *
- * Return qbman_swp portal for success, NULL if the object cannot
+ * Return: qbman_swp portal for success, NULL if the object cannot
  * be created.
  */
 struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
@@ -374,10 +374,10 @@ void qbman_swp_finish(struct qbman_swp *p)
 }
 
 /**
- * qbman_swp_interrupt_read_status()
+ * qbman_swp_interrupt_read_status() - Read interrupt status for swp
  * @p: the given software portal
  *
- * Return the value in the SWP_ISR register.
+ * Return: the value in the SWP_ISR register.
  */
 u32 qbman_swp_interrupt_read_status(struct qbman_swp *p)
 {
@@ -385,7 +385,7 @@ u32 qbman_swp_interrupt_read_status(struct qbman_swp *p)
 }
 
 /**
- * qbman_swp_interrupt_clear_status()
+ * qbman_swp_interrupt_clear_status() - Clear interrupt status for swp
  * @p: the given software portal
  * @mask: The mask to clear in SWP_ISR register
  */
@@ -398,7 +398,7 @@ void qbman_swp_interrupt_clear_status(struct qbman_swp *p, u32 mask)
  * qbman_swp_interrupt_get_trigger() - read interrupt enable register
  * @p: the given software portal
  *
- * Return the value in the SWP_IER register.
+ * Return: the value in the SWP_IER register.
  */
 u32 qbman_swp_interrupt_get_trigger(struct qbman_swp *p)
 {
@@ -419,7 +419,7 @@ void qbman_swp_interrupt_set_trigger(struct qbman_swp *p, u32 mask)
  * qbman_swp_interrupt_get_inhibit() - read interrupt mask register
  * @p: the given software portal object
  *
- * Return the value in the SWP_IIR register.
+ * Return: the value in the SWP_IIR register.
  */
 int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
 {
@@ -442,7 +442,7 @@ void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
  */
 
 /*
- * Returns a pointer to where the caller should fill in their management command
+ * Return: a pointer to where the caller should fill in their management command
  * (caller should ignore the verb byte)
  */
 void *qbman_swp_mc_start(struct qbman_swp *p)
@@ -587,7 +587,7 @@ void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
  * Please note that 'fd' should only be NULL if the "action" of the
  * descriptor is "orp_hole" or "orp_nesn".
  *
- * Return 0 for successful enqueue, -EBUSY if the EQCR is not ready.
+ * Return: 0 for successful enqueue, -EBUSY if the EQCR is not ready.
  */
 static
 int qbman_swp_enqueue_direct(struct qbman_swp *s,
@@ -613,7 +613,7 @@ int qbman_swp_enqueue_direct(struct qbman_swp *s,
  * Please note that 'fd' should only be NULL if the "action" of the
  * descriptor is "orp_hole" or "orp_nesn".
  *
- * Return 0 for successful enqueue, -EBUSY if the EQCR is not ready.
+ * Return: 0 for successful enqueue, -EBUSY if the EQCR is not ready.
  */
 static
 int qbman_swp_enqueue_mem_back(struct qbman_swp *s,
@@ -639,7 +639,7 @@ int qbman_swp_enqueue_mem_back(struct qbman_swp *s,
  * @flags: table pointer of QBMAN_ENQUEUE_FLAG_DCA flags, not used if NULL
  * @num_frames: number of fd to be enqueued
  *
- * Return the number of fd enqueued, or a negative error number.
+ * Return: the number of fd enqueued, or a negative error number.
  */
 static
 int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
@@ -722,7 +722,7 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
  * @flags: table pointer of QBMAN_ENQUEUE_FLAG_DCA flags, not used if NULL
  * @num_frames: number of fd to be enqueued
  *
- * Return the number of fd enqueued, or a negative error number.
+ * Return: the number of fd enqueued, or a negative error number.
  */
 static
 int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
@@ -803,7 +803,7 @@ int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
  * @fd: table pointer of frame descriptor table to be enqueued
  * @num_frames: number of fd to be enqueued
  *
- * Return the number of fd enqueued, or a negative error number.
+ * Return: the number of fd enqueued, or a negative error number.
  */
 static
 int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
@@ -873,7 +873,7 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
  * @fd: table pointer of frame descriptor table to be enqueued
  * @num_frames: number of fd to be enqueued
  *
- * Return the number of fd enqueued, or a negative error number.
+ * Return: the number of fd enqueued, or a negative error number.
  */
 static
 int qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
@@ -1096,7 +1096,7 @@ void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, u32 chid,
  * @d: the software portal descriptor which has been configured with
  *     the set of qbman_pull_desc_set_*() calls
  *
- * Return 0 for success, and -EBUSY if the software portal is not ready
+ * Return: 0 for success, and -EBUSY if the software portal is not ready
  * to do pull dequeue.
  */
 static
@@ -1132,7 +1132,7 @@ int qbman_swp_pull_direct(struct qbman_swp *s, struct qbman_pull_desc *d)
  * @d: the software portal descriptor which has been configured with
  *     the set of qbman_pull_desc_set_*() calls
  *
- * Return 0 for success, and -EBUSY if the software portal is not ready
+ * Return: 0 for success, and -EBUSY if the software portal is not ready
  * to do pull dequeue.
  */
 static
@@ -1170,7 +1170,7 @@ int qbman_swp_pull_mem_back(struct qbman_swp *s, struct qbman_pull_desc *d)
  * qbman_swp_dqrr_next_direct() - Get an valid DQRR entry
  * @s: the software portal object
  *
- * Return NULL if there are no unconsumed DQRR entries. Return a DQRR entry
+ * Return: NULL if there are no unconsumed DQRR entries. Return a DQRR entry
  * only once, so repeated calls can return a sequence of DQRR entries, without
  * requiring they be consumed immediately or in any particular order.
  */
@@ -1262,7 +1262,7 @@ const struct dpaa2_dq *qbman_swp_dqrr_next_direct(struct qbman_swp *s)
  * qbman_swp_dqrr_next_mem_back() - Get an valid DQRR entry
  * @s: the software portal object
  *
- * Return NULL if there are no unconsumed DQRR entries. Return a DQRR entry
+ * Return: NULL if there are no unconsumed DQRR entries. Return a DQRR entry
  * only once, so repeated calls can return a sequence of DQRR entries, without
  * requiring they be consumed immediately or in any particular order.
  */
@@ -1367,7 +1367,7 @@ void qbman_swp_dqrr_consume(struct qbman_swp *s, const struct dpaa2_dq *dq)
  * @s: the software portal object
  * @dq: the dequeue result read from the memory
  *
- * Return 1 for getting a valid dequeue result, or 0 for not getting a valid
+ * Return: 1 for getting a valid dequeue result, or 0 for not getting a valid
  * dequeue result.
  *
  * Only used for user-provided storage of dequeue results, not DQRR. For
@@ -1449,7 +1449,7 @@ void qbman_release_desc_set_rcdi(struct qbman_release_desc *d, int enable)
  * @buffers:     a pointer pointing to the buffer address to be released
  * @num_buffers: number of buffers to be released,  must be less than 8
  *
- * Return 0 for success, -EBUSY if the release command ring is not ready.
+ * Return: 0 for success, -EBUSY if the release command ring is not ready.
  */
 int qbman_swp_release_direct(struct qbman_swp *s,
 			     const struct qbman_release_desc *d,
@@ -1491,7 +1491,7 @@ int qbman_swp_release_direct(struct qbman_swp *s,
  * @buffers:     a pointer pointing to the buffer address to be released
  * @num_buffers: number of buffers to be released,  must be less than 8
  *
- * Return 0 for success, -EBUSY if the release command ring is not ready.
+ * Return: 0 for success, -EBUSY if the release command ring is not ready.
  */
 int qbman_swp_release_mem_back(struct qbman_swp *s,
 			       const struct qbman_release_desc *d,
@@ -1548,7 +1548,7 @@ struct qbman_acquire_rslt {
  * @buffers:     a pointer pointing to the acquired buffer addresses
  * @num_buffers: number of buffers to be acquired, must be less than 8
  *
- * Return 0 for success, or negative error code if the acquire command
+ * Return: 0 for success, or negative error code if the acquire command
  * fails.
  */
 int qbman_swp_acquire(struct qbman_swp *s, u16 bpid, u64 *buffers,
@@ -1808,7 +1808,7 @@ u32 qbman_bp_info_num_free_bufs(struct qbman_bp_query_rslt *a)
  * @irq_threshold: interrupt threshold
  * @irq_holdoff: interrupt holdoff (timeout) period in us
  *
- * Return 0 for success, or negative error code on error.
+ * Return: 0 for success, or negative error code on error.
  */
 int qbman_swp_set_irq_coalescing(struct qbman_swp *p, u32 irq_threshold,
 				 u32 irq_holdoff)
diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
index b23883dd2725..58aac46cc735 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -250,7 +250,7 @@ void *qbman_swp_mc_result(struct qbman_swp *p);
  * @d:  the enqueue descriptor
  * @fd: the frame descriptor to be enqueued
  *
- * Return 0 for successful enqueue, -EBUSY if the EQCR is not ready.
+ * Return: 0 for successful enqueue, -EBUSY if the EQCR is not ready.
  */
 static inline int
 qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
@@ -268,7 +268,7 @@ qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
  * @flags: table pointer of QBMAN_ENQUEUE_FLAG_DCA flags, not used if NULL
  * @num_frames: number of fd to be enqueued
  *
- * Return the number of fd enqueued, or a negative error number.
+ * Return: the number of fd enqueued, or a negative error number.
  */
 static inline int
 qbman_swp_enqueue_multiple(struct qbman_swp *s,
@@ -288,7 +288,7 @@ qbman_swp_enqueue_multiple(struct qbman_swp *s,
  * @fd: table pointer of frame descriptor table to be enqueued
  * @num_frames: number of fd to be enqueued
  *
- * Return the number of fd enqueued, or a negative error number.
+ * Return: the number of fd enqueued, or a negative error number.
  */
 static inline int
 qbman_swp_enqueue_multiple_desc(struct qbman_swp *s,
@@ -304,6 +304,7 @@ qbman_swp_enqueue_multiple_desc(struct qbman_swp *s,
  * @dq: the dequeue result to be checked
  *
  * DQRR entries may contain non-dequeue results, ie. notifications
+ * Return: returns 1 if result is DQ, 0 otherwise
  */
 static inline int qbman_result_is_DQ(const struct dpaa2_dq *dq)
 {
@@ -314,6 +315,7 @@ static inline int qbman_result_is_DQ(const struct dpaa2_dq *dq)
  * qbman_result_is_SCN() - Check the dequeue result is notification or not
  * @dq: the dequeue result to be checked
  *
+ * Return: returns 1 if result is DQ is notification, 0 otherwise
  */
 static inline int qbman_result_is_SCN(const struct dpaa2_dq *dq)
 {
@@ -370,6 +372,9 @@ static inline int qbman_result_is_FQPN(const struct dpaa2_dq *dq)
 
 /**
  * qbman_result_SCN_state() - Get the state field in State-change notification
+ * @scn: state change notification
+ *
+ * Return: the state field from scn
  */
 static inline u8 qbman_result_SCN_state(const struct dpaa2_dq *scn)
 {
@@ -380,6 +385,9 @@ static inline u8 qbman_result_SCN_state(const struct dpaa2_dq *scn)
 
 /**
  * qbman_result_SCN_rid() - Get the resource id in State-change notification
+ * @scn: state change notification
+ *
+ * Return: the resource id from scn
  */
 static inline u32 qbman_result_SCN_rid(const struct dpaa2_dq *scn)
 {
@@ -388,6 +396,9 @@ static inline u32 qbman_result_SCN_rid(const struct dpaa2_dq *scn)
 
 /**
  * qbman_result_SCN_ctx() - Get the context data in State-change notification
+ * @scn: state change notification
+ *
+ * Return: the context data field from scn
  */
 static inline u64 qbman_result_SCN_ctx(const struct dpaa2_dq *scn)
 {
@@ -402,7 +413,7 @@ static inline u64 qbman_result_SCN_ctx(const struct dpaa2_dq *scn)
  * There are a couple of different ways that a FQ can end up parked state,
  * This schedules it.
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_fq_schedule(struct qbman_swp *s, u32 fqid)
 {
@@ -420,7 +431,7 @@ static inline int qbman_swp_fq_schedule(struct qbman_swp *s, u32 fqid)
  * empty at the time this happens, the resulting dq_entry will have no FD.
  * (qbman_result_DQ_fd() will return NULL.)
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_fq_force(struct qbman_swp *s, u32 fqid)
 {
@@ -434,7 +445,7 @@ static inline int qbman_swp_fq_force(struct qbman_swp *s, u32 fqid)
  *
  * This setting doesn't affect enqueues to the FQ, just dequeues.
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_fq_xon(struct qbman_swp *s, u32 fqid)
 {
@@ -454,7 +465,7 @@ static inline int qbman_swp_fq_xon(struct qbman_swp *s, u32 fqid)
  * that FQ for dequeuing, then the resulting dq_entry will have no FD.
  * (qbman_result_DQ_fd() will return NULL.)
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_fq_xoff(struct qbman_swp *s, u32 fqid)
 {
@@ -480,7 +491,7 @@ static inline int qbman_swp_fq_xoff(struct qbman_swp *s, u32 fqid)
  * @channelid: the channel index
  * @ctx:       the context to be set in CDAN
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_CDAN_set_context(struct qbman_swp *s, u16 channelid,
 					     u64 ctx)
@@ -495,7 +506,7 @@ static inline int qbman_swp_CDAN_set_context(struct qbman_swp *s, u16 channelid,
  * @s:         the software portal object
  * @channelid: the index of the channel to generate CDAN
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_CDAN_enable(struct qbman_swp *s, u16 channelid)
 {
@@ -509,7 +520,7 @@ static inline int qbman_swp_CDAN_enable(struct qbman_swp *s, u16 channelid)
  * @s:         the software portal object
  * @channelid: the index of the channel to generate CDAN
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_CDAN_disable(struct qbman_swp *s, u16 channelid)
 {
@@ -524,7 +535,7 @@ static inline int qbman_swp_CDAN_disable(struct qbman_swp *s, u16 channelid)
  * @channelid: the index of the channel to generate CDAN
  * @ctx:i      the context set in CDAN
  *
- * Return 0 for success, or negative error code for failure.
+ * Return: 0 for success, or negative error code for failure.
  */
 static inline int qbman_swp_CDAN_set_context_enable(struct qbman_swp *s,
 						    u16 channelid,
@@ -617,7 +628,7 @@ u32 qbman_bp_info_num_free_bufs(struct qbman_bp_query_rslt *a);
  * @buffers:     a pointer pointing to the buffer address to be released
  * @num_buffers: number of buffers to be released,  must be less than 8
  *
- * Return 0 for success, -EBUSY if the release command ring is not ready.
+ * Return: 0 for success, -EBUSY if the release command ring is not ready.
  */
 static inline int qbman_swp_release(struct qbman_swp *s,
 				    const struct qbman_release_desc *d,
@@ -633,7 +644,7 @@ static inline int qbman_swp_release(struct qbman_swp *s,
  * @d: the software portal descriptor which has been configured with
  *     the set of qbman_pull_desc_set_*() calls
  *
- * Return 0 for success, and -EBUSY if the software portal is not ready
+ * Return: 0 for success, and -EBUSY if the software portal is not ready
  * to do pull dequeue.
  */
 static inline int qbman_swp_pull(struct qbman_swp *s,
@@ -646,7 +657,7 @@ static inline int qbman_swp_pull(struct qbman_swp *s,
  * qbman_swp_dqrr_next() - Get an valid DQRR entry
  * @s: the software portal object
  *
- * Return NULL if there are no unconsumed DQRR entries. Return a DQRR entry
+ * Return: NULL if there are no unconsumed DQRR entries. Return a DQRR entry
  * only once, so repeated calls can return a sequence of DQRR entries, without
  * requiring they be consumed immediately or in any particular order.
  */
-- 
2.33.1

