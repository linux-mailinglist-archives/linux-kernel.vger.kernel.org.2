Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887EE40DCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhIPOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:35:59 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:28256
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238601AbhIPOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6QQw4NdEvS+FRg4G/Al+ZSC8ViyQz7EWuGQUI+GRe1VvqIddIBZrdtxR1rLQb7nTeeDdvpDb/o3/XivIxCQZgrZaWrbVNy27FLb+jJQaYLS8UdFQ5CsJx3HfQ9JNXohE5rc/xpU2HYWm9NEmwI+DQOwdd3wBer/AwCOzhc1frEt+oGcB9tan2fBakfpEVVnmf1lO87jaoD/4uPZN3M52KxPapmz6KxXntVJaSlJ3V6mhuUN+9F1HrWk30o7VNvKYLptzmSCIy5xgiWeR2L/vGUBG6ZqqxG9fwlb/kMC6fvfEAwq4e+GZAFmR4/TI9yosS0HlW6yMH4jIVMJC6eEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mWuoLABYxm5UlUnBvAhB/qrE6vOPzSUUVbE35Pc4Umo=;
 b=WgmzjWQ8ZQEuB2+CSVBCbcEaXnHO9JcZw+gsNGlIrRaH1ovMGxBVFkCLKJ/ui/KztB+LGL2GDNUpOUWtjcrUCtJVnNvCzgrRCa/6Bi+HcRuL+6QVUyMN9nMLPA0CerC9IGLssSxL1A3HVQcQ4sZIfhKa3oIIK9+1uooTz5jEqIjm4YjB7UTTCLT/m3UX9UspeU2TMnag7QJ0agDKrnrxOWP2FA1VVXpEehsJsCEYgY1fOxhZYCuu1TEPckRODHUR7lnzqw8TRK/Bpav8w0zv6rOmaDrewKwhjzKeHjX3l4tBpWU/8I6+DCp98ATmyiooif20JU1h6LkEgHlaKdTPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWuoLABYxm5UlUnBvAhB/qrE6vOPzSUUVbE35Pc4Umo=;
 b=oTAnkPO/6S1ksS8ZVvw/c9DqJittsuEA0WB2X2YTU0ak1AmqFsmQi6iBDMetVirWuNE1iDO5UJV7qstCOSWPXj3K+gJd6eauJWPUTK/JF4RSK7bNi8vbSzroYImZKxqNaZr5P03iQ+cik14NY9uODM6C7FFOCbAahruS7acqUpk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 by CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 14:34:27 +0000
Received: from CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::b980:ad7f:81ed:3a34]) by CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::b980:ad7f:81ed:3a34%4]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 14:34:27 +0000
Message-ID: <4c709b29-2f1c-aa64-409c-62bcd058f81c@amd.com>
Date:   Thu, 16 Sep 2021 10:34:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] drm/amd/display: Reduce stack size for
 dml21_ModeSupportAndSystemConfigurationFull
Content-Language: en-US
To:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, nathan@kernel.org, linux@roeck-us.net,
        llvm@lists.linux.dev
References: <20210914210508.10627-1-harry.wentland@amd.com>
From:   Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20210914210508.10627-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::25) To CH0PR12MB5300.namprd12.prod.outlook.com
 (2603:10b6:610:d7::22)
MIME-Version: 1.0
Received: from [192.168.2.32] (174.93.45.228) by YQBPR0101CA0152.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 14:34:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69b4d11-257e-4170-c174-08d9791f1622
X-MS-TrafficTypeDiagnostic: CH0PR12MB5169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51690096E6B9579340ED3CCF82DC9@CH0PR12MB5169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ETW0KcMrCtffy+HgIvT6dXK6+GAo9go6hFCVQj8yeYxTTlUNhpKFmGRmR/Gy7yYNei4yzlx0J+ReIajr54X+5l6dQlrNCMpRwTa9HnFBLR6uhA2DFcxuKWPp0Wr636Zc+NzOT+vv3/hl7iV5EGvajkCUdvyCzEuLrjtSGvx8Pdf2OAm03vRZbRsonDoBp9e+J74OWXN4ZqI0qSqteUQ1AHkHfpSWyGV7C3JYyMn7X8AfBMpTBNcBKoHILSfX3aYjbDpBPlr5lR1/Orig5ctmA9wUJP/Y3+KLEi7kHWHpdcHLDeVImIUd02EFMnWdOdKrTPXR2DsJgzCbQbCYi86FHmWhDb9QQhIEZYtBdefueBnUGBcBfPWKzfk9X4+OGYNusZFSxjZbTrysSDmMavRuhDDYmZYUcvdafhL4FVDE84QU8LOngt0p7Dn2FcgJKGM8cib9AVR8cNxbEydXnNozgD83WxOjf0dvMU3P9tSoEl508eN4IVbEChpBUmBip8/xYKSBjpj/vPj6N1LKPKm+hvIJO88BomYQG1u5SX7GKqCE+oBJP4qb+NKHRCplnPpXb0SfcFnto5WJggIoSg8xnmthh6aCPRNPlQyngXGY7PDoHMCbpaPSQa7HlJuUp6eivVesOsCQ9ISO1m//RNV369EL1puVzlZ212WzvC6BssRoyMF5nQVEne7u4vBVCm6g86F+bct8m24FRjUM6y/fjA2qHLUdlvPzUkqlePcvKfYb1GwzM6/srtHydZ7JY+r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(36756003)(83380400001)(66574015)(53546011)(478600001)(5660300002)(2906002)(31696002)(31686004)(6486002)(66556008)(66476007)(8936002)(38100700002)(66946007)(8676002)(16576012)(956004)(2616005)(316002)(4326008)(86362001)(186003)(26005)(213903007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTYydzhxeW9qWWg4KzJlMjJ2SDZEcHhuOFN0bjJVUEphNS9iUktEQzhMcFhD?=
 =?utf-8?B?Q1Z4WjEvandja29sc29mS2Z4NkV6dlpyRTZRU3U5aHZkWmpwNVRKSTJJTmNL?=
 =?utf-8?B?UWp3dVU0YlYrT3h2WkF2OUkvdzZ0emdFU240UlRPaFZXU2I2NnFRQjJ6YUJr?=
 =?utf-8?B?VGV5TEEwS3gvaWdoaStSTzk2RVFRbXRGMG1yODVuZnNkWVFLT25zYUxPSDV3?=
 =?utf-8?B?bXVpQ0p2ejhhQ3Ric29ZVlhuTGtMWVh5eU1qTHNsY1dsOUZveUlsbmZObkF1?=
 =?utf-8?B?RWk4RnJrenh1TzJOZitiSGsvZU90Yk9PT0xKSXQ4OVBka1YzMzdFVCt5V1F5?=
 =?utf-8?B?dUM0cGJUQnN3eENWajB4d0NWdzRyUW5nZmtVdEd4bm45N2RiUVBSZXRRWFc2?=
 =?utf-8?B?RUdPMkYvL3lqb2NtRTdmRUN1TUtxNlpBUWtTNXJRbzZiQjFjYnFSRy9MUlB4?=
 =?utf-8?B?d1RlK2hEZ1p3WllsK3BrUjFPOE5LY25XVmV1Q2NXcmN0ZlRHZHFycHdTeUFI?=
 =?utf-8?B?ZW9EUC9JRndRcGVtcDV2ZDBOR01jRGJ4MXJ0OUs3QzQ4c1o2YllGNWlUOG1n?=
 =?utf-8?B?R1pTUFo2UHdyTGdKa1RPalVpZURTOEg5cnBkNnppdHpWS0hyMCtvUzBGOHUz?=
 =?utf-8?B?clQ3cW16dVdsaTFDQ1dwanF0bmxIbjlpY2hRWDRUR0dWa21aRWpGQmU0ZjNX?=
 =?utf-8?B?OFhGY2V3SjE5eFJIOVZoZ2JSMGpCZmNlaU1TRnh0RDlnZWpEMStWVHpwbVRr?=
 =?utf-8?B?ay93UFV4eXRReDNJVEN2YU52ZEVUWEJQOXZLRURzUlZ0aFdmV29vdFF3WEtq?=
 =?utf-8?B?emExc3BoREVKbFBFWkRod21YL1VJNmUyYy9EYmlpUkVBMHFabHl0QVk3amhv?=
 =?utf-8?B?SHgxK2hUckNZeERWcFZaOXFrbER4aGFRaEM1OVhNbHBJVTRzK3BYQXp5RnVC?=
 =?utf-8?B?UStmQk1EUlNKZlBpOHZDNUswdkIzd1ZsUVMveTlSdG0zMW1lOVFpaFR3NTVy?=
 =?utf-8?B?eE5UcnBkc1RQeVpGZ044UGpoblpoY05ZWHRJUWhXOFJVYTVZOU1QNkl4STRi?=
 =?utf-8?B?NFU3WTJ2aGdpQW13SVl5UDhzSFhIZHpaS3pRZkFvT3pXd213THYxZ01nK3RO?=
 =?utf-8?B?RzRHblI0Y1IwWGtrdzM0WTFTTDlFMS9oYzIrYWRHcnZpS0RGc2ZranZLTFR6?=
 =?utf-8?B?U1FobXVqdCtib1hrU1JIVlEwUHBMUUNXUmh2NnUzQXc5T1RpNkNScGNaNDdB?=
 =?utf-8?B?Y0dNcWFmODBtNjJBOGFOaVo1dExpRzVHNkZMMVJjbXlmL2ZvMjd3emh5M3JG?=
 =?utf-8?B?M0U4QzBOdTlGdlBnY205YU81N2F2OFZoUzdWZ0hyU1gvOHFBb29CYW1XWVpu?=
 =?utf-8?B?Z0g1QVFwNnpRSndDbm9URE5XZlBNaVNhbE1LTlZ4T0tFQmFvdHl4ZlZaYmtJ?=
 =?utf-8?B?bTJFZWlDQ0pQV1Z5TTVlVmV1elZIRm0zRVV4YzdDbFJVR0Y5am1tRkVFcXVH?=
 =?utf-8?B?TzhJMFlNaEtDZno4UU13NzR5M3R4eEYzUW84WStSYkdJcEZrU2gydFlEZ2hE?=
 =?utf-8?B?eVRyZkt3LzJPRWlZYXBxOE5WQWRrd1Izc0VpTzhFVHdSaE5EWi9CcTBsQi9V?=
 =?utf-8?B?NU8yN2VDcXVhTEFYRHVzOXBDWndQdVI3bEdjYm80Sm8vb1BLNktQVDJGUUUw?=
 =?utf-8?B?dWprbk5JdDNXWkRXOG1DTkRUcm10VmMxa21XNFlSTVVWV2QwbzJvSWtyUEFa?=
 =?utf-8?Q?/oL/bJ2EOh+1AUysMXIkgqID040pMQfCZaSEYew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69b4d11-257e-4170-c174-08d9791f1622
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 14:34:27.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x5uNZn8pkHfPH96yBune4lxWpf2vFqeDXzNHypgSHh+FvbIATVNFxWpXR1teljn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-09-14 17:05, Harry Wentland wrote:
> [Why & How]
> With Werror enabled in the kernel we were failing the clang build since
> dml21_ModeSupportAndSystemConfigurationFull's stack frame is 1064 when
> building with clang, and exceeding the default 1024 stack frame limit.
> 
> The culprit seems to be the Pipe struct, so pull the relevant block
> out into its own sub-function.
> 
> Signed-off-by: Harry Wentland<harry.wentland@amd.com>
> Fixes: 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> Cc: Nick Desaulniers<ndesaulniers@google.com>
> Cc: Linus Torvalds<torvalds@linux-foundation.org>
> Cc:amd-gfx@lists.freedesktop.org
> Cc: Linux Kernel Mailing List<linux-kernel@vger.kernel.org>
> Cc: Arnd Bergmann<arnd@kernel.org>
> Cc: Leo Li<sunpeng.li@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Xinhui Pan<Xinhui.Pan@amd.com>
> Cc: Nathan Chancellor<nathan@kernel.org>
> Cc: Guenter Roeck<linux@roeck-us.net>
> Cc:llvm@lists.linux.dev
> ---

Reviewed-by: Leo Li <sunpeng.li@amd.com>
