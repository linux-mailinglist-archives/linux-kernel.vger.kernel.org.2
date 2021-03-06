Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6B32FE0A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 00:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCFXly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 18:41:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57886 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbhCFXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 18:41:36 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 538E740147;
        Sat,  6 Mar 2021 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1615074096; bh=OgOHc4xuDNxlFBnNo63rvAzfqdIf2QedCzu2sl0Qxg4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XPv6sWyFM0tAyKjUA7Lal5Z+BdkANGQFhaI0U6DCHcVcnRQgkmxvSQsAotps0sYhh
         NiSj8Sj5jg0TBdPJd8i8EcViHG7B89H1oOmyq0LDv7r0iNkjQw+httXnd7U5tGBNdq
         IxFz4usKCSiLnEgcepLEDsnYt9WX+xva++IwhOL+VzVe5tC1l8ZjatmkYL2VkgrBlN
         4hk9MneXBlAZmQ4Bt29Ee5B8fYHOcnEs1+xHobxIVF2zAiIx36he/MGPjxmrq3FSHl
         456WelJq2BOP7JYhwdwW4oCoLsbU0K2Y2NqddDhYNgb+ToYuBvoARn/GFxrF9+zDXG
         BXsiakuBtd7cA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6FF89A0082;
        Sat,  6 Mar 2021 23:41:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5DE1A800A8;
        Sat,  6 Mar 2021 23:41:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ANycw58n";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luzuGm8WIRaalS1YkjV2UJ64QjhPtFJxzB0U2RiwRApsgDpkymkXDhAW8gABZbaTkzlmmpmL6QO1ssMSMhTtNLNrIpouvvov5DT96RTlMsVE9LipCHvaFX8/Yx4zOnvFp0dNGaaX3me1S+Yb6tY9u3P6Gb+cfS61QUTQ5homBZjVyrFgvPdhaUfJwr9NlpDxYzt0DDvPtwbx5/Y5mfrNTOEVkcB96sjM1I6N3Wo9S5Y64CzvTRPnrxpmhIxC5ImeqlgnhDC/cAA8L2MsGZmE8PTZkLd9WMlwnzQCfph2tkicQJ9tEd+xii1/NnhjEDfF2sLMMmXF7mALwuFA10X2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgOHc4xuDNxlFBnNo63rvAzfqdIf2QedCzu2sl0Qxg4=;
 b=RVbfEbxm2rVRcP6dJ4ikKbsPfQfKfQSMjdb0xqqWRLx8DngMJUhUaIoXC8E/805ON4FFyRvWbl+qCBAj9Hpcdn7qZ3oiWVr94h+FQDIF3BzkkooZC6LF0oTSDg8q1Px2+UBAd4TDTEJ7FPko2MmtllCxtOw8FTiBQvJt3Qogr9mX4xdVwSiqjygJqTYVwKwVepWnYXA+JsrtIcXnIbO9hwbojdXHGO0MS3QIVwEfqyoOs7JreolR9Xrl3BktmHJd6fJltyZPU7IkhxTqNJU9mFbpqF2oenF/QdWdMzEpnWcp8kbzo398KI6+LAlNg9+9nPCTUJp9gb9hZAfiIaLIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgOHc4xuDNxlFBnNo63rvAzfqdIf2QedCzu2sl0Qxg4=;
 b=ANycw58n8uh184fJdAi7IEWoX1BbHCn6061LOkZvid033sjIs7YGleDk6gQdwQQynQ+ZptScPh8UDKcFo+PZiPSSqQIzSNC88dFjMYSkTUMMwSIyP21JZI9vd2KEDi8GULLEd/kAgccJh7f6TZJo7g6KyWajqye4QjRMzK+sW0Y=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Sat, 6 Mar
 2021 23:41:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 23:41:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
Thread-Topic: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
Thread-Index: AQHW5WDHaQXdezZAr06Yos1UmLp1A6odqBQAgABzRQCAAFsegIBYjhOAgAD1JgA=
Date:   Sat, 6 Mar 2021 23:41:27 +0000
Message-ID: <a33f7c33-f95d-60c3-70f2-4b37fcf8bac5@synopsys.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <87bldzwr6x.fsf@kernel.org>
 <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
 <d95d0971-624e-a0e6-ac72-6ee3b1fb1106@synopsys.com>
 <06a44245-4f2f-69ba-fe46-b88a19f585c2@codeaurora.org>
In-Reply-To: <06a44245-4f2f-69ba-fe46-b88a19f585c2@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb7de46d-10e2-471e-b989-08d8e0f95c59
x-ms-traffictypediagnostic: BYAPR12MB4711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB47116C9905A0D124BE686FDFAA959@BYAPR12MB4711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZplpkrwyKT9HRDDnsWrQEt6Rx8Hzy4rVVzecsjpGisN38lQZkckE6rY08ezcjQGKBhqRBcb8f6VYAyKCQDhnzbzPtB9PwIOZOIe2UI2uq4Q+HvCZ8gOCA4yHrQ38WCyItVN43Uc0eQnETzBoHwNg1rX0AXF5rCsjwQgL+cMEJAtrMQZqhJzuycHvjuvGTMqZ1wPhGrSJxze2dI0hrCGIEyHm4DDacMbGGEfiqvYk0Kg1adxGEXC2GnbUV3UkK8a8WN74T/DOgbB/lSb7j/3g+TR7vLpjrya6oJ4ICoUwEjvZMW5+IEiNNNqhza71MCAhWPiSbb7rjdILs+v85jePuVJ7f1WJWlA89wpuNdKdAr1bCzXRF/xQ3cN4J7eH6zs12Xq9Cyz0Oft3o+ND36sTbggtyNFmPfyckYYFl2vqZ4A/qYnCCcOe0A1Pm4THeskYnSnptGbhObWK9iG17CodACdWxqkPGC9v1wz8l84omTfmPiIuNMj6YGpIVujeT4PZvtMvkobsNpChAfAo46o/SmayFZ6oF51r1kgrxaYtrFPKCzNJx91SwuyUcTultMHVs6fZk6B2XXSYTJeBjaYPOty3XbYcIm5Cb47jbXB44suLrEiVMMbyNF6/sEB6+Dc7554Roo9mZuFjlOFwQob5RTii+agNT30KumX8AFEizpj6Vmg5ePgE7/lkHOwFKW0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(136003)(396003)(376002)(8676002)(86362001)(2616005)(316002)(66556008)(8936002)(6512007)(66446008)(966005)(31686004)(83380400001)(66476007)(64756008)(5660300002)(36756003)(478600001)(6506007)(53546011)(2906002)(66946007)(76116006)(31696002)(186003)(7416002)(54906003)(6486002)(26005)(4326008)(71200400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WFRoNEJqbHpuS2ZTMFJONndFbXVtb0k1L0REa0NBM1BTZWQvKzFOOHhYekpU?=
 =?utf-8?B?TTkvVTBzYTQ3bWE5aW8xUnVQcEVpa0o4RXViankveml4eDgxZ3ovUmU0d2JU?=
 =?utf-8?B?Y3JlTVdMSUVlMHBVWlhscUNPWFV6QlNaSW9WTHBRUHJ6ZXNBTy9sYjVtbnBm?=
 =?utf-8?B?RUZVZmRDeU9renZSZmlydmEwMmdWTUpCTnQ0S0VBaG9tbkM3Mi9pV3NVSGhV?=
 =?utf-8?B?bGRNaCt0bkhNM1M0a1E0TDBGZC9DbUZaR2Z2d3JPZGpWNkp6N2U2VzczaXFi?=
 =?utf-8?B?SWk4dXI5dXNUZy9qTjI2d1JheVZKRllRbHo1YXpaQ25YcGhSdWFiTy9UUnR0?=
 =?utf-8?B?amZNajI5cGtaWmlNTzFvbnNCa2VvYStsQkFCY2xZMlY5RzgvUm9JY0diZHZv?=
 =?utf-8?B?TE81dnZZcFU4a0o0SUpGK1RPajkzaGdPeFJUZU5ocnBvZ3NMTFZxRXNoUGpO?=
 =?utf-8?B?NzJxV1kxWUVsZ2hqK05XbjBFTFhVemJYYkc0S2kySHNvRTNWemlhNGQvejBM?=
 =?utf-8?B?NFFLUnpqWG9TKzRkbmtoSWV6NDQzczZxbEZDN25hN1VhVzhhVkdVaDRXMWp1?=
 =?utf-8?B?OUJKZHgydGZOZEYzODJXQXRFSjE0bVFoa2h2UUxYQ0FoYzNEQitiZ2ZrK2hh?=
 =?utf-8?B?U0JjL3gxd2JiNFBjWGs3RU54R2Fnb3AvSlBqZ2V6Rjh2Q3ZHY21RWUx0L2dV?=
 =?utf-8?B?OHJkL2VwTU1HeHJDVGhweUN4eURuWi90S3EyRFhTSnpyWUJDSndiZ1FDMlEz?=
 =?utf-8?B?U3Z5anIyVVBjZmpoOUtVb1dDNXR4ZEpLdTNwYzRiU1d3YjB2b21RZUJVSjVJ?=
 =?utf-8?B?TUhxV2dTai9vODZ5S1o0elFXaU95UEdHR1pJcUhDQmN3b1hiUTNUc2dtdkZP?=
 =?utf-8?B?bzRRYWdVaHZKWVhxbjhrQko0dElWYjNabGpwbUZ4VHUzWWl4c1drb083bVRs?=
 =?utf-8?B?RFVJTkFIc1dXb3ArZzhyWW9uam5hdDN4Wk1MakdyYUNkbUZBZWo3dDY1K1Bt?=
 =?utf-8?B?L2J4YlYzL2RWQkhnVHJ3c29teG5TT01VWUlDZkN2ZFgzM1dGc0lWdGp5Nkp5?=
 =?utf-8?B?c0ZtUDNmN0RGWE1GRVZhUTZyRVVvQWE1WW51SGJJWktuQlczS0ZkT1JRUGdZ?=
 =?utf-8?B?bTQyc0Z0MURaQjdncWR1RGU1dHFNTklKZnQ0QlZpeFNjaElFS1BTSFF2bjdj?=
 =?utf-8?B?RzA4RmcvM0lkUmZXV29QcUZnbE5iUitDdE9UREhReW1sVmR0T3hjWHQ5MEE4?=
 =?utf-8?B?Wm1sbHJLbXJXZ3BYWldhWHFlT1hNSWpIVmlNSHV2MTlDckVnSEVjR0dGVElK?=
 =?utf-8?B?VGNiYzZhbG5nS25laWFGR0dXVEVDL3RpTXdlVmJBcmVYRTNnNUF0emVhUmU2?=
 =?utf-8?B?UkJaQ2hHTUNnWWRPZUlZdmNxOWxVK0RyaHg2V0k0aU93UWw4bHNEMTU1Nk9w?=
 =?utf-8?B?aUNyV2s5eFdQNW9kd1ZmOWs0VytBaEpCMnA5dmVhVHNSc0lGbkZyVXI0ZHZR?=
 =?utf-8?B?NmdvVzJnSWF2QjErR0VDdWFnMnVZTnZPay9jZ2phd25ucUowV3dnZDZvd0lL?=
 =?utf-8?B?NXRCR1ZYSVVDdjZZTmRBLzRreVc4WURqVENRK04xV1JnYTh3Y016dWt0TXZy?=
 =?utf-8?B?MVpvejgyOWJiaTRMUDJjZHFDYWxEMjVXRUZrcTNJUzArTkxBUXNiYjJNMTZ1?=
 =?utf-8?B?eWl0SW5EMWVtSEM0Ui9hSVZmU2s5Ym1MdSs0Um8wNWZueXNrTjgrQmRWSDBU?=
 =?utf-8?Q?BloqciooRrDE3eaatU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA5BD0CAC4B1204E85371F2C45C81C45@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7de46d-10e2-471e-b989-08d8e0f95c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 23:41:27.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKPhZ1dJTjTGyqXM50kzkE2LQ+mhgOd1jd2zVPX5guQP8rB5M+hTFhMAAyY6rumPWcP5x28jmJ3rcMdOna6xdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPg0KPiBPbiAxLzgvMjAyMSA0OjQ0IFBNLCBUaGluaCBOZ3V5
ZW4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBKb2huIFN0dWx0eiB3cm90ZToNCj4+PiBPbiBGcmks
IEphbiA4LCAyMDIxIGF0IDQ6MjYgQU0gRmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPiB3
cm90ZToNCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5h
cm8ub3JnPiB3cml0ZXM6DQo+Pj4+PiBGcm9tOiBZdSBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29t
Pg0KPj4+Pj4NCj4+Pj4+IEp1c3QgcmVzZW5kaW5nIHRoaXMsIGFzIGRpc2N1c3Npb24gZGllZCBv
dXQgYSBiaXQgYW5kIEknbSBub3QNCj4+Pj4+IHN1cmUgaG93IHRvIG1ha2UgZnVydGhlciBwcm9n
cmVzcy4gU2VlIGhlcmUgZm9yIGRlYnVnIGRhdGEgdGhhdA0KPj4+Pj4gd2FzIHJlcXVlc3RlZCBs
YXN0IHRpbWUgYXJvdW5kOg0KPj4+Pj4gICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUxBcXhMWGRuYVVmSkt4MGFOOXhXd3RmV1ZqTVdp
Z1BweTJhcXNOajU2eXZuYlU4MGdAbWFpbC5nbWFpbC5jb20vX187ISFBNEYyUjlHX3BnIUxOenVw
ckFlZy1PODBTZ29sWWtJa1c0LW5lLU0teUxXQ0RVWTlNeWdBSXJRQzM5OFo2Z1JKOXduc25scWQz
dyQgDQo+Pj4+Pg0KPj4+Pj4gV2l0aCB0aGUgY3VycmVudCBkd2MzIGNvZGUgb24gdGhlIEhpS2V5
OTYwIHdlIG9mdGVuIHNlZSB0aGUNCj4+Pj4+IENPUkVJRExFIGZsYWcgZ2V0IHN0dWNrIG9mZiBp
biBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KCksIHdoaWNoDQo+Pj4+PiBzZWVtcyB0byBwcmV2ZW50IHRo
ZSByZXNldCBpcnEgYW5kIGNhdXNlcyB0aGUgVVNCIGdhZGdldCB0bw0KPj4+Pj4gZmFpbCB0byBp
bml0aWFsaXplLg0KPj4+Pj4NCj4+Pj4+IFdlIGhhZCBzZWVuIG9jY2FzaW9uYWwgaW5pdGlhbGl6
YXRpb24gZmFpbHVyZXMgd2l0aCBvbGRlcg0KPj4+Pj4ga2VybmVscyBidXQgd2l0aCByZWNlbnQg
NS54IGVyYSBrZXJuZWxzIGl0IHNlZW1lZCB0byBiZSBiZWNvbWluZw0KPj4+Pj4gbXVjaCBtb3Jl
IGNvbW1vbiwgc28gSSBkdWcgYmFjayB0aHJvdWdoIHNvbWUgb2xkZXIgdHJlZXMgYW5kDQo+Pj4+
PiByZWFsaXplZCBJIGRyb3BwZWQgdGhpcyBxdWlyayBmcm9tIFl1IENoZW4gZHVyaW5nIHVwc3Ry
ZWFtaW5nDQo+Pj4+PiBhcyBJIGNvdWxkbid0IHByb3ZpZGUgYSBwcm9wZXIgcmF0aW9uYWwgZm9y
IGl0IGFuZCBpdCBkaWRuJ3QNCj4+Pj4+IHNlZW0gdG8gYmUgbmVjZXNzYXJ5LiBJIG5vdyByZWFs
aXplIEkgd2FzIHdyb25nLg0KPj4+Pj4NCj4+Pj4+IEFmdGVyIHJlc3VibWl0dGluZyB0aGUgcXVp
cmssIFRoaW5oIE5ndXllbiBwb2ludGVkIG91dCB0aGF0IGl0DQo+Pj4+PiBzaG91bGRuJ3QgYmUg
YSBxdWlyayBhdCBhbGwgYW5kIGl0IGlzIGFjdHVhbGx5IG1lbnRpb25lZCBpbiB0aGUNCj4+Pj4+
IHByb2dyYW1taW5nIGd1aWRlIHRoYXQgaXQgc2hvdWxkIGJlIGRvbmUgd2hlbiBzd2l0Y2hpbmcg
bW9kZXMNCj4+Pj4+IGluIERSRC4NCj4+Pj4+DQo+Pj4+PiBTbywgdG8gYXZvaWQgdGhlc2UgIUNP
UkVJRExFIGxvY2t1cHMgc2VlbiBvbiBIaUtleTk2MCwgdGhpcw0KPj4+Pj4gcGF0Y2ggaXNzdWVz
IEdDVEwgc29mdCByZXNldCB3aGVuIHN3aXRjaGluZyBtb2RlcyBpZiB0aGUNCj4+Pj4+IGNvbnRy
b2xsZXIgaXMgaW4gRFJEIG1vZGUuDQo+Pj4+Pg0KPj4+Pj4gQ2M6IEZlbGlwZSBCYWxiaSA8YmFs
YmlAa2VybmVsLm9yZz4NCj4+Pj4+IENjOiBUZWphcyBKb2dsZWthciA8dGVqYXMuam9nbGVrYXJA
c3lub3BzeXMuY29tPg0KPj4+Pj4gQ2M6IFlhbmcgRmVpIDxmZWkueWFuZ0BpbnRlbC5jb20+DQo+
Pj4+PiBDYzogWW9uZ1FpbiBMaXUgPHlvbmdxaW4ubGl1QGxpbmFyby5vcmc+DQo+Pj4+PiBDYzog
QW5kcnplaiBQaWV0cmFzaWV3aWN6IDxhbmRyemVqLnBAY29sbGFib3JhLmNvbT4NCj4+Pj4+IENj
OiBUaGluaCBOZ3V5ZW4gPHRoaW5obkBzeW5vcHN5cy5jb20+DQo+Pj4+PiBDYzogSnVuIExpIDxs
aWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPj4+Pj4gQ2M6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8
bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4NCj4+Pj4+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPj4+Pj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtl
cm5lbC5vcmcNCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5j
b20+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJv
Lm9yZz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gdjI6DQo+Pj4+PiAqIFJld29yayB0byBhbHdheXMgY2Fs
bCB0aGUgR0NUTCBzb2Z0IHJlc2V0IGluIERSRCBtb2RlLA0KPj4+Pj4gICByYXRoZXIgdGhlbiB1
c2luZyBhIHF1aXJrIGFzIHN1Z2dlc3RlZCBieSBUaGluaCBOZ3V5ZW4NCj4+Pj4+DQo+Pj4+PiB2
MzoNCj4+Pj4+ICogTW92ZSBHQ1RMIHNvZnQgcmVzZXQgdW5kZXIgdGhlIHNwaW5sb2NrIGFzIHN1
Z2dlc3RlZCBieQ0KPj4+Pj4gICBUaGluaCBOZ3V5ZW4NCj4+Pj4gQmVjYXVzZSB0aGlzIGlzIHN1
Y2ggYW4gaW52YXNpdmUgY2hhbmdlLCBJIHdvdWxkIHByZWZlciB0aGF0IHdlIGdldA0KPj4+PiBU
ZXN0ZWQtQnkgdGFncyBmcm9tIGEgZ29vZCBmcmFjdGlvbiBvZiB0aGUgdXNlcnMgYmVmb3JlIGFw
cGx5aW5nIHRoZXNlDQo+Pj4+IHR3byBjaGFuZ2VzLg0KPj4+IEknbSBoYXBweSB0byByZWFjaCBv
dXQgdG8gZm9sa3MgdG8gdHJ5IHRvIGdldCB0aGF0LiBUaG91Z2ggSSdtDQo+Pj4gd29uZGVyaW5n
IGlmIGl0IHdvdWxkIGJlIGJldHRlciB0byBwdXQgaXQgYmVoaW5kIGEgZHRzIHF1aXJrIGZsYWcs
IGFzDQo+Pj4gb3JpZ2luYWxseSBwcm9wb3NlZD8NCj4+PiAgICBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMTAyMTE4MTgwMy43OTY1
MC0xLWpvaG4uc3R1bHR6QGxpbmFyby5vcmcvX187ISFBNEYyUjlHX3BnIUxOenVwckFlZy1PODBT
Z29sWWtJa1c0LW5lLU0teUxXQ0RVWTlNeWdBSXJRQzM5OFo2Z1JKOXduUldJVFpmYyQgDQo+Pj4N
Cj4+PiBUaGF0IHdheSBmb2xrcyBjYW4gZW5hYmxlIGl0IGZvciBkZXZpY2VzIGFzIHRoZXkgbmVl
ZD8NCj4+Pg0KPj4+IEFnYWluLCBJJ20gbm90IHRyeWluZyB0byBmb3JjZSB0aGlzIGluIGFzLWlz
LCBqdXN0IG1vc3RseSBzZW5kaW5nIGl0DQo+Pj4gb3V0IGFnYWluIGZvciBkaXNjdXNzaW9uIHRv
IHVuZGVyc3RhbmQgd2hhdCBvdGhlciBhcHByb2FjaCBtaWdodCB3b3JrLg0KPj4+DQo+Pj4gdGhh
bmtzDQo+Pj4gLWpvaG4NCj4+IEEgcXVpcmsgd291bGQgaW1wbHkgc29tZXRoaW5nIGlzIGJyb2tl
bi9kaXZlcmdlZCBmcm9tIHRoZSBkZXNpZ24gcmlnaHQ/DQo+PiBCdXQgaXQncyBub3QgdGhlIGNh
c2UgaGVyZSwgYW5kIGF0IGxlYXN0IHRoaXMgaXMgbmVlZGVkIGZvciBIaUtleTk2MC4NCj4+IEFs
c28sIEkgdGhpbmsgUm9iIHdpbGwgYmUgb2sgd2l0aCBub3QgYWRkaW5nIDEgbW9yZSBxdWlyayB0
byB0aGUgZHdjMw0KPj4gZGV2aWNldHJlZS4gOikNCj4+DQo+PiBCUiwNCj4+IFRoaW5oDQo+Pg0K
PiBIaSBBbGwsDQo+DQo+IFNvcnJ5IGZvciBqdW1waW5nIGluLCBidXQgSSBjaGVja2VkIHRoZSBT
TlBTIHYxLjkwYSBkYXRhYm9vaywgYW5kIHRoYXQNCj4gc2VlbWVkIHRvIHJlbW92ZSB0aGUgcmVx
dWlyZW1lbnQgZm9yIHRoZSBHQ1RMLnNvZnRyZXNldCBiZWZvcmUgd3JpdGluZw0KPiB0byBQUlRD
QVBESVIuICBTaG91bGQgd2UgY29uc2lkZXIgYWRkaW5nIGEgY29udHJvbGxlciB2ZXJzaW9uL0lQ
IGNoZWNrPw0KPg0KDQpIaSBXZXNsZXksDQoNCkZyb20gd2hhdCBJIHNlZSBpbiB0aGUgdjEuOTBh
IGRhdGFib29rIGFuZCBvdGhlcnMsIHRoZSBmbG93IHJlbWFpbnMgdGhlDQpzYW1lLiBJIG5lZWQg
dG8gY2hlY2sgaW50ZXJuYWxseSwgYnV0IEknbSBub3QgYXdhcmUgb2YgdGhlIGNoYW5nZS4NCg0K
QlIsDQpUaGluaA0KDQo=
