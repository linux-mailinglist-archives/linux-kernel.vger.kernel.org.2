Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4748F3334CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCJFTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:19:17 -0500
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:60380
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229441AbhCJFTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:19:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8pkzSY2sJDttkvIADrnKL9MRu03Ckfre3of3zdqTIZEEgBfmY78KHI22gDrNwaU1DxXW+cdogxwY5S0uFoDNNzBog/58fbsS53h7LfbbDt49AwXS+yHdFycEsAsHbRsz893V4DoCTEfeXw/g4rsogFS29hzgVfUbgjgcstlSPiUFDeCrh5YiB6Mpm5f/Jh0UggtZ/kHhnkkzRH7oDvbUavDESS/5j+HHBCwr/zL8HaO5H88EIElmPWLwuTHmMCAzxaT9ijT654X5Jro/WBj0A8dcuXA2HBMJKLy/eVVZG43znYqZt/89K1yu6Gngmp2O6i2efV3qwGrfqQiJzWMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHbHgKToNZplQ/M8Y+9O3OBI3UkcVzq0PCTQzJFSwKQ=;
 b=oDfFXzXWUCe5OSY2azLVw1cIIm1ReNFBcT8lIMsriqius1+avqUoHW8Ug6FLG8NCjbr1be0dJKc9qXAkDfYK2rHIIg2SWQaTFq0/dmnZf63CoYZyGoge64fpV2pVv1XxjboxkrwsJbd7HjsdY0yPKkef43xtNHCp3OoNGr43U+TWhxUSoHsEq8tmLxfGW6yEc90O6yGqJHn65oOz3csu94B5eLI14r54lNTYPaIAYtnrGwFCq9cDMnFlhXR8RR72zB9o6q7FINeSVbj5ut+3ve4YyUcrPi+VI/p7teaQNIOT1AxH/OB5fPxz6UOEqZf6NWinj2vRJhR9xxqX1unMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHbHgKToNZplQ/M8Y+9O3OBI3UkcVzq0PCTQzJFSwKQ=;
 b=DaAxPg1297/L7xoT+nbd8PON4fJoQ3HuZiiiKTzHKQrbI+Yjrpvf3S5Kw2i7+Izplgc55K+fxqLb9+cG3LOJl3VwXKloq5IXBatBhgqkH5gZMuIeBbPMRjY1E5SCc5nwW2m+zZtQ/LiF1/8q3mE02Sdt1U65AM4z3EFtNyOjVNI=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4300.jpnprd01.prod.outlook.com (2603:1096:404:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 10 Mar
 2021 05:18:57 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f%4]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 05:18:57 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
Thread-Topic: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
Thread-Index: AQHXEzBZLDVGGgTzcUG+Bf2pWnAADap7i1zwgAAhSACAAN054IAACGcAgAAg54A=
Date:   Wed, 10 Mar 2021 05:18:57 +0000
Message-ID: <TY2PR01MB3692BBC4B8231F254981FD7ED8919@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210307090030.22369-1-baijiaju1990@gmail.com>
 <TY2PR01MB36929E9390A48F6FC7042AF8D8929@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <255bce3c-1680-593d-9083-6635e1a57b63@gmail.com>
 <TY2PR01MB3692E5843AC864F7F549927AD8919@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <05aecdb3-23f5-54aa-c396-bff7f1624899@gmail.com>
In-Reply-To: <05aecdb3-23f5-54aa-c396-bff7f1624899@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd7b4f84-888e-4b87-b5bf-08d8e3840188
x-ms-traffictypediagnostic: TY2PR01MB4300:
x-microsoft-antispam-prvs: <TY2PR01MB430057D23942AFFF8F27AFB2D8919@TY2PR01MB4300.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FP1S7Z7K+2DL2mAlgyW6a/rdYP/HiqrQ1odqPgbf8yvdDKaRJQ03Sq3DfcQKPKR+KYtkROhxylgNAWpqB70BppNS9KJJ3r01xP3eQlEd42vhOLwvdhsNSVU0sdfSmLujUhk4w8ocDHvud7DkvBGLTrIFyVkdry68M4ASsYkQJ/bfDBTaCUDoZ1++aksq64CWCf1QjvE4XdOBVf5JJLjU5ecNBpPwAmtE0nW5gfmnKGEXQaPh5wEHXGIYhNZv5+KIVUwjLfTbQTHyRShcmxJUAH/+Qkt3pfPaf/iIso+Ih4hQVFYysiBF2IgOJD20aNii+5z0XNWjmTbmEJ+eNrc8DvlRIPbm5iZD92JqYn65P0vlAvVyVBbKT8Beul0We58NEou4Hq+KqhYR0cMLTrydsZM6Q+9lXiBHPiGS0yelNNkgz7CU2t2so3kE1wdH2B9OpiTKHHe6oLq/BbeTN77ohkSWn9kUUjyK6nbqW7fE4R5Fz7WuVV2wnMjBUubMRxNOVUbabyCdJDXJMddd82669A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(2906002)(4326008)(53546011)(4744005)(66946007)(66446008)(66476007)(186003)(71200400001)(55016002)(76116006)(6506007)(8936002)(52536014)(9686003)(316002)(64756008)(6916009)(54906003)(33656002)(26005)(55236004)(66556008)(8676002)(478600001)(5660300002)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SXJlNEZpTVl5czJSVzVqSDFoT0FvaU1xdTJSclFmUUFVemM5ZGp5SUNKRG9L?=
 =?utf-8?B?OXJoRG82ZWRKcDFobUtSYUJLZUZuZFM5Uk94QWxocU5ONnB3ZFQzRVBmVHF6?=
 =?utf-8?B?YW51Nnd3VWxhajlLUmc4ODdadk5pMXN3MmtSL2JlQ3J5c3NxcXhNZjExQzNy?=
 =?utf-8?B?WTJGVGtCc1RuZkpmOVhUWTlndnBvTVZNVzNaeWliTDJOckxMMTBvaENySkNK?=
 =?utf-8?B?OHdlS09jYTJ1NWlLcFJ1Wmh2ODVkWmxXb083UGJSUkFMZlpjNDVQS21iWkM2?=
 =?utf-8?B?azJGUE5OY1JlZHdNU1BNb2dtanlGTDViUHN6dXQ3UldwN2RmNUZnNkFHWUJQ?=
 =?utf-8?B?OWg3M3FrV1ZuQ0RHKzQ2NmN2UkMxL1NIMStIQlhlSW9HUGNjTk80Z3dpTDA1?=
 =?utf-8?B?YzJjSUtha3RHQUY5Q29pbmhVMWE3d3hFeFpNeExSRXhhZDdVcGxCMjQ4bk5E?=
 =?utf-8?B?a0VjL0JkZnJ1K0o2a1BZdnFtcjZPWVM5U0FGWTBSVTN4bVBUZjViVktUYnBq?=
 =?utf-8?B?UVRVNjVYTVR3RVZiY2VyS1FNR1J5dS9TQXJ2YS8vdUFtdnFWUDBBdmVkVGU0?=
 =?utf-8?B?T0FDbDcwVHBoVzZNQ1k3R213MkpIK3ZJeHhPQkl3aGtseFIwZVBMTVVLNHZY?=
 =?utf-8?B?bWlCc202RmxBOVdaYmUwSnJ3QTdoVDAva2RIZzdkRmtjTCtXQU4xcXA4c1Vx?=
 =?utf-8?B?RjZxWkRMbEdxV1RaSWUwNGdTTC8veDkweExZTzRhd21KVEY2enhPNlI3Z2dO?=
 =?utf-8?B?RDVXV084QXk3REJVeUN2T3ZtK0VYT0NyMS9lL3F3QkpZVWk3SU5DKzBWSEpT?=
 =?utf-8?B?ZEwyRnozdDJQSHpMTTZUTkNVaXk0djRxUjRCSGFHbXhkVFlpeVNJZGhxMm9L?=
 =?utf-8?B?cnI2Ri9zcFk2YWJLRERuQWNMZlMvR0Q5Y3FjNTBzMTk1RjJJUGtVVUd0VXJi?=
 =?utf-8?B?aENVV2E0Wk13THVETXIybGlldTNiSHBJdngzUnRDWnE5V2ZYS0gzVzVNS1pJ?=
 =?utf-8?B?cmxFYUZwSWpNcVQybjJwdXVHeEJwd3ZWZlFkZDVDSXlDMEo4Rk8zUThIV01R?=
 =?utf-8?B?YU00dEdQZnQwWHNPcXhQbksrSXpJZ05qcG9CaWNYWjlTcGFrcDFrZms3emdq?=
 =?utf-8?B?VmhWbUxtUUhBRHJpQXNIWnhKODJPRjFua0xKSnh2Umt6ZXo1R0tOaEsrTzlX?=
 =?utf-8?B?bkxKY3RTazZzYVBOK3ZjblgvRVNqWmJMMWpkL0k0eWU5cm9GRXhJeHhGdUJj?=
 =?utf-8?B?L3FjZDlWRVZzSzVqUFl5ZC9BWDhoQXhTYkxndVBBZ2ZqeVYzcnE2eDVLc2Rl?=
 =?utf-8?B?d2drUm9RbUNiY2NoN2huTlhFNk9sa05Bb3c5bFhqS3gvMVg4YXdDL3F0ZUNh?=
 =?utf-8?B?U0tNSDU0eVZZS1VhZWRSSXJSckJrcHFaTTlQWXhDMFlJb1EzYlU2SERralht?=
 =?utf-8?B?T1ZacWJUMi8vN0dJRW9hL3ZFd3NKODNVQUthTmxPUml6OWdLU2NMYlBUbG9Z?=
 =?utf-8?B?VnIzeHBrck5hTEsyT1ZJTG41a092bm9UZmhlRUVYcGMzZWQ2bVhkMmZiVDZH?=
 =?utf-8?B?U2MwUERvSTByUDRjZjhQMmhqelJFRXI1OWZSVFRqd2NmVE9SS0FNZE5zOG10?=
 =?utf-8?B?VS9ONWtSQnNjK1N6ZU05WUxWYmRSaXZodk5XcmxFUUNrQWRaR2wrY1VyaVh1?=
 =?utf-8?B?a01kWU0wOWQwQ3lnbUIvbk5BSjRtR05EWmx5OGRQL0hwb1FtR0ZoSlliQmQw?=
 =?utf-8?Q?iGP95JuFr5nYD6q+103ad2pArt1W6cWNg7bEZjz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7b4f84-888e-4b87-b5bf-08d8e3840188
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 05:18:57.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwY6TWnL1kcMJZnwc2DIbl3UFwUTnXEsoYtaDeCtvj8Bfn3kL5x5OoGhnPdq1LHRk19qFnRr7jM2AC7V6imzgRF8TKNcgxA+gJsVRyrmdWx6wwXNLv3l4YVoy5jF5WQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKaWEtSnUgQmFpLCBPbiAyMDIxLzMvMTAgMTA6NTQsIFlvc2hpaGlybyBTaGltb2Rh
IHdyb3RlOg0KPiA+PiBGcm9tOiBKaWEtSnUgQmFpLCBTZW50OiBUdWVzZGF5LCBNYXJjaCA5LCAy
MDIxIDEwOjM5IFBNDQo+ID4+IE9uIDIwMjEvMy85IDE5OjU5LCBZb3NoaWhpcm8gU2hpbW9kYSB3
cm90ZToNCj4gPj4+PiBGcm9tOiBKaWEtSnUgQmFpLCBTZW50OiBTdW5kYXksIE1hcmNoIDcsIDIw
MjEgNjowMSBQTQ0KPiA+Pj4+DQo+ID4+Pj4gV2hlbiBfX3VzYmhzZl9wa3RfZ2V0KCkgcmV0dXJu
cyBOVUxMIHRvIHBrdCwgbm8gZXJyb3IgcmV0dXJuIGNvZGUgb2YNCj4gPj4+PiB1c2Joc2ZfcGt0
X2hhbmRsZXIoKSBpcyBhc3NpZ25lZC4NCj4gPj4+IFllcy4gQWxzbyBJIHJlYWxpemVkIHRoYXQg
bm8gZXJyb3IgcmV0dXJuIGNvZGUgb2YgdXNiaHNmX3BrdF9oYW5kbGVyKCkNCj4gPj4+IHdhcyBh
c3NpZ25lZCBpZiB0aGUgdHlwZSB2YWx1ZSB3YXMgdW5leHBlY3RlZCB2YWx1ZS4gU28sIEknbSB0
aGlua2luZw0KPiA+Pj4gaW5pdGlhbCB2YWx1ZSBvZiByZXQgc2hvdWxkIGJlIC1FSU5WQUwgaW5z
dGVhZCBvZiAwLg0KPiA+PiBUaGlzIGlzIG9rYXkgdG8gbWUuDQo+ID4+IE5lZWQgSSB3cml0ZSBh
IG5ldyBwYXRjaCBmb3IgdGhpcz8NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuIEkgY2Fu
IHdyaXRlIHN1Y2ggYSBuZXcgcGF0Y2ggd2l0aCB5b3VyDQo+ID4gUmVwb3J0ZWQtYnkgZm9yIHRo
aXMgYXMgbWlub3IgcmVmYWN0b3Jpbmcgb2YgdGhlIHVzYmhzZl9wa3RfaGFuZGxlcigpLg0KPiA+
IE1heSBJIHdyaXRlIHN1Y2ggYSBwYXRjaD8NCj4gDQo+IE9rYXksIHN1cmUgOikNCg0KSSBnb3Qg
aXQgOikNCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
