Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF83CB037
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 02:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhGPBAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:00:00 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:19714 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhGPA75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:59:57 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2021 20:59:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1626397024; x=1657933024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zg9A/iXPPbTuzXKfdU/Cbwohlun7pr+vM9n+uLPKo3c=;
  b=rTpHouLLCHy8XQjPVaGSxlt1UYtv9eflTfKBR6SrbNKSsloyVG2/2uhe
   FICwnJ7nKLZWkE46/5VBSH2w+XgvaEKFM5Vm/vxabnDwJ5V1jGtUyzaC4
   q44FI962JcdScSJTY2gsNrSpDLWMpKm+VC7YvWQCV/EvtOCFfhYUx/y/T
   3Aw2dYZ0UZfQRlPF3dDugpBxxAmiWKK5ADEdQuu8UtSnJa2Z8/7GjkC/I
   FtTVjmRn+B5miId40ykhMEs8iHuqB7q/z7/tXFYv3dLjn5XYjnF8sHAYe
   9rEHMGc5ygYGDD2c0UWb9WxVBATP4e9BOYqThPcd0U41Fx63IYfFVHWsu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="35090112"
X-IronPort-AV: E=Sophos;i="5.84,243,1620658800"; 
   d="scan'208";a="35090112"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 09:49:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9UIEy0dWtdqJD4JFT9CIXqDTOTxiDBIO96w0R/gCr7XGvCF+pThsu3XzcMabX2Qtzd1PpBGyJONAtCjXV/uvB4HJHWZJbINb/PeP+fUoXPOw4ZF1raGNdW695D5fib18XkqSh2ql7TQMZ86gv6mMoWMzSbr2RFaG0LA3cbrLPh5Uv+/0/mOLfD6wgODWVxfxa8oZ5ehAT0e7Pa9sjSLU2BM2eTXjpLTs5KcfgWyFvvhWBcyqmKRO8HL1R4ZL1CiyQqG7bbW3UFaW/GdhVEzbyIS5uR3Ds3x6n6nCp+4Zv0k9THN0PsZu8d/fCMjiT66ClL4GG8kkV/IDcyKuGuBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6P5VGVWOo8F65kWvk4+62yudjH36Nz6e+eN83i0T7Q=;
 b=gPKWIOut2IglNcMXZc6UiCA80Lqlh35j0d+9RTZ3Wya/hSXCc+8jfPK7UeL/v+yD6yiX3W+BH9iT5PfN4L9acQkb56HIW+cX5nf6p62qN3Z1MOeb9ZFdIfOtK3xjdkvf/IozaZMa0wpoZ6CZqf5ML0Ck0iyZikV076JqwCO8twwoNtbx51qodoD37HwBXoT2mzc99subrXOo44EQseIwQun2vyKxamkaIA6/A7znP4RzBzuLxru4H5DPjF+QEvVl2mY2lVUPUBKoG4UriCEbOTdLUnuvMVNGpMyfyxK0ODVuez4CFFs//OpK/JabIHg9O4noKYJjzz77/rLP/YbQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6P5VGVWOo8F65kWvk4+62yudjH36Nz6e+eN83i0T7Q=;
 b=IyUCbAHjVrik1O+zoxVlFEqCNWzN3ge0Gi7NAnVmc5OyNBCtOi6l8BX7JBuiO5rfGY68YTURNO/tQ1HDUeZHG7yxoZyK/0exbImmi+4gpA2y1QWGFJHvvVNR081EziSuGoHN6XT6iYd9UfhzSKtKP8vQIoW77g2A8y4H6bAW9mI=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB5967.jpnprd01.prod.outlook.com (2603:1096:400:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 00:49:49 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::3856:85dc:d6ba:ec90]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::3856:85dc:d6ba:ec90%9]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 00:49:48 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "'Luck, Tony'" <tony.luck@intel.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAA3M648AA3z+sgAC1LKkQAEYGy4AIMyy6kAGuMGag
Date:   Fri, 16 Jul 2021 00:49:48 +0000
Message-ID: <TYAPR01MB6330B20AC0E430811A0C31218B119@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
 <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
 <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-07-07T11:22:51Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d4978975-b86a-4542-afb9-aa0b2e7d7ace;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbbe4f76-880c-4e2f-169f-08d947f39d38
x-ms-traffictypediagnostic: TYCPR01MB5967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB5967610B61ADC1423F733BC58B119@TYCPR01MB5967.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5HG3N9YGwHMjjsidxTD1qwuQxDCDDA+7WAJhBsktfSsLgFetBK/tbIvlvsNq3KjYWzrlJntQ9DozR8lYb6dbgHEM96D7+znwAX0fvLNujSQoJhfYUE3hOO9ftqwwZCA0FPEoyPOlIjXzulfmVdaLO1vzlaVHirz57GehfgYRKwvcTjav8TNY+PDoG9dpirXsMVUbj/+M09BYQTMhbsBR0ADJdheBgwf+jC7vXPY7VfP1tduiNPOoIq5UCQO9rRgT4QIAkaoqL8SlDlwMOkBZPGb7fbQDwUEUHya/JqiLdqKhE1ygbsV4mOW4U7IhEg+kj3idrfO236e8fxEqxov0uhKbIfuhyXqpDunsNcg/8+jjXAoMJgV844u3b4gxEcSFSKo8snIaDCX74hEB7XMPhXXmgQgAsGQ0WZ+ONSDbCIDaW2n6W+565cOF2Vh6PTAs7odW0jI/5bvkH7okjLxO2C8844MWuztMj3k67Y6K0RO3ClFQ218/SplgN6M09/WPkMr/MlIFyWkw2lOF+w1ON4kJzW6CczGlqU+W6wSIasVoCa5ocMWzeyLGMQgerR7ZTW5PAGJTb0KUX7Bqh1vmDSMDWKN005p0m2pYjik6/RZVFA8c14NN4q9JmwqcOE/45YdmbNE0h4r6fHzH6B5jfeStyC9yXQrpAmphKLQD5Kv4zgn6bekai/IBWdEYAErITIUQwi4w3AAvhFrsKp5LoC/ArNKG+KKMKoFI6WoamKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(5660300002)(110136005)(52536014)(66556008)(64756008)(66446008)(66476007)(66946007)(9686003)(478600001)(8676002)(7696005)(54906003)(85182001)(316002)(76116006)(122000001)(55016002)(38100700002)(4326008)(26005)(83380400001)(186003)(8936002)(86362001)(2906002)(33656002)(53546011)(6506007)(71200400001)(38070700004)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?V1RpeHArSmN1N0JNQk5uZGhVUVRXcGxPTEpQWXc0eWpEVUJ4bU8xWE5i?=
 =?iso-2022-jp?B?MTlxVnJkdGdXc2wxb0JVQXlYVStrQm1hMStSSXVHVFFlcGNtWkRrUEJz?=
 =?iso-2022-jp?B?SitleFVlOFVTOFR4S2F2aHdwZGl0aUZGLzRWTHp6M1h0dkFncllFQWNl?=
 =?iso-2022-jp?B?YlpLV1k1cHJzNWxPVjRYeHVmdWZvOFFFOU90QnRwelQwSXZndzZIOHdU?=
 =?iso-2022-jp?B?MHBkOWgvZFZPTWtPTFhhcWl3cnd0ZXVrYTZ2aGY3a2FROHkyZEpacUF5?=
 =?iso-2022-jp?B?aEtjNnBhaWtYYUVHRk1COHhFMHNWZzdrU2pHdk5GWjFYVXpCZEFHS0d2?=
 =?iso-2022-jp?B?dHZuaXNMSHkxckJ3TVozU2JZT1Z6QWt6VTFobHZQUkdES1Z1ejZjaFFo?=
 =?iso-2022-jp?B?YURlYXo2cDZVQ2MvZ2Q2cUIxY0IrV3FxRHV6b0NRSW9XM1UwT3lqTUtp?=
 =?iso-2022-jp?B?eFhnVlZLRnFjbGZSQVQ1azRuWEl0OEJsL0paYVBVelAwSTAwcnVhZW4w?=
 =?iso-2022-jp?B?ZCtURC85U0tjMlpMblFOMkhWcmg2MW95YVNrRWwrZXU4dzNpOW5DUVpn?=
 =?iso-2022-jp?B?Tmd4bTVmemt5eTNZTEJQM2RjV1V3SGZBaEo5M2x5U05iN0VXL3h2V05O?=
 =?iso-2022-jp?B?ZFFxR25IL3N6Q05hUEJmTThvbWJZRmRoWXN3RTNSaEREbDh6aDRoOVF6?=
 =?iso-2022-jp?B?eTU0NU92NW1kR3hiVjZhTEhIcjkvWmg2WTF6cTdrQ3p6ZG1Ba2w0STFX?=
 =?iso-2022-jp?B?eGI5SEFJbjBEdGh6UjVmZmI2MWF5SHRxQjE0N2tDcTBwRzUwNzJ4ODd0?=
 =?iso-2022-jp?B?c3VCYUNlbGV4ZVJ6NHdQam9DRlZlQXVMeFp5OW9EWENOMlNPQTJha01z?=
 =?iso-2022-jp?B?U3FFNWJuQXhmVGNLZ1NGVHJ0MEJNUy8vU2o4eTVIUXA3d2UrV0ZQQXpw?=
 =?iso-2022-jp?B?b3VycGQvSUxKM0VmWWprbWF5LzZwdUxCWVZ1Z1Bvb3ZVRnBxck52OEs2?=
 =?iso-2022-jp?B?V081WlRtYVlsbFk3MmRJbURmQzVyOWdkTFoxSk9TMVRsMk0yeG9yS0lP?=
 =?iso-2022-jp?B?TU0xTU5taXpUU3JUOVlaME9YMkkreWNudkpYVENZU3hXZE42OUc1SmRP?=
 =?iso-2022-jp?B?VnhRTEFQUmx3RkhlMzMxUXZ6Yit0b3U4YVhYaTNiZDZhdzkzN0M2UW9I?=
 =?iso-2022-jp?B?K1oyQkt1Q3dkMUVPOHJLRHVkWDBzRUdzVG8vVUlZWk94VVk0ZTRZVVd4?=
 =?iso-2022-jp?B?a3JFa0ZnblV4cnpKd2ZwTjV3bEJ5bEJVTE1TcFdmTkJPR014c3g4R1BF?=
 =?iso-2022-jp?B?bFdVREtiSUt0bmFqWHdmMURta3UrNlVWQ3FwUlNldWFaRTVPSGFxN21v?=
 =?iso-2022-jp?B?enorcm9mUkE1aEZ2ZWtQSW91S0NYKzhLZHNmL2JLZFRqbm1JdTI3RlIr?=
 =?iso-2022-jp?B?RUlkcmkwMlB1U0dzZHVISGM5L3JnN3VTdjk1eEplR1RONVZ1R3BoWU12?=
 =?iso-2022-jp?B?SlNZSFdOTTBPZ3V5U3V0eFJZYzRaU29oL1R6Yi8zVXk0RXpCY09LTEg1?=
 =?iso-2022-jp?B?eHc5a3JQeDRVaExGOWV5YzJMTGlGUzFiWHN5L1J3cTRIZlZnVW5jNnZS?=
 =?iso-2022-jp?B?ZFBZT05SY093TlduQ2ptVExHQUlBMVJjRmR6eVFGb0d4ZFRXK0hFRW1P?=
 =?iso-2022-jp?B?dkNlcVpna3pPNHJseStIV3BpSUZGSnZOb25OV205Und0N2tGS2J6TlAv?=
 =?iso-2022-jp?B?TWV1R2lsRHBaNTBPTXdGMUZHWHhLS01yTnVWRFByRURkR0RReHprUWpQ?=
 =?iso-2022-jp?B?N1pwMUhMZWZkVWUyQWRYYk1SU3ZKNEh6cXJzR0lUUStWNXUrRFNJek9Z?=
 =?iso-2022-jp?B?MzVoTnpqa0VXWUNZTDNOaitmMGZnPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbe4f76-880c-4e2f-169f-08d947f39d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 00:49:48.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byNJ2KZiCt8U1wPh1/HpLtcXiaGn+tcUTeaCxZBA3DsIi9pDYVA3hcb8PQpMN2ck/wssR2AVNODsUmsjaCAgqwo9MV7pTcd1NsvoAvsKBPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> > > Sorry, I have not explained A64FX's sector cache function well yet.
> > > I think I need explain this function from different perspective.
> >
> > You have explained the A64FX's sector cache function well. I have also
> > read both specs to understand it better. It appears to me that you are
> > not considering the resctrl architecture as part of your solution but
> > instead just forcing your architecture onto the resctrl filesystem.
> > For example, in resctrl the resource groups are not just a directory
> > structure but has significance in what is being represented within the
> > directory (a class of service). The files within a resource group's
> > directory build on that. From your side I have not seen any effort in
> > aligning the sector cache function with the resctrl architecture but in=
stead
> you are just changing resctrl interface to match the A64FX architecture.
> >
> > Could you please take a moment to understand what resctrl is and how
> > it could be mapped to A64FX in a coherent way?
>=20
> Previously, my idea is based on how to make instructions use different se=
ctors
> in one task. After I studied resctrl, to utilize resctrl architecture on =
A64FX, I
> think it=1B$B!G=1B(Bs better to assign one sector to one task. Thanks for=
 your idea that
> "sectors" could be considered the same as the resctrl "classes of service=
".
>=20
> Based on your idea, I am considering the implementation details.
> In this email, I will explain the outline of new proposal, and then pleas=
e allow
> me to confirm a few technologies about resctrl.

Could you give me some comments & advices?

Best regards,
Tan Shaopeng

> The outline of my proposal is as follows.
> - Add a sector function equivalent to Intel's CAT function into resctrl.
>   (divide shared L2 cache into multiple partitions for multiple cores use=
)
> - Allocate one sector to one resource group (one CLOSID). Since one
>   core can only be assigned to one resource group, on A64FX each core
>   only uses one sector at a time.
> - Disable A64FX's HPC tag address override function. We only set each
>   core's default sector value according to closid(default sector ID=3DCLO=
SID).
> - No L1 cache control since L1 cache is not shared for cores. It is not
>   necessary to add L1 cache interface for schemata file.
> - No need to update schemata interface. Resctrl's L2 cache interface
>   (L2: <cache_id0> =3D <cbm>; <cache_id1> =3D <cbm>; ...)
>   will be used as it is. However, on A64FX, <cbm> does not indicate
>   the position of cache partition, only indicate the number of
>   cache ways (size).
>=20
> This is the smallest start of incorporating sector cache function into re=
sctrl. I
> will consider if we could add more sector cache features into resctrl (e.=
g.
> selecting different sectors from one task) after finishing this.
>=20
> (some questions are below)
>=20
> > >
> > >> On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:
> >
> > > --------
> > > A64FX NUMA-PE-Cache Architecture:
> > > NUMA0:
> > >    PE0:
> > >      L1sector0,L1sector1,L1sector2,L1sector3
> > >    PE1:
> > >      L1sector0,L1sector1,L1sector2,L1sector3
> > >    ...
> > >    PE11:
> > >      L1sector0,L1sector1,L1sector2,L1sector3
> > >
> > >    L2sector0,1/L2sector2,3
> > > NUMA1:
> > >    PE0:
> > >      L1sector0,L1sector1,L1sector2,L1sector3
> > >    ...
> > >    PE11:
> > >      L1sector0,L1sector1,L1sector2,L1sector3
> > >
> > >    L2sector0,1/L2sector2,3
> > > NUMA2:
> > >    ...
> > > NUMA3:
> > >    ...
> > > --------
> > > In A64FX processor, one L1 sector cache capacity setting register is
> > > only for one PE and not shared among PEs. L2 sector cache maximum
> > > capacity setting registers are shared among PEs in same NUMA, and it
> > > is to be noted that changing these registers in one PE influences oth=
er PE.
> >
> > Understood. cache affinity is familiar to resctrl. When a CPU becomes
> > online it is discovered which caches/resources it has affinity to.
> > Resources then have CPU mask associated with them to indicate on which
> > CPU a register could be changed to configure the resource/cache. See
> > domain_add_cpu() and struct rdt_domain.
>=20
> Is the following understanding correct?
> Struct rdt_domain is a group of online CPUs that share a same cache insta=
nce.
> When a CPU is online(resctrl initialization), the domain_add_cpu() functi=
on
> add the online cpu to corresponding rdt_domain (in rdt_resource:domains l=
ist).
> For example, if there are
> 4 L2 cache instances, then there will be 4 rdt_domain in the list and eac=
h CPU
> is assigned to corresponding rdt_domain.
>=20
> The set values of cache/memory are stored in the *ctrl_val array (indexed=
 by
> CLOSID) of struct rdt_domain. For example, in CAT function, the CBM value=
 of
> CLOSID=3Dx is stored in ctrl_val [x].
> When we create a resource group and write set values of cache into the
> schemata file, the update_domains() function updates the CBM value to
> ctrl_val [CLOSID =3D resource group ID] in rdt_domain and updates the CBM
> value to CBM register(MSR_IA32_Lx_CBM_BASE).
>=20
> > > The number of ways for L2 Sector ID (0,1 or 2,3) can be set through
> > > any PEs in same NUMA. The sector ID 0,1 and 2,3 are not available at
> > > the same time in same NUMA.
> > >
> > >
> > > I think, in your idea, a resource group will be created for each sect=
or ID.
> > > (> "sectors" could be considered the same as the resctrl "classes of
> > > service") Then, an example of resource group is created as follows.
> > > =1B$B!&=1B(B L1: NUMAX-PEY-L1sector0 (X =3D 0,1,2,3.Y =3D 0,1,2 ... 1=
1),
> > > =1B$B!&=1B(B L2: NUMAX-L2sector0 (X =3D 0,1,2,3)
> > >
> > > In this example, sector with same ID(0) of all PEs is allocated to
> > > resource group. The L1D caches are numbered from
> > > NUMA0_PE0-L1sector0(0) to NUMA4_PE11-L1sector0(47) and the L2
> > caches
> > > numbered from
> > > NUMA0-L2sector0(0) to NUM4-L2sector0(3).
> > > (NUMA number X is from 0-4, PE number Y is from 0-11)
> > > (1) The number of ways of NUMAX-PEY-L1sector0 can be set
> independently
> > >      for each PEs (0-47). When run a task on this resource group,
> > >      we cannot control on which PE the task is running on and how man=
y
> > >      cache ways the task is using.
> >
> > resctrl does not control the affinity on which PE/CPU a task is run.
> > resctrl is an interface with which to configure how resources are
> > allocated on the system. resctrl could thus provide interface with
> > which each sector of each cache instance is assigned a number of cache
> ways.
> > resctrl also provides an interface to assign a task with a class of
> > service (sector id?). Through this the task obtains access to all
> > resources that is allocated to the particular class of service (sector
> > id?). Depending on which CPU the task is running it may indeed
> > experience different performance if the sector id it is running with
> > does not have the same allocations on all cache instances. The affinity=
 of the
> task needs to be managed separately using for example taskset.
> > Please see Documentation/x86/resctrl.rst "Examples for RDT allocation
> usage"
>=20
> In resctrl_sched_in(), there are comments as follow:
>   /*
>  * If this task has a closid/rmid assigned, use it.
>   * Else use the closid/rmid assigned to this cpu.
>   */
> I thought when we write PID to tasks file, this task (PID) will only run =
on the
> CPUs which are specified in cpus file in the same resource group. So, the
> task_struct's closid and cpu's closid is the same.
> When task's closid is different from cpu's closid?
>=20
>=20
> Best regards,
> Tan Shaopeng

