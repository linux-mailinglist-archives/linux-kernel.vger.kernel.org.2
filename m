Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA30E3D47A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhGXL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 07:56:00 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:14624
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231511AbhGXLz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 07:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPfAgbCWk1LCUzpeOTgQjjzeul8raJhdzuWsRPE22Df7NUHbdhw4hwq0HQMsLZVg4vx6BAGXBTQbCx4HhmFUT9xNNvYOcwUQ7sgV88DkuMARs8pyyi3Wh7a5FuGzGIFHEnTNZUvTqhTGlmM742KjAkSj8lNQdFSNlC6c98KXPHXanK1XjeYDQeLdivz2p65olhoJvYgGlAbodtxSsIK3I24On+LGC5TFaU89wnSEyW+BmjfcbC7IUcGoVkO/q1d1UPWsxx6x9T7mVRPuH0BlKqXayn4lW/sWXcF9mkYppz4/Y4aCWSHbywlwkF0um/VGqg820Y+unM9xZp9RpPEkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xT0R7UfrEk0wVNEjNcEKA/u9GuuqYjYLyNvvh89UPo=;
 b=Kx426kdUoQruijK5LooqloohMcQWm7mk8Nb8nsoFC1PwVOf54BUOAFzxJqu2/syQaZ4JjUB/Yj3WjTNgud3X5GuABzEUQfBmezrOFPuxnw2Hms7cdalQisshtl+ZMAc6GopnF65ifl3cS5OHrzGtzVcxB0mpBNO/9EZgxZ/29r93LALAavHpAojB7itfqpBmkevamJtnLGtf411tFXxBKYuoX1aRtKEvKehNLFCF4JI/JfKxCocemmadnH4GDXcyFJ06XAOrxAbQWD+rzO2Qhma2IjwyRnBE/Qit3/aw+IjKo3CIbVs91Uc89UdNaXr9rKq+Ozz4LqzO77DvIumAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xT0R7UfrEk0wVNEjNcEKA/u9GuuqYjYLyNvvh89UPo=;
 b=BXhnDZUgamI373MNqCkTce03u1UjYCATYSgu6lRtJisjo07rJwBmFqTxYUhHbxLXDKEESmukKVGfh1OkpJVPGDpJIh3S7z/X3/WkcbRzNfNydgjSw2C76IFzhR1+et5iYoGc4e4mkdArT6vOiOnEqjz71db3OOrG0v1hN3Sd9ZU=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Sat, 24 Jul
 2021 12:36:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4331.035; Sat, 24 Jul 2021
 12:36:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: RE: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
Thread-Topic: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
Thread-Index: AQHXf8p3RWr7/P8EwUqhR+4nxzCwZKtQuigAgAFWDhA=
Date:   Sat, 24 Jul 2021 12:36:27 +0000
Message-ID: <DB6PR0402MB2760A70606BEC3B9B7CBC5BB88E69@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
 <20210723135239.388325-3-clement.leger@bootlin.com>
 <CAK8P3a1stoM2zRpkEBOLSFRxPy6Tabn6NgO-1sVRL4uq3wudaQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1stoM2zRpkEBOLSFRxPy6Tabn6NgO-1sVRL4uq3wudaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f40aad5e-4f68-4e8e-b412-08d94e9fa829
x-ms-traffictypediagnostic: DB8PR04MB7179:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB8PR04MB7179E9B9F4F49676B000319BC9E69@DB8PR04MB7179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7775bq2ARFCVr0+zGPxksMJrbYco90qYfdB7Z6SOS6sEyOznmgfJCDmgmHnPEQWCTyQgyjZem1BHf5pKnisro/LyifPOkqk41NeAlnhj38KtjTTTW9mRCuq5FXQNp4sMEleiif/mAccqy3I2F77UTYj2fEotj6AdKPnbAs/LL7MgEmFQLXB+opjmkr6kJSYgLEntQayt5g8p2V+Ea9WjHALY+p4RQsN1S+nIZ6s1Q1a7RediIkF2xtiNLTplPmQHHJxMoAmMofzz+n26y0LxjmSGYAqs/NeFXHneGJHgdU+5hoZy5K8TmhEYK0ur38iNJe5LTtZm2B2tRiG3FIqW34kNAVg4Ja33K7Z/uNz4O0VGiG6/cT72APrOnMIXFqqWI7Gq50Gf/MVCgmyBHsf5y2REtFHjkSBMIG4ILm+imt4lK9emeqo0BhebovLOZ5jN9hWKojDUI1WLT/xmmpuLUiIr7uSh8tQVblkIX0fFeX3aXLmvK/11EQeNs1oXzRTEpXBNB5pZpSj7P+0eUXqbaFEhPpd8CdfUg/5QevsKgeIl/1EX9ns3VhS1SC68Sob8BUM3O84RHS8APAWK+fB8vrKCEDIwMHot3c64czU7uwlxXhay8PZGi/z5TFkSJvk17aSlOiV2o6rDtGVyK9SVHIYXNRHVSQjS0yjU7tPHHkR/Yd5MdyAkDwnhCh5MJzWGwIjAEfRe63tqKfymO7X2Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(366004)(186003)(7696005)(26005)(83380400001)(6506007)(53546011)(478600001)(33656002)(54906003)(66446008)(66946007)(66476007)(64756008)(71200400001)(7416002)(4326008)(38100700002)(76116006)(316002)(110136005)(2906002)(55016002)(5660300002)(8676002)(52536014)(66556008)(122000001)(8936002)(86362001)(9686003)(66574015)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SncxRlJ1NkVxVVRkVndsVmgxVGxXaUMrWkwwTFlCMmlDbmhqSGNaQ0JBcC84?=
 =?utf-8?B?c0RVMlZKRUZYMDZ1eUVtd0pORENGQTdoUW5mWWl4T2FHY0Y1NkNEbjZLQU1X?=
 =?utf-8?B?ZDNwZEZITVhJWmsyd0pmVzF0Y2dOVFZ5Sml0NHk0dXo2Y0hSYmk3M1NBSXZM?=
 =?utf-8?B?c0hoeG02WUJKYjZhZWIvRWdTZVlrSHhuZURSL2kwSWc3ZHRTL1RLY2JpOUVR?=
 =?utf-8?B?RUJDSEhIVnkrTHU0R1QzOENTVmM5L2VKKzg0N1orVXhqVHQ2eElZNURGRzlI?=
 =?utf-8?B?Z2ZzQmxrMnN5eHlidCtZY2wvOTA1STdaWXJpKy9mS3NxWURCVUxJbmJQaG52?=
 =?utf-8?B?WFpHUElGZGluUDhha0FGNjd0STlKaXhsdi81cU85c3dVYjVBZDcyR3lpb29P?=
 =?utf-8?B?b2E5Tmt2UFF3Q0YxaXN1VEphWTBoRlZvY0xJYndNbEJBdUsyN09MV2thV2F1?=
 =?utf-8?B?TnRGdmdGeWtlZmhWWWpHTVhyZkxGOXY1UDZjbGh5YzVVRGJ2bDFRdTN3NWpj?=
 =?utf-8?B?dW51Y1JvM204d3NoZ2VOQ2s4bXVpZjJKdVN2QzdlSjlnRWU2VnhSV0N0eEtl?=
 =?utf-8?B?QTMveDZJTDZGS1hoZUFaZG9QR0hlamMzV0s4MWNTN1B3WFJDM21ESHFqbllw?=
 =?utf-8?B?cWc3SmhFYkM3SGt2YlFzU0UxSnpkQ2xPN3Nydm9JcWlMc3ZPQ2NUN1I5Ri9a?=
 =?utf-8?B?U3lZV08zMFhKa1FrMUlKYk41VTdUbGxHcmJiUGZrNVZ5V25JVVVPTDF4M3J4?=
 =?utf-8?B?U0J5Y3BWSWozbERpaDlZWWFOWjRLRGlGYndBaDh3WFRiR3l4WVUzN0w3UW5H?=
 =?utf-8?B?NS9DbzZROTUxMFdCRk1waUZTeXdsOWhZTVVLOU1Zdm9ULzBTdDdpQXMxbkFp?=
 =?utf-8?B?YUo5YzcwOFFTdDNNMFZrYSt4bjV0eDlZcmdUbDJQTmpuVXVXSmlrRzMxUmdm?=
 =?utf-8?B?VjFub0pWR0tTR2VpQUtrQ21ybWdWdkF3bEdqT20wbVBXSEVCbytHbzBUVXRt?=
 =?utf-8?B?ejRDUkdZWXJjRDVHQmVXV25YTmV3bncwVzdyZDkzSk9tOE5vZnBMY1RzcHpO?=
 =?utf-8?B?eU5Wa1pkRzI3Q3dsM3lLQ0RNamdsUGplODFXK2Vsd1NVcGlLUjB4RFhUTFdL?=
 =?utf-8?B?RytRb3JMRGQ5eUxZWUZlYWtodlAxUkZ6V3dLQVBmeitLc2IwRHhkcFJ2blV4?=
 =?utf-8?B?WERmWWk0eExtUFFBTjZ4UW44WkhlL3V1ZjA1N2J6ZzEzdXdQS2dhOGhUZ21o?=
 =?utf-8?B?V1U0bm1uM1F5VTA4cFN2dHVucm1FRXlPRkRYU1N5VjdLeXpDNk5nZThPemg0?=
 =?utf-8?B?OEZneGhyT0M0R1E0ZTlYZmxTU0VOWHVnQTRkY244NzlFSnFkSld2NWpCZ3gr?=
 =?utf-8?B?ZmZtTFIwREpIc0RCVkE3YVF1RlVRV25sTURKM2dPMm53c2pHd3hSL25oamJm?=
 =?utf-8?B?ZXZRTU1GZ3hRMHZpVitKNU53RDc4VnR4bTRRZEJnZ1dLTWZWMXVHbnpJMmc2?=
 =?utf-8?B?NWFtM092VVJjcDdaSnVEZTk3L0xRWnRBR3pMUmNDNjBvWTllUXJHL1VzV040?=
 =?utf-8?B?RzNPVHVHTDl0UVdhNTdBZ25nRWNOK2pkcUtCNlZHVzVhMVY2b3NOdU1QSjl6?=
 =?utf-8?B?MU5OaktaSFcrVGViVVVYbFRoVlRjNEpOamE3anUwL3VnVk0zQ3lTc1NzTVlo?=
 =?utf-8?B?Z2k1Vno0cnZtZ3UvaDB1SkUzdW5qWlZwSmZoY0swc1hxbXZmVEZTLy9jQ3pG?=
 =?utf-8?Q?+gK9N6gCsvD9uv2l717j4PARGkhFx7nKQkgnD5D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40aad5e-4f68-4e8e-b412-08d94e9fa829
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2021 12:36:27.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLWUy24HyeHuyE/67LQwnhfutKtD6afg4+Q7xR+D4XOpccIoAX/7eKVMsa/72PPC2d/aeczxDp8jT3bHCGCV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gc3lzY29uOiBhZGQgc3VwcG9ydCBmb3IgInN5c2Nv
bi1zbWMiIGNvbXBhdGlibGUNCj4gDQo+IE9uIEZyaSwgSnVsIDIzLCAyMDIxIGF0IDM6NTIgUE0g
Q2zDqW1lbnQgTMOpZ2VyIDxjbGVtZW50LmxlZ2VyQGJvb3RsaW4uY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IFN5c3RlbSBjb250cm9sbGVycyBjYW4gYmUgcGxhY2VkIHVuZGVyIHNlY3VyZSBtb25p
dG9yIGNvbnRyb2wgd2hlbg0KPiA+IHJ1bm5pbmcgdW5kZXIgdGhlbS4gSW4gb3JkZXIgdG8ga2Vl
cCBleGlzdGluZyBjb2RlIHdoaWNoIGFjY2Vzc2VzIHN1Y2gNCj4gPiBzeXN0ZW0gY29udHJvbGxl
cnMgdXNpbmcgYSBzeXNjb24sIGFkZCBzdXBwb3J0IGZvciAic3lzY29uLXNtYyIgY29tcGF0aWJs
ZS4NCj4gPg0KPiA+IFdoZW4gZW5hYmxlLCB0aGUgc3lzY29uIHdpbGwgaGFuZGxlIHRoaXMgbmV3
IGNvbXBhdGlibGUgYW5kIGxvb2sgZm9yDQo+ID4gYW4gImFybSxzbWMtaWQiIHByb3BlcnR5IHRv
IGV4ZWN1dGUgdGhlIGFwcHJvcHJpYXRlIFNNQy4gQSBTTUMgcmVnbWFwDQo+ID4gaXMgdGhlbiBj
cmVhdGVkIHRvIGZvcndhcmQgcmVnaXN0ZXIgYWNjZXNzIHRvIHRoZSBzZWN1cmUgbW9uaXRvci4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IEzDqWdlciA8Y2xlbWVudC5sZWdlckBi
b290bGluLmNvbT4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHdyb25nIHdpdGggdGhlIGlt
cGxlbWVudGF0aW9uLA0KDQpJIGFsc28gdm90ZSBmb3Igc3VjaCBhbiBpbXBsZW1lbnRhdGlvbi4g
U3VjaCBhcyB3ZSBoYXZlIGEgY2hpcCBoYXMgYSBtaXNjDQpyZWdpc3RlciBzcGFjZSwgcGFydCBh
cyBiZWxvdzoNCg0KNDRoIFVTQiBXYWtlLXVwIENvbnRyb2wgUmVnaXN0ZXIgKERHTyAxMCkgKFVT
Ql9XQUtFVVApIA0KNDhoIFBURCBQYWRzIENvbXBlbnNhdGlvbiBDZWxsIENvbmZpZ3VyYXRpb24g
UmVnaXN0ZXINCjRDaCBMb3dlciBDQTM1IFRTIFRpbWVyIEZpcnN0IENvbXBhcmUgVmFsdWUgKFRT
VE1SX0NNUDBfVkFMX0wpDQo1MGggVXBwZXIgQ0EzNSBUUyBUaW1lciBGaXJzdCBDb21wYXJlIFZh
bHVlDQo1NGggTG93ZXIgQ0EzNSBUUyBUaW1lciBTZWNvbmQgQ29tcGFyZSB2YWx1ZQ0KNThoIFVw
cGVyIENBMzUgVFMgVGltZXIgU2Vjb25kIENvbXBhcmUgVmFsdWUNCjVDaCBDQTM1IENvcmUwIFJl
c2V0IFZlY3RvciBCYXNlIEFkZHJlc3MgKERHTyA4KSAoUlZCQVJBRERSMCkgDQo2MGggQ0EzNSBD
b3JlMSBSZXNldCBWZWN0b3IgQmFzZSBBZGRyZXNzIChER08gOSkgKFJWQkFSQUREUjEpIA0KNjRo
IE1lZGl1bSBRdWFsaXR5IFNvdW5kIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgKE1RUzFfQ0YpIDMy
IFJXIDAxMDBfMDAwMGgNCg0KSXQgY29udGFpbnMgc2V2ZXJhbCBmdW5jdGlvbnMsIHdlIG5lZWQg
cHJvdGVjdCA1Q2gsIDYwaCB0byBhdm9pZA0KTm9uLXNlY3VyZSB3b3JsZCBtb2RpZnkgaXQuIE90
aGVycyBjb3VsZCBiZSBkaXJlY3RseSB1c2VkIGJ5IExpbnV4IGtlcm5lbC4NCkJ1dCB3ZSBjb3Vs
ZCBvbmx5IGhpZGUgdGhlIHdob2xlIHJlZ2lzdGVyIHNwYWNlIGluIHNlY3VyZSB3b3JsZCB0byBt
YWtlDQo1Qy82MGggcmVnaXN0ZXIgbm90IHRvdWNoIGJ5IGxpbnV4Lg0KDQpXZSBub3QgZmluZCBh
IGdvb2Qgd2F5IHRvIHByb3ZpZGUgaGlnaC1sZXZlbCBpbnRlcmZhY2UgZm9yIHN1Y2gNCmEgbWlz
YyByZWdpc3RlciBzcGFjZSwgcHJvdmlkZSByZWdpc3RlciBsZXZlbCBpbnRlcmZhY2Ugd291bGQg
bWFrZQ0KaXQgZWFzeSBmb3IgdmFyaW91cyBkcml2ZXJzIHRvIHVzZS4NCg0KVGhhbmtzLA0KUGVu
Zy4NCg0KDQpidXQgdGhpcyB3b3JyaWVzIG1lDQo+IGNvbmNlcHR1YWxseSwgYmVjYXVzZSBvZiB0
aGUgd2F5cyB0aGlzIG1pZ2h0IGdldCBhYnVzZWQ6DQo+IA0KPiAtIHRoaXMgY3JlYXRlcyBvbmUg
bW9yZSB3YXkgdG8ga2VlcCBkZXZpY2UgZHJpdmVycyBoaWRkZW4gYXdheQ0KPiAgIGJlaGluZCBm
aXJtd2FyZSB3aGVuIHRoZXkgc2hvdWxkIGJlIGluIHRoZSBrZXJuZWwuIFlvdSBjYW4gYWxyZWFk
eQ0KPiAgIGRvIHRoYXQgd2l0aCBzZXBhcmF0ZSBTTUMgY2FsbHMsIGJ1dCBhZGRpbmcgYW4gaW5k
aXJlY3Rpb24gbWFrZXMgaXQNCj4gICBzbmVha2llci4gSWYgdGhlICdyZWdpc3RlcnMnIGluIGhl
cmUgYXJlIHB1cmVseQ0KPiANCj4gLSBUaGlzIG1heSBiZSBzZWVuIGFzIGFuIGVhc3kgd2F5IG91
dCBmb3IgZmlybXdhcmUgd3JpdGVycyB0aGF0IGp1c3QNCj4gICAgZXhwb3NlIGEgYmFyZSByZWdp
c3Rlci1sZXZlbCBpbnRlcmZhY2Ugd2hlbiB0aGUgY29ycmVjdCBzb2x1dGlvbiB3b3VsZA0KPiAg
ICBiZSB0byBjcmVhdGUgYSBoaWdoLWxldmVsIGludGVyZmFjZS4NCj4gDQo+IFRoZXJlIGlzIGFs
c28gYSBwcm9ibGVtIHdpdGggbG9ja2luZzogSW4gdGhlIGNhc2UgdGhhdCBib3RoIGZpcm13YXJl
IGFuZA0KPiBrZXJuZWwgaGF2ZSB0byBhY2Nlc3MgcmVnaXN0ZXJzIHdpdGhpbiBhIHN5c2NvbiBh
cmVhLCB5b3UgbWF5IG5lZWQgdG8gaGF2ZSBhDQo+IHNlbWFwaG9yZSB0byBwcm90ZWN0IGFuIGF0
b21pYyBzZXF1ZW5jZSBvZiBhY2Nlc3NlcywgYnV0IHNpbmNlIHRoZSBpbnRlcmZhY2UNCj4gb25s
eSBwcm92aWRlcyBhIHNpbmdsZSByZWdpc3RlciBsb2FkL3N0b3JlLCB0aGVyZSBpcyBubyB3YXkg
Zm9yIGEga2VybmVsIGRyaXZlciB0bw0KPiBzZXJpYWxpemUgYWdhaW5zdCBhIGZpcm13YXJlLWlu
dGVybmFsIGRyaXZlci4NCj4gDQo+ICAgICAgICAgQXJuZA0K
