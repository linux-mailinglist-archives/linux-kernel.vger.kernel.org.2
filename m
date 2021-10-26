Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1E43AFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhJZKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:14:29 -0400
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:13609
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231200AbhJZKO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:14:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvyn0tBDiw13E8GW196pqF6NOIluGE+G6pA7k68UfuCzkr10oAz9NGCEHQr2f1LgS7/W7LF6BWyNNHugmIX/5cqtl7Gl/FbV8lB1Ddh+q2P25x8L8kGMjVNtgUZR9rkO7f9dVOFYNnvRU+HepzFCE4ptNIU6Y9mpcanUQRzFk45aEsE6IPN8BCF85ip3WQmfK8tW8J2JvSsZgetpLRRfe3Y09U1Ypx1DjUw9X25V/wSVjZYJvmopcctRutb6t1RMHRrBcGcFY6g61B3Q+ZQLC9R4ugaWMwxBh38vfUMgX6axsWhMMzBGcVIz1fSX/wXLGprHKSrLzqELFD0a07/Llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa9RiBUIFl/JzZILC6cm9l54MhaLARg4mzYR1fOsYNA=;
 b=SGCKSHskyo97UtdJT7BzYP+UF1bXsAVs+U10ZQZlRJxiRtO9dGqzell++Mb7ozckfTpBMR9EmRmVequj8vE/Je8VEJHmDILLidmcJ2+X39SgOONiwqweDKmmdeop1ukYBJ0o7iHymKboroZii0uYSvD/pCGqGY+OFxYk0DXOgngVl5a2B1qBcSRfW86Bc10cf5ZL+JjY15oHwT3BdP3N0zLFT8UcUVMRHTsR6Kuch9c3VTV8TwCHJfX/Lqw+5v3JJtYz0s63oB3XaUEkdMJOFWzlojo1hzMuj9Y/aYpsG3NgUOrtKcrLKohtYAIQP8xBtwU2Pnmy1Od5lXglzlXP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa9RiBUIFl/JzZILC6cm9l54MhaLARg4mzYR1fOsYNA=;
 b=hC3WbGlew5Qiw9w/zkEkpFI0KcgjjX5xTb7sobd+sMhok9kFPFy+0fx9rm4l69Yn3ZddATMDOzFRoahQUMrEpq3V0nB3qkTMCefg92UvgIX+usNRRS9Md0iw8NgDXb8JJUSkGciT9r5SwUNDti62p23DAlRqoHLLyaiNZmN1lwk=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB0921.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Tue, 26 Oct 2021 10:12:03 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 10:12:03 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogc3VzcGVjdGVkIG51bGwtcG9pbnRlci1yZWZlcmVuY2UgcHJvYmxl?=
 =?gb2312?Q?m_for_to=5Fswnode?=
Thread-Topic: suspected null-pointer-reference problem for to_swnode
Thread-Index: AdfJqSNMGhrwAA/iSB2KhsgTg2gKFgAFfEqAACRFS8A=
Date:   Tue, 26 Oct 2021 10:12:03 +0000
Message-ID: <TYCP286MB11887E3D006B07C37FA5CEDB8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB11888DAE6D94FAE6A9F1CB438A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <YXbeF58NlV1o5tcG@smile.fi.intel.com>
In-Reply-To: <YXbeF58NlV1o5tcG@smile.fi.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fce6d5e-f3ac-4e35-2408-08d998690e88
x-ms-traffictypediagnostic: TYYP286MB0921:
x-microsoft-antispam-prvs: <TYYP286MB09218B15579A94657C3606318A849@TYYP286MB0921.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cxFqXQpl+SCc/YB4Pl6oxFzdaESfj+Dt28SZ7rfi8xkoSdgrDECn8Hwna6zQQboDn6HN4ookyJd6dM8LQnK2LfQzSApjF0YyMKpLxDDzS757cFMr09EDMUsImrhxuGcATBqyiM/t0kPjXzLASWGh13eBJxAItr7G2+863ugUCW8Kgux7Hs6aZeFsS5ostYCa3gxlmfLzXTkW7Hbyt3CzNfnJu3h813o8z0Ldodp/e6CPe1smgROmpOE+wXAd/nU7RcKsR+7yUkm/8/er0bXsm3//2PwVEGJWhjBlQi5pNa2+h3AlL+8nzF/iCMeuwpiiL9N11dNLoLWbCsIfplli5FKf2stEiwpmxBuhLaB2VX+a5oTndB0CG/UZxft6sgCat66g3tP2iCISMu64pSpjClvJPRiSc1nDmF/s4LrsuqP5RGp4DQiIOCDEEUim9UJm2mjx1iLqVPYe9OIvZdC5csMUtPYSZhqIMngwpAc52ivbKohbfF40du6ZgCf3kI9/iJmHffjB7Jq/VQ/DCiGAZNkvHflTRFO6Fx7G31Rq7J8tPBaWucrtjowGD3gLfeqTugMmMtZfNtLkubap2HYswwt4G1MBAE8et7gwcYaQvpRfIFZRdF9odh8XuaSAG3AIT4YlAAKxxJ/SWnfcsqyfJAk8T4URV8UV5a5LydL1aq+K/mMek5Ak0dVG/Z3/NQ3TwaofDWMzksT1c+dytX9Qk5txnU0uR1xKcVl7Oy89uAtdwsSZtZL2JHVvjWy7xwpFG0ain187LBblMw3qx8EdESvyHW12EgD2p+jIKhYKfY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2906002)(186003)(55016002)(5660300002)(8936002)(54906003)(76116006)(316002)(110136005)(7696005)(52536014)(66476007)(66446008)(786003)(86362001)(33656002)(64756008)(6506007)(38070700005)(224303003)(508600001)(45080400002)(71200400001)(83380400001)(122000001)(9686003)(966005)(4326008)(38100700002)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NXZYNE4vc3k5aHkyeXBnQ2RsMVBxS2hQRXVNTXVNNW43YXJKUTdwMHJSd2xy?=
 =?gb2312?B?T20wMmtlZHFxcjlvTVBYWFQ0cjhpUW5tOVBCUHVRcm9rQmZpMThDRStRc25X?=
 =?gb2312?B?MlRSU0E2V0Fzell5aEUraDZhNEE2SElCeDJqVXZHdG5VcG13VXdEdlRKV3Yx?=
 =?gb2312?B?cEcySVd6NHVRdDFpWnkvMFlnTFN6SStmOGhFZ28zRGYrSnllT1JrS2Z1RURw?=
 =?gb2312?B?NzJsN1lFTnpER3hJSEFHdnpTREVGRmJMU0xtM0lDTlNpa3N0LzlNUTVtOGdV?=
 =?gb2312?B?aEljSU5tQWxzb054UHozSXlJMUJSUzJ6OUtjODdnWlc4K3cxNHFMOVl2UnFN?=
 =?gb2312?B?N1pST05jUUVTeTVNZndNM0xUSWxlL01yeFNCdm9jTnR1OUt0MHk3Z21POUda?=
 =?gb2312?B?YmZ4NHZnNWJGVkdJL2lxaUdUTFdoKzN0Z0pQcU95NENmTjhZTlVqbUxEbWUy?=
 =?gb2312?B?RXBKczIwOXdjTEF2QU81VURPM0NXOXlRdmF1RzNJeGNadnN6bFdIVXE2c3Nr?=
 =?gb2312?B?Z2Z4dWY5UVVsdk0zQWRqcktTQlBEcXljbjBEM3lHM2R1VURaQkhRb3hHQ1k5?=
 =?gb2312?B?YjVMUGorQ2l3WWNIem1HamdsRDhlSmp0Uytzcnk3bkdIcFdDdEpGYnhEd0ky?=
 =?gb2312?B?cGF4NFQ2MENjVmxNY2JSaERpT2E0ZUg4ZVVIbnJyL2lCMGI1cE1NMTNCbXpZ?=
 =?gb2312?B?OUZTblZ5QWNyaHRsOUdINTlsWHVTZXV2LzdMdDdhVmlhaEF6Sk93T0pIY2l2?=
 =?gb2312?B?ZWNoajlMeHVNRVZOcWtHeXE5dWdTUjV6RnliUURxQjhySVU5UFR3d1J0N0VG?=
 =?gb2312?B?QnJtRThVRkRPY3ZQQnVxL3JjOFlvcG41eDUvVjRnd3RCZ1haSVkwTWMzcUV4?=
 =?gb2312?B?Q3RsUkhYRldLUzdTZ0U2K0FzNmNCV3R4VDh1dVNYWjRZOWJZWXZ1S290UEh5?=
 =?gb2312?B?SnFWV09uOE0wVm05RnpPWnFNRndiZ1BLNStqVVMxS0UxSW9CMU1MVFJUQU8z?=
 =?gb2312?B?UjF5VVdNQlM4Q3hoK2pPMGRpeWN5cTBocytzYno0ZXk5UzNQdTRyajhyNTlj?=
 =?gb2312?B?ZWZ0S2crQXMyRkZxMmhuNHJXRk9ZcTh4azhhWU8wUXllTjV3d0d4dUp0Q3Fx?=
 =?gb2312?B?eXlldW5iZ2NDb3VkUGtMeXpRb0N3MVZZK0p1ZC8zK01nRkU5dVd0WWdrenN0?=
 =?gb2312?B?SkNhcytlbHlzZnRsMVQxSVVwVWFTVkNWUUFTMnEwQnZpZjcvODJ5S1BEdDlU?=
 =?gb2312?B?VmkrNTVIOENjamtKdFJRWFM5eVlWZmlSSnN6dk0ydGMwb3RFdnNidCtHNUtJ?=
 =?gb2312?B?Z3k2KzZ5OGhJdW1iR3lYTVRQWkdjbW5NY1BFT2taWW40dE9BNU14TzhCbFA1?=
 =?gb2312?B?S2dCWnhHZ05oT0FPcm9yTUxzdU9NZDFrbGR1aDcyMXZ1THBKVjVpYzFXekRs?=
 =?gb2312?B?TWlBcFRjODBEMDN3OXB3UXRZdERUKzJqS1Q1SVNDcXJIdjdpZFIraGxnY2lO?=
 =?gb2312?B?WTdKYlppdUczSUxTM1RJNjJ3eSt3Z1pSN045SUhZcThPdnRSMjVzZkZsTTI5?=
 =?gb2312?B?eDhzWWRvcTh2OW51c09DallZL2RkUVhCQlJlS2I1NDRWVFRUNG5sL2NxRHdO?=
 =?gb2312?B?NUZtZnZxb0UzMWRzbnFieGd0dXFXQ1AxTWxJR3pHRWFHQ3BEemJsR2IvZ2h2?=
 =?gb2312?B?bm5IV0grOXBSMlhZYVNrRzNEQTRFTE5CcEt4SVkwVCtmcFFrMlo3L1Q0bllw?=
 =?gb2312?B?VExnUjVXQWxxMk1wUERTOWZjVUxvVHQrbURuTW9JNXRCRlpMUEZsOE1RSVNZ?=
 =?gb2312?B?MWliWDFpQi9HMGh2WkhrRjh1MHl2QjkxOGFUalBvRnZyV2Q2bEJLWTJTS25y?=
 =?gb2312?B?TFVDZkkvMW5DUDNIM0pzek1UZyt5cmFVZis1THlrbDBka2xYUzM0QUJrZXF5?=
 =?gb2312?B?dlF1YWkzS2k1NzJpQ0w2Y3pIQjJKYXhTTFZiQXQwSU1EWThLZGFJaUJrcWYr?=
 =?gb2312?B?MEFFaG5YU0RPYWFKN21RTnRWMTdPakxFK29sUGpMWVdYQnhPUjVQMVNNK2VO?=
 =?gb2312?B?TTIyVEFPTCtMbHV3bGRXRkdiRmlXSzNCZlhZaHRvRWQ0VmpVVkVYMktQUzUx?=
 =?gb2312?B?MC9IVG94WWpLTzBISnRXRzE2enloMEg2QzB1ZDNUQVJuVnNUWlRTU0N1ek1o?=
 =?gb2312?Q?2flJmRN2a3JuFY2I/kUTCqY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fce6d5e-f3ac-4e35-2408-08d998690e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 10:12:03.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhOPI5sok9zI/02wce1reqTJSQxx8JBQVtjC1+EF9IrBPcPrPi71qo6aTCEUo2tWTG7PENRM1yM2luz5ACNpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB0921
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5IGluIHN1Y2ggZGV0YWlsIQ0KDQpZb3UgYXJlIHJpZ2h0LCBz
ZWVtcyB0aGlzIGlzIGEgZmFsc2UgcG9zaXRpdmUgcmVwb3J0IGJ5IG91ciBzdGF0aWMgYW5hbHl6
ZXIuDQoNClRoYW5rcyBzbyBtdWNoLA0KQ2hlbmdmZW5nICAgDQoNCg0KDQotLS0tLdPKvP7Urbz+
LS0tLS0NCreivP7IyzogYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIDxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+IA0Kt6LLzcqxvOQ6IDIwMjHE6jEw1MIyNsjVIDA6
NDENCsrVvP7IyzogWUUgQ2hlbmdmZW5nIDxjeWVhYUBjb25uZWN0LnVzdC5oaz47IFNha2FyaSBB
aWx1cyA8c2FrYXJpLmFpbHVzQGxpbnV4LmludGVsLmNvbT4NCrOty806IGhlaWtraS5rcm9nZXJ1
c0BsaW51eC5pbnRlbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJl
OiBzdXNwZWN0ZWQgbnVsbC1wb2ludGVyLXJlZmVyZW5jZSBwcm9ibGVtIGZvciB0b19zd25vZGUN
Cg0KT24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgMDI6MDM6NTFQTSArMDAwMCwgWUUgQ2hlbmdmZW5n
IHdyb3RlOg0KPiBIaSwNCj4gDQo+IGh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGgNCj4gdWIuY29tJTJGdG9ydmFsZHMl
MkZsaW51eCUyRmJsb2IlMkZtYXN0ZXIlMkZkcml2ZXJzJTJGYmFzZSUyRnN3bm9kZS5jJQ0KPiAy
M0w0MDUmYW1wO2RhdGE9MDQlN0MwMSU3Q2N5ZWFhJTQwY29ubmVjdC51c3QuaGslN0NkYzAwMmY2
NzcwNWY0ZmIxYWY1DQo+IDMwOGQ5OTdkNjQ2MTYlN0M2YzFkNDE1MjM5ZDA0NGNhODhkOWI4ZDZk
ZGNhMDcwOCU3QzElN0MwJTdDNjM3NzA3NzY4ODINCj4gMTYyNzM2MiU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQw0KPiBKQlRpSTZJ
azFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9TWgzNnNYJTJGbkhhY3Z3RG1T
VkFqbFBzDQo+IEk2VVdhJTJCYjBSTUluJTJGdnZIdEtjZGMlM0QmYW1wO3Jlc2VydmVkPTANCj4g
DQo+IFdlIG5vdGljZSB0aGF0IHRoZSByZXR1cm4gcG9pbnRlciBvZiB0b19zd25vZGUgaXMgbnVs
bCBjaGVjayBpbiBzb21lIGNhc2UsIHdoaWxlIGluIHNvbWUgY2FzZSBpcyBub3QuIEZvciBleGFt
cGxlLCBhdCBsaW5lIDQxNiwgdGhlIHJldHVybiBwb2ludGVyIGlzIG51bGwtY2hlY2ssIGJ1dCBp
biBsaW5lIDQwNSBpcyBub3QuIFdlIHdhbnQgdG8ga25vdyB3aGV0aGVyIGl0IHdvdWxkIGJlIGEg
cG90ZW50aWFsIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBwcm9ibGVtLCBpbiB0aGUgY2FzZSB0
aGF0IG51bGwtY2hlY2sgaXMgbWlzc2luZy4NCj4gDQo+IFRoaXMgcHJvYmxlbSBpcyBkZXRlY3Rl
ZCBieSBvdXIgZXhwZXJpbWVudGFsIHN0YXRpYyBhbmFseXNpcyB0b29sLCB3ZSBhcmUgbm90IGZh
bWlsaWFyIHdpdGggdGhlIHNvdXJjZSBjb2RlIGFuZCBpdCBjb3VsZCBqdXN0IGJlIGEgZmFsc2Ug
cG9zaXRpdmUuIFdlIHNlbmQgdGhpcyBlbWFpbCBpbiBjYXNlIHRoaXMgaXMgYSByZWFsIHByb2Js
ZW0uIFdvdWxkIHlvdSBsaWtlIHRvIHNwYXJlIHNvbWUgdGltZSB0byBoYXZlIGEgbG9vayBhdCBp
dD8NCg0KVGhhbmsgeW91IGZvciB0aGUgaW50ZXJlc3QgdG8gb3VyIGNvZGUhDQoNCkxpbmUgIzQw
NSByZWZlcnMgdG8gc29mdHdhcmUgbm9kZSBvcGVyYXRpb25zIGFuZCBpdCBtZWFucyBpdCB3b24n
dCBiZSBldmVyIGNhbGxlZCBpZiB0aGVyZSBpcyBubyBzd25vZGUgYmVoaW5kIGl0LCBtZWFucyBp
dCdzIGJhY2tlZCB3aXRoIHByb3BlcnRpZXMuDQpJZiB5b3UgdGhpbmsgaXQgd2lsbCBiZSBhIE5V
TEwgcG9pbnRlciB0aGVyZSwgcGxlYXNlIGRlc2NyaWJlIGluIGRldGFpbCAod2l0aCBhIHRyYWNl
YmFjayBpbmNsdWRlZCkgd2hlbiBhbmQgaG93IGl0IGhhcHBlbnMsIGJlY2F1c2Ugc3VjaCBidWdz
IGFyZSBzZXJpb3VzLg0KDQpMaW5lICM0MTYgcmVmZXJzIHRvIHRoZSBzYW1lIHN0YWdlIHdoZW4g
b3B0aW9ucyBhcmUgZGVmaW5lZCBhbmQgd2Uga25vdyB3ZSBoYXZlIGJlZW4gY2FsbGVkIGFnYWlu
c3Qgc3dub2RlLiBTZWVtcyB0byBtZSBsaWtlIGEgZGVhZCBjb2RlIGJyb3VnaHQgZnJvbSBkYXkg
MSBieSB0aGUgY29tbWl0IGJjMDUwMGMxZTQzZCAoImRldmljZSBwcm9wZXJ0eTogQWRkIGZ3bm9k
ZV9nZXRfbmFtZSBmb3IgcmV0dXJuaW5nIHRoZSBuYW1lIG9mIGEgbm9kZSIpLg0KDQpTYWthcmk/
DQoNCi0tDQpXaXRoIEJlc3QgUmVnYXJkcywNCkFuZHkgU2hldmNoZW5rbw0KDQoNCg==
