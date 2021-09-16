Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE440D84F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhIPLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:20:29 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:24245
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237354AbhIPLTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAHMeblbOJKvCPIo2vMr59M7IVnAgUSKDUpAUhIUxqVSIJoyINvtGddqGG4SEfLba6/ZTa/HedsK/Pal51hr6mUQWMPa4gOJAzoMSeXyeBi+KjIZYHkzS6I30mB11UIdDVI8laSrg/9rEyQQXq1HDzjBAMkSldmnTskBrmFmA4HeygEq0ADdaS5LsOCESpskKuSmhkr946Hpa5LV5MU3LfZWJmVUg5y7cWTZDTp1ptXcu6EhaUdGPJcjGu1V8hhp7JEdWzbgQOjcMcQpga4yWkzpo7I/pYGTkPz4hpUU4oAK/JbkO8HX4m3v92SlrXFCPFLrdzJnQYW595ZMdRf4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r33LpVf5TasNOfyqMtcxuG9Sf+2Ff/371JeRpRovvoA=;
 b=mItNc2pTgmfnePn6qnoC34YEQZsFs5EB5fqir1nM1RLJ/E9Czyx97r5p3FE160KPGr+XCNSiUyHv6bVtexPB8mzqxI9laxl5uwY6HKL8Yf9wLcWpk+JpWRq4AbyobA0C0auqalYK9tn+HBpBJVCxkdxYFDc9EzaKQgnVRHj1iXSi5bzUCGg5b6eoMxIkA8HG2fG1TkkpocpE25gOBpuBzJX5m0pLCYeKTjl/vOtAbbBZJkgcBsjJqTSMgVnCHRenK7KJUSxD3+iiY8sA9HNNzl910yI0N1PQ1Sj7yi5s0t+T0xqQ1A8Vq0+k/gTawaIdvZzYjIpG5xOhUGY43x0YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r33LpVf5TasNOfyqMtcxuG9Sf+2Ff/371JeRpRovvoA=;
 b=iabjGb7cZ6OSfpkJnEBjvTpdzsB3b85vN50FxG9zzHcjd3Za2J/YE7riiHv5/3ibi0jYCJIeOINinMGrkVuSUPWs5OQzUGkGWJwA1NddgyvtcdVRLKS0/vLWFZk572K/R3ymt1jadt0V+hnlODvYwXTiLLKsksMg4DduiHOmNMs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB4926.eurprd04.prod.outlook.com (2603:10a6:803:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 11:17:21 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28%7]) with mapi id 15.20.4500.020; Thu, 16 Sep 2021
 11:17:20 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        peter.ujfalusi@linux.intel.com, daniel.baluta@nxp.com,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH 12/12] ASoC: SOF: topology: Add kernel parameter for topology verification
Date:   Thu, 16 Sep 2021 14:16:46 +0300
Message-Id: <20210916111646.367133-13-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916111646.367133-1-daniel.baluta@oss.nxp.com>
References: <20210916111646.367133-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0037.eurprd04.prod.outlook.com
 (2603:10a6:208:1::14) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5708:8600:b29c:ccfa:a961:8ebd) by AM0PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:208:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 11:17:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da409bb6-8407-430b-87c3-08d979038cf5
X-MS-TrafficTypeDiagnostic: VI1PR04MB4926:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB49269AA72BF7725DA068F612B8DC9@VI1PR04MB4926.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjAfh6V47/dSUC3sA+tByyKaE5hRNGCB4e0JUqw6wNuPThs07BS9aLTTnutUdLPbA0TPFz/NUksxoxQ9OnblJ25EU9ERP+4R4wEQVSIWUCTG8SFHju88h0E/GUI1xNoMgZAoY2BoG1CipdZduwEfVR9d7Y2Dxw3P/qULcFZoJy69aOGmiM3YPhRNNXL9ibavSWo3mLCgrIuMIP+7gVMhbeI8Oe4wu1xBaoHbqlzPWjNwLMQGz0Ueo5bzpGCP3FCCXumT39Wed0OpgRf+ouA2M3FSmze4QIvou4bdjpL4QpXj7b9j34hv5UH2YKm20FdtUGx7QiphBowEhQL62n/nGbpRwGR3BMWcoXMCgzkyw3ssKvikKn3Zd6e3BNN419C9QVpF7oHcE+BhFgOsGtSmSLRdYHoamSH3EK1NSkGIVdml+QO4dtrb6VJcNmWZP0o5Ae0U6kFdLbfceiaWdJbe/uxqcEdaDeojvb6ImOFemm92l5MNuaVHkCOk1xbK+XTkKxNCEMAS57UKvKlR1ii5pkWYNerQwTOeMMk853eHUHJ0L3V9FB9RK46zRxrkG6q5vCDKjCAQBXDUgsYgLJXtHkGwxU0is9ldW12tKkOZ0XWJKpCzA4taDtz5piFasdEjW5I8IlvlI0h3NlJQB4H9Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(4326008)(8936002)(15650500001)(6486002)(186003)(83380400001)(6916009)(2616005)(5660300002)(66946007)(52116002)(478600001)(8676002)(6512007)(6506007)(86362001)(2906002)(44832011)(66476007)(66556008)(316002)(1076003)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNZl2AwUlY83h6VY26ZjLsyzPSsUt083DxnKVyDWOKXhJ+J/23RS0wz+nYSD?=
 =?us-ascii?Q?UFvqgMnNm0emaihAyAn/BVmHjL2RxQnSFignNKQtuymiCFcRzzr2LXOC4vLx?=
 =?us-ascii?Q?NQYrErzFdcXdDyildWrufBPgxyYi0+10Pp7gTuaG+Zv4tO0AjDkcVuosW9+S?=
 =?us-ascii?Q?gm6Hy6FIFU8I8GDoiuOzoj4AUymkryCv+SCHP3XCo7JayltO+7I9TvRxm9Uy?=
 =?us-ascii?Q?5uVfor+nVG06FsRA/5FfcieYEO9YZiccYrPqwbDDBy8NCgY7RBSWQ+/FWJ1b?=
 =?us-ascii?Q?kXpKqzGL/Rt+MgXffYaaU9zGDc9PKGO/FF6T1MkZ+q9Ytyulb3B71R9NTvQK?=
 =?us-ascii?Q?0otsJ+PCF/Ab4eUDjhMJXpTX3n1IMaXbEFAslpSBfJqiHuLEWUmT6ezNHtjD?=
 =?us-ascii?Q?cpvGj8r46vqF3BbBDN7m5M3CrZ0DKxqKlLPi3TMCpJG0laCUqBP4rH6oTMiO?=
 =?us-ascii?Q?tBcQj0yHRTrrB6Rdiz5TMo79qyoRWY3xfKp394VxndZlG22/2zNwVgV1tBLo?=
 =?us-ascii?Q?c3hjMwmozcejZgBbiSTIo2wbr8ln4LK7pnS8jk1WBKsmuw/yvc9X5gOIi+Ot?=
 =?us-ascii?Q?Msb0UKM4RUYdnGK+v7LiFwxFk3TN1+0SjrW73iFdSsgj0HvpHIHteBGoPUle?=
 =?us-ascii?Q?AQ96jZBG6fytH8Hs7gO1oFGjQ0sIbiYUWic42vmgblY/Qj+cl+k+LMHFBjXI?=
 =?us-ascii?Q?N2WHvTIaJIm0wj3u71iuFnpx6E5NJlkFM+lsbMVZ4BD2tH8waKylYcRi6Uu6?=
 =?us-ascii?Q?TMTvwjaxGv+lRqHmWxrxjEWRhZ0WLgMZKO8n0wPv+X1SRALKpO7eJT9y2+rt?=
 =?us-ascii?Q?EZz5qwe7v+aFz8n2x0w/05c2VesMJhXkdQ/AGi1qcWUVBhZynnFKaRVO/Kbq?=
 =?us-ascii?Q?JeQlkBN0T4kh/AqO7K7limZNttAHMdx0PIJZXgnvzEbgKqEDez+eh0lJgApy?=
 =?us-ascii?Q?VaQBPuorEdgs8/WA0FHZwv+536AbBAxisPy5pJbC04oKudj/JhvSnwiURjJz?=
 =?us-ascii?Q?LDaCSFPhB/JLgw3iidQ0b50AzDQpCmV6Kqn9ZSpAcBxv9ZHc296PCGkPgnne?=
 =?us-ascii?Q?lbJ7Gdvsndx1y6WYekk2wQt2n/drSwG9776eibxUUAxTgyjOpm2H91ZaN2Bh?=
 =?us-ascii?Q?PyrCoh0wi0/4wfN7bXQHDjDIlUaoi5P6vDdPgtn4it5SDHv3FPzWlfGzFwSb?=
 =?us-ascii?Q?wUnirKzsaC2Cgt1Nfh4hESP5jXFejHu3Vb9EYHh6eo4/aSfW3SqPnijxF5h5?=
 =?us-ascii?Q?LdsxG2fLk2SDoi2kJPfQY9nBQtCvp1s06mLyjapvsVKt0eTyLYL6GsaySCw3?=
 =?us-ascii?Q?G2qC2YKfDgEtcgJIgi8CFTgEMzYwLZ6r6tyjfgGvXf3TIHQD23Unfa48eAQB?=
 =?us-ascii?Q?//cSLtc5ZZgDRYGlo+JUWe8JAZvfgfv4CcVKzOMuswXlLmLG5A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da409bb6-8407-430b-87c3-08d979038cf5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 11:17:20.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOD0spoJ6fTzZKEdwmHEZfxvFD+6B8EAKeOeM2PtDj07e0TRlROIY56DKp56OZnAPnQmUXn/MmjAKduM8lsDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4926
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add a kernel debug flag to enable a one-shot topology
verification for all pipelines including the dynamic
ones. If the debug flag is set, all the topology
component loading will be verified during the complete
callback.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/pm.c        |  4 ++--
 sound/soc/sof/sof-audio.c | 37 +++++++++++++++++++++++++------------
 sound/soc/sof/sof-audio.h |  4 ++--
 sound/soc/sof/sof-priv.h  |  1 +
 sound/soc/sof/topology.c  | 17 ++++++++++++++++-
 5 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index ea27567d2fe4..9ec091130323 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -157,7 +157,7 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 	}
 
 	/* restore pipelines */
-	ret = sof_set_up_pipelines(sdev->dev);
+	ret = sof_set_up_pipelines(sdev->dev, false);
 	if (ret < 0) {
 		dev_err(sdev->dev,
 			"error: failed to restore pipeline after resume %d\n",
@@ -208,7 +208,7 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	if (target_state == SOF_DSP_PM_D0)
 		goto suspend;
 
-	sof_tear_down_pipelines(dev);
+	sof_tear_down_pipelines(dev, false);
 
 	/* release trace */
 	snd_sof_release_trace(sdev);
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 7b4dd64576fa..c4cabe26b157 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -589,7 +589,7 @@ const struct sof_ipc_pipe_new *snd_sof_pipeline_find(struct snd_sof_dev *sdev,
 	return NULL;
 }
 
-int sof_set_up_pipelines(struct device *dev)
+int sof_set_up_pipelines(struct device *dev, bool verify)
 {
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	struct snd_sof_widget *swidget;
@@ -599,7 +599,7 @@ int sof_set_up_pipelines(struct device *dev)
 	/* restore pipeline components */
 	list_for_each_entry_reverse(swidget, &sdev->widget_list, list) {
 		/* only set up the widgets belonging to static pipelines */
-		if (swidget->dynamic_pipeline_widget)
+		if (!verify && swidget->dynamic_pipeline_widget)
 			continue;
 
 		/* update DAI config. The IPC will be sent in sof_widget_setup() */
@@ -630,8 +630,8 @@ int sof_set_up_pipelines(struct device *dev)
 	list_for_each_entry(sroute, &sdev->route_list, list) {
 
 		/* only set up routes belonging to static pipelines */
-		if (sroute->src_widget->dynamic_pipeline_widget ||
-		    sroute->sink_widget->dynamic_pipeline_widget)
+		if (!verify && (sroute->src_widget->dynamic_pipeline_widget ||
+				sroute->sink_widget->dynamic_pipeline_widget))
 			continue;
 
 		ret = sof_route_setup_ipc(sdev, sroute);
@@ -646,7 +646,7 @@ int sof_set_up_pipelines(struct device *dev)
 		switch (swidget->id) {
 		case snd_soc_dapm_scheduler:
 			/* only complete static pipelines */
-			if (swidget->dynamic_pipeline_widget)
+			if (!verify && swidget->dynamic_pipeline_widget)
 				continue;
 
 			swidget->complete =
@@ -661,24 +661,37 @@ int sof_set_up_pipelines(struct device *dev)
 }
 
 /*
- * This function doesn't free widgets. It only resets the set up status for all routes and
- * use_count for all widgets.
+ * This function doesn't free widgets during suspend. It only resets the set up status for all
+ * routes and use_count for all widgets.
  */
-void sof_tear_down_pipelines(struct device *dev)
+int sof_tear_down_pipelines(struct device *dev, bool verify)
 {
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	struct snd_sof_widget *swidget;
 	struct snd_sof_route *sroute;
+	int ret;
 
 	/*
-	 * No need to protect swidget->use_count and sroute->setup as this function is called only
-	 * during the suspend callback and all streams should be suspended by then
+	 * This function is called during suspend and for one-time topology verification during
+	 * first boot. In both cases, there is no need to protect swidget->use_count and
+	 * sroute->setup because during suspend all streams are suspended and during topology
+	 * loading the sound card unavailable to open PCMs.
 	 */
-	list_for_each_entry(swidget, &sdev->widget_list, list)
-		swidget->use_count = 0;
+	list_for_each_entry_reverse(swidget, &sdev->widget_list, list) {
+		if (!verify) {
+			swidget->use_count = 0;
+			continue;
+		}
+
+		ret = sof_widget_free(sdev, swidget);
+		if (ret < 0)
+			return ret;
+	}
 
 	list_for_each_entry(sroute, &sdev->route_list, list)
 		sroute->setup = false;
+
+	return 0;
 }
 
 /*
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 8d1fc6a8d7d0..149b3dbcddd1 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -246,8 +246,8 @@ int snd_sof_ipc_set_get_comp_data(struct snd_sof_control *scontrol,
 int sof_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd, struct snd_pcm_hw_params *params);
 
 /* PM */
-int sof_set_up_pipelines(struct device *dev);
-void sof_tear_down_pipelines(struct device *dev);
+int sof_set_up_pipelines(struct device *dev, bool verify);
+int sof_tear_down_pipelines(struct device *dev, bool verify);
 int sof_set_hw_params_upon_resume(struct device *dev);
 bool snd_sof_stream_suspend_ignored(struct snd_sof_dev *sdev);
 bool snd_sof_dsp_only_d0i3_compatible_stream_active(struct snd_sof_dev *sdev);
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 80e4a8c29280..d950157feebe 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -23,6 +23,7 @@
 /* debug flags */
 #define SOF_DBG_ENABLE_TRACE	BIT(0)
 #define SOF_DBG_RETAIN_CTX	BIT(1)	/* prevent DSP D3 on FW exception */
+#define SOF_DBG_VERIFY_TPLG	BIT(2) /* verify topology during load */
 
 #define SOF_DBG_DUMP_REGS		BIT(0)
 #define SOF_DBG_DUMP_MBOX		BIT(1)
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index d8eb238e5229..44d60081bc26 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3452,8 +3452,23 @@ static int sof_complete(struct snd_soc_component *scomp)
 		}
 	}
 
+	/* verify topology components loading including dynamic pipelines */
+	if (sof_core_debug & SOF_DBG_VERIFY_TPLG) {
+		ret = sof_set_up_pipelines(scomp->dev, true);
+		if (ret < 0) {
+			dev_err(sdev->dev, "error: topology verification failed %d\n", ret);
+			return ret;
+		}
+
+		ret = sof_tear_down_pipelines(scomp->dev, true);
+		if (ret < 0) {
+			dev_err(sdev->dev, "error: topology tear down pipelines failed %d\n", ret);
+			return ret;
+		}
+	}
+
 	/* set up static pipelines */
-	return sof_set_up_pipelines(scomp->dev);
+	return sof_set_up_pipelines(scomp->dev, false);
 }
 
 /* manifest - optional to inform component of manifest */
-- 
2.27.0

