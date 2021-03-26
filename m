Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7168434B0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCZUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:49:44 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36798 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhCZUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:49:22 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9000C00D1;
        Fri, 26 Mar 2021 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616791762; bh=fsKuGDTgTlFfErK2yQv4ALynX5OeV2fdr+On57cOW0k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Rj+ZAAgzIwDWTaG/mf/p99WCNmxETxM1Ce3X8MVYb3yQCD70Djxh0YT8Se+gadROZ
         BnPvBomAz8swD22YcGsnqlLU9yEEvRTKj47q0p4YZaDHLg7Gx1xUnh5hfPFTVC5hy+
         D0pimGixeUoS2BSJ0dU0/eyQp5lx/GquG3/wMj1wx1GzZSM7RtslqmlGwHDujxqryI
         J1xVb3U079bAgLv6qrtz0uGXBuijTccpmvJqtFVqjDIdMaOykGLkMtwSaSVk36sn9M
         66UfXt/9YLbESLugGBNsgF0mbL+vn3Z7GWXxGRrnfjrqh4tampPtx8yV0GF33vJWxr
         b6R8ZOw0kefxw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 10CC7A0082;
        Fri, 26 Mar 2021 20:49:21 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2C2CB80145;
        Fri, 26 Mar 2021 20:49:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XcUoXksU";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6FN9d1TdpZScyFXuvCrhV2KnLkQtOMkajw7HzRXEj3Ds9ACSOo/W6JPoh9Plfs/DW5xV7ra/AQKAVaTVAol8Ps7EdQFcHcxoZWvTUMMUa/my79P6C5iGb3ksJfdrazCf+FOUxmRwoe3NYPRPJf4sah9aMnP9vLZleTtQYlePEQteBS23SdW+0mpA74T0YVrMTTDdtmV2SM4jNnoHXzPc9mLLjSVYDHcmFU9pDQdxlYWIVsJZJ3PJ2co4YgKHJSW2nLPcd+kSGN9rQ2n+Oe4jvK7ZU4HLAJTJTSVaBXFVWBaGc0Hk3hvFTw8uzt3flQjav9PnBFWRwwFbJ5WmVZQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsKuGDTgTlFfErK2yQv4ALynX5OeV2fdr+On57cOW0k=;
 b=f2/UZvV8aDiu10xVh6vgIyLF2d+l253bnGpGDwgczb7pUrJe7i/6CRbkDkS3uFH/9i3nTxKKBSzwySO2YZj1u6iRwKqMfaANm2AnjXOulMoZ0wU7w66V5DAB/XWjYa7UiHMn+ByeHrVrcDV8gsZQAKvrsrXBsDDA3winKOJqzUxlKY1L5T2mwlBOsXMCf5PoOB0+Z971lJ0sUcnbeBOi/TNpC4SbvD8s+dSbTUE7BTkF1uU77CnGOrun0ROcNGcRI46EMAn0H5NnGeXD2xOgvSQ6HylOAoVXUEM2qhFhkjE+N7SM8FeP9ee2X0kD62zeUVlLn26AaZ5V/dNaDQYDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsKuGDTgTlFfErK2yQv4ALynX5OeV2fdr+On57cOW0k=;
 b=XcUoXksULNTyyMs53IWahRx9krUIGXi3Qtv1CsB0bFJKTMLkvJY4SlLooj9HrXQ2j2lFjCDr1D3ZAy/kOcUuIG6R7QzPVX8vWk/79r/kIeS50p2Kx6QgFRwq19xvGbQcHaPRVDo69RBpXwnRU/+ucyjZEpnTdt/iovZw1xi9YSA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 20:49:18 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 20:49:17 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ray Chi <raychi@google.com>, "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "albertccwang@google.com" <albertccwang@google.com>
Subject: Re: [Patch v2] usb: dwc3: add cancelled reasons for dwc3 requests
Thread-Topic: [Patch v2] usb: dwc3: add cancelled reasons for dwc3 requests
Thread-Index: AQHXIl/J9U1tCpS8406PGZ2EQHyeTaqWvjgA
Date:   Fri, 26 Mar 2021 20:49:17 +0000
Message-ID: <56b45ecf-c048-e37b-8801-09876f787f6c@synopsys.com>
References: <20210326164753.1537417-1-raychi@google.com>
In-Reply-To: <20210326164753.1537417-1-raychi@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e4c76ed-010c-47b9-3cac-08d8f0989fc4
x-ms-traffictypediagnostic: BY5PR12MB4019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4019849000FC38DD2A9CB299AA619@BY5PR12MB4019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qbr1fzeIp1Fc1lzUSv9ECPuI6W2sfpFj8VyNSHRnTi9DFWNuEE5KqaWtbqPsvYyTVl/cSwyOvnz7JLN7kvwyQFG2K5eCIYlCegdboGooH0yvmomb/0BtO4XIKbEjnK4ynNvSh8sHZtNQKN4AaKwQZ/84Qtg3H2OPGHPicwafTZjzM8vRn10W4ZjNAwguLQX3988JI3aGTqpxs4M6FtS6O6ooXsdnixE86DeLVyiq3cMoGDmRzfyb4o1veNAPWVvoS8AfYNDYH0eQ2/OTQVP9uUHMUqFW8Inm/u0tvJfKIzMGR1BBRfYO5u3GCh6NL4Tb6ZM58E1BMScbm14Enb0C7XZtlEHQg+xe/lpItUAgwDdL/FXT0AhFzx627YNZH0ZT5ebyViBMuKE5BSrJ43xr3LhW0gtdMzSmj3WKj4wX5M8lBNIzVhInCxbe54ymOdIHXV1xADj2oRIpceywu1Cfpe6j9XS8lBAhbqIhwBDJYQQB4s2vmFo1GOAuOuePVx9xOkjxeDZ8Cj+letBNVCTX2IySVdOxNVAcgaXlu7CVZxSVv0R+NpWXI3UovGhLMSg+3+1NrlRoJjZWL3jjv3anypLcemnSVmD66K74uHF1lzacsEAAScU2YpjsGglSIphQrhgz/sW5W+3Ll4TG5scO1b1iXwaAJ4OFL4AGC9P+u8SxEUn+Z8X/LnyAfmjS0zejQB5v4UBUFGD54i3rK1A81kQM6+zZyLU0ncb5SIDgND0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(136003)(366004)(31686004)(54906003)(478600001)(110136005)(38100700001)(6486002)(86362001)(83380400001)(316002)(5660300002)(2906002)(2616005)(186003)(66556008)(31696002)(76116006)(36756003)(4326008)(26005)(71200400001)(6506007)(66446008)(64756008)(66476007)(8936002)(66946007)(8676002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SjRnam5ER0JROXNmdzJ2ZlU3U1FHaFRCdklsTHh3RnFhS0ZhMzk1L3VWZmly?=
 =?utf-8?B?VS80dDB6Q0ptdGtldS9LditLSVpkTDBUZ25Ba295Wm9PeGpSdE8wdEJJOU04?=
 =?utf-8?B?dk10eE4yMXZqaEZNQW1TZlZjcW9ab3VaUTJtUFJKdTUvdzJLY2xNVG5NWVVI?=
 =?utf-8?B?dVFZSlN1TkVBQU5BTnVZWTJSNGxOZVpSMXh6OFRlMCtCaG1kWVd5VTdYMlN1?=
 =?utf-8?B?NCsxOEo2ZzYydWdsQ3NLelpUa1FvSkFoMXRiZnFyWW5DeWdjQmdYbE5qcTdG?=
 =?utf-8?B?bHQ1dGhpYXpkNm1SYklzOUExeEFpK2RZK0Z6eU9IbWl3MWV6Sjc2UUlrMlNl?=
 =?utf-8?B?R2RKNEkvOVZqMzFLV2I5R3NhWng0TmZrOXZTYWtJVysvcXVhaHZxdG9jQ1kx?=
 =?utf-8?B?cGdGZ0c5RFRERVRDbVNMMnh2aGxLd3N4eThkcUEydDd6T0RmeGM0KzBTdVIy?=
 =?utf-8?B?U1dXVDYrZ0RRcjhXQ3dRenlGZ01BM3BNckxzY3hXMWNwM2ZEdmZTdTNYRnBW?=
 =?utf-8?B?ak44SDd6cG9BU3ppcXNlejJjRHhCaUZUTUtnTDdpeWU2OVplVkNCOGNQdkN5?=
 =?utf-8?B?V0RIc0NoVWEwbG5MUTZ5bmlpR1pXTWhQVVJZRlE1QjFqQXBldHh4bFJDZjBw?=
 =?utf-8?B?dUlGS2ZBRklLUFBKWDVHVkxsUm04TitHZHdMTEhnYlBxc3kvZDllTzd6TUd1?=
 =?utf-8?B?R1h0QXA3TkpvWEduclNKaDlJemc3anVuOXRrUkVlWFl2RGh4cklwUWMxT3hT?=
 =?utf-8?B?L3BBOFpLTVY3R1BQVnFMcnhoaGV1SmZPb1lBV1pCUktLVDYrN0p0aytwOTdy?=
 =?utf-8?B?RmxqU0JxUXJ6WkVTTW5XYnBxNmhRMFpWNXgrdjRLcWFCbVhQVFJ0V04rcGtL?=
 =?utf-8?B?TzhJMTZMcnVKSVFzZ05oK2xOem8rVS9nVjRRdXlwYzlTM2F2MDZCMDB4dWkz?=
 =?utf-8?B?QjFXQTg0LzNZV3YydE4zMWZOQkc1MVJ2dUlnb2VaRzF1czBxV20vcllibTE3?=
 =?utf-8?B?NSsvZzdRQ0ZMQ0E1SFJIc1Z2VGZSdFN6T2pxZTc4OTg5bjRaNmVqUnJqdFo1?=
 =?utf-8?B?QjdKdlRjWERvRVZxbWcxbVRySklTRjUyd1RyNUV3b2tHbWtnUG1RL3J5ak5H?=
 =?utf-8?B?Zjl4VXBjeUl1VVBHb2c1K3diQTgwMEVPdWpLem5DbXB2MjNUc25PN3V1bTNE?=
 =?utf-8?B?ZllzZFFVbWdBWERKYW16NjVkbXFnWGU0VS8yVVhJTmNCMEttK2VHcVlqcFR2?=
 =?utf-8?B?YUtCWU5aWlN6c2RqbzV3UWIxS1JUdmVVbU5VTnFRQXlseUo2MytNZHZRNzZq?=
 =?utf-8?B?ZzFOYSs0VGwzSEdJTDFEeXJndzNtdWdkMk1MT1hjOWxMVUg0cFBxVUpNb2Np?=
 =?utf-8?B?cXFidktDNldaL1l2L1pCVVlOQzg3Q3ZKcTNIV1FnZngraWRhZFMrNG9US09M?=
 =?utf-8?B?amJZK2E4YXdQZWxnbSs1V2dxaDV6aHVaVWdiRnlGNjRKS244WHR6cFNPZU90?=
 =?utf-8?B?a21BQlVUTVFYa3oxREpOWm1Kc2kyK0JFcFdGbE5KYzJOQnozQ1M1bEJFVmlN?=
 =?utf-8?B?c0FZbGQ0TGhDVUJiYmxVYkZ2cGE2M1B4YVhYQi9wdkdvQUdmSXFSempNMVor?=
 =?utf-8?B?QVAzRXExZ05qV3hNSUlyb1B3bXFUdG1ZbFg5VFJYRHVwUldXWlBRejgwSWVp?=
 =?utf-8?B?QVBFaUlTaXRXR1JKMElvZmc4elB2NjdQL1dEWWJkK1UyTldVcUtnZVJoZmM0?=
 =?utf-8?Q?RU9BLIvTmkjK5mRlLuG9UA42TS7cAZkNXw+VsNp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1D18BC3480B6468614FC5C5165E951@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4c76ed-010c-47b9-3cac-08d8f0989fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 20:49:17.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHxqYKuylzvCoOQ4/MxxoiWh3hUVNia6u2fj/Xny/Qqr8UhIzOEzMOujF5fQaLdy1EEbWwge6Sp64xqNEnuaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmF5LA0KDQpSYXkgQ2hpIHdyb3RlOg0KPiBDdXJyZW50bHksIHdoZW4gZHdjMyBoYW5kbGVz
IHJlcXVlc3QgY2FuY2VsbGVkLCBkd2MzIGp1c3QgcmV0dXJucw0KPiAtRUNPTk5SRVNFVCBmb3Ig
YWxsIHJlcXVlc3RzLiBJdCB3aWxsIGNhdXNlIFVTQiBmdW5jdGlvbiBkcml2ZXJzDQo+IGNhbid0
IGtub3cgaWYgdGhlIHJlcXVlc3RzIGFyZSBjYW5jZWxsZWQgYnkgb3RoZXIgcmVhc29ucy4NCj4g
DQo+IFRoaXMgcGF0Y2ggd2lsbCByZXBsYWNlIERXQzNfUkVRVUVTVF9TVEFUVVNfQ0FOQ0VMTEVE
IHdpdGggdGhlDQo+IHJlYXNvbnMgYmVsb3cuDQo+ICAgLSBEV0MzX1JFUVVFU1RfU1RBVFVTX0RJ
U0NPTk5FQ1RFRA0KPiAgIC0gRFdDM19SRVFVRVNUX1NUQVRVU19ERVFVRVVFRA0KPiAgIC0gRFdD
M19SRVFVRVNUX1NUQVRVU19TVEFMTEVEDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXkgQ2hpIDxy
YXljaGlAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwg
MTIgKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMjEgKysrKysr
KysrKysrKysrKystLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oIHwgIDYgKysrKy0t
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gaW5kZXggNGNhNGI0YmU4NWU0Li41MWEzZWVjMjQyOGEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+IEBAIC05MDgsMTEgKzkwOCwxMyBAQCBzdHJ1Y3QgZHdjM19yZXF1ZXN0IHsNCj4g
IAl1bnNpZ25lZCBpbnQJCXJlbWFpbmluZzsNCj4gIA0KPiAgCXVuc2lnbmVkIGludAkJc3RhdHVz
Ow0KPiAtI2RlZmluZSBEV0MzX1JFUVVFU1RfU1RBVFVTX1FVRVVFRAkwDQo+IC0jZGVmaW5lIERX
QzNfUkVRVUVTVF9TVEFUVVNfU1RBUlRFRAkxDQo+IC0jZGVmaW5lIERXQzNfUkVRVUVTVF9TVEFU
VVNfQ0FOQ0VMTEVECTINCj4gLSNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19DT01QTEVURUQJ
Mw0KPiAtI2RlZmluZSBEV0MzX1JFUVVFU1RfU1RBVFVTX1VOS05PV04JLTENCj4gKyNkZWZpbmUg
RFdDM19SRVFVRVNUX1NUQVRVU19RVUVVRUQJCTANCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NU
QVRVU19TVEFSVEVECQkxDQo+ICsjZGVmaW5lIERXQzNfUkVRVUVTVF9TVEFUVVNfRElTQ09OTkVD
VEVECTINCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19ERVFVRVVFRAkJMw0KPiArI2Rl
ZmluZSBEV0MzX1JFUVVFU1RfU1RBVFVTX1NUQUxMRUQJCTQNCj4gKyNkZWZpbmUgRFdDM19SRVFV
RVNUX1NUQVRVU19DT01QTEVURUQJCTUNCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19V
TktOT1dOCQktMQ0KPiAgDQo+ICAJdTgJCQllcG51bTsNCj4gIAlzdHJ1Y3QgZHdjM190cmIJCSp0
cmI7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBlMTQ0MmZjNzYzZTEuLmIxMWZkMDI2MDRiYiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xNDAyLDcgKzE0MDIsNyBAQCBzdGF0aWMgaW50IF9fZHdj
M19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgCQlkd2MzX3N0
b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1ZSk7DQo+ICANCj4gIAkJbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9zYWZlKHJlcSwgdG1wLCAmZGVwLT5zdGFydGVkX2xpc3QsIGxpc3QpDQo+IC0J
CQlkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHJlcSk7DQo+ICsJCQlkd2MzX2dh
ZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHJlcSwgRFdDM19SRVFVRVNUX1NUQVRVU19ERVFV
RVVFRCk7DQo+ICANCj4gIAkJLyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5v
IGVuZCB0cmFuc2ZlciBwZW5kaW5nICovDQo+ICAJCWlmICghKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQ
X0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4gQEAgLTE3MzIsNyArMTczMiwxOSBAQCBzdGF0aWMg
dm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdj
M19lcCAqZGVwKQ0KPiAgDQo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHJlcSwgdG1wLCAm
ZGVwLT5jYW5jZWxsZWRfbGlzdCwgbGlzdCkgew0KPiAgCQlkd2MzX2dhZGdldF9lcF9za2lwX3Ry
YnMoZGVwLCByZXEpOw0KPiAtCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJlcSwgLUVDT05O
UkVTRVQpOw0KPiArCQlzd2l0Y2ggKHJlcS0+c3RhdHVzKSB7DQo+ICsJCWNhc2UgRFdDM19SRVFV
RVNUX1NUQVRVU19ESVNDT05ORUNURUQ6DQo+ICsJCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAs
IHJlcSwgLUVTSFVURE9XTik7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBEV0MzX1JFUVVFU1Rf
U1RBVFVTX0RFUVVFVUVEOg0KPiArCQkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVwLCByZXEsIC1F
Q09OTlJFU0VUKTsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIERXQzNfUkVRVUVTVF9TVEFUVVNf
U1RBTExFRDoNCj4gKwkJCWR3YzNfZ2FkZ2V0X2dpdmViYWNrKGRlcCwgcmVxLCAtRVBJUEUpOw0K
PiArCQkJYnJlYWs7DQo+ICsJCWRlZmF1bHQ6DQoNCkFsc28gZ2l2ZWJhY2sgdGhlIHJlcXVlc3Qg
Zm9yIGRlZmF1bHQgY2FzZSBoZXJlLCBidXQgd2l0aCAtRUNPTk5SRVNFVA0KYW5kIGEgZGV2X2Vy
cigpIHByaW50IGhlcmUgaW5kaWNhdGluZyBkcml2ZXIgYnVnLiBUaGUgcmVzdCBvZiB0aGUgcGF0
Y2gNCmxvb2tzIGdvb2QuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gKwkJCWJyZWFrOw0KPiArCQl9
DQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IEBAIC0xNzc2LDcgKzE3ODgsOCBAQCBzdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQo+ICAJCQkgKiBjYW5jZWxs
ZWQuDQo+ICAJCQkgKi8NCj4gIAkJCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShyLCB0LCAmZGVw
LT5zdGFydGVkX2xpc3QsIGxpc3QpDQo+IC0JCQkJZHdjM19nYWRnZXRfbW92ZV9jYW5jZWxsZWRf
cmVxdWVzdChyKTsNCj4gKwkJCQlkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHIs
DQo+ICsJCQkJCQlEV0MzX1JFUVVFU1RfU1RBVFVTX0RFUVVFVUVEKTsNCj4gIA0KPiAgCQkJZGVw
LT5mbGFncyAmPSB+RFdDM19FUF9XQUlUX1RSQU5TRkVSX0NPTVBMRVRFOw0KPiAgDQo+IEBAIC0x
ODQ4LDcgKzE4NjEsNyBAQCBpbnQgX19kd2MzX2dhZGdldF9lcF9zZXRfaGFsdChzdHJ1Y3QgZHdj
M19lcCAqZGVwLCBpbnQgdmFsdWUsIGludCBwcm90b2NvbCkNCj4gIAkJZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiAgDQo+ICAJCWxpc3RfZm9yX2VhY2hfZW50
cnlfc2FmZShyZXEsIHRtcCwgJmRlcC0+c3RhcnRlZF9saXN0LCBsaXN0KQ0KPiAtCQkJZHdjM19n
YWRnZXRfbW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEpOw0KPiArCQkJZHdjM19nYWRnZXRfbW92
ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEsIERXQzNfUkVRVUVTVF9TVEFUVVNfU1RBTExFRCk7DQo+
ICANCj4gIAkJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSB7
DQo+ICAJCQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfUEVORElOR19DTEVBUl9TVEFMTDsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmggYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5oDQo+IGluZGV4IDBjZDI4MTk0OTk3MC4uNzdkZjRiNmQ2YzEzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmgNCj4gQEAgLTkwLDE1ICs5MCwxNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZHdjM19nYWRn
ZXRfbW92ZV9zdGFydGVkX3JlcXVlc3Qoc3RydWN0IGR3YzNfcmVxdWVzdCAqcmVxKQ0KPiAgLyoq
DQo+ICAgKiBkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0IC0gbW92ZSBAcmVxIHRv
IHRoZSBjYW5jZWxsZWRfbGlzdA0KPiAgICogQHJlcTogdGhlIHJlcXVlc3QgdG8gYmUgbW92ZWQN
Cj4gKyAqIEByZWFzb246IGNhbmNlbGxlZCByZWFzb24gZm9yIHRoZSBkd2MzIHJlcXVlc3QNCj4g
ICAqDQo+ICAgKiBDYWxsZXIgc2hvdWxkIHRha2UgY2FyZSBvZiBsb2NraW5nLiBUaGlzIGZ1bmN0
aW9uIHdpbGwgbW92ZSBAcmVxIGZyb20gaXRzDQo+ICAgKiBjdXJyZW50IGxpc3QgdG8gdGhlIGVu
ZHBvaW50J3MgY2FuY2VsbGVkX2xpc3QuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBk
d2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHN0cnVjdCBkd2MzX3JlcXVlc3QgKnJl
cSkNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1
ZXN0KHN0cnVjdCBkd2MzX3JlcXVlc3QgKnJlcSwNCj4gKwkJdW5zaWduZWQgaW50IHJlYXNvbikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19lcAkJKmRlcCA9IHJlcS0+ZGVwOw0KPiAgDQo+IC0JcmVx
LT5zdGF0dXMgPSBEV0MzX1JFUVVFU1RfU1RBVFVTX0NBTkNFTExFRDsNCj4gKwlyZXEtPnN0YXR1
cyA9IHJlYXNvbjsNCj4gIAlsaXN0X21vdmVfdGFpbCgmcmVxLT5saXN0LCAmZGVwLT5jYW5jZWxs
ZWRfbGlzdCk7DQo+ICB9DQo+ICANCj4gDQoNCg==
