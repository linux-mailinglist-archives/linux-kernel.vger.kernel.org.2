Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A13C6760
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 02:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhGMATY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 20:19:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:14456 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhGMATW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 20:19:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="197258143"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="197258143"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 17:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="649086148"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2021 17:16:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 12 Jul 2021 17:16:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 12 Jul 2021 17:16:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 12 Jul 2021 17:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bytPBw4P7UQAmLj3v6dmA2B7i3L8ZJHDuhuZhnzR6jBwl60sq2WlNCi76FjHuJP+edw+TyMs6unapwin8fIprF0jRzhQ2gdhe0xUCYeeuUiMaoYZoh+K6NOaYjDg0iOL9joJUum97dFUDagne6m/yVqoo9vqVNwXkanUjHcK2RsuUjH434O8VAkPRw6Dum96/3aTYlIeK1Ikbbs7PGb8olaIu+4btZqaGBQPmNBVwZCUKub1HhDdSHtBov8tf1vk2uwUWisrfHcNTdvKRrBPzzEGCic/Q69cbFXbzY2D5/q0vpd9tWqyvQptka17GCVZgiPLbMmRNKrxZs38uneGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvGUzdml2+dWV8nq2BTO5drF78+SjThtdrCbCSuSneg=;
 b=LqM2E+HNFry5KXAGg1lCiqV6QbW7UCN8q6bKqI+vvw8TOq+LQ0SRB8++c5uLZ3H0KvcF54BfVH18+a65s4gF2wvYfx6MPvjhdQm1SXKfOwmvl2qlUq6iqqU9hTcT66lN+wHsjwocUQVjOazFRICA8oGUYWDujYYL5MuYfjSoXQv9uijODOjnjyYRSqNE+FTOBQ77iQjZO2+5rt+M3rGoJXDTmG/IfuIAr1Yp8TmGpsI5Sp/dmCAosKLVGIOZj1r0Be0+0m77GruAGEukbvAN9lDqpxBRuyyJifb+K6RA4YcUtAjk5d8MRkfU+VkKRqgTo2HDEMwUbBe9Z7OF9O95wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvGUzdml2+dWV8nq2BTO5drF78+SjThtdrCbCSuSneg=;
 b=UO4uKJWh5lexU2a87N1q7AS4XY77zY54JuM1s9W3NTmj3A3y3tE9xVARp/FXqYB5k1ui7wbx5KrjActC1aLnfFEjhEeUGd3zwcPRb1dT8h3Nuv5VhGskTmMjneISJBI/bsiWc+p/WoklC7EdxpySm9oNHLV79Ic++hBTiwyX0aw=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM5PR1101MB2124.namprd11.prod.outlook.com (2603:10b6:4:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 00:16:25 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d461:9c2:3f30:92d2]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d461:9c2:3f30:92d2%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 00:16:25 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Evan Green <evgreen@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Fine, Gil" <gil.fine@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prashant Malani <pmalani@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: thunderbolt: Warning and 20 second delay in S4
Thread-Topic: thunderbolt: Warning and 20 second delay in S4
Thread-Index: AQHXdQnwQF82AvtSx0ad+NNohaNbaas7wTOAgARE8QCAAAaEwA==
Date:   Tue, 13 Jul 2021 00:16:25 +0000
Message-ID: <DM6PR11MB39639EB194DF47AE6D7F77ECF6149@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <CAE=gft50j2D_UmNNVOj-h6Hyi5ctMztAVDBP442SPinmCwcnpw@mail.gmail.com>
 <YOk/dzmF9sRg4uBn@kroah.com>
 <CAE=gft6pax+OB-TDDUEUabmc8p3x-p7CC-9ihNbjRKq0MgdisA@mail.gmail.com>
In-Reply-To: <CAE=gft6pax+OB-TDDUEUabmc8p3x-p7CC-9ihNbjRKq0MgdisA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8eb2a71-edea-4756-e0b8-08d9459373d4
x-ms-traffictypediagnostic: DM5PR1101MB2124:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21242174DF30B85F8ECBFFB4F6149@DM5PR1101MB2124.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64rsnSb+f6bulE+udl4oh+tipD4HjJIxgrDmNiHGoV/Y3DPYE76gL9OWBnOxyTIpG3admlpYgyNv4Xut0Clbx3geqlPWBnLjdvabvDPk1HxboDJP4RpKifxNUf4337gs3ftOCFQq3aKqwjnqiWlkWUqpRvvtbhQN1bQpLp+NeRbpYiyzEZ++zfeAqGKSI0I4uz2RfId3Tb6qN31yG4km2gXuLCJ3+dusXfrg/ZYm1lgiGwYKMAMW36glGf4hgSiW6oFykIwZG48xAcqfUVctBrdkoQKiSn7Qo29kmYpDzDQG2UOY8Jd5d/sozJ2DatidyAc2q+B0+NGZH3VYhmtTbLHILgdLlyk68NczF6DsOdBSBFeAkoRZZMd4gmKG0H/iWsufwPAtATJb1qEnZuSKqs+I+CTJfDx6BwKlT/T6Uqj1iZMi9dN+yAI6fSy/0vCR5PJmzGf4Z5eDe7WSUdtceXPvcaMr0C83eAit5V3VjJ9P6dkdBCknDrIPTRsb+GVwXgiF7I7p5+HH4Bp8D2G1Tas/dXOrxFRnIbiNR92ONTgRm5Iz8DzGU8D4tbs6vcuk1hHA4t8nA9lvMH/uGp46a8qKUexeszH4YXDwxgDWTN/7/je8elokIlal+nYY9crrRL4DRlxnP2uJAKfB9xGbyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(71200400001)(2906002)(186003)(76116006)(38100700002)(8676002)(66476007)(66556008)(122000001)(66946007)(33656002)(66446008)(64756008)(83380400001)(54906003)(86362001)(26005)(8936002)(5660300002)(110136005)(478600001)(7696005)(55016002)(52536014)(6506007)(9686003)(53546011)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStMZDVmN2todXNZb09ZcUF1VVJIY05Dd253MytabEdmSG14U0MwOEsrTDBh?=
 =?utf-8?B?UDlGZ3NHWHFaSkxwVSsvcHpFdzBpUVgyNVM1Q3ZUMzdIQ2tyNWpjUWIzNlhu?=
 =?utf-8?B?NXZxa1M0emtmMEZ0TUpEVk1veDZ6enNSalgxVTNPWmxBUGFjeGppMlhCYVpx?=
 =?utf-8?B?anQrcW54TG9yWFA3SDNzQXNUSjIxdkFWbFBwVjdndDNCdk9PdUhET1plWitk?=
 =?utf-8?B?U0xYclJYQUVRSFdSdk81NDl4L0E1aFBmV3VxRmJ2aU4rR0hIVFZMK0lQM001?=
 =?utf-8?B?a3BMeTdoZWlpUnhKK2F6YllGVFNaUS84bisrN0xnY3l4MlhGZlllT1MvNlIy?=
 =?utf-8?B?ekJ5RjdpSGRFc1UvYkw3amZvenN0TTkxSTBIQUxtWFZoM2lsTkFqYktBMkF6?=
 =?utf-8?B?dWtDWm9YVEE5WGRZRVNJQVRHRTE2Qy9xWFo1WS80QTdRQlpsQ0hxYkJhY3o2?=
 =?utf-8?B?NXVhcTFta0lRTDVOMTNneTNicFlyaEhOMXRtUlVaTUFYcUUrTXVVVDNOUW9L?=
 =?utf-8?B?ZURwR3FiRGtGcUZRemlmdzRabXp3aWk1YlJDQnBSVnVud3AzaEdHcXJ6TEcv?=
 =?utf-8?B?VlZ2ODE3citxak51UDU3cnZBQzB0WFlrM29QYmZvMWpvRzRBTmhZNnZXTWQy?=
 =?utf-8?B?ZE41MzlsL0ljUWM5MnFsN1EvZDhzVWd3VnN4Z2RUZzhrNC92ZGZqNnBKUk5V?=
 =?utf-8?B?NHE3SGp6TjFXNU1FdU1NTVAwU0YzR09SNVl2MHhuem5hWDVwUk5sTDI5czBu?=
 =?utf-8?B?YmpyWk5scFNGY2x0em52SElJTjdmaFB0LzlCVWs0TXF1VTJzNmlJL2Y5LzQ2?=
 =?utf-8?B?R1FCUnhWUDNLYndScE5TK0hNb2hvb1FGNG5VcklWM2F5YW95QUlZam5MT09Q?=
 =?utf-8?B?T203MVptWXl4S05VUi92ODVxZkg4Rk9vbkgvM0xvS1hkQWlScjkxd1crRlhm?=
 =?utf-8?B?QmdOa1JQUlRxZGN6ZG1td3dYKzIyRWR2RkZSSTZndG1pcGt6d0NEaHJxNXFn?=
 =?utf-8?B?RTlGYmNuKzlYL2ZYTHBmWndxOHhRRWVCK0l3cnRvdTNUS1JCY1ZxM1dwUWRO?=
 =?utf-8?B?cGRDcFNNYUxlOGg1YkNtRkh4RmVUZ08rNGN3V2VOMjU3QVN4VWxQUzlCTnJ4?=
 =?utf-8?B?N2hBbnpJREhjRlRValM1aW00aUsyRHlQUCtzY2VRSlZsU3Z0cVF0K2NoSitL?=
 =?utf-8?B?elIvOHV2cEZ3UFhlTTc2cjZheFRtb0pJODBpTy9XNTVyWnZzMzVkUm9XejY5?=
 =?utf-8?B?OGlpNTRyb1gvMHlxWlBpRHJvRGhXRC9CQUlRdXlBNERiK0V6elpVb1hzRTds?=
 =?utf-8?B?NlhLcEozNWx2eEJxUEJOejloTktNaEh5bFBybjFtVk55bFBiMkVsMzA2ZWFr?=
 =?utf-8?B?UGZDVFNZb0ltaXBlN3krS0lyN2tGd3dkOS9MOEpjbWtTRzhOcVViL2diYUVB?=
 =?utf-8?B?TW5JaXE3b1FFRW9CRzZQMFl5RXBIMitnVWUvUWR5TW1jR2d5alZ5M1lJa1RW?=
 =?utf-8?B?b1VLSm1XY08zSGpmdkQ4dFlLY1Fya3ByM3hIVkNHaGNXVmNHcmJnb25Md24z?=
 =?utf-8?B?RFg1QlJQOTRaR3RJbVNxMnNIb3dGSWxlaW9wT3hvQzg1UTJsaXRKcGFPc3Iw?=
 =?utf-8?B?Y3ZLMFpZSEVtbW1CWk4zdWppNUdtU0ZkNTI1VG9LNnRHMHA5M2tFR01IM3pu?=
 =?utf-8?B?c3BTUkxMSVJhV1NTZGNPMXpQSmN0UDhoQnZ3YnlhdWVJbmFyT0cxWXplUXRR?=
 =?utf-8?Q?54ee0OXxu+kMUJRIeIB5NWhnds449rVb4RXJW2k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eb2a71-edea-4756-e0b8-08d9459373d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 00:16:25.4186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6jpBGZ0ibJzZSKov9KBDAk6TuRXY2D8WrXAvXVhk5TfJoQ4cKGKTLeQWwatkv6B7ZVCB9DVyXEVGG2F0Iy5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2124
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXZhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFdmFuIEdy
ZWVuIDxldmdyZWVuQGNocm9taXVtLm9yZz4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDEyLCAyMDIx
IDQ6NDYgUE0NCj4gVG86IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBD
YzogTWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPjsgRmlu
ZSwgR2lsDQo+IDxnaWwuZmluZUBpbnRlbC5jb20+OyBNYW5pLCBSYWptb2hhbiA8cmFqbW9oYW4u
bWFuaUBpbnRlbC5jb20+OyBsaW51eC0NCj4gdXNiQHZnZXIua2VybmVsLm9yZzsgUHJhc2hhbnQg
TWFsYW5pIDxwbWFsYW5pQGdvb2dsZS5jb20+OyBMS01MIDxsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IHRodW5kZXJib2x0OiBXYXJuaW5nIGFuZCAyMCBz
ZWNvbmQgZGVsYXkgaW4gUzQNCj4gDQo+IE9uIEZyaSwgSnVsIDksIDIwMjEgYXQgMTE6MzQgUE0g
R3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24g
RnJpLCBKdWwgMDksIDIwMjEgYXQgMDI6MzE6MzVQTSAtMDcwMCwgRXZhbiBHcmVlbiB3cm90ZToN
Cj4gPiA+IEhpIE1pa2EgZXQgYWwsDQo+ID4gPg0KPiA+ID4gSSdtIGV4cGVyaW1lbnRpbmcgd2l0
aCBzdXNwZW5kaW5nIHRvIGRpc2sgKGhpYmVybmF0ZSkgb24gYSBUaWdlcmxha2UNCj4gPiA+IENo
cm9tZWJvb2sgcnVubmluZyB0aGUgY2hyb21lb3MtNS40IGtlcm5lbC4gSSBkb24ndCBoYXZlIGFu
eSBVU0I0DQo+ID4gPiBwZXJpcGhlcmFscyBwbHVnZ2VkIGluLiBJJ20gZ2V0dGluZyB0aGlzIHdh
cm5pbmcsIGFsb25nIHdpdGggYSAyMA0KPiA+ID4gc2Vjb25kIHN0YWxsLCBib3RoIHdoZW4gZ29p
bmcgZG93biBmb3IgaGliZXJuYXRlIGFuZCBjb21pbmcgYmFjayB1cC4NCj4gPg0KPiA+IDUuNCBp
cyBwcmV0dHkgb2xkLCBlc3BlY2lhbGx5IGZvciB0aHVuZGVyYm9sdCBpc3N1ZXMsIGNhbiB5b3Ug
dHJ5IDUuMTMNCj4gPiBwbGVhc2U/DQo+IA0KPiBHb29kIGlkZWEuIE9uIDUuMTMuMC1uZXh0LTIw
MjEwNzA5LCBJIHNlZSB0aGUgd2FybmluZyBhbmQgZGVsYXkgZXZlbiBhdCBib290DQo+IHdoZW4g
cnVudGltZSBwbSBraWNrcyBpbi4gVGhpcyBzaG91bGQgbWFrZSBmb3IgYW4gZWFzaWVyIHJlcHJv
IGF0IGxlYXN0Og0KPiANCj4gWyAgIDE4LjgzMjAxNl0gdGh1bmRlcmJvbHQgMDAwMDowMDowZC4y
OiAwOiB0aW1lb3V0IHJlYWRpbmcgY29uZmlnDQo+IHNwYWNlIDIgZnJvbSAweDYNCj4gWyAgIDE4
Ljg0MDMwOV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgICAxOC44
NDU0NjZdIHRodW5kZXJib2x0IDAwMDA6MDA6MGQuMjogaW50ZXJydXB0IGZvciBSWCByaW5nIDAg
aXMNCj4gYWxyZWFkeSBkaXNhYmxlZA0KPiBbICAgMTguODUzODM2XSBXQVJOSU5HOiBDUFU6IDAg
UElEOiA1IGF0IGRyaXZlcnMvdGh1bmRlcmJvbHQvbmhpLmM6MTAzDQo+IHJpbmdfaW50ZXJydXB0
X2FjdGl2ZSsweDFiNy8weDFkYQ0KPiAuLi4NCj4gWyAgIDE4Ljk3NzczNl0gQ1BVOiAwIFBJRDog
NSBDb21tOiBrd29ya2VyLzA6MCBUYWludGVkOiBHICAgICBVDQo+ICAgICA1LjEzLjAtbmV4dC0y
MDIxMDcwOSAjMTgNCj4gWyAgIDE4Ljk5NjgwNF0gV29ya3F1ZXVlOiBwbSBwbV9ydW50aW1lX3dv
cmsNCj4gWyAgIDE5LjAwMTI4NV0gUklQOiAwMDEwOnJpbmdfaW50ZXJydXB0X2FjdGl2ZSsweDFi
Ny8weDFkYQ0KPiAuLi4NCj4gWyAgIDE5LjEwMDMwMl0gQ2FsbCBUcmFjZToNCj4gWyAgIDE5LjEw
MzAzMV0gIHRiX3Jpbmdfc3RvcCsweDlkLzB4MTdkDQo+IFsgICAxOS4xMDcwMjJdICB0Yl9jdGxf
c3RvcCsweDMzLzB4YTANCj4gWyAgIDE5LjExMDgyMl0gIHRiX2RvbWFpbl9ydW50aW1lX3N1c3Bl
bmQrMHgzNS8weDNhDQo+IFsgICAxOS4xMTU5NzldICBuaGlfcnVudGltZV9zdXNwZW5kKzB4MWYv
MHg0Yw0KPiBbICAgMTkuMTIwNTU3XSAgcGNpX3BtX3J1bnRpbWVfc3VzcGVuZCsweDVhLzB4MTcz
DQo+IFsgICAxOS4xMjU1MzNdICA/IHBjaV9wbV9yZXN0b3JlX25vaXJxKzB4NzMvMHg3Mw0KPiBb
ICAgMTkuMTMwNDExXSAgX19ycG1fY2FsbGJhY2srMHg4YS8weDEwZA0KPiBbICAgMTkuMTM0NTk1
XSAgcnBtX2NhbGxiYWNrKzB4MjIvMHg3NA0KPiBbICAgMTkuMTM4NDg5XSAgPyBwY2lfcG1fcmVz
dG9yZV9ub2lycSsweDczLzB4NzMNCj4gWyAgIDE5LjE0MzM1NV0gIHJwbV9zdXNwZW5kKzB4MjFl
LzB4NTE0DQo+IFsgICAxOS4xNDczNTVdICBwbV9ydW50aW1lX3dvcmsrMHg4YS8weGE1DQo+IFsg
ICAxOS4xNTE1NTRdICBwcm9jZXNzX29uZV93b3JrKzB4MWI3LzB4MzY4DQo+IFsgICAxOS4xNTYw
MjddICB3b3JrZXJfdGhyZWFkKzB4MjEzLzB4MzcyDQo+IFsgICAxOS4xNjAyMTddICBrdGhyZWFk
KzB4MTQ3LzB4MTVmDQo+IFsgICAxOS4xNjM4MjddICA/IHByX2NvbnRfd29yaysweDU4LzB4NTgN
Cj4gWyAgIDE5LjE2NzkyOF0gID8ga3RocmVhZF9ibGtjZysweDMxLzB4MzENCj4gWyAgIDE5LjE3
MjExM10gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwDQo+IFsgICAxOS4xNzYxMDVdIC0tLVsgZW5k
IHRyYWNlIDQzOGI3ZjIwZjZiNDA0OWQgXS0tLQ0KDQpJIHVzZWQgdG8gc2VlIHRoZXNlIHRpbWVv
dXQgZXJyb3JzLCB3aGVuIHRoZXJlIHdhcyBhIGNvbnRyb2wNCnJlYWQvd3JpdGUgaXNzdWVkIHRv
IHRoZSB0aHVuZGVyYm9sdC91c2I0IGRldmljZSwgYWZ0ZXIgdGhlDQp0aHVuZGVyYm9sdCBkcml2
ZXIgaXMgc3VzcGVuZGVkLg0KQ2FuIHlvdSBzaGFyZSB0aGUgc3RlcHMgdG8gcmVwcm9kdWNlIHRo
aXMgUzQgaXNzdWUgaW4gYSBDaHJvbWUgZGV2aWNlPw0KDQpUaGFua3MNClJhag0K
