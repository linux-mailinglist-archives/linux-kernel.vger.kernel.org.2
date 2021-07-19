Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8723CD5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhGSMhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:37:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31283 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbhGSMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626700657; x=1658236657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xJGsy14vE6tVNPSVClWzlrVoeJ+gC06+nDTsb4cR1F4=;
  b=aEPD35W/tHnvXsmGemFLrnAxr08cEua2tLWA57zDevJji+xUrlyQ0VcV
   zY8TmpGEEIna9kmtPzMtl3chNcAd1W2v0ysQxASOPBQmSpCYAfS5W4cuB
   VLsMB6CHjYwtZMwf1Dt1vUzQTczZ2AWR5Ngxy5GLudGsqd5EhA8ODoL4A
   AumvUs3afpYVYM2BuQ6/Qjl7Detlwq/q+TlkdbWHBUlYcQYN0CwDearLN
   p7A6KHCDtYUbn4GJ8/NcpaeI+jLfAA/0k6lukrI+mK+5iPxaLy4fpS986
   FQI0/9fP0b+Yo3Xs38S2XJeR8Snhi9vh70uMvmRNtGoeJkWvMuKk473Lp
   Q==;
IronPort-SDR: WkkHJ97ZxAV0SRrRBhXAWSZr4eG5Ku5z4B9pWHHTEaJCTtGQBCPD3wrG/6ejTLmkIBTycAoFN+
 QtTNWadpr0Di5oeIMBSl080Ei7P4rfQFysI7kNAE5uvZ1AIX+ePujWZWoxQyjZg3WFHDLkBYeI
 yJfsTefNdXAkPVE1neqR/UjJdqKHNmP27vSef6J+J1hZ80grYakEjbyUx440DkJ4ZZuVsWEoFS
 sWarX0INJsDzNkxnd08pckK3KqjTnBtJfxUrfDJxt+FT+sdqVDNK1ZAI/Q3hrGuThlClpSi85/
 Ldkb8Aw3V/Ki2eU+aJOQ1dTW
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="136471914"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2021 06:17:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 06:17:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 19 Jul 2021 06:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4qMsZ+O7G58imx9PnVsZ5H9ghNYQoUyCft5Bx5frehu8bXeX5+w/yje5dmv8uA1FzJyCEJ7FSzHcW1dX9qZZ3R9GrulFNbzD/l7foEv7XjC4jhTjWyicE/ZBu2ML/qraW9yMig4Eo6dBblAPb6B5mzxM/b6KMTXouvf6xnIyJ0jCrBjbd+Za5ae9qsejc+cmvg2iNhaETiGAdmu/VJlr6AbqN1PUIfai65g57ogUXpmzqMTCxC0xvg5g1udfzNQrr1jTWyrmVtJqk+Hd5T2Jp6w/76SEOtx+1/bLXpRJ0pOp+d5VIAsNlB+boLWFPo+Bx0ODhn7D102MMeLrmUm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJGsy14vE6tVNPSVClWzlrVoeJ+gC06+nDTsb4cR1F4=;
 b=kN1Xb39uQsznKhiuOhJfQDmco/Ygj8sqs5bqjnG3QWwQoiOEH4Op2TtGdOZ51995txKZD9iZdKjilJBZJ78eHaBKZHo0EMnLUQPEQT45P5hzAAU++dMyO89GY4nXdUeo4JXfvb201R4HK669vN93I6Xkf15PhpTnCj/7XOipmm9GWt0fXD42gAGBgpmywauGpsDt/qQDFk2AGta2jJvBuInpk9kPsHbXGkgPREUdmps5XBwcqThBFBK1ri2N5b135qGwUi20TXOTihy9IdB5GjDsNmOTQIPvfwK++qIFpAiy/pRDXiE5m7gxtVYUyDkXsh6vKi7inS/htD5R3P2AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJGsy14vE6tVNPSVClWzlrVoeJ+gC06+nDTsb4cR1F4=;
 b=cQvLiQo21noUY4Ljcuz48wwyoLOfygdzMol3/7S9L7hzEwHVA9RHsVlbuRih80Qotlr99/PFq8IuAec7zn4HuPI+WkCA7pUWYBrlU1HJYeXF4KytCgVBYp4tQfIxnf6zpJi3Ddip++puUC8R+XWA86iWY5bbs9kUsJmgh9pnpCY=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1993.namprd11.prod.outlook.com (2603:10b6:3:12::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 13:17:34 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::619c:afc6:5264:d3c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::619c:afc6:5264:d3c%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 13:17:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <linux@armlinux.org.uk>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <Eugen.Hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] ARM: at91: fix link error
Thread-Topic: [PATCH 1/2] ARM: at91: fix link error
Thread-Index: AQHXfKBuFr65/06yN0GtJMsL8tUyBQ==
Date:   Mon, 19 Jul 2021 13:17:34 +0000
Message-ID: <c8748c61-eb7b-4d1c-a770-b7f684fa9096@microchip.com>
References: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
 <20210719080317.1045832-2-claudiu.beznea@microchip.com>
 <9f5f6c1b-835c-46ae-6466-70aaafccd6e9@microchip.com>
In-Reply-To: <9f5f6c1b-835c-46ae-6466-70aaafccd6e9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d999fcfb-0c22-4345-939d-08d94ab7922b
x-ms-traffictypediagnostic: DM5PR11MB1993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1993150F58B1782CD2B2AC9287E19@DM5PR11MB1993.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VMCHoKRxDrRilnzStWh1hOcwgIkv8lIp9hMlL2/6sDnppYwjeM0w2WwFu0C6Uxcs+YPl+GcseMwUnKWnYco0YyqDYaXr7clo9G5EXRgwoLAhwiOpff7OmrQz5E3sQ0DTfb7LYXRlyqYUGXmC6LvXJzQS8UFOYLLJhO1vBRwBHllyIhQ5a2lHIwRzimcqs69DYha9tdSEnCT+V+FahrzS6zdjiy0OFU+nBDhrzt+Fh86IlNvCI4BPyp1D6OFl2m2QMs/rineVf6lSkoPYSvwjucz046TLbKJeqpeIlmYo8r5rxCSRW8BJjhPZLryS/6ieaEYhlDebNvBzN8MoHAaoJDa9uT2bVMLybIpAaenu6meNeWYrRS0rxvf81MsfHg7OfhjIHlaxxtCCBCflm3C/AEkiZczL8PAYwFCe80Wq6PJFsq0ftKeuAsVq/cvvu3UlXjq1LjDpSloeYdXKXfQQJsA3E3Rp78Pm+J5Tvhp9istdTO6ClTXH4YBbGxBLjE52ezDUPn9ipPbAR1OJUzNvQte3bez7dfrSeZWcufhtmbodiZsvA1x2bn++y72WGAaIfGsYDe9hqrtrh/lO82f/v5Firf57WMM0UIm37NM5nUd0XHwk84jpCEFXEldebhqHY5q0fHAQfD2FcLwpzd9i4tqI0/FknQtzU7hVBpmW21iNcovYRfyQNF9W8uPtB3XdK+ywF5nxY7Gt2OV5yX1WZkuq51dABLqgWstO9IoZVdkH41lNm7aII1xSkSYN4rkA1Tv/Z/RYQPz6xuDm+HSxrZtE0UApMZdiiPPgXoE9AgisCKdJY0L8dW4bilUSDhmQTzkZYzp10Y5UgHQr8ClWYY3CFLC0eCuAox/+ybQiIvIRMVIUj3DkxaSSIE8kHxq0ECc0SQrKfEcUFxbGL1JHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(316002)(122000001)(2906002)(38100700002)(4326008)(36756003)(966005)(2616005)(83380400001)(31696002)(478600001)(186003)(86362001)(64756008)(66556008)(6486002)(53546011)(6512007)(76116006)(31686004)(91956017)(54906003)(66946007)(110136005)(8676002)(66446008)(66476007)(5660300002)(71200400001)(6506007)(26005)(8936002)(45980500001)(43740500002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?wgQ9XtkUWOjHDojwtz7HUY9k9dojJIIlBpQ8yXoSpYBiKK+9UJjRYtLL?=
 =?Windows-1252?Q?puPaImwvWc81mBYje8UJuP9ctRxWpbo/i7uSc4SZUhwUJTzj5PdCnWRF?=
 =?Windows-1252?Q?eLKCcY/pxuzKflIA9wmaPgvcTfm30o8mp7QBmSLClVNrOmGfLWh6ofja?=
 =?Windows-1252?Q?WGsLugTT3zTSd599bAW6ZBEjFkzLdE1zMlJ1SwlHzW+3TdxMTn2U7sgx?=
 =?Windows-1252?Q?Kt3m9vpzt801d63/d72mWqdT7eseFDUql4IqbgV08skdHIp7ujrrc2KT?=
 =?Windows-1252?Q?Pq1nw7qBq1CJVn9eTQg7sAEf0dm0CmDOJrhStCq6pJVeyZS/EQa0SAZt?=
 =?Windows-1252?Q?/zN5KLr4WrZNHC50OkE4nwWZjQRWJjAOQSStpu+o5Izjn/SPEyoZRdVY?=
 =?Windows-1252?Q?+lvgL3qe6MiGqsVSK5kSlHX5NlZ2hRxRYFlpm+OcShaeZH2DMhSCbiNW?=
 =?Windows-1252?Q?4b9jbjTwG/sx/uZ5wtUAc/JQEThWpuBl04CCP3LGWYg5Ml8wWwRq6APW?=
 =?Windows-1252?Q?A11tP6bh9DdxjYPI6V9938g2Pxfd6RmcLjzLKcdIjKzMbkGQnYEfIgGa?=
 =?Windows-1252?Q?+koEE8DVKm+UMHQN5Gfwjn4p8UdZTBRnRDTWu73lzWpSaaQkuYtcEMbb?=
 =?Windows-1252?Q?UWecr9Nr59X5bpOGGTD0AGyYHBb57ZNHfiGjhL8fPoFzqEqcHA2cbDjJ?=
 =?Windows-1252?Q?9D5poDdjJZr2DUOiTBeZtIlI6OioQnV/uPsA08M3p20KTo4uXJBI/m3S?=
 =?Windows-1252?Q?hJQUJht8xpeWb5BhM1TpCrdLguPZGN6S5rl72iZhPlnZ/WMPREgL4+tq?=
 =?Windows-1252?Q?Ez/Iz9ucvFohEEzFkoMH3euo5R0ajWXe431WVW103qVWWh2g8u//FKzM?=
 =?Windows-1252?Q?f0cwoyhpqKSbzwR2dk7QbQZUN/tnuTvxRpcHCOsbXVy3woIZKfiogju7?=
 =?Windows-1252?Q?3IsSeKYHRMDteXRlETgUlMaB0yIs47Mp3xRhjrGTclWsmnMrqmTl2S1k?=
 =?Windows-1252?Q?lnJTnWLLNG5RpYDiDEedNUPxVichYcg3cqa+ikd1giSIkT5apNEP9o15?=
 =?Windows-1252?Q?8eLqKrdqVwlKQQ57mffwnO5I245E0JXir48cfU55Mg9L96H1djh1wFXw?=
 =?Windows-1252?Q?npPBrqUdICu1v8t/HThOXvyupLgL5ny4/WNcWolJCF/EeRG6gat78wkr?=
 =?Windows-1252?Q?Z/OsZlvsgx2wukPw5QaXHZPXSkCdZrAHKhLwXSqzSK4C0HcTt2JHlM/k?=
 =?Windows-1252?Q?lqn/K3CBdmY2cLI412jtO0z0xFqb2fipM5pLtEpYf3VWNhjF5jpraZcr?=
 =?Windows-1252?Q?oFqAf5Z5crWLFQPe4bFsCuqaPkpEVI5KEn2HiRKViWSfXc3b/51oETtF?=
 =?Windows-1252?Q?nGsHhWTRxKt60OeingSfkY+NGnmxozYXTGY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4E7D42B6D43C6C4B8750521987EB7FEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d999fcfb-0c22-4345-939d-08d94ab7922b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 13:17:34.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/O6I5JPK2eslgHPm5/DADUB0EN/OSaCo3iDxw3+SsQ1yG0y9U4dnDiA7sZZ1J+zM0RTz9G84pvL9dQdmDnJ9uy6DhC+8d1jB2Rn4yXmZbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2021 15:40, Nicolas Ferre wrote:
> Hi Claudiu,
>=20
> On 19/07/2021 at 10:03, Claudiu Beznea wrote:
>> PM support for SAMA7G5 has been submitted to mailing list before SAMA7G5
>> soc support thus the SAMA7G5 was not present in AT91 Kconfig file at
>> that moment. SoC support for SAMA7G5 hasn't added the proper PM flags to
>> Kconfig thus the link error bellow:
>>
>> arch/arm/mach-at91/sama7.o: In function `sama7_dt_device_init':
>> sama7.c:(.init.text+0x18): undefined reference to `sama7_pm_init'
>> make: *** [Makefile:1176: vmlinux] Error 1
>>
>> Add proper flags to AT91 Kconfig file to solve the issue.
>>
>> Fixes: 5617a08dd9e1 ("ARM: at91: pm: add pm support for SAMA7G5")
>> Fixes: 18d694ecd91e ("ARM: at91: add new SoC sama7g5")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>> =A0 arch/arm/mach-at91/Kconfig | 3 +++
>> =A0 1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
>> index f52b46bccd85..b09bb2279f7f 100644
>> --- a/arch/arm/mach-at91/Kconfig
>> +++ b/arch/arm/mach-at91/Kconfig
>> @@ -204,6 +204,9 @@ config ATMEL_PM
>> =A0 config SOC_SAMA7
>> =A0=A0=A0=A0=A0 bool
>> =A0=A0=A0=A0=A0 select ARM_GIC
>> +=A0=A0=A0 select ATMEL_PM if PM
>> +=A0=A0=A0 select ATMEL_SDRAMC
>> =A0=A0=A0=A0=A0 select MEMORY
>> =A0=A0=A0=A0=A0 select SOC_SAM_V7
>> +=A0=A0=A0 select SRAM if PM
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> I squashed this patch in 18d694ecd91e ("ARM: at91: add new SoC sama7g5"),
> verified that it compiles and rebased the at91-soc branch on it. The comm=
it
> message is as follow (wrapped):
>=20
> ARM: at91: add new SoC sama7g5
>=20
> Add new SoC from at91 family : sama7g5
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [claudiu.beznea@microchip.com: Select PLL, generic clock and UTMI support=
,
> add PM configs]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Link:
> https://lore.kernel.org/r/20210409113116.482199-1-eugen.hristev@microchip=
.com
> Link:
> https://lore.kernel.org/r/20210719080317.1045832-2-claudiu.beznea@microch=
ip.com
>=20
>=20
> Added lore link will allow us to trace this part of the discussion.
> Here is the new branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/log/?h=3Da=
t91-soc
>=20
> Tell me if it's good for you.

Hi Nicolas,

It's good for me.

Thank you,
Claudiu

>=20
> Thanks for having fixed that so quickly. Best regards,
> =A0 Nicolas
>=20
>=20

