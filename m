Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823E431694A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBJOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:41:50 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:64770
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230184AbhBJOlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+JRtoo52F9yj4PqyKahWqbpYFwExJTzUuE3JreHoHE=;
 b=5+bS5JeSOQ5YpiER9i1++r6ndzZFY2Z/CdyxPKNv3VRLwQdHtEFjirHempe0PAsoGyJt97irTmRWP1kyo5sqFZ+gqv1BcRryS36y6JVNgyxCcZCjt15JeJ1+h+1o0VsZnGeY+IgzYifrOV/raCLNTReFNPbKx5yAAd0YO4asN68=
Received: from AS8PR04CA0089.eurprd04.prod.outlook.com (2603:10a6:20b:313::34)
 by PA4PR08MB6112.eurprd08.prod.outlook.com (2603:10a6:102:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 14:40:47 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:313:cafe::fd) by AS8PR04CA0089.outlook.office365.com
 (2603:10a6:20b:313::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Wed, 10 Feb 2021 14:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 14:40:46 +0000
Received: ("Tessian outbound 8418c949a3fa:v71"); Wed, 10 Feb 2021 14:40:45 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5a41300d7ff7.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B1F92B75-FE37-4790-AFCF-8D26F46F0207.1;
        Wed, 10 Feb 2021 14:40:40 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5a41300d7ff7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 10 Feb 2021 14:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7M0XXfWd78ilM7/tYpHyzDVlbV38C6IZgRZdqYrJiBG0LlAXAlazyepMGvn2Xzyp734AsgHaIfX+vx8eQmpCX/mit0S+QqynD3hUvfv8oeDkddGCqym33rOCEvEviLN80dN43whvuM3ZWTYHEnxZAExkmrr6KfwD/IaVf8dW+ZnS+86OYQN2S+1lXoQIT9JMDOr8YERhhDebSlbClYXR2jeLMhqfO53FJ2jYMYMnYWfmBVerrVUS78KqjBRz1sQpIxwcJHOeNg/S72+3Z1cNd5zUbyX36o9lFCBatwNeAIQudfS61jiXrf4yh0nAypXnCT9imjPLzYMuY8UFQouCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+JRtoo52F9yj4PqyKahWqbpYFwExJTzUuE3JreHoHE=;
 b=bKUUYrW45Xx3d76u8eqnmGh4ID2a3X9401c4MImE1+h+hzgs9yPREi/GFxoaF0woGwXZEcWrRapru44NVtqHYpvRAO1rxQPd/CFGXLodjD7bBsV/sNsmSzcFgQC95FViDPMx2IsQtE9BsZeXqTKxBjfGtiLZFfIAiI6xwe2+9cbdfi+JNZlJuOpRtjQ0rIWeOD1QB1zs4gn7hdP4Abe+BFY3C3AeP30DWHzlqbR7b6qtG1ff2pJAjrBFlnTO2XQFwhOUbAtblWVumIzZRSka3f8O9M2O5OV7+ZOmSe3JtFJ5t+oywXQrZ9uFEv0AJJIuNk23Dmsl4nc++X5CzQNk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+JRtoo52F9yj4PqyKahWqbpYFwExJTzUuE3JreHoHE=;
 b=5+bS5JeSOQ5YpiER9i1++r6ndzZFY2Z/CdyxPKNv3VRLwQdHtEFjirHempe0PAsoGyJt97irTmRWP1kyo5sqFZ+gqv1BcRryS36y6JVNgyxCcZCjt15JeJ1+h+1o0VsZnGeY+IgzYifrOV/raCLNTReFNPbKx5yAAd0YO4asN68=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AS8PR08MB6296.eurprd08.prod.outlook.com (2603:10a6:20b:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 14:40:38 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34%4]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 14:40:38 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "agerstmayr@redhat.com" <agerstmayr@redhat.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] perf tools: Fix arm64 build error with gcc-11
Thread-Topic: [PATCH v2] perf tools: Fix arm64 build error with gcc-11
Thread-Index: AQHW/1xyLkwHOhfkFU2IFLIhsAvxZKpRIj6AgABTYPA=
Date:   Wed, 10 Feb 2021 14:40:38 +0000
Message-ID: <AM6PR08MB3589F07CE7DEE8BDA6F0FD53988D9@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210210032447.2248255-1-Jianlin.Lv@arm.com>
 <5db96a5f-3749-7f54-15ce-27b932bcbca6@huawei.com>
In-Reply-To: <5db96a5f-3749-7f54-15ce-27b932bcbca6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B14DDC7C2D76564A92FA670AB5C4163F.0
x-checkrecipientchecked: true
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8bbbdb0-1556-445d-d798-08d8cdd1da2d
x-ms-traffictypediagnostic: AS8PR08MB6296:|PA4PR08MB6112:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PA4PR08MB61122B7740A5DAF488FD36B7988D9@PA4PR08MB6112.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1pJJJAZf2NWzvNvzWoMclbODmu/MLQue8HfcLXQGBVGAJBX0iW9OeI626QdVKYwTGdFv5Vziw6IuZiqzP+ozLEOhWj5aVCoGg071fFimvtTIoJ309PMtqmXvhwckdeFxtSlvKPsIfRGczeY1Sd3eLoTI6njH/c9w3k+HzrwlakkigCfbU6gXpcyaAT/y4OxlbGR/7txW6qpMrGgdzIFsmQwAQdqP5I2CgOlICDGDOaLXZ+zNU6OkY8hR2divILw8IvBChJkpDWT48qa5G3X3bGkOVfdiWO7VKQtn5BCwF6PdxML52D1Fp9bV2dU6hA8QyvFnmoNdsTmGIUK9/l+VkEBxZwai1pr5OG1Bl+TtPTxrgWHlMiviPgWn3drb+ehs1qaFMmMcUZQOJztid0eFtjibRplf+LsH+KukLxBLoMcaz4PEnKtbJUrRObknx0SJXVBxYdxgjbnoIxpLkD83kZlg2MombMMuUI0TJbvBT9hQArvJiF4J+y1jFYk5IyoN07wZNOX5CPy9HiKN3vhvYhGd+dRN+jRJKuZSFI0vPuK5V9QeB9s7Wzp6UoK3IW7E
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(7696005)(5660300002)(26005)(86362001)(478600001)(186003)(7416002)(9686003)(8936002)(55016002)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(52536014)(6506007)(53546011)(71200400001)(8676002)(2906002)(4326008)(110136005)(921005)(83380400001)(76116006)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VzltVVE4TE5vMm4zN0pFTWhseWU0cEhQQSsydHVSK200L3ZPQmdlQzEvN0xX?=
 =?utf-8?B?Q3U1UlFLaUlYejhUb3hXUkh5aXZVazdFWDlzNUxkbHlqRmFKdUgwS1QzeUJL?=
 =?utf-8?B?TVJRbUhEQkZ4SGo0RlhhcVV3emtpK1pQemlWZ29IMGRmeDZJN3BrM28zODlN?=
 =?utf-8?B?N2V5aFFVRHpOUHhGbWFsd2tJQXpYWkxkNmhBSFpWR2JMcXUxZVBka24wNUw5?=
 =?utf-8?B?cDN6WlBaNDlmR3IyQnZlSXRqQllYTDBKMituQ1FJTWNSZ2dxaXhTTlAyZXZ5?=
 =?utf-8?B?UWxrcU1HdU1IckMrVUZVQSt1cXhReDFwTG9DSno4SGdkZDNaVnNha0oycEVr?=
 =?utf-8?B?NFErdUljUDZXZXVZYUcwMlRIalpMY1VwT0VpWWYwTk5XcWZTS01sc2hFdkh6?=
 =?utf-8?B?c2Q5MEs1cTVXWEdoQ2FrUHNqaGhnN2IyU0tBQU5vVjkwbEFXelJLbTBaaFpQ?=
 =?utf-8?B?aWZkNVNXdTZnYkxJT2FUTDZmZ1Nod2dFV0lWVjhWRnYxczJOQmpVNXY2SEkv?=
 =?utf-8?B?WVhkOHVRL0xMRGVPcXlSRXBLeUdWSnRBejl0RWNFZlVVekl2OWt6cmpyczFQ?=
 =?utf-8?B?eFFFNHBjdkRoaXpWOW96NitsNWM3eGRBMnlaOEsxaXdqS2VSYlZzOUVvS1lt?=
 =?utf-8?B?NFpINk1wVThodkVZemx5WVlpMllGZ1FRdFR0aUlidkwxS2VDb3lpNjBsREhl?=
 =?utf-8?B?dHJwOUcyWmN6ZVZUaTJBemd4eHlvdXIvZ3l1OWxpLzEwYnNWOGlqRjhjNTNU?=
 =?utf-8?B?ejl3RCtJWUdnZjRSb3NwOEJUUkNJQ2k4RkZSb2RIckV3L05DSThwdGRZcHp3?=
 =?utf-8?B?UWQzZnY0OTJnRGhZSnJ0OTNOcnhNWWwwU2NEZ2l5SEsvRDZ4YTlqMzhIQ3h0?=
 =?utf-8?B?ZGZGbFgyb1hVNnJMNzA4NWZ4aEFuWVdwZkx2aHN4em1Cd05rL3ozMWpuRC9X?=
 =?utf-8?B?Wjd3RGQ2Zk02czJJMTlKbERMamx0WFpUbmJxTWZPRE9oMUxXcGFSL2NieWRK?=
 =?utf-8?B?cDJYVlpUMmxId1pvU0ovVUVxQVl1RlQwZjRRMDAyK2dmNUZnVndQek1mZkZ3?=
 =?utf-8?B?MTMrZXlDVlkzaEpDNTJZdW5sNUN3cFZaZjRDR0RrZ1ovdkdQQkRlM2xhQVVF?=
 =?utf-8?B?ZkN0dldrMGVvMjJBaDBIcUliOHpFQklualpPQUg1bklGSDc2c1pIcmJLUTIx?=
 =?utf-8?B?UDZiUzJlck1jTzQ1M3JxYmpDakNYOXFFK0pUY1dybTNxekZyWExQMzBtZ1hP?=
 =?utf-8?B?NSs4RVF6L0V4NkVTUmN0K0YrejlIZzJFMGJSTU9CVDdjQkxYdDlmZThKWGVv?=
 =?utf-8?B?ZXJhMmJhbnVUSGxUVXVPdG12SlV2V041Q2hhb2N0S1MzK2xvRkZhMHZZSERt?=
 =?utf-8?B?TkJkdTJGa3VhT0ZUM20rS3JZd0RJbGQzbCt1aWZ3OWdkUjE2NVB4VUg4ei8v?=
 =?utf-8?B?d3NoVHZPenZ6SU1Ed2RmdkpoeU1sVk5KN0VIajQrbzZRQzZMbUQ2Zkp5SkN1?=
 =?utf-8?B?MWxOdHN6QzhoUmRpSTlQQ1Y4SDdPRkRKNkk4cXJtZnNnUVAvYmY2NXQ3THhG?=
 =?utf-8?B?OEVIR1VXUkUyd01EM3NaUG5nSk4vdGluWnZsa0I1U2NKcGdQN0sra3NpQ3dw?=
 =?utf-8?B?TWcwc2pGUzNRakpvNFU0L0FXdXJCc2FybXpJRW9EbjBrNGc5OS9DeHVkMFFI?=
 =?utf-8?B?MnEvZVo1SW9lYSs2ek90OStORGprbmd1RWVKM0hOY3FxY245ZzhlbGRpblZt?=
 =?utf-8?Q?C48EdyGuonwIYLoe1GPulbsSmW1pC4efcDw1dVP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6296
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 982e5605-0f49-4f0b-2045-08d8cdd1d553
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNm5GBRdMh9PeBD30ODxhFrFz1GdLDnWUBmbTlt+zV7urv5GdVinrV3QXJGfEerEn1sMlFl3Y4x9he+eFPbZBcU2q7f/10rnJY5ktuhH49lB0cAP245syQiJVCcYg5qXTY2h+i+BdeXuStFaW84+E31AMqeHfo41srkdn1grs8SGbGKXNU1w7uSRWEjk/djTPFwqwsdt5hx9B6Sq4AlLWB6tvl+l4+rB+ZB94xPP4uPgxRiwhMAptsXogQ7I/fuy8Kaure+Jns6AW9Tn9BcVR4EYdnvzEa5j5peQpEkjejZlzYBARR4x73gA0JxByVTRWv1Gwf/dPi19XZxtFzO/1FCQnes4LR7MFwaZON2s+Z4BTtde/vmjng114Qvt2S/k6u5tlAtdJSGAkYin4kWK4g/JMkiG4ViNMGiFqU1ELvo6vGcZlFYNBcX9DAXYKAmuUtxYjBOUaVLs9PmbMEZO8pI/daKazQIlFFmrsnQBvVETzniasWCnJPIHQb+fuGP5fB9Q0SPanlKNk101XL9Fe/YWiOwMKQzQIdaZZuPM4QW4L9JtiVA5eIAdnPDlm/QiQN/TNhgQCoHXhNVhS9VsapwAbbVcNAt30F7EKBY0wlotsDDLUbhWKV3TlLfxoXjV/kugRp5dd4WF+vX9SeY1hNiqifCjpJtKO/QbMouikQ4=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(36840700001)(46966006)(5660300002)(6506007)(70586007)(921005)(70206006)(186003)(36860700001)(316002)(83380400001)(26005)(53546011)(86362001)(8936002)(8676002)(7696005)(55016002)(52536014)(9686003)(33656002)(4326008)(82310400003)(2906002)(356005)(82740400003)(81166007)(478600001)(110136005)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 14:40:46.4452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bbbdb0-1556-445d-d798-08d8cdd1da2d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeSA8am9o
bi5nYXJyeUBodWF3ZWkuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDEwLCAyMDIx
IDU6MzggUE0NCj4gVG86IEppYW5saW4gTHYgPEppYW5saW4uTHZAYXJtLmNvbT47IHdpbGxAa2Vy
bmVsLm9yZzsNCj4gbWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc7IGxlby55YW5AbGluYXJvLm9y
ZzsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IG1pbmdvQHJlZGhhdC5jb207IGFjbWVAa2VybmVs
Lm9yZzsgTWFyayBSdXRsYW5kDQo+IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47IGFsZXhhbmRlci5z
aGlzaGtpbkBsaW51eC5pbnRlbC5jb207DQo+IGpvbHNhQHJlZGhhdC5jb207IG5hbWh5dW5nQGtl
cm5lbC5vcmc7IGlyb2dlcnNAZ29vZ2xlLmNvbTsNCj4gYWdlcnN0bWF5ckByZWRoYXQuY29tOyBr
YW4ubGlhbmdAbGludXguaW50ZWwuY29tOw0KPiBhZHJpYW4uaHVudGVyQGludGVsLmNvbQ0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBwZXJmIHRvb2xzOiBGaXggYXJtNjQgYnVpbGQgZXJyb3Igd2l0aCBnY2MtMTENCj4NCj4gT24g
MTAvMDIvMjAyMSAwMzoyNCwgSmlhbmxpbiBMdiB3cm90ZToNCj4gPiBnY2MgdmVyc2lvbjogMTEu
MC4wIDIwMjEwMjA4IChleHBlcmltZW50YWwpIChHQ0MpDQo+ID4NCj4gPiBGb2xsb3dpbmcgYnVp
bGQgZXJyb3Igb24gYXJtNjQ6DQo+ID4NCj4gPiAuLi4uLi4uDQo+ID4gSW4gZnVuY3Rpb24g4oCY
cHJpbnRm4oCZLA0KPiA+ICAgICAgaW5saW5lZCBmcm9tIOKAmHJlZ3NfZHVtcF9fcHJpbnRm4oCZ
IGF0IHV0aWwvc2Vzc2lvbi5jOjExNDE6MywNCj4gPiAgICAgIGlubGluZWQgZnJvbSDigJhyZWdz
X19wcmludGbigJkgYXQgdXRpbC9zZXNzaW9uLmM6MTE2OToyOg0KPiA+IC91c3IvaW5jbHVkZS9h
YXJjaDY0LWxpbnV4LWdudS9iaXRzL3N0ZGlvMi5oOjEwNzoxMDogXA0KPiA+ICAgIGVycm9yOiDi
gJglLTVz4oCZIGRpcmVjdGl2ZSBhcmd1bWVudCBpcyBudWxsIFstV2Vycm9yPWZvcm1hdC1vdmVy
Zmxvdz1dDQo+ID4NCj4gPiAxMDcgfCAgIHJldHVybiBfX3ByaW50Zl9jaGsgKF9fVVNFX0ZPUlRJ
RllfTEVWRUwgLSAxLCBfX2ZtdCwgXA0KPiA+ICAgICAgICAgICAgICAgICAgX192YV9hcmdfcGFj
ayAoKSk7DQo+ID4NCj4gPiAuLi4uLi4NCj4gPiBJbiBmdW5jdGlvbiDigJhmcHJpbnRm4oCZLA0K
PiA+ICAgIGlubGluZWQgZnJvbSDigJhwZXJmX3NhbXBsZV9fZnByaW50Zl9yZWdzLmlzcmHigJkg
YXQgXA0KPiA+ICAgICAgYnVpbHRpbi1zY3JpcHQuYzo2MjI6MTQ6DQo+ID4gL3Vzci9pbmNsdWRl
L2FhcmNoNjQtbGludXgtZ251L2JpdHMvc3RkaW8yLmg6MTAwOjEwOiBcDQo+ID4gICAgICBlcnJv
cjog4oCYJTVz4oCZIGRpcmVjdGl2ZSBhcmd1bWVudCBpcyBudWxsIFstV2Vycm9yPWZvcm1hdC1v
dmVyZmxvdz1dDQo+ID4gICAgMTAwIHwgICByZXR1cm4gX19mcHJpbnRmX2NoayAoX19zdHJlYW0s
IF9fVVNFX0ZPUlRJRllfTEVWRUwgLSAxLCBfX2ZtdCwNCj4gPiAgICAxMDEgfCAgICAgICAgICAg
ICAgICAgICAgICAgICBfX3ZhX2FyZ19wYWNrICgpKTsNCj4gPg0KPiA+IGNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzIC4uLi4uLi4NCj4gPg0KPiA+IFRoaXMgcGF0Y2gg
Zml4ZXMgV2Zvcm1hdC1vdmVyZmxvdyB3YXJuaW5ncy4gQWRkIHRlcm5hcnkgb3BlcmF0b3IsIFRo
ZQ0KPiA+IHN0YXRlbWVudCBldmFsdWF0ZXMgdG8gIlVua25vd24iIGlmIHJlZ19uYW1lPT1OVUxM
IGlzIG1ldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5saW4gTHYgPEppYW5saW4uTHZA
YXJtLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogQWRkIHRlcm5hcnkgb3BlcmF0b3IgdG8gYXZvaWQg
c2ltaWxhciBlcnJvcnMgaW4gb3RoZXIgYXJjaC4NCj4gPiAtLS0NCj4gPiAgIHRvb2xzL3BlcmYv
YnVpbHRpbi1zY3JpcHQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKysrLQ0KPiA+
ICAgdG9vbHMvcGVyZi91dGlsL3NjcmlwdGluZy1lbmdpbmVzL3RyYWNlLWV2ZW50LXB5dGhvbi5j
IHwgNCArKystDQo+ID4gICB0b29scy9wZXJmL3V0aWwvc2Vzc2lvbi5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCA1ICsrKy0tDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJm
L2J1aWx0aW4tc2NyaXB0LmMgYi90b29scy9wZXJmL2J1aWx0aW4tc2NyaXB0LmMNCj4gPiBpbmRl
eCA0MmRhZDRhMGY4Y2YuLmQ1OWRhM2EwNjNkMCAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJm
L2J1aWx0aW4tc2NyaXB0LmMNCj4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4tc2NyaXB0LmMN
Cj4gPiBAQCAtNjM1LDYgKzYzNSw3IEBAIHN0YXRpYyBpbnQgcGVyZl9zYW1wbGVfX2ZwcmludGZf
cmVncyhzdHJ1Y3QNCj4gcmVnc19kdW1wICpyZWdzLCB1aW50NjRfdCBtYXNrLA0KPiA+ICAgew0K
PiA+ICAgdW5zaWduZWQgaSA9IDAsIHI7DQo+ID4gICBpbnQgcHJpbnRlZCA9IDA7DQo+ID4gK2Nv
bnN0IGNoYXIgKnJlZ19uYW1lOw0KPiA+DQo+ID4gICBpZiAoIXJlZ3MgfHwgIXJlZ3MtPnJlZ3Mp
DQo+ID4gICByZXR1cm4gMDsNCj4gPiBAQCAtNjQzLDcgKzY0NCw4IEBAIHN0YXRpYyBpbnQgcGVy
Zl9zYW1wbGVfX2ZwcmludGZfcmVncyhzdHJ1Y3QNCj4gPiByZWdzX2R1bXAgKnJlZ3MsIHVpbnQ2
NF90IG1hc2ssDQo+ID4NCj4gPiAgIGZvcl9lYWNoX3NldF9iaXQociwgKHVuc2lnbmVkIGxvbmcg
KikgJm1hc2ssIHNpemVvZihtYXNrKSAqIDgpIHsNCj4gPiAgIHU2NCB2YWwgPSByZWdzLT5yZWdz
W2krK107DQo+ID4gLXByaW50ZWQgKz0gZnByaW50ZihmcCwgIiU1czoweCUiUFJJeDY0IiAiLCBw
ZXJmX3JlZ19uYW1lKHIpLA0KPiB2YWwpOw0KPiA+ICtyZWdfbmFtZSA9IHBlcmZfcmVnX25hbWUo
cik7DQo+ID4gK3ByaW50ZWQgKz0gZnByaW50ZihmcCwgIiU1czoweCUiUFJJeDY0IiAiLCByZWdf
bmFtZSA/Og0KPiAiVW5rbm93biIsDQo+ID4gK3ZhbCk7DQo+DQo+IGlzIGl0IHBvc3NpYmxlIG5v
dCBoYXZlIHRvIGRvIHRoaXMgY2hlY2sgZm9yIE5VTEwgYW5kIHJlYXNzaWdubWVudA0KPiBldmVy
eXdoZXJlPw0KPg0KDQpJbiBmYWN0LCBXZm9ybWF0LW92ZXJmbG93IHdhcm5pbmcgb25seSBvY2N1
cnMgZHVyaW5nIHRoZSBjb21waWxhdGlvbiBvZg0KdGhlIHR3byBmaWxlcyB1dGlsL3Nlc3Npb24u
YyBhbmQgYnVpbHRpbi1zY3JpcHQuYy4NCg0KdXRpbC9zY3JpcHRpbmctZW5naW5lcy90cmFjZS1l
dmVudC1weXRob24uYyBjYW4gYmUgY29tcGlsZWQuIEluIG9yZGVyIHRvDQpwcmV2ZW50IHVuZXhw
ZWN0ZWQgZXhjZXB0aW9ucywgSSBjaGFuZ2VkIGl0IGluIHRoZSBzYW1lIHdheS4NCg0KVG8gYmUg
aG9uZXN0LCBJIGRpZCBub3QgZnVsbHkgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQuIERvIHlvdSBt
ZWFuIHRvDQphZG9wdCBvdGhlciB3YXlzIHRvIHNvbHZlIHRoaXMgaXNzdWU/IENvdWxkIHlvdSBn
aXZlIG1lIG1vcmUgdGlwcz8NCg0KSW4gYWRkaXRpb24sIG90aGVyIGNvbW1lbnRzIGFyZSBvZiBn
cmVhdCBoZWxwIHRvIG1lLCB0aGFuayB5b3UuDQoNCkppYW5saW4NCg0KPiA+ICAgfQ0KPiA+DQo+
ID4gICByZXR1cm4gcHJpbnRlZDsNCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL3Nj
cmlwdGluZy1lbmdpbmVzL3RyYWNlLWV2ZW50LXB5dGhvbi5jDQo+ID4gYi90b29scy9wZXJmL3V0
aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMNCj4gPiBpbmRleCBjODNj
MmM2NTY0ZTAuLmUxMjIyY2M2YTY5OSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJmL3V0aWwv
c2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMNCj4gPiArKysgYi90b29scy9w
ZXJmL3V0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMNCj4gPiBAQCAt
NjkxLDYgKzY5MSw3IEBAIHN0YXRpYyBpbnQgcmVnc19tYXAoc3RydWN0IHJlZ3NfZHVtcCAqcmVn
cywNCj4gdWludDY0X3QgbWFzaywgY2hhciAqYmYsIGludCBzaXplKQ0KPiA+ICAgew0KPiA+ICAg
dW5zaWduZWQgaW50IGkgPSAwLCByOw0KPiA+ICAgaW50IHByaW50ZWQgPSAwOw0KPiA+ICtjb25z
dCBjaGFyICpyZWdfbmFtZTsNCj4gPg0KPiA+ICAgYmZbMF0gPSAwOw0KPiA+DQo+ID4gQEAgLTcw
MCw5ICs3MDEsMTAgQEAgc3RhdGljIGludCByZWdzX21hcChzdHJ1Y3QgcmVnc19kdW1wICpyZWdz
LA0KPiB1aW50NjRfdCBtYXNrLCBjaGFyICpiZiwgaW50IHNpemUpDQo+ID4gICBmb3JfZWFjaF9z
ZXRfYml0KHIsICh1bnNpZ25lZCBsb25nICopICZtYXNrLCBzaXplb2YobWFzaykgKiA4KSB7DQo+
DQo+IGEgZ29vZCBwcmFjdGljZSBpcyB0byBsaW1pdCBzY29wZSBvZiB2YXJpYWJsZXMgYXMgbXVj
aCBhcyBwb3NzaWJsZSwgc28NCj4gcmVnX25hbWUgY291bGQgYmUgZGVjbGFyZWQgaGVyZQ0KPg0K
PiA+ICAgdTY0IHZhbCA9IHJlZ3MtPnJlZ3NbaSsrXTsNCj4gPg0KPiA+ICtyZWdfbmFtZSA9IHBl
cmZfcmVnX25hbWUocik7DQo+ID4gICBwcmludGVkICs9IHNjbnByaW50ZihiZiArIHByaW50ZWQs
IHNpemUgLSBwcmludGVkLA0KPiA+ICAgICAgICAiJTVzOjB4JSIgUFJJeDY0ICIgIiwNCj4gPiAt
ICAgICBwZXJmX3JlZ19uYW1lKHIpLCB2YWwpOw0KPiA+ICsgICAgIHJlZ19uYW1lID86ICJVbmtu
b3duIiwgdmFsKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgcmV0dXJuIHByaW50ZWQ7DQo+ID4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9zZXNzaW9uLmMgYi90b29scy9wZXJmL3V0aWwvc2Vz
c2lvbi5jDQo+ID4gaW5kZXggMjVhZGJjY2UwMjgxLi4xMDU4ZDg0ODdlOTggMTAwNjQ0DQo+ID4g
LS0tIGEvdG9vbHMvcGVyZi91dGlsL3Nlc3Npb24uYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdXRp
bC9zZXNzaW9uLmMNCj4gPiBAQCAtMTEzNSwxMiArMTEzNSwxMyBAQCBzdGF0aWMgdm9pZCBicmFu
Y2hfc3RhY2tfX3ByaW50ZihzdHJ1Y3QNCj4gcGVyZl9zYW1wbGUgKnNhbXBsZSwgYm9vbCBjYWxs
c3RhY2spDQo+ID4gICBzdGF0aWMgdm9pZCByZWdzX2R1bXBfX3ByaW50Zih1NjQgbWFzaywgdTY0
ICpyZWdzKQ0KPiA+ICAgew0KPiA+ICAgdW5zaWduZWQgcmlkLCBpID0gMDsNCj4gPiArY29uc3Qg
Y2hhciAqcmVnX25hbWU7DQo+ID4NCj4gPiAgIGZvcl9lYWNoX3NldF9iaXQocmlkLCAodW5zaWdu
ZWQgbG9uZyAqKSAmbWFzaywgc2l6ZW9mKG1hc2spICogOCkgew0KPiA+ICAgdTY0IHZhbCA9IHJl
Z3NbaSsrXTsNCj4gPiAtDQo+ID4gK3JlZ19uYW1lID0gcGVyZl9yZWdfbmFtZShyaWQpOw0KPiA+
ICAgcHJpbnRmKCIuLi4uICUtNXMgMHglMDE2IiBQUkl4NjQgIlxuIiwNCj4gPiAtICAgICAgIHBl
cmZfcmVnX25hbWUocmlkKSwgdmFsKTsNCj4gPiArICAgICAgIHJlZ19uYW1lID86ICJVbmtub3du
IiwgdmFsKTsNCj4NCj4gc3VwZXIgbml0OiBpdCdzICJ1bmtub3duIiBpbiB1dGlsL3BlcmZfcmVn
cy5oOjpwZXJmX3JlZ19uYW1lKCksIHNvIG5pY2UgdG8gYmUNCj4gY29uc2lzdGVudA0KPg0KPg0K
PiA+ICAgfQ0KPiA+ICAgfQ0KPiA+DQo+ID4NCj4NCj4gdGhhbmtzLA0KPiBKb2huDQpJTVBPUlRB
TlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRz
IGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUg
bm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVy
c29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1h
dGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
