Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518E32A1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347797AbhCBHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:07:13 -0500
Received: from mail-eopbgr1320131.outbound.protection.outlook.com ([40.107.132.131]:64880
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1577479AbhCBGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:22:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqy2DnCoYL9nLPVjPs71GPmS7fFf/Q43qoERg0hswxZLkoOkZEWknsdRjXD9rAvzpH80i0S3Eb0rqa5kbMwj/irV/dNDZx4gHZ3opmImMl8r+fZX6WMnJSi+3nmhyaB5nHItEYlHff2xhVRxO5UdadsOJb8n9mjHh2KypSLdRlhuMdvxxv05goIoZmac2H2+vkhuRAXiF/Ego3tKITqzdsUKdgfMY8fJ8LiqlFhV70cn1gbbgIdNiH3xC/mvH94ya/Gwp9zkEixewHYS43lgypv8luJA0gJsEpDVJpuwN2xiPf66UkXTmVxdtZEb6IYckapd9cNA7MrYmRtwwfzh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh6s7RhEN4jd9wrmIykjpEWkk3ul2va6ca4Xl9yNxnU=;
 b=SeZ0Y5+PObs0hdisGdu8HaXoP3NfylyjbsMNsPXn9qCYL+ocotXUBy8e6sbCSgxHFzRfIPpzv5hnnmebZ/0tuVbsktpKzhlbAPl5XNKfwS8+SGQ6TW72YlYDhJC9NwXEu5WMfNDJpN+93cM+ce8JmWRe+4OdYrSzGvSw6Hhjk9nsfNvYCLDbyCZzK7YqdPWVxIUZ+4TzLI/f+1bGSsGz6qQDaom5fy9QOTd+kKZS02npUbyyMDN7rSkREbT3Gi3BmgfBBIKtzl49/TzZ7HQRvP296M2Sb321MEVj6/L8W4j4xgIG2MxGOhLsvinDVTOQ5PYpyu2+DXJynsaxEUQ+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh6s7RhEN4jd9wrmIykjpEWkk3ul2va6ca4Xl9yNxnU=;
 b=qb+ijtuUYVxvd9wbfy9eyvc4G9NdqygRcpCuU5mtfCx3Wi8te3ffmpIPWpVRGAZBenr7mSgJCSmVSzIHNbFDT32m8Lkobon9fmAAVVl+Thpw7GtxqDfT5auYjEHWaWjyY4MgBAW1S1EDRN1Vet7ZNTCNhe88MJtO7NWfiN3KTUM=
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com (2603:1096:203:74::13)
 by HK0PR03MB3106.apcprd03.prod.outlook.com (2603:1096:203:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Tue, 2 Mar
 2021 06:21:13 +0000
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::d923:be7c:16c6:b9f8]) by HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::d923:be7c:16c6:b9f8%2]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 06:21:13 +0000
From:   Jiqi JQ9 Li <lijq9@lenovo.com>
To:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark RH Pearson <markpearson@lenovo.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBod21vbjogKG5jdDY4ODMpIFN1cHBvcnQgTkNUNjg4?=
 =?gb2312?Q?6d?=
Thread-Topic: [PATCH] hwmon: (nct6883) Support NCT6886d
Thread-Index: AQHXDyr31rtjFAcEvE6noeRX8jYlw6pwOa8w
Date:   Tue, 2 Mar 2021 06:21:13 +0000
Message-ID: <HK0PR03MB370088B1CE476C57A14D439783999@HK0PR03MB3700.apcprd03.prod.outlook.com>
References: <lijq9@lenovo.com> <20210302061205.1825664-1-lijq9@lenovo.com>
In-Reply-To: <20210302061205.1825664-1-lijq9@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=lenovo.com;
x-originating-ip: [57.197.58.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12f1edc7-ec2a-4bf2-3611-08d8dd436149
x-ms-traffictypediagnostic: HK0PR03MB3106:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB3106101263FAFC858B1E88FB83999@HK0PR03MB3106.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4py6HjAsaZ3WgGrHaJbHv2xm7MpgrFxKoHDNn/tb8xfmdBTpuU+Fhg5iPFPKXRqcXEm0FT3jgyYiJiwZ8SYP7bb9kATp9+3EMKgINEajJkEPN21IufR+2hmwlbjyNlwJsKiGTI1pTr4342o4Oira2G35bf2CH0LJwi7UQPioe+sVCc7VeDNV9OP2p292WgbZh81NVZQQ9jKfySQfZnttzGV7Aoq7yiwYV5ngzZ7DDTC4DMyNLHXpfjvVAHaW9YRfehBIbZ7R08Bx1MPUCJf0GvoU3vsjxLi3/WyhnNR9wtMoTelJjgZ1KT+EUxbiVDCAbLkAkqI6v3suYi3pwWVaglfFN+B2HO+IhcoTfqO+Kkt0neB7X7K6+jNOwl45d4AuCwKY396tGUnixkdXNLyzLBKV1B2u+t/N6PSc5i0IAXiFX/uxtMQkOwB9XHNrmqqEtDKHF8zv9jvaEb6cVRbednvSrdp6hq4uZxK7dhPoD/41qTn/4UHXZZ1/5ioWFQM0DqmLh3Sv4yBkwVhd5z08Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3700.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(5660300002)(71200400001)(64756008)(2906002)(7696005)(316002)(86362001)(26005)(8936002)(6506007)(186003)(33656002)(4326008)(107886003)(478600001)(76116006)(83380400001)(224303003)(52536014)(66556008)(55016002)(9686003)(66476007)(66946007)(110136005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aGN4eWwrbGJRcWEzMTcwUWVoTDVzV3dZcyt0RnFsdXU5ckkycy9OM1RseXND?=
 =?gb2312?B?cjhCLzMxNmptT1d6bnBiRzdoeE1yY2Y1Q0NvQ09vNjk5dTVtOG04elZRaWxV?=
 =?gb2312?B?UFRpZXp0N254eHFLRU1kdnNLWFVsbzU2SEtQSmh5cDV5M2V1dVp0blZJWFoy?=
 =?gb2312?B?Y1hhOHZtaXVJSkxpUXRQc1NTcEVlZ1dLa01WTHRtVzR0RnBmbmF4eGZvQnps?=
 =?gb2312?B?WEZZaWdiSGpZU0RKN1dXZCtDVUhXN0lWOFhiYnRYMC94aXZJVjFRbkxReCtW?=
 =?gb2312?B?cGpsalpOSEtBN1FaYk0wSmtPcUxRZHpoVi9NazVTRzNFUWRBNlpGZTNGVWVU?=
 =?gb2312?B?QU81VzVZUUttU2s5SnoxZGFSQUx6UElCZ1lEeFFXdGdhZ21LakJJdVNhL1lz?=
 =?gb2312?B?Y2MxWEt5cXUwRmUxbGdXcHo0RTRqc2Y2TkFab0JGYmxYLytDMHBramk3Tk9n?=
 =?gb2312?B?emk0dnlBRWdiRi9rdCszZGppYTNWMkJPT0dOUnlUUGR5NCt5cnAya3UzR05B?=
 =?gb2312?B?WW81bGZJR3B5bXJ6OGJNQXVzVU11TWhSd05HRHduQ1lSVlc2WVlGcnhqbmRq?=
 =?gb2312?B?UGFQWE9OUTE5bXZmWDVnTm9neXlzTG9na3JZcHRYSzluUXBTRjA0VlUwSjNk?=
 =?gb2312?B?d3FHcXN6d20xTksxV21zSm5ncFgzenNYMmlodmg5S2FCTEpHakVSY0tOSXpl?=
 =?gb2312?B?Z2M5dk9IQ1R5SWUwWTFYMmRzcldiZjdGb29JUkU2aklYU2NQaEZMb1FYSno3?=
 =?gb2312?B?RGtIWGtYbFVBT2tzbGJkRmN2dEZTb1ovbEZlaXdwaTk5QnpiWmYvTHBKRWtx?=
 =?gb2312?B?RkN5R0xrRkVlcFJ4UWJNLzlFMlB6WjFaNHFuWWU4ak5lUHlZYi9JY2FMZHhy?=
 =?gb2312?B?ZmFaYlZDdVp3WkF6cEZWbTVFRTdGd1NKeDAwYURsNVF4dVdYRm5uU1BOb3g5?=
 =?gb2312?B?QmRreUs5MCtqWTV1VmorMFY0R1FUZ2FHQmU2TDA2RWViMUpYQXV1bngvQWxy?=
 =?gb2312?B?cGc2U0xEa2VBMUpLZzIwWjVnaUNrb1VBREkycGN4NElWQ1VoY29WTjFWZVRO?=
 =?gb2312?B?YTROeG5EUlVqcTNuM2VKKzZ6aXp1djVsOStGUWYvMisyUVVtU2xIWXI2RmdP?=
 =?gb2312?B?ZnBLaXVzYTBLR2ZwR0cxR2lQRTAxSUhncHgrWkRaNk9aSTJScFFMR2VUMjBL?=
 =?gb2312?B?YkphRGhPVXZCYkhlNGM5c0pPUVB1VUZQTCtlaXl3cmlmZUtSK0ZEcWFEOWFp?=
 =?gb2312?B?VnBEZTA4N1YrcjMzVnBJT0FrQnlaaE5hVzRiQjl5NjVmZXZ4aFdDM3RsaGEz?=
 =?gb2312?B?OXd3OEVrNEQ4d0Z2OTVKNFMxT3U0V2Y2Q3VSV0NZbFhCYVR0Z2hCcWZ0Q1Vk?=
 =?gb2312?B?dVhSWVdFbFA3bXB3bnBOdFFkSWtXcVh2MTFqOHNUb1ptWkVCQ3VWNU5mYmxH?=
 =?gb2312?B?L3FiZlEwTWZrdHhuZk44MUlOU20ybDBoaWE3WG4vN3NSYmtBcVVkR2Izb3Yr?=
 =?gb2312?B?ODdLZnZGZUZsS2pCL2o3WGx2cTBIZjVTVTFPN1VUVVdtS1NTOU8zdEFqdlU5?=
 =?gb2312?B?eTRHNVY4Wmk5K3BwT2VpRjVjbVU4dnFIR0syRDZnSEhxTWdWcEJtTmdOUGFE?=
 =?gb2312?B?NFlCa2tnNHZySnRsdVpNbSs3YjF1TmpJU3FleXBmMkZqSWpJdEFpcWtYUVpS?=
 =?gb2312?B?bGplRC9IcnJiMndRYTVrT1YwSjJGNEIyK1dHc0M0c3kxNFdFWnFUYW51dGE0?=
 =?gb2312?Q?r8y06WHNsB8ppf6wPM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1edc7-ec2a-4bf2-3611-08d8dd436149
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 06:21:13.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPhgOqoWBHZFrsNrQEiyXBOb8RmWMfRKBu/NinApkVIxStq65DUSvytce/MDJkUJhAXWpiFuzKsLnXj5UQMW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIFBsZWFzZSBpZ25vcmUgdGhpcyBlbWFpbCBhcyBzb21lIHR5cG9zLiANCg0KLS0tLS3T
yrz+1K28/i0tLS0tDQq3orz+yMs6IEppcWkgSlE5IExpIDxsaWpxOUBsZW5vdm8uY29tPiANCrei
y83KsbzkOiAyMDIxxOoz1MIyyNUgMTQ6MTINCsrVvP7IyzogamRlbHZhcmVAc3VzZS5jb207IGxp
bnV4QHJvZWNrLXVzLm5ldDsgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQqzrcvNOiBNYXJrIFJIIFBlYXJzb24gPG1hcmtwZWFyc29uQGxl
bm92by5jb20+OyBKaXFpIEpROSBMaSA8bGlqcTlAbGVub3ZvLmNvbT4NCtb3zOI6IFtQQVRDSF0g
aHdtb246IChuY3Q2ODgzKSBTdXBwb3J0IE5DVDY4ODZkDQoNCkFkZCBzdXBwb3J0IGZvciBOQ1Q2
ODg2ZCBjaGlwIHVzZWQgaW4gdGhlIExlbm92byBQNjIwLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXFp
IExpIDxsaWpxOUBsZW5vdm8uY29tPg0KUmV2aWV3ZWQtYnk6IE1hcmsgUGVhcnNvbiA8bWFya3Bl
YXJzb25AbGVub3ZvLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaHdtb24vbmN0NjY4My5jIHwgOSArKysr
KysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL25jdDY2ODMuYyBiL2RyaXZlcnMvaHdtb24vbmN0
NjY4My5jIGluZGV4IGEyMzA0N2EzYmZlMi4uM2RlN2JkMTQ2OTY1IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9od21vbi9uY3Q2NjgzLmMNCisrKyBiL2RyaXZlcnMvaHdtb24vbmN0NjY4My5jDQpAQCAt
MTIsNiArMTIsNyBAQA0KICAqDQogICogQ2hpcCAgICAgICAgI3ZpbiAgICAjZmFuICAgICNwd20g
ICAgI3RlbXAgIGNoaXAgSUQNCiAgKiBuY3Q2NjgzZCAgICAgMjEoMSkgICAxNiAgICAgIDggICAg
ICAgMzIoMSkgMHhjNzMwDQorICogbmN0NjY4NmQgICAgIDIxKDEpICAgMTYgICAgICA4ICAgICAg
IDMyKDEpIDB4ZDQ0MA0KICAqIG5jdDY2ODdkICAgICAyMSgxKSAgIDE2ICAgICAgOCAgICAgICAz
MigxKSAweGQ1OTANCiAgKg0KICAqIE5vdGVzOg0KQEAgLTMzLDcgKzM0LDcgQEANCiAjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAN
Ci1lbnVtIGtpbmRzIHsgbmN0NjY4MywgbmN0NjY4NyB9Ow0KK2VudW0ga2luZHMgeyBuY3Q2Njgz
LCBuY3Q2Njg2LCBuY3Q2Njg3IH07DQogDQogc3RhdGljIGJvb2wgZm9yY2U7DQogbW9kdWxlX3Bh
cmFtKGZvcmNlLCBib29sLCAwKTsNCkBAIC00MSwxMSArNDIsMTMgQEAgTU9EVUxFX1BBUk1fREVT
Qyhmb3JjZSwgIlNldCB0byBvbmUgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIHVua25vd24gdmVuZG9y
cyIpOw0KIA0KIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19kZXZpY2VfbmFtZXNb
XSA9IHsNCiAJIm5jdDY2ODMiLA0KKwkibmN0NjY4NiIsDQogCSJuY3Q2Njg3IiwNCiB9Ow0KIA0K
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19jaGlwX25hbWVzW10gPSB7DQogCSJO
Q1Q2NjgzRCIsDQorCSJOQ1Q2Njg2RCIsDQogCSJOQ1Q2Njg3RCIsDQogfTsNCiANCkBAIC02Niw2
ICs2OSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19jaGlwX25hbWVzW10g
PSB7DQogDQogI2RlZmluZSBTSU9fTkNUNjY4MV9JRAkJMHhiMjcwCS8qIGZvciBsYXRlciAqLw0K
ICNkZWZpbmUgU0lPX05DVDY2ODNfSUQJCTB4YzczMA0KKyNkZWZpbmUgU0lPX05DVDY2ODZfSUQJ
CTB4ZDQ0MA0KICNkZWZpbmUgU0lPX05DVDY2ODdfSUQJCTB4ZDU5MA0KICNkZWZpbmUgU0lPX0lE
X01BU0sJCTB4RkZGMA0KIA0KQEAgLTEzNjIsNiArMTM2Niw5IEBAIHN0YXRpYyBpbnQgX19pbml0
IG5jdDY2ODNfZmluZChpbnQgc2lvYWRkciwgc3RydWN0IG5jdDY2ODNfc2lvX2RhdGEgKnNpb19k
YXRhKQ0KIAljYXNlIFNJT19OQ1Q2NjgzX0lEOg0KIAkJc2lvX2RhdGEtPmtpbmQgPSBuY3Q2Njgz
Ow0KIAkJYnJlYWs7DQorCWNhc2UgU0lPX05DVDY2ODZfSUQ6DQorCQlzaW9fZGF0YS0+a2luZCA9
IG5jdDY2ODY7DQorCQlicmVhazsNCiAJY2FzZSBTSU9fTkNUNjY4N19JRDoNCiAJCXNpb19kYXRh
LT5raW5kID0gbmN0NjY4NzsNCiAJCWJyZWFrOw0KLS0NCjIuMTguMg0KDQo=
