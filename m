Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6E391B50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhEZPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:13:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49236 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235350AbhEZPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:12:57 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E08B4013E;
        Wed, 26 May 2021 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622041886; bh=NdaSGMt4qbosYuIj87NCfg+0OmXDYyO2bOAcdjhX9OM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FJv7l8afA9Z9qqIpL9FgAy54MYg18td8bdrMGQ+CBzoyqqYeHMAGcBgZvh9lRJNXF
         ZwK2F5i7XP3swOhMsKI/lgtJw4vZKQaYPzY3jvaN8KUk//nnnZ5UniWWuF6nD7Hze8
         L6feUbSQ7lDYWf6Pg39Kbg68DnUWVt6X/dbH//WzOU0rdZhGYP+LFUup3BpyDvpzN0
         pvjXQQUxjZQhlEeveA/gfOOyP7OzwbqzgUlJHspY8plgX1ajcB2uAA4aZxmu5DcYXJ
         /HE1VKMWOjLSTTjy6+JUpGHn5sngKVMkq/DTQ7aCVcfnsF1Vrhsb7vS/z9LlWGQz5b
         VKJd6UKcSiUJA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D4A2CA0062;
        Wed, 26 May 2021 15:11:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A1D3E8126D;
        Wed, 26 May 2021 15:11:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FJ6ZTZkc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlnG3BSS3P+DJXP0P42JSjIotT0TEjalFFm7Uuc92iG6krY1dr75kBzYkTKO1z20/FomnWVJHzhawoz0izVQtmKA4WZ15IZ6XUHDNqJYmV6KHFDQiaT0Zj+69yKomlU0oSa7SMgU/2MBkQ0dTntGfDCPh9OdItU3cXS3JFZWqOfpoJJbnzukbdSgNuj2ywL1FNohW3+lx+MsX926yPfn8rJEsGttzfS2eVZGG733Q2wfZyLJmVlheGiEp1hq9KueeLPX19x6j7uge2UlVtroymdENDvSc7oAtH91gKs6KFVyy5CPcA0BdqupzaEeokwSqcJj2Ee71fMo3/gbqNy1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdaSGMt4qbosYuIj87NCfg+0OmXDYyO2bOAcdjhX9OM=;
 b=D/nFLFJHyt8EbfG1bOxpJZU6NDx7gaplBUKCa+vNrwgW/YImWyyzxEOgf88dcn24LrykR8H5ZYfpbtHT19dwESthwpqmc0slE6eepjV+/RHa68sX0fZflgTVXzCbL87VDbCW9eEGcIf12dLaIufPEKDlQQmDRjjoeAJ1ibdCXxAKHG7sCXFfBwwVZCgG0na0vtVEaKILFLZdBEjs4pM4Yf1fFcQbZwzs5+uBRNpDoc412s7OyUdvN1G6ZqIrsxiO0QTTj1WJXwH5ZMcy5bYyFN7SWE2jQL0laFWoBFcuP3gbwz+1BBRuOk+nEG3UY4zq4hXaoA3l3pCd+0dQF8JJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdaSGMt4qbosYuIj87NCfg+0OmXDYyO2bOAcdjhX9OM=;
 b=FJ6ZTZkcRXND6ijldbNJIDgM0v5x4aN5E0/3LJNOoEuPyoaRlZKnvQBjVb4l2CFQR5ZCg6fmH2xhyU3jvrq3HfCi+Hq1akw85/oR9ccs1iMKPg0m+P90u29xUhiFpFPkfTC2GmI/uaanQPVaNhuHoTAhX3MTI+iRS6ngSSD5jNw=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 15:11:24 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458%6]) with mapi id 15.20.4129.036; Wed, 26 May 2021
 15:11:24 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 12/24] usb: dwc2: pci: Fix possible copy/paste issue
Thread-Topic: [PATCH 12/24] usb: dwc2: pci: Fix possible copy/paste issue
Thread-Index: AQHXUi8vk7XQiK0OskORp/1/OkCkwqr13moA
Date:   Wed, 26 May 2021 15:11:24 +0000
Message-ID: <3bbba91e-4b10-ccb1-3b35-c62e3c157e8f@synopsys.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-13-lee.jones@linaro.org>
In-Reply-To: <20210526130037.856068-13-lee.jones@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.93.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4e090ff-774e-4b92-bb93-08d920588747
x-ms-traffictypediagnostic: DM4PR12MB5215:
x-microsoft-antispam-prvs: <DM4PR12MB521580524E1C826F4E748692A7249@DM4PR12MB5215.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GV5eVvHMs2bd51LEbaoSHmM9lHiANFNRNcgmaR7gDx3Rs4qstwWbOkv726fS/N2cVVAWRkYJZD07xDBLKqI5a+3mb0s1gxcBYJd+1+AqwzakTZGZ+bpXEL+OyXWzK2VPMSx2bQEgNNfP6+6cV03JN06eMwZqKBClKdLXjsRJ7tiBUyrAuueprJ5UAc6EjoBIe9muK1diiWIwWWzE1Dfq0FO2F6bigWswUJWD5VNiGClCoSp2vnL9zVUCS0StddJAPFesVrH9eY3tZv3OAmPAnS+2djbA4+m5JPg0sF9JkwO4dykYKcC8AQBUEo1rATj4o5BKf5UjHyog2czxTP14m1SSCOqurd3VuIKoIvuQ1TTcgUba19LQIyENoiHM5asPdpHfxe61BElp3ceAEObBxI4RrFAOevW+vgdnzfIEnvLtZs0SZ8euOuBJnPDluagI/2uMG7PZ9YOZ/p/sz+t4u9HHvLN3XshvqjGDQFDL/LtlkxdJlfMl/Aeg5J6yCf/wlqjfaDu2y8V8A6OeIDsC8pgOxxCidNulA319ER9ra0xqGa8roeqR70ZyoEw2nf1alLvi+/khgCA5gWpD+aPe9Wll+OqoMACKw/oJv9lbFYGBUYJSv9KHqFNiry765dGXC3nYBqYVGoLhtl4qPzJWB9uwHbQflB97okB2PX6OIxukjstlZuLsf0etpUbIgBbi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(6512007)(26005)(36756003)(66556008)(2616005)(64756008)(6486002)(66946007)(53546011)(6506007)(122000001)(66476007)(8936002)(6916009)(86362001)(66446008)(91956017)(83380400001)(4744005)(76116006)(38100700002)(54906003)(31686004)(4326008)(5660300002)(71200400001)(2906002)(478600001)(31696002)(186003)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejNtRGRHTng2Wkxic2cvdndoajE0aUVMUTBUdVRRQ2tjdWdCVE5DWHVPclJq?=
 =?utf-8?B?eCtSYVlxQlJoUkpiWk80Z1NqN2xPYjNod1dCRWU0UGl6cC8vVFJYRll6T05F?=
 =?utf-8?B?MkllL25ZeWFQRVNKVEYwYy9vMTk2VVBLZWg0OTJaOEV2aGpRZWRvZXJQRG5T?=
 =?utf-8?B?SnlBc0xsanRoUzZQck5MZDluN0gwa0JMZUgxKzJrMHY0Q1hENmEwZTdVaG93?=
 =?utf-8?B?VDJTbFhPMFlFeTMzbWtzN2tuZTJobmlQakNmWjAxQThINzV3Y2tRNFdGRm8r?=
 =?utf-8?B?Q2JkWkhqRVlQc3pteHlYM2Y1OW9NQ1lFNnc5Q1d6eEVJcmozMGZ4K0t0OGx5?=
 =?utf-8?B?b3BsWFgvNVVWclBKWVZsaURWampMUk1HMy80OWxsREtOTDI0MDl3cEE3Q3dZ?=
 =?utf-8?B?LzJpSndpMHJrYkJnSGpBNU1UZFo5Y3lTcEFVNVU2YmtiaDJmRU8ybjFNOUQ3?=
 =?utf-8?B?TUZZWTQ1TFV3cis5NnhLQ0NlRXAyS3JFbmc4QzYxUVA3THJuUVhxUUZoVVFE?=
 =?utf-8?B?MEIxVWcyNGZuMjJiemVSQU84a3RLOGZqNG9RYlBiMWpoV1pLZk5GdVczd2ln?=
 =?utf-8?B?SHBPUG80WEx2QXBxbXV6TEVONnVsVG5oS2F3ckN0QXRGbUswdEZ1dU5wV1kr?=
 =?utf-8?B?UVE4YW9LSHFwY05HSDV3Q0c5eXRQdjN2c1ljbHJ4cDNYTHg5eE9CS1BaSTFV?=
 =?utf-8?B?V00yRDkzbTQzNVZLWUt5aGtKVTNvYjdxc0lBVTB5SnZlNk40L3hqQkNGcnhy?=
 =?utf-8?B?SUNqVDNrMnZrZFd0Snl2UWtFVHhMdGFsUW9ZVUJIRTdKWUhralA4bzkyVEJo?=
 =?utf-8?B?Q1l2akVzMlZmK2FuTXBZU1FmZTlDMi9MNnpYb1Zjd0NPUEVFeksvVzBxejlw?=
 =?utf-8?B?d09LdzBqSFhIeGFxWnZMNnM4aXRkUGZ5cncvcWRKSUhzWmVNb0ViTU94Mm9k?=
 =?utf-8?B?R0hXSldlUllzNVI4YzBVRlRFUHg2eE4zTlFTK1hyRVZXTGRucjJQTFJnbVZS?=
 =?utf-8?B?dUhFU2JrSERlUmxnOTU2SUt4S1l3TVI1QWtTQjN6Sng2YUVTZXlnd0dyTmhv?=
 =?utf-8?B?TVFJemxBQ3RpL1NZQkUyb0k2MzFLemtKUDRWcnBLVlFtWHdNZDJyMTJNU2Jm?=
 =?utf-8?B?SWxkcjJpQ0MvRmcrZEdOZnFwVktlRWNBdHRoYnB5Ymw4WEtKcE50QTV4V1dm?=
 =?utf-8?B?eklHNW5QTktaSGVxSDl2cjh6NmRNdnJObjNNNDI1QjdmbXBSNDkwZjRqOHB0?=
 =?utf-8?B?bzFNdGNXY05UT1hidGgwRytxYzE0QXFQUHRaaExudEhWcVQvcDJUR1kvM2Zr?=
 =?utf-8?B?ZE84aE1XRndjWHYxMVprQ2VYUXpjMFdyN3hLUStwZkJYdVNXTWI2ZlpVekRq?=
 =?utf-8?B?MkFFOXFsU1BHcnRRdy9nTXEvUzdzK3QrcDRpL3V6bHFLTUhoK2tuSWlEY2Zq?=
 =?utf-8?B?T3QvTjZoSVRNY1lzYXJPb1l1YnpEMzd4Ykp4Y0dsM0M5U3U5a0s4dVE1bXBP?=
 =?utf-8?B?d0I0c2tHbnJvU1hpNTNqeDluU2cwb2p4a1UvblBpekg0VlVvUDMrYlJoVjk4?=
 =?utf-8?B?S3kxdXhOYW1TLzhoWUNGYlQyOHFKUzRXVFA4QWVZVDJkNmtia3FGN1hpeWR6?=
 =?utf-8?B?OVRVbktMLytpdXJFMS95Z0EvN2dtN1k0OHFEL2tVK0RyZHJzbXlBV04zZDF1?=
 =?utf-8?B?bDR5dGJ4T0Eyb2kyZTdUVXF4K0hwcndzYWFoTlJNWU12ay83bWxrMDRVZ0kz?=
 =?utf-8?Q?d7HNsXZlbilovLZXMCk26q8184R0BVFz8jpyKaw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <70C481571653F54DB2074F8AA8B1B86C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e090ff-774e-4b92-bb93-08d920588747
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:11:24.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+5LGBNBaCicuPeL87gDMZqBOZozgIuZIQlt1LAFRDC/iVczhvfmP8eaMguEXxS7E6sge1SodXG8xI8P4/TWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yNi8yMDIxIDU6MDAgUE0sIExlZSBKb25lcyB3cm90ZToNCj4gRml4ZXMgdGhlIGZvbGxv
d2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6DQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3
YzIvcGNpLmM6NzM6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGR3YzJfcGNpX3By
b2JlKCkuIFByb3RvdHlwZSB3YXMgZm9yIGR3YzJfcGNpX3JlbW92ZSgpIGluc3RlYWQNCj4gDQo+
IENjOiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBsaW51eC11
c2JAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+DQoNCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1
dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL3Bj
aS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvcGNpLmMgYi9kcml2ZXJz
L3VzYi9kd2MyL3BjaS5jDQo+IGluZGV4IDAwMDAxNTFlM2NhOTYuLmE5MzU1OWI0ZWNkYmMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGNpLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMi9wY2kuYw0KPiBAQCAtNjQsNyArNjQsNyBAQCBzdHJ1Y3QgZHdjMl9wY2lfZ2x1ZSB7DQo+
ICAgfTsNCj4gICANCj4gICAvKioNCj4gLSAqIGR3YzJfcGNpX3Byb2JlKCkgLSBQcm92aWRlcyB0
aGUgY2xlYW51cCBlbnRyeSBwb2ludHMgZm9yIHRoZSBEV0Nfb3RnIFBDSQ0KPiArICogZHdjMl9w
Y2lfcmVtb3ZlKCkgLSBQcm92aWRlcyB0aGUgY2xlYW51cCBlbnRyeSBwb2ludHMgZm9yIHRoZSBE
V0Nfb3RnIFBDSQ0KPiAgICAqIGRyaXZlcg0KPiAgICAqDQo+ICAgICogQHBjaTogVGhlIHByb2dy
YW1taW5nIHZpZXcgb2YgRFdDX290ZyBQQ0kNCj4gDQoNCg==
