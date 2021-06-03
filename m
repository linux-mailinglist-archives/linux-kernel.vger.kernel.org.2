Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF493999AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCFMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:12:42 -0400
Received: from mail-eopbgr1400042.outbound.protection.outlook.com ([40.107.140.42]:12768
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhFCFMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdQrXVp7tpKnyYYYci8XzRvLJ4CJyEJispktp1beK15gZC2MHhq5pgAxOnKQNqNxa05oJHGz7KzQJ66AoZFayD/ZtECLYxxifpotvyDs6Ax77mx6ZoiZESxVJYiOOZTI0nJDYUqlRBRk+8DqyPDjUEttK+gKIH5XamWAQzeEonHV6v/6APStgOGDDKxg+qkPRoQo+Nsy8eObnZEy9B37W83ORTWfqDHactcCP1ugF78DCUj08vfeKu00luxp3U7I7QzKxBTTd6R2gxBpBznjkaKSNNzLvqkxLMbM4aPAFidsAQWZaJGlT2r1Eyp3RMxqwsjH5pGjM1PFDImx+FxLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlfU6p0MnMxRBw1FvhLuacAKqqR1awiiWPrQOlbHmeY=;
 b=GEMcSkCkV9zOTG69vB72isVdWQDVCbvX5mcE2KMQnU/khvph266GIPtRvBYvxQcQZKAlZ5HdmgmjzMJOeRIiVv0wbWbw0NSrwcjU2vX3N6LsXJsvbQLAMfAEFqoTe+RC06RrDyKHrnUXXeWnbcWR0pVQNmWCAmMFU+6a5tIgf32HbF5iOZSvoAhte7XxzQhfbWGtN5UnVuz2VLp0tzt2c2ZKDeBpGdqbPn+kaZaxtvJN2ugruGoP3C48T+kVMxU9JHHYeYmjdIWR3ZF6UGMFelaTjhBSI8p0b1nJePxbgOmUGte9q79xoObima1NBK+BgHUR1WIB7GtHwvoY4MEcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlfU6p0MnMxRBw1FvhLuacAKqqR1awiiWPrQOlbHmeY=;
 b=TsoH7Qo69KDzjo/QCR2UgEgUmDlNRE7W6ZXe4ptKjhym1rQeQUbJ7eGH9WMoyuTQh9FfLy8I91KFMHEmeOg4bNC+bBogPflb3m4/HtHHeZegTN6TClp0A8G7svDhnEipyFvmZI3gmLvmr0KabQl/bFu0meY1uZhiaxBb4nXQku8=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3822.jpnprd01.prod.outlook.com (2603:1096:404:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 05:10:56 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 05:10:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] mm,hwpoison: Send SIGBUS with error virutal
 address
Thread-Topic: [PATCH v5 3/3] mm,hwpoison: Send SIGBUS with error virutal
 address
Thread-Index: AQHXTe22+lrqcvKOF0GtjrJlEENw2qsB0c2A
Date:   Thu, 3 Jun 2021 05:10:56 +0000
Message-ID: <20210603051055.GA244241@hori.linux.bs1.fc.nec.co.jp>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
 <20210521030156.2612074-4-nao.horiguchi@gmail.com>
In-Reply-To: <20210521030156.2612074-4-nao.horiguchi@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb9fe0ac-8d23-4292-a5f9-08d9264df7e8
x-ms-traffictypediagnostic: TYAPR01MB3822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB38226E99599BF66E7EAE4B32E73C9@TYAPR01MB3822.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0eFBrXeDu9yYyybY6gF4nWEw/UyxP3yRiMGAaYi7HCvqHiTUYnEQIFeVustqjKs5cP6GfmeNGt+lHaJkd2cELhajUqkxvEnEjdNYwbDjr+MXLFIRvE/1dfrp9X6crrwhnAcgtPb37hIb1/kMvNxQ9FXOHCuPHCdvm3v7MLLW+IypJtdGtGxAe3X/xHDt7X/tcNWk061vEmXLgdy5r5BLDk3hL/brKBipSXHRZZaLu7NbmA47XV9QbbuwhcFpQrgiPeqQiua3uqXTBuy4xvLzxizEApZ+yukcbqEiXhWEhoXCEMo2Rjtm4+Ts0IbWAokSr562UCLCpoq1cGf3S4PLZtTeKRdQX8xMlLOOw1S7nX0R8RA59ER5ixnN1tpyVRl6EpFiuJ1QEsk7HJOK3bcOp1hQaLqeWC99DIdIaQj+wjw0ulqP6yDSlDkLatTObDp+Hj5GMaD14b3Rd5SCRDllYz0R/U7cKo97rzdvuQBlZCiWNdZuVu5sSnZSifkYANQKrqClxbnrfXCWVWMBooiTD6rm21MJ8geqqQMZlYi5GupmUeX/qVtdG40bb7leAkTN/54gyp3Ejb24qJCtMlQ2G9KcisTdSdp9IkE46GEiuKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(7416002)(6916009)(6512007)(6486002)(85182001)(9686003)(83380400001)(186003)(55236004)(6506007)(2906002)(478600001)(4326008)(71200400001)(316002)(54906003)(86362001)(5660300002)(26005)(1076003)(76116006)(66946007)(66476007)(66446008)(66556008)(64756008)(122000001)(38100700002)(8936002)(33656002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TTJITEJ4SkxmdEdEOEVIeWlmZ3pxbFk4eGRiK2hSRVI3MmZCbkpLQ3hiUFUy?=
 =?utf-8?B?QUtzejMzVGhpNk1wYzJ6WVI1aXNwa0ljcmdiWlNUeVY2b2hKS1BPc3p5UVZX?=
 =?utf-8?B?SjFOelZCaDNGTi9OcGNDbVhIenpPNXFQZlROK253dEFFSExYMFRwa3dMQlhN?=
 =?utf-8?B?aFU2STJVNFROTXBXUjF6K2x2U1czMTlabUhXYjdsVlZTV2YwaG1UcHIzQnRV?=
 =?utf-8?B?RG03QkRjM3NWczdVdzBTc1A2ejQ2VmFSMzM5QlBMQ1hYSG5DOUVEUmdNbml1?=
 =?utf-8?B?ZDAzOERnaUFicDM0dHk3WHpNdmhmUjdNMGNNUTd0YWMwVDVUUWtidTJDazZx?=
 =?utf-8?B?RXRXZDdCVnplS0RIR0hOQU01QVJoUFUzVEg4RngyU2ZheGw3SnY5cWpLYzc2?=
 =?utf-8?B?S2kwZENFbnZ1K0dlc2ZzQkQyMldKdkdnWnNkMG51TXhqeXpGWHF1Zk03RDJn?=
 =?utf-8?B?R0kxZWsydEloWDRJbkdPREFaSzJoWHNPL3VtQlBYckZHcE12TFFTYjRxanJH?=
 =?utf-8?B?TE10VmZubSsya0syUzhESlJNSFY5cnlVaFA2US9JNktKeEp4TUh4SzB4ZDdH?=
 =?utf-8?B?VTUzS1BKSEV5aU92RStSOVBQK2krZ3pqNmMySW1xeHlDclE0THY3K081Rk9p?=
 =?utf-8?B?cUtKRlFES0Zyb2RSdml6SkZ5TkdEVnVsbkdkSTZsejJFbWlQbERKejhKVzQv?=
 =?utf-8?B?L2kwSXlQMjlESHhJVzAyRktHV1doaUs1cWg0ZDNmVUZyMGR0WDNMc2xvMm5q?=
 =?utf-8?B?eThVQit3OGdQakdlS09sd3AvcWtyaVhDZHh4bVBWRkREY3doNmtmcXhWTExB?=
 =?utf-8?B?dS9BK0wvTzdPZ0w3VkVCVVVhUjE0OHVVTnpFSndGQ3ZvMGlIOXNTcXhBR2do?=
 =?utf-8?B?NkpvbFlNbEhUOGU3T3F0S3kwR0NCaFJuWUh1ZTQ1YTBxa2F4T00yZU85NENm?=
 =?utf-8?B?aEtOaXlNOUpmMldudW1YMjViTjJjZDhaMzl2ZXJFTnpiQUxTeEdEblVTNndh?=
 =?utf-8?B?RHJaczNndExTWTdtd1pnZDFhWk5OVTFtaEpFRXU5b3hDS0pvVU5BdnJVSzJr?=
 =?utf-8?B?WXdXZDNRbVhxdHRFSWh4cnB1RE4reW92ZGRSRGNHOC90K1prQzY2OGlXUU5i?=
 =?utf-8?B?WDVFRkp3Tk5EVXBaR1hBNk5KWWU4d3JuTmFEMXdlSDNzTXNQOVdvS3VNcGtG?=
 =?utf-8?B?Y2tjS1JwU29POFk5aEdTRnhadmE1UThsdTFPWFRiOS9sWDA3SGVBM24yNHJ3?=
 =?utf-8?B?Y0VTUVdPNXlJZGJ4UFhtKytlTVZEZFd6bGwzNnlHb0xobm03STREZ0p0dlpD?=
 =?utf-8?B?bFZUczZmVktzZk1wWXB3NkdIM240Njg5ZGUveEJKNzEyU0JidDlkV2hDd1Ew?=
 =?utf-8?B?ck51dGxEWlg1bWxjZ2hieVR0YkIveFpqRURWaWViK2NnSEd0d0RqY04vUlVn?=
 =?utf-8?B?blNFM1VDVE8yOXdFejFTbXZ4UGFhR0pOQXVURjNGWitwMW9aVzVrRjVsUWtv?=
 =?utf-8?B?UUd6a3lYUktIeFlYeCsxNDVOeE5VMnlvek9qRmZBRzV6clpqNzFhYzhhTWlt?=
 =?utf-8?B?aStzVTdGT0x4cXppSGg4RVptOS96ZVU2N25tbkFkdmcxbGpOcUJteTc2ZzY5?=
 =?utf-8?B?TUlBaDlyN3dGTTRQdjdzTVRza2JuSU5oVnFtQUhTclR5NjYwa0tKQ2FYYXQy?=
 =?utf-8?B?Rkh4WVFPMHh0Q0JCcnV1aEgrYkw4S0VaWjJ5T2xDY0NrMktKN2UzbkR4STZ5?=
 =?utf-8?B?dExwN0FqMzZyVmlkcnNOSk15dHRmWE9aaXdmUDNQK1ovUTdyUm9iRS8yWjhs?=
 =?utf-8?B?SVN6Y2ZTZ0R0em1JdGQ4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47D44B65B466804894D967BC8947E6D3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9fe0ac-8d23-4292-a5f9-08d9264df7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 05:10:56.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1j+RXOGHhxDQYakJeYvu0zhEMY+Ro6tOQR8fUIdfTFk6Zu7J/5ZISbwTyD6tlnm7LYrOOPuv/cAzaHQ5wH8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3822
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMjEsIDIwMjEgYXQgMTI6MDE6NTZQTSArMDkwMCwgTmFveWEgSG9yaWd1Y2hp
IHdyb3RlOg0KPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29t
Pg0KPiANCj4gTm93IGFuIGFjdGlvbiByZXF1aXJlZCBNQ0UgaW4gYWxyZWFkeSBod3BvaXNvbmVk
IGFkZHJlc3Mgc3VyZWx5IHNlbmRzIGENCj4gU0lHQlVTIHRvIGN1cnJlbnQgcHJvY2VzcywgYnV0
IHRoZSBTSUdCVVMgZG9lc24ndCBjb252ZXkgZXJyb3IgdmlydHVhbA0KPiBhZGRyZXNzLiAgVGhh
dCdzIG5vdCBvcHRpbWFsIGZvciBod3BvaXNvbi1hd2FyZSBhcHBsaWNhdGlvbnMuDQo+IA0KPiBU
byBmaXggdGhlIGlzc3VlLCBtYWtlIG1lbW9yeV9mYWlsdXJlKCkgY2FsbCBraWxsX2FjY2Vzc2lu
Z19wcm9jZXNzKCksDQo+IHRoYXQgZG9lcyBwYWdldGFibGUgd2FsayB0byBmaW5kIHRoZSBlcnJv
ciB2aXJ0dWFsIGFkZHJlc3MuICBJdCBjb3VsZA0KPiBmaW5kIG11bHRpcGxlIHZpcnR1YWwgYWRk
cmVzc2VzIGZvciB0aGUgc2FtZSBlcnJvciBwYWdlLCBhbmQgaXQgc2VlbXMNCj4gaGFyZCB0byB0
ZWxsIHdoaWNoIHZpcnR1YWwgYWRkcmVzcyBpcyBjb3JyZWN0IG9uZS4gIEJ1dCB0aGF0J3MgcmFy
ZQ0KPiBhbmQgc2VuZGluZyBpbmNvcnJlY3QgdmlydHVhbCBhZGRyZXNzIGNvdWxkIGJlIGJldHRl
ciB0aGFuIG5vIGFkZHJlc3MuDQo+IFNvIGxldCdzIHJlcG9ydCB0aGUgZmlyc3QgZm91bmQgdmly
dHVhbCBhZGRyZXNzIGZvciBub3cuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiAtLS0NCj4gY2hhbmdlIGxvZyB2NCAtPiB2
NToNCj4gLSBzd2l0Y2hlZCB0byBmaXJzdCBmb3VuZCBhcHByb2FjaCwNCj4gLSBpbnRyb2R1Y2Vk
IGNoZWNrX2h3cG9pc29uZWRfcG1kX2VudHJ5KCkgdG8gZml4IGJ1aWxkIGZhaWx1cmUgb24gYXJj
aA0KPiAgIHdpdGhvdXQgdGhwIHN1cHBvcnQuDQo+IA0KPiBjaGFuZ2UgbG9nIHYzIC0+IHY0Og0K
PiAtIHJlZmFjdG9yZWQgaHdwb2lzb25fcHRlX3JhbmdlIHRvIHNhdmUgaW5kZW50YXRpb24sDQo+
IC0gdXBkYXRlZCBwYXRjaCBkZXNjcmlwdGlvbg0KPiANCj4gY2hhbmdlIGxvZyB2MSAtPiB2MjoN
Cj4gLSBpbml0aWFsaXplIGxvY2FsIHZhcmlhYmxlcyBpbiBjaGVja19od3BvaXNvbmVkX2VudHJ5
KCkgYW5kDQo+ICAgaHdwb2lzb25fcHRlX3JhbmdlKCkNCj4gLSBmaXggYW5kIGltcHJvdmUgbG9n
aWMgdG8gY2FsY3VsYXRlIGVycm9yIGFkZHJlc3Mgb2Zmc2V0Lg0KPiAtLS0NCi4uLg0KPiArc3Rh
dGljIGludCBraWxsX2FjY2Vzc2luZ19wcm9jZXNzKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgdW5z
aWduZWQgbG9uZyBwZm4sDQo+ICsJCQkJICBpbnQgZmxhZ3MpDQo+ICt7DQo+ICsJaW50IHJldDsN
Cj4gKwlzdHJ1Y3QgaHdwX3dhbGsgcHJpdiA9IHsNCj4gKwkJLnBmbiA9IHBmbiwNCj4gKwl9Ow0K
PiArCXByaXYudGsudHNrID0gcDsNCj4gKw0KPiArCW1tYXBfcmVhZF9sb2NrKHAtPm1tKTsNCj4g
KwlyZXQgPSB3YWxrX3BhZ2VfcmFuZ2UocC0+bW0sIDAsIFRBU0tfU0laRSwgJmh3cF93YWxrX29w
cywNCj4gKwkJCSAgICAgICh2b2lkICopJnByaXYpOw0KPiArCWlmICghcmV0ICYmIHByaXYudGsu
YWRkcikNCg0KU29ycnksIEkgZm91bmQgYSBzaWxseSBtaXN0YWtlLCB0aGUgd2Fsa19wYWdlX3Jh
bmdlKCkgZ290IHRvIHJldHVybiAxIHdoZW4gaXQNCmZvdW5kIGF0IGxlYXN0IGVycm9yIHZpcnR1
YWwgYWRkcmVzcyBzaW5jZSB2NSwgc28gdGhpcyBpZi1jb25kaXRpb24gc2hvdWxkIGJlDQpsaWtl
IHRoaXMuDQoNCkBAIC02OTEsNyArNjkxLDggQEAgc3RhdGljIGludCBraWxsX2FjY2Vzc2luZ19w
cm9jZXNzKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgdW5zaWduZWQgbG9uZyBwZm4sDQogICAgICAg
IG1tYXBfcmVhZF9sb2NrKHAtPm1tKTsNCiAgICAgICAgcmV0ID0gd2Fsa19wYWdlX3JhbmdlKHAt
Pm1tLCAwLCBUQVNLX1NJWkUsICZod3Bfd2Fsa19vcHMsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAodm9pZCAqKSZwcml2KTsNCi0gICAgICAgaWYgKCFyZXQgJiYgcHJpdi50ay5hZGRy
KQ0KKyAgICAgICBpZiAocmV0ID09IDEgJiYgcHJpdi50ay5hZGRyKQ0KICAgICAgICAgICAgICAg
IGtpbGxfcHJvYygmcHJpdi50aywgcGZuLCBmbGFncyk7DQogICAgICAgIG1tYXBfcmVhZF91bmxv
Y2socC0+bW0pOw0KICAgICAgICByZXR1cm4gcmV0ID8gLUVGQVVMVCA6IC1FSFdQT0lTT047DQoN
CkFuZHJldywgdGhpcyBwYXRjaCBpcyBub3cgaW4gbGludXgtbW0sIHNvIGNvdWxkIHlvdSBhcHBs
eSB0aGlzIGZpeCBvbnRvDQptbWh3cG9pc29uLXNlbmQtc2lnYnVzLXdpdGgtZXJyb3ItdmlydXRh
bC1hZGRyZXNzLnBhdGNoID8NCk9yIGlmIGl0J3MgYmV0dGVyIHRvIHJlc2VuZCBhIHdob2xlIHBh
dGNoLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
