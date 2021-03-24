Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151CC347850
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhCXMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:21:32 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:61920
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231394AbhCXMVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egdbVgNRSYIcfb3Orv2eGnBPXn1QmqB+y+Yj5stjo4q+Wp2GpbZDbfGcJF3FYdvAlBWP5lnHLnemgsUexvjleMUj2u0ROXvK2eVfySgdkRD+FUCdDsJTsybz57S7GIAxjtOK/ZJTp0VXNnH8pUbpPCwvoWhwUN09yiNbVsDjBjPdJ13OfqlJz4BOzfbDgtu9eV5VZIpKFUqQQQHwoaxm3z70b9bNU9NpuAI/Rplu7tnUyXZgrhAyNJ8x9f4fOkVTyjWZpAvmeioFmQShsX+l4fYgkXldsbk70VLjkHht3R0cRN6rvY/CptPfHZV9BCyrs+fDUX+QXp3qcJoT1QS5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO/VfDdfsM1GcD/dqkJEwcH+cnYruY1AK3ik9x7W4xw=;
 b=EXANA6m5ZgySyFvfceZH6OTKjVBU642uXE57mgP70fpS1RrXDXOF8Ma6HI4nOfNrhnqxtLtwW41MfZI7MzqrEM73/vT4ZiFTJTBI/iP10cservz2g3wmeiINiBn7P482GW+DFV9NALZ/vQigOalyaNYIQrajU+sTJ4OQQP+SzA1ry5YXjWz/gxSajoUfF9ZYHjS2qg9xsrTLKQkg3x2w2S6eBCfvIvs1naAVWCPbLBBWJ2v0Vm1V6Khzq17y4DyKwLqN5X0Hmc4nNdSCgrf57+wVe4D0SG1V+NX/UcDNQJ0qRAhjoi95qj46GxV7CcX0sutWmdS+Oxw5LUfTfKEUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO/VfDdfsM1GcD/dqkJEwcH+cnYruY1AK3ik9x7W4xw=;
 b=HB6FbuwsOv0RvP1EyWQlgykVTRD+OeD/THQwgmXIG1omiaY4e5XhTR2ESmsA0exMigUvho09zfXaXiEHrgsj7BqT/qs5T6p7ybdcS3qV+T1rp4reOCVa1FNnV+8ImZCsgXzihOExBwy76WjjZuzmUH35/wxbByOK9qQ58saJlF8=
Received: from DM6PR02MB5898.namprd02.prod.outlook.com (2603:10b6:5:159::13)
 by DM6PR02MB5467.namprd02.prod.outlook.com (2603:10b6:5:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 12:21:12 +0000
Received: from DM6PR02MB5898.namprd02.prod.outlook.com
 ([fe80::d553:d275:2c70:c53e]) by DM6PR02MB5898.namprd02.prod.outlook.com
 ([fe80::d553:d275:2c70:c53e%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:21:12 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v3] phy: zynqmp: Handle the clock enable/disable properly
Thread-Topic: [PATCH v3] phy: zynqmp: Handle the clock enable/disable properly
Thread-Index: AQHXH++dxa0Xf2fc6UugR1sJI+0oOaqSdc2AgACaDmA=
Date:   Wed, 24 Mar 2021 12:21:12 +0000
Message-ID: <DM6PR02MB589819D4999945A32391A892C1639@DM6PR02MB5898.namprd02.prod.outlook.com>
References: <1616509187-8209-1-git-send-email-manish.narani@xilinx.com>
 <YFqs99u6pLzDxZy2@pendragon.ideasonboard.com>
In-Reply-To: <YFqs99u6pLzDxZy2@pendragon.ideasonboard.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8471cca1-975f-499e-8f7e-08d8eebf5001
x-ms-traffictypediagnostic: DM6PR02MB5467:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB546786D8B9BCEF8E83E7BA33C1639@DM6PR02MB5467.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pd77rIhWHKDBAIemw7hTglrkqvM9pOdH7v+ErC1ohPrQOY+fn48RuJltSK+i/FdEOdtApfUchVB2ZW+9K05GZnlKpqbd81xded0q2uNzZPOk3xNbVtbn7QW4/7/H3yXTlETPCA/13h3CaWpeaHZKnJEfQmN/LPuEtyq+Op3Ur0+5crcv14V5V5GK10FeqtQaIjgZ9Plh6g/Bh3l2x+QlPNaoj1w5LkvMkry8Ief9NgIu+16u0iutnqsr/qflvuWy7U+HjimvAmSQMVqlE/kK03p1VnZV3O8uERDKvE+5pvmqZ9zWpNNMq8++igTmaw3V38Lk0rQP5uKgi+yTasL3ydIXzM4UM+jms8780LO/+GN7s1Vvz1e1kAw947FWdjoFJb0LOY2I/HmO8lAP57OoqHSdXf+IEL0PeCVc0t08k+nvDbN2OR+Rx7cu0sAriL1tzzawM1AgqELjOn15fH5ji5m/ttkyfgKSxT6H/2slk4J+CNZhMaHbZiEIoIlBVr8AUdcviNFYB49GvnwwYHwS4SNdrAdO2h+GjpV7sVtz36Y5EyH2d89TLbo5RuKjpTEhcSw+sLJ1Sweof2tTCjWVyrgjY5BA6H/ZmhSyBTfGs7+GB6/+1pXRzpUxS+ODTOZXrTtlIs8XleRa0HeIH5dTlf7CPbaNWBg47EJvYTHVg0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5898.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(64756008)(9686003)(83380400001)(44832011)(186003)(76116006)(6506007)(7696005)(66556008)(107886003)(54906003)(66446008)(5660300002)(52536014)(4326008)(53546011)(66946007)(66476007)(26005)(8676002)(6916009)(38100700001)(2906002)(33656002)(478600001)(71200400001)(55016002)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzhBQzFHMm83eThuTk96ZHlmLzIyOW56dVRoMTZYR0pFZysxZ3ljUnFzMHJV?=
 =?utf-8?B?WWRZbjIzbndRMGNwdmVpVmpSUTExVVMxWFlDTjA3MjM1TUc3UDFwOW5CaWhO?=
 =?utf-8?B?Um5pOVM5cEtydGxmdm9XK2Jxcnd3cFJ2bnF2UmFFRmNvTmtKSXpJRFlsODd3?=
 =?utf-8?B?OExTeit1c0FZVDc5NCt2cVpLWmdDVGVrSGRRdWZablBzWlNXTCs2ME1NbnlC?=
 =?utf-8?B?Q0pqQ2ZOMlE3Rmx4UXJQOUJXazVPeU9IVVIvSUY3bDlQaTFyUk9Ba3kwTktR?=
 =?utf-8?B?MFM3K0ZSeWY3VkhyRmhsbis5MTZzMVBCbUg4UXlGRG82U0JvdjB6enZDa1JP?=
 =?utf-8?B?QUdmZHNVL2FYRVZ0NVA1OXdWek9YYnZVQytOWXVPSEM1SldvQXRCcDhaMk1Q?=
 =?utf-8?B?K0MyWm0zTG5nUFJ4SkdEY1JKa0ZCeE9Ma1ArcS85NStoRGZiMHRMWllMcGhH?=
 =?utf-8?B?cWpxSVlHeWt4aHNnSlRKbWJiaUgzbm8rcitURDBQMzFySkhWYzVRWkY3TkRo?=
 =?utf-8?B?TnlmQzEzZC9xR3hPYVJYVlIvV0wvK1FOcGFYY3ZnallmQ3VWb1BkNkJYWnpK?=
 =?utf-8?B?RStsYTh3cWlHZ3NCckh2dTFRVis1Y0dnclpUZUhKYmM4allyd1BsOXFRNDBm?=
 =?utf-8?B?R1paZEhnOUUxV05YNnloTFh1YVBLU3RrVXA5SzUxMURSZXArSEhLL2g2akNJ?=
 =?utf-8?B?QWthZDQ1RHhjTXNCZnp2cnRnM3JuVGwxWDVmelZ4TGg5Rnl5NEVhVndpcWFq?=
 =?utf-8?B?RWg5Zm0rU0FxMDJUOWIvNlVRYzBsSkRSZzltVTdKWVBKMGxIZTB5cWJaWGFN?=
 =?utf-8?B?MUJPaEE0cmVUTXdKYXN4Q2NtZWlqYjlzbU1UV2ZKZzZYQkNKakE0ZGNNeFdt?=
 =?utf-8?B?aXZvUm9VZU5qMTJtQktUdTY0bStteFdBbnhUVm1sY0htczFId0FIUjJMdjZh?=
 =?utf-8?B?U1dJK2gzY25WcnhJVkZKbkxaTVhZcG8xQTc2T1ZhNm9CaXJoNEFWYlYrSmUx?=
 =?utf-8?B?THRNOHE2RGQ1MENSNmk5WjFIbUViWDZDVTdxL2tXc0RKWjYxTEMyUXBUd0Nx?=
 =?utf-8?B?V3NpNjN6cldPUEo4RytWQ1NoRDRFbmFJQnp6K2FPOEw2a25OTE5qSHVpYTJD?=
 =?utf-8?B?aFJtUS9zR3I4RkMrMXFGRW4yTUVRZE90WTIwTTBJZHJrYURaRlRNaHBjWHpk?=
 =?utf-8?B?VHNGVkU2MU93WmNuTnQ0SndJbmVWSm52THhUTVExTWZEazVsejhrNmZpc1J0?=
 =?utf-8?B?K2lITjlVTTVhRW9hVFJmdC9DUnlmVEtYWUhFeWowS0pBV3Z3Y3YvV3Ntc2JK?=
 =?utf-8?B?REtYZXRSU254ZThoL09QTkQzcHlVS3pJd2gwelE0aWdOaGlqWjRPNEMzdmRV?=
 =?utf-8?B?QStwRXdYTXpGTVBNTmlJa0VMcC9Fd3dxWGxadjhpcXZ1MGhWQ1lSdVd4NHNw?=
 =?utf-8?B?WlB3dXJaaGhiSzloWDVVcUJEdHV0Y3RXVEJVNDFsVmg4UWFtbzdjNmVmeWZh?=
 =?utf-8?B?Q1R0b1E3M0dob2FUcjlrcHp2dzg0aXBNbTF2SFk4c2dKOXd3a0s0MExMWEJk?=
 =?utf-8?B?SVVuT2ZkVFRlbm51MWhVVnFFUzdQemsvazJXUDZDci90UFp6K0t0Zy9TNjFH?=
 =?utf-8?B?aytUY1pTM1ZEdmxPNkRYZkJReTZZOGgyeFptRm9aU1JrdGVKUGczb2RyUGFY?=
 =?utf-8?B?RlFpbjltOVF4Sjc4M2RLVzdSQkIvdEhCVHJ6RWUva2JwaW9GbUZpKzlXMWE5?=
 =?utf-8?Q?szYWUJoUAFGrtLvsjfc6aT1aPMWoPs/g+H/qtjo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5898.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8471cca1-975f-499e-8f7e-08d8eebf5001
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 12:21:12.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pf1FaaUk0uAGO6dIEoMto25FTmScNPk/xgV7I82XK4YqC15tEI8qOfXbbeLwC6CwUJDYWNecsmcwXDc51LywFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmsgeW91IHNvIG11Y2ggZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVu
dC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI0
LCAyMDIxIDg6MzggQU0NCj4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4N
Cj4gQ2M6IGtpc2hvbkB0aS5jb207IHZrb3VsQGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1layA8bWlj
aGFsc0B4aWxpbnguY29tPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBnaXQNCj4gPGdpdEB4aWxpbnguY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBwaHk6IHp5bnFtcDogSGFuZGxlIHRoZSBjbG9jayBl
bmFibGUvZGlzYWJsZQ0KPiBwcm9wZXJseQ0KPiANCj4gSGkgTWFuaXNoLA0KPiANCj4gVGhhbmsg
eW91IGZvciB0aGUgcGF0Y2guDQo+IA0KPiBPbiBUdWUsIE1hciAyMywgMjAyMSBhdCAwNzo0OTo0
N1BNICswNTMwLCBNYW5pc2ggTmFyYW5pIHdyb3RlOg0KPiA+IFRoZSBjdXJyZW50IGRyaXZlciBp
cyBub3QgaGFuZGxpbmcgdGhlIGNsb2NrIGVuYWJsZS9kaXNhYmxlIG9wZXJhdGlvbnMNCj4gPiBw
cm9wZXJseS4gVGhlIGNsb2NrcyBuZWVkIHRvIGJlIGhhbmRsZWQgY29ycmVjdGx5IGJ5IGVuYWJs
aW5nIG9yDQo+ID4gZGlzYWJsaW5nIGF0IGFwcHJvcHJpYXRlIHBsYWNlcy4gVGhpcyBwYXRjaCBh
ZGRzIGNvZGUgdG8gaGFuZGxlIHRoZQ0KPiA+IHNhbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNYW5pc2ggTmFyYW5pIDxtYW5pc2gubmFyYW5pQHhpbGlueC5jb20+DQo+IA0KPiBUaGlzIGxv
b2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1
cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiANCj4gSG93ZXZlciwgaXQgd291bGQg
YmUgcmVhbGx5IG5pY2UgdG8gbWFrZSBjbG9jayBoYW5kbGluZyBkeW5hbWljLCB0byBvbmx5DQo+
IGVuYWJsZSBjbG9ja3MgdGhhdCBhcmUgbmVlZGVkIGJ5IGFjdGl2ZSBQSFlzLiBLZWVwaW5nIHRo
ZW0gZW5hYmxlZCBhdA0KPiBhbGwgdGltZXMgd2lsbCB3YXN0ZSBwb3dlci4gSXQgY2FuIGJlIGRv
bmUgb24gdG9wIG9mIHRoaXMgcGF0Y2guIElzIGl0DQo+IHNvbWV0aGluZyB5b3UgY291bGQgd29y
ayBvbiA/DQoNClN1cmUuIEknbGwgcGxhbiB0byB3b3JrIG9uIHRoYXQuDQoNCkkgaGF2ZSBzZW50
IHY0IGZvciB0aGlzIHdpdGggTWljaGFsJ3MgaW5wdXQuDQoNClRoYW5rcywNCk1hbmlzaA0KDQoN
Cg==
