Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95B43EDC54
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhHPRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:23:23 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:6016
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229699AbhHPRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnnMGITjcW6Yno/3VYpLFTJvvr8DG9J7kQcKhJRGst8=;
 b=FrH7XHzGh6R7GnhA/7HmhkFukrKXVKqAWNf4oMXKwvHGkWHkA2NwgMGA9KwMYCokoBh/zHQ0Qjs+sylsASJ4QKwg2D2iv2EEo5LuEsqv7wrcsqt51oy1SD3YravEh2uOphh8HSsBwQauC5wBuyiuX0IgwEXW1/dmgWznW8S44eM=
Received: from AS8PR04CA0157.eurprd04.prod.outlook.com (2603:10a6:20b:331::12)
 by AM6PR08MB4915.eurprd08.prod.outlook.com (2603:10a6:20b:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 17:22:47 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::3e) by AS8PR04CA0157.outlook.office365.com
 (2603:10a6:20b:331::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Mon, 16 Aug 2021 17:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 17:22:46 +0000
Received: ("Tessian outbound f11f34576ce3:v103"); Mon, 16 Aug 2021 17:22:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 23abc8500c08bda8
X-CR-MTA-TID: 64aa7808
Received: from a7581e1029a6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 21F68594-46D9-4D07-A4F2-8C4565214D47.1;
        Mon, 16 Aug 2021 17:22:34 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a7581e1029a6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 16 Aug 2021 17:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSS8zxz4IU01brGsa/hEksaRk7S3a/cPU1tuIsb1DNXqj1ix/lzcp1b72pB/ZS2kUb1peUKGxsnWdg7UfIIWS/rDXrMu6IGsHBn7IcIGTbYQxorSDYyauavnoNNu1z9v/ployHus+H7i78IKgk9awaaZLpJTbTWt3lLuyICbM7ndFyg8CTu2mFxQvyi/VQgLf0mUH3cdTc9T22Tuvi4KWPTg45dhqf3W5DBfU/5JjsCZLRUfaCnPbHASvl5pmzwCK+vEFUomy2I1mcx9ocqv6MXAL9kiUpf/a3hQcPwSMsQrIVJn4GUh4ul0LGZNPiEGb5TbHPiRT/iF3WZVseYDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnnMGITjcW6Yno/3VYpLFTJvvr8DG9J7kQcKhJRGst8=;
 b=B9khDrBgBZkLCXlwwP3imQABXAgfDRv/+JDGS32rfk7TWQuXdr3f9HVwq376WS9OdyCGh++u+fOcMSP5mpIn3j47cqmvw+qRiZ3/B2dVAFEvV1z+ehOEthbE+hb1InGQFakGhoeA/KAtdaYNmPc5MyCmU/haZS76HSG+9WtZ6ufUO1kAKuto+KXVfvVzu1Z5cENA8TYMLPA+eOV2c8VeueXvybOYgfS41lR4pDGcOlQcL2esxeBjgxX8Le0nGJIwno0oss9M4rWl2hnxLmmO6YIk27dWOGcJsAQ+ubKTHtGPVwg199ZukcXArdo/VfcnXg55N7F6Vx8zBHstRGpK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnnMGITjcW6Yno/3VYpLFTJvvr8DG9J7kQcKhJRGst8=;
 b=FrH7XHzGh6R7GnhA/7HmhkFukrKXVKqAWNf4oMXKwvHGkWHkA2NwgMGA9KwMYCokoBh/zHQ0Qjs+sylsASJ4QKwg2D2iv2EEo5LuEsqv7wrcsqt51oy1SD3YravEh2uOphh8HSsBwQauC5wBuyiuX0IgwEXW1/dmgWznW8S44eM=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB7140.eurprd08.prod.outlook.com (2603:10a6:102:208::10)
 by PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 17:22:32 +0000
Received: from PAXPR08MB7140.eurprd08.prod.outlook.com
 ([fe80::41e8:4ac2:ca38:997a]) by PAXPR08MB7140.eurprd08.prod.outlook.com
 ([fe80::41e8:4ac2:ca38:997a%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 17:22:32 +0000
Date:   Mon, 16 Aug 2021 19:22:28 +0200
From:   =?iso-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     gregkh@linuxfoundation.org, surenb@google.com, hridya@google.com,
        john.reitan@arm.com, mark.underwood@arm.com,
        gary.sweet@broadcom.com, stephen.mansfield@imgtec.com,
        mbalci@quicinc.com, mkrom@qti.qualcomm.com,
        kernel-team@android.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] tracing/gpu: Add gpu_mem_imported tracepoint
Message-ID: <20210816172228.GA9015@e123356-lin.trondheim.arm.com>
References: <20210726164135.1745059-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210726164135.1745059-1-kaleshsingh@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LNXP265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::14) To PAXPR08MB7140.eurprd08.prod.outlook.com
 (2603:10a6:102:208::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e123356-lin.trondheim.arm.com (217.140.106.39) by LNXP265CA0026.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 17:22:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b2ea55-24f5-4a89-1c84-08d960da770e
X-MS-TrafficTypeDiagnostic: PAXPR08MB7247:|AM6PR08MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4915CF17D58895D7655DD8FF90FD9@AM6PR08MB4915.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r2/r4ton2MhMuZDdxuvwViT2iKGvmZfj1jweXnyD1A+3Suqy9dmpbLa0D+AB06DRtAQJQJ5wHTA7mqAjOyznFeq555iorSxofO1pcZBsXkdDi7aMiIYVD8sYyT2UkTnuRaLjunD/U/qRCtm+cbRfe1cy+xTVxT3qna2yUGrCJQm+ODT42JCRIu/1TPbJdlZIQHKza7VUivxZAlxQcPnx5TvhF4kZbjTQT4X3y4Bf0blNtfkgBbefSAtSv+SpgXqv9u7nnCk5NukN4Yu+otI+/yXZMsbxKqSkkvNPldeKoaSHlB/Fh6LG460TbcYerNDl9/YIg1aGN0ZWtMjzR0rP+/R8CB+Ows4vhFRwct9JQoXJW69uOullBq++5YLrisuGqH41fCeEIJZhwebVoeN9s4FyUgHYcNTZBMPfD9yOkI68B1gleSI30vENySPYfHRKkktlw2m4R+i9jeQ343vtUoGiVNnt1pjHj9DaLkt8/GBiJLnt4CATn0fUBVyIeW2TTVgBWzfD1z0exriKJjwEVjilYj7F+m33Qqfrmx9L2XNRABrzNTnJYyqQzQMMA5jndMdHNiGT5IKspff/l3fX8THd1ikYyFvILbMhHlx3P5fN3ri7Et1+n+84Oa8/BiYubudr1FzYc7/sCNQSJP9Q/YUqPofeRFIOqwaAlFJEWJcMGu83AU/4HTZ0eAJqwdxyuuyVlQFBsxJVwoEIcpDqYy/cySwPZI2iOJDfRIeRrykwVWBBUO1CXg/79MSPEh7D8yTOaC7uOo4aURixyvCIWmkBR7ood5AnFHXKrMVKSnE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(83380400001)(478600001)(7416002)(33656002)(26005)(55016002)(316002)(5660300002)(186003)(956004)(86362001)(8936002)(66946007)(38100700002)(38350700002)(966005)(7696005)(52116002)(1076003)(8676002)(2906002)(66556008)(66476007)(54906003)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajVJbXlwMnpGVU9HZzFJemtnTGtjTXZBcysvSHhUVnk5Mk4wUVJaVmt5TkZJ?=
 =?utf-8?B?YWE5MWFQbEV3aXBudTc0b0IvalNIUmUyUUp6S2E0VEJOblFCRnJraE5PSVlS?=
 =?utf-8?B?RmVOSGtPTVZhNWNzWmxFTVRiOUQvN0laUFlJUEhIaWk1YWFUV0FtRXlTZFh6?=
 =?utf-8?B?c2VDQURsc3lpT0M4T1JJSEpoakRMZTR3OE40SEhCRkVqUTdmY0tIYmVtUnQ5?=
 =?utf-8?B?ZGtOdUtyU1RxS3Q2Z2xaNGw4ejhqMTFMdURXb1gzN1lscGhxS21JRlpyUnJY?=
 =?utf-8?B?LzM3Y0hyN05FdXROejhTRktWaGRZYjdSdlRDQTRhZkQ2bHk5b1NTTUt0Wk56?=
 =?utf-8?B?OFk4cFVsMVBRN2VpeUg4amhuZFVzb0duOW9JWnB5MEM5TFFDQlcwcWhQK2JL?=
 =?utf-8?B?R2lMdWhXOHFwZis1YlV4SW9pelZ0R0dHRjlJOURWS1MzcGVHY2ovcFEwSE9Y?=
 =?utf-8?B?dHJWWFpTeG9tc25sRFpsNGRTbmVqQnVlNk1QMUhQUVpJRk13SEs5SVRsSTE5?=
 =?utf-8?B?UzNQNjVqVW9BTUxCU0J2TUd3UmZ2V3E2eHo1WmtjOVg4V0hMZmJjcFk0dUtu?=
 =?utf-8?B?MGR3bTZENVJObkY2UzBhM1QzV2tOQmh4a3FRNGs2NVRzSWMrNHVvY1NxRzls?=
 =?utf-8?B?WFJvSDVtOEJKaldTM2VxdlNRY044aGkyaHdHYUR3MGNXOUdSZ284Z3RSQ0hI?=
 =?utf-8?B?SjMyRU5HOG9VYVVxajBrSytsMWFiVERHVG83QW93RjhBM3VOMzMyRXJZZkhP?=
 =?utf-8?B?V3lmWENMamNiVUxFTEZhNlRCUWZUTWF3MzhVR2ZJcU5rb2lhZHRVVlU2Qis2?=
 =?utf-8?B?ZlMwWVIycHUwbEVxOWF0WHBXRW5ZRHhLRzVuaW0xOWx2OTU3Y1FwdDJkWDJ3?=
 =?utf-8?B?UUdjWFdzbm9RTjdEcGZEVlkwL1BpQ1pMdTkvR0xxVEhJWGYrUllVWVlXckhM?=
 =?utf-8?B?K1NUWTEzaVFjNHBNTmRxb1Ywckt0d1dTVzZoV2ZPZE9FdWZNWEZtUzlqRDky?=
 =?utf-8?B?ZDVpWVhwMUh6RXBHeTltZitwRFVKOWt6anpKalExK0UyOW0xNjljc2d1am5G?=
 =?utf-8?B?SDkwRHdWUmxjbVQ4Tzh6R1NFeVNvVGFvdDdnYU5HRXdhMUdEOUpEbHc2bFNI?=
 =?utf-8?B?TGpERGNGNU9hRjF5blVaN25pNFZmYXJnSHNVN3QxTFNCNlRaMllOY0FvT0NO?=
 =?utf-8?B?eFVIVWNYMWQ4YU9nYU05dEE5dzNwMHl1M1BjcFBwd2YyRlo2dzNZKzF5Mkt5?=
 =?utf-8?B?Mk5YM1NkTjRROE9kcmtSdVFvakxGVThJM0xHOTlIajhMTjJRNU4rczVERzFH?=
 =?utf-8?B?RFU2TjR2bUxQZHdJS3FVZ3haRDVDOUloSEJnZFRpQUNKcTRYeVJsVjAxNWUr?=
 =?utf-8?B?ZFB0OXVuT2xWVW1GNnJnbDMvbTBMeWdGbTZJVUFuOUFIWk1iT0xGRmZIaElN?=
 =?utf-8?B?eWRHZk1mSzJZNXh5M3p1Q01pZTliOHh0VkJDNXAzdE45S2F4aVlMbVBzLzNO?=
 =?utf-8?B?ZHZmdTk5dDRjbHc2bEJaeUtmbVJ4RkkwenlIT0h0RDdwOXI5UktGbW52MUpR?=
 =?utf-8?B?T2hHVXFsS1lmRCtVR05qaDY3QmxRTFFtYTBHSHpDd1JxRG4vbjNvQ2dORC8z?=
 =?utf-8?B?dTY0eHlyQnkrTjYwTktTeCtCeDdpQ3A4cjBScGY1dk5RSjAxZ1dOenE1MVd5?=
 =?utf-8?B?T3pETGl4MVVDQ0QyMnJ4UVZyRFErYWFjUThjN3hmUXlXVFVpeHNUYmxwN1p5?=
 =?utf-8?Q?Ne4xk16Eo1hamp7QJtKRLu11kQyYKClf89MkcOp?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7247
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7bfa94c4-cd18-4743-15df-08d960da6e28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svYBSevoXgDBW88yt4Tq75eW0m/E0oMDg8wF3DT3GjvwOKaHFuAQn6sJwHn65GfoQr8M9EsnCPKVxabvqzVMKiFjF0otuENDy3OBRK2JbSo6YX1c0DtUs6UldXyNioB7hZQnd98I82Ylol8+BN+B1Li9GfIagwOS60kO5G8x5GnP4KRG1/1noX5tTxgz+rHJzaMaRTDGX1m4G4yqNK26v3ZYZnSmg4U2VR0tTAmDdcZyB0EPxAuv1uvMA6HlH1gIvqCk5Aaiy3Sk2klU7EfH+T0uy7mr3jffw3o8CsRsDfWHLmUXu8zjisz/a4xi7h5HZCTnpAHTmOVCUWFcIuKlF1CDM8OlAczgl8fL0RNKvKcvPv4exK79E2AUF+nDEbMqHLT7fpIbidhvAy9wtfEGfix438RY8ZbAYoRpJFPLiCGd5/+l9vZvS3btgPtiTm+0BhSaxR/+jHeRVi9qeYYrR/AhBMqFI1ezUCi+ugPOsMMraRVD0Wma3L75+sv11cWDb6K23r3KohFeaLLmFB4m8EPJY1S6szNXFzlvsugwOnOmPRKX6oNM0gqc7/kNJOF6FfzDBiP/teFS2S8sOUn0hgDbFuAhWUrMyfebyGzwRln0kzAO5nUdjxsiq0CLLmK/uxKD2dhyY2DTUuyvT7C1qDjs++yzoZsbac4ZYrwmqt+oVh7PRmfKfzQJOjEI2LGsfwJaV0jhGtnGc8roe3L/vZantCtltSC7AZH4Kv2DYbnT8coKu2ioYZ3bCrtTRxf6ZAu0huaBr0yhdwO4k/rKbXZCbhPo2viEDi+C5szyB0Y=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(36840700001)(46966006)(8676002)(54906003)(33656002)(86362001)(186003)(956004)(336012)(82310400003)(7696005)(26005)(55016002)(8936002)(966005)(316002)(478600001)(82740400003)(4326008)(70586007)(70206006)(47076005)(2906002)(6862004)(5660300002)(83380400001)(36860700001)(356005)(81166007)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 17:22:46.5616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b2ea55-24f5-4a89-1c84-08d960da770e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4915
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 04:41:31PM +0000, Kalesh Singh wrote:
> The existing gpu_mem_total tracepoint allows GPU drivers a unifrom way
> to report the per-process and system-wide GPU memory usage. This
> tracepoint reports a single total of the GPU private allocations and the
> imported memory. [1]
> 
> To allow distinguishing GPU private vs imported memory, add
> gpu_mem_imported tracepoint.
>
> GPU drivers can use this tracepoint to report the per-process and global
> GPU-imported memory in a uniform way.

Right, as imported dma-buf memory is usually shared between two or more
processes it will be hard to reconcile system memory usage with process
private GPU memory and imported dma-buf memory in a single total sum. It
will be good to improve this and having a separate imported GPU memory
size is good.

> For backward compatility with already existing implementations of
> gpu_mem_total by various Android GPU drivers, this is proposed as a new
> tracepoint rather than additional args to gpu_mem_total.

Is this for compatibility with kernel GPU drivers only, or are there
user space users of the existing tracepoint that can't cope with it
being extended?

The eBPF used by Android to track the GPU memory is the only established
user of the tracepoint that I know about. Can existing versions of the
eBPF can handle this OK?

If the only worry is GPU kernel drivers then I think that extending the
existing tracepoint, to add a new field with the imported memory sum,
will be better. There doesn't appear to be any in-kernel GPU drivers
implementing this yet, and other GPU kernel drivers can just be extended
to use the new extended tracepoint. As long as there's some mechanism to
detect the extended variant of the tracepoint for backports, if the new
tracepoint is ever backported to older kernels, that shouldn't be a
problem.

-- 
Ørjan

> [1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com/
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  include/trace/events/gpu_mem.h | 51 ++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> index 26d871f96e94..b9543abf1461 100644
> --- a/include/trace/events/gpu_mem.h
> +++ b/include/trace/events/gpu_mem.h
> @@ -13,21 +13,7 @@
>  
>  #include <linux/tracepoint.h>
>  
> -/*
> - * The gpu_memory_total event indicates that there's an update to either the
> - * global or process total gpu memory counters.
> - *
> - * This event should be emitted whenever the kernel device driver allocates,
> - * frees, imports, unimports memory in the GPU addressable space.
> - *
> - * @gpu_id: This is the gpu id.
> - *
> - * @pid: Put 0 for global total, while positive pid for process total.
> - *
> - * @size: Size of the allocation in bytes.
> - *
> - */
> -TRACE_EVENT(gpu_mem_total,
> +DECLARE_EVENT_CLASS(gpu_mem_template,
>  
>  	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
>  
> @@ -51,6 +37,41 @@ TRACE_EVENT(gpu_mem_total,
>  		__entry->size)
>  );
>  
> +/*
> + * The gpu_memory_total event indicates that there's an update to either the
> + * global or process total gpu memory counters.
> + *
> + * This event should be emitted whenever the kernel device driver allocates,
> + * frees, imports, unimports memory in the GPU addressable space.
> + *
> + * @gpu_id: This is the gpu id.
> + *
> + * @pid: Put 0 for global total, while positive pid for process total.
> + *
> + * @size: Size of the allocation in bytes.
> + *
> + */
> +DEFINE_EVENT(gpu_mem_template, gpu_mem_total,
> +	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> +	TP_ARGS(gpu_id, pid, size));
> +
> +/*
> + * The gpu_mem_imported event indicates that there's an update to the
> + * global or process imported gpu memory counters.
> + *
> + * This event should be emitted whenever the kernel device driver imports
> + * or unimports memory (allocated externally) in the GPU addressable space.
> + *
> + * @gpu_id: This is the gpu id.
> + *
> + * @pid: Put 0 for global total, while positive pid for process total.
> + *
> + * @size: Size of the imported memory in bytes.
> + */
> +DEFINE_EVENT(gpu_mem_template, gpu_mem_imported,
> +	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> +	TP_ARGS(gpu_id, pid, size));
> +
>  #endif /* _TRACE_GPU_MEM_H */
>  
>  /* This part must be outside protection */
> 
> base-commit: ff1176468d368232b684f75e82563369208bc371
> -- 
> 2.32.0.432.gabb21c7263-goog
> 
