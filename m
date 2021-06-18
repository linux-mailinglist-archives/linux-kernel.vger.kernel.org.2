Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6413B3AC967
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhFRLGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:06:45 -0400
Received: from mail-eopbgr1300057.outbound.protection.outlook.com ([40.107.130.57]:26048
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233483AbhFRLGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM9qP4H99a88YEri9muzLJe3Fygi+HQJO2BdjrMIo2kW35E2c844XdsY7fNJslqncIsi/7+mXxy83aWce/nfti7+Koc0ndSAmhE9acTIeeW8ct9lpCQaMhDuYa1p5OMJEzaFeXnKyvw9XP214N3Duoz+dIPo1I8xDM3LNLbOzis7Gurtm/dxGW3srhm0Fbu4X3Yyj1NRXYZE0PGnaOWj6ctphz+8dCYGrLGgyFciYfXc6i76akjYZyW7+o1mOy5XrTJ2v/t3iRILFQoJJlq1tQKiW2i/u3vweqgZX8JnBYXOafiwA5EBe30/R1rgJzxtC6k6djbypfhgLYQVHuCRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6HulTye0r5nUu49H9bNh3fNpz9Kn9btUh0ud3A9mQY=;
 b=QyxWixmN9nIO+cxpLnoIf1a3Vgxg5hjzq4bHmCSaGOK+l96FBnY7YfrTYRmvLOSYDvOLSEicRPBrfv0ojTFv6dvwePWL7XUWdBgFzDjo8xRHI1J4bnmf3qYa6rloP47qc7rdKi/73kK9NZXaYGtJvvn18GmuH/2/cUPtDCuxf1PQ+hY6i4E/FSVlZVZc0hkaGFRce5aHwl4Lss8QnYauUgDie10lMbb+mFJnNq8LaKOcRHVWzziboXV8yXrVhnADdWqRW/W4ZcNjh0GDRdXyQIOiGrV3bX1fQkiY1shnzuA32QO6XdcamAloNel0Yn+O4rK74jTrcAsw5lr+jM864g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6HulTye0r5nUu49H9bNh3fNpz9Kn9btUh0ud3A9mQY=;
 b=rvLPb3lvuoAzgOiQzwcnE8a2PsykV76ifBRIUWPF4oc7D/S1yjy3WXJnALIKykntWa58v097V4eIHXZS5jlBr8A7UH4bSh/AhcvL6LVckoTPklnGk8DXd8Feov8wBxVxIpn9aFgysMIcbzWIi3YOXHIbGDJ36F5pMyV2wVuPOaM=
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com (2603:1096:203:6b::15)
 by HK2PR02MB3890.apcprd02.prod.outlook.com (2603:1096:202:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 11:04:21 +0000
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::850:c291:f53f:bacf]) by HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::850:c291:f53f:bacf%4]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 11:04:21 +0000
From:   =?gb2312?B?wfW6o8H6KER1Y2tCdUJlZSk=?= <liuhailong@oppo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "maco@android.com" <maco@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hridya@google.com" <hridya@google.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBzdGFnaW5nOiBhbmRyb2lkOiBhc2htZW06IGFkZCBz?=
 =?gb2312?Q?ize_field_in_procfs_fdinfo?=
Thread-Topic: [PATCH] staging: android: ashmem: add size field in procfs
 fdinfo
Thread-Index: AQHXZCdnjBtkQQZp306asXfx57gd1KsZj5wAgAAIU9A=
Date:   Fri, 18 Jun 2021 11:04:20 +0000
Message-ID: <HK0PR02MB31540DAB6B89C8A02B2D5334AF0D9@HK0PR02MB3154.apcprd02.prod.outlook.com>
References: <20210618095035.32410-1-liuhailong@oppo.com>
 <YMx0GIRQmpRC7pdQ@kroah.com>
In-Reply-To: <YMx0GIRQmpRC7pdQ@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oppo.com;
x-originating-ip: [58.255.79.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c978cd9-726c-43a7-25cc-08d93248d326
x-ms-traffictypediagnostic: HK2PR02MB3890:
x-microsoft-antispam-prvs: <HK2PR02MB38906EC58BB5F92807BAFC17AF0D9@HK2PR02MB3890.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tH7lxO8ayGnejaM/8rvieQiEc2FA/5rWO77or66UZUjbZrhTGbeuwWioBOWOFHJrWGCdpB5NjTjwK1IMrgw11xYsoFl2Lu2xxAUfa5UY59LUXdPlF87yoLXxOh71SW4EdRY5OaCWEO8t1LM8lzfl9F10OmvungsEO+6BPtezi8Oh47+1o0sJlARSz942y5wixLAaOVZXXyiHYHmmzOyDJApO5dLLM3tXDD7IwIfRY2iXdRNkRkNIsNNPWaQY7Vv90m+VZo1WKf2Z1wN17cK2M34x4cjca5dGz/HqqHi8ZHYQPjPcQDM1/uJRfB/lqQhuDFTyixWml6Uo8Fa6iVi7Cb9kQh2tpgSSRj0cqOpJ1kZgDb6QfMRrTDxS26U2qk9bjLk8IYE+4xufuho9QIHom4a22wEkAJQMAN50Bk2XcPFXyJDT7eyt7mw+Woi9QxGwSWTud90BM0w475pOIvK4sk1+C87lI2+int/rNwrcZ15kmvqchjQKCn7ShT8ItOqlywW+rKjO7YHvMZn1dFzKYxelVXUTvNdirywmk4ug9bji3hZzlksh+XY43NolN2/Be4R+5Rblwn7NW91ktNOwx84eU+jxTX8f1PgZ21wov5n5+1p2lQDioT/A9evCm/fPAKK68KG+9Fkvta8Vq0g9YQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3154.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(4326008)(64756008)(122000001)(38100700002)(6506007)(26005)(478600001)(54906003)(71200400001)(558084003)(85182001)(66476007)(8936002)(66946007)(66556008)(66446008)(33656002)(9686003)(2906002)(52536014)(5660300002)(224303003)(186003)(7696005)(316002)(86362001)(76116006)(55016002)(6916009)(7416002)(11606007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eUFhalU4QVBVMDlsVitTSFRtUEc2NXd4Y3pMUFpjSVF4cjNhUndjVzlqZmdW?=
 =?gb2312?B?Q2czMFBvc0dyK3NsbmxDVkx6bjB1aTFDU0pLRVB5NThsV0NrWlZvdm1RZTRD?=
 =?gb2312?B?ZVFiajIxYzBON2x3Vmg4OS9GZE1reU96ZzJVdndtWGhFZWRMc0FzOWxmSUxH?=
 =?gb2312?B?b2NaNjkrTWJlOXp1Q04raTJsNDZTaUpHQy9zWGZKaEZ3ZnZrRkUwQUZIaGhB?=
 =?gb2312?B?eUlRQVVlaWNKUUdneVRwRnhEYjFwa00xVFFzQjZxejhPL0x3V3FxWDVrZFg0?=
 =?gb2312?B?S09FZ1dvRGZ2VmRZM25jWHgvUFg4V2grWkh6NGlUQVdBNzQxcHlsdktXN2hm?=
 =?gb2312?B?NisveFlwYjVrZkluRjR2NjQ5b2l6N0srR0FkY1Vva1RmMXVjNFNtUUkwSXpL?=
 =?gb2312?B?dnVEcHlrOXBldm8rSVB3c2RTRTRVU0RFWmNiYkxRb051YTRrRjM3dCtROWJp?=
 =?gb2312?B?ODUxMEVhSkc5V2d2RkI1OVRwRnBIamRWRWp5TG9ib1pjdmdHeU5uT2ZRV0RL?=
 =?gb2312?B?UWxaTzc5bldjMkE0SEl1US9taktvRC9zdFNjTU5lMGs2a29XTkltemdIRGs1?=
 =?gb2312?B?c0NTczM4ODFobDZicFRUUkVTZmkxbzJRQmltR1paUVZRcU4xL21WejlsRmk2?=
 =?gb2312?B?SGRyaTBKdHY1R3ZTVGErN0pnemorWit6bk9VVFhSQXRxV3BKNDY3eEpQVmI0?=
 =?gb2312?B?ckFWRmY1dVNHU1RGRStMZHhFa3hWckNrV2oydzJaZGpaNjVGaWE2Q0s4YVJD?=
 =?gb2312?B?UWo3QW5GZEFMWHpsVFNhRHdoT2JEbHA4ZW4wSXRrK0hLcTRFd1VDZkxXT2ZC?=
 =?gb2312?B?RVlicVBEOGxac1J4eTYvaFd4NlUyalNlN1JUNll2YTNwM1BQbTVwaktxVXhE?=
 =?gb2312?B?QmdxSksvRzJmcFhDUmYyNGJjUVFlQVFjbCtMU0ZxbG94OWFiNDJ2dGlGTEpP?=
 =?gb2312?B?TW9DWkpONmFTcGt5d2REUlRLMy93aURRZC9SQmRRVG9XZDJ4RWppb1pyL3ZF?=
 =?gb2312?B?eE5CbGhUT1dTTzEwajF3cVNXc0Nwbmx0MkE0SkRaTmtSU3oyNlhnQytGMlF1?=
 =?gb2312?B?OVAyN1VvMk9vZ1ZPRk92NFRGK2VmMDRLZDhUSzVuS1FBRHFkZjE2NDk2QjJY?=
 =?gb2312?B?dWdpMWw2Q0wvY3FITzU4ZGVQSEg4SmxWUHlqU0Y5bk56YStnZEFPRzMrM1BN?=
 =?gb2312?B?bmgzZXI4WXpFckYyODV6UkpMVXVHdXpBdUM2WGNkaW1wNnR3RXhIY04raDdr?=
 =?gb2312?B?b202U2p0M0h6MjJRTGVpTXNSL0ZmZVcvaFBpanlsbVc0VW05Y05EdE5KbERp?=
 =?gb2312?B?UFkyc1d2c1dVUklsZW1ZOGQ2NndOSCtoVDNtdHY3TmJtUWFYbWc5NmkwY0NX?=
 =?gb2312?B?TElibVNyS2R4ZlpMTGZOT3ZWQ0djejdVY0hRZW5Jeldqcjg4ZHRHRTVzL2FE?=
 =?gb2312?B?d2dDNG1WdXVGZDYvMjNFQk5JL1FUNmRMRm93cXA3dTZDenNTWXR3WWRTTDRw?=
 =?gb2312?B?NndTcG00SW5DbG9QV2xkWm1UMlltZ0c5TTZyTDdoMmxhWDZWenpDZGpzR1Np?=
 =?gb2312?B?SGZhOGEvdyt5cWRSelBxKytxUE1pQnd4ZWhxYi9HMndSblZPNHNDMXRGUlJz?=
 =?gb2312?B?UEEvNnVmU3NiZldWUCtZUXNpQTFVUDV4TVhEOU9Ec01aVzNwVnd5WlBUSGg0?=
 =?gb2312?B?WmE0bU5YQUt2SllZODFGdTFEOTlKOFlLUGpvb2xBYkd3ak1LQmdYRTlOOTZQ?=
 =?gb2312?Q?efR9duFCeEEW/pkA4zUh6d+2uCizZnwoziDNYvo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3154.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c978cd9-726c-43a7-25cc-08d93248d326
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 11:04:20.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpmVRfOcP0xFlE70eu2+IZB7gaLFtkhosmA8Kk5BvjDl0vkfQUq98ARhWtYUuBABKxLDAL5gfaWzCKs6IkpIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB3890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB0aGluayB0aGlzIGxpbmUgYWxzbyBicmVhayBvdGhlciB0b29sLCBiZWNhdXNlIGRtYS1idWYg
ZmRpbmZvIGFsc28gYWRkIHNpemUgZmllbGQgaW4gcHJvY2ZzIGZkaW5mby4NCg==
