Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A804134FA65
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhCaHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:36:41 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:46176
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234110AbhCaHg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmmrYMjx1Dv36g8GaQJzOKx0PowwQ/aL+cjpWSB/eqbK4tKd4JtXeR1cjapPShU3O/cVAWsaHGO4he9k57FPWkPAgM6kti+DNjkRXjRO4gLAQChRnzhpp4UmCn1T01J1jy9+hHfZvpOEi1oE2zKEu1o3akfdP2Efg9BCaOuILb5JRLXfmuEyzdeHKzjDseNUWhFVXlYtrDvzmAQTfOlzttk8Q2aLRiWC01T86BKhTfvbiCm5SGOyq6chQf1OkG+KOsTPXkwLJc6UiK1i5hs8dHSGRxF4CBg8EFrzNVkYL1rnQbEGrl2i06uMnksGHKei5NOMBVpHdaTV+UqM9M1Cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4JkzEWua1ZtjnFP2hFRYt+1J5EXnSmI43wGH0Bnom4=;
 b=L/hyCbIy2sgNlV7qlTSnXOhFx53UNztSHIQ7LzjUxGAFw0KQTBcED9GdCInYNSTX6vn8gC41vxG6Te7cT27Y59W4FRmkYrFV2abqEBmk4Mmzfgf3XhlOgt6ZyM5zHRxyumpGooB+9wzN4jtLZtzbtQe23u2HarqAtVgPxX0Ql5I3sganREE8Dl4U2Fc0uXA7ESOANGajgZHsoKUQxD6nKAOmhurSagRSnTJwyjBqWayMqTP1jRSlQ6fBYjrxKKdDkC8+0S4zb/u8JkjzsqEzDJFWaNi4ebHHdKg0o3JcE5y8JaiWwKdRyJGmaiwQ2G2kctVTG80UQ2zDeVLZPYEF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4JkzEWua1ZtjnFP2hFRYt+1J5EXnSmI43wGH0Bnom4=;
 b=R7esqB1lO3cH2qgfQ3tMIyJZ4HujuAQ3OAnL7Lv5uDKyApCY4OO2nSdV6qIpT9ec/nTKHRdxmHIRGv/V34dNOqyVvt0P1Ht4O3KyXnERFuigPM1Gx6Rxr82hOVFvPrdruXhDoRJrkPLu7VZ1RTRdyV8/BYuMTtZvisiPpkoZnvI=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB2861.eurprd04.prod.outlook.com (2603:10a6:800:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 07:36:25 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 07:36:25 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: Re: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Topic: Re: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Index: AdcmAIdX20M9a26tRNqXPOAbwkktdg==
Date:   Wed, 31 Mar 2021 07:36:24 +0000
Message-ID: <VI1PR04MB585316E4B7C095A6B5C462278C7C9@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c80b5a3-603e-4cb7-380d-08d8f417b066
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB28615D7F971160A57EDA91A88C7C9@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:275;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfymi54+QBCFLj2DG7tSj2/E+a0tuXNx/8liPrxfTMpqBnhMqJYxSgKdmjjRSAQEjuSLlwPDmda+7hjIJWvOapBqa+Hm+LyMqRzzW1WenEZJAMK41y2Gi5fVJJ8UDzIKDUgIBdT9GLfEnBChCTOBpDFfWsjQd5WaaXDIszF9GNfHB/ns0g3WcKhkzrB3XLBDI7nkFLTSkg5nWAiR2HeOptsdfoqZOavlZDDxXDywbbLmgJmJrKza702VFFS5cUS6sium+yuVztUNY6v5M4IrG+rvFLVr5IzkaGMQGbDTVqem1D60SoA9qLekTj5lfCLJJxztJhMbN7boEqsQA5Dby42ULQGUg0G0AgoxJ5LvTWmFiPyz1cycPfyGKGzlHC49/zoXeyoTfL13suNONdO5gOEsSEaDjw+6BUYtWsrTapsn/Rd9jJOR1KFMDAgTOkItQ5QL8vBR7Kcx66d07NLAYzhuXs3nC0AiMADRQX7v8hFiPfwvxmwONUIx0Wz2QXmkzNUN+FeK53kjrI+x49hAPsRHmYNF8Jkp7A0uM7rtlsxXnZF1t0hb3QdJDgQKJ8ubuLw1HSWx9CJxhzc8Lp4P4BczgcmYxDkNza/g69lY0gAyAs7fSVVrKfjtchwhxkTohkDw5ry1UGI1Nvbb0eoCNASz8z8C0EoDu+DeGMU2EQv1M6DlysY0yklvb3E0LVgA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(53546011)(86362001)(26005)(54906003)(110136005)(38100700001)(4326008)(33656002)(8936002)(66946007)(5660300002)(6506007)(2906002)(71200400001)(66446008)(76116006)(64756008)(66556008)(66476007)(7696005)(9686003)(8676002)(55016002)(52536014)(83380400001)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R0VRdWpGVzhTWUduYURXSzE0Vk5TQklmV3FsVVNtNFhLVFBQK29PZ1pMU2VP?=
 =?utf-8?B?UWRaYW0vZytKSFJyVXRRK2E3bzhBR0pOQ1dEbWJrV29rWmJLU0dxK2hRNDRp?=
 =?utf-8?B?azNmVjdqRVZwT1BpakpobzRxWkNlV3NrRm0zZkxOZTRwTmNPKzh5cGQ4L0dt?=
 =?utf-8?B?U1hFVGNhVHRVRjcxdHZMbDIzWjZYRmFRMWs3dWQwbFVzL1VSaTIzK3dwdkxm?=
 =?utf-8?B?RmJqNHRhdU5RN2JDbmllSWFYV2xsYlVoeUVnOEYvcTZ3UXl6b1pXNzJQaHYw?=
 =?utf-8?B?R3BXVWoxcFRQKzhYakpidjlUck5ZMUx6aXhJL3BZVXo1VE1kdFZPQSsxSzMz?=
 =?utf-8?B?YlBseFdBVE5FeEtxdWZlMG9UTkFueUdxb0l0RzN0MTFhN1Q0OHpFZXRQL21W?=
 =?utf-8?B?RjNNRldNRXVzUEdsM04vMVU2UkU4ZlV5NVFlQ3hqdE1sVlVvdjVVNE0vWk9k?=
 =?utf-8?B?OHdpNWJSUXBvV1Zwb05UMGNrU3J3aVM2QXVtOVRHZGVwbm14WE5GT3hRNzVv?=
 =?utf-8?B?L0dDSXBlelNWZlRDWDJ2TUd6R3RiQW5adkF5dTJQSmIrbUozZVRHSnNxb0FX?=
 =?utf-8?B?cVB1THpFU29LYkZyNzBEemttVVFXclVSOHJhTGNvVERURm1CT2dEdzM0dDFK?=
 =?utf-8?B?ZVZQOEhYbmpjd2VYVGR1dnV3QjFmRGMxN1N4YStlSGlFOEFVZE9XYlNiWTla?=
 =?utf-8?B?UFNCOXozNTV1U0cwQXRzeURsaFRyOHlqSXE2UDJtYlUvN28zUm1iUWFzSTh5?=
 =?utf-8?B?ZXZrYmtGRGNUN1NtSHNIWTc3UTJhSTNmZFYyT0VlaWpnMld1R0sxcFBsaVZk?=
 =?utf-8?B?bk9CYTlPNWlnVEdySkU0QnBFaDJvMVpzYUd5VENhWHJacEpUR0g3Y3AyTEhH?=
 =?utf-8?B?ZGQxTVZ1S29FWk1RTTQ0QktpZ0FIb2JRMkRoU252cFdYVTh2aXFlclNoTkt1?=
 =?utf-8?B?WGh3VjkwU044d2JEY3Q1NnZrLzZ4MTdsbjNDTXNKMC9UMklQR1hSQ1dVaVdm?=
 =?utf-8?B?ajhZNUdPZVVFVDBPRWNhMWRuQTZlbHN3KzJzaXdaUXRGSHJUN3E0RDk0ZmxZ?=
 =?utf-8?B?dlNsQ0xuemdEN3RxWDNOK3RNL1c0eFpHN3J4R3FiWTFTUnZpYWF5UU9WNTlE?=
 =?utf-8?B?bDZJcmhPcUw0OWtJOUM5SEpwME50QjkySU84SnQ5RHBDOGFQcTVSa092UUpU?=
 =?utf-8?B?a2ZtMUkyV2hQeWZJRERTSjk4K3IwTm5NS2MxWEp0REVlQ1BOS3FVdUNkZUJm?=
 =?utf-8?B?aUlXQWZmUEMxcEIvb242QURhYldDTm5OT2dCTlQ2YS9wOXZ6aUVneVBDZEky?=
 =?utf-8?B?cWJId1JySUdyUVB6RWhFUG42c1AvYnVBWlRCbmIwWGlSSytmNGNHcUJCb0xj?=
 =?utf-8?B?Ym9xUjEyNkpyMXRCT1lSTmRhbmpKWFd4bU8wUVhSZDNMSkhCVEZ1cGExTmRh?=
 =?utf-8?B?ZGUvWGJLVTJpQVZpdDFEU2RKUUxVVmJwVStFNVZhMVErRmtCM3IxazFTT3JY?=
 =?utf-8?B?V2lZdzdZTjFWWUZBVHBwZ3UvT1ZLdHFCMUg4WjhnUDVobjRFRXhpRlhlVDdP?=
 =?utf-8?B?dmcwRHFLTVhVN1RPSk5CYjUrUlcyYmVFbDNjQkVwQzBwR20rb3JJQkczNTV0?=
 =?utf-8?B?YzhKUWUxVEhydk1ldzg0SU9EZjdSUjBHNGsyN0NUTHl0Rkxlcmd1SFFBWVpv?=
 =?utf-8?B?OElnQUo2UWFaS2pLOHd0UEVKTC9VcW9aVVRPSTFRb0NiZGZXNFNBcDNpN2tS?=
 =?utf-8?Q?59nvQDBuqxc2LphNPAORFo/m4THK9U6VLZ6v57b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c80b5a3-603e-4cb7-380d-08d8f417b066
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 07:36:25.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Omj8RMcMVXu17YvoKHn21dth2KfXCUVlRbS+tL2zVULm9zD4CdI8oOzHtjOCRZPvj8aRM7LYXVssyuu9ztxZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCA8c2Jv
eWRAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAzMSwgMjAyMSAxMDoxNyBB
TQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgQWJlbCBWZXNhIDxh
YmVsLnZlc2FAbnhwLmNvbT47DQo+IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47IHNoYXdu
Z3VvQGtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IFJpY2hhcmQgWmh1DQo+IDxo
b25neGluZy56aHVAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiBpbXg4bXA6
IFJlbW92ZSB0aGUgbm9uZSBleGlzdCBwY2llIGNsb2Nrcw0KPiBRdW90aW5nIFJpY2hhcmQgWmh1
ICgyMDIxLTAzLTE1IDAxOjE3OjQ3KQ0KPiA+IEluIHRoZSBpLk1YOE1QIFBDSWUgZGVzaWduLCB0
aGUgUENJZSBQSFkgUkVGIGNsb2NrIGNvbWVzIGZyb20gZXh0ZXJuYWwNCj4gPiBPU0Mgb3IgaW50
ZXJuYWwgc3lzdGVtIFBMTC4gSXQgaXMgY29uZmlndXJlZCBpbiB0aGUgSU9NVVhfR1BSMTQNCj4g
PiByZWdpc3RlciBkaXJlY3RseSwgYW5kIGNhbid0IGJlIGNvbnRvbGxlZCBieSBDQ00gYXQgYWxs
Lg0KPiA+IFJlbW92ZSB0aGUgUENJRSBQSFkgY2xvY2sgZnJvbSBjbG9jayBkcml2ZXIgdG8gY2xl
YW4gdXAgY29kZXMuDQo+ID4gVGhlcmUgaXMgb25seSBvbmUgUENJZSBpbiBpLk1YOE1QLCByZW1v
dmUgdGhlIG5vbmUgZXhpc3Qgc2Vjb25kIFBDSWUNCj4gPiByZWxhdGVkIGNsb2Nrcy4NCj4gPiBS
ZW1vdmUgdGhlIG5vbmUgZXhzaXRzIGNsb2NrcyBJRHMgdG9nZXRoZXIuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IEphc29uIExpdSA8amFzb24uaHVpLmxpdUBueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4g
QW55IEZpeGVzIHRhZz8NCltSaWNoYXJkIFpodV0gSGkgU3RlcGhlbjogDQpUaGUgY29kZXMgYXJl
IGNoYW5nZWQgcmVmZXIgdG8gdGhlIFJNIGRvY3VtZW50IHVwZGF0ZXMuDQpJdCBkb2Vzbid0IGZp
eCBhIGJ1ZyBpbnRyb2R1Y2VkIGZyb20gcHJldmlvdXMgY29tbWl0Lg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQo=
