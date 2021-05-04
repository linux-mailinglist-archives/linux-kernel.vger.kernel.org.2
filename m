Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46B3724AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 05:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhEDDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 23:13:01 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44982 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhEDDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 23:12:59 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1297340216;
        Tue,  4 May 2021 03:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620097925; bh=NEbSfmimcAqoBHHu12qurdg2dlE/jqZRoecZAJnhwHU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DweXyOi6wDA6yQak4ZRQy9z1FiMqpAgGSJxtXsy7BHxAyzsTAWiO/Szu0YO3JqP6E
         SIEpdrJsItsOVrX8gm4fSCTjQ7YEvyhRnYcsDKMzuvi1eBk+Nai6JtHFhyssH0jR4M
         8rbN3+Z9o7HUxjagZI6rxDnR17RSBSqMgN/vbJMXdvg5GlYvqa3fx6zg2nuS8DtrF+
         VNp87C5x/KEJiJCNWKzE4eRpIBoPE2Szr9V4oWpD126LT7DVzGwpdbthyntkp42vXk
         62VSHCUPFFTeHq88pZUWrGQyZzzIzbESuwu3+5y/ybI5R7MmYdzm3YEomFEkiCvAum
         PLthfdQIAB1Ag==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 647A6A0068;
        Tue,  4 May 2021 03:12:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6D0AD4016B;
        Tue,  4 May 2021 03:12:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TNqsVWf3";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKjZCGliN72XkBENGS5wbRU+Skd3orwBGReAC84RSKQ/rD6laqDg15kZUlgJB8AVgCQT4E0KQUOpq/9rkHhFIGgZaHZva5nvtAPS5vPkWf4AnbNUCkdvSoQqvyP9sFuUUBiXq4nYhO6m+sbXmNyFQwZm6uVG3dm1hiC0t7wCV/5GVmjvTLe+mkEMimuEQW/vXGOs1ET4OWCX/jQ/UGcyO9p6ezjaCbULIUzAoDoZwk8K8HTn/ZaT5orxIM+nHZiQw8Vx4fRCCmulM53CKxunrJThXec+qPIEtlll1uvb4vzshGRTEWqUDLDtkgALeVBBFtP0kY8WyIE2laZnYVCT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEbSfmimcAqoBHHu12qurdg2dlE/jqZRoecZAJnhwHU=;
 b=Jng2nQbubo9EHVTKvWT+1UvOX0OAjfQb7tJsGJnV2rzJNw+VvICiuHvXCQBBdptNHTZnVmm4Q1i4ieFcFxPYcz1K/rQjN6b1Nc9JjzmHwJ0qt07qUOtCyePhrT+y6H5F6XFvJzgkXviup6sbYn/uclXBHIOviYvsO0HL9Wa7aeLZnzTrukgmzO/hYwXARSeQV8fKa9+HUEzW61UTnmpwGKYRf64g4f6mbn9LtCojxtTzqBJqbXsdYm/azqqxyvRbvJR2nrairxb2YNsF3MneVYCVDYrZGezqQ3H4VzNQWMVaseCTQqZeNZqeNDs2ieQ4ux21U3rYwZppdTjVFPQbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEbSfmimcAqoBHHu12qurdg2dlE/jqZRoecZAJnhwHU=;
 b=TNqsVWf3aox71KUlOy6ToLqbga2aHW2YyhLCvfDuY7OH9omLQqCA0Ex4IGVaTy5J0OeQfujMYpvUPXK9Esh20og2VCE1RLsvubMS7cyWG0Xbt7nHR0Fv3iV4Ghlw//2ayrhDC2sqgcXH/C7LjSl54Ts2aSwqhPim4SzxtIBSgvw=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by BN6PR12MB1729.namprd12.prod.outlook.com (2603:10b6:404:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Tue, 4 May
 2021 03:12:01 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::9d35:da6d:452c:98f9]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::9d35:da6d:452c:98f9%7]) with mapi id 15.20.4087.038; Tue, 4 May 2021
 03:12:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0AgAAHAwCAAAdWgA==
Date:   Tue, 4 May 2021 03:12:00 +0000
Message-ID: <e12fc396-76e6-9506-31c8-cfdee3fb7577@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
In-Reply-To: <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83389182-d370-45dd-554c-08d90eaa628c
x-ms-traffictypediagnostic: BN6PR12MB1729:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB17295E327066630562077DAEAA5A9@BN6PR12MB1729.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WaPjy7WjaL90guDubnDoetvtaGTdAvrl6oVSrUA+9GQAlDhEX763w+3rsT7tZMIb/NU6d5yI81OcmVCsX9ANlat5TJKPUFrKgQO+m8D4TlFa+MykMEDXmxRxcxCvNYUhBvX6EMlSsZ9JyKwgcLVz/CwsIeA/2JTR52T5ZFw2almbQXHWkQ/uh+X+KaGILeSbDRXDrwaWGhFYZbKDMO8++an25PA5MBRIWAqfrSICo7L25B2IsAG146EWneOchkS7Sq/Mb2bT0SVPsUB9iTC+sJzRYkHLGvlXEViRvubBItFyneTFEki4m/9xSJcgDwTWPyox5AE8TAsPJDhtHoZwFQrrVFa7vZDw661/Rfozz5azyL/pkSknHa4EaCtRUKKjU03TrYp/4L4uWZUk3Ca2dh7mwSf2VZyTjHTDdEQIntEC4uoUzjjFkO3xS/2SpVUc0p3dgnaKgVWYwpaSiScOUnNxTfwAyjcxhLUZaHL2iYOjS8joHfX1IHSXL2OyqundGNYoUl0CvVkrj3/E+3PcEMzcayBxh4TOyaExKfIuA40SWDY5Yxac7zezIb/+npZRW0nr5NpL8MnRJIA8SHzvB5cTY8oKtWY4O52Aax0jvt0/tTbhvQLosXamycRiEiVvR7mGqKQno25iSiATZJSmJ5yeZRkl53UEHhJUy2bt62dGbLKw/BrU0A03PTNBkcv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(66476007)(64756008)(66946007)(6486002)(5660300002)(66446008)(66556008)(76116006)(316002)(8936002)(110136005)(2616005)(8676002)(6506007)(36756003)(54906003)(53546011)(2906002)(38100700002)(83380400001)(31696002)(6512007)(478600001)(122000001)(26005)(71200400001)(31686004)(4326008)(186003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NEtNWWZSdldHMGd5Qk9PY09OSzA0Q3lRZ1gyYkNUakU3ZEJjK056YVhseU9t?=
 =?utf-8?B?b1VQZDNhNWRpR3UwOWRBSDhITXBJTzZXZFlSaGgvM0NFeFREeDVOVUl6ZDlL?=
 =?utf-8?B?eW5BQll4bWpDSkUzY0FpTHU1c2E4U1NaYlRVQ2xIWnhsVWpwZGFNU0tpUlVF?=
 =?utf-8?B?N0lZRUJlQzBBcHNCOVZoSFJvemRkTFZJTDQzbHQ5bCtoSmZBcUx1YVY4bzlD?=
 =?utf-8?B?Um92R0ZjcGorUlJuRnNlTFBYTy90dktZbHpTeXJIK2FvOTlsMjlDOXJxc1hV?=
 =?utf-8?B?Sm5hSStzVXRKSXppenJZVDZZVEN0MjFsWVVSMURxeG1MeDJtUkorK1ZoM05R?=
 =?utf-8?B?UXVFa3VvbVUwL2s5WDlMZUpJUldVRmZhekRtUmFJb2VmaWVucE9DMzV1UGd4?=
 =?utf-8?B?YjhZWUMvZlp1NmR3MXl4Ti9GTmZGemsxUFBVbHI1SDQ0K1NNSU01MEtzSUlU?=
 =?utf-8?B?VTlrUXc0ek1yKzJkZTlWMmptdXNXTTAvZEZrVEhwYy9YMHc2eXdxTzlBWEhI?=
 =?utf-8?B?Wk01cXFVVk0vU1EyMDQ1VVVoZDc2SGF4ZmVwejd5LzdSOU5rUlRYekdzVjRP?=
 =?utf-8?B?MUQ3b0UzeTFJeW5SbHhldHN6RHFmdVRPQjJPYzBxYUEvR3Zydk1uNllPUFFl?=
 =?utf-8?B?MFQ4LzBQNmJRYVRaa3llS2VOTHBLckhHTVJaWmU0YTFuRlhaNk1haFRQZGV2?=
 =?utf-8?B?MGVlZHlENkZaZG96WnpoQi96bjUvNlVJeW9ORllVNzFNMXpRNjFTQ2c4R29H?=
 =?utf-8?B?TDBLbzhhbTdaR2d3VWxHS0ZQbkZKN2RRdHhHYkhRaWRqZHBLQS9CWkpwSEJl?=
 =?utf-8?B?TWR0OGxldUZEOElmeWdHMnFYQnZPV1lFQVMwM2RtODRicEVaaE1iN2VabzFJ?=
 =?utf-8?B?NklSNHFwRitFSDE2RUVBc250Y3pPMTlBN1dEUVNxZjY3Zk5Idmw5aUhzdGlX?=
 =?utf-8?B?R0JqTWNDV2U0eWZXZEMxWHJodjRwZWJsVW1FL20veHRFY0Y4bDRNZ0pBTHdT?=
 =?utf-8?B?bVN3WGtlODIwNk1OSWtiZWNUWjE4eHA2RSs5UllmMERvcUVrRVlwbFo0WFJn?=
 =?utf-8?B?SUdLUHlvVzlvcHFSNFhCQ0ovZ3crVWh3WHJ5eHZQb3V6ZmJVUERzd2tNMlEr?=
 =?utf-8?B?S2lneFFLUjBIdFZWR0ZNVVlmZFl2c0hLSHFDYmY0YzJsVytCVjFBbUJwSDBJ?=
 =?utf-8?B?MzJkZEVsc3BQcHVxNHpUOWxOdldmQXlZYnVWOTA1eDBzSWx4TzIxN1lXZFBY?=
 =?utf-8?B?bmw5am82WCs0ZjFjY3ZERHYyOS84Y0NiZEFXaUtBbnNJbDA5azZndytrS2VH?=
 =?utf-8?B?TmlWUmQvZEFyVWF0WElPNG5mYXJRR0dmUEF3MEVIeXpxdEYyeFJucFIrRHR1?=
 =?utf-8?B?Q0F2TFBPclJkYTBUZTdDUGdjL2R5RnhtMUx0bjN5ZEx6YitNY3c2MWRFcmR0?=
 =?utf-8?B?RU9lMnV2bWkraCtzbzFsTkJZRmhObWtQOS94elEyM3piTFMybDQwVGp2VW5I?=
 =?utf-8?B?d3dMWXZDMzNvWkZaeExyRU81ZGRhbDJnMURQMmJLcEt6ZWpEUkVTd1FkM0Za?=
 =?utf-8?B?RXNxSmo1Rm8rUk5IS09oQ1BzZEJhaSttenkxcGszamszNFdheHhMQVlJN3Iz?=
 =?utf-8?B?eHhySFIxejNLeGRHUXgzVmtsVGM3emE4dU85clVySVlOSlpzbjlXN2tyMXN3?=
 =?utf-8?B?clNUSU5LaDFyMlR6YjE5T2tyRDhMa0tlSW43RHdSdllnZGoreC9seWRVYXl5?=
 =?utf-8?Q?jWjTfTPJx0ca94UxVYqScsRX5PTK+NF463WXdX/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D552E8F7F6B694B900A79C9431DD4E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83389182-d370-45dd-554c-08d90eaa628c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 03:12:00.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guLoiIrbIZQSq5kUTCZtT/mu1kWTquH/63l9uBZzV+kLZkiqVKzUjJOmqIZOEM+OMj9y8YhZLeA0cyzBG+4XzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1729
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IA0KPiANCj4gT24gNS8zLzIwMjEg
NzoyMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gV2VzbGV5IENoZW5n
IHdyb3RlOg0KPj4+IElmIGFuIGVycm9yIGlzIHJlY2VpdmVkIHdoZW4gaXNzdWluZyBhIHN0YXJ0
IG9yIHVwZGF0ZSB0cmFuc2Zlcg0KPj4+IGNvbW1hbmQsIHRoZSBlcnJvciBoYW5kbGVyIHdpbGwg
c3RvcCBhbGwgYWN0aXZlIHJlcXVlc3RzIChpbmNsdWRpbmcNCj4+PiB0aGUgY3VycmVudCBVU0Ig
cmVxdWVzdCksIGFuZCBjYWxsIGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCkgdG8gbm90aWZ5DQo+Pj4g
ZnVuY3Rpb24gZHJpdmVycyBvZiB0aGUgcmVxdWVzdHMgd2hpY2ggaGF2ZSBiZWVuIHN0b3BwZWQu
ICBBdm9pZA0KPj4+IGhhdmluZyB0byBjYW5jZWwgdGhlIGN1cnJlbnQgcmVxdWVzdCB3aGljaCBp
cyB0cnlpbmcgdG8gYmUgcXVldWVkLCBhcw0KPj4+IHRoZSBmdW5jdGlvbiBkcml2ZXIgd2lsbCBo
YW5kbGUgdGhlIEVQIHF1ZXVlIGVycm9yIGFjY29yZGluZ2x5Lg0KPj4+IFNpbXBseSB1bm1hcCB0
aGUgcmVxdWVzdCBhcyBpdCB3YXMgZG9uZSBiZWZvcmUsIGFuZCBhbGxvdyBwcmV2aW91c2x5DQo+
Pj4gc3RhcnRlZCB0cmFuc2ZlcnMgdG8gYmUgY2xlYW5lZCB1cC4NCj4+Pg0KPiANCj4gSGkgVGhp
bmgsDQo+IA0KPj4NCj4+IEl0IGxvb2tzIGxpa2UgeW91J3JlIHN0aWxsIGxldHRpbmcgZHdjMyBz
dG9wcGluZyBhbmQgY2FuY2VsbGluZyBhbGwgdGhlDQo+PiBhY3RpdmUgcmVxdWVzdHMgaW5zdGVh
ZCBsZXR0aW5nIHRoZSBmdW5jdGlvbiBkcml2ZXIgZG9pbmcgdGhlIGRlcXVldWUuDQo+Pg0KPiAN
Cj4gWWVhaCwgbWFpbiBpc3N1ZSBpc24ndCBkdWUgdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBkb2lu
ZyBkZXF1ZXVlLCBidXQNCj4gaGF2aW5nIGNsZWFudXAgKGllIFVTQiByZXF1ZXN0IGZyZWUpIGlm
IHRoZXJlIGlzIGFuIGVycm9yIGR1cmluZw0KPiB1c2JfZXBfcXVldWUoKS4NCj4gDQo+IFRoZSBm
dW5jdGlvbiBkcml2ZXIgaW4gcXVlc3Rpb24gYXQgdGhlIG1vbWVudCBpcyB0aGUgZl9mcyBkcml2
ZXIgaW4gQUlPDQo+IG1vZGUuICBXaGVuIGFzeW5jIElPIGlzIGVuYWJsZWQgaW4gdGhlIEZGUyBk
cml2ZXIsIGV2ZXJ5IHRpbWUgaXQgcXVldWVzDQo+IGEgcGFja2V0LCBpdCB3aWxsIGFsbG9jYXRl
IGEgaW9fZGF0YSBzdHJ1Y3QgYmVmb3JlaGFuZC4gIElmIHRoZQ0KPiB1c2JfZXBfcXVldWUoKSBm
YWlscyBpdCB3aWxsIGZyZWUgdGhpcyBpb19kYXRhIG1lbW9yeS4gIFByb2JsZW0gaXMgdGhhdCwN
Cj4gc2luY2UgdGhlIERXQzMgZ2FkZ2V0IGNhbGxzIHRoZSBjb21wbGV0aW9uIHdpdGggLUVDT05O
UkVTRVQsIHRoZSBGRlMNCj4gZHJpdmVyIHdpbGwgYWxzbyBzY2hlZHVsZSBhIHdvcmsgaXRlbSAo
d2l0aGluIGlvX2RhdGEgc3RydWN0KSB0byBoYW5kbGUNCj4gdGhlIGNvbXBsZXRpb24uICBTbyB5
b3UgZW5kIHVwIHdpdGggYSBmbG93IGxpa2UgYmVsb3cNCj4gDQo+IGFsbG9jYXRlIGlvX2RhdGEg
KGZmcykNCj4gIC0tPiB1c2JfZXBfcXVldWUoKQ0KPiAgICAtLT4gX19kd2MzX2dhZGdldF9raWNr
X3RyYW5zZmVyKCkNCj4gICAgLS0+IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKEVJTlZBTCkNCj4g
ICAgLS0+IGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKCkNCj4gICAg
LS0+IGR3YzNfZ2FkZ2V0X2dpdmViYWNrKEVDT05OUkVTRVQpDQo+IGZmcyBjb21wbGV0aW9uIGNh
bGxiYWNrDQo+IHF1ZXVlIHdvcmsgaXRlbSB3aXRoaW4gaW9fZGF0YQ0KPiAgLS0+IHVzYl9lcF9x
dWV1ZSByZXR1cm5zIEVJTlZBTA0KPiBmZnMgZnJlZXMgaW9fZGF0YQ0KPiAuLi4NCj4gDQo+IHdv
cmsgc2NoZWR1bGVkDQo+ICAtLT4gTlVMTCBwb2ludGVyL21lbW9yeSBmYXVsdCBhcyBpb19kYXRh
IGlzIGZyZWVkDQoNCnNvdW5kcyBsaWtlIGEgcmFjZSBpc3N1ZS4NCg0KPiANCj4+IEJUVywgd2hh
dCBraW5kcyBvZiBjb21tYW5kIGFuZCBlcnJvciBkbyB5b3Ugc2VlIGluIHlvdXIgc2V0dXAgYW5k
IGZvcg0KPj4gd2hhdCB0eXBlIGVuZHBvaW50PyBJJ20gdGhpbmtpbmcgb2YgbGV0dGluZyB0aGUg
ZnVuY3Rpb24gZHJpdmVyIHRvDQo+PiBkZXF1ZXVlIHRoZSByZXF1ZXN0cyBpbnN0ZWFkIG9mIGxl
dHRpbmcgZHdjMyBhdXRvbWF0aWNhbGx5DQo+PiBlbmRpbmcvY2FuY2VsbGluZyB0aGUgcXVldWVk
IHJlcXVlc3RzLiBIb3dldmVyLCBpdCdzIGEgYml0IHRyaWNreSB0byBkbw0KPj4gdGhhdCBpZiB0
aGUgZXJyb3IgaXMgLUVUSU1FRE9VVCBzaW5jZSB3ZSdyZSBub3Qgc3VyZSBpZiB0aGUgY29udHJv
bGxlcg0KPj4gaGFkIGFscmVhZHkgY2FjaGVkIHRoZSBUUkJzLg0KPj4NCj4gDQo+IEhhcHBlbnMg
b24gYnVsayBFUHMgc28gZmFyLCBidXQgSSB0aGluayBpdCB3b3VsZG4ndCBtYXR0ZXIgYXMgbG9u
ZyBhcw0KPiBpdHMgb3ZlciB0aGUgRkZTIGludGVyZmFjZS4gKGFuZCB1c2luZyBhc3luYyBJTyB0
cmFuc2ZlcnMpDQoNCkRvIHlvdSBrbm93IHdoaWNoIGNvbW1hbmQgYW5kIGVycm9yIGNvZGU/IEl0
J3Mgc3RyYW5nZSBpZg0KVVBEQVRFX1RSQU5TRkVSIGNvbW1hbmQgZmFpbGVkLg0KDQo+IA0KPj4g
VGhpcyBzZWVtcyB0byBhZGQgbW9yZSBjb21wbGV4aXR5IGFuZCBJIGRvbid0IGhhdmUgYSBnb29k
IHNvbHV0aW9uIHRvDQo+PiBpdC4gU2luY2UgeW91J3JlIGFscmVhZHkgY2FuY2VsbGluZyBhbGwg
dGhlIGFjdGl2ZSByZXF1ZXN0IGFueXdheSwgd2hhdA0KPj4gZG8geW91IHRoaW5rIG9mIGFsd2F5
cyBsZXR0aW5nIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgdG8gZ28gdGhyb3VnaCB3aXRoDQo+PiBz
dWNjZXNzLCBidXQgcmVwb3J0IGZhaWx1cmUgdGhyb3VnaCByZXF1ZXN0IGNvbXBsZXRpb24/DQo+
Pg0KPiANCj4gV2UgZG8gaGF2ZSBzb21ldGhpbmcgc2ltaWxhciBhcyB3ZWxsIGRvd25zdHJlYW0g
KHJldHVybmluZyBzdWNjZXNzDQo+IGFsd2F5cyBvbiBkd2MzX2dhZGdldF9lcF9xdWV1ZSgpKSBh
bmQgaXRzIGJlZW4gd29ya2luZyBmb3IgdXMgYWxzby4NCj4gUHJvYmxlbSBpcyB3ZSBkb24ndCB0
ZXN0IHRoZSBJU09DIHBhdGggbXVjaCwgc28gdGhpcyBpcyB0aGUgb25seSB0eXBlIG9mDQo+IEVQ
IHRoYXQgbWlnaHQgY29tZSBpbnRvIHF1ZXN0aW9uLi4uDQo+IA0KDQpJdCBzaG91bGQgYmUgc2lt
aWxpYXIgd2l0aCBpc29jLiBJIGNhbid0IHRoaW5rIG9mIGEgcG90ZW50aWFsIGlzc3VlIHlldC4N
Cg0KPiBDb21pbmcgdXAgd2l0aCBhIHdheSB0byBhZGRyZXNzIHRoZSBjb25jZXJucyB5b3UgYnJv
dWdodCB1cCB3YXMgYSBiaXQNCj4gZGlmZmljdWx0IGFzIHRoZXJlIHdlcmUgc2NlbmFyaW9zIHdl
IG5lZWRlZCB0byBjb25zaWRlci4gIG5leHRfcmVxdWVzdCgpDQo+IGRvZXNuJ3QgYWx3YXlzIGhh
dmUgdG8gYmUgdGhlIHJlcXVlc3QgYmVpbmcgcXVldWVkIChldmVuIGlmIGVwIHF1ZXVlDQo+IHRy
aWdnZXJlZCBpdCkuICBUaGVyZSB3YXMgbm8gZWFzeSB3YXkgdG8gZGV0ZXJtaW5lIGlmIGtpY2sg
dHJhbnNmZXIgd2FzDQo+IGR1ZSB0byBlcCBxdWV1ZSwgYnV0IGV2ZW4gaWYgdGhlcmUgd2FzLCB3
ZSdkIG5lZWQgdG8gcmVtZW1iZXIgdGhlDQo+IHByZXZpb3VzIHBvaW50IGFzIHdlbGwuDQo+IA0K
DQpZZWFoLCB0aGVyZSBhcmUgYSBmZXcgcGl0ZmFsbHMuIEkgZG9uJ3QgaGF2ZSBhIGdvb2Qgc29s
dXRpb24gdG8gaXQgaWYgd2UNCndhbnQgdG8gcmV0dXJuIGZhaWx1cmUgaW1tZWRpYXRlbHkgYW5k
IGxldCB0aGUgZnVuY3Rpb24gZHJpdmVyIGhhbmRsZQ0KdGhlIGRlcXVldWUgKGlmIGl0IHdhbnRz
IHRvKS4NCg0KVGhhbmtzLA0KVGhpbmgNCg0K
