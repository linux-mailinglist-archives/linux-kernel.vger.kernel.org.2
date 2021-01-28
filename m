Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE3F307E05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhA1Sbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:31:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46956 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhA1S3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:29:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SI4oaA103039;
        Thu, 28 Jan 2021 18:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=pYzydHr2+BwJlvIqnZ7iliz/r/uJxRzgqJCm9FWYIME=;
 b=cPHw+1zvdNNSrSWqz3/gKBtvpGuXobEmw7snTnCwdgi2+H1DpfS+1AcZL7tjPYTRXUKz
 mFsud1VxZim/nnv1Z2fH8A9TZgr9kM7yvos7xRAv+X2GiW3cTo8pHXvPJYEH0R9egG7x
 xj+AHsldoRM1wIiQgWoinV0YphZAW7jCwDgCSrk/5J3MeBJnIQCIGAqW0en5Q3WuRXHL
 GM6+Jbc8GyK0hpd6NDo9tPO4Ub6XuOgAZt4YMNMitR9la1YS2DkIGBymebo8XAB39rYK
 CAs909i2OTbgMUWgff6kHwZqmirc7RMMsLqYEWzFdWmo2PqCARh3jk7j9bJDE/71IdGO FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkwhk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 18:28:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SI5Bs7003546;
        Thu, 28 Jan 2021 18:26:48 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by aserp3030.oracle.com with ESMTP id 368wcr2fyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 18:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKSYmfmNya+B6/pY3+c5HBoTC/vQ33ZyMqd0HzvGnOEJY+3Rv33bwlqPf9aQCcw4gu0wzJImq6+4P3Uv8hnbKpxOF6AYVfB2qIq+LOhxWBpcnweNBrwLD6GAleCDaSlZ+fsEt/SJl6HkVEVWVWl7QNQc+WXYBS2See4F5qEZxljhLgIrWEIEGNPWg6PNv+rFIijGiNQvK2ptjnWyNiKiURowc4roUn8XXR+aLAGNW9SyckFeFSlAfan2fCcjy1zEIzevcbayFrpnwuf+2iBuYA54dszWFxNR5NU0/r72Z4TI25x0oDttm7+gwHQNNwD9uKcDgmo5noCTiQUFqyoV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYzydHr2+BwJlvIqnZ7iliz/r/uJxRzgqJCm9FWYIME=;
 b=OHWgzoRyAhibutd9XN1VRO12A9tXVlMlqVn5FACbhLlHFv8oOdo6eSWo8fiWbSKyEFyjvKpVMLc9TPU1fIG3lZ+kUHbJ1gOvm68gVfRLUJNTQZXzAgDGElooW8tT+Gy8XyhGQMFw7Y1mzrYYYIHbGI1GWQ46W6MgizU02VR+mIlmuT/J8uaYl86dNNhtd8vZQetc9g95Nrw77HHd7PneLti/cHDVJLCT4ts0tKMRweaDcLcnPaOxPkDIvlGbewp8Gqj1MBhJGIi6jGlh66Eanl6prrbyez2I8KbqmjUZci8BuUp0uF3y4LZ59IxaRo+l3t1YxWPhzQSQ3OZyN3hlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYzydHr2+BwJlvIqnZ7iliz/r/uJxRzgqJCm9FWYIME=;
 b=uDgy4XoCl5s5gpQ9xhPjgu5MftpRz/zfyDEvSG3ljubFoEDql5uwH6ERV1Tx3Ry6DA+z8eAlD9dq7rNZ2SZeNH93WTTJHNZMCWzBJ+Qfv+UyeWJRh1Ou/O4Tn/suuUOFC0fDOZFhIVOJxy6X5j2rgckuAhLwXoL2pZ7XY0AFXy4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2822.namprd10.prod.outlook.com (2603:10b6:a03:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Thu, 28 Jan
 2021 18:26:45 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 18:26:44 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 0/2] mm/hugetlb: follow_hugetlb_page() improvements
Date:   Thu, 28 Jan 2021 18:26:30 +0000
Message-Id: <20210128182632.24562-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::26) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 18:26:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e71a20-272d-4cf9-8d1b-08d8c3ba43ac
X-MS-TrafficTypeDiagnostic: BYAPR10MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2822F7707440EF7909C43BD5BBBA9@BYAPR10MB2822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6brfqIEE5+lE4nwDa3x5OCNd2L6YXtAs40gYK7JtTPO24fetvYn7N0WWtZ44HOoEOtbcPT6PfZ1ebISiMXCaHsUGkGLYSq6nBe591z3ocUQ15Ek9M+2yP/YXDGLUXXsyryG2ZG+uFvfluAWAfKARLK+XzYK5tLp9nkw21uFSwjkg0J+Zvo9UuRkQeFSUkdHcE3pu/QW7dWZoqnhFtYM7iPjnhKhCmH2kQcmLZjv0J4wRWooM696EFYR3g9ZN1TS0yp2TM/ppUcsTKb5ljpxsMrreWSnRDpk+qDhGwiETx+a9XE81S/1WVz7AcQS2WoC/BYwHdn016lFtwK1HMoFTZgqTarYeK/r0xl5fAgkUs/IUiTEJ+qBVHZ68DD0ZHHva236cxvBRhSQdNVbwS1v+fpgbZc4NQ9G0dXqjbXPm1LACJhW38bQ6vZ6FNjHcjtlvqfbbWbo+ZtAvru4VrBT4nhG0tN7+98QuVd6EviO6HHBfCWFccO/4E2Ck+WIbfI4a9xLZHQpDkuFjmi4kSa7GqxWLXoujgnZVZzaM+kteWWku+aSbpivnwLSi6ORnOHTI0CiAFyt7t//ZXI8FEqng4a+5anpXS3dnZaK/KBwtLLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(66476007)(6666004)(316002)(66946007)(6486002)(6916009)(956004)(478600001)(8936002)(8676002)(66556008)(4744005)(52116002)(2616005)(1076003)(7696005)(103116003)(107886003)(86362001)(2906002)(36756003)(186003)(966005)(54906003)(4326008)(16526019)(83380400001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N/gOpDCJP5gTFg8/pC61Vbcau0kW+IvsiXpEGIK4VcrsJgF/ViHCXLQtHW60?=
 =?us-ascii?Q?FJj311VwYYgnb7PqUA/m50V6MDCe5gS8d/9YKmBwEaYtPENy8Tkd2jrxh+Mr?=
 =?us-ascii?Q?LnKonUhB+v9/bmrrbRD1ztlSAuzVuQQRaWdYJSFq16xdcUe4y0adnohx4sDx?=
 =?us-ascii?Q?I9Ad8sYcf41jnpoDvr1mpMlNy7wZ9PxECthQKN4gnbjJpabpSmFK615DirHJ?=
 =?us-ascii?Q?Rwcp78ewwnhtgVXxk16j3tmJgZetLiARaxqPTWQCZs3glfzpNCBohlAJHd1D?=
 =?us-ascii?Q?baiQFVZewERUqg1Rg9B31MatwQ36N8zM375YCoSGsvodhxpCuz6+GgCAIjeo?=
 =?us-ascii?Q?XtFxTC9YUKOi7J6b0obENxPjeIXZsdcchhkc923JiJ1tPQvDaYy7NFzX6gk2?=
 =?us-ascii?Q?YlskdQVmrTmIxuUBFzzPpvuV+g+MTbQpq/kJJn2z35Wjtms7ojNeijFdvAAc?=
 =?us-ascii?Q?SYCNS9OdMwxoQm4D0KolKhV5bWKGrz9xO/EeAT378MRpIkVgqiD2Noj5glS0?=
 =?us-ascii?Q?cPrxaK7v8jQwRH+eSDEnSnBH4zPWJ8cP1xSupS5EbRfVdQY3St7aIFhrHc0o?=
 =?us-ascii?Q?cPpBIYeB4oSq+GulBRw+d5wbNmpXvv3MIwU//TtRyI5SB8ClzAJ4Dg2iTRUu?=
 =?us-ascii?Q?JF5A72cTHddgo53yWPYILKhRtREj0xy4Cr13LgtfpNCDZZmd+ELoAjiNOqq6?=
 =?us-ascii?Q?d2Tj1LZGI6gP2w1LmlFdn1vsYHN1X2Vz0Fn9vyG3RhMigaygdCWSsLZeXhjf?=
 =?us-ascii?Q?zEwuVz1HkV+ZLawbtZ/Exd+dEySiR5sDM5zgOouR+Ho46RfuQ36EqGvAsvuS?=
 =?us-ascii?Q?9MemUd0eB3QMqITOjBBQsnlHePkx1IuxTinksCYol1uN/1FUrQgD2B/ALkym?=
 =?us-ascii?Q?1vXZ4N0lVl5g4oWlHUpyCvFR0i/mXfzcm8bjlphNmZrz9irv9unsgr7dTyE4?=
 =?us-ascii?Q?UfadxzL7MkMi0ydfP2UOakhYzs4GvP9ldFxMSW3JsYI/Bo4qbfEKYfOqgJnW?=
 =?us-ascii?Q?7+o9cmtxl46l7kzxvrkwlJu+w+7oxoj3gooPXSagL+uyrkPJFbt39muFmlgh?=
 =?us-ascii?Q?npo/EnPF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e71a20-272d-4cf9-8d1b-08d8c3ba43ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 18:26:44.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7e/TLOovTDRurOSQojDkQJKfujXv3fzDt9Cus+0/tt9JgpEtUz92a5xd6WeDGmxMC62RO9hWlcGE4ViAr+OWpOXMtkzYvdAG6RBiIk5fxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2822
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

While looking at ZONE_DEVICE struct page reuse particularly the last
patch[0], I found two possible improvements for follow_hugetlb_page()
which is solely used for get_user_pages()/pin_user_pages().

The first patch batches page refcount updates while the second tidies
up storing the subpages/vmas. Both together bring the cost of slow
variant of gup() cost from ~87.6k usecs to ~5.8k usecs.

libhugetlbfs tests seem to pass as well gup_test benchmarks
with hugetlbfs vmas.

v2:
  * switch from refs++ to ++refs;
  * add Mike's Rb on patch 1;
  * switch from page++ to mem_map_offset() on the second patch;
  
[0] https://lore.kernel.org/linux-mm/20201208172901.17384-11-joao.m.martins@oracle.com/

Joao Martins (2):
  mm/hugetlb: grab head page refcount once for group of subpages
  mm/hugetlb: refactor subpage recording

 include/linux/mm.h |  3 +++
 mm/gup.c           |  5 ++--
 mm/hugetlb.c       | 66 +++++++++++++++++++++++++++-------------------
 3 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.17.1

