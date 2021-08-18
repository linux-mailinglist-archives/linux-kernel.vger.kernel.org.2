Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402293F0926
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhHRQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:32:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60832 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhHRQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:32:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IGGxOL027002;
        Wed, 18 Aug 2021 16:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=MmyYOOr4yLM0QnQLrDQ70mTPUYrKXqoxdFcg4Qk/OtM=;
 b=Ijg3E6swseddp58S/xP8NG9u23PMjVuVsai3UWs8TGsS9oE9I+wt0FEjd11pI+Fe8k4G
 PYwCEPZEMc/AOdrG05AXTc9fGAxFxet3xu0MFISP8hiEoKr/++jm7GFyAb7y3SKFlOKS
 o0y2m/GLuJIPPo2XWIvBgaqrcxD/v4T5XwBPRBgMgD5RK3/ny/n9Qf9vOXqZC8n2LxHX
 u315zVNoBe6Om65rozgrRDRmuQlBnH99cFmDD3p4zlmXQ8a/7vPc0wYCak4adK6C2KWq
 AgLv9i1KIWePGpi3h63TRmkUIfambJStrLe/ET/rf74epLf7hjOvl/YKY7LvRHlPvZpW JQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=MmyYOOr4yLM0QnQLrDQ70mTPUYrKXqoxdFcg4Qk/OtM=;
 b=E7TGrTx4Od12CnCdQNlqBDQKrm0epWqDu+nbhaSq6E0C/0sL25Or5u2FWaoO9jfxJpIv
 qR8YuOdu9nZwhB2UfFZiO0gw8vS7E/G8rD0dyav37pnD30lRGvHZkp2FsSKFXoF1apfa
 QTVxH9xpw44vLmNP1wCrwrHGz9Fsl7vYHfkHxhbcFe6uCn8I4RwQsBBkGVT+ahhmEbda
 ykjHZqv6egspcY1p4iuZ5hpMEwFcQd243v55YlaWgD8wGYKod7Rj81D2eumq+tP02qUO
 CPH3CYXbEUsK5D2Cxv3RMxLTTJZKoafXjw5NELZNv0Gg+LWUHtzbXHgZRtytIZCP3WBM jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf3gc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:31:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17IGL6px086584;
        Wed, 18 Aug 2021 16:31:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3ae2y2gwdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed47iB0hH7NXJOjOOt38qLzG9rGBCkHVxDYQ1PttIBt5OUZ/g2T4B9WwOiqEy4mXRmgtCyKUGxd/xwXdW8Uch31Ur61XBtDeCQbKS45lFvqr2g1eivPcFLMaY5iU1GwHxkeN3ZwU3MLAeBmZCy2F57XSFd4Z+PXdxlm3gDHeZD4l0r970UcsddNoRo8b02EUJWfZF8ICIz6ct8qSo+EZI9agY23yn4KKpb8oaUAxaJBcfTePjkcGVjlKQ+O5I1hxgSgakO0nMKvGA0gCkx1kHg+5E6QUfz9+IyXKuc4OnRuzwfIJvBSSCc2eWC2M5qVPEUCJKhwIGFE2l5fuwONGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmyYOOr4yLM0QnQLrDQ70mTPUYrKXqoxdFcg4Qk/OtM=;
 b=XrNCNSs+Ayz7+OYjzpbGie0OODXoj0uvo0hYU227/NxeT4byjEN/B2cKqkF/Fm9whuCOE27/yuG1uZA+V4gCQTfaTsYJaq0EhHvpl7B/+rmMwmp4lxkI5IGDIlPu9deHTcP7DEbWHrDSYtWe8PGOj+eA94RhVN4xkA1o6KRW0i+88cemg30ZzBIqLIex07McDmOZ584mP7pZZr+Z5ifZ9NOyLc2yFVH3XPfdkV6vPHVbzgZpnVlfeZfQTnnXxLxYW7pTSDlYtqnnkNtx+mVzMTMOwQbNeitXPSnJe4OuRl+mPjAdfFb5WvqchfAqZ+Q3vvTMm9xzdVrgnp/svstX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmyYOOr4yLM0QnQLrDQ70mTPUYrKXqoxdFcg4Qk/OtM=;
 b=naqaDi4dr+vvl72RaPdAd+iY5zlT2kCbINeKZV30b7JddGWJkGBtRlJhLi/5p2DWOrHeAZKbuAkC6ge0IAkhTlzpv/9H/b+FHr77v1KTYoGET2Mv1zZhVwxei+gimDYoje6wYRPiROb938eelBP587FPbXamA/UhDorKXlTzIxk=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1854.namprd10.prod.outlook.com
 (2603:10b6:300:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 16:31:17 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 16:31:17 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        mihai.carabas@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] misc/pvpanic: fix panic on accessing sysfs entries
Date:   Wed, 18 Aug 2021 18:38:29 +0300
Message-Id: <1629301110-2714-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 16:31:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09390bcb-8906-424b-bf98-08d962659a50
X-MS-TrafficTypeDiagnostic: MWHPR10MB1854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18546B23DFA04BA5A8EA09F188FF9@MWHPR10MB1854.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBlCr0JkjGwikVVdtrXDJstAJVn9SIJv3S1K230c4sThzWx7kkbzhXdJDQ+IETjhoad0CtHibcYyF2n/dCgGOa/99WtTh6JccTjQmt7WoSXa1qKeNX2v43cekAlw0h4Sp3J/AoTcGwOnSf1cERJFJutlXamhRsRmBZae1eC8EM9FajHnfDqsAqe4kwCoiMo4CH4O6PrOJQeQzx9dLkRdQjaKhKetQTW7OK1bkn/hoswMc95aeg/YFL4r1ADwqOmjO+YyHvMGD9znTcKQua+Z4oLQ1Q7hOCbc97iX4Pys4/M+RnmzgYp4E75VsNAYH/wSPUOOev2zy1Mji6ESPExEtVmFuO3/A2dzR3BfhY8QZEWTme+ONeOPsjq7YVhnTWKuYlwuAhdjmvukvxU106oLPRYWS2f3E6bCVLyGhRQ12X8hD0WJL9s7N84cm5sasv8IVeVyFhl9mD5qRCmjJtXivYJqivkY1CYYISRCqQZYxLYluMoBAJEoe8x0RleiJtzkKcfxz6S9aSk3zQGZLgl/a6FFWAQzgUeEWswDqDEYXa48XxdBz40b1lT0XimaPAKf/4HaqrhtnA3qghtCOVuzMnaPjFhaOoDxl4gRw2WhvUmgiVBL2GhcM5AgqzHL3DBQc73zG/IFV4XAIpY3vGDinUC1PmJPjfdCb3qXnbqyPAgq2PwIFpFFUIqy0H8OEw50cS/YlE8YWdVuOhpCSfJCtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(6486002)(44832011)(6666004)(36756003)(4744005)(316002)(186003)(38100700002)(38350700002)(26005)(86362001)(8676002)(8936002)(52116002)(5660300002)(6512007)(6506007)(2906002)(956004)(66476007)(478600001)(66556008)(66946007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YuzG2sHhGXsR0ROrUvAGK3f1b33HKE+V/2z7SqY5GLofGDlxhFujlSGawp1x?=
 =?us-ascii?Q?RPe2zgRr7cDe6978WpUxeCmfkKfMvTmQMRNeYMulGzehlPYebmUp9Q6/Xawz?=
 =?us-ascii?Q?2OxsEc8Q0kKkunrkKSBv6Gk5pCyUHIsmV0czWHYCceD0qzkho/5mgpFKL8iZ?=
 =?us-ascii?Q?178+DLXPVf4WAyTaQhmIQ3BY1Xq7So1q9rDrZre3KAa7wzzvB8WyR5KGqLCm?=
 =?us-ascii?Q?Wwyw7SLir5i6OAhcg9GFCBVUxUUbaAVRtiZwZHgMFT0RiG1RQ1F96Tv5cCAG?=
 =?us-ascii?Q?Jki1XcBV7ckVKODpVymO+l37agmwV4ex8UomPDV8Iup0VbvwXTkdGqIeMXOf?=
 =?us-ascii?Q?gw5mUcI9j6hO3/3U5JTtpPZw+amD5MjjJnr7PdUJnH1KbiHR7oZU7vAucTyE?=
 =?us-ascii?Q?qYI7BbWw+dDljc3pctiPyW9a8PfJlVh8E3XMk0VqiExPhmZ1GMtiuL9YzaLn?=
 =?us-ascii?Q?lk4uMZlHqS3uvkcIKO30Lzhg1Z4BYYtYd5NJlT8BVNHj8HnGANE7lT4aLY6O?=
 =?us-ascii?Q?fnwOFt1U6z8IMSu3KWjYgrF0VSInt6jIxazzkW5sgcD2+x+KsH7cV338WPnt?=
 =?us-ascii?Q?cDhemfYSKRT83nXqC+Xj2IUn4zG3FViTuXU1Qicu8o/JfihwM4E9J2sd6487?=
 =?us-ascii?Q?vYNrXVmkf0KjURqgH8vMy6aGX0+rp0rBO5HAzyUFidQxb4WkHd6KooRYh6H3?=
 =?us-ascii?Q?Br2hU99DRunqx5atoGd3t2AmVHqCr8+kN/t6QpQ73lgh2MfwDxNeizLBniFA?=
 =?us-ascii?Q?VN/W9nZfUWvwwRZSJW7ln+Ez05/PeF8m0ZyUOjLxPEV3TDdcxdJNF39qkmjl?=
 =?us-ascii?Q?hgueMFeonHIy1MZN7AgFn9HgwAPI41wj2kWQ7MPUmysKKY+5x2cxH9GiODMI?=
 =?us-ascii?Q?4fq6EiFpmoQngWXQvrEtbrKayeRE38Q19w5xDWcEUyzA3ekLJjwt3kSAde8W?=
 =?us-ascii?Q?bh8JgBsGlvgvmLwt6/3Hcb/a0ZpSWrCxTUAKeUm16boatMV2JE1Vzwlry5jD?=
 =?us-ascii?Q?Is9fxoaCZTFMi/yUsoqhIM0S4pt2vzK5GQM+2uB/6DHoArNAAcR8oW4nfjI0?=
 =?us-ascii?Q?jTMreKyRbZWC0AA5zyjK6G49uVV7hEscRPKVCRhV7LA1nOPg8cWe4DLXCaBm?=
 =?us-ascii?Q?vdSTzPAoJ2T+iaOu7iRzi2ghCzo5JKrz2h6Gshi/HOY1kZ0sucgaxEw8S9fJ?=
 =?us-ascii?Q?vsh5x7kCvQQjj5jVBRI1DpPgc2TR9wV06+JFzQDEtXe0RkaQ9MX6ZX8f0emS?=
 =?us-ascii?Q?N8UqFvyHNNEjfwJfIfzuJuiopl9YHwhs5dZ2DAtzmkc4vD9CsNbS9dyFvaHt?=
 =?us-ascii?Q?sHLjYJWX7l2PU28hhNcGb2jb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09390bcb-8906-424b-bf98-08d962659a50
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 16:31:17.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lymH3dk3VbNRYU6Lw3pZKPhDQZhapG1UIdFL545khlKGg5a7ytVcAdRoFrDTPJ2bsI5NLetdS90bRRhf8Y2CuwxS4SXEIQDmtuLS8tx2SkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1854
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180103
X-Proofpoint-GUID: pFZZPYNqFQilwqb5NtJ-6OmhKofvuRQK
X-Proofpoint-ORIG-GUID: pFZZPYNqFQilwqb5NtJ-6OmhKofvuRQK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")
removed dev_set_drvdata from the probe function and accessing sysfs entries
from userspace is causing a panic in the kernel (pi = dev_get_drvdata(dev) ->
pi is NULL).

Mihai Carabas (1):
  misc/pvpanic: fix set driver data

 drivers/misc/pvpanic/pvpanic-mmio.c | 2 ++
 drivers/misc/pvpanic/pvpanic-pci.c  | 2 ++
 2 files changed, 4 insertions(+)

-- 
1.8.3.1

