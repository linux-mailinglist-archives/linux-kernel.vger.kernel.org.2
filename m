Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8973D8F37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhG1Ngj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:36:39 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:37728
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236444AbhG1Ngi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfS+TlWLCB/izXtGFF0iedvF26ekTCu50YoWs6ttgsRiqCq4c6Cjd2sTGkSawh2DObewAVymxYSzCz/tvb7bcSmikoCQyxkZxQVqXTeSQ1Af++1jmUP+WhQlmttWRKcIejlVzWjRTnEtKM3JtnOcH0xR7ljtSyUJxzaSU9UIYgi64lV9dOsUElTAtDcAQ5tXgwstGPw83noz9afoZ4rPGQqXTSvdON2nTpLdsAan1k2pvgQrTgMfJqb13jKGajDWLUNYEXwoWeiVfB96H2bWISPH/iyPzWScjLpqlVvfDmLbRDNF/REVDIm2BgF/iznAsKuYG/lBEI7gGN6Tt+7usQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdiu5wdWGcW3ewqNg9m7M9N5rFqo3iJWIca1lZ/2Zew=;
 b=X68LxV+ODn1XN8cDGdnIsBKkTRzuS82quid/DqG6VnsvIGsMt6X/fqtHWlIJJao1ssk9EklyltdUzyOhBXWYYtrbzg7nuwnAEOk0nIGAKT1BNaMcGa1ffvOuH1GTRV06vTl8DaOXWJ5adENW+jgFdPORrxwyIOCLyzg0cwS6yiUWqaJCRegYfQTkBcFvoJ8TmbygNKQ5mvGN7lhnFdYnr1gHzxC+K15zebg6oDsPsdsPhQWDxYsb9gxuLkESdaf9bIXop4MqlDjkpoML+CYV2FcTFfgg597Z1RzmreaOVQojwnsoTyGRSkJ9ZsY69atRz19gPhc0VnrtkqNk1VVRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdiu5wdWGcW3ewqNg9m7M9N5rFqo3iJWIca1lZ/2Zew=;
 b=kYJaZ3bH0dOPzrkm1mk12twMzPf4z7iVKeRTPLwnHlMvlP4IZENGR8Jn7tACmxJ3ALqXsmw9WPLv2ztrZjOhQXQkrk6U+VBcGFJZ5v7m9T5ic6p1NgHi3huMSrF0LtLSqmE77YZR3CeIYYFAFLIaggmpJ85wve3pi36eAANg5dU=
Authentication-Results: inria.fr; dkim=none (message not signed)
 header.d=none;inria.fr; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 13:36:34 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 13:36:34 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     lucas.nussbaum@inria.fr
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [BUG] crypto: ccp: random crashes after kexec on AMD with PSP since commit 97f9ac3d
Date:   Wed, 28 Jul 2021 08:36:13 -0500
Message-Id: <20210728133613.28586-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
References: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0014.namprd02.prod.outlook.com
 (2603:10b6:803:2b::24) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN4PR0201CA0014.namprd02.prod.outlook.com (2603:10b6:803:2b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 13:36:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09fdc45d-4db9-4226-b02b-08d951ccb796
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4573DF6587F0EC27F0F09650E5EA9@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Zz/enjK3tQItxP1a0li5VuTnNV4anLXH2Squwu6P0m96QxEchbHsDYaIDI4Y3AvslcjonrSUUmJSeYJEVnJL5eN5yh1YDxaiagk/kSJ6dIUdFDyqfd4RUjNRDS8Ol/XiC5wKEpsqDYpzYNcmBQ1JFNUa4QIobcVmzycJM4vo4Q96Ecgtw0AvhVtFUfU9Thh/YHu/0cNqEs+g9PuZsC0hxbDMKtilf/vKQDHmMhbMThWjjC0RL6P3WbNmJ+6r+mXSHAy5RgISh7xtBMVnBYxqIYgVzTc7uEMl1L2Ub7Zc6LeicvWZ3g8NeMqPbfAli/exChVlRHkj8VKR7Yl315QnO2C1YGFSz5VwDi+LdOQd7xQoWxyWZl2tzqBs0GjicmM5FYg92HsPUDYoBstT5SQLMkX/wruHoFflvyOqkfZt/pHCQp1dMeQLlRePlt9ybJD/+juk1PjNjtGuGuYt+xfGwLO5L4deBNQ/YcHXn19UhDxbuyokA4Kn4jt9DTjtwLmtrDokVyD6rC6DK8Xf/IEHoGay4ZvcXV/lsGq33hM+sIQaBRCI3hxRh+liK5hvBVXUX9N2kZ+dlmGjZ66EBt4BUuBo09wz3Q23vnKAIviGm0Fy8lGo3ajLBLDbyr66kO6ae6bCFkzDoBMc08ComqkFehJvVIppsRwd1p628m3tU7wR++j1RN8fKDsGrv+CC4CUe/uHAUqilMXMhIWfuNRVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(2616005)(956004)(36756003)(1076003)(478600001)(6486002)(2906002)(6916009)(8676002)(44832011)(8936002)(86362001)(66946007)(4326008)(5660300002)(83380400001)(53546011)(6666004)(26005)(38350700002)(52116002)(7696005)(66476007)(38100700002)(316002)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8PVfNUueh0Za7W+4+zHmjxy3tQGD88PN7dwVfc7ijF8Kq9ZpmL0GNPcg3Y1F?=
 =?us-ascii?Q?O2smOjvl6V/AbHpXg8tbgi71YKIiQs0ysYUW2nNwuXBAlaj8fbbM0WiEjlML?=
 =?us-ascii?Q?hmsiwRI2Yc04dpo1jHY0IBn5lusNngRWzfuZntHZJJERoZiqQx7xRPh3Jr5o?=
 =?us-ascii?Q?HUhZXvdm/CJ7gEAlu6Bk4KH7Kkv/iv1z4Q9frASe7rX8VKIktmmLGnqU3FQV?=
 =?us-ascii?Q?BIjIfWHnQpYJ118kCF30RNYFIF5A2NldPZ6XAbbEKRAzQEnUJvHHYZq8hB1t?=
 =?us-ascii?Q?WY4nuWsERAOLvTM21bqBnUEbidm3x0138cYopnwYi3v8Er3f6RJ4OnlqK3Z5?=
 =?us-ascii?Q?sHdaNMc+ElE4nDocgfHjYdpqfnMdRdoJsnB1VXXhY3om3oSzyd9HFhmyaHUA?=
 =?us-ascii?Q?tmlsfk4fEUDUWhtP+fDjLvOeBWwWj6dmxN7a1wqZh9Gd6f86W1dSY0Ct405B?=
 =?us-ascii?Q?Z0ylpyHqAmy8KdfNsL9Df2ayXA7ud6tmlRrjwUASzQSEjsCFOd48xNiRz8lH?=
 =?us-ascii?Q?811WrguZNkaRJ/X2UDyAVN8WngzN4V9Vi3e6pGxr6RV3KqNrWsqAz9PFolYF?=
 =?us-ascii?Q?jPim+VJOkr5qZ5R4phnj/dWSjOWizcgtXK45jX5Iz2UlSLsa2ZmfyCJRf/V6?=
 =?us-ascii?Q?QobzvB8Vx8h1vS7sMthMUO0EOEKR4MNEsWYfaw5FmS143IumwGnPEPJlRMoM?=
 =?us-ascii?Q?nrAEWtl4J3+G/LtLYN9SGDyNbwWTYXBN7GfJiN9ciIKydhYePUoUYptPqlcx?=
 =?us-ascii?Q?KcYlxLp9Bd0pZbZXFugBbU89GeLAhCqBnxYQMgLi4NNg2UiBwzgRLspUCke3?=
 =?us-ascii?Q?abyu8mu95NTEG7MGq4TKXXaiLWFPlGn7/ZWtt/SAJ0FtgSTkmbSYrjxcaMv/?=
 =?us-ascii?Q?wKw23o6o9pZ+4WGmrSUmstla/9YPPtwWrzOgtqBnQs1V0eLHZH8tv8nwlZE3?=
 =?us-ascii?Q?bCoMbNwamAqo6thel48bh8nsmz4j5nrLGHqWtv+fuN8QHaLIj89ZcInmh/U8?=
 =?us-ascii?Q?w/t9CxbzVvEQ6cfEq+594qbZNdKaMvAJNvj3RnG7tYTMTo+vzwaw3LKYsGrz?=
 =?us-ascii?Q?oGiZTJirLOUS7gPi/I2jLfDUf4/ERAwsjAjEO3yuAOkA2573sAq09CT6aJeh?=
 =?us-ascii?Q?q9uIHjZykQ4vBc5qHMcuoSf09BGqiCy20Vsfinb03kww1thjKQT6nqD+DO1M?=
 =?us-ascii?Q?YT6/hN55sw1s3r2jWePyR3hkRSm2Fi/Ru5dT9WO/UtsvJZLPxaWRf1X01fJE?=
 =?us-ascii?Q?RiPyykBPBfkIgBq/nmMjj41VQ8Rt0U2utYimSMZNhPczIhmgEbbIFfVoRx18?=
 =?us-ascii?Q?X1TEKHp0svawrc0n2i/Vf6qm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fdc45d-4db9-4226-b02b-08d951ccb796
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 13:36:34.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k+GmdeizBKS2ILo3m5KgZJKDphanY9oI5a7j07CCNKrr50yeyxwXsE/Mq215rMIw4kPd4LLZStrtjiIK1narQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

>On several AMD systems, we see random crashes after kexec, during the
>boot of the new system (typically 1 out of 5 boots ends up with a
>crash).

>According to git bisect, the regression was introduced by commit
>97f9ac3d ("crypto: ccp - Add support for SEV-ES to the PSP driver"),
>included since 5.8-rc1. 5.14-rc3 is still affected.

Can you try the below patch and confirm whether it fixes the random
crashes seen during the kexec.

From: Brijesh Singh <brijesh.singh@amd.com>
Date: Tue, 27 Jul 2021 21:48:25 -0500
Subject: [PATCH] crypto: ccp: shutdown SEV firmware on kexec

The commit 97f9ac3db6612 ("crypto: ccp - Add support for SEV-ES to the
PSP driver") added support to allocate Trusted Memory Region (TMR) that
is used during the SEV-ES firmware initialization. The TMR memory region
is locked by the firmware and access to it is disallowed by the x86
software. The firmware SHUTDOWN command can be used to unlock the TMR.

Fixes: 97f9ac3db6612 ("crypto: ccp - Add support for SEV-ES to the PSP driver")
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 49 +++++++++++++++++-------------------
 drivers/crypto/ccp/sp-pci.c  | 12 +++++++++
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 91808402e0bf..2ecb0e1f65d8 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -300,6 +300,9 @@ static int __sev_platform_shutdown_locked(int *error)
 	struct sev_device *sev = psp_master->sev_data;
 	int ret;
 
+	if (sev->state == SEV_STATE_UNINIT)
+		return 0;
+
 	ret = __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);
 	if (ret)
 		return ret;
@@ -1019,6 +1022,20 @@ int sev_dev_init(struct psp_device *psp)
 	return ret;
 }
 
+static void sev_firmware_shutdown(struct sev_device *sev)
+{
+	sev_platform_shutdown(NULL);
+
+	if (sev_es_tmr) {
+		/* The TMR area was encrypted, flush it from the cache */
+		wbinvd_on_all_cpus();
+
+		free_pages((unsigned long)sev_es_tmr,
+			   get_order(SEV_ES_TMR_SIZE));
+		sev_es_tmr = NULL;
+	}
+}
+
 void sev_dev_destroy(struct psp_device *psp)
 {
 	struct sev_device *sev = psp->sev_data;
@@ -1026,6 +1043,8 @@ void sev_dev_destroy(struct psp_device *psp)
 	if (!sev)
 		return;
 
+	sev_firmware_shutdown(sev);
+
 	if (sev->misc)
 		kref_put(&misc_dev->refcount, sev_exit);
 
@@ -1056,21 +1075,6 @@ void sev_pci_init(void)
 	if (sev_get_api_version())
 		goto err;
 
-	/*
-	 * If platform is not in UNINIT state then firmware upgrade and/or
-	 * platform INIT command will fail. These command require UNINIT state.
-	 *
-	 * In a normal boot we should never run into case where the firmware
-	 * is not in UNINIT state on boot. But in case of kexec boot, a reboot
-	 * may not go through a typical shutdown sequence and may leave the
-	 * firmware in INIT or WORKING state.
-	 */
-
-	if (sev->state != SEV_STATE_UNINIT) {
-		sev_platform_shutdown(NULL);
-		sev->state = SEV_STATE_UNINIT;
-	}
-
 	if (sev_version_greater_or_equal(0, 15) &&
 	    sev_update_firmware(sev->dev) == 0)
 		sev_get_api_version();
@@ -1115,17 +1119,10 @@ void sev_pci_init(void)
 
 void sev_pci_exit(void)
 {
-	if (!psp_master->sev_data)
-		return;
-
-	sev_platform_shutdown(NULL);
+	struct sev_device *sev = psp_master->sev_data;
 
-	if (sev_es_tmr) {
-		/* The TMR area was encrypted, flush it from the cache */
-		wbinvd_on_all_cpus();
+	if (!sev)
+		return;
 
-		free_pages((unsigned long)sev_es_tmr,
-			   get_order(SEV_ES_TMR_SIZE));
-		sev_es_tmr = NULL;
-	}
+	sev_firmware_shutdown(sev);
 }
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 6fb6ba35f89d..9bcc1884c06a 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -241,6 +241,17 @@ static int sp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
+static void sp_pci_shutdown(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_device *sp = dev_get_drvdata(dev);
+
+	if (!sp)
+		return;
+
+	sp_destroy(sp);
+}
+
 static void sp_pci_remove(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -371,6 +382,7 @@ static struct pci_driver sp_pci_driver = {
 	.id_table = sp_pci_table,
 	.probe = sp_pci_probe,
 	.remove = sp_pci_remove,
+	.shutdown = sp_pci_shutdown,
 	.driver.pm = &sp_pci_pm_ops,
 };
 
-- 
2.17.1

