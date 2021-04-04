Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D073538D2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhDDQVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 12:21:40 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:24292
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229861AbhDDQVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 12:21:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM/nVTdob1IhjTmvLoGLjQCGFOJCK6p+Y0tnbiXrdHTv1C5DO91Wp0Sj1RpO1bhpPMQsg3zGe4ZgmMgvlb7h0AkBKJ6g6WhDUQTyFHMLMphmE4wqpLFuFxJScZhiYAWFIsRjxijDyreyFzikMaKeF56jyqb4cgdWVAz6WodUW6Es9N3Fi7KLrLBQWxTV/3LFSwUgnPm6xpQoEYMoWi+MkfsRWzV3s86QCQEAjuW7JFCn6R96gAP9UqoMPcZ8jApgtx1UD6W7iOBtPxKiLOYacwglwrLjJCtB1U2ymJTH5fbr/3eZVTlTkcm/Ef5cqEBtaR15KDxxUjmGTVVdB9/PpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiUHVF0fWufNP/z49mTjUiNJXACeFSNSgz1lU8RwLiM=;
 b=g3P+Ezo64w2LTgGKzlCwt/o01RwfsBId1ZaSfjC8Z7x1amJxyocYUN4CiMAV75jFt5G/mXtgo6GGBCVYkQoz0/LqJjIh/Nh+G4OVjhkoOSEz4zU4FbJiXvKFKK4AA/pcXtuK0faSE+YkjQfA7GEd+zygSbExdbr1ZbCFrj+2NJ/ihqkLk7/VSZ5oeBkSV1HHUfWvKKflhv9mOzTVSVyImWU3CoqF99/TSC0ETjGkb/aN1mKvy8KD54LwW4g9JLLZwa3yTVe3M7HE+sTeuvUO4XG4nx2+D/kJUHyzyL+gb9y7wpP7Nl571DJzUHtbf5iRD+F+Y3uH27jTjs/oPY4JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiUHVF0fWufNP/z49mTjUiNJXACeFSNSgz1lU8RwLiM=;
 b=e9wfxGyjPcrJXY2KgJ7yRcWzapden4dsx6yN82WMT2GtIeRng04CB239pFirVxHLT1jL2rut8TIdkyqLKZpXP1IXXqI6Q/U12dMr9OFk0bswlJL/eOYiI/dkMETgZ81ria8S+VgWH4CjD8jGeAx1mGC6Owfa2clKuZJK16YRDtQ=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2665.eurprd03.prod.outlook.com (2603:10a6:3:f0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Sun, 4 Apr 2021 16:21:27 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 16:21:26 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v5 15/19] regulator: Support ROHM BD71815 regulators
Thread-Topic: [PATCH v5 15/19] regulator: Support ROHM BD71815 regulators
Thread-Index: AQHXJJt1XmMiZln9KkGiE9saW20FG6qhhdKAgAMOFQA=
Date:   Sun, 4 Apr 2021 16:21:26 +0000
Message-ID: <a387f856d3a5d4b01124eb54c5b9476bbd61c86e.camel@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
         <eb20a8f466a9ccbc26d261f0102d203718a32fa0.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
         <20210402174215.GI5402@sirena.org.uk>
In-Reply-To: <20210402174215.GI5402@sirena.org.uk>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a90c60f7-461f-478d-8035-08d8f785b272
x-ms-traffictypediagnostic: HE1PR0302MB2665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB266511AD8FE896C06A01F95BAD789@HE1PR0302MB2665.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OSW2hRYC6Jw5BT6yByZvwDyqjDjiwHluqeoMbqFOR+WpWHXcbo6Zqg7+c5hTz4Qa6uAHAiapTy74LtwEjo4uCofxonyQequrI/dsk4LXjquLFpfB6RKLAbUJNVOINtjghxMtcQE2RnfY0R1xv+gNCrJyo6qxy5D9tn17AVdhoveLfH3zsMGXyAlPiyskEkDH3tPM/TnZxwiFsDGPfIHj4QQz0Mvi46PJivtolYe8K8h8ihwLsXrLN9M54afCCQhrDAgN5gRWd+ZbaPEnHf+rx3MPH5EruSuyBlJqsipzAcOQEYAjNZblcRP0b5aDbM1lKm7/5BTGRHdDv6OJtoXsUETnzfuGNcxh9sAC39/en8nPdnYfEvKOBlAPx1EOyr71DcIU53bZYlT3lHYwc3Jypw89ipSkyJdLk+R9ukCDto7sU8R608XiGUp5HWGwOm33pSOCmIyugMZVPetTyt/JviHIuu2lCppzrD58nym/aOVwNEqPh+e5SG6Q0rEI0xV8Hhjl9VrZiNlYXv3UfaS+fev0ReLOX0rq3Zhzx+C95w3XaIqYhHpciTI8kgQnkf91dJcmHsE3qckkO2wFvgTe3ORv7ubWSfZW+EO8hbNJcQyamNVo7jh9SesfsCIY3PHezbPcMMOSILGjlQbeSOuaWpzaFv1nBF+BHZ1qsFTRVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39840400004)(186003)(86362001)(54906003)(2616005)(6916009)(71200400001)(558084003)(5660300002)(66946007)(76116006)(64756008)(66556008)(66446008)(66476007)(8676002)(8936002)(316002)(2906002)(6506007)(3450700001)(6486002)(478600001)(38100700001)(6512007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NG5wZXA4b2N0Vy9yNnJTKzlvTWlnNG5sb3NJUi8vcXdFVTBGTFV6ZUVCVFBj?=
 =?utf-8?B?di9vbzFlRmRmV2FxOU96eE4rY0lRV0d4bUJvS20zSmN3TkJJRnZrQ2N4SDVr?=
 =?utf-8?B?eU1NY3FlQ0MzeDZJdWVvejBqWGRiKzkvNHA2SUo3VTNrK2pXcy9JL1QyVFRP?=
 =?utf-8?B?SlJsa2FKZXRjSThiT0FlcFB3NXJZdi91R3JtZGxlNGF0ZnBob3BMd3FSRm84?=
 =?utf-8?B?Ui9VRXM0cWV0R3Z1OHErRVZxRitUR2NSS05yaG1wd0JqU21kSTZTN1JGOS9P?=
 =?utf-8?B?Z09WTEt6UzAzaE04VUN2VXJLUVg4ZUlnNEhWd2xUbTlrY1Fjcnl1SWNIRDFT?=
 =?utf-8?B?OUp4SVc1RFhnMEVrNHpPZllOd3VDMWI0M3dQZnJLSXhlVXU4ZkdGdGJNQjJ4?=
 =?utf-8?B?ZDM2aGcwZHJwMVl2ckZCa2RFT1lCb2JROXptZGVvR0xOV004YjMzSjlmTEF5?=
 =?utf-8?B?SlliZkx0N1lST0QrUVhDTVpLTGtKU3l4Tm51WUtwYTZIK3l3R1c1N0dqSGJU?=
 =?utf-8?B?cUY1U1RBQmFFLzNWNGJpU1NGVTdWeitBbHZVK0tBZFkvSWoyU3RwaTZNVERy?=
 =?utf-8?B?Y0JzZytiamkyd2V5ejFwdG8wb1Z0RFI3Mm5VSVVzTFc2RFZSRDVZenhYTlNs?=
 =?utf-8?B?SG1PTE84Uit2eXNlVDNwQkRKYU1Wb3FMOXpZZkhIb2ozc3JBS2pjbzBDZ2pr?=
 =?utf-8?B?QURVYi9FYm9abHRzYVRmeGhYbFNmdEYvR2NMWE8yV0NVdWFNeWNkQjhtRFNr?=
 =?utf-8?B?QUZsN01WVERUTk0rYUN4N2tHOVArQ3NRSXJGc3BaWWlXQWVPVmJmaVdkcTRh?=
 =?utf-8?B?K25VVFZNSW1NN1RoczdENFVMRDJLRzRTdVJ3U2JUN1h2MHRSV2tzRHNpRWV0?=
 =?utf-8?B?Z0hqY25EcjErN04yRWdiaWc4UHRFY0dmM1NEcGlWaUNIeVA3cE1rQURkWGhj?=
 =?utf-8?B?QmJxdzZvUlR4MG12S1ZqUFdxNitwNnd0KzhtZXhKZkVtTHdMZmdHTWVPMWll?=
 =?utf-8?B?c005SnZueExwd0NwQVRMSm1JOWliSy9NVzczT2hMNkp2NWxqajJHV2JNNThI?=
 =?utf-8?B?ODYvZFRPVGFEeXNUNTRZdXJteUs2V1kyZHdKNnVzR3hjYmljYzdmY3FiNUh4?=
 =?utf-8?B?UnhtWXR4a3N1Wkt3ZDNXdGk0TnFEZ0NHNUpjRHZpQzFBKytiRjVIRG4wQ3hr?=
 =?utf-8?B?QWZaTFlUZVV6ZFovelhHeUt3ZGZETjFualV5MXRMazc1Q1FTVzZxbXRTemZ3?=
 =?utf-8?B?UXg3MFA4L25jZk8yZVQrNnJiSWxjSmhOWDhuQnhTZ0k3SEpuYlRkbi90WlUr?=
 =?utf-8?B?WnRvNG0zRFMyby9VaXlFNzg3WThZR3VGZ2dHb1BXaGxBT0NpUzAyL2lWc0VQ?=
 =?utf-8?B?bi8vMHJ1WXJ6MHQ4NC9Ed2plaEYvOVhGN0ZUUW9WdW42M0Y0Y3FYTXhxL3BU?=
 =?utf-8?B?bE0vTUxzWVMyUzF6TWVHS0NzSGw2SEtNTElic2lRd3pKRXUzckxmNE5FV0k4?=
 =?utf-8?B?T3EzUHgzcnlQWlVIRDhwN3BoZlRiZktlTk1tNVppdUZvUnphOUZhSFdmbm52?=
 =?utf-8?B?YkVqUTh0RXJ4dEd6SmcwM0dEckFlUkt0SEJLQ09GdHJlK0g5RG1ka3FLb1I4?=
 =?utf-8?B?R2JLRDNMc053MG9hMkdwNzJWQjhnQ1hYd2tMTFJyUXRsM2ZScFFBdS95MFVv?=
 =?utf-8?B?am5jNzZJM0lDdFF2SFNRakFWckV5SzNtbE16Vi8rcU4xNnZkVjJIdWJQQXZC?=
 =?utf-8?B?ZnNGTGl6MXcxTGh4Lzhwd0VYTmFLVmNSV0FCcFVvVGlwRG9VMVVnekc1bExm?=
 =?utf-8?Q?R5mnPwK4DBk/R+i32473Z4aykcEk+TBI11OiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B4FCB65F55A244848D9BF7374BF8D9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90c60f7-461f-478d-8035-08d8f785b272
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2021 16:21:26.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aq0i7dq5nwC867HwL8nlD4wggkTumP5F7fG3AkiPl2qBXlqClSVoqgR03NqY1dKlC+nkwgmVD0ar+4FysjKtHCnc8oMw01dcZVqO16YtPHTinZmyeKCD5CWnfs/N0DDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2665
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjEtMDQtMDIgYXQgMTg6NDIgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIE1vbiwgTWFyIDI5LCAyMDIxIGF0IDAzOjU5OjUxUE0gKzAzMDAsIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gDQo+IEFja2VkLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+
DQo+IA0KPiBidXQuLi4NCg0KRG8geW91IHdhbnQgbWUgdG8gcmVzcGluIHRoZSBzZXJpZXMgb3Ig
ZG8geW91IHRoaW5rIHRoaXMgY2FuIGJlIGFwcGxpZWQNCmFzLWlzIGFuZCBmaXhlZCBieSBhIGZv
bGxvdy11cD8NCg0KQmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQo=
