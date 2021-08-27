Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594283F915B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 02:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhH0ApF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 20:45:05 -0400
Received: from mail-eopbgr1300122.outbound.protection.outlook.com ([40.107.130.122]:53704
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231434AbhH0ApA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 20:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLjReieNpeU50O9il/ZLio56VfS2UZDa23SpmTEoZUvMRC0qjyptjr2fZUh01ro4/rWP0ob1H+j5n+PkGPLb61IMog35KYSOqOdZ4V1IAyN5t/uAn78D12+LxjRX10W9wN4vnkN4fuCDw8dRDoNdktV/uUgoQGC0uJzVICAv0bc9eB6EQmiGigTuLlqJVuaeE5/b5o11wD7TlxsUZgzakF9krmOzBVvX1iKou+WixvcPABWTODu4B/yn0bbWPfjaLKsDNXhpPqiWU4N3hEjt/if3zLC55vf2UVcsf7u9uRzpDoXPHgYlMDxhNSCZm+DnT2bOFz4As/jIr0MBfJcITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VIjbQXGcNTMsaapW9blnztX1Im2UfcQlJsBL/5eIac=;
 b=d/sfwcHgaXUgMX4kaLeqjCsZLHujzQDnicXJ1q05POvFEk09usGSzQLj+r1M5My/fucej9qsEzLZ71xsx7uF+fgJJ7rS5OH5eWNiKnysKVDZATVsOcyK+4TxHaVNqrErYpQYhqMOiTV0DEmpGmMLHLyWPG5JrIopM/Ze2ttms/4IOb5vtQx1hSLirKBBcB+FjoouW6CDCycV5b5yI074SYs9QLLCs3VUB40XtTEjFKoefrw9PicTgXYNvdqGWyTAF1CmpO/xTtGiEexM7p9HQVlAcMRSldDDBUFBOB4MyaqWZYw1Z57wxkFdJHGKmIflhfgIrhSkjNd2bxH2HVsYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VIjbQXGcNTMsaapW9blnztX1Im2UfcQlJsBL/5eIac=;
 b=ZGNRHCuQ+kY8z7RsQkbLcSwKGVfjlHub5zEI00Ptg/LBeYeDt6jqOOp5Hd0+LrYbAXXMoAKQwmV/nIW/gd93+7AX8YMAIOpXen7hNjA7Y+B4VTMZlbU9v1GdHqXF3s+x7iEfYq1C/MDv+9ehb4ti4T7gcMBbb8GOALuPipy9ogw=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4027.jpnprd01.prod.outlook.com (2603:1096:404:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 00:44:04 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b10a:f267:d52c:1e5b]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b10a:f267:d52c:1e5b%3]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 00:44:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: Fix spelling mistake "faile" ->
 "failed"
Thread-Topic: [PATCH] usb: renesas_usbhs: Fix spelling mistake "faile" ->
 "failed"
Thread-Index: AQHXmnWtOY13w46No0yzjqdCsujc/6uGhB/g
Date:   Fri, 27 Aug 2021 00:44:03 +0000
Message-ID: <TY2PR01MB36923DAECAC98875B58799DCD8C89@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210826122658.13914-1-colin.king@canonical.com>
In-Reply-To: <20210826122658.13914-1-colin.king@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b09e4d4-d732-4e56-814a-08d968f3c4fd
x-ms-traffictypediagnostic: TY2PR01MB4027:
x-microsoft-antispam-prvs: <TY2PR01MB4027F15A8F5A8672A192E93CD8C89@TY2PR01MB4027.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1k39pkRiVRtGqRCSjfQTeilvwRze3Uq6ySrywrTkrRC65zfqC9nFABWL+c5dRrrGG3PeORgdZSqicGrgWlIa4RuAEJRYqXT9LEC5ahCX5aXANuRanFEHYythniMjCOqIyUN/fLSt4jwJHAGTK2KUbVlH71kvQBf5ElViNSVlaSHTuQeupH4UdnSCe7tMoUBu4gEGUHZj7VYBR7cIAXxBalrplqNPYD5xbVqvVpzkv46G5VBu8K1s7Uj2E1kJjkQqF6Mg4Ze1jwzg+D6yVTlFBX7iX+cElgNrN5cJiDaALGzZ4qNih/5KEnINTEHWI/Q2BK3rnf8KiKkGrKlIB9i5v0cwuf8yHXaaD0JSn/kteWrMeTSLlek8llN92n1JOIiOlo/VgVw1I8/HQ+2obeWdSouHZ3c+AS0FpU+dwJelx2D8MlTZPWCIKmLhRVqUIt38lCBMzUWdgbmVVpawg119GS/TmRQxU8J3lLSaCZGawE892YINvdrvaXgbWnF+tXe91lcKQI9cStPhzz/up8YFL7JpANyusCyot84KOtch4qUHYMuirUAe1+wdS/yeq/xT3rMuTdsb6yrQnC4lUP2tkVZ6H5z/+x9KqQDEtAvBNU6FPzc6g1sA44tYtGg7qKETdYFbbZ373Xq2fukHlm1IiHYFT77G4ZSL8eHdaUFiXuiR/YolbwImDupR1EIXk+gwGJgopFltR+r0+cxXP8kFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(9686003)(33656002)(66476007)(86362001)(38100700002)(64756008)(66556008)(6506007)(5660300002)(55016002)(76116006)(83380400001)(2906002)(478600001)(122000001)(7696005)(54906003)(4326008)(71200400001)(110136005)(66446008)(8676002)(8936002)(52536014)(66946007)(186003)(316002)(558084003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkZhN3FkZHhoTm02SVFDWUwva0pqcnRUbXNUbDNKcWxpMXlvVDhuN0NZNS9J?=
 =?utf-8?B?WHVoMjUyNXpiT1Y3aWFySUJVaGt1TjMvSU1iNDZOOE5xb1U5Uy9kcGp6bWxO?=
 =?utf-8?B?RWZHRUQrdHB2ZTU1UFVneDdiQzZqemdKbVBFS3ExYWI4ck5zcyttT3ppbTRG?=
 =?utf-8?B?ajhoSWxnQkxpTUwvajZxazBneWQ1RVF5S2NPMklFR3c1YllCSGV5My9ROGYz?=
 =?utf-8?B?OXpTS3QyK21xamt1RTYxbnBscmtPcURNTWFTZ0NOOFA5SWp5Z0NYYXdyMnJ3?=
 =?utf-8?B?bzZ3VTZSQXluR1lHd0t0QnJXdGU5V1NzWXIyY0QxK3puRjJTbUppd1Y2Z0lZ?=
 =?utf-8?B?bFJiZHYya1hMMkN2VVJTL3NRV3cwZE5SbWtnbDdMK3hEbHdjVFlJT0lJOFY4?=
 =?utf-8?B?WkdhckJGbHhKYjFYMFZaZE82ZGpTeXRNS01CQncyKzArd3FxUkdQZEcyeHI3?=
 =?utf-8?B?aXIrZFNOK0RjSDAzcmM2YzVsRWtBWEk5Y3V3S1VEVmd0aG5ON2dwWmFRMzVh?=
 =?utf-8?B?N25SaVp6Z3hpV1Z1Z24xZUlYYlZkUkZkdEZmNG9EUURqNVJqQllvUUhpUEtJ?=
 =?utf-8?B?Ym5FTkl4WHgwWFNVNUpnaWQyY1JXeU1panpOQSs2YVdFNG83RVF3RzQ2RUox?=
 =?utf-8?B?eDZlRHBoQS9ocDJjMlljdFM4RTh2enRHcnpWVlBPMmp4SkZ4Z2ZubDNTMWNX?=
 =?utf-8?B?cmFNVnZyVC9mYk9pckdHR3VCZlhReWNVcXVyMXlnMWlyR1ZjK0ZCSmQzcCth?=
 =?utf-8?B?dnVleFZ1N2ljVHVrNTJ0WHd6LzdTQjVXWFFLdERvbHlwSytrQXNEeXNmNmgx?=
 =?utf-8?B?ZGltQzVZT01MSVI3MlRLZlZFTEl4VmRFbURxeGtiNDhXcDROdzdvZTZtRXpW?=
 =?utf-8?B?eVN1UDIwaTJQbnc1aFBYNjFveCtBSkp4UEkwZzR1K0V2MTB2dnhoTlc3MFNF?=
 =?utf-8?B?dmd6R0kyK1FJcmIxbW1qVVFaeVJ6d1ZKSjNpdk1lQ201dDhkVkhmdzJYMzlV?=
 =?utf-8?B?TisyRG00UWNMODdqdzdjSEtrUGI3MHJDb2FFZkltditnTEdHR2pZanBzVFAy?=
 =?utf-8?B?S3FBSzdIMjE1WmVHYWhlQ0JDTktvSDZ5NG1NVjU4YTBvaDRUd3RLRlVoYnp6?=
 =?utf-8?B?Wmx5cC9PMDR1YzdINEdqTnFDeUorOVprTmFwT0RybWpKRWdLaUVOOGtwYmla?=
 =?utf-8?B?NFV4a1U1VmdJMlFGbHo3RmJqQzg3cDJIR1kvTDJrb2paSW1RcEV4QnJ4dTNH?=
 =?utf-8?B?WDU5bituQlowbVRBUUhLWHVqRFgzVXluaFVyQURvNTQxbExxQmpqa3l6bXVY?=
 =?utf-8?B?eGpUY2hHb3R5V2RjWlR4OEFxYlRld1lib3A3N3BUNDduVHU4eXVhOG9xZEdt?=
 =?utf-8?B?eFowN2JsRmZyTmJCUlV5cS80ZUE2NWVCSkF6ZXgrSE91S3FSTGg0R3luMUsx?=
 =?utf-8?B?VEw5OW1hYWhvaUxSVWNrYk5pbXRqdHF2UlBMYkhCVWl6cC9oNFRzVzI3UW5U?=
 =?utf-8?B?RkF0bDVTMURhRzQvOUpKYU93M0Q4Vm1DZS9iTEU1YzNsMTAwZEVoKzUySUlR?=
 =?utf-8?B?YmpBUzZXUTlWR08zaTRyT1BZZDkvcXBDcGF2SWdObUI3aU5LM1hPT0xlMnFW?=
 =?utf-8?B?TlIzU1psSDNXM2Z5cGltK0NjLzdlVTA5RVJxeEJ0Y0ppQ0UzRGllMU92Qm9T?=
 =?utf-8?B?ZVNRWVJLSHVBV3BhTm9IZVVDU0xXZkdNNmxVdklLeEtRMVJNdm1leE9aalJE?=
 =?utf-8?B?aDU1eW11dEVCSTg5Q0F4Q2VSajR5Njc3QkpkY01XRG9oUkJBNGpVMGhjbVM1?=
 =?utf-8?Q?vsVIsNZLCpF+cOOvZ191BmL53aq+ZPer/n/Lc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b09e4d4-d732-4e56-814a-08d968f3c4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 00:44:03.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcJtvSZnTvhPpVnZjZf6DwvmLwFWrXlE6Vi+YK7XgN9N8jWuOKbh1cDydsXxZMF+cDqxlQkDS4i6WHs1aeRtYpbUBRUsWGv0t5iUL0uUob2fPnaE7ESg5+aEbdxwJMYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNCj4gRnJvbTogQ29saW4gS2luZywgU2VudDogVGh1cnNkYXksIEF1Z3VzdCAy
NiwgMjAyMSA5OjI3IFBNDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPg0KPiANCj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgZGV2
X2VyciBlcnJvciBtZXNzYWdlLiBGaXggaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBw
YXRjaCENCg0KUmV2aWV3ZWQtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9k
YS51aEByZW5lc2FzLmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
