Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C21411B16
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbhITQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:55:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:1504 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244593AbhITQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:51:16 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KGiPZ7010607;
        Mon, 20 Sep 2021 09:49:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=30zwakarzyRdEpNCmgJVJ0S2OTSL2JGTqmbpebtF5fM=;
 b=B+u4lAt4CnApoEVoJbHaNFjjQ7KSOIs6WxM1Fd8ovuovpB7nu6pdO66D599VP1zn83DH
 kJEvHWp8mEMrz/UcO3BPyZ4FLN4LL1l7ZpGLz5WN3wb8EoTcUMBeo5d4d+H0ssS1KwAE
 +6fE29vIslWNIwsFFtasbIuK8DGpTs3X2JqbOQW7X/fvYVX1ewaPZmYiaVt1mv/j/CDm
 cwWKD06AQL5dM8ToKWSFawIBvqmuwj6xxh83dfVeYrxObiCHvd4MHVc/lFZtxTBXmEpg
 Iv55cAnTF8K7Xqu1wwrj5Mnma4TESMO9FWsnhJ3u44lpyTkkmXA1gWQgLabe9rytOsT2 rw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b6udkgcgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 09:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvSE1gmOdW751eaWRsvfxZ6Vgegr+46NkfEozSpOUbNZ6jroPnSjB/9hjCoQF9m9fMHgtmHOV71UwCOl+av6H0BE98obaOk1elWR2VGjVTK8CoftD0aIx9Hnd23cHe9v/AU+gGMhEaq1EsM39HEg2yfnz7/gY1u3kVTMfK49r9EUlaqw6l44uafNjG+7cz2NfARzIcUIor+JJ/1u4SbVVCcjjkzu2Zw7pNjmJD3jhRXxIZ2odQPC5XuzgaFRL0AaageJWfY0GtStilFSIWbw9Ih9IdKblNIpNUiDB0S1EGp88AeJHWKngjq0Zfm3f76xd9iLQw5QPXL0KYu5TFI4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30zwakarzyRdEpNCmgJVJ0S2OTSL2JGTqmbpebtF5fM=;
 b=V0IWzrvNoMYImYp0s2MmdUlAO2y9ubOu/2CzI6BQr7rSHaaXEprXoroYW99UqWdkwAROHvQVGEmeBsdXk1IC5YfhOhwWd50ZvqZUynCTqXYcEkZiYjiesiWBBF1rbaHU+zFfrYZPnhG0VnhITcBKG+T1lAnvU3rLmKnl3QKQIWJpxcHx1q4EygbEL/k+JnO2wzf6ZKwNiCwE209so6Lidme/I33iaQ8rTld1f3ZAwD6qKlwlHfNRntj1Sq9NPAxUzOXx9RA7PMx1jZa14COq4bQXpIY2yzYkpXIjJTOcQp5OOJJs2SD+XMcR4YLJCjeRMGxISzCbWa1Xq36okgdTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6953.namprd02.prod.outlook.com (2603:10b6:5:253::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Mon, 20 Sep 2021 16:49:42 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 16:49:42 +0000
From:   Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, peterx@redhat.com,
        david@redhat.com, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [PATCH v2 0/1] Documenting shmem as an exception case for the pagemap
Date:   Mon, 20 Sep 2021 16:49:30 +0000
Message-Id: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.33.0.363.g4c719308ce
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 16:49:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8637d80e-1492-4c7e-1816-08d97c56a4db
X-MS-TrafficTypeDiagnostic: DM6PR02MB6953:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR02MB6953866FC763415C41D421F3E6A09@DM6PR02MB6953.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrRMt89QkB5blmHbG7Y5p8S3KOsofHEvaEkvgxmHdbFkUS0iBsip4lcUPn6M1JgMxLhI50rLL6EC2d0yMqWY+G5HBYB+deAEhPprXb9C3Dx5m05KI6ammcwWjZjmCL2zkSCFA8/rN6yANdJk5NzrUCBO9G/JzWZD0hmDXPRT1zT0Y/zmo6TCbXFP+hP5BcSD5ibnrqhaZ0dR9GCEJswCHlL8ltUZ1HttAanJA37oG+wKjnGQ0UGHAf5y9u0HwNvhSUtLZ55yH50xsDIr/JOdCW1qIGzFXCUC2iON0yPjc3MSLo/VbtmoOvxX9YftEB0ytJAUFPPGdUO3OLjiTCku+kRcDIdtvryjQfIo+UkO2kHW9cyB2J5JZsjhjCNOV6gydry6VanPc7tk27CtrfAHLQTabO2HZl0ZS39ZToQrRuhtwJH5FQPQBl5xI6tCLxCv0RK4wuIEttG8HiSP1o9u0m1ayDskfXEcmibUrd5ZDHSZfliq7rmpSu8e2JfiEeLuAh1V009TdeJ1K9MtbkqZ7lJU/hMnudPJLSF0NbrlQ+3H+NwLoPU6GCnW8uAjrZT293WWIXAg5wQYa4m7hp7RDx/FCY7lhAVuveIM7Jwg/NudIx732YkWGq0AwUnx8rt4SGi+74MbaQKyFT6RYnLsJkit6zP6xToD/fsjlp05lIN+PxV+JXKTO6l4E/Ox7UABg7ELoqb95ZXZbZ3O7gAMZSdjD/nno5wfM+TmghVtFsCegxgmg5KV5w1jGZ3Mt6AhXtJfxOTwemWpPJ7ditr3dlTFP+Sk42+vp54VsJGC127o42A1qSKo1J+aBE2cuu79uKr/ZLONxf7LbdkHGhkH/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(2906002)(5660300002)(86362001)(966005)(66476007)(6486002)(4326008)(36756003)(26005)(38100700002)(316002)(83380400001)(956004)(66946007)(52116002)(2616005)(7696005)(8676002)(38350700002)(107886003)(8936002)(1076003)(186003)(66556008)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MB/WGb8mnUqDgzvc62UhqDssa1clLh6aOcLVCZ3dE2Tm/tcxeLRRjrJq95NG?=
 =?us-ascii?Q?fJbUQmPfK4iZvfDkr8EHAUuco9b3EMUagHIOcMaRSs5kr7R4O9g4wb26NDQo?=
 =?us-ascii?Q?S68I5V9H+8bb9vyAcwlxL/CNhmnE9cvalGTGS4cy7sLcMxZ3A/ppgnHOtIc4?=
 =?us-ascii?Q?9TzDc4X7ieN4UmSZRZhfvtnhE/xobZeFp86lzPPq8TNCX5rKUAQHcD7u9/kM?=
 =?us-ascii?Q?72dz3ajEaVRofrzVWOr5uWHmPsi0JdgAuiPjmejJoCUy7YHruZXRSsbdLjCW?=
 =?us-ascii?Q?XNa9HA9qFw/L0gsSbbjmTAPfl5ZjnrOlyPg5xYZeEj7KIn3eJ9Q+ItlqiM4y?=
 =?us-ascii?Q?HILFi1rxQhRKoCQwpCVKBxc1yk5j+MgPJhH0JthhmyYtzGV7KcM+jR3z5/AT?=
 =?us-ascii?Q?iRqJvKVpen7gatAInLaBwxhws51OnCb5jvAnFUWSYn+JOKXDBm3M9kXcQVGC?=
 =?us-ascii?Q?O6Hy4sP0mA7AtymQ0JQTb92ov6DquS80AcU39BEtEKNmLaNzZyrUd6xdrujI?=
 =?us-ascii?Q?5uKQsxM6BiLn5XDJAeJO/SwnrJtqi13shWzSsy1oYfumkajXg08WaaZsJ/B3?=
 =?us-ascii?Q?JsoLswfSNieG3es4qvsHbG9KoICWLBfr35lc2bUC4zIATXJTWnEjD3d5IVEg?=
 =?us-ascii?Q?SShNndn6jMheE3J5iyWgJUsAd2ThHfsyFKScPNCaAclVmgN8DCYwQs45l09/?=
 =?us-ascii?Q?t+g3dVG3HxW3EGqeFRh+Dylx2drHj4qFE0q8BspxSmsc58gMFfkc7+OGzwad?=
 =?us-ascii?Q?VNUZG7SBgLqCQYjjpCrckGEVHRQD7uzRPKrcg6AIKBstDeof9mU4wmTM+xas?=
 =?us-ascii?Q?nF/XehM95WEoYGaqVVbRKsgwwIFCUklujNa1tsDMBMQTA9Esosx4zcme8Lz4?=
 =?us-ascii?Q?LGk0WCWJrWRnTTYkXOIHEXc4B7VQSMY7gt63jMRRvN6DWfpDJ345SZ7l1ouJ?=
 =?us-ascii?Q?XBdFWXVYNiCFiQm/dhqBtGSfKyM0m7uFHaOXWiZz3EkOzH3QQHaFkCh592wH?=
 =?us-ascii?Q?4Yjc3tC5vdZTLrdXGHJk4gG8xcqGgDTIpi30MzEmTZ6J5PlsS5qtDeH5y9A4?=
 =?us-ascii?Q?APUAscj96btBBAn8MyvY0WqvvsVq1YImtmUHOdZMKW0XKuoSpOhO4U8htKKA?=
 =?us-ascii?Q?apDfmIdZRGuuv/RC5+x04lP+nEyF+DtHQrMw3Vbd1TDiQrKJTKZGiPZtcTkH?=
 =?us-ascii?Q?O+jP5fE9XTIhb9spoMyuGdz77nNgpOAireRsO4BBE74PyW+dE8Mvk6QYyUeM?=
 =?us-ascii?Q?d4Iai8IF3ffZJsjUZJAfLOeCkwiweu11r8SNZtYReUmo4Gg1P4Y+YdKDVxIL?=
 =?us-ascii?Q?jKzi7gjY5AVQwO2IXQVvHehD?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8637d80e-1492-4c7e-1816-08d97c56a4db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 16:49:42.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrDPZSMlIWXwxosu7ciysjPtNH5wjV0DZqDyiu1S00K0vqi6kmi6Cb3dQnxFSR4S4row4hhq3w+OxjrKpnfhVb/zJwn3bU74ulAGA3a5hjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6953
X-Proofpoint-GUID: DGnDJnLsIqyTQ3h3Q2SmQWgkTDdpRXO-
X-Proofpoint-ORIG-GUID: DGnDJnLsIqyTQ3h3Q2SmQWgkTDdpRXO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch follows the discussions on a previous documentation patch
thread [1]. It presents the exception case of shared memory management from
the pagemap's point of view. It briefly describes what is missing, why it
is missing and alternatives to the pagemap for swap info retrieval.

In short, the kernel does not keep track of PTEs for shared pages within
the processes that references them. Thus, the proc/pid/pagemap tool cannot
print the swap destination of the shared memory pages, instead setting the
pagemap entry to zero for both non-allocated and swapped out pages. This
can create confusion for users who need information on swapped out pages.

The reasons why maintaining the PTEs of all swapped out shared pages among
all processes while maintaining similar performance is not a trivial task,
or a desirable change have been discussed extensively [1][2][3][4]. There
are also arguments for why this arguably missing information should be
exposed to the user in either a future pagemap patch, or an alternative.

[1]: https://marc.info/?m=162878395426774
[2]: https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/
[3]: https://lore.kernel.org/lkml/20210807032521.7591-1-peterx@redhat.com/
[4]: https://lore.kernel.org/lkml/20210715201651.212134-1-peterx@redhat.com/

Kind regards,
Tibi

Tiberiu A Georgescu (1):
  Documentation: update pagemap with shmem exceptions

 Documentation/admin-guide/mm/pagemap.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.33.0.363.g4c719308ce

