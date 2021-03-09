Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE1332F10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCITea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:34:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59738 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCITeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615318461; x=1646854461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjVqqWTezZuORo9vvRsSMPqMaDRtxt8xkfZtEYoYVK4=;
  b=HxoiZGtwgE0jETmgEvcwMyh9T7bDFNgcJNTYJ86ul9AOH0eAzw3nv+QX
   ES3k7agYkSrpv1zAuaeYq4CZ2UfMfoKtcCMsf+iMOvs0OKymgiIImygEq
   yjd3DkciazdhB2fYA2vy8TwPxdAsRYOMHrDNn10S96pAbFAO0HLixVNgN
   aBnx9sypWRBfy85g9Ox/u55VZ2TYo6C4JbgJBv3c0SSg7fJBruic6i+Ci
   9cp9mDHScoXZjspg5lT5EEJSRiMgk3d5TdIZrVnKPG4xWUK1lW0dpUdZc
   ZzP4CKL3AV24TFrN5szLXHC2BNU9irhfuLC8H918VIUeAIvpmtYAg7Gd4
   w==;
IronPort-SDR: aZCp1y73aWMth2iA+8erYofpJt4TjIXD3Kl7ItTcq47s+l7B7trTtTmjJ/Sm9CkmB4g1o2+ghr
 oSDJC5T55fmY2EjVBAMs3bufN8xhLwzk2Bxor7DAYmY60m7o11dnd+mJ0ZJKajOASauhPTG4Ra
 Sn2rD3zgp27jffEfpGA5bOcmbZ4OjK9U7gNslRUWFgyGfx/L+BNK63PZd/7XZVvtxMb4JHH5Co
 07q0CIUU4Nw2BzqSzZ3Dj+StgEKXSXV9APIX4GuWyga5dXqiKhLczJwimBQ4OGft8fy/cTTfGf
 yq4=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; 
   d="scan'208";a="161766736"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 03:34:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrN6bAApEUU7yvp7Cir2qF9ncdNns2Z2cYRoRZctYNWiSM8ldDOqmte4A9gVOWswWxtMymLRUlYD7aYc+Dk4Yb7xoCz4rvE43Z547MqhGe0T/pRDv8+F00e/QS5Tq3v8kYqvUhQNPlMzZPBubT16kKkExj2/cxIYK/Nr67QF0kmKfXZFVTYzXp2bcQWjgcqOcVw/cJSARziGU2THu4iA/ctBcVP8UdmGpSv4mQvZwFw/Hd8YCDRvfT2EC7x9x5jUQutrQrZ5wSD8J8DrOgHisxEiSm9lLvKVukJWMQq2//9fPPxViQH91jl6ekJj0h9yNSPSvpJVw2hst0E26yyO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjVqqWTezZuORo9vvRsSMPqMaDRtxt8xkfZtEYoYVK4=;
 b=LYLi/hyL4zTPnGM0E3SqKXUurS8tYpB6+RMZM77znxKYtD6OypsPx7jrZhgOhW7fbCqJ0SNvitqs0/sW3U8ECPjOpEADc3PsZ8oegOQwfkuK6RlSuXKXtQFPL7snPG50ikNNM5ieoegOB+R8/GTZxE487a+a/e8OQjBinrFsL3GBKzW1/5i455LuZeKGMfGOFQe89BhaAOz5EKrq4KJvhWfOvRHKWxyi8d52FIS/tXJ49I/YHnTWFWTnvAPT8+YywA0ysMnU0Bd2HwL9Lz6xPv8xzCeICHo+hq9L7kkKG/JrC4GQS11h5E/2hqo2D3P4r0vutcuc0m7FQuQuowF8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjVqqWTezZuORo9vvRsSMPqMaDRtxt8xkfZtEYoYVK4=;
 b=blYe5l7xIFWdKLh9LljT7FXR/W97WCckZ9Cy8D08BGIbzKudl27ZHVDB2L0oYjsOZ/oMlWhr7q30zbSEAK0TgFRHlecbORg+jhEzLCfAOYXas7Slxb70lGDoOV3SfFiMUx1OGgj2tgx6zxEj4iZ6rnxA4taKGJd3pn1t/ursJ+w=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by SJ0PR04MB7614.namprd04.prod.outlook.com (2603:10b6:a03:32f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Tue, 9 Mar
 2021 19:34:17 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::ec3e:7abd:37a1:eb8b]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::ec3e:7abd:37a1:eb8b%9]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 19:34:17 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "Lewis.Hanly@microchip.com" <Lewis.Hanly@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Cyril.Jean@microchip.com" <Cyril.Jean@microchip.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjorn@kernel.org" <bjorn@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "Ivan.Griffin@microchip.com" <Ivan.Griffin@microchip.com>,
        "Daire.McNamara@microchip.com" <Daire.McNamara@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
Thread-Topic: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
Thread-Index: AQHXEGjIqKITvaSpSUqD3+T0zlVHB6p7hPiAgAAq5wCAAGWxAA==
Date:   Tue, 9 Mar 2021 19:34:17 +0000
Message-ID: <07d76b634a675b7559f471d419935b88e2ce36aa.camel@wdc.com>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
         <20210303200253.1827553-4-atish.patra@wdc.com>
        ,<e97e6dd6-fcb5-fac1-41e2-534f524bf5d2@codethink.co.uk>
         <DM6PR11MB3770E7FA8121AA91D9EDC4FEE5929@DM6PR11MB3770.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3770E7FA8121AA91D9EDC4FEE5929@DM6PR11MB3770.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3 
authentication-results: codethink.co.uk; dkim=none (message not signed)
 header.d=none;codethink.co.uk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [99.13.229.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 360d6cf8-af8e-4647-c2cf-08d8e332547b
x-ms-traffictypediagnostic: SJ0PR04MB7614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7614123E3FCC830AC1DDC2DCFA929@SJ0PR04MB7614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VIXk7epV7prWLcvtXe/TGgNzbWt+angvrDeCEMZIman4hmmHMy5lGm8uNcDHZbY+tv3KQnKK27gJydbLGB85qudt27dun0IFJKwD4bYHfpjOo3W09anLWTaa3po3GblGW1CnrIaIAanst/0JwayvGFB6gbIZF54U8iy5NTvBlIc5u8P+Tj4YkCJmz78Agi/SmXuW6srEXcJaItYwnGcrQ8aOz5oED+D+nRyDBHLBTltrhxJVwVMYN+2m/r3P3ywjI2Q+O0s7S83M4rHP3uyI2VXm0LXrjh/rM67IykeohjWsAqsVINeQLrtuv0VI2xpGx82HMO2KX52j+dnps+6uMjgeUtqFpVHFErtQpWdCf4z54QUn7MxjOeei2iAwIfNKZXKqJCOeh1XPYwOreklQKMBp1Ef/BM22hnGh17pjpQwz8/TgC/q/4ih4eW0gN3ZwVy7qJS7D6ST+U7+ce+vppRaf54TVEgiTc5dAM599nolJj/1NQZO7SUj24IUJ9zfEyUwfm6xa3/i48Su5hPzsdqHkvKFTgmn9GfcKWl7MAI5gNlAPK7/8aI5Q6gvBkySCnn9Zxoq4qrZbCN7dRJ5h3KqJlwwzzABMKAzoka9iLy0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(966005)(54906003)(110136005)(316002)(4326008)(8936002)(8676002)(53546011)(6506007)(66476007)(5660300002)(36756003)(478600001)(6486002)(2616005)(71200400001)(66946007)(91956017)(76116006)(66446008)(64756008)(66556008)(2906002)(6512007)(7416002)(186003)(83380400001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9QfCWQMlWOqip9h6q9hJWXjhpXOZHRa/15wMGPLQ03I9zy9TzM7eCAtFRoB2AIAC7KTHzP0zHkwN/K4R6R96NYN1gCulB8+FiYhUDJTAjYT1utiAYxf3tBaBdFYNC7cXVR2pPcWC5SO0KvNQ9rlYOkQ0E3+1D0mnmBhbF1kNXM5hdDhpLQwx+KIcjWftTwDk1sljAbrGVJb0qitt2iSzBNRbDtcPDfiOG2ycL+M/oxTSjyc7JKvmU/fV2CtJQGFWtYkRhfFNmd4dnWh/wj6L9HUc6XpXfyeh6Wx101TOctqfWJACBsFUPuAIZ2avLWcV4UCUyz4MqdKY1iJdFFQxb5rRKmat3w8QfSd7q1hg723cKsXZo6VVQXCkZV2ui8K/Mk7eZouNDDzmhKHBMRUyqSj+3a1tfi8DIbfV9y9Mbiav3rSOKQm6o47/GLJQosI0tbPCzS0zfrZjVCgteFs0f6OFD2etheTIoirDvh1gOEyTUKbeOYDunq17OYos/eehc+puJAlVC9g0/vXsOVLqkw1zKwhiZyFGFV+3+cEr/SxcqnImKd8s4/XPX6i96dMrIwDWOKOTsVvUNqqVY6578J90yADneHvRZMioXIiQoqK03P9FiVdSSvfJB0AlDmx0CHLfJWHIsWA5n7r4LIElVty63G+0bylDd0H1acqhiFme8y5LUjHGJWBq9GnBa6GUT9nYnR2J0QaQZpUV0QplY7dUwYG0Ymxu2fIPzBizdZkfogf56YClvMrV84+ISWpu
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA607141980C0E43BB3482D8C07C7A0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360d6cf8-af8e-4647-c2cf-08d8e332547b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 19:34:17.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MX1WWBfXGJ2aVsz1gNsFtQRi/R4Sun342os7kNe1lqMQD5P7G/Y4eaNru9Gqk0HSMCLhr3wAflNpYAAsJFokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7614
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDEzOjMwICswMDAwLCBMZXdpcy5IYW5seUBtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPiANCj4gDQo+IEZyb206IEJlbiBEb29rcyA8YmVuLmRvb2tzQGNvZGV0aGlu
ay5jby51az4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggOSwgMjAyMSAxMDo1NiBBTQ0KPiBUbzog
QXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnIDwNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IEFsYmVydCBP
dSA8YW91QGVlY3MuYmVya2VsZXkuZWR1PjsgQWxpc3RhaXIgRnJhbmNpcyA8DQo+IGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT47IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNvbT47IEJqw7Zy
bg0KPiBUw7ZwZWwgPGJqb3JuQGtlcm5lbC5vcmc+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZyA8DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbGludXgtcmlzY3ZAbGlzdHMuaW5m
cmFkZWFkLm9yZyA8DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc+OyBQYWxtZXIg
RGFiYmVsdA0KPiA8cGFsbWVyQGRhYmJlbHQuY29tPjsgUGF1bCBXYWxtc2xleSA8cGF1bC53YWxt
c2xleUBzaWZpdmUuY29tPjsgUm9iDQo+IEhlcnJpbmcgPCByb2JoK2R0QGtlcm5lbC5vcmc+OyBD
b25vciBEb29sZXkgLSBNNTI2OTEgPA0KPiBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbT47IERh
aXJlIE1jTmFtYXJhIC0gWDYxNTUzIDwNCj4gRGFpcmUuTWNOYW1hcmFAbWljcm9jaGlwLmNvbT47
IEl2YW4gR3JpZmZpbiAtIFg2MTQ1MSA8DQo+IEl2YW4uR3JpZmZpbkBtaWNyb2NoaXAuY29tPjsg
TGV3aXMgSGFubHkgLSBNMzQ3ODIgPA0KPiBMZXdpcy5IYW5seUBtaWNyb2NoaXAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDMvNV0gUklTQy1WOiBJbml0aWFsIERUUyBmb3IgTWljcm9j
aGlwIElDSUNMRQ0KPiBib2FyZMKgDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPiANCj4gT24gMDMvMDMvMjAyMSAyMDowMiwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+ID4g
QWRkIGluaXRpYWwgRFRTIGZvciBNaWNyb2NoaXAgSUNJQ0xFIGJvYXJkIGhhdmluZyBvbmx5DQo+
ID4gZXNzZW50aWFsIGRldmljZXMgKGNsb2Nrcywgc2RoY2ksIGV0aGVybmV0LCBzZXJpYWwsIGV0
YykuDQo+ID4gVGhlIGRldmljZSB0cmVlIGlzIGJhc2VkIG9uIHRoZSBVLUJvb3QgcGF0Y2guDQo+
ID4gDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNo
LzIwMjAxMTEwMTAzNDE0LjEwMTQyLTYtcGFkbWFyYW8uYmVnYXJpQG1pY3JvY2hpcC5jb20vDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+
DQo+ID4gLS0tDQo+ID4gwqDCoCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL01ha2VmaWxlwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gPiDCoMKgIGFyY2gvcmlzY3Yv
Ym9vdC9kdHMvbWljcm9jaGlwL01ha2VmaWxlwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArDQo+ID4g
wqDCoCAuLi4vbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzwqDCoCB8wqAg
NzIgKysrKw0KPiA+IMKgwqAgLi4uL2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5k
dHNpwqDCoMKgIHwgMzI5DQo+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gwqDCoCA0IGZpbGVz
IGNoYW5nZWQsIDQwNCBpbnNlcnRpb25zKCspDQo+ID4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvTWFrZWZpbGUNCj4gPiDCoMKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy0N
Cj4gPiBpY2ljbGUta2l0LmR0cw0KPiA+IMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC0NCj4gPiBtcGZzLmR0c2kNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmlsZQ0KPiA+IGIvYXJjaC9y
aXNjdi9ib290L2R0cy9NYWtlZmlsZQ0KPiA+IGluZGV4IDdmZmQ1MDJlM2U3Yi4uZmU5OTZiODgz
MTllIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvTWFrZWZpbGUNCj4gPiAr
KysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL01ha2VmaWxlDQo+ID4gQEAgLTEsNSArMSw2IEBADQo+
ID4gwqDCoCAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gwqDCoCBzdWJk
aXIteSArPSBzaWZpdmUNCj4gPiDCoMKgIHN1YmRpci0kKENPTkZJR19TT0NfQ0FOQUFOX0syMTBf
RFRCX0JVSUxUSU4pICs9IGNhbmFhbg0KPiA+ICtzdWJkaXIteSArPSBtaWNyb2NoaXANCj4gPiAN
Cj4gPiDCoMKgIG9iai0kKENPTkZJR19CVUlMVElOX0RUQikgOj0gJChhZGRzdWZmaXggLywgJChz
dWJkaXIteSkpDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlw
L01ha2VmaWxlDQo+ID4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9NYWtlZmlsZQ0K
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42MjJiMTI3
NzFmZDMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9t
aWNyb2NoaXAvTWFrZWZpbGUNCj4gPiBAQCAtMCwwICsxLDIgQEANCj4gPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICtkdGItJChDT05GSUdfU09DX01JQ1JPQ0hJUF9Q
T0xBUkZJUkUpICs9IG1pY3JvY2hpcC1tcGZzLWljaWNsZS0NCj4gPiBraXQuZHRiDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWlj
aWNsZS0NCj4gPiBraXQuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9j
aGlwLW1wZnMtaWNpY2xlLQ0KPiA+IGtpdC5kdHMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZWM3OTk0NDA2NWM5DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWlj
aWNsZS1raXQuZHRzDQo+ID4gQEAgLTAsMCArMSw3MiBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPiA+ICsvKiBDb3B5cmlnaHQgKGMpIDIwMjAg
TWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jICovDQo+ID4gKw0KPiA+ICsvZHRzLXYxLzsNCj4gPiAr
DQo+ID4gKyNpbmNsdWRlICJtaWNyb2NoaXAtbXBmcy5kdHNpIg0KPiA+ICsNCj4gPiArLyogQ2xv
Y2sgZnJlcXVlbmN5IChpbiBIeikgb2YgdGhlIHJ0Y2NsayAqLw0KPiA+ICsjZGVmaW5lIFJUQ0NM
S19GUkVRwqDCoMKgwqDCoMKgwqDCoMKgIDEwMDAwMDANCj4gPiArDQo+ID4gKy8gew0KPiA+ICvC
oMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArwqDCoMKgwqAgI3NpemUtY2VsbHMg
PSA8Mj47DQo+ID4gK8KgwqDCoMKgIG1vZGVsID0gIk1pY3JvY2hpcCBQb2xhckZpcmUtU29DIElj
aWNsZSBLaXQiOw0KPiA+ICvCoMKgwqDCoCBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLWlj
aWNsZS1raXQiOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAgY2hvc2VuIHsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0ZG91dC1wYXRoID0gJnNlcmlhbDA7DQo+ID4gK8KgwqDCoMKgIH07
DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCBjcHVzIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRpbWViYXNlLWZyZXF1ZW5jeSA9IDxSVENDTEtfRlJFUT47DQo+ID4gK8KgwqDCoMKgIH07
DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCBtZW1vcnlAODAwMDAwMDAgew0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlZyA9IDwweDAgMHg4MDAwMDAwMCAweDAgMHg0MDAwMDAwMD47DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmNsa2NmZyAyNj47DQo+ID4gK8Kg
wqDCoMKgIH07DQo+ID4gKw0KPiANCj4gVGhlIGxhdGVzdCBNaWNyb2NoaXAgcmVsZWFzZXMgaGF2
ZSB0d28gbWVtb3J5IG5vZGVzIHRvIHByb3ZpZGUgdGhlDQo+IGZ1bGwgMkdpQiBvZiBtZW1vcnkg
c3BhY2UuDQo+ID4gPiBGb3IgdGhpcyByZWxlYXNlIHdlIHdhbnQgdG8gbGVhdmUgaXQgYXQgMUdC
LCB3aXAgbWVtb3J5IHJlbWFwcGluZw0KPiA+ID4gd2l0aCB0aGUgbmV3ZXIgcmVsZWFzZXMuDQo+
IA0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBGb3Igc29tZSByZWFzb24sIHlvdXIg
cmVwbHkgZGlkIG5vdCBsYW5kDQppbiB0aGUgbWFpbGluZyBsaXN0cy4NCg0KDQo+ID4gK8KgwqDC
oMKgIHNvYyB7DQo+ID4gK8KgwqDCoMKgIH07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmc2VyaWFs
MCB7DQo+ID4gK8KgwqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4g
KyZzZXJpYWwxIHsNCj4gPiArwqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArJnNlcmlhbDIgew0KPiA+ICvCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+ID4g
K307DQo+ID4gKw0KPiA+ICsmc2VyaWFsMyB7DQo+ID4gK8KgwqDCoMKgIHN0YXR1cyA9ICJva2F5
IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZzZGNhcmQgew0KPiA+ICvCoMKgwqDCoCBzdGF0dXMg
PSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmZW1hYzAgew0KPiA+ICvCoMKgwqDCoCBw
aHktbW9kZSA9ICJzZ21paSI7DQo+ID4gK8KgwqDCoMKgIHBoeS1oYW5kbGUgPSA8JnBoeTA+Ow0K
PiA+ICvCoMKgwqDCoCBwaHkwOiBldGhlcm5ldC1waHlAOCB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZWcgPSA8OD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aSxm
aWZvLWRlcHRoID0gPDB4MDE+Ow0KPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiArJmVtYWMxIHsNCj4gPiArwqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICvCoMKgwqDC
oCBwaHktbW9kZSA9ICJzZ21paSI7DQo+ID4gK8KgwqDCoMKgIHBoeS1oYW5kbGUgPSA8JnBoeTE+
Ow0KPiA+ICvCoMKgwqDCoCBwaHkxOiBldGhlcm5ldC1waHlAOSB7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZWcgPSA8OT47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0
aSxmaWZvLWRlcHRoID0gPDB4MDE+Ow0KPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ICt9Ow0KPiANCj4g
DQo+IA0KPiAtLQ0KPiBCZW4gRG9va3PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHR0cDovL3d3dy5jb2RldGhpbmsuY28udWsvDQo+
IFNlbmlvciBFbmdpbmVlcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBDb2RldGhpbmsgLSBQcm92aWRpbmcgR2VuaXVzDQo+IA0KPiBodHRwczovL3d3dy5j
b2RldGhpbmsuY28udWsvcHJpdmFjeS5odG1sDQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
