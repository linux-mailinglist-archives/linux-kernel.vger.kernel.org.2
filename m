Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E849343B25F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhJZM1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 08:27:55 -0400
Received: from mail-eopbgr1410138.outbound.protection.outlook.com ([40.107.141.138]:40480
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235981AbhJZM1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:27:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+3VxQjlBEoyyf50rSzC8wlRFqc8tEbGIK5QdfUjuwB3HXG4FCSGbxzNpu+8Lg0dQoC70WdwTvKa9cMKAgcB9X0VyX6HM4Ze1dMmbmZB10veLife+2kwvY9Ndwyn49uqPPPWsVzxyKcL0td7I74WU2kpY+JIFISGPE3nQ+vI2ORdpRD2oOElEHHIWzoXEhqlQTfrlQVAp/fTgX+qqAzcav7A7TxXPSflT/uIyKvuH45lcy4tJSKMuBSIKEFSr031zfwtaJ6rnxQY0sR15js5BK2TvVGhyRwsC8jWOe40+Zn0SfGUFZTjfYoW55BeWmDJuIqrDznfWN7nXu52msO1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIvOBQ1UyZMHhXBag2jer+y550z1M6y3fAlWJcbYk/U=;
 b=MEs7p43RsBWc+l66e4DrrSbS8/Wm1sitMt7RcL89zL5K/Kj34zuQyMnhRLAHwN4p8cRD/Kt3Re1RQuKcKJ8KErqlQ1fERyLhkHT5mrl4IHIZAdgRZDl8E0f8kSoLhLE6GC7pri5zINFiVsAXtRgFYQoA1MQf8/YlU7MwKRrAq7wiMasU7kslQ8QAlbpSUsHdT8yOCevAaWK+wKnGsDCSN3w4WKj//A3F62DTq8tct2XqrNtIoiSueWpxmY7fqDqPLTkoMGWPOzVdoYiU9DiErrBqKJlV+KMkGP96h/xldDVBJ0mkXyEgfx/UnwRB+ukY/XplM+JnPKwl9t4aBONOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIvOBQ1UyZMHhXBag2jer+y550z1M6y3fAlWJcbYk/U=;
 b=0IjBcikZIyCOX3ov+VC6Efudhlv0vaUTPyvsrlqlZ+cUK5Iw8HAGvL7ZP1n8I19mpmB9ischMggOeKKZtWxg6FlsVIrVll5AiRZGdcmneUTdldDL5bhBmW7X6LYm6/z5TxgM/6YH8r/xs4zp/fABLfxW7MNn3rxC0fnmCJoN+uU=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB0608.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Tue, 26 Oct 2021 12:25:26 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 12:25:26 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     John Garry <john.garry@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogZHJpdmVyL2J1Zzogc3VzcGVjdGVkIG1pc3NpbmcgbnVs?=
 =?gb2312?Q?l_check_in_hisi=5Flpc.c?=
Thread-Topic: =?gb2312?B?u9i4tDogZHJpdmVyL2J1Zzogc3VzcGVjdGVkIG1pc3NpbmcgbnVsbCBjaGVj?=
 =?gb2312?Q?k_in_hisi=5Flpc.c?=
Thread-Index: AdfJtAX2fMFFx03OTqmNb23By5R1KQAAUCzAACfhWQAAA9s/EA==
Date:   Tue, 26 Oct 2021 12:25:26 +0000
Message-ID: <TYCP286MB11881C0EDA01EB1882A3AB2D8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB118803910D5797B4B1B1938D8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB1188596CE44B1236D4EDD4B88A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <035fa6a5-2401-abbb-84a0-e46ddc0ce157@huawei.com>
In-Reply-To: <035fa6a5-2401-abbb-84a0-e46ddc0ce157@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6944b3-01c9-49a8-0340-08d9987bb0c6
x-ms-traffictypediagnostic: TYCP286MB0608:
x-microsoft-antispam-prvs: <TYCP286MB0608853DC8BAF8D28EB034408A849@TYCP286MB0608.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TODpuU6apvO9YyaDj062bNHe/Wa6ckfIUzCcBR4EunbAf/mmP9jLgS68E5LmU/ruKu8hcsv1CkHnj5BKicprp7MX1jRnIxX09svcvU0VWrbnaanL/6nr3/UYPGMtMQjFxgHdZH73qxhvPK5APDF05GdOqle5p+kp0SYWEVfZFYcxyzhlgNpmp1b/6zVmajkz8pTM+rJep4+d55TOnF1fPXStlSpOQtSBxMo3owIl/ASeBhTLCtFIuHmWZkW13/dNqE92apy3CoZnSnqznOqADuDqYJg2CKUD+uJn4Ge5zPXUi/5145rYnF8ZZPhqC9OWXqw5zkh0jBbyJ29Bv8uHvAu1Yxlvg6VQtM3Hc3jE688mHP+JmMyKyDkH2gvGbIPZ3MSJGJ7Q5E3W0zPG3aurQ27N6/DGWRH7KIDW65aB7yeTvX0QdztdnU9HQWuWGeluDZXrzbfbYh/EeHx1wvdun8nV985tCgf07jETwEzmDHytmYKhNy680cJP+VC6QzjJMDTmR+2yRkOBewWtpyGMuHRAXw8uhPUZQij2TBmTgPdEP+40XzmpQKKQ1F21fPMEHvEibinL/XAu79vh5TE2qCKEFgIZhWZc/hl7dtRvLU2s/gqIgYglHQw+PN7GBVkRU4kuFh5OErA0mjsYfmMi966oqad38j4HXwdZNDAOvuelk05ibJTcAjZMBHJOT32AuQ4YhBrcXx4XncaU5IWxc/ffE3eO5Yven3xg1EfwWHmkckZAx/cQTYN5yeIoqfIHnw6rkPadR/8aNLEAsT621W064/AK0hCuLZ97KjGSHmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(33656002)(26005)(224303003)(7696005)(6506007)(66476007)(66446008)(2906002)(966005)(76116006)(66946007)(64756008)(66556008)(786003)(186003)(110136005)(71200400001)(316002)(9686003)(8936002)(38100700002)(5660300002)(45080400002)(38070700005)(55016002)(52536014)(122000001)(53546011)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NEV3b2ZPVjRrN2dLMGV2dzdTTlQrU1pJRTdiUDlSd1ZwY1FwUDdkUHJQUmtG?=
 =?gb2312?B?L2VyVllBZTBpQ0pzczFUeTZVNU5RLytCMFNtUWFMb081V1hGeHdTV2M2cEVE?=
 =?gb2312?B?U0RLMGpBem0xVUVZaGxadnA2dWFvOGVsYlAyaUdCWWozNXBBbVVuVmsvNTdO?=
 =?gb2312?B?b1BtZDViTURQZUR1MlMrTUhuMVlpWXhXRkVDbEVrSkNYZ0dCVkdvR1g3VzZF?=
 =?gb2312?B?eHhjY2F4akZwakp0S1lRRGcrRmtOcFFCdTVpTnRxRTdQaiswRE9weHcxU082?=
 =?gb2312?B?eURuOGdBZTRIYW5vQzVCQ1NzZTY1ektoL0NxSThLOVhMcE81OWRzRFdmdzhY?=
 =?gb2312?B?ckx6V0l0Z3drQnlNMXVnOG1ZNU93TUtOT2FqMkp6OWhSZzJ2bjhmRk51TVp6?=
 =?gb2312?B?V1czVWdFWW9YRE01YWlJWjRTRE1FRkNhYmxDMVpRbWtPRk9FSGdjekN5b2xH?=
 =?gb2312?B?aU5CQmNHdlFiMHRsVk1SWjN2RFNyWm5ab3ZEN3E3N1AwNGVISEJFaTJXWmox?=
 =?gb2312?B?eERQUVZ5TXFRUlhxRDBTazNlL21YRS9RRzNPb3VET0lMMzByN0txWkdjbXlC?=
 =?gb2312?B?SnU0Mi9ZOWNBTWZoY245U0QwM0psZWNZdFFUYlpFaTBjdWlVZGh5RjhhZzcy?=
 =?gb2312?B?Z2pZVGJDWGRIaDJLRXFVUi8yaDRNUEZJaGlzQ3JDaC90QkU2dkNPb2Q0OFJS?=
 =?gb2312?B?Q3k0b0hZWG5vemZhUEQ3N2hYaDdJNEtGK0ZnbGVHYVBYVjJMMUowTDJXaGpm?=
 =?gb2312?B?VzFSUVhyUkxjUjZRM2h3MnFrbjJteHkwZ3h1TG1FYy9zejVqZTdPOWIvU1ZH?=
 =?gb2312?B?dmNrTDVXZUF2bTN0M2xtSFpHdFVKbXVOdEZaMEgxRWZ6TDJRWFNsZFVoMlM0?=
 =?gb2312?B?YXNXOWpPTHN0NzhDUElFZXNUalNYVS9XcmhIeFJLRzZkQ2tnRXdod1BJWlZF?=
 =?gb2312?B?SmRLMER4MS9LSzRZVVpUS1dseXVKTUZWT1o1S0o2Tm93S2FTUVZzcEpXSUlY?=
 =?gb2312?B?Z3JmdFVObHpQbzlEenpQS1ZNcElTTkE5dWJaUXM3Ny9sMG1PaEVQUTJzSVY4?=
 =?gb2312?B?L1Nqc2xZOGM4MnB1OTZxNWIrOVcrVG1MR1VQTDQyQjRMRC9LN3ZxNE1QWnBl?=
 =?gb2312?B?eC85WTRnRjJEY0Q5eld0dHF0L3VQR2NuK0hQeDZCRjh6bElBekkrZmpjZTFk?=
 =?gb2312?B?aEcyV0NnOXlrd0hMRTduZUFZOGtJS25VbEhuVGtqZTRxNXV1YlVKRDNLem9T?=
 =?gb2312?B?TU0vb3N4bVpHVU1uSmEyRElkaXhYMnBrUjhzaDBXNmVBTFgwVjR1Rm9ManlK?=
 =?gb2312?B?V1E2L3cvZ1J0NkFYVTU5TjlBOW8wNEh4S0NIeDRyWVJHSjlQSVNPck56bzJI?=
 =?gb2312?B?dWtrVFVkY0oxQ2xMQkowQTc5cFAvcmlObkV6NDcwWlVzc1hDdVBwUmJBWkJ0?=
 =?gb2312?B?VCtHU3RmbGZlaitwVGVmTkFJcXYyU1BIWFFBTGl6YXMrL04vNlk4Wkppckt6?=
 =?gb2312?B?bEFJVGlBMUlhV2lERzdrc3RWcWZ1cGZlRUZGQzZFR29wQjZUTDhRQjJlU25q?=
 =?gb2312?B?R3g0d3NNQ2QwRExoK1h5TWQ3R21YV2tBZE5qOXJOZFhqMENuSUFuS1p2ajZE?=
 =?gb2312?B?djdEeUsvWG90bFQwNmxUUUNaUGVUVkY5Qit1NGo2ZjlnckFuU01RU0tpQStP?=
 =?gb2312?B?Q3JwZHdaZU5JTXQ4eFZaekVyY2wyQUFPK3J2cWdKdkl4OFJBejVId3YwNVZv?=
 =?gb2312?B?WEV0NnpBVGs3MHRQdGxFR3pvbEhZanJGZjUrT1pCRThzSDhVMVY1eGhXRFdX?=
 =?gb2312?B?WmZOV0tKaFdvd3ZCbGVCQk5zUUYxYmk3L1RPR0FOcEZwQ3V2NGh1aDRKa2tX?=
 =?gb2312?B?MGhlZFFrMGtHNXhwRGgrVkZaSVhWTHRXVlhDUkovYWREdVJ3aHVlbGN1eXB3?=
 =?gb2312?B?Z0lPZWtyN2I0cVh0Ymg1a09VeTkxenp2M2luczY3dk9KNC9WeWRUUlk3N3Q5?=
 =?gb2312?B?MEQxY2dkUG1EanBTemNGVDcyR0UxaFFZOHBabHdrZ2JDRlo1ZHVHbklkd3Qx?=
 =?gb2312?B?dFU5SzlYdzF0RGF3Ty9zRjU0cFdhV1paU1E0QlEzWGR1Y2ViNGhUVXQ2VHZw?=
 =?gb2312?B?VlFrdndHWk5qenRMOVRsVTZ3V3hwQTlmeFpQS05UeDlYbThORVBQam9vaXJt?=
 =?gb2312?Q?XSJVjfpzQfAm5nL5dya80YM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6944b3-01c9-49a8-0340-08d9987bb0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 12:25:26.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxodKlE98KtZAGmPYRRfbYpJfPUsYuVsxNzedMVUwOrZ9F3RZXqZu2rPy5BPjt4+L/aAYTsBrcmihBigZvdxUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0608
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpZb3UgYXJlIHJpZ2h0LiBJIGZvdW5kIHRoYXQgbnVs
bC1jaGVjayBpcyBhbHJlYWR5IHBlcmZvcm1lZCBpbiB0aGUgY2FsbGVyIG9mIHRoaXMgdHdvIGZ1
bmN0aW9uLiBTb3JyeSBmb3IgdGhlIGJvdGhlcmluZy4NCg0KQmVzdCBSZWdhcmRzLA0KQ2hlbmdm
ZW5nIA0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogSm9obiBHYXJyeSA8am9obi5nYXJy
eUBodWF3ZWkuY29tPiANCreiy83KsbzkOiAyMDIxxOoxMNTCMjbI1SAxODozMw0KytW8/sjLOiBZ
RSBDaGVuZ2ZlbmcgPGN5ZWFhQGNvbm5lY3QudXN0LmhrPjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0K1vfM4jogUmU6ILvYuLQ6IGRyaXZlci9idWc6IHN1c3BlY3RlZCBtaXNzaW5nIG51
bGwgY2hlY2sgaW4gaGlzaV9scGMuYw0KDQpPbiAyNS8xMC8yMDIxIDE2OjMxLCBZRSBDaGVuZ2Zl
bmcgd3JvdGU6DQo+IEl0IGlzIGRyaXZlci9idXMsIHNvcnJ5IGZvciB0aGUgdHlwby4NCj4gDQo+
IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFlFIENoZW5nZmVuZw0KPiC3osvNyrG85Dog
MjAyMcTqMTDUwjI1yNUgMjM6MjINCj4gytW8/sjLOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBqb2huLmdhcnJ5QGh1YXdlaS5jb20NCj4g1vfM4jogZHJpdmVyL2J1Zzogc3VzcGVjdGVk
IG1pc3NpbmcgbnVsbCBjaGVjayBpbiBoaXNpX2xwYy5jDQo+IA0KPiBIaSwNCj4gDQo+IGh0dHBz
Oi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmdpdGgNCj4gdWIuY29tJTJGdG9ydmFsZHMlMkZsaW51eCUyRmJsb2IlMkZtYXN0ZXIlMkZk
cml2ZXJzJTJGYnVzJTJGaGlzaV9scGMuYw0KPiAlMjNMNDgzJmFtcDtkYXRhPTA0JTdDMDElN0Nj
eWVhYSU0MGNvbm5lY3QudXN0LmhrJTdDYzI2ZjBiNGE1MjUwNDczN2MyDQo+IDc1MDhkOTk4NmJm
NWFlJTdDNmMxZDQxNTIzOWQwNDRjYTg4ZDliOGQ2ZGRjYTA3MDglN0MxJTdDMCU3QzYzNzcwODQx
MTcNCj4gMTQ0NDc2NzclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTA0KPiBDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEw
MDAmYW1wO3NkYXRhPWxreDkzUW9LJTJGTjFpbEcwdTVpbDVsDQo+IGhWalVpQWJWWTZSWCUyRnVK
aCUyQkJIbXVJJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBPdXIgZXhwZXJpbWVudGFsIHN0YXRp
YyBhbmFseXNpcyB0b29sIGRldGVjdHMgYSBudWxsLXB0ci1yZWZlcmVuY2UgcHJvYmxlbS4gSXQg
Y291bGQgYmUgZmFsc2UgcG9zaXRpdmUsIHdlIHJlcG9ydCB0aGlzIHRvIHlvdSBqdXN0IGluIGNh
c2UuDQo+IA0KPiBOdWxsIGNoZWNrIGlzIG1pc3NpbmcgZm9yIHRoZSByZXR1cm4gcG9pbnRlciBv
ZiBBQ1BJX0NPTVBBTklPTiBhdCBsaW5lIDQ4MyBhbmQgbGluZSA1MDQuIEl0IHNlZW1zIHRoYXQg
dGhlcmUgY291bGQgYmUgcG90ZW50aWFsIG51bGwtcHRyLWRlcmVmZXJlbmNlIHByb2JsZW0gYXQg
bGluZSA0ODggYW5kIGxpbmUgNTA5LiBDb3VsZCB5b3Ugc3BhcmUgc29tZSB0aW1lIHRvIGhhdmUg
YSBsb29rIGF0IGl0Pw0KPiANCj4gVGhhbmtzIHNvIG11Y2gsDQo+IENoZW5nZmVuZw0KPiANCg0K
SSBkb24ndCB0aGluayB0aGF0IHdlIHNob3VsZCBoYXZlIGEgcHJvYmxlbSBhcyBBQ1BJX0NPTVBB
TklPTigpIHNob3VsZCBqdXN0IG5vdCByZXR1cm4gTlVMTCBmb3IgdXMuIEJ1dCBJIGNhbid0IGdp
dmUgeW91IGEgYmV0dGVyIHJlYXNvbiB0aGFuIHRoYXQgd2l0aG91dCBmdWxseSBleGFtaW5pbmcg
dGhlIEFDUEkgY29kZSwgd2hpY2ggSSdtIG5vdCBrZWVuIG9uLi4uDQoNClRoYW5rcywNCkpvaG4N
Cg==
