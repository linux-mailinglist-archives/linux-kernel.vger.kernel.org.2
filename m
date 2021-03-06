Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B680632FE08
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCFXjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 18:39:31 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57830 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhCFXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 18:39:08 -0500
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 97A9B400B2;
        Sat,  6 Mar 2021 23:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1615073948; bh=ZeQ/RM376WD0XJgo+c9uNDAJk2aipK5irjTIavOCXNA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cOSL8390YtEePU6I+h8GJn0IjQkqFJiwZUoMjnQGO2/1i3TPUjdKoXillu7ipoX/K
         5uot1zNdRwbSaLS+CQXId0tGRuIimuOV/kDzYvgyEjFwmJ8q99eUpOCzpq+hBP/cSt
         dVG7L26jR1D5Cn7W8PZ+SRbz/kEC8vm8la6kYnDtcyCXyCNrasTHM6nvkdJoOMiuTF
         0eVfc5KHHa8c/klm2ysA2WAKMKggrzdcacoxYAzKKeoishwVQxpTB5GyZKocne0m62
         EMW24rF2kjNdAz4BQdH+dBQKbiscFTCMqB726fsT0roFqIutq/AwD/zm8qREJbp1Dz
         he3vLkWGGHg1w==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 367D9A00AF;
        Sat,  6 Mar 2021 23:39:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0B1C74009B;
        Sat,  6 Mar 2021 23:39:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oIqFofXu";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur5M+0hPoLDjwlPUazlLGPkb7a4wYoZ7QzAHEpiXc5omIDKIsULtTVjkFLe4cl1eSY4mKR/q8PMsTiI2Y6NCTRfMwShwec46KUrUFuPK5gFF7VYAQFkQalg8zn83LBsJGarwr3Xswj878fZxv6FjI/Sl1MlyxBM8nHBo1SwRop5NQQaTOPZ+YPt/wymdglc6PQAYQl9S5zN2oE3j1YyjEIbI4rLIS+Qcei59AdytrYd0mMsGfjvciFDr4ieEQjE7kufX4o3zAN6fEHLllnBlTrJ1Qn7xOjfHnBhWfv0Q2BwFcWU5i0/OhggSX68W/XolJAnjMFRUbSEmJB1gQH8wBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeQ/RM376WD0XJgo+c9uNDAJk2aipK5irjTIavOCXNA=;
 b=bpdu0vT5CwGcn380JtCagesKBQgOHOeodGpopo+7/ocDZrYqUMQQUfbAOTkpI+kzN+O1CUcuPvCJDGgYHPNNPKjz2h6zNv1Cnn7ZxVly6MqztnlpcljiaHXuEZOMg0ie4QPJvGmiRckAcBkSwEBHdAKvaq6eYMZnrkhGSqv18Q78YfNNy12qIHdrZaNBLJQw0FNodYGE6/b2FYRpq0+zUgTtmE4lQ9X2oCsv2JaUDnNfTbnmdTehXxYFoSJP9/UKOJkwBqKLWj8rT2RA28fkx/S0iebIRlLfqhszDbT9xcbiZTHKlegTjG3PD7W22Ao5/PK4NftyP5ZEnEKF47I0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeQ/RM376WD0XJgo+c9uNDAJk2aipK5irjTIavOCXNA=;
 b=oIqFofXuxZ+skhGGeQgoIIkC5hLwvpGfTic0cHNsKzNjghvXFY9S0vmA3Rn58eh6rTPJb4uSYPxlK1mB8BnfXJbdCJFPtFp9fTYKgK3GXEcSX++98GWIHM2sUyBs32Fs60oJliQb0pYpc40kmldKzHrdh1jnBXU/AaziPNYy23A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Sat, 6 Mar
 2021 23:39:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 23:39:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following
 programming guide
Thread-Topic: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following
 programming guide
Thread-Index: AQHW5WDIwx81PtjZwki8YDgRRTr5BKp3A20AgAD1lQA=
Date:   Sat, 6 Mar 2021 23:39:01 +0000
Message-ID: <e696b018-b310-5811-5c80-3c50dde297e7@synopsys.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <20210108015115.27920-2-john.stultz@linaro.org>
 <eb4b8540-a57c-53cc-a371-cf68178bec15@codeaurora.org>
In-Reply-To: <eb4b8540-a57c-53cc-a371-cf68178bec15@codeaurora.org>
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
x-ms-office365-filtering-correlation-id: decc588c-fa24-4035-2383-08d8e0f90549
x-ms-traffictypediagnostic: BYAPR12MB4711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB47117685F9F90F6A4949BD19AA959@BYAPR12MB4711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dnR+2VF2g7pQC6JPp7DpTW3G0lLDueMh44d57tW7F5wb1UH21tOssCKMq6zo4JVe7Zc9n6utRtbwniCWssaBFxOczDJOabzpePrgiuwIKNBOaT9eVHJjV9irCEygIfKc70/Dod9Fvg771cFT9vScKsnYag1FZ8J84rfV/+oIS/VIxxDKJuxtbw0T+HKkzuTQTKOInO+MHcT9ax16OXwKKNML8BQ9VyGx2RIia4clOctC7GhL+8/inqX69AbAZDDJRayiModWDuiFz6lMZVFrDibijRfvc0CGLtdB04lgfLTftoaaFe0hndGBxHrxz6uATT/NtaFo2ChjWCKVMurAovL+XHPRJRZfXGMPeLMjzI5/4swqWmX7+jUNmaE7/q8oGDnD60GB++Px3hU/kNCeGDJIp6vUT8fTcPNMaK1bAoJcd2NtYGAUaGhcXYtY3sUcE/FttPnUVnDoBaeTkrUkA/dmo0KwrflWNkEP2K2R3vJI+tjEAaA6tRyyYcUJjo4Hzm9RDJvv7nQophedM5nYPx04vNlNB3q1VRvXuaQFipKuDk24JsuYrAKygRHGHYepiSevW3TkwMCIOYGTnDSxYq6p6mAB6ZXeMxhZZF6apfE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(136003)(396003)(376002)(8676002)(86362001)(2616005)(316002)(66556008)(8936002)(6512007)(66446008)(31686004)(83380400001)(66476007)(64756008)(5660300002)(36756003)(478600001)(6506007)(53546011)(2906002)(66946007)(76116006)(31696002)(186003)(7416002)(54906003)(6486002)(26005)(4326008)(71200400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NzEweHU4K3diWDZOb0M2THkrNFZ4S1B0OXo3OE9WWEQwbjBlS2NCY1lRQitJ?=
 =?utf-8?B?ay9WdjkwMVpKQmtoby82d3A1NysrdmFxMnhhUzVWc29lOU9EWkNkQ0NwMmVN?=
 =?utf-8?B?d1ZITUF1N2h5N0lPWi83bk1xU2hLYkgvREFaUHFKZlhwZm41WEhwL25wcGlN?=
 =?utf-8?B?ekI1UUZDWjR1a2VwWnllN2JxaFlpbHZRUi8zNFhkQzg5Z3oxejNYUDh2SktS?=
 =?utf-8?B?MmhHQmpmZEN0bUt4b2ZEZHBVd2o5QTNCSXM1UDZKNERCQUdSQldQRW1teGky?=
 =?utf-8?B?c3l2OHNVWm1ZUS83aW00NDZ2MUk2aGhzTlpHT3hGdUt2aXBkUjRneE1SS29D?=
 =?utf-8?B?QzFuVkM0VTJwZks3SkMwUWdPVmFoTzNtL2Q0aHZmQ2JyK0RHdFl0UWVxbEdz?=
 =?utf-8?B?RXNZTkI1SERPbzNYZVdDOTBjYlVGL2lyQmlNVkQvd0dJUXNYMjkrRzNxVzlN?=
 =?utf-8?B?eEx4Vm9MaHROZzFTOXlETU0wRytCbC9Gbk5RaUNYN0dXbUh3VUtoN3NKMFM5?=
 =?utf-8?B?eUpIcWtTL2hRWWthUG1MUFZTRTd4MVRXSUgyNi9zWnlOKy8vU0wrc0NiTXRJ?=
 =?utf-8?B?QXpoYkw4RktKWWhwUEM0eWNUQWVJTi9jY2xPQlQrMVdCdmVhQ05QWVB5OEN2?=
 =?utf-8?B?L1ZiWVU2NmR4eDlnZSsxWWZYZTJYYVc1QWF0dmVnU29nMUhWK1JyamlwaENa?=
 =?utf-8?B?RDkySnd1cW10Z2N2YnZIbE1yeDVtWjBtTExuLzRlUHVzRVBRYW9uanBqS0Nm?=
 =?utf-8?B?V0Y4WjVYbGVZL20zWGpEa2F4WlplVmdUSmxVZEs2WmtOQzJGVU9KWTdwdWVC?=
 =?utf-8?B?aEZGSmo2NFRidTN4a0NyL1lCaktoTWwzbGpvTkZzaHNxRk53MDBERkhHTU11?=
 =?utf-8?B?L1JLWmhxVDVaWFluMEE1Yk5Xd2tZK3BRY0RIdm0xd09JZVlzNHZJR1o2TWNi?=
 =?utf-8?B?aDRQWmRob0U2NGRhQXJFdXpGcm5CMHNwbWRFUkVWaU44N3NFNW9FRlRkbGpX?=
 =?utf-8?B?cENmRUgreVFtUWh4TGlTZlBpaVcrMmRoVzV1ZkZBN1VsZXJIeVYwMVVVd3Nj?=
 =?utf-8?B?dmc5Y3BKc2pZTjJRVWV4M00xdmk3bkVVN2dYSTJ0N1gxdkltdnJ3Ky9pZjRN?=
 =?utf-8?B?UHlxcHhtdHNROEZxaEpQb0FPdm9BOUo2b2Q5YXpPaDZOb2pZVVUwR2VzbjR2?=
 =?utf-8?B?WStsenBvMHQyZVg5Z2pOSldZdTdHbjlFOVNRTjN2ZnZ3NnVuZTZFMnpqSktT?=
 =?utf-8?B?WmJXQkJ1ZW4xNmNRc2NqRnJMZTBQbjNzdlpLS3drVVNsMVhiaGZBRzl4MWtK?=
 =?utf-8?B?N3ZPUFduQnFnVFNUVytqdi9GUVgxbk85c1cyV1JjeGxUcTRHeDIvb3VqTWQ0?=
 =?utf-8?B?bkM1WS9Hb2drRDNPNGx0YU1kbTh1b0ZxQ0FmSnloN0g3a01lQ29ZbC9RV2xT?=
 =?utf-8?B?YU1OZUZtc3pCd0twUUFRODExRldUTDRpWHplbUszK0gwWGVzOGo5U0doRDNz?=
 =?utf-8?B?Kzl2OWJqWGpnM0Mvcis4dlU1UmlkZnpVZjU4Q0FKenc2cHZuTkw3dVU3bnVQ?=
 =?utf-8?B?KzNaM3JUMFNVbkZtQzlvNnp3aUpHVmVhVVJ2ZWs3Q0VTSGNZZ0NvYjBWQnVC?=
 =?utf-8?B?ZFhMc2Z4WTJtRlVQS283LzVxbjVGSDgrNS9PckJzVUwxb1Nyek1NeDNTc0F1?=
 =?utf-8?B?UmVMbDVqU0tKcEVFNWNRSlk0ZDdzQ1R1Qzl3dzlvRFYyNlRybmZ3Y1F3WmVJ?=
 =?utf-8?Q?/V0vm/SJIZZtXrgjhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17D841CAD3AB4E45B91BAC2A12D5D24D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decc588c-fa24-4035-2383-08d8e0f90549
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 23:39:01.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cistnDaIcVNFpg0BFUA8hgoRq7apSfEn8OLEHXrw9KaulFsIxH+jrsGDOh6V7XcNcWDrPfUBmP89Gj98r68eRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPg0KPiBPbiAxLzcvMjAyMSA1OjUxIFBNLCBKb2huIFN0dWx0
eiB3cm90ZToNCj4+IEluIHJldmlld2luZyB0aGUgcHJldmlvdXMgcGF0Y2gsIFRoaW5oIE5ndXll
biBwb2ludGVkIG91dCB0aGF0DQo+PiB0aGUgRFJEIG1vZGUgY2hhbmdlIHNlcXVlbmNlIHNob3Vs
ZCBiZSBsaWtlIHRoZSBmb2xsb3dpbmcgd2hlbg0KPj4gc3dpdGNoaW5nIGZyb20gaG9zdCAtPiBk
ZXZpY2UgYWNjb3JkaW5nIHRvIHRoZSBwcm9ncmFtbWluZyBndWlkZQ0KPj4gKGZvciBhbGwgRFJE
IElQcyk6DQo+PiAxLiBSZXNldCBjb250cm9sbGVyIHdpdGggR0NUTC5Db3JlU29mdFJlc2V0DQo+
PiAyLiBTZXQgR0NUTC5QcnRDYXBEaXIoZGV2aWNlKQ0KPj4gMy4gU29mdCByZXNldCB3aXRoIERD
VEwuQ1NmdFJzdA0KPj4gNC4gVGhlbiBmb2xsb3cgdXAgd2l0aCB0aGUgaW5pdGlhbGl6aW5nIHJl
Z2lzdGVycyBzZXF1ZW5jZQ0KPj4NCj4+IFRoZSBjdXJyZW50IGNvZGUgZG9lczoNCj4+IGEuIFNv
ZnQgcmVzZXQgd2l0aCBEQ1RMLkNTZnRSc3Qgb24gZHJpdmVyIHByb2JlDQo+PiBiLiBSZXNldCBj
b250cm9sbGVyIHdpdGggR0NUTC5Db3JlU29mdFJlc2V0IChhZGRlZCBpbiBwcmV2aW91cw0KPj4g
ICAgcGF0Y2gpDQo+PiBjLiBTZXQgR0NUTC5QcnRDYXBEaXIoZGV2aWNlKQ0KPj4gZC4gPCBtaXNz
aW5nIERDVEwuQ1NmdFJzdCA+DQo+PiBlLiBUaGVuIGZvbGxvdyB1cCB3aXRoIGluaXRpYWxpemlu
ZyByZWdpc3RlcnMgc2VxdWVuY2UNCj4+DQo+PiBTbyB0aGlzIHBhdGNoIGFkZHMgdGhlIERDVEwu
Q1NmdFJzdCBzb2Z0IHJlc2V0IHRoYXQgd2FzIGN1cnJlbnRseQ0KPj4gbWlzc2luZyBmcm9tIHRo
ZSBkd2MzIG1vZGUgc3dpdGNoaW5nLg0KPj4NCj4+IENjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtl
cm5lbC5vcmc+DQo+PiBDYzogVGVqYXMgSm9nbGVrYXIgPHRlamFzLmpvZ2xla2FyQHN5bm9wc3lz
LmNvbT4NCj4+IENjOiBZYW5nIEZlaSA8ZmVpLnlhbmdAaW50ZWwuY29tPg0KPj4gQ2M6IFlvbmdR
aW4gTGl1IDx5b25ncWluLmxpdUBsaW5hcm8ub3JnPg0KPj4gQ2M6IEFuZHJ6ZWogUGlldHJhc2ll
d2ljeiA8YW5kcnplai5wQGNvbGxhYm9yYS5jb20+DQo+PiBDYzogVGhpbmggTmd1eWVuIDx0aGlu
aG5Ac3lub3BzeXMuY29tPg0KPj4gQ2M6IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4N
Cj4+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+
DQo+PiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4N
Cj4+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hu
IFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gRmVlZGJhY2sgd291
bGQgYmUgYXBwcmVjaWF0ZWQuIEknbSBhIGxpdHRsZSB3b3JyaWVkIEkgc2hvdWxkIGJlDQo+PiBj
b25kaXRpb25hbGl6aW5nIHRoZSBEQ1RMLkNTZnRSc3Qgb24gRFJEIG1vZGUgY29udHJvbGxlcnMs
IGJ1dA0KPj4gSSdtIHJlYWxseSBub3Qgc3VyZSB3aGF0IHRoZSByaWdodCB0aGluZyB0byBkbyBp
cyBmb3Igbm9uLURSRA0KPj4gbW9kZSBjb250cm9sbGVycy4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIHwgMyArKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4+IGluZGV4IGI2YTZiOTBlYjJkNS4uNzFmOGIwN2VjYjk5IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+PiBAQCAtNDAsNiArNDAsOCBAQA0KPj4gIA0KPj4gICNkZWZpbmUg
RFdDM19ERUZBVUxUX0FVVE9TVVNQRU5EX0RFTEFZCTUwMDAgLyogbXMgKi8NCj4+ICANCj4+ICtz
dGF0aWMgaW50IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KHN0cnVjdCBkd2MzICpkd2MpOw0KPj4gKw0K
Pj4gIC8qKg0KPj4gICAqIGR3YzNfZ2V0X2RyX21vZGUgLSBWYWxpZGF0ZXMgYW5kIHNldHMgZHJf
bW9kZQ0KPj4gICAqIEBkd2M6IHBvaW50ZXIgdG8gb3VyIGNvbnRleHQgc3RydWN0dXJlDQo+PiBA
QCAtMTc3LDYgKzE3OSw3IEBAIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+PiAgDQo+PiAgCWR3YzNfc2V0X3BydGNhcChkd2MsIGR3Yy0+ZGVz
aXJlZF9kcl9yb2xlKTsNCj4+ICANCj4+ICsJZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4g
SGkgSm9obi9UaGluaC9GZWxpcGUsDQo+DQo+IEkgYWN0dWFsbHkgYWRkZWQgdGhpcyBjaGFuZ2Ug
aW50byBteSBsb2NhbCBicmFuY2gsIGJlY2F1c2Ugd2Ugd2VyZQ0KPiBzZWVpbmcgYW4gaXNzdWUg
d2hlbiBzd2l0Y2hpbmcgZnJvbSBob3N0IG1vZGUgLS0+IHBlcmlwaGVyYWwgbW9kZS4gIFdoYXQN
Cj4gd2FzIGhhcHBlbmluZyB3YXMgdGhhdCB0aGUgUlhGSUZPIHJlZ2lzdGVyIGRpZCBub3QgdXBk
YXRlIGJhY2sgdG8gdGhlDQo+IGV4cGVjdGVkIHZhbHVlIGZvciBwZXJpcGhlcmFsIG1vZGUgYnkg
dGhlIHRpbWUNCj4gZHdjM19nYWRnZXRfaW5pdF9vdXRfZW5kcG9pbnQoKSB3YXMgZXhlY3V0ZWQu
ICBXaXRoIHRoZSBsb2dpYyB0bw0KPiBjYWxjdWxhdGUgdGhlIEVQIG1heCBwYWNrZXQgbGltaXQg
YmFzZWQgb24gUlhGSUZPIHJlZywgdGhpcyBjYXVzZWQgYWxsDQo+IEVQcyB0byBiZSBzZXQgd2l0
aCBhbiBFUCBtYXggbGltaXQgb2YgMC4NCj4NCj4gV2l0aCB0aGlzIGNoYW5nZSwgaXQgc2VlbWVk
IHRvIGhlbHAgd2l0aCB0aGUgYWJvdmUgaXNzdWUuICBIb3dldmVyLCBjYW4NCj4gd2UgY29uc2lk
ZXIgbW92aW5nIHRoZSBjb3JlIHNvZnQgcmVzZXQgb3V0c2lkZSB0aGUgc3BpbmxvY2s/ICBBdCBs
ZWFzdA0KPiB3aXRoIG91ciBQSFkgaW5pdCByb3V0aW5lcywgd2UgaGF2ZSBzb21lIG1zbGVlcCgp
IGNhbGxzIGZvciB3YWl0aW5nIGZvcg0KPiB0aGUgUEhZcyB0byBiZSByZWFkeSwgd2hpY2ggd2ls
bCBlbmQgdXAgYXMgYSBzbGVlcGluZyB3aGlsZSBhdG9taWMgYnVnLg0KPiAobm90IHN1cmUgaWYg
UEhZIGluaXQgaXMgcmVxdWlyZWQgdG8gYmUgY2FsbGVkIGluIGF0b21pYyBjb250ZXh0KQ0KPg0K
PiBUaGFua3MNCj4gV2VzbGV5IENoZW5nDQoNCkhpIFdlc2xleSwNCg0KVGhhbmtzIGZvciBsZXR0
aW5nIHVzIGtub3cgdGhlIGlzc3VlIHlvdSdyZSBoYXZpbmcgYWxzby4NCg0KWWVzLCB5b3UgbmVl
ZCB0byB3YWl0IGEgY2VydGFpbiBhbW91bnQgb2YgdGltZSB0byBzeW5jaHJvbml6ZSB3aXRoIHRo
ZQ0KUEhZIChhdCBsZWFzdCA1MG1zIGZvciBkd2NfdXNiMzIgYW5kIGR3Y191c2IzMSB2MS44MGEg
YW5kIGFib3ZlLCBhbmQNCmxlc3MgZm9yIG9sZGVyIHZlcnNpb25zKS4gV2hlbiByZW1vdmluZyB0
aGUgc3BpbmxvY2sgdG8gdXNlIG1zbGVlcCgpLA0KanVzdCBtYWtlIHN1cmUgdGhhdCB0aGVyZSdz
IG5vIHJhY2UgaXNzdWUuIEJUVywgaG93IGxvbmcgZG9lcyB5b3VyIHNldHVwDQpuZWVkIHRvIG1z
bGVlcCgpPw0KDQpBcyB3ZSBzdWdnZXN0ZWQgYW5kIGV4cGxhaW5lZCBiZWZvcmUsIHRoaXMgY2hh
bmdlIGlzIHJlcXVpcmVkIGFzIHBhcnQgb2YNCnRoZSBwcm9ncmFtbWluZyBndWlkZS4gSXQgc2hv
dWxkIGJlIGFkZGVkIHRvIHRoZSBkcml2ZXIuIEl0J3Mgbm90IGEgcXVpcmsuDQoNCkJSLA0KVGhp
bmgNCg==
