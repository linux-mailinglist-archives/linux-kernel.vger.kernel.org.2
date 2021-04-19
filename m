Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC868363C85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhDSHcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:32:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56152 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233438AbhDSHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:32:12 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C3285C063D;
        Mon, 19 Apr 2021 07:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817502; bh=rcfPd/3ggT7+lTrqWoiu5bYMGOlH2B6V90cBMKOoAxo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bAKbPAqf0gdkx85ANLW9luf2Ippfn5Bgp7kA99KS02WXBjlXabIl6tZ/TbJ4PqEYa
         zhIQmH428WSqtBdA4LQdnhOM8pasGIz3iOeVAa3I47QG481fRuP7Jhuu+qTfe5tZ0L
         D5FpAaD3K6tyWkLQ54PagwdU9d5RbBAGF2MsNhzLqpGfEjdSomXsVit38E3whGmwQv
         MOXlYwrHMNqtgUAgISsi8OJJp0tZ/MDkCVdsWEyG6aUGg3qOqDmLxaBtLJjI00CkAX
         SIpWYETW5QTSeLu8DCLZ+Lj7sAJuPIY3EKxp/sZT7pz57is+9aGM3AHFKc2mc5HE9y
         I/nsqrqTxMsSQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 98FE0A0070;
        Mon, 19 Apr 2021 07:31:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 571CE40138;
        Mon, 19 Apr 2021 07:31:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Kjq2Wzpk";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdFvb3KlYiqBVIHgSC04s+8x6SUssBwYUafjiPdderyUaYVMCE0ea0T9jmucNfnJ8KwyC8snUvsjYH//hvdCTpZ0fwHhq8eW2iH2j/8nnSXbtsMsSghoBbMz0IXIRQuSpyfJpu8cA/mz+0oYevwsMj3jiE6MOPmY2GyvjXNR80WEO8vlbpAEm8+E2SfkkNZsD5n4ZKwuPVcuSf9FZZuAfDyONRMGHKsP7PqgACB0DUogaUhSkqwX2AeSo2pFlAAT7003gaF09MiKMbLmo+PpJACSD189TKsh3ipm2f1YsmRTSeg6P1+bWseRUisL+QrKm1rmi3oQh2hoBCzNz/kXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcfPd/3ggT7+lTrqWoiu5bYMGOlH2B6V90cBMKOoAxo=;
 b=UHy60OsmbKdoVaPvXsLLncbHroXp3BjCkmV0409vsQDK06ENaO7iVqb/ZJsGka/DAE2m9gU8Ine7eBJhOqcxiu87zQVg9Dyaga8KYKkbeSG06yz4bNGplwTptaaySLDErw6nco4On14/G0qFu6lXe7hYXNGxj4ijS5CU2TX/yjE/rHLrp9tmkssirFa4Z/SvFqZEomLqtFuuSRsruaGgORVD7hmHuRCoXQXEp3Squ1tftIUs0OZAFLTBYv5JLStaWE3UHKfzhO/9hKzL9K+ePwM+y9JEhENv0r2bXMRKbjzAf+uY8n56xhgjCUeq/hpLtUo09X3Ix+JVpr+Ru5CLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcfPd/3ggT7+lTrqWoiu5bYMGOlH2B6V90cBMKOoAxo=;
 b=Kjq2WzpkfyoZZxPTfbJp060oCTTVfaGti+/tEWywwG4P1B/Nq+kIcR+LOllQmVE/XzdlKatiE+bDMMEDCK74u3zz6HjrlIjrH1b+MJnjXeUFpvQ4cwjSOn1gEVAwbUtVdyLAvxTwbhnD5XZ7VsMAM4IwiyYrYmvTmoPzH7xacBI=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:31:40 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:31:40 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 11/15] usb: dwc2: Add hibernation entering flow by
 system suspend
Thread-Topic: [PATCH v2 11/15] usb: dwc2: Add hibernation entering flow by
 system suspend
Thread-Index: AQHXMr7F1gIt+wWdvEyEElnTzXWztaq7dpSA
Date:   Mon, 19 Apr 2021 07:31:40 +0000
Message-ID: <aea3a5ad-d511-743f-90f8-3735a07a2b24@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124811.BBFDBA005C@mailhost.synopsys.com>
In-Reply-To: <20210416124811.BBFDBA005C@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71cc3fbf-052c-4880-a2f1-08d903052c6d
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5000DADA3FFE1E618EEF89C8A7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czhmqlFkteIDehKtjLbydRoRlQ4cXKFe7xlKcoPh4912HzoTinsmRT/SZwQkHEUR1T7ai+VxEeBi7v8RFR9HpDkmm5we4RRdWXA4HTr8XygViu+Rtnb/Z1lf92UhDLDTw/6wryKwZtUmSDNLeLuycuEVHbByUz9djGy+4U6eya4bBupIei3snWD2dNQdSdwGbMV7I3c7b4H1UttmxrgkPs8Tx3+uX62x9GVr4sGkPj2FNd1e/RRiz+P1g8G1Na73JL8UL9RUy5P8iQMjzZYOsaWVWc/8ayHYwYjDDgbLxHArDkrRfw4atXK3YN4Qfy1HChfUhduzyeHHxcTUNpz9wPpGHwVh/1nqAtvvEr6POfwdWtlLkeu+3ayS/jrD2pgjnI5y71VluyLDRzPYzDHQkm0qzBUxMuEk9pJozQzf32YUDm/MK+u3WIotdU1GIev6xsgq2PCQS6Znbhx1l2RKraUWadfNwXPA6ef6xu4eKvrgUSNzfO8EwcBFXOqEhD27eLO8d6Uwpvf0/bwrw/NlnDsjrBcBMcJ1UMtrmT3ClAnzdGvLdPzvcU4NGyC4S7SdGqzXsGD7x3PwoSzNgMEEEep/HIXL4t3V4LdSrrWSboQYqZ3Q0ZvFWnNK6b1irdEd6izryLCBfH+uXvchxiGIxJ+Ak2vampf2zAbKWDCHLD4GeRrM2Am7jt51CvTjOasF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(15650500001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?REhvWXplRk1TSzRiS3FQam1xN21yMGJ5N0tLcUhRNjBkT1hUUWppYzRSQmhR?=
 =?utf-8?B?RG5CQmRjamRGM0RjWWZuQ01wWEpmeGRHZU5NRE5NWndaYitheVgxUmVieUI1?=
 =?utf-8?B?RXdkb09kU3N2V1hGZE5YbzdVcjVsTmorTnBMUzJIaTJ3L0k4djBtNm0wbStI?=
 =?utf-8?B?MzZkb0wzV0ZaaTBMSFBEQjU1TnYyYVpvUHY1Q0xwTk1mQm8rTXBLajR5MVRW?=
 =?utf-8?B?YkVHa1pMaW9aOFF5YWRtUXFjS1FLajhqczFBMHEydm1NZ2I3KzRUVVRBelRi?=
 =?utf-8?B?cXljWUY3V3N2aFZVZ01lOCtsQ201ZnR4dFByditnYzVZODFkQlVNazM1RjFx?=
 =?utf-8?B?UDloc29Bc2kyR2NvaVdueFRWMDRPLzc4WlFpYm5CT1FiVUZ4T1kveWZpOG1q?=
 =?utf-8?B?VU1vdUU3akMwYkZZa1dYM0FqWUVXMEQxK21UWHk0dElqYkpZWWNXVE9UR2cx?=
 =?utf-8?B?WTZJTHhicmxCQ3F2S2NwTHgySHRLYU9nWjQyRDNDNm8xME5Bb1RzeUxSZGVz?=
 =?utf-8?B?VGpBSUIxdjI4dlpIUWl6VmUrdWpUUE9GbTh4SXBsenN5U3ZtMUpYL21sSjZx?=
 =?utf-8?B?UEl1b3ZQc1NYeHhzUlpPaTFYcVZ5ZUVLQ2JKeitoaG1odlMrdGZkZ2kvQm96?=
 =?utf-8?B?QVdLcGoxeXF4Yk9ESnFxUWZOM3liVnVoUUFLeVpkNE9UUHhZbldYdTRjTmxy?=
 =?utf-8?B?UnQxSFZtbnBNTkIyYVNqckNYR0ordm4wZWR2dFVhekxkeE53amNybXhKNmV4?=
 =?utf-8?B?OWY3Ump4eFdvd21iRTIrblVHaHE3ZzVUL2hkaDNXcGJqem5HbS9iN3Jud2xP?=
 =?utf-8?B?dmtsMjZLZyszY2FLQTIxbGp6UC9VdFRaMFdRSUNIcEpSNThYSThWMUt2alpu?=
 =?utf-8?B?TXZrbURaV3l4aVBQRGI1blVvVjF1bithZ25FZ1VmcVdkVS8vMFFxOUhGTU9E?=
 =?utf-8?B?N015aUFDL3hqR1dUdjlQVWUyU0ZMN1Y2dE9RVzgyTmdoNUVlSWFzV3pOdm44?=
 =?utf-8?B?Zko5eGNGa1RlV0g4UThBNjc2SU9jd1hZT01qOHlmNEduWkFPWm1mWFFjMEJn?=
 =?utf-8?B?ek5BNFFySDFFMndIUUYyeForbjZKT3A3U3JibCtXb0NyTldUeGErbDc0MU1w?=
 =?utf-8?B?YVJVNkxRdDdHTThsY0V3dFVQSC9Rek45NGQvckl1SGcvamlHcGhpdlF4OFo3?=
 =?utf-8?B?S0RNL2kwMWk3ZWlnZFJaZmtuQVZBR1BYdXNxd01ibWE0QXVaSXJRWkIrUXgw?=
 =?utf-8?B?NG1FaVF2bjBVS2xJUUhvT0MrY0loU0w1aE84OGI0SGV5YnoxSExkTkZOeks0?=
 =?utf-8?B?VVhSaGFETmRiV280MmNRWXRZSFdud3lCays0Rkc3bjU4dWYzT29WWmtZbldH?=
 =?utf-8?B?eGwrUkRWK045TklEWGtmYU9vVHA0MENYc3owb2hxaVB3bjdMSzZNakU4ZjJs?=
 =?utf-8?B?MmlxVWdad05LZFlSQ21lZXo2d2dQTlc3RGU2a1ZEakorY2RCSHpBcUdVMDB6?=
 =?utf-8?B?YzVqS0ZMUXlGOUNMQjhBV2tFM2JsaUsySkhzcG9SNmVJOFJobi9SdnlTeFlV?=
 =?utf-8?B?ZjY0b3czZjBqT3l4dEFTVTZyZTk4aTJTWGxNbDV2ZmJDblJhcnRqYkVuZDFs?=
 =?utf-8?B?QzN5U3JHSnpGcmJyUmtkSGRjSlhRQkRKU3hOa1c2aHkzTkFHMWZOcmdzQmpa?=
 =?utf-8?B?eVFzL1hsQzl0UW03NnlkWXZMRFNVbjltRVZCVHQ1NEhmc1d5MHhQdG02SWRt?=
 =?utf-8?Q?l+D8CY1CAjF1MY+Zps=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CABE8E6E1EE2F4AB5A578A7C32B0E90@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cc3fbf-052c-4880-a2f1-08d903052c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:31:40.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnI3O3ourv+CAP11Y7OIvbx1tDshXfMsT1VmT6n/aYzjRwbd19JfOhUzojvaCyh0MnFQOnCwRNjAN5tYN1+vQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDggUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gQWRkcyBhIG5l
dyBmbG93IG9mIGVudGVyaW5nIGhpYmVybmF0aW9uIHdoZW4gUEMgaXMNCj4gaGliZXJuYXRlZCBv
ciBzdXNwZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcnR1ciBQZXRyb3N5YW4gPEFydGh1
ci5QZXRyb3N5YW5Ac3lub3BzeXMuY29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4g
PE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBDaGFuZ2VzIGlu
IHYyOg0KPiAgIC0gTm9uZQ0KPiANCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hjZC5jIHwgMTAgKysr
KysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMN
Cj4gaW5kZXggMDkzYjE3MTdkZjAxLi45Mjg0ODYyOWNjNjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBAQCAt
NDM4Nyw2ICs0Mzg3LDE2IEBAIHN0YXRpYyBpbnQgX2R3YzJfaGNkX3N1c3BlbmQoc3RydWN0IHVz
Yl9oY2QgKmhjZCkNCj4gICAJCWNsZWFyX2JpdChIQ0RfRkxBR19IV19BQ0NFU1NJQkxFLCAmaGNk
LT5mbGFncyk7DQo+ICAgCQlicmVhazsNCj4gICAJY2FzZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1f
SElCRVJOQVRJT046DQo+ICsJCS8qIEVudGVyIGhpYmVybmF0aW9uICovDQo+ICsJCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+ICsJCXJldCA9IGR3YzJfZW50
ZXJfaGliZXJuYXRpb24oaHNvdGcsIDEpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZGV2X2Vyciho
c290Zy0+ZGV2LCAiZW50ZXIgaGliZXJuYXRpb24gZmFpbGVkXG4iKTsNCj4gKwkJc3Bpbl9sb2Nr
X2lycXNhdmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwkJLyogQWZ0ZXIgZW50ZXJp
bmcgc3VzcGVuZCwgaGFyZHdhcmUgaXMgbm90IGFjY2Vzc2libGUgKi8NCj4gKwkJY2xlYXJfYml0
KEhDRF9GTEFHX0hXX0FDQ0VTU0lCTEUsICZoY2QtPmZsYWdzKTsNCj4gKwkJYnJlYWs7DQo+ICAg
CWNhc2UgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX05PTkU6DQo+ICAgCQkvKg0KPiAgIAkJICogSWYg
bm90IGhpYmVybmF0aW9uIG5vciBwYXJ0aWFsIHBvd2VyIGRvd24gYXJlIHN1cHBvcnRlZCwNCj4g
DQoNCg==
