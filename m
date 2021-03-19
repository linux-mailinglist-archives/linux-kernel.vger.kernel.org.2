Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95A34290F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCSXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:10:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40912 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhCSXKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:10:08 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EF4A6402DC;
        Fri, 19 Mar 2021 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616195408; bh=ytJLzZxdRggUKHp7eYmjvQFXxgiVBkUhKo64W4gdxcg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O4R7mTMk0aNyzsWKqJk2tsuACiTMvU+cy766XJ7zfisXI4dcf9EPzusDxkZnXSn8Z
         ++Uta543FTqTadU9zN50GUdH2m/IGI8pFQYr8pgAsmoxnVsUjq3j4SVNvQDCgKlwaU
         O5AvJ/5uv0l3XuB8RQQT4VopRUOLSTyyT3Y7M+BufbxvJa/8Oi8AqZVSM/1PylUotf
         cUmgxzy77vtc3fH9l8xQoUltVWltonBo/THhMTlEaPI2qmxMSR9u2S3kAEaJJEemVZ
         Byom17/fRnghKgJCIv4xKmNfpiKj+n5A9irUQ2t56wOhdYwtTjnwsOiM2yffxz7oXW
         AXD4pK5gVlUVw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 16C8EA006A;
        Fri, 19 Mar 2021 23:10:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E422140050;
        Fri, 19 Mar 2021 23:10:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Ew4fN2By";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4h3GlWP9jh2DZrdIqz6o3yQf3zhcl7cvnCfvbkhr9n+Zf6O9EvuwdqoMFh6MLrqyOna81EdUp2f7dvGDK5RIX1FsMlxi90RAHrA3Lp4tlF42o2lSD2k7SyWRpLkjzaGwYCsMIAGaHBjE0FCazIHeHzBJARYidqNzSpG5BoQ7uQ973AnKTICxP7KYPMzwzo9v1gevkZfhec253ZeLm6WeX0Vc++A5KmBfk6hR0N9dPHd+Lu4IIvNkLToJBHksnGqb/a+A0nssBq4T8M/8x+Ju91CM8t8H3yaboVNrfLMiq7hyv5N78nM0Un/8xHDbVw9f6jNVVUkjQ/F0hzPytH+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytJLzZxdRggUKHp7eYmjvQFXxgiVBkUhKo64W4gdxcg=;
 b=m6YZNz+loFanXmo/G2NcQllcidKuxBHOrtLwwWNXRfoBhO8ZykcrxqjHOLnM76l4szNMbMmzr9dgsPHry1ODHwl7LXQGQd0QEOhi84fiOMzzQ6N+ty7LKuJ9KCGIRLaxFPL39QceRm1D3esf+D7FWDkc852GdhL2P2jzIIKcvyZMbFwdufF7skL+iDEe5X9MmpZcizj8oFTVqOpb8+102vK4/H79+t6yniZWSrapaey8vNOJbCA1Of9KxlEeLrC4vGeJ90o1OIYLyRioBXNeDUgqAL6bZTwLhv2pRpl4dzLdUh5V3pLMf8TDjtSpj2Z0xlWF4VggxERGv72GbzX6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytJLzZxdRggUKHp7eYmjvQFXxgiVBkUhKo64W4gdxcg=;
 b=Ew4fN2ByHUxjEfSGvDrtHTX05FF8CTNnl6wijA6i20w7V6PHYxiySYN2YTgAdRgZC2HaP1o32UYOE/T71pMjBMDcLq990uZEVXiajNj8ARlqJ/ZHxo37fYxE5d1Z/owCVhVFMsQejFxaVXE5ncs9qK/Z1g6P63aLPMSMl8w3cmE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 23:09:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 23:09:59 +0000
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
Thread-Index: AQHW5WDHaQXdezZAr06Yos1UmLp1A6odqBQAgABzRQCAAFsegIBYjhOAgAD1JgCAAVXNgIACB8sAgAA6IgCAEMWfAIAACCsA
Date:   Fri, 19 Mar 2021 23:09:59 +0000
Message-ID: <28bc3ce1-7ace-be25-7d7d-ca8ab1b0f0e9@synopsys.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <87bldzwr6x.fsf@kernel.org>
 <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
 <d95d0971-624e-a0e6-ac72-6ee3b1fb1106@synopsys.com>
 <06a44245-4f2f-69ba-fe46-b88a19f585c2@codeaurora.org>
 <a33f7c33-f95d-60c3-70f2-4b37fcf8bac5@synopsys.com>
 <fa5cc67e-3873-e6d9-8727-d160740b027e@codeaurora.org>
 <3db531c4-7058-68ec-8d4b-ff122c307697@synopsys.com>
 <8b5f7348-66d7-4902-eac8-593ab503db96@codeaurora.org>
 <ee47c2c6-f931-6229-13cd-d41a28b3b9c7@codeaurora.org>
In-Reply-To: <ee47c2c6-f931-6229-13cd-d41a28b3b9c7@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f53612a8-5198-4ffb-cea9-08d8eb2c1e56
x-ms-traffictypediagnostic: BY5PR12MB5014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5014F5E0CE0A6ECAB19DAF5FAA689@BY5PR12MB5014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsKCROVZ6WSAWTxX+1RqK6DXVbxIVezJNwTrM6f5Gow5irkKepDJxFegWerbblMNVzKM8JS2PGghoRFFHDd05AfY6/+r6A2Uw+vhpK08TGYOIkod+v2MAPL6nwfB1ADer9M0bPYdP7f6J9R63Hw0TOVtWzn1yqlXN5SaGi7asmc65qQUiOOxXq+yyNfsxCCr5FcQcRHCJVBQpQjqCSaC9998B+70fJEyX8DqAZ80xFiiVlvln+ArRFY/6GAopuBJZn4k3z78aZg6tTc07yBAN681kr0pEyiQNnnmt/vg3CnjZyCEiIwSRRJlStAZB533GuhPmTmTWj2qxFCuwCfkfJnlJv+bgHeh8UKEj1sEWfsUw7WJhvciXFbvXnDjD1N7AYqatGnKAIRJVy8NeBAsFicB4TvuV/v0h8lfD11lzX5G3rdg9+WVWUoIeMJW+hjs5QMuk/juGogQy4+KaWZv4JRxbaDpuEiTYWZdhPrQOUfC9I34N3FxubHdCabecqxOE8MpaX+oTk83xU5uWXk6bnfvbZa/TKI+Db0rK0vndVLRzmXIQ3rjXtZMWkk3kNd27N2u/8aLC3/vvZxnDcX3toLlOquFx1Pk4TnPSZedQAo7CmZZGpnxLR/cNhOuZjWLu2qWbnSuhDD6w67QsdcsZf4pUxKpZC4Eb0eR3PtN4JFKubbUwB/Q/CMg0OoDpXn/g/4mPGcycvDcwbKOdkZH/Gp0uYjdv0xxX3n92BbgaObz/6JAGR9VCuI+16oa9uiKIJ6tLzz+yW22arwvo/lWiKF6WPx9knBS4lJJxfLCS8l5nrK6ZRPYmqVP+/yPGZmb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(31686004)(966005)(53546011)(66946007)(2906002)(66476007)(64756008)(186003)(86362001)(6486002)(4326008)(71200400001)(110136005)(6506007)(36756003)(76116006)(31696002)(66446008)(5660300002)(83380400001)(316002)(84040400003)(6512007)(26005)(8676002)(8936002)(7416002)(478600001)(54906003)(38100700001)(2616005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZSszNkF6UkZ6U29Va3NIcEIzeDc3eWlIejN1bHdpZEY2QSsxdDgySitadUVt?=
 =?utf-8?B?MW45clQ2Qy9wVFhDcllERWFhZVY2VnBVZkdvVldCRnAxSENSS09Wemh3ZCs5?=
 =?utf-8?B?UGQwZVk2bGwvVlpBNm5BRkdRamYrVkZEcnBEUDB3OTBtTEtQd3pCYUVZY2pI?=
 =?utf-8?B?bXFualhiWWM2ZzZSd3FUOU9rZXU5TUNZKy9tMUtCQUhBZldtNGJIcWhJc3F0?=
 =?utf-8?B?VXd4T1BlTDdVL05wYnBzNFdwa0pGSE1yZjZxaHU4UURFaG9XeDR4MGluRUxj?=
 =?utf-8?B?SkYyQ1pHKzl6YlMzODdyTFBnUzdmVWtlNkp5NTlIR1NDVHo2UHdnNUVvdis2?=
 =?utf-8?B?TElIdDhtK0NNdExrdUVkeXVsWTQzaFlNYm9aYytCa2xSSGh1ZVErd3FhVGE1?=
 =?utf-8?B?OS9pZm5hRE1XZUZKSVdSZTZxTnBFdndtT0pQMmc0WDJsV3FjdjdYMVlzM3g0?=
 =?utf-8?B?Q1RjTzkvemMvdmxUbXoydHFsNFdob3AwUHRVeHNxcE15Tmk5bDZ3K05EcDF2?=
 =?utf-8?B?SXR4ZWhhMDRUNW45aTFVaHJmdk9RZGt0V3NoUVJkSnRXeFhrcTZuQm9uM0R1?=
 =?utf-8?B?ZHNGYXcvWnF2eEZjQ1hrM2d0WHBUMHVBQlJOa2pTRmlKZGN1c0hsUGRvcWFh?=
 =?utf-8?B?aWwyUk9NLzhUK09zb1cyWHhaTG5WTVlBSjYwYVlUbkFVSDBmUVB5b3lpRDRO?=
 =?utf-8?B?N2RFYjM2dmxWVHNVRVdtSUxZY1dJdE1rbjZwbmcvaDBjZDV3a1JMRVc4ZVU1?=
 =?utf-8?B?WVlsQWN3cnhVT05jeTNKQk94cFd6aHpSZ1h4QWdlaW5pRzl4aUZvSDQ4enM0?=
 =?utf-8?B?QmpJMWRUSExhRU43cTZjcFpzeTV2R0xwS1pZYW40aTkza0E2VnBNQlJYdUFG?=
 =?utf-8?B?MlJrRzBTeVdISDV5K1F2WTlHd2Y5RXpwekE1THNncFZ6K1NucE90czNxa2NB?=
 =?utf-8?B?RlFBWXpPZ20yMnZnTmwvTVVMb2FTNVNjdXRrNzV2Y2E3Mjh5VkZQbXJORVRV?=
 =?utf-8?B?OTRpQkVDMHBLc1o5THBFcGU3Y2J6VVpoZDNsdjIyNzhkUWJVdU51MXMwQnF2?=
 =?utf-8?B?eFBnTm1iWFpFeTBuQ1M4TlJpVWRWQVpHanY4RkVFMW50Nmg4eXBiNkdXVXpq?=
 =?utf-8?B?dUd3SE80cm15ME85QU5EaEUxNTZZQlZRZkhOL3ErMFZ4Qnp4eWVmc1dsVTBO?=
 =?utf-8?B?ak43YWgybTdVWUtiaDZtbThzbTU1MEpFS0hHVkZXMGN3Y1FUK1l0Y0t5WUVC?=
 =?utf-8?B?UEpvcXZCKyt6MHNoOTRZWjJ6U0J1OUxRdW5pU1VnMm0xSHUzQnJZY0lvVVl1?=
 =?utf-8?B?QXRmek16aGwyVWw0alZVN1RlMnlKdjI2aEk2MzYraytWQVkrZHI2WlJjdURF?=
 =?utf-8?B?MHVTMGQ5NUhBV2hOMVUvY0dkbXh4N1pTRDljNE02WmN4ZVJRYXlrUUhrSkRk?=
 =?utf-8?B?aFRuOExrN1lUSElTUmloV0JPRWNHK2EvT1RXWTVOYUQ4Y01oaVZhMWl0R0RK?=
 =?utf-8?B?QnQrTlB5dVhUeDk1My9uYll5MVRvZVdjRThLVDh2Z1phWlZWamZkdDQ0UVRL?=
 =?utf-8?B?QmdsNmtaNE9JNk5wYTNDTWFsckdLNm8vR01PTGtzdGd6RkMxdFlNQmwxS1BR?=
 =?utf-8?B?QTVkSCtvdVN4bWRGMVQvZXRMd3VPbjB4aTF0VW1pcnBBK3RXNHhTamQzdFI2?=
 =?utf-8?B?cnYxbDNJN0cvVzhqRzRBN1g3Y3FqUUI3VkNpZ08xNThLK2ZnUkdJZldhV3E4?=
 =?utf-8?Q?5tS6KJn9RzA7AgMC6Yh7VEimk+36RR8OwS8nedG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <497BB363B6E8214C8590E8D36B4821A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53612a8-5198-4ffb-cea9-08d8eb2c1e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 23:09:59.2159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYqjUXVV0ajDEHZTx5YiX2BU92kxD/H3osTrJ3i1lw+tgBv65/iIcZmNjkh0Xhl9sAjTPxpZCDT9qqBHULQsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDMvOC8yMDIxIDEwOjMzIFBNLCBXZXNs
ZXkgQ2hlbmcgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDMvOC8yMDIxIDc6MDUgUE0sIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDMvNi8y
MDIxIDM6NDEgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4+IFdlc2xleSBDaGVuZyB3cm90
ZToNCj4+Pj4+PiBPbiAxLzgvMjAyMSA0OjQ0IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+
Pj4+IEhpLA0KPj4+Pj4+Pg0KPj4+Pj4+PiBKb2huIFN0dWx0eiB3cm90ZToNCj4+Pj4+Pj4+IE9u
IEZyaSwgSmFuIDgsIDIwMjEgYXQgNDoyNiBBTSBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPj4+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gSm9obiBTdHVs
dHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+IHdyaXRlczoNCj4+Pj4+Pj4+Pj4gRnJvbTogWXUg
Q2hlbiA8Y2hlbnl1NTZAaHVhd2VpLmNvbT4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gSnVzdCBy
ZXNlbmRpbmcgdGhpcywgYXMgZGlzY3Vzc2lvbiBkaWVkIG91dCBhIGJpdCBhbmQgSSdtIG5vdA0K
Pj4+Pj4+Pj4+PiBzdXJlIGhvdyB0byBtYWtlIGZ1cnRoZXIgcHJvZ3Jlc3MuIFNlZSBoZXJlIGZv
ciBkZWJ1ZyBkYXRhIHRoYXQNCj4+Pj4+Pj4+Pj4gd2FzIHJlcXVlc3RlZCBsYXN0IHRpbWUgYXJv
dW5kOg0KPj4+Pj4+Pj4+PiAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sL0NBTEFxeExYZG5hVWZKS3gwYU45eFd3dGZXVmpNV2lnUHB5MmFx
c05qNTZ5dm5iVTgwZ0BtYWlsLmdtYWlsLmNvbS9fXzshIUE0RjJSOUdfcGchTE56dXByQWVnLU84
MFNnb2xZa0lrVzQtbmUtTS15TFdDRFVZOU15Z0FJclFDMzk4WjZnUko5d25zbmxxZDN3JCANCj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gV2l0aCB0aGUgY3VycmVudCBkd2MzIGNvZGUgb24gdGhlIEhp
S2V5OTYwIHdlIG9mdGVuIHNlZSB0aGUNCj4+Pj4+Pj4+Pj4gQ09SRUlETEUgZmxhZyBnZXQgc3R1
Y2sgb2ZmIGluIF9fZHdjM19nYWRnZXRfc3RhcnQoKSwgd2hpY2gNCj4+Pj4+Pj4+Pj4gc2VlbXMg
dG8gcHJldmVudCB0aGUgcmVzZXQgaXJxIGFuZCBjYXVzZXMgdGhlIFVTQiBnYWRnZXQgdG8NCj4+
Pj4+Pj4+Pj4gZmFpbCB0byBpbml0aWFsaXplLg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBXZSBo
YWQgc2VlbiBvY2Nhc2lvbmFsIGluaXRpYWxpemF0aW9uIGZhaWx1cmVzIHdpdGggb2xkZXINCj4+
Pj4+Pj4+Pj4ga2VybmVscyBidXQgd2l0aCByZWNlbnQgNS54IGVyYSBrZXJuZWxzIGl0IHNlZW1l
ZCB0byBiZSBiZWNvbWluZw0KPj4+Pj4+Pj4+PiBtdWNoIG1vcmUgY29tbW9uLCBzbyBJIGR1ZyBi
YWNrIHRocm91Z2ggc29tZSBvbGRlciB0cmVlcyBhbmQNCj4+Pj4+Pj4+Pj4gcmVhbGl6ZWQgSSBk
cm9wcGVkIHRoaXMgcXVpcmsgZnJvbSBZdSBDaGVuIGR1cmluZyB1cHN0cmVhbWluZw0KPj4+Pj4+
Pj4+PiBhcyBJIGNvdWxkbid0IHByb3ZpZGUgYSBwcm9wZXIgcmF0aW9uYWwgZm9yIGl0IGFuZCBp
dCBkaWRuJ3QNCj4+Pj4+Pj4+Pj4gc2VlbSB0byBiZSBuZWNlc3NhcnkuIEkgbm93IHJlYWxpemUg
SSB3YXMgd3JvbmcuDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEFmdGVyIHJlc3VibWl0dGluZyB0
aGUgcXVpcmssIFRoaW5oIE5ndXllbiBwb2ludGVkIG91dCB0aGF0IGl0DQo+Pj4+Pj4+Pj4+IHNo
b3VsZG4ndCBiZSBhIHF1aXJrIGF0IGFsbCBhbmQgaXQgaXMgYWN0dWFsbHkgbWVudGlvbmVkIGlu
IHRoZQ0KPj4+Pj4+Pj4+PiBwcm9ncmFtbWluZyBndWlkZSB0aGF0IGl0IHNob3VsZCBiZSBkb25l
IHdoZW4gc3dpdGNoaW5nIG1vZGVzDQo+Pj4+Pj4+Pj4+IGluIERSRC4NCj4+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+Pj4gU28sIHRvIGF2b2lkIHRoZXNlICFDT1JFSURMRSBsb2NrdXBzIHNlZW4gb24gSGlL
ZXk5NjAsIHRoaXMNCj4+Pj4+Pj4+Pj4gcGF0Y2ggaXNzdWVzIEdDVEwgc29mdCByZXNldCB3aGVu
IHN3aXRjaGluZyBtb2RlcyBpZiB0aGUNCj4+Pj4+Pj4+Pj4gY29udHJvbGxlciBpcyBpbiBEUkQg
bW9kZS4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gQ2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2Vy
bmVsLm9yZz4NCj4+Pj4+Pj4+Pj4gQ2M6IFRlamFzIEpvZ2xla2FyIDx0ZWphcy5qb2dsZWthckBz
eW5vcHN5cy5jb20+DQo+Pj4+Pj4+Pj4+IENjOiBZYW5nIEZlaSA8ZmVpLnlhbmdAaW50ZWwuY29t
Pg0KPj4+Pj4+Pj4+PiBDYzogWW9uZ1FpbiBMaXUgPHlvbmdxaW4ubGl1QGxpbmFyby5vcmc+DQo+
Pj4+Pj4+Pj4+IENjOiBBbmRyemVqIFBpZXRyYXNpZXdpY3ogPGFuZHJ6ZWoucEBjb2xsYWJvcmEu
Y29tPg0KPj4+Pj4+Pj4+PiBDYzogVGhpbmggTmd1eWVuIDx0aGluaG5Ac3lub3BzeXMuY29tPg0K
Pj4+Pj4+Pj4+PiBDYzogSnVuIExpIDxsaWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPj4+Pj4+Pj4+
PiBDYzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0K
Pj4+Pj4+Pj4+PiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCj4+Pj4+Pj4+Pj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+Pj4+
Pj4gU2lnbmVkLW9mZi1ieTogWXUgQ2hlbiA8Y2hlbnl1NTZAaHVhd2VpLmNvbT4NCj4+Pj4+Pj4+
Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+DQo+
Pj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4+PiB2MjoNCj4+Pj4+Pj4+Pj4gKiBSZXdvcmsgdG8gYWx3
YXlzIGNhbGwgdGhlIEdDVEwgc29mdCByZXNldCBpbiBEUkQgbW9kZSwNCj4+Pj4+Pj4+Pj4gICBy
YXRoZXIgdGhlbiB1c2luZyBhIHF1aXJrIGFzIHN1Z2dlc3RlZCBieSBUaGluaCBOZ3V5ZW4NCj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gdjM6DQo+Pj4+Pj4+Pj4+ICogTW92ZSBHQ1RMIHNvZnQgcmVz
ZXQgdW5kZXIgdGhlIHNwaW5sb2NrIGFzIHN1Z2dlc3RlZCBieQ0KPj4+Pj4+Pj4+PiAgIFRoaW5o
IE5ndXllbg0KPj4+Pj4+Pj4+IEJlY2F1c2UgdGhpcyBpcyBzdWNoIGFuIGludmFzaXZlIGNoYW5n
ZSwgSSB3b3VsZCBwcmVmZXIgdGhhdCB3ZSBnZXQNCj4+Pj4+Pj4+PiBUZXN0ZWQtQnkgdGFncyBm
cm9tIGEgZ29vZCBmcmFjdGlvbiBvZiB0aGUgdXNlcnMgYmVmb3JlIGFwcGx5aW5nIHRoZXNlDQo+
Pj4+Pj4+Pj4gdHdvIGNoYW5nZXMuDQo+Pj4+Pj4+PiBJJ20gaGFwcHkgdG8gcmVhY2ggb3V0IHRv
IGZvbGtzIHRvIHRyeSB0byBnZXQgdGhhdC4gVGhvdWdoIEknbQ0KPj4+Pj4+Pj4gd29uZGVyaW5n
IGlmIGl0IHdvdWxkIGJlIGJldHRlciB0byBwdXQgaXQgYmVoaW5kIGEgZHRzIHF1aXJrIGZsYWcs
IGFzDQo+Pj4+Pj4+PiBvcmlnaW5hbGx5IHByb3Bvc2VkPw0KPj4+Pj4+Pj4gICAgaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDEwMjEx
ODE4MDMuNzk2NTAtMS1qb2huLnN0dWx0ekBsaW5hcm8ub3JnL19fOyEhQTRGMlI5R19wZyFMTnp1
cHJBZWctTzgwU2dvbFlrSWtXNC1uZS1NLXlMV0NEVVk5TXlnQUlyUUMzOThaNmdSSjl3blJXSVRa
ZmMkIA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoYXQgd2F5IGZvbGtzIGNhbiBlbmFibGUgaXQgZm9y
IGRldmljZXMgYXMgdGhleSBuZWVkPw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEFnYWluLCBJJ20gbm90
IHRyeWluZyB0byBmb3JjZSB0aGlzIGluIGFzLWlzLCBqdXN0IG1vc3RseSBzZW5kaW5nIGl0DQo+
Pj4+Pj4+PiBvdXQgYWdhaW4gZm9yIGRpc2N1c3Npb24gdG8gdW5kZXJzdGFuZCB3aGF0IG90aGVy
IGFwcHJvYWNoIG1pZ2h0IHdvcmsuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gdGhhbmtzDQo+Pj4+Pj4+
PiAtam9obg0KPj4+Pj4+PiBBIHF1aXJrIHdvdWxkIGltcGx5IHNvbWV0aGluZyBpcyBicm9rZW4v
ZGl2ZXJnZWQgZnJvbSB0aGUgZGVzaWduIHJpZ2h0Pw0KPj4+Pj4+PiBCdXQgaXQncyBub3QgdGhl
IGNhc2UgaGVyZSwgYW5kIGF0IGxlYXN0IHRoaXMgaXMgbmVlZGVkIGZvciBIaUtleTk2MC4NCj4+
Pj4+Pj4gQWxzbywgSSB0aGluayBSb2Igd2lsbCBiZSBvayB3aXRoIG5vdCBhZGRpbmcgMSBtb3Jl
IHF1aXJrIHRvIHRoZSBkd2MzDQo+Pj4+Pj4+IGRldmljZXRyZWUuIDopDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IEJSLA0KPj4+Pj4+PiBUaGluaA0KPj4+Pj4+Pg0KPj4+Pj4+IEhpIEFsbCwNCj4+Pj4+Pg0K
Pj4+Pj4+IFNvcnJ5IGZvciBqdW1waW5nIGluLCBidXQgSSBjaGVja2VkIHRoZSBTTlBTIHYxLjkw
YSBkYXRhYm9vaywgYW5kIHRoYXQNCj4+Pj4+PiBzZWVtZWQgdG8gcmVtb3ZlIHRoZSByZXF1aXJl
bWVudCBmb3IgdGhlIEdDVEwuc29mdHJlc2V0IGJlZm9yZSB3cml0aW5nDQo+Pj4+Pj4gdG8gUFJU
Q0FQRElSLiAgU2hvdWxkIHdlIGNvbnNpZGVyIGFkZGluZyBhIGNvbnRyb2xsZXIgdmVyc2lvbi9J
UCBjaGVjaz8NCj4+Pj4+Pg0KPj4+Pj4gSGkgV2VzbGV5LA0KPj4+Pj4NCj4+Pj4+IEZyb20gd2hh
dCBJIHNlZSBpbiB0aGUgdjEuOTBhIGRhdGFib29rIGFuZCBvdGhlcnMsIHRoZSBmbG93IHJlbWFp
bnMgdGhlDQo+Pj4+PiBzYW1lLiBJIG5lZWQgdG8gY2hlY2sgaW50ZXJuYWxseSwgYnV0IEknbSBu
b3QgYXdhcmUgb2YgdGhlIGNoYW5nZS4NCj4+Pj4+DQo+Pj4+IEhpIFRoaW5oLA0KPj4+Pg0KPj4+
PiBIbW1tLCBjYW4geW91IGhlbHAgY2hlY2sgdGhlIHJlZ2lzdGVyIGRlc2NyaXB0aW9uIGZvciB0
aGUgUFJUQ0FQRElSIG9uDQo+Pj4+IHlvdXIgdjEuOTBhIGRhdGFib29rPyAgKFRhYmxlIDEtMTkg
RmllbGRzIGZvciBSZWdpc3RlcjogR0NUTCAoQ29udGludWVkKQ0KPj4+PiBQZzczKSAgV2hlbiB3
ZSBjb21wYXJlZCB0aGUgc2VxdWVuY2UgaW4gdGhlIGRlc2NyaXB0aW9uIHRoZXJlIHRvIHRoZQ0K
Pj4+PiBwcmV2aW91cyB2ZXJzaW9ucyBpdCByZW1vdmVkIHRoZSBHQ1RMLnNvZnRyZXNldC4gIElm
IGl0IHN0aWxsIHNob3dzIHVwDQo+Pj4+IG9uIHlvdXJzLCB0aGVuIG1heWJlIG15IHYxLjkwYSBp
c24ndCB0aGUgZmluYWwgdmVyc2lvbj8NCj4+Pj4NCj4+Pj4gVGhhbmtzDQo+Pj4+IFdlc2xleSBD
aGVuZw0KPj4+Pg0KPj4+DQo+Pj4gSGkgV2VzbGV5LA0KPj4+DQo+Pj4gQWN0dWFsbHkgeW91ciBJ
UCB2ZXJzaW9uIHR5cGUgbWF5IHVzZSB0aGUgbmV3ZXIgZmxvdy4gQ2FuIHlvdSBwcmludCB5b3Vy
DQo+Pj4gRFdDM19WRVJfVFlQRT8gSSBzdGlsbCBuZWVkIHRvIHZlcmlmeSBpbnRlcm5hbGx5IHRv
IGtub3cgd2hpY2ggdmVyc2lvbnMNCj4+PiBuZWVkIHRoZSB1cGRhdGUgaWYgYW55Lg0KPj4+DQo+
Pj4gVGhhbmtzLA0KPj4+IFRoaW5oDQo+Pj4NCj4+IEhpIFRoaW5oLA0KPj4NCj4+IFN1cmUsIG15
IERXQzNfVkVSX1RZUEUgb3V0cHV0ID0gMHg2NzYxMkEyQQ0KPj4NCj4+IFRoYW5rcw0KPj4gV2Vz
bGV5IENoZW5nDQo+Pg0KPiBIaSBUaGluaCwNCj4gDQo+IFdvdWxkIHlvdSBoYXBwZW4gdG8gaGF2
ZSBhbiB1cGRhdGUgb24gdGhlIHJlcXVpcmVkIHNlcXVlbmNlIG9uIHRoZQ0KPiB2ZXJzaW9uIHNo
YXJlZD8gIFNvcnJ5IGZvciBwdXNoaW5nLCBidXQgd2UganVzdCB3YW50ZWQgdG8gZmluYWxpemUg
b24NCj4gaXQsIHNpbmNlIGl0IGRvZXMgY2F1c2Ugc29tZSBmdW5jdGlvbmFsIGlzc3VlcyB3L28g
dGhlIHNvZnQgcmVzZXQgaW4NCj4gcGxhY2UsIGFuZCBjYXVzZXMgYSBjcmFzaCBpZiB3ZSBoYXZl
IHRoZSBHQ1RMLnNvZnRyZXNldC4NCj4gDQo+IFRoYW5rcw0KPiBXZXNsZXkgQ2hlbmcNCj4gDQoN
CkhpIFdlc2xleSwNCg0KSSdtIHN0aWxsIHRyeWluZyB0byBnZXQgdGhhdCBpbmZvIGZvciB5b3Uu
IFRoZSB2ZXJzaW9ucyB3aXRob3V0DQpHQ1RMLnNvZnRyZXNldCBzaG91bGQgYmUgdmVyeSBuZXcu
IFRoZSBmbG93IHdpdGggR0NUTC5zb2Z0cmVzZXQgc2hvdWxkDQp3b3JrIGZvciBhbGwgdmVyc2lv
bnMgYW5kIHNob3VsZCBub3QgY2F1c2UgZnVuY3Rpb25hbCBpbXBhY3QuIFdlIGNhbg0KY3JlYXRl
IGEgY2hhbmdlIHRvIG9wdGltaXplIGFuZCByZW1vdmUgR0NUTC5zb2Z0cmVzZXQgZm9yIHRoZSBu
ZXdlcg0KY29udHJvbGxlciB2ZXJzaW9ucyBhdCBhIGxhdGVyIHRpbWUuDQoNClNpbmNlIHlvdSBh
bmQgSm9obiBTdHVsdHogaGF2ZSB0aGUgc2V0dXAgdGhhdCBjYW4gYmUgdmVyaWZpZWQgaW4gdGhl
DQpyZWFsIHdvcmxkLiBJdCB3b3VsZCBiZSBncmVhdCBpZiBKb2huIG9yIHlvdSBwcm92aWRlIGEg
dGVzdGVkIHBhdGNoKGVzKQ0KdG8gcmVzb2x2ZSB0aGlzIGlzc3VlLg0KDQpUaGFua3MsDQpUaGlu
aA0K
