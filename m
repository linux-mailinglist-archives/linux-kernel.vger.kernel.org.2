Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5B398467
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhFBImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:42:03 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:18403
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229826AbhFBImC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoabQ6r0IRQN1kdsJuk5w6PpBXnnErh/s5DQnkQ1RVkxqS3mHrl/oGpO3RvPzUgutxZTho8wvwSJ2NykV8L1YWqcxITv8sSF0cDzcG6S45ygul7L+G99ki34HDs6eAVN8NZ7+n5IMwTc9LVeDYO6NX/6ycGvUcIra+0YrH2fN0IPmsPXRHv+4ISLkTXPKSae/tpURc4nc8OnuPeJD7mQ8mOnfl/nSL4YO7mJGuk5c4zXt4cZkgt/3qIiJo/Qrn1rMGC2fZqY0rEDLTdQDsMdIxbHurnheWJOlkY51UshvD+usWdmnPotzgV3WmnQ530J6P/KXeG50MfLSubkMaFsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27kXnRunIeE6uKFTVhsbK/igxoNgF9AA9QxSt2ICamo=;
 b=oVzXBD4Ua7fQM1jT2vwR6QPw8WC0/FvDVWLwzz85wG8xiNzz34o7t8CDxP0qvYg2Bi8YYDEz1DRSREBUh8LyyjJ5Jq39S6V9rjCXJoLZfg+RhJ8ivEJyLsdl8aPTzCThR4DgJBWHT+iojYgYutMZdmb1J8RPSHtclYYUgqRk7OD9+X1H0RfCB1kB6pl9fMrsvnToLTdh+o4n06tNxSTBYFjVYavV02gvL6gVmvNTtQgAAwQMzQNiYSAsMj+tXmDlOj6F9JT/sZ8xwy6Avti9AipKbPKeX9vffPx4yWnb7/debQYOgw2egDuLIdxPlBnzdZAFAz72XG9CzwS9yCHM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27kXnRunIeE6uKFTVhsbK/igxoNgF9AA9QxSt2ICamo=;
 b=ImOHnKzhI6gtPilZP6Lq7Nr+esPAKg7ebBbKL1jbzKC1XfZVhE3U+KWMEsxiqDBjsmEsY4JJHIm4nMArvo2FWLnEr0bNAsoqcc9JpZNUqv/gI4vcEnHin4P9uj5i+XMIp1gz6N4wy/uMsBzdbK3WrIcTthm4k0DUp3VbuCNtzAM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6617.eurprd04.prod.outlook.com (2603:10a6:10:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 08:40:18 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 08:40:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: RE: [PATCH 0/3] clk: support regmap
Thread-Topic: [PATCH 0/3] clk: support regmap
Thread-Index: AQHXU7DDzP95mW1iZUWgmMnWU2SzTKsAaGwAgAAA4wCAAAT2AA==
Date:   Wed, 2 Jun 2021 08:40:18 +0000
Message-ID: <DB6PR0402MB2760D99DFB7EEB296DB31FEA883D9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210528113403.5374-1-peng.fan@oss.nxp.com>
 <162262192433.4130789.1017942859005253343@swboyd.mtv.corp.google.com>
 <a5833012-3e86-5be0-71f2-de4d9b32a152@pengutronix.de>
In-Reply-To: <a5833012-3e86-5be0-71f2-de4d9b32a152@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f746f4c0-f2e7-417d-e9ad-08d925a20cef
x-ms-traffictypediagnostic: DB8PR04MB6617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6617E3A60F820C9CF206FFD0883D9@DB8PR04MB6617.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Goy641IqG+X0/FWXU4L/iZ6yTf+5YZ+hZA956UA60Qpm7zWbs58FNpBZHUSSwsvqCad+G2b8Ty04bGbL5ln8xLHR0vfG56OMPeF4nTqE9M0ZARggvVQfu89GCX6OevVgufoaTgCDOK4yFaOUKBU0h/CGylbSbSemqXzteVhXq4BoGaTV9zGFOpDe0ML82S1/khp31erWQc6V1v1xOC/7s+xtZ68Ixv0d5b/O7SkGokY+uzJGNRsRW+D0IQQY9PXo8iPk6OI+0Q4Wst0tikNyr5pdoAidD7N45fh/x7DKkMYyQE5n8cnj3hVm4qSp98t+EEoXl+sbl0dRSeJwgI9sEIkg8OrMESS6BACsSHvhQttD0vFCbbUrjwjXr8PzlDz6d77chLn0G4vy+OErZ3st6CyQ0SK1qCndqnmo/NOOiLALoMu9UJaU8r0NIe2XJhYDM14ILotY9IfH5PsUE6PrbrqcFobHcrlRnNdDv4yh25NEMYws31zlOD757cqMtoZRy3EKi3YeCFo9D/npyL2KB45H6IIAYMoUVZs/Hy3tQy4DgLFVgzjxgiE2WD8jRgXfWx+NAsTXrdVZ1LwWplelZe2gGWW93tTZ4l4e5zjibCyfeSo4A/wH7A5ZQoTRpSAlY/3TNh00+TY3EEy6gO2ytaDeYI5/HcMr93mC4BMiFscubzPRKRGxGvdvSAVK1s4+t3RdAeAJ9fyk0JbOY3dLGf304gjv7WOjrOKDzxPSYF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(71200400001)(55016002)(38100700002)(122000001)(86362001)(478600001)(966005)(7696005)(9686003)(8936002)(66946007)(2906002)(44832011)(186003)(110136005)(64756008)(66476007)(66446008)(76116006)(66556008)(8676002)(53546011)(5660300002)(52536014)(316002)(26005)(6506007)(4326008)(83380400001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NGNiV3U5V2VBdzQwZkVxQUV3RXNXSUs5SHhjaWloUmxXcHczSXEzV016WFVJ?=
 =?utf-8?B?N3NlQmpaQXYxNUZIVTRiQk0vdmZteGE1emhUUFJlbmdMWkF1ZnNDaXZRYzJr?=
 =?utf-8?B?QytSeEZzZXo3Ni9hb0FuWE12ZU9JdG16R21RRVpTblhRcXZoTlRMS2o2bnhw?=
 =?utf-8?B?TUVYcjcwVUEwNVhEMmNvNUVyYm16QTRyTVdOL3BpU0kyQnBnT0EyRFBXSWdq?=
 =?utf-8?B?bTUrbmpva2MxZ09DQVhodHV4N09jdkh5RkdwOHhGdkJNNmVQbGlqTzlDN1Vq?=
 =?utf-8?B?ZVdDQTJjNGdwejgvUmpRYS9UczkvdHVMcUZKWE1TRXorSGc2UmJCKzNNNXJm?=
 =?utf-8?B?aHJvUCtnUVVaSlFrbTVpWTlmRVd3YVR4TTdldTZObG5IcUZ1dHhWUkhtbDF4?=
 =?utf-8?B?bjBBR1NJamFvdGl6U2t4elo4bW5JR0F6dUNBb2tJMGRxeElqWFVoTVp2Ulgz?=
 =?utf-8?B?MTVKNHFXZGgxWWk1cUFhMTRmV2ZPczNkUmtuZFhkeE1BZHhoTGxQZXBIVnJH?=
 =?utf-8?B?cGJWQWpSWU5kbytQaVdXc0hyUC9HVjV2NGQ1WnFiZy9VOExmN2lJQ05rdi9S?=
 =?utf-8?B?WFk5V1RFY0RvZnBnV1dxWUVNQjdHbVhwc1RxdVlYK1IrN3RLY0YwZTU1YVlz?=
 =?utf-8?B?M2JKRXdBUEk0eUxIVjNwb1Z3YUxsckhzREg1MmNhRzAwSit6dzhkRCtFVDRH?=
 =?utf-8?B?VVhQdHFRNUJYMmxVamI2V2wzWk5JYjN6VnhzYll3UWxiODA3T2RKSmJ2WVk5?=
 =?utf-8?B?UG5uRHNMN3NqcmkyakFBZnBLU0VQZXhQY2RNSERsbWh5OW42NzRTajBCZG8z?=
 =?utf-8?B?c2F5ZVdLMEVpZkErblA1ZUl6VWJDK1EwdVdNYlVEZjdSaTNpeW5SanB3MXB1?=
 =?utf-8?B?NjhWWTBKWTJEazg5Uk13RC9GRktucWpJS0I1b2RrRDdKT0JTWjh5WUxpaEw1?=
 =?utf-8?B?blVUemxpaEVvMFlPVzFpZGFEOE9yb2lFNllydjQ5VjlwSWs1ZFJTNCtJN3cx?=
 =?utf-8?B?cnllbDVNL2tBc0c4ZGF2dXdEMnpxYUxUb2MxVU5NbzluWmZTU2szY2FsTXYv?=
 =?utf-8?B?S1ExWldGcVlDZjRxWmVyc0ZmMmRmVVhPc1hFaWlWaXR2SldLaGx1MTlqYjAz?=
 =?utf-8?B?bnNESUNTQ0ROTXgyQmtQZ0ZFMEZRRWpFcWlncTZsZ1hDeDdNaW1QV3ptL243?=
 =?utf-8?B?dkovRUI4d3NjY0dFTHZtUi9Pd0FRVzNhYndHV3VaVGxUUERic0hjbTdqem1w?=
 =?utf-8?B?TEhDRHNGT25iWFJtZlZVN29SajRydXBsd1hqa3B0dGk3U1AyU2VNbUFoRTJB?=
 =?utf-8?B?T2JOcjk2bUsxaFo4SnZqT3dSdXJDRXd4Uzk2Y25iTFlBMk5rSUdUeDBpaVBl?=
 =?utf-8?B?eDU2MVhaMnFNM2htenNZL1VvV21jOHM1NTErY1VuOUIwUFVISCtJNWNIdjJq?=
 =?utf-8?B?TUovMFdpZDdMR3Q2ZDEwQUxNMFB1ZWJwbkhwK1FoN3FQZkpMczc4TzhpUjMx?=
 =?utf-8?B?TGZDaVBNVjR3S093azg5MEpqaXFYNmxMOVJob1k0SnFnRHBpS0Y1dFJleWRV?=
 =?utf-8?B?WHBoaitTQ1BrS0JDdG1FVURWWWszRTVMN29sQ1dJNFFBbWtLa0hia1RobDBh?=
 =?utf-8?B?VS9tcWNWZFBOQ3pja2N2NTZiZk9BclErL2N3aHZxU2lrbWJiTGQ5ZHl6QmZU?=
 =?utf-8?B?U3Awc0UxOGxxUExoMWcrZjltRERYd293NkZRTTJEUWxNV2NhajZEYVVGM05L?=
 =?utf-8?Q?UifMZpLBSBA/l4E5HhJiou6evZcf5s8VTXZNsM4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f746f4c0-f2e7-417d-e9ad-08d925a20cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 08:40:18.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Smjo3Ew0DGpk0vvAsNC5Jm28OSPoUY2b5gLfoOeLxtyFE3XdCQFafwdc6E1TMYe6EPaMuiBa++fLLF3j2UCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvM10gY2xrOiBzdXBwb3J0IHJlZ21hcA0KPiANCj4gT24g
Ni8yLzIxIDEwOjE4IEFNLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gUXVvdGluZyBQZW5nIEZh
biAoT1NTKSAoMjAyMS0wNS0yOCAwNDozNDowMCkNCj4gPj4gRnJvbTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4+DQo+ID4+IFRvIGkuTVg4VUxQLCBhIFBDQyByZWdpc3RlciBwcm92
aWRlcyBjbGsobXV4LCBnYXRlLCBkaXZpZGVyKSBhbmQNCj4gPj4gcGVyaXBoZXJhbCByZXNldCBm
dW5jdGlvbmFsaXR5LCBzbyB3ZSBuZWVkIG1ha2Ugc3VyZSB0aGUgYWNjZXNzIHRvDQo+ID4+IHRo
ZSBQQ0MgcmVnaXN0ZXIgYmUgcHJvdGVjdGVkIHRvIGF2b2lkIGNvbmN1cnJlbnQgYWNjZXNzIGZy
b20gY2xrIGFuZA0KPiByZXNldCBzdWJzeXN0ZW0uDQo+ID4+DQo+ID4+IFNvIGxldCdzIHVzZSBy
ZWdtYXAgaGVyZS4NCj4gPj4NCj4gPj4gVGhlIGkuTVggc3BlY2lmaWMgY29kZSB3aWxsIGJlIHBv
c3RlZCBpZiB0aGlzIHBhdGNoc2V0IGlzIG9rIGZvciB5b3UuDQo+ID4NCj4gPiBXZSBoYXZlIGEg
Y291cGxlIHJlZ21hcCBjbGsgZHJpdmVycyBpbiB0aGUgdHJlZS4gRWl0aGVyIGNvbWJpbmUgdGhl
DQo+ID4gZGlmZmVyZW50IHJlZ21hcCBjbGsgZHJpdmVycyBvciBkdXBsaWNhdGUgaXQgaW50byB0
aGUgaW14IGRpcmVjdG9yeS4NCj4gPiBJJ2QgcHJlZmVyIHdlIGNvbWJpbmUgdGhlbSBidXQgbGFz
dCB0aW1lIEkgY291bGRuJ3QgYWdyZWUgb24gdGhlDQo+ID4gYXBwcm9hY2ggd2hlbiBKZXJvbWUg
d2FudGVkIHRvIGRvIGl0LiBNYXliZSBub3cgaXMgdGhlIHRpbWUgdG8gY29tYmluZQ0KPiA+IHRo
ZW0gYWxsIGludG8gb25lIGNvbW1vbiBwaWVjZSBvZiBjb2RlLg0KPiANCj4gSU1ITyBmb3IgdGhl
IGJhc2ljIGRyaXZlcnMsIHN1Y2ggYXMgZ2F0ZSwgZGl2aWRlciwgbXV4LCBtdXgtZGl2LCBldGMu
Li4gaXQgbWFrZXMNCj4gbm8gc2Vuc2UgdG8gaGF2ZSB0aGVtIGluIGFuIGFyY2ggc3BlY2lmaWMg
c3ViZGlyLCBsaWtlIG1lc29uLg0KDQpZZWFoLiBMZXQncyBtYWtlIGl0IGFzIGNvbW1vbiBwaWVj
ZSBjb2RlIGNvdWxkIGJlIHJldXNlZCBieSBvdGhlcnMuDQoNClRoYW5rcywNClBlbmcuDQoNCj4g
DQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAg
ICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGlu
dXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0KPiBW
ZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0
ICAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01
MTIxLTIwNjkxNy01NTU1IHwNCg0K
