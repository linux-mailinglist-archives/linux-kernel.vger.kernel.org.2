Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC840D020
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhIOXZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:25:27 -0400
Received: from mail-dm6nam08on2087.outbound.protection.outlook.com ([40.107.102.87]:53792
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229769AbhIOXZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+9uXrIPtLfxdJ/yGn3f6yL9vQU3xeL8VdoCOWlAyRFGRQxoAAiERCuPtYa2AUDUo0HGnc10qK8XLMKstwtRdiTLNI6HM9rBsjiXdlFtRm0UkRGmQGSDlbXd1QqAB9/glruNODxIvuD2nLvMNm3mCE7YC6bIDGTCOI5S0mKyuPiGn/xwAVp8kcUtkH+jPOnDjH2G9S5xpJ0L/ga+uA3GtlJPOfLE7faFP0VJ+dwPCBW/QHWeS4gcgP+2/MoLpkbno5Vpy2r7zvcZKezHSa2XbZ1S0v1L28sS87NcFherJtUbz0ABmKJ1B6TuHAP73pO6sxgQVSUkUaCQ4/GBteJpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jHpWLPnMxUwlsj1ohg5udpDk2G9+VNFxPaPwZg44abo=;
 b=ABeRAy3KoNBgFkPggbpaAcS805pxTsr6PX//sWEh0BKq02TJTDF81UKCBh5W99uONiQ2lvCPeNYi/tWUEym6pSvAnC2F9ccb2z0Mhlt/YqhC6kSV/01M/2tPW6q4C1s0RVEuJ/n4I/zw4dumSNXzG+R901eQBHyvxTSJnIHhgGt5RQcksmh1S0savbnKD5VkWZRyhUQ0UEM1f+H4d+M/wlfJX6JaYfli2ViPx2iaeXADM5aDfVCyQATUxqwW1kvtIrAm1K8wqJiJzohP03Fesmbnj1g54bAcTLBF1hSYUxGc61CLFIo0ImZsOdu9+XNnHmzTXb0FfQXygPgCFP1Cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHpWLPnMxUwlsj1ohg5udpDk2G9+VNFxPaPwZg44abo=;
 b=o4JrdQARdRJet1vUcW5Rj6ZRGB3AfGtm+92Rzd9/07IWHEMV3YIgCBYtVqoKFs0oHANa5rsDW31XPreKXf9opn7NG1nOW93mlbjdAZxM6mLNV6I3o1qJwQanA5gdhOTtKcp3P9o4+YS8dSWZCAkWFQIZp47sYp8Wpf6L/dIIMCk=
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 23:24:05 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9%5]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 23:24:05 +0000
Subject: Re: [3/4] drm/amd/display: Fix rest of pass-by-value structs in DML
To:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, nathan@kernel.org, linux@roeck-us.net,
        llvm@lists.linux.dev
References: <20210909010023.29110-4-harry.wentland@amd.com>
From:   Anson Jacob <Anson.Jacob@amd.com>
Message-ID: <9404bcb9-a7b9-4b65-5665-181639012828@amd.com>
Date:   Wed, 15 Sep 2021 19:24:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909010023.29110-4-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::19) To DM4PR12MB5072.namprd12.prod.outlook.com
 (2603:10b6:5:38b::22)
MIME-Version: 1.0
Received: from [192.168.2.12] (142.118.127.251) by YQBPR0101CA0199.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:67::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ec8e38-40ba-4008-5965-08d9789fe8df
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54299547BC8FE01D25A5892EEBDB9@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLdGAfw0ciCktP5StSeNZgosaOFx4qSKXq1NWZYrGJC34MmY6QaZTz6M/+lS4fv9wjGKLztyhdcccE6kYqSKb44gPEeuM7tWhBPQ0tUEqjTCMokY8u4xz1auL6c1wO3ID0kyQOFkZiq/IYIovo95JZLsgXyIRQmvPOOvf6q1T1AmjKTy9wgbe2W5CMrJqKOwtAc3HSkvAnYRSzXuw7+I+7GP2p+r2TaINrFg7aX2CZUaicCyezeK8ub4YG1AvZ7KoJrmmGiC6VuswDRcy+8veB4uvndoY10nWmSMQp0Id6FKtIML3S2d+R1QEcEzooCqi08MWkrOdUetVlgiomehM4VXIUd+4BzAB1/iVGHENYuuDfYTWB6MtsFV9Ezd0ERyCfFKfjEcCXgi5AbOy7VGB7v6Ycf/fNH69kVl59itSPamJqmqGOsBRWfymHfodzi4X7GmwX5NaLqxJ1XN3pDv3PB+PRtVxg+uqPTVK9Y6KHRFp/3ErQrpPbPb5uZq+hljgtpZDkUQYHKKKl8AgUCC699fKV3Yk8bybYqEwTU5dC9UcJXmjJdy55TzA7iJTD0lPjbCwMBt891va5Uxtm9PMbINbsk7u++hfsdeJPTSa+/Ir4jMG4EGjRPZTgAIxA0sYj5v6uwSsh3bruQx5dcgPTOtB89icVrRWr59yYr5odPzDRhVkv/nFPFICgdOzEOBMTX0dNPTsIn3acqOd70KC6s6HYHChYbptmD3XzqFYCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5072.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(66476007)(66946007)(2906002)(66556008)(36756003)(316002)(956004)(2616005)(186003)(4744005)(16576012)(86362001)(478600001)(38100700002)(5660300002)(31686004)(26005)(31696002)(4326008)(8676002)(6486002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elpyYkFpQjRnMXlUOWZuSTE2TUYzRloxQWJINmpRTWt5VkVOTVo5UkFkcU5E?=
 =?utf-8?B?SmFQV2hkUlltV0x1R1FIMDZjUVFoSjJjdkNuNW5LaGVtQksrUFB6b0tqMzUr?=
 =?utf-8?B?LzJPNGdDNkowSXc4cGs1WXRCNnhZMEFrRWFjTXZ4ejZGV0tkd0h1Q3N6R21v?=
 =?utf-8?B?T0JRQ0p2NzJ3SExaZFcwMUF3V0o2emU4VlFBb04rSHEvbkpsaUk5OFpvN2lJ?=
 =?utf-8?B?dWluSUdnV3JXQ3R1all3RXhpSEdyWUxYWDcweXdNVmM2ejZCQW1YM3ZETFZk?=
 =?utf-8?B?bWxXYVRZNWJ5NjZUbHdZMUZXbFMvWi9XV1JBaE54ZUJvdWt5VHZmaTI4RUZj?=
 =?utf-8?B?aDN5TFZ2SlNJa0xFNTNvNXpGZnZaN283TUgvMlZlSnJvSTNqZUtHdVNKYjkv?=
 =?utf-8?B?QmViazByczVSZ245Y2VzM0tQZ2FkbEI4ejZBRnZHTitzb2U3WFpiZzNkNTNv?=
 =?utf-8?B?ZTNweFpmNHdIcStMaG5CUUJpaTJIR2wxU0NWcldhNmlxYlh3YThZUVFmZWR4?=
 =?utf-8?B?OUlmS2ZOR1R3KzlDRm5Nc1g0RVJKRUtMbHFDakx4M013Vm1vSlVMWUUxajNW?=
 =?utf-8?B?MFVlQ0tRSnIwczRybkRnZldLUUtrdlJjR3BUdnEvWUFQS05RUW81aFg0S3Vq?=
 =?utf-8?B?WllFbmsvS2lOQVVRSFMyYVcyZHVYSFNwREFRbEd0YnJWZ0xkL1lPNlk0WEg1?=
 =?utf-8?B?TVZudGtzR25ZMGZKb1IwTWdQSDk2S1BnOGZTQWNVOGY5MWtZUGdaRktwV2t4?=
 =?utf-8?B?cjFTS0swL0o1Qk5pWFFvU1VjN0pjL2lwTWRvTGxmdVVjVmVCVzFoK3Z1S2F6?=
 =?utf-8?B?RHBMQm0zVVMrOCtpMkdFdHV3d29NU1A1OHR2TXlJTnRFQlVhdmJSZjUwTmdD?=
 =?utf-8?B?WlQ2YmFQVW1sNzk1SnZyRWk3NkhrVGtWK0Y2b3ROejM4aHhvSldodUJMclRy?=
 =?utf-8?B?bk5uV1hWVDYyUWNidkRzUHZRTmNIY1hJdjNkemhzM3ZlTlM3cEk4YWY0UWtt?=
 =?utf-8?B?ZTZQU1V5eHdCaXJ0bGJKWWZMYWhYdW5CZ1hMcThIZlNiZ1hFaURvcFV6OTZF?=
 =?utf-8?B?VXdGMTljMzdnNUtMTHVISGpHL1Uwdk13dit4eVdrRThVbHNFazkxZzZPYnNB?=
 =?utf-8?B?MG9Pa2RpSTU3eEYyQlZGMWV5TUQ3Ym9yMEVJMHZXOFFpeW5KYXY2WVl2c0c3?=
 =?utf-8?B?M0QzcDhlVkVpNUJ4VWhyL2t2a2NJbStvcG9NUEYvV1paQWtHbkRhUjh3MCs3?=
 =?utf-8?B?N25BekdKVUtRNkFhejh4SUZ0eWZFWEF0UHBkdWpvMVhNYXRrMjVEemRCazNy?=
 =?utf-8?B?V1d2NGpXbDVYNGx3ZGJWaHhVSExLckwrM2tidE1jVnZIUHVHblZkZ3BMcTM2?=
 =?utf-8?B?ZmtHSFFmRTQrcXY1KzM5R2VIUTE5Y3pWck1vZGhGU3B2Z0p5SC9MUEJ1WHB3?=
 =?utf-8?B?TE5qL3AxTHlEdnkzbk1aNmJGbG4yZlVKNjB2QjBqVHp6cXRSZ2J1dHlzTWtK?=
 =?utf-8?B?eTFtelBKWEJNdVdhNkN5WWtlMVJaamh1Qm9VREdJQVZzTktzcjFqaVEyTDV0?=
 =?utf-8?B?U1pCQUUybEdURytYZUwxVkVSNERhVHpZSVZ1aTFNR0Y5OXhGRXFFTlVxL3kv?=
 =?utf-8?B?RW84eDU3dkp6WUtuU0R0ZXc0QXJLZXBQTEhvYmpNMGZkbWg2YUpLcTdGRWVm?=
 =?utf-8?B?WVpFRTRKU25JYmY3bTJmbTloU2lXNEg4Ri9HU2h2NzhEdFBKU2taTHpLaDVo?=
 =?utf-8?Q?GHMVE88e/tIyXiblVnMyE3ys1MsK7DtL4ZMZo3j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ec8e38-40ba-4008-5965-08d9789fe8df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:24:05.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0ox6gO41G3d+OQEyvThT5zXHG0furtK4EkAdzCGLQiv9L/yNExPVBEc3h6ryfwRN3PY01zanca4csI74+idrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

This patch fixes the following CID's. Thanks.

Addresses-Coverity-ID: 1424031: ("Big parameter passed by value")
Addresses-Coverity-ID: 1424055: ("Big parameter passed by value")
Addresses-Coverity-ID: 1424072: ("Big parameter passed by value")
Addresses-Coverity-ID: 1423779: ("Big parameter passed by value")

-- Anson
