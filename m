Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FFF310B01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhBEMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:23:05 -0500
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:63325 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231344AbhBEMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:20:00 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2021 07:19:58 EST
IronPort-SDR: 9kBijDSxWMYDTTaEpPbcTQPYxfggIkBkkYXbyQTNrGA2solyV4SPNGZ/mEoyhn/LNcLNFb/FaK
 Af/0MeowVdHL0FTiL8sb6a7qnpZFGmc/lH9hKIxmSVEhuCNU7MiQ2DMFnmsUf+MS3mvQBODhQN
 fTUvWwW9hyBjDNMUXhQS06NHgCHiBOOkGtnbAqC235xkJUwG87wzK9bIcnCsERW/psbzi9D66h
 hHUJ4MA1k7mwewTWkC/d624YG5rjcPSyP88Vou+bQvVSBJO8fIL8W83hQ2k7SyyEFIbTvGGwkR
 CXM=
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="25443526"
X-IronPort-AV: E=Sophos;i="5.81,154,1610377200"; 
   d="scan'208";a="25443526"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 21:09:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFoEw+1zxG4t4GUb7DpfB80CWSdkWgsqJcv2S9rs3NpfH3rd6skTTgHbuD0Onb9jx6mduga0AP14H/dZga8HgxFDh6Om6nmaWVyFIS0PoH3+cYGmucqHDghtTBaTr1QGY1t17XSrLO++9J83Tk4ggXbQqI/0mXYiDuiZSisOKkDmfuiKIzBLyiHdUBstQp7kZO0sVcozpwVGEPv/wwcCp6kweBfJb6HFPtO3ZFidONdu+/Ds2EtOHOAeK290cUNxwH0mNWlIv4vcTFVVHAVV+X6cuPmqd3Z61SK9PhKRhPVFG15aCibhx/xZcvUo2JhFC+NKEUU2HYwiNgWSkaOiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYsY5hso1YYhmf+jPZxVdUcLKLPsX7vo12VHdaS2208=;
 b=MsDeFKOeOlfZguuj8//Xt090oG2G/kanWoaZgd4VBfpT0de+OQbLNOhvG4Pvucn8j5pMTrpFMhx0cpIYGSApD7MXxZa70NetJbkzHPl/hSEKKbh5sDuZlnHfGxAsTlstH8abPkY9IMX+BJln2ABU8XHt2Z8FEI0wxQAJIrlgy2NKGTW4OD9jmEhD6/645kY8AXFFN4BYghhuIt7XmqX502WDeAfiAfOur8ah4KcI+x/9SICnARDRd1UR+RAShnLcDQN3AJGqPnQ8TE8gXmEhxDX+ufHdPWrcy094OnvEIwHfIVfqBe7CVLzYvgcIH+BSK/nh++IOw5MVIA9sh0rQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYsY5hso1YYhmf+jPZxVdUcLKLPsX7vo12VHdaS2208=;
 b=Pqqf2DvQ89FYYfvi8tAME/4VNc0kuMs9gAoFs2f9TWPU13vMzGEXikt0xCnHFmA+SMmmLn/7DpFs1o7AW5N9w6VuI+RYIQeYV6Yl9n/CZTBU2XcXEgIRHQM5fZl6Usi/DvNR00706tVUaZ4SG4zSN7dwR2kDxvoPEqnERvpCOrE=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 12:09:30 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 12:09:30 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Topic: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Index: AQHW+WMHTGeMdPN4T0+BYj0CxDS1qqpFEjAAgADvEKCAA3DPIA==
Date:   Fri, 5 Feb 2021 12:09:30 +0000
Message-ID: <OSBPR01MB46007C599F706F3C56B20E64F7B29@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
 <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
 <OSBPR01MB4600991FC47D2E5A7E013F0CF7B49@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600991FC47D2E5A7E013F0CF7B49@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: cdb6ff8e9907457089f5d378865df3ce
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b420603-da9c-4632-1d07-08d8c9cee429
x-ms-traffictypediagnostic: OSAPR01MB1587:
x-microsoft-antispam-prvs: <OSAPR01MB15872CEF8C3AF7408BA8C782F7B29@OSAPR01MB1587.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wa9V1hg3ZVxNJK9YemLN1jPRkUU/0rtCikwiXCqbEV8Qrh9WO4hw7G0Ihzo9D0e6s7syli82AzxBEUBykVMRbOG/RQwBqvT1WGPyfZMYZpMyupIE2ILfBnusR1Xcdl8c4C1KSzFnEttltdCc/FELwDkWh0DFMDdVSPibDK67c3SGAYlPiN3h4Sbn9xR09LBYCceoZvShx+4W4cyw+orOMhoyLE/uiWEKwRzQ0eaDGrAaNgc6yaSbtVX/n1HHzPwYSiL10sOybssEcQtZZfejP0YiywtmTKHPVOgyjnfyDLpKoUDAABOMQ04O9fp1C5kFXtzoW+YqQlkkDNXTyaOYvluxoNy0PQCEc1XEBkxZ0ScTgoUQeL4ue6uq/WjSUVkI2vfMDtT+AIoTN7/E6uRWo3nzj7UxrJhup1iX+TgldG+KBmcBTKAFEBX143Blap5B/2Any6tcwyV5sPSqoyDj61SfURDxXqf2GABEh1NpfPYPgBT6xGqwHKOoWS0jIU3OL7STVLytEetPbw8d8n2iW98T0fBufA8od4mY46fQ9wUVFqiSxBcffhztrkkZwwfbrQvlLEXuxsfWwK1hSU1diS4sP45uYpiiMdgUQLJyDRGzI+vfzSsmcI+T5lpoSBnzqtacqJ2NuVRxwQATawmYIMk503sDMhpQHYIDCOaGTDc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(26005)(921005)(186003)(55016002)(85182001)(86362001)(110136005)(54906003)(4326008)(478600001)(9686003)(2906002)(52536014)(966005)(53546011)(6506007)(66946007)(5660300002)(76116006)(33656002)(7416002)(83380400001)(71200400001)(316002)(7696005)(8676002)(64756008)(66476007)(66556008)(8936002)(66446008)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?TE5yak1MbEFhNjlNRmFjdUNHTGNFUHBPVEhQaVBBeHdHS2R0T0JsQWI1?=
 =?iso-2022-jp?B?Zi93dm1NMmhab3ZQMnh0SVdua05UR05lalZzMU1MUHpMMGVyUXZjdXFW?=
 =?iso-2022-jp?B?TnFnUkRWdmhxRUFkc3NTSS9GVmZUU1NMa3llUjdRMkpnblBnSUZWZklD?=
 =?iso-2022-jp?B?WXZRUi81RUkzRkJKbGtaODJpN29YVm00QU8yNjhrNVgzVVh5SG8yQzBa?=
 =?iso-2022-jp?B?Ym02MWtyNUFoZnNiYjhmME04c2F6QUNPdUozUHpZYTQ1WWM3Y05EYnNs?=
 =?iso-2022-jp?B?RzBJeEpDdFgvT0liNzJyQzhKb0NLUm5kMW5jZ1dpWjl4TEdkT0h1UUVR?=
 =?iso-2022-jp?B?b21NdXpzMnpOTUg1aFRiaktvbkpoSkRpUSszS2ZuY2sxR2laV3RrNWx6?=
 =?iso-2022-jp?B?akdtbWxuU0ptS1RnbkFzdEVFejZrWEhSZzlFZTZPbmdjY3NTbG1aMXJD?=
 =?iso-2022-jp?B?QTJ2ellDMUEyL1cvajBjaDlUYU9uSTdBL2ZWVUNlNVM2TVMwaGs3YVVy?=
 =?iso-2022-jp?B?TmRFY09LVm1RcEZpYmtpWWlrTXE1blFaQkRYWjZJZ0VuTE5kVE9OWWdx?=
 =?iso-2022-jp?B?bVBSamxISHNlcVhaNlBUcXRyN09mL0ovSnRkUG1wWjNNZzVQcTRRend0?=
 =?iso-2022-jp?B?LzcwWC85aTJNWW94YndwSmZ4K04vaGY0VklJVEh6OEFUa3RVeityN1pG?=
 =?iso-2022-jp?B?UjVRMHU0bXBGSkFTY0V5ekE4UTNuTk1HTGZmSEo1bWZOdTdRaDAreUo4?=
 =?iso-2022-jp?B?V2V3WnQzZzU5NmpsaDlvcVcxcG1CTTdVSlRkbHBYQUhleTdZOVA2TWx3?=
 =?iso-2022-jp?B?QmZONE42dmMzWTlLdWRDOXpsY2pXcFhVOFBPdnVZV01LaGpqdTRHbmNT?=
 =?iso-2022-jp?B?TUxlNmFLVFRSWDdYU2NtV2MrR3hsMTFwQkJmRFZzUDlJUmNqN2NpYmRY?=
 =?iso-2022-jp?B?WDdsRU5TR2Q5L0x1NmlZYm5Hd2lGZmVnUUxwM1VrT0NyQTBRTzBBVHhs?=
 =?iso-2022-jp?B?bll3S0xZZFZIL3dtb2V0L3FIT1N5eVVlTC95dkt0MHllc21FY1JBZHJH?=
 =?iso-2022-jp?B?bmF2U2VLZWNrTEI2czhrVHdJK3dGY3B3Ui91b0huQ2luT1dhSjNwWXZm?=
 =?iso-2022-jp?B?NWRvWlZDZ3NhazhicXQ1bXFkV0dWSU5ubGNNZTRzLzNxL2szdDlNRUh4?=
 =?iso-2022-jp?B?NWNPUFdWVFVkRU9kc2d1bTBNcS9XVTIwOGp0QkNpSC9LWGMzbHBEcndX?=
 =?iso-2022-jp?B?b2txcWh2WXArNWNCWXBEQVpKWU9TT1FhS2d5UHhjVTMvTURlM2I4ZXlu?=
 =?iso-2022-jp?B?WUVFdWlKSWVOTm1pMitJN3BpdEhaRzZjYzd4ODBiVlQ3ekMzd2Z2MXkx?=
 =?iso-2022-jp?B?RlZTRkdvTzhNZkc3WmNyRUhCbFJmVFNUTDNhMW54RDFkU1FlRU84RElH?=
 =?iso-2022-jp?B?dEk1bGJxblIrc2FCZGlWRENTQXhvZWM0eHovUlZUVlpQSlJlb203eE5P?=
 =?iso-2022-jp?B?c0Fqa0dWSE1CWEV5a2I0Y2crSzc4VUViZzc4M2JyT2trK0gvSklUSjRU?=
 =?iso-2022-jp?B?RXptcVo5Wk5iekhYRnFDTUNGK1NIWHNiUDU1VHEzTGtHUmMyNk1pUXNv?=
 =?iso-2022-jp?B?MHB3ZWF3Yy8rYkhUVEVCSkFZN1VnbCtuVE9vNEVpbmdNbmdCY2s4ejMx?=
 =?iso-2022-jp?B?cWVWRU83V0NldU9ITUlJeVBtY2puVDhmdE9qUFh1d3RHSCtJYktLbGR0?=
 =?iso-2022-jp?B?dk5FaFkzakwzQUVrQzlPK2lvdVh5b0crbzU2TjZNUTE4YnBCKzJRV1FG?=
 =?iso-2022-jp?B?U01KeUZ1YThQUUt6bXg1NGxHU1VhRFVtSTBzajhSTG1rVmVrTEJ0WUh4?=
 =?iso-2022-jp?B?Yy9ZVmdGNmZPRitoa1cwNXJKdTFDWXpKNTVySlF4c2IwREl0RlljZDBi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b420603-da9c-4632-1d07-08d8c9cee429
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 12:09:30.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJZn8BZPpJbtktJVbKn/Alqxc8z2+SfxF9iNKlHrxa385SWSR28qOx24xzmcyILFleq2QXULsj8mTRYILlfff32xoNhV5WfjJfzcTDy1IJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1587
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John

> > Apart from that, I think that we're a bit uncertain about patch 3/4
> What are your concerns?
> I think it's okay for perf to read a new event code with a number at the =
beginning.

The impact of this fix is on {name} and later rules.
parse_events.l uses {name} only in one place.
The only rule defined after {name} is {name_tag}.

I think the point of current fix is that the rules defined after {name} are=
 not misrecognize and the syntax is not broken.=20
{name_tag} starts with ', but {name} does not contain'.
Therefore, the corrected {name} does not misrecognize the {name_tag}, and I=
 think there is no problem.

Best Regards
Shunsuke

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of nakamura.shun@fujitsu.com
> Sent: Wednesday, February 3, 2021 4:02 PM
> To: 'John Garry' <john.garry@huawei.com>; will@kernel.org;
> mathieu.poirier@linaro.org; leo.yan@linaro.org; peterz@infradead.org;
> mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@redhat.com; namhyung@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH v5 0/4] perf vendor events: Support PMU events for A6=
4FX
>=20
> Hi, John
>=20
> > Just some things to note:
> > - please pick up and apply reviewed-by tags granted from previous
> > reviews if explicitly granted, subject to making any trivial changes
> > requested If any significant changes are made, then don't pick up
> > theses tags or drop them (if they were picked up earlier)
> I will fix.
>=20
> > - I'd say that it's best not to send my patch in 1/4, but better to
> > mention the series which this is based on in your cover letter Sending
> > my patch is only going to make the maintainers (Arnaldo) life more diff=
icult to
> track these things.
> I will fix.
>=20
> > Apart from that, I think that we're a bit uncertain about patch 3/4
> What are your concerns?
> I think it's okay for perf to read a new event code with a number at the =
beginning.
>=20
> Best Regards
> Shunsuke
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
