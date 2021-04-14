Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B635EF41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhDNILZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:11:25 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:6112
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349988AbhDNIKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvLYVLFRzqjZvPs3NyZewNZ1AvI+TmNIRGm7jjW3MlPyF8PSWtdotWvf9VArHkAg2HUBFmRFRUlEDBcCyLel5N0+ojM4OmuSgkKxLmx5p1vfqReknnMReEGDc8lVudCMQkISHXqo5ZpYofejsJqDPNaJ0zFVIoOnRaSjt5RqEBCMsigp1afvZwcJrFgmb/wbw89FJF/WGcfVepnaBDA5O9MMbAi/Nu0wuyHAl9nURTwNLP2V4jjINSK8y8+1sYnIHXGBik7Y8J099yY4EXFhCy5q0fhAeMgxut3x6qZfStbrXE2pWt0BbINKsVzBRbqITqLC8v7oSNI20K9DgBxYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXbgXXgbkplKhi1qXP4uJ6TOwgdHfG0zKj0RTvp3xyU=;
 b=VJZijoL3QxCQAxCOFldKUGslYv4sKkdzodb5DnF/PsdQgEuvf8ufqvnDAqW20iH8b0g61UKQtAUohLQ/ilMZxfni796hcxeN3lALLcJSLlIlP8+i2f7JIEBqGoWImnyFa93vUmjpwELMhDHXg/nEtCI6CgH10CGO302AbIKcUfe1eGQuBNFRhWYbWyf0VuRwP319Af+4Rj/z1Lo9CEGbMBfrd5fIVN4J/SsfteSwjWuv+OsbCbpdi4W08TkJ6cq9dk5tk+nJEULeqBLum40b/WsrEjNeDr/2pPi4NuUILbWMBtdG6pGo48J2LgW7Jid6wAbEG9uC8SKDktjF4jF1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXbgXXgbkplKhi1qXP4uJ6TOwgdHfG0zKj0RTvp3xyU=;
 b=dNP0lPzV/D6TnhUtXqZznrAx9d5iCNbfE0U9nxfWF4nnu2bk9wtwyMjEo3B0BTG23mqCqq/6hPIltq1jABHDlcgsnvo1BRikumDXUwXN/J9xKiy7NDXNBe8upbQg7MVkPsqHYfjoI9Dr0I3tsmNs2zTnjP/S6rpfVvGsueIDNx4=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1243.namprd11.prod.outlook.com (2603:10b6:3:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Wed, 14 Apr 2021 08:09:57 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 08:09:56 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Mike Galbraith <efault@gmx.de>, Dmitry Vyukov <dvyukov@google.com>
CC:     Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogUXVlc3Rpb24gb24gS0FTQU4gY2FsbHRyYWNlIHJlY29y?=
 =?gb2312?Q?d_in_RT?=
Thread-Topic: =?gb2312?B?u9i4tDogUXVlc3Rpb24gb24gS0FTQU4gY2FsbHRyYWNlIHJlY29yZCBpbiBS?=
 =?gb2312?Q?T?=
Thread-Index: AQHXKrzDGHQ+LKiz3UinMerWnn+L46qynjeAgADR2QCAADfF8IAACicAgAADA/o=
Date:   Wed, 14 Apr 2021 08:09:56 +0000
Message-ID: <DM6PR11MB42020E2F3A57E285D512A7B2FF4E9@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
         <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
        ,<182eea30ee9648b2a618709e9fc894e49cb464ad.camel@gmx.de>
         <DM6PR11MB420260ED9EC885CCD33840EEFF4E9@DM6PR11MB4202.namprd11.prod.outlook.com>,<d47e3abad714ddae643c7e3a10bbf428a65ddd17.camel@gmx.de>
In-Reply-To: <d47e3abad714ddae643c7e3a10bbf428a65ddd17.camel@gmx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 406e4296-d119-4ce8-e43c-08d8ff1cb12b
x-ms-traffictypediagnostic: DM5PR11MB1243:
x-microsoft-antispam-prvs: <DM5PR11MB1243CDD79B522916A86985DBFF4E9@DM5PR11MB1243.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlTZXAjN6QuK8rV1ZnY0MBGu5lIfQZ1v00pM3m6c/jsfXiuGwuZ16lTyOweI0AustAWOYp1NtO5xh9KuglJ9dm6SZpJi7lpcBo3IqiJH4P7OhrdG2U9CJgLcA8XJ0Z/SFaVPVCBQbKIVGN+hwL27+Ltn/7reLIwiHJKwm21lVDcSPSZfUSzwFHk0X9WVNCkQvlnJxO8+zgZQRNmakLhKmVo3ndC4gdHwori433gbORy0fpYJVhRS9bRkDlmXPYlDWS1VsBeXtxqDLZioK4Ipur4scHsbX5/TK2KSeVbDODx7mEZvW5ZMZAErxiMsvlnGmC+hkNH6g5+Rh1FHOHPBJ8cfn2KOQZkHrS3kF0etDZoy0JN0imPh8JATaN+XV9Z5T2RgSGRXz9dx7E1RsNasoero8VmQ3ALGAExTJ9mm9ITXg9ZTG3vLXnIkLKrtKQE1LykmN+/hfUXHHodGfoeYQ538HiycJzgOTUAqufR4kg8aiuccZUGTe3K4BuizS8hwCfZzPjKEweysODSCMRLAcRp2e66jwsnI1GD2idwqyAWsvKnXGWOF43UB8nnR9wpsLv66fBFEUZET3oC9MXYWvTQRQVYDd96ve6H8uOxKoKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(366004)(136003)(376002)(5660300002)(6506007)(7696005)(26005)(4744005)(186003)(38100700002)(122000001)(224303003)(71200400001)(478600001)(4326008)(33656002)(91956017)(76116006)(8936002)(55016002)(52536014)(54906003)(110136005)(86362001)(316002)(66446008)(2906002)(64756008)(66946007)(66476007)(66556008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?TUxuN1FBNHc0V3h0SnQ4SlphR08wTnd4T21yclRvVmJ1aGNBWms2REtKVUox?=
 =?gb2312?B?T0F5bjZuck1oRVdWS3dzRW5XZTQzeEE1ZlJreU5DSmJZY0dGYllCbTRmWWlP?=
 =?gb2312?B?blg0UjVHTnN2TkVYZEtkNzJVWFF0OGNPVVFIcEQzTm0wSTdBQkFQT2VsMCts?=
 =?gb2312?B?cHNaOGhGUUtTeXBoN2pPWjRNZXhyaGt6OG4rajBhUTRvVWwzODhsZnY4alRO?=
 =?gb2312?B?Rlllckx2WVVnSWZ3T3Urc1RERlBiZ1pCalFZb3JDeE5kLzVsOEppK1JyVnY4?=
 =?gb2312?B?Zm9iSlFJaFVueVpHdEhmVWU4WHh0MDA3WTZnVE5WLzg3Nmc5VGZBdU1jM085?=
 =?gb2312?B?Q2UvTFhUbUN1YzdQZjZvWTJSaEFhNmt3bTZWYmVpajJqeFBFMGpjNmlLdXRp?=
 =?gb2312?B?bXNPS0hldkRTUytJb0g3K1ZVcDlSZ3BSNkplU3VhZTFNdFRMQmpaRDIyQTgw?=
 =?gb2312?B?ejUzUXFmdkZEZTJ6WVVPSER5Rm44UkhNZEJ2T1RicXZrZVhUckNqVXplMml3?=
 =?gb2312?B?UUZ2Uk9rcy9rb0lSQ1FCS3dYalJjUGlkK0xiR3BTWEQzYkp3SkVoUm55Y3ln?=
 =?gb2312?B?SHVWclcyWnF4WUNyYTZuUFJwWUxHWERKNnF5RFM5TU9YcUhQbCtzcy9ZcHF2?=
 =?gb2312?B?a2ptd2YxdDVSSDVYMk1iclNJZS9ZNXFYeHY5dWxZZGZ2UVZubDl4VWxIa0c1?=
 =?gb2312?B?aExnZWJSQi9LYVRSd0VnZm5QbDhJZ3pTVWVnUzFQUHoxVm81Zlczb0RSc0pk?=
 =?gb2312?B?eU1UbDNuU3VscmVveDlsZS9FNEs5aDdsd1pNUDJvOUk1a0hVSFppV2luNy9V?=
 =?gb2312?B?c1ZGKyt6YktaUHBia20zZ2h5Vi9kUUIzUXFrTlJrWmZYTU5EcFhuRkNZaWRr?=
 =?gb2312?B?Tlp5YmljNFlmSkNaU1RZOGNweEsxYkpqR2R5SStBaURvdy8xcERKMFlOSkhB?=
 =?gb2312?B?TnVXQWtRa1JYOWJtVnYwaDZOL3VtK0htc2J2QS9DMlhEeWhod0FGMmtrVFh4?=
 =?gb2312?B?VG5Ja01mcGdCME9raWNFU0d4bVJBUzBKL2o1R01CelFQV0Z2U3MvcEhBSCtO?=
 =?gb2312?B?Z1ozaFZOWTMraG1McFpaaHdCaFpOdkdhMExJVkhUcVdvN0VrYnNlWmtTdWVu?=
 =?gb2312?B?L2xtL0s5R0pnMS9pVk4yUTJ2ZDdUTDhWaWZ4alVlZ20vcG1WVkkzSEZtbjB6?=
 =?gb2312?B?MUlMRk1UTkpoZFdaa2tGRFhnNmo2d2swZmluZU9WQkd6bHVlaFFmb2xxTFRt?=
 =?gb2312?B?d3BzTUxjd2xpSFA0Z1drQ01TU250cGVNN1pzSVVJQ2NkR2VHTk4wWUZRNm8y?=
 =?gb2312?B?d0o3dHl5c1JwWlhVb3hHVDFuYk52YXkwT1h0L0dPMkFDQ0JDZENkWVlyejlP?=
 =?gb2312?B?a3lxV1k1bUFHYkxXZjZ6b0VBM3FQc2lZcWlrdytDYVl6b1RBS2ttRDRxcWN6?=
 =?gb2312?B?eHpZTWdFcFZWRmN6RkM2Z2pEemlSZW9FWE9iSVQwbzVmVGhpeHJNVWgyQTRu?=
 =?gb2312?B?QmJKQ0NZVW5jelZlUzZzWHIremgvOWcrNzN2RnBxZVJPaUpObVBBeXZJYjZq?=
 =?gb2312?B?MjBiQ1J5WFIrNDluTnAyTmN3Qkh3Vm5QYXo1ZFhITGVUdWFONUFDVFU5aGhx?=
 =?gb2312?B?ekNQa0N2em8raFkxd1ZQWmNwWUcxOGFMRmlvektSUnJsc2RvazBhMDhrR29C?=
 =?gb2312?B?T2JRUDVVcHZEem9QM1ZGbm81RGZ4RmdGSk5jRmxrMGNDTnB3Z1ZYYndpY2lZ?=
 =?gb2312?Q?uI985C8LNY1qtYtZrc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406e4296-d119-4ce8-e43c-08d8ff1cb12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 08:09:56.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MytB50pMoqLthg1VVkefiVu4kXRDIXICht3ZB0utQy0YEedXjKnGhSfEEaKdGiO24E6Cxn6pLC92fve/gHq5M9XrRz8LgmXlcwjQ3G65PzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogTWlrZSBH
YWxicmFpdGggPGVmYXVsdEBnbXguZGU+Creiy83KsbzkOiAyMDIxxOo01MIxNMjVIDE1OjU2CsrV
vP7IyzogWmhhbmcsIFFpYW5nOyBEbWl0cnkgVnl1a292CrOty806IEFuZHJldyBIYWxhbmV5OyBh
bmRyZXlrbnZsQGdtYWlsLmNvbTsgcnlhYmluaW4uYS5hQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2FzYW4tZGV2QGdv
b2dsZWdyb3Vwcy5jb20K1vfM4jogUmU6ILvYuLQ6IFF1ZXN0aW9uIG9uIEtBU0FOIGNhbGx0cmFj
ZSByZWNvcmQgaW4gUlQKCltQbGVhc2Ugbm90ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRF
Uk5BTCBlLW1haWwgYWRkcmVzc10KCk9uIFdlZCwgMjAyMS0wNC0xNCBhdCAwNzoyOSArMDAwMCwg
WmhhbmcsIFFpYW5nIHdyb3RlOgo+Cj4gaWYgQ09ORklHX1BSRUVNUFRfUlQgaXMgZW5hYmxlZCBh
bmQgIGJ1dCBub3QgaW4gcHJlZW1wdGlibGUsIHRoZSBwcmVhbGxvYyBzaG91bGQgYmUgYWxsb3dl
ZAo+Cj5ObywgeW91IGNhbid0IHRha2UgYW4gcnRtdXRleCB3aGVuIG5vdCBwcmVlbXB0aWJsZS4K
PgpPaCwgSSdtIGluIGEgbWVzcywKClRoYW5rIHlvdSBmb3IgeW91ciBleHBsYW5hdGlvbi4KCj4g
ICAgICAgIC1NaWtlCgo=
