Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361DC41A6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhI1EqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:46:16 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:23015 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhI1EqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632804276; x=1664340276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oaZwgXDN9yQIoho76trrTmBfWwj8lrnLvJH46YYd9tA=;
  b=OHNrvOejY1IsBq76dTGPEtsSW7btPMTNLyDU4y7V8q9qzwMql4W/rvtq
   C2HYnD3RVgWzdkRO+JSfH6Czk/Z+gNnUHWWEj2aJeON8Ia7bhu8ONmyGw
   Zezf9CWs2SG7AFnac/yRJLeztOjIK2GtsU63uXjyEXSTz2eMGkGpeXfeV
   yKRX+n50WsQnFK/opa+yD8YFdqyjGENC73yw2IWVDIqBBcJ66DKdj8LoW
   MdmLXz1Z+FfgV6IUayvuYmojLoZO+Uk6AHyeMh5jDwoKdZahiiDrK48N5
   +YsQHsCjqjut7jtY28Og71oLWdkvUcOcIvmfXW4CVpbpSLIR7a3a9/u/u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="39963754"
X-IronPort-AV: E=Sophos;i="5.85,328,1624287600"; 
   d="scan'208";a="39963754"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:44:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrZiaDMKROZGum5TlO+S3u/T7b5vYJfCjEd9MHGkZrGNLiSrtxShb/CFMzz2H3r9CxIJhRb1E3z82/Uzs2xFHXXGcLpt4ThrKoOYaKbPsINfNFzBERc3YQ6zZugwEZah2Ul6RIclqN5uagq9l6DnFiQRMbh9EunmjdYCSwxqXrUK1knHDNekIfNVN/onk7yJqlPz+nKRxj2med2grssqXgR3GEcnuHfUmcpeIxron9vUDErSBB3Taya85doMGqvLNedCRxQCRLEsxqgKyDDQ5WRF5gUmNhgAkBlTQgE2H24V4ZrTQSd7e6p/0uFxN01jD9UYmboC/j0vKs0qnF6eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oaZwgXDN9yQIoho76trrTmBfWwj8lrnLvJH46YYd9tA=;
 b=F7ycV6M5PSvujohg1LrMYIfZ7YVURRPO3WJcVTVqcHPLZdkAHWi5hWY6U284jiPtnXvgldCiP1Vy/DiWex0pQfJhnMvLhZp2SpfdaaxgWjY+eiuE2SOg3HhHlH7C6huwiZKSHsFeea2djn9mD+T5SjtX6ES03C+yChTtDbnR45qp5zHFXd30mhG4PpewuuMsh3hZjuIm1l8HUsnK6yZO3cfGS0z5Q9rhQAPxDlwfBSVx0ObI3ZbFlJLJ4UAeaYsy8a4tAmAaXsPGUOFEq//kXjEkkODlV0K10BQbyTuojohUsm717TX8tjr7yDJ7hvG09f74+JoVSLVsAcSKWWJmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaZwgXDN9yQIoho76trrTmBfWwj8lrnLvJH46YYd9tA=;
 b=kwKy3qZXMSuQYKOgtDVztfn/Iv8xn7LnOrj1Be9DUIbU6xdbO+himPlb/dFu3826LB1ozZx+DWq1eC/m74Kph6KE3pGdWTyqNwlq+iR/VULFKrt/qqqP0FEKD9420ZleHdp5zogy59AWG5Vpiqly6x/tsKIJj5BzDN7Is4VlLDY=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYYPR01MB6731.jpnprd01.prod.outlook.com (2603:1096:400:ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 04:44:30 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::c9d3:f528:4d7f:4c83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::c9d3:f528:4d7f:4c83%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 04:44:30 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: Fix return code in mkdir_rdt_prepare()
Thread-Topic: [PATCH] x86/resctrl: Fix return code in mkdir_rdt_prepare()
Thread-Index: AQHXsRygJrKlFEaLNEa9KiWM7h2WTKuziLOAgAVbYuA=
Date:   Tue, 28 Sep 2021 04:44:29 +0000
Message-ID: <TYAPR01MB63308EDD28ABD3666D6AAE168BA89@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20210924081713.502039-1-tan.shaopeng@jp.fujitsu.com>
 <600c2857-8a5f-df1e-0edc-65fea2aae078@intel.com>
In-Reply-To: <600c2857-8a5f-df1e-0edc-65fea2aae078@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YTA2OWU0MmYtOTFkMi00MTk3LWI1MjItNjI4NWM4YWU4?=
 =?utf-8?B?MDlkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0wOS0yOFQwNDo0MTo1MFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4fa12cb-7b32-4e31-3a5c-08d9823aa8c8
x-ms-traffictypediagnostic: TYYPR01MB6731:
x-microsoft-antispam-prvs: <TYYPR01MB67319E5E05E1603766FCB9998BA89@TYYPR01MB6731.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jopUHwXdTuxRyiAXuyQpNRJVY2FRcIAyKkH13EK2n9PxTlUrG3+AulwBVKwVkXTKlVal4sIqDFShNOvh9dCRhr+qde0ivj3M7VQUQZHE3hJgAaFQ8wTlgnN901FM9Glik2EJv9lX2yUwyZ/QcHRy8z0Yx4cAYRRQ9TKxoAP++iwAIF7aPbz10LMC1fR8jnksgxXFbqcFufpTgdU2gfUIS9JK57EcDAQekGX9Wc9mSOHKemynu0EAlwY2WFMHvE/k3JOcCfCDjpMCWFlRR8v9JR8U0GfNeIRJBvp9aNfjgfFGlnd+vXynsM4yv2wUjZZk0BeC9K9heXswp+vyplGfQ19235iTwG3b1UyeVGZFFDG2mphNdAApDBoSvkPCp0zFpkt2TSM1t0gsO+ldwBx6MKd33fzfGuRWySzGfeTDAzK73Iufc/PP/ta80oTzmNtG/b51F8Ub8LmLYXzd5tHBPyBRsU6PCcxsSmlOSm4VSIeHkwrTK4Qm0PSEikwo1mxt+71QSz5rIoLehAGTOqYUUyyXc+gKOtFDFAiGGkdWqOL7lE3A4pMfCQhQ5soeie+5hHL1zw0CapTUuOjHVf9pDg7OpQ429pdUpJz6YTAkPd+8zdPByNjS6+8dVAn8kYYshovkttRCq133I5n+Vl6eWcJ5C00II+9a2mbKhBMIplv8H9B/4blKvMlqaFiH2PGID6/IhD1EtCcgrYFYNJddEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(4326008)(5660300002)(110136005)(38070700005)(316002)(9686003)(7696005)(508600001)(38100700002)(122000001)(86362001)(55016002)(71200400001)(8936002)(66556008)(85182001)(64756008)(186003)(83380400001)(2906002)(6506007)(66446008)(52536014)(53546011)(76116006)(66476007)(54906003)(8676002)(33656002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhTdVBvMmQ1ZmYvS1BhYVRHNTNJOE5sWVNSbG5XMDJiWExtK0lITWx1Y0ZQ?=
 =?utf-8?B?Q1ZMQ0hMOFpYcnFHYVMyZ1Iyc1lJM0pTUDJpd3lNV3Bvckt5OFhWY2QvaUpS?=
 =?utf-8?B?cW9hblVRRktuOHBXelFoc1B6UHRON2xtTXFIVW1lNDhtT2ZQNTFsRlFGNXhU?=
 =?utf-8?B?RmJRVU1DQ1pxOUJObzdJQXE2UTFMSTdwWFpjeW53dnk3VXFCc2c4QUxRM3hY?=
 =?utf-8?B?T3g4eU5nQTV2dktGdXN1ZzNrQWtEMGFERVhpbEZPdWVXUXJ4VTJVSU9yT2Ju?=
 =?utf-8?B?d0t4ZVhTTzhURUNjeUR3aUJzNy9sUEFHc0g2SnJrcEIyU3RYMjA0VjRFbXlv?=
 =?utf-8?B?VW1rWm81aXYvdXhQdWEwa1BqR2hFcnhkbGd5NWdxd3hEbFpYTGJLaGs3dnEx?=
 =?utf-8?B?Q283VHlEVlVaa0F0SFBNZWZlWGE0L3pTR1IyZy9wR2k2WGtkdHBXRjFhR0pp?=
 =?utf-8?B?dmhVSnhORHFIZ1pyOVc5ZHVoSktpa0xDSVNpN2FoYzV5d2pkdmwwSWdmR1Ix?=
 =?utf-8?B?TEErUWc5QXVrYXV0d3NtdG11TlhPQWc4b0RVaHUvMDlJem9WaDVYaTNseE81?=
 =?utf-8?B?bXB4VE45OGpxSWdwR3laNmsrNFJjN2FCYmdwMmhMYmJxVXNIejR2Z2I5OXhK?=
 =?utf-8?B?Z2dUaGpTVU1pTmQ3aGlaSjhSWGIzUXBKNjlnK1ZETVZmY09HdTZ6QldaZGwr?=
 =?utf-8?B?WElBemVleG9VM3hxenIzeUJraGo4dlBSLzh0TTVnRzdDekF6eWRVOHYyb242?=
 =?utf-8?B?U1hNa1RhS01RdVY0dExYRjJSN08zMTRrQlJRbFYvZ3h2T2hhQ3BwcjBwcFN6?=
 =?utf-8?B?L3FobmwrWUwzcExmaktqOVU1NjQyclQyOHlXRXFDeFJqbk5JU3h3VjV2eVhP?=
 =?utf-8?B?UjZEeTk1VEo4VStiQmZiZll3Tkx5UVVUZ1pDVHlqMFhyVzhCZ3ozQkFZZm5W?=
 =?utf-8?B?WE42cWZ0cEh2M09vRk5jWVlIT1dOTmZNTjJkejM4YjZPSWo1NWtWc3U3VElx?=
 =?utf-8?B?bVcyUHhUalA3cWJ6UitXc2htcUhSamJFdjdiazM2QzhaWnd1eVZseGZCR3Iw?=
 =?utf-8?B?aEtTdXRKNThXSEMzcENKQ3ZkaWFGOFhqNUVraC9MNHFabGI2YWNmTTdFMDFM?=
 =?utf-8?B?d0VjTGIvNnBPZEY5WGZMWm10V0d6VGdnR29LYU1iUWh2OUhESFQ5TldBb1ZU?=
 =?utf-8?B?TEJvVnJ6Ry90Q25HVWYvTnd3cmZGWW9aR3MvbUhld0xUYVgrNkw5dUpLUmlE?=
 =?utf-8?B?OHp5ZjAvRUFnUWJHcEJHMTNxaUZ2NE5BM1ZWckE3bWtWajA5aVFsZHdleUph?=
 =?utf-8?B?WkFOdEtBVTFaODM2TExzeFBrY0MxVE8reDdiQnJmcFRYME9paXJ2dE1UMVVL?=
 =?utf-8?B?TWxpVWZCdUV0TVhrZllwbmtSTkVDQzNCQ2R0Zm96QlpWeThiWjJyWnFlWmVr?=
 =?utf-8?B?bTNzQVFlMzNRSnk3WWVxcnVSemdXbTNBYUNORnZwRkIvMzladlRTSG9NbkZS?=
 =?utf-8?B?anU0cndZQjNRcEpkNmgySDFJcDFoSDRLcEgxR1MyVDd4MncvaUh6bWIxOG1r?=
 =?utf-8?B?T0w5eXpoMThPN1N1RVNScjRJTGNOYkdXVGsyN0p3MW1uSTBoYkhwR3YzbnFX?=
 =?utf-8?B?amNUZlZnUVNGNnI4ZG1RNW40NjV0eEIyOVUyZytPeWE5TWpKZ2NDOXRBSUtO?=
 =?utf-8?B?WFRFS3QvK3dDZFBrdlduNTlEdnQrd3ZzR2JvZGkvanVDa294NDEwMWdRWDFq?=
 =?utf-8?Q?Ihk3jqZf5uEDXrIbtWz5LSyqeNEurvEPPyVA9Cu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fa12cb-7b32-4e31-3a5c-08d9823aa8c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 04:44:30.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpWoJ4jJ/5dzkFRNDL+4CMPwK03S8LZ8HMUO7DX0T5cW8FtjylTeyvDbK5iTs2wQ3HTc1ee3t0Q0h8NeL9WJEpYbQ86kY1VwwJj0ecFfzWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gOS8yNC8yMDIxIDE6MTcgQU0sIFNoYW9wZW5nIFRhbiB3cm90
ZToNCj4gPiBXaGVuIGt6YWxsb2MgZmFpbHMsIHdlIHNob3VsZCByZXR1cm4gRU5PTUVNIGluc3Rl
YWQgb2YgRU5PU1BDLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhb3BlbmcgVGFuIDx0YW4u
c2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gSGVsbG8sDQo+ID4NCj4gPiBJ
IGp1c3Qgbm90aWNlZCB0aGlzIHdoZW4gSSByZWFkIHRoZSBjb2RlLg0KPiA+DQo+ID4gVGhhbmtz
LA0KPiA+DQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYyB8IDIg
Ky0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91
cC5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+IGlu
ZGV4IGI1N2IzZGI5YTZhNy4uYTkyZDA0NzQ3NmY2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBAQCAtMjg1NCw3ICsyODU0LDcgQEAgc3RhdGlj
IGludCBta2Rpcl9yZHRfcHJlcGFyZShzdHJ1Y3Qga2VybmZzX25vZGUNCj4gKnBhcmVudF9rbiwN
Cj4gPiAgIAkvKiBhbGxvY2F0ZSB0aGUgcmR0Z3JvdXAuICovDQo+ID4gICAJcmR0Z3JwID0ga3ph
bGxvYyhzaXplb2YoKnJkdGdycCksIEdGUF9LRVJORUwpOw0KPiA+ICAgCWlmICghcmR0Z3JwKSB7
DQo+ID4gLQkJcmV0ID0gLUVOT1NQQzsNCj4gPiArCQlyZXQgPSAtRU5PTUVNOw0KPiA+ICAgCQly
ZHRfbGFzdF9jbWRfcHV0cygiS2VybmVsIG91dCBvZiBtZW1vcnlcbiIpOw0KPiA+ICAgCQlnb3Rv
IG91dF91bmxvY2s7DQo+ID4gICAJfQ0KPiA+DQo+IA0KPiBJIGRvIG5vdCBrbm93IHRoZSBvcmln
aW5hbCBtb3RpdmF0aW9uIGZvciB1c2luZyBFTk9TUEMgYnV0IGZyb20gd2hhdCBJIGNhbiB0ZWxs
DQo+IHRoaXMgZXJyb3IgaXMgcHJvcGFnYXRlZCBhbGwgdGhlIHdheSB0byB1c2VyIHNwYWNlLiBU
aGlzIGNoYW5nZSB0aHVzIGhhcyB0aGUNCj4gY29uc2VxdWVuY2UgdGhhdCBhbnkgaW50ZXJmYWNl
IGJ1aWx0IG9uIHRvcCBvZiByZXNjdHJsIGNvdWxkIGJlIGltcGFjdGVkLg0KPiANCj4gSXMgdGhl
cmUgYSBzcGVjaWZpYyBpc3N1ZSB0aGF0IHlvdSBhcmUgYWltaW5nIHRvIGZpeCBoZXJlPw0KDQpJ
IGRpZG4ndCBkZXRlY3QgYW55IHByb2JsZW0gb24gbWFjaGluZSwgSSBub3RpY2VkIGl0IGJ5IHJl
YWRpbmcgYXQgdGhlIGNvZGUuIA0KDQpFbHNld2hlcmUgaW4gcmVzY3RybCBjb2RlLCBpZiBremFs
bG9jIGZhaWxzLCBpdCByZXR1cm5zIEVOT01FTS4gIA0KRm9yIGV4YW1wbGUsIGluIHRoZSBzYW1l
IGZpbGUocmR0Z3JvdXAuYyksIA0KMjEwNyAgICAgICAgIHMgPSBremFsbG9jKHNpemVvZigqcyks
IEdGUF9LRVJORUwpOyANCjIxMDggICAgICAgICBpZiAoIXMpIA0KMjEwOSAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07IA0Kc28sIEkgdGhvdWdodCBpdCB3YXNuJ3QgaW50ZW50aW9uYWxs
eSB0byByZXR1cm4gRU5PU1BDLiANCg0KQXMgeW91IHNhaWQgaXQgbWF5YmUgaW1wYWN0IHVzZXIg
c3BhY2UsICANCnNvLCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2ggaWYgeW91IGRvbid0IHRoaW5r
IGl0IG5lZWRzIHRvIGJlIGNoYW5nZWQuIA0KDQpUaGFua3MsIA0KVGFuIFNoYW9wZW5nDQo=
