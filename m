Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C93E4F98
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhHIW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:57:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52566 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233230AbhHIW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:57:55 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5C1CF410A3;
        Mon,  9 Aug 2021 22:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628549854; bh=ubkgImGM06SAgZpByhkimo62895+yPLIN9IIzCGgP+k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lcNxsPNM9rUd4WwwaVRX6m6T3TaKz5W+yVjvC16eBzgYK4oBhfjKwerVXZxvcopl4
         40OaSa+VlRPEwJDkUHG5NVLQ3NYHq987/EqNwJ90em7yJ2Hj0BdSV1jlSnKm21ieME
         bLulrhe1NJt4W7Ptr5KBdw+SZXpsTw8rtkvn/pDc3Wt4+UbSNP5CD7dJmKaI6wmo9j
         y7yCcbKbv3TWFWabdxmieWEYBBwAGQ8VYsX2jyyuqW1CcUytqCKKLdGe50zETmOaYo
         Wtowm7+Fsh1IzDy1uJDUj8RWCkQAsfp9DCl8euwCJemXyAobp0LyK+hVvXGyOgLpcv
         w289zEuVcFp4Q==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4441FA0071;
        Mon,  9 Aug 2021 22:57:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CF1C800BD;
        Mon,  9 Aug 2021 22:57:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="IdheNAeq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA0gO9yfYtuvOHpRxmJkWLMkQoApvbJy6pdA3raaKEOQFu1B6g+alDP1gGqt8Zz5Eol3t9vC1oxomrkCjqGpNkUYqCyGnIEGR48RZ7sXGmflsWpdWlPn/2i8LA/8Z7j1mdU9MHPYw9LpmXCWXAcNKmYuJCXNTywe9iU8sKp7VEixZpSdkm9UD1+6Ucksv7KzPBPlJgyALWbhgwCqQYo0PvUKmTl5oQ9PhOB4HOahdbzd0n5qblydNo9uvtvlW7sq1rxd3IzzplQOmkhJPhyOS/VW7g5ePGKnaFTnEXurNCMG6nA4lbnrJC1ASYO/1gBFCJRtHhxE+wOF1KWQNU4Fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubkgImGM06SAgZpByhkimo62895+yPLIN9IIzCGgP+k=;
 b=bHONpeDqDxKyL7rT1eTf0plh2gMGa9ptSggqa2ERb9alqsMrHzXEHnkkeSdokKU+qhhwjhO3kdMFpkfo6HWGN3dALe3j4nitw0Lv4asqYxKZNGBDaPAugxbkmWytyHm57w/mH3IdVpjlBtn94sAI6DmFBAnFuuHkQYcWXtzVDxH+SGcYWbQWCZHlbtdVqGyPwZRxq37pM+2mv/yvGFQsr34cXgmTBXgZb9MedfcyS9N3nzLXH+mbvx6D4PziQ08ZpNcoQGRRvaRMX1ohgz/1nki8Z1Vdd/nrQFqTPE9gqYxtlnZhICdYNWYgZq3ADYQY92T/lCDPOeNdHX9ppZ3mmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubkgImGM06SAgZpByhkimo62895+yPLIN9IIzCGgP+k=;
 b=IdheNAeq5uxQN31djiEx5A+/V+6R1Yu2pKokx4XKuVPgKctz0fVD3DO4KRjtvkIa1SHIFZfq7HrJ6kZAXBUpRopXJF5rY16MumMUyezTrpO2UGzE3M9lqmkO6zb0lbPq1+nbXhopbdQy2avfKY1ZknEE+E+krSls/lzU2KaN/20=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 22:57:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:57:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
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
Thread-Index: AQHXjW5ko6qYUR8aokekS5eRbPy7oKtrxUWAgAACvICAAAD6AA==
Date:   Mon, 9 Aug 2021 22:57:27 +0000
Message-ID: <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
 <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
 <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
In-Reply-To: <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3913ab95-8ec9-4e4f-449c-08d95b890f7d
x-ms-traffictypediagnostic: BYAPR12MB2952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29529CA9AFB786AB6EABAAD1AAF69@BYAPR12MB2952.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wji4dS1nGGG7S+OgzxckXxvkTFsDpMv/dO/t4DYE9NIlbzrH4oxCx+JyRcR/1RJ4gK+cNc2QREsuhpHTkN8sLBmLZ5n0IqzJif8/jBye61zQEsR5s5yEoS8Gf8PNRKtGg1eJfDCCSxsUebvrtAmmvHIAlnWMleHGrdXxDBg7FZ+BZnCO3cAHyHhQYquX+8X5ArKm337+nY87uNpt+VrYHQkj/dS+rlMVS7WaLBeshUEgQYMIyRaCQIZvYf23d1KZpydR2ly1336FAxF4Geh+lZRGAVblSH6GdQi2gaepORnLqUkb8Nz7LqpcdkOtFi5PrOZtXQkLmlVKonIcU7VkzIhRARUC2IMGnZHq2pqD2Ne+9wokP1jNqOPf1ukjiESyQjcyV2b00tuAxeXI8fzin6CS3hKsGR+2q0HFLBbJKi9HAtFcJyb7NjaRt+WjYcydFOkdHNu+5GACQA48JbezUelHiHy1QmS9fmvczHeaNdEchQPAt87U14qd3GZFr2OwET0I0DtSq+cJGJ1oEduCp26zUEYIvTQqw8xlnvlBBOgJHzQMJXjTHQome77C4W8uT7ddbJVihy8ZrA9beT/VVRZCl4ZRp7yWwJPtWRTHO6oU2KQS0nEC31lGRW4NGSmBe3gFF4MLG+isfnc/MI8CC4fz10gc+rsFIYrkAYYGFe5R3qRctSmWIHliieZMZlyX+65SjhP7qS2VFap6I982ZXg2t0lbqu6Z3zv61xCPdsfvfs3W6KN7+ssDqJutCtAqRpOTeFTBUeZYbjiSUGvDfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(66946007)(186003)(7416002)(83380400001)(76116006)(8936002)(8676002)(6512007)(31686004)(31696002)(71200400001)(6506007)(53546011)(66476007)(2906002)(86362001)(66556008)(478600001)(26005)(66446008)(64756008)(5660300002)(122000001)(38100700002)(4326008)(316002)(38070700005)(36756003)(110136005)(6486002)(2616005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3hjNzlsbHFGblpoaU1nd2FuRXF2bE9KZnRLSW5iSGFKYXlrS0pheGU2QWc5?=
 =?utf-8?B?NGYweU93VUZPV1BEMjN6bkU2U0d2Snp1VUd3SGI5dEtPbDBwQ3NuNlJrNEMx?=
 =?utf-8?B?VTdIbC9VdU1uSnprOXZWQkRKZVd4OVJ2MlZZUzl0aFQrTXZaeTVzMGwxbnI5?=
 =?utf-8?B?QUNmZW9IeEIrY2dtckwrRXYzaVJFYXlCbnFwYTl1anVWVDNuT2pGMFA1Kzgv?=
 =?utf-8?B?Szk4WGxXd3ZOL2toVXBxMVZSRlJlM0FGZ0lEVXRCWnA4Ulg5SFppNE0zakJW?=
 =?utf-8?B?ZFBYbzV5OHZ4T0VRTzRIYnRXZm5DSG9EbnhzZlV2UnpGUDA1Z1hmVm1Ibmkx?=
 =?utf-8?B?NGpKbU9pOS9YeEwrQmdlOEVvYmxXZGVLYlBLU0VTTk0wN1p5MGxuQy92eGRR?=
 =?utf-8?B?dzNCYnY2Y2E0ZTJqaHVZYWFnQW5STTE2UXZxOFVkTTVKMENUb3hlMXp3ZU0v?=
 =?utf-8?B?YUQ3cEVBVG1XSHIzTGhvcG9qUE5RelRLQTd0MHVoWHRlNUxTT0tIUzNHUXBm?=
 =?utf-8?B?Q0RDL05hVGVtWVY2eW5WWkt2Rm1XYnZMK1ZHUlNzcGJBRmk5dStweHB5ODZV?=
 =?utf-8?B?Z1J6Y2JqaXpJMlhHUDFGWDNBMXp2N08zZjdtNThGaDhTaHhGQVFLZ0FYNWZI?=
 =?utf-8?B?VzVkaFJiODAwdExndXhGdC9lSityMm9zTFFRSmlYMFVMTlh0WithWHdsRURJ?=
 =?utf-8?B?RlZPMmVNUzVpS0xSUnBwMkt3WHNjcDRDQkVCclg0akZTcVFESCttaEErWThG?=
 =?utf-8?B?cFZLYkFNYmRDOHJISEdWYTYyTHRoYUg4SCt0d2JLeWpCQmNneUdaZUFOZThl?=
 =?utf-8?B?SkxpM3RDRlZHcDY5bGlDdHpXK29GQk8xaGlpMUNyUHEyWXpTcE5DcTJHMDNC?=
 =?utf-8?B?ekN3aXBCRDhQeEVGclFOdFZQWFJYcmZPQWR3Y0JUeVRIMTVwV0ZMdkJXcHFl?=
 =?utf-8?B?VkZOQjBVdlhHdFJvc1YwTG1idG10MXhFbitySlB0Q2c2UVo1Vm55ZncrZnRw?=
 =?utf-8?B?aDVVekowZ2lCVXJ3NzhJQmJMTmtjTEx5RkZkWDVCdzlxSFBvdS9wR2tDb3hT?=
 =?utf-8?B?MGNHdTkxMUlYU25sOS9ERy8wUDRDZUh1VEdHU0tFMHpZdG92ZDF3ejVDQ2VM?=
 =?utf-8?B?SHR1QWZrTTJLdnpaeXBQQXhmeGhPNlQ2RVptUXNJOTFZdDZmWkRXdlVXUVB1?=
 =?utf-8?B?SG96Z3IyWThxZjc3ckU4NjVqTW5sZUhuMmJlc0pGRTVkNFloVm9VOWlRamZ0?=
 =?utf-8?B?UUZIMEZ2clVRQ3FnM3RWQ1JGNzJ5OGc2WnRaNG83cHFzVnhVMWt1QWYrZVZT?=
 =?utf-8?B?Q1IxQVdkRFRCUTQxeVplZ1VKSEQxVXpvdlE3d1dxOVRuWXBTWkppakJlbGtT?=
 =?utf-8?B?NERmZnJzZXVFYlA4U1NmYmVKMnI4dFp2bFVZZWk2a0VIbkJaSk16L1d4MlFa?=
 =?utf-8?B?N1ZxTmdqT3lFaUpUMW1tM25CaEtzSXpZYUNqY1FCaTcrNE9iS2ROU3Zna2h4?=
 =?utf-8?B?aEF3NE92ZHNPRWNMd0V2cmNvZ3o3NkF1T1Iycmh2YzUrdHB5NEpjNitEaytD?=
 =?utf-8?B?Z3NhV3hRVDZjQ3FkakU2RDZxSHF3bDlBZkRMYUVUdDROZVpxV0k2cmFwNERa?=
 =?utf-8?B?QzljLzVFZjNWOHpMWVhQUWx0ejExaEY4dmxDK3ozY3JENGVUYVFldEMreHZB?=
 =?utf-8?B?MXJHYlM3ME9pY3hZdWhFTGhWVEZLdWd1T3pEZ25SM0NCUmxZVW5YMEFoWWxm?=
 =?utf-8?Q?Tj+G3zeO3+OLH3dMVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5547BADB2ABA54AA4D471E07E19E993@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3913ab95-8ec9-4e4f-449c-08d95b890f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 22:57:27.6391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAjdQ6RCbsObnZAumIGaLp+QIZs/nv6nmk923UQYmFPpYXmBn4R+lKElnc1y4VFji4p0Q/+4Fxramv3QVCE8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9obiBTdHVsdHogd3JvdGU6DQo+IE9uIE1vbiwgQXVnIDksIDIwMjEgYXQgMzo0NCBQTSBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPj4NCj4+IEpvaG4g
U3R1bHR6IHdyb3RlOg0KPj4+IEluIGNvbW1pdCBkMjVkODUwNjFiZDggKCJ1c2I6IGR3YzM6IGdh
ZGdldDogVXNlDQo+Pj4gbGlzdF9yZXBsYWNlX2luaXQoKSBiZWZvcmUgdHJhdmVyc2luZyBsaXN0
cyIpLCBhIGxvY2FsIGxpc3RfaGVhZA0KPj4+IHdhcyBpbnRyb2R1Y2VkIHRvIHByb2Nlc3MgdGhl
IHN0YXJ0ZWRfbGlzdCBpdGVtcyB0byBhdm9pZCByYWNlcy4NCj4+Pg0KPj4+IEhvd2V2ZXIsIGlu
IGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzKCkgaWYNCj4+PiBkd2Mz
X2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0KCkgZmFpbHMsIHdlIGJyZWFrIGVh
cmx5LA0KPj4+IGNhdXNpbmcgdGhlIGl0ZW1zIG9uIHRoZSBsb2NhbCBsaXN0X2hlYWQgdG8gYmUg
bG9zdC4NCj4+Pg0KPj4+IFRoaXMgaXNzdWUgc2hvd2VkIHVwIGFzIHByb2JsZW1zIG9uIHRoZSBk
Yjg0NWMvUkIzIGJvYXJkLCB3aGVyZQ0KPj4+IGFkYiBjb25uZXRpb25zIHdvdWxkIGZhaWwsIHNo
b3dpbmcgdGhlIGRldmljZSBhcyAib2ZmbGluZSIuDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIHRyaWVz
IHRvIGZpeCB0aGUgaXNzdWUgYnkgaWYgd2UgYXJlIHJldHVybmluZyBlYXJseQ0KPj4+IHdlIHNw
bGljZSBpbiB0aGUgbG9jYWwgbGlzdCBoZWFkIGJhY2sgaW50byB0aGUgc3RhcnRlZF9saXN0DQo+
Pj4gYW5kIHJldHVybiAoYXZvaWRpbmcgYW4gaW5maW5pdGUgbG9vcCwgYXMgdGhlIHN0YXJ0ZWRf
bGlzdCBpcw0KPj4+IG5vdyBub24tbnVsbCkuDQo+Pj4NCj4+PiBOb3Qgc3VyZSBpZiB0aGlzIGlz
IGZ1bGx5IGNvcnJlY3QsIGJ1dCBzZWVtcyB0byB3b3JrIGZvciBtZSBzbyBJDQo+Pj4gd2FudGVk
IHRvIHNoYXJlIGZvciBmZWVkYmFjay4NCj4+Pg0KPj4+IENjOiBXZXNsZXkgQ2hlbmcgPHdjaGVu
Z0Bjb2RlYXVyb3JhLm9yZz4NCj4+PiBDYzogRmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3Jn
Pg0KPj4+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
Pg0KPj4+IENjOiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPj4+IENj
OiBKYWNrIFBoYW0gPGphY2twQGNvZGVhdXJvcmEub3JnPg0KPj4+IENjOiBUaGluaCBOZ3V5ZW4g
PHRoaW5oLm5ndXllbkBzeW5vcHN5cy5jb20+DQo+Pj4gQ2M6IFRvZGQgS2pvcyA8dGtqb3NAZ29v
Z2xlLmNvbT4NCj4+PiBDYzogQW1pdCBQdW5kaXIgPGFtaXQucHVuZGlyQGxpbmFyby5vcmc+DQo+
Pj4gQ2M6IFlvbmdRaW4gTGl1IDx5b25ncWluLmxpdUBsaW5hcm8ub3JnPg0KPj4+IENjOiBTdW1p
dCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPg0KPj4+IENjOiBQZXRyaSBHeW50aGVy
IDxwZ3ludGhlckBnb29nbGUuY29tPg0KPj4+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
DQo+Pj4gRml4ZXM6IGQyNWQ4NTA2MWJkOCAoInVzYjogZHdjMzogZ2FkZ2V0OiBVc2UgbGlzdF9y
ZXBsYWNlX2luaXQoKSBiZWZvcmUgdHJhdmVyc2luZyBsaXN0cyIpDQo+Pj4gU2lnbmVkLW9mZi1i
eTogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+DQo+Pj4gLS0tDQo+Pj4gIGRy
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2ICsrKysrKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+PiBpbmRleCBiOGQ0YjJkMzI3
YjIzLi5hNzNlYmU4ZTc1MDI0IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gQEAgLTI5OTAs
NiArMjk5MCwxMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRl
ZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPj4+ICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4+PiAgICAgICB9DQo+Pj4NCj4+PiArICAgICBpZiAoIWxpc3RfZW1wdHkoJmxv
Y2FsKSkgew0KPj4+ICsgICAgICAgICAgICAgbGlzdF9zcGxpY2VfdGFpbCgmbG9jYWwsICZkZXAt
PnN0YXJ0ZWRfbGlzdCk7DQo+Pj4gKyAgICAgICAgICAgICAvKiBSZXR1cm4gc28gd2UgZG9uJ3Qg
aGl0IHRoZSByZXN0YXJ0IGNhc2UgYW5kIGxvb3AgZm9yZXZlciAqLw0KPj4+ICsgICAgICAgICAg
ICAgcmV0dXJuOw0KPj4+ICsgICAgIH0NCj4+PiArDQo+Pj4gICAgICAgaWYgKCFsaXN0X2VtcHR5
KCZkZXAtPnN0YXJ0ZWRfbGlzdCkpDQo+Pj4gICAgICAgICAgICAgICBnb3RvIHJlc3RhcnQ7DQo+
Pj4gIH0NCj4+Pg0KPj4NCj4+IE5vLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoZSBjaGFuZ2UgZm9yDQo+
PiBkd2MzX2dhZGdldF9lcF9jbGVhdXBfY29tcGxldGVkX3JlcXVlc3RzKCkuIEFzIEkgbWVudGlv
bmVkIHByZXZpb3VzbHksDQo+PiB3ZSBkb24ndCBjbGVhbnVwIHRoZSBlbnRpcmUgc3RhcnRlZF9s
aXN0LiBJZiB0aGUgb3JpZ2luYWwgcHJvYmxlbSBpcyBkdWUNCj4+IHRvIGRpc2Nvbm5lY3Rpb24g
aW4gdGhlIG1pZGRsZSBvZiByZXF1ZXN0IGNvbXBsZXRpb24sIHRoZW4gd2UgY2FuIGp1c3QNCj4+
IGNoZWNrIGZvciBwdWxsdXBfY29ubmVjdGVkIGFuZCBleGl0IHRoZSBsb29wIGFuZCBsZXQgdGhl
DQo+PiBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpIGRvIHRoZSBjbGVhbnVwLg0KPiANCj4gT2ssIHNv
cnJ5LCBJIGRpZG4ndCByZWFkIHlvdXIgbWFpbCBpbiBkZXB0aCB1bnRpbCBJIGhhZCB0aGlzIHBh
dGNoDQo+IHNlbnQgb3V0LiBJZiBhIHJldmVydCBvZiBkMjVkODUwNjFiZDggaXMgdGhlIGJldHRl
ciBmaXgsIEknbSBmaW5lIHdpdGgNCj4gdGhhdCB0b28uDQo+IA0KPiB0aGFua3MNCj4gLWpvaG4N
Cj4gDQoNCklNTywgd2Ugc2hvdWxkIHJldmVydCB0aGlzIHBhdGNoIGZvciBub3cgc2luY2UgaXQg
d2lsbCBjYXVzZSByZWdyZXNzaW9uLg0KV2UgY2FuIHJldmlldyBhbmQgdGVzdCBhIHByb3BlciBm
aXggYXQgYSBsYXRlciB0aW1lLg0KDQpUaGFua3MsDQpUaGluaA0K
