Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB33212E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBVJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:16:19 -0500
Received: from mail-dm3nam07on2058.outbound.protection.outlook.com ([40.107.95.58]:13568
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230340AbhBVJOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:14:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAmbt13WFNUjzFCQ6OCyi6YsDbf+PvsKwzvsS1gObzcRq/7D9eXf3OfCovxfsBdSE0S5j/wtBn+OB0yMPhmYWxAtlnYwxe4hcyPstBy9bhGwpjzyiDTd8JpMElW695M70B6R1ogQG1FJA/21v1NuFBKUI8dIUW2ZR8zQs7wxNTNBTNDFOzdfnuBPPK7GCX+iFsHUVmynQCDRf93SDO0ibWD7Q4rl+w7yDcflcVdQRE7U126L6uZCmsPEVHtttBD+JWdUGrF4QHXPGDb0t0H3qlTnZWfF2Yq/zGTProi6znsGqMZBB0wwmEchyxZgIhgU03Snzpkgudn6ZYxDURTcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZuJ/yMyFyQxpN2ulNCOlRpvmNdOpVnWOPw3NZgaDd8=;
 b=GmCN55S7MOBQKLjvbHIbR4aWyTK+dpSFxz5jF6yez/VnFSay5whoIWBKIWdF7x28B11WdIGlfC8Cgom+A7aHQTNP6Fpv+DjYWoUR8J8ie8BortkWknYJsgCiF6gbwrLf5kOQG1cizj3F1RV6idVbcFVelfoZpvvI98PvD96I21wCsbt4I044Cz2w3Vk/YHfRASDQY3OUGFJQ8glqflo4cJquHRGOjVgAcnQPotjTLAGKhuR+3MbYk0WEvYulTbDSGt9BKYnHu5R45XNaHaznCo+BkYIzQnu9+qnCy4Ttnn2rGRlT4YhEmn6NdiLSbS6P3FQEqQK4skI1cWKEGB9Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZuJ/yMyFyQxpN2ulNCOlRpvmNdOpVnWOPw3NZgaDd8=;
 b=Dc2ML3LYajLxHxvhdOfDwAYHM9oYAEx+cTwjkgC00n3iB7ZghTO+p7uHU9yuXpSs9G3UThtVx89jdljh40vt9TvMLQZw2grqVKNis0TzKJbLO1cBFRM/1UdGJUkmjjc3o+KFDjuT93PodgNPFHVpNyzfp2zHaviQPXmMDbBGj28=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3911.namprd11.prod.outlook.com (2603:10b6:a03:18d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 22 Feb
 2021 09:13:48 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 09:13:48 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Tejun Heo <htejun@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB3b3JrcXVldWU6IFJlbW92ZSByY3VfcmVhZF9sb2Nr?=
 =?gb2312?Q?/unlock()_in_workqueue=5Fcongested()?=
Thread-Topic: [PATCH] workqueue: Remove rcu_read_lock/unlock() in
 workqueue_congested()
Thread-Index: AQHXBSQsUlFHrUgAcUWq/QuSrKRMa6pdOyAAgADM8gCABdTweA==
Date:   Mon, 22 Feb 2021 09:13:48 +0000
Message-ID: <BYAPR11MB26321D7D03F03A53B305967BFF819@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210217115802.49580-1-qiang.zhang@windriver.com>
 <CAJhGHyDE18PwQtS_W-aZA4Z6SAX3ZiCr6bA1Gqpu=XMN2n724w@mail.gmail.com>,<20210218151732.GR2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210218151732.GR2743@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de92af7d-dbc2-4bc8-7112-08d8d71229cb
x-ms-traffictypediagnostic: BY5PR11MB3911:
x-microsoft-antispam-prvs: <BY5PR11MB3911CD15175490FE6609D8A8FF819@BY5PR11MB3911.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cqzo9f+LtDzBpilvNQIoIh1XNBy9w3FO41HGydWji+eKdvEGuDraDaacbnzxY8Gxq8VFNfU9nwlpbP+fYjSKakQWeu6yXGrEknfNCFLLgAP1nI3rPIPHF+ekT528d2mATRxYG3Cd2iuk24mdNy4FEhmcl3DYNjCo3Jvf1xxleh3gXfkANdfzttSRNA+cTBUZlzzd+f0uC1ASXiqwOsh+ADyEG8ZdGaMEwe94VTKz8V9zfXOxkT+coFta0wzENYa69/UvIdu7ErE/ca9R+1Mk5t+U/9+UzMnfsGozxjP60kgiTrbXJ24OU+YvTUAUf4uc4cc8+g8SluaprJhi7HffwlmaUCF/UQnUeaNIBsIZrsrmVywc3Setx7N64sPQLvGbE5S53crd0gLjj6F9AEK8TwGmIQUgLCvhY7q1+YiLLeqSpnXahAbfKaWNR1BwmlRO0jy/jE+XfAHBZ+9o6iJepq5xI7KGH1jWvu3OvgZJa7ezNEECff4cAQSozM3fn+FSo78RPdEHeRJrWJhTFp6K+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(224303003)(83380400001)(110136005)(316002)(2906002)(5660300002)(86362001)(478600001)(7696005)(8936002)(52536014)(55016002)(66946007)(4326008)(54906003)(9686003)(71200400001)(186003)(76116006)(26005)(6506007)(64756008)(66476007)(66446008)(33656002)(53546011)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aDFmTkVKeWNKWHZUUWV4Z1NVQlJNZzJjdGw5VnI2eEM0U2xPV3NqUFAwR1JK?=
 =?gb2312?B?ZHFNd2ZIbXM3ejNUd1RjaWlOWHI3MndNNHByRjJaaWJkQktKdGVYUWUxZEJU?=
 =?gb2312?B?bW9VR2pjRkRRSk5iQzRkK0NVekpNNHFWUzM3QjVwNU1hZGNCVG1YVUJHNCt6?=
 =?gb2312?B?eWhwZWRLNEZ2VHgyOFNIS2huUXp5MUlmaTRwS3NXaGZ5WHo3QlhsVnNpZWNQ?=
 =?gb2312?B?ZFNVTW9jUFJFeGRaUmhkbkVZV2FXWTZGUVBVeHpoczlIWHlNZHNIZEpCdDMr?=
 =?gb2312?B?REJDTUhnOUs1L0djWHNoaGUrYWU4N2xNQXc1N3ZHQXhzcWlxSDZzSjFTbmZK?=
 =?gb2312?B?cEVKcUcrNkk3a1NxODVzNVZTUitmQzRDVWo3SkJySmluaVZWaldLMUY3bEpM?=
 =?gb2312?B?RjhydFZUaG5lYS93REd1VktXUktoZ3BqSTV2N2ZxY0ZJMXhXQ0xyZjh0WXlu?=
 =?gb2312?B?UXJrVXJpb2VTdTYrTmt0UnBFTWhKU1lFRmFTN1c1T2s4SW5VOXZ4L1ZMWHZo?=
 =?gb2312?B?UWdSemd0aldrejA3QSt6M3MzTU9DeElHdHZydGtlb2M5N1dTbVc3RXU0b3JJ?=
 =?gb2312?B?RzNkMWlSRnJ6VUxjNUkxaHRJK256YlFlVk9JZlRrWmFJRTAyM0t0RjZMeFhZ?=
 =?gb2312?B?Z2dWMkRtRUhndWVSUG5KVTRJNExtMVJ0Z3Btc3MvT2RMOUZFd0FOSnZVaklG?=
 =?gb2312?B?YndlY2FkZndiT2JybDR1RGVMb3lSeHcxM0h2YlNYVzhFUm5HN0svWkZ5OEpr?=
 =?gb2312?B?N01QRlJ3bXIzS3A5dmNTblo3dFJDZE9XM2NUTzFBbW5DellUamFFLzdWVlZF?=
 =?gb2312?B?QzIrVnFqNUtwOEd5eTYwT2UzelM2bENrbFN1Nzh0S3pBb0U3ZWN1ZFBSdlps?=
 =?gb2312?B?SjU0NTZmYUE2Y1dGbHQxUTA3bkt6Vk42bTVNc1FRQVNVR1p2OXJ2WXR4SGVY?=
 =?gb2312?B?U3p2K1hQTEttSjVpTGZTZnFoS2FXNzREbkVyT3hOR3U5NCtlTjh3T1JNQWNt?=
 =?gb2312?B?S0JCKzdZUmg5MVNaTnJ6ZVU2dlVGNFZMbVAwUTNUNjA0ZTBmbnY0eEtZQ1dB?=
 =?gb2312?B?ZWk5TnNhWGcxZG40QWwrU2Jva3ZCYUFUcFowLzFnU2VVOWkzNEFFTXpYa0g2?=
 =?gb2312?B?UnAxcVYyaWJGbHIwQ0tZMnBkTnkzMWk1U2tBUERrOWlIcE5QRTZEaTBPaVkz?=
 =?gb2312?B?L1l1b1ZUYzFqeWcwRTFPSm9Ic0xwQndINGxCY3ViL1dHM2laZHpXWmk4Tjk0?=
 =?gb2312?B?cHQvTjNjN25Ra0tUWEMyQ0tMQnJFY1VtKzdRYUM3V1F3SXlPU2V1aE5IY2NZ?=
 =?gb2312?B?cmZZUGNmdXppNTNXRW1qQnM4L1V0WnZ6ckFvN0RXRC9JaVRlU1drbzQ4ZG54?=
 =?gb2312?B?RjVsSG9hRVJEU0dTSmVWTGZTV1lpdnBYWVNVNFNrZU8yODZ2SlpEdXJvQTVF?=
 =?gb2312?B?OFE5aTZxQ2YvU211dGdCVGR6N1F1NkFrandLck9CN3Z4M1djcGtCd0pOWEtX?=
 =?gb2312?B?R0p5QkpWWVUwWnRjSlJxbjdqcjZkVVpKVXJEanBqMFZMQTlMSTFmTCtscDlP?=
 =?gb2312?B?TWIzYmJqdE5taUJieUFYVUxkQ3AzWG5MUVFXUWkveGJORUdXWEFnZVhEQTVu?=
 =?gb2312?B?SFN1M1ZOTEs0RkR6Sm8zUEwvL2tMdGQ2Z3hqWENub0p5cE9zTk5xMnFYckdz?=
 =?gb2312?B?OGtuMkcwbFJ6dFJWK3puZ1ZNMUt5ME01NDRkTXo0S1dBOUNDZmVtaDZlWTdP?=
 =?gb2312?Q?jywZRJ4HxG4S4rMVV0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de92af7d-dbc2-4bc8-7112-08d8d71229cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 09:13:48.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIStc8Z8uz0jgEMrQ7fKY17IBdP1kEz/vzDAhoFt3ItI9gJtujuRS4iZNAWkxdlJf80AIINfRgljmv1JwZ0vAI/OGyfXjrfYxgDsgVvMWPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3911
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF1bCBF
LiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMcTqMtTCMTjI1SAy
MzoxNwrK1bz+yMs6IExhaSBKaWFuZ3NoYW4Ks63LzTogWmhhbmcsIFFpYW5nOyBUZWp1biBIZW87
IFRlanVuIEhlbzsgTEtNTArW98ziOiBSZTogW1BBVENIXSB3b3JrcXVldWU6IFJlbW92ZSByY3Vf
cmVhZF9sb2NrL3VubG9jaygpIGluIHdvcmtxdWV1ZV9jb25nZXN0ZWQoKQoKW1BsZWFzZSBub3Rl
OiBUaGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRyZXNzXQoKT24gVGh1
LCBGZWIgMTgsIDIwMjEgYXQgMTE6MDQ6MDBBTSArMDgwMCwgTGFpIEppYW5nc2hhbiB3cm90ZToK
PiArQ0MgUGF1bAo+Cj4KPiBPbiBXZWQsIEZlYiAxNywgMjAyMSBhdCA3OjU4IFBNIDxxaWFuZy56
aGFuZ0B3aW5kcml2ZXIuY29tPiB3cm90ZToKPiA+Cj4gPiBGcm9tOiBacWlhbmcgPHFpYW5nLnpo
YW5nQHdpbmRyaXZlci5jb20+Cj4gPgo+ID4gVGhlIFJDVSByZWFkIGNyaXRpY2FsIGFyZWEgYWxy
ZWFkeSBieSBwcmVlbXB0X2Rpc2FibGUvZW5hYmxlKCkKPiA+IChlcXVpdmFsZW50IHRvIHJjdV9y
ZWFkX2xvY2tfc2NoZWQvdW5sb2NrX3NjaGVkKCkpIG1hcmssIHNvIHJlbW92ZQo+ID4gcmN1X3Jl
YWRfbG9jay91bmxvY2soKS4KPgo+IEkgdGhpbmsgd2UgY2FuIGxlYXZlIGl0IHdoaWNoIGFja3Mg
bGlrZSBkb2N1bWVudCwgZXNwZWNpYWxseQo+IHdvcmtxdWV1ZV9jb25nZXN0ZWQoKSBpcyBub3Qg
cGVyZm9ybWFuY2UgY3J1Y2lhbC4gIEVpdGhlciB3YXkKPiBpcyBPayBmb3IgbWUuCj4KPklmIHRo
ZSByY3VfcmVhZF9sb2NrKCkgaXMgcmVtb3ZlZCwgc2hvdWxkIHRoZXJlIGJlIGEgY29tbWVudCBz
YXlpbmcgPnRoYXQKPml0IGludGVyYWN0cyB3aXRoIHN5bmNocm9uaXplX3JjdSgpPyAgSnVzdCBp
biBjYXNlIG9uZSBvZiB0aGUgcmVhbC10aW1lCj5ndXlzIGZpZ3VyZXMgb3V0IGEgd2F5IHRvIGdl
dCB0aGUgam9iIGRvbmUgd2l0aG91dCBkaXNhYmxpbmcgPnByZWVtcHRpb24uLi4KPgo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwg
UGF1bAo+Cj4gSWYgaXQgbmVlZHMgdG8gYmUgY2hhbmdlZCwgcGxlYXNlIGFsc28gZG8gdGhlIHNh
bWUgZm9yCj4gcmN1X3JlYWRfbG9jaygpIGluIHdxX3dhdGNoZG9nX3RpbWVyX2ZuKCkuCj4KPgo+
IEFuZCBfX3F1ZXVlX3dvcmsoKSBhbmQgdHJ5X3RvX2dyYWJfcGVuZGluZygpIGFsc28gdXNlIGxv
Y2FsX2lycV9zYXZlKCkKPiBhbmQgcmN1X3JlYWRfbG9jaygpIGF0IHRoZSBzYW1lIHRpbWUsIGJ1
dCBJIGRvbid0IGtub3cgd2lsbCB0aGVzZQo+IGxvY2FsX2lycV9zYXZlKCkgYmUgY2hhbmdlZCB0
byByYXdfbG9jYWxfaXJxX3NhdmUoKSBpbiBQUkVFTVBUX1JULgoKVGhlIGxvY2FsX2lycV9zYXZl
IGZ1bmN0aW9uIGlzIG5vdCBjaGFuZ2UgIGluIFBSRUVNUFRfUlQgc3lzdGVtLgoKVGhhbmtzClFp
YW5nCgo+Cj4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRy
aXZlci5jb20+Cj4gPiAtLS0KPiA+ICBrZXJuZWwvd29ya3F1ZXVlLmMgfCAyIC0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC93
b3JrcXVldWUuYyBiL2tlcm5lbC93b3JrcXVldWUuYwo+ID4gaW5kZXggMGQxNTBkYTI1MmU4Li5j
NTk5ODM1YWQ2YzMgMTAwNjQ0Cj4gPiAtLS0gYS9rZXJuZWwvd29ya3F1ZXVlLmMKPiA+ICsrKyBi
L2tlcm5lbC93b3JrcXVldWUuYwo+ID4gQEAgLTQ1NDAsNyArNDU0MCw2IEBAIGJvb2wgd29ya3F1
ZXVlX2Nvbmdlc3RlZChpbnQgY3B1LCBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3EpCj4gPiAg
ICAgICAgIHN0cnVjdCBwb29sX3dvcmtxdWV1ZSAqcHdxOwo+ID4gICAgICAgICBib29sIHJldDsK
PiA+Cj4gPiAtICAgICAgIHJjdV9yZWFkX2xvY2soKTsKPiA+ICAgICAgICAgcHJlZW1wdF9kaXNh
YmxlKCk7Cj4gPgo+ID4gICAgICAgICBpZiAoY3B1ID09IFdPUktfQ1BVX1VOQk9VTkQpCj4gPiBA
QCAtNDU1Myw3ICs0NTUyLDYgQEAgYm9vbCB3b3JrcXVldWVfY29uZ2VzdGVkKGludCBjcHUsIHN0
cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3cSkKPiA+Cj4gPiAgICAgICAgIHJldCA9ICFsaXN0X2Vt
cHR5KCZwd3EtPmRlbGF5ZWRfd29ya3MpOwo+ID4gICAgICAgICBwcmVlbXB0X2VuYWJsZSgpOwo+
ID4gLSAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiA+Cj4gPiAgICAgICAgIHJldHVybiByZXQ7
Cj4gPiAgfQo+ID4gLS0KPiA+IDIuMjUuMQo+ID4K
