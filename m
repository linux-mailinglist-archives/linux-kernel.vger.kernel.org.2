Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6306A32E5C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:09:51 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:9965 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhCEKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:09:27 -0500
IronPort-SDR: jNzPJdntgc2tNBoNME/RzvM2BUxMoAslZgFAJXESxtcVzfQDWc+mmxbZMQjGf/l+IpcRWLYN+9
 ZrWyH/hda4BEJTqlLnzpQoNyQLsVMXyuEtfU8pCzJIxQQldXwpYbZlQSri/FoetqcSffwups07
 DUCR+sr9/3aLcGuaQWZk1Yz7wX9wGAmW/fKfAP6JoiE+wx4egd+PDmQT2OzAyGP+s4zFpRp2zY
 yF78VwHTVUKkBe2vFqw3VMxGObponhBuWif29Y8PNk/YEnHLYr26z8kmS5Sb0p8hp4cSViHaRZ
 A5Q=
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="35417726"
X-IronPort-AV: E=Sophos;i="5.81,224,1610377200"; 
   d="scan'208";a="35417726"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 19:09:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9wdaD+GSPdgUULqFB4PjNDVV+rPs5yfOnv8365nlZwKtZ2ylain9pNyT7KnGIll2QnjiMXeG7O79N6JSw3NoDevfnci+g7xkKW7TclBvP4yPosypqDLnRaCKPOic+vwi5WnhUjJNZwc5GbKLZfwC9/2R0ph1KtJplytiS0zVktNfrxBAIZBKnK1htdOb3yviK/jJwPsJRTDfQJpmjxHN1kRWLrCbhTiXy2dCrvtQ+UGsBX1hs8d5e9wGkMiSqyawV6Kp63pggenHKZnNd1dVPwcsEBThDXY+XPtyHrSJa23pCifG5MeDtqsk1+pTp/JjuzXHRa5zXRmnTfoyW+1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbxfW9vPaHp6E19iIKH15vfFXchxJ+Ef0hpgXq8WGSA=;
 b=CFDsyfrai88EAsuB7AMCgHXdzaNSL62RSp9GfW9OG8h06To0s4pZOc7i8vB9PdfU9r0KoLv9Guu891VU0daKtNZaclccE/xs2FvyBJAoC0lMfR0YQj7gTcroYBDLQJCQ7UZU4HndrKuqMsEpAAN5kHMtnpi4f7ZgrDhHrLuA1jIAAN6y65ztcbel5erQ6+wfgdpCa5mj3GIIyWadfaTuHqLVhFPuoHJUvGf72eo4vomH+CGnpdgyILxW1cBUNLZ++TMoVwqj2vO7lPzkH5f7azQPY7JTi/DioB52MFxayzTI/Q5CFAnnwdonVLzxTzrU62tWJBLQ+4i+4fKKeOB6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbxfW9vPaHp6E19iIKH15vfFXchxJ+Ef0hpgXq8WGSA=;
 b=FOq2mBhvR9B2lSV8AyIElf3mr02b8preGMpR0D1/nTpkdNL5n1ts2+dPtf7t69zl2cQmo2IZNY9sWmjvH9VQkuj37iQYY2u7Zp6rjsv3Q7CzH2UXPHMsbnloj+1BpJyFmyM5SDYAW3Ee5YV+TPF5dHvoZjTnKz9IpEcUCRlbZWw=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSYPR01MB5335.jpnprd01.prod.outlook.com (2603:1096:604:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 10:09:20 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3890.028; Fri, 5 Mar 2021
 10:09:20 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     John Garry <john.garry@huawei.com>,
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
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] perf tools: Add lexical definition of event name
Thread-Topic: [PATCH v7 2/4] perf tools: Add lexical definition of event name
Thread-Index: AQHXEKlBkVxBxv6w0EWmceCNSxz1JapzkeUAgAGbKNo=
Date:   Fri, 5 Mar 2021 10:09:20 +0000
Message-ID: <OSBPR01MB4600C6910F2AFFC5819C8145F7969@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
 <20210304032610.3112996-3-nakamura.shun@fujitsu.com>,<74955041-45ab-10df-e044-5d64898c81d9@huawei.com>
In-Reply-To: <74955041-45ab-10df-e044-5d64898c81d9@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aa102a5-5bd3-4e4d-9867-08d8dfbebe73
x-ms-traffictypediagnostic: OSYPR01MB5335:
x-microsoft-antispam-prvs: <OSYPR01MB53351D4E2EB889F0852F7FBAF7969@OSYPR01MB5335.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+Ye5w1jswTuT63zRoxD9MLnXqDz+dPdrm27AiBUb6ccs3OM6Ns8rk0cXxCLFLSKgElR2salddWaQA5b3/atWB7wo67mIX06JOU5jAzkJ8m1NaWCOuICZm+GWqrk+GE89nuDqCXNdooFHhKu9jn5/MdSIIJeV5DXgc7eNJNgWVOVKUTyRgLoAij86SdX2HeAEQeSRxNBV36okoEd95d5jat339JX15M6wuCR55QuU2IGlUZKhjEDMETQc33hi0YhTsKg782jX4vMDBjqg073HvmGRv4/nVCxoa/Eg3LfXnr8tfrzr5m/v7H3B4BYb9VxyY0ABlzuIhg+X6y7Bgw2tBghXnyz2xqplLM7Irj/yj6qDCfja1gRKnmHno/hnxGi3CAK1w7LyOoReIg+RXj15VO5tjv7NwlWc1OBCN32U6S4M7Ge1fZ1PICAe6t+xeQ0XqtwR0D881w59EKOTcenexUaoNB2pit3M72/YbI24+5pxof4A9dSD1xxNfYhK+L4W3qNbe0IdiXxGfyh+b00FWNcfc9u4W84CTI7J2kfN4kskf1im942NV7drKepFOLz8k8i8YkcrEMuHgtpiD3y/0E9VeA/xihb4lXtr7GxzG1cjSVjhcbLstj2+k+2X5cnEw7ojjzE51F79zAiRe7kIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(64756008)(33656002)(921005)(9686003)(55016002)(76116006)(110136005)(7696005)(8936002)(71200400001)(8676002)(66476007)(52536014)(66556008)(66946007)(66446008)(4326008)(5660300002)(478600001)(4744005)(54906003)(316002)(7416002)(2906002)(85182001)(6506007)(186003)(86362001)(26005)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?N3FiOGFFaFBKVnIvSXBRUXJLWGJ3b1ZoWWpnNGVwYWlMWWR6OVlPTHNi?=
 =?iso-2022-jp?B?TjhDR1pjNThIa1FadWc2emVJWmxheFpERFJORmwrbjdwQVNBU1dGRC92?=
 =?iso-2022-jp?B?cXJ0S2g2VXQxaGRma3pKOEJSYlBPeHhYQnQxb0l5dG0yS255aWtkZHI2?=
 =?iso-2022-jp?B?amt3eFJEckYzc01LMEovaVF4N1YxYXptaUQxOVFUaHpLc0tibnNkOHRZ?=
 =?iso-2022-jp?B?ZXhpejlsN3FwTFFra1NLOWxYeEV6T0pJdkRzaEVnTFJYU21WRGh1SWdp?=
 =?iso-2022-jp?B?SXpCZ21Pd2I2akZ6d3JBTkxEOW9ldXBWK2RRR0svNjZ4ZmFYaWlUVUtB?=
 =?iso-2022-jp?B?TlMzMmFrUnNsTzZWVVFzMlRuMFcyMmw3UXNROHlVcDE1c0VJU3Bqakg3?=
 =?iso-2022-jp?B?TGdPSEt1dm40S0p3RktSVG1EbEQvSXkxcnoyRzYyL1BESXBCMU5pZVVG?=
 =?iso-2022-jp?B?M2FUN0p1ckMxMHk2S0dsVlZCOUp5UzRpeVFnWFl2S2p2eGgzZThhSmNr?=
 =?iso-2022-jp?B?d01tU3F1SDRxZXd2WnRaWFVUbTdCU2tRL0pZYk1zOER2SVpHUWo5L1pn?=
 =?iso-2022-jp?B?UGFqZklrajAyeFRlVFN2OWZyQmh0WEd0R2wrdHBGR0s1WnN3RWtWdEJB?=
 =?iso-2022-jp?B?Y2hqWGxHSHltOXQ2SGhQM2wyQkhBdi9kcHlJOVZGeVRyYkEzNFJkYk8y?=
 =?iso-2022-jp?B?ODRIbUtvZ2w5WmZ5OVZnRnBUL09XU3FqR0NaUEhaVlhXcWUreWlkT1Bh?=
 =?iso-2022-jp?B?ZzY0V2hKczU3bVVKUzRYZHM0QVc2TmRENktWckVyaXIyNHcxSW1qclI0?=
 =?iso-2022-jp?B?NEhnS3h3K3hRUzdyRlUwbFh3TTliUjUvdm5YUXZ1UmZpQWtrSisrNC9B?=
 =?iso-2022-jp?B?ZUo2L25LTmZ3bmlOVnJwUWtoRlFhanFTV1JRY1NPZUlKZ0lBUkVUbGxL?=
 =?iso-2022-jp?B?T0JtWENUZUdTTklTWU1EYVVFTW93b1BhdUhNSUtwTUphQ2ZrUFlWTE4x?=
 =?iso-2022-jp?B?QXVJWVpGZDBhVWQ4WkwyVlNtZTlGRWtvT0NWeVpna3U2d0wyRGxFdE5s?=
 =?iso-2022-jp?B?R2lPdzRoV05iVEkrMGdPd0pCV00yMGtWTmZxYmgzZGxQbWI3NG1FKzNa?=
 =?iso-2022-jp?B?bkdHZXV6czZOblVSUDVnSjJYODRkSDVId20rU3orVWttdkhqK0JBOWNi?=
 =?iso-2022-jp?B?VFpPc3JSR2d4Sk9rZ29sS0F1bFUwb2xmeG5yWTcxeUYzbk9STEQ2eXJa?=
 =?iso-2022-jp?B?eElqaVpjTU9za2E3Z2xhVTFHdVJMUXYwZExwM1lJVFk0KzBxY1FGS3l2?=
 =?iso-2022-jp?B?MlY1dUJjak13SDJBMUZONzdaOFhsMXBFaGI0VjgvR1pCbmdPMkVPYnF5?=
 =?iso-2022-jp?B?VGJrYUc2OWlWVExkV2dQWTRwMEJubnRiVzNiQ0FkRW5sdkVZdzI2L3Nx?=
 =?iso-2022-jp?B?Q3BNam9MMnpSV3ozd0JqNE52Sk9yS1NTREdUWjMxZS9LYTBFR3ZpZEw0?=
 =?iso-2022-jp?B?VDRzdTlnU0ptN2s4V3ErWnJIa1ZpSnVyeVBORy9WSlRjM0lyazk2NmQx?=
 =?iso-2022-jp?B?aHhBVTd4OWpadUxxUXg4UktnM3JVU0JLYVhGZC9kbkpaYWlTdUpPZkRk?=
 =?iso-2022-jp?B?OEJpN0RQUElQc1ZiZFlPSGIzekhHdms1YTdaWmVEdmhQb0loRnIrMjRm?=
 =?iso-2022-jp?B?QktmV0ZiSGgvL2NFaFJEZ0VlSkpkTnpxSVpIelE3NUhUUHliaGl4OFhn?=
 =?iso-2022-jp?B?bEdYbDJIYVI3bW84RjhjUmhuaTJlbFNvUXlRZk5YYmV4YU9vNnBpdkJM?=
 =?iso-2022-jp?B?SnAxaGNXUHRZZFl1bnY1aUFlVUZKVHgzYkloOFJEMFhMMXZFMmIweUNB?=
 =?iso-2022-jp?B?RXE2eStQVVZZSU0zaUQzeS9qZHNvPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa102a5-5bd3-4e4d-9867-08d8dfbebe73
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 10:09:20.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNuaGj900QjP0McFCG7IGu0568aI08TQIpIOgN9hT6nhaieIIBTXdZPICYiiuUXqobg6u3MfTQQoGlMhpVmYwwZ4qfpoawgoVHa7HK6/wPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5335
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John=0A=
=0A=
> > From: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>=0A=
> > =0A=
> > Add the lexical definition of event name so that the numbers are recogn=
izable.=0A=
> > =0A=
> =0A=
> Sorry for the hassle, but it's not clear that we got a definitive =0A=
> conclusion on this patch from v6 series:=0A=
> =0A=
> https://lore.kernel.org/lkml/YCuo01Wxxe%2FMCrC5@krava/=0A=
> =0A=
> Would it be so much worse for you to change format of these event names =
=0A=
> to not start with a numberic?=0A=
I was trying to match the specifications published by Fujitsu exactly.=0A=
We also thought that being able to parse event names starting with a number=
 would be an improvement for perf.=0A=
We've discussed it with the team, but we decided to change the event name.=
=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
