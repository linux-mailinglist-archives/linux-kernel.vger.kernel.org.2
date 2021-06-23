Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8C3B1416
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFWGpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:45:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34736 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229660AbhFWGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:45:39 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15N6fjX8032639;
        Wed, 23 Jun 2021 08:43:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=WzfQJgcs7xzreysm3BAuTrx/rGjFPAoKX/YMMp53XCk=;
 b=wcM4uxV83bUeZelURHUv3iQiK7LsrYX2Y9ii/7AocpJIsFHWlQUUG+pSroRrt6Yz6YgB
 kDr83QuqOa5YJvctAJPe0XvIpGCT18uaSGWNasRRel6vc74+EnCoqceV10lrhqeLHNNR
 W0KOe8tA7B2Wbs5Cd8/ArKh8dCEWUjX64uf8FYjNZKagd9bgibjc6zVa5IPQMSFG5S6K
 nXU5fiR3SOw2v0AxjWFrYk1ZnU6phV/Ctd0dQnw9m6T6ogk6qII8LVBoVvlfYpB5vRJW
 1PkDGz90p5Fn1kDaQFZ59kBmAkkJ2OtUpTHcf8F651hGLS4oWY/A2NKN/1jtctyI7GSp jw== 
Received: from eur03-db5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
        by mx07-00178001.pphosted.com with ESMTP id 39bbk86ep6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 08:43:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IccT+PtCjtAkeLDqRG/9DVPx/HkH03CTZTmsv2RnqpJqpHq7jV5xi4UzR2TyCH5riE7vV7CpK2A7plnxQJDwvG1o2ii8jCsrxx9ciQuLScuvVKVavBS3bed4luaKTAUNcLXU10c7fWyeov8tgH+fLhK3hj4xltzg/o5Ct1jU7iRznuJGdIh7VgmMhKjEslh3BugOax4j51iNFiebAdxHZvZDDd5mJEYr85NOa4cXCzQZdnlIfJK5z2pAHzVPztD1cYElYQ45X6ROT5il0eXuUzbgGGtHYCR4zFTHLyEhSh8GWZwQ1jXMJvtEAMvJvLDRznWWPPHqT2wiO7ei/oh0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzfQJgcs7xzreysm3BAuTrx/rGjFPAoKX/YMMp53XCk=;
 b=fx5IeK+4xrh9VleHWqYc4f/US1BSPbNostsEADDKlEZKZYJ+MoiZa+W1723BMcYuW5CqQkTNUgp+Vb26Btgf8lD8jPwnrDah+XOZy+baU+OnuB3j9PvDH6glNJduEd2ui0M11FOpWv86rnNAKbi7IGM67D9jEtEugBfFWCjSNVcrjdg+boThLm+boH8OUPqRv762H5hJ1WqH80uvnCi/h6/4S/9qhq6joINlbhMmuO9VL7boXS+w8Bvx7CaNtYV8FXeB6Rq3nRc3bC0hhAlek/9bMjjZnyLJS5UIefVVhXm16Tj3lH2GTG36EpQ/PIafs3g9el9Xh4/zAsNqtY7YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::11)
 by AM0PR10MB2850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:132::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 06:43:10 +0000
Received: from AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c24:3471:b4a1:351b]) by AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c24:3471:b4a1:351b%8]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 06:43:10 +0000
From:   Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To:     Dario Binacchi <dariobin@libero.it>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Gabriel FERNANDEZ - foss <gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Thread-Topic: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Thread-Index: AQHXZ6uOCktfUfYWYk2+Yi5wSfjGMashH4G3gAAFh4CAAAFGMg==
Date:   Wed, 23 Jun 2021 06:43:10 +0000
Message-ID: <AM8PR10MB4785F58DC33E888BFD2B9E9981089@AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM>
References: <20210622211401.25604-1-dariobin@libero.it>
 <AM8PR10MB47856D4CA879CD0230ED171081089@AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM>,<1431023086.718458.1624430227963@mail1.libero.it>
In-Reply-To: <1431023086.718458.1624430227963@mail1.libero.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2021-06-23T06:43:10.347Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged;
authentication-results: libero.it; dkim=none (message not signed)
 header.d=none;libero.it; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.76.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25592df8-22d5-4608-f043-08d936122af7
x-ms-traffictypediagnostic: AM0PR10MB2850:
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB2850624B6DE2A31285AB1BE481089@AM0PR10MB2850.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsg7rHBNPiNHN9ynmpjai9Ju8R69WnLe2w1e2ymAXifKb0Nh9GWqz0ONFHAGRz6OR8RI8qaSyZNmxzcO9dA40bQuG/HK5Mkvt2IK/DvbdFmDz3WvkLrjatYEm7O4KvKLVSgF4v++HdOdow+gWBmd/N2gwSUjJeKcoBYmA8SX2zj++2CfIiNqEwt/YjoLMr3GTfvKP8wL3XSdjd/qp1bVqugmMKNG8hfgumwbk98CesONq7WyoNxcK7hrK+kprPY14NFEreoIbcJMr+7UlRSfvSaUoRvdIHl2pCni8vV/ZvOo80i6qsH/GPcrIixFaNqIZm3qEY/QXHWAmLsVsW1YaLDMobt5Y0Md/77lBYNbjUtPkC5zhAI/SXAdX84/O4llFGqXk0P4ETlcSdv3RbWkBlmGZIK+IYwv8bf2D1GJVEOcWQaI/K66duwyOi8zPcC0R6/IrdF1xBnoZSylRpyIadlhiN+SRAOBTkYdAq6ykc59y6+bRZDWzjFgIssZZy66CQqAPjGIeX+NPAtqsLkSvfDErVKzqU6VLCDoRtlaDr1TLcjOEXZje8961f/CA4Z+bDfKwRVwWeOUaqNdHng0UYgojLi1TVYDsheuQkljgiCD+CriEvv2nh2RFVH4u8MBma3DLxVYc9ruo9kvUjG3dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(9686003)(2906002)(83380400001)(33656002)(86362001)(5660300002)(26005)(186003)(53546011)(55236004)(66476007)(6506007)(7696005)(52536014)(122000001)(8676002)(55016002)(76116006)(38100700002)(110136005)(478600001)(316002)(4326008)(54906003)(71200400001)(66946007)(91956017)(64756008)(8936002)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aJQFw5ATVufI9dHElnEBlwQI211wevuh5r+vUA7y6Yvo3NgG2Tnow9kM+b?=
 =?iso-8859-1?Q?sX5vDzU+XA8uZrAZCc58Tq4SDnoO/lJgiQ1oHEuzsiDfRsutJPwUPQa0Bp?=
 =?iso-8859-1?Q?Z8bsw+FGh35uS2kgCIsyrkbLbG1z04kwxssZvdoSb5ThabhnmosR2/VUTG?=
 =?iso-8859-1?Q?EseRfICWr4MFMQ3e4Zi5p3TrNS7otSuhbJxsCRql+tVQ+UK+7PnAcXQgir?=
 =?iso-8859-1?Q?AQu/l+oCv4NghDXwObePVxhMtnIq02UFfOP5Th1Uxp7+j5fchZkowc5OGE?=
 =?iso-8859-1?Q?7EGF0OM0m1KeGM3b5095X2TXbPVl1hNrgEBdchklmFEF/pRwT5HhTovTl5?=
 =?iso-8859-1?Q?zfx4cFsCn2VJXlMvmAPcy7+WY47yeBFfurmP+qJ4bmfVBhrFQO0ee37T6C?=
 =?iso-8859-1?Q?/DIDdTZBuM8yKlCXkfJFrAcFo2a/NsY+nQeSWre4jLwhojSjK14m29ZRiL?=
 =?iso-8859-1?Q?h4deYR+BMRfgHREc38J9cjCR3NseyjoMGMxoz67sNa6V9prM6CR2rYXvRS?=
 =?iso-8859-1?Q?fvSgETK+vyeO1vwkJp2LCIL5M3kMW83wyn1maL4/gbBynEi1IWdeCUaYqH?=
 =?iso-8859-1?Q?V1dlDO4FWsVNvCiQ5GzQnXqEywf7IczETzfCgTfKZpmrAXjdma0Rd+kHuz?=
 =?iso-8859-1?Q?Xobu/fb6rioIhHGck3iVyQpx3bWQae36M82Z9tArIj9zqCP9KAneuUnQP9?=
 =?iso-8859-1?Q?qX2GTrOTV3bX/dMr7ARQspyVwwXBAYco0uAfsi3oKWZBlCjoSkL+9OjWst?=
 =?iso-8859-1?Q?n6UqFI08hhy74uKN5eMYw2B3AnSeai+3OGkb+da7rRHRA9rwVYyoiZkVIb?=
 =?iso-8859-1?Q?jq0OiinuDJ5hTlehKcdCieEGfx4LwvUkpXArFZGarlGYbeYZ+74PipyPRJ?=
 =?iso-8859-1?Q?Yyh9sIBWpmnoPAaotAU5wcm/Dudo+kUkQfjBrxacFJJdQj+E19+USYptKC?=
 =?iso-8859-1?Q?KJcekBuB797EIhX5CoMMIORnQVEuT1ZrTkSff4v1ie39YsSBJC05C4lXrl?=
 =?iso-8859-1?Q?NzzpdtGQGdyUZU//GOSqGE9orGz0lQbcYuv9brn8CzQAnMMLUo/xkusmgb?=
 =?iso-8859-1?Q?wGxt8I5l+KepV/r5iX/pVEWd5dxoMmguLRouIklNH4j+L4blcTWsslgY6T?=
 =?iso-8859-1?Q?hzrOYS694XZ3mM4S+JocmwgRqAGWol0W1bLAI8pDO8oqXjf0RLybhNq02y?=
 =?iso-8859-1?Q?DiwFfnTuHfRllwMZXGdT4X8IK483anyr20asYzUJPMP1GnZ9hOZc62RCxQ?=
 =?iso-8859-1?Q?HvF4tiUzG6NDxIh4K6bMLeGF6yeayQzscDDVLkiCn4gEfekmVivbGn33Uh?=
 =?iso-8859-1?Q?3abkFQnahAS9YpiC+prBY1Gyrwolf/zS+19djo0+FROwkIbk/sTsU8IjX0?=
 =?iso-8859-1?Q?1Bt/SOWpMW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25592df8-22d5-4608-f043-08d936122af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 06:43:10.7381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eW0Fkt9NTgidbivPttnBAFJbYGGRadu5+j0N8VT1TEhyLZwWQ2HCF2/ZF68vlkAnj4HvN+wdVzKDNcSzDl0MyANx3+YcqVYBWDdv0ySjbZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2850
X-Proofpoint-ORIG-GUID: ZYhsfXn8yM6zN7YJtxuGHh3eF1-XlyqV
X-Proofpoint-GUID: ZYhsfXn8yM6zN7YJtxuGHh3eF1-XlyqV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_02:2021-06-22,2021-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106230039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the same=0A=
=0A=
=0A=
From: Dario Binacchi <dariobin@libero.it>=0A=
Sent: Wednesday, June 23, 2021 8:37 AM=0A=
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>; linux-clk@vger.kernel.org=
 <linux-clk@vger.kernel.org>=0A=
Cc: Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>; Maxime Coquelin=
 <mcoquelin.stm32@gmail.com>; Michael Turquette <mturquette@baylibre.com>; =
Stephen Boyd <sboyd@kernel.org>; linux-arm-kernel@lists.infradead.org <linu=
x-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org <linux-kern=
el@vger.kernel.org>; linux-stm32@st-md-mailman.stormreply.com <linux-stm32@=
st-md-mailman.stormreply.com>; Gabriel FERNANDEZ - foss <gabriel.fernandez@=
foss.st.com>=0A=
Subject: Re: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs =
=0A=
=A0=0A=
Hi Gabriel,=0A=
=0A=
> Il 23/06/2021 08:27 Gabriel FERNANDEZ <gabriel.fernandez@st.com> ha scrit=
to:=0A=
> =0A=
>=A0 =0A=
> Hi Dario,=0A=
> =0A=
> I agree with your analyse. =0A=
> You have to change also 'u8 pll_num' from 'stm32f4_pll_post_div_data' str=
ucture into 'int pll_idx' =0A=
> or something like that.=0A=
=0A=
Always in the same patch or in a different one?=0A=
=0A=
Thanks and regards,=0A=
Dario=0A=
=0A=
> Many Thanks !=0A=
> Gabriel=0A=
> =0A=
> =0A=
> From: Dario Binacchi <dariobin@libero.it>=0A=
> Sent: Tuesday, June 22, 2021 11:14 PM=0A=
> To: linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>=0A=
> Cc: Dario Binacchi <dariobin@libero.it>; Alexandre TORGUE - foss <alexand=
re.torgue@foss.st.com>; Gabriel FERNANDEZ <gabriel.fernandez@st.com>; Maxim=
e Coquelin <mcoquelin.stm32@gmail.com>; Michael Turquette <mturquette@bayli=
bre.com>; Stephen Boyd <sboyd@kernel.org>; linux-arm-kernel@lists.infradead=
.org <linux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>; linux-stm32@st-md-mailman.stormreply.com <li=
nux-stm32@st-md-mailman.stormreply.com>=0A=
> Subject: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs =
=0A=
> =A0=0A=
> Enabling the framebuffer leads to a system hang. Running, as a debug=0A=
> hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c=0A=
> without taking the console_lock, allows to see the crash backtrace on=0A=
> the serial line.=0A=
> =0A=
> ~ # echo 0 0 > /sys/class/graphics/fb0/pan=0A=
> =0A=
> [=A0=A0=A0 9.719414] Unhandled exception: IPSR =3D 00000005 LR =3D ffffff=
f1=0A=
> [=A0=A0=A0 9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9=0A=
> [=A0=A0=A0 9.733008] Hardware name: STM32 (Device Tree Support)=0A=
> [=A0=A0=A0 9.738296] PC is at clk_gate_is_enabled+0x0/0x28=0A=
> [=A0=A0=A0 9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38=0A=
> [=A0=A0=A0 9.748857] pc : [<0011e4be>]=A0=A0=A0 lr : [<0011f9e3>]=A0=A0=
=A0 psr: 0100000b=0A=
> [=A0=A0=A0 9.755373] sp : 00bc7be0=A0 ip : 00000000=A0 fp : 001f3ac4=0A=
> [=A0=A0=A0 9.760812] r10: 002610d0=A0 r9 : 01efe920=A0 r8 : 00540560=0A=
> [=A0=A0=A0 9.766269] r7 : 02e7ddb0=A0 r6 : 0173eed8=A0 r5 : 00000000=A0 r=
4 : 004027c0=0A=
> [=A0=A0=A0 9.773081] r3 : 0011e4bf=A0 r2 : 02e7ddb0=A0 r1 : 0173eed8=A0 r=
0 : 1d3267b8=0A=
> [=A0=A0=A0 9.779911] xPSR: 0100000b=0A=
> [=A0=A0=A0 9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9=0A=
> [=A0=A0=A0 9.788791] Hardware name: STM32 (Device Tree Support)=0A=
> [=A0=A0=A0 9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (s=
how_stack+0xb/0xc)=0A=
> [=A0=A0=A0 9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__inval=
id_entry+0x4b/0x4c)=0A=
> =0A=
> The `pll_num' field in the post_div_data configuration contained a wrong=
=0A=
> value which also referenced an uninitialized hardware clock when=0A=
> clk_register_pll_div() was called.=0A=
> =0A=
> Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")=
=0A=
> Signed-off-by: Dario Binacchi <dariobin@libero.it>=0A=
> =0A=
> ---=0A=
> =0A=
> =A0drivers/clk/clk-stm32f4.c | 6 +++---=0A=
> =A01 file changed, 3 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c=0A=
> index 18117ce5ff85..42ca2dd86aea 100644=0A=
> --- a/drivers/clk/clk-stm32f4.c=0A=
> +++ b/drivers/clk/clk-stm32f4.c=0A=
> @@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[]=
 =3D {=0A=
> =A0=0A=
> =A0#define MAX_POST_DIV 3=0A=
> =A0static const struct stm32f4_pll_post_div_data=A0 post_div_data[MAX_POS=
T_DIV] =3D {=0A=
> -=A0=A0=A0=A0=A0=A0 { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",=
=0A=
> +=A0=A0=A0=A0=A0=A0 { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s=
-q",=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CLK_SET_RATE_PARENT, STM=
32F4_RCC_DCKCFGR, 0, 5, 0, NULL},=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",=
=0A=
> +=A0=A0=A0=A0=A0=A0 { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai=
-q",=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CLK_SET_RATE_PARENT, STM=
32F4_RCC_DCKCFGR, 8, 5, 0, NULL },=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SE=
T_RATE_PARENT,=0A=
> +=A0=A0=A0=A0=A0=A0 { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CL=
K_SET_RATE_PARENT,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STM32F4_RCC_DCKCFGR, 16,=
 2, 0, post_divr_table },=0A=
> =A0};=0A=
> =A0=0A=
> -- =0A=
> 2.17.1=
