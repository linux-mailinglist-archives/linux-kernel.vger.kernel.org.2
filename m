Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893043E8431
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhHJUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:17:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:32808 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232731AbhHJUR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:17:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F380BC0F3C;
        Tue, 10 Aug 2021 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628626625; bh=ms/L7cZXARhcpeV201i39BxTuKloJJV6RklcxH6szsM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=A0/Ti40YUOZYoxEol3IP3GNiBAFeEZTQczcsFUEkCd5LtxalTbkOImTxwYEdHAQpK
         JWdkYxfVrZV0BT4VSbwR+80dGWv5FlqBR6nSX+aOpTcJaB9WcpktUfd5VUlm2npz1i
         FYZerAARnUi2Ckw5m3KH4jZlaovOZX0dxn3gYMkvVC92wVMVydP7PvR5Ha6QQrus47
         m4vxrCesUw8rYzmd4JqfRAT4cJf3CYievcMbygnGnQ8ycF9rDiT1Kmd41acHSrPzu6
         h7unqgTNslUNPBicpdbeUaXFYIBoaZg6lVYIGEn+VlEfyWEojLpXVssrqZsHOjkDW0
         wCroEPvPVHNDw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E76F6A005C;
        Tue, 10 Aug 2021 20:17:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E64D6800C0;
        Tue, 10 Aug 2021 20:17:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ipR+7pgz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI0qqiOOwG7ImoviO4bDP7BSmP5FsVwioeQvPqMYO1E6JwYFPXZqVqVfy02EGtF1s06PEnl2EknVDF+RjDFsXR/TcC9iEcU+8BHvccziwyTvUytOr6uTlBp0IHIs1zjPug5V5RzzX5AkjjwkqGRWyOcxf4rkBnN/29u5FsVkJpLl9TIkKcRMR6zdy0qwsYQ6mPUejqUxYqM5HWztJYar8LohU41nvBbwk7GgvGBX8yUXUflC8cJIW+/C8It0EEkJ8Nx5SxEkMY7dE4iesrDxzlsT96Ra3pzY09lsVvLRDIM8foGwfeKSW/Vq12aJh2WvZ8HvaVLFF33lKwO54aUTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms/L7cZXARhcpeV201i39BxTuKloJJV6RklcxH6szsM=;
 b=bMo5fkICN7ZxD31FN8vMOuzPrlV8r49RyZKXNl3ceaUnmTy6istaNZbHhNX8Q+6kBipoGVZjJqIK96iXmp7ARffONAWr4meNGhyu3IaXRvo9vdnLFRPPfc1nZY3WrUR0h7lTORBNU/pJLytb1oEj1pa7YH/AJc2Be/f7FYDM+eTjm3zAozNLxCTdpmWShrepHH/McENYI1NxZ+DImcy58oZDYaQnQ00sRf5EsqUZNTxcjmXl2IrHJf3uHdH2xoNNmiJl5kl1oQeMDVg4SVlCxRTf+n3VZNxyjEKJ8mpnA46/yAstrQDVe4q+l04izNIDK5jWcOGVOAArwoXhin+jKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms/L7cZXARhcpeV201i39BxTuKloJJV6RklcxH6szsM=;
 b=ipR+7pgz2TMIMztgjS9TNe6nTUZr+PEy5vaOciOiNgDlPGMyZ8IrPepkx8OHzTUEq1Ec5choLddNHtnMyPzIxk18NVzKw2ts6PfyDWdvsUg0UhzHyaMZpqUHTLSlzKLdlLJEM0LS+Au97uzhj6AhhO7Xsj8M5sTHXZEss/PuXBw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Tue, 10 Aug
 2021 20:17:00 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 20:17:00 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Petri Gynther <pgynther@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Topic: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Index: AQHXjW5ko6qYUR8aokekS5eRbPy7oKtrxUWAgAACvICAAAD6AIABMcaAgAAy+YCAAADCAA==
Date:   Tue, 10 Aug 2021 20:17:00 +0000
Message-ID: <915337ae-07d4-6a19-ec98-a8b88c5d9743@synopsys.com>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
 <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
 <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
 <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
 <b025412f-c27a-a59b-cd8f-aec0faa98928@codeaurora.org>
 <a2139dcd-2512-2138-66b4-311056d92afa@synopsys.com>
In-Reply-To: <a2139dcd-2512-2138-66b4-311056d92afa@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da493d68-7294-446f-fd41-08d95c3bcfc1
x-ms-traffictypediagnostic: BY5PR12MB4067:
x-microsoft-antispam-prvs: <BY5PR12MB4067D4F328DC3571E705DEADAAF79@BY5PR12MB4067.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rv//qOyPZTY7viztIrMoMCExAjPe3MNGDCHntgiXXi+5ce8RNxxf1Bb8DYxr9UvTXsdKAVe7tXBeitISj+6SnYDO9YSdOL/G9uvMxBurdJ/YrA9lM2zO6djvg4cV0SRNc6lNQw1BjuhbFV8IXjU/nhhSpDW7LKlM3LulKbjDMOHMnph0OlOw6Tj2KSIidIU6InmOqmkUBvS2hd+EMXxBtYuYQpfy8qWEtJO8fdFGcTCHdBUc8kimmG/eUFOruESZ2s2/Kk0pNiqZwt0uer4M7P1E8+XZ9WywkTKvB7+oy/ijTTGGhtAAJRMBcmk5DrFfAkdUmMU/1nMBv74wiTIVmMEwy/hu0Ym8KTb3C77iXtrS9ctUcOJ1G9Ftydpv7k5xfAdwSMtjABjoRa6qnc8HrBYT+a4EYqnOGhvQKHBhqgozyK/z41lk6uEgdpfr/XgXxORiDJmEpxVkILFPQReIY65Xj4roPxvcCW0MC6vyFs0Y5LXbgNwjA8xEqdfuxqINFx0VvZjRS5ly4rX6ofH6gJFpRIgXw9YKqDiNqPMAwixuSOwYMhzpRTfVfrnIxhdYmXZFHoMMAps824mdncmyf5kPN0hC3EVhPZm9qS14t20V2yVu6IwZ2aNfJmVWgufjaEATWmrVKrs+yLYBnpS/lRwKfv7qjeLiGSpmcV8dZ8xHmPQl9WayClgPVglq3+JjGaf6kWLo8f4njvXx6Lyo63UXdFEjrtQk9IEZK29HDxQVvmM0pXS4cwWxIzIHglYxn6Sg0JCHM+QEaJz7u+Yc+teOx4TtWKfc3HNP52dyElNlDZ5TNXYZQVeaFNLG8henXrmkLWSeTQIOfXb4kDwCV7Mw6eDfhAZAFaoCkUtfOFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(39860400002)(346002)(6506007)(36756003)(26005)(53546011)(31686004)(7416002)(186003)(83380400001)(31696002)(2906002)(86362001)(66946007)(316002)(54906003)(64756008)(76116006)(6486002)(5660300002)(66556008)(66476007)(66446008)(478600001)(38100700002)(6512007)(71200400001)(110136005)(8936002)(38070700005)(2616005)(4326008)(122000001)(8676002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3o0UHNWMTZUVjBJZno2OThpUmg3NHova0NjSEhVQmphUGphMEFYbmlicXFB?=
 =?utf-8?B?di82OWRxVXRNaHNjeVZYRUdwNExLOHUzRU9GZm0vQ3FJM1Z1QTVHckFrVm9G?=
 =?utf-8?B?aW0xb2V0RnpmUmEvR3BHdDJMdndTaHVuQjl1TUQ5cUJwNVpnZWZuODVRcUlw?=
 =?utf-8?B?ZGRoQUFPZEFrMkRPc3Y0SG4yWnZPUDhMc0w1Y0UyQWQ4bnUwYUpFcjd4c2Nn?=
 =?utf-8?B?WVRpdUJ3TlB3b2d2cmxkd0NBWTZqRE5zdzhwTnErN3MxU2NMRGZTWmZDRFpD?=
 =?utf-8?B?MkdFUUFIakl0VG1OYmw2V3pZRUFTdkZKUDBMcjRaRXZMQnFNd2dYRVBxN3o1?=
 =?utf-8?B?WHdMdEVzSXRZYkNsNTdhVkZZNkJrd0k4WjZyMmpwVG9NaFp3eGo3Z0MzTkVP?=
 =?utf-8?B?cFJQWmFtYytuRWxTS0ZScW9JUE80VlZZaUdrckdaSG5NWUtQZTQ5REgrVkRQ?=
 =?utf-8?B?cWcxSDFOOWVKYUpwbVNvVEZZRHUzMVhZVmppeWdwazZkckZMSEhqYlVEaita?=
 =?utf-8?B?Wkd4S0VKdkMza2ZJWkR0ZG11NjNYcmx3RG5sTmxKWTgxWThyMVNYbVNWazly?=
 =?utf-8?B?SXc4a3crc1hvWlNkeUJrTUVZdFBMV0hKMG1jamcyWCtXNUxOK3VYMGRmL21V?=
 =?utf-8?B?UVBwaDFtUFkza241UXowZENSenhNeDNhaVRJViszaW5CK0xDb0tLMW01SU5K?=
 =?utf-8?B?R2U0RTliY095WWQ1aTlsdi9ISHVTVit6TmRUVFdVeWJKTVMzL3ZuVFpwc2tw?=
 =?utf-8?B?STh0RkVkU1BEZ1dST3k1YkVPUWNiQi91ZE90OXZiWk5wd2FKSzc3WVpveWht?=
 =?utf-8?B?aGVSWFMwMTRYMWdHZjFFWkd4VmFZd1B1OFFEQVZibUs2amNSTFdKR081eVVR?=
 =?utf-8?B?bG5JYXpSRGM0MFd5S3BBVzlFWlF0d1V2enE4eTRWWERNKytMQVNTekRrUmdR?=
 =?utf-8?B?S0lTd1JxWGRSYUxydThsZ1p3MzRxVVBGdzZtcDJITUs4K3YxUlFad0dod3Fw?=
 =?utf-8?B?QUNiaHR2OERwRHRoNyt3dkQxWHJDQlR4N1dKcDN5TnRIc0xGM1BnWmwwM0cr?=
 =?utf-8?B?aGQwR2xXRndZaGZ5dXo1aUY5Z0hZWkg0aDN2OTdxbGZwNm5oWU5VRkUyWndH?=
 =?utf-8?B?WkNaNjlTSE9kZUZjRU05OGYvalYzeHVCTkthYWVtL21mY0dJZ29rYVpPbEo4?=
 =?utf-8?B?SW90ZGgwRE5ZTHFZUzdsa3ppUHY3SEtjVENQZUZlNGpib0U2NnNNS3FCY3gv?=
 =?utf-8?B?eWFUNnhoTHFJSkpvODUwZHlMZzZyN1hRcG1uUEtia29sN1AzSEkwRHlqczNL?=
 =?utf-8?B?bkRnaUdDa0NHWHBmOE1wWmkzd0hnZ1dWYm56RXFwY28wQk4ybjhIM1YzU1JM?=
 =?utf-8?B?NWx1cjQ1U0g5VHppeTJaUGFIUWZaNUtRVndTYmM4VGZRS0NrYldWbHpSUWN5?=
 =?utf-8?B?dGl2V1d3bjg1UThwRHM4L0l5SlEyVElxc1oxdWkrMDk3M3hNbUx5UXdsYVZY?=
 =?utf-8?B?aSs3enoreXAxLzI4RzN4VkswbnI0clFYNS83ZERDQ2VjT0NnQk1xZk81dnJR?=
 =?utf-8?B?bnYxTFRVQnZrS2FqTXczMkZac1F6YVlkcmdodEVHQmxaWGppL1A4d1dSc2JD?=
 =?utf-8?B?SkVRelIyemNkME9XTGZ6VlJ1THNYZ0NITThwK1lXTEZ0Q0FSY0RMbkcwSVJB?=
 =?utf-8?B?emRsalh6YUtQeUM1RkkwVlkrV3ROR2ZVdzVkWEt2em5MSUlZUFk1RGlYeE1T?=
 =?utf-8?Q?pMjprO63hsOxAC0t0A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB204F07F8D37F43A8E8A3EC69385CED@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da493d68-7294-446f-fd41-08d95c3bcfc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 20:17:00.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF6CF54Nu6e8lrxoNREYjGEunk7cp2t1TW/3OcUJuM1zHDJrkzswVRLMsCANMncHmXdsOg0p9e7Cwzk5FtEDLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+PiBIaSBUaGluaCwN
Cj4+DQo+PiBPbiA4LzkvMjAyMSAzOjU3IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4gSm9o
biBTdHVsdHogd3JvdGU6DQo+Pj4+IE9uIE1vbiwgQXVnIDksIDIwMjEgYXQgMzo0NCBQTSBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+
IEpvaG4gU3R1bHR6IHdyb3RlOg0KPj4+Pj4+IEluIGNvbW1pdCBkMjVkODUwNjFiZDggKCJ1c2I6
IGR3YzM6IGdhZGdldDogVXNlDQo+Pj4+Pj4gbGlzdF9yZXBsYWNlX2luaXQoKSBiZWZvcmUgdHJh
dmVyc2luZyBsaXN0cyIpLCBhIGxvY2FsIGxpc3RfaGVhZA0KPj4+Pj4+IHdhcyBpbnRyb2R1Y2Vk
IHRvIHByb2Nlc3MgdGhlIHN0YXJ0ZWRfbGlzdCBpdGVtcyB0byBhdm9pZCByYWNlcy4NCj4+Pj4+
Pg0KPj4+Pj4+IEhvd2V2ZXIsIGluIGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3Jl
cXVlc3RzKCkgaWYNCj4+Pj4+PiBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1
ZXN0KCkgZmFpbHMsIHdlIGJyZWFrIGVhcmx5LA0KPj4+Pj4+IGNhdXNpbmcgdGhlIGl0ZW1zIG9u
IHRoZSBsb2NhbCBsaXN0X2hlYWQgdG8gYmUgbG9zdC4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgaXNz
dWUgc2hvd2VkIHVwIGFzIHByb2JsZW1zIG9uIHRoZSBkYjg0NWMvUkIzIGJvYXJkLCB3aGVyZQ0K
Pj4+Pj4+IGFkYiBjb25uZXRpb25zIHdvdWxkIGZhaWwsIHNob3dpbmcgdGhlIGRldmljZSBhcyAi
b2ZmbGluZSIuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIHBhdGNoIHRyaWVzIHRvIGZpeCB0aGUgaXNz
dWUgYnkgaWYgd2UgYXJlIHJldHVybmluZyBlYXJseQ0KPj4+Pj4+IHdlIHNwbGljZSBpbiB0aGUg
bG9jYWwgbGlzdCBoZWFkIGJhY2sgaW50byB0aGUgc3RhcnRlZF9saXN0DQo+Pj4+Pj4gYW5kIHJl
dHVybiAoYXZvaWRpbmcgYW4gaW5maW5pdGUgbG9vcCwgYXMgdGhlIHN0YXJ0ZWRfbGlzdCBpcw0K
Pj4+Pj4+IG5vdyBub24tbnVsbCkuDQo+Pj4+Pj4NCj4+Pj4+PiBOb3Qgc3VyZSBpZiB0aGlzIGlz
IGZ1bGx5IGNvcnJlY3QsIGJ1dCBzZWVtcyB0byB3b3JrIGZvciBtZSBzbyBJDQo+Pj4+Pj4gd2Fu
dGVkIHRvIHNoYXJlIGZvciBmZWVkYmFjay4NCj4+Pj4+Pg0KPj4+Pj4+IENjOiBXZXNsZXkgQ2hl
bmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4+Pj4+PiBDYzogRmVsaXBlIEJhbGJpIDxiYWxi
aUBrZXJuZWwub3JnPg0KPj4+Pj4+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KPj4+Pj4+IENjOiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhh
cnZhcmQuZWR1Pg0KPj4+Pj4+IENjOiBKYWNrIFBoYW0gPGphY2twQGNvZGVhdXJvcmEub3JnPg0K
Pj4+Pj4+IENjOiBUaGluaCBOZ3V5ZW4gPHRoaW5oLm5ndXllbkBzeW5vcHN5cy5jb20+DQo+Pj4+
Pj4gQ2M6IFRvZGQgS2pvcyA8dGtqb3NAZ29vZ2xlLmNvbT4NCj4+Pj4+PiBDYzogQW1pdCBQdW5k
aXIgPGFtaXQucHVuZGlyQGxpbmFyby5vcmc+DQo+Pj4+Pj4gQ2M6IFlvbmdRaW4gTGl1IDx5b25n
cWluLmxpdUBsaW5hcm8ub3JnPg0KPj4+Pj4+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdh
bEBsaW5hcm8ub3JnPg0KPj4+Pj4+IENjOiBQZXRyaSBHeW50aGVyIDxwZ3ludGhlckBnb29nbGUu
Y29tPg0KPj4+Pj4+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+Pj4+Pj4gRml4ZXM6
IGQyNWQ4NTA2MWJkOCAoInVzYjogZHdjMzogZ2FkZ2V0OiBVc2UgbGlzdF9yZXBsYWNlX2luaXQo
KSBiZWZvcmUgdHJhdmVyc2luZyBsaXN0cyIpDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBT
dHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gIGRyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2ICsrKysrKw0KPj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+PiBpbmRleCBi
OGQ0YjJkMzI3YjIzLi5hNzNlYmU4ZTc1MDI0IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+Pj4+Pj4gQEAgLTI5OTAsNiArMjk5MCwxMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9l
cF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPj4+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4+PiAgICAgICB9DQo+Pj4+Pj4NCj4+
Pj4+PiArICAgICBpZiAoIWxpc3RfZW1wdHkoJmxvY2FsKSkgew0KPj4+Pj4+ICsgICAgICAgICAg
ICAgbGlzdF9zcGxpY2VfdGFpbCgmbG9jYWwsICZkZXAtPnN0YXJ0ZWRfbGlzdCk7DQo+Pj4+Pj4g
KyAgICAgICAgICAgICAvKiBSZXR1cm4gc28gd2UgZG9uJ3QgaGl0IHRoZSByZXN0YXJ0IGNhc2Ug
YW5kIGxvb3AgZm9yZXZlciAqLw0KPj4+Pj4+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPj4+Pj4+
ICsgICAgIH0NCj4+Pj4+PiArDQo+Pj4+Pj4gICAgICAgaWYgKCFsaXN0X2VtcHR5KCZkZXAtPnN0
YXJ0ZWRfbGlzdCkpDQo+Pj4+Pj4gICAgICAgICAgICAgICBnb3RvIHJlc3RhcnQ7DQo+Pj4+Pj4g
IH0NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE5vLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoZSBjaGFuZ2Ug
Zm9yDQo+Pj4+PiBkd2MzX2dhZGdldF9lcF9jbGVhdXBfY29tcGxldGVkX3JlcXVlc3RzKCkuIEFz
IEkgbWVudGlvbmVkIHByZXZpb3VzbHksDQo+Pj4+PiB3ZSBkb24ndCBjbGVhbnVwIHRoZSBlbnRp
cmUgc3RhcnRlZF9saXN0LiBJZiB0aGUgb3JpZ2luYWwgcHJvYmxlbSBpcyBkdWUNCj4+Pj4+IHRv
IGRpc2Nvbm5lY3Rpb24gaW4gdGhlIG1pZGRsZSBvZiByZXF1ZXN0IGNvbXBsZXRpb24sIHRoZW4g
d2UgY2FuIGp1c3QNCj4+Pj4+IGNoZWNrIGZvciBwdWxsdXBfY29ubmVjdGVkIGFuZCBleGl0IHRo
ZSBsb29wIGFuZCBsZXQgdGhlDQo+Pj4+PiBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpIGRvIHRoZSBj
bGVhbnVwLg0KPj4+Pg0KPj4+PiBPaywgc29ycnksIEkgZGlkbid0IHJlYWQgeW91ciBtYWlsIGlu
IGRlcHRoIHVudGlsIEkgaGFkIHRoaXMgcGF0Y2gNCj4+Pj4gc2VudCBvdXQuIElmIGEgcmV2ZXJ0
IG9mIGQyNWQ4NTA2MWJkOCBpcyB0aGUgYmV0dGVyIGZpeCwgSSdtIGZpbmUgd2l0aA0KPj4+PiB0
aGF0IHRvby4NCj4+Pj4NCj4+Pj4gdGhhbmtzDQo+Pj4+IC1qb2huDQo+Pj4+DQo+Pj4NCj4+PiBJ
TU8sIHdlIHNob3VsZCByZXZlcnQgdGhpcyBwYXRjaCBmb3Igbm93IHNpbmNlIGl0IHdpbGwgY2F1
c2UgcmVncmVzc2lvbi4NCj4+PiBXZSBjYW4gcmV2aWV3IGFuZCB0ZXN0IGEgcHJvcGVyIGZpeCBh
dCBhIGxhdGVyIHRpbWUuDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gVGhpbmgNCj4+Pg0KPj4NCj4+
IEFub3RoZXIgc3VnZ2VzdGlvbiB3b3VsZCBqdXN0IGJlIHRvIHJlcGxhY2UgdGhlIGxvb3Agd2l0
aCBhIHdoaWxlKCkgbG9vcA0KPj4gYW5kIHVzaW5nIGxpc3RfZW50cnkoKSBpbnN0ZWFkLiAgVGhh
dCB3YXMgd2hhdCB3YXMgZGlzY3Vzc2VkIGluIHRoZQ0KPj4gZWFybGllciBwYXRjaCBzZXJpZXMg
d2hpY2ggYWxzbyBhZGRyZXNzZXMgdGhlIHByb2JsZW0gYXMgd2VsbC4gIElzc3VlDQo+PiBoZXJl
IGlzIHRoZSB0bXAgdmFyaWFibGUgc3RpbGwgY2FycmllcyBhIHN0YWxlIHJlcXVlc3QgYWZ0ZXIg
dGhlIGR3YzMNCj4+IGdpdmViYWNrIGlzIGNhbGxlZC4gIFdlIGNhbiBhdm9pZCB0aGF0IGJ5IGFs
d2F5cyBmZXRjaGluZyB0aGUNCj4+IGxpc3RfZW50cnkoKSBpbnN0ZWFkIG9mIHJlbHlpbmcgb24g
bGlzdF9mb3JfZWFjaF9zYWZlKCkNCj4+DQo+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzE2MjA3MTY2MzYtMTI0MjItMS1naXQt
c2VuZC1lbWFpbC13Y2hlbmdAY29kZWF1cm9yYS5vcmcvX187ISFBNEYyUjlHX3BnIVAwRTFwdjND
MFBTdERlcEt5eThpcUtnVWFPaER5MFpEaFlkei1fY1p3bkpSUWpOanZ3ME1kSlFDZFU2WHdudDNZ
QXNfJCANCj4+DQo+IA0KPiBUaGlzIHNob3VsZCB3b3JrLCBidXQgdGhlIGF3a3dhcmQgdGhpbmcg
aXMgMiBsb29wcyBmcm9tIDIgc2VwYXJhdGUNCj4gdGhyZWFkcyBjb21wZXRpbmcgdG8gcmVtb3Zl
L2dpdmViYWNrIHRoZSByZXF1ZXN0cyBhbmQgbWF5IHJlcG9ydCBtaXggc3RhdHVzLg0KPiANCg0K
SXQncyBmaW5lIHdpdGggbWUuDQoNCkJSLA0KVGhpbmgNCg==
