Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93EA4118AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbhITP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:57:25 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:26949
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238631AbhITP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:57:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB4W5iJEhv1nslDAhRzAkOTYiKiUYiUjViFEvyt+Nmp4+4NZy4RywLNIYSeFJQIi2DfhK721FNxUsoxlVChenwBrmE1nB/AQ+K0AXNDZvzO0xUj7bnHWZziuFsgdaW4TtFFDultci8UVOkLlCmMymYYN3Zph21qJkNJMw3m8QI5OI4kk6VmBbFwG0laEw1Q4QhCRbhtrbm441DZg9hdPTUujIrPD8hSePd9WH8y41IYHj4F6TdySbt37ZwGdue1XdOgbv3o1dKwSteFQXwRqPFPAHPJnUm2ryCbuLN2WuPX6ReUooW8g21KtKgwumX62LlpyNAToA7LTqc2oZE5rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OgvXYVMyNmaLF6/e0ahk67ANn4KV7pfDxk+22fn2NIM=;
 b=DBinalYz3gxQBa43qKU4ZPafueBqhwjX6CeKxypC9pzYZBxk2V3VIFhAfP6H4z5E1y3rod6iVGyK/aTQ/ZP7ckBRZIwQBCGlz5D87I13q5KsvnXdTqE9FECyIrGow5IZEjecELZgRL+AbSeOpmRB/QmQVsY9Gww2zm3lADdCe935A/WAXKUgb9RfKjn5coaZmx7n3L1Qf1Xqmc1fzcMaAwyeXNgeDpbtnNvqgZAVRMfwqX2sVJjYA2d7JdJBTjC77iijXP0wD/X/+Cww5VU2AucjxRI1xE0cVkr7j/PXXcpaFZaqDMlDZYMXsUG1ewWeo87V5XPEeyZd6vAKVPp/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgvXYVMyNmaLF6/e0ahk67ANn4KV7pfDxk+22fn2NIM=;
 b=DBzD/GwgIB7ktVcqHRQzPXpc2s4Day6+LJ3W0njrBlxi7IrSG0ErOd/nv443g+cpXh/eOTOq/gSwtAnmKVUZduMwvz/NVCffItA0SMBSGfhs7QVoqZlfaShDMJJ+a9vJ959yorbnpJi9khD3tldZ2JmEQjb7rdkhqOZ9FI5r6D8=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DB8PR05MB6825.eurprd05.prod.outlook.com (2603:10a6:10:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 15:55:54 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7%3]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 15:55:54 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "marex@denx.de" <marex@denx.de>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "andreas@kemnade.info" <andreas@kemnade.info>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "pzimmermann@dh-electronics.com" <pzimmermann@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver as
 module
Thread-Topic: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver
 as module
Thread-Index: AQHXri7VGS1vVPqiL0OD+QqmgHS9ZautAfEAgAARrIA=
Date:   Mon, 20 Sep 2021 15:55:54 +0000
Message-ID: <b399f461991b3dc6ba3d3332a054e7feea1d37f1.camel@toradex.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
         <20210920144938.314588-6-marcel@ziswiler.com>
         <dc987232-8687-a3cc-cc44-9e82e94ddd52@denx.de>
In-Reply-To: <dc987232-8687-a3cc-cc44-9e82e94ddd52@denx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1447832a-db7f-4706-1dad-08d97c4f20c2
x-ms-traffictypediagnostic: DB8PR05MB6825:
x-microsoft-antispam-prvs: <DB8PR05MB68254F5A69F1D575454CFA5AFBA09@DB8PR05MB6825.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8QM+0tSSF4EbACSHAOu8IsaYoguq8w6TToKw2lMLD1bmPoK+guLYtauKnBNvpFYp2qfpOSmUFW6td1vEPpLmRW4VwYk/VR1GrxeVRpcUKP3kSu2RYdsoZHgDDd/+dn9s4OaltBDoSsKRGomJpnPyQYwMX+4i0nIeqftoP/+cX46H0gy83CAULI8CW9J+9474LNDM3/1S36pFYnbl5Gq1isPPWLcwsJEV404GZqzY4YE7OTItfad7CsMXCauSP+U926jhD3TUm2iFFpJl6RmfO+brVB4HoWdjXOGB8j6kUq0o7O60fYmSf6/vGDGLfcaq2Zpg2DnNlRNdkd5fKEXZUe+ETdLr5te4Co6uN2ZGlo0ktDuUsl6oXvZGpvPoaP1y3VRrGNS9dBaockXU67DSBiRW3v6iAztbYM389IiPqV5yI0QFP0ZfuUc2oUNLKnkS6jGVblWgkCNWzSB7GlwZtlHNfaK+gl8ygTnCpoRCFFpYV+HptrBFaPN8hDrWDsfmJnduhuaCPO/yYK3KDyAYWdXuucwxlnUhXYSLJIRixzVfQSdYuzrvuLPW3hsrb/oVimSMQw/aZ+i3le26G05MQAbBhuys9zz//geN6zNAN2/1yslz5m4Eo5Y8zKYF5A35Y08Es31s9LzhBXLvqRZGEszsGFuDJuc/E0jfCEQK7idsl3eq38nI4bQKzWSoohvuhwxSMr1l0rEXyvekMmUqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(346002)(396003)(376002)(2906002)(110136005)(8936002)(71200400001)(66946007)(66556008)(66446008)(44832011)(26005)(6512007)(7416002)(38070700005)(186003)(4744005)(64756008)(38100700002)(6486002)(508600001)(91956017)(54906003)(36756003)(86362001)(316002)(2616005)(4326008)(6506007)(66476007)(122000001)(53546011)(8676002)(5660300002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anY4NW9RblVsZitEYmk0L2N3OUJCUi9Kc3p3c3V1NURmNlNYMmV4TXNBWFB2?=
 =?utf-8?B?UEZpc2JsZmRuNld6QkVaaURvZHF4MUtuaHMybE1laUtQV3J5QktDVzlDcVZP?=
 =?utf-8?B?am8wY2lvVk5XaXZLUk9ySDgxN0FVWUR6V1hVbDBPaHVKcnp6TGgyVVQvTU5a?=
 =?utf-8?B?WW85Q0wyVXVsOG96U0ZrTlV6NUM5UFZCNGFaMlpON0FWV1pPN1lqZkVvblQx?=
 =?utf-8?B?bG0xN3JOR0Fod04vZGwrTEI3RzduYTlvSVl6V3ZUaHlLNFRvVUt6QkwwV3ph?=
 =?utf-8?B?VWw2WWMzcWxuVk1kL3oxblB1UXpEcFhaZW54TERNK2JtODNjUDlkWnNLZXhR?=
 =?utf-8?B?ZGxmK0dUSnl2aUVpdEQzaVp6Nm5nZWNwSkRIK1FTMXczb2pSb3hjaWVKRXQz?=
 =?utf-8?B?RTlaZExNdW9kOW55NHIybUNORndqMlAzMjZKRmt6NmZFZFdIcGlCaGF0azd1?=
 =?utf-8?B?d2ZTV2R3dHgyUms3VTl1ZEdKdWMweGhGdWU0VnZmdXJpMU1FYnhUcWxURU5y?=
 =?utf-8?B?WElvemRINEpEcGtRdU1uT0FCc1VPdXJOQVl5YXUrMHJKZm9vNDc1RjlMT3k3?=
 =?utf-8?B?MnpHcUtad1hOeVN3L21aZG4vRnJUUjZ6ek1jdm1xME5GdmppeWluZ3NjSjNX?=
 =?utf-8?B?MU1nWlEveUkvWjdWUldKQ0tIOENHb3Yrb3VZZGJNU1hHcVhuK01qNlVpeEky?=
 =?utf-8?B?S1pDdDZmdUdBV2w3eG5sVGFpQ3lqQ0tYOEJSMFZzNkI5STc5dmNxSVZnc0dH?=
 =?utf-8?B?ZUtqSmxoQ0ZlcFBnaU1GSGorRVBYdURUcWl5VzNDaDlvOHdlRW0vOUg4NkNB?=
 =?utf-8?B?Q2dZUEhhcXFhNUR5eFZXcWZ6VUovMm9vNzFma1lBNU53aUdmcG0vTE4zdmVi?=
 =?utf-8?B?OGZOeS83aEwzYW5kUE03anBFOUN3ajVvOFJxRXg1RkRxZG4rL3c3azh0UHFR?=
 =?utf-8?B?OTdNUGxNNk9DR1RFZmpnMmNBRFl0SmVkVnZMUWhaeGt5WklsNWVkWGlxZzZE?=
 =?utf-8?B?dmRSYnBCcXQxdzh2K0dvaTFnNVZHZlB6T3V2bGs0a0I3dU4vR3c2YnZtWWNp?=
 =?utf-8?B?NlBreUhjbjRBdDdvTVdNWWhnMkFZUWhyVUNkSTZCSGNUVjR5N0xjNDEraWRP?=
 =?utf-8?B?bHpYaGlYb2l5Q25iOWRDT29ldzA5VTk2akFVb0dpQ1I0SWVUaTE0eCtNTzZv?=
 =?utf-8?B?MVdubzBNSW1lYmlVZi8xeE91dmpXK3U5cVE5ZC9SeE9COUQyemRmL2J3aFZB?=
 =?utf-8?B?YzdsdUNuMzFkSFk0Y21BSlVyWkhlVnJ0dm9nYmVVTXRRY2V6K0gvM3NCTmh3?=
 =?utf-8?B?N24yNlVMTkJybENwVlNZQlM5NS8rRG9KRll4WnFvTjNEWjFUZXZwckZnZ2kz?=
 =?utf-8?B?WHJGWHQvUUFRNGtzYU14K0Q2NGs0ZHdtRnJROVIxbU1sdndTV0ExU1BMMUhY?=
 =?utf-8?B?RFVDUENVRmtVbjJYdnN3ZGgwMGY3L0xTSklUNUttM092dXh6WGRCc1NrQ1BB?=
 =?utf-8?B?bU1RYTlTdG9GaTF6U1FORDlsY3lPOTlSeU9sOTV1L3NZYTc0VGhpV2NOZkRR?=
 =?utf-8?B?RFhtVHZiR2pUSkt4aXBLZXUzWG1DNkhYWTlaTjBwWndHYUF4RG9IRjkwaUMw?=
 =?utf-8?B?UWJwRG9nZXR6WHNrS20yNUFOdHcvT1o0MkpwNGVBY0xGTmx0UUdhVlVZY1JP?=
 =?utf-8?B?ekZMazlpNGVSZ2FTbTFKbmZVSlh1bUYyQjk5bXdYRmRYVThhRzBJSllmeGR0?=
 =?utf-8?B?dno1TENiU01LUTkzTlUrK1dCS0FROXhKNGljcGpnaTdhMEV0a3dMSlVWN3FY?=
 =?utf-8?B?Z1l4SVNmbEV6eUoyM2wydz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <62E754609A1F4946858C14C9D33F03D6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1447832a-db7f-4706-1dad-08d97c4f20c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 15:55:54.2719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynIHVPvFtJpZv7oJbZv2ac2/6Ahg8Z+wbnO0XsiPK1+ZeRZ8Dbh/UWqy05C0DmZjySVYyCkIaNfwhrn318k9+alj+Qwa1qE+nXgu51T3TpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6825
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTIwIGF0IDE2OjUyICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
T24gOS8yMC8yMSA0OjQ5IFBNLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFy
Y2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gQnVp
bGQgQ09ORklHX0lNWF9TRE1BIGFzIGEgbW9kdWxlIHRvIGF2b2lkIHRoZSBmb2xsb3dpbmcgYm9v
dCBpc3N1ZToNCj4gPiANCj4gPiBbwqDCoMKgIDUuMjE0NzUxXSBpbXgtc2RtYSAyMGVjMDAwLnNk
bWE6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvcg0KPiA+IMKgIGlteC9zZG1hL3NkbWEtaW14NnEu
YmluIGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+ID4gW8KgwqDCoCA1LjIxNTc2Ml0gaW14LXNkbWEg
MjBlYzAwMC5zZG1hOiBGYWxsaW5nIGJhY2sgdG8gc3lzZnMgZmFsbGJhY2sNCj4gPiDCoCBmb3I6
IGlteC9zZG1hL3NkbWEtaW14NnEuYmluDQo+IA0KPiBJc24ndCB0aGVyZSBzb21lIFJPTS1zaWRl
IFNETUEgZmlybXdhcmUgYmFrZWQgaW50byB0aGUgTVg2IHdoaWNoIGlzIHVzZWQgDQo+IGFzIGEg
ZmFsbGJhY2sgaWYgbG9hZGluZyBuZXdlciBvbmUgZnJvbSBmaWxlc3lzdGVtIGZhaWxzID8gSSBz
dXNwZWN0IHRoZSANCj4gZGVmYXVsdCBST00gZmlybXdhcmUgbWlnaHQgYmUgYnVnZ3kuDQoNCkkn
bSBub3Qgc28gc3VyZSBhYm91dCB0aGlzLiBBdCBsZWFzdCBpdCBzZWVtcyB0byBmYWlsIGlmIG5v
IGV4dGVybmFsIGZpcm13YXJlIGNhbiBiZSBsb2FkZWQuDQo=
