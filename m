Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9093A3FD2D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhIAFUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:20:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58470 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhIAFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:20:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VNafFU006741;
        Wed, 1 Sep 2021 05:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YTLdhZpTEPXfQVAPWRWt3ycKgILjwKYkoj2+QNEDZiw=;
 b=A/1DIT8F/qvC+zMI1PZO1vTNVAtS1LXNRCbBAkX8jhS9uUkyoQPOc4bQiFmjR4KdSE23
 +Qx0RZolEK5iSKlbDfWMYn4U9Kbb2I/r0QIaWfBIZN/1t0+l2fZ/2uLyqxwTRk2qE0X/
 DZSdpu6cBODjRsM9nM+Iz96PoAxDBJEZgsZfLh80q5chV3e0hlP/aRnp8kSIFK7Y3HHN
 qvpCJboUcBsX1DUHR/8LRXQeNA8+co8cjBZQRiRT29Smavwdt+sz/oXrFVn1pqErMRRe
 m0vSzEFGvKPvwU3wxulTVjqEWjySFE9Hq81NSXXin0GaRfjc5sZcmq2GZ9umUgw02bf5 Pw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=YTLdhZpTEPXfQVAPWRWt3ycKgILjwKYkoj2+QNEDZiw=;
 b=ElTQ3cvryvxdAkXM9pHEN0KTpJLeoCBRBvcp6UvtxPQ2WrwBeyFgK7HdYhCDMe34EZJS
 CK8mSXcpqfrrKw4/PsCe6uAcjn2CbacJ3Bb9aVPwyFoum71aJG4pyHptw11ZF2lTaiPU
 6OlBoQ5BsGFH2AsEwC/dexl8fexUgigz67ZiK1ABdFFtqFSZQPz6+LFdxx4xDflMn3EP
 gbh/UlpJfABiENDlaq+j5KnEj0KaToHM4HDptxm0WvBxZvhbrr2cmPE7oYGbvFt+B9DB
 CTHb2Mb2ofCSmCDVJ8+iG8ZLhhTMVRHUG9m79RP8ExI1C9YXs12tuc8z0tK/u7P99jZJ PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1ueh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 05:19:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1815ARFa167343;
        Wed, 1 Sep 2021 05:19:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3arpf5s5tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 05:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgsmPxN8aCEH6GTKFOFYLsx2+xSPnKpHWwG47Q58lQOwHiNOUXI9vSNaafqQYmsbih0T5XUtwwa/Osbduz7n7sZCUaRnSbjLHhrBXL2e5EoXsKrT2w5dRomOxuMhANrAUkeanVsELIHtFvm9JfgB9jauzkqPYkXnJya2ZHqehhfFOr6XJBZhQH7ZpJ/Qi9l8mEfmVerpyy3FgiTziPIpLtFi5Ql6YrL9rsFMZMbhm7nNO3pi4tbbKIyHKrGHsbge7Pm07rFte5mW48IQAAP09mHq7dsatCiWtr14MazS7SecrHryRdR0saNQqDd6rW7PatiGP+3fmFo3J3SwPFkehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTLdhZpTEPXfQVAPWRWt3ycKgILjwKYkoj2+QNEDZiw=;
 b=b2FOdyU4pPP3MbvJbFg5lYyOpGalr2bw5rs1p+7A1jFG/BH5bKOuPCKbF5oh+R5+a3c86RVm75yzKn3m0qu4xIeLQiWwgWy4+dj7VTqSCKtkIV3Q64LPxc6HAnrxbv50k4KCXHhi+ot1IE+h4KZilQAZcoTO6FKVsITTuWzYMniuDMqXCx7MGdSMIx9/CYYS5XKwM6lCNkMn3JXsk4tq/yJZh/gcXC9v/pFV2+frIVUvBu933cbOQ7lAy5qq8TAhvwvQhem7YEs/OaPseqFjFMxIeZGNlInsATu66OWvLk9Oa1/FHiJqjLZsbKD4kdHCGxScbWxUkYnPHE+JqNoUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTLdhZpTEPXfQVAPWRWt3ycKgILjwKYkoj2+QNEDZiw=;
 b=vb9012p0uo8x6UUBtd4qOE+nJka3/pHYSMskrVTmkaZDgIv2NdWtcqKTY2J2vBq34CfZWZykM1Lf6Dtn8kQCrEv3iG27594W9WU/9XeL9dGcWysW9Rawn1rGF3CLdSnc6cwYoor48d3/zp7q1jsWxRlLxhRAYa9mLRwvj1wJMn8=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 05:19:27 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:19:27 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     geert@linux-m68k.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] lib, stackdepot: check stackdepot handle before accessing slabs
Date:   Wed,  1 Sep 2021 15:19:12 +1000
Message-Id: <20210901051914.971603-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (110.33.47.182) by SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Wed, 1 Sep 2021 05:19:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9908c8ed-c396-46ec-f531-08d96d081167
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-Microsoft-Antispam-PRVS: <CO1PR10MB469152CF347BC48B91BDB8ACB0CD9@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUALHckUUk2ZOi3Jyk6YPkMlY9IntfbCgYOtVDMdKkRlb3crAcKz1RGzugPL+fl7RwM+QCH8dc13lnWPi5WtoYpfg/9g3Oj/kFYm+MvkCvocFsLwrg1OkbN63JdkPO/h5G6B3HawRIxA3+YSCMMNimFx0T3+gTMCF2i4CCHHkLuDTFWmtQRgrvz2lpLCGe208jDwtSowLTqHmARgn0+rDoMjOAQHzcvp4sRx57JxE3gTHxlNpvB+yrWH/GKx1JSTTCsDn61ZR4zLrGq2ysncRu11BY+ftQaXK0ZcGi7aHYs4+4W52UqnwUap+L50SX37juohcNvDWB+fJdKvRaXphTp+kY/YKUEgarZm0UxtKDxr36rsTMOo5e+5QbAbBoe40r99KpPmwczYUix+BMGeAnWgNGJW0/drs+iXxzmaby4IQe72Ky5WOywfdL3obKnKY2WufeauVU+ofaOIpRgRhTxQvhM1+zN7fWrXwG1znJJtNNb1TPPyJd4HMduIQjEAX6lbRTQ50J0m/7qEm/ufEUnZOco5rbP8T9+gg/5ciIgbqW0BkPr/07Sa1EuCKA10YRktvxAVkY+UMW4gOzAc49WtDCH4x0dBY6JfA4PnAlvdEhi7o6daSGG86HFYG0hMNAJO8Zl0PrYYm37R/jpoHVa7jdA7VG8MwycmeArQEmm6D1gfb/A3pFiVGwe9KHKTjJqo+wtVOi45CGDPrlVq1+v2/sQDkZiXZytfLo/TS3LvHiHtW2wzAb1TjC3rIjLtbW6iHF5pmemBA0BEbhmNYVgz3woSOjYxtLhFqTxq9wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38350700002)(66476007)(66556008)(36756003)(86362001)(186003)(5660300002)(2906002)(508600001)(1076003)(6512007)(956004)(4744005)(6666004)(8936002)(83380400001)(316002)(2616005)(4326008)(52116002)(26005)(6506007)(66946007)(966005)(6486002)(103116003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kEZilYN3SqQ5SGPLZLP6JTAyZlJ3oVOSNDchfvcAzyCfZ7iNIp8v5MqPPc4/?=
 =?us-ascii?Q?isfAhM9j5pOMnwc75UQn50fw+1x+68qXl6n8u3VJ/3oX+0ZRSxRbxBjRm2k7?=
 =?us-ascii?Q?fcMg2J7xVncNXYtwtPYD0q4y0NSR9NBfWwt9t+qUHw7EY3vglfC5+ANXr4Jp?=
 =?us-ascii?Q?E4i3Af6E529bXe4ESPjqY22mCVyLSMNTck2lZrq31Q6Y4H6qUvqJAnZHQxml?=
 =?us-ascii?Q?4devh+ToStfuPpOtxtHpBVwYQb2mukCahTjne6rTDjhFN7jejbhQ5sc7oQpb?=
 =?us-ascii?Q?Lp1a/4Fe+n+NsY4W/Wtye01EtIMvHDuZ4eJYt0o888h8obFh8EXgjYyJ9CIe?=
 =?us-ascii?Q?ipjER2Vtzl/CqWow0Nh+GCE9oyv8fmOQHqIjvQQMdbsxQ0GrJKwHGWaP+RxE?=
 =?us-ascii?Q?ghfX0QAJNldcaHNpR+MINQ6do2AzQSmPcMS3SOEBjICtezKagUTxPuS6r9UV?=
 =?us-ascii?Q?XIjaQnEMbn70uSO548oUMoMNO9m8CejIEN3VkD4IflfhxbiKv5yN/HlU1fyJ?=
 =?us-ascii?Q?z0M7GLcfU2w3W2OzLTh23mlGjHl+KKxQns8bZvBb40eYBDrFOYEFTlLmlG6q?=
 =?us-ascii?Q?meC/XkQDJHt9q7esrKQoYM6tc0jQQz/k0t+L79XxlzQiLzSH7goWzCTioP2l?=
 =?us-ascii?Q?t2rnyZuZftsx+Uk7i+2CdkDe2IDkonvCi1WUw8UP7QpmGt4TdELViJ07xSSm?=
 =?us-ascii?Q?Cd5+HKV+ZNSojt3tRFta3P8fZ9AFb35T7jK5lGF3VaTKoOWFbMl7CcleVeG0?=
 =?us-ascii?Q?/MfWHwwdb3QsT8N7Z29G/WdDbE8UTnGvOkRpygHPBh+yaCVoXmlYoV3C483k?=
 =?us-ascii?Q?5Pk6h/Ky4e8mS333D0Y5wuUDaFD2o/0ckp3EKZxCbLamghkZoF85CdD6KjsZ?=
 =?us-ascii?Q?iCLWZZ500zxWxKYXEjBdwJ2l+GVfCYxiGa7WaejRp/GPu8N9w5FAqCVoxhi6?=
 =?us-ascii?Q?n7lF4F48rvVKi9u6k0hTmLFg9y5lwSr2j8a+P32pNNLlKsEJCw6pnDUejwSb?=
 =?us-ascii?Q?UYMeqkM3ik3kLsoZzEWh5b2V+XYWQk8WN6kr39wGwr/Lxj+nfXcqmz6NCETL?=
 =?us-ascii?Q?nBfZtX9BUtzeooo4VZEudLArLWYZTErVJq3lYsu+kwhWnZmT4dpIEt/2Utma?=
 =?us-ascii?Q?+BbbSz0w3qyusWJx4kwHvL1CPvFYCbxIj+/eX+6kMgwx0Cs/eeocD47zYXtV?=
 =?us-ascii?Q?il1WgNUyNKRwUcEoaIebHRBCTdBpBOe8QsIIHmO5xYpt7Wq3p2GQ0umWPDZX?=
 =?us-ascii?Q?Dx3nNLARo/O99bPWNOo+FBk4VftwTg9N3B3D4vwYysks5Xkx97ihcsucdm0F?=
 =?us-ascii?Q?t74vxw0KWvAYxygBBOQGQ0Rf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9908c8ed-c396-46ec-f531-08d96d081167
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 05:19:27.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhCv4PZfjJVosdJRVFIgX2tMb8OhzaD4OVDRFHIOTCt3V9buQT/ODujnoY5PSqcewDYMoVUwNqA9sMOV3D8Cnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=809 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010028
X-Proofpoint-ORIG-GUID: jJXzCnG6zLtuwtKg4bjNFqamA8tnsoqO
X-Proofpoint-GUID: jJXzCnG6zLtuwtKg4bjNFqamA8tnsoqO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch series addresses suggestion discussed in an earlier
RFC [1]. Since earlier RFC was about SLUB subsystem, and current
changes only involve stackdepot, I am submitting the patches in
a new thread.

The changes of this patch set are as follows:

PATCH-1: Checks validity of a stackdepot handle before proceeding
to access stackdepot slab/objects.

PATCH-2: Adds a helper in stackdepot, to allow users to print
stack entries just by specifying the stackdepot handle.   

[1] https://lore.kernel.org/lkml/2772cf56-4183-857f-d070-c54bceb5c8d9@suse.cz/


Imran Khan (2):
  lib, stackdepot: check stackdepot handle before accessing slabs.
  lib, stackdepot: Add helper to print stack entries.

 lib/stackdepot.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.30.2

