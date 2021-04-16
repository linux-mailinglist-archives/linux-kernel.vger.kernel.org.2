Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C650E36196E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbhDPFny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:43:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54054 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhDPFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:43:53 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3BDBFC06A8;
        Fri, 16 Apr 2021 05:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618551809; bh=YbywFMGyJ2vz6o/weKQQ2zZ7bfQYWSU34NPSfS4k3vU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q3W3ik0wKeZ3G499NQRNaxsVNfWI9JvBipQcVzKy7Admweo/ed9edfgNEkD7uOt90
         FUp93XnVVydqnwoeaooO8n7ESTd7pl4aYoijA1juVuVfmvilGcmvp2HXb6b8OcPdaO
         KGmkw9jG+1k0ag/DcIx1q0rnd4oDGOYwws1WFT2hzOigF+iyThZDlQZdEVo6xkPsqo
         H4sq41Qbbj8ZxIeXdHPcgXV7dL/qc1MjbTakjL5HIUn0X9ssjK7gTMbkKwXkQ348Pp
         hY1ObSKAyxVZes3Hd3sFyWaONqpTrUri6rHmXMy/km3ICyL4rk9kPfUt7cpocEQ46n
         uK0cgdqAkWvpw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9551DA00BD;
        Fri, 16 Apr 2021 05:43:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 15BC080219;
        Fri, 16 Apr 2021 05:43:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="WcmdrKlG";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTLDQFrrK9jjPgrH0NUtegg5Ffi6w/C5BekgPc2kgsBRza9p9ACv6sKsuhAXbXzRveZsclAEd/W1ArWC3XyXVH7ZuUKL4PmETz+hodnpT4cyVHuZizuy0oKZgIKmuB6y7xg9YN1pU6OsCO03FuPLR0yj55ppfDMEUwHOXj0Lpu4dzU6X39mMk6MDtfB7GdQcuonALJXa2xpQAtALVrgiwh1+bASPP9JK7k+0Zlobm+mZbzaVfS5+N3/qgGbmMprsKNzIlmKxU78pQZNE+MOG9qi1w/OvRRI2L+Zun2XWqRZHXimbO0NiFphm1n/FawUdBAPmrjj502KOhuZ9MAZBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbywFMGyJ2vz6o/weKQQ2zZ7bfQYWSU34NPSfS4k3vU=;
 b=gdcjz2s4ZG4ZoYgE54/IFoA3k8p2c4xdWI/iwrJLlcV9GGoq3Uf3mqxW2yUhuhl1ZDnB2WMZSycfytCA7b/KhEu+zEjZFPD1EukcdMF/vXMGcXAcqqWGFMvHq/ls07s2cEJr8Q8VC18jx6lqHqlX9RbkAQcbD3RIhNkb8kSxPBs4K+dyW203CwO48wMKw2xZw8KdiYo2aItJn40G7+yr6o+gwwOzmtkdGvzNp+Wfwa9IMs27iJsvrJeLyg1hFI91RvQoYjDxY1EoR80l5fSlWck1tfJsJcOKiwlu8J/cF6X3LrzxnsGRfVQ39mhN84sEz60YUCSRDLLP6G9oy7zqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbywFMGyJ2vz6o/weKQQ2zZ7bfQYWSU34NPSfS4k3vU=;
 b=WcmdrKlG4k8HJAA1RSQiedxN/UvVwe/ikq52tYycIfnYVVabD6MZ4ydtCF36E2vzYUoE9ZuvUIo5xzgOXqID+x5l+wVyQs01XOU38veFnVU64KpDINHz8yCEnffjd9/cXIFhHCAEEsF+6zm9ZlThQqyosF6LeJs93NkuOpKgXbs=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 05:43:24 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c%7]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 05:43:24 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
Thread-Topic: [PATCH 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
Thread-Index: AQHXMbniubPxts+cBE6E3sPvdZnhn6q1S2SAgAFX/IA=
Date:   Fri, 16 Apr 2021 05:43:24 +0000
Message-ID: <d0bf6d03-8ef6-9eca-9736-eb7bac823a7b@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <65daa916b29e0009083702cb4584c8274e58ddac.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <8b16e1ea-b8bb-b3fd-29ce-a997579f92eb@gmail.com>
In-Reply-To: <8b16e1ea-b8bb-b3fd-29ce-a997579f92eb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fe72c7d-04ef-41cc-abf5-08d9009a8d5b
x-ms-traffictypediagnostic: CH0PR12MB5314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB531431C2CC2EC75B5E0416C2A74C9@CH0PR12MB5314.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqZ7lzwBoqn3MliI6eDDvtAszbl/zi+dImD+xmvWTkGDbxMqGqfSokWwq1q7koqHwtK3bg6cjEQzooreVo6CGvuQ6ry1YSMeU6RD+ka3yFMDAJ41djOwYW4wR+Wu06SQqRqg2FMnOZYzap/Rg6VEctjiX73qAWASxR5NBAcQ7ThBvUZM3lykAUF1M0wHKm6O7glXW6FPq0eU7sSOlDn4WsfWQL7IhubYxXThiolXw8igXnVBXXnE8Rs5p8HREUonNSZI+aWhYoeww9aw3VN+Y4PO0WdyKtbq3KFTnki2hZmRCWNi9gkna3KFP1L6Ki/vbSK5btYym63IoqojFIIx29dZmbnxxpdb5qXdUHetF7XW4a9klYTH5Z9twI28udSlVITxtGrkCIozSwP3s5ZloP+9+ckg2CCEuj+/vJ7Qqdz04E644XGu1qZEsZc7oc/6kCwZd9+Ja7Mr77c/zSPbOc65TICdtWNqHRsSoiMlCKlR0Yj3prujbDJr6Idz3FXQs9YzH8MldjwXNyQOWXNUs4mHhAQ+gJK7+I88424Qg5hOt8yd5jr9D3VW6wFR09Sa5JgEQxaA2pom8uzCv2cRGUIfYbmrtu5/Z9akv1Z7VFqfAj5GLpyTeOOfJ1UQ8gw5rA2WMATICfRPdafRHnHoNUvd87Wyn6HR1g3ktEHMT14=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(136003)(39860400002)(6512007)(83380400001)(8936002)(122000001)(38100700002)(31686004)(6486002)(186003)(53546011)(2616005)(26005)(6506007)(478600001)(36756003)(71200400001)(66446008)(66946007)(91956017)(64756008)(316002)(66556008)(2906002)(76116006)(66476007)(5660300002)(110136005)(86362001)(4326008)(31696002)(107886003)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?azAwNEJTSllwR0JrSUJiTjgzeG51LzlzQmpoa0tBdmg4Rlh0TEtobVZkcHlX?=
 =?utf-8?B?b2J1Q1NTTEpQeHk2WnpXbnlndm1CZ05OU3N0KzkrY1RBSkhzZ2xGUnRuaTFW?=
 =?utf-8?B?SmhnMHMvMFJFNjMvOXY1K3IvL3NxaE0vVmJPcytBYjFmNFUwaTRsRG45NDEy?=
 =?utf-8?B?UFFtdERabXU3YktSUmliUG56OHJlMEFSOGVlTERZV1cvRExCdHhUSGxENGwx?=
 =?utf-8?B?ZzBGUWh1K2I1Q2htMlVHazJpRzNjK3duems0KzhjaE1QMjNSOFZYZUNYa3lN?=
 =?utf-8?B?eC9YaVdlNlZURnRlenlXeWJBcVVUWUgrVTQ0UFpGenI5djA5cGhaQ0lSMkh2?=
 =?utf-8?B?MklndVdJNThiKzcrMko3NUpXUitQK3lIZFdrM00vZktjMmxrK016MWl4Y1dS?=
 =?utf-8?B?VjlLMmVET1AwaGZUbHNCaWhQSDUrOWVtczNJZDZhVVZZYnZ6Lys4V0dtdkN0?=
 =?utf-8?B?MlZVbmplSStNb3F2N0RwVS9MaER4ZE5EWFFWa3NPWUhDVU5tUkhaRk5IbS9K?=
 =?utf-8?B?WHZXUXhBcDNuTG1YZXV2ckw0ZGxsZXpTQjIrQkVqbldmN2YwUTc3Q2trTGlq?=
 =?utf-8?B?ME5kZWdyQm11OE9oaFJldDNoY0tuT25FeTlIRXNYTWJsbFBISGZMb3VRVTFZ?=
 =?utf-8?B?MWtoWExndCtTeFhnVXNJSG11UXNMOWtwZjh2VUs5OGJ5anhXZXJDUzllN0hZ?=
 =?utf-8?B?OExOT3N2d2hlVDJqVmZRSG8ySzJqUWFmcFVZT0FSUjY0TVNFVDlXcm9zcjla?=
 =?utf-8?B?b1g0c0U2U0lKZ25VZ3BKYS9jU3ZJUUJPNTJ1Mlg0WHJlbXFDNm95ZVNtWVYw?=
 =?utf-8?B?c0pjTDNTanBRY2RTUkVVbStpc1d3MFVTQW5uN003ZFJXS213WVM2SXFQbGJn?=
 =?utf-8?B?TEp6eFZNelUyc242bHRNTVhZTDdUeURINTFvZmFpYlYvOGFwcFV0VlJTNmpV?=
 =?utf-8?B?YkU5ZWpzQlhka0Y5bDhXYm1sYXlEb1cxSDMxWXphYlJVVnBtRy9wTEZPR3Ju?=
 =?utf-8?B?akUvRXQ1a3ZHU04vL01Ud0ZLaHpqYU9GbHRVQW9KQzcrMEtoSHhWZmM3QkJQ?=
 =?utf-8?B?Ty9WUmhFWUVEQXJ5ZEZqQ2dJdXFIOGVkdzdlbUdOZGZzQUFxL0ZQU252Wm1m?=
 =?utf-8?B?RUo5R01RSGtDVnlNck53bFpXZlVjZHdnbTl0Q2JIN0pUVVgvSlNiZXRuT2dM?=
 =?utf-8?B?NVh2MHgxV1kyR040bmlQM2ZtRUN6UVRNK1o2Z3l3NzFhbm1iSXdlNXhiQUY4?=
 =?utf-8?B?elhMamRqWDJqRlRacjlscHRZbG9GVVFHODJISFNmeHNmb1RHQS9oQ3J1eGF1?=
 =?utf-8?B?MVNQTVFIQVZVd1IvbTRoMXdydlBGYmsrVVYvUm56SkFZSnN0dDFyblhRMUh6?=
 =?utf-8?B?QWU0WDZUSVYyYU1KTnkxck04V3g2VTNwSnY5bEZnTkozMVM4RVZHWlp1MTMw?=
 =?utf-8?B?cW5GWUljQTN4Q0NIYlg0c0NUTDRaZXUxYlExcExmdUN3NDBxZUxsNVliVFYx?=
 =?utf-8?B?WEFXbHc4anJXNWc1eVdVOGszektYSStDUSsxcGoxbkNudC9jS2dvWWVCMnNS?=
 =?utf-8?B?UldsSGsva0l5QjlRQTJQY0JmTGw0RThQbzdPSnZnb2xrc243VnRBb2kxaGRk?=
 =?utf-8?B?Q3FQN2FkSXdwS3l1Ymd3QWd4KzVhc2VwanU1NkhqdjVoNEFNcTJVU0hzeE83?=
 =?utf-8?B?Z1V2TklQaUVMcEY1ZXhrVittL0FpMDVldXNWTlBPd2F1YUZGOGhsR3N4Y3pR?=
 =?utf-8?Q?akiiRDETT47m53lCIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EA727AFEAC1124DA4BC99623C7E7FAD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe72c7d-04ef-41cc-abf5-08d9009a8d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 05:43:24.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWll16mM5hjkUoMsTK603n06O0ufjnxkzm3Tpx8al939jowv///q7Gr1v2xEIV0f5e3wDkH9sRb+kIrkvN40WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpPbiA0LzE1LzIwMjEgMTM6MTIsIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToN
Cj4gT24gMTUuMDQuMjAyMSA4OjQwLCBBcnR1ciBQZXRyb3N5YW4gd3JvdGU6DQo+IA0KPj4gV2hl
biBjb3JlIGlzIGluIGhpYmVybmF0aW9uIHN0YXRlIGFuZCBhbiBleHRlcm5hbA0KPj4gaHViIGlz
IGNvbm5lY3RlZCwgdXBwZXIgbGF5ZXIgc2VuZHMgVVJCIGVucXVldWUgcmVxdWVzdCwNCj4+IHdo
aWNoIHJlc3VsdHMgaW4gcG9ydCByZXNldCBpc3N1ZS4NCj4+DQo+PiAtIEFkZGVkIGV4aXQgZnJv
bSBoaWJlcm5hdGlvbiBzdGF0ZSB0byBhdm9pZCBwb3J0DQo+PiByZXNldCBpc3N1ZSBhbmQgcHJv
Y2VzcyB1cHBlciBsYXllciByZXF1ZXN0IHByb3Blcmx5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEFydHVyIFBldHJvc3lhbiA8QXJ0aHVyLlBldHJvc3lhbkBzeW5vcHN5cy5jb20+DQo+PiAtLS0N
Cj4+ICAgIGRyaXZlcnMvdXNiL2R3YzIvaGNkLmMgfCAxNyArKysrKysrKysrKysrKysrKw0KPj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4+IGluZGV4
IGNjOWFkNmNmMDJkOS4uM2IwM2IyZDczYWFhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMi9oY2QuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPj4gQEAgLTQ2MzEs
MTIgKzQ2MzEsMjkgQEAgc3RhdGljIGludCBfZHdjMl9oY2RfdXJiX2VucXVldWUoc3RydWN0IHVz
Yl9oY2QgKmhjZCwgc3RydWN0IHVyYiAqdXJiLA0KPj4gICAgCXN0cnVjdCBkd2MyX3FoICpxaDsN
Cj4+ICAgIAlib29sIHFoX2FsbG9jYXRlZCA9IGZhbHNlOw0KPj4gICAgCXN0cnVjdCBkd2MyX3F0
ZCAqcXRkOw0KPj4gKwlzdHJ1Y3QgZHdjMl9ncmVnc19iYWNrdXAgKmdyOw0KPj4gKw0KPj4gKwln
ciA9ICZoc290Zy0+Z3JfYmFja3VwOw0KPj4gICAgDQo+PiAgICAJaWYgKGRiZ191cmIodXJiKSkg
ew0KPj4gICAgCQlkZXZfdmRiZyhoc290Zy0+ZGV2LCAiRFdDIE9URyBIQ0QgVVJCIEVucXVldWVc
biIpOw0KPj4gICAgCQlkd2MyX2R1bXBfdXJiX2luZm8oaGNkLCB1cmIsICJ1cmJfZW5xdWV1ZSIp
Ow0KPj4gICAgCX0NCj4+ICAgIA0KPj4gKwlpZiAoaHNvdGctPmhpYmVybmF0ZWQpIHsNCj4+ICsJ
CWlmIChnci0+Z290Z2N0bCAmIEdPVEdDVExfQ1VSTU9ERV9IT1NUKSB7DQo+PiArCQkJcmV0dmFs
ID0gZHdjMl9leGl0X2hpYmVybmF0aW9uKGhzb3RnLCAwLCAwLCAxKTsNCj4+ICsJCQlpZiAocmV0
dmFsKQ0KPj4gKwkJCQlkZXZfZXJyKGhzb3RnLT5kZXYsDQo+PiArCQkJCQkiZXhpdCBoaWJlcm5h
dGlvbiBmYWlsZWQuXG4iKTsNCj4+ICsJCX0gZWxzZSB7DQo+PiArCQkJcmV0dmFsID0gZHdjMl9l
eGl0X2hpYmVybmF0aW9uKGhzb3RnLCAwLCAwLCAwKTsNCj4+ICsJCQlpZiAocmV0dmFsKQ0KPj4g
KwkJCQlkZXZfZXJyKGhzb3RnLT5kZXYsDQo+PiArCQkJCQkiZXhpdCBoaWJlcm5hdGlvbiBmYWls
ZWQuXG4iKTsNCj4gDQo+ICAgICAgV2h5IG5vdCBwdXQgdGhlc2UgaWRlbnRpY2FsICppZipzIG91
dHNpZGUgdGhlIHRoZSBvdXRlciAqaWYqPw0KPiANCldlbGwgdGhlIHJlYXNvbiB0aGF0IHRoZSBj
b25kaXRpb25zIGFyZSBpbXBsZW1lbnRlZCBsaWtlIHRoZXkgYXJlLCBpcyANCnRoYXQgdGhlIGlu
bmVyIGlmIGNoZWNrcyB3aGV0aGVyIGNvcmUgb3BlcmF0ZXMgaW4gaG9zdCBtb2RlIG9yIGRldmlj
ZSANCm1vZGUgYW5kIHRoZSBvdXRzaWRlIGlmIGNoZWNrcyBpZiB0aGUgY29yZSBpcyBoaWJlcm5h
dGVkIG9yIG5vdC4NCg0KU28gbm93IGltYWdpbmUgdGhhdCB0aGUgaWZzIGFyZSBjb21iaW5lZCBh
bmQgY29yZSBpcyBub3QgaGliZXJuYXRlZCBidXQgDQp0aGUgb3BlcmF0aW9uYWwgbW9kZSBvZiB0
aGUgZHJpdmVyIGlzIGxldCdzIHNheSBnYWRnZXQuIElmIHRoZSBjYXNlIGlzIA0Kc3VjaCB0aGVu
IHRoZSBkcml2ZXIgd2lsbCB0cnkgdG8gZXhpdCBmcm9tIGdhZGdldCBoaWJlcm5hdGlvbiBiZWNh
dXNlIG9mIA0KdGhlIGVsc2UgY29uZGl0aW9uIGFzIHRoZSBpZiBjb25kaXRpb24gd2lsbCBiZSBm
YWxzZSBhZ2FpbiBiZWNhdXNlIGNvcmUgDQppcyBub3QgaGliZXJuYXRlZC4gQXMgYSByZXN1bHQg
aWYgd2UgY29tYmluZSB0aGUgb3V0c2lkZSBhbmQgaW5uZXIgaWZzIA0KdGhlbiBpdCB3aWxsIHRy
eSB0byBleGl0IGZyb20gZ2FkZ2V0IGhpYmVybmF0aW9uIGJ1dCBjb3JlIGlzIG5vdCANCmhpYmVy
bmF0ZWQgYW5kIHRoYXQgd291bGQgYmUgYW4gaXNzdWUuDQoNCg0KPiANCj4+ICsJCX0NCj4+ICsJ
fQ0KPj4gKw0KPj4gICAgCWlmIChoc290Zy0+aW5fcHBkKSB7DQo+PiAgICAJCXJldHZhbCA9IGR3
YzJfZXhpdF9wYXJ0aWFsX3Bvd2VyX2Rvd24oaHNvdGcsIDAsIHRydWUpOw0KPj4gICAgCQlpZiAo
cmV0dmFsKQ0KPiANCj4gTUJSLCBTZXJnZWkNCj4gDQoNClJlZ2FyZHMsDQpBcnR1cg0K
