Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3283A9E99
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhFPPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:09:27 -0400
Received: from mail-eopbgr1410109.outbound.protection.outlook.com ([40.107.141.109]:17959
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234443AbhFPPJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMh4VBSUZLzJe9am13rY+DD5b/ph6WBU4MqvXGNhq3O3qj/AuHprHIIgJ/R3M9cGuGAF8+LEaqoLJL0g9u92R9UrsNiuLrcxuhNZDGTq6C4ftiWTNphw5RpUIN6i8h1SwyHsj41cNgQ78uJ1IKbmBN9jNCYaj97bjACDvvaWHA4txPsqfN5PFOKx2X9EgPibb4joqMCzpDFIzYpMiWJI77x/wvOPeqws7VWL371cd7THygXG/wel4D7geiAdWyx7XKHzWzEKn1qJ+ob2rwvSfLKv5vwAg6dtuAu2Pl8AE+LuN8ApsSnIftw0P958GhjdOxIwI59aywc3Tx7yURkVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GMxfxXMDbYbjbIU6juUCZC3UsRSD2Y6HoOGCw7EQnQ=;
 b=FAqJAiOlbd5jfiIhSm2mM7zlnPCcZ4khX7cm7XnuN8OWyMd7rrVS75EseBjoSKy9XtGxfcUvtSgit/b2UvngFKuDat+B4orhdG7WRpqMxRjMf/gmscK5EPVQXklnTb4jSOcDXJUJlHPk3yfOtjQn5WurdSmVK5Wjk9e7LV3/rDCGgxd39wXIrCAoXpjHw5WwKDK86uw6+9CT3g2Ty0+lCAoeZOd1XfGlCM07eUF7vtbcT5Wj1A5Q/oNNkIhbQc+KHdbN7hwd2gA583Mn4SsocemuCpb/l4dtAGtEeCKfgdppKZB62eKYwqdqg6sLNnrrKJtIZ8AVQTqvVWyGYOlF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GMxfxXMDbYbjbIU6juUCZC3UsRSD2Y6HoOGCw7EQnQ=;
 b=pdF0EAFz1A9J0D7ZlBhW8WckTdlklPHB2+OcwjPV9dra3el+6za5ZKXPnIrgtCkz9iXMIafg97ELxb0YH9at6/3isLo5mwoatCMsjj8xp7vxcMBp1JlYKratG2oAJUNn4fIEXac+xY+sBtxeN8K8uQ05RANRhTrkaCKQtQjmSu0=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYAPR01MB5088.jpnprd01.prod.outlook.com (2603:1096:404:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 15:07:17 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::788c:8a19:fea5:209d]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::788c:8a19:fea5:209d%9]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 15:07:17 +0000
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
Thread-Index: AQHXV86EpPNANrzU4UCJO/Td0zuOkKsVKxiAgAAsQzCAAQNqgIAAaN1AgAAK6YCAAACigA==
Date:   Wed, 16 Jun 2021 15:07:17 +0000
Message-ID: <TYYPR01MB6603D0473CF72D7EFB599D2CBA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
 <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YMmuz0EVjfEi6MJj@dell>
 <TYYPR01MB6603047A864DB37F111BDAD9BA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <YMoP7fdkyyYUrDf2@dell>
In-Reply-To: <YMoP7fdkyyYUrDf2@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b23621-2127-40b8-5bd1-08d930d86e97
x-ms-traffictypediagnostic: TYAPR01MB5088:
x-microsoft-antispam-prvs: <TYAPR01MB50885D48CFF3BADFEAB81F75BA0F9@TYAPR01MB5088.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7RFRmLTCoBkVB0/ENS7E2mzarQa2K/T39Aqy8xs79Zhhaplqfx/lBacJNvgA7BPEt3gZ0865HoINdnhwNOlRsqvQp6F2pIx6o7+rvEcyl0wIOpB/gP0GRm/V8yo4XSnrc4R09hBfVmZBpTLLm/Y4QuhF0b4ab4tRieHXX9RR1SywuWaYecb3EjpelqHcOhF6CEc5fnQLP6ZHb2+c8iuxe/lAHZX4gJkDvg+SllQTpcEmc7oAl9/lxDlfL9BEGn7mJwiYamfH0/+A2Rz4hDbenCkh8p7skB+Tv94H99g7PMYbmwLWANCnbqTBx6uRK5SNnHUMcNdZBySnQP872PKbaTuu7E+kAnWHEwHKB/aUCusZpxFaYpxZwrgJRuiXSOgvd50WWBhavaI+CgcKFulszbRecxmUzbT0Al2tyrtqlZJ6IN2h1aJNHSIP6MyxKxhER+YVUddMKS2IhrKFDfSWSmIFoxOoiW4wK/ZTuX0vsHxtuQSIkfTs6DlxjoFOfObh89luV4iOT9j6p/V+g0b51f8cPj2sATB5TcH6ywElq1qIdf4vzUReVxfHBojHzfrIJKv0wAAtTQya/XXX3pp14lnJs1bmAjr9SKEVdZ5Yq2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(52536014)(7696005)(86362001)(6916009)(8676002)(316002)(4326008)(5660300002)(186003)(8936002)(64756008)(66476007)(9686003)(2906002)(66556008)(66446008)(66946007)(6506007)(33656002)(38100700002)(54906003)(26005)(478600001)(71200400001)(83380400001)(122000001)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxTajNTL210TDFhZms1Y2JYWmtsbm8valkvY2NkeHhQRUd2SUlpZGlNT01L?=
 =?utf-8?B?MnZ3ckJRSkpMWmYrR0Q0UVRoZHFKdnNmeEZmR2R4Zkl0eVZHeFNMcDE2dDU1?=
 =?utf-8?B?L2FyanFQWUdpTFVnRDJFRjBWUTlZMmkveERNNkJsVU9rUHh2b0pVaTUvUWxz?=
 =?utf-8?B?eGtLQ09lZ29kcXZqVUlyQkZCQ1diZWlNemF6ZlNPN202aS9mcUlYNUJlMjgw?=
 =?utf-8?B?NDNJWnBsY1djb25MZThHMkNYVVhsSHR4LzZ1RG1TMnF4aDRjTWZ0VCt3Uk56?=
 =?utf-8?B?L0RpU2VBSkNGdzZ4citUVmZrS1FQb290QW5zZHZwV2VzZHR0RzNBK1JIUGlN?=
 =?utf-8?B?K1M3b3JleDBPdmpUdEE5Q1R3SjRLd2VOejdxN3JBbkxZMTIraHVBeGtNQVk4?=
 =?utf-8?B?UnphdENrc1o1cWZDYkYrcHVqdmhDWVI1cUp1QWQ0UnJ3bUNIa3FiTkhNeThC?=
 =?utf-8?B?UVF3SEpBSGkrOGsya3VGQzh2aGQwVkJLQXhFOUliUFMzZmJSV0NTL0UwcXZH?=
 =?utf-8?B?ZUtBK3NsNnlnSGQ3TitWMlJHMHBTdzBScnQ0bWJKeS8rRHpKOU9xMExBYUtS?=
 =?utf-8?B?Y1VGMTVxazVkZDc0NWpJMmNQd0ZwdVRhengrVjJ3NVpPR29lbnRhSE1helpK?=
 =?utf-8?B?TGhQeUFGU1FqdytKU2xDSVg1NW9PTDRRRk5YcUJTTjRtWTlXY0ppV211cUp0?=
 =?utf-8?B?QmNTd29OWnJ6WkdVRk1YU3grV3YrTitjdjRNNDdHT3VIOEpPWE5jUVlqWS8z?=
 =?utf-8?B?dmMyUlZaL3NXNWs5WDJGbmxpRWtmOXlUbHNQbEdVNGt2OHJCdUV4WXdGVzgv?=
 =?utf-8?B?aGMzUHZpY0pKYXFVTEtHKzVTbmJnZ0dmaS9GRDZhczU2MEZidy9kVkZFTjFT?=
 =?utf-8?B?aEs1TnlqL2dUOTRVVW50UzREQU8wbGo0ZVNRRWRBQ2Z2dFo5U1VQdjNYdFpN?=
 =?utf-8?B?ck9nSjFYUmo3NjRUaFMwZkh0OTRCMGJ6SFoybVk3djFXVXp3dVdZcUFGMEdV?=
 =?utf-8?B?SWdIaHVVU3BQTzIzaDQyTDZrSVUrMVhLTUFEekljWTcvcGxlZ1J6WmdNVG5r?=
 =?utf-8?B?M0ZSSUlxK0RWZ0ZwaitBcVNsTW5Lam9LTXk4S1I1Y2tHbGJZYkFvSnRKemNl?=
 =?utf-8?B?TjNNVFl2bENnclpHaWhKUExWUjhnZGhMMUVld2drL3VTYVZsNmRtdTRTK3Ey?=
 =?utf-8?B?YUFXbTZBd21USDhiazM3dGpGRzErSG5ZSnRxSGVva1cwaTJlanlubTNaK2Mx?=
 =?utf-8?B?NEN5bkNselYxSDljSXYyZ1hBN2ZpYUJ0L1ZvNFFXeWovMVJWZ0U4Ty8wcG8v?=
 =?utf-8?B?RDMwcElhR2xvQk9ObXlxck8wL2s3dlJmNGwrTGYzeFovSGFUNjhsR2dqOEF3?=
 =?utf-8?B?NkMrSUFTdit5ekMzSTl1VmZScmFOdkkxUkJGMTRqMzRBUUdzWXJ0b1hiYVRk?=
 =?utf-8?B?NVhGMDVWaXJUc2lnWWdiaExXa2gzN3BUeENLc2RjSEgxbXhmK2p0QldmbGl4?=
 =?utf-8?B?TmFWaDBKTDZrSFQ4TDltRWx4QUVTSEVrRlJObDNZUm1xSWEyQlMycnU3a3Zp?=
 =?utf-8?B?dnFzSVo5QUlGZS9vOHUrUU1sMHdsUlc1UmdtTlRyQW9kZVN6U05lcFFNb1Zr?=
 =?utf-8?B?ZEdhVDRVUEI3YkIzQXd3YlFmVDZzWHA0djVMQzJJelNxL1I4NE1vOGpRMnpj?=
 =?utf-8?B?RitGczFJbXlrOWU1SUxYR0o1Z1hmZUhYc2I5YWRaOFdtc3lNRkhOV29DTWpR?=
 =?utf-8?Q?FCUwrfdY10/XW1TE6y2FLpv4m37t9s8YSEXlVUi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b23621-2127-40b8-5bd1-08d930d86e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 15:07:17.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+9dAsuQGyLzSvCKYew3x/ki54xMbsK2eGzEzYeEzxKN7OeREOvfPGKdUpm/TtEdcBuJFm5c/54ja1f9gULKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gSGkgTGVlDQo+ID4NCj4gPiBUaGUgUEhDIGRyaXZlciBhbHJlYWR5IGV4aXN0ZWQg
aW4gdGhlIGN1cnJlbnQgdHJlZSBhcw0KPiA+IGRyaXZlcnMvcHRwL3B0cF9jbG9ja21hdHJpeC5j
IGFuZCBwdHBfaWR0ODJwMzMuYw0KPiA+DQo+ID4gUmlnaHQgbm93LCB0aGV5IGFjdCBhcyBpMmMg
ZHJpdmVyLiBJIHBsYW4gdG8gY2hhbmdlIHRoZW0gYXMgYSBub3JtYWwNCj4gPiBwbGF0Zm9ybSBk
ZXZpY2UgZHJpdmVyIGFmdGVyIHRoaXMgTUZEIGNoYW5nZSBraWNrZWQgaW4NCj4gPg0KPiA+IFRo
YXQgaXMgd2h5IEkgd291bGQgcHJlZmVyIHRoZSBuYW1lICJwaGMiIGluc3RlYWQgb2YgImNsb2Nr
IiBzaW5jZSB0aGUNCj4gPiBkcml2ZXIgaXMgbm90IGEgbm9ybWFsIGNsayBkcml2ZXIgdW5kZXIg
ZHJpdmVycy9jbGsgYnV0IGEgcHRwIGNsb2NrDQo+ID4gZHJpdmVyLiBBbmQgZG93biB0aGUgcm9h
ZCwgd2Ugd2lsbCBoYXZlIG91ciByZWFsIGNsb2NrIGRyaXZlciBhbmQgSSB3YW5uYQ0KPiByZXNl
cnZlIHRoZSBuYW1lICJjbG9jayIgZm9yIHRoZSByZWFsIGNsb2NrIGRyaXZlci4NCj4gDQo+IEkg
c2VlLiAgVG8gYmUgaG9uZXN0LCBJIHdhc24ndCBhd2FyZSBvZiB0aGUgUFRQIHN1YnN5c3RlbS4N
Cj4gDQo+IEluIHdoaWNoIGNhc2UsIHRoZSBuYW1lIG5lZWRzIHRvIG1hdGNoIHRoZSBvbmUgaW4g
dGhlIGRyaXZlcjoNCj4gDQo+ICBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgaWR0Y21fZHJpdmVy
ID0gew0KPiAgICAgICAgIC5kcml2ZXIgPSB7DQo+ICAgICAgICAgICAgICAgICAub2ZfbWF0Y2hf
dGFibGUgPSBvZl9tYXRjaF9wdHIoaWR0Y21fZHRfaWQpLA0KPiAgICAgICAgICAgICAgICAgLm5h
bWUgICAgICAgICAgID0gImlkdGNtIiwNCj4gICAgICAgICB9LA0KPiAgICAgICAgIC5wcm9iZSAg
ICAgICAgICA9IGlkdGNtX3Byb2JlLA0KPiAgICAgICAgIC5yZW1vdmUgICAgICAgICA9IGlkdGNt
X3JlbW92ZSwNCj4gICAgICAgICAuaWRfdGFibGUgICAgICAgPSBpZHRjbV9pMmNfaWQsDQo+ICB9
Ow0KPiANCj4gU28sICJpZHRjbSIgaW4gdGhpcyBjYXNlLg0KPiANCj4gSG93IGVsc2Ugd2lsbCBp
dCBtYXRjaD8NCj4gDQoNCkhpIExlZQ0KDQpJIGFjdHVhbGx5IGxpa2UgdG8gY29tcGx5IHdpdGgg
dGhlIG1mZCBzdWIgZGV2aWNlIG5hbWluZyBjb252ZW50aW9uIGJ5IG5hbWluZyBpdCA4YTM0MDB4
LXBoYw0KQWJvdXQgdGhlIG5hbWVzIGluIHB0cCBjbG9jayBkcml2ZXIsIEkgd2lsbCBoYXZlIHRv
IGNoYW5nZSB0aGVtIGFueXdheXMgZG93biB0aGUgcm9hZCB0bw0KbWFrZSB0aGVtIHdvcmsgd2l0
aCB0aGUgbWZkIGRyaXZlcg0KDQpBbm90aGVyIG1hdGNoIGRvZXNuJ3QgZXhpc3QgaW4gdGhlIGN1
cnJlbnQgdHJlZSB5ZXQuIEl0IHdvdWxkIGJlIGEgbm9ybWFsIHBsYXRmb3JtIGRldmljZSBkcml2
ZXIgdGhhdCBJDQp3aWxsIHN1Ym1pdCB0byBkcml2ZXJzL21pc2MgYSBsaXR0bGUgbGF0ZXIgYWZ0
ZXIgdGhpcyBtZmQgY2hhbmdlIGlzIG1lcmdlZC4NCg0KVGhhbmtzDQoNCk1pbg0K
