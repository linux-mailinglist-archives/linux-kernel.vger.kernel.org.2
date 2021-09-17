Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C340FA55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243320AbhIQOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:38:49 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:37761
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243237AbhIQOir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:38:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEY8IJyct2TyZfWrgesCr6wDBmjZUWA3oGUqDjgt5X5wSOdAUw2KhhSkWYOtv5v2gHQHmYs97+vRNc9CMjlxrRmey1hG8YaxNi3HeKpFmCMuUZRVuCmB8omQQlVJhveHtHmV99+A2//aX7vCGs1u15mWS1NXRkL7twn+8IQqWsq7vyixt68yGKgCLA7oYL1GNHWuEopH02t69fNNqCNnwG4z7UEYM+MW1G9dIiikYsHulc44XcZmk/KxOyyOlsL0mSJ5WTIVihjHPfroiO9cynSbIy2b2+y3qym1UpOjdXQpu6X4AGzVqm6vMfcRfRfqcPGEVzzETCLnGBaQvs5GrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8gLGWve3UvVd8jvC9XczASUE2rKrgol1jb5xFi620Vk=;
 b=VWNDiY0/u38ySHyq/wO/MdlangeoeTg5IotlmTxrFGMfKyH9wb7+jMESlPtSnmrdzeCUIwxkG2A6WSufzuJTgEcO8bUfX46zqS1Goy06Mjil4bxvqDZdCgQDisL8fnvO5W+bGrDFgRM8Z5uessfzX7ae4nQBteMTQf/SckmWaPnL8iFxLwZ+FnjyI0ahQP6fkBqFBfKx11o7BiBkgrcYAz8p5uqRxh3QmxODulQtX3omRF8a9it6bAOeE0rX6lyZh5CvH3lOq/oKsDCLNAvkvM5yYkNbc+gvi6ebjwYnfj6SS1sRPQl9vgEmmRoMUFaHZDkisA71c6dtz68R/1ZjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gLGWve3UvVd8jvC9XczASUE2rKrgol1jb5xFi620Vk=;
 b=kTPVPw3DwVLTvXaX6v+aXkk72rRdN68kHCTDS9k1jl5jcy4nTabVRT8vboLVo475lixj2OupgfJBRvjwssiBe9YiEI1cxvLXYsvN4iQb9e0OFQNiSnpcYgnbY11YyRh4CERvycXkso8bNnHB70M7da07Yxe1wh0rPtwmvjRlD/A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 14:37:21 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::dd84:b996:1c8:705]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::dd84:b996:1c8:705%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 14:37:21 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH v2 02/12] ASoC: SOF: control: Add access field in struct snd_sof_control
Date:   Fri, 17 Sep 2021 17:36:49 +0300
Message-Id: <20210917143659.401102-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::32) To AM0PR04MB5140.eurprd04.prod.outlook.com
 (2603:10a6:208:ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5708:8600:8372:c747:541d:bbc9) by VI1P193CA0022.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:bd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 14:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78449ff7-341e-4d0b-f7dd-08d979e8a850
X-MS-TrafficTypeDiagnostic: AM8PR04MB7409:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7409E8116CC0F13C9BE61503B8DD9@AM8PR04MB7409.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oQXWWRKgQzGtC5GYEbIZzr+M2stQ3xiTSQ4hfmV9UuZBhTBCutUjAkzmwVw37Q4N98Lh3NptPRrgb1d9nt+m8184mJ4w6cl6IqSffvgMzZFWOGeQr6TRBXxoR3E5QLEeFqB/aWoCblmA8WOkMmml56CkLoPn8O5Tzkee7hG8uxwQJemtXR2gTWMa0jckLLjvVtvp5W1Qcq1uUpfeG//PrK4hu0xSD+cz6uvr2RtQByo8Vh4VbNTbmLKDEksTpkFWm5JgxowcPHbe7pte9d/FKJR16awinmEnXXMkbxFoE3V7kyx3iAhbNxhKGF/fCdWXyvGok4Pvrp5ByAyW0RNG7pzm2ADcQHRqOGlJS2N2g94KdC6XjhpHb6LZ9cNUlp1hGawRSAVNdrjgISlhTvJyQ9ti35CiQD3AzwiTKTnS9c7ez2DEn5/ztcXCBEuPds56wxGed1fDplozTvdk+wgklbXn1MZ60l5PwRl7UP8rFR9268oJIKTfO9nn4tBX+LvFfBERjeuaXf+YPAyhmXnWPd6D7KvRkrq6nioj45/Zulb3yuScxQtk2VFKijUhSUCZanl/9psdM/FkpMiIO4DXIjMHEkLWFg1yX+GVWYHILZPO020pgtoVehaWIw1F/yT2xRrY+2/gOjODuIGcTDy8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(5660300002)(8676002)(2906002)(4326008)(38100700002)(8936002)(66476007)(44832011)(1076003)(6666004)(86362001)(66556008)(6512007)(186003)(478600001)(316002)(6486002)(2616005)(6506007)(52116002)(6916009)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vIxmjOKrQnf7dvjgWclkmp2hfse8HvRJb0GHP6Pln2IR76ZDN3SOLckG2Mu?=
 =?us-ascii?Q?3miCLFN3X+TZ+ya7JjaCPsHGpeGVi9PbihyWQds+vNDXEikU6E6MB60RIVA6?=
 =?us-ascii?Q?l1WLZEmQbLxYz3hdQrs/ffKCcazMIXqEh1gJU4+0qmcQ9JEsqNGRoYrtfeCT?=
 =?us-ascii?Q?KUDBftgVtFFstkEVme3aDlz/9af1+5N5Z0U5GKwkg0GGBjlv/KttGfkTHdkV?=
 =?us-ascii?Q?l32m6Ddhnco3/3kBECFvMu8BmvSRW/i0slIEbzmJG/nSjNKeENj44tc4SsUh?=
 =?us-ascii?Q?esdlS4cpFHc+ZnPg7RUI4mtVyeA9A+CB9GF7xgOyPvLLmTc8r08JckBw19ne?=
 =?us-ascii?Q?qU3Pc+s1fGXhVPCjsOs0vastkiNpO0nLzk8ObRJjIXulcEXTUM0j57Jet2VV?=
 =?us-ascii?Q?ywhA/XffLF0mGgaUdU5Iw7C8Fv6z6JGrAW43nS9HyIaq5TAcNMbLXTkd/In2?=
 =?us-ascii?Q?a4OSLiJFPFdNM3gqvgby7HVFlK7IzHwSJv5YCIKXrpyk7pf9P3mo+L0iH87T?=
 =?us-ascii?Q?WlEPji99dlWm+ZRW2frRlYGNctp3u4JAjFLJA/1PkdYWVhISmmM+I+0EoMGd?=
 =?us-ascii?Q?6nKK1VfaIqpzJOcghGdaX93HHPiLLqnwVwr2/SqAa9A/dffvQl6ae9kXK8Aj?=
 =?us-ascii?Q?yS1IC4rWwEmHT1Bqh8HGCKGCyBFRomAqrIJH/PKdNgGYwWsot+aIDq0/T6Nm?=
 =?us-ascii?Q?ms9oN0obOgAl90VpWaGN0y0vBDi+Yu0x7JGKpLYxnAnaCnfEl2xN111ehGzd?=
 =?us-ascii?Q?bJRV5MHM/JQ5DhgGnquA+iRFSSag4/tLHVecZH1J+kgdCflkQ4MfKCdOSglp?=
 =?us-ascii?Q?GAS1zpXtLhlXvQskpG14CksW2c0WSvu4uxbOnerYzkF130iNSfylFalWb5b/?=
 =?us-ascii?Q?IEOW63Sgp9GWcrgePZUZqm38gpDP+FYeFOKtjSsIFyLCHqLCZtlO/zzqiScN?=
 =?us-ascii?Q?nMh/XhmiFTUxR/ME0bL/8bQuVHmcapMtAILEI07z1EihrInXJJJAqTyfUqG4?=
 =?us-ascii?Q?x6twBufIzGvaOKAoiPq3PCeTKViu0LlMVU2ZrQ6+DbZLzhMzDrwvsweI2VZW?=
 =?us-ascii?Q?tKf9uKLVfRDbIMIjoFJccgG6OrJvFxF66IyahP84zcUL3r2shXuHtwkrh642?=
 =?us-ascii?Q?vTBXVE++eyXrF3QC4n3s2FKrztoRWF+nokKjXqxZbeoCULjjZzOrugSVPeYL?=
 =?us-ascii?Q?WDxgo8La+7aO7rt5QjhhxdtwgFn4XoebwFB2phukTV1d8r/krEUQHHYo3cPx?=
 =?us-ascii?Q?op6gP28ZVWgWDHrXMCngNMKCpB67AFv9vlcKYw52dMqPKEldcwjIxqJwQ/K/?=
 =?us-ascii?Q?mGrUU3VQ/to/SuTriHBdFlfIBK+1mJJRjRmdzhgIgt6LVAhX0fClhGcg0nE6?=
 =?us-ascii?Q?rXWlEbAIz103gKypOfkUpual1K/X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78449ff7-341e-4d0b-f7dd-08d979e8a850
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:37:21.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqzc4/Qvpe7UNhMFUfWiCfW5hLtlrNKgnPQB2WCWjtgJ1WmeOQaB8+t8WHmTpBwIm8H662JXp184lrWzX4T6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add a new field to save the access setting for all controls
in struct snd_sof_control. This will be used to ensure that
only widgets belonging to static pipelines have volatile
controls.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/sof-audio.h | 1 +
 sound/soc/sof/topology.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 9a8d005e75a0..78a4a0c90a29 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -66,6 +66,7 @@ struct snd_sof_control {
 	int min_volume_step; /* min volume step for volume_table */
 	int max_volume_step; /* max volume step for volume_table */
 	int num_channels;
+	unsigned int access;
 	u32 readback_offset; /* offset to mmapped data if used */
 	struct sof_ipc_ctrl_data *control_data;
 	u32 size;	/* cdata size */
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 96b8791f7cc1..d8f7b1edefc3 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1250,6 +1250,7 @@ static int sof_control_load(struct snd_soc_component *scomp, int index,
 		return -ENOMEM;
 
 	scontrol->scomp = scomp;
+	scontrol->access = kc->access;
 
 	switch (le32_to_cpu(hdr->ops.info)) {
 	case SND_SOC_TPLG_CTL_VOLSW:
-- 
2.27.0

