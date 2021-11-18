Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AD4564FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhKRVZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:25:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhKRVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:25:41 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIKYhqE027760;
        Thu, 18 Nov 2021 13:22:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id : mime-version;
 s=facebook; bh=Kxo8ANhWOqOrD9VnaMJ3OrQr4kQwQ0+MJnz90TykERg=;
 b=NAOQ7ZFNv58rsae548Rs/UOT0jB5zzOefE93WUdrsEnZM20d/X4DhmZYuabgboIyMjk8
 0TI2QzMtF+er6j0OJ+J/no75/H2KHcpEpTVXmIiFrA8a7X2mkLMCkdvTxG+4lrhu6ULO
 SjmH6oIhoZlm3Og1JocrK0GcCgfridwnWVU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdqp4kq3y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 13:22:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 13:22:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTfX8/cJb4gKff4Opa3NImr6MvWFnBLXH8jdXZkpmDPp7j/87oOseQuRhSLsxau3vRg7lUAHDvEesTVUaPm8FblTR+nF/Nkxb1c3YdqO53XT55zckLVrK7zPRfxKe5kDypQ8ggzDvqNaLDws3TJRUbxBydXSrX4alcQY8wdqWrq0kzj036mgzUSjnUEkD45KcgVSCYQD+p6FA9wOsxyaGLfgWfMviG6CZZqL260m/5uX3lqjdA2n9yfsBeBURTg7DSsl6jfktY5sw5e2Mo+d0vnR/NYGoXQB9Pt0OEj3YuhoubHXSHVxoZTbIIUGn1kFr3QKm9xL0GOF//no4WlQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxo8ANhWOqOrD9VnaMJ3OrQr4kQwQ0+MJnz90TykERg=;
 b=EnNKpb/GJ/fW1T7p2U4J05JrQP/rG8NW/qFaWgz3yRT5vGnSx+V2NUfkS73rpNhNV8stNzBweT8uOGHeP5HvGxQVws3/n6ie+UM9g+kNoBDITJWvE+jzI2OU3R1xkOTUiMcAYI51rPopb1OABis1tAsQgR0YyoEoVebZaqpjG9RtXjxpI6yOp8QSiKnvx4As77ebQNeV3JPZHylrsWoFkiCz9c50t9YRmyz6vdQAu+H7wYUl0HiHfwSbXbo04xJAlccd0P2zfe31CVdUgazhS3ru7sZVw6Tsz4puNxxXAcDY0CKL8U2P0d3s+bwVg6PY8o92ZfQhpBZ2w+/5IwTD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4390.namprd15.prod.outlook.com (2603:10b6:a03:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 21:22:35 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 21:22:35 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Subject: [GIT PULL] zstd fixes for v5.16-rc1
Thread-Topic: [GIT PULL] zstd fixes for v5.16-rc1
Thread-Index: AQHX3MJohLd7tvU2E0SoSeZx2RSNQg==
Date:   Thu, 18 Nov 2021 21:22:35 +0000
Message-ID: <1F7E17E1-9B51-4D21-B7FB-9BD3BE4A199A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f0a77ee-b4e1-44e6-86dd-08d9aad98a95
x-ms-traffictypediagnostic: SJ0PR15MB4390:
x-microsoft-antispam-prvs: <SJ0PR15MB43905C2299AA98BBF0974B7AAB9B9@SJ0PR15MB4390.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FyT2h4ByzoZfdnZjpAKpe5eUwRsnvf/SmtIktMxw3u/sTZcJIlg7vJSa9ctQ1k35S55L2mE86HIW/j+NUtghI34IJBxxk/lpoNpzGZxFM/5pHjk7csf0785u3MC4Q/0LQ9on33TKz9F6MWMiDpacYL7avpsa7gLoCl1RBuqnIfvgtwFp18qi+Kg4oZponQvsX+fgT7T6oV+wBMkDd38+tdyMAHycrTqh0ONh5iNx9Z5wxWiLOpd1k0ZuSB+xdvyJpEBmZuxDsAtflNkqRTLoxTH9tGAvB6m/REAp3zPe+nOIalXMPb7t1RDDpiAfj7q0QY73tLsHNKjlKql+7nLKWpcyrRGieGBB/4OjtWr6RfpJcrao1XPNlBQIAaH4aKsj4ryZSAJEjiStkQZB5SpQxpqhOc/umKfGl+3v+q51HxQOb+/NVgcMp1JquKuIwm4WK8pvgpH0hqWFVUWc2k/+Z6fvs6OPqo8gadXte8zY5BbkDEZqsxZ7lMdGkUlWfy8ow69az0Py1sX67aAK4zxKj2EaRvPv2rymJrqvjEKgbESYS3Ylv4pEeyUAGtmYjwYVyic1NytpBupjuM7um1YpasOSxBscqofaxUDDQ/MHQZPjsWX/hISpSQtJwQUmzno5t79I4tpPC+55sFk0c/TfyrrsvGCd9gyPWVDluaKFQsZVOzxgeEIEzmaHOs4ahUST+0DW9A27ZiKOYs83P+i0yVEWeAP11B6LSHuehdIPap7ykN1NympNyz4taeKLq2/JPoXQmYwxPAxe7d4wKRUMOjxakmy9B2qi5cM3fGxXDzC8BHFdj0ehA3KNb8zzjJ7meXfuAwyQ905tcadfLGY5CrCAkrKPQ8f1KCwiaw+7tc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(5660300002)(6506007)(6512007)(186003)(66556008)(71200400001)(64756008)(54906003)(66476007)(4001150100001)(76116006)(6486002)(8936002)(66446008)(66946007)(8676002)(966005)(91956017)(38100700002)(122000001)(508600001)(4326008)(2616005)(2906002)(33656002)(83380400001)(38070700005)(316002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wwCDjrAsalPu76qEeKdLx1jemVWZc7QCFwnAtumRBu/qK7uPdgTTxDIIYhdZ?=
 =?us-ascii?Q?U8VIs2R5vLFBKaMVkQaRCLgC7/7cg7HLO/T9lML7hNLJ22EsJLIzm2hqTZfO?=
 =?us-ascii?Q?UnjkOCKuSrDinlk8nzvZnmTOzfwWeM3bMBu+y0dZhGk868iuMgZANG5a8/Jp?=
 =?us-ascii?Q?y3WWHfsF7KiViKW+tTl8xGV+HxZeAISFqEoDUDpUm7Phlq9cdxDaHFNiIVRT?=
 =?us-ascii?Q?BZ+AMVCmvYQi2XCsqjNFhkrAdM6IR9XbUBmx70XXKWvysk5qQEjDxZqze3R1?=
 =?us-ascii?Q?W96DC0CHjlTvXyoTqIGAMWVpuiYBPYymJVZN3VTXm9DQrdjYAcnQ+xq9T0iK?=
 =?us-ascii?Q?sVLgA4RLc0cQIhOFeLmjC338OLuHPGvuc4jwL+GeB+unNId4rSTvi9ixBf1W?=
 =?us-ascii?Q?rUB+6upBKqgB1SjWJVwHs2b6bxEI2PcXE8yUq2Kc6mPnJgaUU672DT6g+waX?=
 =?us-ascii?Q?HA7RxIOTYdWJ4EYYZwNXszfnFHO3G6qUzlnndWrF6ZOWnguF3WuIG9VsUw9E?=
 =?us-ascii?Q?m3Zncrjlnl1xQKq6Xz9aKrVlxbVogDgOS0mltJCoHJVDjKNpTn3cI/6yywKz?=
 =?us-ascii?Q?t8Z+JvYTPAcFMcMVK6oNS1y0Vk+aya+WdEV9HvD7ykEObHPpAPbdJXlA8AWO?=
 =?us-ascii?Q?A4Bhq81Kz0Ki5rBKCFxzUa05oQS8EFm35Rldp3/XngH7k5LyP0O3c+wrrIg9?=
 =?us-ascii?Q?/EHYtIAWNYv2kaANSFDseXA9DZ+ZFyHoMYVsy9wv/hkmmZ17ROaPRoeij9XU?=
 =?us-ascii?Q?Bv48wmAhYtkELMtoMnxLqd+AvYnzgB0xQHNNRV6Ebsic02O6f6ip4vBgfH06?=
 =?us-ascii?Q?Z/oDd/mmRTPD6Gi1wm99HUOtCOw5OW0PRve9T6eaWhLEn3Zkc3aPW5ELNTJA?=
 =?us-ascii?Q?Jwg3ZqDbo+KSO6tUdqovrm8RbXNgU0DHO/NN/k28xxDDRb8R4o33TFpOV19T?=
 =?us-ascii?Q?bH2h/+DOww1Y7pYTgNgxiBTJ5x3wJMCwmoTMurcheND5RruQtB0eV3386HYh?=
 =?us-ascii?Q?Z8PIv/j3Iyaqt2ba1CAwn9UqOHiGmhkaE6++gO/VtKkBx/EPQ7EfMiqgxgpY?=
 =?us-ascii?Q?RyZd/ILMqV8mBErtgTmfDY1h/l0b039BHs/HJjdVhErdhVoLfc+18fVOGibh?=
 =?us-ascii?Q?v58CMTTtpcc8NYhhxSua5lj09qwUcuC08PA9j1lPPCLo1IiwyKnPz6OSFs+m?=
 =?us-ascii?Q?jK4RKHBpi/4Nh6Gbpth4J2XmoGg6ZiZqd/Vlqf8Zn4GfL1Abo3NjKmwdY73K?=
 =?us-ascii?Q?duETagV0t7P27K+EIWinRcssom+VhumHK4nZpO2ApcB0ljBkHnq4RbfYr6Gj?=
 =?us-ascii?Q?q/ioBOmiR626fUXSUVhrims8JV5N/WTOTU9JP87e8cJLDyH+XwV7/HXPLEZ1?=
 =?us-ascii?Q?pafTZzxg6i5trJhobMBH4q4++b/BIisRSaLRxElHLKvLWKIT4p2RUZudAlZv?=
 =?us-ascii?Q?ZdA/Vu4Tbt8ZlR1n2ZdWiC1VvdMpWNIAQbYwQY0rYWDglSWbqF+/c94oHvAz?=
 =?us-ascii?Q?FiDj1MqmNHg/TNXKtOIPmTkD3wdcfmhKyGWfkfpqeOpx6fO3BYOBv+2mPEKx?=
 =?us-ascii?Q?GpwAN2GfCiaqKCM8cEPBU9NfVu3MJWqsNRSTfz/UKBCDpftoqhEjyFaZEROt?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <046EBE6D33BDB74685D2B59F23BE9519@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0a77ee-b4e1-44e6-86dd-08d9aad98a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 21:22:35.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7cU7In9uR47D0NTOKSBHWfck4JnW/cP4KzMOYR1zyY451roaX1xv8TOUjXnDcbI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4390
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CRirX0OoM_5R9l-dWxVQkAnmDuu9ftk9
X-Proofpoint-ORIG-GUID: CRirX0OoM_5R9l-dWxVQkAnmDuu9ftk9
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://github.com/terrelln/linux.git tags/zstd-for-linus-5.16-rc1

for you to fetch changes up to 7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8:

  lib: zstd: Don't add -O3 to cflags (2021-11-18 13:16:22 -0800)

Best,
Nick Terrell

----------------------------------------------------------------
zstd fixes for v5.16-rc1

Fix stack usage on parisc & improve code size bloat

This PR contains 3 commits:

1. Fixes a minor unused variable warning reported by Kernel test robot [0].
2. Improves the reported code bloat (-88KB / 374KB) [1] by outlining
   some functions that are unlikely to be used in performance sensitive
   workloads.
3. Fixes the reported excess stack usage on parisc [2] by removing -O3
   from zstd's compilation flags. -O3 triggered bugs in the hppa-linux-gnu
   gcc-8 compiler. -O2 performance is acceptable: neutral compression,
   about -1% decompression speed. We also reduce code bloat
   (-105KB / 374KB).

After this commit our code bloat is cut from 374KB to 105KB with gcc-11.
If we wanted to cut the remaining 105KB we'd likely have to trade
signicant performance, so I want to say that this is enough for now.

We should be able to get further gains without sacrificing speed, but
that will take some significant optimization effort, and isn't suitable
for a quick fix. I've opened an upstream issue [3] to track the code size,
and try to avoid future regressions, and improve it in the long term.

[0] https://lore.kernel.org/linux-mm/202111120312.833wII4i-lkp@intel.com/T/
[1] https://lkml.org/lkml/2021/11/15/710
[2] https://lkml.org/lkml/2021/11/14/189
[3] https://github.com/facebook/zstd/issues/2867

Link: https://lore.kernel.org/r/20211117014949.1169186-1-nickrterrell@gmail.com/
Link: https://lore.kernel.org/r/20211117201459.1194876-1-nickrterrell@gmail.com/

Signed-off-by: Nick Terrell <terrelln@fb.com>

----------------------------------------------------------------
Nick Terrell (3):
      lib: zstd: Fix unused variable warning
      lib: zstd: Don't inline functions in zstd_opt.c
      lib: zstd: Don't add -O3 to cflags

 lib/zstd/Makefile                            |  2 --
 lib/zstd/common/compiler.h                   |  7 +++++++
 lib/zstd/compress/zstd_compress_superblock.c |  2 ++
 lib/zstd/compress/zstd_opt.c                 | 12 ++++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

