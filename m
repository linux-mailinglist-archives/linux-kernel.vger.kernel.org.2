Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060493A34BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFJUWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:22:32 -0400
Received: from mail-sn1anam02on2118.outbound.protection.outlook.com ([40.107.96.118]:47908
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhFJUWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/Bttwj+7OSzZvKJW5RUWxoTyWLf2IR1PxXejQoLlR7dx+qVCDM18NuHFJ9ul5H0kXWQrZIJyHwjccVthYPz8P+NYFCg1slfik+EkAHJ/JxdL73vIRT8uMMlryCtPf0K75ptdlrE1yKefIE/neLK7j/inb9IzZHGvcVhy+2g3FHMVqQ3IDAiwawt4uIyB4+WH+ht++Ea1NdKMPFERnRbtK0m3S+CTK1j9x8rAjPgga5NLbaUoA/BaWmxTyJkqN1lnsuHOZnXVMgQa+LvrYiH6tmn5+PwatLqrIeBFm4r64cTEQtN1IEDvM46bIY91GDCIb4HqyGQ8XNerTOzeiPMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiroEI/Rxc+esE/fHYZ9MX3MOPBcS1O7Tv/I1w1ZDec=;
 b=moU8dqMTHwn6cLqb0ZsowowehjI8HFsMtLhnxBMqR1c/8RZFy5TU+fNnUG118wy0YgjNfA72Yuyhz6hCdmqLKeqgNwTe5yU6wWRuOn1jTjnFb+AH4dQGYNByQVRKdPuTovan09sStl2+B8q/R9zRocjQ5OYCWxKlm5Z+uSB15m/gBc9AGaNPWdGUZZJzB/8vNB30OGaLfLGEr6UkP3/Q5DbjDLoIKz0zVd77ixMVQa52IdoFN4csVMT4nNfpwD9xGIBXszbIie4hF7YvJBlcrlEMWN31M9I6CfWDPJiqFtBSpkQLlAgupfRsewSQT5IZoCuum4aUAfrk1yHEzWZZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiroEI/Rxc+esE/fHYZ9MX3MOPBcS1O7Tv/I1w1ZDec=;
 b=neVcDNZnwFJaks6fFN71+n4/IPDfwyhIvDOEDDLxAaZFr4VK+IKJKiZ2V8rEi/dDwzpWByIaci8qBgr+HUp3H9nPTZIiM06T9MSfx/Ctt5dxkleN290UsH6QKDvtBIjKRAZzGgghkOpYkn5Fkcl+pZ4z+UveIpv1vZ9KkPBgqgw=
Received: from BL0PR02MB4370.namprd02.prod.outlook.com (2603:10b6:208:42::31)
 by MN2PR02MB6671.namprd02.prod.outlook.com (2603:10b6:208:1d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 20:20:32 +0000
Received: from BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc]) by BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc%5]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 20:20:32 +0000
From:   "Lin, Zhenpeng" <zplin@psu.edu>
To:     Kees Cook <keescook@chromium.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Thread-Topic: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Thread-Index: AQHXXJPcuZEfER7lZkGUYZVvC3KPw6sKLTUAgABFaQD//8QFgIAAiFAAgAKw9YA=
Date:   Thu, 10 Jun 2021 20:20:31 +0000
Message-ID: <C7AC6780-9DCE-4CE5-90B1-9AA0731341BF@psu.edu>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
 <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
 <202106081140.F73F91F@keescook>
 <25AB8A72-B970-47C2-8688-48126075E72E@psu.edu>
 <202106081614.E57675D17@keescook>
In-Reply-To: <202106081614.E57675D17@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=psu.edu;
x-originating-ip: [67.22.19.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f06e615-a235-436b-d499-08d92c4d3271
x-ms-traffictypediagnostic: MN2PR02MB6671:
x-microsoft-antispam-prvs: <MN2PR02MB6671D71C2BFD4C040017F588B7359@MN2PR02MB6671.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqvJgs2zt7mF3JNr55As3Bed71OdfdX/uZR7l78scZLZY8LQ+Fys5Upkas5Mx6/r95Iv/nTBNSRKsvPYSpSp0zNx5D5SIeept+w6oJUBiU+hpyKpdPtCvhi7iKXknZehI7FWWX+d+ZW3z+tTix96hRbDkV6xQvRWpEUMQtXPlH6Q5O16VRVGim1iwUi8hLQ1mbRdyMB7fYpUJFncjdSk3oxEgYW2umM1EGYdgl/2jW93XpunhBgTAmA24voATnesXnaY8HZV1I4xRbgTHAxX8reird+wMFxmr09T4Oi1He2FkYw8O4DXPpVGf64UyaG9bWSdMyNQdiwNU9q9uGFn06mPW+ndWcyFKa3NEsDr60wTWptsGlvYMLqpgTAXX7CN140TNu1fTgMVI7Edl7Qq5EqR54D33+IX3rYnyars5+4hscPr+B5AXY/TLLRhdm4yReKAy6AnDVQOntvvPqvf+dBSVPz4y00QGc19jFc95Rr0KoC69E969N5I9hLOskruMXrBS5TWtwN0IjoyjwkKoLKS7JDyDGay44MzO2YAcDCFGe768KOOECGuxF3h+UhQozqloSptePxpdA2WarRC15ds7YowGCI7nHFHxTHHl6jKFIBdysChYnQ/fu0vB3uYNO2/0V/W4kLB6Eh2kl4V1Yw81B4Yywtu1EtIUZEuPGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4370.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(122000001)(33656002)(91956017)(4744005)(2906002)(38100700002)(8676002)(4326008)(66446008)(66946007)(6916009)(36756003)(66476007)(66556008)(83380400001)(6486002)(76116006)(478600001)(186003)(5660300002)(86362001)(54906003)(75432002)(53546011)(2616005)(8936002)(786003)(26005)(71200400001)(64756008)(6512007)(316002)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STZUUEN6aUMzdTU2c2dNc2xtOVNUMDNnUDY2djBTWDFSY1dIUUlqY3NWYWNR?=
 =?utf-8?B?WlVFQlFZQkFtSjBPNDlRYlZnMUsrUmJwQVVIeFRQV1orY3BzdGgwSmJ0RGxx?=
 =?utf-8?B?ZC9OR25ud1Buc0FSWGQ4bTZqTVJUZG5FVXlzVDQ4R2VERkVIdHg5N0pnaDA0?=
 =?utf-8?B?NnpmQ0g2dTNRTFNNL0VkQVJIWkw1ODJsZ01PWnF4SHJUWEgvMnRJMndhYVFV?=
 =?utf-8?B?K3hPMHZQd21iK29TaTgwSDVRRHkvaFRyaUd4UFpUTDNqMmFobk96aTdScW1K?=
 =?utf-8?B?dGNnRFgwZlRDeTRQOCt6cWVvbDhZSE5LSTU4WEtTYmVJaURRczBwZ2dFcU1j?=
 =?utf-8?B?bXYyd1dqdy9aVVFhSEdYY2hMZk1XaUdrWVhLd1Z2Zi93UWowdzJwQjZ5MEds?=
 =?utf-8?B?emtBeFZkN1B3L2FLNVB2U3FDSFNnWndTWWRLdXkxYW5aZXBka1kra1o2SWNa?=
 =?utf-8?B?dnFVMXhmeEJUMlVVdCtJbHVoc0pwYzJsRU5keTkxVG56TkpldHoxR0l4SEsw?=
 =?utf-8?B?bDFZMCs2czBKMUhoVVFrbHJNWnVhOGh2NERuQWhhNEk1bFN6MmhkUnlIY1da?=
 =?utf-8?B?SjRnQlg3Z3ptcE8xS0lJcVNOckdaOUhYbXRTZXRJY2I4cjREeXRrckNyaERI?=
 =?utf-8?B?QTZpbkZKR2VYUUNUekRFci9od1Q5TmlHUmZqYXFodkQ1VkJKMEJzUXlMN25G?=
 =?utf-8?B?SS9aNjRTQmwrWUk1dllwY0trMzJJM2hBUEpsZWhpUUswSnBDYjNDNUw4U2Vo?=
 =?utf-8?B?WUo4UFJVQU9QY0tIbXhXbnZBcnM4MktqTURyK1Q0YnZyMi8vK0dqV2lLYkxw?=
 =?utf-8?B?a0M4NVBtSVdTVW1TWFpQQzdsZUhMMEgzT0FxVzRMR08ybXVsbXJDVnJ5KzZp?=
 =?utf-8?B?R0pmamdsSGI4MmV3M3pwRVM4TWJKU1NOdDNkZ2R1eHk2Rk1zMXdVaGpPdzFM?=
 =?utf-8?B?Q1h2L0FLSGh6bWlMRmp3SmpXa3FKanlKNFVkcHVPU0dmdVdTY1VTRlYrVWdr?=
 =?utf-8?B?S0x6azUwdExNbGNvQ1djSGR0RThUNFJZQ1pheHU4NFRDTkNhMlNqVXMvbVlr?=
 =?utf-8?B?c0oxNkdsTGxodWlXM3hEK1lvVXlMenMwc2EyTDdjZlFpYXNuMExLNHRkcEgx?=
 =?utf-8?B?cWJQMmVxRHBNU1RoM3Jrb0Z1dWxpV1d5MlJlL3BrV0tBRW0zeUwyL1ZtODNu?=
 =?utf-8?B?aXdJYkhISk9qU1RNZG5BMjBBVTg3REhHdTFtaW1wUU9FcVYvZ1RqYnIyWVVP?=
 =?utf-8?B?UW81NWhHaTloVFdvVDZnTWtxU3pHdDVWb21JdEx2eHUvNUNJUE5MQzZ4OHJa?=
 =?utf-8?B?SXFVenNYbGxiQ3VSbGFuMW55UHR1VGpodEhiZUk3MHpKVlBNR0t6YmhhczZG?=
 =?utf-8?B?QytPNW5Ec3puKzhqM3RFYkNiOXNCS2ZkQnpaQjh2citsMVFya0dMTDJJeTBP?=
 =?utf-8?B?cW40c1IrMXBWUDhsY29WRy9XZDBmUHY1UUdGNWhlUjIxQjhGV0FiNWJSL2Nq?=
 =?utf-8?B?OUV1TVhjQkg3S2o5ZGVWbHdPN1VFZXhCS2YzcTNQc3VhdnllUllCd24yZG1K?=
 =?utf-8?B?NTBMNTZoZnpYYVZWWkdCY3UxeElNZFVBaVk3ZWxwd3lRYnF6UFNHek43U3Bn?=
 =?utf-8?B?ZURKRXdPRjZoL2d6TThFNEl6YTl2KzRRYkhuZUM3dkZNejZvZjdCVFpFajZE?=
 =?utf-8?B?amV2WXJVckUrSFNSLzkzQWI5QnQvSXAxSXptRjhUUnhVLzdlRVZPekRoWk5n?=
 =?utf-8?Q?r/rdiCU+NSTAQEdT8+BaynwggkKJg4k1dbKOr7p?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCDDF18812B60F45B4B2EE3366000630@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4370.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f06e615-a235-436b-d499-08d92c4d3271
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 20:20:31.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4dcZBv0hn0D0lTR3tqSaaHmqVFZ7nALyijssldHzZH+lx/2FnF5eUas56k6LwKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6671
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U291bmRzIGdvb2QuIEJ1dCBJIHdvdWxkIHN1Z2dlc3QgdGhpcyB0byBnbyB0byAtc3RhYmxlIGFz
IHNvb24gYXMgcG9zc2libGUuIEJlY2F1c2UgdGhpcyBidWcgaXMgYWZmZWN0aW5nIHRoZSBiYXNp
YyBmdW5jdGlvbmFsaXR5IG9mIERDQ1AuIEl0IGNyYXNoZXMga2VybmVsIHdoZW5ldmVyIGEgbmV3
IHNvY2tldCBpbiB0aGlzIG1vZHVsZSBpcyBjcmVhdGVkLg0KDQpCZXN0LA0KWmhlbnBlbmcNCg0K
77u/LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtlZXMgQ29vayA8a2Vlc2Nvb2tA
Y2hyb21pdW0ub3JnPg0KRGF0ZTogVHVlc2RheSwgSnVuZSA4LCAyMDIxIGF0IDc6MTQgUE0NClRv
OiAiTGluLCBaaGVucGVuZyIgPHpwbGluQHBzdS5lZHU+DQpDYzogQ2hyaXN0b3BoIExhbWV0ZXIg
PGNsQGxpbnV4LmNvbT4sIFBla2thIEVuYmVyZyA8cGVuYmVyZ0BrZXJuZWwub3JnPiwgRGF2aWQg
UmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+LCBKb29uc29vIEtpbSA8aWFtam9vbnNvby5r
aW1AbGdlLmNvbT4sIEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+LCBW
bGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6PiwgImxpbnV4LW1tQGt2YWNrLm9yZyIgPGxp
bnV4LW1tQGt2YWNrLm9yZz4sICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNsdWI6IGNob29z
ZSB0aGUgcmlnaHQgZnJlZWxpc3QgcG9pbnRlciBsb2NhdGlvbiB3aGVuIGNyZWF0aW5nIHNtYWxs
IGNhY2hlcw0KDQogICAgT24gVHVlLCBKdW4gMDgsIDIwMjEgYXQgMDc6MDY6NDVQTSArMDAwMCwg
TGluLCBaaGVucGVuZyB3cm90ZToNCiAgICA+IE5vIHByb2JsZW0uIEp1c3QgdG9vayBhIGxvb2sg
YW5kIHRlc3RlZCB0aGUgcGF0Y2gsIGl0IGxvb2tzIGdvb2QgdG8gbWUhDQoNCiAgICBHcmVhdDsg
dGhhbmsgeW91ISBTb3JyeSBJIGRyb3BwZWQgdGhlIGJhbGwgb24gdGhpcyBzZXJpZXMuIEkgZ290
DQogICAgZGlzdHJhY3RlZC4gOikgSXQgbG9va3MgbGlrZSBha3BtIHRvb2sgaXQgaW50byAtbW0g
bm93LCBzbyB0aGlzIHNob3VsZA0KICAgIGJlIGZpeGVkIGluIC1uZXh0IHNvb24uDQoNCiAgICAt
LSANCiAgICBLZWVzIENvb2sNCg0K
