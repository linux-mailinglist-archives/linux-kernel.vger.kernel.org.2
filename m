Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD08340089
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhCRH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:59:51 -0400
Received: from mail-db8eur05on2043.outbound.protection.outlook.com ([40.107.20.43]:54881
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229540AbhCRH70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVo15sFf/b/5ERt4716pCwYVBDv7LSy+IgwmybbdFLP2ymJvyru0IexiGvi7pJMcYH+Kn1lA1S8hVz0PDqfploL37Hbd8eVnTCywSf1jWxi1MNd4PfP6M2gP8ffjONVrkr/Tmo+XbzWe26//1nmCpkeI9oh7netSUa/k2dBXh9x59Rw9ZEzyYMIyPouW1FxHriMIye6Ydho9fMMfuwwdVqFCkrGa/daCgdraBhnUKZB47R2R2Ljmpo0XUaO/yIVkWHTTr1KGN11BU3BozZLUYHrnD5+39ylz9PN3pvv4kt+9aodal4bxvlMGEZ1SmoxRFUbTCIwUd+GYNnNOIpYDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JfYbA1RTIzZKEBvQq/ccdBWJMQn8eFNoJymJkPwXpo=;
 b=DrUiXuedQO7dz2VnjRjckt4/AW/52ZwFyUxOaQoV/MHnwFypMs1/jp2xPwg/749y4pm+4Sh+s/1jApKiWwnIDbtuT6T0CScJ+n9jtKAnzsG4u7GTWApEs+dkldwfRsrFfh3p9XHHOR9RgVOQAO437CSTVO3+3wdiF1koQ4poQ50AkEV3DDW35tFBxrqMQ/ICClo3bTwAPAUE15YfaVTznKAPKIgXeSy7KgysVYTqWdDELU5yWNMTy0G0xFbsfj8CU337VmNEN+3dAi6tonc73N7Jz5XeKRnfJdRUAzvTL6yt47MHEyiuK6vYVOPU7MEESwVnJkhlh7HruKU6pxJZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JfYbA1RTIzZKEBvQq/ccdBWJMQn8eFNoJymJkPwXpo=;
 b=UtCbeiWvq4kHJNKIlPZVKc5Z5UTsNQdg34xnOo+20Wj+nmQXBxxKZFG9VtdQdk2nIe6XSymsLrML8i2z+nJ6SiCoXLeVm8s/Gt7cgq4SOfO0HD3f8CP+HVjZzkRHhlQ6il54zuWgQnel0WFiDscosJllJzP6MHUc2XMsgnAnKDo=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:59:24 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685%3]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 07:59:24 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] optee: enable apci support
Thread-Topic: [PATCH] optee: enable apci support
Thread-Index: AQHXFxnYXTe1sDRwj02IbFElWYAqQqqH2isAgAAG5YCAAX5yYIAACDOAgAABsFA=
Date:   Thu, 18 Mar 2021 07:59:24 +0000
Message-ID: <AM6PR04MB5413A5A59145A4EF3CAE9190F1699@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210312083653.38780-1-ran.wang_1@nxp.com>
 <20210317080442.GA3018337@jade>
 <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>
 <AM6PR04MB54133297642949378521C6A9F1699@AM6PR04MB5413.eurprd04.prod.outlook.com>
 <CAMj1kXEfVh-q=cae1RWTVwABYsmX=-OZbWmgRMm4DSK7NjQBEg@mail.gmail.com>
In-Reply-To: <CAMj1kXEfVh-q=cae1RWTVwABYsmX=-OZbWmgRMm4DSK7NjQBEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df71404d-6084-434b-f717-08d8e9e3bef6
x-ms-traffictypediagnostic: AM7PR04MB6871:
x-microsoft-antispam-prvs: <AM7PR04MB6871E2EA65649DADDAD7E9FAF1699@AM7PR04MB6871.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: unOjnTfdy50KUflQNBj8IT0OOTmgUA4VaXWcpu1INVxB2JTLVLjJikooct4QtI9ccXso111E6JR9OFCihTX9qMUgYqKEU0qlQ7Yrw/cP6iTA1kxM68zPNbWPIRzP/d+OjR9h9gGPEPEr96tyfXRHUdanw03+fst/fS5cqAmZs/fFYcD+TkQbih1IRaDTncL+y7T8CMe7haEs0nFbhlOrr6EqqcJwHjovkP8I9J7GW2CPqZF8lRF/eZWulqhGlPTFfTblBrPnqSWmHZ82HapxguKmw3tOMDxtp2DPR+oJJnUEe549Oa3qWhYZb4aVCezCbOHaBpSWpx7fDnE7/iSlEzAK+ObKt307H8D0lMx3eCRmPk7H58cL1JMqiKRsBiRCBXNZ98+zZx8CJ0rMsTLfFq7usnk95SUmpTvxvBfvi58AWvOqiQ/PjHSZ9Pz31DJd6VjSjKE0c/1QRaAcFvMOp6nz3vMV+FD3xS+FOGnyctgBUA7qAyelVDmy3fJcE1jhb7asS63kzMVJJZVbCtlaVRitv0Dz8fgwOGiLudzLDUSbgOu9ukojO7n0TGyGQRRWOGeq+MEjM/xnCg9NgZsDm6Xe7lVu37bBl7u3+UdqgFb4lbAw4/z/mTG6gK/5k0c6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(54906003)(8676002)(186003)(9686003)(38100700001)(316002)(4326008)(83380400001)(33656002)(6916009)(478600001)(2906002)(66476007)(66446008)(55016002)(66556008)(5660300002)(66946007)(76116006)(64756008)(71200400001)(7696005)(53546011)(86362001)(8936002)(6506007)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S250N1JqQklUenZjOUROV2U3YlRpcGtJVWFvRStoSnlZa0xFRG5qbndUZGl0?=
 =?utf-8?B?Qk11TktpeGZFQ0tWcG5aSTJBcXhzd0lFaHhON0xZRzVBcUNPUlJ2WHBCSmpQ?=
 =?utf-8?B?bkpkQ2xZNWFzMVhQa1VJVkZGOUZHTHVuZUlaTE96bmlEMVd1K1ZwSzA0cERZ?=
 =?utf-8?B?RG93bTRMZW5JcWZ4VkYybm5ITmNRMHhqaG9FN2FsVTgxbWlpR25raW85b1JR?=
 =?utf-8?B?dFdxVHRTbXp6YkRiSWF1QnBQM0Y1VnBMZTdoMUgxSU96Uy9FajI0Q3AyUmdX?=
 =?utf-8?B?MnVFVEVzR0VsdENZTUVWck50ZTdMNEFEeG02cVEwa3dGVnhUWmVjMUcvMTZC?=
 =?utf-8?B?N3R2YmJMNXc0MWxrRTFSY0w5aXpKQm96RzhodXRqTVpqeENHaHMxcjQxRlBQ?=
 =?utf-8?B?YVdQVUc2dzVzR0lmampaTDJGcDl3UU1uVEt0a1RwcGJteFEzNkVlRkNsY0I2?=
 =?utf-8?B?bWE1Q0JtYlVDc3hmZDhiamM0WDRNSGdvWFlXeTZzdUZmM3BlK0xtSW1ucU1J?=
 =?utf-8?B?UFo3SWhueXBISHNWVXNiMlFhdUxMdG1maGhEQ3p6Qll6TFlJYUdEeEJCYjBo?=
 =?utf-8?B?YVNjNDNXb2J0NStOOTVrZm5IWjIxTCtDTWdUWG9UMVo2SmV0SmdSR0pHOTg2?=
 =?utf-8?B?V3RBSFpxUkR5UlVpOWZDaHdVSFF5elI2TGxIQnJXYjFlWVdtSWY0RUJKdXh3?=
 =?utf-8?B?cjlNcjhTeUZmSjZRa1BLbU5QbUt2aHFmcGlvbHBpbERrRk45UEJuSUxqQ0xG?=
 =?utf-8?B?Y09uU1lRWFZjYXVidy9xNkVNYWY3Y1JxUHVxRXpTS2ZZZndodkJ2bmJUU2dY?=
 =?utf-8?B?bjhSNGIwSGFYcE9JeUZOaDVBdVorMXh2VEExN2I4dHdJRG1td3RGZldZWC9E?=
 =?utf-8?B?WE1mU2E5ZWpGeURrZVRDVFJyTEdzTWVCRHFJMmhnWW5NS29lQUcyUkN5aldu?=
 =?utf-8?B?OUVtQWVjVzYxUkxiVHRNMzZ6Y3kyQjRzaTE1UllaWFFjNTJZSndVN2VTMDhw?=
 =?utf-8?B?bnpPRU9wWDUzSlVuQVZVRjZ3bVNGZWY4bGk5d01RcUxGN3VrV2RINjZBV2hk?=
 =?utf-8?B?bUlPMk1FdEY1OTJmOHN6ck5xVzNRR0NKOUIydFFtc0wxb1JSdlNGNnpNZC9Q?=
 =?utf-8?B?U1M0U0hHYjFMei94aDJJcFF5aE1vWEo4cCtYZlZiMUxXOVV1MGkvNEtNdCtU?=
 =?utf-8?B?Wi9DS0wvQ1c5YzJTRXNMaUF4TVg1YlJablhZTVo2RHozOWtFMU9JdFAxa3NZ?=
 =?utf-8?B?T25kNDdzd1JNS09XUFl2ZlpOd1cvdG9LZzFnQlJHOGx1YTN0aVFRSTV3TUJn?=
 =?utf-8?B?UWpaQlZsd0VtMzlsRjJLeWQ2MFpLSmFVVXduRTVYLy9ZT2lValVmU0N2endP?=
 =?utf-8?B?Y2h1cStscUVsWjQ0SUZHUHhZWllKRUVhbzVMSDE4R0ZtczVRTTdIeFVVWG8x?=
 =?utf-8?B?blIvMHllVXRSTytjRjJRUjVQZFUvemRXQUhxbG5uVE9DUjQxVi9Za0k1RUp2?=
 =?utf-8?B?N2VpRG9TY0V4a1ZlYW5YSnZzbEFwWlBVN0JjZk9rYlcvbms4Z1IxYjlETDBE?=
 =?utf-8?B?Zk1HaW0vQ0JvcC8xY1UraGplRFZXTWhBb0dOai9RaXBKRUpFOG5ibVJkcEY0?=
 =?utf-8?B?ckhGZnRTbDUvOHR0OGNnMzg3Q0lDU1BFWHgzMkFkb3lvZUFzQnVKWXRRZUN3?=
 =?utf-8?B?SXlMdEE2cU1DeWNCN3ZZTXl2dkRVYk56YUEyUGZFTnZMSXExenBESDRKc0Vl?=
 =?utf-8?Q?e3PXwFlOO5TDOqlEHe/vudzo46A3mH1ANcHTmRi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df71404d-6084-434b-f717-08d8e9e3bef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:59:24.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTOjHMomkWTx5nXcGcFNYAr8N/ibfq5BqzHZ7k1yVKuY8lek6/e3W59ngoCrY27J8hAOOjMfNk0jFYiPAl2GQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkLA0KDQpPbiBUaHVyc2RheSwgTWFyY2ggMTgsIDIwMjEgMzo0OCBQTSwgQXJkIEJpZXNo
ZXV2ZWwgd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDE4IE1hciAyMDIxIGF0IDA4OjI5LCBSYW4gV2Fu
ZyA8cmFuLndhbmdfMUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIEFyZCwNCj4gPg0KPiA+
DQo+ID4gT24gV2VkbmVzZGF5LCBNYXJjaCAxNywgMjAyMSA0OjI5IFBNLCBBcmQgQmllc2hldXZl
bCB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDE3IE1hciAyMDIxIGF0IDA5OjA0LCBKZW5z
IFdpa2xhbmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IE9uIEZyaSwgTWFyIDEyLCAyMDIxIGF0IDA0OjM2OjUzUE0gKzA4MDAsIFJhbiBXYW5n
IHdyb3RlOg0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkIEFDUEkgc3VwcG9ydCBmb3Igb3B0ZWUg
ZHJpdmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcgPHJh
bi53YW5nXzFAbnhwLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy90ZWUv
b3B0ZWUvY29yZS5jIHwgMTAgKysrKysrKysrKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdGVlL29wdGVlL2NvcmUuYyBiL2RyaXZlcnMvdGVlL29wdGVlL2NvcmUuYw0KPiA+ID4gPiA+
IGluZGV4IGNmNDcxOGM2ZDM1ZC4uOGZiMjYxZjRiOWRiIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvdGVlL29wdGVlL2NvcmUuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29w
dGVlL2NvcmUuYw0KPiA+ID4gPiA+IEBAIC01LDYgKzUsNyBAQA0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gICNkZWZpbmUgcHJfZm10KGZtdCkgS0JVSUxEX01PRE5BTUUgIjogIiBmbXQNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPiA+ID4gPiA+ICAjaW5jbHVk
ZSA8bGludXgvYXJtLXNtY2NjLmg+DQo+ID4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9lcnJuby5o
Pg0KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiA+ID4gPiBAQCAtNzM1LDEy
ICs3MzYsMjEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiA+ID4gPiBv
cHRlZV9kdF9tYXRjaFtdID0geyAgfTsgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsDQo+ID4gPiA+
ID4gb3B0ZWVfZHRfbWF0Y2gpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKyNpZmRlZiBDT05GSUdf
QUNQSQ0KPiA+ID4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIG9wdGVl
X2FjcGlfbWF0Y2hbXSA9IHsNCj4gPiA+ID4gPiArICAgICB7ICJPUFRFRTAxIix9LA0KPiA+ID4N
Cj4gPiA+IFlvdSBjYW5ub3QganVzdCBpbnZlbnQgQUNQSSBISURzIGxpa2UgdGhhdC4gVGhlIDQg
Y2hhcmFjdGVyIHByZWZpeA0KPiA+ID4gaXMgYSB2ZW5kb3IgSUQgdGhhdCBpcyBhc3NpZ25lZCBi
eSB0aGUgVUVGSSBmb3J1bSwgdGhlIDQgZm9sbG93aW5nDQo+ID4gPiBkaWdpdHMgYXJlIHVwIHRv
IHRoZSB2ZW5kb3IgdG8gYXNzaWduLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGlzIGluZm8uIENv
dWxkIHlvdSBwbGVhc2Ugc2hvdyBtZSB3aGVyZSBJIGNhbiBmaW5kIHRoZSBndWlkZS9leGFtcGxl
IGZvciB0aGlzIGFzc2lnbiBwcm9jZXNzPw0KPiA+DQo+IA0KPiBJIHRoaW5rIGl0IGlzIGJldHRl
ciB0byBhc2sgYXJvdW5kIGludGVybmFsbHkuIEFzIGZhciBhcyBJIGtub3csIE5YUCBhbHJlYWR5
IG93bnMgYSBBQ1BJL1BOUCB2ZW5kb3IgcHJlZml4Lg0KDQpPSw0KDQo+ID4gPiA+ID4gKyAgICAg
eyB9LA0KPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFjcGks
IGR3YzNfYWNwaV9tYXRjaCk7DQo+ID4gPg0KPiA+ID4gZHdjM19hY3BpX21hdGNoID8/IERvZXMg
dGhpcyBldmVuIGJ1aWxkPw0KPiA+DQo+ID4gTXkgYmFkLCBJIHdhcyByZWZlcnJpbmcgZHdjMyBj
b2RlIGFzIGFuIGV4YW1wbGUsIHdpbGwgY29ycmVjdCBpdC4NCj4gPg0KPiA+IEJ1dCBsb29rcyB0
aGlzIHR5cG8gZGlkbuKAmXQgdHJpZ2dlciBlcnJvciBpbiBteSB1bml0LXRlc3QuDQo+ID4NCj4g
DQo+IERvZXMgeW91ciBidWlsZCBoYXZlIENPTkZJR19BQ1BJIGVuYWJsZWQ/DQoNClllcw0KDQo+
ID4gPg0KPiA+ID4gPiA+ICsjZW5kaWYNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gIHN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG9wdGVlX2RyaXZlciA9IHsNCj4gPiA+ID4gPiAgICAgICAu
cHJvYmUgID0gb3B0ZWVfcHJvYmUsDQo+ID4gPiA+ID4gICAgICAgLnJlbW92ZSA9IG9wdGVlX3Jl
bW92ZSwNCj4gPiA+ID4gPiAgICAgICAuZHJpdmVyID0gew0KPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgLm5hbWUgPSAib3B0ZWUiLA0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgLm9mX21hdGNoX3Rh
YmxlID0gb3B0ZWVfZHRfbWF0Y2gsDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAuYWNwaV9tYXRj
aF90YWJsZSA9IEFDUElfUFRSKG9wdGVlX2FjcGlfbWF0Y2gpLA0KPiA+ID4gPiA+ICAgICAgIH0s
DQo+ID4gPiA+ID4gIH07DQo+ID4gPiA+ID4gIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIob3B0ZWVf
ZHJpdmVyKTsNCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMjUuMQ0KPiA+ID4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+IFRoaXMgbG9va3Mgc2ltcGxlIGVub3VnaC4gQXJkLCBpcyB0aGlzIHdoYXQg
eW91IGhhZCBpbiBtaW5kIGVhcmxpZXI/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gTm90IHJlYWxs
eS4NCj4gPiA+DQo+ID4gPiBPbiBTeW5RdWFjZXIsIHdlIHVzZQ0KPiA+ID4NCj4gPiA+ICAgICBE
ZXZpY2UgKFRPUzApIHsNCj4gPiA+ICAgICAgIE5hbWUgKF9ISUQsICJQUlAwMDAxIikNCj4gPiA+
ICAgICAgIE5hbWUgKF9VSUQsIDB4MCkNCj4gPiA+ICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2Ug
KCkgew0KPiA+ID4gICAgICAgICBUb1VVSUQoImRhZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJi
ZjRhYTMwMSIpLA0KPiA+ID4gICAgICAgICBQYWNrYWdlICgpIHsNCj4gPiA+ICAgICAgICAgICBQ
YWNrYWdlICgyKSB7ICJjb21wYXRpYmxlIiwgImxpbmFybyxvcHRlZS10eiIgfSwNCj4gPiA+ICAg
ICAgICAgICBQYWNrYWdlICgyKSB7ICJtZXRob2QiLCAic21jIiB9LA0KPiA+ID4gICAgICAgICB9
DQo+ID4gPiAgICAgICB9KQ0KPiA+ID4gICAgIH0NCj4gPiA+DQo+ID4gPiB3aGljaCBkb2VzIG5v
dCByZXF1aXJlIGFueSBjaGFuZ2VzIHRvIExpbnV4LiBTbyBJIGRvbid0IHRoaW5rIHRoaXMgcGF0
Y2ggaXMgbmVlZGVkIGF0IGFsbCB0YmguDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoaXMgZXhhbXBs
ZSwgYnV0IGFjdHVhbGx5IEkgZmFpbGVkIHRvIHRyaWdnZXIga2VybmVsIG9wdGVlDQo+ID4gcHJv
YmUgZnVuY3Rpb24gYnkgdXNpbmcgYWJvdmUgY29kZSBpbiBBQ1BJIHRhYmxlLg0KPiA+DQo+ID4g
QW5kIEkgYW0gY3VyaW91cyBob3cgdGhpcyAnY29tcGF0aWJsZScgcHJvcGVydGllcyBiZSBwaWNr
ZWQgdXAgYnkga2VybmVsIHdoZW4gdHJ5IHRvIG1hdGNoIGRyaXZlciBpbiBBQ1BJIG1vZGU/DQo+
ID4NCj4gDQo+IE9uIFN5blF1YWNlciwNCj4gDQo+ICQgY2F0IC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS9QUlAwMDAxOjAwL2Zpcm13YXJlX25vZGUvbW9kYWxpYXMNCj4gb2Y6TnRvczBUQ2xpbmFybyxv
cHRlZS10eg0KPiANCj4gPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRvIGdldCBpdCBkb25lIGJ5IGZl
ZWRpbmcgLmFjcGlfbWF0Y2hfdGFibGUgd2l0aCBzb21ldGhpbmcsIHJpZ2h0Pw0KPiA+DQo+IA0K
PiBUaGUgUFJQMDAwMSBISUQgaXMgaGFuZGxlZCBpbiBhIHNwZWNpYWwgd2F5LiBQbGVhc2UgZ3Jl
cCB0aGUgTGludXggc291cmNlIGlmIHlvdSBhcmUgY3VyaW91cyB0byB1bmRlcnN0YW5kIGhvdyB0
aGlzIGlzIGltcGxlbWVudGVkLg0KDQpZZXMsIG15IGZhaWx1cmUgaXMgZHVlIHRvIHdpdGhvdXQg
UFJQMDAwMSwgYW5kIEkgaGF2ZSBmb3VuZCB0aGUgRG9jIGluIGtlcm5lbCBjb2RlIGV4cGxhaW5p
bmcgdGhhdC4gTm93IGl0IHdvcmtzIGZpbmUgb24gbXkgc2lkZSA6KQ0KVGhhbmtzIGZvciB0aGUg
ZWR1Y2F0ZSENCg0KUmVnYXJkcywNClJhbg0K
