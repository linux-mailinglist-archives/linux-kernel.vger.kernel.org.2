Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E843D945
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhJ1CXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:23:05 -0400
Received: from mail-eopbgr1400109.outbound.protection.outlook.com ([40.107.140.109]:11232
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229769AbhJ1CXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQdg+QdX8UdxTSMzcQjsKIRXigpZS13gX0Ouq72K5LSlfzWcZH/ohMXIntXWqF3uu0JoLxAJ8jm+CR5moXiJxqOzFlQSELdpa2LSySLQLxcgFhQz2/vCWA3XHaWB0zcTctRbD9MycsvEd+1Q2AxiE4jMtt4ucQcw4oRrKoij+7ujcd+cvciZsKl4CsYAZr1iZ10c96fprv2FWZGj4HQfEIqNzTuJMKO7wtFZi548jOEGKDgJdWbYl+GZ/s/VCeKXhmZGC+7WjSrbixBM2NlNfZdQ6R0rYbx+rzALjUvs+PcMfyNO1ZruzWDyWy+qJJzjpo/JpFedfVInQVKE1fhNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH+bPy9JDCaVFproKoCQwRBMrrvsxgJr3a/hOw1ExSQ=;
 b=VowmR90HYSLJVCR4AEYmmeQ+e+Uxg0nrwKYjJwF3JzqAAPT0V1h18RcmiITBkbZ1O0s5paOfvI8dmpj8rGsM37xMHKBCA5MpGqy7wcncxACaeRqS8fod+SVASt48ymiC1f/sWvb93E8IfezR+7DBwknVaD4uyK7rwPm8nBmprZYRAyi+tQhLpLM64f3cA/96sZS0UrTomjqdrVWQkeXO128jseZUdlmLrzqK/oZ+YiDHOECBfhz3d8EUahl6RCKN1anNJj8SSFTGachyqsz9qehS9tQ/0gFwzrSVHQJU/uentzUAEDAm8EMHMu+49MEP8QamkK/vrVi9E1MeYYRxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH+bPy9JDCaVFproKoCQwRBMrrvsxgJr3a/hOw1ExSQ=;
 b=DVkdC83wfp7tqIMUYh6EClfLK02/Pevml2Qyl/FMQu7HRUfckIXjqwKb+W6BN191yADw/uhl9qodjSLJtj+6Zh77Nyds2n9lRIqe7WwBnW9glsfLOQGaAO64pYIxTh3oaCHQhUtB97DXiuBQfYNbiSuSKRQjxd8LljRsRv3dYgQ=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB1193.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 28 Oct 2021 02:20:34 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 02:20:34 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogZHJpdmVycy9jcnlwdG86IHN1c3BlY3RlZCBtaXNzaW5nIG51bGwg?=
 =?gb2312?B?Y2hlY2sgaW4gaGlzaV9xbV9wcmVfaW5pdA==?=
Thread-Topic: drivers/crypto: suspected missing null check in hisi_qm_pre_init
Thread-Index: AdfLImPw9K3hXRldQ8ebJhLRIqPCMwAeB9sAAAHu/aA=
Date:   Thu, 28 Oct 2021 02:20:33 +0000
Message-ID: <TYCP286MB11880901F8D4A1563F0DF34F8A869@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB11889662BE368CEEF92CF65E8A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <e1d5b35e-5055-34de-5864-f2331c9ac051@hisilicon.com>
In-Reply-To: <e1d5b35e-5055-34de-5864-f2331c9ac051@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95674e1-1b9a-467d-4fec-08d999b985ca
x-ms-traffictypediagnostic: TYYP286MB1193:
x-microsoft-antispam-prvs: <TYYP286MB1193CB2E8E86303311C5A6BD8A869@TYYP286MB1193.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUvlcYi6ImtBlOlBlVwDUminm8TXvCFYWZkSeGIEdSyJbSgA8x9iLVB/cjZdToB0U81kXitVyaH11lQshymtEDirrtbPpPk1Gk5uDeFzRwF6htqbY5S11tGLeQwRSA7FckIL+CuUipouCVAqVqcuMHBZGH7aKHySkkZhRfQIVpbOXAwN9FmjdITKJrO6TJN6UOOwthp5IZghE1zzz8aAys8bGL+6nUFDBHR1n9yamSwRWuJb/0/iK2w3uMF5gcjERkb3XP0DzG4DJmrfb/RKOE/P+mONsOfNnVXvNGXyIsKYIIrgRbOjhiGr1CuxtQKuNxzpoI/qpoOrnl6gMVcc8XQII0C2wLhWu2EheBY8bar6KUblArRHGKJehDyceJDAD5dL8YYTED19874gQGMGAp4Qg6YRTv9I7sZvjpsRrnH0r8St1YJYGPWi1aLWnHwAlJTysyEaP8nRoYYP36XocQ/nSlzVR3W+qlG6fnmC+Kcsr73CpVGfX4Jd1IYxf/fLBROEfBSIvywkCkMfF6JWBU+Tgd2Jrp4rkSKqf9E2GTTvl05O+LtYES5QO8CBoNj3x3cV/BqihQRd0nxM9obEMsDbscDJmfpq0ZRj66N+rybB2rbHFEfbJx77Q7BMfiLopjytaPW15D0qjGlsTaWkrVNl7CP1usJrNm3NaWvOFOpvvGCN2i55JZSDnGzHetoocqVgXlxr1wlYV+9DJclvhbby49aTpqjxNCbRuEEi17Gm0cGyHUoQNAKhzn1gUHRJp1+6P+ZvwYbAyJtRQbcfkJ9lyd0jRBe0OiGaQFRLZUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(86362001)(71200400001)(5660300002)(110136005)(4326008)(6506007)(8936002)(83380400001)(38070700005)(316002)(786003)(508600001)(224303003)(66446008)(66556008)(38100700002)(2906002)(186003)(26005)(52536014)(122000001)(66476007)(64756008)(966005)(45080400002)(55016002)(7696005)(76116006)(9686003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y0VIK0JtMWdqcDVRRWZhRWZQQmdxMEVnMXMyMVBnWU8xYVN6dk10S2sxUHpJ?=
 =?gb2312?B?cHBlRmtHUFptRllGS3R0WDNWYStPNUFlUWJBbkR0S2x2dUdjdDZXK3dJZUZ6?=
 =?gb2312?B?dnBxRktxTTZlWWlKVmFVQm94b2pwUjNVZWFyVDBmRW1MNkZRc0ZNbGFZalQ1?=
 =?gb2312?B?M1RPVDVkYkhCL2c5NlVjYUF2dlFRZElvdm9rcjk5NFExN1dBaytvV0dRSkZH?=
 =?gb2312?B?WndqWU9OMEl3QW1aYUJtUlBGMzk2dS9iWXpWOXVXVkdveTVWc2JjSFo3MVAv?=
 =?gb2312?B?RzNnQVpoTjV6d20ycGJKay9HMlJUZWEra0YrQVNXZEFCajlQcWVFQlRVSTlX?=
 =?gb2312?B?ckJmM2xZbER5L3A1bmRvSEpIL2p3SDJJYllnY2ZmT0x0Q0FJZlF1WUgxR1B0?=
 =?gb2312?B?eDZpL0M2ZnVCMXI1eGx4Y1hnNkliVnFxcWhvRVV2dUxaRVRJazE3U3IvaE91?=
 =?gb2312?B?MjVUWDU0K2pOcEdqekhQQlE5WXNGajlSUi9hdDBWeTc1Nm4zNkFPS3diWWdk?=
 =?gb2312?B?bVNlbFcrSnE4V0theW1UbFRWNmMvR0wvQnBzMjJ2Vml4R2NmZnZjTnRuck93?=
 =?gb2312?B?YXNMeGlicCt4Q0NuUmNzajU5YVZKUzJZZ0R2OGJuYnpJbWRVY29mbVJEVUps?=
 =?gb2312?B?SGJzU0N4dEk0ZXFIVGpGOWM4anhXN1o0UDRhY1VaSGlucWREdktMVHpPcHIv?=
 =?gb2312?B?UUNFTW53OGc3NjNSbnc2R204UGt2L25vQk5aNllFQ3ZTRDdtM3pPVFBPNU9j?=
 =?gb2312?B?ZENSUy9iOWs5c1hBVW1lODZoTEVPVTVHeG5qMG9OS245T1pDRlVNdEcvTGkw?=
 =?gb2312?B?dm1MU0c2TSsyNU1ROXVISTNWZWZ5TDM5TkFoK09lSE9GWlZwaGlYMGUraXpL?=
 =?gb2312?B?dlR1cktGK2d1eU5hQTFIT1dWOC8xdjB0TGlDL1ZmeHhBNlo4Q090UTFVVnBF?=
 =?gb2312?B?WFVaWXdYSk1jR0VHdlZ3aUdSL2kxNkp1bldkYW53TFlmSUtsT3ZZOVY3dHZ0?=
 =?gb2312?B?bFFLbDR6d0x6UVhSTE9qZ1VQWU16NkFYR0lQeGNKR3E5aTgvNXhqRnpaUzJL?=
 =?gb2312?B?YWVMbDFNVG0vOUMzcm5uM3I3R0ErV1FXV09WZm01ajUwSExRelQ5cTcrQzZi?=
 =?gb2312?B?S0RnQ1YrNnd1TGFnZGVUNGw2MUNQK0NtbzhKaUlyeHpHZjRpaUZNcXpsTTVo?=
 =?gb2312?B?QTJhRFdPMGNmTTVuVWlaN1VFdGFseWN1Qjk5YXJocExJMnNzRERCaDZHc3ZB?=
 =?gb2312?B?U0Y0K1UzZWJBa0N3NkVKY0drMTlTU2lMMnErR3BSVHE1NXF0NGJZRWxGazhS?=
 =?gb2312?B?cGhsYWNEZ2hBUU5ZYUhMVFFwMXFVL0dMNTZMazNvN0ZGRW9yMlpyU0UvRzlO?=
 =?gb2312?B?QUFVT25QTGxpSzIwL1RHeEIwOTYyT21EY2M2cFpFUjJIenowNG5sdm84dmEy?=
 =?gb2312?B?N2N0MzdTUmNjL1h3WFdLRFA1QWMrNlg0SEFzbm10RGRGeXQrS0dyRVN0RHdy?=
 =?gb2312?B?M1pFRFVselR3b0FXWlh1d2w0RENJcXA4ak9acVIwQ29kZTJqak1nUC85TkRB?=
 =?gb2312?B?TzZxZy9TVmoxby9JL095em5obVZwd3ZSZHNwZWFIdnlxcU1yRWdnYnhZaXBn?=
 =?gb2312?B?dkNZQ01NSGlkNnJ5aXJ4VXdDWktpRkw2enAzclpxNlJ0eDRxL1FhRjlBNllj?=
 =?gb2312?B?VEZEN2s2Z3I4Z3JHWXhSTzltaXlsRHBzOHdBVkdqbWx6UmVxU0hEWVNqUHM3?=
 =?gb2312?B?K2JOMU9md1VKOUdQU29kdW9HK0F2MGt3SjVhc1MwMXl6VFZoUlFFM3piSDB1?=
 =?gb2312?B?RW0yMW8rSXZSZFRZaWMrODJSbmt0cWx1bTNsSlNwOXpxRTNaSnRJc3hwTWRD?=
 =?gb2312?B?VVoySzlSTEpqRXBkR1RCZ3NzSTBWUGh5WGh5SWpIYTU3RFBQUExtaEJnZEx4?=
 =?gb2312?B?NlN1Z1B6Z2owVWVsN2gxQ29tenNRdGorYWl5T1V1bC8reEhJbGxrSjFyRytX?=
 =?gb2312?B?Nkp4UFgxUUhkYk53WXc1L3hrcGREcmhMVFVMdUF2WU82TE0zQVgxcnFIaThy?=
 =?gb2312?B?RkNQdnRzNnNTZjZ6cUVEblVPRjFqYVZzczltQzhMRkNxbEVMenZrbGltdlJn?=
 =?gb2312?B?R2Z0dUlwcmdXbTExYlNOZEV5NFJSU09OazdicnM1WVJyWVVYUjRkVmdSanFQ?=
 =?gb2312?B?MXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e95674e1-1b9a-467d-4fec-08d999b985ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 02:20:33.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Yp/j8cGTihqAJWlXkfGBXVlxHStIc+fwVHTq4f1W8OnVBYVqNvgEC3QdIX00NUmdnFBeZ9wCc32rPH14o1aPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1193
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R290IGl0Lg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpDaGVuZ2Zl
bmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFpob3UgV2FuZyA8d2FuZ3pob3UxQGhp
c2lsaWNvbi5jb20+IA0Kt6LLzcqxvOQ6IDIwMjHE6jEw1MIyOMjVIDk6MjQNCsrVvP7IyzogWUUg
Q2hlbmdmZW5nIDxjeWVhYUBjb25uZWN0LnVzdC5oaz47IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9y
Zy5hdTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0Ks63LzTogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0K1vfM4jogUmU6IGRyaXZlcnMvY3J5cHRvOiBzdXNwZWN0ZWQgbWlzc2luZyBudWxsIGNo
ZWNrIGluIGhpc2lfcW1fcHJlX2luaXQNCg0KPiBIaSwNCj4gDQo+IGh0dHBzOi8vYXBjMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGgNCj4g
dWIuY29tJTJGdG9ydmFsZHMlMkZsaW51eCUyRmJsb2IlMkZtYXN0ZXIlMkZkcml2ZXJzJTJGY3J5
cHRvJTJGaGlzaWxpYw0KPiBvbiUyRnFtLmMlMjNMMzI4NiZhbXA7ZGF0YT0wNCU3QzAxJTdDY3ll
YWElNDBjb25uZWN0LnVzdC5oayU3Qzk4Yzk5YjliDQo+IDI1MDg0YTNmYWM4ZDA4ZDk5OWIxYTlj
YiU3QzZjMWQ0MTUyMzlkMDQ0Y2E4OGQ5YjhkNmRkY2EwNzA4JTdDMSU3QzAlN0MNCj4gNjM3NzA5
ODEwNjAyNjczOTQ3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFp
TENKUUlqbw0KPiBpVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
JmFtcDtzZGF0YT1lM3AwUFAxdHAlMkJBDQo+ICUyQnJVQUxVZ3Jvd3VZRVpUM0wyMVdvUUJxZkFu
NWlLYWMlM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IFdlIG5vdGljZSB0aGF0IGF0ICNsaW5lIDMy
ODYsIHRoZSByZXR1cm4gcG9pbnRlciBvZiBBQ1BJX0NPTVBBTklPTiBpcyBub3QgbnVsbC1jaGVj
a2VkLCBhbmQgdGhlbiBpdCdzIGRlcmVmZXJlbmNlZCBpbiBhY3BpX2RldmljZV9wb3dlcl9tYW5h
Z2VhYmxlLiBTZWVtcyB0aGF0IGl0IGNvdWxkIGJlIGEgcG90ZW50aWFsIG51bGwtcG9pbnRlci1k
ZXJlZmVyZW5jZSBpc3N1ZS4NCj4gDQo+IFRoaXMgaXMgZGV0ZWN0ZWQgYnkgb3VyIGV4cGVyaW1l
bnRhbCBzdGF0aWMgYW5hbHlzaXMgdG9vbCwgaXQgY291bGQgYmUgZmFsc2UgcG9zaXRpdmUsIHNv
IHdlIG1hbnVhbGx5IGNoZWNrIGFuZCByZXBvcnQgdGhvc2Ugd2UgdGhpbmsgbWF5IGJlIHRydWUg
YnVncy4gV291bGQgeW91IGxpa2UgdG8gaGF2ZSBhIGxvb2sgYXQgdGhlbT8gSWYgaXQncyByZWFs
IGJ1Zywgd2UgY291bGQgbGlrZSB0byBwcm92aWRlIHBhdGNoIHRvIGVhc2UgeW91ciB3b3JrZmxv
dy4NCg0KSGkgQ2hlbmdmZW5nLA0KDQpJdCB3aWxsIHJldHVyZSBOVUxMIHdoZW4gQUNQSSBpcyBk
aXNhYmxlZCwgaG93ZXZlciB0aGlzIGRyaXZlciBkZXBvbmRzIG9uIEFDUEksIHdoaWNoIGlzIGFs
cmVhZHkgc2V0IGluIEtjb25maWcuIFNvIG5vIG5lZWQgZG8gbnVsbC1jaGVja2VkIGhlcmUuDQoN
ClRoYW5rcywNClpob3UNCg0KPiANCj4gVGhhbmtzIHNvIG11Y2gsDQo+IENoZW5nZmVuZw0KPiAu
DQo+IA0K
