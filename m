Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A14535AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhKPPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:25:25 -0500
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:60808
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238173AbhKPPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:25:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEkgF4l8uEpKouRPcbMiyI2KPaAMOdRf2zb3tmq0QMhLqyrCzaUoubkbZkvFoJ+dkHx0F3O8PJDgbaz2g5NVpGBRjhaHxUI+VUPCVlaxZGvDxVWiQUDQbnHGuf6WOX2htQe4SRTEdRgqmaTAC8OVHdxwPvRPhXMFSc5GI9mURnrzTBDauHxcJMFD6h+Ip1MqIKvPNO3TeNQl6taKZU3NA/dH2zfOtezw8krszXJtZK9BBpmaO4jIfGpOuStCQoaiCfRX0Y7Bbin05PVyRuY9aFom2dkRbTD1L/GF7gDQes2LJKlBIVEHUUnPY0cKbPA4wdbbwNH4IQbsbGuByVbm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCZouXwTxARtL61XltXgJV4Uy2gLPG6QyAVTnp5xgiM=;
 b=Aj0VWvHgm969h2JGcB4fnHd7OBUEBIREoVYtza2PReBzXQ+PMARQAjIpUjGpHZf/t2i8XTnTULTSHq4mfIfeAw9rJquSyKPngR93eeikx1plcLQ/unnO3N7z2vaBbSg//IBV15O/0lELQK2H/T8hwDHe9UqGl/EY2F/wVyPyDJ0GQWdfGLx+4yzwHL44HSaDcHoeu/mGk90Oye3K3/QiTfOYx3K1crtf8MmCtpHdJ7w/1lVJDhuObziZEaiVQ0HgWLLI9gqKbaJ6349y+R6dcMJYtftVijzpdJgzY7tJiLfpfA50N2g/1iVU61ozttpYuXwikKt0w7HNI1Lwkk4qPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCZouXwTxARtL61XltXgJV4Uy2gLPG6QyAVTnp5xgiM=;
 b=arxXVUG7g7mg+lbPT/AUl9ygI9srypS8ykDR3cAro17nCHNjCAKuoncONTMQnd6dUbyyh3RBtIJtKKkl+nZQskr5D6IwmnHizrkmLRfEgl9r12C8EW7WubouNVH9EIk0oRZhwalWRwC/u9CVevE5GtzWQslD37qkfGEoAMlq5FY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB6880.eurprd04.prod.outlook.com (2603:10a6:803:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 15:22:02 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 15:22:02 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, peter.ujfalusi@linux.intel.com
Cc:     daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rander Wang <rander.wang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH 2/4] ASoC: SOF: imx: Use the generic helper to get the reply
Date:   Tue, 16 Nov 2021 17:21:35 +0200
Message-Id: <20211116152137.52129-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211116152137.52129-1-daniel.baluta@oss.nxp.com>
References: <20211116152137.52129-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0013.eurprd03.prod.outlook.com
 (2603:10a6:205:2::26) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:1e69:ee6:2dad:c9e7) by AM4PR0302CA0013.eurprd03.prod.outlook.com (2603:10a6:205:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Tue, 16 Nov 2021 15:22:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0404410-d5f6-47ac-1bc0-08d9a914d6df
X-MS-TrafficTypeDiagnostic: VI1PR04MB6880:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6880B7F5600A87469AF6E19EB8999@VI1PR04MB6880.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QO/LwXGfQmfn/fOfYKgQVRNwF2nyL+qVkVHMkZXdUtIEPItNNUNxIOLXB46mkTx9PQRT7jbSDgD3PgcsuLGGSQla4yDpV2AeUQE/gqQ+N8+YaS1hkGYSuEc1XJ3lIci+iAgNIzzoVe/QVJGMe/tlSMXK+hKcYv67VSCDgzr3IgFjeIRR+6pyNKfkcj6eJx5lTWwFCItDnSAL7YiASHTzmsTkWRpQkPmMiYnMyd0WfVldE9mjbra1XbbhJk9qIcYRyWdu759I+cBdshjnkXH7ktaCqwheJ6XaILdK+oVqHpnPBKKT/jlYyz+F8wDdWziX2pk02+Yo1dc2KGqCs5AqBbHvbMPGzGLgN9+Zy3TUAXZ78msr/CH92SDJIifgxS8fWrZpLfnryYzMiVQEufmQbJqAcZ10G8IcfmoawCXbR/GkXqt5d66qzNkbzmoOjhkp7KFN4DjGvhGgN4ajBIFPuqXs+qBvf5xsXJ8Zp+saGwplT4Iu/Kr8qzwYeXGo22aIxBHd0uO5He05C+YGc0V35ErMzl1yCo1uq1HFISM3hVNbottYqQ2yCNnemvkVX37uR6d/aRexXqMIvdflK+XNOWwpaO6Au9jhhWhQXQ7eUNf+R/FsVIYjrvv0v2tA6PhnnGuXGU824942TVGe3twpJJ0m4LRuM7IAdUU9cZx3YADJcL2ulvJ9KVHn2UwIiUXKpyY7lM7JbXqI/mKNmiCxdiJNFpOE5MjXdVgrX4NKBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(6666004)(38100700002)(5660300002)(8936002)(2616005)(52116002)(2906002)(86362001)(6512007)(316002)(66556008)(186003)(1076003)(508600001)(66476007)(54906003)(66946007)(6486002)(7416002)(44832011)(83380400001)(6506007)(41533002)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcVBJe+1ogOCG10hAqTXBLwiwpshQr6A/aEpw2B1fiGaxVj2EqdELcUEhq5f?=
 =?us-ascii?Q?GNR0gzVGdDK4Np5xOoOClsvvHKGDBZls1NR/ZEciTFKyQNdB2HfMvzcnD+24?=
 =?us-ascii?Q?w2TUo70ppGrT5y5+Q+hITxvbBbESbMJnk3EMhEgw+u8dIo7pm6hnB9afGmHl?=
 =?us-ascii?Q?AvaLCEVzGdBFZiGLh4SJ4zWKtFl0EmXqQA9TzysM1mrmPp/gj1SDLfRoE7qg?=
 =?us-ascii?Q?Bgf7K7j2ACKJ/lkfhUtgoQmwL6OedFTqgk/JYm8EZnz4ialgNmtAySZD2bzI?=
 =?us-ascii?Q?iIv8whK957NwLn4juEszrtgzS+X0QiTEDvURys+pkJnsbqnNe1JBBHu4fn7c?=
 =?us-ascii?Q?z6Doa9I8Ri5c7z4woJ/stoO2v6qCCI6lfdn+UVhO1NxErhx9uMk07LcCfrS+?=
 =?us-ascii?Q?5b8lzSRWlp++rnkAIZHYr2rOQshdaqDaKChMghbxktHw1d2W+GYY+73EuQKK?=
 =?us-ascii?Q?X8YDIfoRsUvabsQF4DYMYU1iSBnIX+7Jder8GJOJjEmTJJax0T5olV8LTYWN?=
 =?us-ascii?Q?9WjVYk24T81EW0tqnYCSIIidCJzboIImgnx2Kfc9S4BI5iA8ZqOH8d0wy6/s?=
 =?us-ascii?Q?GD0FIpURj7ziX94D+C8OqQStAC1gJW1VU5KKM5tTCyApX3jqq3PmaVomfbXl?=
 =?us-ascii?Q?EUe/F2gXiBcNp6kMLSV9g28Wf9IXQlSzaBIM4Ip1XynKf8Hqgsatre+9qtfK?=
 =?us-ascii?Q?r47uQwZZWaMRnhZpy7Y849ppR6Zzcf2oKKIem3ZtRU3LFersjGsxH4jkDOAq?=
 =?us-ascii?Q?AxQnVl4DXH2PF/ox+nRWRdjSdYUj3fy4USF+3csxtSCUFJJF+B5mMSv4hn9e?=
 =?us-ascii?Q?TZvh4qmEqDakInTPtW2QaapLwvjrKZp7ftXsGY8H3z4YRmLx/rTWIaP7pjAf?=
 =?us-ascii?Q?IiIh/+Cj+dedWpsAhHbVrtc90KIzeRGXTHWZA3b3GvY5PEY4MVtYlQAbcXb3?=
 =?us-ascii?Q?haJ2NUd7AQ/7ygG9Rjnan/ez1/O88oo2wc2NX04uqFK1V6RnaHfmV3soliS2?=
 =?us-ascii?Q?I9IF18/Mw3bDCAPfgg6afi6YQFHim3HYw1PosG4wFrLRe/4knxuiMxXRw6vC?=
 =?us-ascii?Q?puZzj7cPOGWLLpUADzs+x02/Y+XC+oKjYzTP9AMOTHL/Qs4mE07EGfM54/Ec?=
 =?us-ascii?Q?52ZCUWvYBRuEBnQ4AxEBwD6dIhylxCWDPNPnRTi9iQNAqMlsWxE6F2MDZXcf?=
 =?us-ascii?Q?C87gKc0HvjOiE/7OH/x8fdIvvneq2vMwubhp8PSihxIYKYvLmyqsxtcgRIfR?=
 =?us-ascii?Q?n7ybVeKV0SM8S+s1vOLwgbt6d/JOZWT9XgUM8vyqZW9FT91kNwNnRi4cnzuw?=
 =?us-ascii?Q?2REj/QT9eSsf3+i98IDgqm7u6/qYwwhP/wwaYVtzSlLCwt2YAxKIYsaLtb5K?=
 =?us-ascii?Q?Gdut8anKm0yQ2Cv4n0IzuS9COd/LVsTmbDVLd3gzTtPIlF0WuAdu0PBavf53?=
 =?us-ascii?Q?fPnUaHnFlqIV84FK4ICaNQ2KKDV/PbV+bfzm4dCiHPrT9VyJllwWOoqCQyh6?=
 =?us-ascii?Q?zSZrSaBWgjmFcgMytPzDvVF+2TqOfCD5STeHy+htjbv4qAc+YAo0XFDdt7Ow?=
 =?us-ascii?Q?cHOTyw61g0ofuDMKKOIHuO8wH3HUXvT6YjRJ4xFSuwyscF4NWOmYnWotYeLl?=
 =?us-ascii?Q?TCmj7GiPlBosB/TEAZ82zUbMXYiLrHK1xYhZ3ztnpampB6D02aKowIslaCiE?=
 =?us-ascii?Q?gL9+Fl8GwrXogIfWtQLlPTgHdNg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0404410-d5f6-47ac-1bc0-08d9a914d6df
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:22:02.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmvZlCVtaKoJS6A6PZedvA8h8iEZUjiHvNixRZEGZAa2jDxOQfZsEvGCQcuU7huTLx5qfJVWcB6sL1D0o1zlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6880
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Make use of the generic snd_sof_ipc_process_reply() from the core instead
the local implementation.
snd_sof_ipc_process_reply() handles the reply retrieving and the ipc reply

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx8.c  | 37 +------------------------------------
 sound/soc/sof/imx/imx8m.c | 37 +------------------------------------
 2 files changed, 2 insertions(+), 72 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index dd59a74480d6..0aeb44d0acc7 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -59,40 +59,6 @@ struct imx8_priv {
 
 };
 
-static void imx8_get_reply(struct snd_sof_dev *sdev)
-{
-	struct snd_sof_ipc_msg *msg = sdev->msg;
-	struct sof_ipc_reply reply;
-	int ret = 0;
-
-	if (!msg) {
-		dev_warn(sdev->dev, "unexpected ipc interrupt\n");
-		return;
-	}
-
-	/* get reply */
-	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
-
-	if (reply.error < 0) {
-		memcpy(msg->reply_data, &reply, sizeof(reply));
-		ret = reply.error;
-	} else {
-		/* reply has correct size? */
-		if (reply.hdr.size != msg->reply_size) {
-			dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
-				msg->reply_size, reply.hdr.size);
-			ret = -EINVAL;
-		}
-
-		/* read the message */
-		if (msg->reply_size > 0)
-			sof_mailbox_read(sdev, sdev->host_box.offset,
-					 msg->reply_data, msg->reply_size);
-	}
-
-	msg->reply_error = ret;
-}
-
 static int imx8_get_mailbox_offset(struct snd_sof_dev *sdev)
 {
 	return MBOX_OFFSET;
@@ -109,8 +75,7 @@ static void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
-	imx8_get_reply(priv->sdev);
-	snd_sof_ipc_reply(priv->sdev, 0);
+	snd_sof_ipc_process_reply(priv->sdev, 0);
 	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
 }
 
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index e4618980cf8b..f454a5d0a87e 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -32,40 +32,6 @@ struct imx8m_priv {
 	struct platform_device *ipc_dev;
 };
 
-static void imx8m_get_reply(struct snd_sof_dev *sdev)
-{
-	struct snd_sof_ipc_msg *msg = sdev->msg;
-	struct sof_ipc_reply reply;
-	int ret = 0;
-
-	if (!msg) {
-		dev_warn(sdev->dev, "unexpected ipc interrupt\n");
-		return;
-	}
-
-	/* get reply */
-	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
-
-	if (reply.error < 0) {
-		memcpy(msg->reply_data, &reply, sizeof(reply));
-		ret = reply.error;
-	} else {
-		/* reply has correct size? */
-		if (reply.hdr.size != msg->reply_size) {
-			dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
-				msg->reply_size, reply.hdr.size);
-			ret = -EINVAL;
-		}
-
-		/* read the message */
-		if (msg->reply_size > 0)
-			sof_mailbox_read(sdev, sdev->host_box.offset,
-					 msg->reply_data, msg->reply_size);
-	}
-
-	msg->reply_error = ret;
-}
-
 static int imx8m_get_mailbox_offset(struct snd_sof_dev *sdev)
 {
 	return MBOX_OFFSET;
@@ -82,8 +48,7 @@ static void imx8m_dsp_handle_reply(struct imx_dsp_ipc *ipc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
-	imx8m_get_reply(priv->sdev);
-	snd_sof_ipc_reply(priv->sdev, 0);
+	snd_sof_ipc_process_reply(priv->sdev, 0);
 	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
 }
 
-- 
2.27.0

