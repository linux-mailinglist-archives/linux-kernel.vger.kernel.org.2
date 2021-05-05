Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7D374870
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhEETHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:07:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:41702 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235149AbhEETHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:07:50 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E33D40436;
        Wed,  5 May 2021 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620241614; bh=TAZjPtSr7KoLDKUY3deEFpRBLKmaT9A9foKLKYf0bVY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QScPLxilQcIcOinz90KBnDoRtKwVULuTNWnjiJayrwctreM6h1lImtMikTa8wWEUC
         IcVaxq7ru42BS2zuer7ft91JKOHEIaGnu6sYxaUCuj9VuawCVjgOALOmvLkohz0NLX
         PSJVfLKMCOFimIlSk0YchXoZBOzP0XivSXwObtyUcIqORySQ5tkTiUTmOEx74vzOqu
         jkgUux1wwNxRzuxp8UFQEeBnCpbjSr6IS9q1j3KeTZjxRNUNyuzx8HqeeFYQGrDduv
         QbpaHMBPpntClFdi59pIRrAULigAu1zuWs9E66ioCSrDYXe0ZlnTDgnP3f9CL12fTX
         6fpsZ44uuqtZA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 93331A0070;
        Wed,  5 May 2021 19:06:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5669580214;
        Wed,  5 May 2021 19:06:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uZfIapGX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF6vomunfCrGylXCBgRFPhlBqailbH0LuA8TVqnbSOsjil5Fu5Qpr/rEaugwtgZVB3o9/zpFVtUp4mmIzH5F3X4tWerkm0Ungr07KlVqT+OuCSo9RUkXcKd35NXOnhnOyJjC193PgIULmRIfr9IvVRmFCGl7lKNBgmOjY/mlpBXF4xsPIOKEtLll5exuV4B5lEsQEVG8Ik5mhT9OfsTo+xusRggmG94vYnYEOkWs1ZCz8cMNdpTFuJCw9dSeL7m5QPEkKVqjbCfJxOmaj5dCz/HeTmlBITh24xXR9H4jcfuiRKDWgtUuRouM+9tfs2+fCB+6MEyNTGVEekgIT1/uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAZjPtSr7KoLDKUY3deEFpRBLKmaT9A9foKLKYf0bVY=;
 b=leer55131Mj0oVnINg8luLtkcKhDiTGz211MHpbsGFe9MGb999NkwsNpEqAcAQAK+hQmauEWStX7gtbls0uwYXCyGcGpeR9mIFZMmih0sCXsS+YmdlzfYsQ4sSlOT1NMp5OoMnCnxgqZx/l67GeC/i0DbHnUzyM/oxgVj1csVQJ/uJdVNq9WVyWvHs65UhwYVn4P9LgRavdbPJq2KNMLFkiI5VfE7NFgsB1yzwh+XAjG9TUz9E5e+AgZUFc0WrDA+OtyDOXpg5H65jRiLs3+LzF20S1sZ0QYz53/BoEa2QpSLe/I+XKtjfWfhWj7/p/0qkmYj3/4C4J69d55gpjUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAZjPtSr7KoLDKUY3deEFpRBLKmaT9A9foKLKYf0bVY=;
 b=uZfIapGXp7qDXOwjhhmzdAr9IwKk/1UJEl2cXbMkbUOAw+/8fVgCTeJRYmfR6sjj2YCpsavQlc+UaRiIZvglgRrR5xeJ0P7PaB/Axhn7AQTfNsssZmKzSCgX6TdVJhQ1O+n4cvLZt5nCDQZtWjHCGoSpec4uwvCcOkzPbN5Phf8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2741.namprd12.prod.outlook.com (2603:10b6:a03:62::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 5 May
 2021 19:06:49 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 19:06:49 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0AgAAHAwCAAj0igIAAZ0+A
Date:   Wed, 5 May 2021 19:06:49 +0000
Message-ID: <bd88e35e-ed40-aa53-273b-f7370f3c485a@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org>
In-Reply-To: <8735v1ibj4.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f7099a4-ef8f-4e0d-0d32-08d90ff8efc3
x-ms-traffictypediagnostic: BYAPR12MB2741:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2741C25B052C3A22322D34ADAA599@BYAPR12MB2741.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQG7rL6I/gt9QkDKHKSyXHQDzctSFyntmslG1MqT6tWIASg+ke7o5DIZNFGA0xqOIwrw5pPxSXIyoVh3achrxgKCSN6iXYPQW00h0xN5pF8IZXuMj0zRqvKyvD3CzcoJd8ILR1j+I6bwRac11ZCPFcLFZtM0zKgN3Vh85e1Rfw0sPdP4VmwzsP7+W6C+8deESWTJOhVG3MLAIyz8k+Ms/3Ch4+h7nsSztLZx+qsoks3slUclzkFU7xxmNYoYej7DQDy3penax0Sc9mTQhIPhfcOgAZ7rEXPaUzN94I4iFCE/QdFd7auvSdM06BZbF7fab4X/gWg8djMKQyH5/bAntDlFp+TY2k6TXMKqe6UmLChE5NFXYq+SjhSlOO81qH1go7XLsucjpwryKzWmfUeUVO9SnrsUUW4jQhx+LbNZvQt7QBZM+HAQVm9vGpwfOlovkzyPrMQqWCf6fq7D+CcTDKNNSAKJg2f7FLv7u67su+STtxubIrY/53Be+KCVqIdhp4kwP3j/og9s5aLLYQhoFOIJbctUBjBzSWbPpTldGVn5AvHz13Ae8jHIJBzzqf949OQLbrZP4dcjRpc0LmCyLPSJlk9g8FOzvivK7IDUXUJwyIBSw/NLqLowrzIukJMoDTCb3erX5QdNLJwcqFiikp0cOMmIbNx50dxUL8fbvc+Alsu/tLQ/90nU0IVtc/YO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39850400004)(376002)(136003)(76116006)(122000001)(66556008)(64756008)(6506007)(66476007)(2616005)(8936002)(38100700002)(26005)(6486002)(66946007)(4326008)(5660300002)(2906002)(86362001)(478600001)(186003)(71200400001)(31686004)(31696002)(36756003)(110136005)(53546011)(316002)(83380400001)(8676002)(54906003)(6512007)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RkZFSDFYQnRRa3BlUGZoRUV3MzVuK2dMTGFkTFQ4OVA3ZVMxckl6UDBaeUp5?=
 =?utf-8?B?VHFDbEZBVVhiaHNpNDdiQitucGFzaXNiOVZDaUVjT1FYdm1PWWMyZ09Sc3JG?=
 =?utf-8?B?RTRlekRtdEV4cFcwOU5Nb0xuSERnODlYcUNpdFlPVUVSdkx4QXZ4dWVPZEJy?=
 =?utf-8?B?RzJlNVMrRWRFY3U4dThmckQrbzdqYmpGeUltU25xeUxIdnFtUkFjT0orMERa?=
 =?utf-8?B?cng3OGRtK0lFdWxZNCt1SGV4MlkwTG9IOUFraHE4ZlZ4NVowMGo3S0JBYnpN?=
 =?utf-8?B?eWM5VWJtUTZ1a2lmTEJ5WUJZY1dVY21DTGhPQlJqVFlISGhVS3lnZmMvSlY4?=
 =?utf-8?B?OEhwVUtsQWs5MDVjbDJtT2ppckZ2cnlyVDVBL3Y2bFY2dGlQN3licitLMjkw?=
 =?utf-8?B?bnZ1T1NiOGtBeHJWRHZvaFFaY0s2b3U1bGt6UVl3c1g0VnRuSXBTMnFjVk1R?=
 =?utf-8?B?dWRTN2JXZlhFU3ZvUVhXL3hhMXBrZjV2LzZkZGRtVklETnZNbG5GbElmcE5p?=
 =?utf-8?B?VmFtTm13emg2ODZ3NmNuVktiNkxtVHFIdDBZUC9SKzN6eTdvb0x3N2ZBNTk0?=
 =?utf-8?B?OWY4bHNtMFdEZGNVOTB5Y2VoSnJQNXM0VXpPTmRySWFsaTUzeGZhSVVSUUV6?=
 =?utf-8?B?MEJYdkZMemVMdzFrNitKOCtLS0s5THBXalIrdnJtUkZWbDNQN2NZQVdQWDJr?=
 =?utf-8?B?c1RNaVRMVTVYa1J2WWhBbFBBdjhlek9ocytmb1l4OU1aTWs4WDZ5TW9XenUz?=
 =?utf-8?B?dUx6Qm9MbkJMYWdHdjBTMTdJbXEvWERYRjBrZ0ptZU94c2hlaDExcVBFNkJv?=
 =?utf-8?B?bnZKaFI2UUNhbkxHY2xKcHltZmUwSWhVM0N1WTlQZ05kcnplVGIyN3kvM1ho?=
 =?utf-8?B?Wkw1T3dzRzJKT1RsV0N0V2htbVdNYS9NYlR4UjBCdlQ1ZmZqazlBRkVsalYw?=
 =?utf-8?B?V1Y5WVIvS2IxSThCbStPWE1rNDY1Z1JNU0RlZ0F2dmZwekJwV1Nibm84NnFP?=
 =?utf-8?B?V2dlc3NMKzdWdUhIWnZyVm1aNUZLYlA2Q0xKZ0JJbUJNQVFkMjMzOHpGRzFF?=
 =?utf-8?B?YnBLRnlXNmJVWFRvMXlMS1FaK0pQUnF3Vkc0bW1mM2s2L3NXb1JBZThJWHNL?=
 =?utf-8?B?c0dLSEd0SmVBZHQ3aFJVMVJxVTZ5dU9JZmdCY2JpQWVoenpvM3pORmhTQW9P?=
 =?utf-8?B?UmdHSWJneVlYbjh0MVZaNzlYMEczZmNweGRuMkxPdGg1Q2VPYzRNSW1hUHJy?=
 =?utf-8?B?aXdtL2pyckY3SnhXbE1xeG11U29TVkZSekx0YU51eldPVytjZG0rOU9kNTI2?=
 =?utf-8?B?c1ZjU1FNZURpVTNTazMvM0FSbjNOWkM0d3p6eVpxQnl6VVA1UklKczJEMUZr?=
 =?utf-8?B?RHpUVFcwZ05oazlwWG9vU3RBd1E1WUpNbTBuSm5lcURucnhvV0tRNnAyeUp5?=
 =?utf-8?B?aXpsRnBJdWNtRUs4RFBUWG12cElTTlNkSGgrTHhsdTBrSXN5N1hQZVNhenV1?=
 =?utf-8?B?Tm1vb3FTRjZLKys5RjFKbjFNVzBtY2ZtMGhNQmRFMmVRMlZWa2FyTXZla2Zq?=
 =?utf-8?B?UTlLdy9MRml3SDFiUHpKODF1NDN3bFNpS2xucU55MzRXSGhlZW9mWDIyTjNC?=
 =?utf-8?B?eXJMNjNScmV1SVpBd0wzMzY5eERTODVqRXJrVmk0eGFHWHQ1aU5McWhtc2Fx?=
 =?utf-8?B?alU0SXAzYzFSM3dpaEZQZlMyQ0VZVGpMSlJsZGVwSVBMMUZVNzdkWVNyRXlO?=
 =?utf-8?Q?SpJPuP/v5ZCHaqOD6ojXxqBINSCHrVnpzqilif9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAA55913AF7EF14DB6F88FA680FF930B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7099a4-ef8f-4e0d-0d32-08d90ff8efc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 19:06:49.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YL380g31IgtC+3PaGGi47WqfCxA3va1zC2SsCZgwEcZ8o+lQb8ENzLYq+0sVHX/AnqLfGpaSeHywvD89UVSLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2741
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBXZXNsZXkgQ2hlbmcgPHdjaGVu
Z0Bjb2RlYXVyb3JhLm9yZz4gd3JpdGVzOg0KPj4gT24gNS8zLzIwMjEgNzoyMCBQTSwgVGhpbmgg
Tmd1eWVuIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+
PiBJZiBhbiBlcnJvciBpcyByZWNlaXZlZCB3aGVuIGlzc3VpbmcgYSBzdGFydCBvciB1cGRhdGUg
dHJhbnNmZXINCj4+Pj4gY29tbWFuZCwgdGhlIGVycm9yIGhhbmRsZXIgd2lsbCBzdG9wIGFsbCBh
Y3RpdmUgcmVxdWVzdHMgKGluY2x1ZGluZw0KPj4+PiB0aGUgY3VycmVudCBVU0IgcmVxdWVzdCks
IGFuZCBjYWxsIGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCkgdG8gbm90aWZ5DQo+Pj4+IGZ1bmN0aW9u
IGRyaXZlcnMgb2YgdGhlIHJlcXVlc3RzIHdoaWNoIGhhdmUgYmVlbiBzdG9wcGVkLiAgQXZvaWQN
Cj4+Pj4gaGF2aW5nIHRvIGNhbmNlbCB0aGUgY3VycmVudCByZXF1ZXN0IHdoaWNoIGlzIHRyeWlu
ZyB0byBiZSBxdWV1ZWQsIGFzDQo+Pj4+IHRoZSBmdW5jdGlvbiBkcml2ZXIgd2lsbCBoYW5kbGUg
dGhlIEVQIHF1ZXVlIGVycm9yIGFjY29yZGluZ2x5Lg0KPj4+PiBTaW1wbHkgdW5tYXAgdGhlIHJl
cXVlc3QgYXMgaXQgd2FzIGRvbmUgYmVmb3JlLCBhbmQgYWxsb3cgcHJldmlvdXNseQ0KPj4+PiBz
dGFydGVkIHRyYW5zZmVycyB0byBiZSBjbGVhbmVkIHVwLg0KPj4+Pg0KPj4NCj4+IEhpIFRoaW5o
LA0KPj4NCj4+Pg0KPj4+IEl0IGxvb2tzIGxpa2UgeW91J3JlIHN0aWxsIGxldHRpbmcgZHdjMyBz
dG9wcGluZyBhbmQgY2FuY2VsbGluZyBhbGwgdGhlDQo+Pj4gYWN0aXZlIHJlcXVlc3RzIGluc3Rl
YWQgbGV0dGluZyB0aGUgZnVuY3Rpb24gZHJpdmVyIGRvaW5nIHRoZSBkZXF1ZXVlLg0KPj4+DQo+
Pg0KPj4gWWVhaCwgbWFpbiBpc3N1ZSBpc24ndCBkdWUgdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBk
b2luZyBkZXF1ZXVlLCBidXQNCj4+IGhhdmluZyBjbGVhbnVwIChpZSBVU0IgcmVxdWVzdCBmcmVl
KSBpZiB0aGVyZSBpcyBhbiBlcnJvciBkdXJpbmcNCj4+IHVzYl9lcF9xdWV1ZSgpLg0KPj4NCj4+
IFRoZSBmdW5jdGlvbiBkcml2ZXIgaW4gcXVlc3Rpb24gYXQgdGhlIG1vbWVudCBpcyB0aGUgZl9m
cyBkcml2ZXIgaW4gQUlPDQo+PiBtb2RlLiAgV2hlbiBhc3luYyBJTyBpcyBlbmFibGVkIGluIHRo
ZSBGRlMgZHJpdmVyLCBldmVyeSB0aW1lIGl0IHF1ZXVlcw0KPj4gYSBwYWNrZXQsIGl0IHdpbGwg
YWxsb2NhdGUgYSBpb19kYXRhIHN0cnVjdCBiZWZvcmVoYW5kLiAgSWYgdGhlDQo+PiB1c2JfZXBf
cXVldWUoKSBmYWlscyBpdCB3aWxsIGZyZWUgdGhpcyBpb19kYXRhIG1lbW9yeS4gIFByb2JsZW0g
aXMgdGhhdCwNCj4+IHNpbmNlIHRoZSBEV0MzIGdhZGdldCBjYWxscyB0aGUgY29tcGxldGlvbiB3
aXRoIC1FQ09OTlJFU0VULCB0aGUgRkZTDQo+PiBkcml2ZXIgd2lsbCBhbHNvIHNjaGVkdWxlIGEg
d29yayBpdGVtICh3aXRoaW4gaW9fZGF0YSBzdHJ1Y3QpIHRvIGhhbmRsZQ0KPj4gdGhlIGNvbXBs
ZXRpb24uICBTbyB5b3UgZW5kIHVwIHdpdGggYSBmbG93IGxpa2UgYmVsb3cNCj4+DQo+PiBhbGxv
Y2F0ZSBpb19kYXRhIChmZnMpDQo+PiAgLS0+IHVzYl9lcF9xdWV1ZSgpDQo+PiAgICAtLT4gX19k
d2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKCkNCj4+ICAgIC0tPiBkd2MzX3NlbmRfZ2FkZ2V0X2Vw
X2NtZChFSU5WQUwpDQo+PiAgICAtLT4gZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxsZWRf
cmVxdWVzdHMoKQ0KPj4gICAgLS0+IGR3YzNfZ2FkZ2V0X2dpdmViYWNrKEVDT05OUkVTRVQpDQo+
PiBmZnMgY29tcGxldGlvbiBjYWxsYmFjaw0KPj4gcXVldWUgd29yayBpdGVtIHdpdGhpbiBpb19k
YXRhDQo+PiAgLS0+IHVzYl9lcF9xdWV1ZSByZXR1cm5zIEVJTlZBTA0KPj4gZmZzIGZyZWVzIGlv
X2RhdGENCj4+IC4uLg0KPj4NCj4+IHdvcmsgc2NoZWR1bGVkDQo+PiAgLS0+IE5VTEwgcG9pbnRl
ci9tZW1vcnkgZmF1bHQgYXMgaW9fZGF0YSBpcyBmcmVlZA0KPiANCj4gSSBoYXZlIHNvbWUgdmFn
dWUgbWVtb3J5IG9mIGRpc2N1c3NpbmcgKHNvbWV0aGluZyBsaWtlKSB0aGlzIHdpdGggQWxhbg0K
PiBTdGVybiBsb25nIGFnbyBhbmQgdGhlIGNvbmNsdXNpb24gd2FzIHRoYXQgdGhlIGdhZGdldCBk
cml2ZXIgc2hvdWxkDQo+IGhhbmRsZSBjYXNlcyBzdWNoIGFzIHRoaXMuIE9UT0gsIHdlJ3JlIHJl
dHVybmluZyBmYWlsdXJlIGR1cmluZw0KPiB1c2JfZXBfcXVldWUoKSB3aGljaCB0ZWxscyBtZSB0
aGVyZSdzIHNvbWV0aGluZyB3aXRoIGR3YzMgKHBlcmhhcHMgbm90DQo+IGV4Y2x1c2l2ZWx5LCBi
dXQgdGhhdCdzIHlldCB0byBiZSBzaG93bikuDQo+IA0KPiBJZiBJIHVuZGVyc3Rvb2QgdGhlIHdo
b2xlIHRoaW5nIGNvcnJlY3RseSwgd2Ugd2FudCBldmVyeXRoaW5nIGV4Y2VwdCB0aGUNCj4gY3Vy
cmVudCByZXF1ZXN0ICh0aGUgb25lIHRoYXQgZmFpbGVkIFNUQVJUIG9yIFVQREFURSB0cmFuc2Zl
cikgdG8gZ28NCj4gdGhyb3VnaCBnaXZlYmFjaygpLiBUaGlzIHJlYWxseSB0ZWxscyBtZSB0aGF0
IHdlJ3JlIG5vdCBoYW5kbGluZyBlcnJvcg0KPiBjYXNlIGluIGtpY2tfdHJhbnNmZXIgYW5kL29y
IHByZXBhcmVfdHJicygpIGNvcnJlY3RseS4NCj4gDQo+IEkgYWxzbyBkb24ndCB3YW50IHRvIHBh
c3MgYW5vdGhlciBhcmd1bWVudCB0byBraWNrX3RyYW5zZmVyIGJlY2F1c2UgaXQNCj4gc2hvdWxk
IGJlIHVubmVjZXNzYXJ5OiB0aGUgY3VycmVudCByZXF1ZXN0IHNob3VsZCAqYWx3YXlzKiBiZSB0
aGUgbGFzdA0KPiBvbmUgaW4gdGhlIGxpc3QuIFRoZXJlZm9yZSB3ZSBzaG91bGQgcmVseSBvbiBz
b21ldGhpbmcgbGlrZQ0KPiBsaXN0X2xhc3RfZW50cnkoKSBmb2xsb3dlZCBieSBsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmVfcmV2ZXJzZSgpIHRvDQo+IGhhbmRsZSB0aGlzIHdpdGhvdXQgYSBzcGVj
aWFsIGNhc2UuDQo+IA0KPiByZXQgPSBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCgpOw0KPiBpZiAo
cmV0IDwgMCkgew0KPiAJY3VycmVudCA9IGxpc3RfbGFzdF9lbnRyeSgpOw0KPiANCj4gCXVubWFw
KGN1cnJlbnQpOw0KPiAgICAgICAgIGZvcl9lYWNoX3RyYl9pbihjdXJyZW50KSB7DQo+ICAgICAg
ICAgCWNsZWFyX0hXTyh0cmIpOw0KPiAgICAgICAgIH0NCj4gDQo+IAlsaXN0X2Zvcl9lbnRyeV9z
YWZlX3JldmVyc2UoKSB7DQo+ICAgICAgICAgCW1vdmVfY2FuY2VsbGVkKCk7DQo+ICAgICAgICAg
fQ0KPiB9DQo+IA0KDQpIaSBGZWxpcGUsDQoNClRoaXMgd29uJ3Qgd29yay4gVGhlIHF1ZXVlZCBy
ZXF1ZXN0IG1heSBub3QgaGF2ZSBsZWZ0IHRoZSBwZW5kaW5nX2xpc3QNCmFuZCBuZXZlciBzdGFy
dGVkIGF0IGFsbCAoZS5nLiBkdWUgdG8gbm8gYXZhaWxhYmxlIFRSQikuIFNvIHdlIGNhbid0DQpz
aW1wbHkgZ2V0IHRoZSBsYXN0IGVudHJ5IG9mIHdoaWNoZXZlciBsaXN0IHdpdGhvdXQgY2hlY2tp
bmcgd2hpY2gNCnJlcXVlc3QgaXMgYmVpbmcgcXVldWVkLiBTZWUgbXkgc3VnZ2VzdGlvbnMgYW5k
IHJlc3BvbnNlIHRvIEFsYW4ncyBjb21tZW50Lg0KDQpUaGFua3MsDQpUaGluaA0K
