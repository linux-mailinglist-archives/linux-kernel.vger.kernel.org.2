Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB6330FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCHNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:44:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63211 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCHNoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615211051; x=1646747051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5OvB+pS9IX19wTZT6E0aa12P0uIBdEB6c+CqFsAHLSI=;
  b=aF1nokM/i2IB7S0md7klxNoNZ8ixU13N89x0k2v59RSAKqgaBts9G1P6
   0cREmEW15C27kJLTYMjStplNS72weMQMcviC9+1HHUj49TyGl9qfe8Ozg
   0B1icunIkl9vTo/FbZwXIcorHZIA2AgltVNDZ9AUvmNJPnsMUkTjugpen
   J3q6RLibN2G/cWqK35c19hPD612Jxgr3Tgmhg/UZXBa6TDv+3YS67jc0O
   2s09Imqovo8JbcHGSbkphKJ/MW7AxQCEfDvj/mVhsq6jQ3jvNqIAftCcu
   ML7gsLb3Wb+QcPydejhcDLfkxYgj/3+EnoERrUkit2KXu5lpGNLUQp4lG
   A==;
IronPort-SDR: Mqy8X39n8KeOIjFr2WKaELqnTTs3pxNyPXE6ilrLWPN6MNwL0CotJ+JMav6e+fi5/Yiuscb3UT
 CHkJN+TphV6Q4xXfuSiQvEjTB9IXI8fklnaxNc6l2z9xObjeTqDKEeTVgkVRx7j++KjQjiBnUZ
 9XtbUC0S5tAoxGrfnSm7XKm98o1fGld4BAeFUfBunYo7GlN0gcMdTFq5IW/JILLpMKg+t4Vw+j
 q+4WltuQl0tq8KH3TkhKv9zACcJZMnBP158GgvqnQAEXqn5vQK+jRbOADuYa8Qmo1MrSB4fCYw
 Mco=
X-IronPort-AV: E=Sophos;i="5.81,232,1610434800"; 
   d="scan'208";a="117969944"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2021 06:44:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 06:44:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 8 Mar 2021 06:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZQoFmUnb3chUhDJQc+n5GmREcxemm5a+ZQ4ABXdAsUVnF+liNDkF6ZBxakXYxpKoO1lGzwhdv3BamQW4dp5I6x/V+lMYe9m+3Zwog1GX2vtkRAuo03fQ4uLFjE2CY1cV1srqnvqiIlJ6MoTbgEiMU96nG9hy/cpUXqlkMASpD53WJ6KwysjtU9iXZq6BR2W95mGCwIOAtZWAvT1kvc2e/JiWM7nu4p+I23qvCelDYLqJABNRD+rTnsqcJUTyFNxawmSLZqQtvhoApP11fbwqFeri4+Lv1VuH8iYgiTj9kGhjm/mOCtJHOnMkw4jnh1arcsQa3wS09NHGPHZXQGnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OvB+pS9IX19wTZT6E0aa12P0uIBdEB6c+CqFsAHLSI=;
 b=DGoSGrbNhuCqwRztJYV3zdFc/yy63ylKuafrQI0fVViaca24ujAN/QNTYrdat0HeElnLaaRL2ZCcA5Ayw3VXKzr7XN5j/QsCAFppsKFQcCMyPMo+nTOPZEtBI6PD0bG+Z8g1Ev7wEkPDK7+Z0yNT+BlnvVBJt8XtIsYz5yOuWH0ah6X1QQGfmAbSBcRa2eWxTg0GI3Nb3iGMNvYRtzNpiUbwEhYhSPWjKpuc2F+piLA5uJlQtX1IpHGZ7t1An05t/033wjcPQMHVq4BDriTq21yAjsGms74qOOoxLmMVtyyFaCq0o0yDs/iCX7spwsseklN3HkNPKClT8xcEfXDb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OvB+pS9IX19wTZT6E0aa12P0uIBdEB6c+CqFsAHLSI=;
 b=aEA6iCOOvzZ0zyNRoO/BYJddeUgZa1a0EuRSvvicyAu4FKB+KunDFivgPM9oSYG4+zdDl5/GfNaotzIitZze8bBP12EXG/Ge3x3vjveZvjVCVJ8EHh2qBIBKKu7cVD07mkCviMLd83VZxCLrWoxKfNiQiDrr9XecA4MeyMo2JcA=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1241.namprd11.prod.outlook.com (2603:10b6:3:15::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Mon, 8 Mar 2021 13:44:09 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:44:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <maz@kernel.org>
CC:     <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/2] dt-bindings: mchp-eic: add bindings
Thread-Topic: [PATCH 1/2] dt-bindings: mchp-eic: add bindings
Thread-Index: AQHXFCEchn+zHXPinUqV6uSJUocprQ==
Date:   Mon, 8 Mar 2021 13:44:08 +0000
Message-ID: <063169cc-30a4-a122-c53d-47ffe9a056e7@microchip.com>
References: <20210302102846.619980-1-claudiu.beznea@microchip.com>
 <20210302102846.619980-2-claudiu.beznea@microchip.com>
 <87v9a9zt8k.wl-maz@kernel.org>
In-Reply-To: <87v9a9zt8k.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b0549f8-c3bf-4298-e1df-08d8e2383fd6
x-ms-traffictypediagnostic: DM5PR11MB1241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1241C4590D18915BD0BC3FCC87939@DM5PR11MB1241.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoO8K/jFq4Z4YP9xXKE8zlOwc82svdDpkYFaNqxm2OOPDrX7ecGk01tWBY9x1YKasBPwh31lQPPZ6Xj/Pua8PYJCNQSqbFldYSxKZThlH64Wci91HoVW4z9Mtecbuf4UnBtdiEkunRKSSkuMwfIixDHxdGrK0WuOiyfTEXCGkIrsW9z+jv2snFKSm0HewvDvIoOAiP/LGbeQzOlPR3gMgmejZEJ+C+tbB8WR2wpbo/QRsYc+saFylFvedfjZ+lnWg9e3yQXT2HxhGhkg8MygEMQIAZC1vvBVPn1O6qPv0pFnAklTaCrwKzVRpk/lG3VJyB1yf76M5UG4sC7kRxwW8ttfK01sHOHEWkvRdDhuNbW0uipd93PVThkX2GN34iXOLhTUDSHiY2JXxSZ2QN5HvRofgXs+y8XxIzGeMZjxymLmzQlNAMj/Ebzx8MoN/poGtQahh+8Q9fk10wUqI73cE2Fxpldgp5wP1+WzwXAqkko4Fw0u7ids9YsJaARfzPGrguE8puKjXCPzl14F7XOVNS0KbHSQYd2qhDZYHVOCnbL9MEdfhrvBuJS5mlGrdCcAdem4NDOK4DsCElqgMp35JauvjYFgiKSWIL5Z6UkUvs5mE5rALd03+W6axQewU93vJwGw8ndMBx8cTP1I+maRh7TkqDLTxX49q9UgoxmMzBwS6tKAnob45tNqiwILwY9t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(5660300002)(316002)(2906002)(478600001)(54906003)(31686004)(83380400001)(966005)(6916009)(6512007)(66446008)(64756008)(36756003)(66556008)(186003)(8676002)(76116006)(86362001)(107886003)(26005)(91956017)(53546011)(71200400001)(4326008)(6506007)(8936002)(66946007)(31696002)(6486002)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?czdseHJmTnZPaFVsT0FXcytyMmIraUwxVndLL0FKSld6NXZiWmZIMXVzU3Nu?=
 =?utf-8?B?OTEyaUhRS3l6V0I5cmZuSnc5YmMxaWsrVjNIcnVkeU1PRE80ODZBbkRNc0N1?=
 =?utf-8?B?L2VmV3pka044cGV5LzJnZDJzM3FQejZqM0ZXaDhab2xJTnpXQnE5cEdXbmY1?=
 =?utf-8?B?c2ljR2dtQWdPaVE4Q0hsMDRQdjNWOFRoNFN2eTZhd1QzaFlCOWphQ24yb09i?=
 =?utf-8?B?bGxXWndLNC81VzJSZ0VsMmt5RGlxMStZaGZ5UTBacExJY1lWNEJnR3hGNnpH?=
 =?utf-8?B?YUsxdFRJdGIwWmZnZ1JXdDJXYTlxemZBRFNaUVRQenVxL1U4VUxvckVERU8v?=
 =?utf-8?B?U2ZWQ1FOSzZKWjJHOW5ZaHU3TzlsVlhpT0dET0dzbGN1akVxRS9MZk1VOURn?=
 =?utf-8?B?bURMUkk2QWhESi9qcm5XalhncGdUWnNXckYyMHhMTHBBRDliZ1RvQWdFRHE5?=
 =?utf-8?B?WU9GVEZ6L2VGdk44Snh0YWVOYm04NzVwSXpsVnRsaE5CU1FtZENHV1FCTEdX?=
 =?utf-8?B?YXZ6TEdyQXZHSXh2Qmp4cStMVnF2c3MwVWdOdk1ta3hYTHFBVDUrRENQR1VD?=
 =?utf-8?B?MEl4VVI3amJ1a0J6YmJXbloybENFWVcrWTRhQ2Rwb2dnaFFkUUxNUlI1VnpX?=
 =?utf-8?B?Z2hpdXQxK2Q1czBwMTNFYWRDYmQyblBkUFBLKzZndTEyb25XcG9NdDk5ZTlx?=
 =?utf-8?B?M2U3SmxkbEZVNkI2QXdaVzNyNFNkTmVuaVh1OXdneDdKaUVlSzJJU2hUckVC?=
 =?utf-8?B?RTVLY2dIS2NVL3dja2k5djRDVnovVm4wM1BVT3QzVW5tMjNteGhOdGpxZjk4?=
 =?utf-8?B?citnT2IyNFZIWHgvMEdIbEVFWGtXSjN2bFVHclpCVjdqeTFrUHYyS3RBQytG?=
 =?utf-8?B?WVNPaHcvTktKZ0pQMnlxZXpSYXpNaWw4aGNyMTRpQlJmRys0S2JTcmVyM0Vj?=
 =?utf-8?B?YVFWZDBCdHFsQ1pJeEpYZXFOd3hPdVJMUHl5OUc3cXRvTU5pVE0vMGl5MDhL?=
 =?utf-8?B?Mmk0RkliUHhnd1YxN0U0OGtYQVhhR2VCQ3lweWpVU0VFOU01NjhldXdFN3A0?=
 =?utf-8?B?UEhCMTkxTVZMYTNMV3RLSDJFZ0dERXF4TTYvWTFFY2tOU0h2Wi94UUJTMnMy?=
 =?utf-8?B?QzJId1hsWUpKSjdRZUpkRnNiVjI2Z2RKeWJZWmdlVE41bGZZRTd3aEk0b1dV?=
 =?utf-8?B?cng5bHpLc3F1TlJMaU1iVGpWUmNueW5ZcTlGRlZGN01XaVhsd0I4SVRhRXRV?=
 =?utf-8?B?RE1COGdTMlgxV0c5ekEyeTBzcGJEclJUNWZvWHBqVGJCU3lwck13cmdlZTdx?=
 =?utf-8?B?WlRpU0lqeHNoam83dzl5eHdlTTgrbS8wbStxNHRUWmkzM1NVWjVsTERvYXFN?=
 =?utf-8?B?Qkw4Q3NwYkFwbEl4SWhhRGxqNHZVMm1MVzA3QVRubGxFMHZqbzEyOFpmQm1t?=
 =?utf-8?B?NnRkUW84VWFydVNzOTZYd1Vyc2tzTFhQSEpDS3pkdzhSTzBFVTlGZThocTND?=
 =?utf-8?B?Z0hkdGRCb05kWkQwVE9JS2xCT2k4d0NXZ3lPNEVoT3NuRXpHSXZzMDRDRUhV?=
 =?utf-8?B?UHNoM2pReHYrTnVnZmRrMFU4WEN2OVBtMDliaTFDdjhOc3pEdzg3bmdySktl?=
 =?utf-8?B?K3FIdCtRMWU5YXRJZE1hczVxRjdENmlnWVV5YThXK1hXVFVaK1pzemdlQ3ov?=
 =?utf-8?B?Tnd0WHBsakRzUTRJalYvUkZubmZLMllXTUNPZ2dBYmRhMjFROHRUcHhaSmE0?=
 =?utf-8?Q?G6jztsHeTmuFdDal7A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B397FA9AA8844A8E4CE10E61D94ED1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0549f8-c3bf-4298-e1df-08d8e2383fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:44:08.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbj9kzqnDjm5rVwrPO8R8GzI/CXTqbqUHbpTo0pLbAE2zEx5hIJynzV5NdTxxhE1i2mMthXMRBR+jm4IXHadXxDUJumkqlDWcVuRtW5vKKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDMuMjAyMSAxMzozMiwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgMDIgTWFyIDIwMjEgMTA6Mjg6NDUg
KzAwMDAsDQo+IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPiB3
cm90ZToNCj4+DQo+PiBBZGQgRFQgYmluZGluZ3MgZm9yIE1pY3JvY2hpcCBFeHRlcm5hbCBJbnRl
cnJ1cHQgQ29udHJvbGxlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9pbnRlcnJ1cHQt
Y29udHJvbGxlci9tY2hwLGVpYy55YW1sICAgICAgICB8IDc0ICsrKysrKysrKysrKysrKysrKysN
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvbWNocCxlaWMueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvbWNocCxlaWMueWFtbCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tY2hwLGVp
Yy55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi41
YTkyNzgxN2FhN2QNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tY2hwLGVpYy55YW1sDQo+PiBA
QCAtMCwwICsxLDc0IEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pbnRlcnJ1cHQtY29udHJvbGxlci9tY2hwLGVp
Yy55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMv
Y29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2NoaXAgRXh0ZXJuYWwgSW50ZXJydXB0
IENvbnRyb2xsZXINCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246
DQo+PiArICBUaGlzIGludGVycnVwdCBjb250cm9sbGVyIGlzIGZvdW5kIGluIE1pY3JvY2hpcCBT
b0NzIChTQU1BN0c1KSBhbmQgcHJvdmlkZXMNCj4+ICsgIHN1cHBvcnQgZm9yIGhhbmRsaW5nIHVw
IHRvIDIgZXh0ZXJuYWwgaW50ZXJydXB0IGxpbmVzLg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+
PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gbWljcm9jaGlwLHNh
bWE3ZzUtZWljDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+
PiArICBpbnRlcnJ1cHQtY29udHJvbGxlcjogdHJ1ZQ0KPj4gKw0KPj4gKyAgJyNpbnRlcnJ1cHQt
Y2VsbHMnOg0KPj4gKyAgICBjb25zdDogMw0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAg
ICBUaGUgZmlyc3QgY2VsbCBpcyB0aGUgaW5wdXQgSVJRIG51bWJlciAoYmV0d2VlbiAwIGFuZCAx
KSwgdGhlIHNlY29uZCBjZWxsDQo+PiArICAgICAgaXMgdGhlIHRyaWdnZXIgdHlwZSBhcyBkZWZp
bmVkIGluIGludGVycnVwdC50eHQgcHJlc2VudCBpbiB0aGlzIGRpcmVjdG9yeQ0KPj4gKyAgICAg
IGFuZCB0aGUgdGhpcmQgY2VsbCBpcyB0aGUgZ2xpdGNoIGZpbHRlciAoMSwgMiwgNCwgOCkgaW4g
Y2xvY2sgY3ljbGVzDQo+IA0KPiBUaGlzIGxhc3QgcGFyYW1ldGVyIGxvb2tzIGxpa2UgYSB2ZXJ5
IGJhZCBpZGVhLiBIb3cgZG8geW91IHBsYW4gZm9yDQo+IHRoYXQgdG8gYmUgdXNlZD8gV2hpY2gg
Y2xvY2sgY3ljbGVzPw0KDQpJIHdhcyBpbiBiYWxhbmNlIHdldGVyIEkgc2hvdWxkIGFkZCB0aGlz
IHBhcmFtZXRlciBoZXJlIG9yIG5vdC4gSSB3aWxsDQpyZW1vdmUgaXQuDQoNCj4gDQo+IEluIGFu
eSBjYXNlLCBJIGRvbid0IHRoaW5rIGl0IHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBpbnRlcnJ1cHQN
Cj4gZGVzY3JpcHRvciwgYnV0IHByb3ZpZGVkIGFzIGEgc3RhdGljIGNvbmZpZ3VyYXRpb24gYXQg
dGhlIGludGVycnVwdA0KPiBjb250cm9sbGVyIGxldmVsIGl0c2VsZi4NCg0KT0suDQoNCj4gDQo+
IFRoYW5rcywNCj4gDQo+ICAgICAgICAgTS4NCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9u
IGZyb20gdGhlIG5vcm0sIHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4NCj4gDQoNCg==
