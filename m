Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AE37256A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 07:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhEDFXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 01:23:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50858 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhEDFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 01:23:03 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2A896C00AA;
        Tue,  4 May 2021 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620105729; bh=WpyFypcC7JK5+hMaYpiB2KHI21Ra0Fko3SRjdMIU448=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JyJYDncee5+LWM5jkIEBKBcxQhYjyOrT0NY4RoPKuuGTyzdRLuVm+PlD4A6NgmqiC
         1tjdvzJWElWj+du7u7FojKWO0FWIpnM8t37fTFAbwUlR8p3rK0EJhJ5jLOsbIVxWdH
         zFXc27LrS2N6LB2/nTCf3r1oBrgFMxfhMRQk3g4QjKNvBM332srSyf6UGPz3XnhM/k
         u6p86DMuHEj1AJBaGs6bRrtnTb/l/f3Z7l3DL1PM9qAFlrk3ejfibpKvmiXUxcLx7r
         MJdpkU2xFByYl7cVTPtbxRGCjuOHm0VNGdPAivF9TIQodAjgN8lAzn8kZfrm9Gcdqj
         Ji4OlSWSzSLIA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B7CF8A005E;
        Tue,  4 May 2021 05:22:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3CB1140190;
        Tue,  4 May 2021 05:22:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="PWH3AYeP";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp1+x9AuklVbQJUgugX2Ga5Q2deVtp6F7yaTS46ruyIPppoE9cS2dfjYZ2otnfvFKJ/1oBx0gOsyq/8vbR1BXFX6U81Ylv0wsYymdduTcsRh6KeLeKVO6xfwEc+aRwUTs0yLQ2CuYLG0H4YsjOf7VFYERazM4poVbgHJheFO2yLKsdJwPq0RP4WMKDhe3knpOCc4X6C5Aopb9ZhKoUvV5bwQKxmSs5YJJaO3r801nGbEkybDx+/yatHDQW9b5YA5oNob8Yvqm+C66zEY30KE9dKw9rmFFxZnuU0IjhqUO68g6X5V0btU4qzI9LoeQrAeHi0pVV7ZBJNwkEL/B/YtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpyFypcC7JK5+hMaYpiB2KHI21Ra0Fko3SRjdMIU448=;
 b=GAEI57RQlMXYOAykODlYBBhR2B47yIv0RcyEPIGiWxRha5TO+oJBMKEZv/uh+p5xbwaaRx5JntVHAWzG6xGl55DrG7nSFf1op0YeDE5EjPYZjWJSFw1Is7eskViVpOhIAf9sgpxqVdacQuG4i92QNK+oNap0uyUw7kOYF/Sb0M9ihjgLvOY+d32rJqCVHdqtPR41VWS02qZqDLUYShKPi7Lia5NaLv0PflCNA1poM+kc5T+NOl0PRspN74KM/OsEmAazksHr4PKHdOTphYGULX4reV50v1toJshyFLsBNTrgByXgj+X/I8s40++6LLF9UgGw9OjwakfepIH31mxWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpyFypcC7JK5+hMaYpiB2KHI21Ra0Fko3SRjdMIU448=;
 b=PWH3AYeP52SdZWpmFHNQOcKJXCmFULyaHKq82KI1R4MIueHHa1dD/puAenZUVbh3MJx4FZRsdu82wsBxUDF+WgYZ0TttuOqf53z5S9vvpMmzM2AGr182e2kRstwM3RSsLPjIM9zgNhO4gOYYo9rMbB7gbMlO6ypQEDSEGXTopY4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3445.namprd12.prod.outlook.com (2603:10b6:a03:ac::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 05:22:04 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 05:22:04 +0000
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
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0AgAAHAwCAAAdWgIAABHGAgAAf5oA=
Date:   Tue, 4 May 2021 05:22:04 +0000
Message-ID: <5c06dc0a-4274-b6f0-3844-bd8afa1a59f9@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <e12fc396-76e6-9506-31c8-cfdee3fb7577@synopsys.com>
 <7ef627cf-3f8f-8a52-52c4-ac67ab48b87d@codeaurora.org>
In-Reply-To: <7ef627cf-3f8f-8a52-52c4-ac67ab48b87d@codeaurora.org>
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
x-ms-office365-filtering-correlation-id: dd92f0c9-4c05-4418-819d-08d90ebc8df6
x-ms-traffictypediagnostic: BYAPR12MB3445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB344503128BCF87E9653765C2AA5A9@BYAPR12MB3445.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iXv/WK3RwRYa+sOcImxaTlzACbzNgdE6lVw2/0OeHv3AsQYnUV68mARRjOjHTjjdgHg3U9pH49R9Wgd9xltylGXh2wrDR7NG0YjqN9uKTRB5Et7KJgDuNuie7bCvWJq+Up53/7aicKMuNB80cink/18AgYOAb5k6vtD+f1M5BsxohjNEG1oA3olKkoHTZ3w23MkOCLdY7jELcdAa9gMW5uWcZqxj/XSKtPw11cXLazqqtSX0Rt55kRznsmgKXYHjfhrK4HbjAgmZxF+hjYiBElNpkTJn6qcNTFsW5Lj5F6huwCxlFoN9K/F8szGDVVJuPSUGyieTDccuT9ti33iTtW0p7JKthTqyILla8R/Rg2PgopnAk5+prbFpMVGPhj2X3IPo7yEit9/fzWXAb7PIEY1bbOM30zN58vKo7IPCsCDXy5OofQIGlo5CMXSFTx9WAIk2h14cILEAB6YW+J+GgX8sva4oySACggciaB+2MyJanbcY3/QC4HEe0uFVsxYV2IPvY8wgqbLhMOuv82oZZWwCGkCzxP1npZlFRv5eu/4Ljn8kypD5nhugZR6dHm1gmCZhkch1it5CZgnoH+hUaHg5QVzFiVYLqc26tKM50kFKxVNH+LB/77/JUokR/RCSzRw/9AeECec1aaMGtf2QEETfjvqvCDZIM22yQ2XHkozaAIbifMYUzYR8x67BQsj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39850400004)(136003)(366004)(66556008)(38100700002)(36756003)(8936002)(71200400001)(6486002)(66946007)(64756008)(66446008)(316002)(53546011)(4326008)(76116006)(83380400001)(6512007)(54906003)(110136005)(8676002)(5660300002)(26005)(66476007)(31696002)(478600001)(122000001)(2906002)(31686004)(6506007)(86362001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c0dBako4SjJMTklLcUpnTE1VQlBCVGFNMGFpQWMrZnpSRFlDK0cxbHdtLzdK?=
 =?utf-8?B?NGpTT3Q3clQ3T3YyeDU2ZTJkaW9WMDNOYUN1cm5RbHRFL0JzVmJ1OS83VXpT?=
 =?utf-8?B?T2gwV20yV056VDkyTVpMaWcvWVluc3lwVXlLbW80d0ZkVWt5dWlkRTJWcVoy?=
 =?utf-8?B?VGNQNmhwMlB5aW9DV0w0TWw3Q3Y5cHU4d1JMTHZuRDcwZGlKWjN6eWtaUk8z?=
 =?utf-8?B?Z1c3MUZ1TzVvR1pzVjRTQmY1WlFiemhabTRtNEFydFRaRGYxMXp2SU96TGE3?=
 =?utf-8?B?YUhYaDlHUzNMS0NvQjB4ZUN5VTc4WWgvMnFiTFlnQ1hCNTAzRDRod1hUaEZh?=
 =?utf-8?B?enZ6cFZ3a25USEp1ck04YmxuY3QzUVJrZW9IYzBJN2htSSs3TS9ZdkZKVzVN?=
 =?utf-8?B?Q1JycWp4cEJIOERQMndML1E2a2VLMkJUVXZQYkt1QTVuRDZpZWF3ZU5JUkEw?=
 =?utf-8?B?NExsVWpjY01lejU3OE5qVWhvUFlLWWtqamtJaHNjaDlYRDM5cHIrQVpaODZW?=
 =?utf-8?B?bFdYc1N1WUNKb2xCdTEzRGp3ZmJRaHNPOFUwZlBZcGJsbENqeHVxL3k2K1Fy?=
 =?utf-8?B?Sis0ZmJucnFmSHFWMldZN21LY1NvWCtjSVNoeWJRZE9MUjN0RUVLMU1LQmR1?=
 =?utf-8?B?VEtveVpTbFE4cklSV1RpeUJROERRcHo0T2JhcGgwd3hRY0JPSkltN0NQdGN5?=
 =?utf-8?B?bzdmbDU2dWQyc3BQNXBxOC9ZQzB1bUt2Y0VBMW1UZ055eHhuWnJ1TmVqTlBX?=
 =?utf-8?B?dng1aHV5T3VvUXgzQ2hDSmx0MzM3akw0a29yMlNlRCs2N2ZrNWVwdGhHUkJE?=
 =?utf-8?B?L292MEs5Y3ZEZXI5Qk5iRzM3UlZRcE1ydWtycGR4T0R5NGlrTlVsSW1BeXJm?=
 =?utf-8?B?aGZuM21aNTNTZzZyWmF3Zk8zekZNVzdESW0zWHJXdHlROXN6Q0pHcXNiTHA0?=
 =?utf-8?B?N2hKWTltWFNMR3BhMjZZYUJya1B6dXl4VHFYS1gyazQyeDhQaUFsaHNRYUNG?=
 =?utf-8?B?bDRiaGI3RmV5ZkZlVEtWbDNjY3M4WWdjVzBwaWpvVXAwN21ERHFKbjJpeTNJ?=
 =?utf-8?B?RGR2TE1UMWdNWWRvbVl4Rnk4VVE2N0FnWlNlRVdEUTQrUEVyZHlRVzBJYjh2?=
 =?utf-8?B?cHdQZzlNUmE1aWQzVHJmTzd3RDNUcStmaDBHS2NvcWlzRFM1dytvMzNsd21Y?=
 =?utf-8?B?WEFGVzdXTDI2RzFVazBNK1lsQkd1OFJwOXhpRklmVXpPb0FCRGovdzF3RHhj?=
 =?utf-8?B?TUI3TjUrRzNzVEZ0TDZ6am5TbVJIclVVUmV5bHlCWUQ3enl2OFJxZkZzTEJ4?=
 =?utf-8?B?RWxSV242RmpxZlBldnFheEVyYTJMVmRZV0VKbmlySndSK3dEUlhYVmlmWUY1?=
 =?utf-8?B?ZUlSc0pjVjJvTUl3Yjk4eHBzd25LNEorY1MxZ28zSGcrUXo4cStmeUxHc3Mz?=
 =?utf-8?B?cEdJZXZTR2tvMWtrTGVWV3pRcWl0T1NRYWtMSzUvV3lkMmlZNVpNNEVGSHNP?=
 =?utf-8?B?ejI5aEVCVWFIR2pVZXhaWjBwbWRMNnVGemd0TnB4bXdiclVncXloVDVhRHds?=
 =?utf-8?B?QjZ1QWcyNnFEK3dDY2RqZUVIVnFjcktjZGJyTmpaZnF4Q1NYV1RBZDhWSnZD?=
 =?utf-8?B?a29yd1V5b202YW1NWWY1UlNWcHQwZUJseGYxTWpNUU9wYkhQZ25ZRXIvZ0F2?=
 =?utf-8?B?R1oybzY0RzJEMk94dkZpTnFZajhsSC9haWwrYjJTSmc1aGVhd1h0V3ZZZi80?=
 =?utf-8?Q?NjyN07IOzNaRQt5dcH+V6gm/a+B1or/Ju3V3q2w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <118B4A5C50A67D4692BE1E494DD23B87@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92f0c9-4c05-4418-819d-08d90ebc8df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 05:22:04.5850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNL4raDLrVSMDcclaUr24fQvhALBiY5QvGqvA4lW0xXrOlYAdrT7QyMjily9oNK6YvQDBo4lQrODb9E3isnm2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDUvMy8yMDIxIDg6MTIgUE0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4+IEhpIFdlc2xleSwNCj4+DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6
DQo+Pj4NCj4+Pg0KPj4+IE9uIDUvMy8yMDIxIDc6MjAgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToN
Cj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IFdlc2xleSBDaGVuZyB3cm90ZToNCj4+Pj4+IElmIGFuIGVy
cm9yIGlzIHJlY2VpdmVkIHdoZW4gaXNzdWluZyBhIHN0YXJ0IG9yIHVwZGF0ZSB0cmFuc2Zlcg0K
Pj4+Pj4gY29tbWFuZCwgdGhlIGVycm9yIGhhbmRsZXIgd2lsbCBzdG9wIGFsbCBhY3RpdmUgcmVx
dWVzdHMgKGluY2x1ZGluZw0KPj4+Pj4gdGhlIGN1cnJlbnQgVVNCIHJlcXVlc3QpLCBhbmQgY2Fs
bCBkd2MzX2dhZGdldF9naXZlYmFjaygpIHRvIG5vdGlmeQ0KPj4+Pj4gZnVuY3Rpb24gZHJpdmVy
cyBvZiB0aGUgcmVxdWVzdHMgd2hpY2ggaGF2ZSBiZWVuIHN0b3BwZWQuICBBdm9pZA0KPj4+Pj4g
aGF2aW5nIHRvIGNhbmNlbCB0aGUgY3VycmVudCByZXF1ZXN0IHdoaWNoIGlzIHRyeWluZyB0byBi
ZSBxdWV1ZWQsIGFzDQo+Pj4+PiB0aGUgZnVuY3Rpb24gZHJpdmVyIHdpbGwgaGFuZGxlIHRoZSBF
UCBxdWV1ZSBlcnJvciBhY2NvcmRpbmdseS4NCj4+Pj4+IFNpbXBseSB1bm1hcCB0aGUgcmVxdWVz
dCBhcyBpdCB3YXMgZG9uZSBiZWZvcmUsIGFuZCBhbGxvdyBwcmV2aW91c2x5DQo+Pj4+PiBzdGFy
dGVkIHRyYW5zZmVycyB0byBiZSBjbGVhbmVkIHVwLg0KPj4+Pj4NCj4+Pg0KPj4+IEhpIFRoaW5o
LA0KPj4+DQo+Pj4+DQo+Pj4+IEl0IGxvb2tzIGxpa2UgeW91J3JlIHN0aWxsIGxldHRpbmcgZHdj
MyBzdG9wcGluZyBhbmQgY2FuY2VsbGluZyBhbGwgdGhlDQo+Pj4+IGFjdGl2ZSByZXF1ZXN0cyBp
bnN0ZWFkIGxldHRpbmcgdGhlIGZ1bmN0aW9uIGRyaXZlciBkb2luZyB0aGUgZGVxdWV1ZS4NCj4+
Pj4NCj4+Pg0KPj4+IFllYWgsIG1haW4gaXNzdWUgaXNuJ3QgZHVlIHRvIHRoZSBmdW5jdGlvbiBk
cml2ZXIgZG9pbmcgZGVxdWV1ZSwgYnV0DQo+Pj4gaGF2aW5nIGNsZWFudXAgKGllIFVTQiByZXF1
ZXN0IGZyZWUpIGlmIHRoZXJlIGlzIGFuIGVycm9yIGR1cmluZw0KPj4+IHVzYl9lcF9xdWV1ZSgp
Lg0KPj4+DQo+Pj4gVGhlIGZ1bmN0aW9uIGRyaXZlciBpbiBxdWVzdGlvbiBhdCB0aGUgbW9tZW50
IGlzIHRoZSBmX2ZzIGRyaXZlciBpbiBBSU8NCj4+PiBtb2RlLiAgV2hlbiBhc3luYyBJTyBpcyBl
bmFibGVkIGluIHRoZSBGRlMgZHJpdmVyLCBldmVyeSB0aW1lIGl0IHF1ZXVlcw0KPj4+IGEgcGFj
a2V0LCBpdCB3aWxsIGFsbG9jYXRlIGEgaW9fZGF0YSBzdHJ1Y3QgYmVmb3JlaGFuZC4gIElmIHRo
ZQ0KPj4+IHVzYl9lcF9xdWV1ZSgpIGZhaWxzIGl0IHdpbGwgZnJlZSB0aGlzIGlvX2RhdGEgbWVt
b3J5LiAgUHJvYmxlbSBpcyB0aGF0LA0KPj4+IHNpbmNlIHRoZSBEV0MzIGdhZGdldCBjYWxscyB0
aGUgY29tcGxldGlvbiB3aXRoIC1FQ09OTlJFU0VULCB0aGUgRkZTDQo+Pj4gZHJpdmVyIHdpbGwg
YWxzbyBzY2hlZHVsZSBhIHdvcmsgaXRlbSAod2l0aGluIGlvX2RhdGEgc3RydWN0KSB0byBoYW5k
bGUNCj4+PiB0aGUgY29tcGxldGlvbi4gIFNvIHlvdSBlbmQgdXAgd2l0aCBhIGZsb3cgbGlrZSBi
ZWxvdw0KPj4+DQo+Pj4gYWxsb2NhdGUgaW9fZGF0YSAoZmZzKQ0KPj4+ICAtLT4gdXNiX2VwX3F1
ZXVlKCkNCj4+PiAgICAtLT4gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKCkNCj4+PiAgICAt
LT4gZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoRUlOVkFMKQ0KPj4+ICAgIC0tPiBkd2MzX2dhZGdl
dF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cygpDQo+Pj4gICAgLS0+IGR3YzNfZ2FkZ2V0
X2dpdmViYWNrKEVDT05OUkVTRVQpDQo+Pj4gZmZzIGNvbXBsZXRpb24gY2FsbGJhY2sNCj4+PiBx
dWV1ZSB3b3JrIGl0ZW0gd2l0aGluIGlvX2RhdGENCj4+PiAgLS0+IHVzYl9lcF9xdWV1ZSByZXR1
cm5zIEVJTlZBTA0KPj4+IGZmcyBmcmVlcyBpb19kYXRhDQo+Pj4gLi4uDQo+Pj4NCj4+PiB3b3Jr
IHNjaGVkdWxlZA0KPj4+ICAtLT4gTlVMTCBwb2ludGVyL21lbW9yeSBmYXVsdCBhcyBpb19kYXRh
IGlzIGZyZWVkDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+Pg0KPj4gc291bmRzIGxpa2UgYSByYWNl
IGlzc3VlLg0KPj4NCj4gDQo+IEl0J2xsIGFsd2F5cyBoYXBwZW4gaWYgdXNiX2VwX3F1ZXVlKCkg
ZmFpbHMgd2l0aCBhbiBlcnJvci4gU29ycnkgZm9yIG5vdA0KPiBjbGFyaWZ5aW5nLCBidXQgdGhl
ICIuLi4iIHJlcHJlc2VudHMgZXhlY3V0aW5nIGluIGEgZGlmZmVyZW50IGNvbnRleHQNCj4gOiku
IEFueXRoaW5nIGFib3ZlIHRoZSAiLi4uIiBpcyBpbiB0aGUgc2FtZSBjb250ZXh0Lg0KPj4+DQo+
Pj4+IEJUVywgd2hhdCBraW5kcyBvZiBjb21tYW5kIGFuZCBlcnJvciBkbyB5b3Ugc2VlIGluIHlv
dXIgc2V0dXAgYW5kIGZvcg0KPj4+PiB3aGF0IHR5cGUgZW5kcG9pbnQ/IEknbSB0aGlua2luZyBv
ZiBsZXR0aW5nIHRoZSBmdW5jdGlvbiBkcml2ZXIgdG8NCj4+Pj4gZGVxdWV1ZSB0aGUgcmVxdWVz
dHMgaW5zdGVhZCBvZiBsZXR0aW5nIGR3YzMgYXV0b21hdGljYWxseQ0KPj4+PiBlbmRpbmcvY2Fu
Y2VsbGluZyB0aGUgcXVldWVkIHJlcXVlc3RzLiBIb3dldmVyLCBpdCdzIGEgYml0IHRyaWNreSB0
byBkbw0KPj4+PiB0aGF0IGlmIHRoZSBlcnJvciBpcyAtRVRJTUVET1VUIHNpbmNlIHdlJ3JlIG5v
dCBzdXJlIGlmIHRoZSBjb250cm9sbGVyDQo+Pj4+IGhhZCBhbHJlYWR5IGNhY2hlZCB0aGUgVFJC
cy4NCj4+Pj4NCj4+Pg0KPj4+IEhhcHBlbnMgb24gYnVsayBFUHMgc28gZmFyLCBidXQgSSB0aGlu
ayBpdCB3b3VsZG4ndCBtYXR0ZXIgYXMgbG9uZyBhcw0KPj4+IGl0cyBvdmVyIHRoZSBGRlMgaW50
ZXJmYWNlLiAoYW5kIHVzaW5nIGFzeW5jIElPIHRyYW5zZmVycykNCj4+DQo+PiBEbyB5b3Uga25v
dyB3aGljaCBjb21tYW5kIGFuZCBlcnJvciBjb2RlPyBJdCdzIHN0cmFuZ2UgaWYNCj4+IFVQREFU
RV9UUkFOU0ZFUiBjb21tYW5kIGZhaWxlZC4NCj4+DQo+IA0KPiBTb3JyeSBmb3IgbWlzc2luZyB0
aGF0IHBhcnQgb2YgdGhlIHF1ZXN0aW9uLiAgSXQgaXMgYSBubyB4ZmVyIHJlc291cmNlDQo+IGVy
cm9yIG9uIGEgc3RhcnQgdHJhbnNmZXIgY29tbWFuZC4gIFNvIGZhciB0aGlzIGhhcHBlbnMgb24g
bG93IHN5c3RlbQ0KPiBtZW1vcnkgdGVzdCBjYXNlcywgc28gdGhlcmUgbWF5IGJlIHNvbWUgc2Vx
dWVuY2VzIHRoYXQgd2VyZSBtaXNzZWQsDQo+IHdoaWNoIGxlZCB0byB0aGlzIHBhcnRpY3VsYXIg
Y29tbWFuZCBlcnJvci4NCj4gDQo+IFRoYW5rcw0KPiBXZXNsZXkgQ2hlbmcNCg0KTm8geGZlciBy
ZXNvdXJjZSB1c3VhbGx5IG1lYW5zIHRoYXQgdGhlIGRyaXZlciBhdHRlbXB0ZWQgdG8gc2VuZA0K
U1RBUlRfVFJBTlNGRVIgd2l0aG91dCB3YWl0aW5nIGZvciBFTkRfVFJBTlNGRVIgY29tbWFuZCB0
byBjb21wbGV0ZS4NClRoaXMgbWF5IGJlIGEgZHdjMyBkcml2ZXIgaXNzdWUuIERpZCB5b3UgY2hl
Y2sgdGhpcz8NCg0KVGhhbmtzLA0KVGhpbmgNCg0KDQo+IA0KPj4+DQo+Pj4+IFRoaXMgc2VlbXMg
dG8gYWRkIG1vcmUgY29tcGxleGl0eSBhbmQgSSBkb24ndCBoYXZlIGEgZ29vZCBzb2x1dGlvbiB0
bw0KPj4+PiBpdC4gU2luY2UgeW91J3JlIGFscmVhZHkgY2FuY2VsbGluZyBhbGwgdGhlIGFjdGl2
ZSByZXF1ZXN0IGFueXdheSwgd2hhdA0KPj4+PiBkbyB5b3UgdGhpbmsgb2YgYWx3YXlzIGxldHRp
bmcgZHdjM19nYWRnZXRfZXBfcXVldWUoKSB0byBnbyB0aHJvdWdoIHdpdGgNCj4+Pj4gc3VjY2Vz
cywgYnV0IHJlcG9ydCBmYWlsdXJlIHRocm91Z2ggcmVxdWVzdCBjb21wbGV0aW9uPw0KPj4+Pg0K
Pj4+DQo+Pj4gV2UgZG8gaGF2ZSBzb21ldGhpbmcgc2ltaWxhciBhcyB3ZWxsIGRvd25zdHJlYW0g
KHJldHVybmluZyBzdWNjZXNzDQo+Pj4gYWx3YXlzIG9uIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkp
IGFuZCBpdHMgYmVlbiB3b3JraW5nIGZvciB1cyBhbHNvLg0KPj4+IFByb2JsZW0gaXMgd2UgZG9u
J3QgdGVzdCB0aGUgSVNPQyBwYXRoIG11Y2gsIHNvIHRoaXMgaXMgdGhlIG9ubHkgdHlwZSBvZg0K
Pj4+IEVQIHRoYXQgbWlnaHQgY29tZSBpbnRvIHF1ZXN0aW9uLi4uDQo+Pj4NCj4+DQo+PiBJdCBz
aG91bGQgYmUgc2ltaWxpYXIgd2l0aCBpc29jLiBJIGNhbid0IHRoaW5rIG9mIGEgcG90ZW50aWFs
IGlzc3VlIHlldC4NCj4+DQo+Pj4gQ29taW5nIHVwIHdpdGggYSB3YXkgdG8gYWRkcmVzcyB0aGUg
Y29uY2VybnMgeW91IGJyb3VnaHQgdXAgd2FzIGEgYml0DQo+Pj4gZGlmZmljdWx0IGFzIHRoZXJl
IHdlcmUgc2NlbmFyaW9zIHdlIG5lZWRlZCB0byBjb25zaWRlci4gIG5leHRfcmVxdWVzdCgpDQo+
Pj4gZG9lc24ndCBhbHdheXMgaGF2ZSB0byBiZSB0aGUgcmVxdWVzdCBiZWluZyBxdWV1ZWQgKGV2
ZW4gaWYgZXAgcXVldWUNCj4+PiB0cmlnZ2VyZWQgaXQpLiAgVGhlcmUgd2FzIG5vIGVhc3kgd2F5
IHRvIGRldGVybWluZSBpZiBraWNrIHRyYW5zZmVyIHdhcw0KPj4+IGR1ZSB0byBlcCBxdWV1ZSwg
YnV0IGV2ZW4gaWYgdGhlcmUgd2FzLCB3ZSdkIG5lZWQgdG8gcmVtZW1iZXIgdGhlDQo+Pj4gcHJl
dmlvdXMgcG9pbnQgYXMgd2VsbC4NCj4+Pg0KPj4NCj4+IFllYWgsIHRoZXJlIGFyZSBhIGZldyBw
aXRmYWxscy4gSSBkb24ndCBoYXZlIGEgZ29vZCBzb2x1dGlvbiB0byBpdCBpZiB3ZQ0KPj4gd2Fu
dCB0byByZXR1cm4gZmFpbHVyZSBpbW1lZGlhdGVseSBhbmQgbGV0IHRoZSBmdW5jdGlvbiBkcml2
ZXIgaGFuZGxlDQo+PiB0aGUgZGVxdWV1ZSAoaWYgaXQgd2FudHMgdG8pLg0KPj4NCj4+IFRoYW5r
cywNCj4+IFRoaW5oDQo+Pg0KPiANCg0K
