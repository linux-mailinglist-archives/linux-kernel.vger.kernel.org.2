Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9E3BC8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhGFJvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:51:20 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:14150
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231159AbhGFJvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMAY7RMx6TwgGRPmsyTK9c/B1MUPoPtj6IVMDWcRs6rxHTholDAz06uLYM0TsF0W8M97Rls+CdaU/YYFsyD6apEpesoGPaH281N8MrTZOu15fV/wmBl63zaeRKybHSEwdnFHOcmLw4vPoumkipqzVcOizbftSMsfMk/ArWfZvNx72O59QGOKPB/p3aj9/1CRhQhTyScD6+0I0J/WU8ZmHgT7H7s7DDOu8Y87HAOSdcbTQ/zsVRtPVtquL1DlUg2N7B1Wr9XzM5Xl1C9L5SLVORVPpAS1oVsbSdaZ8Zig1WMBkA3/Ols0dvtvNmcd42tbDRdOQsTV1SxGtN19ktfzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXRFJbJ0Pq6spil27GGHUbjyNQmNBwOVBMoBNWKTtog=;
 b=MBTw/2Eb+x8J3aTQsRw9A1Rr2GyeTnsvToaRNr16t/p8XBVIF/5ld8RTb8TwRgO/QBXYfGwjRM4x7JMX1+i0z3VesJV5g/v7IBTPzJ7ctDQX6qkr1v6L/0flHFttxykp33cTLhdq1uRL6WBf8eFuYOZZWlUgbWIlMseBjWLf8s8zjzRq7eGyemkWEK4GJpZoZoruwgIxqCD8dGCu1OQM0Z4yLAmq6pAsNtVo2Sxd93UYGsbsVVepuVcArFp3dQIdR0oVpaupXyVtIur4BHhX4A4QGk2Cc+CSZ8UPeN3W1CzB525SP1D8mejq4rSRZZYojee5YkuozJhI5DBM8VvZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXRFJbJ0Pq6spil27GGHUbjyNQmNBwOVBMoBNWKTtog=;
 b=fjdQatmxc/wsquVMnTJbZ2w/q4Q2NIPvaeZYduwBRikf324bMjoMElSxgQ9T5pAgFaTeEyww7a2YfyFYMtw+I6o5ui22bVy0zCSUeyG2iGatU5D+z+4k1u0iYYYfCMMobPy4DgybRbJrUKLyKMIRNTT1A4Ah2sTMHgEpnp6WtNo=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5883.eurprd04.prod.outlook.com (2603:10a6:10:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 09:48:38 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::f5e8:4886:3923:e92e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::f5e8:4886:3923:e92e%8]) with mapi id 15.20.4264.035; Tue, 6 Jul 2021
 09:48:38 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
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
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Thread-Topic: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M
 platforms
Thread-Index: AQHW9JtY/Flb1M5HB066RDaFAFubB6s2l3KAgAAW5jA=
Date:   Tue, 6 Jul 2021 09:48:38 +0000
Message-ID: <DB8PR04MB67958A087F20D46867066B2CE61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
 <a35ea181-4beb-31d0-dd97-6d587b642a6e@huawei.com>
In-Reply-To: <a35ea181-4beb-31d0-dd97-6d587b642a6e@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e541e93-efbd-4e44-a34e-08d940633b00
x-ms-traffictypediagnostic: DB8PR04MB5883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5883802B3F1A8D3BA7C702B7E61B9@DB8PR04MB5883.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7Shaqj+H8xkm7fruGD9K4UxOse1kdIAef0CqEaK15ocMjbxh53OAowY7iyQm7WXpvS9duFK/InmwWqgVCFwxwBLtm01mlsqxqEesHIpZS4WpuPdsQWobkcT1R9rjuPTsbaUxQy8IepRNZyRzMXalCa6+xLSmG+yC0lOUJk7W6Ltka01X+DF6jy2atAmkw5WwmEEfDTf4GFi6Oe+Gc7GtxZcEmsaAnC8tW2yRWq/YwEiNi23lqOvH5i/1PJRIBPqOFo5WApLD1RGtuKgHfqLPSAjA9T+38zcQZ8RrDt/4vzdko/S56DzETigmazVZCEWhfcOkQQt6IkmsA8J/yRDv/S0JeTIhU9nm6H6/V5m1/xp/G6CN45AykvBUQck42rL9ND0LzRSRd0V8zFziPw3tjtjZ3yVPQyt+A3rtOWneI6NU3KlREI8HavuaO+bB85RqhfakHNoZlmCeDov/Rg3F9tdFWDVlIk8uyKt0NNqtz0TTF5FhGc0kg2xruwy1KehcAoJGDNCuiTSqffe0FzZo5F3+UyxTf+mUXX0PXYo+9G1HRgD7IjD5Sngv/h/+LOAi5nfX80eG5cNlXOCb5WoBlsr8yCYf7m/KKlQGh+PpdClsbKYftOkdvlOsDUMX7lkdzdCPlPtdbVcQ/HY2V8h1sJUBPWiVGRtm9cO0TIUE+ZraFCDm6n4B/GFiUBDkilDItr8HOMf+yTA3F1Nu4L74Bun2tFeO+UNhQgu0Um+cq+GcJ67l7965+zXT86WmLekz3EguQyjB9LHU1TKfKHKVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(8676002)(186003)(5660300002)(71200400001)(6506007)(33656002)(53546011)(7696005)(921005)(86362001)(45080400002)(66556008)(66446008)(66476007)(55016002)(64756008)(966005)(2906002)(9686003)(7416002)(316002)(110136005)(122000001)(478600001)(83380400001)(76116006)(38100700002)(52536014)(8936002)(26005)(4326008)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UDRUTFoyaVhVTXJGeXRLbkRBUDc3a0dvSE5uYnlIMFpYMTN4eS9sTWpTekpx?=
 =?gb2312?B?QVJpMUc1ODg0SGFxdHJwNnMxODJpVFhTaklIOStDWHphdFRkTUNDekozWitn?=
 =?gb2312?B?d2E0RUt3V2JlMUh2bDVBbno4S3Ewclc2Rk5uYjRaaUsxZHIrUDd1eHF3bHJa?=
 =?gb2312?B?bDZ4eEU0WE1tVXU2MzJDZUNrb253b21EQUhSUWdHd2tIRGRJVnREWm5tbXlv?=
 =?gb2312?B?eTBMZHBncHR5Z1p2TjhiZVVnZUd3T09ZeEdWazF4L0lEU2xXRjNkS2VaTVI5?=
 =?gb2312?B?VEhtTm85RzI0aVpVSldEVmNiSEdUekJKdkFOK0ZXRFV0STZSeFJ0cFU3TStB?=
 =?gb2312?B?N1hWczhEaGh4dGE1UzM0TTRoTHVmUTA2REQxV1dBV1N4N2xNSk9NNXh5WERs?=
 =?gb2312?B?MzJiSUxUOFpkbXB6dkg1aytIcW04bUZ1WXdkYUZkQ05uNW5jY1dkdWlKZWkr?=
 =?gb2312?B?RnpLKzRlRElhTGMxMVJ2Y2k1OEtsMmJyYkJFR1VGTUtqb2thS2ZRdkc4Ykha?=
 =?gb2312?B?K0VtTDhGOVcvaUdReXc1WXNHenM5OHAxVXNSUk55dEcvQlkvcnV1KzgwWjBx?=
 =?gb2312?B?UVpxMlk1VXhqZE5SRnloMWNFajZWMi9OcmlhNTkzOTlQZ0tuYkMxSWdHTHBw?=
 =?gb2312?B?QjVIS3IwWSs2VVpzT2pvMVZCUDJZNW9HQkEwOXRRaU80eklGRytISzlIeEZv?=
 =?gb2312?B?NVhMK255eGZaMm9OMXcveHlwUVBNdmVNNG9XRXBvd1hVeG50V0NEVnJYUDdI?=
 =?gb2312?B?azljUzVQbWovWTd2RWdBMXE0UEdpSUhDUUxyVGl6OTZKU2xONG1lNm9KSTlv?=
 =?gb2312?B?QVVCc0pEV0Q3d3Fjc1FvQkpNSmk5MkVFQXdQS3hLLzNveFJoNlZraTZjclB6?=
 =?gb2312?B?RlZPRkxUUnd3YUNVNTJpR2UyL2cxdTErNW1JTlhNQlpYK3RmMTZ4V01qcTZR?=
 =?gb2312?B?NXhxODFCUys2ZnQ1Vlh0Z2VGak1sYkVxZEhWbWNaU0hQZkp2TElVcVNlNlMy?=
 =?gb2312?B?TFViYmJESm5Md1hWZEsyWEhnN1IzWXp4YUlOMTdtUFVzWHZMM1JZdzU5YUQ2?=
 =?gb2312?B?TDRhVUtsYUd6QXFHUjlReVYvZm1tb2k2dFlSRmlCRDlQQmdoRGRmWTR6UkEx?=
 =?gb2312?B?Vy9BZFpDOFZ0b2ZvYnJ3Z3o2NmdYa2EvbWxJOFdkVmpmbkhYbVNQS3NSejk0?=
 =?gb2312?B?bHFPZkRKUUlhSGtpRXNHdnZHQWh1LzM5VnhwV1NrM1ZNQ0xheFNiNUlrM1Yz?=
 =?gb2312?B?dTB4Ykt1MGE0b1lPZjRjRnlieHZqNFl0YVYxVGZQN3g2SHpOc1UzZWgvSVNx?=
 =?gb2312?B?dmsyRTBzQlQ2RHN5REJJNktNTUlZS0tNZDBYQ2xDN3hqZjkvbWc2UXBORU4y?=
 =?gb2312?B?Ym9tamVPSkhoWnlXUVUrTTdJNzRNMnovK0ZYdG4yLzZqQ3ZZc0RTRXJ5bzRD?=
 =?gb2312?B?N3dmc2czRlVzbGdQdHpHNVpCeDU0WW01LzlHemNDaXJPYUdZWVlUMDUrT2lQ?=
 =?gb2312?B?Y2h5L1dTdHBGRTRYWDZzU01rYVJQdHI3ZStUY1NBQU5XRVpNWmw5SG4yQnlO?=
 =?gb2312?B?M1VHemZBQktvcDFzVnR0b1FyMXRyZnpkM1dwN1J5Q1pHZjlwcFcxS2hpcVZB?=
 =?gb2312?B?MHVFclFFMncrNENYUnF0RWVqZzA3K0lGUDNrRmZlTTRVcW9TaFBPL2QvaXBP?=
 =?gb2312?B?TVZHbi8rM2FjanhPOHdWUHM5eVhFdFkzQWE5WVpNQXk2ZFFMUWwwNG55Q3hk?=
 =?gb2312?Q?nbQF4QHGx9J66nvnJdrs2Mck8j1CGUsZbsBq+ps?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e541e93-efbd-4e44-a34e-08d940633b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 09:48:38.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFNoHpitDBQrv1xf4/mzz39hgB86Rm+rMRLInOomTAuG7MyQS05PcDjNue42RmzjCS0L3E5D2K51snCLMnfUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5883
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMcTqN9TCNsjVIDE2OjI0DQo+IFRvOiBKb2Fr
aW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgd2lsbEBrZXJuZWwub3JnOw0KPiBt
YXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZzsgbGVvLnlhbkBsaW5hcm8ub3JnOyBwZXRlcnpAaW5m
cmFkZWFkLm9yZzsNCj4gbWluZ29AcmVkaGF0LmNvbTsgYWNtZUBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsNCj4gYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbTsgam9s
c2FAcmVkaGF0LmNvbTsNCj4gbmFtaHl1bmdAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBr
amFpbkBsaW51eC5pYm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MyAwLzRdIHRvb2xzOiBwZXJmOiBBZGQgSlNPTiBtZXRyaWNzIGZvciBpLk1YOE0NCj4gcGxhdGZv
cm1zDQo+IA0KPiBPbiAyNy8wMS8yMDIxIDEwOjU3LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4g
QWRkIEpTT04gbWV0cmljcyBmb3IgaS5NWDhNIHBsYXRmb3Jtcy4NCj4gPg0KPiANCj4gSGkgSm9h
a2ltLA0KPiANCj4gSSBoYXZlIGRvbmUgc29tZSByZXdvcmsgdG8gdGhlIG1ldHJpY2dyb3VwIHN5
cyBldmVudCBzdXBwb3J0Lg0KPiANCj4gSWYgeW91IGhhdmUgYSBjaGFuY2UsIGl0IHdvdWxkIGJl
IGFwcHJlY2lhdGVkIGlmIHlvdSBjb3VsZCB0ZXN0IHRoaXMgZm9sbG93aW5nDQo+IHNlcmllcyBm
b3IgdGhlc2UgaW14OCBtZXRyaWNzK2V2ZW50czoNCj4gDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jDQo+
IG9tJTJGaGlzaWxpY29uJTJGa2VybmVsLWRldiUyRmNvbW1pdHMlMkZwcml2YXRlLXRvcGljLXBl
cmYtNS4xMy1zeXMtcmV3cmkNCj4gdGUtMyZhbXA7ZGF0YT0wNCU3QzAxJTdDcWlhbmdxaW5nLnpo
YW5nJTQwbnhwLmNvbSU3Q2JmMzU1MTcxMzNjMw0KPiA0OGViZDU4ZTA4ZDk0MDU4Nzg3NSU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzANCj4gJTdDNjM3NjExNTcwOTky
NzYyNzk4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQQ0KPiB3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtz
DQo+IGRhdGE9UnpOYVhadWJUcmhPME1SbDJzRDQ1djdWYnMxS2d6UldDUnltVFFJSkxaTSUzRCZh
bXA7cmVzZXINCj4gdmVkPTANCg0KSGkgSm9obiwNCg0KSSBvbmx5IG5lZWQgYnVpbGQgcGVyZiB0
b29sIHdpdGggYWJvdmUgY29kZSwgbm8gbmVlZCB0byB1cGRhdGUgdGhlIGtlcm5lbCwgcmlnaHQ/
DQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiBUaGFua3MsDQo+IEpvaG4NCj4gDQo+
ID4gQ2hhbmdlTG9nczoNCj4gPiBWMS0+VjI6DQo+ID4gCSogcmVtb3ZlIGJvYXJkIGxldmVsIG1l
dHJpY3MgKGJhbmR3aWR0aCBtZXRyaWNzKS4NCj4gPiBWMi0+VjM6DQo+ID4gCSogQWRkIHRoZSBt
aXNzaW5nICJTY2FsZVVuaXQiLg0KPiA+DQo+ID4gSm9ha2ltIFpoYW5nICg0KToNCj4gPiAgICBw
ZXJmIHZlbmRvciBldmVudHM6IEZpeCBpbmRlbnRhdGlvbiBvZiBicmFja2V0cyBpbiBpbXg4bW0g
bWV0cmljcw0KPiA+ICAgIHBlcmYgdmVuZG9yIGV2ZW50czogQWRkIEpTT04gbWV0cmljcyBmb3Ig
aW14OG1uIEREUiBQZXJmDQo+ID4gICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBBZGQgSlNPTiBtZXRy
aWNzIGZvciBpbXg4bXEgRERSIFBlcmYNCj4gPiAgICBwZXJmIHZlbmRvciBldmVudHM6IEFkZCBK
U09OIG1ldHJpY3MgZm9yIGlteDhtcCBERFIgUGVyZg0KDQo=
