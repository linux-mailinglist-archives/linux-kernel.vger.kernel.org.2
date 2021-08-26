Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCF3F8AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhHZPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:13:16 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:34195
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232291AbhHZPNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:13:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz/Wz96101k5MPpW5d+PvPKhpc3XEJucER/SP1sjs5+O5GJ4+9b9FO9F+K8MfNsjWhc/zB80yMpJ2hfyYhA856DyWNw1rdqcIK1O8JJh+/wxZpGPxnKyQzcSlYU318O8MHBQfNQtO2/VtEGDCvvtT4UQc04Jas3lW7akO3aie3y7zwDNwwZXy5jQqvtmB33bDmB97rC6EtOV3ulmNjLLZJqVf1ym9T0feP6/qc+q5nZ73Fc9CjP936uKpnBmzi01aYwjKSS8agGFS98zOckHjfkGX6F+vAtqN9x6ciVgoHG829pAJRnJ8SlHNPa3NhA8nyuu+YGmPFWTI+ct+S2yZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7XhnFs/UzXkH4U9c0b/38G50rBwvBh73kbO3muZrZw=;
 b=G3p2KUmkUzV0strAfQjZw1VRL1DN6RHdJRDyyhNzXDcUkDVpI1A8x1HAH+buTvSUigm/9PrfaWGsIHrMpB8X55FyVvNLl+lOExX3caqf9Bvpe7uSHZGrU9KnRz5SKmmt7OJbbIfzsWRwfFsiV8JNjXmHKVQDlaeXQhL/n49waf51Iy4orSMbi0VUBrBeEmlQ3do76XjBHcot1dpsdMov5c9Rh4YaBS4tDQVOGe6SLZS4SvakI6pimunhSrOC7YIFhYlXELHQpjuPcf7dllSF3aFbMUjnkxhRbJIMRW8Wr4gpBXT+ysZtEWMaeMGAkjYfuB09U3QB0RFigE8mbnGhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7XhnFs/UzXkH4U9c0b/38G50rBwvBh73kbO3muZrZw=;
 b=kY4ltzVECPyGMkdnLt0JFCbjZe7qezYYoI9ju3rN0hJ5VPxwB87xmvQpPiVlcRnqH2Dtb81/7yNSUDkHSVc3mWQa22qI7HfVrM3oetInPDnEMWxkX8eLw02B4aJSCSw9ZKTNzHrfngFsHvp1x1MyFmBjvweZu0V/1DO3yneT8mo=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 15:12:24 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9058:2eaa:5414:d29c]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9058:2eaa:5414:d29c%5]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 15:12:24 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Colin King <colin.king@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Fix spelling mistake "atleast" -> "at
 least"
Thread-Topic: [PATCH] usb: typec: tcpm: Fix spelling mistake "atleast" -> "at
 least"
Thread-Index: AQHXmneCGOHtRUkrskypVodARC2UxKuF5Cbw
Date:   Thu, 26 Aug 2021 15:12:24 +0000
Message-ID: <DB9PR10MB46526F54459472C249DA397480C79@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210826123959.14838-1-colin.king@canonical.com>
In-Reply-To: <20210826123959.14838-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 576b4837-7b11-45f3-b7e0-08d968a3e8e2
x-ms-traffictypediagnostic: DB6PR10MB1845:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR10MB1845F859B452F246C979CF66A7C79@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vu/6qRefHe6alyLfuC7KR5aj5TELnBBEG48gijDm/WEzkFtXVLXeHzDb9HIsrOqvBCO9YLYIKGlT4b8bYAoUVxHPtEjyVT9e7a8ps++OaiVJBHjUdbjzzsebdrsybrRrz56v2sWWdEEMnVnzM4B1yDpXgzSfCtXEIU0VP3OQhNlgFk877JJ37ctcfljlxZIpH+AHi83mTR3lm1b0oijWmU6IE795Gu2XgUprbaEdQhlQ89mnGWn/kY1dJZaon8Y1GAJr1fnOzJGEWoRoFz2uyIIchQmOw0o6a0Q/F0CZnxO93kD64WpJxo+yCatG58ADtOyJlLjwFZg4bnHNU4aInG4AAMuh4Qr9uBt+5AIhB0TiWHKZEigMdAN5R5/NhxrL0ttf5SeAA03Au78oZQpL7TN9k8CRJt2BhmYFDHAAZvS1ef7jWVuM5KqVcXWrg+qoySbzgSC8WWatPByx02jjpy6iysCbeo334Qr9L/Hy8+CZoH9Wdzg/4J0B5/3NsVtHsYzwda7/fuxELUKNBWHZOTUiXSMgvYRXtEcZCiTSJVQ+8VRjW0wvaRBZVr/IVkVLdY2IXkloCfs+uu5dycVr1yRYZetbEr/jlvY7gptYvHF8m7r26+X2YWTND9vNWjxbXxMFH78ZP0yInZaVbKKPiG9n4Zf9M8eAcYFUO6UoavVRJpWR43IWUxMR8/pffFDYy0CS8Dk9ntfgfWWViH8KmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(366004)(136003)(376002)(8676002)(86362001)(7696005)(478600001)(54906003)(26005)(6506007)(66556008)(76116006)(2906002)(8936002)(53546011)(110136005)(38100700002)(66946007)(122000001)(4326008)(71200400001)(64756008)(66476007)(186003)(5660300002)(38070700005)(52536014)(55016002)(83380400001)(9686003)(316002)(33656002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai9iSy83bUJzWDZnejhRUWhmQXMrQ0E0bENESGpxd1JrVmJOOFhwMzRITU5q?=
 =?utf-8?B?UnBoellXcWlhQU03T25ZUWdlNEZzNWJrS3RaU3A4ZEFJbk9uMGUzNlFWTWFk?=
 =?utf-8?B?RmNLcE5FOGVWdTRQMzAwdTVFNjZqQitoamFta20vazRkaUFmQVN5R21pTnBn?=
 =?utf-8?B?RWpVaDkxdnJQTUlLOUczam42TlVoenhvelJxQ2VSdkFtOXRiOEZZR05tcFp4?=
 =?utf-8?B?ak1yUVQzU29uUEdkanVyWGxDMEwzUGljdUNuWlAwZ1JOeDU2V3BJQ0p5cS9W?=
 =?utf-8?B?ckJUK1VMbHhtZVdEanByQUZQZjk2QnF4RUhPcWJWakVZUkRDVjB3Ky8yalZ5?=
 =?utf-8?B?NG9FZEdveVlRSUJsVW5pQ1oxL0RPbzZ3N0dZbWJVR1Rtei8vaXBYcHNyMXhZ?=
 =?utf-8?B?UzFrbTRPNkZLNHB4cnRmMzhKeVl0M0x3b21hcVd3bXc1Rk9DaGhBRS81a3lO?=
 =?utf-8?B?WGlwajlkOTFKL0pPSmZsRCsyTGpwMTg5RjBPdlViZ1U0OW5LNjBIWHM2WUZv?=
 =?utf-8?B?TkdCajlYQlZzRVhFTi9NTFc5Nmx5VzVNMFBlUVllYU84U2lRQ1hKVjVyM05Q?=
 =?utf-8?B?WmFxUmFMdlRlemN5eEFsNWhTZUZSUHZydTJQOWVRVm9xK2t6OUlRbDVTTnIy?=
 =?utf-8?B?VXQ3WG1zRDBIY21uWWszZ0FRMmU5OWx0N2gyTi9LTWJ2T0I4azVxcVdkRXBM?=
 =?utf-8?B?MnVSNFJWZ0RNV3Z5a3laNit4eVY3UnZWMEp3TUZmS1dCNzBrdjlBWGRVQlpX?=
 =?utf-8?B?dDcxLzlVN3FCZlR2YkZTQ2RES0xXajNiYjdFTzZzNGUweXd2L3p2Y20xMFhv?=
 =?utf-8?B?RnFsZTl0aFg3eXVnc0FJb3hDd0VqT3RxWkFmMTlBZUxWMGdQSkx5emdxTUoz?=
 =?utf-8?B?dVlaL2dudGdVWTVDSVRjVXZRUzNSV2FzY1FFSmtrSXlrOFh6KzhOVFdIV3Qx?=
 =?utf-8?B?azNmWk1pQWhSenIrb0w1KzNDRUgwaG5NaXFLRms0TmVlQlFDSFFMTnVQRURH?=
 =?utf-8?B?Y1hHOXY3V1ZrQUhsc2xoUEpmaGlWRHIybWlFdTdYcVdiWENGMGI0YUtHU3pl?=
 =?utf-8?B?L3k1ajdIbDFoU3E1VWI3c0tNL2dQa2Y2QzFPMmQyZW83VVcyM0c1Ly91OXBD?=
 =?utf-8?B?QWtKUncwYkNleFE0RGpKUGl0d1k5SHhlWmp4Q0dXQVREaENYNWs1TnAxcThj?=
 =?utf-8?B?bHhvcXlDSmhlOHFCdlljUHdyaDlqalhjd0F3RlZMZGdJT0FkalRRN1NnT1Bq?=
 =?utf-8?B?aGlROEN4b1k3cXd5SFZ4WTZOaGxOMFRYcXFKc2w3Ylh6YXVHQVYwWHVZUUI0?=
 =?utf-8?B?dkUwb0hwYUJPa1lxaTJpN1NKNHBLWTZBVURzZjFyNUhNNWlMamY0dDBnaC9w?=
 =?utf-8?B?WU0yVjFKVzY4d24rTHJpbWRubXJWYWp5Ylc1VzIveWRoaWk1RzJreXFML2pJ?=
 =?utf-8?B?MW9Gd3BzWGM5TktHOGNYVE9ldVJWZENOOG9tcjRpZGRwbjdGOHAzWXJyTVFt?=
 =?utf-8?B?VDQ1T0MyeWdqZG4rWXFpRWp0dTJaUi9Zc3d5b0kwRHcraEFzWHMwZzJIQkJ1?=
 =?utf-8?B?QkdvRlliNlhKdGY0TUxPWFZ6bWdUMWhaalMrd3lUNmRYZ0t1VXhtMEtLQ2NL?=
 =?utf-8?B?TXNENktnOTcvU0xnRnRVK1pacVN3TVJYRTh3YkVCTlB3QjNjeTRKa1V1R0Yy?=
 =?utf-8?B?NnJPcjJXMHB6a2JzczByREdzRnJDVi90Y0RVUmw0UFFRZExHbFJEUHN1SHVD?=
 =?utf-8?Q?vyixPgvi3Y94lpzS336E1UZAu9d4Jrh0trZy59h?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b4837-7b11-45f3-b7e0-08d968a3e8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 15:12:24.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0/MIJt52pn3UKAnOLaHzsw4vBV2SLMUzaS/HV+wwjEmaQpxsXQq2KLF4fUQALtBIn8BWRP9akk4XEwCGL7521oE2HJi5tqwAMMtyStuWjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1845
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYgQXVndXN0IDIwMjEgMTM6NDAsIENvbGluIEtpbmcgd3JvdGU6DQoNCj4gRnJvbTogQ29s
aW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IFRoZXJlIGFyZSBz
cGVsbGluZyBtaXN0YWtlcyBpbiBhIGNvbW1lbnQgYW5kIGEgbGl0ZXJhbCBzdHJpbmcuDQo+IEZp
eCB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdA
Y2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYyB8
IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYyBiL2Ry
aXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwbS5jDQo+IGluZGV4IDA0OWY0YzYxZWU4Mi4uYjk4MWZj
MzlmYTNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiBAQCAtMjc4LDcgKzI3OCw3IEBA
IHN0cnVjdCBwZF9tb2RlX2RhdGEgew0KPiAgICogQHJlcV9tYXhfY3VycjogUmVxdWVzdGVkIG1h
eCBjdXJyZW50IG9mIHRoZSBwb3J0IHBhcnRuZXINCj4gICAqIEByZXFfb3V0X3ZvbHQ6IFJlcXVl
c3RlZCBvdXRwdXQgdm9sdGFnZSB0byB0aGUgcG9ydCBwYXJ0bmVyDQo+ICAgKiBAcmVxX29wX2N1
cnI6IFJlcXVlc3RlZCBvcGVyYXRpbmcgY3VycmVudCB0byB0aGUgcG9ydCBwYXJ0bmVyDQo+IC0g
KiBAc3VwcG9ydGVkOiBQYXJ0ZXIgaGFzIGF0bGVhc3Qgb25lIEFQRE8gaGVuY2Ugc3VwcG9ydHMg
UFBTDQo+ICsgKiBAc3VwcG9ydGVkOiBQYXJ0ZXIgaGFzIGF0IGxlYXN0IG9uZSBBUERPIGhlbmNl
IHN1cHBvcnRzIFBQUw0KDQpBY3R1YWxseSAnUGFydGVyJyBzaG91bGQgYmUgJ1BhcnRuZXInIGhl
cmUgYXMgd2VsbC4NCg0KPiAgICogQGFjdGl2ZTogUFBTIG1vZGUgaXMgYWN0aXZlDQo+ICAgKi8N
Cj4gIHN0cnVjdCBwZF9wcHNfZGF0YSB7DQo+IEBAIC0yMDUwLDcgKzIwNTAsNyBAQCBlbnVtIHBk
b19lcnIgew0KPiANCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgcGRvX2Vycl9tc2dbXSA9
IHsNCj4gIAlbUERPX0VSUl9OT19WU0FGRTVWXSA9DQo+IC0JIiBlcnI6IHNvdXJjZS9zaW5rIGNh
cHMgc2hvdWxkIGF0bGVhc3QgaGF2ZSB2U2FmZTVWIiwNCj4gKwkiIGVycjogc291cmNlL3Npbmsg
Y2FwcyBzaG91bGQgYXQgbGVhc3QgaGF2ZSB2U2FmZTVWIiwNCj4gIAlbUERPX0VSUl9WU0FGRTVW
X05PVF9GSVJTVF0gPQ0KPiAgCSIgZXJyOiB2U2FmZTVWIEZpeGVkIFN1cHBseSBPYmplY3QgU2hh
bGwgYWx3YXlzIGJlIHRoZSBmaXJzdCBvYmplY3QiLA0KPiAgCVtQRE9fRVJSX1BET19UWVBFX05P
VF9JTl9PUkRFUl0gPQ0KPiAtLQ0KPiAyLjMyLjANCg0K
