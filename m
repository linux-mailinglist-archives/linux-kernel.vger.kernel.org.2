Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02537F4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhEMJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:14:11 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:47287 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhEMJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:14:07 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 05:14:07 EDT
IronPort-SDR: Aq+vchCKoSgDpQYdsEal3gwJzm2DcWZwG5yGag6Fyci1XoB7UgzXHMyCReceYnPYHVJscd+9pb
 /ZbDmRSbn78X593sc/XjTwNrOgVKNxLXCSTl84fbcVj/NzYVKGbl+LuM3mcn2vFPUSthmRbd2k
 9/h5U4Rh/w+kvmKJA/aYs5m2g6tgogacTrz3g3gfl66JJ2MHFgt0yr4Yh1xyOKZ+RYWxiyzQa8
 FOoMdoxH/YEedZtKdHQ8nan+Oei2kSONHxyHzomjlmzlIdW4SCb3UE4x4mXBEDbtMy5AR3gyUr
 +tM=
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="31378219"
X-IronPort-AV: E=Sophos;i="5.82,296,1613401200"; 
   d="scan'208";a="31378219"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 18:05:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc7lPnp3I5qWKYMkqr06uZ2hbc2Mz2iorwDvmCZBIka+Bwuy2rcE3ZtBDtagRWTikrs3dk55zFXNCKqgQ5RB3eAtvQBwguDmh9nCKN2atzXnJGZwRgzlZyKCghFWx3lxQ0v04SLLSszZcWm97g51gKZMmDyAuM2B1Wi8ZbMSAdSwAJDIOwZqRrEyyHEx7Y12SVA+PhANDFAiAvD+iSKUAmPAnjrbNzR54/NFlfZDs43iSGkw8ThfkwWudl8Tg2hKeznq6cdCIE8mS2D12sbVW40jE3JfIJopxqU8ppHfhG6NSJrPXRJOZK9aPhmdSBkpxNcCRYFbi6gTfom7VwFqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69PwEob+KnrCl2OTtTr5gKIQDlw1zMGMSnAVJ4gD+R8=;
 b=Oz8mCtrHZhcADZ6UzwREkp4Yoc/RzWWjinA0Fk38J8Jg9Z6yw8TaWKc4+FkDKM/fBuRilMBXvZP7tY9ILy15S4niGTzCQM/CqrUIOKrqSNlhXLxFnZyFn5heMzVWWSmsrxYhJ9LlnRUrZPtbk5nKtwY1aYeocRWr8tcb4ws30VuabQsQQhCiSAHJ8X3p+OkHJd9PRTnojHLH3w/Nkpg2TqiI7ysG+PpY98XxE+x+baC+yI5d9vd+W4vKP1LyjqxyJeCcy9bdjPs9miyRQ4hSu4tHGM6NfwltlJvGnu76ufdNGY6rgdB1jz2LkWFDLtMfQFtBg8ndxH/IgBnuN2NNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69PwEob+KnrCl2OTtTr5gKIQDlw1zMGMSnAVJ4gD+R8=;
 b=Hik5bdMHutIcXiUo7XgmDPeJ7c7CQ1kuEWw667L33W1vH1z2KorA3VDFOg82BzaNMGYAOFvQFZt8zYoEeFWR9KrunnJkgM9FobZx+88z0kxhmsh7ca0rhyJoBaajtep3D4yo0Bmrryz9Ctm8Sf0mug7xi/VTvQbWoLMq/7j9mi8=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 09:05:42 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::9081:e85a:fe02:1275]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::9081:e85a:fe02:1275%5]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 09:05:42 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Rob Herring <robh@kernel.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
        "Zachary.Leaf@arm.com" <Zachary.Leaf@arm.com>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 7/9] perf: arm64: Add test for userspace counter access
 on heterogeneous systems
Thread-Topic: [PATCH v7 7/9] perf: arm64: Add test for userspace counter
 access on heterogeneous systems
Thread-Index: AQHXNZRvkV2XawLZJE2M435JfCOoPqrhQLHG
Date:   Thu, 13 May 2021 09:05:42 +0000
Message-ID: <OSBPR01MB4600B56CA4CE59935DDCC8B7F7519@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210420031511.2348977-1-robh@kernel.org>,<20210420031511.2348977-8-robh@kernel.org>
In-Reply-To: <20210420031511.2348977-8-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 275e8c6b-8e02-4659-5411-08d915ee4934
x-ms-traffictypediagnostic: OS3PR01MB6596:
x-microsoft-antispam-prvs: <OS3PR01MB6596617FABCF9C12FE88C6D2F7519@OS3PR01MB6596.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: halSTntJXI72sJ1edpnR4ql6G0Lb61BgIRSxNBKbvyIK9S7iIgV9zv+kWwDoUN2jCNMqxPmIZxO/1VZ7u3UCKk50zrYM+ae4vU6obON1nSH8PIBxrtu5/RDvJJsMTH8XQcDDpcKH8NdR3gU1+/uxOy+Hjd8zbT8LchdUnQwOTi62r2gkV/8Uwixyz1iOXNVKOqQAE4mrdhUtEoWj27CqBnbYm/yhXFHs8+QOecrGjE4Ohvx+4pDTAluy1i5Z+V9eu2ULcBowcVgfI+eLeKIGLpZo9f6+UVrVuqxeWWVfWraetiNOXgJ3tw9hJT+U1M1JN3k/bx0xE7Mk82LCoSQ8z4mr2UyNOr4WiWEG/Cl3dnsozTUzWJDPdNv1S8NmtuNaTeOUJARZOliQX9wXljy89AP7yUf7h3jOKLhmgsOa/A6G+ZcSTwacxVMjoIMp1DnGUpbnp9CwFs+cek+jtRxBWIF/BPZxgNDgcvu3BuxINrRqZnwD+tKIW7X90PC2Shu1svK1fE8q4pCuG7VEH31WvhundkP+LUQ7oail8A+kDoVBzrs7HFDaEFLtAslsffOJbk9mIWW3dEqvlYkiFrOBFiSg/rqeaf1EuuwXui/ST2I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(64756008)(66446008)(66556008)(66476007)(66946007)(38100700002)(33656002)(76116006)(71200400001)(52536014)(86362001)(122000001)(6506007)(83380400001)(26005)(7696005)(8676002)(6916009)(5660300002)(7416002)(54906003)(478600001)(316002)(9686003)(2906002)(186003)(55016002)(85182001)(4744005)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?QmhxdnVjU25CTTMyZk1NdWFXalJKbVRQR3hsVlVQSmhiMG1iN1owMUVM?=
 =?iso-2022-jp?B?SUNJN1RZL1hJeVp0VmN3RExiTlpRZUpDL3lCU2tpUXVjN2Q1VU8vZ0Qr?=
 =?iso-2022-jp?B?dnZxaGhWNHQzUzRCNmVmZm5FTW1LV0ZLL3czamNmU01Ga0wxSDRTc2M1?=
 =?iso-2022-jp?B?a0pOYzRwbERRdE1LbExSZFJyT21LWUtYZTJKQUk2WkMrK1U0REd2TFFh?=
 =?iso-2022-jp?B?RzdCelhDNFFvRld6UkVQQjFZUmhYSGhGUXJjeVVhejJsR2tYdVNUTnhE?=
 =?iso-2022-jp?B?SC82WURPTTNRejkzMDgvTDBKektlMXo2emVrTlp6bjNjcy9DTjU1cm1r?=
 =?iso-2022-jp?B?Z1B6dzUwTUMrUlRlM2J0RFYvTjMzSmtJOUJ3VENVRmlCK2RBdU80RjVV?=
 =?iso-2022-jp?B?NTF2Wkt4OC9ZNjVTMXFQVkkrRlV4TWtVMGtyaTl3YVJHSzBXM3UvbmhJ?=
 =?iso-2022-jp?B?UE9MVTlNUUt2cU1IMjUxRkhLYURRTHZjTlVJeXYzdUgrLytXcGpzd1pz?=
 =?iso-2022-jp?B?TCthbXN6c1NNbVh0a2JLQ2lSTHJuQkljQ2FiSkxhUXQzTnVBaXVwSmxu?=
 =?iso-2022-jp?B?cS8wUzBVbmFqb0FpTThIZGxmTW1NZ1dzVVdnSkF3ZHNEWVJ0andReE93?=
 =?iso-2022-jp?B?YUVXYzlIeWJ0KzQ3R0hqWlV6TDJMTHowSE43di9IK0lrdEs5UEYwZTk5?=
 =?iso-2022-jp?B?QUJ1dExRSithQUdjdVJlVlV2a3I2UDNxL0RIeUVPeXRnT1R1TjRzT200?=
 =?iso-2022-jp?B?bmdaRlJuNWtQb2ZVbHJVdW54TFBKa2ErKzYwTnBCZ1dydUlvZUFiQ21h?=
 =?iso-2022-jp?B?djRDNjdkaGMwa3d6S1BCMXRNM2JEd3UxOUovRWF2ZWwwZlAxM1V6YVc5?=
 =?iso-2022-jp?B?TElJRVBwMFE2bHdwbW1iSWEwZjQ1MFVTUTRBOUlLdVNkaHNCa21VTStt?=
 =?iso-2022-jp?B?K3NCSmhTV0VoajBwRm8wZXhRdnlmMGlBQjh2d1c5U0EvUDhINnk1TVk2?=
 =?iso-2022-jp?B?WWRWc2J5cm1lNEdDZDBIUHUzZDhJUGc1emh2eU5KSnFIa2phM3VhK09B?=
 =?iso-2022-jp?B?NEZQRnZDR2xGRmtFbFhtdytkdHpHNWNqVFhTTmJidGIycCtKL0JKUkRD?=
 =?iso-2022-jp?B?TkQrQlpCYW5KaGNZR1FHcDFIK2xTY2k2WlJmMXZHQ1NUOGhoRElNMzNL?=
 =?iso-2022-jp?B?Z1FEajRqYjRnN1NYOVVhK295UzZFT0ZsaFpQQUxNcUIxUktuUVlIME1j?=
 =?iso-2022-jp?B?OVF4djFhaGsxTmpLallXb1Y2bC9qOERFUTB2TXJRSHZSeDVGbDllVzNH?=
 =?iso-2022-jp?B?OU5WSWlMUWtWZWIwRG5lZ3RtSnIwRU5BQmNJb0lKSGhIeG10bFJ5MDZq?=
 =?iso-2022-jp?B?cmFlUWNMeUJ2RVc0eklBdWNuUW44VzlMNGRucmF4eDVYOHBjSHVKR08x?=
 =?iso-2022-jp?B?ZEV2dU5PNnVhSHVhTjBQVk1rR2tleU5iR054b1pTZzBUOGFZbG45OWs2?=
 =?iso-2022-jp?B?bnhVckJDMEJNY2RIRks1T3l3dlZYLzNFRi9IbEFkb1ZwRVA1a1JBZExH?=
 =?iso-2022-jp?B?RU0yK05wVXBaRSs4TXVvYklzVzN4U3BMZ2RmcDdVVlhEa2drdVJuZDZ4?=
 =?iso-2022-jp?B?ZTFiY25rVXhFTE5CWGFwam43cXhKTFE0WnJCaGtDWU1ZditYZSttSU1Q?=
 =?iso-2022-jp?B?WTlmTzBGMkwzK0xpZHJGa1hrSDdYSkZxOHJNNEE5ZytncHJmVERDNDFK?=
 =?iso-2022-jp?B?YmxlbFNiT0JRRlk4Q0xReXhMNmlFSDNMUHZ0SGdoTnFqSTB2Z3FKM0dM?=
 =?iso-2022-jp?B?UFo2S0JmTVBEWkc0aVFsRTNyZzFTL2Y2MU5yQkdIWjlJb25memo0dklG?=
 =?iso-2022-jp?B?VXYxczN5M3FjQXBBYy9JZUcxdC9VPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275e8c6b-8e02-4659-5411-08d915ee4934
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 09:05:42.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGKSd/8cwQXDWoR19B7fuVyil5grloCy8N25pE9I8plBcqG0653wb7LujaOUiz1mrtsLfxiHUPrXfyLJnfO2u7DaGI1DEX/qc7ZJsc5UzPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6596
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob=0A=
=0A=
> Userspace counter access only works on heterogeneous systems with some=0A=
> restrictions. The userspace process must be pinned to a homogeneous=0A=
> subset of CPUs and must open the corresponding PMU for those CPUs. This=
=0A=
> commit adds a test implementing these requirements.=0A=
=0A=
Are you planning to change x86 tests (tools/perf/arch/x86/tests/rdpmc.c) =
=0A=
to use libperf as well?=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
