Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB5315D64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhBJCgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:36:43 -0500
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:48357
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235287AbhBJCci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts1C3+1KWF4AmbTeVPssVzlf5AjVzFCv8HPRq1U/Mvs=;
 b=4ez/Q7Ht7cQubS8Uf6jKwsEQoqaAhtnPf/bHpP2iQF8M0jW5LcMnW3Ycb2ueCH7pE9KFC/5cRjj/fAPcua2ajxVYQC6EtQe8IaXuVSOk+TsBBdkbI45UKeUFfenmZUD08meYTH0VS16jFk7rxOlnM1jbtvlDqaeN8SUwyZWjoEQ=
Received: from AS8PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:20b:311::9)
 by DB6PR0802MB2375.eurprd08.prod.outlook.com (2603:10a6:4:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 02:31:46 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::a) by AS8PR05CA0004.outlook.office365.com
 (2603:10a6:20b:311::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Wed, 10 Feb 2021 02:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 02:31:45 +0000
Received: ("Tessian outbound 4d8113405d55:v71"); Wed, 10 Feb 2021 02:31:45 +0000
X-CR-MTA-TID: 64aa7808
Received: from e021c8cc2d45.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4E02FB84-E3AA-4CC0-95B0-82EBE32342EA.1;
        Wed, 10 Feb 2021 02:31:40 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e021c8cc2d45.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 10 Feb 2021 02:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIaLYkeoEVYJGd2zJh1QFCzANwnfiNdXmEOYPCxEUHwQTdgEXMFYtmPh0/DRiIGuFKK1EhVvEb3XuS62GfXM3U9VWKGnRuwTN6cutVqu9VSaBh9YjyNOwIBze01hMYa4l5KzMKvuSbUQxY+kl23FNT+lJH3goW2ntASqKmHBBTyuGWgX8oD9ri7iMyMDAxrUN2I3ETTnJynFiU6cfDF1MjaBJlRNOM4g73v8d+74W4RuA7p1hyCDsDg0yfucl73FoMzYrk/8DHr1FaaRVtqJrQ4LDtc1cdhHpXy9Qz0VHAlu951F/xZ6epOt7gTlzuZcuohESYmptZbhsOeJ9MuIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts1C3+1KWF4AmbTeVPssVzlf5AjVzFCv8HPRq1U/Mvs=;
 b=QJ7O+HISiN0hoYcOstjvgK0zoVo/Vv4lwNa8iWHpTWY3u6z9wLbD3DInGOIfirtheTNNyoj5zrDViHmbWIFS7rI1messG1mB4QHwl6HmBux6nXnOk3BxjPGZudirV1r4/X0IjnpSnJ/YLiNENZiBrQhzR+BWj146f0pGz2aIOrQk4fqp76WB076t3788uZyFRSxKw/mtNHps8opGfF5iBHSEPeDPDgMS6xHm3OZ2tlY4m0toJYOVn0ZUgocqeUXvv3L85ZRzkXPWkWwTtQn20TLAFCQOjBipj7wEDec4iZpdzXV4mnLKipm6pOT/0Zdp3dVH5WRDKEsYVTdWQSPwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts1C3+1KWF4AmbTeVPssVzlf5AjVzFCv8HPRq1U/Mvs=;
 b=4ez/Q7Ht7cQubS8Uf6jKwsEQoqaAhtnPf/bHpP2iQF8M0jW5LcMnW3Ycb2ueCH7pE9KFC/5cRjj/fAPcua2ajxVYQC6EtQe8IaXuVSOk+TsBBdkbI45UKeUFfenmZUD08meYTH0VS16jFk7rxOlnM1jbtvlDqaeN8SUwyZWjoEQ=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AM6PR08MB4565.eurprd08.prod.outlook.com (2603:10a6:20b:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 02:31:38 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34%4]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 02:31:37 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>
CC:     "john.garry@huawei.com" <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf tools: Fix arm64 build error with gcc-11
Thread-Topic: [PATCH] perf tools: Fix arm64 build error with gcc-11
Thread-Index: AQHW/teEh/7GSlALIkGh1GdzfE9lgKpPvWEAgADtV5A=
Date:   Wed, 10 Feb 2021 02:31:37 +0000
Message-ID: <AM6PR08MB3589CB41DDB314215B260F96988D9@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210209113357.1535104-1-Jianlin.Lv@arm.com>
 <20210209121728.GA12546@leoy-ThinkPad-X240s>
In-Reply-To: <20210209121728.GA12546@leoy-ThinkPad-X240s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 778C875BE61D084CA102C103B2A46E9C.0
x-checkrecipientchecked: true
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2019135c-1713-48cc-6ac2-08d8cd6c02c5
x-ms-traffictypediagnostic: AM6PR08MB4565:|DB6PR0802MB2375:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB23750F00780DC12631730FE6988D9@DB6PR0802MB2375.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ez+7f5qag/U4aSsb2WO31sRtQ2+PZNmo63kWUgfgWexKttvdm390gsZT+PYugw6ZUh/FSkltpNO6FchjFKlCvsw+pxeC0NDiefJbV3ctBClvDhnc9rPfX2s+te5cJs+SzPqcoQjTzwycodZUntuYbx2qT1SDNdiuDB47DGiYxjORfjA7K4so7phuYsM0MQbe22QTSnuOE2DLW16zrtMi/lvZ4n/UfimDScUQwwrKJz+YrUgBQHClGHdwbH1sVdsIxPV06ObXHyZXy5XAFex8BgcoXDyehG0UfBNjT+uZagbK3Vs1gM6scqkQxuleXihqYvV2k1jWkO/ooGmmsx8m8PUtH0y5tg7X/yfkb3eQq4wpSlxOaPB1aJHREm66+niZxlWJFeh1nei8xtKPbYhBeqgzGYN78DJOhlDkchLHHVYJggj655ikOEb2jtmMkV876qJ5eOUwxR/62RQG47ln3Oqpu6CliruMO7oWDKb+G8y6qJJE3d+RH6SsXAkp0DgHDY7Fal36uz4c9k41UvUlVdj0qa4sDnVKLZ/Yw5LCc3Oqs4ebFyanHVuRLR77Pe/cqFr0bsIhf3FgFZT/euX3B91jqiftqnPMP/Tz9qnkKTE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(55016002)(86362001)(7416002)(83380400001)(966005)(6916009)(33656002)(8676002)(8936002)(4326008)(9686003)(2906002)(26005)(478600001)(7696005)(52536014)(64756008)(6506007)(66476007)(76116006)(66446008)(71200400001)(54906003)(5660300002)(66946007)(316002)(186003)(53546011)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dTJVMkdPanIyNjltVDZ3b3puTlRlaDJnQ1dsSU9pRitoRWFINTlsOGVuNG9N?=
 =?utf-8?B?ODhqcEt5WDNPU0ZFbGZML1hnSHVZUzgyTzFRUTVNMmlpNVVZNG94UjZpTnZz?=
 =?utf-8?B?NUlEdk5EZ09vTVBiSTZSNjM5N3QyeFhNaE5vSk50RFErMEwxNmZiSWtacWpF?=
 =?utf-8?B?THM2V2tQWVc1NEZUU1ZJZzR1T3p1ZkYzY2c2SUtQNFlVM2tCOTh0WGQrUGxx?=
 =?utf-8?B?dzAyM2NUckxZUGVJeENTR0Q1SkI3RXE0bFgzRjY2SUI2QmhNQW40K2J5VlBa?=
 =?utf-8?B?Sk81ck9QaWRkZDN4NHVQQlV3bDZPVnRYVU9MY2l6VVhXQVBVaHoxUlFEN2p6?=
 =?utf-8?B?QlZsdE05dlV6bHpmWWhyd093WTA1QXZDWGxBTEVlSndNeVN4Wi9GNkFTZ01K?=
 =?utf-8?B?Q3ErME1TamRGSXVQSmpLZ0FtNUNGRTRGMjE3MkE4NzNhUUh1bjdhcWoyZlpz?=
 =?utf-8?B?K1JwdGxvRkx0enNVVWUxL0pqUFJUUTk2alNTandML281QXBLUDRjU3BSVUdR?=
 =?utf-8?B?UlkvaUd5SzVVVXV5NXFkL3kyQVZ6bHhIdDRDUThSRkpOK3QxWWZJZ0ZzQmlu?=
 =?utf-8?B?QVo0dlFGZ2NscTBwR25rZFdnRnk1Zm52OEdyWmlhaWgxQmV3V095RXo5eFU0?=
 =?utf-8?B?TklsSU8vTjhNdXVPM1N6U0hzTHlvWVZBeWlsZW4xQTJ6NjZsZk1lNjZsZzRK?=
 =?utf-8?B?alZYRFdiZDdIRjFJaGtFNm9Lc1FsaDF6Q2tqbG9pb1ZZVlg4MFltemV0Sm9I?=
 =?utf-8?B?R3VtUGFKWUc0Y1o5UUtmMHBNRUZtaVJZTmRXYXYvd255S2JFbnZWZXdORzdB?=
 =?utf-8?B?QUVIbEhqZGowdzF1QStUd09OVW81amo3UG52N3JuM1hqQnNkbjIzbVBoM1FD?=
 =?utf-8?B?S0k5dm9RbkJWYXFCOGRENzZuUlNFVUdLb204dUkxdmZHdU9KSTErRkR4TUF3?=
 =?utf-8?B?eEZ1MG53UnJGU2VkK3FRcGdMb3V0d2UzUDQ0eDdVbDE4UE11US9kV1d2RjFW?=
 =?utf-8?B?UDVIbVNRVUlkM0ZZNStTK3ZtcDRjbGM5ZGxyeDI4d2dBNVgwV0dHZnNObkhx?=
 =?utf-8?B?ZUhFRWJEaWhRcTNhVTV2cnZqTXFueTQ1SmZsNHlTdlZ5TEFaYk5YcWh1dlBV?=
 =?utf-8?B?d01IYmpicEpnSXZWdjZWN2hmcUUxZ1Fab0xRS3E0ZFBrTnhsZ1lzTEluQkRp?=
 =?utf-8?B?M3VYVkQ2aFo5anA3STFxUGxBMElGQkhaREJ0eU5CWWFKV2syRGUwMGFrKzJF?=
 =?utf-8?B?Rm94akZQQ3dSK01oNzhoRmR6clRvbGYrMHl0VWl4MDExckJ6YU0zc25zYVI5?=
 =?utf-8?B?ZE5TcFRZUWo0em5KMUNST0tsRU5IY2lGL2tJTHlJbDRMQThwdlg0dnl6TCtL?=
 =?utf-8?B?ekduZVpxejA3dXRQUWlQSnE4TUE1WnBCNXl2TzFsNkNZSjBEOUpDUWZMcWgz?=
 =?utf-8?B?ZEFpaDFuZVFCcFJ1bTV2ZUNpY25MLzY3U1RiOWcwNllrSEo4NHBNWExiZ3hS?=
 =?utf-8?B?bDdoeGJ6Y1BKQVU2R1lMYmVGUVhDcTlMUUxKbDVrQ0Z3bkMzYXgyVUoxczlJ?=
 =?utf-8?B?KzBEREc0TkJyaWw5ZnRhTjNaQkdVVzhrWjBuZFB2eTQrd3UyRk4yaWdQaGtx?=
 =?utf-8?B?Z0ZSVTNjZVJBT2R2VzVlR0VhcjRPRlNuRmhmODZjVHA0N3RvZUdubWVuWUVG?=
 =?utf-8?B?RmxESG5yR2VJNWZjOTNTSUkxeDdOSCtWZ3ZVUjZ3emd5MWlma1hDaWpJRkdx?=
 =?utf-8?Q?CyCdT2DPdOPXw1ygA3+Ck6B7FVkVQgz7eJzIGgD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4565
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8202e561-58d1-4918-f9ff-08d8cd6bfdde
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOSKfmpTVVD9AehpwlSWxQmaVIrMatiU9DHRcnjHkl+O8V6hKUdUDpFs8087/guL27ucOVYVvaQjtUBUkyMNyGd3N08I/SwQ72wBkaN7ZBpDW/MXdoldqf7OjzVKmc7yl7B6txLAm0gQZxsjWNBtrRmGOuCbl1+9PppbO3we2p3jVCURztwDNteuxsL4VBPeQXmhQlqUIpQzkX6PjjF/uUWnjP1AvozLRF4NaM5vN5xUJazX5impZvVQ1tUuBESf6M7FwoLXBPchXN+vGw4U3oLVjkpNZqGegZWoRY9cPqEzjooLuZvXIO88xz2QxBYRF5bEcc5Qd+3FUmLC3XGXZHPsD+vh8u1liIY+/+cTBeXAg96E35TXkxkhR1S0szKbMlja9TURpjaxP/0Mli+qUCb4Z/jX+rCY9NHid4BYv3pTv2o1FB7JhXMm+zc7PpyiU8k4aKBNYX3hBUvDK0m131r2pmDibcl+H56HQ4kqLO0v+ckAZoRq1grCgcyBzWtWLyR/9QXIlKgLXyBvj/mbaH6MfISfiEGZZhn438hXP//HuS2Mn2p9/ApL5armxpSLuKXNFNhpCEdo8t0SgrCtkSUzmEimhczGB+gDM4zgYn2fbBy95DzkODMelkeydzstRQnc1kDx3Wbi6XfFXK/IHG3UfIw/3UrPN5OaqMry1C/GTZCKH+VyHD/kCnMVuqiHCxvKB3esUwkH0eyBvJ7Hsp0UfHv3RBe6HAdEJ1tlYNo=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(316002)(9686003)(336012)(47076005)(86362001)(7696005)(82310400003)(55016002)(82740400003)(8676002)(5660300002)(966005)(70206006)(478600001)(2906002)(70586007)(8936002)(4326008)(83380400001)(52536014)(36860700001)(186003)(26005)(54906003)(81166007)(33656002)(6506007)(53546011)(356005)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 02:31:45.7750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2019135c-1713-48cc-6ac2-08d8cd6c02c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvIFlhbiA8bGVvLnlh
bkBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA5LCAyMDIxIDg6MTcgUE0N
Cj4gVG86IEppYW5saW4gTHYgPEppYW5saW4uTHZAYXJtLmNvbT4NCj4gQ2M6IGpvaG4uZ2FycnlA
aHVhd2VpLmNvbTsgd2lsbEBrZXJuZWwub3JnOyBtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZzsN
Cj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IG1pbmdvQHJlZGhhdC5jb207IGFjbWVAa2VybmVsLm9y
ZzsgTWFyayBSdXRsYW5kDQo+IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47IGFsZXhhbmRlci5zaGlz
aGtpbkBsaW51eC5pbnRlbC5jb207DQo+IGpvbHNhQHJlZGhhdC5jb207IG5hbWh5dW5nQGtlcm5l
bC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGVyZiB0b29sczog
Rml4IGFybTY0IGJ1aWxkIGVycm9yIHdpdGggZ2NjLTExDQo+IA0KPiBIaSBKaWFubGluLA0KPiAN
Cj4gT24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDc6MzM6NTdQTSArMDgwMCwgSmlhbmxpbiBMdiB3
cm90ZToNCj4gPiBnY2MgdmVyc2lvbjogMTEuMC4wIDIwMjEwMjA4IChleHBlcmltZW50YWwpIChH
Q0MpDQo+ID4NCj4gPiBGb2xsb3dpbmcgYnVpbGQgZXJyb3Igb24gYXJtNjQ6DQo+ID4NCj4gPiAu
Li4uLi4uDQo+ID4gSW4gZnVuY3Rpb24g4oCYcHJpbnRm4oCZLA0KPiA+ICAgICBpbmxpbmVkIGZy
b20g4oCYcmVnc19kdW1wX19wcmludGbigJkgYXQgdXRpbC9zZXNzaW9uLmM6MTE0MTozLA0KPiA+
ICAgICBpbmxpbmVkIGZyb20g4oCYcmVnc19fcHJpbnRm4oCZIGF0IHV0aWwvc2Vzc2lvbi5jOjEx
Njk6MjoNCj4gPiAvdXNyL2luY2x1ZGUvYWFyY2g2NC1saW51eC1nbnUvYml0cy9zdGRpbzIuaDox
MDc6MTA6IFwNCj4gPiAgIGVycm9yOiDigJglLTVz4oCZIGRpcmVjdGl2ZSBhcmd1bWVudCBpcyBu
dWxsIFstV2Vycm9yPWZvcm1hdC1vdmVyZmxvdz1dDQo+ID4NCj4gPiAxMDcgfCAgIHJldHVybiBf
X3ByaW50Zl9jaGsgKF9fVVNFX0ZPUlRJRllfTEVWRUwgLSAxLCBfX2ZtdCwgXA0KPiA+ICAgICAg
ICAgICAgICAgICBfX3ZhX2FyZ19wYWNrICgpKTsNCj4gPg0KPiA+IC4uLi4uLg0KPiA+IEluIGZ1
bmN0aW9uIOKAmGZwcmludGbigJksDQo+ID4gICBpbmxpbmVkIGZyb20g4oCYcGVyZl9zYW1wbGVf
X2ZwcmludGZfcmVncy5pc3Jh4oCZIGF0IFwNCj4gPiAgICAgYnVpbHRpbi1zY3JpcHQuYzo2MjI6
MTQ6DQo+ID4gL3Vzci9pbmNsdWRlL2FhcmNoNjQtbGludXgtZ251L2JpdHMvc3RkaW8yLmg6MTAw
OjEwOiBcDQo+ID4gCWVycm9yOiDigJglNXPigJkgZGlyZWN0aXZlIGFyZ3VtZW50IGlzIG51bGwg
Wy1XZXJyb3I9Zm9ybWF0LW92ZXJmbG93PV0NCj4gPiAgIDEwMCB8ICAgcmV0dXJuIF9fZnByaW50
Zl9jaGsgKF9fc3RyZWFtLCBfX1VTRV9GT1JUSUZZX0xFVkVMIC0gMSwgX19mbXQsDQo+ID4gICAx
MDEgfCAgICAgICAgICAgICAgICAgICAgICAgICBfX3ZhX2FyZ19wYWNrICgpKTsNCj4gPg0KPiA+
IGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzIC4uLi4uLi4NCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggZml4ZXMgV2Zvcm1hdC1vdmVyZmxvdyB3YXJuaW5ncyBieSByZXBsYWNp
bmcgdGhlIHJldHVybg0KPiA+IHZhbHVlIE5VTEwgb2YgcGVyZl9yZWdfbmFtZSB3aXRoICJ1bmtu
b3duIi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5saW4gTHYgPEppYW5saW4uTHZAYXJt
LmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvcGVyZi9hcmNoL2FybTY0L2luY2x1ZGUvcGVyZl9y
ZWdzLmggfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2FyY2gvYXJtNjQv
aW5jbHVkZS9wZXJmX3JlZ3MuaA0KPiA+IGIvdG9vbHMvcGVyZi9hcmNoL2FybTY0L2luY2x1ZGUv
cGVyZl9yZWdzLmgNCj4gPiBpbmRleCBiYWFhNWU2NGEzZmIuLjkwMTQxOWY5MDdjMCAxMDA2NDQN
Cj4gPiAtLS0gYS90b29scy9wZXJmL2FyY2gvYXJtNjQvaW5jbHVkZS9wZXJmX3JlZ3MuaA0KPiA+
ICsrKyBiL3Rvb2xzL3BlcmYvYXJjaC9hcm02NC9pbmNsdWRlL3BlcmZfcmVncy5oDQo+ID4gQEAg
LTg1LDEwICs4NSwxMCBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKnBlcmZfcmVnX25hbWUo
aW50IGlkKQ0KPiA+ICAJY2FzZSBQRVJGX1JFR19BUk02NF9QQzoNCj4gPiAgCQlyZXR1cm4gInBj
IjsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4gLQkJcmV0dXJuIE5VTEw7DQo+ID4gKwkJcmV0dXJuICJ1
bmtub3duIjsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JcmV0dXJuIE5VTEw7DQo+ID4gKwlyZXR1cm4g
InVua25vd24iOw0KPiANCj4gVGhpcyBpc3N1ZSBpcyBhIGNvbW1vbiBpc3N1ZSBjcm9zc2luZyBh
bGwgYXJjaHMuICBTbyBpdCdzIGJldHRlciB0byBjaGFuZ2UgdGhlDQo+IGNvZGUgaW4gdGhlIHBs
YWNlcyB3aGVyZSBjYWxscyBwZXJmX3JlZ19uYW1lKCksIGUuZy4gaW4NCj4gdXRpbC9zZXNzaW9u
LmM6DQo+IA0KPiAtLS0gYS90b29scy9wZXJmL3V0aWwvc2Vzc2lvbi5jDQo+ICsrKyBiL3Rvb2xz
L3BlcmYvdXRpbC9zZXNzaW9uLmMNCj4gQEAgLTExMzUsMTIgKzExMzUsMTQgQEAgc3RhdGljIHZv
aWQgYnJhbmNoX3N0YWNrX19wcmludGYoc3RydWN0DQo+IHBlcmZfc2FtcGxlICpzYW1wbGUsIGJv
b2wgY2FsbHN0YWNrKSAgc3RhdGljIHZvaWQgcmVnc19kdW1wX19wcmludGYodTY0DQo+IG1hc2ss
IHU2NCAqcmVncykgIHsNCj4gICAgICAgICB1bnNpZ25lZCByaWQsIGkgPSAwOw0KPiArICAgICAg
IGNoYXIgKnJlZ19uYW1lOw0KPiANCj4gICAgICAgICBmb3JfZWFjaF9zZXRfYml0KHJpZCwgKHVu
c2lnbmVkIGxvbmcgKikgJm1hc2ssIHNpemVvZihtYXNrKSAqIDgpIHsNCj4gICAgICAgICAgICAg
ICAgIHU2NCB2YWwgPSByZWdzW2krK107DQo+IA0KPiArICAgICAgICAgICAgICAgcmVnX25hbWUg
PSBwZXJmX3JlZ19uYW1lKHJpZCk7DQo+ICAgICAgICAgICAgICAgICBwcmludGYoIi4uLi4gJS01
cyAweCUwMTYiIFBSSXg2NCAiXG4iLA0KPiAtICAgICAgICAgICAgICAgICAgICAgIHBlcmZfcmVn
X25hbWUocmlkKSwgdmFsKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICByZWdfbmFtZSA/OiAi
VW5rbm93biIsIHZhbCk7DQo+ICAgICAgICAgfQ0KPiAgfQ0KPiANCg0KVGhhbmtzIGZvciB5b3Vy
IGNvbW1lbnRzLCBJIHdpbGwgc2VuZCBhIHYyIG9mIHRoZSBwYXRjaCB0b2RheS4NCg0KSmlhbmxp
bg0KDQoNCj4gQW5kIGFub3RoZXIgcG90ZW50aWFsIGlzc3VlIGlzIHRoZSBmb3JtYXQgc3BlY2lm
aWVyICIlLTVzIiwgaXQgcHJpbnRzIG91dA0KPiBtYXhpbXVtIHRvIDUgY2hhcnMsIGJ1dCBhY3R1
YWxseSBzdHJpbmcgIlVua25vd24iIGhhcyA3IGNoYXJzLg0KPiBBY3R1YWxseSB0aGUgZm9ybWF0
IHNwZWNpZmllciBicmVha3Mgb3RoZXIgYXJjaHMgcmVnaXN0ZXIgbmFtZXMsIGUuZy4NCj4gWzFd
WzJdLCBzZWVtcyB0byBtZSwgaXQncyBiZXR0ZXIgdG8gY2hhbmdlIGFzICIlLThzIiwgeW91IG1p
Z2h0IG5lZWQgdG8gdXNlIGENCj4gZGVkaWNhdGVkIHBhdGNoIGZvciBmb3JtYXQgc3BlY2lmaWVy
IGNoYW5nZXMuDQo+IA0KPiBUaGFua3MsDQo+IExlbw0KPiANCj4gDQo+IFsxXQ0KPiBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQvdHJlZS90b29scy8NCj4gcGVyZi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9wZXJmX3JlZ3MuaCNu
NTcNCj4gWzJdDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3Rvb2xzLw0KPiBwZXJmL2FyY2gvY3NreS9pbmNs
dWRlL3BlcmZfcmVncy5oI244Mw0K
