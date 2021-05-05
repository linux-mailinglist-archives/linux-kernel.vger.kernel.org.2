Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D52373862
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhEEKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:11:53 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:34465
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229689AbhEEKLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsodtuWwSZObq83oTYnHF7DJS3/8HxbuEKbx08uVYEtpJVaCnqarrDl38buv2Kuem/dKK5Cuk4/TCvvfFhs9qYYXV6PDfRjECVEvgLeeM5FqfS/ufrHDtv42ZS62P14Dhe5KmCX7i5MKr8lssz6U7K3cBE4x52CacmO5Qm4BIuRdVNFHVl2g20sNm0TDWam+HxSZNH1MIANoAVN4xGfsT5aBkdNDapDXOOemJiJZjzA6dz2r0vnMYbAdY6I2oA0X/MS7xd9Yozpzs8lKFU1eu/XWEkEVMz4cIo1Ngn68VlMk5+4lDQvoMg/R6jeFOSZBTA1sP0VFPElS592tnjFB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrpbyIPvJMvzJD+6x6EM4ErVvU1VwpwqS2A62aqC5os=;
 b=oc6s9wbVDYS2C4j3oPhg4gl0zgTaOPBTspXY/ceb6GpcU9YoYIxpTrq+j62munOoeIKpdZdEXPfwk7LSmQmkUIfXe+t0b5B0FjBQAz/n3aC738VPXKc0r+tnxZIukHlqOc657pIFJihhIa81XdmELWV2gHqNFpOSdt6WhGbKS6DxnZY5EQcASCqTUu+IwTvUvMIkxKcof3B2QlaS3clDVVUffdpNFsVN/LEdYHVeG+d0byCgoyFOFumY1z4qKoJtvi96mF8ehBIV5BUNfJyYMHIXpTb2U/8pR12gtZPTIhUeXmrGT9uUZ+3W3M+zDTGCcPYgmRT/F3nWr4p6OHpB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrpbyIPvJMvzJD+6x6EM4ErVvU1VwpwqS2A62aqC5os=;
 b=Q6dLm6RDj8OWVINK8/6PMEQNvHECUmRyA3h1NQuVgkOogXwZhcT9qxIwHO8EBHrX4Mu4aHPDyUyGdpj/DrspZlN9HLIPEhTS00QdWHDFWz5nIidtzFHasCC1eD3oTBXvT6zyfqA51Yzs2P2E9X7ptPYXcw7tldkefwksXJaeygI=
Received: from BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18)
 by BYAPR02MB4344.namprd02.prod.outlook.com (2603:10b6:a03:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Wed, 5 May
 2021 10:10:52 +0000
Received: from BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f9c6:6c2f:3084:89b8]) by BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f9c6:6c2f:3084:89b8%3]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:10:52 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "quanyang.wang@windriver.com" <quanyang.wang@windriver.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] clk: zynqmp: pll: Remove some dead code
Thread-Topic: [PATCH] clk: zynqmp: pll: Remove some dead code
Thread-Index: AQHXPn2fNc4/u5hEg0mmySXeuab37arRM+wQgAAPdgCAA20E0A==
Date:   Wed, 5 May 2021 10:10:52 +0000
Message-ID: <BYAPR02MB3941426A2E28DC3B3D38CBD3B7599@BYAPR02MB3941.namprd02.prod.outlook.com>
References: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
 <BYAPR02MB394182A55D073BC6061F6D76B75B9@BYAPR02MB3941.namprd02.prod.outlook.com>
 <d47c05e0-14b9-c64e-1468-4bae7db83840@wanadoo.fr>
In-Reply-To: <d47c05e0-14b9-c64e-1468-4bae7db83840@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd30640b-4bab-4cd9-fc2c-08d90fae106e
x-ms-traffictypediagnostic: BYAPR02MB4344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB434401B6FB2E0AB3E466428DB7599@BYAPR02MB4344.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAQlt6rKcWXEXlAJ4+f6UESv8apL2wiIvANPAe9CPE39nnVv9tG8X/iv9W9hxQz6sIZAzaSEs3D0pFfiN4rwn/Dddbs8n9FGOXRJvJrghmLDy3AmX/tznju+M+skgG//pHYeEFJoj6fscPeZWJmuks31Bn+m1c2LAatxfSX9kz9S6kt1f1LVcMX3ksBGTjpYEPPz+5sQc7b9+Q+DNHXyKwIGPU/f57sxyutnUtcnIzD2FNOnIXXsLMkmuhUEu1wU10mOntbguZZ8/JqKQiZztFCr9MPKx32NydJwu4L8S9N4GOrDgCGghLKeGW6QzVGPVYbVrxJHdHVstKqgw3Kkcrmjm6NtnEIUlSea+UgGH1NH3LblY2VtQbHPDgAA0mJurzfD4lwvr2+vURwzDd+mJRdWsjt96EFQ+MwwzJY2p4rteoUI0rS2FAZ8SSsw8f5maGmyQ9DBbglnw2su+lMYZNAoO94nGQR2pE5o65nEZMHga0k+jyLJKkV2vzvDjA5mTjfOxQD0EEJW6NghCbp8CAiwPuUJnJBYxQ1lzPjq6CDfilAZ8ND4Ii/1Q7aoA9T7D61lyPLNJg8Vhi1rRlhlic3hHp5k02Ed0MjtnyozYL39pDfReOzqC6wZw2yJ2lt39FrL+su0io4ul0FFjC1WNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3941.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(54906003)(83380400001)(33656002)(4326008)(86362001)(122000001)(110136005)(478600001)(9686003)(66556008)(52536014)(2906002)(8936002)(53546011)(186003)(6636002)(8676002)(71200400001)(5660300002)(55016002)(7696005)(76116006)(66946007)(66446008)(316002)(66476007)(38100700002)(6506007)(64756008)(26005)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MnVJTEJOR1lZOXk0V1J3TS8rOHExZUVuZ00yVE1pSXI5bmJZQmhnOThFNjNS?=
 =?utf-8?B?ODNXTjZ4RUF4eXVpem41Zmd6TW9EVk0waVNvcS81bmVpME1jYVExTXgxaGxR?=
 =?utf-8?B?SWdMY0JOQUI2Z2NGZEJmdktlaTZDQVpsKzdJU3dRMEZMS1NYamxsSG81cTla?=
 =?utf-8?B?V2ExV1lVU05nTkpYdTFyRHVHR0xzNndSQzkycXpMUmdKSDVJWnJYakhFZGlm?=
 =?utf-8?B?U3VPZjJGOFNDM2l1OWsxd1YxSHh3SmVHOE1IckpsaERLTnpaSEkzUmRYa2Nw?=
 =?utf-8?B?SGJQZElmR3NYUkF6cHFmbVF6a1FmWTVwSUwzMGg2M2tUczQvbWFmOGhaU0Rr?=
 =?utf-8?B?ajZsTkJ2VTlnNWVuWVBOMlZXLzdGWUJqbE9kVk5qbHZHQndTSGk4cEMrWHRy?=
 =?utf-8?B?YkVMaXFSRU04WnBmR0xQVldWRnhBa2Zha1lqZjgxRDNJSi9KK2NQemZ0VFlH?=
 =?utf-8?B?eEFJalFKTkFwbUZXRFpvbmRiVjVreCtxUWVKSUJFVWZFY2VBMnZJbHd4b1Va?=
 =?utf-8?B?bkRlWWFPTDdaWE9oNjJxbGdDYjh5NFYyVXIzdVA2NlN0RjN2YnBQU0JrVVhw?=
 =?utf-8?B?OTh0VkdVT082bVRUNlpnU1pCUGE5T0k5MkJGelpjTUhVZ0tlVWtDRzBsdEVR?=
 =?utf-8?B?WHRocTRLRzVUeEtQQllLSm5FVDBjYitGNjRZM0NzQVdwZ0hMWlFqSVF3OXh3?=
 =?utf-8?B?RDBNVlRRRkhFYUtTQnh4anEzbXNQcVNzMWRvOTI5TkZiNTREOHpJV09sakxz?=
 =?utf-8?B?Q2pSVTEwTVVRVGxCT0h0dkVRcVlmRFZadTVXNlZrd3pnbUxFTHllTTJibnhD?=
 =?utf-8?B?UnU0cTdyL1k5ZmNLbXgwMVBuTTVORGM2ZlVLRTByang2cVpjdVdOMk91Vk0y?=
 =?utf-8?B?bXlCVmdYQXVlZElFOW83RFFVdVdxdnRYc0FBaUVuMUtCZmdFTlpIbHRkYnRE?=
 =?utf-8?B?eGFXUUUzS2FxRVBVZW5ma0tvaUMzVDhzWUtKMFVEQ0xydVJNRHZ0VnpqK28z?=
 =?utf-8?B?Wm1PNEdPY3R6ZDZIVVl5a0oyN2dGbGIzMElJNlpuNndqUkdTZ01jOEcwV3Z4?=
 =?utf-8?B?aDFoQlRpS0Y5M3VLN0cyckc4d3lHeGhPazRFb1BDaVZDTTc1eVBOVUlUWUxQ?=
 =?utf-8?B?WXoveFVEYWxGVit3bjduejY2Mm5DSC9FR2I3MDFqZ0syVjRISXlkOXRCT1Z2?=
 =?utf-8?B?dVF4SlQrOFRUazNzS04reEtxamRJTDJONWxHRll4ekxLWEYxZDJ3dDUvWmJy?=
 =?utf-8?B?K3N2Y2x6MXd1Q1FWS2FpN2VHV2pLbUUrSU1rNFRTc3FrNmhaSXBXTHhkMi9Z?=
 =?utf-8?B?QzRjTDcrNVBXSEZER3E0eVE0c3A3Z1l6ZHdYMExjVm5iOUFVaG9HaUgxMWNL?=
 =?utf-8?B?dGsxalRhSVNDK3g1OGErcm9XYkRYN1BlN05MNDE1VHN6UGxJQ2hURVZqY01m?=
 =?utf-8?B?RmhRZElLbDlQck5OVGxOc1BnTnNQL2xYdW1NMitBcEg5QjJqMHpHNXBUL0dD?=
 =?utf-8?B?bzFQeDhCS01ERTVlK2pMYjN3UE9yWDFCZmVwL2ZPOGFCL3VsMGVaWXpUK3lo?=
 =?utf-8?B?RE9MU2RSRjVQTXdoZmFmb2ZuWE4yWmVGY21JbTh5WENSclpRWndtSlNFMlNk?=
 =?utf-8?B?SHZ2RHlrWlJRUWFubFl5NUtPeitRalk0b2VTVk4zQlhFVFk3dHNCSU0yMU1L?=
 =?utf-8?B?M2loN0hZL2ExZCsrYkpwcFY2RFhtZGZkeks2WlJKL3dJVlN0NzZMUTFuQWg2?=
 =?utf-8?Q?VWsr7Xn134SoVzVK4KeocjGTjjqJk9YagMW0iVP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd30640b-4bab-4cd9-fc2c-08d90fae106e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 10:10:52.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aeqZbVxGyZVDbyQNlFOHTsnJ5Cm1A99ox6KgAQMjxvAuzRh1aCgiHkG1hU3uBK1gb95941ahzWvAMWoK6XgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0
b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCj4gU2VudDogMDMg
TWF5IDIwMjEgMTE6MjAgQU0NCj4gVG86IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsg
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1l
ayA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gcXVhbnlhbmcud2FuZ0B3aW5kcml2ZXIuY29tOyBK
b2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT47IFRlamFzIFBhdGVsDQo+IDx0ZWphc3BAeGxu
eC54aWxpbnguY29tPjsgU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhakB4aWxpbnguY29tPg0K
PiBDYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsLWph
bml0b3JzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IHp5bnFt
cDogcGxsOiBSZW1vdmUgc29tZSBkZWFkIGNvZGUNCj4gDQo+IA0KPiBMZSAwMy8wNS8yMDIxIMOg
IDA2OjU2LCBSYWphbiBWYWphIGEgw6ljcml0wqA6DQo+ID4gSGksDQo+ID4NCj4gPiBUaGFua3Mg
Zm9yIHRoZSBwYXRjaC4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZy
Pg0KPiA+PiBTZW50OiAwMSBNYXkgMjAyMSAwNDo1NSBQTQ0KPiA+PiBUbzogbXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb207IHNib3lkQGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1law0KPiA+PiA8bWljaGFs
c0B4aWxpbnguY29tPjsgcXVhbnlhbmcud2FuZ0B3aW5kcml2ZXIuY29tOyBSYWphbiBWYWphDQo+
ID4+IDxSQUpBTlZAeGlsaW54LmNvbT47IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPjsg
VGVqYXMgUGF0ZWwNCj4gPj4gPHRlamFzcEB4bG54LnhpbGlueC5jb20+OyBTaHViaHJhanlvdGkg
RGF0dGEgPHNodWJocmFqQHhpbGlueC5jb20+DQo+ID4+IENjOiBsaW51eC1jbGtAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3Jn
OyBDaHJpc3RvcGhlIEpBSUxMRVQNCj4gPj4gPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZy
Pg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIGNsazogenlucW1wOiBwbGw6IFJlbW92ZSBzb21lIGRl
YWQgY29kZQ0KPiA+Pg0KPiA+PiAnY2xrX2h3X3NldF9yYXRlX3JhbmdlKCknIGRvZXMgbm90IHJl
dHVybiBhbnkgZXJyb3IgY29kZSBhbmQgJ3JldCcgaXMNCj4gPj4ga25vd24gdG8gYmUgMCBhdCB0
aGlzIHBvaW50LCBzbyB0aGlzIG1lc3NhZ2UgY2FuIG5ldmVyIGJlIGRpc3BsYXllZC4NCj4gPj4N
Cj4gPj4gUmVtb3ZlIGl0Lg0KPiA+Pg0KPiA+PiBGaXhlczogM2ZkZTBlMTZkMDE2ICgiZHJpdmVy
czogY2xrOiBBZGQgWnlucU1QIGNsb2NrIGRyaXZlciIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+DQo+ID4+IC0t
LQ0KPiA+PiBIT1dFVkVSLCB0aGUgbWVzc2FnZSBpcyBhYm91dCAnY2xrX3NldF9yYXRlX3Jhbmdl
KCknLCBub3QNCj4gPj4gJ2Nsa19od19zZXRfcmF0ZV9yYW5nZSgpJy4gU28gdGhlIG1lc3NhZ2Ug
aXMgbWF5YmUgY29ycmVjdCBhbmQgdGhlDQo+ID4+ICd4eHhfcmF0ZV9yYW5nZSgpJyBmdW5jdGlv
biBpbmNvcnJlY3QuDQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvY2xrL3p5bnFtcC9wbGwuYyB8
IDIgLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFtcC9wbGwuYyBiL2RyaXZlcnMvY2xrL3p5bnFt
cC9wbGwuYw0KPiA+PiBpbmRleCBhYmU2YWZiZjM0MDcuLmFmMTFlOTQwMDA1OCAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9jbGsvenlucW1wL3BsbC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvY2xr
L3p5bnFtcC9wbGwuYw0KPiA+PiBAQCAtMzMxLDggKzMzMSw2IEBAIHN0cnVjdCBjbGtfaHcgKnp5
bnFtcF9jbGtfcmVnaXN0ZXJfcGxsKGNvbnN0IGNoYXINCj4gKm5hbWUsDQo+ID4+IHUzMiBjbGtf
aWQsDQo+ID4+ICAgCX0NCj4gPj4NCj4gPj4gICAJY2xrX2h3X3NldF9yYXRlX3JhbmdlKGh3LCBQ
U19QTExfVkNPX01JTiwgUFNfUExMX1ZDT19NQVgpOw0KPiA+PiAtCWlmIChyZXQgPCAwKQ0KPiA+
PiAtCQlwcl9lcnIoIiVzOkVSUk9SIGNsa19zZXRfcmF0ZV9yYW5nZSBmYWlsZWQgJWRcbiIsIG5h
bWUsIHJldCk7DQo+ID4gW1JhamFuXSBJbnN0ZWFkIG9mIHJlbW92aW5nLCBjYW4gd2UgZ2V0IHJl
dHVybiB2YWx1ZSBvZiBjbGtfaHdfc2V0X3JhdGVfcmFuZ2UoKQ0KPiBhbmQNCj4gPiBwcmludCBp
biBjYXNlIG9mIGFuIGVycm9yLg0KPiANCj4gSGksDQo+IA0KPiBpZiBpdCB3YXMgcG9zc2libGUs
IGl0IGlzIHdoYXQgSSB3b3VsZCBoYXZlIHByb3Bvc2VkIGJlY2F1c2UgaXQgbG9va3MNCj4gJ2xv
Z2ljYWwnLg0KPiANCj4gSG93ZXZlciwgJ2Nsa19od19zZXRfcmF0ZV9yYW5nZSgpJyByZXR1cm5z
IHZvaWQuDQo+IEhlbmNlIG15IGNvbW1lbnQgYWJvdXQgJ2Nsa19od19zZXRfcmF0ZV9yYW5nZScg
YmVpbmcgdGhlIGNvcnJlY3QNCj4gZnVuY3Rpb24gdG8gY2FsbCBvciBub3QuIChpLmUuIGlzIHRo
ZSBjb21tZW50IHJpZ2h0IGFuZA0KPiAnY2xrX2h3X3NldF9yYXRlX3JhbmdlJyB3cm9uZz8pDQpb
UmFqYW5dIFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIFRoZW4sIGl0IGxvb2tzIGZpbmUu
DQoNCj4gDQo+IENKDQo+IA0KPiANCj4gDQo+ID4+ICAgCXJldHVybiBodzsNCj4gPj4gICB9DQo+
ID4+IC0tDQo+ID4+IDIuMzAuMg0K
