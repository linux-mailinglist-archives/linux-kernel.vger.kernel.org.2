Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03543EE736
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhHQH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:29:11 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:38240
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238647AbhHQH3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCvKZlmaZ3HyQi+DaT1u3/t6TxnLSfJg5Syq1CaDYTC7d2fSGE2JBGBLmfJJjhWDi4EFkyt6S7sQE7fV7LJ702AFNWWtYh/cL+51pqoHCSl9pUpnbYs1Sgmie1xQtzgCJ5ynXflH0tUBT7kV1akP1Mp8OTmIieDmWKmf6Ry6CQnxmVp4lNDTeF2fqlsV6332MWB0LKQBSJYPHm/Pv3+ztg5Y97U1eLEIS6fP9pjpvKEvT8MBgXlyhavQ+un/xqBDkS3eSqoXXkoz1myV13+Mp40vxFqFRWTlkT8cy005gCbmWJ43+rJ89tZpdUFx3PvEIj4YCkKaQFEJMykp6ax/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw9BtdQi9gh5Y0/MfWG2nHZlCVj54GX2s3AecoNfC8o=;
 b=JeRgtX7RyyA1z0zSJd5xgHUDfft8mwz18inDvsv7ezx5/us/3jqbXqutO0zFFzwIIS6Z6l2W4BfEujk8Bw5rGrrp/02lBz2FppTOnfbw1qmeSojCyrZbQAPeuQe062mmhtomivR0wzxlbnhN+LWzfbbp6I6NL+2o31rew03hPPBsaauucwFwPgQnv52K3Fopp97XQ2pcSXC4TxOabjyycbMxVS64WuOpfCrnOrD/T8R5MtPYo6XqiQ8p63GRItS13FTa6OfSX/DdWDpjIQLeZgxJYajywKL8/GJX5lrlTDwsFs9RGgqpyVizgpzM9495Josdo60XhTlZrniyUwSaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw9BtdQi9gh5Y0/MfWG2nHZlCVj54GX2s3AecoNfC8o=;
 b=ZbtJAkOsH/00x9SgPWEiXugX+Afxkh+0SMpBx8+E9vQcoakaccnIaAz4rxeOa4o1voSBcOluH462KtGFiB5E/FYhJdywTN+yyqF6z0GQORApWYKdJYUhD1oTeDPzB4bc4XTqNGIhp5tsgdhbKizvtbfmoX49pmyUBLA8CB7KfkM=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 07:28:35 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 07:28:35 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mm/hwpoison: fix some obsolete comments
Thread-Topic: [PATCH 4/4] mm/hwpoison: fix some obsolete comments
Thread-Index: AQHXkPpfD62lHR2obUmGpq7iVWNusKt3UQWA
Date:   Tue, 17 Aug 2021 07:28:35 +0000
Message-ID: <20210817072835.GC452988@hori.linux.bs1.fc.nec.co.jp>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
 <20210814105131.48814-5-linmiaohe@huawei.com>
In-Reply-To: <20210814105131.48814-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2b4de62-952f-4547-207a-08d961509fef
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3965B1FD8341F8094B37047BE7FE9@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26rbb6GMXoYjT/IbMDbUutEvBCjCyB2TnYUwG6tpXZaiMvaokhF6byIEimKNdpBBRnq765iOyGFDrS+NHNWig6kQHfUwuZoVtnm6aQSpVBmSWd9Og7jTrqNeplco7gNxoYlT7DycYw+D5yeUsT4bHySvPmpjkKYP8ZhZ+9kzJ1QtyfGbnO8FKiuJnHRPGwhmJjxZSLv+pYvhPgziUuTHMNZym+JH/x3Mf8tEMemNCWizz8eLs9ec3GcyPOkfe07qiyslYK7PX/7wH4mCZ27mZM3ysJaobAaM3dBPIGy2dH+CjHRIVbUzVejE/NX+oEOGy4d3dLJF/GhT1Mzwyf/khOPDanJFJpEhEyH2VBKAeUTP566G39QzwcgxXzhFgPcF0AHVPUcBciRN3PqzQXDugEXwpC74vag4q+8iQA1PnWl/mV4GrDRQhX0YPF2SgIQhEJJ2zB93N0MmHuzqRtYD3mXtYJav40mqdhVuNAZiOiziK34p74z01jUL1Tsjfv1sDWdHoezPxwiNJeNrdXIHwFo4iPn+ycuB4TJlM4xcU4kHHLS4BpKxuPRrE9N167baNwcojZNWloWCNJ0v1WoBKJiQNQrO6k1GNi96Cb2Xsrm9DkIOA48jxeAu1sqVXATMwhjVn0Bik+EjK3NKCrP5f1sv1FVCwJItvCpst5beWUdTBP6wPkivG9Cn7PRlCqjz6KQLh4iXfNzHZ+vXLmkVkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(8936002)(5660300002)(85182001)(1076003)(122000001)(38100700002)(478600001)(33656002)(4744005)(316002)(54906003)(6916009)(2906002)(66946007)(55236004)(86362001)(8676002)(66476007)(64756008)(26005)(66556008)(66446008)(6512007)(9686003)(6506007)(4326008)(186003)(76116006)(71200400001)(6486002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTFwNUNPaitlUG0xNzNJMExLSkp1WUVvRnFwNEk4Tm9NajJqNG94OWQ2eXdI?=
 =?utf-8?B?THlDajE3cWsrSm5udld6bUphZTVmcXpwdFhhOTFXN25POFNEZGd5Y2xZMEt3?=
 =?utf-8?B?Nm1VQ0pYdEpESmxRY0MwTVpLT2IrcldtQ29JcUUzZFRjNk45ZC9tZnoreGdV?=
 =?utf-8?B?eDdBdG1RMUcwMUw4Y05wallWS0pYNHpJMlZFRGlHTkpkSXp2NWdhRlhNenQv?=
 =?utf-8?B?eTZUYUV4ZWFmNUh3TFgyUUdNWXVhSDRCT3Q2MlkxQ3FkT3I2Ui95VmZMZWZG?=
 =?utf-8?B?R3VNWkVLcjJna25YdFlEMnFWUUtlKzhEZTNMVnpyUjJtVkx1UTdlaWNGYkFq?=
 =?utf-8?B?ZXIrN3BKdXpSTkNDS0RxZWJxTDJTYUM5c2pWbmwvd3Zvdi9GMmNhNzNaTFpF?=
 =?utf-8?B?eWdyYytZYm40MlBQOHI1amdZQU9sV3BJamRtR2hJR2tPaEplVWJ6anNwTmFw?=
 =?utf-8?B?NS9WbHVRTVk3ZEZQRTh3ekFXVUppcHRmWHpLYjhObmpEVVM5NUxyaGtZSUlU?=
 =?utf-8?B?d0JPd29aRi9LZVFxM2NqdncwM25oY2NkZ3FoT2pGQ2JTb21CVmFmZGhvME80?=
 =?utf-8?B?cWJIOFB0T25CNnZLRlhvNWxNWnZldXBOQzRuQnpMTksxcUNSb010UDg5WXUz?=
 =?utf-8?B?a0NHdXltb0tiK3NiN0diYmZrN05VN3RyaSt1Vml4WitvRFdJeEVQbXBmc1Va?=
 =?utf-8?B?R3I0UnhZZW51OVVCRVM4RkVyc0ZEdmFrWG9WVFJvYzJ5aVRHbVZ6OEJkekRB?=
 =?utf-8?B?eWYzY0EwSlBwWitmVGh2eDVlZ3RIMHNOVzlhN1YvbzZlV0ZLWTZKRXRFRUl1?=
 =?utf-8?B?bEFoYlNsZWxWVjFaVXJkNFU2RmMrLy9LS0FyVkNXelZKQk1mNUxqZktJVXdY?=
 =?utf-8?B?a2dRdkRndWZMSFQrbGQ0UnFpR3RvRlpLTjd2Q2s0K0pLbHpmRm5HUTRnbWJu?=
 =?utf-8?B?QStIYkxMSm16NC9DYXlWVGU1OGt6Qi9nUDQzSnp5ZHZ2MUxwaW1SUlk4VFZ5?=
 =?utf-8?B?Y3Fqd09aZHJFRXhzZFlYdXRRNXNxVXJWdkFvVkF6bDV2eGFxWnpPQVI4NjIz?=
 =?utf-8?B?Mnd4RmtFajh6aGV1RXdhVkhHcTh5czhRTWtKbjNXVjg0NkdKM3Fia3ZWdTdT?=
 =?utf-8?B?dFNhekkydVk5KzJYRnowSVBwb0FIU0VXL0tpL0hpNlFtM1ZqSEowYzhpK2FZ?=
 =?utf-8?B?clNCeFZ4eklVZmZvcU9welFZbXlQQUVMMTExMWIrdkZZbkJQZXY5SHZydWVD?=
 =?utf-8?B?TEcvaUN5VTZsN3NVU01tN1dUOXF2OElQaVM2L3RNczBRS2IwcjZSQTFHVUMz?=
 =?utf-8?B?K21lTlIweU1GRnREZFVYcGl1TkRmY3ZJQmp3ODhDMi9mREhsYUtCTWV5a0hF?=
 =?utf-8?B?N3NqWnV3RWpBTlFMelpQK3NlNWRCT0syWG1GamlwOFFVT2F0RGp0ejkvUVg0?=
 =?utf-8?B?NWN5Z01nQ2lVeVR2Y1A1K3Nua0hvQXR4TEJmeUg3MjNTS2dpWUVhM1FiMEps?=
 =?utf-8?B?a1BOdjNDTFJONUx3cXoxZ2F3UGZHRTRVZW9RclhRTjBJNlcxTkI3Y250a0FG?=
 =?utf-8?B?bVBVaWtjYVFKQ29xUlJTeVlGbEJHbjFNeGs3a0JkbXIxanBjckUxeWtJOG11?=
 =?utf-8?B?MjhEUEQ5dGFidUUxQVh0K29FSGFXMjBuSnE3QlNtTW1tVjR2aHJmYk1mWnRB?=
 =?utf-8?B?MmlFME9GdTJDSVkwSDRaYWI3Y3RYRVRHQ1hpek5LcnluS2UvenRxMkRnWFky?=
 =?utf-8?Q?82x6+SwjRHJ2JE+Z+WAwUrqh9sZuM/drFMOYsnY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EF6ABA9E7F39E468C4672861E58E906@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b4de62-952f-4547-207a-08d961509fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 07:28:35.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Z5PhYZm1qs3b3K7m59Aq8WLjaju6nRx+Orh0hyNEQe1Wp3wsSu0EAmeYdvof0A7/JiFKybuedy3OnJR9Vamzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMTQsIDIwMjEgYXQgMDY6NTE6MzFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gU2luY2UgY29tbWl0IGNiNzMxZDZjNjJiYiAoInZtc2NhbjogcGVyIG1lbW9yeSBjZ3Jv
dXAgc2xhYiBzaHJpbmtlcnMiKSwNCj4gc2hyaW5rX25vZGVfc2xhYnMgaXMgcmVuYW1lZCB0byBk
cm9wX3NsYWJfbm9kZS4gQW5kIGRvaXQgYXJndW1lbnQgaXMNCj4gY2hhbmdlZCB0byBmb3JjZWtp
bGwgc2luY2UgY29tbWl0IDY3NTFlZDY1ZGM2NiAoIng4Ni9tY2U6IEZpeA0KPiBzaWdpbmZvX3Qt
PnNpX2FkZHIgdmFsdWUgZm9yIG5vbi1yZWNvdmVyYWJsZSBtZW1vcnkgZmF1bHRzIikuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KQWNr
ZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
