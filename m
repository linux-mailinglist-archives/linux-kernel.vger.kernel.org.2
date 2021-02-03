Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F165030D70E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhBCKJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:09:37 -0500
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:53345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233548AbhBCKJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FcuYCofILzclw5XkjuDy79kkKzPy9j+foP1Pl0QLHE=;
 b=cdfJ05k1BLS2LrCzIAFvI/ixStcTPskFVJVbRuJdBCdmRbOVVWlGXxPm4vCUtXZ2oQNVnDNwCmgUgQtszReq8josjo8kGtOmvXd9yWXtBjDKkaloH40bGP+3IG/ZlwjuvGXb0k0M2fcfH695qFwWTfP8h0jU4wtsSnpwN/NZShM=
Received: from AM6P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::43)
 by DBBPR08MB6202.eurprd08.prod.outlook.com (2603:10a6:10:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 10:08:36 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::d0) by AM6P195CA0030.outlook.office365.com
 (2603:10a6:209:81::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Wed, 3 Feb 2021 10:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 3 Feb 2021 10:08:36 +0000
Received: ("Tessian outbound 8418c949a3fa:v71"); Wed, 03 Feb 2021 10:08:36 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3eac11ef882e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A4D2C560-3081-4636-82A4-16E83FD24813.1;
        Wed, 03 Feb 2021 10:08:31 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3eac11ef882e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 03 Feb 2021 10:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB8lT1rEl4GrPW+6x0kk6SPNQHiZUcZNmsS9qgPQ7HnfOGQWVmsuX/AG4OvMKiPgbTdjyvzdocDYYVtTf0jDkflOhdE4A1EtDk7A99XjddxnQPa8AYGXGUSycgWyOyfdBgtIobcO8p6zQ/lvRU7lR95TUPazQgITnNdgaUwjrbZI04RmJAc8nK70knoE/GEZ6EyDFECf7WquV8srux9ZhScHEtUOGMIWq46szpxOB6zM2Y9rkwWFqCXkOzm36B1TAkdYTurvjulk6FoYaXJHjXOr2Zdnzb0u5dVrvNmho28tleF78/FHVCy1M4M9vMwvJQ1MAArXZ+VZgIBF7Lb7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FcuYCofILzclw5XkjuDy79kkKzPy9j+foP1Pl0QLHE=;
 b=l1e/zva6ZhpMgbPFyG+sQIUrqjv3l4bLa4FBBy+e10RFnrmVhVzKsmU3LGCSkPG3tnG93c7HXnA9sLkgL0UGYAvJsj9NMeMWNDddHqY3s8cGFwmrRapm10gRYoNamF/GPj/o2MXzJokZiDYC+DuaSoR4Mxexs2nLd991aK5/rTyKdkKZ4JMOzHlViMUYXZecGsZbOsId3sVCkUSUFDdnusgAWvSGxlNUa9ocyEBXFkxm/us7YiENj4GFO/R72v6I5jQbAbzk8JUjPAZYBIbQNNLldhnu0LkcebUl+RLx1CvTe1WZNLTxcT3iVEl26XvbMUwxpS2WbKrH5kCJThCE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FcuYCofILzclw5XkjuDy79kkKzPy9j+foP1Pl0QLHE=;
 b=cdfJ05k1BLS2LrCzIAFvI/ixStcTPskFVJVbRuJdBCdmRbOVVWlGXxPm4vCUtXZ2oQNVnDNwCmgUgQtszReq8josjo8kGtOmvXd9yWXtBjDKkaloH40bGP+3IG/ZlwjuvGXb0k0M2fcfH695qFwWTfP8h0jU4wtsSnpwN/NZShM=
Received: from VI1PR08MB3198.eurprd08.prod.outlook.com (2603:10a6:803:49::20)
 by VI1PR0802MB2430.eurprd08.prod.outlook.com (2603:10a6:800:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 10:08:26 +0000
Received: from VI1PR08MB3198.eurprd08.prod.outlook.com
 ([fe80::7c6b:e979:e3b2:abeb]) by VI1PR08MB3198.eurprd08.prod.outlook.com
 ([fe80::7c6b:e979:e3b2:abeb%7]) with mapi id 15.20.3805.026; Wed, 3 Feb 2021
 10:08:24 +0000
From:   Peter Smith <Peter.Smith@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
Thread-Topic: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
Thread-Index: AQHW+aQ6VkaIqc08EkKfOjb8LuFdtapGK3ZA
Date:   Wed, 3 Feb 2021 10:08:24 +0000
Message-ID: <VI1PR08MB31986E54164FA3293AA737E1F8B49@VI1PR08MB3198.eurprd08.prod.outlook.com>
References: <20210202022441.1451389-1-nathan@kernel.org>
 <CAK8P3a2864oSVkhaYynoadyYMcYDh0LvDDFSJ2D8OTHSszuSQA@mail.gmail.com>
 <20210202195133.GA1481999@localhost>
 <CAK8P3a19W2ejs8mtHrf6Nd6BVG8u5fM4BZB+neVEWdOmGCbLbw@mail.gmail.com>
In-Reply-To: <CAK8P3a19W2ejs8mtHrf6Nd6BVG8u5fM4BZB+neVEWdOmGCbLbw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 010875FA393928418D50D38AA7869D3D.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [81.104.142.31]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fd67e4f-473b-4c53-6b88-08d8c82babec
x-ms-traffictypediagnostic: VI1PR0802MB2430:|DBBPR08MB6202:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB620240B34D513CF6BAA2E905F8B49@DBBPR08MB6202.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r4B+OS+69BlI8oYgYvdV9Fy1nwE+TcWq2FL4BCC30ZWykGkL5xTgYbb0VBhkiGI+IL4AFV1WaKA0OR3XF9WMDnASVE4/ZI+GPbIEls5GJ32o17iKy/5hSRW862hWlLkpmtkJgjSlWb+6dCkrw6ZhW8ZCu4hM9vTNpN4+AwhhiiddaVpFWZA6kp9NX5E0wGsCVz+13AEX/1729o978S/60XYiw5P7pJZGUTd/u9pdBOVWDGTHSjCA3+uoq4B90uADm9jBrRBHzMurpeFe9PhDiQhQpXLlIUsOzCHteNyqfHY/SkV0NZNEyQDsLe82kUnU2RhToIcfy0dqA1gfvbmtkbDfZp7b8V3Uht3Mz3cc5zBmQSPgdxatiM5mGUTwb3VZx743WJVDdh4r8iGwtNx1/7VhTHBRVW81KbO6ESl43vO+sS8WPqOFHlfq58RpK50Mui4pY2eHUg1I28krOFJY6/sh5G6FsI4PJy40woIDEPWtCVIfFH5CJ/ryzhMeTPuqklQrrr7xFm+sYtF+Ssajl46qquo2hn7TJM8wdAgrtCXaZgS6TxQePp9Xj+M4P+lDwXgil8ZDxf+xSPQhtSXqRD3eZBtdXI/IpCPDIpEEIuI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3198.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(83380400001)(33656002)(52536014)(86362001)(2906002)(5660300002)(55016002)(66446008)(64756008)(66556008)(66476007)(66946007)(8936002)(76116006)(186003)(26005)(7696005)(966005)(4326008)(71200400001)(6506007)(53546011)(54906003)(110136005)(8676002)(9686003)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Wk1nenVZK3Z6Q2czNU9PaDVTTW9YeVBMalRmd1FMWXJ0VnB3bElkSUttRzE0?=
 =?utf-8?B?K092NXlUU0lpcGtWQ3NkQ3dqajkranlsaVluTkdIcFMrSjJCUGZQRFZuWkto?=
 =?utf-8?B?bXkyZFdLbU95UnFTUWpnV3lDdTNueGZ5bGUrT2RJVTVqeTV0NGw5MVJPMEdS?=
 =?utf-8?B?bEdqRS9wZ2J2WmFlR3YzdGxnMkRUYjJreDROWTFrOXQwYnBvcDIxOVc1NnZS?=
 =?utf-8?B?Zk1VTyt3U2d4VFZPdGowa0FHZVQ2U2ZXcitCMkUyMFJxQVFObE5rN1lLcEhK?=
 =?utf-8?B?T2RVakJXZmZSTmxLcFc0ZDZFdVEvbU4vQTFhQXd3V2RUTXdrUExNYk1xb2F0?=
 =?utf-8?B?SCtDckhENVZ3ak1INDMxdFUwcWVZME0vdGdHLzY5dHpJTVkreis2VS90SC9k?=
 =?utf-8?B?YmFQakR4aUJoY2FmWDVZcnF6dUpDRVNJUVNia0J0TW5ZeG8vOExybUVPV04x?=
 =?utf-8?B?bzJTQXhBTHNEZER4UXprcUdNa3AwUHFHL3d0L2swQnFuTFR0WUNtRHFQaUhr?=
 =?utf-8?B?TkxtY3ZSQ2hUQ0djUlJvWC8rZ2ZzWnZUZWd1dlgweVJycFVocHhrNDh4bjlz?=
 =?utf-8?B?NkRtMXFzWmo5ZWNZWTFkMEVpNDB3YXl2Mml5MENTRnhmeEVMYTlKbkczc3Nl?=
 =?utf-8?B?MjR5aXpQQlpKY2Y0ZUl3RzlkSENCQ2Y3c0ZPbUNQRmg4UTYrU1lwSEMwTFdH?=
 =?utf-8?B?VTUrWktvRzZwMmg2VjBTWHY4UTgrRm03MVZxektZZDZJRjBRcDE1cXpvNFE3?=
 =?utf-8?B?N3BTaGVseHNGYkJsMUZOaExBV0JCUzVvMnFuM2lydDBMaFA5MWR1cFZRdmd1?=
 =?utf-8?B?ejJtY3RMekdwa1ZVemFkc1ZNV00vWEhqZmdVZjl6TlRQVXhoTWQwajF6ZzNN?=
 =?utf-8?B?TWs5Y3R5UHlCS0tFOEpMUlNNVjg2aDlrcjFmc0QxS0J1VTlBekFUNlFoOWxn?=
 =?utf-8?B?cHlwMGJ3TEdMZnZJdkxYWlNaTjhJTlNqcjRyaHRuRUV1TnZWRDJ1cUx0TTM3?=
 =?utf-8?B?WFlzbmdVaDNXUzlzb25keTlwd25Ea1EySHgrckE4U2tIZm5jeUhwVFZmTzZE?=
 =?utf-8?B?Q3JGcXhZSDNTSW9lcGxpVUpHVXFFd1ZpR3ljL1ZzUWRxaytleG9YWHRpRytO?=
 =?utf-8?B?eGYyZjAvdGZIWHM2dzVmT1JJYnJVMGhqZWNMdGRrYlJlU2V1UDI4Y1lPMmZo?=
 =?utf-8?B?MkdNNlNWcnlkY2ovNkQ0UUZUenA1S2IvUmUyY3kzZkVMd0FxTXBpYWxLbGgv?=
 =?utf-8?B?L0l6b3pFMTN2cUdscVQzMkYyMEwya2l0ZkNSZ2ZhQ0VqY21qSEorQzR2OTVE?=
 =?utf-8?B?bVJMMW43OW1pL3hSL2lsVGVvc1FoMGQzQWVBOXk0NE9PTkFjVTU3Z3kra2VW?=
 =?utf-8?B?WkJrR1dLSE40NHB2NllVNVNvQTdsM2UxZVlMTjI3SGh3bmtCcmROUEdzcUxn?=
 =?utf-8?Q?2OECoXR/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2430
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: ecdf156e-c554-4640-aa6d-08d8c82ba4ef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: en8TrjAo7fQnMJtFq+ZUOU9gRNh1r6IfTMgxBNYgiMD3RL9SMeKt88dBc0oi4SdtRnRi4RNRdl5DG+FqirSWbva5cEkqExNwKQDG6pBo6WduHrt0GblXKoH9Au8pQ8LgMP0NWuSWRWZN87Z+9iaRm4ibbxn3ZRJR0xMcT4WaLr0B1tPKVDxgRJtId64a/uvvLLA20spg1Mgw1olWgnNSZQ0p1Xe7jYACghgd7uFHDh3puG4pSDaRjColx8Z9QQhqRS2GC5KJuiIgUoK4r7anSE1N5oJjD/m9B86/eIetiJ/xohThwoiBSvgCI4y8Tgpo8HWEyk2DMXlz4YGmMw7N2+wij7V1E6nI5NgnBWXta3Ck7lmjbRLEY1d4htQnCQwQVDrFgF4FHScrVFXYfpy3I958YZCwNUqLXTgZR/SlNsxNsEqisIGWJp6FphoSqKuIxRmLzqjbtRnHN9CJYFc94uKnfpNHKl3s2bFhmqvWR4RN641lGlGoyXTODGwCIXajZW7iGaNVepKeR7SNsKyMN+XZjzUrSWCtRLArJ5a6G8VTpqhjQ6a9jFs8lgbeIpMtOne8KJOZnZxwNHdPcmKncg1dreaVFiBh8ku2D2gZqH9YLjjMRKbsfOtU109eI2t4/Bv2sozyIfO7PFdwM3MjKva2yTURwtj585WaiBDU3QjvePhrmlyg9xTxpZu+7xZXxY48y+y4L62F1qjBsOpCDsxwIWZcJadyWe//K61X0TQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(52536014)(336012)(82310400003)(478600001)(83380400001)(5660300002)(107886003)(70206006)(966005)(81166007)(7696005)(82740400003)(356005)(70586007)(9686003)(4326008)(186003)(8936002)(33656002)(55016002)(8676002)(36860700001)(47076005)(2906002)(86362001)(316002)(26005)(6506007)(54906003)(53546011)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:08:36.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd67e4f-473b-4c53-6b88-08d8c82babec
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6202
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPg0KPiBTZW50OiAwMiBGZWJydWFyeSAyMDIxIDIwOjQ0DQo+IFRvOiBO
YXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+DQo+IENjOiBDYXRhbGluIE1hcmlu
YXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24NCj4gPHdpbGxAa2VybmVs
Lm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNh
dWxuaWVyc0Bnb29nbGUuY29tPjsNCj4gY2xhbmctYnVpbHQtbGludXggPGNsYW5nLWJ1aWx0LWxp
bnV4QGdvb2dsZWdyb3Vwcy5jb20+OyBBcm5kIEJlcmdtYW5uDQo+IDxhcm5kQGFybmRiLmRlPjsg
UGV0ZXIgU21pdGggPFBldGVyLlNtaXRoQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGFybTY0OiBNYWtlIENQVV9CSUdfRU5ESUFOIGRlcGVuZCBvbiAhTERfSVNfTExEDQo+IA0KPiBP
biBUdWUsIEZlYiAyLCAyMDIxIGF0IDg6NTEgUE0gTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBr
ZXJuZWwub3JnPg0KPiB3cm90ZToNCj4gPiBPbiBUdWUsIEZlYiAwMiwgMjAyMSBhdCAwOTowNDoz
NEFNICswMTAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBGZWIgMiwgMjAy
MSBhdCAzOjI1IEFNIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IFNpbWlsYXIgdG8gY29tbWl0IDI4MTg3ZGM4ZWJkOSAoIkFS
TTogOTAyNS8xOiBLY29uZmlnOg0KPiA+ID4gPiBDUFVfQklHX0VORElBTiBkZXBlbmRzIG9uICFM
RF9JU19MTEQiKSwgbGQubGxkIGRvZXMgbm90IHN1cHBvcnQNCj4gPiA+ID4gYWFyY2g2NCBiaWcg
ZW5kaWFuLCBsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcgYnVpbGQgZXJyb3Igd2hlbg0KPiA+ID4g
PiBDT05GSUdfQ1BVX0JJR19FTkRJQU4gaXMNCj4gPiA+ID4gc2VsZWN0ZWQ6DQo+ID4gPiA+DQo+
ID4gPiA+IGxkLmxsZDogZXJyb3I6IHVua25vd24gZW11bGF0aW9uOiBhYXJjaDY0bGludXhiDQo+
ID4gPg0KPiA+ID4gV2hpbGUgdGhpcyBpcyB0aGUgb3JpZ2luYWwgZXJyb3IgbWVzc2FnZSBJIHJl
cG9ydGVkLCBJIHRoaW5rIGl0DQo+ID4gPiB3b3VsZCBiZSBiZXR0ZXIgdG8gZXhwbGFpbiB0aGF0
IGxsZCBhY3R1YWxseSBkb2VzIHN1cHBvcnQgbGlua2luZw0KPiA+ID4gYmlnLWVuZGlhbiBrZXJu
ZWxzIGJ1dCB0aGV5IGRvbid0IGJvb3QsIGZvciB1bmtub3duIHJlYXNvbnMuDQo+ID4NCj4gPiBU
aGF0IHN0YXRlbWVudCBzZWVtcyB0byBjb250cmFkaWN0IHdoYXQgUGV0ZXIgU21pdGggc2F5czoN
Cj4gPg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVz
LzEyODgjaXNzdWVjb21tZW50LTc3MDYNCj4gPiA5MzU4Mg0KPiA+DQo+ID4gaHR0cHM6Ly9yZXZp
ZXdzLmxsdm0ub3JnL0Q1ODY1NSMxNDEwMjgyDQo+IA0KPiBSaWdodCwgYWRkaW5nIFBldGVyIHRv
IENjIGZvciBjbGFyaWZpY2F0aW9uLiBQZXRlciwgd2hhdCBJIGNhbiB0ZWxsIGZyb20NCj4gZXhw
ZXJpbWVudHMgaXMgdGhhdCBsbGQgYmVoYXZlcyBqdXN0IHlvdSBkZXNjcmliZSBpdCBzaG91bGQs
IGFuZCAoYXNpZGUgZnJvbQ0KPiB0aGUgY29tbWFuZCBsaWtlIGZsYWcgaGFuZGxpbmcpIGxpa2Ug
bGQuYmZkLCBzbyBJJ20gbm90IHN1cmUgaWYgdGhlcmUgYXJlIGFueQ0KPiBrbm93biBkZWZpY2ll
bmNpZXMgb3IganVzdCBtaW5vciBidWdzIHdoZW4gZGVhbGluZyB3aXRoIHRoZSBrZXJuZWwuDQo+
IA0KDQpJZiBhbiBlbXVsYXRpb24gKC1tKSBpcyBwcmVzZW50IHRoZW4gY3VycmVudCBMTEQgbWFw
cyBhbGwga25vd24gQXJtIGFuZCBBQXJjaCBlbXVsYXRpb25zIHRvIGxpdHRsZSBlbmRpYW4NCmh0
dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9ibG9iL21haW4vbGxkL0VMRi9Ecml2
ZXIuY3BwI0wxNDcgDQoNCkluIHRoaXMgY2FzZSB3ZSdsbCBnZXQgYW4gZXJyb3IgbWVzc2FnZSB3
aXRoIGEgYmlnLWVuZGlhbiBvYmplY3QuDQpsZC5sbGQ6IGVycm9yOiBiZS5vIGlzIGluY29tcGF0
aWJsZSB3aXRoIGFhcmNoNjRsaW51eA0KDQpJZiB0aGVyZSBhcmUgbm8gZW11bGF0aW9ucyBwcmVz
ZW50IHRoZW4gTExEIHdpbGwgYXV0by1kZXRlY3QgYmlnLWVuZGlhbiBmcm9tIHRoZSBmaXJzdCBv
YmplY3QgZmlsZS4NCmh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9ibG9iL21h
aW4vbGxkL0VMRi9Ecml2ZXIuY3BwI0wxNDY3DQoNClRoaXMgd2lsbCBzd2l0Y2ggdGhlIGdlbmVy
aWMgTExEIHdyaXRlIGZ1bmN0aW9ucyB0byB3cml0ZSBiaWctZW5kaWFuLiBUaGlzIHdpbGwgbWVh
biB0aGF0IGFueSB3cml0ZSB0byBpbnN0cnVjdGlvbnMgd2lsbCBuZWVkIHRvIHVzZSBleHBsaWNp
dCB3cml0ZTMybGUgYW5kIGFueSBkYXRhIHJlbG9jYXRpb25zIHdpbGwgbmVlZCB0byB1c2Ugd3Jp
dGUzMi93cml0ZTY0IGFzIGFwcHJvcHJpYXRlIGFuZCBub3QgdXNlIHRoZSBleHBsaWNpdCBsZSB2
ZXJzaW9ucy4gVGhlIHJlbG9jYXRpb25zIGZvciBpbnN0cnVjdGlvbnMgbG9vayB0byBiZSB1c2lu
ZyBleHBsaWNpdCBsZSB3cml0ZXMgYXMgd2UnZCB3YW50IHRoZW0gdG8uIEkndmUgc3BvdHRlZCBh
dCBsZWFzdCBvbmUgY2FzZSBvZiB1c2luZyB3cml0ZTY0bGUgZm9yIHdoYXQgbG9va3MgbGlrZSBk
YXRhDQpodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QvYmxvYi9tYWluL2xsZC9F
TEYvQXJjaC9BQXJjaDY0LmNwcCNMMTk4DQoNCkkndmUgbm90IGtub3cgYW55b25lIHRyeSBMTEQg
b24gYmlnLWVuZGlhbiBiZWZvcmUgc28gdGhlcmUgYXJlIG5vIGtub3duIGRlZmljaWVuY2llcy4g
SSBleHBlY3QgdGhhdCB3aXRob3V0IGFuIGFjdGl2ZSBzZWFyY2ggYW5kIHRlc3RzIHRoZXJlIHdp
bGwgYmUgc29tZSBwcm9ibGVtcy4gSSB0aGluayBldmVyeSB3cml0ZSB3aWxsIG5lZWQgbG9va2lu
ZyBhdCwgaWYgaXQgaXMgdG8gaW5zdHJ1Y3Rpb25zIGl0IG5lZWRzIHRvIGV4cGxpY2l0bHkgdXNl
IGxlLCBpZiB0byBkYXRhICh0aGF0IGNvdWxkIGJlIGVpdGhlciBsaXR0bGUgb3IgYmlnIGVuZGlh
bikgaXQgbXVzdCBub3QgZm9yY2UgbGl0dGxlIGVuZGlhbi4NCg0KUGV0ZXINCg0KDQo+IEZXSVcs
IEkgaGF2ZSBub3cgYnVpbHQgYSBiaWctZW5kaWFuIG11c2wgQyBsaWJyYXJ5IGFuZCBhIGhlbGxv
d29ybGQgYmluYXJ5LA0KPiB3aGljaCBJIGxpbmtlZCB3aXRoIGxkLmxsZCBhbmQgc3VjY2Vzc2Z1
bGx5IHRlc3RlZCB1c2luZyBxZW11LWFhcmNoNjRfYmUtDQo+IHN0YXRpYw0KPiANCj4gICAgICAg
QXJuZA0KPiANCj4gPiA+IEkgY2FuIHNlbmQgYSBwYXRjaCB0byBhZGRyZXNzIHRoZSBidWlsZCBl
cnJvciBhbmQgbWFyayBiaWctZW5kaWFuIGFzDQo+ID4gPiAiZGVwZW5kcyBvbiAhTERfSVNfTExE
IHx8IENPTVBJTEVfVEVTVCIgdG8gcmVmbGVjdCB0aGF0IGFuZCBoZWxwDQo+ID4gPiB3aXRoIHJh
bmRjb25maWcgdGVzdGluZy4NCj4gPg0KPiA+IEkgaGF2ZSBubyBzdHJvbmcgb3BpbmlvbiBvbiBo
YW5kbGluZyB0aGlzIHRob3VnaC4NCg==
