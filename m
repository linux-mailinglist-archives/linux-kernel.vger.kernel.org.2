Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5D349B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCYVAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:00:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43690 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230189AbhCYVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:00:31 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 14C4C403B7;
        Thu, 25 Mar 2021 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616706030; bh=/vu8MYrphFlsLW0q5BnoFAAH6b7uPOOXF/JhGeL/yCc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jPDgfx5dVtD+Z+mieq36ybfyiT+mUviZG/INZOQzfz+fQ6JvyIT+YpZY4lO0VLkg2
         dyvs8Zxk1A01AEh6zbr/5bN/EDgbABBamuOoKqlQoywdABmQOBPiuRBov7/PfUhcHc
         +wrzpchXoWfijuQWfzMbBF7pKLCZYYEZOTdytFiJ4cxBvi08QvRcKyMT5K74/vAe9r
         4kS9hCfHobdo4d483tpuxqMmBqA6WVEVrg1kluT1pdGTCtsi3hZAjEbKbAz+p9mkoS
         nIbjnQlOMQEm0OrZgcxhuXH1qgYx4VozK+NLwraauVy+QS7/1FInPOl+HwqFt570QA
         8rsMMYEqIMPBA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3BB34A007F;
        Thu, 25 Mar 2021 21:00:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D5716802BC;
        Thu, 25 Mar 2021 21:00:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="iZCpq4v9";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0HmUwDTyhCTL2S5Q7MZJurGkfMIrem4QbVkUFyATowpPjSGnryzqvPQnW/HsEQC2mo6gZl23nZr8hQmoRJYFnPC/aBrirUaXSMfC4fHCJeQiPuq84u+QzqBlDHEBCHWyxCLFO8M6lGWDR4QXavASE+w3lvei8rlXUX+/H+ev1zhmDJhHfWjhkSlVpZSyEN8wMgTuT/FJrK4KDA0qkrSyUmVTejLSWnP1ZlI6m1pmMwDWZXeVfdEAEzUVklcvbyYoAKs/PaUhB5GEjdAuEpDMavU/x4Tonph+WWTTEOROUOs56STSNzyuhCTdrqi5cwTf7Dtbs3qx7ZjgJgavCooiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vu8MYrphFlsLW0q5BnoFAAH6b7uPOOXF/JhGeL/yCc=;
 b=E6U2FOO/bj6fD9vR+u+MUUrYR+n66E9jeMJmvtYb/KQO5f33lyfacSNpUqZ2x95T74dwZUrci0zo4val9nCpc/SPg042SSw+O8PE1QxeBCsXt1Ye/wVCczGl/D4hI6klV4uVS+EJOLqoQGAg7TTMBKiHHpFVEOs6kM3pb+QTl1xPw3JCH9OpDH0M5JlOljN7xUOi5f6AE+LCM7Kueh+RzK/q4F/LAEOfElAivRw2A9a/rmhJuuFbDL/JbJ/gAKsi1uYRhmi3E0y9TiOKij8G0k1s4iFTnAxLw5cj1HuAweJfl+/OTKkqEpfoEu4rxnZLkZxO+BnFknnRkt7Ezd0CvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vu8MYrphFlsLW0q5BnoFAAH6b7uPOOXF/JhGeL/yCc=;
 b=iZCpq4v9HAHfbeCUuTRJ71fZ4g7I8M9z2gUDJRyKgQqvt1F9UhDWwWfpCIJjxxIlFWCqejqdkSOfUscQttDZFV8nLkECJDRgya87YpoZGO4NpGfBw6fUur141iWiVBuLz49pUb7i2SpqFwbtQKhqHIgbQ1zwDbcpl3oS9m9/SS4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 21:00:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 21:00:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>, Ray Chi <raychi@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "albertccwang@google.com" <albertccwang@google.com>
Subject: Re: [PATCH] usb: dwc3: add cancelled reason for dwc3 requests
Thread-Topic: [PATCH] usb: dwc3: add cancelled reason for dwc3 requests
Thread-Index: AQHXIW2nGqzRRQomD0uNMTRrx8NI/KqUoRgAgACPzgA=
Date:   Thu, 25 Mar 2021 21:00:27 +0000
Message-ID: <8ec7cdcc-e709-357a-b255-27018f3972f1@synopsys.com>
References: <20210325115436.861299-1-raychi@google.com>
 <87y2ebju7r.fsf@kernel.org>
In-Reply-To: <87y2ebju7r.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 531b668f-fc0c-4b89-b2e3-08d8efd1044d
x-ms-traffictypediagnostic: BY5PR12MB4260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4260190CF6BFCC401A605005AA629@BY5PR12MB4260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Son0aIxkxM75zOIb0i6DYZLDbBbRi3iWYDZOygcW31JNDVTYWxkkfSYBCenA6NYf+08ayI/qTTbRbxbWPp3aTzqu0gNSy9nMokC32ai1mkFgAgiqBPTI8LGfORrxgipki+IGc60Kauz5TWJNxFT9y51vTz1/TwLT1QfS0LH8q5SU3iFP/+srb9IZpG+vubd/MhhxdF7AWXcxvqriGc3yZeJ8wIdjxFEdAsdDBk1Bn+w2GNkg1A7uDse27cp5Yv3QBd/LrtvL7N1U9w2+T9PRRKHatyzpIH4e0d0Nd/DdfnUKdgSEnl5i8VHfFDfQecW8Sa325XgTtLHg2kZkVUADQexQV9LoyfXDm5dUYVQlbKZ6TGJiqFyaHoxFVZVk8azngau2crPngj7E1wxj5gemilO6qCe+X9HpR9w6Ix//ekCJ9c8awyV572WqybRnHMr5+Zi6hYXP6li9UcZG237sLmx1lak28Z/G75cbnFNx5GKmNR9kK53uiIQyUqnx5D+2lWxH5OoA6eC6uOAENP5IJpQFJCeJbYrcY2BfiAYRafi89372EWfEDaQBKeG/SUaqiP6QHQedsaas4Gx0X75v050evbTAVpxB+AHsOR1iWqtGrg0Wrrrxgzv3F8JcDnajUNrchxZZgFx0jYkSlOPOfbF08P5oCAnMnqUyxzhSGHKMxaWF0UaoDk4TWuqW1h1+0xP6eZmhfalILqVXe+X9hQpRWF3gxh5CYPDyqpeY9gSE9TA3h0AHA5B8tl0iSPTrqbhwWq2q2QjygrmtP1tBq2jBzOcWTIwjhORqontbVa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(36756003)(76116006)(64756008)(2616005)(38100700001)(31696002)(5660300002)(66946007)(31686004)(66476007)(66446008)(66556008)(86362001)(83380400001)(316002)(54906003)(2906002)(4326008)(8936002)(6486002)(6512007)(8676002)(966005)(26005)(71200400001)(186003)(110136005)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bnRNWXVhK090alJ3cmRVRlFRYlc0eVRtazc2Z3JnK1h5aU5ZUVVtcE5ZYnda?=
 =?utf-8?B?YVhUeCt2NVp6TjhWRGdhTUxIdHFQeTBPcGUzbFk5Uzh3dks5Q0hGTm4yVDdk?=
 =?utf-8?B?eEMvdVRNTWtYbDJmZEp4SVpwanZzN2IvZ0ZSdEcreDgwSTNiZEh5Mnl0Zzk5?=
 =?utf-8?B?RWVtTkJoQkFXcjVzbng5cDVaalRLZ2E5ZHNaZHZBYVlzKzNlSDBUMmUzeWFB?=
 =?utf-8?B?cHhzMWNHVXErUnMxT2xuUE94T0JSTTNSYnB4dTlPUi94Z0lwNFpBbmthSFhi?=
 =?utf-8?B?dGhQdVFLdkFiZVM3YjZwaFUvSyt6S1VybWNKRFJnVGpwZThmY2VlUzMwTkRL?=
 =?utf-8?B?SXh1OGRTaHJPVEozN3kxdXRRY2FtZUtOUDMvRGRtVnRycVB5Y1dibGZKd2pN?=
 =?utf-8?B?RVJCckRwQms1cVZETWNuOEpDc1J6WmxiSzhpdzZrelVDMzFqM2ZicUVHUU8z?=
 =?utf-8?B?ZWsyVFZDQkNvUVRHc1NpTU1PUWJvV1Zvam9Hc2VQeGNwRngwb00wM2pLYlNn?=
 =?utf-8?B?Qk1BM2F2Z0Nnd3ltUVZGZVRYM2FrVHhkNkY1OUhYNWJRdlNMMnZSeXg4MDZr?=
 =?utf-8?B?bFJDd1Erb3FWTnc2eXZMM2o0TUZuYVh5WUhLamdtckVmdlBTRUw4NnNUaUtr?=
 =?utf-8?B?MnF1cTFVN1NXV3Y3dmloQm9BYlEwRW9XMTZZN05DQkJHSGNmWjdYUTREcTFF?=
 =?utf-8?B?ZEg4K3VLNHNsRUE2aU5CeUlTcHR1cUpHK1FBdnF0Q1hCa1VxL015ZDdGUzdY?=
 =?utf-8?B?bFlFaVdmTzdUVDZ2ODJBc0RuWSt5eFpSQ3NvQnVyVnRWODIxdm45V29nOTF4?=
 =?utf-8?B?elBWa0U0cnFTU0xPU2J4NVM3UEZUcVBVdldZSUl4S0JBVzNxMTdNcDBTM1ow?=
 =?utf-8?B?b1pFa2tiMENrT1d2ZUdLQUZsV0ZnU2FmTTlseFRHeHlSTDhKU09qVXkxTXBZ?=
 =?utf-8?B?YWNlejZyaE80M0RiZUx1YWg3cUtOZjJVeUM4SUx2eW8zWTloR2dsWFU4WnFr?=
 =?utf-8?B?bGVqenBvalJ3dlFyV2diWUd4YStRYStXTDk4RzAyVkp1M2hMRGxRRitJaURa?=
 =?utf-8?B?M0dlTkp2VmVMNWo4MGtNRjFIVWpQMmRnWDJKMzRELzl5OEt0UGhkRi93MTlK?=
 =?utf-8?B?TEpyNGpkL3dWcDQzMTNwZU5GNWoyb2lVMWxsT2FsYXgwMDlCeUsreHdrS3Iy?=
 =?utf-8?B?WUx2dm1xdk5MTGpqTGpRUzVFSmRZMlE1c2VpNjZxbWJia3hDWjJNaTRObS9E?=
 =?utf-8?B?ZUFuL05Ld1ZXNHc1WDN6VVBmQmlkZWVaaERrNmV5bGs4VCtsS09xMmk0SzZB?=
 =?utf-8?B?dFlFcS81RDduUk5XWFI3SWszOVdVUnJOdm9nNUZKeGszNU5aRTgzVFVhd0lC?=
 =?utf-8?B?b0t4TXJkMzBxdFVvcGlrRFFWQ2hZa1JBRmhQSFFhOERjNmw2QUZraGdSU01y?=
 =?utf-8?B?MjNTUEFXdWVGUnVBU0Nma1RrOTFHa01CY2FLVVJUakFOTmhlMjg2OGpDTFlT?=
 =?utf-8?B?Q2FpdFI0dVpScW4vYVl2aUxhMkRienMxdFlXQVl0dGFxdkwvUUNiWkFXdTBp?=
 =?utf-8?B?VHgrZFNjeHV6WjhzMG81Vk94ZGlma1A3T2tmZ2hYMkFLWUhBNjdHRTgwdDBx?=
 =?utf-8?B?ajN2N3d0ZFlNUE15b1piMVZwaWo2MlFwL2FpUWpOd0JxdVFnUlI1d1MyMkhy?=
 =?utf-8?B?cFFPTEFmOC9VZDhuZk5nUkEwaC90N2ZyZGNaQk5iVGczMGx4OFZaeDFmZDZK?=
 =?utf-8?Q?JxcPb7Mm+WggnHaApc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB248F83186244B86A524F7A424CD41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531b668f-fc0c-4b89-b2e3-08d8efd1044d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 21:00:27.1070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zehwlQmBfPlcLGWqLzkDkX4mOBpLFHc8zJGG2rhp89EGocD7PWEQXEhTKQAui8fi/746iO/HX4alcx9MSg21nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiBIaSwNCj4gDQo+IFJheSBDaGkgPHJheWNoaUBnb29nbGUu
Y29tPiB3cml0ZXM6DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaCBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmgNCj4+IGluZGV4IDBjZDI4MTk0OTk3MC4uYTIzZTg1
YmQzOTMzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPj4gQEAgLTU2LDYgKzU2LDEyIEBAIHN0cnVj
dCBkd2MzOw0KPj4gIA0KPj4gIC8qIEZyYW1lL01pY3JvZnJhbWUgTnVtYmVyIE1hc2sgKi8NCj4+
ICAjZGVmaW5lIERXQzNfRlJOVU1CRVJfTUFTSwkJMHgzZmZmDQo+PiArDQo+PiArLyogQ2FuY2Vs
IHJlYXNvbiBmb3IgZHdjMyByZXF1ZXN0ICovDQo+PiArI2RlZmluZSBEV0MzX1JFUVVFU1RfREVR
VUVVRUQJCS1FQ09OTlJFU0VUICAvKiBSZXF1ZXN0IGdldCBkZXF1ZXVlZCAqLw0KPj4gKyNkZWZp
bmUgRFdDM19SRVFVRVNUX0RJU0NPTk5FQ1RFRAktRVNIVVRET1dOICAgLyogRGV2aWNlIGlzIGRp
c2Nvbm5lY3RlZC9kaXNhYmxlZCAqLw0KPj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQUxMCQkt
RVBJUEUgICAgICAgLyogQnVzIG9yIHByb3RvY29sIGVycm9yICovDQo+IA0KPiB0aGlzIGlzIGp1
c3Qgb2JmdXNjYXRpb24sIHBhc3MgdGhlIGVycm9ycyBkaXJlY3RseS4gQWxzbywgbWFrZSBzdXJl
DQo+IHRoZXNlIGFyZSBkb2N1bWVudGVkIGluIHRoZSBBUEkuDQo+IA0KDQpOb3RlOiB3ZSBkb24n
dCBoYXZlIGRvY3VtZW50YXRpb24gZm9yIGVycm9yIGNvZGVzIGZvciBnYWRnZXQgc2lkZSwgb25s
eQ0KaG9zdC4gVGhlc2UgYXJlIGp1c3QgdGhlIGVxdWl2YWxlbnQgZXJyb3IgY29kZXMgZnJvbSB0
aGUgaG9zdCBzaWRlLg0KDQpXaGF0IHdlIGN1cnJlbnRseSBoYXZlIGZvciBob3N0Og0KaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZHJpdmVyLWFwaS91c2IvZXJyb3ItY29k
ZXMuaHRtbA0KDQpNYXliZSBzb21lb25lIGNhbiB3b3JrIG9uIHRoYXQgaW4gYSBzZXBhcmF0ZSBw
YXRjaC4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
