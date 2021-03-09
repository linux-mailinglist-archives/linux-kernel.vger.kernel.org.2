Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF86331FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIH3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 02:29:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:6531 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCIH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 02:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615274938; x=1646810938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2tbkoUGTro+MmnlxiEO7H0on7FrAska+0HBxrvtwJVk=;
  b=Q6uuXwfMZPka+0xY3oo/uyygjMRWcwTPcDWOMj3GqWwdGMxb3z8fIjb6
   rf0+8xgChE+lzkp83v4I+g+9hFaOzkyR6CzzZE/U75hvbOXz3YTjugO/H
   /wBlCpZjCp3+EztlSMq2Fa9+pWENnhdQc20Vj8J1d4dwHV2RZs3OhM5xz
   al+Yw0kSg5fHOb7WBj1INESh1HRCeiZsz7kavMjrM7wFZgq8hrwfV4BL2
   c+YePl8Kr5osICOLaNCRcvR/uT33W0WJI9HPtPQwmyAmhYURHw7U6O3qn
   vKXTj8arGlaNLaT1vUQrR69+ME+uUxSG6OHMK8AhNoNIWKrNlrFqVA/Zd
   w==;
IronPort-SDR: POsoBChKmwM8F4E90Sg8efJZ4JZBOuB0nC9/w2gswDhqHRMY4M837TDeub8Jtjk0umgLmLPygU
 WCdBNlRCCkHeLw8E7IxpxjxCFEwCb8KTB4KzdQWibd1ehRWhtCo3JFRi239y4KxwhEDXYdV9UQ
 J7FEQhdihVLNtR6M0VXIh/8rpWxPGY9t6urebb91fdnezbNggMDcdj40Qdhsly4YqXauqmBW7q
 kZwHCqZcWYsf8ecL019SeRybbFxju36nlzzR2rKcE15QDRuOshDm1wjAdue3Ku4WuTtNoVrkyu
 7RM=
X-IronPort-AV: E=Sophos;i="5.81,234,1610434800"; 
   d="scan'208";a="109247937"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2021 00:28:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 9 Mar 2021 00:28:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Tue, 9 Mar 2021 00:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et/ixpVcGaoVLpT17okJqNZglnjJoLrxAWrNiOg7BtVWs0OAfIIykYrQFPRjA+x1MmKGu+uMnxWEgSToiZymMrT8iwKbw9E0HRk2/nof4TrQbCA9Dd/ePJiFYMjHz2MTcpjTod/o0yyBLL5uWKhd8two/y2kirPE2yrP2hgERX6MPaW71LfdreM+JPOa8iIxIwCxvyt04marMvDVB5MWWGmlj5EM2y0vxmiy3MSAsQ7UGmKTDf0RomliEXhNIkvvS1sVJPpagR+BPMVPSrG0XAVrC++kbAYw9PmlAJzai64qMD5fHpDTVWz8jOYjVkTQ6gP0byIYdHUw3YMI3x/tFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tbkoUGTro+MmnlxiEO7H0on7FrAska+0HBxrvtwJVk=;
 b=C3iI6EgGdOV9egYhUeXb8/ZUL2rFqR9uPyoLteGwQ+H5h0QhgYykbB969EWchC+PXmOEgUECD2Qeb4E8aYH58KaFsVM2mYMd45rHSnpSfMIfP7z5HLTEtsTtkwUac3ndlEU4LmvDMIaLOm0fLltRX9wrBLcxiEH7FpM2E5KU0/6wcAHm+BnIun1UwJoj72fCh1LyRwxF82RYVjKSMZf390TOArbgtqwRaV10PbNXexS6WK4bjCuvwK8qZjRWni0bNeEiMMkeEmNWxxw9M23EFhTwbVU1tQQ5ioVnPLs3SfCzFVhkHlVozVoDujRrlVndR4nZtAP/VmMYq8jOD56VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tbkoUGTro+MmnlxiEO7H0on7FrAska+0HBxrvtwJVk=;
 b=k+eZwLszFK/1lQ3NS6xOPl3GpPUV1Fa7adDd5qOt1DSizBxrmcD0RWyi9y9qUsyFB7p4w7BF9hyGXU7k5Fjn/KDCmxe77QuYDcyUE3L4xvrHSzlINoOyfKregjkgyXLFN3JmZ453VyuX3tVxWPTAG4Iu4pn8/rzy1guULR4NeK0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3103.namprd11.prod.outlook.com (2603:10b6:805:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 07:28:52 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 07:28:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
Thread-Topic: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection
 logic out of the core
Thread-Index: AQHXFLXahW+TwdBlzkur1VDkcdYBtg==
Date:   Tue, 9 Mar 2021 07:28:51 +0000
Message-ID: <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
In-Reply-To: <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a7b76a-47af-406c-36b1-08d8e2ccfd13
x-ms-traffictypediagnostic: SN6PR11MB3103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3103100CCAF3EBDFF6D59969F0929@SN6PR11MB3103.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1c7Z58N+Ur769EIFxq30uhgBHfOIn69RjRL06siYYhvF3BW7RSDndWa/1A3FWo3HfTIUlp5n2PYbGUba0puTD919om8/Svmt+NNsQYUoCU3eGodBCj4GkfnNrH7Z5ZLa7Z+8K/msKqlU3Xi72py6ARTbn/sdv/XSV46qH8xLo+3ttjV73SBT/ankMc1E2O93zPF9LB05YSQE6N2tfVTWN8FRC+JLNIEHpQSsFAVWT7L+/WifubKtOBrgSqai/e0wO5vbTA9mFKSw/DstNqYHMyc6ltDMgJoZzWOaaOuw1QFupgcspujiQZm+ghqNsG3u0/8mxEWLAG8FjyKEnp71JkeqPmAn2KExdzqU/HcQcF57B/FX+nf+fvdieqvi0BeERTgTUtlOYE/3yZUdmhDEzqiloveKSC08/cz0B+sOww667anOghq4m5KXDZlxojVBf5fsAf2I7LPJB7WKNCEpbVF2sRD64soaw6DDrZEOMOIlVS9whu4TZLf77whwHnG0EP93g1teaIa5yfCgKk7Xd3+xYiiGUraI/uEPveqOPWg08dszOE4yocSLWRljdOLLU48K1PHYKYvi1+KhprlbRvXitmg5e6enr/DZpYf2/WY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(346002)(396003)(36756003)(53546011)(71200400001)(2906002)(4326008)(66556008)(31696002)(76116006)(64756008)(86362001)(2616005)(31686004)(5660300002)(8676002)(316002)(83380400001)(6506007)(478600001)(54906003)(91956017)(8936002)(66476007)(66446008)(6486002)(66946007)(186003)(6512007)(110136005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WkxPMnJsQm5RZGMxNENZTTNzMjF6L3g4R1dMQlV2UkVNZ2hoZ0lkbUVhVVV1?=
 =?utf-8?B?N0Q4aVpIQXo5blkyUEM3NExWbzJwUXVDK0YwQUY1NGRGR2E2V2pQQ0x6MHgz?=
 =?utf-8?B?Z1gyWXFySy9BRmJLOENzcE84MXdzaUQ1c3M1Z3B6M0NWc2V3V0ZuaTdBYTd3?=
 =?utf-8?B?ZEU1MlBSS25XWjNsQmFHcG9xbHFtZVZ1eDdWYkV5Ry9sbWlVeWd3WTNPdjgx?=
 =?utf-8?B?eVVBbjNJZ2pCNEViSStmZzJPVGFyL3hpa1UrYXRSMll3V25xYU1wdm9QUHJ0?=
 =?utf-8?B?R3diTnJ4QWRjaUhwNEdJb09BS0c3UGN0K0dBU3BDeVhUU2N4VUdNeGFBQWFi?=
 =?utf-8?B?azFSZlRUT0N4VENqNWhEbUdKcFMyOEVMT1RvMmxyb2dNemVqOVZOK0paRFB4?=
 =?utf-8?B?OGNlY3J4L3MzUUFKTVJHMzhka0hlRnRvMHJlM1pIMDdzOVhWOUZOejFlSncx?=
 =?utf-8?B?NFdYYXpLWHZtZU1kM1AvRnY1MW11L1M0bTNaaHd2Nmk3RWtZOHNqRU5SanNI?=
 =?utf-8?B?eHE2UkZGSXlPUi9acWJmeWlnMmFkUjNqNE1EQmpBUW44K01Ia205S1RsWGdx?=
 =?utf-8?B?aGlLb2swRENKNWVjb1g4czV2SjlaQVhpNXpCN1NaKzJiSDJ3bUJHaFVPbExr?=
 =?utf-8?B?TkRIZGJNcXdudDM5anR2Ykg3M2ZQQUpTeUV6d0xvSjNHdGkzY3IrNXhhaUZF?=
 =?utf-8?B?d2dBZ3U2eDIwdUY4Um5kckFHdEs5NE45VEVkR2xKN2l2YzYyb1RYL041UDRk?=
 =?utf-8?B?UGRRMjhtYzhGa3M0bncrazdicmJ4VDFvbmgybUR0THdzcUR3MHdaUzhIeitV?=
 =?utf-8?B?T0ptYXVSNy9ZUUJmQkE2cnJzdXdnR3BrZkM3SE1PN2FDMzk0Nzg5aWxJdS9W?=
 =?utf-8?B?dTFlRFJBUnhkY2pmaUw4R242a0JhMENjaktxamdzUGN4cmdDYzZnWjdGM1Iz?=
 =?utf-8?B?RWpRbmlPcjc5NzNsSnRmTFU0RG95U2ZvTXRPUHBaMHJnN1d1U0VQNHFXcUxy?=
 =?utf-8?B?RXhuMTk5M3RaMXdQRlV3a0ZEc1MwOFZ4eTVTajlhZy9penpiZGVZaVJQeitl?=
 =?utf-8?B?ZkRFenUzbFNSSDBtZE5vdE9ZcWRHanRWZEtOSk1IZ3pRaXVEcTZ1cUw3SDY5?=
 =?utf-8?B?QTNzVmFhZURrUVFrVUc0aFVzVDhxajFOYzQwOE1sZkFXUjVLcE9rSU53RlZ6?=
 =?utf-8?B?Q2ZRQU83MDdNNU5RTW9ISjBzM1E2NitQY2ZPZkpBeHZUdE4yRDlTS2pjRGJZ?=
 =?utf-8?B?My9UNlJLblZkSjVMc3lZUnJwbTJ3K1h4Ykt1RnZ5MlFwbWtuc09rbHZhNkFK?=
 =?utf-8?B?Z0poZ1dXakxkUEtFS3FWYlU2QjNoTEtyZ013a3ZtUkR5SWcrTk9TbTR4YVk0?=
 =?utf-8?B?N0p4MzFsUlRUd1lvYXQ3UXpKWjlzRjNmTGRrZ1dBOGkxVWREZlJNYTQwd3A0?=
 =?utf-8?B?UnB3eklCMzBybWV3NlJmSGR4bnFaTDRxSVBjNDFKZG9zWEZIcVVsaGV5QkxD?=
 =?utf-8?B?S2FlTjEyK0hZTkZLZUV3cFh4V3dsdnNJYXhhQzBmRVRFR0V5Vk5ndCsrVTlI?=
 =?utf-8?B?Qk10Q0daT3N0eGdtYjB0NnVJemJzT3NRSjEyN1VlUlhsWkM2ZmRZNWlkRVN4?=
 =?utf-8?B?Qk8vUFI4WTRsT1ZvdDkya0wrc24xYzloNW4rK1pwb3c2MHdLVjh5elBpenla?=
 =?utf-8?B?elh6SmJtcWRyNXpBLzdDL2RHVytKY2Jpc1BPcE9vdnVTR2srZllxMjZpZnlK?=
 =?utf-8?Q?5LZObjRxRpDK3H2T4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABE430FA12837040913059871DF54ECE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a7b76a-47af-406c-36b1-08d8e2ccfd13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 07:28:51.8552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beZxTPtuvlYiGjgdbwA6unRo5z/0ws8rx3uKBsJzqd9dWFDKqvQY3/ms7pzna7Wrk4/Hz9W+B7GAJHApdVDvRNJ6HOg1xUN/9OXZvdKIZZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy84LzIxIDc6MjggUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMy82LzIxIDM6MjAgUE0sIFR1ZG9y
IEFtYmFydXMgd3JvdGU6DQo+PiBJdCBtYWtlcyB0aGUgY29yZSBmaWxlIGEgYml0IHNtYWxsZXIg
YW5kIHByb3ZpZGVzIGJldHRlciBzZXBhcmF0aW9uDQo+PiBiZXR3ZWVuIHRoZSBTb2Z0d2FyZSBX
cml0ZSBQcm90ZWN0aW9uIGZlYXR1cmVzIGFuZCB0aGUgY29yZSBsb2dpYy4NCj4+IEFsbCB0aGUg
bmV4dCBnZW5lcmljIHNvZnR3YXJlIHdyaXRlIHByb3RlY3Rpb24gZmVhdHVyZXMgKGUuZy4gSW5k
aXZpZHVhbA0KPj4gQmxvY2sgUHJvdGVjdGlvbikgd2lsbCByZXNpZGUgaW4gc3dwLmMuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZSB8ICAgMiArLQ0K
Pj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jICAgfCA0MDcgKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oICAgfCAgIDQg
Kw0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3dwLmMgICAgfCA0MTkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gDQo+IEhtbW0sIG5hbWUgc3dwLmMgZG9lcyBub3Qgc2Vl
bSBpbnR1aXRpdmUgdG8gbWUuIEhvdyBhYm91dCBleHBhbmRpbmcgaXQgYQ0KPiBiaXQ6DQo+IA0K
PiBzb2Z0LXdyLXByb3RlY3QuYyBvciBzb2Z0d2FyZS13cml0ZS1wcm90ZWN0LmMgPw0KPiANCg0K
SSB0aG91Z2h0IGFib3V0IHRoZSBTV1AgY29uZmlncyB0aGF0IHdlIGhhdmUuDQoNCkhvdyBhYm91
dCBrZWVwaW5nIHN3cC5jIGFuZCByZW5hbWUgY29uZmlncyB0bzoNCnMvTVREX1NQSV9OT1JfU1dQ
X0RJU0FCTEUvTVREX1NQSV9OT1JfRElTQUJMRV9CT09UX1NXUA0Kcy9NVERfU1BJX05PUl9TV1Bf
RElTQUJMRV9PTl9WT0xBVElMRS9NVERfU1BJX0RJU0FCTEVfQk9PVF9TV1BfT05fVk9MQVRJTEUN
CnMvTVREX1NQSV9OT1JfU1dQX0tFRVAvTVREX1NQSV9OT1JfS0VFUF9CT09UX1NXUA0KDQpUaGUg
cmVuYW1lZCBjb25maWdzIHNob3VsZCBiZXR0ZXIgaW5kaWNhdGUgdGhhdCB0aGUgc29mdHdhcmUg
d3JpdGUgcHJvdGVjdGlvbg0KaXMgZGlzYWJsZWQganVzdCBhdCBib290IHRpbWUsIHdoaWxlIHRo
ZSBsb2NraW5nIHN1cHBvcnQgaXMgc3RpbGwgZW5hYmxlZC4NCk90aGVyd2lzZSBvbmUgbWF5IHRo
aW5rIHRoYXQgd2l0aCBhIE1URF9TUElfTk9SX1NXUF9ESVNBQkxFLCBhbGwgdGhlDQpzb2Z0d2Fy
ZSB3cml0ZSBwcm90ZWN0aW9uIGZlYXR1cmVzIGFyZSBzdHJpcHBlZC9ub3QgYXZhaWxhYmxlLg0K
DQpDaGVlcnMsDQp0YQ0K
