Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A553C33335D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhCJCyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:54:22 -0500
Received: from mail-eopbgr1400123.outbound.protection.outlook.com ([40.107.140.123]:6422
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231235AbhCJCyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:54:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAtenZKAytTkwL6njpb99Jj7DRVqHnO2jcE7mGPmfw2daoLXNEOReBn2ed+sLbYKXe7M9iGeqT4ttl1FgLygZMdUYTFdYQDvZrrE66eGYwF2JlLHjJxKTkBcaxc/T4i+icHxSjjxK/hLilfso6UZF93X0G2GlmKMTKax7lbQqVSMHxuadDw/uQ8VLNVQGTLi8hqAKSSzrI6FSV3WPe/cok56J//Xu3IEBIvwXBFqhZl5jB3+gNdjGilC0s/MWM0HWHfrzwCEhVP9OuibwKU6XxoDiLmikoWnMuOJEjRxSkIFt2smlnHbCbk6pW7FF4h0msDY/VpsNXr3Isl+kJAVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlgbvhZG9HVwzN1fgAcbhnGHz4gcFN504sn+w06Xvkk=;
 b=Xiqp8HIzD/USFaw2DipQ0ttUbD0+rL8h8RBb9o+/Hkq122o00WoxeYWhwJ7UZb/NtmVaJfHe1thzBsdP1+EOihYanRvO/sLD1fNjsWkTEVQkdMsazSLfMfXeP8Tb+g5amrZTw1Y6RVcPaDOjl4bg2aG00qRkyC03Kv/kYZTEZKELLwYwu4Of+9EFwYzLwB9YZywfPvTY0BqUoAnHMIjRpwRk3KOGGbr/eGsHAKkD6x0fftaO8EmT+qiLa2jq3GhQk7CsZlLR+GWSbgU7W/AfOUj29O0QZ37U/AJzhGomAT5gY/XXiAfv4qoeNEq74799m8GboFbOyr+WVIh7By632A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlgbvhZG9HVwzN1fgAcbhnGHz4gcFN504sn+w06Xvkk=;
 b=U0RzQfHRbOCs/hh2PAdzpYOtbFCSUTXAIZ72wnEvPjXKqyo5dJebnWY7HuvfsHHpCTa+MNcAu1aKzbiqHOMv+TFwqSJ6hYt78j0N9oGA5RmyoG1cKlmF6V1eCa5rMygIG0jZ1w6Wqcw/DJ0UX6dclfrkY7rwuIKcvv/07BQMtN4=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB1903.jpnprd01.prod.outlook.com (2603:1096:404:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 10 Mar
 2021 02:54:04 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f%4]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 02:54:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
Thread-Topic: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
Thread-Index: AQHXEzBZLDVGGgTzcUG+Bf2pWnAADap7i1zwgAAhSACAAN054A==
Date:   Wed, 10 Mar 2021 02:54:04 +0000
Message-ID: <TY2PR01MB3692E5843AC864F7F549927AD8919@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210307090030.22369-1-baijiaju1990@gmail.com>
 <TY2PR01MB36929E9390A48F6FC7042AF8D8929@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <255bce3c-1680-593d-9083-6635e1a57b63@gmail.com>
In-Reply-To: <255bce3c-1680-593d-9083-6635e1a57b63@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3946cfa2-cbe7-4c14-8812-08d8e36fc454
x-ms-traffictypediagnostic: TYAPR01MB1903:
x-microsoft-antispam-prvs: <TYAPR01MB1903A5CE4DBAB3E8A66C1ED4D8919@TYAPR01MB1903.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvJ+a5K5DfJL/71CUkq8Heou7zE21t5vPicZ9LdR+CKcJhxs9Siv7WYmCHZ+fLHBlEVZOfc2Y1jNhiWLXOOgJM8oRlRMTzLLKFSCEPq56NSNzEc0GZ4bGxwPNnIZNuCFry3/fOjYoBFU9DRny1/JviykWje49gsOAn+FL8N6wOh0hZA92zy9V1G8de2h21aVyqS2AGT+f/B0TOuaoB9HOvwwwsBYEzdov8kyF25tiZuk8VCZ6UMgP23N44DMVy+rZVbT9zvQnpUYG/aC0qQj0Y7mUkVUgdJxTCzSvhd5jM4vEtBzFHytXSOQuboGTW+O6TYtd6pMyWC7AgD6IWmTobMTaQtbuaF6+4S5tvbQA1Sx3uGRiH5WmgAI6X4eXvbfVxapA/fjlbPNk6KiJLp8GFFBq+uUW45yx5TGacUSisNcpGhWq+nRucvrXm/ZLqA6AmhgvDTlHCFGCwx3OY5IQVYQe9q7KlakeSWxpbzCIWRKp+gbrVvy2X5O4X1mXd7VpXqh+kT3Y79BY/3xRKluKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(76116006)(66476007)(33656002)(66556008)(55236004)(2906002)(64756008)(66946007)(66446008)(186003)(6506007)(4326008)(26005)(8676002)(7696005)(6916009)(53546011)(316002)(52536014)(8936002)(55016002)(478600001)(5660300002)(9686003)(86362001)(4744005)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TlNBUmpvOWZWbDVqQ1hMZ3VZZ0FDMittVllXREFySGVOK25McGdWakRVRW44?=
 =?utf-8?B?ZEJISXdUdWMzZXJHQXo0Y2dqdDNMb1hZM2FsRlRNd3hScHk0Q040L2RYdVhJ?=
 =?utf-8?B?Y3liZmFyNW5XeWRFdWduM3JKMXNDYVBhV1l0Q0RxcVlnL0g4K0NpNjYvOE8w?=
 =?utf-8?B?bEZrL2F4STRKbFQ0ZjEvSmZaK1FvYW9BTElkWXJoU3Fibzl1djlVRGF4RDBz?=
 =?utf-8?B?M3BNZTBHcTY5YmZ6Ukp5eUVxZDBDb3ZVcWZzVU1hby9hL21VNk5HNmt0cEFk?=
 =?utf-8?B?N1pRWlp0QjNTcGdNYWRXTk1CdnJETE9rUGd0Zy9VRWdwUUpzbkZ6ZTNiL2dk?=
 =?utf-8?B?L3lLaHB6REU2UERFMUlncjdVRzBHOEx4bURDcnVOSlo0aUpHYm5lWisxWm40?=
 =?utf-8?B?dVRZaE94eFRRQmg3dkVpOG5XRUZpcTN4eVVmTmFNZllmdGpDMktZZDZUclpG?=
 =?utf-8?B?NWZpbFlsbHpROW9UMmErT24ydFlmMUFIdG92M0hvcE0vcExPSmhQM0l3T2Zo?=
 =?utf-8?B?V3YzK0xKTlJhZ2h1L1hLb1l3d2RWdmduMlFmT3htTmUzTXk5MVQ0NGNxSTlT?=
 =?utf-8?B?M1p5WXUyQksyejdvSTQwZ0p0NXp3TUVWMnFNNWRnQWxRSFdEVkc5Ulc0eXlR?=
 =?utf-8?B?VEhhQW84dE1XdGNjTUl6WmNocWt4MVpUeE0rbk1kOUhXQ1k2UFhoSWpIVFc5?=
 =?utf-8?B?WlJTbjJnTjdhdzlkYXBDK1pJdEEycTZEOGZnMTlnODBITGd6aFByYmplSm84?=
 =?utf-8?B?TjlsVHpJd2xSVGhvVjN6QndBT01KTXlqeGpvdVVNbHVoZTY3Z0x2SmtXVSs4?=
 =?utf-8?B?OFc5WWJUM05DWStLNTdpa0h1M1Npemlrbmw3eXE3M2VsWkhhbDVoenQyL1dH?=
 =?utf-8?B?TzVYMllyREtESEV6b3lKRGltbk94WDIzaEtTV3h4VDZsZU9kaVJxeXEwUmtr?=
 =?utf-8?B?R05RMkZ1MkJmM1dxOUpOYzYyMWJOMzNYV2pIQmFsTmlDb0paYnl0RnhIWkxC?=
 =?utf-8?B?aGorNTUwNVYvbExiYUx6QTFia1BNVC9wQlA2cENoZ0lnRWt4d1NiVXhqVHlM?=
 =?utf-8?B?TDlad0J6R2ZMZkprRUQxbFp1c2xsU0xyN2lzMWU1Rm14V1pHNjBBRGxNQUQx?=
 =?utf-8?B?OWV5QnFUZ2hQYzJCSVh6WHFCZXc0ak8yZHNTZDlwUm1pa2FHeWd2dHE4WVRp?=
 =?utf-8?B?NTVLNWF1M1JEN3Jod2thYU1BaWZFUi9wRUdoOWlZTkRad3Qxc3d0Sk1PM3hz?=
 =?utf-8?B?OWM2ZUZWUS9NdjRhUUlyNmN0SGY3UmRMSDFyZXJYTXZiNDh6eEZ3eWM2NVY5?=
 =?utf-8?B?eWVObWZqMnBrTThWMEs3YTNFZUZHc0l2OEh6Z2U1dDAxQlBXQzZwM0h1Wldr?=
 =?utf-8?B?YTY5cWRHZk53bXNMd0syTzB4ekNrY0lJWitZRHhBcnU1dVVNYnRKUFNaZ1Bt?=
 =?utf-8?B?bUU0dXBnS05Ed2FYbWtPZ1FtMXZkNTV4b0IwUnYyZEpsbEV3TGtONHZkcG1W?=
 =?utf-8?B?ZXFLNWV3QnFKZE95Tm96WmFWY2xjWHcrVXVkMDRYM2NzUkorWmJuVldRbWhp?=
 =?utf-8?B?czBaS3EzUUhSaGllUlBGVWYxUCt5TVJ3SGE0SXdtajFlREdvd0tqNjN5T2RQ?=
 =?utf-8?B?OTlsR2wxU2NNZmNZczNxKzd4MGJlZnFvd3dNTHFyNng2d0JWQmozbjRZaVdM?=
 =?utf-8?B?aFdtUWdIbFlQNDlzM0ErSDVjeElBTHpDRVFhWUc5QzdCUmRZb1RCV05pWkdR?=
 =?utf-8?Q?Dm6KBuSifeB4yW0kBcUXQa/rzC6YcZ83OqaW51p?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3946cfa2-cbe7-4c14-8812-08d8e36fc454
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 02:54:04.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N/LXZ2L7IKS+ZARk5nE9vUBLqoFhHdfi1Qi+GO9N+0GJkRqDHpCzGbk5WYFO4oIv0oRX2rIe+WuhAYmyRxFZ8OiHVG51VzLecrS9u5AUpMhx5BPywA/bRStu2UhL3gh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1903
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlhLUp1LA0KDQo+IEZyb206IEppYS1KdSBCYWksIFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDks
IDIwMjEgMTA6MzkgUE0NCj4gT24gMjAyMS8zLzkgMTk6NTksIFlvc2hpaGlybyBTaGltb2RhIHdy
b3RlOg0KPiA+IEhpIEppYS1KdSwNCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIQ0K
PiA+DQo+ID4+IEZyb206IEppYS1KdSBCYWksIFNlbnQ6IFN1bmRheSwgTWFyY2ggNywgMjAyMSA2
OjAxIFBNDQo+ID4+DQo+ID4+IFdoZW4gX191c2Joc2ZfcGt0X2dldCgpIHJldHVybnMgTlVMTCB0
byBwa3QsIG5vIGVycm9yIHJldHVybiBjb2RlIG9mDQo+ID4+IHVzYmhzZl9wa3RfaGFuZGxlcigp
IGlzIGFzc2lnbmVkLg0KPiA+IFllcy4gQWxzbyBJIHJlYWxpemVkIHRoYXQgbm8gZXJyb3IgcmV0
dXJuIGNvZGUgb2YgdXNiaHNmX3BrdF9oYW5kbGVyKCkNCj4gPiB3YXMgYXNzaWduZWQgaWYgdGhl
IHR5cGUgdmFsdWUgd2FzIHVuZXhwZWN0ZWQgdmFsdWUuIFNvLCBJJ20gdGhpbmtpbmcNCj4gPiBp
bml0aWFsIHZhbHVlIG9mIHJldCBzaG91bGQgYmUgLUVJTlZBTCBpbnN0ZWFkIG9mIDAuDQo+IA0K
PiBUaGlzIGlzIG9rYXkgdG8gbWUuDQo+IE5lZWQgSSB3cml0ZSBhIG5ldyBwYXRjaCBmb3IgdGhp
cz8NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LiBJIGNhbiB3cml0ZSBzdWNoIGEgbmV3IHBh
dGNoIHdpdGggeW91cg0KUmVwb3J0ZWQtYnkgZm9yIHRoaXMgYXMgbWlub3IgcmVmYWN0b3Jpbmcg
b2YgdGhlIHVzYmhzZl9wa3RfaGFuZGxlcigpLg0KTWF5IEkgd3JpdGUgc3VjaCBhIHBhdGNoPw0K
DQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
