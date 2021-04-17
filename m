Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E864362E40
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhDQHPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 03:15:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhDQHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 03:15:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13H7A01X115870;
        Sat, 17 Apr 2021 07:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Yu8YYjqvKYSxUTWB7cXiGOpExHEyBoNer2abnR5NU/g=;
 b=SXVAHtnRTUeqkoOS0abSPuAymhDFaSfKlfau/mry4bQl53RWv4hr1hf/HkgD5zO+fuGs
 20nvGhI4q3kIYJyN0GRrl/fyu0ozNoDKr8SGztgrYwTkxXzFw8zBud4kXUuGZYASuOk+
 L0dNQKFk3cUniCpzn/ABaChTUz2NLE2lERI9yKpFAarZfoG5SlSlefpkFNqJRjVS/r8n
 S5ntKNlaXwlv1LUrP1qSYcDt48buS2++bK22U3J6i41HJbLvNU3OeufZIXkbZCtQUz4U
 XWIMCzAmUi5PvZ0qelV1Q2ccf3pjep/j3twWd03xGPzwM4F6bL7vk9+tVVK7sRNj/yi9 qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37yq3rr5gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 07:14:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13H7AZhQ051109;
        Sat, 17 Apr 2021 07:14:37 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by userp3030.oracle.com with ESMTP id 37ymssucek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 07:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj3Sdpiq/x1SRrBWy9/V60lpF+aXVyrF7Kl2CGPlIx6KU6UQzdCkzZ140WjknNd01tDGHCvrLMHyQ2C4VPERmHSc8pEDICOUr36H1p/uhQ1zRh0quiQBOjaPuOa1GZrAbqCxLG7k1lDLF3DnZKFPSpkJ601iyTfQKTgX7G/VIF9hs68xQB/woXjS/C/3cz1ATkMGFAcSaQY2m4s/tLNdazZ3HpRqW3T3A7qwNpT35qNku56CP8zRN7JN1/+DKqOAxOJP9kIXz0zfn7jwbJmZC5Xp9Vie7HAboDUyGkG2crNIRQsGtNKBNdpgflHWq3W7EKmzNR29JB6eyYX9lvclUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu8YYjqvKYSxUTWB7cXiGOpExHEyBoNer2abnR5NU/g=;
 b=nX/5jAbEK5wq4Uy6PBwA+5gkPQOd7in4kHhOicG1ZuDLbbZ26rMw4liI40H+tUpRf3rrpt0/xnNcDKjQ0UYc+FHWjoq/GxBIE8Y9wn1AO1ohELxNId/7zZ2lvIwL7Lcwp8J9HypdCdh2EPUhWuc3xljM1BEfejPJ7E0F7AXyINFXivwOqes3pIC0/clV+GgpOd3OG8zLfKnwyvF7Fe59Hof3h+sb4Mo5bbX7xipDw94ski4jyMOLG1oZ01l7trJAW+Et0qLmngzNM09OGv3N9nHherTJ9mSDFZJ81TOicmLjPCHRNxaOMnyZzFvhm6oA9iDne0aFAZzCeSlNOz6ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu8YYjqvKYSxUTWB7cXiGOpExHEyBoNer2abnR5NU/g=;
 b=mE7SyCx/O5Ej0phlq9ltvPTXooDfenEHrOylH7iR+zBMwdx2X5x0e3ZXZJqdK6aXJBWpGsqLbDotPv9xB+WtgnNcsqxXCvFV+EEYq1pd+pimP8E/U/bLVXm2lWJfw7dSdV5Ww0ntifJXH4qTCLAdIk3BTRc5nge4lRUQp402R/8=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1895.namprd10.prod.outlook.com
 (2603:10b6:903:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sat, 17 Apr
 2021 07:14:34 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3977.038; Sat, 17 Apr 2021
 07:14:34 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH 0/6] Constify struct page arguments
Thread-Topic: [RESEND][PATCH 0/6] Constify struct page arguments
Thread-Index: AQHXMxZ4je/lzJomLE2vlJJ6LGu94Kq4THSA
Date:   Sat, 17 Apr 2021 07:14:34 +0000
Message-ID: <D5C0B139-FDFA-4A89-8235-821747D8700E@oracle.com>
References: <20210416231531.2521383-1-willy@infradead.org>
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:d524:a73e:4ba2:9091]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0217a46-3cdc-497b-573a-08d901707428
x-ms-traffictypediagnostic: CY4PR10MB1895:
x-microsoft-antispam-prvs: <CY4PR10MB1895FD7BE67FE1AF99E6DD85814B9@CY4PR10MB1895.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFW/O9Zl09jEdYtmtQmwh4B8otaVc/6gcW33vGSbwxJRv120hXJWbTQsRHEi19FGCPC5YHdYiqRUZeI+e7WX3RUBq6wuNv3LWZ5bJOULUc/37OprWtsLxUVjY0Dc4JobthNRDjsQiDoKXqEZCk7OBD0kJUUkfy1h0HNy+gtUoYJwpvXrhdG/u4wB24yR/PQZqo48iccfJTKMZNRTwngQKvAV/3XGnMoyPPU1iTs9VNcz8q3KmAMVeLVgNwOZIzrOHnHRFAK4gNEFBXD6OxYioZAbUhzSWmS1PGjGU0Mr4SR9t33GXF1g/upikbkisO2dyPo3bbe3n65nyDOSMKSP1Uqx6zmMPXjv0Afo0ACUp21aWx+7mx9e+6xO/QLIKXpeC4JZyr6/LxoEZzwGos3wuCgmvCOyPbPKTlHVqHMbxRokbSgSagEKXmOpXmXFyp+PES42HXl/zQnnG8TWyOdbfm1gTl1dtLfKIL4TDNNDua18zF48uvNqWrRYVVpZohbNfogasqquFujHvIYQmMjyA3F6jwvfaqsQEVe7dLepIfqDYZO/TgtfUvAHMDVuJnmMFDjw3QbzYwEEUQem4b9MeiSqebbsAtQfhIeDH7M8n3A628HqG1X8FvwPkdVs6VEawAUgW74S6IOLmEbDerpYRRS0JwPvph1NrO0G0XkzQRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(6512007)(122000001)(186003)(64756008)(76116006)(2616005)(4326008)(71200400001)(66946007)(66476007)(83380400001)(66556008)(2906002)(8936002)(478600001)(86362001)(6916009)(6486002)(66446008)(8676002)(54906003)(38100700002)(33656002)(53546011)(6506007)(316002)(44832011)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nBdq90ve1BanrzW6rVvXalhO2vTOG3bL2xWQwXV7xDtuIxUGZit+1aQv8bFl?=
 =?us-ascii?Q?7WSfh/9fVDeTL5+O7ul/1wdD1H3QUwbFVkJulFRMtP16kP6AiYHJT6XnRNTH?=
 =?us-ascii?Q?brjR/erbMJ3PHBytUFoZwHSChdgLVIDf05WEFbq6cRupiYN8+JeqiiipTHUh?=
 =?us-ascii?Q?912HlSsq7HouQT9XH3b4fs1ICClLUYzY5qx2AO+bYAytQhtsu1vEFTGp5SAI?=
 =?us-ascii?Q?6sMxTbmzBtPp2rbvNgyRwWP3dfLfSDTbUf/cQvVuMOVqrtOTS+IKF9Uf9Ze4?=
 =?us-ascii?Q?iczErGqN89WCxC2h1zjIpJY9aFS2p7OhSHbH7UeeiA+PwncrbVS6s1qI4kPR?=
 =?us-ascii?Q?ym7p65/C/De0/W8DXVVQRvlAmIpoQRyBR5HY65Vsb8CAf/tjTk7dlCBLbEsY?=
 =?us-ascii?Q?JQLOUrpVtJC/+KgQ+GVR8oT4QuXyyv3rKlkiePBMASCEfcYorUhxSf+JAtGm?=
 =?us-ascii?Q?JEUvnInpnIIO+2KAcmVLsObBzeW9LCfWUxHu+IgIerQFreTOUrbwigyyw9nK?=
 =?us-ascii?Q?8h3djlfz6a29H+/MT4uCFVlrenKrYpAcqg9rEElrKiQh47vO1phgLK7j0lRl?=
 =?us-ascii?Q?F7rvXFzd7wp4bHUNBGhhWyr5Fz3Z/KZC6o/QAEUwMs2c8ZM6EhgiBpKRe350?=
 =?us-ascii?Q?FpAFqbttmIbbIMy+jbrZ5Gg8UlxlZB1SCpuRiMxbWtAxB0Y0sRrcMbf33agj?=
 =?us-ascii?Q?B1AkDD0k/A9jPfBb8qrpjOo86C/omZa0TGN44HPUO22U6ykIUNiqC1IUOoOB?=
 =?us-ascii?Q?LfNUgsijeX0cEvWp0mAoFk1PaP9JDlLNGonVhxNVY+hgtjvmWoIIRgw9FWj5?=
 =?us-ascii?Q?lgQDzyYznN9ZDRAUz2a+By+zZ7R3L2Pdp5eoDzzrYb99fqRghrQrxAMWfWgo?=
 =?us-ascii?Q?/3eL0oQsPfoFwbHuQ/X+Un6dFvOeuGSNTSXYmWC8ZNMv/7AAMUZi/Dim44Ym?=
 =?us-ascii?Q?EOn0+cna0DZdc42USB29uv5YmY2spvkCoBZ7TY77jn4fsxXuZiyAR0sgu0/N?=
 =?us-ascii?Q?4Owx5jFO+HHvTqzxqK+LNqCaQcL1mnjsmtMzDUnxyiEoWJXLVaSSJWr/YDEz?=
 =?us-ascii?Q?g1jQgJaYg0UZxQ71g45gxZ+C/vLinWGqqbmYoq02Zxt4AvjtXVIlS0qxHB3Q?=
 =?us-ascii?Q?TwhY/oq0MApZOyz840OQhBc2XNES1DnAEMYgbrlV3CYWwe2J6FshDghcXJks?=
 =?us-ascii?Q?zWaBbP22+iM0PBHcP0wAAiV2R3gmYJiCRM97u0PEoSRC6lUsy068xEeHbTIm?=
 =?us-ascii?Q?WO3zKJcR+pk3cfjeiSfm/VWVKJSbkjdi9oTZRFQfgyTRL8BjXI7OGoAe+oRQ?=
 =?us-ascii?Q?Ub2OSZALdpWurzCcMv9k8FdEoZhCUG1GjNuJh0CgcZyML0UwvDhyxxtf0+mW?=
 =?us-ascii?Q?t6Fs7aZ5ZpNDlOsmTm9X7KPy7drs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D72B30980EFA1B4EB61DE5E741B66568@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0217a46-3cdc-497b-573a-08d901707428
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 07:14:34.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0nOU/XhQw4fwU0D6I8ut8lhzR0u91L501J0jBUE9X6HZANMG2Q/zdqnXbEwbDwEgWFBI4yeh7vH2vM0Be27nYSD7He2F9V3zWaZl8rQFAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1895
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170047
X-Proofpoint-GUID: DqHg4wvapW18M7tqBsvHw_KEXbQa8qAV
X-Proofpoint-ORIG-GUID: DqHg4wvapW18M7tqBsvHw_KEXbQa8qAV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me and I like the cleanup.

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Apr 16, 2021, at 5:15 PM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> [I'm told that patches 2-6 did not make it to the list; resending and
> cc'ing lkml this time]
>=20
> While working on various solutions to the 32-bit struct page size
> regression, one of the problems I found was the networking stack expects
> to be able to pass const struct page pointers around, and the mm doesn't
> provide a lot of const-friendly functions to call.  The root tangle of
> problems is that a lot of functions call VM_BUG_ON_PAGE(), which calls
> dump_page(), which calls a lot of functions which don't take a const
> struct page (but could be const).
>=20
> I have other things I need to work on, but I offer these patches as a few
> steps towards being able to make dump_page() take a const page pointer.
>=20
> Matthew Wilcox (Oracle) (6):
>  mm: Make __dump_page static
>  mm/debug: Factor PagePoisoned out of __dump_page
>  mm/page_owner: Constify dump_page_owner
>  mm: Make compound_head const-preserving
>  mm: Constify get_pfnblock_flags_mask and get_pfnblock_migratetype
>  mm: Constify page_count and page_ref_count
>=20
> include/linux/mmdebug.h         |  3 +--
> include/linux/page-flags.h      | 10 +++++-----
> include/linux/page_owner.h      |  6 +++---
> include/linux/page_ref.h        |  4 ++--
> include/linux/pageblock-flags.h |  2 +-
> mm/debug.c                      | 25 +++++++------------------
> mm/page_alloc.c                 | 16 ++++++++--------
> mm/page_owner.c                 |  2 +-
> 8 files changed, 28 insertions(+), 40 deletions(-)
>=20
> --=20
> 2.30.2
>=20
>=20

