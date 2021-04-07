Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67F1357159
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354097AbhDGQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:05:21 -0400
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:25061
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354077AbhDGQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:05:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7wwIIBTi2QuHO37AK8CmZSU9VDAdz7BtP9WXkuYO5qQ8dYvXhPOqevLHfbyMIYgDt+d6EnDjxdNXVug2iZKi8utIITLNVgocfVjud8ZIz4yiuJYqMyrtvVYO11ZU6OI/Sw3nubZmNWjzbMJxKfwTTOCY4XgC4pyRnPlXpfgmp8iVgATeRLKgyVg9jbROFOI7/JpLvrqwjz9fMmOJD7/iwWdVZFV5iiqXXw3nUwis5q9N5P4BTSs04nQLhB2FFk5pojvmfHsMQDm422XvShJfI075WIzpqhnLKf8KDtqASnNIMauP0sqnaZoIEaMO1B975QqrfSyVWXfdxOB7JuZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UxjuZ6++f/LZYVN6lF7phauMYI4cnwncF8C0JaxWi0=;
 b=jdGFWrPybdf0ONNld6XjdfQg+rt5XwU0ZWvHSI+vJiiB3ZvGYf8+HzyocpUW3SYGopbVPdW+bELZNcMFpRq79yLVjAA02yhHEF8WZIVdz2o00BdVL9jB2lTjtHZxWWMY6zaRyshYsE58Us9yz4ZEkXvVBOP7n9No+kJA/AdDgPzv72A5Y3Cw3KJ2sUtFhILe1vELhTr3LfrUCewugkUPZcyLA1tw003If3N/zxAVQv4nLusL23HYeL5vv3P5aZLwJlLmx0pFLJdmUSf/MYtAz/pubK3XHMTnz4nLd6VYKA7mzNdqjbuqVgTauG7Cbg2ijrU0laMqLmmR3O7WNdNyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UxjuZ6++f/LZYVN6lF7phauMYI4cnwncF8C0JaxWi0=;
 b=l1BiIhGMnmNtUtEmrRv2ihiXKblJeUU1wzJPiOO46RNLI5jd5q70tiouuGdXQKs83E9zCykUybOv31Ef0TPUy8M4palZYX7QfY6/8/Lb9eQdnFNizwkzKI63rzuGdr08lqz9qCkCpWKMgfdCWSkYXF9MrqXXibieLF2tUH7M/Uc=
Received: from AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fe::17)
 by AM9PR10MB4354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:266::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 16:04:52 +0000
Received: from AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0bc:c738:6a49:c60]) by AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0bc:c738:6a49:c60%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 16:04:52 +0000
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
Subject: RE: [PATCH v1 1/6] usb: typec: tcpm: Address incorrect values of tcpm
 psy for fixed supply
Thread-Topic: [PATCH v1 1/6] usb: typec: tcpm: Address incorrect values of
 tcpm psy for fixed supply
Thread-Index: AQHXKoVSavLi1PUelU2dlLtlhmQbWKqpODFA
Date:   Wed, 7 Apr 2021 16:04:52 +0000
Message-ID: <AM9PR10MB4134A5A4A0D34EC3F2C572BD80759@AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM>
References: <20210406013643.3280369-1-badhri@google.com>
 <20210406013643.3280369-2-badhri@google.com>
In-Reply-To: <20210406013643.3280369-2-badhri@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b70892c-b66e-4a0e-e5e0-08d8f9dee0d5
x-ms-traffictypediagnostic: AM9PR10MB4354:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR10MB435454EF1E134FBB1C163237A7759@AM9PR10MB4354.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ha5NR39suyRw3lJHSFc+HMumHg4hfMEEPs7YfdtYQLb9FYPKZ5PQds82LX4sYLmyVlqlRhjhlIaPPM2Ix6LBiDS1aPswi/9mXB5PjU0X8z6c/61P2Haka0cHDM7dnsyZwLJTSbXMNu+hMvALmJkxXJoJTUcwSoR7syXr7YESw5rIJmueLfsemdRl5IcoZRIeNEQ7jEZzP3zAjwilVpSOKh80BeOK1aoAX8LgbWkP81wSnn7ZPqimRgPJhi377mY09TfBPTcO72SgKuS0Jylz42s4rcnY1PEHtCPy4j73xb1eZi/k56CCeQuwdaSautv6Jt1d6PAdXoCkccEfkSqVd9B0Lpe82LRnYwmzhGkClwHb4s9XftD5k7LADbvFiGWv7qpXfclErxJiEHn0mx3BrgZN0MO+hViA4SVK3f3a+0W+6fiE1mEpXG7fVHTwORQwcubLPxGy5pWAWDpGoVTjYG3BKOGEV2XxWVY5BWtbG/nn2ON47icGnYgKf40JxcBrzQcUM590fxjGD7cNGhmHIGNuBRCL6hlajtpffv6rnR8vAsCEiiQmFRXJGbVYYWqCDl05O0/w0DtGH9UmVatwyk45MfMZdMHCfMZQzJRZ4ZcWC0MeYQc213Bg2fKbnJ+4qrhIufkM/X4+NSSADKpToA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(33656002)(7696005)(53546011)(4326008)(6506007)(186003)(76116006)(83380400001)(86362001)(2906002)(26005)(8676002)(66476007)(52536014)(8936002)(478600001)(66556008)(66946007)(64756008)(66446008)(55016002)(54906003)(110136005)(71200400001)(5660300002)(9686003)(38100700001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVdKbUhLcTNJeGlPd3VrVHZyWHoxSi9RYUYyVWNOSnRBOU94S0pDcGZVWS9s?=
 =?utf-8?B?VHo2aFZmbEY5azdNekNzNkYxeGVUdkNmSTZYZklFM1E1UW9LQnlmRFk0dStD?=
 =?utf-8?B?cTJmNzJyNDNYZGZ6ekZtTGsvc0pFOG9pclZZZDhVUzJlQ2Ftak5qWElkRUVt?=
 =?utf-8?B?Yi9ZREtZODZCeTRGM09GRnJHVHJHTmNnYnJmOGtLUE1pdTBuc1NHM2t5bDZE?=
 =?utf-8?B?eUYwS2lsWnorbDBQdXcyYktnOFJDNk4wQnFUak1uOWptT0ZSUVJlS3lOOUlT?=
 =?utf-8?B?RENXYUcxSmRia2pZVVcvUk9rc1FpODFHVWZRM0o2UGhQL1JSLzMzZ3FFdys0?=
 =?utf-8?B?dzdBS3dBekJRc0JiVG5VampLSmpGeHMxbUF0Mk5iRFNWci9VRml5UXp5SDUw?=
 =?utf-8?B?QWhUUEZic2E3aGE1MWN4cWRRM1JucWM4Y3FHV3JTMzJjbWQ5dU9vcFVUTENt?=
 =?utf-8?B?TTNPandXVGk2Zk4wRzFtWDJEb2ZwMkZOV0VsTmY0S2UrQnhiaVBHb2laeEsx?=
 =?utf-8?B?dzZ6V0dmWFZyK3ZHblF4YVhSM3hHbkV3TEVjNzVPemVVZStyTDgwQmQyVU55?=
 =?utf-8?B?dytSTzV4VkJUQzFycGxCaTFHZzhWL0I5OUFueHB1cnhCSW45eTdkZUVYdDRp?=
 =?utf-8?B?VnVUdHhXcmg5ekw1a2U5TitHdWRBMktBMDhRNjRaaEVycFZwYVFUeTVvYjFX?=
 =?utf-8?B?bnRKcXFIcjBCaGFrdnI0MkhJRFd5V25GNUVhSW9PY29TMjhuY2NpRDZMSTYw?=
 =?utf-8?B?Y2V2eHJHK0o5djlzWGE1UnVPYTNVZzlJMEc4RlNtV09XRHFycFc1NW9uRmVS?=
 =?utf-8?B?emFuODNuWHFqRVI0dTE3WUFCdDhuWlR2ZUcrZE1uYkdWdCszQzJJTXNlanNK?=
 =?utf-8?B?a09pZXZVOFc0N1g1RHVUMkM2VHJJZ2JZYTh2ZzlDNSt4amZRb24wWEFNa2JC?=
 =?utf-8?B?MHRUcFVYbjdTdGhTS0pDM216V3orWE9QZDkyd2sxKzJ2ZjRyWFIrbGd4UjVk?=
 =?utf-8?B?RlZJdHRET2FhbVNXY3dZUU1lZllIakNMMzdrVGpEOUdWOFg0dzJRL0tnSVQ0?=
 =?utf-8?B?V0R1cEQ0L2Q2amZzSzVXVkJ4Ti9FeXY4U1JKTGVUZ1FUL3l5VkFyek95MHg2?=
 =?utf-8?B?Zm1SVmtUUVR1TzI1NnU2RjhrSkYxMjR0S080anZxdjFqeDlMTDdVc1k0Um00?=
 =?utf-8?B?REtGNFJ3R0x2ckVFMk9hWXExVE5YYlNmRjZmTkMvNk53N0pPaS9FQUdiNmtW?=
 =?utf-8?B?dU81bURsR0J4a0UyZWREOEtJbnAwRGN1WHE0aWd4UE9zV0M3QlJKV1JLOWpZ?=
 =?utf-8?B?WnVyZldpaG1iSDJjaEJkcnY5akhrZjVPUmJ0SHhyNTUxN2hOczg0dVFqOWZs?=
 =?utf-8?B?ZHVzNlBVb1hrM0htcWN0dU5FRFFRKzNpWDJrZ0k0T3hLYndtaUtqcHRiSkw2?=
 =?utf-8?B?aG5PRlJLdzhMSmpTeERiRStYdWk3UWtZQzFwZlhRcHdjTUpXZ1I5WUVUNVRY?=
 =?utf-8?B?NTlRbFdSVWNaM2N1UlZIc2NTZERmSkdINmE2NGV4SndIYm51MnZpc0ZhbE9Z?=
 =?utf-8?B?bHM0UWhCR095bmFVejllVlpjc0JBaGtIbVBUaHBPQkdGY0hGbkFlUG5TU3V2?=
 =?utf-8?B?V1pMWDA0SlJ6cVIvVWo2R1ltT090YmVKaytCcVF3d2psdzJNdUdVNnQ2Yy9D?=
 =?utf-8?B?aTVpSVJlNlVtTCs5R2tOamQ1SXpFeEFuQmVQWFFpRGlOd1NPNElTWkRqOG1B?=
 =?utf-8?Q?X5nU6jpUg1bTjW5MzkgA9/Wa+YJjFuQfDeFV7LJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b70892c-b66e-4a0e-e5e0-08d8f9dee0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 16:04:52.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgAFmHcRlS/JHXY1oRLowuz+0NXaSOCrlPaqIZjTZHJ6rONxgHIHSb5QrdvIzUPLAdSVvWa6MGqgeH8spmU+mJHm9KWYcFNUmX3C6svkVME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgQXByaWwgMjAyMSAwMjozNywgQmFkaHJpIEphZ2FuIFNyaWRoYXJhbiB3cm90ZToNCg0K
PiB0Y3BtX3BkX2J1aWxkX3JlcXVlc3Qgb3ZlcndyaXRlcyBjdXJyZW50X2xpbWl0IGFuZCBzdXBw
bHlfdm9sdGFnZQ0KPiBldmVuIGJlZm9yZSBwb3J0IHBhcnRuZXIgYWNjZXB0cyB0aGUgcmVxdWVz
dHMuIFRoaXMgbGVhdmVzIHN0YWxlDQo+IHZhbHVlcyBpbiBjdXJyZW50X2xpbWl0IGFuZCBzdXBw
bHlfdm9sdGFnZSB0aGF0IGdldCBleHBvcnRlZCBieQ0KPiAidGNwbS1zb3VyY2UtcHN5LSIuIFNv
bHZpbmcgdGhpcyBwcm9ibGVtIGJ5IGNhY2hpbmcgdGhlIHJlcXVlc3QNCj4gdmFsdWVzIG9mIGN1
cnJlbnQgbGltaXQvc3VwcGx5IHZvbHRhZ2UgaW4gcmVxX2N1cnJlbnRfbGltaXQNCj4gYW5kIHJl
cV9zdXBwbHlfdm9sdGFnZS4gY3VycmVudF9saW1pdC9zdXBwbHlfdm9sdGFnZSBnZXRzIHVwZGF0
ZWQNCj4gb25jZSB0aGUgcG9ydCBwYXJ0bmVyIGFjY2VwdHMgdGhlIHJlcXVlc3QuDQo+IA0KPiBG
aXhlczogZjJhOGFhMDUzYzE3NiAoInR5cGVjOiB0Y3BtOiBSZXByZXNlbnQgc291cmNlIHN1cHBs
eSB0aHJvdWdoDQo+IHBvd2VyX3N1cHBseSIpDQo+IFNpZ25lZC1vZmYtYnk6IEJhZGhyaSBKYWdh
biBTcmlkaGFyYW4gPGJhZGhyaUBnb29nbGUuY29tPg0KPiAtLS0NCg0KTG9va3Mgc2Vuc2libGUs
IHR5cG8gYXNpZGU6DQoNClJldmlld2VkLWJ5OiBBZGFtIFRob21zb24gPEFkYW0uVGhvbXNvbi5P
cGVuc291cmNlQGRpYXNlbWkuY29tPg0KDQo+ICBkcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0u
YyB8IDE3ICsrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi90eXBl
Yy90Y3BtL3RjcG0uYyBiL2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwbS5jDQo+IGluZGV4IGNh
MWZjNzc2OTdmYy4uMDNlY2E1MDYxMTMyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBl
Yy90Y3BtL3RjcG0uYw0KPiArKysgYi9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiBA
QCAtMzg5LDcgKzM4OSwxMCBAQCBzdHJ1Y3QgdGNwbV9wb3J0IHsNCj4gIAl1bnNpZ25lZCBpbnQg
b3BlcmF0aW5nX3Nua19tdzsNCj4gIAlib29sIHVwZGF0ZV9zaW5rX2NhcHM7DQo+IA0KPiAtCS8q
IFJlcXVlc3RlZCBjdXJyZW50IC8gdm9sdGFnZSAqLw0KPiArCS8qIFJlcXVlc3RlZCBjdXJyZW50
IC8gdm9sdGFnZSB0byB0aGUgcG9ydCBwYXJ0bmVyICovDQo+ICsJdTMyIHJlcV9jdXJyZW50X2xp
bWl0Ow0KPiArCXUzMiByZXFfc3VwcGx5X3ZvbHRhZ2U7DQo+ICsJLyogQWN1dGFsIGN1cnJlbnQg
LyB2b2x0YWdlIGxpbWl0IG9mIHRoZSBsb2NhbCBwb3J0ICovDQo+ICAJdTMyIGN1cnJlbnRfbGlt
aXQ7DQo+ICAJdTMyIHN1cHBseV92b2x0YWdlOw0KPiANCj4gQEAgLTI0MzUsOCArMjQzOCw4IEBA
IHN0YXRpYyB2b2lkIHRjcG1fcGRfY3RybF9yZXF1ZXN0KHN0cnVjdCB0Y3BtX3BvcnQNCj4gKnBv
cnQsDQo+ICAJCWNhc2UgU05LX1RSQU5TSVRJT05fU0lOSzoNCj4gIAkJCWlmIChwb3J0LT52YnVz
X3ByZXNlbnQpIHsNCj4gIAkJCQl0Y3BtX3NldF9jdXJyZW50X2xpbWl0KHBvcnQsDQo+IC0JCQkJ
CQkgICAgICAgcG9ydC0+Y3VycmVudF9saW1pdCwNCj4gLQkJCQkJCSAgICAgICBwb3J0LT5zdXBw
bHlfdm9sdGFnZSk7DQo+ICsJCQkJCQkgICAgICAgcG9ydC0+cmVxX2N1cnJlbnRfbGltaXQsDQo+
ICsJCQkJCQkgICAgICAgcG9ydC0+cmVxX3N1cHBseV92b2x0YWdlKTsNCj4gIAkJCQlwb3J0LT5l
eHBsaWNpdF9jb250cmFjdCA9IHRydWU7DQo+ICAJCQkJdGNwbV9zZXRfYXV0b192YnVzX2Rpc2No
YXJnZV90aHJlc2hvbGQocG9ydCwNCj4gDQo+IFRZUEVDX1BXUl9NT0RFX1BELA0KPiBAQCAtMjU0
NSw4ICsyNTQ4LDggQEAgc3RhdGljIHZvaWQgdGNwbV9wZF9jdHJsX3JlcXVlc3Qoc3RydWN0IHRj
cG1fcG9ydA0KPiAqcG9ydCwNCj4gIAkJCWJyZWFrOw0KPiAgCQljYXNlIFNOS19ORUdPVElBVEVf
UFBTX0NBUEFCSUxJVElFUzoNCj4gIAkJCXBvcnQtPnBwc19kYXRhLmFjdGl2ZSA9IHRydWU7DQo+
IC0JCQlwb3J0LT5zdXBwbHlfdm9sdGFnZSA9IHBvcnQtPnBwc19kYXRhLm91dF92b2x0Ow0KPiAt
CQkJcG9ydC0+Y3VycmVudF9saW1pdCA9IHBvcnQtPnBwc19kYXRhLm9wX2N1cnI7DQo+ICsJCQlw
b3J0LT5yZXFfc3VwcGx5X3ZvbHRhZ2UgPSBwb3J0LT5wcHNfZGF0YS5vdXRfdm9sdDsNCj4gKwkJ
CXBvcnQtPnJlcV9jdXJyZW50X2xpbWl0ID0gcG9ydC0+cHBzX2RhdGEub3BfY3VycjsNCj4gIAkJ
CXRjcG1fc2V0X3N0YXRlKHBvcnQsIFNOS19UUkFOU0lUSU9OX1NJTkssIDApOw0KPiAgCQkJYnJl
YWs7DQo+ICAJCWNhc2UgU09GVF9SRVNFVF9TRU5EOg0KPiBAQCAtMzE5NSw4ICszMTk4LDggQEAg
c3RhdGljIGludCB0Y3BtX3BkX2J1aWxkX3JlcXVlc3Qoc3RydWN0IHRjcG1fcG9ydA0KPiAqcG9y
dCwgdTMyICpyZG8pDQo+ICAJCQkgZmxhZ3MgJiBSRE9fQ0FQX01JU01BVENIID8gIiBbbWlzbWF0
Y2hdIiA6ICIiKTsNCj4gIAl9DQo+IA0KPiAtCXBvcnQtPmN1cnJlbnRfbGltaXQgPSBtYTsNCj4g
LQlwb3J0LT5zdXBwbHlfdm9sdGFnZSA9IG12Ow0KPiArCXBvcnQtPnJlcV9jdXJyZW50X2xpbWl0
ID0gbWE7DQo+ICsJcG9ydC0+cmVxX3N1cHBseV92b2x0YWdlID0gbXY7DQo+IA0KPiAgCXJldHVy
biAwOw0KPiAgfQ0KPiAtLQ0KPiAyLjMxLjAuMjA4Lmc0MDlmODk5ZmYwLWdvb2cNCg0K
