Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C449B3584F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhDHNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:40:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45578 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231601AbhDHNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:40:51 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A4688C09DB;
        Thu,  8 Apr 2021 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889240; bh=sLg49U+W25BbMSLpqfpaX+3fCT/RAaRowKryz/aBwZM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k7GU/AXnCWaTfCWq25kjc+D4QKHr/JqntW5C/zrbjObEE21LyFtI/LcqjTD64z8wB
         2vVxxCIICLKAp7nY7x7B5jk7UvtIEYaE+dXR7mrWoQ7xz94w5C36BB6D/ZyhT52bzM
         5zztaz2DHuAvcdFVLg91y9D7pr+fXzia+oHMI0P980x3tKeoej46bLRQo1NmFb4Yo3
         LrLHBWF4uAnjH4ghm+vU9uF4XRaDwBgf8oLgNBi4U+/v5L2T6ahWneKMrCG85F98I2
         39BJWf6LIxQPLn1UdCi3TgrPmrK0lfqy1/NfhlSbSLfmbYbbiJuuQlHPKzMakZzq0D
         7tD9zzjXk4Wqg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3EC3DA0084;
        Thu,  8 Apr 2021 13:40:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 17A77400CC;
        Thu,  8 Apr 2021 13:40:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="d/VIsw5O";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3lsopMs6yQ4kAjwlu1bseoIb9ecjNGoeGgdiahz3M2S83nYuCG7Rax1rut4n0oIP9TtwOjY2WOPFIJaIJx0H/5lqqoXQa+rL2gKEzw3X1fkioXEfXZNe3r4WYBRInwt7lkawHFE8dbvFaGBBBRCyJegfWKWdDYo4JMCdpkA3j8sSJDfypnF8jtgI3Fvmsz9scWvIzQvJksZEYP0XcZ88fa+VAlGBcI7kxuakI9/u5jpz8HqSFOXCulCIs8PxeLiH7AKR/BhjxH8L5X81KXA72WgJ5v2HwCG1cHtJahOTV44a50Dpm6ZmqVtT91mMfYuWSn/y8RkdKIL46aFKpAgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLg49U+W25BbMSLpqfpaX+3fCT/RAaRowKryz/aBwZM=;
 b=VZyFLU1Vwuo9U+MLopf5+JP+WEblIkKS0g5nb8kHEZlYIkbUOc76eYEm6t/0qlFLt7VBiCoDfIFaIlS62LJm/rjoTx6mZfCaDxA6ihjZetm6WjEBsCyUNaJ51S9L8NOquFT2Eh3ZqDJCO+7rXaEV0TlFktoM/vh1iamaNd1LAttV3KgZo+gc2CIRNq5v+R+HEPH+vH1iXPak7gRcFO1cgF2yAHsN+SO4cu9jniyQKMBZ5aTzy8szxHIn3d5oS3Kjp/FAkdR1u7Z1qrYHv9SwXUOxXAJ65P+2rzZBMyre8176HYYDiN2L/ic8DAzo+UZ1KUyPIhRV9U+2iK1jeze2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLg49U+W25BbMSLpqfpaX+3fCT/RAaRowKryz/aBwZM=;
 b=d/VIsw5OCwzbDY3V+N7R78niXln2sTw2KyWhBNjxnaWZD1Ru4wGepZdb6MAn5+v7bvLSr1FDvY67S09sdBKq5PASW7t731G/bgVX+U9/mnwxVJIp/Uy7i1wB8yHgtwZ7zQ+FX6TcXoJGm+p11IJZ4J3typCuqOQMb0/FSUt4oas=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 13:40:36 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:40:36 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 12/14] usb: dwc2: Update partial power down entering by
 system suspend
Thread-Topic: [PATCH v3 12/14] usb: dwc2: Update partial power down entering
 by system suspend
Thread-Index: AQHXLFv9Gix2/inv8UWsrChuzhKdAqqqoMmA
Date:   Thu, 8 Apr 2021 13:40:36 +0000
Message-ID: <05ab1c3e-b668-5d4e-7373-d4ba50120eb7@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094559.33541A022E@mailhost.synopsys.com>
In-Reply-To: <20210408094559.33541A022E@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a304959-2c02-4532-9e49-08d8fa93e43d
x-ms-traffictypediagnostic: BYAPR12MB4630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB46304826DA7DFA1FC0CE7433A7749@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EHew6BhEVEtAnY/gaJZMaOjG43RBiew0WGaTRf2D5S66T3pyJLDeaVLXWTjjPWNIktZIVMg8c1misFHAxIVEFqSVMeKToTYH4G1enTPeNRSboUTW4XYQvgAybnrLl+WHgicxFVx+Jyqd5HiQda5qKxgU9lyByxMeCJJXiNAFchAFVJ7PiV8ZMVcGGlfG0e1LJnNwfuTkxbLxD/YaJQrMMqy91Ud82ACU3AonqZsCU2PdJCIbvbRGcZXiBlM0tih2VaA0xsTNyBgU2I1jv6hZbukwpaWmaV0Bm6Xj2maLKE9PUOCGXVnYx2t4bmhu8F+sBAfpAS5v/Gxtxjk82EcpwYnfz923f6YatkkgfgjhBrP1PivQLYww35HlBuKQuJTbpuYiLJDKVAqMCISfCJTURfj8PpHcJPDoHGEU8ok7XHuNVpoYIXSZ9VQD85NmkprK6+0AaBFdS0SFchRweYH1OL3hWsdtyywuhQ5sS0nCiyKVz/C4LV3JCUnV6J5bWDahIDQrgX1mRFo1hAxV2XGOLLJRPmN/6O0RwdRFIKE6z4z70/e1tU7yKVzi0o9falKBdoRmOZKSgvxJeO3d5svbmDYW8S3ljtpIH9hRMx1QJptup5xaZh8gLuOS7YtqSlnvB5VmHrGmBaWy3vTDNPvRWdH5TfKYC93RhRR5/Hsfh94rUXtvUEvIifwC+XiVVvi2m0aDVUobgkw+rKEqDbgGoLtceqLkK1imtLdI3YN+Xpw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(6486002)(38100700001)(2616005)(26005)(186003)(91956017)(76116006)(316002)(2906002)(110136005)(71200400001)(36756003)(4326008)(64756008)(66556008)(107886003)(86362001)(66946007)(66446008)(6506007)(53546011)(478600001)(66476007)(6512007)(31696002)(31686004)(83380400001)(5660300002)(8676002)(8936002)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N09zZjY3c0IwVHphbWcvd3pTSEZpRkVibk9IMHFPQU45Zlpza0YxdjVLc25h?=
 =?utf-8?B?RFlOMnh6ayttZ1EyeHB3TGZxV1I0Njk0aXJjRWhZN1lYUGRDYW1aeG5aV0xo?=
 =?utf-8?B?MW4wL1NFemtRYjFvSUJONWVrS3A2TDR4OWRSNXhPWmNKMHpZeEdxQ284UHFQ?=
 =?utf-8?B?TDh6RXY5NkVRZjNDcDAvalNoMktGUDBSajY3QWkwQmx2WWhHN3JrUStWRnc1?=
 =?utf-8?B?T2xPYUxmNk45eHdLRkJDRWp3TXFvcEE5dFI1VWJEMk5EWGc1aHBWTmQvU1ZV?=
 =?utf-8?B?N2hCNmw0UmpBVmFrc0p1RlNlTEVqK1hiRjUyMWF4NzFnblZmWkRlYlBwWUJy?=
 =?utf-8?B?WjhtcVJpZUl5azJqK0VZYTI1QUVHby93a1YxZkNMNEczelFKaXhpb2RndWNL?=
 =?utf-8?B?eG9GRDZJNHg0TjV4MHYwRFU0MFQ5ajdOV1lQejBuelBqd0hoc3pzZENvbTVV?=
 =?utf-8?B?YkNPL0I0RHRiemxiSzA3U0lwMGFTT2N2Q0xmU0NQV2hGSDZIUDkzRno2Y1M5?=
 =?utf-8?B?TDNjZ1pSMWtKRkR2NENrZFVObUZJRVlZVFNPTkM3bEF4WFgzeDZZZDkvc3BY?=
 =?utf-8?B?eGJzNE1sRVBCSGtkYlBEVkFadk1ZTVQ2TDhnYkhxSDdrZ0twR29SYmg2UjIz?=
 =?utf-8?B?UWxobmRGNXRGeGtBdGdEbEVKQ2krUnJpeHhRc1d3TGtiT1FmM2RpZXBxSmVi?=
 =?utf-8?B?aExtZ091K3BVdk5NNktvdGU5NjhsZnhFT3BjSk9uRytyWlZjTWY0SllRNkZB?=
 =?utf-8?B?NGFXemdqc21saXJhRXlRMGFQMzlWMkh5U1h6WXhYaUtBV2ZXamJ0VDY4RlYz?=
 =?utf-8?B?N3lQa0l5UnFUU3JsRTExTVpDcWxpVURMTXAzRmhrNDVuRzEyUXZLTDBxZ3Zh?=
 =?utf-8?B?NUdycVBBbGtqazJScHZBM2lPR3Bwb213eWl1ZVBXZ3ZpWnhtZmlFZXRyY3Bm?=
 =?utf-8?B?WXh3U2orTlBwNEg0UytZaVhLWEYzUElvOG5oNHBaNWlhRVk3T0tyZERjc2NH?=
 =?utf-8?B?L0svbUNVNDNuK2trNDg5SkY2ZE5sM281c1ZJK2FmcGJGeHdTOS8vUDNFWVZm?=
 =?utf-8?B?WEdDdkgxMTBvMVhHS2c2aVRBd1FoWDNIb1B2YmxjWWROQm13L3JFMGZ5TGw5?=
 =?utf-8?B?ZTV4TGF5K3g3RVRjcGVwSlBoWUpnNTZTUGt1cFIreTFodnNTNFBTWEQwbS9y?=
 =?utf-8?B?ckhrZ1NZZnRZNDRTTHdXazJyQkdiSW5MR2pzZDlSQWtLY3gvSnBOV2diZ09r?=
 =?utf-8?B?WDBMWmwwcXhuTVdsTklDa0VVZWs0MDhNUk40QnVVekF6c1E3S1UyOEhFdElT?=
 =?utf-8?B?MThzODV4RGtKR3RLZ1pheWEvb3U5eW9JRXdpM0FRNWhkU1IvaHZWLzhvSDBH?=
 =?utf-8?B?REhHZ2dxRFloNi9vQnVDYkNselJRTHF6bkxIN1d6eXhkd2I2RlVsdmR5UWti?=
 =?utf-8?B?UzliV3BCTHVJbVljREJhMVVDaGxDNTJrUU0yVnZLaEJZZmdaQ1dqT0RIT0hM?=
 =?utf-8?B?ZEE5ZjltMW5mN3hqZnMrV1lWeG8xd2ozbTlla21OU3NMRXpXSVF1K0hhTWdz?=
 =?utf-8?B?M1AyTFN1dyszcnlnNjBycHNQTEtlNjEyMUMzeVVCVGVKWUpCMDlpUCtncGo5?=
 =?utf-8?B?K0FvUklFTU9tU2xQeElOZFFTa2hCMnhRUGNTM0FtZlhIam9ONE1weHNwaEt3?=
 =?utf-8?B?WU1pZmQ0WXdkT0lNSm1zeDJtV0F1UWFyU2x3VzQ1SDhEalFGVTBoMUNkdzYr?=
 =?utf-8?Q?G5dlxUsKc09zwFU41w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEB98C8F9496BA44BCCD2E012C67C545@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a304959-2c02-4532-9e49-08d8fa93e43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:40:36.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EscWQd9wdm5ZQKLSss10ns6fpxOB1ZtyavyLBYhrZlkfV7R7M4ZxKW0vxU+tUi3Px+XKTiDLby2UpZkRuKs7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NSBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBXaXRoIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gdGhlIHBvcnQgcG93ZXIgaXMgYmVpbmcgZGlzYWJsZWQsDQo+IHdo
aWNoIGlzIG5vdCByZXF1aXJlZCBieSB0aGUgcHJvZ3JhbW1pbmcgZ3VpZGUuIEFsc28sIGlmIHRo
ZXJlDQo+IGlzIGEgc3lzdGVtIHdoaWNoIHdvcmtzIG9ubHkgaW4gIkRXQzJfUE9XRVJfRE9XTl9Q
QVJBTV9OT05FIg0KPiAoY2xvY2sgZ2F0aW5nKSBtb2RlIHRoZSBjdXJyZW50IGltcGxlbWVudGF0
aW9uIGRvZXMgbm90IHNldA0KPiBHYXRlIGhjbGsgYml0IGluIHBjZ2N0bCByZWdpc3Rlci4NCj4g
DQo+IFJlYXJyYW5nZXMgYW5kIHVwZGF0ZXMgdGhlIGltcGxlbWVudGF0aW9uIG9mIGVudGVyaW5n
IHRvIHBhcnRpYWwNCj4gcG93ZXIgZG93biBwb3dlciBzYXZpbmcgbW9kZSB3aGVuIFBDIGlzIHN1
c3BlbmRlZCB0byBnZXQNCj4gcmlkIG9mIG1hbnkgImlmIiBzdGF0ZW1lbnRzIGFuZCByZW1vdmVz
IGRpc2FibGluZyBvZiBwb3J0IHBvd2VyLg0KPiANCj4gTk9URTogU3dpdGNoIGNhc2Ugc3RhdGVt
ZW50IGlzIHVzZWQgZm9yIGhpYmVybmF0aW9uIHBhcnRpYWwNCj4gcG93ZXIgZG93biBhbmQgY2xv
Y2sgZ2F0aW5nIG1vZGUgZGV0ZXJtaW5hdGlvbi4gSW4gdGhpcyBwYXRjaA0KPiBvbmx5IFBhcnRp
YWwgUG93ZXIgRG93biBpcyBpbXBsZW1lbnRlZCB0aGUgSGliZXJuYXRpb24gYW5kDQo+IGNsb2Nr
IGdhdGluZyBpbXBsZW1lbnRhdGlvbnMgYXJlIHBsYW5uZWQgdG8gYmUgYWRkZWQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBcnR1ciBQZXRyb3N5YW4gPEFydGh1ci5QZXRyb3N5YW5Ac3lub3BzeXMu
Y29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5
bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBDaGFuZ2VzIGluIHYzOg0KPiAgIC0gTm9uZQ0KPiAg
IENoYW5nZXMgaW4gdjI6DQo+ICAgLSBOb25lDQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvaGNk
LmMgfCA1MyArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNk
LmMNCj4gaW5kZXggY2I1MmJjNDFiZmI4Li4zNDAzMGJhZmRmZjQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBA
QCAtNDM2Nyw4ICs0MzY3LDYgQEAgc3RhdGljIGludCBfZHdjMl9oY2Rfc3VzcGVuZChzdHJ1Y3Qg
dXNiX2hjZCAqaGNkKQ0KPiAgIAlzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcgPSBkd2MyX2hjZF90
b19oc290ZyhoY2QpOw0KPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgIAlpbnQgcmV0ID0g
MDsNCj4gLQl1MzIgaHBydDA7DQo+IC0JdTMyIHBjZ2N0bDsNCj4gICANCj4gICAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+ICAgDQo+IEBAIC00Mzg0LDQ3ICs0Mzgy
LDMyIEBAIHN0YXRpYyBpbnQgX2R3YzJfaGNkX3N1c3BlbmQoc3RydWN0IHVzYl9oY2QgKmhjZCkN
Cj4gICAJaWYgKGhzb3RnLT5vcF9zdGF0ZSA9PSBPVEdfU1RBVEVfQl9QRVJJUEhFUkFMKQ0KPiAg
IAkJZ290byB1bmxvY2s7DQo+ICAgDQo+IC0JaWYgKGhzb3RnLT5wYXJhbXMucG93ZXJfZG93biAh
PSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fUEFSVElBTCB8fA0KPiAtCSAgICBoc290Zy0+ZmxhZ3Mu
Yi5wb3J0X2Nvbm5lY3Rfc3RhdHVzID09IDApDQo+ICsJaWYgKGhzb3RnLT5idXNfc3VzcGVuZGVk
KQ0KPiAgIAkJZ290byBza2lwX3Bvd2VyX3NhdmluZzsNCj4gICANCj4gLQkvKg0KPiAtCSAqIERy
aXZlIFVTQiBzdXNwZW5kIGFuZCBkaXNhYmxlIHBvcnQgUG93ZXINCj4gLQkgKiBpZiB1c2IgYnVz
IGlzIG5vdCBzdXNwZW5kZWQuDQo+IC0JICovDQo+IC0JaWYgKCFoc290Zy0+YnVzX3N1c3BlbmRl
ZCkgew0KPiAtCQlocHJ0MCA9IGR3YzJfcmVhZF9ocHJ0MChoc290Zyk7DQo+IC0JCWlmIChocHJ0
MCAmIEhQUlQwX0NPTk5TVFMpIHsNCj4gLQkJCWhwcnQwIHw9IEhQUlQwX1NVU1A7DQo+IC0JCQlp
ZiAoaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duID09IERXQzJfUE9XRVJfRE9XTl9QQVJBTV9QQVJU
SUFMKQ0KPiAtCQkJCWhwcnQwICY9IH5IUFJUMF9QV1I7DQo+IC0JCQlkd2MyX3dyaXRlbChoc290
ZywgaHBydDAsIEhQUlQwKTsNCj4gLQkJfQ0KPiAtCQlpZiAoaHNvdGctPnBhcmFtcy5wb3dlcl9k
b3duID09IERXQzJfUE9XRVJfRE9XTl9QQVJBTV9QQVJUSUFMKSB7DQo+IC0JCQlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZoc290Zy0+bG9jaywgZmxhZ3MpOw0KPiAtCQkJZHdjMl92YnVzX3N1cHBs
eV9leGl0KGhzb3RnKTsNCj4gLQkJCXNwaW5fbG9ja19pcnFzYXZlKCZoc290Zy0+bG9jaywgZmxh
Z3MpOw0KPiAtCQl9IGVsc2Ugew0KPiAtCQkJcGNnY3RsID0gcmVhZGwoaHNvdGctPnJlZ3MgKyBQ
Q0dDVEwpOw0KPiAtCQkJcGNnY3RsIHw9IFBDR0NUTF9TVE9QUENMSzsNCj4gLQkJCXdyaXRlbChw
Y2djdGwsIGhzb3RnLT5yZWdzICsgUENHQ1RMKTsNCj4gLQkJfQ0KPiAtCX0NCj4gKwlpZiAoaHNv
dGctPmZsYWdzLmIucG9ydF9jb25uZWN0X3N0YXR1cyA9PSAwKQ0KPiArCQlnb3RvIHNraXBfcG93
ZXJfc2F2aW5nOw0KPiAgIA0KPiAtCWlmIChoc290Zy0+cGFyYW1zLnBvd2VyX2Rvd24gPT0gRFdD
Ml9QT1dFUl9ET1dOX1BBUkFNX1BBUlRJQUwpIHsNCj4gKwlzd2l0Y2ggKGhzb3RnLT5wYXJhbXMu
cG93ZXJfZG93bikgew0KPiArCWNhc2UgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX1BBUlRJQUw6DQo+
ICAgCQkvKiBFbnRlciBwYXJ0aWFsX3Bvd2VyX2Rvd24gKi8NCj4gICAJCXJldCA9IGR3YzJfZW50
ZXJfcGFydGlhbF9wb3dlcl9kb3duKGhzb3RnKTsNCj4gLQkJaWYgKHJldCkgew0KPiAtCQkJaWYg
KHJldCAhPSAtRU5PVFNVUFApDQo+IC0JCQkJZGV2X2Vycihoc290Zy0+ZGV2LA0KPiAtCQkJCQki
ZW50ZXIgcGFydGlhbF9wb3dlcl9kb3duIGZhaWxlZFxuIik7DQo+IC0JCQlnb3RvIHNraXBfcG93
ZXJfc2F2aW5nOw0KPiAtCQl9DQo+IC0NCj4gLQkJLyogQWZ0ZXIgZW50ZXJpbmcgcGFydGlhbF9w
b3dlcl9kb3duLCBoYXJkd2FyZSBpcyBubyBtb3JlIGFjY2Vzc2libGUgKi8NCj4gKwkJaWYgKHJl
dCkNCj4gKwkJCWRldl9lcnIoaHNvdGctPmRldiwNCj4gKwkJCQkiZW50ZXIgcGFydGlhbF9wb3dl
cl9kb3duIGZhaWxlZFxuIik7DQo+ICsJCS8qIEFmdGVyIGVudGVyaW5nIHN1c3BlbmQsIGhhcmR3
YXJlIGlzIG5vdCBhY2Nlc3NpYmxlICovDQo+ICAgCQljbGVhcl9iaXQoSENEX0ZMQUdfSFdfQUND
RVNTSUJMRSwgJmhjZC0+ZmxhZ3MpOw0KPiArCQlicmVhazsNCj4gKwljYXNlIERXQzJfUE9XRVJf
RE9XTl9QQVJBTV9ISUJFUk5BVElPTjoNCj4gKwljYXNlIERXQzJfUE9XRVJfRE9XTl9QQVJBTV9O
T05FOg0KPiArCWRlZmF1bHQ6DQo+ICsJCWdvdG8gc2tpcF9wb3dlcl9zYXZpbmc7DQo+ICAgCX0N
Cj4gICANCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc290Zy0+bG9jaywgZmxhZ3MpOw0K
PiArCWR3YzJfdmJ1c19zdXBwbHlfZXhpdChoc290Zyk7DQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUo
Jmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+ICsNCj4gICAJLyogQXNrIHBoeSB0byBiZSBzdXNwZW5k
ZWQgKi8NCj4gICAJaWYgKCFJU19FUlJfT1JfTlVMTChoc290Zy0+dXBoeSkpIHsNCj4gICAJCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+IA0KDQo=
