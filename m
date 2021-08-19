Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3393F1D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhHSQGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:06:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18532 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238750AbhHSQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:06:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JG2A9B002028;
        Thu, 19 Aug 2021 16:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aJdeps0gv5QR7iqwNWIc3mvYCCR55m/AB6mUgWkOmzs=;
 b=aBRWdT/vMp4l9mUD+xUgR5PuU6j7bwFVrMVsa/8CmzrsPBrSJzqVPlYJpvlEXlc7le48
 SrkdFHhBwMPZbTeomrXvSzyL6lR3TNt3Lqoj9KV6qmviHlzz9RctaH8m/MBxeodPyOCT
 jGHUBwcrVR/o/8dAqR8dWon6Yvw8SPDJKAKvjQcwRiYk1hXKfRUgEl2TzWpi960FDSVY
 h473px6huGWjQB6ntlQDykMJ4ZLESOaergtVVUfaBrDx3MskuMHhiJ71/NyGGrTo+rnr
 I1ZV6Ml6kTs0AFc5CXNtOKxV2Om1fqGnQBmeMZsdbTeSes7i4im0FSZEA8JmSt1R9hkv HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=aJdeps0gv5QR7iqwNWIc3mvYCCR55m/AB6mUgWkOmzs=;
 b=JeQVyF40CPZlu9WP6XUtX7G5J9cSXW1mmDLqiNqtE7xF2wzNTiLxDZe3xu7F8zWbE+AG
 j7JKybAIYZcsQqeBcO+6EPIY5o/nP2XgWJA+UREZ069JOeLYblTtFXuhbBG+Dlau79G5
 Nn+Y3LRxM2YShMHLwmD4D4a5fho+nM3jNkD/RJ7XiOR2exXyd+Rgq46B/BmWv/75t7e7
 QxNF409YABLPZ560Os932QMp5Cl08hOkh7b8bkeeBn+sMugfYUneJGlgr/XbPhgnyqQy
 Eo42n5C5uvD2BuGPfEGXZcAFrLMIe7JIAxANWD04k2lUV2qY2Bb22G7SBvNAU0myUu1k CQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs40g8tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 16:05:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JG1Aw4103219;
        Thu, 19 Aug 2021 16:05:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 3ae2y4p26t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 16:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJK8cvaGfVPL/bp6xpxuHyvgD2M97fzopgpuv1n0QVZZBzeYATxMhLMWLL5xwM9GKxng3pR9m2L0VQsMnSUh2DHWXBPG8M4ZTT259zlrKnRw7ZLqh1vN2iiyaDZ2OoBhwqxIcFFbMBZi2YlxdiBMyEzZrbgxXfd5TvPwOgzZQpSnSQ79gwKmAFRIVCQuUr7rWOecfoCAP1H5idCwGKiuHQgKCQOSrw9Pw26XRNZaH2WZjyOT9AKqLTKhz32WSOP8R7Paly9u3yUc8HMDcDXICRn2Iqag8MUeNI5pZV9yVdo7HzoyzQMO+T9TeMu9d08fYt3FVMZiCJgk85m7nwfHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJdeps0gv5QR7iqwNWIc3mvYCCR55m/AB6mUgWkOmzs=;
 b=Zdt64XLHKWkWbkGfuUn2mBAMm7u2/BQ9dV3Np6G5DIwh7bCen+JJ2/3E2rO6cUyM7v5IMlvy6xzbpQHbrxfKZKh6wjD8/eSXmE75pSGPG5nSijOI+VKMEbjGKhlTUM6zRWORfwLfDcE+xn7D1hMPgGjEnGnHX55YACxOFuhRPJ5pdTmBw72uFR0dnyYj12u75j5oDdb1wNDzmPsd4YxE+VqoFOb1zlRqOlTb/s0No4hbJEMGUKwSgMhqeH8zsuB7zBgsL5ysewZ59JjEcrxksr0hMcALBX2et1DcB1/kSyoSafl4zuirT9NbRzg/OcxFRqlThXjgVPJI5zXTiUKBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJdeps0gv5QR7iqwNWIc3mvYCCR55m/AB6mUgWkOmzs=;
 b=r8yE77lPsLu2n/RxiKF/ilBNy7lmpPre0OBZWzNmoIPHqPGk/Tt208Vq40Co8Ls8DpwBhZWw3PRUXe8nsfgxLTiPVxJP/sIy5rb1eiBLMGGjSLtGHyX83XI3AO04gJs9ICA29reSXcR/K5RKT2MOTzr/nAi4Bfjwf+o63RN8Gq4=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2063.namprd10.prod.outlook.com
 (2603:10b6:301:34::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Thu, 19 Aug
 2021 16:05:16 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 16:05:16 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        mihai.carabas@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] misc/pvpanic: fix set driver data
Date:   Thu, 19 Aug 2021 18:12:26 +0300
Message-Id: <1629385946-4584-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629385946-4584-1-git-send-email-mihai.carabas@oracle.com>
References: <1629385946-4584-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:805:ca::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SN6PR16CA0041.namprd16.prod.outlook.com (2603:10b6:805:ca::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 16:05:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85684aca-c621-4f1b-8008-08d9632b228d
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2063CD942373B3F37DF8DE8E88C09@MWHPR1001MB2063.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLOmGpWybudqVi1dBVZB2cAQEan+UdSH0jgy0SP59rq1af63iM9wIm5ls+4Dh/WmXynPPPu24sWCAa8GEAfvpXkrMU86jy16EM1SAzGTOBok6T6jWev/LhWfd0ioEsqazU7HP1Bex/kHnP2HsAmU5fQ+Dr9BEdUWO7khVMtfO/yFX5GbAHMWZHl1Q/mslEqBF+jKi+qyE5rffZWpVsNkhUEd+GZpt1WX1zE96YRHgXtAihGLM/SmDGVP9+j2i1PPRX82NasBlK/iZCRUccXSuJuC2grNI5f+o0sobxTq0BXLlpr3UEDmvZKZiYgl3sTSwpcgJmKvFpEsB1Z3+DAWOt2snyYv3BhnoDo8aKOLdtxX+K/P4mHVbGE8bXg3nl8RAtrIx52iKOfYKOLwhOqCE1uEDXJ9D6SAK06rbpz22Urho1ix5OjT0Af8Js3S87rWw3M2etRk0SIzHlF8LqG5A9HaYwPclnecR47c8XiIBk20NRvnL09g25cMtS7OyO1yDrpxDGnGYkgYiw0wPIhOzTzd7O5zspzBuBft9FU249TBMNs2TESa4i4/OT+P5frhuToR+DLA0ePIol4jC9o+aI76FX4U9x9oL5fdAZIQVqzeMM3Pz370F0T/n+2JZy2nOamX0AmSMfpDK9ge5d53ybc15e29S+fS+U7OO3NJzm7InLog+CCHRt/PoaPyETjs9tRZAigmYgieVVaDAR/lEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(36756003)(6512007)(38100700002)(52116002)(44832011)(26005)(6486002)(2906002)(6506007)(8676002)(83380400001)(186003)(956004)(86362001)(2616005)(6666004)(38350700002)(66476007)(66946007)(66556008)(4744005)(478600001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75c4UPyMwQLRrZDbhdawQkshrfA6ylUfMPXY47BDEgp40c1XQgGsP6Bh2R1H?=
 =?us-ascii?Q?xHw2HY7HLEsiHLKqDc6HrjNDweyYUHnJ76QmR542fNKeJlVQGVi5BtZJMl7T?=
 =?us-ascii?Q?J/RfCSb8Qu/q8t+Rb9gckYYRFBelUHym97MO7nQ7G0wMHd09WyqXEsfaUfmC?=
 =?us-ascii?Q?xJa3Xt5rGmbJ7+85Lp5STFPdpzSKlFaojWTFBs+bOiSzHBptj3XzlcfL7rXR?=
 =?us-ascii?Q?XQii4ZaOiD4eah9/86/posPI2k25yojt+kqQS8aa0qrXdvpg3GA2CdHFZ1DJ?=
 =?us-ascii?Q?ElvISLf/fTmnaonDJoQTHCuy5Bl/+My1lFN7iNZgjlfEmKfy6Ep7KUX7WPSy?=
 =?us-ascii?Q?a4dKOBMFpdzcWvllZH7slzzy7o4gwzFAxxryxXPO00jxNMfqN8ATNqHjGIZ9?=
 =?us-ascii?Q?dlOHuehT/y9xIj+dr0U2Rw+PBBOfG9rjaQxuGei1O+QurhoxGJnv9dywKAum?=
 =?us-ascii?Q?jVsZ17giN9ZqullUGA4RpLHrRSsMX5L+CeeVnHbZTFabvaQefmcpPBfljkjG?=
 =?us-ascii?Q?QtHz60auQ3nAz5jN9iSbEPRyFVfDaHhOBMdnhmhkAoI5bD0lGTiEuO1ihUr3?=
 =?us-ascii?Q?SlBwwdySx2DxHfSdl2wfMoFRBWCi7gRAW2jMqTTqeYzWRnpjbzsyk7ttl8ij?=
 =?us-ascii?Q?AsHRSzzvIO7W2Jfl/9zttjp/kU+pXKXm1BpX8vXxjhAhZbkJUYBBQVmhpEtF?=
 =?us-ascii?Q?rZ5xHtmi98RI9q7ZvzRfuicLbrR0CLjen2oktVIT8TVOA1Wly/yvu8yi87pb?=
 =?us-ascii?Q?U6LhU5Cf3riSCDzT6dFE9WTM6VUBv7jFAvvkDamcGNlBrhab67dtYuKPfYco?=
 =?us-ascii?Q?Fs8HwphFneNkv7tFzkEPKBYJoMMD2mNL7Om4OwYyXkJ7RsPStQ4S+6tAx+7d?=
 =?us-ascii?Q?3NyEphydV1WeNLaxBTs4UpN4qoOYgQ3qwsk+qDCKCCeD6bBk+PYqgyjAExQv?=
 =?us-ascii?Q?T0S0gMpuSMJ7kHWXkXNNflyE/7Yr7vhRDW+zu2q6cRtc2CqJkVr3pWxjozGS?=
 =?us-ascii?Q?ruBmjUtC9Y3gUnRFbtWPgVYGqK86KRc9V36/z5jfuyhMlG/NcuwR0nNNK9TJ?=
 =?us-ascii?Q?fdzv96xbJyb8uTmjk6cxk/QAyeWYlyVyNNMo2tqhAwvnNFSs8nTQ5gdhQiOu?=
 =?us-ascii?Q?u4hG6yXl2cu2FeOXvwkZLAUGujVL/5rdsqCSslSNRmyqWJ4GW+0p71Ic6qRm?=
 =?us-ascii?Q?l/nVYbBUcbxZnQ3zKymmgjqEx/dnSgzteJcgybt4xZH2bLtf27m46V/tAMfU?=
 =?us-ascii?Q?LijrPyYA9M8x2aTwv1CyXnQjB5L+UMxUHgq1CtYjkjD8xV1hPT0CLMjw75Xv?=
 =?us-ascii?Q?e23xd43OwCTLSiee1uInaDTa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85684aca-c621-4f1b-8008-08d9632b228d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 16:05:16.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3pYHpb3uyvC/84nsQpc/hLukQ8ODKeIl8GbTrFJDS0vbfsLUif+JaSq8Pzg/VYRwvERpxRoBbALxZUusLwYIzJxMH5xf/ZCiwsiBf+GZ+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2063
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190094
X-Proofpoint-GUID: s9gwh8xRcSRB3_KmULQn6XbVZpKHRD0d
X-Proofpoint-ORIG-GUID: s9gwh8xRcSRB3_KmULQn6XbVZpKHRD0d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add again dev_set_drvdata(), but this time in devm_pvpanic_probe(), in order
for dev_get_drvdata() to not return NULL.

Fixes: 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic/pvpanic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 02b807c..bb7aa63 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -85,6 +85,8 @@ int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
 	list_add(&pi->list, &pvpanic_list);
 	spin_unlock(&pvpanic_lock);
 
+	dev_set_drvdata(dev, pi);
+
 	return devm_add_action_or_reset(dev, pvpanic_remove, pi);
 }
 EXPORT_SYMBOL_GPL(devm_pvpanic_probe);
-- 
1.8.3.1

