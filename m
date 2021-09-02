Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87D3FE63A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhIBADX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:03:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24088 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhIBADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:03:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181M6kR0004466;
        Thu, 2 Sep 2021 00:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WYZKuo2MAYemhIEVapj+f/601jsRfCLw0nm1y50cYI0=;
 b=K4CC64bY7jmfUFgy4saPe6ONsfUxHXlHtjf1rEYAaGa6U6zF/B4JnMjG0Ow6IuI3+dWt
 lNZW2li7XguazOJfy7dD1bViM4Yf/vQIzVwTU3tyKnreqtwjeB1QoUQQsr/0wuUuQKre
 +OPy2beg1Dgatm26w0e/lAzShBAguPLVteWrFFBheiiEoK1qy4WvS9ZNJESu+CIdlmAm
 eoATG7bx6JWjeK4AvZnGLsuhMklqL5kXNStZoaNdgXyd6+XlKD/jmsvaQM/AJtXAbQZR
 oqNWaN1/0J/KYpLEgAxXhHYfo3wfuZf+qtzCHuI5WD9Yh16mIqIhisxAora9LNbcQeIj fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=WYZKuo2MAYemhIEVapj+f/601jsRfCLw0nm1y50cYI0=;
 b=okmAPmgdfAOs98y/HBv2vyx1RsXsOzPVRYnVOqogzMdXIsDdaowmIwa7I2lOn6o6vP7U
 Dfu2o6ZV1mGN7w8+njEzotA1nGhJpSPyehNtJVLaq1PPc4LvJOF+wfOXL8Z2Kspngl23
 ozdhtlAuJjcVl5Jg4QuCRDoOCN2F6jwORr4T4lLyViuyLYQoGMe2vkWzqSnz+LhQJeqS
 S2Mtt0YYOeqyZNe6hm9bgWEl0C+x3px3xe8pMbYf8e+ZKmAMJi+UxYFuWababpoG9+Vw
 nWHxI5PIiu91LlZJcURMchzGrZj+02EUeIQ6swEDPnddI10DwimFhvEvc8KxeLBd5Pmh Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw18vs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:02:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18201p6s155792;
        Thu, 2 Sep 2021 00:02:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3atdyw5pgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyBy95cGT0/0B29ZiafisAEhkBfvWHPuHWrIgEEhtExNQYlYzc+Xlsa4ZokMzY53iWvpCB6kSIPjtEyLURv+dwX9h1qiH20S0ElsIrFWz41cncLsZPg0hUpkLcvzPkd03lbXID4KW04nfNuMxGeC6ThqBpy40WR29P+t1Mg8QDXrbeQ5NjOuF37Sf8tKYvXVPg0jIXlEkwmg8jGycTY/SvttMwc7oT9tKgwTGyEoauVtq0btzAJZarz1i4DGVWs69zAGdfuE+Hqrc0EU3wMrkM5J4s72Oh6FL0e8Y6hVWxH5yLG/jZrBvyzxpvS6OHOiLpMSENz7CHwPyTM2R75bAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYZKuo2MAYemhIEVapj+f/601jsRfCLw0nm1y50cYI0=;
 b=lVoucd18zbg0mvUAltnFjidapt5wIQe1oskTA18C4uOAEikcg5gn1FC/7tXL4l1cjpEaKHiMffi/qBnuLiuROKuMzEGSMnKBttcsExGlxhfmU2AQcMziygRG5GX2NZ88bDrcJRXZKCYhtvz/iGCtygY3uRXdOW1DrwZW/DGkFCJdYucbYLVxJ0ETGCWTM5y+N3SMMHxVUDiFaGadNm0QoALZCM27l0m62DjF0Eow9JtcXz0/nAYUoFJPPNqmtp7tZXudihGpsj/3bxdTMwdVkFU7ckBhhC0c1DxUoVAAN02pmPV2v/ZYHL5MNVovQ7/YS1cpUpCXYgWDi9taQ0Wfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYZKuo2MAYemhIEVapj+f/601jsRfCLw0nm1y50cYI0=;
 b=rpSoRyUNy13OGuC0K8So9XHyg1lT4Va8QrykeAo11uAcVOWX8TRO8Xst7jmZmzoXvom3OXGx/xHrJiiXrj7nyLEiB35S7Wfpx4vhh/a4V/sabcwVN32ByWHCChIf8tmps1uRVkp1clb9rXaCD+Z8WpgZ4Pe9PaGWiJMAxf0qOtw=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 00:02:11 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 00:02:08 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     vbabka@suse.cz, geert@linux-m68k.org, akpm@linux-foundation.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] lib, stackdepot: check stackdepot handle before accessing slabs
Date:   Thu,  2 Sep 2021 10:01:52 +1000
Message-Id: <20210902000154.1096484-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SY6PR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10:e8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 00:02:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d288b9c2-a36d-471c-b2dc-08d96da4e813
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-Microsoft-Antispam-PRVS: <MWHPR10MB19998D15070CE634494A6261B0CE9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJeCzcGm+xMYxKOdOrkHhpUbGMEkE9uQw/EdIOUyMM5S9OQJvnpLvopHvZ1kxh4l8HYa9aecWc/Tw8Ip7WMmEMXbHAeravUQsN7tO3+GBV2Lf6if6VoyQ0qHIIVmVbzSnkIdvpqsC35QH7Bn+2qb5dQNgmn5K/eYvc/NKMLBnkPOS9cSLeanTz1eCCF4hPnJL3rM7O7+XDX7NFDcJL1hTppAOwXedglrGzeaNOwwA8jb3yxghcovdCOvvOWrkBpA21Bm0gKJezbGX4GqZOHSVnSQy01IBMNuodZ6wLeVAtaFkFKkKnjEuC/6vooi/ITMrF6HoQbgLx5FL7b3kq5/WRZz75K4/njVo+MrDyHun2+7XD/vBv6sh7jXUdoFkrRaD5wC85BjfJCHNmIABO8nTcRUcGfqvAefEhd0Brfa9zMzISeQp8qdvhzP9AqiWTDvn5X9yTYraIpM9SEtWcdHnwTmw79vhSeDiuitsdT9s7GfsJA3hOQTvmRo21fq6l8kAdOwXV0cvVH+RmJ56BAx21fhQR1UWkPLitDieihC/8eGVN00NtbgMX6mz2lIXow3PGyyhjBxyqH8ZNOiz5MWthN7iP3jvWq9QE5BOmLr3tDky32oTk4A4Z+QeAyVo7V/zLKbXWISV4wsbemj7CYmijhhK41BthnZbghx3JufMfTpNWs/M8ed5NIEmmbcDJPbNLO7qIiz3+Ts6qBhbnBErw2O2NqFaK3cBSNEXlu1Vjy5PJDUDp1f71UmGnrcpDtegBCjTiBPjjei91zczsT8Zmgaif6dzf6GA0+zXGqkFFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(66476007)(66556008)(83380400001)(36756003)(1076003)(5660300002)(8936002)(52116002)(6506007)(8676002)(316002)(2906002)(478600001)(966005)(6666004)(6512007)(956004)(103116003)(2616005)(186003)(86362001)(6486002)(38100700002)(38350700002)(66946007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+7N7jKLH42+Ih5gVlN2xkmZR7EpJQfK87zoMd5KK6+GyeRFS5qAlLq0W4p7?=
 =?us-ascii?Q?6Ih9ZEA544ZP+DEUYnkU1NzLkIasVBOnJGcNbfy8321VfWHUemf5bKJtYfcW?=
 =?us-ascii?Q?SI5XsPSR24cVkoYefKc3U0uCD75ga/hvAMdOXpEIwhIlyPyejAZfaglugypA?=
 =?us-ascii?Q?ZHRH03LvtXCzSEtYTmSxvkVZJ6X3MMdUuAMGWAtLu70DXRZ97JF4gYxze5S/?=
 =?us-ascii?Q?AwwxLTgFgRUkE+OGYf+drpZp7ETOu2u6yxIclmlKSLu2pGeBOseZEoNTNVkm?=
 =?us-ascii?Q?WKLn5Gg2xptVVcv8P2QEu7JVxXx8Qg8u6e6laV/bXGvUd18ReagMHmYXfXrq?=
 =?us-ascii?Q?TyXRIuGMlaf6KDVMXQ1QbZdGaaxwQc5tEwwt9dmPykfgVvlcP1ckGDisFDgg?=
 =?us-ascii?Q?rxUj6dPchk0/4VQROYlS0ENAXrcc6Z/jBZi04pg5wfxpCFbyTuNY/IX7EpYn?=
 =?us-ascii?Q?3sI58AOUrg192W894ipemTUQtWUEbtpoOecBPYXfzreZDS94BRkyr2Om3uUy?=
 =?us-ascii?Q?TYwOvC01Y0sGzw/83r7LaBupk5B/aPBRQv8ip82aTM45VC/BHvBtr5suxVrs?=
 =?us-ascii?Q?2pIhc9qFHL+3rR+QMEWqRjKQVF6nOtSw/OOgMjUpxcuZuVd6ph9YKnbOI38l?=
 =?us-ascii?Q?XGTfMEkx0+3IUiQfVTlryRcAHb/8zQXz1QlKd07VKjZro0Kx/pRbeA40hgWM?=
 =?us-ascii?Q?rUPry6pzqlICgQBkcd1YEdmaK7CWAc38E2/6ViNQ5qGigTAZbWMSIYkhZDWn?=
 =?us-ascii?Q?Iba2JXBbqSkHpgg1mvV/S8cXGFtgP7tsxUvX/ZyzPdHLu82kyrD9D6k4snZ5?=
 =?us-ascii?Q?eua5wJ6km2xpTLgn1cGyXorqAT3k9ie24NIee4v7VntEHLbp7u1wrHZ/STea?=
 =?us-ascii?Q?6RH1RydmR31Ss9cvWNyTy8rsiE+qsrhwynGt6qSih0vhUqyBBEKDZMpBmfy3?=
 =?us-ascii?Q?bNwcwpXOsUrXPJRkJqzypxOatWo/pUuuN4utIk62ZEc4PtLLGbyDshN0SHTk?=
 =?us-ascii?Q?2/vumU6ggXyIOzrSw0PRL6TlftF0QHnEps787K690BOFn2ks+wR8s2x3hRoM?=
 =?us-ascii?Q?ECZkxAsCzYl6lcTXJb9pfyToo4GEq17irwYcMNbcQAkA7li4wjH/TmIi5Ohj?=
 =?us-ascii?Q?ZCxH8Tt7b6fqmymvhLZi+3gi/xryyYghPWpc5u540m65iMs33A3VqzziYGPQ?=
 =?us-ascii?Q?pgOlfUTWIqBkr5pra0ikPW+HaHhuGEQQ8mGIX4xI5GbBoiPJBr3kzD1wzPlP?=
 =?us-ascii?Q?M9AuODlcw8RJsnjp6URWR1irg1tN8UNz7HXSngzAn8JWeX2Mc+yw2MBHzCzU?=
 =?us-ascii?Q?6u3XZ1zI9XZUK+ygmDOoqgH3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d288b9c2-a36d-471c-b2dc-08d96da4e813
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 00:02:08.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+bDrk/t9sT/21zuvLCAB8xJ320MPczZKTxc39evlPP5y8wKuKlLv2JwfPmpkBaw/78RcTqEOuXzI5SOdyHqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=725 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010142
X-Proofpoint-GUID: NYJ8E80B7aOJGZVLxexfaWHlNpcC-9uz
X-Proofpoint-ORIG-GUID: NYJ8E80B7aOJGZVLxexfaWHlNpcC-9uz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original cover letter
---------------------------------------
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
--------------------------------------

Changes in v2:
- remove WARN messages
- add declaration of stack_depot_print in stackdepot.h
- make current users, which use stack_depot_fetch + stack_trace_print 
  to print stack entries, use stack_depot_print

Imran Khan (2):
  lib, stackdepot: check stackdepot handle before accessing slabs.
  lib, stackdepot: Add helper to print stack entries.

 include/linux/stackdepot.h |  2 ++
 lib/stackdepot.c           | 20 ++++++++++++++++++++
 mm/kasan/report.c          | 15 +++------------
 mm/page_owner.c            | 13 ++++---------
 4 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.30.2

