Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB7038362D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbhEQP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:29:17 -0400
Received: from mail-eopbgr1400058.outbound.protection.outlook.com ([40.107.140.58]:32089
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243622AbhEQPOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A77DWjJzkwXXDvmlLYugzrnWVNouAyqWhI+KvvLDtueEGNNI74RSs50PaLQkzA1X8nIvpu0oSKf9v5XVtt2Kzqoe0Jg3NtN1FccHivU1zT/mQRPO0NqMuu5fu7e6Zu9nvA7zodYCfHlOdT6i5wv3AgSdg9acpYnvBtdzt3fhlJ1AnAcGCcBJHYyOzv76eMcP5rLevJzk7zQWYaydFxUP8EYjIxxI8CO7BPvOCwFA90EB12UcJQWaH4Epy3ZalNB5ThwM04hkBOnfQ4CDy335oM02EnbCPtZsHoD5Ve9+jsZG48acHqQatNj2RA0YoOEWQr6RUQfL4qN9qaR2T7KryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz+byi9+CSeP6MDHNelCKOj1gkQTpcn+qGQbKUjDnww=;
 b=U9qRldAn5qQ/qAxFgmEPeQ2bC5cumkYbvx0jKzeXzELXlJAKYYNWAX0RelsR3AsOzoDidrr+jmhWFvVqt81ldlXLciLjYp2jx9eyflkvbJ/S6aSQeXgTjyhJRfEEXh24UQZVXcPf5paLXqe1gu8sOrXZXGyYOF8gvE73v0V2v+hRnau+yjsrrVSfj4/YxnfD4q7YkUtCoyrdXmkVoZLVrnkzYDyORTzF7PJbgyHr3WAR1XzpGqSAEUjLNxgZKLrzsKYvlSfwoeNhRx8jRcIhcQleyQkqdrG3funToRG4c1oPG56sWP8PuxglJ437tObyu4cQxzX6KddKs7ZnoP1YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz+byi9+CSeP6MDHNelCKOj1gkQTpcn+qGQbKUjDnww=;
 b=fUV6DiNZiT42wcjWssJ2DEGE3xk1jdRV1l7FvCdrdhZMOQNlV70sim1M8X9LcYO47zl9CYn8xWVb8hA/O2whtiMR0vZho78jCQiBvKqP/Lne2p5VD8fe5avqorOmy/U4IsFPBjFh6ou0JE8udguG+kqZzNmPhqnjTLVUz4kduLE=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6592.jpnprd01.prod.outlook.com (2603:1096:400:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 15:13:15 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 15:13:15 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mm,hwpoison: make get_hwpoison_page call
 get_any_page()
Thread-Topic: [PATCH v4 2/2] mm,hwpoison: make get_hwpoison_page call
 get_any_page()
Thread-Index: AQHXStiyWzTF5qQ0pkqhyqurrqTYtarnoyGAgAAlfQA=
Date:   Mon, 17 May 2021 15:13:15 +0000
Message-ID: <20210517151314.GA2321791@hori.linux.bs1.fc.nec.co.jp>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
 <20210517045401.2506032-3-nao.horiguchi@gmail.com>
 <20210517125859.GA25228@linux>
In-Reply-To: <20210517125859.GA25228@linux>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78421a27-675d-459f-ff74-08d919464b59
x-ms-traffictypediagnostic: TYCPR01MB6592:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB65923710B57F25A742704B81E72D9@TYCPR01MB6592.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prnb7P0JG5SH0MPGaYyxpLgSlGRuaTCCKwgSHOP5guZKiJyUuutBIdtXS1UUyv8E3qOsopikt5SCez3uNYIOPbHF2K3LpepLagisciY/oO6kmNdcyN/a8eXsskVcviZ1A8t8n372z6tYcu9zCz+WXKXAC1ivihespTM4jJikv4KGs1szQY3PuB5Dnag5GASbYH/CPHtho9olx2/5Ini/gSm4a46H5/QazUHstWt7GXEyNDRu6LvoKxaX8CtV7949qxX88AiVhZXot8tNoE12bNawDa2m3e3T4jSSnHX6mrTU6vxDWSzWxPOFLtUle213fvaaF1x5TItVw3FQtD9LQvDkaWnGtWikzcK7PaRWiaPBGv1YmMpqzQc41ItCZ7jeUKVwpqrZvBgfMk3EGY2KJF9XZuuLWQm67HOXBAI2G/NBRCxnuBSM6/KCGV8KQIV9mZLfyogQ0tXVZ4XVvG2aDcJrgySrCnO1vWcICC/rHhEVXSwX5kNGCn27cbYlUXdskgmNtM3/j/+wFmC0iOWkiE2qdMEFARBNkVg7XVaJLxw9IHuH3jXrJJSNYDfiQWNm+bLffX8z/KbYPJPd9qA3n6+bzhrP1Uoyts09aMIV53k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(6506007)(26005)(55236004)(1076003)(478600001)(2906002)(316002)(86362001)(85182001)(54906003)(122000001)(33656002)(8676002)(4326008)(76116006)(186003)(66476007)(66556008)(64756008)(66446008)(66946007)(38100700002)(5660300002)(6486002)(9686003)(8936002)(83380400001)(6512007)(6916009)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Wk5tOTZRL2N6ZVMvM1hRRmlHVFBVdlJOck9HMVVwamFLNTlDcE5nQU4yQ3py?=
 =?utf-8?B?K053cGkyV1hhZDhYbjJYYklJTTBUcSs3S0F6TGRYMjQ5YitqbmkxOFVNM1VL?=
 =?utf-8?B?R1laQTV3ZUc5S2dvM3pRNmR1NVBBUFlxRWF0NmZNbHBKSHNiaC9mQmtDOTYr?=
 =?utf-8?B?NXpLVmhEbktBT2JLb0o0emVPSnRxTVByUlk4V1V6bzZHY0VkTitDSDVvOVNK?=
 =?utf-8?B?b3FvQmR5RW9UMlZWbEdXcE1rMlJjS3pDbVBWYWI4TEh6WERhSlRrbi9pSnp5?=
 =?utf-8?B?R25lWWhmMWdhSXBJN1NDUERWd2NIYWJ1Qm01MlUzeDFHSnJLRmFWclpEaUNK?=
 =?utf-8?B?MVFuQWFtSkxXRUg3VHlaOEZ2eERDSVZmekgzaE5GQUVjRm0vcG5La3lLV3V5?=
 =?utf-8?B?YXBYbmxOS1NpdnU0c3NvWElQaHl3TFczaU9Ybk9rb3pkUjlXc0cwb0xJSnFE?=
 =?utf-8?B?UlBWL0RONzhpWVlFTlZMQ3VmeG82N0hFN3JkRG0wbjZLdWkxTWUxbDVKVUNH?=
 =?utf-8?B?QXo2TVRSUnZzdWlQRStjUDBYb2dqUGRwVzE1YUlVNmRBdThkZDZXbTN0eEdB?=
 =?utf-8?B?Wkx4MnM5ZmM1MGF6RGpuWmkyN2xRbGdUWVc0WWx3cUVvL0NiTDVhd0VnYVBT?=
 =?utf-8?B?WTJKMVdlQ1QvSk5iRWNFTHJWR1dFSjVmcGMzeS9IbllKaExGTkVZOU91QVVM?=
 =?utf-8?B?ZDBCTytmbkk2SGVLSWVmY3UwMzZqYUxyV3QyS2ErZGE0TEVWRjZnQU9yMndi?=
 =?utf-8?B?Q3lWMjhQUTVtZjNuMkZmZG9ibDBhQ0FSSnZia3hJdjI5REtVeTZlTlFIYklz?=
 =?utf-8?B?d3BEYnJEaWptc3hQUUk4K09VKy9WdzJ1aUJtMS9tOFZQQlptY2ZUWVR4ZXZ2?=
 =?utf-8?B?Y0RrTlJTajJqSTl4M0pYSld2V3lXWXRMclF6RDduOERNdlZGS2puK2pwU2tD?=
 =?utf-8?B?dUZMUlZORFM3Vi9qeVFZVUNoV2c0V1ROTzd3NzJtZitzdTREYkF6S3N2bjhq?=
 =?utf-8?B?TFh3aWYyaVhLQjVsS0tYTVdrbkhrRkxEcVhSMW4zd3NXbGY1aUxqbzYvUytT?=
 =?utf-8?B?ZStRejY2dFBRZExtV214WkhlRStrRDg2TENiS2k0aWgwTXUySVNjK0trZkI2?=
 =?utf-8?B?NWdMOFArQTZsVldkRVNGNW9tMjJKa3lNQkhkKzRMcjE5eXNaSWZxeHhOZ3k3?=
 =?utf-8?B?aWVLbEsvb0dEWDR3QUZaYktBK1FBd0lucFdUcXM2K0Q1TTArOUlpdFVPOS9y?=
 =?utf-8?B?cjdOdktuVnZvb3JHRkZ3RHhnMGpTdmpxSzcxK2N3VytsUHVrQ0dacEVpQkpt?=
 =?utf-8?B?UFh0cHo0VmZUd3NtclgzMVk5YWVjQ09UU290UUg0U21Rc3ZrODI3NmdyalBI?=
 =?utf-8?B?dHcxV2ptdVVXYjlLVlNvWFV1ZElXTHpWRmpoQzh1Z0xQaHhGZllUMjU3cUdz?=
 =?utf-8?B?RnZHWElwTENJWkdQQUVoNXhOU0JPYm1SaHg4S0VsYnVOaStVQW5hVDUvdVBo?=
 =?utf-8?B?R3NjN1JCNjhLQzd3bitwYkpQbWlaTlg0RDU3UjJZNkxKUlJSUVNQSnZFUUdX?=
 =?utf-8?B?NmhZd2F3Qm5MYTFKZ2IxWDBFcXp5QTBpVDMrWEsvK21PTnZkSVIwODU3dGhx?=
 =?utf-8?B?UGtUbnJmSE1uNkpBY2Y1UnAwODlHMUdwRTFPY2ljdWpCRFhkb2ZYWXhSRHA3?=
 =?utf-8?B?VjBGVStRVEY3aUg3R2FHQzZVR2tMaHVBMlc0Y1AxYVVaSUpseko2OENLOUNO?=
 =?utf-8?B?N2g0dlFtbG9PYzIySXdrcnMreHl3VnNMbXNxdVdlN0VUZHVXd1A1SzBsdFJp?=
 =?utf-8?B?VEtlRnlQT3h0VlJWWXAxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7BCBD97998B5A4D9AFBF66A28679A80@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78421a27-675d-459f-ff74-08d919464b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 15:13:15.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFj83j9bSkdsFo8ByYNdJFPrUkFNWNS8VtlYY77tBaKFrwzuegqy5+RPE50N3LAs+IlR62N6jPVMp/fqBEP7wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6592
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgMDI6NTk6MDNQTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIE1vbiwgTWF5IDE3LCAyMDIxIGF0IDAxOjU0OjAxUE0gKzA5MDAsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiAgc3RhdGljIGludCBfX2dldF9od3BvaXNvbl9wYWdlKHN0
cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcGFnZSAqaGVhZCA9IGNvbXBv
dW5kX2hlYWQocGFnZSk7DQo+ID4gQEAgLTEwOTgsNyArMTA5MSw5IEBAIHN0YXRpYyBpbnQgX19n
ZXRfaHdwb2lzb25fcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiAgDQo+ID4gICNpZmRlZiBD
T05GSUdfSFVHRVRMQl9QQUdFDQo+ID4gIAlzcGluX2xvY2soJmh1Z2V0bGJfbG9jayk7DQo+ID4g
LQlpZiAoUGFnZUh1Z2UoaGVhZCkgJiYgKEhQYWdlRnJlZWQoaGVhZCkgfHwgSFBhZ2VNaWdyYXRh
YmxlKGhlYWQpKSkNCj4gPiArCWlmICghUGFnZUh1Z2UoaGVhZCkpDQo+ID4gKwkJcmV0ID0gLUVC
VVNZOw0KPiANCj4gVW5sZXNzIEknbSBtaXNzaW5nIHNvbWV0aGluZywgd2Ugd2lsbCBiZSByZXR1
cm5pbmcgLUVCVVNZIGZvciBhbnkgbm9uLWh1Z2V0bGINCj4gcGFnZSwgd2hpY2ggaXMgbm90IHJp
Z2h0Lg0KDQooc2lnaCwgaGFyZCB0byBzYXkgd2h5IEkgd3JvdGUgdGhpcywgcmVhbGx5IHNvcnJ5
KQ0KDQo+IEkgdGhpbmsgd2hhdCB5b3Ugd2FudCBpcyB0byByZXR1cm4gLUVCVVNZIGluIGNhc2Ug
dGhlIHBhZ2UgaXMgYSBodWdldGxiIHBhZ2UNCj4gYnV0IHdlIGNhbm5vdCBncmFiIGEgcmVmY291
bnQgYmVjYXVzZSB0aGUgcGFnZSBpcyBpbiBhIGZsb2F0aW5nIHN0YXRlLCBtZWFuaW5nDQo+ICFI
UGFnZUZyZWVkICYmICFIUGFnZU1pZ3JhdGFibGUuDQo+IA0KPiBSaWdodD8NCg0KVG90YWxseSBy
aWdodCwgc28gdGhlIGJlbG93IHNob3VsZCB3aGF0J3Mgd2FudGVkLg0KDQogICAgICAgIHNwaW5f
bG9jaygmaHVnZXRsYl9sb2NrKTsNCiAgICAgICAgaWYgKFBhZ2VIdWdlKGhlYWQpKQ0KICAgICAg
ICAgICAgICAgIGlmICghSFBhZ2VGcmVlZChoZWFkKSAmJiAhSFBhZ2VNaWdyYXRhYmxlKGhlYWQp
KQ0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVCVVNZOw0KICAgICAgICAgICAgICAg
IGVsc2UNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IGdldF9wYWdlX3VubGVzc196ZXJv
KGhlYWQpOw0KICAgICAgICBzcGluX3VubG9jaygmaHVnZXRsYl9sb2NrKTsNCg0KLSBOYW95YQ==
