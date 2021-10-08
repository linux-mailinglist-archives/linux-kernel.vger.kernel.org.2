Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7CD42616F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhJHAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:42:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60804 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhJHAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:42:26 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2F9E7C41E6;
        Fri,  8 Oct 2021 00:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1633653632; bh=s6z+DR2wTgOp58A6GVfiBq6GDc7XQrdaq07byxdpCSA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=We4989I0lJUdoQgrEVoYFHChk5tASPjLqRHd97ELBaBongr5+307f/Hj8iGJFBoCz
         AgXQfG22HRCMZ1/QQm5BUs5JV8ALdBtOY++svyN7q/468CVGflqa9aZxN+CJ/G/I/9
         B6R4vhMfx8X8/GqHUokpbLCL2MfZ+FBLRbEJIiRQYPLHJwSM44jjTkK4qjkgvKZISs
         BSIFXfpsIKQVAG8pYEG+JUmtldh4W4EQBPoPo8pj4OnEyRJ3sjZbb8ELEQwJOhHz2p
         KS6b58T9PGLCBuZ2fzkrXuhmQ9+cC5baJBTV3czfHo/uk/MiX4vyGSvZhqSfmTTdTo
         hlHhrSiu4VFjA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2AA58A005F;
        Fri,  8 Oct 2021 00:40:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5C4FE80151;
        Fri,  8 Oct 2021 00:40:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="n/8a7xhv";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4ql8tBijPXKMGcpwf3u+eq5HsHZ/qnQSfhyMMf0zPv13hQ2yD8YqJYNGriWMNz/0Z+ncs+KE/oq8o5CMXW+oOiA2er4S2N62ug+VrimX45j1Kn8Yan6WJwgdyvydze/fooeFq+ihlYmLMHVb+iU3wqd5+GeH+U663fX4BL7racxcDDDil+x8RIfF4J6lUAsYHyV3RCq+8xcRqEKdVIlmgNXR4sg4YjaDyzQDjBok4aUxtwWicdoyCvDgxiZjEWNX4Ja/6GaJi2zuq/Ieo7rrbISrThe4W0Dn/grS/32Q2qnlu6wEtNYMjbkczMMv6c4nV21XHu47ErJVihgJKwOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6z+DR2wTgOp58A6GVfiBq6GDc7XQrdaq07byxdpCSA=;
 b=B6Hcr2aJ84Tao5l6Qf5bL7Kzfly/XB38TPLRfiqt2sHatujrYITvH7xPvbwADF53c7bQ5G8/UEvWF6H4J3UBs2kvSYym38RZBSVjjgVV16VtiiObGG7RQfIvph9MgKO2s0M6JHMYz81e2zttLfp+qR1GEJZqYkwA0G1wxjn/GmWFYkoBVK9R52W36LE7HQXnM9YoJnrVRcTVU6PPAzM6Iftny8UexGOALqSXN7KwAq6vrDwT4OGstAsa9ri+loUSMqwszcL9SM5dSiKioLvLIrlhtKVHElwW8fQGZ1SXvp1ULst4P4hzxiIPC7V/hK3tFdrP1jDUlpzDFzeYw2n9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6z+DR2wTgOp58A6GVfiBq6GDc7XQrdaq07byxdpCSA=;
 b=n/8a7xhvt6OYzG7K3YbzyTtf5TOYg1QIh+R4a9uwNtUW3CjXOwAAjGxOiRLc56k7TiC+ve3aNqZG2Ns29PF6sVqqEAv2SgRYTWzSNs1xymV6FVALCactkwhOOipEimYtt3R0upfVNNlrSZnCj6GC1/goIpuKWBWPN/apRRT15ro=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4641.namprd12.prod.outlook.com (2603:10b6:a03:1f7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 00:40:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::5967:b5df:7ee5:e45b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::5967:b5df:7ee5:e45b%6]) with mapi id 15.20.4587.020; Fri, 8 Oct 2021
 00:40:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Shantur Rathore <i@shantur.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: fix endpoint direction when inputs are more
 than outputs
Thread-Topic: [PATCH] usb: dwc3: fix endpoint direction when inputs are more
 than outputs
Thread-Index: AQHXoxf7R3wBqqczlkKmtu+9UCfOnaucYsoAgAJy2ACAA+nDgIAAu5eAgCT4/wA=
Date:   Fri, 8 Oct 2021 00:40:27 +0000
Message-ID: <4ed902e7-76d2-057a-8c0b-5542eb524d55@synopsys.com>
References: <20210906120836.4596-1-i@shantur.com>
 <6305c1ef-12e6-781e-3235-cd206d5b2b62@synopsys.com>
 <CABEcMwXdot0yCKt3+Azr4dehA3bP+8dm2azTgzJwT-Xv7tbCQg@mail.gmail.com>
 <4ce1f8fa-d26d-cf15-b19b-aaa8e81e9a00@synopsys.com>
 <CABEcMwU7w2aT2jb4bqNKP97FsupQidgVHT5C+1GfFyJe7ojv1g@mail.gmail.com>
In-Reply-To: <CABEcMwU7w2aT2jb4bqNKP97FsupQidgVHT5C+1GfFyJe7ojv1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: shantur.com; dkim=none (message not signed)
 header.d=none;shantur.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1040a192-fb44-4daf-bb3a-08d989f4392b
x-ms-traffictypediagnostic: BY5PR12MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4641C6FAE82033C256EA7B86AAB29@BY5PR12MB4641.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4mZw4YhaeRCRiYlqkrzWjummpdlO89JQMOwuHUy2XENlNnejFoHw444txbFq2v86QM29CITonS+zZclW5+Yiq1hTlVig/Jt+igjzgaRe/a4y6WsWCJbeGVNQxBigorcRepHO+sFr8xBBRqFn8llyKCrysca7orxgSgK2qA2JLDzBrnG2Reh1jFeSEg8SDCDK49TYFmZZOE9/x5qFBEDlzlMocQxU7lZv2pWbYMKDt8AIh4zZ5HmhaohXv9npusSzyuvUyT5VhKbRaM1uDWkp10mcMKFp3mSRHptg7fPGgAZB0a32q+NPEi5JRX3lMbbW3GPBkD0m1LjdURtOvqFD053bhn0FSf4tsqCnebW3p54xjvUQYr8bHMUZ8GZD1tUO0G8saM++mlSpfqNE//UeREbx44i+wTbKdMSuPiAvCu5lP3ENBWIJ8rkgVaZOd32F1a95QyFzMOgVsSzC+Elx5hoflSeFG5RpyscwPYxHDBgK9AkU35rmQB3gl0DwK8Q+VsN4SyuSvgSufw0F3XthuKv0dYgH5PL/Ggvs3hTfCWE/v4OlGC6VT5MdVSDfuGHlwIE4D7+jJ9m3Plzskd1c5KGwJRJFf4WyaSVvo+GUhVRHHKanT2fjGJBfRA2/XRymrD7AGW3C8fJAxhv+v7iWJS/xSmENzbU8J3nUD1Y2iIhwaJr/GIeHk7m+JxFGkxLdzgTTDFKoqMfskbT7s+re+vV4Z3eaaIbe8QQLJEJ7D9AQJRmT/S/Tb63nNrNLW6eorf6qKoOzAH6bhpTBbBnoPTS4rQ2GYo20K7rLxJy0BU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(64756008)(2906002)(66446008)(66476007)(53546011)(66556008)(36756003)(4326008)(6486002)(5660300002)(8676002)(508600001)(6506007)(6512007)(110136005)(76116006)(71200400001)(83380400001)(38070700005)(54906003)(2616005)(8936002)(31696002)(316002)(26005)(86362001)(186003)(31686004)(38100700002)(122000001)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emJxclBGdGNZZEJqK1kzejUxS2N3QlY4azBxUnc3aUR4OWhWc2VFQWZQN0dW?=
 =?utf-8?B?Y1ZQU1lDNG5KNG5OZW5zdzV1RDF4Zm9adlhhdHNTVTFocHljRjNjb281WlBu?=
 =?utf-8?B?MXQxMExzdFpLYXllZ2NrUC9PVFRwa1IyclBJQVU3RUhQcnZGWVpzbDEyT09n?=
 =?utf-8?B?SGhTR2Vja1I1QVFnQ2FFQitleHFSSWZNamxGbTR4UXlibDZlMUdObTV2TVVt?=
 =?utf-8?B?MjRUNXFRbHFnS0xnZzhyVXQwd2VDbmNRWkFRMCtFcE96Y0tkZE9rVE82OGNJ?=
 =?utf-8?B?cUNxbWh1N3liaWZjWS9zbGJvdTR3QkMyZFQ1ZDdvL0MrNE51b2k0N2szZGxs?=
 =?utf-8?B?SVZTRVdEY3RjWlNFNE5SUEZzUG5pUHlZWHQwWHZVTFAzc0FScElTRk0yWE1E?=
 =?utf-8?B?cmJ6LzMzRHFsdnFzSVFjVmFKc0kwbEVXbWxnZnB0VFJSN3F0N0cxTFFrc0Ry?=
 =?utf-8?B?Rld4eWdlVFlrTk56dWVlajh4NUxmU3l4WE44c0xnQXRPaGFWcnBqSU53Q0hn?=
 =?utf-8?B?MmhGZU1UZUNBVkovcHloZFFubHNOUEtiM0JDQ0I2UElPcHVRRndEOEUrMTF1?=
 =?utf-8?B?QUhWN3NYR1VlUVNaVytMcTA5dlVrdlpvOERHL2RYalBDWmdKYUcrUGx6RFhy?=
 =?utf-8?B?azlhMGs4a2w4T2hDTkJTNkRtRkwzeWZEdVNrRlN6aWZmWk9ScjhMMkRsV3Jy?=
 =?utf-8?B?YkZoaytIWmFOTldqM21lTDdoSXhHUVgrUFF5VVRqTTlPRWxENm5zekNqU1RV?=
 =?utf-8?B?a25LWG5YbzlNVEw2Tm5ScHdpeEJ1dGJOTzk1MmJJSmVJSmhwS1plVStjYjlG?=
 =?utf-8?B?TWZhWTJudVZlNWJ2V0dFTjIzeVI2UXA1Y3dwdkZQWXhFRm80eWN6UE9URjk5?=
 =?utf-8?B?OVJDdGhxbUpCWXZTbEFORFFaUFNWeVdQZ0VWblhjRC93UXRGZU85TXRmYWYr?=
 =?utf-8?B?WExWRFdvb2xkNVFXMlp6S21OQzZhOUwzOEJFeTBSZVYzN0E2eHY1TmxhOFps?=
 =?utf-8?B?WjVubSsvbWZ3cnN0Z2Y5cnJ5eTNURFV3aGhlc1Ftb0xmY2MrRmRtRzFUeVJT?=
 =?utf-8?B?WmxwcStuSERBSm5xQUxuR3RaU3ZXSTJwcm5aMy9JYWNIeE5SLzdYUEFqR3FK?=
 =?utf-8?B?ejE1dGN4eWZKYzY5NHE0MGVOaFZwVklKaUFnK3pwN2E1enFkQ0hWamdMSmdP?=
 =?utf-8?B?ck9PTmhvc0tHYzlIRUFOc0JzbzRSeEdrNitTWWg1VDc4Snp3MkxXUDdMRXlt?=
 =?utf-8?B?eUNKVDhVTTN3Nmh6SjR0RlVmdm9aRFA0WmZLRnNESkJ5MjZVcGNLVFd1K0Vx?=
 =?utf-8?B?QkRNZCtpYUwxTm9iUjJPS1NXaWlKYUdmeFZiWjhRVTlha2ZMYTFMeGczWGpB?=
 =?utf-8?B?UFRLclo2ai81cW1iUzg2aldRcWNUNVJmb3ZSYkt0QjNEVklDVTNSMXk0aWRp?=
 =?utf-8?B?SEZJbDlQK3FqQ1VMZkF5dlVqRGFwZEQ1cU9DeWxZaHYxVlNwcVJnM3R4Ymlq?=
 =?utf-8?B?S1JLNjFtRTR0K3RRZDNzdk5ZNFZVbUgxTlhnbWVhNnFpZzVFQzdIaTFVY1Ax?=
 =?utf-8?B?cWNlN3N2SWp5ZjE5SGppbXoxYmQ0YWJkdHBYUWlzMHBEUXBnZmpwdUNFaUJ1?=
 =?utf-8?B?ZFNzSlhXVjBCcTl0eFZWMXF5TGRNNzlibTVycUJEVGYyUThKWWdJNnRPbTFX?=
 =?utf-8?B?Uk1wd2x3SVV4UDRRanJwOFlaMlBtdmwxSFkxeHcxNzVBcVFqeHhoNm9oMkhl?=
 =?utf-8?Q?Yn6X4yy+K5TRETWsUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF698D9B171D2048BD3E5E60DBF82A9F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1040a192-fb44-4daf-bb3a-08d989f4392b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 00:40:27.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tdau2gHYZlL4xxH+FN/KnoaiSdT113ko6EydE9zSeKriAwa+sYH6pP0dzQSgfj38rdlwLxrP2C22hcmgqjpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4641
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2hhbnR1ciBSYXRob3JlIHdyb3RlOg0KPiBPbiBUdWUsIFNlcCAxNCwgMjAyMSBhdCAxOjUyIEFN
IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gd3JvdGU6DQo+IA0K
Pj4gU2hhbnR1ciBSYXRob3JlIHdyb3RlOg0KPj4+IEhpIFRoaW5oLA0KPj4NCj4+IEhpIFNoYW50
dXIsIHBsZWFzZSBkb24ndCBkbyB0b3AtcG9zdC4NCj4+DQo+Pj4NCj4+PiBUaGFua3MgZm9yIHJl
cGx5aW5nLg0KPj4+DQo+Pj4gQXMgcGVyIHRoZSBkb2N1bWVudGF0aW9uIGZvciBSSzMzOTksIGl0
IHNheXMNCj4+Pg0KPj4+IFVTQjMuMCBEZXZpY2UgRmVhdHVyZXMNCj4+PiBVcCB0byA3IElOIGVu
ZHBvaW50cywgaW5jbHVkaW5nIGNvbnRyb2wgZW5kcG9pbnQgMA0KPj4+IFVwIHRvIDYgT1VUIGVu
ZHBvaW50cywgaW5jbHVkaW5nIGNvbnRyb2wgZW5kcG9pbnQgMA0KPj4+DQo+Pg0KPj4gVGhlIHN0
YXRlbWVudHMgYWJvdmUgYXJlIG5vdCBhY2N1cmF0ZS4gWW91IGNhbiBoYXZlIG1vcmUgT1VUIGVu
ZHBvaW50cywNCj4+IGJ1dCBpZiB5b3UgYXNzaWduIGFsbCA3IGVuZHBvaW50cyBhcyBJTiwgdGhl
biB5b3UgaGF2ZSB1cCB0byA2IGVuZHBvaW50cw0KPj4gbGVmdCBmb3IgT1VULiBUaGUgZHdjMyBj
b250cm9sbGVyIGlzIGZsZXhpYmxlIGFuZCB5b3UgY2FuIGhhdmUgdmFyaW91cw0KPj4gY29uZmln
dXJhdGlvbnMuDQo+Pg0KPj4+IEluIHRoaXMgY2FzZSwgSSB0aGluayB0aGUgaGFyZHdhcmUgZGVm
aW5lcyB0aGUgZW5kcG9pbnRzIGJlaW5nIGluIC8gb3V0Lg0KPj4+IEkgYW0gaW4gbm8gY2FzZSBh
IGR3YzMgZXhwZXJ0IG9yIGhhdmUgRFdDMyBkb2N1bWVudGF0aW9uIHNvIGNhbm5vdCBzYXkNCj4+
PiBmb3IgY2VydGFpbi4NCj4+PiBJdCBpcyBhbGwgYmFzZWQgb24gUkszMzk5IGRvY3VtZW50YXRp
b24uDQo+Pj4NCj4+PiBJIGFtIHRyeWluZyB0byB1c2UgYSBjb21wb3NpdGUgZ2FkZ2V0IHdpdGgN
Cj4+Pg0KPj4+IC0gSElEIEtleWJvYXJkIC0gMSBJTg0KPj4+IC0gSElEIE1vdXNlIC0gMSBJTg0K
Pj4+IC0gTkNNIC0gMiBJTiBhbmQgMSBPVVQNCj4+PiAtIDIgTWFzcyBTdG9yYWdlIERldmljZXMg
LSAyIElOIGFuZCAyIE9VVA0KPj4NCj4+IFdoeSBkbyB5b3UgbmVlZCAyIE1hc3MgU3RvcmFnZSBk
ZXZpY2VzPyBDYW4geW91IHVzZSAyIExVTnMgaW5zdGVhZD8NCj4+DQo+PiBNdWx0aSBsdW4gbWFz
cyBzdG9yYWdlIGRldmljZXMgZG9uJ3Qgd29yayB3aGVuIHlvdSBib290IGZyb20gdGhlbS4NCj4g
U28sIEkgbmVlZCB0byB1c2UgZHVhbCBNYXNzIHN0b3JhZ2UgZGV2aWNlcw0KPiANCg0KT2suDQoN
Cj4gDQo+Pj4NCj4+PiBUaGF0IGluY2x1ZGluZyBlcDAgdG90YWxzIHRvIDcgSU4gZW5kcG9pbnRz
IGFuZCAzIE91dCBlbmRwb2ludHMuDQo+Pj4NCj4+Pj4gQ3VycmVudGx5LCBkd2MzIGRyaXZlciBh
c3N1bWVzIHRoYXQgRFdDM19OVU1fSU5fRVBTKHBhcmFtcykgaXMgYXQgbGVhc3QNCj4+Pj4gaGFs
ZiBvZiBEV0MzX05VTV9FUFMocGFybXMpLiBJZiB0aGF0J3Mgbm90IHRoZSBjYXNlLCB3ZSBtYXkg
c2VlDQo+Pj4+IHByb2JsZW1zLiBUbyBjb3ZlciBtb3N0IGFwcGxpY2F0aW9uIHNldHVwLCB0aGUg
ZHJpdmVyIHRyaWVzIHRvIHNldHVwDQo+Pj4+IG51bWJlciBvZiBPVVQgPSBJTi4NCj4+Pg0KPj4+
IEkgdGhpbmsgSSBhbSBzZWVpbmcgdGhpcyBpc3N1ZSB3aGVuIEkgdHJ5IHRvIHVzZSB0aGUgbGFz
dCBJTiBlbmRwb2ludC4NCj4+Pg0KPj4+IENhbiB5b3UgcGxlYXNlIGxldCBtZSBrbm93IHRoZSBk
aXJlY3Rpb24gSSBzaG91bGQgdGFrZT8NCj4+Pg0KPj4NCj4+IEF0IHRoZSBtb21lbnQsIEkgZG9u
J3QgaGF2ZSBhIGdvb2QvY2xlYW4gc29sdXRpb24gZm9yIHRoaXMuIGR3YzMgc2V0dXBzDQo+PiBo
YWxmIElOIGFuZCBoYWxmIE9VVCBmcm9tIHRoZSB0b3RhbCBudW1iZXIgb2YgZW5kcG9pbnRzIGFo
ZWFkIG9mIHRpbWUuDQo+PiBXaXRob3V0IHRoZSBmdWxsIGNvbnRleHQgb2YgdGhlIGNvbmZpZ3Vy
YXRpb24gZnJvbSB0aGUgY29tcG9zaXRlIGxheWVyLA0KPj4gaXQgY2FuJ3QgYWRqdXN0IGVhc2ls
eS4NCj4+DQo+PiBNYXliZSBvdGhlcnMgaGF2ZSBzb21lIGlkZWFzLg0KPj4NCj4gDQo+IEl0IHdv
dWxkIGJlIGJlc3QgaWYgZW5kcG9pbnRzIGNvdWxkIGJlIHNldCB1cCBhcyBJTiBvciBPVVQgYXMg
d2hlbg0KPiBhbGxvY2F0ZWQgcmF0aGVyIHRoYW4gcHJlYWxsb2NhdGluZyBpdC4NCj4gTG9va2lu
ZyBmb3J3YXJkIHRvIG90aGVyIGlkZWFzLg0KPiANCg0KT25lIHdheSBpcyBpZiB0aGUgY29udHJv
bGxlciBkcml2ZXIgY2FuIGdldCB0aGUgZW50aXJlIGNvbmZpZ3VyYXRpb24NCmZyb20gdGhlIGNv
bXBvc2l0ZSBsYXllciB0byBjaGVjayBpZiBpdCdzIHBvc3NpYmxlIHRvIHNldHVwLiBTbyBpdCBr
bm93cw0KaG93IG1hbnkgYW5kIHdoYXQgZGlyZWN0aW9uIHRvIHNldHVwIHRoZSBlbmRwb2ludHMg
aW5zdGVhZCBvZiB0aGUgb3RoZXINCndheSBhcm91bmQuDQoNCk1heWJlIHRoaXMgaXMgc29tZXRo
aW5nIHRoYXQgV2VzbGV5IGNhbiBhbHNvIGJlbmVmaXQgZm9yIHR4ZmlmbyByZXNpemluZw0KYnkg
ZW5oYW5jaW5nIHRoZSAiY2hlY2tfY29uZmlnIj8NCg0KQlIsDQpUaGluaA0K
