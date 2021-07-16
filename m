Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8128C3CB4B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhGPIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:55:02 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:57924
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237433AbhGPIzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:55:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz5JsqnXBXYMyQycrnB6DzKNBpIObxOomKfcEcUv71/Q5KighvrbRfVrig0do9smcwKB9J+Ff6T213Y9In3tGVvFBioCZ92P+3ITApSDqqCCapnX4wut80gdGk3xYToGKbcqfiSJ64jmim0/TAHtsDtvIIF7oKjvIdwf7jeY0A7IrjtSNsVFLVDaEXUq8RCX266R7HAFR0lEp5QPGRon8dzDZN6W384mRjBxrjiEuFbxZQTEdmOZNrdR5vqbSI4UuCfoa1IMkD6y7YlidtlAlIbBJnnEHVLp5y8NWYyxcu+ByXJTADhQ8kdoGw1+aYcg85VQY1Mowb4tTSlut1Qz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRp4dlOD1dGhkb9TvRqf9ju2LzTeDvAghPvZ+T2LQ1o=;
 b=GF9vzfxZY6gF/Vp4WJGKjI5fht9AgrVvRBtLINFvVLZ0mzgDgFwwQgmcWrXP1VX/9nnKov394okKDFOyZ2OJY/uFmbP2TrwIjhbsTxPaQPd37gUQ/AAhoDFh6VGb5+M7cUjlW9WyCK2QwvisOgU95OnrBckM6skWuVC80g9bUKF4zSTZTNlvKHL7iNalbRByg1NDOHjjdGyekKL6VQajwQQdn6Co/FsB8i3hT8pSTDKqlczAbxDfxg+dpv+dSJGR7j1vxUig97xGEKp/iLJd4JIPnOxcwcqB2OsJP1d7s+xwvP2gah8FYiWMPrQFiPfaDhPsB7R65wRJnfKk+fLT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRp4dlOD1dGhkb9TvRqf9ju2LzTeDvAghPvZ+T2LQ1o=;
 b=fgBV4iam1hYkXH/GAoR69k0OlnQdQsXVLE4t0TSdAdWwp9ieb/10IhFrB9hmJU+vaQBIAs+4palbNpb+dMgisDYHaMJxLmCdAqb73rMgV3zdJE36vgRL9Fci8EDIvc5AoKw5ApUzC0YQ88QaMNDE9NVU7WGR6LQyk/T7qN+4gmk=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 08:52:03 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 08:52:03 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V3 0/5] i3c: master: svc: some bug fixes and add runtime pm support
Date:   Fri, 16 Jul 2021 16:53:12 +0800
Message-Id: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:52:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5f58cd-59c8-4db2-53aa-08d94836fb96
X-MS-TrafficTypeDiagnostic: AM7PR04MB7142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB714278AF94EB7330FE3646DBF3119@AM7PR04MB7142.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+4k5ccg0NvN4m/dCBcv93Z8CClyxThH7hvFI0PcY4oooJtD107mvfDCIaO57iORgbDE+P6H90iQ9u7NKm6GwTH7M7kyrV3O9WkscLCPytReU/vZCCviF3BQTbx87fhIjEHvzPnL950R3hQ3srFVPJAgsQ4xkJye+FYOmOx3rQqMsYfeECqWyP2Ws5EarHwX2mvZTw+OKLHtgsk40fIT8eeKM4EnmMfyFnoNLmYGmzuse34dFCUbyxjRAOhAcnfm9hkXhP6K9fasYrZCE1vRnxmYXOwMSCSNE7OLYfgXZ8vMNCFuMe1VPup15UoGTamzmvpSiHI6fPlRU4NMvI6ZCTYXbm0SEYgEaENqVnYO0SqAPY4rjJPeDHITuDLG4fEvC6IS/dAVe6ucvmxvtARpmNt9kt2jQ0P/eyqjtW9ZkvSZS1NvJGPKlpxwyOqI6CojI3F7li5Ard87mjjtUw29pdFmQqN2wsL7R+ezL14aY9IGOShalVU4ROLCnsyL9UguRkAj/0woIyYOznU14HdcVAiphdmsbOmGtUAeugd8ndndi/Xo39S3iML5trldaLUhf1H8u8vMSGVVoFrrit3gz30BTV4ozj9HiRD3T4xysqhQ7A9YUk4KgfajPMJFWUV0cA69S66xyu2ouphwaZbYrvUCkrHIdpAXln7DkGl1SjUA6MMWhNcs15FlXbDKTNqwqzDutkNeIIXdN9BWRP1y0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(366004)(376002)(36756003)(478600001)(5660300002)(8936002)(4744005)(316002)(66556008)(66476007)(8676002)(4326008)(86362001)(6512007)(1076003)(66946007)(26005)(2616005)(956004)(6506007)(52116002)(2906002)(6486002)(6666004)(186003)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hGK44nyTI+ymjQP+6PmlDxn5biNsKt4cE4CPrVkuhvjO282/N5rsFrfZiqs?=
 =?us-ascii?Q?kYLxXcKKsQlsE7c5fsEGZSuWfjJ9lWoTkMoaJhSkdjfYsB24LeqEcFHt04MG?=
 =?us-ascii?Q?gTeSGetai0KB8rGSAA2+5vassyFlKyjJZ/Ljj3BT4g7hDOgKMliwX/raJokh?=
 =?us-ascii?Q?eSwtKyzyRRVmEtPl2iIgkuz9J9R4XbgJjmO7EILpy3l90YWBpJudjLye518f?=
 =?us-ascii?Q?IXLj8n+VHYhVL227a+aw1EprVeEwTYemRBE2EP73sxJcLAcURXsSwBSNOdwI?=
 =?us-ascii?Q?YhYe5EJ4GZADLskwTo8bbfsHKcFWz3bDUUWfnwz32n13kUY9TU2QOfe2EOwS?=
 =?us-ascii?Q?eLPQ6xOWh7wFCLWFV632IUzUdl6nEC1JBjeBSUiC7gvnjWOcb9iZwpDlUxS5?=
 =?us-ascii?Q?xPjGDA1wTKnP2HWXemLl7d3KzPxTCQjnNA0mK03DNOF/tCbjxlELUN03sUGr?=
 =?us-ascii?Q?+dqwM9qzzg7mxldxUwsowA62fGaOLFWcEudCAOsGMApfUxssr3qx3iGgxAZc?=
 =?us-ascii?Q?AlTP6f5Zlye9sBaUAO5N7I7VwdQbwi1PsJ7QJZmxkqTfpTAKGqrvVIYyp66e?=
 =?us-ascii?Q?uVETcYwZNqpWs5VcuZEpgyeDv1YoEjelUozkQHEFfZ7oejHTJ1+ThIENG3L2?=
 =?us-ascii?Q?tzcJM5OVJBJxS+ooRK4nCFrNbgy/MMw3T6Pz00E6Vm+yxeQOqz8nBJNh67h3?=
 =?us-ascii?Q?mkqbILjOnHgHultZS2gH1b7eMXI0j4WuT8IbQVW917vRsn0Xs8pz5h6lSP2j?=
 =?us-ascii?Q?6HpTnS0GyS8rUzA9gom//6kPsaByCxlCeGwIPsuEiZloJDH/gQSO+Bt126jL?=
 =?us-ascii?Q?1e4lr1Ey8DX4Xl76bY2W+LV8prNSyV5NOIHkoLx8cURXQoe4K1KmC5E8NBI0?=
 =?us-ascii?Q?0LGuGmLJqu5OeweDLW2x7qStjA09SqSJJf85f6jibgNO5XU1VAnJuRwQ/a5B?=
 =?us-ascii?Q?byzcHDrc54UzzQaNbR/5pt8bV/WcMEjrwiWiXtKvMbaxYepYNXBjxfIeB14d?=
 =?us-ascii?Q?2GhtlVyKcTwtA995nP8LKLwRTLi4facs26wg/Hq8YbXdwbVh0avB5jzA/LeV?=
 =?us-ascii?Q?XMfiQT/T8Esekea1g/8kbVP9Qb8LY8z9h2pmvaetbrAtaryFaQHLAcEWmE2K?=
 =?us-ascii?Q?faxzyAa0ynZ+eB05n7/kdbzkl0PtLF+Jrc5zaddjKD7d3csLxoVNAdjW74eI?=
 =?us-ascii?Q?MkoSsOkXyeybSpHIDwl+h7gkcnEDvp+iAvOGDsM3SKPe+liuNPcSy+fhJE+U?=
 =?us-ascii?Q?1VzTJNv8X0PbpqRE4k+ah7P+vad4id7ezLhGDdMPXMyuk4Rxq/RPKUHQ0Rzi?=
 =?us-ascii?Q?lKsia3+0cjn/WO6iSXBxUDHX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5f58cd-59c8-4db2-53aa-08d94836fb96
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:52:03.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5fzGrYimQYPSMiHVznvjAgDrWnJIoI+01xGSCS5Prp7ymCiobqxNYCioSQtQmnt6nFhmrXaCwnCeklBjCBGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

V3 changes:
 - i3c: master: svc: add runtime pm support:
   - restore the error path of probe function
   - enable runtime pm just before i3c module reset

V2 changes:
 - align the parameters of the function in the second patch
 - add a new patch to support runtime PM.

Clark Wang (5):
  i3c: master: svc: move module reset behind clk enable
  i3c: master: svc: fix atomic issue
  i3c: master: svc: add support for slave to stop returning data
  i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
  i3c: master: svc: add runtime pm support

 drivers/i3c/master/svc-i3c-master.c | 234 ++++++++++++++++++++++------
 1 file changed, 184 insertions(+), 50 deletions(-)

-- 
2.25.1

