Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC293804EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhENINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:13:50 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:65206
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229654AbhENINt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGRwiaBiv2y822u9EvK4OhColaO7QpdGAmxrqWelIoIpir5aTLm0FJoWKXFQXPQhCYZ6IkmbF2XbYf0Z27tujHz0H5y1+7fmacITwLLOyC6d7lWOT163par3msN0kSZlD2ZKqk5DPqE71Xt7MigL4VkZi2so2Sr7QvVlkV/3XNNYbeE/k40HueWl9EWIaoaFo7JwFmKOYW+ZEBo6Y4u8pXQuGhVUnDiGtTFAhlkOz3dds+JV4CjAo7mPiz5AvzY6Y+YF5f21up/Q+VE5GV7x7EtPMx3iSHvAWZUVmu86sJVvqVfbxBfNlmlVHVH27WICNTgO6NOudtHaKDEG4oRmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEsVRAuyfMkSIdHNhS7IFji82TjmQ+OMQcxSGtfcRHk=;
 b=It4+4HxvvMlz3sCexCJX8hcak7PajB9sdNxqrZQhVEHW4hHaub2hnwvCvBmRINaPJo+bHl+R2mtv9KilNMKigGwlb9X4vKEE/iSpOBbHTHqknZcvB315qvL3x/v3CZX7921FvApHrkGMStpjnhm4XkJ2GnE7P+MM8/rtIKFviIN6mf3/xRvcAiSX37wf7yQGb9OMqbQ1ocLTf175czS0QbS7Sy5AnQa0uHdPmHes82ADKlccpf3ERXBmCReY1oDN1EAoPRrmIZCv6DMQIc+z6oyQ4UCXGIF1E1YLR3qCQVi12PQt7rTRqkO9+ss6KAnUrGSFqvTDd7MlH8BCzWXcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEsVRAuyfMkSIdHNhS7IFji82TjmQ+OMQcxSGtfcRHk=;
 b=tJd2IT1hIyr9M5rquApCk1aosAFbR70Dvnf16EnaQQcs3ifdcthVlKE9+D8DZDjm2a/BWrCN4gJlfsVsWP69ppFNESSqbbvNmoigqTl6FuM4iTwdugeAChbjq4c5GYsppSuqXh9EvIC75nws8M59MiS0FaqKc1o5Sigm1itaxm4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2892.eurprd03.prod.outlook.com (2603:10a6:7:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 14 May 2021 08:12:35 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b%7]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 08:12:34 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] extcon: extcon-max8997: Fix IRQ freeing at error path
Thread-Topic: [PATCH 4/4] extcon: extcon-max8997: Fix IRQ freeing at error
 path
Thread-Index: AQHXRXRNk4IBjrSCh0GVY2/NQAmyoKrcxK6AgAG1azeABCzGgA==
Date:   Fri, 14 May 2021 08:12:34 +0000
Message-ID: <b4a88b987117120e055f230bc83c029e1655dd1c.camel@fi.rohmeurope.com>
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
         <9047a741b4c4d97e721ed8b48cc4b434a46acba3.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
         <edf3ff4d-8bd7-17cf-0d7c-96b4f704dddd@canonical.com>
         <978a829103c768a01ed8a1b37ea607ea5fb0ddb0.camel@fi.rohmeurope.com>
         <f5b5c30f-9a84-459e-d3c8-5a5760912cb1@canonical.com>
In-Reply-To: <f5b5c30f-9a84-459e-d3c8-5a5760912cb1@canonical.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa70d399-0eb0-4434-71e2-08d916b007b5
x-ms-traffictypediagnostic: HE1PR03MB2892:
x-microsoft-antispam-prvs: <HE1PR03MB289268042B1B84EDE7579E9AAD509@HE1PR03MB2892.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ehd7QZfncuzu1eVotgFP2jRPtVytSifT6ks3Bzp09XxUXnMCdDS6a4krpqQygsvt+thCWXWZyXYObhBC1L+FcQDIopwt+71eiE1JTckK7mFFTbc+s6Ul3gtKMB2DHcRVSP4Hz9oolvJLkCleK+w3Pj00V9BiI5xDS4O3nACmfCl2tO312bZyK5Rnd+voY3dOtxzrjETTd8LRMTJj/kKGVahI93DyXQPMJzo0KFWZYstbpo/FkR46vkxlBuDn5RcvXKK2eXcFnBGeF9Z15skh5qHvWGrmtEGDMZXPNDz/p6A23TJLqbvyaxU0Qy/BGgTVJDQ6IoSzC62VJxY1ma4Wf+sy83ybvf5FdmxTKAxxszc6FE6Qjow+9upTMRuL2Nh/0T3hPw+pLa/+tixsG0/sGWeUyHmRSVhKHDKNP+NCzfA9CZGZgT4fFpoPE6lFQ+iF6XKCvVjwMo6DqHhi9TPgILFan6JOndUIPZsDHfFru8Blr1kZpgVJbzDPr3jTHxlvGplIXPa+CB595MvhBidLszEVjWIRt/F/Cv+7Xb31WfLGOj4ertc5oClKQqJ7Sv7K0UxkRyKsPxqMowVk8wsU8M9ctuTQi1JaLq5ONFxwa4U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39850400004)(396003)(346002)(5660300002)(86362001)(26005)(3450700001)(38100700002)(4326008)(186003)(8676002)(6506007)(53546011)(6916009)(64756008)(2616005)(83380400001)(66556008)(66946007)(6486002)(66446008)(66476007)(76116006)(54906003)(478600001)(71200400001)(122000001)(316002)(8936002)(2906002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z1lzOWJjYWtVdEtOblVsemdGNEZhMVcvTUw2Q0NaNjcyUFU3eS9ReTBOL1I2?=
 =?utf-8?B?QjE3Q3RKbTZoVGtJOWpPM3IwaGlUOVFqekRtR0UyMFlWYmVsTDVaanQ0SHBo?=
 =?utf-8?B?NldtcVlQTzZMYUVZbGFoTEo5aFd4QXB1OElUQVdzT3hHMjVyRjdBb0tmZkpt?=
 =?utf-8?B?Y1BKQjVTN2YrMEhDanZXT2ZCM3hEK3ZJUkgrZ3lOQ0d2VEc0TVV1bFlTWUpa?=
 =?utf-8?B?dFk5dWZGcTIrV0d2QzZ6UDRjN29CZllwU0J1eDFYYzhESHVZelJWT1dJa3Zq?=
 =?utf-8?B?L0pYYlVaSUJidjUzMUtwVzdaeGlHQ1hjaHpxMVZhV3hIK1pQWkpEc2d4UWxk?=
 =?utf-8?B?aGo3bWZOTWM1aWRyNnhLYnE0KzhhVFJuT3VRcUdhNkZiNHlUWGV3ZGl2M1Ny?=
 =?utf-8?B?Tlg2RjdRRGlVdWtpaHNpYzU0d0tJR2ZWc3lLZ0ZQM3c4N0cvYjNaSi9CQzVU?=
 =?utf-8?B?OFYxWDNCRkxjd0prS000KzJqcVlHMFQwUG42S2FKY2lzN2Jhd1MrNklBMGNV?=
 =?utf-8?B?anY2Z3Y4V0RIUnF1WlQrK1MwNGZ5ODZNaWYxNnBDeC8zTUlINElFRlFZMFJF?=
 =?utf-8?B?UGxnLytHNU93VlJDYkd2a1hIYW1ZV2Z4a2l1RERvTUYyNTJRb2twbjYyVVJ5?=
 =?utf-8?B?UlZFUTlUNHBYZTk2VEZOS2F0eFN1cXRkbG5tTmJ6Mlg5REJoUE9iMVdQMVls?=
 =?utf-8?B?MzlDYXdQd3JYT2J0WXh4RTRoOStJemp2OUkwaUhCblo3S2E0UnhMdXZ5SzhU?=
 =?utf-8?B?aHBOclNsSTh5azB3OVZZM2JCZDl2MDFVM1o0RDJ6djgvSHdtaTFxaktkZ3da?=
 =?utf-8?B?RTNBeGI5VjdHWlUyUEpCMHN3R1MxZy9xRy9CZmVHaitFYzZUSE5rcVJwb2Fa?=
 =?utf-8?B?SVRySzU2clFEMGh3SzQ5VHBtbXg2QjlLZXIrSkp4eFVrcERIeDlFRGFOWDBt?=
 =?utf-8?B?V1Z0T2h6ZmUvempvOVJaeDVuUjVpa21kazl3L2RMODdhTTRtY0pOQU05M0g1?=
 =?utf-8?B?cFZFSmtmK0JQSWRNRENQQzAyWjN3ak1zejh2SG0xcW5TQ0JIZU1BTDhsTmdr?=
 =?utf-8?B?VnI5MXZqNFowYXBZcVB1dnZuN2pLV1NMYkltSHA5Q1hJdHVMbkpDOUt6Z1pZ?=
 =?utf-8?B?RVlYamhpV0V2ZWZJaG9yWmNJUUFtZzZRSFJVcnovamNaM2ZlNW1KMGF3czhh?=
 =?utf-8?B?cHNmc2kxWGF5Z3pxSjEzVEREY2srcFZ5YVIvR2Y4SWk5ajU2dkhYM1Q4T2F2?=
 =?utf-8?B?K01pbTJDa0hrVGpQc0kvREdMc1lpbTF3Wi8zT0JKOWRwMFp1OFVXbmR5L2Ux?=
 =?utf-8?B?Tnc1Z1BWMW1zYWM5NXZtWXU4bjkyUDVMcGp6LzNSUWFXM2RuclVCd0xVMHF2?=
 =?utf-8?B?eHhjbmdoYkV1d1NNaCsxV1QvdWVROUpBV1BWd3JpMnpNVDRjVTdaTTkvK09y?=
 =?utf-8?B?bkJrei95SFFGcjNseHF3bmVMSEhYYldQOWJIa3lBQjFhWWRNZDRJdDlKSmVp?=
 =?utf-8?B?bFhXNkdkVDdzWEQ0THl5TzRXYkxNREczV3RFUmpUU01SVUo5aDVKY3BTbW8w?=
 =?utf-8?B?TnRPL1YzZEZZS3lCdVhyWmtIeDVjb1JwYzB1ekZ3bzZhK2h3cDJYNTgzWlNK?=
 =?utf-8?B?QVpNdHM5azJxTmV1dWo5d1UwVWNaNlJPQnlaQktjNC95Nkp4M3htdXBTNTMv?=
 =?utf-8?B?c1NBQWxncFEzUGFNQXNRNWJRNndmSGlpZXRaQm9aUVZxWEdJNUtWMThtb2I4?=
 =?utf-8?B?YytDWmttNVpqdTMvSjhFeTlUV0xJNlQ3NFhyaTc2TDJEd3ZkL0VpMUQ0WDI1?=
 =?utf-8?B?SFlrUHYyRHVxdW5vT3hJZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4471927DACC3BD45ACB3B1F1ACC97534@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa70d399-0eb0-4434-71e2-08d916b007b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 08:12:34.7405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rc1FVsrcpH5x3wt0FGLkE6Cm71QMVv6mMb58aZfdPs++k9vyXgk8ULBB+CZScFo6HS8KWVO+O3pr4YkonPFVS2p3zGL3c4Wq4NpjMwkRJilYMWtw4qGgszzRhwboH+oH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIDIwMjEtMDUtMTEgYXQgMTI6MjcgLTA0MDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IE9uIDEwLzA1LzIwMjEgMjM6MzIsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4g
PiBIaSBLcnp5c3p0b2YsDQo+ID4gDQo+ID4gT24gTW9uLCAyMDIxLTA1LTEwIGF0IDEwOjIxIC0w
NDAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gT24gMTAvMDUvMjAyMSAwNDox
MiwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ID4gPiBJZiByZWFkaW5nIE1BWDg5OTdfTVVJ
Q19SRUdfU1RBVFVTMSBmYWlscyBhdCBwcm9iZSB0aGUgZHJpdmVyDQo+ID4gPiA+IGV4aXRzDQo+
ID4gPiA+IHdpdGhvdXQgZnJlZWluZyB0aGUgcmVxdWVzdGVkIElSUXMuDQo+ID4gPiANCj4gPiA+
IFRoZSBkcml2ZXIgZnJlZXMgSVJRIG9uIHByb2JlIGZhaWx1cmUsIHNvIG1heWJlIHlvdSBtZWFu
dCBtaXNzaW5nDQo+ID4gPiBJUlENCj4gPiA+IG1hcHBpbmcgZGlzcG9zZT8NCj4gPiANCj4gPiBO
by4gVGhlIGNvbW1pdCAzZTM0YzgxOTg5NjAgKCJleHRjb246IG1heDg5OTc6IEF2b2lkIGZvcmNp
bmcgVUFSVA0KPiA+IHBhdGgNCj4gPiBvbiBkcml2ZSBwcm9iZSIpIGludHJvZHVjZWQgYSByZXR1
cm4gdy9vIElSUSBmcmVlaW5nIGlmIHJlYWRpbmcgdGhlDQo+ID4gTUFYODk5N19NVUlDX1JFR19T
VEFUVVMxIGZhaWxzIGF0IHRoZSBlbmQgb2YgdGhlIHByb2JlLiBUaGlzIGlzIG5vdA0KPiA+IHZp
c2libGUgaW4gdGhlIHBhdGNoIHRob3VnaCAtIGFzIHRoZSByZXR1cm4gaXMgT2sgYWZ0ZXIgdGhl
IElSUXMNCj4gPiBhbmQNCj4gPiB3b3JrLXF1ZXVlIGNhbmNlbGxhdGlvbiBhcmUgbWFuYWdlZCBi
eSBkZXZtLg0KPiANCj4gSSBzZWUgaXQgbm93LCByaWdodC4gVGhlIGZpeCBpcyBiaWcgYW5kIGNo
YW5nZXMgdG9vIG11Y2ggdG8gYmUNCj4gYmFja3BvcnRhYmxlLiBJIHdvdWxkIHByZWZlciB0byBz
aW1wbHkgZml4IHRoZSBwcm9ibGVtIHdpdGggImdvdG8NCj4gZXJyX2lycSIgYW5kIGNvbnZlcnQg
dG8gZGV2bSBpbiBuZXh0IHBhdGNoLg0KDQpBZ3JlZS4gQmFja3BvcnRpbmcgZGV2bSBXUXMgdG8g
c3RhYmxlIGp1c3QgdG8gZml4IHRoaXMgc2VlbXMgbGlrZSBhbg0Kb3ZlcmtpbGwuIEknbGwgcmVz
cGluIHRoZSBzZXJpZXMuDQoNCkJlc3QgUmVnYXJkcw0KLS1NYXR0aQ0K
