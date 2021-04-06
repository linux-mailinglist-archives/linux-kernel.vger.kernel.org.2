Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704B3354E85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbhDFI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:26:45 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:37472
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233333AbhDFI0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvJmQSIrj66Huugzx8wz+MM3sJA3owjteMJgOh60e33InEo6senD7w62wZiaZwofgrLKn4/7xHPvUyZ/V8fR+KVywE5GUAvaMus2VDojtPhidXlgN3xmtgk79KWxi1a7VRfIPkx97jOJmdnWGXqzyPg+4gO6vBLnLbpRJN5A8XfU+Jf7n+ZNrNRWXM0QZCGkqvCLjdHb/rSKpTVA+S/9ApbY5qx7xMtcyye3jDrCNJzEP/aJGhAjQDBsr7QPI89Ox9vLc+j/uAcobcyahP3NPQNqu+RcE8HXzxfHDN5umf+bJQu2wZLoeN36tAduKVpwC2pLajYN1yMSAh1TEotAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu2eGzM0r8xe6NO0RnCDtJD4yOdyLaF1eaXsu4SovrE=;
 b=jgGTlm8BlXPH5PgvxHAykm/PozlrtymkwwiKM5dEXoALDCS/7X3oYbyICfb/h8qQb0EWndotPkZ5tkp7spx742LRAzoDIAE7pNihamvPcUCMmZXgGvx+pMqx12fA0CEqPXfzIa3GcUNDuVL3VUfPTh6RZ6hyfKn7BBOllzetVXZQ0qh5YEJlT9/z03oIgu1WSDwLL6zBJNoWn6ajJW/W4ZXxqvsRuMHR/0764nZhNmE02qQt69rOuINp0rQUB5DUU9lxTFq0fWRypDFBns5fttry51GX+hkRLUtCmXYibtT8zzgI2ZQYb7llxmquicmN6L+LEMGlH/YWKI8S8HW6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu2eGzM0r8xe6NO0RnCDtJD4yOdyLaF1eaXsu4SovrE=;
 b=G0hvW6WhQOBmhGwg7X3RI2SqUfu4kjWOxnSGNlGK3V+SUc4GP61+bQ7T2HWpRo3E3iNzP9u3QajAN10SawSEjmqr5X70QXU0giMPNagA18TprioWj7gQHZhdpzIIOODe/w8AhU8RWleqicorr4etMnP2LfWe34fVTl/maER+HjY=
Received: from BY5PR11MB4193.namprd11.prod.outlook.com (2603:10b6:a03:1c8::25)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 08:26:34 +0000
Received: from BY5PR11MB4193.namprd11.prod.outlook.com
 ([fe80::b17c:f05a:9c88:8f65]) by BY5PR11MB4193.namprd11.prod.outlook.com
 ([fe80::b17c:f05a:9c88:8f65%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:26:34 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Question on KASAN calltrace record in RT
Thread-Topic: Question on KASAN calltrace record in RT
Thread-Index: AQHXKrzDGHQ+LKiz3UinMerWnn+L4w==
Date:   Tue, 6 Apr 2021 08:26:34 +0000
Message-ID: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9407824-ab5d-4176-a512-08d8f8d5b080
x-ms-traffictypediagnostic: SJ0PR11MB5119:
x-microsoft-antispam-prvs: <SJ0PR11MB5119B7277D572D63AD76C8EEFF769@SJ0PR11MB5119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GT+VCnlaxgEcLSPe/iqKDZD/tf78RHLK2MG8shaoQ0nipC5urLRCMtEn0+7TxKOcV1yaKUa+3+cTgsvrJu9OfVVNyloprMWx9y6uqb9kXwsBMUVqBzCHflUmg6VSZHlD4eNYWFkkCC5NVqzAtZ6I3rhmpAbOfsc6qd4+ufJTrPx+YhXWgOCHpJPUgZqcia9pCfq1OsvSivtAO4HqzHxSR67kj+L6hvV7TNifSnVZmyxSG63z9oGclDGr1rrAfznLk3xjS2GCdfCXP+IGleXUq3/pRkAQZgYlw8bvq+sVuYwWWTHPRoPNlZC9Fuk2bl/gsbM1hEoXM8SMzXdKgUExVswYZU9sZdPJlmy+0j152FGXT3UvBp9cCdmESjLid+2gsBlaoG6+7LkTKlyPZYzFa6tDSXGF9Vspk2WdbESPjDEfFcHx4YWob5sspthWPqWJN5K3NgL+qHgE+fZMaih9H5yXgg+mVxkuGt6B4VIuX7I5eAVILR4il9Mb2JZXCSIB4fAduClwrGlF07V+xJ0GsUq+BdFTd++y8pCNYTnqW9aZsW1dctXLpyYS8LD2I/sP3skDML7mLmPN00q9dwJpUbcFKUR3LKMT+2Q3+Wf0iuTGTH6vxJX9cUH7CfB/9F0CU7ZKLbboRoPthyWn10RMFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4193.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39850400004)(66556008)(33656002)(76116006)(7696005)(2906002)(8676002)(5660300002)(66476007)(6506007)(66446008)(64756008)(66946007)(4326008)(8936002)(52536014)(71200400001)(83380400001)(316002)(86362001)(38100700001)(478600001)(55016002)(9686003)(91956017)(26005)(110136005)(54906003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?SVp4WmR0NFV6Vnl4UkVTZUM0VmRIeFE4bEpkdFIvdkdQY2wwTUNEUGdvWnpv?=
 =?gb2312?B?RlNmU2Nlbkc5Rll2QTU2cWR1ZmlIY212TUpmbEk0eXBsZ2tvYWhxaWlxRUVS?=
 =?gb2312?B?UEJiL3NXekNQRjVNbDZOdWg1NWxkQ3NYNC95YVM3U1crVzVLaUJYdkpLUE1B?=
 =?gb2312?B?a0o3a0JuUUdKMEMwRDc1YkNzMTRQbXNhbUsrdlpNTHExd2VUV3NyRW5MSGph?=
 =?gb2312?B?d3dZM1E5TERVcHErN0V2L0V2VHpFNjZYdmpKczJuR2tZU3htME03MzQ0ZVpk?=
 =?gb2312?B?NTdEVGhKcUVTQzZKVTIzS0dWVGdaMWtmNkhTNWRFd3o1U1Z2Wk1RMXNYblEw?=
 =?gb2312?B?ZXk4NmFKTVlYdzEzcnV6UHg5dnE3a3JrTTV0dVdtRjk4S29tTnBLM2EzWU1P?=
 =?gb2312?B?anRRUktCTWZqL3NJVUJhaCtqWFYyRy9NQ3JWdTE2Z2tmS2I2c2UwTzBLQjQ1?=
 =?gb2312?B?NlVRSDhyYS9hK1FveFVRMHk5YXVUeUg2WmpYWE56aHgySVQrTjFLcktKUTRP?=
 =?gb2312?B?NEZsRlVXSm9rVVA4RzY1dTljU05qdStUeTNSQkpXU2N6V1FlQzFCQ0JZd3VG?=
 =?gb2312?B?YTZaRnRUUC9MYTUxTEJ4b0VhdDk2eTZ5NFg1UkJsZGhGcnJkUjRrMGp2UWtu?=
 =?gb2312?B?NmxLY0w3dndtMkdlSFJnMmZhQ3phVUFvTjJuNm1RQ1FIYU0zdkJGMmZpR1Yw?=
 =?gb2312?B?NjViQTNXTWtBdW9DRWNISm90Y1FMVHduOXRhdjRaczM1RFIwcTNqLzhxUWVJ?=
 =?gb2312?B?VStsWC8rS3VjeTVaYm5ya04wcjFadVMwSkt6MGgxQWRUSDAreGZIbmw3NndV?=
 =?gb2312?B?dHZJZGJtTnNKL1hlRDNFb3RKd29McFduQVlXS1k0cERJbmk1bUUrYkJZbkpC?=
 =?gb2312?B?ck0welhNeGQwMndwTmJRVHZyTmtTa3NXZXFTNnJ5WGx2NFova0V2ZUY2YWFO?=
 =?gb2312?B?dzROY3hUL3FEMytMNVlaYk4vaGJ0UkRRcjBKVnBTZlV2SVlIb3RYcnY5OHNw?=
 =?gb2312?B?TnZGVWJNcERSMzVOa2Y0RHpDZVFUc0FKZlJhYk94ZGU4bFUvRGhwVG5hSExw?=
 =?gb2312?B?cWIraTZOZXAvN0JrTnczUStDbDVTejlaakI5bkM3RU04clZJaVVlMTNjQUJB?=
 =?gb2312?B?dDcyM1A2anN4RGJ6VjhBeDUvcWtQd2wrMXRKWVp5VElISGtnV3RPckdyYy9u?=
 =?gb2312?B?ZU4wbFZQNEIyMEd1cDYyajJMRE9WNDBITW8rTVc4cEhQc0RuUjRnTWp4WUo5?=
 =?gb2312?B?Z3VzUFIxOVdwNzY3SEpWVE10OVh3M0owdyswVHQ1OG85cElUN2V6anpVa1JK?=
 =?gb2312?B?eWpQUnJwbEJlaFQ2TUk2Y0Y2Q3htYUR1eXFzRkxRSE93U1c0UHFUWGNhcnVX?=
 =?gb2312?B?ZGVVNFF2T3pWWW5HT2syTnpsTzFCOEc3R005ajUrbitNU1VxM2xxK09jMC9U?=
 =?gb2312?B?V0FzbURVQkRob1FuV1k3TitMczdiTElhUE1vOFRLeEhSY1dMMndOcVFncDNY?=
 =?gb2312?B?MHFJUGRoNG11RDVuenBvRmtDVGcwdElvNmtON1JsY0l6SkVHZE9WWG1uZWh0?=
 =?gb2312?B?d3I3dHpkV1pnR3hBQ3E4WWFhNjBxMTNJSjF5MHhNVHdYTEQ1cWl2K00yZDky?=
 =?gb2312?B?M3BEUnB1VFJSeVkxa01KVFMwc1p5MmNQbDd5WVNmUGNrZEhEek9qL1ZBUjFB?=
 =?gb2312?B?bUxJTUpYNk5iTXRrUXRqaktJeGwwM2pXWUJla01SQmFOUURBcVF1MEJsMFJG?=
 =?gb2312?Q?nP7pXtxrhw+lpJCH0g=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4193.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9407824-ab5d-4176-a512-08d8f8d5b080
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 08:26:34.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFVkcvFCRziJDnBu3Bk1Q04uxZVsGbFOdpYVbkh1y7hnO7KaT/BaItSfMc19zrXWZOaMzESaMtfYgMgmh34592IpLaE6zX2RB40D2kARtrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gZXZlcnlvbmUKCkluIFJUIHN5c3RlbSwgICBhZnRlciAgQW5kcmV3IHRlc3QsICAgZm91
bmQgdGhlIGZvbGxvd2luZyBjYWxsdHJhY2UgLAppbiBLQVNBTiwgd2UgcmVjb3JkIGNhbGxzdGFj
ayB0aHJvdWdoIHN0YWNrX2RlcG90X3NhdmUoKSwgaW4gdGhpcyBmdW5jdGlvbiwgbWF5IGJlIGNh
bGwgYWxsb2NfcGFnZXMsICBidXQgaW4gUlQsIHRoZSBzcGluX2xvY2sgcmVwbGFjZSB3aXRoIApy
dF9tdXRleCBpbiBhbGxvY19wYWdlcygpLCBpZiBiZWZvcmUgY2FsbCB0aGlzIGZ1bmN0aW9uLCB0
aGUgaXJxIGlzIGRpc2FibGVkLAp3aWxsIHRyaWdnZXIgZm9sbG93aW5nIGNhbGx0cmFjZS4KCm1h
eWJlICBhZGQgYXJyYXlbS0FTQU5fU1RBQ0tfREVQVEhdIGluIHN0cnVjdCBrYXNhbl90cmFjayB0
byByZWNvcmQgY2FsbHN0YWNrICBpbiBSVCBzeXN0ZW0uCgpJcyB0aGVyZSBhIGJldHRlciBzb2x1
dGlvbiCjvwpUaGFua3MKUWlhbmcKCkJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20g
aW52YWxpZCBjb250ZXh0IGF0IGtlcm5lbC9sb2NraW5nL3J0bXV0ZXguYzo5NTEKWyAgIDE0LjUy
MjI2Ml0gaW5fYXRvbWljKCk6IDEsIGlycXNfZGlzYWJsZWQoKTogMSwgbm9uX2Jsb2NrOiAwLCBw
aWQ6IDY0MCwgbmFtZTogbW91bnQKWyAgIDE0LjUyMjMwNF0gQ2FsbCBUcmFjZToKWyAgIDE0LjUy
MjMwNl0gIGR1bXBfc3RhY2srMHg5Mi8weGMxClsgICAxNC41MjIzMTNdICBfX19taWdodF9zbGVl
cC5jb2xkLjk5KzB4MWIwLzB4MWVmClsgICAxNC41MjIzMTldICBydF9zcGluX2xvY2srMHgzZS8w
eGMwClsgICAxNC41MjIzMjldICBsb2NhbF9sb2NrX2FjcXVpcmUrMHg1Mi8weDNjMApbICAgMTQu
NTIyMzMyXSAgZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDE3NmMvMHgzZmQwClsgICAxNC41MjI1
NDNdICBfX2FsbG9jX3BhZ2VzX25vZGVtYXNrKzB4MjhmLzB4N2YwClsgICAxNC41MjI1NTldICBz
dGFja19kZXBvdF9zYXZlKzB4M2ExLzB4NDcwClsgICAxNC41MjI1NjRdICBrYXNhbl9zYXZlX3N0
YWNrKzB4MmYvMHg0MApbICAgMTQuNTIzNTc1XSAga2FzYW5fcmVjb3JkX2F1eF9zdGFjaysweGEz
LzB4YjAKWyAgIDE0LjUyMzU4MF0gIGluc2VydF93b3JrKzB4NDgvMHgzNDAKWyAgIDE0LjUyMzU4
OV0gIF9fcXVldWVfd29yaysweDQzMC8weDEyODAKWyAgIDE0LjUyMzU5NV0gIG1vZF9kZWxheWVk
X3dvcmtfb24rMHg5OC8weGYwClsgICAxNC41MjM2MDddICBrYmxvY2tkX21vZF9kZWxheWVkX3dv
cmtfb24rMHgxNy8weDIwClsgICAxNC41MjM2MTFdICBibGtfbXFfcnVuX2h3X3F1ZXVlKzB4MTUx
LzB4MmIwClsgICAxNC41MjM2MjBdICBibGtfbXFfc2NoZWRfaW5zZXJ0X3JlcXVlc3QrMHgyYWQv
MHg0NzAKWyAgIDE0LjUyMzYzM10gIGJsa19tcV9zdWJtaXRfYmlvKzB4ZDJhLzB4MjMzMApbICAg
MTQuNTIzNjc1XSAgc3VibWl0X2Jpb19ub2FjY3QrMHg4YWEvMHhmZTAKWyAgIDE0LjUyMzY5M10g
IHN1Ym1pdF9iaW8rMHhmMC8weDU1MApbICAgMTQuNTIzNzE0XSAgc3VibWl0X2Jpb193YWl0KzB4
ZmUvMHgyMDAKWyAgIDE0LjUyMzcyNF0gIHhmc19yd19iZGV2KzB4MzcwLzB4NDgwIFt4ZnNdClsg
ICAxNC41MjM4MzFdICB4bG9nX2RvX2lvKzB4MTU1LzB4MzIwIFt4ZnNdClsgICAxNC41MjQwMzJd
ICB4bG9nX2JyZWFkKzB4MjMvMHhiMCBbeGZzXQpbICAgMTQuNTI0MTMzXSAgeGxvZ19maW5kX2hl
YWQrMHgxMzEvMHg4YjAgW3hmc10KWyAgIDE0LjUyNDM3NV0gIHhsb2dfZmluZF90YWlsKzB4Yzgv
MHg3YjAgW3hmc10KWyAgIDE0LjUyNDgyOF0gIHhmc19sb2dfbW91bnQrMHgzNzkvMHg2NjAgW3hm
c10KWyAgIDE0LjUyNDkyN10gIHhmc19tb3VudGZzKzB4YzkzLzB4MWFmMCBbeGZzXQpbICAgMTQu
NTI1NDI0XSAgeGZzX2ZzX2ZpbGxfc3VwZXIrMHg5MjMvMHgxN2YwIFt4ZnNdClsgICAxNC41MjU1
MjJdICBnZXRfdHJlZV9iZGV2KzB4NDA0LzB4NjgwClsgICAxNC41MjU2MjJdICB2ZnNfZ2V0X3Ry
ZWUrMHg4OS8weDJkMApbICAgMTQuNTI1NjI4XSAgcGF0aF9tb3VudCsweGViMi8weDE5ZDAKWyAg
IDE0LjUyNTY0OF0gIGRvX21vdW50KzB4Y2IvMHhmMApbICAgMTQuNTI1NjY1XSAgX194NjRfc3lz
X21vdW50KzB4MTYyLzB4MWIwClsgICAxNC41MjU2NzBdICBkb19zeXNjYWxsXzY0KzB4MzMvMHg0
MApbICAgMTQuNTI1Njc0XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhh
ZQpbICAgMTQuNTI1Njc3XSBSSVA6IDAwMzM6MHg3ZmQ2YzE1ZWFhZGU=
