Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70518416B99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbhIXGcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:32:33 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:50829 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244204AbhIXGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:32:31 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 02:32:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632465060; x=1664001060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W8WjLDqQxWYuQl8Q2Ih3Q1jf51kni25VKlB1ctgaV50=;
  b=jQ5I1nkxKDcvJNIWmoOJ0bH0qO1J66TGmDXfg8N5QFhS4DbHhXUHAKRn
   X8bHZCmBem7YlDLf/gEXa2QsNB+OB2CceSSUBGIpjbrwWw+q9ek1TONKs
   MMs43jyQ4nkBJJqeofVpUa5MA9aZXoXSAPi+FVy0t4PngY4iNcncluEl+
   /3aco+G5FGF3jZY+7GTdxwQiW6Si9/P7olIwJXnkRI3siSHYlXwPfVb/4
   SNPWX2BOxhpflmdW8H+D7g5eOnQ9++bost0YFhfZD1QUdZmS9YoeSwVgG
   huQi+PSV3kyVUUKU8AN5LADxYT4h5zPBeRiCAHEirchFAxkFRXhMQHHCT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="39687810"
X-IronPort-AV: E=Sophos;i="5.85,319,1624287600"; 
   d="scan'208";a="39687810"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 15:23:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvaPBUet76N5AoEusCyDEfJYfvZjscp5z18lWdX3eT59a+iXicAbOp5hAsMSQDxPPTYRYRgoW0uSiev1u3dF/NLta4TFFRsdgl2E/4PMPIeC6HxVj4JpAug0KYNFa205de049avPTrX73gzBNhn1DNJhHV0rUJzAS5XQ/a69HGSunOMRQ94I3IlRg9zeP1cyIHxutsrrxs738GB6EvIyM6bk+dTNUEfTTFvM4fFWBKSBKAtlWz2NrLWz24DC71g3XnsrOMdXAQSAXYYMaNse3wTyPCWLVUi5pEUjLuoOriQJCrc/IminMSxxGD9Un3/e8o+qyGKCo8mLZqNEcIGgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/GfiMBlsOFzS2HFR5sGCBMVgIqU7oUZJgWUF0jBuJ2A=;
 b=BKxPRLwokFpHQnFJL5uQygS9bs6RUUw4RXlB9MkOf1OKXsVYgh535agKNeOLEidsgmehfFmhxaE5iClDYrhauERHfJQwfp3J+vmNyGOgdCVqrCVTvY1GC7iYkJK3YlHKhYESNLaKMa/8+MAf5hSVV8Kjf6wIUuqfqg9SSVeA6H4StUZDk0FGQBcrnakor+E2W4gnlJEbNQvLHtA+1YPl/BioqXCuVMZB0c6Qcu6rE1qcQ7Lnm/FskhvB/KzySGE+Umr9tUTonta5N3G5JY/pg9ebJTu5/L1jRgS9WqGSTzAO/1gl9/Pz4Kk/rGYGrzhWSjorIOOQx1zzGyikyML59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GfiMBlsOFzS2HFR5sGCBMVgIqU7oUZJgWUF0jBuJ2A=;
 b=aUOjPY98KzMp2fqfylH8T/zlS6LPlmiYE4231oWzzOYY9sCH/kcK3MxcQkrKgrKUTSUcUoRtBYqW2zwhuHqWyPr/BoHQcOUcO/OVGSZINzmdyxLZf6xbTAtUU1z6UqjqqRjDB2DXZhq678v8olofQMk4zbyCLCAlOn6XOV+xM0k=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB3165.jpnprd01.prod.outlook.com (2603:1096:404:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 06:23:41 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::c9d3:f528:4d7f:4c83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::c9d3:f528:4d7f:4c83%9]) with mapi id 15.20.4544.015; Fri, 24 Sep 2021
 06:23:41 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC:     'Fenghua Yu' <fenghua.yu@intel.com>,
        'Reinette Chatre' <reinette.chatre@intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'H Peter Anvin' <hpa@zytor.com>,
        'Babu Moger' <Babu.Moger@amd.com>,
        "'shameerali.kolothum.thodi@huawei.com'" 
        <shameerali.kolothum.thodi@huawei.com>,
        'Jamie Iles' <jamie@nuviainc.com>,
        'D Scott Phillips OS' <scott@os.amperecomputing.com>,
        "'lcherian@marvell.com'" <lcherian@marvell.com>,
        "'bobo.shaobowang@huawei.com'" <bobo.shaobowang@huawei.com>
Subject: RE: [PATCH v1 09/20] x86/resctrl: Abstract and use
 supports_mba_mbps()
Thread-Topic: [PATCH v1 09/20] x86/resctrl: Abstract and use
 supports_mba_mbps()
Thread-Index: AQHXsQampqE1wxhtTkyDC1PkckQWv6uytvVw
Date:   Fri, 24 Sep 2021 06:23:41 +0000
Message-ID: <TYAPR01MB63305E4A3128B7CDF84F86538BA49@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20210729223610.29373-10-james.morse@arm.com>
In-Reply-To: <20210729223610.29373-10-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9OTc2OTZmMjUtZWM0Yy00ODMwLWFhNmQtMWZh?=
 =?iso-2022-jp?B?Nzg5NTgyMjk5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMDktMjRUMDY6MjI6MTBaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a69fa49b-efba-4238-3b8d-08d97f23da6c
x-ms-traffictypediagnostic: TYAPR01MB3165:
x-microsoft-antispam-prvs: <TYAPR01MB3165FB02C5384DC196CF65BE8BA49@TYAPR01MB3165.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mF93SpY7fZlZ2XAmCOYQkl/+Dn47cI8351C7/CgK9iSPILEw4s2YV4YaL7Kptmz1tVv8TthefKIkzLkpu0Wt1ce0PyO7v6Ef53u2S1gzKIglKK/fz+m0PF0mbxCVGsjq2+iYeS0XwzwzKx+gAaePWDOzQj85AAbz9Ou3k95H2wCwB7/N90E06IM8D5K3MDeb3EVLeTeq3vdjhG9K3nfzAtcLCFnOFAqH1il2/IGrbIcHdNGh+GDBCr6I4EtmdKufhD4MazVbwBYcjqo4Hbsa1T68Suct00TdfILQ30xJkx8LDITX7I3ofFUOBOG8dZBTu9crw7Bv8GCyMknHB9H2P2lbb/Z07VQ/LuTeFV+BvyavqXJLYAFtoXzZ/u2uKcPJUq6mTBoDsP+koYatXrK6wj/zFA0gI1t4dGYq/8Z53GpmNTTShhfApyE09iXhe3Zj6vV5xbhEMOCs6L3/YiEsrBiNCfBDrXn+ZHhQ7Efc1msPwR/IecciXk2Pbtj4+L/E/TyN8Q46h2QVFdg/nPkbVY09/mx8AqED2oSIDBgA5F0OAa/K84Zy6rDXeg+ah2JTzP7R8+GVkBTKAmblxFWubfEVjWon8ISA7R8xrP6xvBX5QcoO4YgTSSNRvj9tMVz53zbPw4xD7GyrqpydLnlaApTqph9HSKBotz+SuSzd/mBiem20O3HrlJNNRrR4VWfVOgoIEiByBZH0NXREJSR0zv6fxXbnu6ve/C7d12i9ok8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(9686003)(4326008)(7696005)(508600001)(8676002)(38070700005)(85182001)(186003)(33656002)(54906003)(52536014)(6506007)(2906002)(5660300002)(110136005)(26005)(7416002)(76116006)(66556008)(86362001)(64756008)(38100700002)(122000001)(66946007)(66446008)(66476007)(83380400001)(71200400001)(316002)(8936002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TVlBT1BKdEJ0V2RwR0ovS3BxVTZnbm5MNW52aDREamdjYk04Z2JURWFr?=
 =?iso-2022-jp?B?NWRuaUZna1VZWE5lMHBEYzliY0dIZ3NBdUlEbzBiVzZENFluYWR0ZGk5?=
 =?iso-2022-jp?B?T2JibHdxd2lSOFUzS0pQQlFJNWtYcERJUUFLMjBsVGR3elV3SmNGRUNo?=
 =?iso-2022-jp?B?YnlBRTB6Z1B2WkN2NGxxdkFxSC9OVk9xcUFBRjZtNVl3eGdRMlRwSnpX?=
 =?iso-2022-jp?B?T3pvV2NVQngzOHg2NldjMjhtbWp5T1BveEFDd3lpWjJpVkEvUnRSZnF1?=
 =?iso-2022-jp?B?SmpXRkhqZnZDRFdPK3RLcFZLVFpZYTVOb1V0c2tDdEVtWktXUVhLb2pS?=
 =?iso-2022-jp?B?ZG84Z3J1ZktDWmdHYXVWYitCczVDTEM3bkwrajdveTYzZ01Uc0tEdWh0?=
 =?iso-2022-jp?B?NWREdnZFbThIaVVYczdtVjQ2dEh0RVhwbktVbEJaa0w1VTRlRnhIL254?=
 =?iso-2022-jp?B?MEVEWXdlbisvcjJ5cEVzTDdiRWoxZXVkQlQzYWRuY1I5eEtiQnJzLzBF?=
 =?iso-2022-jp?B?a1g5dFpGellISkM1clVpYkdoN3YwUlBPejkzUjRvL0s1b1YwaXFCbndX?=
 =?iso-2022-jp?B?dXY2eWJudU8reFBWOEhpL2VVbzcza0hFZzEzdHhZK3RFNmRLSmU3cXBz?=
 =?iso-2022-jp?B?NW1XV0dmUCtrU1VPZXdTMEMzcy9udWpyOEJPbjBkazZNYmtTbVpqMGZE?=
 =?iso-2022-jp?B?NGdORTlzcm9yOW0xY1VpZnFIc2RhejhpMjd2cTBHbkVWdDFVU0NTdGlH?=
 =?iso-2022-jp?B?NkxnTDlPbkMwYTlYYjZaZE1Pa0pYQitzQ2xmSnByTTBnSWdiNGVYQ010?=
 =?iso-2022-jp?B?WktKdkcrZk1JVjVFUUltcjJ3NkNaYjdmazkyK1ZUbHhYVnp2Wml2MlBB?=
 =?iso-2022-jp?B?cHlKRGVhYmkrL2hsQ2hMbTd0QURkc1B6NGhwWFZ1VHE0TFY2VDQvd3J1?=
 =?iso-2022-jp?B?VVpsb21RcDYvZHpoMDk1azlUWUhXOXpjS3NETWpSSVRSMVl3cVBSdkFJ?=
 =?iso-2022-jp?B?eGlqR20xckJwVWZwUUV6TVhXSmFtOUlLTEl4c1plbGF3TDBaU25YVUlz?=
 =?iso-2022-jp?B?ZFp2Mkg3OFRJNUdscGFmaXRaejBUK016dElySEhpQ2ZHckJxdU9ha0Yx?=
 =?iso-2022-jp?B?MG1yUytLN3h3OWlwY3ZzdFlmNktYNmNBTHhqNlpQZHBteFFuMGdRaW9Q?=
 =?iso-2022-jp?B?d0M0TWZ1dEYrMTFMZTJWTzFFb1JjcUJyQm1jVVBhTjBQK2xFQmt6SVho?=
 =?iso-2022-jp?B?MHdQQXdtRThac0Z4WDNVcG9UZk0xYUhHNkxUby9mZTVTdWxsd0l2SkZM?=
 =?iso-2022-jp?B?UXJjOEhWTWxWbDFzb1Y1TnRhUDIvQWwwclJlaGRhM1NDK09Bc0U0WEth?=
 =?iso-2022-jp?B?cTJJVksySWhrWWQ2K3lMdGx0NFVWQmdHL1c2WDJpMmhrN3U1R2xuQTNh?=
 =?iso-2022-jp?B?MEQ2MWJPa2Y2dEZmbndzUUdOMHNYRmEwaWlobkdlMHd2ZFJ0b2dvNFZV?=
 =?iso-2022-jp?B?YS9NUHVFTW80STNpWUIyaXdzZ0x6T1BEblg5NStQVVhTZmtheTV1L3NQ?=
 =?iso-2022-jp?B?MTF1WkpKS2kzQmYvMGNqV2ZpMmJCYVl5THJJM0thOEhiZWoxZHAreFdI?=
 =?iso-2022-jp?B?RFViQXZHSjVzVWJnaVdBRFR1QTdTR2hpejA3dzd5RlpWdWhTN2c2am1w?=
 =?iso-2022-jp?B?dDFiVHlZNURSMTc0M2sybUxVYm1HVm5VQnE4RmdmZlk2Q0dPM1p4REtz?=
 =?iso-2022-jp?B?bWY2NHdsZFhKQWwxR2R6QWdlNkJnYVNOcUUwT1hRTVo1RFhkYmhYc3lD?=
 =?iso-2022-jp?B?NGIzOHhwK0pwRXJjcTgydFUxeFBjQjZ0dzlYUEFXZzJsTlFhZzk2cFFJ?=
 =?iso-2022-jp?B?cHNidG5QVHJMZ1NKR1VyR1ZXNm1OL2VaUTg2ZS90eHY0L1R1aklUa2pT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69fa49b-efba-4238-3b8d-08d97f23da6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 06:23:41.4028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yhTBBK2bliyLxSy8m8p1i6ddRvoChSzYmI0NZALnbv/GmN04IQHKOpkOvmxquA4ArlJKnb301WTDN8DPHysgZSwALzXBo4oyTI5l7NASy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> To determine whether the mba_mbps option to resctrl should be supported,
> resctrl tests the boot cpus' x86_vendor.
>=20
> This isn't portable, and needs abstracting behind a helper so this check =
can be
> part of the filesystem code that moves to /fs/.
>=20
> Re-use the tests set_mba_sc() does to determine if the mba_sc is supporte=
d
> on this system. An 'alloc_capable' test is added so that this property is=
n't
> implied by 'linear'.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e321ea5de562..4388685548a0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1888,17 +1888,26 @@ void rdt_domain_reconfigure_cdp(struct
> rdt_resource *r)  }
>=20
>  /*
> - * Enable or disable the MBA software controller
> - * which helps user specify bandwidth in MBps.
>   * MBA software controller is supported only if
>   * MBM is supported and MBA is in linear scale.
>   */
> +static bool supports_mba_mbps(void)
> +{
> +	struct rdt_resource *r =3D
> +&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +
> +	return (is_mbm_enabled() &&
> +		r->alloc_capable && is_mba_linear()); }
> +
> +/*
> + * Enable or disable the MBA software controller
> + * which helps user specify bandwidth in MBps.
> + */
>  static int set_mba_sc(bool mba_sc)
>  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>=20
> -	if (!is_mbm_enabled() || !is_mba_linear() ||
> -	    mba_sc =3D=3D is_mba_sc(r))
> +	if (!supports_mba_mbps() || mba_sc =3D=3D is_mba_sc(r))
>  		return -EINVAL;
>=20
>  	r->membw.mba_sc =3D mba_sc;
> @@ -2317,7 +2326,7 @@ static int rdt_parse_param(struct fs_context *fc,
> struct fs_parameter *param)
>  		ctx->enable_cdpl2 =3D true;
>  		return 0;
>  	case Opt_mba_mbps:
> -		if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
> +		if (supports_mba_mbps())
>  			return -EINVAL;
I think if(!supports_mba_mbps()) is correct, isn't it?=20

Thanks,

Shaopeng Tan
>  		ctx->enable_mba_mbps =3D true;
>  		return 0;
> --
> 2.30.2

