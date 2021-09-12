Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCC407C35
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhILHj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 03:39:59 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:15845
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229540AbhILHj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 03:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSH05U25NU8TkiMGQWKEw9HbToE7SzFguLQOOfTPm8gU2WR3tNjEiAvavgr2nBbOo0ifmby10qIyr1TNqKrFnisy9EI8fvPG+rNDXVVZnod20857McMRIdYfV81eOw4kcGyQNL6hmh983hAy4Jv0fyPh4cvRfi/NrAF4TFRjDlLZZzBjwaNjYyqCoONAXSIzJNyD9FOzDug2rY16dZcvRdFAYHiQwYYkj5xkrt65d02eiFHlX6dBUwqjWUI9aT15bESkX/uGqFbtryFwcVmwtJ3RSSBGnEtDZz65nwyCQ+hVurEDn8Nxvnr1qWSrEvaYBQ60B6XRGBBXMTAA6jfxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0wHrWszWH7jeHN5C0iJdgk/ING/2Iuw1X7Fp4mCruHQ=;
 b=RKBgiugH5dRds2aorVoHETKGRv0cJmRNlJwuATXEZeIY1oS+G3t4/RN1IM/FJ31wlUfw7L7WhFnBlBZG7xoWpwosQGwcfMLbehixbynF/8JIullFXVjCXSa1TsmUqBzaq84tK5j5cBy13XERLWoP+rL6y6L/rtlj7/xE+dFqy0jIc1LsMNL9vUbwr+Y+4+K1xhkGH5VA1MuuK1Zx7/Q/gMfPfFI0i5kjKwlI5hPh1ks6wa4Mc49typTnH+uZ4WFmnM5eFOl56ge1xOLeJFsD5H9IW8N0tn0lGrd+XjLl4OrgQVmt28x6uhmy+bCyRHjp7tG8WHQRcAuWAReZN8zAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wHrWszWH7jeHN5C0iJdgk/ING/2Iuw1X7Fp4mCruHQ=;
 b=JVIX9kZXJqcwZwIW91hA/CdrAqGhjU8hx6lHR93ecmVPOBeEvuOw+AsvWixduWRmnoKMV6iLh5sDYxc5lO9y7QEfEm9RB9Y+VsWhRG8/6OxCN4hBrAy5HUvwQpT9WYP5fuBsklDv+Sm81RwA4kIvUivKkuh4BqKGQiNNt2k0cQI=
Received: from AS8PR02MB6760.eurprd02.prod.outlook.com (2603:10a6:20b:253::19)
 by AM7PR02MB6259.eurprd02.prod.outlook.com (2603:10a6:20b:1bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Sun, 12 Sep
 2021 07:38:42 +0000
Received: from AS8PR02MB6760.eurprd02.prod.outlook.com
 ([fe80::8964:627e:50ff:ba32]) by AS8PR02MB6760.eurprd02.prod.outlook.com
 ([fe80::8964:627e:50ff:ba32%7]) with mapi id 15.20.4500.018; Sun, 12 Sep 2021
 07:38:41 +0000
From:   Michael Zuckerman <mzuckerman@habana.ai>
To:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tzachi Cohen <tcohen@habana.ai>
CC:     Doron Singer <dsinger@habana.ai>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core
 library
Thread-Topic: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core
 library
Thread-Index: AQHXphVPCGSs79Sf6UmDEOaezR74FqugBgoA
Date:   Sun, 12 Sep 2021 07:38:41 +0000
Message-ID: <AS8PR02MB676015CD4D7719D8DC581F01C6D89@AS8PR02MB6760.eurprd02.prod.outlook.com>
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
In-Reply-To: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tcohen@habana.ai
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 985a5a66-15d6-44f3-10b2-08d975c057fb
x-ms-traffictypediagnostic: AM7PR02MB6259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR02MB62597EAE2D671BBCC81382D1C6D89@AM7PR02MB6259.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWvDkNtSVjxMOVIotN56JUyKZDEAU/EF4aWcxOykEXrYI0KDJW/W8ePFp4VStShAnmrP8jA7HEvj6X1QSiL2SvXWBhueto/y4eL1jH2cKzB5mx7p6LF9yRxQPQaIHwlIMWwbrL+tDzBaxA+K6aHVjtAr6hp3TRA5Jz9zSd9zeeBU8CA5LrdrQVElzWhCZ8aAjKxGpcr9cJsts8l64c5boItqxDWNxb1x1DMJ0NA3LJRkxtHOM3ax7Dspy6RsYVNRBtXq2/nF8a68Tzxh5zSmWCIlRyGMTCjCvAzyFrBfdb9I/mfqq5y6/FbuP+xEk5t/gMdBWh8WOYyJygLSvhuEtJZ/v0eFhD9SwGDQG8mr8fklxzuGhy1sEZ360SbukAfVPl/hYNqTRQHkJuHqm8Pk/B8hjiQ+h6Vq8SR2+8ft8UtsCooi4iYJkCfn1ZMPL/HA4f+oEv3s/iB/aD431KwznpEeCbx/cR0IUM+qr/09fMQigbwPkDnF2d5nEqrL3GwgLUEe5zihGPjgS/ect/XznAX3y2AXr2uy2+s8gtjhYHxXDsF2B51nTJD4trGW8TYxiwtt034vRCW8s17wZEmLkaDInbslnMHxSJZTpdJMLyo6/WP8lKE5pag58of50hdRq/t41xLNW4XfMPZ255iAP+Qr7ge2wwh9J4aM+kx57L3NcWcbOPs6YEUlyoVI5gQ4+oRbKaJtLu4E82JUamCPktw6ZNwB4z30vzZBMZZtK4NrfUZewfrPP2GuXT9DDWWh0CZUJCuiHx3hKqaAAVAA5Y1F/tVGZ8cFrmQ5u8/Xcmy2VmNIWK1lhuOe+aT/V7wFdC4fqrPlTMVoTPpByTp3rnDCOwwpUbfqXu1BVKg5ysV7J8tXbGDQtMXqmf09KtBz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB6760.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(64756008)(66446008)(66556008)(66476007)(110136005)(4326008)(54906003)(5660300002)(7696005)(45080400002)(6636002)(186003)(2906002)(52536014)(508600001)(9686003)(76116006)(316002)(53546011)(55016002)(6506007)(66946007)(966005)(86362001)(33656002)(8936002)(122000001)(26005)(38100700002)(71200400001)(83380400001)(38070700005)(10090945008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjBETE8rTWdUeTJoalJFeWFneFZGWFlWMmZydjhQWGRmbVZFNmpUZU56R05p?=
 =?utf-8?B?a01ObUdubTdublBWRzExT3daMERFQzRKSmpJMEsrb2E4NzY5eW9qWlRWby9h?=
 =?utf-8?B?WjFCOERqK0JXc2VDc0p2NmhIR2k3MURHRDNYc2Q1K1ZDV2phVjRjNWt4dFF1?=
 =?utf-8?B?ZXVickxXVjcxcGlaODVoMFN3czIvQ2gzNFJ0SzVWRGNSZlNVdGMwWDBVSGlt?=
 =?utf-8?B?MjJmQjVqYURXVDhITTUza3NnblB3U0VXVGl3TE51WDB0MnI5SXlIOHdBcThr?=
 =?utf-8?B?QnYvWk5LVzhFL2JCZllYNFphWWk1WDRNNGdJM0czb1I5dkRNL2RZa1VxVnJj?=
 =?utf-8?B?N2ZwSEFVNExuM0JnNTNNUFk3bVBoVlpHSTdtTUdkWjhXMldiRWUxN1doMTBJ?=
 =?utf-8?B?MGd3NHliQU1MNWpHTGVLS1dYNkt6ZnZoOVhnajhLTEpiSWtwYXlXTHcwVVNK?=
 =?utf-8?B?SWQrc3VZMHJ1S3gwd1loS1d2Vk1tV1lRd3Z2bDdxbzJyK3lpaHZPSUs1cEJX?=
 =?utf-8?B?N2xwYUU3dGl3WEhFemVRK0liZWlqNXRwS0NsSkt6eVc3MFptTXo4bDcvZ2d5?=
 =?utf-8?B?NkNza1NHUUJxRjFWaDNWOEczclBqR0JYdjg2OGhqY1FCQmFDbkgzcHFtTlBJ?=
 =?utf-8?B?VFEyckppUDhpYmd0eURVNmN0dm5EK2NkeWMwVkNka0luOFVabXV0c2swQml5?=
 =?utf-8?B?WHFHekxVRVVFNjUyNi9xbFZRbmliMmR2MjhxVk5mY0szR2VKOGJES2ZGQm05?=
 =?utf-8?B?Ritsd1hGTUVFVElXYjFvdGZzOENzSVlzRVpMeFVQbWpMUEcvRHVVSGdPY2FJ?=
 =?utf-8?B?cDRZOXBQVW5RZ1NObG1OT0J4WFdpTUIwZ1dQeEV6SnV3UTVZVnAvbGt6bzlT?=
 =?utf-8?B?RjVCcnlKSE5GQlhoU2ZTTGkvYXYxUTVwdUJudXRTVXQ5UUcxaDFPWnpMQlZ1?=
 =?utf-8?B?MGpFSTB6RS9PdFJJYW03UVovbW1FMlhWbnc1dFFHc1RXS2F3TGhVZktOdDJU?=
 =?utf-8?B?aVdjU25TL2hhcDlkT0tVR000bDA1WmYwTGRqUEEwM0dYMmFtVWRPOXFtNURy?=
 =?utf-8?B?ZGphaGVocTNNTk1JRWRZNG1MQmQ0N2MwVU1KeFJ6a1RvOUwreDNQWlUrUTVP?=
 =?utf-8?B?Uyt6RWZ5WGsrSitORFh3bzI0T1Jia1NnMkg3bWJTZUU2Q3o3WHZnZVB6aTV1?=
 =?utf-8?B?dHRSK080ZGFZK3lNUUZqSU05WVdXbFVxUmpRUDE4NkRkY0l1N0ZISmgrbkp1?=
 =?utf-8?B?RW5sNnhQM3FZS3RoWHVMUm5HdXNPc2NyZlRiNm85S0xDSG0vd0h4VDFOeVlN?=
 =?utf-8?B?MlRBbXVYZUI4Vk9oOWp6b1BLNXVzQjIyVERxRmc3SEpMbzVWY3J0OEd6ZEdR?=
 =?utf-8?B?a1k3dEs3bTgva3BJcUhxWDNVeStWWXdKdXF4S0NXQWxEVkI0d0ZkNXcwSnk3?=
 =?utf-8?B?eU9BZWptYXBlVWVucy9acGoxNGxKd3V0U2MyMjNvY1NkRXU5UHBzWXZDWHEy?=
 =?utf-8?B?ZWVwZzVacmpiYTNucmZXYnQ5ZzhuTDNHSDdoZTJ5N0NFOWpRMzhlRjQ2OWhk?=
 =?utf-8?B?eVRvb2d6SnRPVzBud2hZWkhvQXlLVWdkbjdXa0QvTHlGY2swVlhVcmNBemtm?=
 =?utf-8?B?YXFOQ2lvaksrNjlla0I5WUFFRFV0bVozTHhYZy8vbnlOR1JpRzFqZXFXTC92?=
 =?utf-8?B?MVY4dkZRN2pjaVZtZk1KS1JNWEFCYzdxbGdBaW1yYW5IVHM4ZWVBb2NMT0FH?=
 =?utf-8?Q?OZu6mnYzhF9DTl5HolNkty25h7oLnYXXQrDRZIV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB6760.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a5a66-15d6-44f3-10b2-08d975c057fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2021 07:38:41.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 720YYIwwwfb9wif7FSi5QZLtMkYIA6xMMhcUj+5a1HFOARB3/F2bVk402pBl85yVqVvGTKBqW0kV474WyKEMxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6259
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIEBUemFjaGkgQ29oZW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE9k
ZWQgR2FiYmF5IDxvZ2FiYmF5QGtlcm5lbC5vcmc+IA0KU2VudDogRnJpZGF5LCAxMCBTZXB0ZW1i
ZXIgMjAyMSAxMDoyNw0KVG86IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+DQpDYzogTWljaGFlbCBadWNrZXJtYW4gPG16dWNrZXJtYW5AaGFiYW5hLmFpPjsg
RG9yb24gU2luZ2VyIDxkc2luZ2VyQGhhYmFuYS5haT47IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz47IERhdmUgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT47
IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+OyBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT47IExpbnV4LUtlcm5lbEBWZ2VyLiBLZXJuZWwuIE9yZyA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IEhhYmFuYWxhYnMgT3Blbi1Tb3VyY2UgVFBD
IExMVk0gY29tcGlsZXIgYW5kIFN5bmFwc2VBSSBDb3JlIGxpYnJhcnkNCg0KW1NvbWUgcGVvcGxl
IHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gb2dh
YmJheUBrZXJuZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cDovL2Fr
YS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24uXQ0KDQpIaSBHcmVnLA0KDQpGb2xs
b3dpbmcgb3VyIGNvbnZlcnNhdGlvbnMgYSBjb3VwbGUgb2YgbW9udGhzIGFnbywgSSdtIGhhcHB5
IHRvIHRlbGwgeW91IHRoYXQgSGFiYW5hbGFicyBoYXMgb3Blbi1zb3VyY2VkIGl0cyBUUEMgKFRl
bnNvciBQcm9jZXNzaW5nIENvcmUpIExMVk0gY29tcGlsZXIsIHdoaWNoIGlzIGEgZm9yayBvZiB0
aGUgTExWTSBvcGVuLXNvdXJjZSBwcm9qZWN0Lg0KDQpUaGUgcHJvamVjdCBjYW4gYmUgZm91bmQg
b24gSGFiYW5hbGFicyBHaXRIdWIgd2Vic2l0ZSBhdDoNCmh0dHBzOi8vZXVyMDIuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20lMkZI
YWJhbmFBSSUyRnRwY19sbHZtJmFtcDtkYXRhPTA0JTdDMDElN0NtenVja2VybWFuJTQwaGFiYW5h
LmFpJTdDMjM4MGMzNDlmYTk2NDg3YjdjNmIwOGQ5NzQyYzZmZDYlN0MwZDRkNDUzOTIxM2M0ZWQ4
YTI1MWRjOTc2NmJhMTI3YSU3QzAlN0MwJTdDNjM3NjY4NTU2NDg0MjMxMjE1JTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPXJwJTJGSU1LQUFpJTJGQUZq
anMzR00wY1Y0VmlGbjFia0E5bmhBcTYzMlFCMFRRJTNEJmFtcDtyZXNlcnZlZD0wDQoNClRoZXJl
IGlzIGEgY29tcGFuaW9uIGd1aWRlIG9uIGhvdyB0byB3cml0ZSBUUEMga2VybmVscyBhdDoNCmh0
dHBzOi8vZXVyMDIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmRvY3MuaGFiYW5hLmFpJTJGZW4lMkZsYXRlc3QlMkZUUENfVXNlcl9HdWlkZSUyRlRQ
Q19Vc2VyX0d1aWRlLmh0bWwmYW1wO2RhdGE9MDQlN0MwMSU3Q216dWNrZXJtYW4lNDBoYWJhbmEu
YWklN0MyMzgwYzM0OWZhOTY0ODdiN2M2YjA4ZDk3NDJjNmZkNiU3QzBkNGQ0NTM5MjEzYzRlZDhh
MjUxZGM5NzY2YmExMjdhJTdDMCU3QzAlN0M2Mzc2Njg1NTY0ODQyNDExNzIlN0NVbmtub3duJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9VWRtWWMlMkI3MUVzRU1BdHpt
NmtWMFl1NTNicnJaTmRVU0lFRFElMkYwdktoQTglM0QmYW1wO3Jlc2VydmVkPTANCg0KVGhlIGd1
aWRlIGRldGFpbHMgdGhlIFRQQyBjb21wdXRlIGVuZ2luZSdzIGFyY2hpdGVjdHVyZSwgaG93IHRv
IHdyaXRlIFRQQyBrZXJuZWxzIHVzaW5nIHRoZSBUUEMtQyBsYW5ndWFnZSwgZXRjLg0KDQpJbiBh
ZGRpdGlvbiwgd2UgaGF2ZSB3cml0dGVuIGEgcmVmZXJlbmNlIGltcGxlbWVudGF0aW9uIG9mIHRo
ZSBTeW5hcHNlQUkgQVBJLCBjYWxsZWQgU3luYXBzZUFJIENvcmUsIGFuZCByZWxlYXNlZCBpdHMg
Y29kZSB1bmRlciB0aGUgTUlUIGxpY2Vuc2UgdG8gdGhlIG9wZW4tc291cmNlIGNvbW11bml0eSBh
dDoNCmh0dHBzOi8vZXVyMDIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20lMkZIYWJhbmFBSSUyRlN5bmFwc2VBSV9Db3JlJmFtcDtk
YXRhPTA0JTdDMDElN0NtenVja2VybWFuJTQwaGFiYW5hLmFpJTdDMjM4MGMzNDlmYTk2NDg3Yjdj
NmIwOGQ5NzQyYzZmZDYlN0MwZDRkNDUzOTIxM2M0ZWQ4YTI1MWRjOTc2NmJhMTI3YSU3QzAlN0Mw
JTdDNjM3NjY4NTU2NDg0MjQxMTcyJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3
QzEwMDAmYW1wO3NkYXRhPXNhZFNXSUJ2QVRvMm9WdlNXZ3pHdWpuWVl4Y2ZHTUVVRURnbmZzbXk0
QVUlM0QmYW1wO3Jlc2VydmVkPTANCg0KU3luYXBzZUFJIENvcmUgY29udGFpbnMgYWxsIHRoZSBu
ZWNlc3NhcnkgYnVpbGRpbmcgYmxvY2tzIHRvIHJ1biBEZWVwIExlYXJuaW5nIHRyYWluaW5nIG9u
IEdhdWRpLCBhbHRob3VnaCBub3QgYXMgb3B0aW1pemVkIGFzIHRoZSBjbG9zZWQtc291cmNlIGxp
YnJhcnkuDQoNClRoZSBwcm9qZWN0IHJlcG9zaXRvcnkgY29udGFpbnMgYSBjb3VwbGUgb2YgVFBD
IGtlcm5lbHMgdGhhdCBpbXBsZW1lbnQgYmFzaWMgREwgb3BlcmF0b3JzLiBUaGVzZSBrZXJuZWxz
IGNhbiBzZXJ2ZSBhcyBhbiBleGFtcGxlIG9mIGhvdyB0byBpbXBsZW1lbnQgbW9yZSBjb21wbGV4
IG9wZXJhdG9ycy4NCg0KVG8gd29yayB3aXRoIHRoZSBHYXVkaSBkZXZpY2UsIHRoZSBsaWJyYXJ5
IGNhbGxzIHRoZSBIYWJhbmFsYWJzIGtlcm5lbCBkcml2ZXIgdUFQSSB0aHJvdWdoIHRoZSBhbHJl
YWR5IG9wZW4tc291cmNlIGhsLXRodW5rIGxpYnJhcnkgYXQ6DQpodHRwczovL2V1cjAyLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29t
JTJGSGFiYW5hQUklMkZobC10aHVuayZhbXA7ZGF0YT0wNCU3QzAxJTdDbXp1Y2tlcm1hbiU0MGhh
YmFuYS5haSU3QzIzODBjMzQ5ZmE5NjQ4N2I3YzZiMDhkOTc0MmM2ZmQ2JTdDMGQ0ZDQ1MzkyMTNj
NGVkOGEyNTFkYzk3NjZiYTEyN2ElN0MwJTdDMCU3QzYzNzY2ODU1NjQ4NDI0MTE3MiU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1Wb2N2Y252b0x6MzZi
aVQ1OEd4V1RuJTJGeGlVRCUyQnFHMldSRDlFRU9FRE5iOCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpN
b3Jlb3ZlciwgdGhlIGxpYnJhcnkgY29udGFpbnMgYSBmZXcgdGVzdHMgKGFuZCBtb3JlIHdpbGwg
Zm9sbG93IHNvb24pIHRoYXQgZGVtb25zdHJhdGUgaG93IHRvIHVzZSB0aGUgU3luYXBzZUFJIEFQ
SSB0byBydW4gd29ya2xvYWRzIHdoaWNoIHV0aWxpemUgdGhlIFRQQyBlbmdpbmVzIG9uIEdhdWRp
IGRldmljZXMuIFdlIHByb3ZpZGVkIGEgc2hvcnQgcmVhZG1lIHRoYXQgZXhwbGFpbnMgaG93IHRv
IGJ1aWxkIGFuZCBydW4gdGhlIGluY2x1ZGVkIHRlc3RzLg0KDQpJdCBpcyBpbXBvcnRhbnQgdG8g
bm90ZSB3ZSBwcm92aWRlZCBhbGwgdGhlIG5lY2Vzc2FyeSBBUElzIHRvIGNvbm5lY3QgdGhpcyBs
aWJyYXJ5IHRvIGFueSBEZWVwIExlYXJuaW5nIGZyYW1ld29ya3MgYnkgd3JpdGluZyBhcHByb3By
aWF0ZSBiYWNrZW5kcyBpbiB0aGUgZnJhbWV3b3JrcyBhbmQgYnkgd3JpdGluZyBtb3JlIFRQQyBr
ZXJuZWxzIHRvIGltcGxlbWVudCB0aGUgZGlmZmVyZW50IG9wZXJhdG9ycy4NCg0KT25jZSB0aGUg
ZHJpdmVyKHMpIGZvciB0aGUgR2F1ZGkgTklDIHBvcnRzIHdpbGwgYmUgdXBzdHJlYW1lZCwgdGhp
cyBsaWJyYXJ5IG1heSBiZSB1c2VkIHRvZ2V0aGVyIHdpdGggSUJ2ZXJicyB0byBwZXJmb3JtIHRy
YWluaW5nIG9uIG11bHRpcGxlIEdhdWRpIGRldmljZXMuDQoNClRoYW5rcywNCk9kZWQNCg==
