Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3E363C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhDSHdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:33:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37398 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233831AbhDSHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:33:02 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AFEC14066D;
        Mon, 19 Apr 2021 07:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817553; bh=VkN/2+b28F9y6Ea1ogCIx9fQSS0PMU/YDPZ3Dl5+Brk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=B12myu8Eelz/U8UTMj4s+pMG2Ut9JT9VQq12VK1tOu5wKqOSuYOAYZz7wvveegPr9
         Q3kKG+UskOxBboNoaXFLT6kVYhcRQsg/y1Xm20nZELRjPYNMd2DkJ9h0K5CoMN8DWx
         89U35b4xDUH9PcIYDpAiNXYeFbloIi7oQRVzvJhZ8ZvxCf8dmPeG0O47e98dkyfniG
         3i+caRGvhCtgeJI2X9H7d9Lh8bUV4Au2KK8Eb7I5FNe0Jh1nXDlFL+SXuPWIow1/qU
         tAGqMXZBeBEwojeREkVwVSTyor9GQ/wLMStDIF2h+Vab8MDmalL4ZIhoC7obRvxoLp
         wNcel2qkFOvug==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 684B8A0070;
        Mon, 19 Apr 2021 07:32:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9FB4E40145;
        Mon, 19 Apr 2021 07:32:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NEbgv+JE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElC1zupvtqjYYw7Oy137OYjAHckst5Giv6a11DORq+d17dEnM5oHfAoC+zfjniS9kMwWNk+sNkEhiRSs5FMA83xcauOyj+BFqeJxA7tOBRUaVr6iIJbYt0PBrMdsklHOGYNBZ0qDkvyNjM0zNNvzrmDwYcvRhojE5MXN6YqVBf66ApVQNNIXZb2kqc1ZVSgZChQ0xQiGdsdVXdZY15LbUNiu0CG083o5eqjhk8kfjRIqPTgfGxT/ICO2pNbr+ALWwVt0+jCCE5TAwVNDD88/Rkolwo/NWyYQ6BuKr55c9oKxz6ehLoDs10wqiooFWnLXeHqz3aM2iCBTykMlp8/3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkN/2+b28F9y6Ea1ogCIx9fQSS0PMU/YDPZ3Dl5+Brk=;
 b=NR3yaXPEULBdV7U5SUTg08uVQjOCwn2yGnMqYSJ2AoqCHQ5navEkgJVRKQj4m73N71GN7fhqatEYJZSWa2QrJhLJKn3jUoSfTpOVZXygo+z1T01+KWy4l9gT9TX/GSMSaM30HtJ53kGSlsADEIwZ3nXjelxcGvU0tJAjqOHnLj5BsepHSu08EjqVIKt9eJ5aFniGckgcq0nKB90yl9sxer9Quuz86ve+ileo93L25Gk0wQbmxPEIHDzMSt5yyt5kKUYmXLVTk0SsDCaYlLjNvmDsiPxTcxGH3qSNUu/8/UOwyxkQhQQur02s54Tfdue2oDjxlcX2OK2FZgGWJJyffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkN/2+b28F9y6Ea1ogCIx9fQSS0PMU/YDPZ3Dl5+Brk=;
 b=NEbgv+JEYahGalXDgzjKHm1KuckSPlmAj75zHX5ucxKc1ETbkt7yHYhQt7PUvETdZfMxwSo2sZsfmIeymRjJ3lhr7DXzRv9c1+rSttCh9zrSVclIQwn/PemA5Z2H3K+d6K42LTFyT838nqQ5lTEncVhtY5SrHzj3GgxRiMP9NBY=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:32:31 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:32:31 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 15/15] usb: dwc2: Get rid of useless error checks in
 suspend interrupt
Thread-Topic: [PATCH v2 15/15] usb: dwc2: Get rid of useless error checks in
 suspend interrupt
Thread-Index: AQHXMr7YmEeJxxsOJ0u1ExM4buUuVaq7dtEA
Date:   Mon, 19 Apr 2021 07:32:31 +0000
Message-ID: <40d57687-96ca-187a-1d8e-7be8f9cddbde@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124843.9EDCDA005D@mailhost.synopsys.com>
In-Reply-To: <20210416124843.9EDCDA005D@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: 4a61d800-3529-40d9-4679-08d903054acc
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5000D24E946BB13D5766CCE2A7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j96fsx6JlRG3OH8xvJkdIF8i+M25V5Nceh3uHBVAX5Av8GUKBLNLsLiPj/PzKlwLr/GqixKKop4O9oVeATpjEnhngO81VLCiti75aInBiHqTMFi0jTgRFCc5/0aeCrPUn8uRXyT42zohR8i47XjPdaWrvSmm2i5hvgtLfDU1CxSA+49lXgV2OdQr3oxU4Xf0jR3kWfRlQZxZ9QoM4E3fvn7E4+INm9PbDLMJUndkBfKRz7Di9yzvl4ZLAnTyo7VW0s3ii4NW03/pxDhwMPbxsiHbccyVUsFDdQ90AY/zsyShECEZ9V3MbnDHyMQYWZN28pOvXqu3g8clvtdUiMjUfYT7yLy4+gcf4QU0LenJ7HtjZxC1awWzPsTU1PPXbwBtFmwsFHCymFiphvBf5AH5pMp27SlZeUVrgxxqvW2ZtMOu4xdofUfkzhX721pfNUtUb1Ze7Ll8qwDV+z5cwBSixn2Bux9SApG4fZruVAbD3+pUpO75V8mm7Gzxa1+hBZc9td06cV3IsCWCtx1yyOtqMejJKkoWoreqnEDIjW3Ysbcf6dfBYHQ4EG4w5nQ59dmPS5KnP2QalWVxnUmQ2mh4sGIpGwHnL0dRE83HwWf5m4eOuZhKlNwRS9KcP6+iK7QYTt/gHD+r8OQ8hMSwvZ5jxmA4WaWEzlK6sI761r7GWeRGd6ocvf/jbW3o/y2IeaqkBCwRqOdh1GPFWh1iJXn5nc70NpQPLxMzrknKncHg9rA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(54906003)(122000001)(15650500001)(2906002)(31686004)(38100700002)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?blI5NmhNVlFwc0tHcmlldnJpZWltKzcvTUhsQkFzL3ZRS2NxTi9BYTBsQXFz?=
 =?utf-8?B?RDB1RDdaMTNjMlhlcFh6QzcvWlNLVnpBN3A5cmxKd1V0VGtiMFlXQmVOUmJl?=
 =?utf-8?B?Sms5UmxJazNQenpwWlpFN3p5QjIwUGZXMzdFOTZoWGxCVTBiQS82dkxXRERL?=
 =?utf-8?B?ZzRqRXV0dlF1WWlpbUJ2dExibjhTVU8xYytNODRDZ2Eva2VJOS9mTFhwMEJE?=
 =?utf-8?B?Z01zOHVPcVdYTkhhNlpqS0JpM3drNVdWR08xdnpYK2U0cHMwUmowdGtIUXJJ?=
 =?utf-8?B?UXd1TjhVN3dTSDNGYWdyWUNCbERCOVRzL1p6SmN1dXUvckc4cXFoNGhqWVBE?=
 =?utf-8?B?YkxUR2hOV2hGVHBmQ0crRGh2bjJ1WVFrYW4zQnQ2WDcrbGxvajFkanhTR3ZY?=
 =?utf-8?B?TXN5V2ltQ1Y4dk1tZHVTUElWUzlTTm45akllSkNROEFmN25tTU5PYkliQ25O?=
 =?utf-8?B?b1dpYXUwSjhWVTRBMUZaUzVnTDRseEJIclA5cEpEaGszNG5qOXBxMHNCNHoy?=
 =?utf-8?B?Y29mNEpETHprMlpNU1dHS2FFNHIxR2d3SnY5QUdpTlZDWDYwYzJtV2I5UGdy?=
 =?utf-8?B?cVBYN2IyWHlLYWswY3FPbjM1NWc1YmpkM056dUgxVTFVRzlXWFBxNE1ZVWpO?=
 =?utf-8?B?dWpaYmVaWGxHajJPTndzclNjckNZTUFXbklDSGF1Q2hTdm5IT2N6ZElKMTlo?=
 =?utf-8?B?TkR4WUZaVHVLT2hpUnNiTVBIV04wVEEyNFBHMkZuVUFuQ0JXcjhtRXdXUjBE?=
 =?utf-8?B?NG5MaGU1WG5RaG5PU3ZpRERGdHk1T1BDRHk5My85dzRXVU92VG5hb1V1THBi?=
 =?utf-8?B?dCtNTnhBTHZMRVRLR2hVVEVXVXZGNzZtbzcvNVh1WXZTYXkwVU1vZ2ovSG9x?=
 =?utf-8?B?RzVFTFJRY252amtsSHFVaW9xcHVLZlUvUDl0MFExRFlsZExQaEd3MjZxWHU5?=
 =?utf-8?B?MzVrWnpCVS9GODJoTThTNlI0c2Fma1VNcUtGYi83Z3Q4c3h5S1FrL2dBaVor?=
 =?utf-8?B?V0lrYkoxTXY4Y0JQZmNmVVk3STB3emcwMlJhNEw4OS96b1l3bFhEY2hXU3FO?=
 =?utf-8?B?Q0pTRk1aZ1l2YUYvVENMWDNPSzJQZHI4Wk9hZ1NTM1EwSytJc2szUk1nMklX?=
 =?utf-8?B?Tk93eUF4S3JSTEVlTStteCtjYmMxMklRVlM4RjVacEJOcExBRHlqYXJPaWdN?=
 =?utf-8?B?QXFHZ0FvWUcvdHUvOHQwL20zZUJNZ0hFTzFEdktnMlM3S1ZPR0lNQjVJNW1J?=
 =?utf-8?B?REZBY0JoNFE4czFKd3liUU9XNGFyQ2ZKd3c4U3lOS0JaQ0wwMDQxVWRCZWcv?=
 =?utf-8?B?bis5TFphb0JTa2N3ZHc4d2VvbURxNDNjQkhqYVRoeFdXdzBtNyt3cU8xTXg3?=
 =?utf-8?B?V1lNOWYxdUR4TmwvQzhFeUdRNGdKRmMzM2ZUVUdSSXpzZEhLR1hSVFBlSCtS?=
 =?utf-8?B?akg1R2Evd1crRWc0SjdLb1NDdnYyWXhxUmhzZk8rZTFXUTRGbGJOS2FDZ2ZK?=
 =?utf-8?B?RXZwSVZDTStad3p1dFc3SXJYcFdvZXBhRHJkdWRKVWU5Ty9SdTNDOXpBMzF1?=
 =?utf-8?B?VDhOa1dLc0hiY0hHVXB3d2Z5MEhjM1Q0LzRMWnR0Wk5JbVpPeEtlTkt2Wlgy?=
 =?utf-8?B?eEM1emUycmVSQzg1YUFCc1RmdXN4WWgyMHNpdjY1a1BpbWkyZkkyc0Zvcyt2?=
 =?utf-8?B?MG0rZGQ4NHlNbDNyMU5QRzJBbUdjaXNsVWlicHNvVm5MNU1Wam5PRFdaOHdK?=
 =?utf-8?Q?dJ2xTUcmA6newX0SZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E8BBA2A6731949A69B1FE924B77B32@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a61d800-3529-40d9-4679-08d903054acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:32:31.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4IyNMH68GBOyBv01aeIyvrYcgxxlNO4tXB5uwkyqbuE3oMQEGXoDC6WNdqwRiDA78QkCGbFta3ck7+gJDWbog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDggUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gU3F1YXNoZWQg
ZnJvbSBEb3VnbGFzIEFuZGVyc29uJ3Mgc3VnZ2VzdGVkIGNvbW1pdA0KPiAidXNiOiBkd2MyOiBH
ZXQgcmlkIG9mIHVzZWxlc3MgZXJyb3IgY2hlY2tzIGZvcg0KPiBoaWJlcm5hdGlvbi9wYXJ0aWFs
IHBvd2VyIGRvd24iDQo+IA0KPiAgIC0gQWZ0ZXIgdGhpcyBjb21taXQgdGhlcmUgc2hvdWxkIG5l
dmVyIGJlIGFueQ0KPiBjYXNlIHdoZXJlIGR3YzJfZW50ZXJfcGFydGlhbF9wb3dlcl9kb3duKCkg
YW5kDQo+IGR3YzJfZW50ZXJfaGliZXJuYXRpb24oKSBhcmUgY2FsbGVkIHdoZW4NCj4gJ3BhcmFt
cy5wb3dlcl9kb3duJyBpcyBub3QgY29ycmVjdC4gIEdldCByaWQgb2YNCj4gdGhlIHBpbGUgb2Yg
ZXJyb3IgY2hlY2tpbmcuDQo+IA0KPiAtIEFzIHBhcnQgb2YgdGhpcyBjbGVhbnVwIHNvbWUgb2Yg
dGhlIGVycm9yIG1lc3NhZ2VzDQo+IG5vdCB0byBoYXZlIF9fZnVuY19fIGluIHRoZW0uICBUaGF0
J3Mgbm90IG5lZWRlZA0KPiBmb3IgZGV2X2VycigpIGNhbGxzIHNpbmNlIHRoZXkgYWxyZWFkeSBo
YXZlIHRoZQ0KPiBkZXZpY2UgbmFtZSBhcyBwYXJ0IG9mIHRoZSBtZXNzYWdlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQXJ0dXIgUGV0cm9zeWFuIDxBcnRodXIuUGV0cm9zeWFuQHN5bm9wc3lzLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0u
b3JnPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5
bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gTm9uZQ0KPiAN
Cj4gICBkcml2ZXJzL3VzYi9kd2MyL2NvcmUuYyAgICAgIHwgIDMgLS0tDQo+ICAgZHJpdmVycy91
c2IvZHdjMi9jb3JlX2ludHIuYyB8IDE4ICsrKysrKystLS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5jDQo+
IGluZGV4IDU3NmMyNjJkYmE1NS4uNmY3MGFiOTU3N2I0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MyL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuYw0KPiBAQCAt
MzkxLDkgKzM5MSw2IEBAIHN0YXRpYyBib29sIGR3YzJfaWRkaWdfZmlsdGVyX2VuYWJsZWQoc3Ry
dWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgICAqLw0KPiAgIGludCBkd2MyX2VudGVyX2hpYmVy
bmF0aW9uKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgaW50IGlzX2hvc3QpDQo+ICAgew0KPiAt
CWlmIChoc290Zy0+cGFyYW1zLnBvd2VyX2Rvd24gIT0gRFdDMl9QT1dFUl9ET1dOX1BBUkFNX0hJ
QkVSTkFUSU9OKQ0KPiAtCQlyZXR1cm4gLUVOT1RTVVBQOw0KPiAtDQo+ICAgCWlmIChpc19ob3N0
KQ0KPiAgIAkJcmV0dXJuIGR3YzJfaG9zdF9lbnRlcl9oaWJlcm5hdGlvbihoc290Zyk7DQo+ICAg
CWVsc2UNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMgYi9kcml2
ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+IGluZGV4IDQ3MDQ1OGFjNjY0Yi4uYTVhYjAzODA4
ZGE2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmVfaW50ci5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMNCj4gQEAgLTUzNSwxMyArNTM1LDEwIEBAIHN0
YXRpYyB2b2lkIGR3YzJfaGFuZGxlX3VzYl9zdXNwZW5kX2ludHIoc3RydWN0IGR3YzJfaHNvdGcg
Kmhzb3RnKQ0KPiAgIAkJCXN3aXRjaCAoaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duKSB7DQo+ICAg
CQkJY2FzZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fUEFSVElBTDoNCj4gICAJCQkJcmV0ID0gZHdj
Ml9lbnRlcl9wYXJ0aWFsX3Bvd2VyX2Rvd24oaHNvdGcpOw0KPiAtCQkJCWlmIChyZXQpIHsNCj4g
LQkJCQkJaWYgKHJldCAhPSAtRU5PVFNVUFApDQo+IC0JCQkJCQlkZXZfZXJyKGhzb3RnLT5kZXYs
DQo+IC0JCQkJCQkJIiVzOiBlbnRlciBwYXJ0aWFsX3Bvd2VyX2Rvd24gZmFpbGVkXG4iLA0KPiAt
CQkJCQkJCV9fZnVuY19fKTsNCj4gLQkJCQkJZ290byBza2lwX3Bvd2VyX3NhdmluZzsNCj4gLQkJ
CQl9DQo+ICsJCQkJaWYgKHJldCkNCj4gKwkJCQkJZGV2X2Vycihoc290Zy0+ZGV2LA0KPiArCQkJ
CQkJImVudGVyIHBhcnRpYWxfcG93ZXJfZG93biBmYWlsZWRcbiIpOw0KPiArDQo+ICAgCQkJCXVk
ZWxheSgxMDApOw0KPiAgIA0KPiAgIAkJCQkvKiBBc2sgcGh5IHRvIGJlIHN1c3BlbmRlZCAqLw0K
PiBAQCAtNTUwLDEwICs1NDcsOSBAQCBzdGF0aWMgdm9pZCBkd2MyX2hhbmRsZV91c2Jfc3VzcGVu
ZF9pbnRyKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJCQkJYnJlYWs7DQo+ICAgCQkJ
Y2FzZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fSElCRVJOQVRJT046DQo+ICAgCQkJCXJldCA9IGR3
YzJfZW50ZXJfaGliZXJuYXRpb24oaHNvdGcsIDApOw0KPiAtCQkJCWlmIChyZXQgJiYgcmV0ICE9
IC1FTk9UU1VQUCkNCj4gKwkJCQlpZiAocmV0KQ0KPiAgIAkJCQkJZGV2X2Vycihoc290Zy0+ZGV2
LA0KPiAtCQkJCQkJIiVzOiBlbnRlciBoaWJlcm5hdGlvbiBmYWlsZWRcbiIsDQo+IC0JCQkJCQlf
X2Z1bmNfXyk7DQo+ICsJCQkJCQkiZW50ZXIgaGliZXJuYXRpb24gZmFpbGVkXG4iKTsNCj4gICAJ
CQkJYnJlYWs7DQo+ICAgCQkJY2FzZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fTk9ORToNCj4gICAJ
CQkJLyoNCj4gQEAgLTU2Miw3ICs1NTgsNyBAQCBzdGF0aWMgdm9pZCBkd2MyX2hhbmRsZV91c2Jf
c3VzcGVuZF9pbnRyKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJCQkJICovDQo+ICAg
CQkJCWR3YzJfZ2FkZ2V0X2VudGVyX2Nsb2NrX2dhdGluZyhoc290Zyk7DQo+ICAgCQkJfQ0KPiAt
c2tpcF9wb3dlcl9zYXZpbmc6DQo+ICsNCj4gICAJCQkvKg0KPiAgIAkJCSAqIENoYW5nZSB0byBM
MiAoc3VzcGVuZCkgc3RhdGUgYmVmb3JlIHJlbGVhc2luZw0KPiAgIAkJCSAqIHNwaW5sb2NrDQo+
IA0KDQo=
