Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDFA37FD47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhEMScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:32:17 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:6146
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231175AbhEMScP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:32:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHip7QDKGPTlu0nh6Ww6pm0qD0OWemAacmhBXMtb+q1u0IkpVHrCUV+5qHEqzdBZFVqRGpn4dfLAFGWS60atrHCKH27goDVJ25NfsvZ1xo1x4W7Utr7tZvplq0Sx6dwrUa9UMmVHGNuenuUCp373SBZE3j9tUS1JmRSlysABbOWiUQcxFFpIZvx2WXb/J1V9jpVtLu/eRTfLoU99ZHsf1yHTZWja1hny1HfygFIxpPPGBEKbYnYEzfhtaMhZSdV2jUrcn0+3L3+Eq40qlJ2eVEkGCoflt5n/73wDFXP4qqjiGXISGZtNeISUJYwEvYxenZnQK098F0zIg+H7dl8ovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+JCufn/qTK9tqfJvCD2XZte4dDCdknR5zXVJY172rA=;
 b=b+DPmPYYi2NupTTLnhVesHbXBrBoNycueWhvXxhKuUZh2XqCu1PYrKzT8QJVpNXViZW5HaYqdVrqdzN2sxg6J/n2/tGNca71+x4BMqsGXrEBwK0Kh1YHoBuVd+SQNt6Q0ZdAp4PcQP3ct+xgZITxqi6cj5bNVc6NUggVa5VM3reoVulxXMJ3xkQT/yeu+PQ6hnTJLc6O3a6d38+XFVDPilnYS3GvywMzsCIKCGslJnL06Rs10qDWYyJHfKyAvP7JfN/+MhjLo39lakeTWgiglp+ge8tsS1U5oBp7Gq4Pd8oEvEYF9oKNaeZq9S3mACX0xhLKbf3Cg1i95lMpjrQZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+JCufn/qTK9tqfJvCD2XZte4dDCdknR5zXVJY172rA=;
 b=N77W6GpGSlIGZ4+IyHFfkKWIAgsxFiGZdDO3ZzFPTLUyh7wNGGfOuTYlfXQEPCnjWuohBtpq7S4PNIPlLJokWOfnPhD0/ZaZCqnizNP0zNnF+M7EJyWmJsc/fOJuPFmWit2aHi+uoAPfvVqCys0O3zIMTX6/7Z2M2A9wzYbaNJI=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0401MB2686.eurprd04.prod.outlook.com (2603:10a6:800:5b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 13 May
 2021 18:31:03 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f0c0:cb99:d153:e39b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f0c0:cb99:d153:e39b%7]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 18:31:03 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marcin Wojtas <mw@semihalf.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Kornel Duleba <mindal@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Thread-Topic: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Thread-Index: AQHXRhK6wSxUwtoqZkenOXHlDRJ4r6reBtQAgAKnz4CAAMsmgIAAPAuAgAAKRwA=
Date:   Thu, 13 May 2021 18:31:03 +0000
Message-ID: <20210513183102.6dflgb4v2oekdlq5@skbuf>
References: <20210407123438.224551-1-mindal@semihalf.com>
 <20210511030658.GG3425@dragon>
 <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
 <20210513021214.GJ3425@dragon> <20210513141921.i7sfmekbcw2m7vxd@skbuf>
 <CAPv3WKfnWFjfZw39avZBEyUpEsH2f=NCs8VfjeR+wzk4qV3GmA@mail.gmail.com>
In-Reply-To: <CAPv3WKfnWFjfZw39avZBEyUpEsH2f=NCs8VfjeR+wzk4qV3GmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: semihalf.com; dkim=none (message not signed)
 header.d=none;semihalf.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [86.127.41.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5856550-5aeb-4a19-820c-08d9163d438e
x-ms-traffictypediagnostic: VI1PR0401MB2686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2686E2643B362941BC6B8B55E0519@VI1PR0401MB2686.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWBOx77+L0e89JGZb6qYeorwnVgf7SOBPcFismkhnAgSEsorpxVIOTm3JwSrUTBC5ZQ3T/vg58YTI4LzPefNDErNYBls+/yA3phyKtQtIVhkMWmrZA9Tqt2Mc4P46QOxqaVNMAmBISoxNu0PQsjb2zt9ivnUCQQ0FF+zML78kdvo9DUOaRV/a4355CHOu01Hjrvq+cF8HoCGsJVQ0R+oC2pREUaCxnx6kCaIijZQ+F1XZFAGg+2u0T1L2pUWx8eskUI3iPNnqBlSICwEWkOJpTAa+HYWTtWnpc7VQd7VtvLLcKutep8bN0TA0GBpIwdfPE6/UyvYAyP6mhLtRm2HjTGHugmTANe1ZLeKjQvsGX9Yo7TeRObjsPmWlm8xJL+Brvv1bN1X48zCfVq3hahX3AbBi1VCEnJnVUoCKOwrUnhI2bzA55tfB6xbF93vmxrh/Q2ciIzhZM4MVz5XRqotUrUpLv1tiNkXqM0IFkUe2usRV1Wdfn90/fmHpQFX+9xCSugcKG5trQGhuui3kX8Cc01WgvjvyRD8rYraeUBwZYZvS7Y7bspvr6gS9mpMpBAPCPKPwrXGSaArIR+4oEoP4RL0IvrjFT7krTrKASfYPF6xWkJ07N860qJOgrOmVnr3WSHjmM7lIWEbrwOYVvzgR3JA9COqiI6gc/JPpm5NyPJytLejOVBYPCkcvWqKKB4K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(396003)(39840400004)(366004)(376002)(346002)(4326008)(66946007)(6512007)(478600001)(2906002)(9686003)(66476007)(1076003)(33716001)(66556008)(66446008)(966005)(83380400001)(71200400001)(8936002)(6486002)(54906003)(7416002)(122000001)(6916009)(8676002)(186003)(316002)(38100700002)(86362001)(76116006)(26005)(5660300002)(44832011)(6506007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N0w2WWgwTUpQNndPVUc2NGg1aThXbE9sSTN2eTJGbm9WcU9KVEs2cHUyS3N6?=
 =?utf-8?B?MTRNN2RKVnRpeVRZVWM2SS9JZXUvZWJPbWxmd1c4S1IzZ1ZPSk5URGRPSUd4?=
 =?utf-8?B?a3BqWXpiRW52Q2l0ZFJSMlVtUmxXRW1keG91R3Y0ZEZDakMvcm9ES0tvOGlQ?=
 =?utf-8?B?MW5RYm5PbS9PYndRbEY1eGF6c0V4NEpNQzcyN1VzK1RQVDltRXR4aStoTTBQ?=
 =?utf-8?B?TjZIOEUrZHJ5VEtsN0RDUGhUc2JIeGlEUUFuMmZaYW5vTFEyUHpCSTVEcXZO?=
 =?utf-8?B?cExWK1VIRUlDaXorbFVpYUpIM09WR1dMRnpiR1NYaWQwQzQzeGVWTEtEaHgw?=
 =?utf-8?B?NW1hZ1lXWUR6U2NqZm5UM2dSb0tidmw1ZjIwWjF0b2c4bjc0RmNDN083czZF?=
 =?utf-8?B?d2o5Tjg3Vi95ZjNNVEFyb2ttNlZWdFZINHVGSm1RRndkQWk5ekF3SVViYXRq?=
 =?utf-8?B?ZlZ6MjN0S3VjSitJejZzSm1ZekdjbnhXeSthNFhyYm5CeWZQTWFWZWZXZlE1?=
 =?utf-8?B?Y1ZjU01uNGtucDkxSmFaNUNoRTdHSE5EeGF1QUZaVGlXZWhyaFBaZUtaaEc3?=
 =?utf-8?B?SEU0WHl0SENNVkRNRHpyN2JkS3VHeUZ5OUdkRlhjQms2dnZ3NTBCRFBYSmJP?=
 =?utf-8?B?eXErYkVneVo1MXkyS0tLUk54MThOSWNRc3o2aVNVL0ZGVFJCdkJUazA2VEtB?=
 =?utf-8?B?c2dkOHdpNkpORzNDRERiZlJkQklRSlpJUXZWaXZseVFlZVFuSDUzY2cvUy9h?=
 =?utf-8?B?Mkw5eGo4SjRlWEdsUkVsVmgrckdzcU9aUGhqd1dmMUJFN0x2djZObzBMbzZW?=
 =?utf-8?B?a3RpSzY4WlFjTU1jeFFSS1gzVm5aRHVCTk5QNnlEZ1NueWdaMzZ6UUVFTUJD?=
 =?utf-8?B?eHROOTgwWm5LWU50ZXJUTDZMbXBGMlQrYjEvTktXbGtKbnNWWUFBTGtldmhG?=
 =?utf-8?B?YzNiL3ZxOVRLV1JsdFY1TEtkUi9aK3R0a1ptVEEzYTNlUCswRDBWdnFZY20r?=
 =?utf-8?B?OUhlR1Ryd2pBeWx0bndnenFsMTBDdWtzMTRJVHY1QXpVRERDZVlOUjQvQ3Fn?=
 =?utf-8?B?ek50TTU1N0Q5WGRDNkt2T0xwNmZsaFl5cUpBQXdSbU9wTXBxWkFQL1AxNm9h?=
 =?utf-8?B?ZXh1akR5K3R2SENMUGVmUWdNSkt0M3NBT1FTMFpSVmpsRUViVjl2Ty9aWlVB?=
 =?utf-8?B?QytLS1JQMVNqRlZwOXRrNzJkNmh5YnNLSWsrSE5OYjN0M3pCa3RWUWV4NFpE?=
 =?utf-8?B?dm5tQlRNdVk0OTZPdTBYWVRXZVR0WnYyeXFLaWY1b0I1Sll5SDYwSVpqQjFO?=
 =?utf-8?B?MEtPcGZDWk0yc1NnMEpZemdFOVZoM01FSzFTSEJkUkF0VGVHSFc4MXh1bm50?=
 =?utf-8?B?L29lKzBsenhVckxDTXBwdkFUNGMyZVRaR05DSFllNy9hWEY3SU84RFVXOU1S?=
 =?utf-8?B?MjdQakpLcnA5SFBNdTE4OHQ0Y24rVHZtWjZwWE1UK3k0b25veU0yT3BuQVNu?=
 =?utf-8?B?Y0NiV1M0YnBvWG55K2JXaEE4dUdKOUI2ZHM0ZEJhUEhkWG0xYWgvRU1Eb3Rl?=
 =?utf-8?B?Y09WMGxQeUExeWVtbFI1TDdKTVJ2cFZrVzFNMWd0c0UzdWFFVCtkWkxLR3lk?=
 =?utf-8?B?M3JGdTk1VnpQc1BGTzVmM0pPMUo4UzJmQTFGYzVEWUZoeldKOTc0VWc4YkNi?=
 =?utf-8?B?dVlRNHF2Z1k0UE56M0dLYTAwd3RtSDVBZnBpTDFKRTBkQ2F0RUc2azlSeTlC?=
 =?utf-8?Q?DDL7OGCvK9rpXdb9/F6Y7c2AdeO2hqMuNy/sLaE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FEE1E02538AD146A02C4FD1AD74C676@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5856550-5aeb-4a19-820c-08d9163d438e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 18:31:03.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sK3Mx8Ynal0BnDM51mH1m8nr6kB6ZwtBCYPBPM7iNAjprOzWKchkvO3mcULqPLZL/uARnBtC3eLKn42lN4wr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2686
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2luLA0KDQpPbiBUaHUsIE1heSAxMywgMjAyMSBhdCAwNzo1NDoxNVBNICswMjAwLCBN
YXJjaW4gV29qdGFzIHdyb3RlOg0KPiBIaSBWbGFkaW1pciwNCj4gDQo+IGN6dy4sIDEzIG1haiAy
MDIxIG8gMTY6MTkgVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4gbmFw
aXNhxYIoYSk6DQo+ID4NCj4gPiBPbiBUaHUsIE1heSAxMywgMjAyMSBhdCAxMDoxMjoxNUFNICsw
ODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCAwOTo0
ODoyMkFNICswMDAwLCBDbGF1ZGl1IE1hbm9pbCB3cm90ZToNCj4gPiA+ID4gPi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID5Gcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+DQo+ID4gPiA+ID5TZW50OiBUdWVzZGF5LCBNYXkgMTEsIDIwMjEgNjowNyBBTQ0KPiA+
ID4gPiBbLi4uXQ0KPiA+ID4gPiA+U3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogZnNs
LWxzMTAyOGE6IENvcnJlY3QgRUNBTSBQQ0lFIHdpbmRvdw0KPiA+ID4gPiA+cmFuZ2VzDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPisgQ2xhdWRpdQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID5PbiBXZWQsIEFw
ciAwNywgMjAyMSBhdCAwMjozNDozOFBNICswMjAwLCBLb3JuZWwgRHVsZWJhIHdyb3RlOg0KPiA+
ID4gPiA+PiBDdXJyZW50bHkgYWxsIFBDSUUgd2luZG93cyBwb2ludCB0byBidXMgYWRkcmVzcyAw
eDAsIHdoaWNoIGRvZXMgbm90IG1hdGNoDQo+ID4gPiA+ID4+IHRoZSB2YWx1ZXMgb2J0YWluZWQg
ZnJvbSBoYXJkd2FyZSBkdXJpbmcgRUEuDQo+ID4gPiA+ID4+IFJlcGxhY2UgdGhvc2UgdmFsdWVz
IHdpdGggQ1BVIGFkZHJlc3Nlcywgc2luY2UgaW4gcmVhbGl0eSB3ZQ0KPiA+ID4gPiA+PiBoYXZl
IGEgMToxIG1hcHBpbmcgYmV0d2VlbiB0aGUgdHdvLg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBT
aWduZWQtb2ZmLWJ5OiBLb3JuZWwgRHVsZWJhIDxtaW5kYWxAc2VtaWhhbGYuY29tPg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID5DbGF1ZGl1LA0KPiA+ID4gPiA+DQo+ID4gPiA+ID5EbyB5b3UgaGF2ZSBh
bnkgY29tbWVudCBvbiB0aGlzPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFdlbGwsIHBy
b2JpbmcgaXMgc3RpbGwgd29ya2luZyB3aXRoIHRoaXMgY2hhbmdlLCBJJ3ZlIGp1c3QgdGVzdGVk
IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBQQ0kgbGlzdGluZyBhdCBib290IHRpbWUgY2hhbmdlcyBm
cm9tOg0KPiA+ID4gPg0KPiA+ID4gPiBwY2ktaG9zdC1nZW5lcmljIDFmMDAwMDAwMC5wY2llOiBo
b3N0IGJyaWRnZSAvc29jL3BjaWVAMWYwMDAwMDAwIHJhbmdlczoNCj4gPiA+ID4gcGNpLWhvc3Qt
Z2VuZXJpYyAxZjAwMDAwMDAucGNpZTogICAgICBNRU0gMHgwMWY4MDAwMDAwLi4weDAxZjgxNWZm
ZmYgLT4gMHgwMDAwMDAwMDAwDQo+ID4gPiA+IHBjaS1ob3N0LWdlbmVyaWMgMWYwMDAwMDAwLnBj
aWU6ICAgICAgTUVNIDB4MDFmODE2MDAwMC4uMHgwMWY4MWNmZmZmIC0+IDB4MDAwMDAwMDAwMA0K
PiA+ID4gPg0KPiA+ID4gPiB0bzoNCj4gPiA+ID4NCj4gPiA+ID4gcGNpLWhvc3QtZ2VuZXJpYyAx
ZjAwMDAwMDAucGNpZTogaG9zdCBicmlkZ2UgL3NvYy9wY2llQDFmMDAwMDAwMCByYW5nZXM6DQo+
ID4gPiA+IHBjaS1ob3N0LWdlbmVyaWMgMWYwMDAwMDAwLnBjaWU6ICAgICAgTUVNIDB4MDFmODAw
MDAwMC4uMHgwMWY4MTVmZmZmIC0+IDB4MDFmODAwMDAwMA0KPiA+ID4gPiBwY2ktaG9zdC1nZW5l
cmljIDFmMDAwMDAwMC5wY2llOiAgICAgIE1FTSAweDAxZjgxNjAwMDAuLjB4MDFmODFjZmZmZiAt
PiAweDAxZjgxNjAwMDANCj4gPiA+ID4NCj4gPiA+ID4gYW5kIGxvb2tzIHJlYXNvbmFibGUuDQo+
ID4gPiA+IEFkZGluZyBWbGFkaW1pciBhbmQgQWxleCBqdXN0IGluIGNhc2UuDQo+ID4gPiA+DQo+
ID4gPiA+IEFja2VkLWJ5OiBDbGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT4N
Cj4gPiA+DQo+ID4gPiBUaGFua3MsIENsYXVkaXUuDQo+ID4gPg0KPiA+ID4gS29ybmVsLA0KPiA+
ID4NCj4gPiA+IERvIHdlIG5lZWQgYSBGaXhlcyB0YWcgZm9yIHRoaXMgcGF0Y2g/DQo+ID4gPg0K
PiA+ID4gU2hhd24NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRp
bWlyLm9sdGVhbkBueHAuY29tPg0KPiA+DQo+ID4gSSBhbSBub3Qgc3VyZSB3aGV0aGVyICJpbmNv
cnJlY3QgZGF0YSB0aGF0IGlzIHVudXNlZCIgZGVzZXJ2ZXMgYSBGaXhlczoNCj4gPiB0YWcgb3Ig
bm90LCBwcm9iYWJseSBub3QuDQo+ID4NCj4gPiBCam9ybiBIZWxnYWFzIGRpZCBwb2ludCBvdXQg
YmVmb3JlIHRoYXQgIlRoZSBmYWN0IHRoYXQgYWxsIHRoZXNlIHdpbmRvd3MNCj4gPiBtYXAgdG8g
UENJIGJ1cyBhZGRyZXNzIDAgbG9va3MgYnJva2VuIiwgc28gdGhlcmUncyB0aGF0Og0KPiA+DQo+
ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9jb3Zlci8y
MDIwMTEyOTIzMDc0My4zMDA2OTc4LTEta3dAbGludXguY29tLw0KPiA+DQo+ID4gQW5kIHdoaWxl
IGl0IGRvZXMgbG9vayAiYnJva2VuIiwgd2l0aCB0aGUgRW5oYW5jZWQgQWxsb2NhdGlvbiBjYXBh
YmlsaXR5DQo+ID4gYW5kIHRoZSBwY2ktaG9zdC1lY2FtLWdlbmVyaWMgZHJpdmVyLCB0aGVyZSBp
cyBubyBhZGRyZXNzIHRyYW5zbGF0aW9uDQo+ID4gdGFraW5nIHBsYWNlLCBzbyBubyBpbmJvdW5k
L291dGJvdW5kIHdpbmRvd3MgYXJlIGNvbmZpZ3VyZWQsIHNvIHRoZQ0KPiA+IHJhbmdlLnBjaV9h
ZGRyIGNhbGN1bGF0ZWQgaW4gZGV2bV9vZl9wY2lfZ2V0X2hvc3RfYnJpZGdlX3Jlc291cmNlcygp
IGlzDQo+ID4gbm90IHVzZWQgZm9yIGFueXRoaW5nIGV4Y2VwdCBmb3IgcHJpbnRpbmcuDQo+IA0K
PiAuLi5pbiBMaW51eC4gUGxlYXNlIG5vdGUgTGludXggZGV2aWNlIHRyZWVzIGNhbiBiZSB1c2Vk
IGFzLWlzIGJ5IG90aGVyDQo+IHByb2plY3RzLiBSZWdhcmRsZXNzIG15IG9waW5pb24gb24gaG93
IHRoYXQncyB1bmZvcnR1bmF0ZSwgRnJlZUJTRA0KPiBkb2VzIGFkZGl0aW9uYWwgcmFuZ2VzIGNo
ZWNrIGJlZm9yZSBwZXJmb3JtaW5nIEVBIGFuZCBmYWlscy4gU2luY2UgdGhlDQo+IGN1cnJlbnQg
RFQgZGVzY3JpcHRpb24gaXMgaW1vIGJyb2tlbiBhbmQgdGhlIGNoYW5nZSBpcyB0cmFuc3BhcmVu
dCBmb3INCj4gTGludXgsIGl0IHdvdWxkIGJlIGdyZWF0IHRvIGdldCB0aGlzIGNoYW5nZSBtZXJn
ZWQgaW50byB0cmVlIGluIGNhc2UNCj4gdGhlcmUgYXJlIGFyZSBubyBvYmplY3Rpb25zLg0KDQpK
dXN0IGZvciBteSBjdXJpb3NpdHksIGNhbiB5b3UgcGxlYXNlIGxpbmsgbWUgdG8gdGhlIGV4dHJh
IEZyZWVCU0QgY2hlY2tzPw0KDQpBbnl3YXksIEknbSBub3Qgc3VyZSB3aGF0IGlzIG1vcmUgImJy
b2tlbiIsIHRvIGhhdmUgYSAicmFuZ2VzIiBwcm9wZXJ0eQ0Kd2hlbiBubyBhZGRyZXNzIHRyYW5z
bGF0aW9uIHRha2VzIHBsYWNlLCBvciBmb3IgdGhhdCAicmFuZ2VzIiBwcm9wZXJ0eQ0KdG8gYmUg
c2V0IHRvIGEgY29uZnVzaW5nICJjaGlsZCBhZGRyZXNzIHNwYWNlIiB2YWx1ZS4gVGhhdCdzIG5v
dCB0byBzYXkNCkkgaGF2ZSBhbiBvYmplY3Rpb24gYWdhaW5zdCBTaGF3biBtZXJnaW5nIHRoZSBw
YXRjaC4NCg0KTXkgbWFpbiBwb2ludCB3YXMgc2xpZ2h0bHkgZGlmZmVyZW50IHRob3VnaCwgdGhl
ICJyYW5nZXMiIHByb3BlcnR5IGlzDQpjdXJyZW50bHkgbWFuZGF0b3J5LCBhbHRob3VnaCBpbiB0
aGlzIGNhc2UgaXQgcHJvdmlkZXMgbm8gaW5mb3JtYXRpb24NCndoaWNoIGNhbm5vdCBiZSByZXRy
aWV2ZWQgZGlyZWN0bHkgZnJvbSB0aGUgY29uZmlnIHNwYWNlLiBQcm9wZXJ0aWVzDQp0aGF0IGhh
dmUgbm8gb3RoZXIgdXNlIGV4Y2VwdCB0byBiZSBwZWRhbnRpYyBhcmUsIHdlbGwsIHVzZWxlc3Mu
DQpNYXliZSB3ZSBjYW4gZG8gc29tZXRoaW5nIGFib3V0IHRoYXQgdG9vLg==
