Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B732D3F1D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhHSQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:06:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18216 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238590AbhHSQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:06:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JG2TBc012355;
        Thu, 19 Aug 2021 16:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8rzd6qlEH1wH4+tM3/rRKrLpcVO0KaT/7XdGc9tUHzg=;
 b=PC2IlVYkjgExUUVteHJ7LWPe01DgywHCRnzFQBMas+MGZu4KofH0v9LVfQJ+sCHGk+wz
 2CSrCdeD5GpTU114DyotieDy7CRA/SJb2XaeW8aQEMT7tCUmxNaA/Yog+R2GQf3gcHGS
 DK6XEYswYp+miZee4OmFoN9ABrVibGeyO996cDnJTsnuEGCEG0jz1spkzOXbK6fLpNm3
 cPgBtBvVpkFnLlUFW/N/po7A5QKffyn9wdInlJc7Iw+nc8BMOm7nuNuirLB03tl3kzkn
 tuIGJKGAc1piCCvu+YogLk7kQJsPB8RuzkDI3tx2kO5dVrw79pjTVIwiudCmYw7RdWwD Fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=8rzd6qlEH1wH4+tM3/rRKrLpcVO0KaT/7XdGc9tUHzg=;
 b=wPKIa06NxePefsbclWMNb45Dgz7WHuCHOQk1LsfdXvunn8gWSa+4jv9sAKl0Q00I3dCG
 J1Ut5Rj/ps7yAY4xbBWV5xql38pcfwijs5Bla9B/3MZrmrTpJY7N7QcDyVIObUm1HGI2
 F5T5UO5jPEK+miV20ZA7FwmXlHCN89s/rbI4SHuq7c9O1xxXMHBWbaaEJpbMVW3p2Zgf
 LyLTGZUFvKeAWEwK5rnibJ5Euonkl2pDYPraS1LLSQcFFXtuhhWIZ8/LIvGn2z+W8EUp
 pmCWEnB+whacQUNfTg2EywK/ZfMoZ29dhiZn0SVhTMeQWN4tjAsPKjlI2m42fC8iBlTe 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24m9q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 16:05:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JG1Aw3103219;
        Thu, 19 Aug 2021 16:05:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 3ae2y4p26t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 16:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyamqpaXu0HuFlo6oKbNwvMXW8uTJnJOaQTNguNQQoF9LFCVyD/GqpGbfVXVlZbG8pEKwX8/muL2VKcoiFi8yZmg2JLNAMJMFhGQvBlvfW5LQMkOl7z1WyFiAOcnxm+Kjc+sB+Rp9fzc2rD5Zy42QWraKRIgPuGOYUgrLfl5udejSZ5QdPCtJl/B9FIUCEk2EKdg7UTtU42u3uQuO8KtqX1OJxXC48vGMhYe9XXltK3clzLTcJIAbvJ01bgewjBEg68s8pimVXIhVPzL+PVU/TldADrQHWnh+VSfA+vSF0T+suQodNpbp+P3mXBm814QntjnEwJLsnD4BTCmhLVbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rzd6qlEH1wH4+tM3/rRKrLpcVO0KaT/7XdGc9tUHzg=;
 b=hdw/ibuTn4hZ90ZSapMLDMuOwxD8OBqLI/EgoVWvzSlXdwsI59P5KYJQ1hgXRsxfi4/2SRg8ezOaHtxQqH24qxXqKxV8I2UY0f31icFSfGKD2UQN5dP3UVW1YzOncTEBmi0C/z/ZL0klOuWMOZf4XX5l+zk/gIJcoYyk2cfnPvlpy1gq4AhBOAVhZS4prPR55mLC7WRQEyKeisZ/gexMy7t8AM4hhq06o2BQTm+50iVu8QOSCoBV6qCNaPn81evHNwyFYAfv9OQJQpd4RuuEhmIW7864+03EaAL22PYRw+HOpV1OICa/uUSYGT/YPvFk+9FpUAkdmiIKzIC2+VFhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rzd6qlEH1wH4+tM3/rRKrLpcVO0KaT/7XdGc9tUHzg=;
 b=zp1TINGoIZLgZMaBeiTOjdL5YTLY8CVZKCIHvTM+mLatcqgOVvylEZ04zOAY4Fv3uXYkVe/+Yy2P5vJBhbtE3jT4medbVnylPoxtgbnfdXaWsOw2MavwMchbmNRrdJ9qWN7e+tNi11xMLfDpmyAQJquZLB4bs9TzGUUkJnK74a0=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2063.namprd10.prod.outlook.com
 (2603:10b6:301:34::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Thu, 19 Aug
 2021 16:05:15 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 16:05:15 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        mihai.carabas@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] misc/pvpanic: fix set driver data
Date:   Thu, 19 Aug 2021 18:12:25 +0300
Message-Id: <1629385946-4584-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:805:ca::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SN6PR16CA0041.namprd16.prod.outlook.com (2603:10b6:805:ca::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 16:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41679028-3261-4a83-5a36-08d9632b21cd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB206367CC15D7751A2CF7117288C09@MWHPR1001MB2063.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Pn16kVZpvhX0RLx+BZYW51/FRE/xKE2E3HuRsIeHbUuCiSqUQVdwzj9xODETDZtl8lK3K06dLw79FIFZbTvzHTv5E1W47J8/aA+dFtPEgeDhT19UuGWgQncqPwnfn1TM7AY8Wx64mxZnpgYAgtNssjEOA5Ja1XmqSSizQSUIPv+aBRj/r7l2pMsE19tj58p5JfdYQjMaC1WPu2KRiwHQCLKIX46U6ffDXVotSWaGb86jgWL6nhtHKwiwGUdDizgkkBemBeKz0f7ZbnyD5yfipW9EPuChNoJJQxb9+Kz8Li3SSNyWYFKN0J5kRJsdmKAPflKUZxxo2tc8FSq+nKJBIHdMTUG4L22Slrolzws986SQrnD6UdjsKW52S8DKEJjpFtjhdnSov4DfJvGHZE4533GcS4vjyeMPTW8yuZxvWRuEWByrUYW8/ifnmCkq/GzBnwPNqQtUOPxzd7i51jacwpMuACn7U8sqP9hYrW4vJRcJOIyTRrslcFxYWOkV8VUCT2iQq5LF7zY8bJFXPzHAfwxN3l76J9qpiuwFklokf/Ry7FjXgNYZGOBWhvC9mgAdw2rjV6G7kOUY4pnEXaC0gV1mKkgdN7qyy4gFu0kPGqrEqpR8YT3200pRFvTOlV0JsjSVRh91xu9amUj4puyxqFWDIMZPoVLXUd0RZxDVe9bO1Irt+Tmg7K6omwl2n5ElrqSEX7lfTHB5WWflHafA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(36756003)(6512007)(38100700002)(52116002)(44832011)(26005)(6486002)(2906002)(6506007)(8676002)(83380400001)(186003)(956004)(86362001)(2616005)(6666004)(38350700002)(66476007)(66946007)(66556008)(4744005)(478600001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amyT0B2doVAucsJ9971Pj1xJQks2BNx88sQEiSDiYp/uWybd4X/oNJqaOpxY?=
 =?us-ascii?Q?mp7CT6Pz5aUcsGW7dSHACUeoZkGmzrq5TuUCyYNTpU/AC1ZSH5YSyoTY2mI6?=
 =?us-ascii?Q?kK5Qy3ZuY/CgQ8A7a1kE7efhv88Zl7ZrfNpRITzP2bLwjpnw5P/4GuwjJKK+?=
 =?us-ascii?Q?QqsxDzGS7gi7p+hbbUDrZimzA9X4jN2xjTuvwXngUj5MxzNibm9nlQa9esXJ?=
 =?us-ascii?Q?ugMP15XWkQIJQhy6GcSz9fuF3O4KLhhDPijHfGKukGnYHVLII1DUD46sphL0?=
 =?us-ascii?Q?2sKgT5O92noOEO/Ba4MV/Y+SZ5nl67tQsVazuQaBjaVGIBahdl9lBp53IhTx?=
 =?us-ascii?Q?Qd/yE4jqGCw+g9UUE2TnttPb8DLbh6nQ3lLUxj1JcMAC9T/iJI2SKV1T7sbM?=
 =?us-ascii?Q?Ye8SRanDG9FzXb7lRO2kC99a5Qg3OBRTn7rEt69aFBIKmtb1t/kGbIU32EHW?=
 =?us-ascii?Q?F+s2dtJsvBcs+qnc/G7W62Pebwlwk5LFQbpOB+5ORLZcvqkMBNwnXsXbzNn4?=
 =?us-ascii?Q?70C7xhG2jl2sYmNTkaInlreykSA1L318AFcN1gn8p9FAYyxv3xJPwGsjMYum?=
 =?us-ascii?Q?KMlAZFyMQsLAt3kiGgZKZwpNbbwmEDAlmHYIOUotPSqENvqf+72bHuUNRyff?=
 =?us-ascii?Q?lMvOMVqQo3wVj+JNek9mDLc9A5tUzsAPdlwjTP26gFtg8ztp4/KWXhFd1Inb?=
 =?us-ascii?Q?D4Agexo8yDhXbjgqrJeFhfktPeDT4Z9Fg2PHsKo7ZRT0ov15HsGpchAl+7D1?=
 =?us-ascii?Q?0LNwyYVvBwwB9q00uyhmU+8c9MV9LdLyEhGljIk6Mm1fYmYEo3otA7CveJie?=
 =?us-ascii?Q?oTz3NFBAjQNhunoJZcYXGqhWUomwYPuckLjQ1Nq5xKhkOxpt9vFdx8n1kbiy?=
 =?us-ascii?Q?UBrf6Qxtl6L27xYwF0ing6/a1OokoRbCxNsJjMEOGpyqCnvnQvXwxYkTAeK3?=
 =?us-ascii?Q?ysNcfiVCRgKmN+2uojBoGmByO817e4JK2EwRCMLHhrzncXsGzUX6Y7n1w07U?=
 =?us-ascii?Q?JEMDRtO1fsc52eUuu0iQLcbnCCP/aj039mnhyIX6xh+M7n5262WhEsA8vMrR?=
 =?us-ascii?Q?VtAo8rEqG72Ezp2OFVslJyhei23aRwfM39gFbOgC5cxBOeGT42mEw5rAULfF?=
 =?us-ascii?Q?sbZeaD7q/DLhT23mzX2O2QAaFWCvHJcqQBLHUr15fzGMH5CO5NKmwB2g8+mu?=
 =?us-ascii?Q?e2wHYJ2jNWOM+d7OMLi9BouJCDxdNhBwSjRekF+/WYOoOIyiiu0lTLRn9RxL?=
 =?us-ascii?Q?j7WiBN4KLD8wYI1I0aDPbXv2ldJc6UXwNRGELbHFWrAAPVCfdwDXJIarqd9Z?=
 =?us-ascii?Q?lwlE9vsMnAObSIvV+x7iZU3S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41679028-3261-4a83-5a36-08d9632b21cd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 16:05:15.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBb685YUUpwCagh4bkR2viCTue3ROuUmvmxetFkWmkHQgsyH3EPLbexyV8a222Qlmk8ljs/6Ae1jkXeyVjQufNih36F+28AofRm2f8FKM1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2063
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190094
X-Proofpoint-GUID: ABSw_EpXOddJ151IIiNghL3gkx2DDbBc
X-Proofpoint-ORIG-GUID: ABSw_EpXOddJ151IIiNghL3gkx2DDbBc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")
removed dev_set_drvdata() from the probe function and accessing sysfs entries
from userspace is causing a panic in the kernel (pi = dev_get_drvdata(dev) ->
pi is NULL).

v2:
- fixes a compile issue with CONFIG_PVPANIC_PCI
- move dev_set_drvdata() to devm_pvpanic_probe()

v3:
- move dev_set_drvdata() at the end of devm_pvpanic_probe()

Mihai Carabas (1):
  misc/pvpanic: fix set driver data

 drivers/misc/pvpanic/pvpanic.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
1.8.3.1

