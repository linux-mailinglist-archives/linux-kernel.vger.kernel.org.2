Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9444544A7CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbhKIHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:49:25 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:58982 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243678AbhKIHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:49:24 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A97Vg87006759;
        Tue, 9 Nov 2021 07:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=ekXFfPOMFgQ1u9An4Fjc/VePV7ZRIEuxfx+ch/nTTh0=;
 b=Wd2yStdoqUaHyLdo2p6Z1c5A9O887DboE1429k+bLw2qMNpCTdFOogDzo8Ibkbjzs71V
 CZEMbZtJ9x1HaApXBHQmdfdqVAOqvwa6l32AjBCk1MlES9CU7xopIMz4THE6wVTtdlwM
 374q0L4d/+y9RPYn1h49ykF/zW2K3Nm1MNytTnGbscwTX2ME6I73DNpmQf4Ko/dBtT0K
 MsoMeSS1Te/2HFEBveeCPzBkhP6meRJnE0QL2J77BGlvfikB0UuR4bvbVycPx6zvibdE
 MrSPtsoWhq36f28D8jhARsuRMbXhRc3+fwHlUhgWgHW58D3GeXzH4H8XZ3mycUJ7S0Qc tg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c6rqah9h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 07:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7VZ+QEbzOnNdEpPKAaksc/8kuzwbo0mF7IvgVdm+M6nOkrtkQmc3LLIgcSJhY1Z3NuWbKg9XfE2A2PH5t72e9IjTvUMrC/nt4vkYEjY9n1MaX2ZBsldeu0lqCWmAJ/1GWNwcn0irT4FLKBoFp3wjRqua2h7+3KzB+XMGwsp6ZQIoMaDLTl4/lGx34jiD8loPFXud10BHQE8iIQPnZFNumvkSvs0UIpOnzVSE966Le2mQ9Qi6vf6bEuxr2iufEBYGl/29fzuc6oGn0UPGmSZBv5ozNrJvBZBJ9lkLeyfmW6Ly3r3Ha0GBxDkqSL9GsKPrNl4z+q6AbJB/5dEI+5V3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekXFfPOMFgQ1u9An4Fjc/VePV7ZRIEuxfx+ch/nTTh0=;
 b=SNB5Z4MxmypTNQ8k74c2SpU+OWkghHmM0Ui//AKb1gKXokP8TtEqWw1wZntPi3NUN0dC3Sf4JP19lc92hXtBD6j+wQDJm5p3yKQ8bv+D51So4UAKGbfQ/8zMB53LGKREu8QyZJtkZXOKumlKFxJ5yZc8xt0+6QxD3rgMJ98GTNVnJf76/MfAgmI5D07gq7tN1PyNI0L/uPsqKdF8WKS3XAj4GsDlg6fkCyKBr0e/+keyWT7cHRmn+xKZU9PZZlgirOmcgxio2qZbzvaXwr0TdkwRINQb2Hz6+kXEBSYtVUMvD4pEQ6NDyGnwxj2CnzRc4nUn6zm21dNJbujEOpxeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 07:46:30 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:46:30 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     dinguyen@kernel.org, gregkh@linuxfoundation.org,
        richard.gong@intel.com, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] driver: firmware: stratix10-svc: schedule thread out when there is no data reveived
Date:   Tue,  9 Nov 2021 15:46:13 +0800
Message-Id: <20211109074613.13994-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.1 via Frontend Transport; Tue, 9 Nov 2021 07:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07b51a44-0f10-451d-4c53-08d9a3550ad1
X-MS-TrafficTypeDiagnostic: PH0PR11MB4791:
X-Microsoft-Antispam-PRVS: <PH0PR11MB479161F627300BE6472FECFDF1929@PH0PR11MB4791.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd5OYH4tDM5QrsgDgS2k+T+9xR7x3akUfz3A2OgrPTCPPGONDxUJSVLmiffBvFMAqUMeAGQCb0sn+PZiRu4kcbMfywKBZqGpbBob+/ZKsSDphV8YGX1mEUhaz752V5L+O72RsjddYGyESuUbw8NPpQ5kyWfp/9Co8frxiz56jxaRPbPEQ0dS35NIP3rgRRfzge6SpILQXHlg7yxbojgo+fa7HkD5yjs4lbkFGN/Z2RYW6EEBPPC4N6bEaKH2NeizxAY7HnyQgta6LRsekdodjG/db7vq4aAyG2G22rJTV5gcr6H5XdBX/lc1B9gDGdDZHV/CFK4ISVUDyq4rBN/HAzI06M+m6C6V/JSFPkp2VI9HrLO/bxVKD3YQCwHIoRzto1JFwGOUdiEfJ9LNjbFv1Oqh8wDjxvoM5eZifm7l4d3qPpL+HZrzCwoOqTOmXPMwJ7Z98ClOMq5ZnbK8qxU4w4N/XCg6hHiMpkKhAmYUdFX2YutyYOGCqGns7w2rBbM0dnsbrqjEkV5M2/CMQ5IdChhTQGSeZvdlFFCB8IbVYEFASX+o6jvDziPe2vk3tzdnIE1vNuJYa1NibiDOfM7hz89pTzdLhAP4AwdPZ51+PcSiwPkYPSeyHgkVISTGLYF9EnT8R9HDIZ4/Vf0wm8X4gVR5PzgVR/Y7Lev+T2RqXXibrC6+swfHOxcR+P/EzPSoI+Ewerrk21LRRnpLOdolCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(26005)(86362001)(66946007)(66476007)(6512007)(2906002)(1076003)(6506007)(186003)(6486002)(956004)(2616005)(36756003)(6666004)(4326008)(8936002)(508600001)(107886003)(316002)(5660300002)(38350700002)(52116002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LgBKHtwSUTqVi3HJWl1RV4WfGXdClXcAr9LqNvYcqKzND/9eoaIzRSYtkUtc?=
 =?us-ascii?Q?2f1gRowP4zq5Q3AEJ6ue0lZ9IAQWOijSYiDTmbIaYw/2Kr0QTtcASaSp7TSe?=
 =?us-ascii?Q?oM59SLTFRDY3CBOPq4XBUp5lwiOXUxGp9d+8xlwq2dSmJkb0Se041xh1AAPH?=
 =?us-ascii?Q?tYHF05Jc17Tc9gmBlm9oCDPY8PPzxhWzFbm6253Qf9ugpUoc0fQ4tS/rB1RJ?=
 =?us-ascii?Q?KLifE2QKX9YasFe/z1+W8B1efd9Zobe3IPkzRGJG/HXmWqgDHSLjx4NWKQLD?=
 =?us-ascii?Q?oNVKoslSEZAeNS0n0ksH2EgvO7BZTNjbkxM19KJuiCkRTUwDV61s22JnLSG/?=
 =?us-ascii?Q?tbSxWwyr7y7SyVp0mf7uVKq6jdIotS4b2L6VJXf/P6AraCLjelIiEqHvVcQs?=
 =?us-ascii?Q?Wjl/B0CEwd9x9Zf/vc60QDvx6i9FNpZ9iW5SSla1ulDFtlts5NO2EArpRhkO?=
 =?us-ascii?Q?+nTZex8lkwxSxit8pfTmoVeVh3+IDyjNLyxIWEgqSKfO32gUdmP11j2rbJwG?=
 =?us-ascii?Q?ORY1PdYp9crHVRgAhn7fr/qDC523EE0Kh+xDNhZP3oDyxp/9qtARfh2UHEr2?=
 =?us-ascii?Q?X+yEcDcTQDIVLdc/hhqTw8pALVUYkO0GXlBYv+gnhwLb+AS7rrvIBZGW2U5h?=
 =?us-ascii?Q?bpnAqxo0J3ayewV3M6db+q3hNK4GH2kIHnCM8KjUJU8X10nIMchPBPoIeIfj?=
 =?us-ascii?Q?rDXXlhgHHvSFF4K1OjPPfSAkNiS/SO+TndomDy8yjXmFky3RqL68fglaZrfi?=
 =?us-ascii?Q?v4AXFAlLOcSF3dBk99zCMkq/JcDT4fnAUgLu7rs25DJFtXBneEdx9fBkWGbL?=
 =?us-ascii?Q?Dtzo+r+IKU2+f7yJ6Ui921qk7WVpOf8BrEXHs86aMW1ObCXdZu7At2CF1Vof?=
 =?us-ascii?Q?z5GfMpc5RAnPk5DAmlQgAleQFiMDSZbU+Fb4rjs3mVeGiUNoiYshoYwEtipj?=
 =?us-ascii?Q?Z03dM4DhLrR6vNGwuXmD3OnuT30CVhy1RiGD5AiqPqcNNinblWv3rPP/lrnO?=
 =?us-ascii?Q?O9Yn3YZ8s1IPsXrDnad5UFA6049SSqzeiSlBMXq4Wi05K1WGl6fRWMlJ8IV1?=
 =?us-ascii?Q?Bm3wKuTGiWpIZfBdo3ZfeFV3OO/n7vMfDXt4j5StONm4zjO00msjV5IkkhHw?=
 =?us-ascii?Q?K5KcHaRWSMbzdyBqvWyqkOzxJ1jp8Tg4gGnVmAE4qQOLMDuyAI2Xc06/EIwD?=
 =?us-ascii?Q?iPhN/5qUwFil3nDQUyk+RwKABahaYKpAWhH0gCEkeVYZeZEvg4UCQCDfHJeL?=
 =?us-ascii?Q?f/owfkGvyNJIFmWrFX8G+xtcPttcGcWr2IozIPbPVh7D51e5/mwyzLe+cMve?=
 =?us-ascii?Q?tX/jvT9O4qSs1t0bZDNfFuLAtYNrUONJMNrIFnJEmNb82aS2oon4aBgbxHif?=
 =?us-ascii?Q?W5WFtYu/57VU38se5pfbsJE2AbqnVc4W0R0dg18yLg8S7fUZKDJoZHr1KFzc?=
 =?us-ascii?Q?kMeZH8dfIsQsKrA+kPeYDBVDNVBtFpXOiu4zzh6jn1jOuj0LGbdJQkVl5T/+?=
 =?us-ascii?Q?X7P/gelzt6/s2ZFqd2FOpxx6Ayz+wwRdWWJflprs34foR4g0hS0MDPg9/Uo+?=
 =?us-ascii?Q?8W5wclVILItTjwbzWMAQ3wyQiBmxXlAtakfRntQwQ4OXizFMdt/eQVgN0TPD?=
 =?us-ascii?Q?IHfAv/hUAYbzM/jSCus27zE=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b51a44-0f10-451d-4c53-08d9a3550ad1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:46:30.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90Mgyr8AG7Si6oOUBQV0ywOLZsRsjOC6pFtoHFxvvjUO1oLCQnatqqZAMj7opAxPUxVNrdopcSvfPhQwZn9SmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-Proofpoint-ORIG-GUID: syvk4JNkUbMKm6DD_krSN6oVIuPFsCjm
X-Proofpoint-GUID: syvk4JNkUbMKm6DD_krSN6oVIuPFsCjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111090045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Li <meng.li@windriver.com>

In thread svc_normal_to_secure_thread(), function kfifo_out_spinlocked()
always return, so this thread can't release cpu even if there is no data
received, and cause cpu is under heave load status. System performance
is poor.

This issue is introduced by commit 7ca5ce896524("firmware: add Intel
Stratix10 service layer driver")

Therefore, schedule this thread out when there is no data reveived, and
wake it up after sending data to it.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/firmware/stratix10-svc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2a7687911c09..ddb86d441726 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -365,8 +365,10 @@ static int svc_normal_to_secure_thread(void *data)
 						pdata, sizeof(*pdata),
 						&ctrl->svc_fifo_lock);
 
-		if (!ret_fifo)
+		if (!ret_fifo) {
+			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
 			continue;
+		}
 
 		pr_debug("get from FIFO pa=0x%016x, command=%u, size=%u\n",
 			 (unsigned int)pdata->paddr, pdata->command,
@@ -861,6 +863,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	ret = kfifo_in_spinlocked(&chan->ctrl->svc_fifo, p_data,
 				  sizeof(*p_data),
 				  &chan->ctrl->svc_fifo_lock);
+	wake_up_process(chan->ctrl->task);
 
 	kfree(p_data);
 
-- 
2.17.1

