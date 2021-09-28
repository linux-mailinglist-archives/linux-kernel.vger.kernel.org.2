Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45B341ABEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbhI1Jcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:46 -0400
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:40032
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240047AbhI1Jci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL4zkGz42LkfQHu/VT72jhcoJpRAum5ZHT42+dnQ6NwMEmDgGofiRdq+9LIeepblyqmZ/vSyNnGE8DYdQpZLRf7LOEzTCL4XIVgxL7ulvAqFdjzmOHNdYDVWsnL7Fp/Vo0bspkfsmCuG610fS7yMyN7eEhUfsbMNSt9DvXcta7sfRymnQtooW2F8yfAb9Z1+QOleoeEpnbxtIdtLHdahCoG4PRtMAR6pOEiXijkf85G98JdQR24nprUjt6AL7uO2o4G1Yxsb0mnxbVDZCKJGauSfvb7CksmwUiA7fBzxykbzYBPo8KnMpiqAo6DS7U61oe8C3zBs1ZzlFKvjVpoHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3TzZXPz94KpYohwyApSZNPU0VXsZzJFp2GjNnj/vdkU=;
 b=Ev2tSB1Xar8/DnG8b2hsFJbv7PCYtaFAdSXo5mHzmuxeUcMw8G0m0T90FF6YbehgSYEB1NrSMX84xVKtAiRYvD3Ptm3l2AaaPsNQef+r2R7PnrPSTrp0Xk11V7Fr+MIAQbGMDyhkWJnCqMInTydG1cYHv6tcqwLSGLT36jEe2lFT7f+ZXRvHbRmRv8eCV09So6nOtXnApbHa/15hG0t0oclrgdKXYPzuZfXrADHJwrg1T3CfJuUERqv0tO4wC7VkYYvzbABT/iWcV08exmi7QSsaVWUltEnNbCeh217j+TbXkj+Ujf/mkYwW1xtmLnATJfjwXnI7fAImFYeZR8xF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TzZXPz94KpYohwyApSZNPU0VXsZzJFp2GjNnj/vdkU=;
 b=tLLzyzrptO2vQ99i6AzLfaczb4OAmZGbM9hOkwloA4RGatgDNbw4HiiUJKGo6Z6iNhXRMCqqZnXtxw34had3nJTJEBRtlozOdgLSZyiZ4S0NO45vOKil7vuBpymzV2bqZN6y1Z3o/YWx0rDs+E0LJ4TMnv91AINvkyDGttbKCiE=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2665.eurprd03.prod.outlook.com (2603:10a6:3:f0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 09:30:57 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c10a:1cea:5bcd:f415]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c10a:1cea:5bcd:f415%7]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 09:30:57 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining patches for "Drop ROHM BD70528 support"
Thread-Topic: Remaining patches for "Drop ROHM BD70528 support"
Thread-Index: AQHXtEMgpGocC8KfaEigJnKmTxhh76u5Lo0A
Date:   Tue, 28 Sep 2021 09:30:56 +0000
Message-ID: <0e58f1d5-5427-466a-cf54-c24846ec43b4@fi.rohmeurope.com>
References: <CAKXUXMyKJ+zRf_7FChSND8yOV+Ws+2QWUGnBksR-99EFC3GzYg@mail.gmail.com>
In-Reply-To: <CAKXUXMyKJ+zRf_7FChSND8yOV+Ws+2QWUGnBksR-99EFC3GzYg@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71879a5a-c3ab-4c78-ae2b-08d98262ad11
x-ms-traffictypediagnostic: HE1PR0302MB2665:
x-microsoft-antispam-prvs: <HE1PR0302MB266549E027E83BE165831CFDADA89@HE1PR0302MB2665.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:193;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNk+ZBlFrJNY+OAsZfhe/dv2YTT4j7xBcIoD28rQWq4tHjXOzFNp0W7yGgW35yjq4ZMn/qBYZhinLUGShB6x+oGdoJOhSiEOBJlrSFv9MmL5rXXXvBvN9Fs6BZhe7lMySL0RB2Zs4QqpOXLMWkLDJW/CLncwja86W2R7RcZfXFeYYQ0vS0qPK2A1bgzqLIn17WJCTRf4h3BYs2Df4mCEumXzPenrYB+I8m1tJNYG7fHp6sHK3lHULFp/sk4CYRygDtygbGgEAUbJkt0Y0glFTY2s+ecO/W0Z0WCZFZfR7qWErokM9mBugHA0PijTz0MESPfBq1x8uuvTD3bTUqUzWjg4hyYAl6W0BDvKi1syYSZY889sKHAm1+rTFtsuVd1rKyxjXB/nL94IrCGLHfufpjhVL+W5tzKZ5KIwI3P14GrZEP1N6Mm+KatyqZRHf/hzRrdlDISwiPUKgUdHH2QSqGUBam1NXIbU8lFP0u8SC4tmDVBbzof1q0PXm3MW6DuMuUUBnSWB8Pq971A/d/S3w1DeMyOnjjkwcTQ1n5pwFwZI8jvWPRRcLUdm0MPEu2gMYp1XRwvZS4I/Z3x7f609I1N3oj9gEkIElzTxrMxZ2/6U+RGWUcx9c3b4mVioYoGY9Q0mbH9LM7LT29psqesbAonpxUq2UnirYK6aGR7fbhNae8DlyBP1/sxYpwpaKKKy0c1/ykjr9kr9VTKuWtQjmbKNH/ItwRP5VNNKd+Dwc4ej3JCtp4qK81opEQ7nTnmBisWvta8w/POyRaIM2+6ynDd81DtcuQvAUaZZatqhkCD3s4rCzIDMyCWZWsEqBw7z6MdZywAq73wrdRZI6blBp9BSLIMNyzIXMHMxPfnkjOc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4744005)(83380400001)(2906002)(508600001)(122000001)(6486002)(53546011)(6506007)(2616005)(186003)(31686004)(966005)(316002)(64756008)(31696002)(66556008)(38070700005)(86362001)(71200400001)(6512007)(8936002)(66476007)(76116006)(38100700002)(110136005)(8676002)(66446008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QklTMFBFWG1JYlN1ZjVxbHlFUnNla3JJNGN1RUFYa3c1OHBscjVnQk55VEkv?=
 =?utf-8?B?MHVyNTNEY1ZNYkxzcktaRitoWU51TW5sY0NjTXg4WTloTTRwQStuQ0Q3MTVL?=
 =?utf-8?B?dGlCQmhDS25tUGVqME56QmJXbXdmWnNMaEtXTWtROHJxcG1KQUVEWFdERnBB?=
 =?utf-8?B?OGpUeHQzQWhUZUV5ZEMyYnN3R1Y4RGZzNUZxS3B2aE8zWDdUa2Vwem9vL3Mw?=
 =?utf-8?B?dWl5Q0QyTlhQZU9MWVhRaFZoTy85WExQbHQ1WjVVRUV2VkE3ZkUzbXloQlhq?=
 =?utf-8?B?OWZFODlOVjI3ak4wOHhjZk1Oa1NNcTMzdGZjWHlNYlFsYk94ei9kSVpIMDBY?=
 =?utf-8?B?NnVsQkhiaWlVYXppOFNhZ1V4WTVNTEZPUzJRQ3VFaURHKzNWT2JlNXhqZ2U3?=
 =?utf-8?B?MVhia0c0QjBnLzlnWnlKVlAxRTFRd0VLcEg4Wmxzai83OXkvQjRrYnhsZzI3?=
 =?utf-8?B?b2JJbFZCRmV6cGVzM0ZpUWFSbWs4YW1tclNqNFl6RU1kaGkwdzVvTWhhdUVj?=
 =?utf-8?B?NHlkaXltcmNkYmp3cEh0bGhacGdPQUY1dVNyaEpBdHRpeEx4cjRCWkFLaGNz?=
 =?utf-8?B?TDNrdU9nakloUWVEeFI5YzR2dVMyWVJEREpLQ1BmdGMwS0tpaW9Dc0NYN2xl?=
 =?utf-8?B?cDhTWVA4YVJDSzJncWl4RUl2Q3RwY3N3d2ZkSjJDSUJvSUozbzhISmlXUExs?=
 =?utf-8?B?elpqRVJud2paWXg0dUJJZ1hvVGxlejlmU1U5a1orcXN3d2FhbEtCWFRwTGdn?=
 =?utf-8?B?WVEvbXNqV1lsRlhwN3JXYmVLU043VU1NcUpQaVBJcml1K0FEYS81NS84QXFw?=
 =?utf-8?B?OVhUdXFrYW9RT05EcGEveWVKUkZNSVZzUnVBbWFGSSt5MmNIM01MdFZyTzJX?=
 =?utf-8?B?MG1ibHRLSlN2UTVBZ3NzYlRzREQydjBqOTlvTGFNRXI2b0RJYzlsU0ZONWlz?=
 =?utf-8?B?NHc0d2c3SWNwbWlQOG9kS2IzQnl6VnlhSGUyczI2TnhudVZwZzFPeGZ5ZlJh?=
 =?utf-8?B?TnpFb3FsWmZ4RHdjTlU5a0I0L2tCQzJwNlViTExNY0VBVjJSWWN5dEdTanFW?=
 =?utf-8?B?dldMc2pINTVSTFVoRXpoanY4T3piNkdIbGNlekNGcm04ZTZlTThId3dHT2ZE?=
 =?utf-8?B?dFk4ckI1VlJqaFlxR1E0bDJ2dEJaNlZ2RHhjNXV0dUl2ZlBGM1dVdWhuU2ZW?=
 =?utf-8?B?Yk1sbnNjZzg4cnRycXp1THcydFVYTG0zQ3kyc2pqVm9HcnlCanFuaWpheVBT?=
 =?utf-8?B?VFFUelZ1RkZCM1F6SXdzUExnVWFZenlqVzNReUljV0hFSHRHWDhNNmVpZXNt?=
 =?utf-8?B?OXZSZ2toNnRyWlFvOFJPalY5OHRyeU45L1ZZdFJTaU00ZmpnNEJjQUFmOEdO?=
 =?utf-8?B?VFNXc1J1TVBPTWFrMkJyaGtpQjFFL2xnQWRkM1FYeDJFZEhRSEMzNllZMWFP?=
 =?utf-8?B?UE95U3VmVXdhbVhRUWpKc3ZBUHBSS1RpTzgwQTUydk5rU3pmODRvTWozZ21m?=
 =?utf-8?B?OWpxRkd5NmpYbjJzdUZwSENjM1VpRldROFE1RDFHc3Ntbk9FUU9qc2I0V2Yr?=
 =?utf-8?B?ZC83MHhPazJJWlF2Ni9wMXFjYm9jU2ZhVjJZSHdoN2FpdVFwNHBsRUREVldZ?=
 =?utf-8?B?NXZ5THErY1dpbW0zUDlLYnVqVVB1N3ZmdGZ0cWNOVzg4WjEwNlkwS0xOTU1M?=
 =?utf-8?B?cmlGcDFkV3RQelRNRDhGU2hZbFc3Z1BaM2tJUnUrZlJzVDRVdGhvRVdLcndC?=
 =?utf-8?B?OTJQdmtUUHdyZUErV2J4eWFVQ0NId3NXMzhaWFZ2aEFRdms0cEIvSVZna0U3?=
 =?utf-8?B?Zk1VdmtPYmJRWWszcWdjZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3B78F4C32D41F448591B561E6F1B1C1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71879a5a-c3ab-4c78-ae2b-08d98262ad11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 09:30:56.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFzNUKk/LZdlFvN2ru2moBb8qt3spHfSEnQQMbhGcJ89YAGSfxaElV0DC+himufJVUCrCcoytFuzHGw/+gy/+/9cDE7Xxkdd605wNo3kz0zOi6k7xcF2jD1NVmtmtUDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2665
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVrYXMsDQoNCk9uIDkvMjgvMjEgMTE6MzAsIEx1a2FzIEJ1bHdhaG4gd3JvdGU6DQo+IERl
YXIgTWF0dGksDQo+IA0KPiBJIGFtIHRyYWNraW5nIGNvbnNpc3RlbmN5IG9mIHRoZSBNQUlOVEFJ
TkVSUyBmaWxlIGFuZCBub3RpY2VkOg0KPiANCj4gQSBmZXcgcGF0Y2hlcyBmcm9tIHlvdXIgcGF0
Y2ggc2VyaWVzLCBEcm9wIFJPSE0gQkQ3MDUyOCBzdXBwb3J0LA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvY292ZXIuMTYyMTkzNzQ5MC5naXQubWF0dGkudmFpdHRpbmVuQGZpLnJvaG1l
dXJvcGUuY29tLywNCj4gaGF2ZSBsYW5kZWQgYnV0IG5vdCBhbGwuDQo+IA0KPiBBcyB0aGUgdXBk
YXRlIG9mIHRoZSBNQUlOVEFJTkVSUyBmaWxlIChwYXRjaCA5LzkpIGhhcyBub3QgYmVlbg0KPiBp
bmNsdWRlZCwgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIC0tc2VsZi10ZXN0PXBhdHRlcm5z
IGNvbXBsYWluczoNCj4gDQo+ICAgIHdhcm5pbmc6IG5vIGZpbGUgbWF0Y2hlcyAgICBGOiAgICBk
cml2ZXJzL3Bvd2VyL3N1cHBseS9iZDcwNTI4LWNoYXJnZXIuYw0KPiAgICB3YXJuaW5nOiBubyBm
aWxlIG1hdGNoZXMgICAgRjogICAgZHJpdmVycy9yZWd1bGF0b3IvYmQ3MDUyOC1yZWd1bGF0b3Iu
Yw0KPiAgICB3YXJuaW5nOiBubyBmaWxlIG1hdGNoZXMgICAgRjogICAgZHJpdmVycy93YXRjaGRv
Zy9iZDcwNTI4X3dkdC5jDQo+IA0KPiBXaWxsIHlvdSByZXNlbmQgdGhlIHJlbWFpbmluZyBwYXRj
aGVzIG9mIHRoYXQgcGF0Y2ggc2VyaWVzIGZvcg0KPiBpbmNsdXNpb24gaW4gdGhlIG5leHQgbWVy
Z2Ugd2luZG93Pw0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4gSSB3aWxsIHJlc3BpbiB0aGUg
c2VyaWVzIDopDQoNCkJlc3QgUmVnYXJkcw0KICAgLS0gTWF0dGkJDQo=
