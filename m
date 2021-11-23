Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBB45A2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhKWMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:44:07 -0500
Received: from mail-am6eur05on2092.outbound.protection.outlook.com ([40.107.22.92]:53249
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233857AbhKWMoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:44:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afs5W6WVn3ro1vpMqCtus1NnNPyyZ872gCZIAbVq7qUl8tOEGzTxwqFRRXFNb1je5N5Yi5QgCCbVtZetWRynPBU90PcCCSlWsK4YvM6is0CwGehS2H0WLGe7TwOF0vr/jHzrD8eqSF/XLwh+fY/1JVOw4tk8+ckR7PNK92BMpmYiQAUs6cJUyK+gH1ymRy9e3NP8D4uRZzLFOyQmOoRNJbiug/YnI+GTui9r+URlwLDMpnrECHiwSqmVx4M3abzaFZH8PsKiNypgcF9YJ8MeSLLOJ/kKt4d6/ZmSrUbNiBsBH9SSaqB+GMMFSco/TvirHLc8b2W6Itvldmg67Dn8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPV748cHChyxG0iJAQGd+nVKD3wj7suMjF3RM8sVtS0=;
 b=VVXpeAwI3qExb324mB0jS2uwd8CSHR8DwbGVhQQ/cuG+kgotE03iHkGZzEw5bHsonXVThkHwz1JfpLvVJlnNAGwy+eCQok3jLYoMeDVUUzjcRZKaHXIZEE4RdTrSJT3fLZS1a0X0baVC9/GCKnPiBTWWdAd8vK/q5MW/wK+Y4PAF3cN9aDAqVlXj6g7b6llgiZYqV0hz43YU2zdhe7EbONgNTc8ADVDnJNhxdcqP3U5caSU0T9UjsxT0NkbFuLj9nvjMPRj222rBWwyR6Jc4Ods18Fdj3fUGxJsEAEYRcWQuf/KaYrrfiVcrKQ9dXjXbBGUIOoyY+IkwK8IM4q1N0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPV748cHChyxG0iJAQGd+nVKD3wj7suMjF3RM8sVtS0=;
 b=ZHRUoas/P0uAhBm2gIe/0EYs8tvW1Z72XZIcWXQrTHQBceXfHtTMfhIti4YAuz/X1vK7WuSm7xCddgLMWSoVOeBxNsQO4uHYWbbCEysGgo4+rckVUDOQ1r+vbLmNhYlo4DGlHgpKbpqTX43o8DH31i3Z1KqLIJZtVpKRKKI3uDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM4PR07MB3091.eurprd07.prod.outlook.com (2603:10a6:205:11::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.16; Tue, 23 Nov
 2021 12:40:49 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f%7]) with mapi id 15.20.4734.019; Tue, 23 Nov 2021
 12:40:49 +0000
Message-ID: <46f438c2-6f5f-645e-23b4-95216ec23ca3@nokia.com>
Date:   Tue, 23 Nov 2021 13:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <2bf37a35-1ccf-f4fa-c999-42b9154a2914@nokia.com>
 <88db136a146edf53801d86509b52d40f@walle.cc>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <88db136a146edf53801d86509b52d40f@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:7:67::24) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (131.228.32.167) by HE1PR07CA0014.eurprd07.prod.outlook.com (2603:10a6:7:67::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Tue, 23 Nov 2021 12:40:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f8fe5b-3b60-4318-bdc5-08d9ae7e7a4d
X-MS-TrafficTypeDiagnostic: AM4PR07MB3091:
X-Microsoft-Antispam-PRVS: <AM4PR07MB309187CDA9CC0810C15865E288609@AM4PR07MB3091.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4gMTUEbuJehYD7koCjdQ2KN4/8rNcSQ7hSLxwkliHpVE6riyHos4yQzk8Qtr8qRVrYAkWSrE9SfyK9m0wKwnyzKGA6q7fTlMw4SYoVKtHX4ULHHtNMlyJOfgIZ/7xOXth3AnapbMJ4HTi+4FwG4CdcitGW5AIuiSzt+8a1OSbMDfNB1wf52R/+1YNNEASNTBXYY0ePmqoF/xG4gbALaFp/bCZrmKr8Y2K3iTdrhGoGX7nb7lw2ss/fNDD2VwSM+KaLPWkNNyPA9h6yyi3cVQpsnn9xrToOOewx+u+4C6oLr0wPww8di2L9QeEY/GcxW+mLWIQdTmnLNBVOZLspAIwEZ6DCF44HhdKHmotDS+rTDHpkiC4p47VEh1EmQGhY2XD4UAkFYyZ62e0Jp11mg8l+wZ7GF9CJVuYUu3ETqVLwclTG6KpJGQlMIECRYSi6m8SJMvOxCLjAoAbaYM0VY0I9Ss7mnCB5y42c5blTv/tvXvhIgof4VzTLUISaK6xK3YqzqJdYRpTxW1hMWWQCu2F6HX7jXOkQbpQi4kfaH6NWVWoo5dmUR1mll84nWTJymJLZJUofrbffn6n+fonwXpa1FnAL+33So3Ow+hE5NqVVBYhzHQ6cST38NHu0n0TSqMW3wktr2YZct06jCd2yiym4v4ZtvqI1hQK1UJmnlpkoE/ej6Dp5w1w8QUer1hG1cou//GV15LK5yLYS4yfOX/3+gVF8ydL2zBM5LF6L/FzqneYUTklvUe/HrLvbFgV8Gd0JFRhmCLzy9In0jP/qJGnS6Pz3aKjWxkWL8WazLlJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(956004)(52116002)(31686004)(38100700002)(66556008)(186003)(2906002)(82960400001)(5660300002)(83380400001)(66476007)(53546011)(508600001)(66946007)(36756003)(86362001)(38350700002)(2616005)(8676002)(6486002)(6666004)(8936002)(316002)(4326008)(16576012)(26005)(6916009)(44832011)(6706004)(54906003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW03dmREcWJGNmd0Q04rNlQ3d1hRcm5pVHM1SzRzUDk5bUNobGF5ekgxVDA2?=
 =?utf-8?B?dDJnM1owZkpLK1RoeHdpRnMwWmplMXM4c1Q2NkNoQnMvMVE5Yk81VEkyOU5R?=
 =?utf-8?B?U2xlVVI2a2VMMk9vTnh2RFplWGxPQURURjhZRGlTdlpXajA4NlhGR2ZtNEhB?=
 =?utf-8?B?SmxsWmVieXdXSElTOTNuQklaV3J3Um1QQzN4OTlVRllUMVZDSFFwakcrUjVl?=
 =?utf-8?B?YVhOaW5YMzFjRVI4bWRHcFJlMXc0R3IvMUtJZjZFTWpYSW5HNzlWSzVtV1Fr?=
 =?utf-8?B?T1BMT0ZCaXVUUHN5a1VBeUhLR3BGOGVYMk5RMHhHSVkwclNpWmdLQkw1SzJn?=
 =?utf-8?B?Q1g1Q1MwaS9kWHRNUUd3M21OZ3dUSUVYTThGclZGem1zTHpFSDQ0NzhmeUEz?=
 =?utf-8?B?VmlYdFpoaVpKNVM4RVY0VllYR0NkUGZNZHdqUVNCTVpxTzV3VUNQdVJ0N0Jz?=
 =?utf-8?B?N0tKSE9HVE9RTUVPSU9PeDFRK2ZUd2lLY3N3T3JGalhsSkdKc1J4VGEwbDhY?=
 =?utf-8?B?WlRjQU01Q0ZWSml1b1MzL2NyQUkzbnVpQ01vOEo0RERkYS95WitWR1ByaFlw?=
 =?utf-8?B?dWxpQllVVHhMNHVWUXZ6Rm9aTU8rc2lhMitFMm9SdXRaMTFuMis3WFJxNGlD?=
 =?utf-8?B?bG5zN3hzZGNuMXZsc3dnQlJnazhwbWN2VWJJNUFFMUFzR1VYSkJGRzZjaWpJ?=
 =?utf-8?B?NkdIRXppa0dCeVJhTTRSV3dDQU5TSTM5aHFPTGlmTU9hYzM1c0szY1JMM0NZ?=
 =?utf-8?B?WDhOWVlEd2tBL2FLU1VUUkgrVXN5dWFEY0FNb082SnlnU3RvamtTMUFkQkFY?=
 =?utf-8?B?TG15SHhNSUVnNnhkTXFyWUY4R1NDYWJ0aHlwbVZEZjIrZnhMRXJwTFpPOFEz?=
 =?utf-8?B?bjg2cU5vTFRHd1dEdUsxTVg2NTJnbHVVdFJlcVhVNTArZXdIcys5a0VneTFm?=
 =?utf-8?B?VWZuMHArWHErU3JyTXJJK0ZUc3E5dXlzTmRPRHZiOTFzMTI3TGU1eHdRTFVT?=
 =?utf-8?B?VGZSSDl0TlkrQWR3akdMTEMzK3ByT0Y1ZjlRNUxpM1FrT2xaMHJJUUlDL2Zl?=
 =?utf-8?B?QXdMVUcxQ2l1eTk3QnNkRkdkRFVickxPZWh5WG9SS2M5dDBxTUxYbTJxZzB2?=
 =?utf-8?B?SUNHOWZYZWZWZGNFRjh2Tm4zRVBLU0V4UDBTeDNEVjI2Q2llZWlVN1dUYTRX?=
 =?utf-8?B?SnB6M0UvaFpPc0huNjJVNWgwcG5WSkMvVTlHdnN6WmRmK0FEZ1h1bTliM2lK?=
 =?utf-8?B?elVETXZtTUFoTzJtUjBiUzByRGw0cTZjUHIxcWM3dW0yZ2Y2Q25CSlVjOERo?=
 =?utf-8?B?SUdTYTZZY3ZBQTBvcHR2T2JDbEtXaUdjVnZNZUZnVy9OMUZTVmE3bnVRSEZo?=
 =?utf-8?B?eldNaHFlczFkS0QybHYzRnN3UVJrR0FUVWZnUmxhRTJEbjBEemcyQ2lhYW9k?=
 =?utf-8?B?YUU3aUl6TGZWRXZ4Szg2dGorNzViNEs1bTd3RzAxaG5jWVpsSVJ4Mzd6RHZJ?=
 =?utf-8?B?TUVaMnRlaElDZE5zM3luUWdtQ2NhR2c4VmNabjZpZk5aYU15NTFsNnlHUnZL?=
 =?utf-8?B?eWNnQUx4SlRpajRBUU1UTWhLb1BOQTQ4NDIwWkpydDFwZ09EWWN6RVRGWGxS?=
 =?utf-8?B?aDVuWmJ4eWFubEVnUE5HUk43aE90b2JqU3pNQ1ZNVWxLMUxLeVpTMXoyOHhh?=
 =?utf-8?B?ZnJKdjU3dlpjcFRZb2lmWEZpd0NDMG9jYTNxTldFbm91aTNUWmlWZzJvMHZJ?=
 =?utf-8?B?Y3psd3I5d0dTWHM2VlhoaVlvYkxEUHJ3dHhscXJxQ0tMdkJySmlUZkt3WmZL?=
 =?utf-8?B?VnZpK0pabEVCd1ArcGk0eE1DZmxTVVdpNGw0dE01THhBckErTzAxbGkrdTJV?=
 =?utf-8?B?T0RzazlhNFNZc0FxREhRN1R4aVRkclJKVW8wNG8xUXgrR25QZHprSlQwaDQz?=
 =?utf-8?B?YTlrKysxN2FBN2hIdHFwRXQzcWt1aFJWV0FWUXhublZLWitycHljZlpOSk5V?=
 =?utf-8?B?d1pYVTNyYTBCMy91OU9Oejh3eXlzb1FtWTFmRDgxdmdieFVua2hrUmtDdlRE?=
 =?utf-8?B?TitIbVpXT0tENnJJL3BER3BmbmlFUnpSTlU1elY3WXJrSUovTEcrMEVmMDN0?=
 =?utf-8?B?YkhMdnh0ekcwV05nOEZ2am40S2JoTG1EcmxwV2k5UjV4UHVLK2hZbFE4TlVY?=
 =?utf-8?B?Z3JSVEtVM1Y0L0xLV1JZUGRkdDBpbW4xam5HeTBXL1gzRmFpU0dtSTByNUVy?=
 =?utf-8?Q?I0AcAmEG5Wrkoia/ubptij2sKzrJ4ZU5aGUke6FLGI=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f8fe5b-3b60-4318-bdc5-08d9ae7e7a4d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:40:49.2652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNz2hTkEtCjGI828P1UHYCm1ml9c9MrkjxklGi6g0OLFfV5Jwto/5FoHtskijpumu1eFYtSPCn7WBw6krlDKlF/gY+SKr0wcTL4FGtMXYvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 23/11/2021 09:14, Michael Walle wrote:
>>
>> Some people ask themselves why this table keeps growing if there is SFDP...
>> I see the point in fixups, but maybe at some point we will be able to support
>> some devices just out of the box?
> 
> Are these features detectable by SFDP? Without knowing anything, as you ignored
> my former question, I'd say no.

Well, I just had nothing to say on your question.
It wasn't my intention to study security features of a chip, which I don't use.
There is a background which I didn't tell you, which might even emphasize the
importance of security version support even without security features:
Micron might want to "streamline" the product palette and as security version
is backwards compatible (except 6th byte, which is not an ID, actually), a
buyer can get security version instead of normal one.

And the reason for the above is, mainly, because there are real problems with
this chip, even without new features, sector erase doesn't work properly
(refer to my other email in this thread).

-- 
Best regards,
Alexander Sverdlin.
