Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC23E12E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbhHEKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:44:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21766 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240245AbhHEKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:44:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175AfRVn002817;
        Thu, 5 Aug 2021 10:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Ip7111TusjDGT0AXnDFeUQaDqQy6f3gkxIfJNLXcFe4=;
 b=bJum7NhP0IXHdw3wZ8BKLqtBMLOvmn5d8lU07CVgJYs3T6CR0nouWi3rug6s1R5WU+al
 1hHvnTNGkfD/0JIqIhcsb1KuMffXOX1yXo9kCLMYSVk0zxtKkY4HBHY877mt2l4LKENf
 gB3un8o0yzZorBFkaqE1zaG41qPRLAJoNW1k/zWkGC41jFJ3/+9l5+JzEl36FEKYsnZN
 WTpTlUpeug71SWhPLX9VdUTYQ3sqSLPHDgzBGjK8tPQo0C2MHKBlO4I0W0FSHIuVlf61
 gOC0Qi9UWvTr3uWq5LOXIzjz52f9WOyudBsvPQvxGB+bK4D3e1wO71zLKa4B5BoBUe/n AA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=Ip7111TusjDGT0AXnDFeUQaDqQy6f3gkxIfJNLXcFe4=;
 b=hiFs9WfxCdKeL++33lVaKHUuePrhXjFtx77hRsOSbughOWHa3XDqmXev3WgSM1CNSi/f
 2vU4Aa8qKBMzrE3Pam6Qr59h5J/W3jykZWhuPa2XdVoSObnMzjQhe0BE33iu3nNygfFP
 eisqZ11lMuH05agp1UndOKFEYy4ngmP/J67uzBCbRZ4RbuaNBu780/zUz5ChdXpOo6BR
 8ZdwXq2iu0sGieV/v3XSQf/uifyOLZ+H1ofVHSVBGtu5AxRCXe/pmye8l51EPRr2P7o3
 papUy3pZGIqT1BZngXg/Vsmt/nFKUSCO0ftfdrs8rpFCbO7hzQnU6oCCoTtkCVvuhkhf 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn3wt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 10:44:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175AZj30080525;
        Thu, 5 Aug 2021 10:44:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3020.oracle.com with ESMTP id 3a5g9yyfgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 10:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFF2lRvdv9zraxk67RFzvnocTLoJpT6WtznXbPIqMQUAkkId+3MNerjL26OOcG+SFYJGwXQHm456GD1skYVuCFW9MGQV33P3Zy+lbI3/yVpqS1WT3jzCsaQQRuWZoAFRGqcyz/pdm+bnduo3t0y6UW4YPsy+Q7MC8X+3c0dKh8lRnqJ7x+Qw/PjPIaUl3mb1SHm/ux3c+tUwotOrYyuNhaU04TRrnN7VtLRtOoAdRfJx4y13HImzM2VSDn3NLXAZ6/d2VrmdFyJ2ygzpnNu3jp+vPUNdQKW2fSMP/KD9vQ2Pj2uYRp2jjwvkQE9jrNlM9M2Dwl5kKroBKLVN8yd6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip7111TusjDGT0AXnDFeUQaDqQy6f3gkxIfJNLXcFe4=;
 b=YOxy3fu8/oVB73GlXNQWJZzDYbQaNhw0KMm/dYd03u8NVBxgbTtYDuGgL+E8b6dT+Q7hhAx7lxIGTQ5ifncPb56O4Yiix9kurELpIV0muqQn32dnh7+TJDgI6Acgg3mfUiyU2LBEOgtfzOsx0/3K15mZl28osIcRQIYTXFoR7+ouheER1GVhwHZQnPPaTlw+JrQiZ6LqQD8nYw1b0LY0zWE1/48AaxmRwLg2xv0QwoGpjByrk4YfpkCPf3vKQ7KRN/nIGonQtg5bTcdgFogdlpaQ9w9seuRsk3NCkdvhz/Ra/dfYUFEJJKLLawndTscrgSAYh1S3FED44g7ukMxgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip7111TusjDGT0AXnDFeUQaDqQy6f3gkxIfJNLXcFe4=;
 b=Vj6P0gWKM09dtmm3mzsGmnvxFDPtRnRs4EAWRsI77iDJMt9DmAiTouNvvn8YJmL30TyuFpLcQhJPTj+7CPz3bZXSgIzOwtsku3UUkAK3nGkketKX8XZwA6HGG8eujWOcADJJd8X3ALVN5i360DQ1ha8quJR7gq80BlJZjYEY5Sc=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4484.namprd10.prod.outlook.com
 (2603:10b6:303:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 10:44:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 10:44:04 +0000
Date:   Thu, 5 Aug 2021 13:43:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <20210805104353.GD26417@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Thu, 5 Aug 2021 10:44:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd918f0-6a61-4cc2-c61e-08d957fdf1e8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44844FB971B036718509BAE58EF29@CO1PR10MB4484.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlM17hpCx0X13xSCzVs1wk8VfKp8t4pFbxXQLfS1wmMB4aHkW2wqYdjC66v6eW4WO5gSMpeLc5uFPrdBbThU6NqSdD5Kfd7mKc5hh9EEHXlRmxmhEvR4skuAhaRi/Sq+O7XnbKW/8Bx65i4nW2y62/RcUYcwpIEU94flDDxeob1dUHIHcjlvoMu1XCx40Lu9uJy9plsG0mLjlxXLHDWIvtmPmAGMf+vQDsKy8+d13hdfZEfeOhv7Zl44HAb5bTnUeBL9pxtlHCnRmlljsTsUVVLBkiUwI7Vx5qLu7jMjkCDv4ZYcdLvrcXtOIvRxe1a69SXiqddvMvbaRo3xAeD52GlGsNyI60IdyFTfmQnDiedIa4yF3rILTyFnNEtBu7/QAxaGIO417dG0pzYS8OD3m8OMjrPV5fTWDRzB6Q1kNd/fSO4Kg5IsTnfXKY6cc4ueaIJ0utlIKN0/SGFaHW1WDmV+O+NqsF9Cz+lLAXWATR4xXG74epj4VodaGL3ZccfeBc6lqV5WP5ZsK2/bKGLRZw57XFlfOFVqN81qDyt+fRaDzuobQ8y0Mrg2k3/LOUB9T99tmPOmHFAxno1vQMukCJyk3TaGmhPBiP50zbMn96zxKIcOGt8n3oIMncmYQtaEvRytZ9+EZFy+IOrCXLkWuPf2/2ejUF6Cfy1zvyjVsbeYPmFx/ajsJ1LuMW8kvlYr/1gF0ESG5yMeZKWPx09jdiS/MudxpmKirAeVOdPc/9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(376002)(366004)(9576002)(8936002)(33716001)(86362001)(66946007)(66476007)(9686003)(6496006)(83380400001)(316002)(8676002)(66556008)(33656002)(55016002)(54906003)(6666004)(26005)(186003)(478600001)(956004)(44832011)(2906002)(1076003)(38350700002)(52116002)(5660300002)(38100700002)(6916009)(4326008)(125773002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y20rNEb5jmtkMk7RyxXOw9zQd4g5+13VqQGozPDcQzGhGbTN6+CTP6o/XqwK?=
 =?us-ascii?Q?MST6zzN1hMIC7/OZLeaaIuAPiD8LpPSVnqd+IkFreCrbTBchTH1UKWDsrHe+?=
 =?us-ascii?Q?fsan2tVXkkIC0TN0QT1AtqmoVn/ihOLW7QM7PJeUwBkif1PovMYgXWNH/1P3?=
 =?us-ascii?Q?DTfy9HlVHipIgXh5r6eGZOCv4++4npa+W0WgthJg6xSM5UR8X1Qnn0tI+3z8?=
 =?us-ascii?Q?WkE0f2tB0bT4FMd2ULWZb5nLAwgSmg/AGOQFoGVUj05b2oWMmYpLqov3O1F4?=
 =?us-ascii?Q?vHrRjId2BtJYC6TpCiKttyPYTuagnbBXPEOWem9pwSlP5ayBwBx+l7g/8hBM?=
 =?us-ascii?Q?3cu5lsrHoRWN4uXyQkSSn10/JyZIx7b6QHQ4eI84m7ZqUfRyBxUSHf1+D/9x?=
 =?us-ascii?Q?EVs2XISqhLCFEKO/Vm2+bNpsBH6WTKLvQi7mJ7Dhqug9Tz1ZsSioL7KdYN+Y?=
 =?us-ascii?Q?IZprdO+upUYz+CXYDIDgpNq9K3KzZIVl1FokJWdDtGoEJYJv+OcavxVKIPBl?=
 =?us-ascii?Q?PVO8o/z7OAWPm4JT7+Iy6vos8DoTDFT0WiIVbZOIEto3DiyqPYw3EukTj4Hp?=
 =?us-ascii?Q?FSw7KhnYGtwkm2pZsn3jmR4ee1COf3JAyCMzbIHmeWQMWY09Q2ICQCrfJ4ZQ?=
 =?us-ascii?Q?o7pkB+wFK3oO6MdVZfdDla83WVV8H9NwuJy+xRw5qNZrD+MPQwDgD9PJrBGY?=
 =?us-ascii?Q?YJMtyG1WdCeqrx1VfVv0gykxh42Ny0pe0ES7/W8twDvfT0KItNzXGTo2F9Rk?=
 =?us-ascii?Q?jk2+vfWd+ATmCvH39xG9ptjPgtNFU4Oj8VjFPQ72zhOT+jEbSmUgEEunwlVo?=
 =?us-ascii?Q?y3OvwP1sJaKsQht9He64c4WUjxObQqg3qikAq16FhWjoyWaynBpx9cXjerdd?=
 =?us-ascii?Q?NQZsK+MOp07nVyANvok+9amJ4oFQUDDmALaBQ8hnu6JcvzAvSnLxALOT7jKl?=
 =?us-ascii?Q?QE1Rj1HESWFe51aGVbhX57H4nZHu13iZlDXTlCxoTQhaAngcFE9rYoYQaTLO?=
 =?us-ascii?Q?IMfMK2NnyKcSW18er2XrDLeexyLcXdfKu7FQ3s2OBa/GHErGfNbVEHfrkH1l?=
 =?us-ascii?Q?Y7j/DIQ/syJr4Anoy6itsX6QY+DTNYYcxh2oc3l9Jq6SancTYxXOUIwJqzxC?=
 =?us-ascii?Q?hBDYgbtQsb7XlgO6XBfHOrlx3juEg5yr0HKRedhZ0a5GORf3ggbWp3wJNlIA?=
 =?us-ascii?Q?yIiyqyyvd50947rBVj9AID/tTlKduRprU7nixDHlfsDZ3EmeWYcgJNP80pIJ?=
 =?us-ascii?Q?289n6Hurt3GiG2leJ2s1+uJ3K2AMggrK0AqSnWOSzuCHsV2C5Qk90jOx6Sxf?=
 =?us-ascii?Q?2UqwTdOoDypWG48qECQmPGYl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd918f0-6a61-4cc2-c61e-08d957fdf1e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 10:44:04.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY/lRmrewA/VNqHX8JAbZ7oW4cYwuqaR0OtrVXlU30cSyKgp+q2e7XjkV6PROB6sWMfPy7jJMnwNMqMxuKkyBPAyJQ5k+zb6MkxRIH7n23s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050063
X-Proofpoint-GUID: XXqL1JBlzRnxN0iZoeQ8w1mxQwwtJQYa
X-Proofpoint-ORIG-GUID: XXqL1JBlzRnxN0iZoeQ8w1mxQwwtJQYa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "= {};" style empty struct initializer is preferred over = {0}.
It avoids the situation where the first struct member is a pointer and
that generates a Sparse warning about assigning using zero instead of
NULL.  Also it's just nicer to look at.

Some people complain that {} is less portable but the kernel has
different portability requirements from userspace so this is not a
issue that we care about.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..32c8a0ca6fd0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4029,6 +4029,12 @@ sub process {
 			     "Using $1 is unnecessary\n" . $herecurr);
 		}
 
+# prefer = {}; to = {0};
+		if ($line =~ /= \{ *0 *\}/) {
+			WARN("ZERO_INITIALIZER",
+			     "= {} is preferred over = {0}\n" . $herecurr);
+		}
+
 # Check for potential 'bare' types
 		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
 		    $realline_next);
-- 
2.30.2

