Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B79372984
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEDLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:23:47 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:6919
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229903AbhEDLXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDPvbSTFDkB+QG2wnN50wTJo2TMoEC4OPxtjv3GUFRhO214jYSk7XaslUjTDsIXZ/qHGoXTjxUMIZ4masMb+twK6JmK0DV0wQPaHGdLyyc+ppXt25pLqrRPwcrxKv2oXRKLJhpiGgFDgXZ3t3LRYdVtEBD/5Bek8Cy7vrEJwT523puVfa0vrzRZLZCrKm6dFvW9P82Rcx2KxoGe2vJn/vX+zTHLDB8dKQHd50rUcRVHZ2Jgk0QF1o2iSteDjU9siv6Wg4/E0pLKB8ZVIItik+s1o2E5KX5s3UB5htXJHVQlVce1L8RBfV7Q5L76RQk7kexjW6mLYODPFRvXAnW8G2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKo/FrhTur0NynfMbqP9HpYxZxTxfslgyYjpvVO5fQA=;
 b=dthI8IDn7KpCLIZggTRX11YKZI6tYMk8MvOTuZcHmk/qRJ01EK6Nv9Yap+yEWeowo9gWVrurLvgaMYdfaSuGfpB/zAAfIHhm9apAkEvaugKQDAZwlXPTW7wdUnsN4l9PoBuiBmtnYzt14vqBtJSBGyRn98MjeAkaQ9snZOQKhaeQZhWO73nILsIgIsZoM8jbRe0jds4ta3ceDqdPu9I7Yw4SRzKX2zToynVRxnUvW4DcXWElVdSeALL7W9NzILa8kBokfmW84ymSHQt39FUvGP0EPI99nmS9Rz9OGzsOGVhfOIfkyaHdJhPcnd6Y2MFXQGlGsgBi7DZeb/A7OYMXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKo/FrhTur0NynfMbqP9HpYxZxTxfslgyYjpvVO5fQA=;
 b=poDp8u7er7fCCjC3xug9lbSCkOvasHCdW3l9RhOE794uhf5Y2zI2PNj+wMAI0PgSm7+yrWB0fo6d7Dq7e7Wb5z2a93iaTaNfQmjDrTIw1yDF9FaLyKozthKAXGUyrWZFXM1u9EmzZ+cVAuOfPIBH/HXTVMNEYOFd863BnPt0uaY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3125.eurprd04.prod.outlook.com (2603:10a6:6:11::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 4 May
 2021 11:22:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Tue, 4 May 2021
 11:22:48 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V2 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Topic: [PATCH V2 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Index: AQHXPX0eRMyCb+5Z90CURUSnlReObarTMhSAgAACgOA=
Date:   Tue, 4 May 2021 11:22:48 +0000
Message-ID: <DB6PR0402MB2760F59F7230BEAC45C617B1885A9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-5-peng.fan@oss.nxp.com>
 <CAOMZO5A4JOP0zST75bO9Ww7pxJjJSYHE9HmWCJb7DjYYd-Y80Q@mail.gmail.com>
In-Reply-To: <CAOMZO5A4JOP0zST75bO9Ww7pxJjJSYHE9HmWCJb7DjYYd-Y80Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [58.223.139.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e9962b0-537e-4422-9da8-08d90eeef2e5
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3125A2D3A184787CE0856A1C885A9@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhVLI71bzlcrrYQf+83ZNliiXkV8ajiZjMKTrSCRhP38VOk+5yRrRHJr+c1L0SdTBGixghYx+P34/PlQX2auH1hPGTus9GTMgWfifsCnCMcPBgGTiu6cGKK4vQ6TDe5oGRsRgJ5B3vKJNAnYk+/uFRtenqGKB0yLvos1VXkjgFSPL+TNJMLWtNF3be4E+AYsQMN3ip2qOrz/ldUk09RWYMtlKN9NwuW4WoxdF04Zvzn7qDGyNXNxlxQqUVsmk5SXR3izksl511JXQZXTcr8hiWvyLZ7m9bSSoqoleb3akft5yAl4vPitdZOZhF52LHm9vFvpFSXSkaJX7N+btPoMvCPeE2II9ZnEU/Jip150+T3Rc6m9rR7G/RPve7N4rXrWZuWNOjPFHkw0TQAJUr8VYtauJBflLNchN8Nf9N3nDLuH4EMdVprsR9Q5ZMwExyHcZH1AkKO1gNs/enEvoZW7ghcf4fs3ITgw7NES9tIcmc0B+sKLrv8afdZosfJ6VzNpCN+THd154MuI8sTdlVjE/t1B9mUWvsxG7KTHj/MMhydLP5u9VdpqTOruMCwvcJi4qCZ4xivZN+VLI0eQUq5htL3qAt7i2lBCD1N4Y8OjjD4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(110136005)(5660300002)(52536014)(76116006)(54906003)(4326008)(44832011)(9686003)(33656002)(8936002)(55016002)(53546011)(71200400001)(6506007)(316002)(122000001)(478600001)(2906002)(7696005)(66946007)(8676002)(66446008)(64756008)(7416002)(66556008)(86362001)(66476007)(26005)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TkRwemQ2Yk1PakpqN1B1WGQzY1pBSU5EK1RqbHFVMkw3OEpVNUZkejNUMHF1?=
 =?utf-8?B?SlJsQWoxTVB5S0tvOHpWYnN4ZjdBclIvMjFRZ0JzS1NidTU4bVhMbEY3dG9X?=
 =?utf-8?B?Y20zV3NNZ0N5b1dmV1Z3Z2pHKzlhanJqTy9MaEZlQktFOTl3eDlIc3hOSW1s?=
 =?utf-8?B?TjRIZFRnd1ZvZTB6NmxzdE9UOTU2NU9ZM0lCN2VqR1htem9YbWNCU25GbWJX?=
 =?utf-8?B?cWVnZnJLZHo3REpJYks0ODhWQ3pxeXptY1NSYlhjQmtsbVhzSlpONnQwTW8y?=
 =?utf-8?B?aUpsb3ZPSjZ2MHJHeHNFaVFPWFVYVGpPd0pmME1IWmhyNWhaNzJXeGJ2MzZK?=
 =?utf-8?B?alhJK1Qwc1NHendMU0tTL3phTVRYNWM0SmN0a3cya0VuSVNCUTgvczNycXVT?=
 =?utf-8?B?V21lOE1Vdm8xZUJXUkY5d1FwL0wxcW5WQXpiSnN3ZVJnbUZxbG9abFJGZDF1?=
 =?utf-8?B?Z2FOR1h2WERUYUhyZ1NSc3BoL1VVZEthR0RhbW1KVnRmSFd5QzRCMTViR0Ja?=
 =?utf-8?B?ekhlRkVkemFpUjkwbzlPYUpGWUV2cU9MeXByR2lEUktqVTRYN1IzTzIxL2ZH?=
 =?utf-8?B?ZkFUZmJSRTVvUzhBQjMzQ0NmL1didDJEM2hFL3cyME4rUzZicTloY3d0N2xh?=
 =?utf-8?B?d0VFOFlwdFJiNDRxRHRLSmh3M1FvWHJZMEJNa2krTWJuYXZDeFA2MDdhSktn?=
 =?utf-8?B?RldtbDRiUHVtUGRLMjNKN2UvODBlY294RDBVeXBKVXdmNU1xR05jZW1wQmNR?=
 =?utf-8?B?eE44QkhPUFJJV1gxcmxCTXl1UURTSEQvZlB6dDFMTGY3MzVnNEYyYkJQWlN3?=
 =?utf-8?B?NHZyYktSK21mZll2YUFpRG9sZ1lxb1RzMWVxR2pFSUFmcmUwcTRRT29TZkx2?=
 =?utf-8?B?dUhzajhmRVBNUEkrWFNST3ZOQUhFY2padU1teGZMOHdRUThTTTlmZm5VSy8z?=
 =?utf-8?B?UTl4bkdSZGxaZ29tR2ZoMlF4UW1HejV2WnJPeU9YOG9TczREZFBqL0tIaXoy?=
 =?utf-8?B?UXVaWHRxdmlnYXhTa0tOdms2akEybUs2UllnT0lzY3ZIMjFQbW1PL3BoOS9w?=
 =?utf-8?B?TUlCUk9YV2FURFFqaHA3K2hpbzRheGx5QlltTVBaRzAzdnhJalowaFNyOGxK?=
 =?utf-8?B?cS9IaC9EK3I2M1Q5Z3JXcVdycmxJRTZUMVlYN0ZpeEZEQ3dwK01Na1VrTkhk?=
 =?utf-8?B?dHdSTWpqbDJrb2sreDlWaW0zbFBTaXd4N2ZlVU5HNnV1TUtVenVvM0NPY2JM?=
 =?utf-8?B?dVhuc2JIaGJaUGtLZnpqcmxqTWhrcG83TlE1akd4U01hY3NJUzBBamN6a2tM?=
 =?utf-8?B?TW9xMXdaTTMvOGVDdE1rb3dqVjEreEFwRlQyZjJLOTAzNmloZllzbVpyRVhI?=
 =?utf-8?B?NEpzdlJ0cDdIaEwyakRETDFxUlV5TVBGR1FsaWVPdy9xL0M1Q0Q1WmpWMGtV?=
 =?utf-8?B?akJDQ2MxSi9NcVRJY0V1M1NpN3JXR1hTZ1k0MUNkN0IzUVFtckduZFl5eHRs?=
 =?utf-8?B?T1JDUGRXWmpzS0xRL2MxLzIyc3MyUFBkeWh5cGZ6bjFOdTh4WFN0WG0wRS9E?=
 =?utf-8?B?SllORm9TRmkxdUwybGdtc2x0ZmVWZklWQnJQbStXcGNjVHZzU0RuK2JGbW5U?=
 =?utf-8?B?MGp1U2tjd2ZaV3hraEllMVYvUXo2Z0lzcC96UHFsWVpXQ21LaElZVk5qS1I1?=
 =?utf-8?B?bEkybUFpR0pOM1A3cHJGUGt4UDNpOVdGVDhIb1VQOU9LZXhBZmR6eGVGUU83?=
 =?utf-8?Q?LXLul/AcD1O2+sJJ9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9962b0-537e-4422-9da8-08d90eeef2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 11:22:48.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIZ0jXbHWO0YhJ/f+CJ9HMgMIyqqWfhoKFa+dxy9N8768Ihc1UspR7TtCwyxEUGUEdqsJ1kM31Ew3NmNic17yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDQvNF0gc29jOiBpbXg6IEFkZCBibGstY3RsIGRyaXZl
ciBmb3IgaS5NWDhNTQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIEZyaSwgQXByIDMwLCAyMDIx
IGF0IDE6NTYgQU0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90
ZToNCj4gDQo+ID4gK3N0YXRpYyBpbnQgaW14OG1tX2Jsa19jdGxfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikgew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBk
ZXYtPmRldjsNCj4gPiArICAgICAgIGNvbnN0IHN0cnVjdCBpbXhfYmxrX2N0bF9kZXZfZGF0YSAq
ZGV2X2RhdGEgPQ0KPiBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gPiArICAgICAg
IHN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gPiArICAgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVz
Ow0KPiA+ICsgICAgICAgc3RydWN0IGlteF9ibGtfY3RsICpjdGw7DQo+ID4gKyAgICAgICB2b2lk
IF9faW9tZW0gKmJhc2U7DQo+ID4gKw0KPiA+ICsgICAgICAgY3RsID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpjdGwpLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghY3RsKQ0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgICAgICByZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+ICsg
ICAgICAgYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+ID4gKyAgICAg
ICBpZiAoSVNfRVJSKGJhc2UpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihi
YXNlKTsNCj4gPiArDQo+ID4gKyAgICAgICByZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X21taW8o
ZGV2LCBiYXNlLA0KPiAmZGV2X2RhdGEtPmNvbmZpZyk7DQo+ID4gKyAgICAgICBpZiAoSVNfRVJS
KHJlZ21hcCkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHJlZ21hcCk7DQo+
ID4gKw0KPiA+ICsgICAgICAgY3RsLT5yZWdtYXAgPSByZWdtYXA7DQo+ID4gKyAgICAgICBjdGwt
PmRldiA9IGRldjsNCj4gPiArICAgICAgIGF0b21pY19zZXQoJmN0bC0+cG93ZXJfY291bnQsIDAp
Ow0KPiA+ICsNCj4gPiArICAgICAgIGN0bC0+bnVtX2Nsa3MgPSBkZXZtX2Nsa19idWxrX2dldF9h
bGwoZGV2LCAmY3RsLT5jbGtzKTsNCj4gPiArICAgICAgIGlmIChjdGwtPm51bV9jbGtzIDwgMCkN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGN0bC0+bnVtX2Nsa3M7DQo+ID4gKw0KPiA+ICsg
ICAgICAgZGV2X3NldF9kcnZkYXRhKGRldiwgY3RsKTsNCj4gPiArICAgICAgIGN0bC0+ZGV2X2Rh
dGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gDQo+IE5vIG5lZWQgdG8gY2Fs
bCBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSB0d2ljZS4gWW91IGNvdWxkIGRvOg0KPiANCj4g
Y3RsLT5kZXZfZGF0YSA9IGRldl9kYXRhOw0KDQpGaXggaW4gVjMuDQoNClRoYW5rcywNClBlbmcu
DQoNCg==
