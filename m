Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52D73571D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhDGQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:09:58 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:51486
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236439AbhDGQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5UkW2DrdyQMfuEpP+DOlth31juhqdqM31cFXsHWJQpbzS3ch+E+RUBk5rOEVSuSRe0EdVxhxYGGYsD3E3DJYLcgRoKF2L9YmoyEcPB1E1uR0b/nxCTEp9Zaeu8alS12SSd1Ct7+bwm2lyM47f5Oh4fnaP0bdhf+PW7u0nVHneety4JD853+/KnJwCYtD5qlq1C78BbFTe/BgWuVtjLvHlSl4CojZ97mmAZUVvrUpyaTKQ9Ld/O2MAEyQU6ukqql8o/gg0RR2R0qgCqulBchdGHqNF3ZB8lbjX/MJUCz2n8mxxRbOeMQDZ1n9Gvq3sxwGJqGNc5XwsUJBoVhdhbcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bXXnAXOGfYO8jHtVzAsYOOifV5I7cV+pKXVb1ROw5s=;
 b=n6PEnd9BQgW37swWkK1xzsezCKKSnmg972szlwqtbPU+tsHsrPUt4BRgNu9ezHF4RRLT2SQBPuWzAvCMJ+L7SPTYIN6v6oXed+c4SMmpp4tTQpPgf03t9Th7Wz9inv7uX3NFkL+K4aZ9nqNdVMqZjN6BIqzMTxAoO+A28+qBRgYHT7oZeZVFgJuIoVAf1HqT9RT72eaZd6bNitPxli0OioYIcKoK9awSIGi2m3ht8kD3u2cZDmkD5OlLM7W21f5Ll//IzazdjpoRP9IJoYiJuGzPSy/YkkjOOflkPiG623DLRXmGfKU10kAqbYjqIEkKG0Y3xoaHZedp3PV9aDkfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bXXnAXOGfYO8jHtVzAsYOOifV5I7cV+pKXVb1ROw5s=;
 b=UEqYDZInEjSey7vYzE7e2K9z+4McGQ/acV9Yx0wgQRB7GsD64Goz4FcwD0UWtWbmU9Pk8Pcb77524Na42OTUE3rN2XtmYsTt9f4oSpsWFDaS7hjRPAcn/3vWbAk0ZG2nXXKDCEZksnFBtdmejXKcUouUgXDQFt6p+RKcOJgu0Dw=
Received: from AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fe::17)
 by AM0PR10MB3028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 16:08:44 +0000
Received: from AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0bc:c738:6a49:c60]) by AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0bc:c738:6a49:c60%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 16:08:43 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Subject: RE: [PATCH v1 3/6] usb: typec: tcpm: update power supply once partner
 accepts
Thread-Topic: [PATCH v1 3/6] usb: typec: tcpm: update power supply once
 partner accepts
Thread-Index: AQHXKoVUQFsHLYQoSUClgf4trRM3oaqpOx+A
Date:   Wed, 7 Apr 2021 16:08:43 +0000
Message-ID: <AM9PR10MB4134EC102F0017423E6822B480759@AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM>
References: <20210406013643.3280369-1-badhri@google.com>
 <20210406013643.3280369-4-badhri@google.com>
In-Reply-To: <20210406013643.3280369-4-badhri@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8dfcb39-0e8b-4d0d-4c07-08d8f9df6aee
x-ms-traffictypediagnostic: AM0PR10MB3028:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB30287B897680179BC6D6590CA7759@AM0PR10MB3028.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tx/69RQ/m3LJ6+y9K6RbXRmuaADBHDglcCaxGV6QpQMXJzJIDkcF/9Y/AU8wWE1wWFZ1NxJL0kaBbw3BPxCUlOohGtMLKo+2hlfyc7wSNi6y/y94yvyYnOXo4zfI73SlHlu3RrBtwKos6NYygJ6vWoHkEU9PvpzM/4BQHFOE0HXj5eFGOzM4XJy2AyyYBqwbrm1xwkrkc4KrhTz82YSJBVfp7ROKj3BU1ENwFbVFuAamddu57ESnb3fVxLby9T7RYcENjId+k3F6Ov0MM6radH6a3w40hyYKBKbqopfajg9EBCputGSG4A8j+M/B/VPyHsn/K17zDLVkAXTJ88LPsCXDuJL7UolPOj/pQTrf6Ly/9ujpTOETUjptFzf9BHbsuw8LOjPqwE+oNieyTh0Srn4HnVMZjH0QW2hfsZMsd0833In+d/1y6n1thTAAocWFghECQEDVKNOtLsnlNYfriav8chjvrtL3fVPPor1k5Z1xAC3SfpGAVBkP9ia2MAE36ApR9sfbdJuGRQkddoS+1VG00ZhpQJAkyVhY/AiqcQG4T41nkONVtvhnQdNUcy70UAF2TAyrTQFN9Uw0V7TGJZjUOeL6RATCKuNOR6ivM5O6ykbetsNfNIV+rb0wpvGM3E8IL4aeINU2OQr+z2SqhXb7X5SgsBv8bZi7c7aLbd8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(8936002)(83380400001)(33656002)(26005)(9686003)(478600001)(110136005)(4326008)(7696005)(66476007)(66556008)(52536014)(54906003)(76116006)(2906002)(66946007)(66446008)(64756008)(55016002)(186003)(38100700001)(6506007)(5660300002)(316002)(71200400001)(8676002)(53546011)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SVZENFdTY1hUT2FwdGhJVXJaNzY3RWQxeERob3V2NE9Bdkx0dnJET0dDN3Bz?=
 =?utf-8?B?elZBL1MvYWdRdHRFZ1FPK05OTlRadUxlRUJTNUlsZHllUnhYbkRHK243azJE?=
 =?utf-8?B?ZkhTcWMzTjZUMkJOelk0S1V4ZitxTjVnUytTWUxjRFozSFA5eUZkdmVCWDV4?=
 =?utf-8?B?MWRKQVZoTldIbE0zb2hQdGNaRXdKRnRhM0hRcVcvcTVPV0xGaFFIS0xUQ0hO?=
 =?utf-8?B?MjNjY2VqK3NEbE0zdElNbGZ3Ujh4OC8rMnQ5RXh0S3hHTUpWSC8ybVFKTEZm?=
 =?utf-8?B?bzNZTHAzeW1nOTAvbjJ6NjRnRHkwajRsVDlSekJBQkFOYkd2NXJWZkRjRjlF?=
 =?utf-8?B?Znpjczk5NGc1U0hwZ1VweVN3RnBRR3R0UHkwK2hDdE9GTlRYMGpRcU9aK1px?=
 =?utf-8?B?ZjdtbVUzUHM2c2x0R1k4c3plTmtkcGs1WjFubFEwWE5UcnpLYlNBOXNva2xz?=
 =?utf-8?B?WjBEQStTU0V3ME4vUWdkcSs2bW1Eb2tUZjRqbUJiSzFzN2ZzN2lWQTdYS0lW?=
 =?utf-8?B?ZDBraFBtSjZ1OFRiOThmdGN3SjVoTVNEcWUydEpZUUkyb1I0Y1NZVjAwOFY1?=
 =?utf-8?B?Y2hqUmVkQWxya3NGdWRJTk10T2dFWmdyRnQwbW0rN2hmRE1ZR2pPQzlKT01U?=
 =?utf-8?B?UU51R1dKaHE0cFlZWHphU0xUYUkwR1ZySW1vVTlYaHpmNGZKZXlISWxYSXlJ?=
 =?utf-8?B?UkxUYmQ3dlkveTZ6SndQSzMvdDR1d1FLaHhRZCtYVzNBN1FIRDlTVUZGMXVE?=
 =?utf-8?B?RWlTTU5keVJJbHp2bVNUNGFjWlhuVnQreGJBdnNpWDdMZVlON0Q5SUk3aDVk?=
 =?utf-8?B?Um1VYkdMOWJMdEp4LytnUzBYNXl5TjFzUG5ocG1vWmJneEFqeXVHZGNnbEYy?=
 =?utf-8?B?V05jQ3RhRWVWNlVveTVBU09ETWJEVEF1anhUNGFXNE9ETVRXbG9DaDB1NTFn?=
 =?utf-8?B?Y2VaNFZ1OFBRNlUxOVpTM3hFdW1sTXlFcUhFYUtyUHhlQnJkM0lUOWlkczdY?=
 =?utf-8?B?c0Y4QVRpUnNMTFMyRzI3QnlPaERKSzBBcUFOWkhQeFZlUm1SQlZrV25vWjFN?=
 =?utf-8?B?Z1dIdTFKSUp2T3I0anVtSTdQZ1BNRHFaMWVxdlllbXh5WXRJNGVmSldFRWd5?=
 =?utf-8?B?dlc4RDZHbTNnREYvSVZtdERrUzRmMnhxV0pYcEJ5OVpLN0JXT0V0MVVZZndM?=
 =?utf-8?B?RzFrNFBhMDc5RkJwQUJmczRCUVVxSS9NNkhkUW95TUs1a3F4Zk41L05rT1Jy?=
 =?utf-8?B?Snk1Y2hmWlVpdSsvNUxXTEZmSXEwVTk1clZqdzdIaFVWWkxpNmVtc0RYQ2dF?=
 =?utf-8?B?eXV6R2dSdTJtUG8ydjFvRml3eHVHbHVpQURXVkZyV295RlIvbkVldWtKYXlw?=
 =?utf-8?B?d0E4ek4rQ2ZyZ2xETTF1d2loaklGV2F6aE1pZGdrclJsdUtnK2NRdTg5OEhR?=
 =?utf-8?B?dTRTYzRkUUpUa0xnLzl2ZHMvVW9qdDNOTzNZaW5BLy94SmFjaHlEUzllL2Zk?=
 =?utf-8?B?aHFnQzJ3TnZEQyszMWJ3dnRLRVlMY1dWd3Q3K2kxaE9GSEJERVE3TzM1UGFS?=
 =?utf-8?B?eCt4OHVmbEp5dXRRTEhaaFUrSFo3cDZlclU3dTFoUWx4S0dYb3ZTS2dBVVBF?=
 =?utf-8?B?dzUwQkFVUi9SRzY5Ukt5b1VjT3FVSEVjUmhkNnZOSkVRelJiM2VLUnZTcmpG?=
 =?utf-8?B?TGl4dWN4L0lrZWhpOGIyRXRvMHJuSXVXbDZYeHM3OUJoMExhY2wweFczUDZX?=
 =?utf-8?Q?NkH92cwPX9Xjfl48mcICHU/4QwmJOM11uUQQUt9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dfcb39-0e8b-4d0d-4c07-08d8f9df6aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 16:08:43.9273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8O2Vs4fLwSLh/L9jDYQ1QPEVx/CXKHuHpShZwECKjHDWfg7R9jZL17/OgpOBvehJowV4aBcha63RYYcoFDYgi15FCD0fsNMM+n2C84cne4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgQXByaWwgMjAyMSAwMjozNywgQmFkaHJpIEphZ2FuIFNyaWRoYXJhbiB3cm90ZToNCg0K
PiBwb3dlcl9zdXBwbHlfY2hhbmdlZCBuZWVkcyB0byBiZSBjYWxsZWQgdG8gbm90aWZ5IGNsaWVu
dHMNCj4gYWZ0ZXIgdGhlIHBhcnRuZXIgYWNjZXB0cyB0aGUgcmVxdWVzdGVkIHZhbHVlcyBmb3Ig
dGhlIHBwcw0KPiBjYXNlLg0KPiANCj4gRml4ZXM6IGYyYThhYTA1M2MxNzYgKCJ0eXBlYzogdGNw
bTogUmVwcmVzZW50IHNvdXJjZSBzdXBwbHkgdGhyb3VnaA0KPiBwb3dlcl9zdXBwbHkiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBCYWRocmkgSmFnYW4gU3JpZGhhcmFuIDxiYWRocmlAZ29vZ2xlLmNvbT4N
Cj4gLS0tDQoNCk1pc3NpbmcgY29tbWl0IGluZm9ybWF0aW9uIGFzaWRlOg0KDQpSZXZpZXdlZC1i
eTogQWRhbSBUaG9tc29uIDxBZGFtLlRob21zb24uT3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCg0K
PiAgZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BtLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYyBiL2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNw
bS5jDQo+IGluZGV4IGQ0Mzc3NGNjMmNjZi4uNzcwOGIwMTAwOWNiIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiArKysgYi9kcml2ZXJzL3VzYi90eXBlYy90
Y3BtL3RjcG0uYw0KPiBAQCAtMjU2NCw2ICsyNTY0LDcgQEAgc3RhdGljIHZvaWQgdGNwbV9wZF9j
dHJsX3JlcXVlc3Qoc3RydWN0IHRjcG1fcG9ydA0KPiAqcG9ydCwNCj4gIAkJCXBvcnQtPnBwc19k
YXRhLm1heF9jdXJyID0gcG9ydC0NCj4gPnBwc19kYXRhLnJlcV9tYXhfY3VycjsNCj4gIAkJCXBv
cnQtPnJlcV9zdXBwbHlfdm9sdGFnZSA9IHBvcnQtDQo+ID5wcHNfZGF0YS5yZXFfb3V0X3ZvbHQ7
DQo+ICAJCQlwb3J0LT5yZXFfY3VycmVudF9saW1pdCA9IHBvcnQtPnBwc19kYXRhLnJlcV9vcF9j
dXJyOw0KPiArCQkJcG93ZXJfc3VwcGx5X2NoYW5nZWQocG9ydC0+cHN5KTsNCj4gIAkJCXRjcG1f
c2V0X3N0YXRlKHBvcnQsIFNOS19UUkFOU0lUSU9OX1NJTkssIDApOw0KPiAgCQkJYnJlYWs7DQo+
ICAJCWNhc2UgU09GVF9SRVNFVF9TRU5EOg0KPiBAQCAtMzEzMiw3ICszMTMzLDYgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCB0Y3BtX3BkX3NlbGVjdF9wcHNfYXBkbyhzdHJ1Y3QNCj4gdGNwbV9wb3J0
ICpwb3J0KQ0KPiAgCQkJCQkJICAgICAgcG9ydC0NCj4gPnBwc19kYXRhLnJlcV9vdXRfdm9sdCkp
Ow0KPiAgCQlwb3J0LT5wcHNfZGF0YS5yZXFfb3BfY3VyciA9IG1pbihwb3J0LT5wcHNfZGF0YS5t
YXhfY3VyciwNCj4gIAkJCQkJCSBwb3J0LT5wcHNfZGF0YS5yZXFfb3BfY3Vycik7DQo+IC0JCXBv
d2VyX3N1cHBseV9jaGFuZ2VkKHBvcnQtPnBzeSk7DQo+ICAJfQ0KPiANCj4gIAlyZXR1cm4gc3Jj
X3BkbzsNCj4gQEAgLTM1NTcsOCArMzU1Nyw2IEBAIHN0YXRpYyB2b2lkIHRjcG1fcmVzZXRfcG9y
dChzdHJ1Y3QgdGNwbV9wb3J0ICpwb3J0KQ0KPiAgCXBvcnQtPnNpbmtfY2FwX2RvbmUgPSBmYWxz
ZTsNCj4gIAlpZiAocG9ydC0+dGNwYy0+ZW5hYmxlX2ZycykNCj4gIAkJcG9ydC0+dGNwYy0+ZW5h
YmxlX2Zycyhwb3J0LT50Y3BjLCBmYWxzZSk7DQo+IC0NCj4gLQlwb3dlcl9zdXBwbHlfY2hhbmdl
ZChwb3J0LT5wc3kpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIHRjcG1fZGV0YWNoKHN0cnVj
dCB0Y3BtX3BvcnQgKnBvcnQpDQo+IC0tDQo+IDIuMzEuMC4yMDguZzQwOWY4OTlmZjAtZ29vZw0K
DQo=
