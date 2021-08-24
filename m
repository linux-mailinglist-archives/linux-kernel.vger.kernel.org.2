Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13C13F62C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhHXQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:36:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7980 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229569AbhHXQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:36:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OGTubQ014100;
        Tue, 24 Aug 2021 09:35:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jomAxZg81keF5iQTbN7qbY01QtvEVey070QJ6tYDA58=;
 b=c9MHn9QkfE4xu7363z15/ZTu+NYcY5oL6J8RhML7Ny7+Jbu1y28W+m8uQV6dnifDBjLl
 TUUqqy94wVvax/CeMBbUOgnaqltFdnuAQN/nyBiX970/8TLB2RZACYu9cy6EzxpM9mKQ
 KW+WgLRlwTyPKCR8XVXXld2Si5HXLZHeTUc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3amdb78ewt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 09:35:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 09:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHP7Go42w/fFAgHems0VmrMSiOJrTc+frLSkWDh5Zx5S6ZMfK4t1W4XGZwpoyc6rSzAKPBM3sGsjpZHw6gidxzCVPzcCBL6rFgp9+MezQ+ZwrTVlnXtDW6rW9W7lwkTOZuPOYbE0eeLGTdue6PJiBvJsAOD9CWuOA3ujd1PBr6MrOI2Vl+eVbrm25yIX6b3PhTDhp+QMphf9DuYwG8CXY2172NvG/kOE7IUuRPt4pbbFQg7QH1ax7/yTVUDUWNdJzO+lj7mXH/ObIN/haIXvDo2a1BKqsG4CfDmXUMUS24gim0y9lHrkBjerWUlzK3hWFyn9Di05bgHFotjFpGvoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jomAxZg81keF5iQTbN7qbY01QtvEVey070QJ6tYDA58=;
 b=nHMYVi04fmqiSoEt1DJlnQ3nRI2ckSCDAqDSqIwKCjYFO7y7MSyDjgz7YoZfTGa0jkVJmzNzY9D57RpIzBJMosB2H23QQkSHs0kV2wmkJkjHMvixQHcca9Kshyo1xnR0W/2j9lkV48WhFkUSvI5EHGcgViNLpvNjt5bUWrYhsXRrZcVswx/o9UtW6fGo0/4wqb5vQq5Dourxqdqgaw5WWRkyHO1UbzjFDwg50M1FlQVWO45SYrlTSRIsAtOMfhK2MuFoP3yjk37+a+vaKsQGWQMBbuUcYw3IHnmz9dRI241IgvwPbJj7orVOFJvH9bsC4ocabdZK/ERVgK55iOqr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5077.namprd15.prod.outlook.com (2603:10b6:806:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:35:34 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 16:35:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] x86/mm: add select HAVE_ARCH_HUGE_VMALLOC in Kconfig
Thread-Topic: [PATCH] x86/mm: add select HAVE_ARCH_HUGE_VMALLOC in Kconfig
Thread-Index: AQHXlHcfk9M8pCWIuEiEFbUIYzuIU6uC4y+A
Date:   Tue, 24 Aug 2021 16:35:34 +0000
Message-ID: <22FE49E7-85C9-440C-8EA7-4651B08B6495@fb.com>
References: <20210818212148.3927001-1-songliubraving@fb.com>
In-Reply-To: <20210818212148.3927001-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b60ae6e-bb8c-465e-33e4-08d9671d3213
x-ms-traffictypediagnostic: SA1PR15MB5077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50773FA799AC7B520A2E75B6B3C59@SA1PR15MB5077.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7o+CjWBsOkp2FsKxr7WWPavanGpz3etfn0TL5Z4cOcD/zMQvy9yLhZyt9Z2ZTpwm4LxoSP4WnKqpUrad94B/1IJ/rQisx/iFGVcPQR0Q2pqjRIhSarUXMNuho/p/XVpEAuftQGa6AR+2qp0/9fl/4c/yjI9KdgsCighDqw2dFFFXlbapkdXGZUKSXosamstXrp4xNqmxktoMVWvQfoh78qbUx0WOKcjLQFjMtS4y4GTxGbLlt782iTZMnttnErzoOWSWwi/hTe5jFxjBQGZtH5rcV090sWKtCBHyB4sclECbV5kpOBg9Q6kRSTf+iLSbeZ235GjjjxxVHzAnv4dr5QmPOhN8fl0EnHgXuPH7n3FgJDfEzwKFVC/zfGCntWwIl9wW0Dq+upIui0c92toB3P+QhtDqYldEPnwa6ElSJKfHYUhcj4VlEUMuux0qa3P2lW9+p1tODJIbYxLP1Fa5aG3poiu/97ZlO90S9me8/34sVrTxilHY+UoWf0cvQ3GHaUy/KOonTV4GQuBHjL56Xr/C1QMde7ZO8mTFu2kyohvHBhMmf5QPYlEo476WjcvzWjsUfxO8YyR+ymNMrlZcq+VnO+2xieFaIFxikN4b0X5m3REJTrtIH8DqRicQvQ3Ie77gRd1Wlw/0pJUh3T0EhU4/GecQPvxA+mtyqfJmCynvWDlStQdHrNBCEW2orPj2ES20umFPReeeyO3yqy6R9V5A0zR8yMvNYg03oT0bYaQOeEFjvTVVctpG4nLnhzI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(86362001)(6486002)(2906002)(64756008)(76116006)(66946007)(53546011)(66556008)(6512007)(6506007)(66476007)(186003)(4744005)(316002)(8676002)(122000001)(508600001)(8936002)(54906003)(36756003)(71200400001)(4326008)(110136005)(5660300002)(38100700002)(38070700005)(2616005)(33656002)(66446008)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FqKQHOkszxaydevAoZ4SUVWppUF4I39l4LtsGpRz+ZWyM93SYnet/wFS2mTd?=
 =?us-ascii?Q?3MlPeKBGElrhTmaq0sOb5M0UVZLNs+ZsSYBKLMyhmgDWd4lEbY7Mt1+KU4UR?=
 =?us-ascii?Q?IKA3QLYTzhDvr/43eYiGLNvappWHDPFn0gAtZrEZdp1SWiS3G8LojZGsjhFw?=
 =?us-ascii?Q?zOk/nB0Acj07/ola5Ccjt9lwdXgqyVgyZRLv5C7LawNHIIO7LImX7CvS/+jz?=
 =?us-ascii?Q?8IxcypxrYtgB5zn1DND93WSH5Th4AbhQndJraxYjcdfRdQblw7NqKA8NmTUf?=
 =?us-ascii?Q?XjD61DTrZyffFmZ6qRSr6s09RPtYp3N+PmHyH1NaTznZpeI9EPIwon1/vOwH?=
 =?us-ascii?Q?bdAOgdBpbS0Aff5cWX4+wtI+6TMpEDHd9QW4wvWIwy9Bf2IgZHpmXu+Ciy1/?=
 =?us-ascii?Q?6AV1pI6V52+zxh/H7PPEWkxF0unrAT37+uSgKDJhRLC/Gtcpy5aSVJgTxANS?=
 =?us-ascii?Q?kxlz50Y3qKIjbMMsFqj++miZZD8asbFi4X7AQvOrsTV9na38lASLdJes8Ph6?=
 =?us-ascii?Q?cK7tq08nqfHDekSdF4qUtlhzuy8s74+0tG7EeQ3yKpg215i4RSAaQjjIuKf2?=
 =?us-ascii?Q?dHDl7msnuJZCjKQ7YBZzMnHprH6jBTqM1pvCkrX8rPeM5N1JBE7LC8r3Ao0t?=
 =?us-ascii?Q?V/t+3wu/uE8CObit7ciNnPgmyqV9x9N90MTVKpPL4UAjFV3XLragRV6m7chW?=
 =?us-ascii?Q?fBWXtdP7nXrNkX42Fk1rzwZp5Xri/SWWG/gRCjR/2wFnBTUE5jb3EEcjfJwj?=
 =?us-ascii?Q?pnM5Sqz6CwD0BqHCMR1kgVdwW4R5qGuKpV+AMCRXxQhh5MkXbpo1TnvZ0KaN?=
 =?us-ascii?Q?8nu2Ji5KJqYL5R1zyM7zEZfJW4p4+b+3A44p1wL4D1SytuXF6ZMW100WmKXA?=
 =?us-ascii?Q?6JZ/fTJPKcaAYjFtXvrQ3Y9i47FP1E00nPN0RT/uALVxYX5LzPjzngYuxmRI?=
 =?us-ascii?Q?hLVEGvhwpmIbNJ0a53RqqxSxkXChHf8d/s1RyQjgAk+iOnVke+ADVPl+jY4v?=
 =?us-ascii?Q?ltas9n+bpWW0nKfdkWoemjyLld+FYIXv4bcZY/NytvbJTFXz+Al6mGVNAA3K?=
 =?us-ascii?Q?Jm9+GQx9obZRF75ubjQrD0EXx3fXU7WM8kVf0aiATtGmxh4xzHGnbpbL5nuJ?=
 =?us-ascii?Q?VdugNJlGog3tLkBi7pGOuhytHXe8x5+L5cwDA7qfBRZEMhXkgA35TX/mYJ4E?=
 =?us-ascii?Q?uDFCHOSXrg3WZq2travqwDtltlTbj8ElJHbg17rm55woKZOP2af/D0Td9HCe?=
 =?us-ascii?Q?zd3m2yJcSJCfJQX8avUa+KU9j4Ug58vTShjGNjPzKBAPS8Gu9+05/u2AHuHn?=
 =?us-ascii?Q?JUGG+30riTudiAjgCiMd0MaW0S4h+zT53xA7PtiG5876tB4J924o5D9eplgM?=
 =?us-ascii?Q?+l1odO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47813CF2D910084BB64554E6A639F5F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b60ae6e-bb8c-465e-33e4-08d9671d3213
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 16:35:34.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfhLDtT87tuo7n73AGpvxmtp3/fYNTdUL0ZG56IM1/xnGlVkLACHY08c+p9mCN4vEc9kFCYA7pX5iYQ4UyRRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5077
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: vw36GmaITg_kuPaGNqLMdQq2Iyw59NJo
X-Proofpoint-ORIG-GUID: vw36GmaITg_kuPaGNqLMdQq2Iyw59NJo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_05:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2021, at 2:21 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Add "select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP", so that huge
> vmalloc is enabled for X86_64 || X86_PAE.
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>

Ping...

Does this change make sense? In my tests on Intel CPU, vmalloc will not=20
return 2MB page without this change.=20

Thanks,
Song =20

> ---
> arch/x86/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a68bf2db0d3ea..6344c572555e0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -154,6 +154,7 @@ config X86
> 	select HAVE_ACPI_APEI_NMI		if ACPI
> 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
> 	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
> 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
> 	select HAVE_ARCH_JUMP_LABEL
> 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> --=20
> 2.30.2
>=20

