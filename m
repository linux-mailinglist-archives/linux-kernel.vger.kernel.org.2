Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57568307F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhA1UNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:13:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49488 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhA1ULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611865513; x=1643401513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zEEpmeJBlM5rDAq6AS5QzRyMDT8acdljS4ZYLf668Mo=;
  b=JH+6dx7lIRJqsYbBXA/o8eHfNCT8WmgQQSa+88NdZ9kePkBbW+4Wcr1S
   KbBryMMAwScD+uFlvgmdLhw1hn5Q3P6vgja5NqNbR2jJXER1Wj3h446+w
   KPkMw+d9Nn4LIMOOKUOMLzJYQrtvsnpyyK/1ls0WxmbZhQtOZBNuKMUqT
   +Z/GJ9CL6hy12hJ7Osq685IZp79woEOeV2ASEm1nJDirDa+oGJXHReXsZ
   nmvAFG14CA82jIt7kMEeo6egQRuJfq/IqzpzvySws4C5HwWgXjovcsGdA
   riLkK7y/syIVF0LMUtfMpPErpyyaDIwvSlGLSVE752llsV6zZ8Zm0AUSE
   g==;
IronPort-SDR: +7BA1NUC+g+nQx8T1/9J0NdbaZLrlzf6E2eFsZo/3B2dLOoCkABNA7x5N9fxi3FUB6acuDaIC9
 yU83+pKeXUfgb/q0bekMcFI00NLZdf3ng30Lkj81LLQ+NVtZHSY4p2ynVhsLObb4090rzr06yc
 ZUPR/wnTkJ7mfz2fq4yYU4EL7rSEskC8d2KkY/r7rf1mzxdKexnC6xLlpummmYNbPB6RgEX3Mo
 wSHBgkxjsE+Td7KuPkxNtBaGXFs4slk02o2CDBDs2rrVPI4dHfXYEP7+QAN6zkz2eWoar9Pb9Y
 MTA=
X-IronPort-AV: E=Sophos;i="5.79,383,1602518400"; 
   d="scan'208";a="262610579"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 04:23:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+LhL/8i8sKzxbcam/6UwmJtLzPOhmNVaZUkegZHttyrJYxjeiKdb8thfaExao8mjjP2d4F2Q2qfK95By84Y0cmiOKDH2EaM4Yy6gXy2bAKJ1+Q6talOPjqfU7M6Jj82kYu8j8osVDqaEPGNye3kIF0OZGr5yw4ECdmI5cGIitiG5e1EuSXZFuf4S6uGHxJ+uUBoCutkEQ/Cg6u8xW9Z9co/QnOYLEWQt2II9Y9HZdaZRhDVQiwxhx+/BS7u6jAZnln5yXOcpdF8P7NPnK9nX31OLkiOkFSC5FezgThEIGjt0d4/GMp29VkDrmVuLSWPSy2ViZ+66ieCJcnSlRCGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEEpmeJBlM5rDAq6AS5QzRyMDT8acdljS4ZYLf668Mo=;
 b=PaHernv2n3MGbEhFkbJqP9PSuSU1pyuWfP7fcd2Jx+AMsCmWS+Sp9BTTN823xmWRtc39UJknJWnkW2YurhgZycIxs0myrU65d5tEp1NPIiIRZtOBtB65bkBzXJuFqYePSgo9nZilAb6Kr+4PbgmiRhSeuDksLDlw3bu7mjM+lWpIqvpQKpb0JhbfeMKbpn0cpiK0namH4LcQvxORP91AJGG+UFhYwJzYhZunHiZ8GOpXAXHUwqD4f9t+LlqWaeMRTguqM4yGYmWaowN2mD6Gb9m5sqJ0nCN81KFiEmQGZ/7484mBlogFmSKswlCXZNOTIq3yJG3JhybkWUKEhAN2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEEpmeJBlM5rDAq6AS5QzRyMDT8acdljS4ZYLf668Mo=;
 b=F2Cwehkyz1UsK5MMptZPxvTosybAIdSGosJ/ETg1LBtoOPIfzsQyGBodxLZnZZMbk90fxk3rNQJ+UImQ7L5d/F6jZKSHUWBKXH6kI/XLZegrA8yJQVnmBxknKq0NVcj6P8f+Wfg0x1k5hWS5x1E+GEeN1v0HxnrgcTfXmBU525k=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by BY5PR04MB6373.namprd04.prod.outlook.com (2603:10b6:a03:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 28 Jan
 2021 20:10:07 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::ec3e:7abd:37a1:eb8b]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::ec3e:7abd:37a1:eb8b%9]) with mapi id 15.20.3805.019; Thu, 28 Jan 2021
 20:10:07 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH] arch_numa: fix common code printing of phys_addr_t
Thread-Topic: [PATCH] arch_numa: fix common code printing of phys_addr_t
Thread-Index: AQHW9Sl5lhSWQS7LUESA0z0V5FxvVao9eNKA
Date:   Thu, 28 Jan 2021 20:10:07 +0000
Message-ID: <85b98720b27e45ade9bc9e78342cf2d926a729a7.camel@wdc.com>
References: <20210128035533.23722-1-rdunlap@infradead.org>
In-Reply-To: <20210128035533.23722-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [99.13.229.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afd07b71-4649-4463-da01-08d8c3c8b55c
x-ms-traffictypediagnostic: BY5PR04MB6373:
x-microsoft-antispam-prvs: <BY5PR04MB63737A602DDE5E69C744400AFABA9@BY5PR04MB6373.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8VanZjwgFN8sT9wDhIoNVlw3D8JKAN5Hqu9XXpTj7kcxJ5rHo17ZMdSCVYhWUrIWP9umn7qvczez4gYQyQ5n4A1DE6G3J/3F4dK47FTCpDhcq5W+fZbBaFWq4xNqq8ZwdgXGNUW2Xa5SnnD+RmjTSckiD5O7Z/Fxb6jE4kjoXfadWCmi0DPR+6meke/XbhhOa4n+Yv9sMeYbHTG+L1iR6TiwD2phctEjPHkJI7XmjT3iszAKPxuEuwgHJaFovJ8WxtZJaDPkRt8xVSJBlgJL/NbP1GPoAF1RjoPCTRNp0/OWStIBYDycudM3ZilO2MxUk7xQq9lZiXOVVPENe/3phDUDD48vzQXyeDNS4v50dxAtw1jUCmSAQLP0X7zl7ZAziMbqxQyaVLPCqf5vKY1umxh7hGeLdN1f/3Z+4H952EgvackmhzCCqyNLOWXbp+MUQKNfLw2vOX5X5s+fjvOgrxIVOu8EiWS3BGnJHpHwuw0IkinGhXnVq8hwcWzc53+IjRlUAjIUDk/wRhwkvYjgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(6506007)(6512007)(8936002)(86362001)(83380400001)(4326008)(2906002)(64756008)(66946007)(66446008)(186003)(6486002)(2616005)(478600001)(26005)(5660300002)(36756003)(316002)(54906003)(8676002)(110136005)(71200400001)(66556008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TFJkc2p5M3VNK0hIdlpPSnJWOER1dnUrSlhINzZ2TXpwUGtaZmI4VHY4VTkz?=
 =?utf-8?B?Y0hvbFJjdmhtM3ZIYnhDY3pPVll4Nnk0SkRjdWU5WkNwZXN0T2d4TEhDSHY4?=
 =?utf-8?B?L0s0V0pXUDNFYW4xcEF0STV4WU4rQUpPNElSQXZFbjN6U20wNzM3SW03alM3?=
 =?utf-8?B?NzNPWEw3K3c3QU9kdHJkR2tudmRsMk5UWHlvUml5Rm1GLzFueXNBOTBiUEg0?=
 =?utf-8?B?WFlWYThRUnZjU3huM0Y3Q0lWTTJoNEZna0lWT1hzbytDMERORENSVnBDd3Yv?=
 =?utf-8?B?cEY3TVhpYkQzRDQrbDdhUE1BU2RubGg1N3hWOEZDeVE1RDdkc2pBVTBOQi8z?=
 =?utf-8?B?Ym5ta04xdE96WDAvYXpUeEtqdnczdGFQNE43b2xHUS9tZmZ0YlZXVnY4T1Jx?=
 =?utf-8?B?QVl2QWYyNHdrdkZld2YxYk56NUxKamhUNzFuQllQVkxCdEJ2TUMzMnJNUVho?=
 =?utf-8?B?bWUxWlkyQ1o1dmVFM2lyVHFBaVlWZXZ4TjhyaFpXQm0yY0JWc2VGUlNMVkhz?=
 =?utf-8?B?SURWOGtYVm9wV1RuSllDdUdUSFYxWUZCWnhHZ3NyN3E4VFVoWHU1RklSMGRD?=
 =?utf-8?B?S2VtSnpVZFZiUHRYc21JM1VJV1dnd01sY3ZjSzhtRXVDK3EwR1NnNTIzQkJU?=
 =?utf-8?B?KzEwK0htaWZlSGloMTdNN2cwV1hxZ0MrbTdaaU9xOGg2YkYxS0RNOUVFcVVE?=
 =?utf-8?B?NmFOekpGV3ZCWUN4YzBuYVpIQitQenZMTjVZN1pQRkZ1NmdZTmMrUkpoK3ZP?=
 =?utf-8?B?MDY3d3RIZ3lYblcwdzgwbktUcWw4STVCYXJGRG0ydEpTUjRuZ1poTUFUQW5K?=
 =?utf-8?B?S3VacDE5R1k2WWlPM084ckE0NGpEZE9GUEFWWUVISW9EMlpQRW1QVW93NjNu?=
 =?utf-8?B?cVVpSHZ3dmZwM2tyK3hhcUkwYUdCVVh5Sm9FM1NWR0h2dzRjUmc0eVYvZ0V5?=
 =?utf-8?B?QWJKcStQNkxPMzJpKzA5TTc2WGd5S0dlNUdVcExZS0EyazkxZm1zY2tGNWhZ?=
 =?utf-8?B?SnZPYUwwU2NYOG1YMWIzVHJGK1dpd2R1eTR2RTY0aW5WcDVnMmtTWDN3bGpN?=
 =?utf-8?B?bTVNRThzWlhMV3FmNmE1aXVzaFZzZk9ZOUlwWDhNVnJHRHhMcysrLytRK1hC?=
 =?utf-8?B?YlhTWEtYK2xwU3JIaHNzT0FwN2IxYWQyTlFwUjVRS3NWQThaWURsazFPOUpM?=
 =?utf-8?B?dHE2MGN1UDlxcEovcUxZU3VHNnRxUUlIcHEzVHIrMGJkWXRZUTZJcVY5U3lQ?=
 =?utf-8?B?S0Y1cGdObDdFeklscmxjWmtHZXY3L3RoWW5taXo3V1BSUHRMV1ZQdEd1VUQ5?=
 =?utf-8?B?SENERXNYb2pOVTF5YjExaFluKzZGcjhueXpQa3BtdkxlK3FuRklzc24vbGRa?=
 =?utf-8?B?Z2Fmc2ljcG1FOVUwQWNTNitUQndDa011UlNQL1Jwd3VES1RteUJJY2NBY09o?=
 =?utf-8?Q?0Xcy5r8z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BAB6C94E5EA0141AC154614807E5467@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd07b71-4649-4463-da01-08d8c3c8b55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 20:10:07.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBcWxDBszn+fAVySmyn6lLmfqt386ZTDeQtlXkJzZwCHYh8f3mhjnPoSn8rQmbnVUk7tvAjqohtESpIG06K3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTI3IGF0IDE5OjU1IC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IEZpeCBidWlsZCB3YXJuaW5ncyBpbiB0aGUgYXJjaF9udW1hIGNvbW1vbiBjb2RlOg0KPiANCj4g
Li4vaW5jbHVkZS9saW51eC9rZXJuX2xldmVscy5oOjU6MTg6IHdhcm5pbmc6IGZvcm1hdCAnJUx4
JyBleHBlY3RzDQo+IGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQnLCBi
dXQgYXJndW1lbnQgMyBoYXMgdHlwZQ0KPiAncGh5c19hZGRyX3QnIHtha2EgJ3Vuc2lnbmVkIGlu
dCd9IFstV2Zvcm1hdD1dDQo+IC4uL2RyaXZlcnMvYmFzZS9hcmNoX251bWEuYzozNjA6NTY6IG5v
dGU6IGZvcm1hdCBzdHJpbmcgaXMgZGVmaW5lZA0KPiBoZXJlDQo+IMKgIDM2MCB8wqDCoMKgIHBy
X3dhcm4oIldhcm5pbmc6IGludmFsaWQgbWVtYmxrIG5vZGUgJWQgW21lbSAlIzAxMEx4LQ0KPiAl
IzAxMEx4XVxuIiwNCj4gLi4vZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jOjQzNTozOTogbm90ZTog
Zm9ybWF0IHN0cmluZyBpcyBkZWZpbmVkDQo+IGhlcmUNCj4gwqAgNDM1IHzCoCBwcl9pbmZvKCJG
YWtpbmcgYSBub2RlIGF0IFttZW0gJSMwMThMeC0lIzAxOEx4XVxuIiwgc3RhcnQsDQo+IGVuZCAt
IDEpOw0KPiANCj4gRml4ZXM6IGFlM2MxMDdjZDhiZSAoIm51bWE6IE1vdmUgbnVtYSBpbXBsZW1l
bnRhdGlvbiB0byBjb21tb24gY29kZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8
cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQo+IENjOiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4N
Cj4gQ2M6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJkYWJiZWx0QGdvb2dsZS5jb20+DQo+IC0tLQ0K
PiDCoGRyaXZlcnMvYmFzZS9hcmNoX251bWEuYyB8wqDCoCAxMyArKysrKysrLS0tLS0tDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IC0t
LSBsaW51eC1uZXh0LTIwMjEwMTI1Lm9yaWcvZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jDQo+ICsr
KyBsaW51eC1uZXh0LTIwMjEwMTI1L2RyaXZlcnMvYmFzZS9hcmNoX251bWEuYw0KPiBAQCAtMzU1
LDExICszNTUsMTIgQEAgc3RhdGljIGludCBfX2luaXQgbnVtYV9yZWdpc3Rlcl9ub2Rlcyh2bw0K
PiDCoMKgwqDCoMKgwqDCoMKgLyogQ2hlY2sgdGhhdCB2YWxpZCBuaWQgaXMgc2V0IHRvIG1lbWJs
a3MgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX21lbV9yZWdpb24obWJsaykgew0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBtYmxrX25pZCA9IG1lbWJsb2NrX2dl
dF9yZWdpb25fbm9kZShtYmxrKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBo
eXNfYWRkcl90IHN0YXJ0ID0gbWJsay0+YmFzZTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHBoeXNfYWRkcl90IGVuZCA9IG1ibGstPmJhc2UgKyBtYmxrLT5zaXplIC0gMTsNCj4g
wqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobWJsa19uaWQgPT0gTlVN
QV9OT19OT0RFIHx8IG1ibGtfbmlkID49DQo+IE1BWF9OVU1OT0RFUykgew0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX3dhcm4oIldhcm5pbmc6IGlu
dmFsaWQgbWVtYmxrIG5vZGUgJWQgW21lbQ0KPiAlIzAxMEx4LSUjMDEwTHhdXG4iLA0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBtYmxrX25pZCwgbWJsay0+YmFzZSwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWJsay0+YmFzZSArIG1ibGstPnNpemUg
LSAxKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBw
cl93YXJuKCJXYXJuaW5nOiBpbnZhbGlkIG1lbWJsayBub2RlICVkIFttZW0NCj4gJXBhcC0lcGFw
XVxuIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbWJsa19uaWQsICZzdGFydCwgJmVuZCk7DQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOw0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gQEAg
LTQyNywxNCArNDI4LDE0IEBAIG91dF9mcmVlX2Rpc3RhbmNlOg0KPiDCoHN0YXRpYyBpbnQgX19p
bml0IGR1bW15X251bWFfaW5pdCh2b2lkKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoHBoeXNf
YWRkcl90IHN0YXJ0ID0gbWVtYmxvY2tfc3RhcnRfb2ZfRFJBTSgpOw0KPiAtwqDCoMKgwqDCoMKg
wqBwaHlzX2FkZHJfdCBlbmQgPSBtZW1ibG9ja19lbmRfb2ZfRFJBTSgpOw0KPiArwqDCoMKgwqDC
oMKgwqBwaHlzX2FkZHJfdCBlbmQgPSBtZW1ibG9ja19lbmRfb2ZfRFJBTSgpIC0gMTsNCj4gwqDC
oMKgwqDCoMKgwqDCoGludCByZXQ7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobnVtYV9v
ZmYpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfaW5mbygiTlVNQSBkaXNh
YmxlZFxuIik7IC8qIEZvcmNlZCBvZmYgb24gY29tbWFuZA0KPiBsaW5lLiAqLw0KPiAtwqDCoMKg
wqDCoMKgwqBwcl9pbmZvKCJGYWtpbmcgYSBub2RlIGF0IFttZW0gJSMwMThMeC0lIzAxOEx4XVxu
Iiwgc3RhcnQsDQo+IGVuZCAtIDEpOw0KPiArwqDCoMKgwqDCoMKgwqBwcl9pbmZvKCJGYWtpbmcg
YSBub2RlIGF0IFttZW0gJXBhcC0lcGFwXVxuIiwgJnN0YXJ0LCAmZW5kKTsNCj4gwqANCj4gLcKg
wqDCoMKgwqDCoMKgcmV0ID0gbnVtYV9hZGRfbWVtYmxrKDAsIHN0YXJ0LCBlbmQpOw0KPiArwqDC
oMKgwqDCoMKgwqByZXQgPSBudW1hX2FkZF9tZW1ibGsoMCwgc3RhcnQsIGVuZCArIDEpOw0KPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKHJldCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHByX2VycigiTlVNQSBpbml0IGZhaWxlZFxuIik7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCg0KVGhhbmtzIGZvciB0aGUgZml4Lg0KDQpSZXZpZXdl
ZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQoNCg0KLS0gDQpSZWdhcmRz
LA0KQXRpc2gNCg==
