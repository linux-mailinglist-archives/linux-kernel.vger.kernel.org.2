Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A2D364F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhDTAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:49:18 -0400
Received: from mail-eopbgr1400043.outbound.protection.outlook.com ([40.107.140.43]:41868
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229936AbhDTAtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agvFxhh5W/v3VjlBNHRuz8s3V8Slocmic6Q8Os/M+1zUHqakUfm4hWMRGZ6kI/Ffrvee7FOTqruw8nW1dDT2l4SWcKSrqw8TW1LmdEK8r+HnqtcpnRD6s/TpcxtuzgQfokza/Q8lzeOfEgcJHGf86pYv9sJS8fGjQRrA7LfBqv5QYtT+OuL/Dbmr52p1NtPPODmb13EGc4Ho0Vwf3+dTzoi7yXOAtueqTOnkn0dtLAzwHSBMxafKIOu/2l2vgO4xXYM4Xennjpn54oGq/fpEHCktvfNA0dRD+bBrF181GbuCZMmaLiRJREbb10v616QXmRI6AgiTU+YUifiYj1sfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84LPV1S/mSn/8etvsrBVOIrf7lZW9KvAirLEF3ti2fs=;
 b=C49YkDgL4QWKetshivJeJmU91z8xWjlBZWPiZQLzHYAfaZhmW7NcPNRetOs2OX2TP6JM8oEsI82zSvCnykDBsjtA5+XMflPu2mn/Gj1NRuYpI0cubgZcJnt0UPXl4RrQo0UMzb65140LQsmHuVZ/zuTdDV1ybn1/znCVFuuKCowBbYRApRYNRDIEp0PFmgx5x/iZo+L6IxVFqAu1WYIF/JpLXQVZgbYRsMaKLpzPuBhak0WA5VzbpucqEyz8PWtLYSe+7p5q1TFVnei/aJ/+4pnXHYf1PGPSER5Wxd6ZyHiJ8PBnEo5ecMofkw1qogkD3mpikLS15cGmDj4AHzdvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84LPV1S/mSn/8etvsrBVOIrf7lZW9KvAirLEF3ti2fs=;
 b=c8NvevPorvZselaLXyIFvqi8ubKXSsM0vaYbrQaruDUURUHJD3kyyqLSSbu9pcxXBGI2LzpW9ctebBwGPEpB+yd0JmCD6J8D2aZamH8CmBWwn3xnR0y+lvUBWvVuYVPGUDE5cB1mEVU8EslrG/T+qqXXqIbYp+lY1yt5irkzC5U=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3616.jpnprd01.prod.outlook.com (2603:1096:404:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 00:48:33 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 00:48:33 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Jane Chu <jane.chu@oracle.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-failure: unecessary amount of unmapping
Thread-Topic: [PATCH] mm/memory-failure: unecessary amount of unmapping
Thread-Index: AQHXNXwdmAQL9dchRkWr8gN3KSY5Mqq8ks6A
Date:   Tue, 20 Apr 2021 00:48:33 +0000
Message-ID: <20210420004833.GA9675@hori.linux.bs1.fc.nec.co.jp>
References: <20210420002821.2749748-1-jane.chu@oracle.com>
In-Reply-To: <20210420002821.2749748-1-jane.chu@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84adebca-5cb8-4c8f-0d63-08d90396068e
x-ms-traffictypediagnostic: TYAPR01MB3616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3616CAF96786ECD260977730E7489@TYAPR01MB3616.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utlQiq4TsU5B2VA68SHpP67Wik59Ip/v+RuG2Fflcc+lxq+zn7ZI7uXg7SviPVi1poJnmbX7yKEDjTvK9pjF9/zVMFqEzmjpzN3r52onLU8EXwUDvR/mjfqTO9QRq1qLugeowMR82xdYiAS1ZW3Tzcesaib6yx6OcIW/nQ/qUXJVM0/2PRhtmNBlN6BtSWvONvphhiOcyHs1/2xjIRkdTwAL56uuoboV0faGtBH5Qrd5uTdJTC25Vm4m6Lq4rD8zHtpr208WxQ3+zP781Ge7qtZkVl+n8JH0fly1DsQWFDHgDsXB3SLgI7DTNFCYXdaDDZMHpJmq5/2JYzJLXV7vSasAi9/x2DLb4Hbk3Qgme+Ck6UlkoWrta2PMTSpaZW/S7qsfvquy0hwd2Y9qubEqMbWBLyW61Y+3BgCJVyF+GG0KGvk3OjskF5ocv9ZwrVuc7038DZb/I/HVkFkGaCMxpKePwzFLS5QPfkiitKYXcf2J4n9P5cXpwW4mRWa3grvyelV4yWabm0dKIyeladVg8PK9YuHyEE1gIZ2tuJmPwO+h+B8RK2LIs5cIZfUbzJJCWwotnix/h48j4Sje3Gk+DxwmESA8ykewNQJQ6Mncg2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(76116006)(5660300002)(4326008)(66946007)(66556008)(6506007)(6486002)(9686003)(122000001)(33656002)(66446008)(55236004)(1076003)(64756008)(66476007)(38100700002)(8936002)(54906003)(6512007)(85182001)(2906002)(478600001)(71200400001)(86362001)(316002)(26005)(8676002)(4744005)(186003)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UXVyb1FoNkhiL3ZaNkgvcDlwRFdYTkxJMDNKc2cyTTl1Y3NsSG4zbE45SHYy?=
 =?utf-8?B?SFFWUzVvb0xiUTVPL1drVEZYbTN3WitQQmpyT2hrZUNyb04rMzVLQVdXRlJR?=
 =?utf-8?B?azJTcHJXaUpDU1NxVW9JcldDMTJuRFhqMmNxM0RCTzRSTk5SR2FIcHJkdE9J?=
 =?utf-8?B?WHZuQWZIb2JJWlNpYlRuWStZM1RNbitYYWRIWTdLbk1DVmFyYmJ6bjdlMkxi?=
 =?utf-8?B?d0xqN2JrMmIrV1ZmVFRMNXZzNGJqcFA1NXFRZGhiNjdNWHprblAydVdtNVpN?=
 =?utf-8?B?cW1JZzdGek9McEdBOXlVWGtrOVVJbEpJZm5uRUlBRnB2MkZLYjhDWSt1YUl1?=
 =?utf-8?B?L08zTGprZ3paZG9sMVdueklZWUhqbC9aT0tWaURCRStNVzB3WFhTUnpCcUl0?=
 =?utf-8?B?cDYwSDV2RDBYOEJNS0kvbEM0V0JLS3JxZXZZbmd0Q1YzVmJRdUhkZU1NVkZG?=
 =?utf-8?B?OEgwdVJia28rWnZ6aWNsSU84cXVqZkRsV0FRbW9QRUlxbWlNQzBtNld0cmdW?=
 =?utf-8?B?Mkh0N1hyMm1QOUQxYXJtbGlZdU9xeDJacHJ2dkVxMFoycWtPTHI1ZFgrZEV3?=
 =?utf-8?B?WVdTK29QSEpxdTlrUGNSYm1XV1A3L2RISmU0MEJnWjBnVXFINXJ3TGd6TG4y?=
 =?utf-8?B?eTJKY2ZSVWEzVUZYck5QMXQwUmp2b2hKeHRacmdpL3JTYnlEbjVZdkRzRGQx?=
 =?utf-8?B?Q0hNYnJTa2ZwQ2t5VUlrbXVSYi9IUER5YTExNUJtY2RjQXpvMkdDMFNaamtD?=
 =?utf-8?B?UC9FcFJMOUZPcVY1Qm55bGNZZHBPN1hqNzZ6L2s4ZDdUdGlrMiszQWNTTmNy?=
 =?utf-8?B?TEFtNXp0dWFxS1lQbC9VTGlnVi84aFNxWDNsR2xaYnNnWDFyNUhPWTljak5O?=
 =?utf-8?B?VUJpZ2VRSE1NREtXQVNiMkJHaklpdkt6NFlEM3JVTExtNjFiejZFakJQMXRX?=
 =?utf-8?B?alR1eitFTU0wb3h2b2NZMjZaWEJSMkduajVuR3dzbmxDTWFxajB2aTdodlZy?=
 =?utf-8?B?WjExd2dDN3BqeHRwYlB3RzlManlaa0QwdFcrZnUzKzNYNHhZdktSbWYzditI?=
 =?utf-8?B?R2NESUdOZXhWM3lVUGMzSUJDUlNlT3ZVV0EzdG9kZG9UcFlsaFdNNDh2Z3Jj?=
 =?utf-8?B?dTVkN3NuSjAzZWtQVTZMWk44WDdjUUsyVExXWDVxbmtIZEdmZzhVQzVxL080?=
 =?utf-8?B?dmlIQWVDdktYbG1pSzNraDg5ODE4Mk9SV1lSVXpFeUxDQVp2cUJkaTNHMGEv?=
 =?utf-8?B?azdSZnA5NEZWVzhTRjhhSmtoc2h3QzJtOHE3MjJ6a3FIeE1naCs4b0tvbE9N?=
 =?utf-8?B?ZG9xNXIyNVR6dk1kOFJ4QkpYTmE0RmRCYi94UDhSRm9xWWtIRytWNWNFMUNx?=
 =?utf-8?B?bG15ZzJWbnBOTGUxY3J0OHg4Q1lpbVEvZjBFU0RybXRZZ0NWMk5waFVCUXFp?=
 =?utf-8?B?NVluNFllUStMSVJ2dTJjWHVQNWRzQ3lmVWFZbVA3emV2NVNjZEFkcEFpdFhK?=
 =?utf-8?B?MEptTDhyVnhmRkY4OHU4N1NUQkJGT2Z2Zmc0MWZsUE5wSDVMT3krenloSzhG?=
 =?utf-8?B?UEN4azlYQ3FUTmtmamlra0dXSkhkaEJ5VHhVTnJTN2pQN0lDTmxxRGIwYjEz?=
 =?utf-8?B?dFB4ZThVc0N3QUoreVNyUEdranMrZFRZMnI5V0JyN1dOcmhkdWVscmdLZXBF?=
 =?utf-8?B?dVFnbFpaZE5mN3h4OC9YWnZoMDlaTWVkdnJHSVBzUHN5Y0thZ1g4SlhFZk05?=
 =?utf-8?Q?HL2D3eMC98wujQboQnz0jqY4MQ5AsLaLQU4tLjL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <385A29C330844441B8B6F654B43B5D3F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84adebca-5cb8-4c8f-0d63-08d90396068e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 00:48:33.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90MMkcr3puzPq3qBYfIoHN5AKOVHeIbKn9GaPkCvyfmEiZWlNtQAtck8XXyJD1oMySC/Im6dC0ejXbYnEmE0OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTksIDIwMjEgYXQgMDY6Mjg6MjFQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6
DQo+IEl0IGFwcGVhcnMgdGhhdCB1bm1hcF9tYXBwaW5nX3JhbmdlKCkgYWN0dWFsbHkgdGFrZXMg
YSAnc2l6ZScgYXMgaXRzDQo+IHRoaXJkIGFyZ3VtZW50IHJhdGhlciB0aGFuIGEgbG9jYXRpb24s
IHRoZSBjdXJyZW50IGNhbGxpbmcgZmFzaGlvbg0KPiBjYXVzZXMgdW5lY2Vzc2FyeSBhbW91bnQg
b2YgdW5tYXBwaW5nIHRvIG9jY3VyLg0KPiANCj4gRml4ZXM6IDYxMDBlMzRiMjUyNmUgKCJtbSwg
bWVtb3J5X2ZhaWx1cmU6IFRlYWNoIG1lbW9yeV9mYWlsdXJlKCkgYWJvdXQgZGV2X3BhZ2VtYXAg
cGFnZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4N
Cg0KVGhhbmtzLA0KDQpSZXZpZXdlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3Vj
aGlAbmVjLmNvbT4=
