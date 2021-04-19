Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC315363C81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhDSHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:31:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56132 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237778AbhDSHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:31:50 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A9929C063D;
        Mon, 19 Apr 2021 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817480; bh=+WpvodoZhAlFJhGzV4VXU2U7Q+510KubWmJ9Wr87mg4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PZRtdnb9uCu5fmqINBjSzBNEwfUC2YqLiE6lz97KdFz9O0aXgM/7L1oVhLr3NKMe1
         3HJbbollcMaIJ+0rO0KupdogP4PzXIT22uar4yiwgZFhv+DjBlwDl0VrZpPwJfZH2F
         wZ/OOe2HPrMP9bU1boOfJZawdb88tTpZpbYmltnAaXvhnMlHrGwUJiY2Oa9iIvAi+a
         hhORio0hD6y7CA9dhKVqfhHaTk3mn/mM7FmyieBDKgW+N+qiMQTkrQd3SimIJ8Na7I
         oOLpzrkd7TIL+sct0QiVFu9jU6k80lgKaO3cRiaRSYzgjx0BJwj9WO8aDbnHjD4LHg
         URSf8b4D6Ieww==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 49160A0069;
        Mon, 19 Apr 2021 07:31:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8298F40138;
        Mon, 19 Apr 2021 07:31:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dx5Cvqr+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI4nUnlOeo9yMA2Ja4W74dIOmxngL4lu6FaWokBxBK+Tn6FFOO4mKpoRg8jQVLhTZqMhmtSVKVZz/D9OCVWlqiHLSNok5c6Nd9Zmubka4KqkqAEb2Xu5DsXn3Nd4SnXMEMQXeLK+YWu46Kg5RirUhAf7LbLJQfYW8QH6xNJ0LWEDJ7Wjr0/P3+zRMzY4KUViOVOuZmZcK+h8dVRSypJl15k7fAI7lkkLMa5Dn1Zafw/eHeETh1NQopHc9epIsJkMFfE5nbIIV+hQ5Nf1lWVzh0tGalQQJsNhcY0sAyGQ1eLKBYkkKwgkHcSwIxm00H48/lcwu1PBUXS6oyZbjmHKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WpvodoZhAlFJhGzV4VXU2U7Q+510KubWmJ9Wr87mg4=;
 b=Z55VJ+DpfD+vHqOGWF8BCMY5FYt0CQC+f/Qr8OtAm7A10jl9q5rKVoDVbtOKWxJtbuNHc8/um7lg5QaS4Ghj963S+6eho5dj7ymLAkAjd7Gi6hM/OXDn7j2LLn1OzaBADt3nY+WPdADpX/OwnbJYorMRQzuWAsRY6jC/88fIMe4L/Htr1/1suEiIufnlUBnd0yvzbP6uK/THzyGrYNREkRvmvw7RAGVL51+izRC+tvaQ236erABks5vWYze5FBqA5UBHYNDREs/hx5PQP80F1R1Hp672Yk11GST9vqCDhnZwXRk0/o6SjNMT65CA/xJmofmPKkjIztLmHJ8Ob0VoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WpvodoZhAlFJhGzV4VXU2U7Q+510KubWmJ9Wr87mg4=;
 b=dx5Cvqr+QPGepEnPv08V+XLn7OJgrFK5zKz8YqeQjHczGfV8vF1iqIhixhWgv95Z6xSfNMU8W9pFxE80gNRi8AD6S9cqWh4zh03SzLYGWwREeabEWV8ype6F9lWtI7T4Y50P8v6NAx8JgwQKTdk7IWSCRPlM/ebq74yRNXU2s3k=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:31:17 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:31:17 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 09/15] usb: dwc2: Move exit hibernation to
 dwc2_port_resume() function
Thread-Topic: [PATCH v2 09/15] usb: dwc2: Move exit hibernation to
 dwc2_port_resume() function
Thread-Index: AQHXMr68FHxCwqFSqkaLvwMGLJHlE6q7dnkA
Date:   Mon, 19 Apr 2021 07:31:16 +0000
Message-ID: <362fe35b-92c9-59d6-011f-bfa53f9a555b@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124755.E47F3A005D@mailhost.synopsys.com>
In-Reply-To: <20210416124755.E47F3A005D@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: c126af49-719c-4f9a-d5b8-08d903051e71
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5000F1CADBCC05F98AF8C32EA7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJF0JdxBgsaQ58kM7XbTsSqrI2ELxjek9KZ9qzLEnCvgJG7OY1f2tCIwi1ajyKZKmY3EUDsFasX1EyThEWwxNYsVgOay81+fk8He4kQ9SHn2C0vQtDUpmOnuZYxaInZ8LbK8XB5EXNH3/H2BGmqBy+QV4sdJ0M1lDCwJjjX6KzGPDBsoKwa95l6QN845g8GFV3fRokFX1vuKi0gDvo0wUKZfP3nzjTa8wkVjDg2+Lu9MFtjO2dCgngu7VuaHR4yIKGmM7ZbHPvVLx72mS1XjPOA1zDMdT2bk9YcTJxdBVoWfbs+PQmhu9goaG4N4ooudA7rKyOZWBwAvLxdPhHgKmUM3v7daWNZaSUobRmfpBvju8ijlG7/g3zIoIvvgCt3OHL0CIWAYix564DNImA2tq4hLKaf7V02bd0DLg0iMEENoI4jWkYfBLtgtWF7G2pkx2RkTIlqy2z/7Q/Ibgr9szWds7ysXjHY6Xpc05VCm6ZZS77YdMf2WQ+oNnISsq/UumVauAs2+zg2S5dh/fS3nnFt6coMra28KJYnjVjIiEWF2ZRKynoQhdFUKGrXcJvRQhNYYXLJXJQ8t2yxrY/Lvi3R9gYjIVPtbhVOFC/AJX0GEik9MtAepdSrILd+KW0+2Tvmj4cuc3Lb01R4FUrdqTV3Iut3wUVczIQSi+HT0OwQB9gDhOblR3JVFk3YO2038
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Um9hYUtsRlA2cksvZlZVaDVvUW1XbjlFK3E3bmh0N25rV214TDhJVDFaRitq?=
 =?utf-8?B?eDJmZjk1NTVTRHJQWDlZd1ZYd2dBdFdPeUlEcDZKRFB5NkVoVGNxVzZLanp6?=
 =?utf-8?B?aEZUQmI1bGsrNm9XSEFKOWxMSzVTUUNtdzZmS0twUkhtNXJKV3BjQUR2S2tU?=
 =?utf-8?B?dGJiaVJZTno4cmt6b0hOak03ZlkvdGRkanRmQ20rZDJBM0VSZjVrS0hpTk5Q?=
 =?utf-8?B?TldPNHNzT3dNTnc5Q1ZXUU1mNkdkbVhoREU1NUljdmRXZzV4TWlUVW10VnJQ?=
 =?utf-8?B?WUtRMjlYdmJseVR1QjBpalZpWmU0bDk2Q043SW5Cejlhemc5K0lkMStZRkdj?=
 =?utf-8?B?eGk1KzJDQUJjeTZUdGJYT0dxcTFZanFnRE5IVVJXODZKSnVsbjErODBwT1l0?=
 =?utf-8?B?M0VvYjV0RnExaG01VGhIbEE4cE5qTXBubFRLUHJYWU9yZWhhekgxNFhNSHc0?=
 =?utf-8?B?ZXVabE92YzNmajNZZHNhUWRxY1RHVlgzZjN2M3JLZE5JUHBlbzVwNStFNmRN?=
 =?utf-8?B?YkxVRHVRWStFQXE3Y0tLcU1QeWtrR3lmdmVraGF1WERpdW5qODR1SUN5Qlpa?=
 =?utf-8?B?dFJmbGtYOWtnU2lZNVdMVXoxRkp1cnoycGRETThvVGhIcTZ5aTlWQkMrdC9p?=
 =?utf-8?B?cVpHSFQ4NENRMDNCbkpSKzhXNnlxRENXYlc0RUFUN1IvTUdlZXFkYVJPc0Y3?=
 =?utf-8?B?bi9zNlgrRkRKd3FMdkpQNGJiY3JpQS9hSjZqT2FUY3huODF5YytDYWZzVjlk?=
 =?utf-8?B?dDErL25VbmxXUFJxQVBpdXZGalJkUDYreVlBSVNGMi9TN1RPM2pIaWh6c0VH?=
 =?utf-8?B?b3FYaDhaeVBtTDhMUXVoTkRsUGh3TllobEVvNTJ1OE1NR3JwQmczTVlBSFdz?=
 =?utf-8?B?bkVIMXhydmxhL09PL0tDdHZaNmFQZUMxQjA4dzNkTmR6QlVXNjd2NFFpL1RV?=
 =?utf-8?B?aEs0eEdGbUJGNU5uWlpQUE5Ld2dIVXJuOWJ3OS9YQkQ4L1RaMC9pSkhGSXBO?=
 =?utf-8?B?SC9iV2YwWll5TlBWYXZJQjlNT2dkc2c2dXRiT2dQclhSTDRqSDJRRDc1cGxx?=
 =?utf-8?B?eDNFNjRkYWdkeHJZbUd1WjBvT2dTcDJodnhydm5SOUhaOVU0bTZ0ODhib1hj?=
 =?utf-8?B?djB1YUEreGJrWFB6NWdyV3lRazNMa0h5UWNOTVhaYklCaHpDd2FVclpSNUp1?=
 =?utf-8?B?OERQbEtLSWNsUWdhQ3dDVkRRZzRQNFo2MkU0M2JYSyt6RUhlUG9LREpnMzN2?=
 =?utf-8?B?emdrMklNYmhSV045aWlkSEdzOVhYSXZzaEJ2ZjNPamtMRFFTY0MwUXZTWDhG?=
 =?utf-8?B?OURSWHB2alFyc08yWm9iM1hpeWhKS3VQSnp0YjhOWFBmdzU2eVR2Y1BHa3k1?=
 =?utf-8?B?S0hNdTRoRFRvWXVoQ3M5eTF2eGpTN01qUlY3UStoY0tZbWpxTm5RbnNlZldT?=
 =?utf-8?B?VkVXUVlxYW1WeW1JZFE1N2N0SkxwSlVsdUF0YXhjbUJjL0JaMnFjVFFhSXJL?=
 =?utf-8?B?aS9IZGZ0eUEwekdUVGMxQ1BXM0F5R0tDMTJxR3JxVXBkdHFXRnh3d2laa3JU?=
 =?utf-8?B?eXNwQ0dLd2RVeisrUFpIeGRhb0tTNDBxNXBIZ1o2QlBsSlZlMnZoVVJ5MG4r?=
 =?utf-8?B?VEFuZEhCOWpRSUROb1k5QjgwU1F4aGxHNXZOQWxYOW1WOGRZRGFKT0k5QXVv?=
 =?utf-8?B?ZFdNSUFFc0tqRXlzUjl4dE1BQ0ZnV0x5Ui9uTEZ2TStkSXZGV1pnczhXMzV5?=
 =?utf-8?Q?4pOMQDJbEJRIhKrFew=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <419BBDA3753D194D93FC0B47FC6ECC2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c126af49-719c-4f9a-d5b8-08d903051e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:31:16.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYOw6oHAxzC87YdxqDDTpjBvLhjwG6jcKJrFYakb+N4wSDub1C178mgAzrFrpo8IOD9pWZh/UWNtmkpmTvL8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDcgUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gVGhpcyBtb3Zl
IGlzIGRvbmUgdG8gY2FsbCBoaWJlcm5hdGlvbiBleGl0IGhhbmRsZXIgaW4NCj4gImR3YzJfcG9y
dF9yZXN1bWUoKSIgZnVuY3Rpb24gd2hlbiBjb3JlIHJlY2VpdmVzIHBvcnQgcmVzdW1lLg0KPiBP
dGhlcndpc2UgaXQgY291bGQgYmUgY29uZnVzaW5nIHRvIGV4aXQgaGliZXJuYXRpb24gaW4NCj4g
ImR3YzJfaGNkX2h1Yl9jb250cm9sKCkiIGZ1bmN0aW9uIGJ1dCBvdGhlciBwb3dlciBzYXZpbmcg
bW9kZXMNCj4gaW4gImR3YzJfcG9ydF9yZXN1bWUoKSIgZnVuY3Rpb24uDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBcnR1ciBQZXRyb3N5YW4gPEFydGh1ci5QZXRyb3N5YW5Ac3lub3BzeXMuY29tPg0K
DQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lz
LmNvbT4NCg0KPiAtLS0NCj4gICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gTm9uZQ0KPiANCj4gICBk
cml2ZXJzL3VzYi9kd2MyL2hjZC5jIHwgMTMgKysrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gaW5kZXgg
NDNhMjI5OGI3ZDQyLi5jYzlhZDZjZjAyZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBAQCAtMzM4Myw2ICsz
MzgzLDExIEBAIGludCBkd2MyX3BvcnRfcmVzdW1lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykN
Cj4gICAJCQkJImV4aXQgcGFydGlhbF9wb3dlcl9kb3duIGZhaWxlZC5cbiIpOw0KPiAgIAkJYnJl
YWs7DQo+ICAgCWNhc2UgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX0hJQkVSTkFUSU9OOg0KPiArCQkv
KiBFeGl0IGhvc3QgaGliZXJuYXRpb24uICovDQo+ICsJCXJldCA9IGR3YzJfZXhpdF9oaWJlcm5h
dGlvbihoc290ZywgMCwgMCwgMSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlkZXZfZXJyKGhzb3Rn
LT5kZXYsICJleGl0IGhpYmVybmF0aW9uIGZhaWxlZC5cbiIpOw0KPiArCQlicmVhazsNCj4gICAJ
Y2FzZSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fTk9ORToNCj4gICAJCS8qDQo+ICAgCQkgKiBJZiBu
b3QgaGliZXJuYXRpb24gbm9yIHBhcnRpYWwgcG93ZXIgZG93biBhcmUgc3VwcG9ydGVkLA0KPiBA
QCAtMzQ0NiwxMiArMzQ1MSw4IEBAIHN0YXRpYyBpbnQgZHdjMl9oY2RfaHViX2NvbnRyb2woc3Ry
dWN0IGR3YzJfaHNvdGcgKmhzb3RnLCB1MTYgdHlwZXJlcSwNCj4gICAJCQlkZXZfZGJnKGhzb3Rn
LT5kZXYsDQo+ICAgCQkJCSJDbGVhclBvcnRGZWF0dXJlIFVTQl9QT1JUX0ZFQVRfU1VTUEVORFxu
Iik7DQo+ICAgDQo+IC0JCQlpZiAoaHNvdGctPmJ1c19zdXNwZW5kZWQpIHsNCj4gLQkJCQlpZiAo
aHNvdGctPmhpYmVybmF0ZWQpDQo+IC0JCQkJCWR3YzJfZXhpdF9oaWJlcm5hdGlvbihoc290Zywg
MCwgMCwgMSk7DQo+IC0JCQkJZWxzZQ0KPiAtCQkJCQlkd2MyX3BvcnRfcmVzdW1lKGhzb3RnKTsN
Cj4gLQkJCX0NCj4gKwkJCWlmIChoc290Zy0+YnVzX3N1c3BlbmRlZCkNCj4gKwkJCQlyZXR2YWwg
PSBkd2MyX3BvcnRfcmVzdW1lKGhzb3RnKTsNCj4gICAJCQlicmVhazsNCj4gICANCj4gICAJCWNh
c2UgVVNCX1BPUlRfRkVBVF9QT1dFUjoNCj4gDQoNCg==
