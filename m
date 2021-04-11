Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218B135B598
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhDKOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 10:10:35 -0400
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:2941
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235407AbhDKOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 10:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIo0L3crRXymjofPKSMVOXhvbdk5Pe8hh2HAIpD33QXfRmhBorDOpbqRdHFY0vfZJM2c26b3T4LUziBDYUsqNjDvFf5ZhZC/RPzBpsqO29sGLWpy9pUvSmyXofmQgK6RNN63bt4bwkzzYNTfvXvlYFgUMb9DrlpbIhL1cfTA0ffaSCaTZGiWVyU2buX3vOYWtoD82fBUlYHMoNobjiMGg2DAKFfS0kThB6wvZkAwsH208UNnC2oDrl63MEL8LiBOcKtY25OHS4DD5zL9zm681t3BtCf8bYHpC7ZTljPj+PcJTPzeRRbsjAJUvIzgfTW5LOgdVxSAUEpxBCKFgXGZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8fwqBWtQSSrRaAYTnqtF3FA/c3V04w4cLV1olc7rQ=;
 b=RDPjEfO5sStyBoZlfYcU+Z1wbGwKliGx4m4ZHEBzHDhTRmgJWqbjiLECGFB9h130qgZM+KGmczyyCjSYOirqT67UcWaXsupBjYhi5y8nQqG7RhbXt+VH3bvNDj7jQWtcaT97yiZdIcYfqmga7uMRcayyiMYgyTZ9htxY/aP1jP9V7TJVWj8qTl+ySxEo/hiG5ZFiHAG1ZyPlfzzi3cqjv1GxWdH/Et6MJgrZ4ckYVOG7qzeZS486O79HHS+pj8CEkgH0Cweaa/Lut/PuDuKG2NEdIh4NmUangICpw4hSRrvyciaMiYtGkMiJNe6G9zlfHtxJ5Bkmn0ytvaC9OpvJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8fwqBWtQSSrRaAYTnqtF3FA/c3V04w4cLV1olc7rQ=;
 b=SkXKcKhQp5hH4MtbFZzzF24u62mBkCLaawIZF1AOFU+KCYyICzhlxDJC1fofE7L8qR1DVlmQ+gCmiNqchrDI8V6m7vEs/p5NOqcQpGp89k5vF+gvLJ5Hc8TBKKfDFmJQjUKjxW8cfacnAN6PP46WOfsfz0MjqZ7pj9+Rv6qr7Q0=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB4067.jpnprd01.prod.outlook.com (2603:1096:604:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 14:10:10 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 14:10:10 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXLBphMmpyIdnLSkKcpoovCRWuzaqqM6eAgACvi9CAARN0AIADaZ3w
Date:   Sun, 11 Apr 2021 14:10:10 +0000
Message-ID: <OSBPR01MB4773DC96B7559650843217F0BA719@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <20210408070809.GD2961413@dell>
 <OSBPR01MB4773DF588214D8B9E613E074BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <20210409100220.GE2961413@dell>
In-Reply-To: <20210409100220.GE2961413@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eccf9e39-959e-4e12-6ca7-08d8fcf384a5
x-ms-traffictypediagnostic: OSAPR01MB4067:
x-microsoft-antispam-prvs: <OSAPR01MB40671480AAE2923208AD9D9BBA719@OSAPR01MB4067.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OR1E6H+sl1EuGaTE3M47gGVS4LJAdAxs/j/ve5wgU8qjBWC6QAGFj9D43ymTRyEypgXyonGDxxPFB6zfXetEQSdkrEf7yYX3j4SQTt+bwp/d/p/J7LuT3Tte7esl8bT9b3iGNnXz0Q9KzD51Jkc5b1rNwFVe7mGO4wS+oVAwuXeJYn2BinrQFFq/ZlTL/prZDxVwdHE2pnWIy0qkQLCNlhivzKjPKA8cUGaG0dfO/zdh+TiUDy2Tt0B43WAmw9ltIQTLQgsZcosd0gJUr3fUkiRn7F+RIQOU3PbCnog/KBbqT/xfFpeDiWrgoxKC+92blM0FxHCZl1z/IXQh/gCECC/2oSdMdAqUeoHQfLBP9BqpDqr54sz7Ixn6QO7PcFMuIhdzcpdq08ttqkTqNaiDebShiX8jfaTBRWHe4vUNaPTdQZ+DrumRsGydbfGhIpVEWGlva2edu4d2JK4kRs1ZiTus15p/0ow38k5ZkIbExTdSEMWHOTqO+lPScGdHud1rdwPtVA8eGUWKJdZ4pPR2zD3nd+Jrd5wQxw0rUd4v8sar2+azCKy4UrHrN3tg5MhQA25+aKz5OpVA9F7GANM+jZKjOyCe/edHpMfb9qjuzPA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(8676002)(316002)(4326008)(33656002)(86362001)(66556008)(26005)(71200400001)(55016002)(7696005)(54906003)(186003)(8936002)(6916009)(66446008)(76116006)(38100700002)(558084003)(2906002)(6506007)(52536014)(66476007)(478600001)(66946007)(64756008)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aHlDeS9MUDdyb05kU084OUl6NlFjbnJQTUg3bHlIQXhWRW81a0xiWWdZMkFO?=
 =?utf-8?B?Q3pSR2NVMS9Fb2krTjJwejNLTjk2T3dsQ2Y1OWdXeWJYUUpTYTdIcCtWMG16?=
 =?utf-8?B?cENydktGL3pVZ0Zab1RPN09RcmcwYUNSck5GNzZQQzYvdzNUZjdDVEd2Snlv?=
 =?utf-8?B?Zk9kYUlnQ0s3RmRnbGYyMEwrblU4ZlphTHdWR0lTMEE0Rjd6Y09nSE1WUlIx?=
 =?utf-8?B?Y1JGc0tDVGVGcE9Zbmw0ZUUrMXlRNE1yNUxyeStpOFlTb1o1TnpVRC9qRjRj?=
 =?utf-8?B?bEN5NzFDaGhlcSt5NXRMTjZCc3cvWFcrOGszd3RWakhqZENyaDV0NXU4NXU4?=
 =?utf-8?B?QVovQWd1b1dkejhUdURBSWJ3UHAxazZqdE5PdlRDd2lxenZZQmNzV2pjelVi?=
 =?utf-8?B?SFBGKzRDWnFmdGxSRmNPWC9pMUZwbExBUFhndFBCTjNaakw0c2hxbDJDTHRk?=
 =?utf-8?B?ZjNiVDloMnhLQUVuZmpQWHY0ckk4TnhEcHhpbHpsSnJDSjdJZ01QelJ5RkRY?=
 =?utf-8?B?S3pSTHBMcWpoa2ZESU5MZlQ5ZDZwVk1LZUwzOUFOREY0NUhnVmk5Q29qOXYw?=
 =?utf-8?B?RTJPaWxETlM2WjRKS2pCNExyTDV3aWFHMmt5SzJyL0RRMHRnRnh3WFV6Vlkw?=
 =?utf-8?B?S3EyRzlZRlIwRjY1L0ZYNkd3c1JWeE5Sd3lTdDBYQUdMNm54MjN1d0Z1NnE0?=
 =?utf-8?B?QW1WUFZRZUxDMklNZjZldEx6VzVaWXpxZmZTYy9rWmNETTUrTlFPQ3JnTUJK?=
 =?utf-8?B?c3p1Ly9YcFRVTWZZcEwxbmtic2dnc1NVdWtleElnQWhTNzYwajUyc1RFUndn?=
 =?utf-8?B?TlZLS3c4VFdBMjlJOU5LZCtnVS96c2xFQ2Q3YWZDMVQxYjZoNzhZZHZQWWxp?=
 =?utf-8?B?dDd2U0drZFBwWWlueGw3aUlZTHF3dXdiMytMNllMSE1laUdNOGcrK1Q0eFlH?=
 =?utf-8?B?eGZscWs0Ti8zT2lvR0dUeGxzeWRwZWQ1OGcxQldUV0RSOHhXMno3M2E5M3RU?=
 =?utf-8?B?S0c3KzFYS0s4eCt3YUhKMFRzTVE3UmtKY1lsZG50elo0Z1YweW9VL0Z3Vklh?=
 =?utf-8?B?dDdLM2trMzB5VjM2QW1zc05Xdk4wQ1R4UG9qaCtzZnQzclRvU1RwUVJmdlFM?=
 =?utf-8?B?ZHVTellrZklGYVBZL1lXQlUxY01NaFBPdTh4QW9qV3Q3Y0tTa2ovc21HTzQr?=
 =?utf-8?B?MVhEalhCaDFKV1VTUzBPMGtpOXhNZm16am81MmpiVWxDNE5XMDBMNVQwNmpS?=
 =?utf-8?B?MXhHaC91SlNnM3hFYlVYK3NKdzJKWnB5c2tPOUV4ZVRHLzRJYW1TNzZmelpM?=
 =?utf-8?B?VEVkRHlxNWcxdlgzZU04QWZSWkFEZ1FvRlI5WDJVS3A3V2ZMaTlld3VFbU1K?=
 =?utf-8?B?aWIyeFpaMTF2VzRBSTVZcndFcUFYbk9WSnhkSWN3dHVzQWhOSXlrQysybmxY?=
 =?utf-8?B?Z0Y1OUI2OE13cm4yOENTa3g0UmJ6VHZzNzJxbTNjYzZubWVERFFMcWk1T0sy?=
 =?utf-8?B?OXZLQnVONFEwaHRWRWthK2RUb3JQZW96OXZyN1EwQTh5MWpSUlFKcUVWalNm?=
 =?utf-8?B?c1JKWkFuSkdpZ1Y2QTZ4NUZJZlBEcXZnTFpxR2Eva1JiSzMxZTg1VUpyMnN6?=
 =?utf-8?B?dW0vUGtpU2tEc0RQb0oxRDkxQklXeUVDdjQwem5xbDQzMFdrejdTTzVubGcv?=
 =?utf-8?B?TDRZM2xXM0ZqREhrVU9yVXBmMVpPSXBHUlFvMk1aTHpLRmtYWnVLWEZaL3Nw?=
 =?utf-8?Q?PkhNOFcHLBF8dl2vnm7bxB269XAmFPO28QlfLK3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccf9e39-959e-4e12-6ca7-08d8fcf384a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 14:10:10.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olJy/NGxdRbsWW3KzaSfzgUC+TL0xMtpvVUbsqJrFAPGzv+WSl1+PPj5EE8xJwTDIB5n9H8bk2MCiOlvqNAURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVGhlbiB5b3UgbmVlZCB0byBtZW50aW9uIHRoYXQgaW4gdGhlIGNoYW5nZSBsb2cuDQo+
IA0KPiBXaGF0IGNoYW5nZWQgZnJvbSB2MSA9PiB2Mj8NCj4gDQpQbGVhc2Ugc2VlIG15IGxhdGVz
dCBbUEFUQ0ggbmV4dCB2Ml0gYW5kIGl0IGhhcyB0aGUgZm9sbG93aW5nIGNoYW5nZSBsb2cNCg0K
U2lnbmVkLW9mZi1ieTogTWluIExpIDxtaW4ubGkueGVAcmVuZXNhcy5jb20+DQotLS0NCi1yZWJh
c2UgY2hhbmdlIHRvIGxpbnV4LW5leHQgdHJlZQ0KLWFkZCBsb2cgdG8gaW5mb3JtIGRyaXZlciBs
b2FkaW5nIHN1Y2Nlc3MNCg==
