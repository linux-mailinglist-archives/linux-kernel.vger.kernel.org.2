Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB43A9DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhFPOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:35:09 -0400
Received: from mail-eopbgr1400134.outbound.protection.outlook.com ([40.107.140.134]:19040
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232825AbhFPOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNFerKKD2nRp8dGVaUttQ+xO5VlXw41BKen7hwjIsmqgpk+P7PK6nxQEMtl6F8IxN/0c+6laGYo6I1iUpIAtezfBhr4Mseo/sn2Ewjic5L0Sjwcw/R8FpfADPyMEeRZOzqr/Wq78EMGIL/hnGDVmmpErWjM3T3jqS1c2g1CwJdJdMjISGleMMIX569Au9Z7+Sby+qLXLhFTxvqsXrMqtFfH5phSoaxyBUDePpFu2nZWf6mqxHkuyClqVklVz1xQC7SJzDKQPYOLMeYeHFmxq6vuEf0uw3nuN1c9PDo+QNORP/mts5MsakpjXzXntylASOfeqXOW9gUPMVLt5nczydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1wq29GX46OzOKL+dFCKnxsNRoLaJQW+uN4LOIIKS6M=;
 b=fweZS51gSZOutJZiCDJfXEVDvOtAr6ZbIIAITZmIq98g/e+q+1LePJBhG3pxOsmDbWAhbp6giYFnBfKm6Gcn8OIaCmnmFIHOFgj5RaQuI8V09ruwcpKgFTw+bTaqcNgZSpWcfTOs3tN2wOyG79ohxOY+qf9GqqFF2oIvCs/rxGTCSf7VEVXLpnYxLScW3TFy8UwgfBuv9l9eUSDynXVcNrybzDNK1/bqgZAcXCN0qMSd+DELlkmXlDeXyF94rILkXG5hB4tKUb8FIWFU16eaKa0rix+L3o6ScZzhJ6COAybTIpO8hSxLlH1RKZ3kKaa46tWtHEs0xh3/FNKRgzEVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1wq29GX46OzOKL+dFCKnxsNRoLaJQW+uN4LOIIKS6M=;
 b=d9IxdSYjDKH5vnfT8q9hIdhiW6BsJuHsM22r0K+QiJ/3kN3q6/NhQdU/uq+HF6CW0r+GgyhrbD1J4NTJzWp+fjQX6irDbC7uPf4hdxn/70V4gCY7gBRINrh+oJ6aUyALzkuxSoai9JQvoZWYLk5WR/yhX2NJI2MwdSFeJHdpjBs=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYAPR01MB5948.jpnprd01.prod.outlook.com (2603:1096:404:8055::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 14:32:58 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::788c:8a19:fea5:209d]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::788c:8a19:fea5:209d%9]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 14:32:57 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXV86EpPNANrzU4UCJO/Td0zuOkKsVKxiAgAAsQzCAAQNqgIAAaN1A
Date:   Wed, 16 Jun 2021 14:32:57 +0000
Message-ID: <TYYPR01MB6603047A864DB37F111BDAD9BA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
 <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YMmuz0EVjfEi6MJj@dell>
In-Reply-To: <YMmuz0EVjfEi6MJj@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43322a9c-b5b0-4d90-d158-08d930d3a2e7
x-ms-traffictypediagnostic: TYAPR01MB5948:
x-microsoft-antispam-prvs: <TYAPR01MB594886DEF1287C5F7D79C30CBA0F9@TYAPR01MB5948.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Q8n8dL63TJ0lzq3gTo1WFmuqfTMnrX73FMvjI/djN9OHoOvWrEqRUBRjd6vsv3TZ+GzORpUdCcXkN/ngS6KANEFKXuRsZb23XuY5kLyjHOHiFfNtmKk2JTWTm5Cqx8UoJFlhtLeCLT6mqE67Z6mR/kZv7JAI6pJzlgJa1xCav/CYeEGVox88KCZoc2i7zuPfnDTJyYIO23//kt6KxE67NyM1CPp6u9HIiYuJiNiLvMxyCLgvRoQ/5IhGuBEz8UoHkoDOdllp/Y1VSHBdFnfsPz8dd1Zun7+V2jUJIvaCHXk0UJ4EQH81S+19LOkwKaphoUQQuv9hQGVUvMDPlGyqOas4YxwSE9F9TFO79fCBxeneZ3sdKaK4+XANvqNdEYlqk11JbqWzwmNamb+Yq3H4kzMoM5VLQjMuxsv2A0LE0YlohanvJzF5vUbvd2nwFuRyiwPRoldRx4Lpyc8XSVQwA22SQuMjxpIeS7zBT4VyMKx8vq6KJQCuvo2cLiIwhsxPxZVABT4AltxhKO/mShbTFWqaBW8oWn6rZ878PzxSuNdZ/CyizxW/GjvNvKN8tPG7qLG/uen2wTcS3/ierENdBd5jkoCBdAWyfOyjwAdJDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(122000001)(478600001)(54906003)(64756008)(52536014)(4326008)(38100700002)(9686003)(316002)(26005)(83380400001)(2906002)(71200400001)(8936002)(6506007)(33656002)(76116006)(7696005)(5660300002)(66946007)(66446008)(66556008)(8676002)(186003)(6916009)(86362001)(66476007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hka0dDQ213QlBVSmV3b0l2aG9PTXppSU9QSEJ5bmV4R2gwRVFiY0s2alcv?=
 =?utf-8?B?cTY4cWpMN3VSWjFFaHFSZUwydWIvcVA4SzFSY1orLzY4bVRZanV3RzRCdlVP?=
 =?utf-8?B?RUM2bnUrT1ZjakI1aFZ2VkR6Tm15VWNHb2tFcnNoNHdLenRvMWhaMTVVazBq?=
 =?utf-8?B?NUpQc3FmdVU0YU1kS2w3ZGtQSDJ0UkpXM0UySUdqNkFvR2l4R2k5Y1Z0R3Z1?=
 =?utf-8?B?YTNvK25qVnZBQmlqakJZUGM1TWtwNkJMbE1xQTVwNjIzRDRac0M2ZUE3eHB2?=
 =?utf-8?B?OFhEbDE5Y2NsUXFHYzhYeGlwUHhHTVQwRWdlSjNZbGlnYzRHcjErc3NSbVdU?=
 =?utf-8?B?N3JLbHB4RkhyMkYyOE1ERENoS2NQM1g5R056cHpQR2JBOW1UVjQ3cXdRWFZC?=
 =?utf-8?B?T2pNakZNTXJSZ3ZidHluYTI4VDgvRmZkaThwY0c1V3hTb29FaVBaaWNRVHVi?=
 =?utf-8?B?RERPTkozU2Fid3ZCVnZ3VFlFN0lsMHkvd20wcnMwdXBlTjZKMWxuNWw0RjFE?=
 =?utf-8?B?d0IrL2tMYXRDL0gwcCtBY0RiY3NLSWFxbXdCOTdscWp4SS9TZXh5ZFp1ZUZw?=
 =?utf-8?B?eDZEeXJXM3NJQzBTK0VtV2tHa3hQQ3R6Mk0zQklLSUU0b0tKWlZVVE5ZSnA2?=
 =?utf-8?B?UmFTZlgrbDBRV0lrdGZrTk13Y2l5MnpjcktORy9IYW96VVNya3dWT1JoV3dy?=
 =?utf-8?B?OXdLVmw3dTJSZjdla0wydUs3cW9aVk96eVRvc3c5azhYa1g1ZjJlUktGeitN?=
 =?utf-8?B?ZFRrZjY1anVZSEhwWU0zc1NXb0NjUnN5U2JZeDBFUWxDT3U1cmZOWENNcmVx?=
 =?utf-8?B?Wlp6US9qRnZMZG5MU2ZUNmlUeGM0dkhnMU1abUR6Mm9DWTVBWWQwY3NCUVdZ?=
 =?utf-8?B?WS8vNTN4aTM0OEdKZmo2VTBFWXRnQ1IrSzJ6OFpMVVhaa3hoVXZiRTBUM2du?=
 =?utf-8?B?cmdCRUcwMjVCckhFVkx4dXF4eWtwOWp5bG5JUVVGcVdRVXZmeitnUG9La0RH?=
 =?utf-8?B?akR6a3plY0FzL2pPNkQ4Ri9mU3VuQUVBS3hQSTd6dm4xUWpsSGZuRkZSNFRL?=
 =?utf-8?B?cmJHTFlGd2puQmduWVVEWEZlekV4aWN4bDhYWk1PUkxRdXZ3NCs2K0NESTlP?=
 =?utf-8?B?Z2JaaEppc2tKSlV4aVYxZnlLYkdEZ2VibWJxdHlSejkxWUp1OWFpUWdOdlNK?=
 =?utf-8?B?Um03Sm9KZ3RBOWFtMnlya1dVaFNCakRhNzBIM3VNNFJpYWE4eUJsVUMrVFlZ?=
 =?utf-8?B?NHdOTEd0UWJiTWFvdk1YTDl3MTBjTncrWVdueU9sNDNPQ0dpN2tHUEd5Ukhy?=
 =?utf-8?B?akFaMTVmR2tFNWRSdkc1L0Nubys5R3BFSUFXNy8ySERhZ2loMm1ZQ2luRnB6?=
 =?utf-8?B?ZjQvQVdYR2FZdldqbW9LWkFGWjJNeHdrb0JCbTlVbVZTUmMwdzJVRzY1VmhB?=
 =?utf-8?B?dXQvN0UzNzUyN3FqWmNTTTd6K09kUElSQ21YSkxFUFB3ZzJiMitHRjc4SkJw?=
 =?utf-8?B?RVYyaVNpc0czWXpoUmxqaUs4bk5QVWNxQmwrSTQzWUVRSmJFbXZVSlRjMUpY?=
 =?utf-8?B?R2xCMklwUFErL2FzbmRXR1l6dXFvQnlhb0hXcnd2aXMvMEp6dTZwTmczbFlZ?=
 =?utf-8?B?V0o2bjhrYVB2YU5JbmlaR2E5cGFVb01mSGl0dGlya29wL2xkR01wbFhJYzBC?=
 =?utf-8?B?NUVhMEZqYlVNWGVVOFVobU1zOFhEMVd0eWtwN1U2UFIvdkdOOWtXNExrYmwx?=
 =?utf-8?Q?3qzn45labavhogxbXD0lQ2bvDfbS5traOpFQBl/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43322a9c-b5b0-4d90-d158-08d930d3a2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 14:32:57.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfV3ec9mErCb3e/E/9lNcrUYpcTwhQ0KUMcYHvgrauAHq9rNllKAceCP7d/mzSgTbzym86vd3CiCZc3bWfkeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgc3RydWN0IG1mZF9jZWxsIHJzbXVfY21fZGV2c1td
ID0gew0KPiA+ID4gPiArCVtSU01VX1BIQ10gPSB7DQo+ID4gPiA+ICsJCS5uYW1lID0gImlkdGNt
LXBoYyIsDQo+ID4gPg0KPiA+ID4gQ2FuJ3QgeW91IGhhdmUgYSBuaWNlciBuYW1lPw0KPiA+ID4N
Cj4gPiBIaSBMZWUNCj4gPg0KPiA+IEkgd29uZGVyIHdoaWNoIHBhcnQgb2YgdGhlIG5hbWUgdGhh
dCB5b3UgZG9uJ3QgbGlrZT8gUEhDIHN0YW5kcyBmcm9tIFBUUA0KPiBIYXJkd2FyZSBDbG9jay4N
Cj4gPiBJIHdhcyBmb2xsb3dpbmcgdGhlIG5hbWUgY29udmVudGlvbiBsaWtlIHRwczY1OTEyLXJl
Z3VsYXRvci4NCj4gPiBEbyB5b3UgYWNjZXB0ICI4YTM0MDAtcGhjIj8NCj4gDQo+IEkgdGhpbmsg
eW91J3JlIHRyeWluZyB0byBwdXQgdG9vIG11Y2ggaW5mb3JtYXRpb24gaW50byB0aGUgZGV2aWNl
IG5hbWUuDQo+IA0KPiBDdXJyZW50bHkgaXQnczoNCj4gDQo+ICAgaWR0IDxjb21wYW55IG5hbWU+
IGNtIDxwbGF0Zm9ybT4gLSBwaGMgPGV4YWN0IGRldmljZSB0eXBlPg0KPiANCj4gV2hlcmUgdXN1
YWxseSB3ZSBoYXZlLCB0YWtpbmcgeW91ciBleGFtcGxlOg0KPiANCj4gICB0cHM2NTkxMiA8Y2hp
cD4gLSByZWd1bGF0b3IgPHN1YnN5c3RlbT4NCj4gDQo+IFNvIGFzc3VtaW5nIHRoZSBQVFAgSFcg
Q2xvY2sgaXMganVzdCBhIGNsb2NrIGl0IHNob3VsZCBiZToNCj4gDQo+ICAgOGEzNDAwIDxjaGlw
PiAtIGNsb2NrIDxzdWJzeXN0ZW0+DQo+IA0KPiBJdCdzIGRpZmZpY3VsdCB0byBzYXkgd2l0aG91
dCBzZWVpbmcgdGhlIGFzc29jaWF0ZWQgY2hpbGQgZGV2aWNlKHMpLg0KPiBXaGVuIGRvIHlvdSBw
cm9wb3NlIHRvIHVwc3RyZWFtIHRob3NlPyAgTWF5YmUgdGhleSBzaG91bGQgYmUgcGFydCBvZg0K
PiB0aGlzIGluaXRpYWwgc2V0LiAgSSB0aGluayB0aGF0IHdvdWxkIGhlbHAgYSBsb3QuDQo+IA0K
DQpIaSBMZWUNCg0KVGhlIFBIQyBkcml2ZXIgYWxyZWFkeSBleGlzdGVkIGluIHRoZSBjdXJyZW50
IHRyZWUgYXMgZHJpdmVycy9wdHAvcHRwX2Nsb2NrbWF0cml4LmMgYW5kDQpwdHBfaWR0ODJwMzMu
Yw0KDQpSaWdodCBub3csIHRoZXkgYWN0IGFzIGkyYyBkcml2ZXIuIEkgcGxhbiB0byBjaGFuZ2Ug
dGhlbSBhcyBhIG5vcm1hbCBwbGF0Zm9ybSBkZXZpY2UgZHJpdmVyDQphZnRlciB0aGlzIE1GRCBj
aGFuZ2Uga2lja2VkIGluDQoNClRoYXQgaXMgd2h5IEkgd291bGQgcHJlZmVyIHRoZSBuYW1lICJw
aGMiIGluc3RlYWQgb2YgImNsb2NrIiBzaW5jZSB0aGUgZHJpdmVyIGlzIG5vdCBhIG5vcm1hbCBj
bGsgZHJpdmVyDQp1bmRlciBkcml2ZXJzL2NsayBidXQgYSBwdHAgY2xvY2sgZHJpdmVyLiBBbmQg
ZG93biB0aGUgcm9hZCwgd2Ugd2lsbCBoYXZlIG91ciByZWFsIGNsb2NrIGRyaXZlciBhbmQgSSB3
YW5uYQ0KcmVzZXJ2ZSB0aGUgbmFtZSAiY2xvY2siIGZvciB0aGUgcmVhbCBjbG9jayBkcml2ZXIu
DQoNClRoYW5rcw0KDQpNaW4NCg==
