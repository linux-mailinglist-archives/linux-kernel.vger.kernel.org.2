Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71953324F45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhBYLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:32:11 -0500
Received: from mail-eopbgr1410043.outbound.protection.outlook.com ([40.107.141.43]:45312
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235649AbhBYLai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:30:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2LSn+E3O1Unvh8y7rQZTbJthtaEV47gXRN5emsOBE/3n3nxX1JaU8tMTrETXAJpdk7/D38vULpr1u/LmZ/rPEPXLCxTq+gMzaKt5/yLFO1YGjkS5gr/+TFfo3bRPiUV6MhS0oIBeJRnf/1jNdFABIAdOn065K37C85hVXZ3bOMI9wTj3kIENdewXFPmCzjDUC8ERvohNvtqIgngeYkO3PB0Udn0O5++I/lUI9rlUM9tgfo7fgnSkfyRspewIKYNfADvtN0fRIvwOgW/gIWUKciUyNKTRwmcJjPsVDWyUiZjpm50vRMh/29jssbCVJwM8/Y9ciA6CYe01qWFBusjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2CnKLFc7e8Ep0lol3SpLDRgEHfwzqGOUhP3Dx4zS/0=;
 b=O8b0sLAm86j+LAnFgmgt9y7v7IH4Tr1i3/aTmZh9Ce2yi6w8GrvGjLJzRgjrGhcbtc9OCTY2noa/cI6Ut7LWzMdTRMUJ+9D8/hR2Z0zHr410KASIUKfCs/HJc9Ma9aU2G7L0AKqpSbuS8BBJkvVKexkMku4mBV523lzLY1FRyC9Ay8/rk4UBC6TaYso9OwtJgi+Il0Y9IVWeoFaWpukRjA5JYqjJyr0G3FFk9yDIQLifWnkoiysKMLO4Fb3dJhYFpddKyq3wEu1zCRwxgNzRi7UURcV/gdxqfB89pXY0ZctN56sAt1nIm58MjDp7O99Jwi9e9Bk7ji+Hl/JEgWMJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2CnKLFc7e8Ep0lol3SpLDRgEHfwzqGOUhP3Dx4zS/0=;
 b=jEQupOuizveEH+pmmEzPoYTW5oMi/3kW/2GS1HEOJLeokIVVxT7piH0X9kvakXNcCi8O1KJ2a34qu6fFMcYMMlGdC5qmK+BFlNCdXJ5vmzp9kHL5Y8YwfKA4jTxsKq2e0tCdRuewjMSJDNbXN2toDCHrAbINdEwOISK2Zzs/QuQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3967.jpnprd01.prod.outlook.com (2603:1096:404:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 11:28:18 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101%6]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 11:28:18 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCn0F5fAOAyGRl0mX4JfXYioGdapnG5GAgAEgN4CAAIHeAA==
Date:   Thu, 25 Feb 2021 11:28:18 +0000
Message-ID: <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux> <20210225114329.4e1a41c6@alex-virtual-machine>
In-Reply-To: <20210225114329.4e1a41c6@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39f0d871-177e-40f2-4e6e-08d8d9807374
x-ms-traffictypediagnostic: TYAPR01MB3967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3967F1E0FDA0B4895F226338E79E9@TYAPR01MB3967.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VJjweDa7FyAAsJNS5wGXCUXdLPSXvpig2zZ59Jghk8WmsiL4zIh6i4h//5aoqYE5SlM/RWsNvjKuNEcl8X0X99CYS2IZaodz9OFyoTCPvWuE5InCT2kxvb3wf1XdgYoSf7DBOEi+MjDx4QUqeUxGb8nQosP0Te9EQmZWO8OEBcns9e+Vb7hCUYQMeWSC5Q3mkLEONDDYqLgg4WqGPjZxUnddF5XWcqmSsrb9dXgXzMmJW66cYV4r3K2xqiB75QHBjq+LayR1nvFk0PXHEg0at2iTWkS1lH1CiyHj9qUMEMwRp4wnCEJ1JjEq3rfPdrNrO5ZHcDYZJ/0vojHUgYozF6XlvYu7og4NcHvmQJw1TAucbKKTkQrdr2fJ2dz5lUdWeLPQDKL73ukh4awmipWETsQmbuJqk3Nhbf7k5IJlWEEIi1U+cAIqTL9WiWre60BNPEG+xnQI+Bk1HlGlqLzcihoXqBcN80uWxQSp4NuTMoVP6YZR8HR2I5RlyC1trtUNIJQJzuGrf3qnVejKpGNvOZPudVGVpuRYOSzCG4Kl7JzCMmn3NQvFprcclWKQhW4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(316002)(186003)(55236004)(26005)(76116006)(6506007)(8936002)(5660300002)(85182001)(1076003)(9686003)(6916009)(6486002)(7416002)(54906003)(83380400001)(66556008)(2906002)(71200400001)(4326008)(66446008)(8676002)(33656002)(64756008)(478600001)(66476007)(6512007)(86362001)(66946007)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?YmpzZWpBdmZHU1gvdG9LeCtTMHVLeWQ1UXFPT295c2kxazV0dmQ3Sk5l?=
 =?iso-2022-jp?B?cWRQQXVVVGhGeGdRdXh1cHp1b3NkWms5dmo1czJnelhRUG5TbURuYzBE?=
 =?iso-2022-jp?B?bWhyenJ5VElyVWxkbjI2MDNucVpLNDJxZm5ieUNtZ0RMQnpFdTBWdVlO?=
 =?iso-2022-jp?B?MnVNeFlYS25OdmVUNGkxWmlWTDNwbDZ1NmlwbDJNZzNhRHBjRXMvQjNO?=
 =?iso-2022-jp?B?RXJFRUQ2SmxuSGxodG5RV0M5ZFAyallxYjRRa1RuMlZ1V3I4aHpZakkz?=
 =?iso-2022-jp?B?V3lqSnVGaGI2SFFvS1IvdmV0MG15dEpaZWgwSDN0cSt3UlZSbUlPN0FI?=
 =?iso-2022-jp?B?eUh5RmRlbnpLdGhsZ0ZnSlpUUFRENjBjTHhoZFdBZm40Y2RuRko3aStk?=
 =?iso-2022-jp?B?aEErTUIwR3MrTlBCN3VuMDF4UnFsK1BnWlVxUFZNSWVURWxoSUVqVDdq?=
 =?iso-2022-jp?B?a3M3Nkh6a2hvdTZZSHIvZnNBL01zRzdHZHowSzN3ZjNhUnREV1FHRDc4?=
 =?iso-2022-jp?B?eDExMVJLekRoazJ5Um9wSUR2SG8ydmJoVmFnQmhtZ3hZU1BRdklUM3Yv?=
 =?iso-2022-jp?B?SjBOOHZZUWNRSUFsdmh2Z2VlM09BMGgzdXFDRmJwdEtlYktEbVR4cGJC?=
 =?iso-2022-jp?B?UER0Q3VVL2JXMnc0TXpQRkpMOGFQU1NtZVlKdGRxL3hKUW1Vb01DR2ZI?=
 =?iso-2022-jp?B?akMwKzQ3Y2NCb0lKV3F2Z3ZMNzNRMkJqdVFzN2tCejNYLzQ2aStjbDdh?=
 =?iso-2022-jp?B?ZlBOR0hvSWRLZ0tCang4NEo3amwwVnBjcGVrQUJLcTJReEJ5bGRVSjZs?=
 =?iso-2022-jp?B?MU04WVZHMFVnTmNRdWdGOVgwWEJtVWtXcjA4UUZPQjZockFMdHJoTEYr?=
 =?iso-2022-jp?B?aUFpQU5BRnlkb3NGYVcrb3ZiVkJSV0lDOEVMeCs3NWdqVGJvYW1ZbGJn?=
 =?iso-2022-jp?B?ZSs2SXl2MmlERktKc2xRaXU0MnBwTGlMUld1WVZUWHZ3YVBMU0Z4QStX?=
 =?iso-2022-jp?B?T3RNK3BzU2xtK0VkS3d4b0xWd3A0bmtxMy81M0dza3pvNmFtek41RHpi?=
 =?iso-2022-jp?B?cUJmY0F2dmdxb08rQ0FrSEsyZXlQQWpPazlCSzRvSVlvNUxTMk4xQ0Fi?=
 =?iso-2022-jp?B?WW9RL3liVU5YYUo3ajFpcm0vNWtmdTlOUHR1Vkh1Vjd6cDRuSkFpYUVS?=
 =?iso-2022-jp?B?UzRGMEJUWFA5Z01POXd0YUZMR0FBL0Mya01DUjVIZzVJNmZyRXpuc3lo?=
 =?iso-2022-jp?B?QWxVcGVqUXh2eXBTL1hzbmdIaVhnNm1uVnZFK3dycCtlR1E3OVQ3RDJr?=
 =?iso-2022-jp?B?bU5tS295S1JUZGwyRDZoaFBtUjk4Q29pTkdiZi9kTTVIZWFVMkoyVGVw?=
 =?iso-2022-jp?B?NnQ4MmdNVXIxY0R5V3kvZ2ZNNWk1Ykk2RVlSZlpmVHk0ZE1WY1R3RmFP?=
 =?iso-2022-jp?B?UFhjSjluR2E4VzlCZ1lJdnB3MGhmMDI0R0FLUCsrbXpMc2tqN1RDdGYy?=
 =?iso-2022-jp?B?dnRpb2szbWFLcCtJZnAyRlRuVFZIdW1wbTZibzRGZVYwNTNNZ2ZYd0V3?=
 =?iso-2022-jp?B?UG9veUdEUGVpMEh3Q1FjaWVseDYrZFhoOGVCUVJiY3lmdGxxbytQYy9l?=
 =?iso-2022-jp?B?eVFMVURwbW04cGd1c3M4dXF6bGFqZzErMUplVm4wdEdiQWFBdklwZjlO?=
 =?iso-2022-jp?B?bnBWWGFja1MrUk1BblM3dkQ3dVNTSjFqS2hkbDVEckpmaDNtSy9QN2s4?=
 =?iso-2022-jp?B?NnVsVTQxelNxa2ZPZHAzUFJYTDFtM3h6L2RoQllXVHcySnMrdzdnYTlB?=
 =?iso-2022-jp?B?NmJVWUhIdlliTkx0MTdpS1hacUhGWWk4aVd0OXNWU3JhRmRmZHpWdUFp?=
 =?iso-2022-jp?B?NVVqOTBjV0V6eEVYM1FQY1BKL0ZtMXFITm5JdXU1ZEg4OEFpYjFoTGJv?=
 =?iso-2022-jp?B?amZCSndxVG5mR3Q2cFpzU2RQRDBMQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <2F1ADB323F838F48B411E9387AA9B558@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f0d871-177e-40f2-4e6e-08d8d9807374
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 11:28:18.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz0UYVDiS482tExH3rZjF/8KUwkVAXzTxW1je/cAVWOAFRhVwi39OPJk9AaHj6YSycpcGYmwX9klaw67ajuzKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:43:29AM +0800, Aili Yao wrote:
> On Wed, 24 Feb 2021 11:31:55 +0100 Oscar Salvador <osalvador@suse.de> wro=
te:
...
> =20
> > >=20
> > > 3.The kill_me_maybe will check the return:
> > >=20
> > > 1244 static void kill_me_maybe(struct callback_head *cb)
> > > 1245 {
> > >=20
> > > 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > > 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > > 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT, =20
> >=20
> > So, IIUC, in case of a LMCE nested call, the second MCE will reach here=
.
> > set_mce_nospec() will either mark the underlying page as not mapped/cac=
hed.
> >
> This set_mce_nospec() is not proper when the recovery job is on the fly. =
In my test
> this function failed.

Hi Aili,

I agree that this set_mce_nospec() is not expected to be called for
"already hwpoisoned" page because in the reported case the error
page is already contained and no need to resort changing cache mode.

...

> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index e9481632fcd1..06f006174b8c 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1224,7 +1224,7 @@ static int memory_failure_hugetlb(unsigned long=
 pfn, int flags)
> > >  	if (TestSetPageHWPoison(head)) {
> > >  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
> > >  		       pfn);
> > > -		return 0;
> > > +		return -EBUSY; =20
> >=20
> > As David said, madvise_inject_error() will start returning -EBUSY now i=
n case
> > we madvise(MADV_HWPOISON) on an already hwpoisoned page.
> >=20
> > AFAICS, memory_failure() can return 0, -Eerrors, and MF_XXX.
> > Would it make sense to unify that? That way we could declare error code=
s that
> > make somse sense (like MF_ALREADY_HWPOISONED).

It seems to me that memory_failure() does not return MF_XXX.  But yes,
returning some positive value for the reported case could be a solution.

> >=20
>=20
> @David:
>=20
> I checked the code again, and find a few places will care the exact retur=
n value, like:
>=20
> 1: drivers/base/memory.c:483:      ret =3D memory_failure(pfn, 0);
> This is for hard page offline, I see the code in mcelog:
> static void offline_action(struct mempage *mp, u64 addr)
> {
> 	if (offline <=3D OFFLINE_ACCOUNT)
> 		return;
> 	Lprintf("Offlining page %llx\n", addr);
> 	if (memory_offline(addr) < 0) {
> 		Lprintf("Offlining page %llx failed: %s\n", addr, strerror(errno));
> 		mp->offlined =3D PAGE_OFFLINE_FAILED;
> 	} else
> 		mp->offlined =3D PAGE_OFFLINE;
> }
> I think return an negative value will be more proper? As the related kill=
ing function may not be performed, and we can't say
> it's a success operation?
>=20
> 2:mm/hwpoison-inject.c:51:        return memory_failure(pfn, 0);
> mm/madvise.c:910:               ret =3D memory_failure(pfn, MF_COUNT_INCR=
EASED);
>=20
> These two cases are mainly for error injections, I checked the test codes=
, mostly it only care if the value is 0 or < 0;
> I do the related test, normally it work well, but for stress test, someti=
mes in some case, I do meet some fail cases along with the -EBUSY return.
> I will dig more.
>=20
> Other place will only care if the return value is 0. or just ignore it.
>=20
> Hi naoya, what's your opnion for this possible issue, I need your inputs!

We could use some negative value (error code) to report the reported case,
then as you mentioned above, some callers need change to handle the
new case, and the same is true if you use some positive value.
My preference is -EHWPOISON, but other options are fine if justified well.

Thanks,
Naoya Horiguchi=
