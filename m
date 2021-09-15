Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7140CF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhIOV71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:59:27 -0400
Received: from mail-sn1anam02on2060.outbound.protection.outlook.com ([40.107.96.60]:46783
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232618AbhIOV70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I49DxKpnKIlnMN0bsqnHM4K+d9qDyTERn9UkWEPgVmXN49rOpDxvA0Dy93fHR2Ae2E2A1qxHg0nDP54KdpZs0K2PsqJ3ShqdY8iX/2x1TiU5UR6D3K7xkCYIrk9XrMuD5H/a4Bnek4nlqWOJiRJYnSp5WXvdyJRxlYa+AgaWAzmd4GpAlXzze/ScGZZ+T0x/PTlkydld5ZRXZD0VyupwVMbEY0/ACrl5QRa12nAj8LFwFTU3zz+YSPEsYyyPlZOXCC/y7ZECXvV0dIgB6ZYa34Q3GaCneGz9eT83xVWk9me1/81E16KdyecAeo7Rmnrk5wtiOU0Udxn1pEK3+3kjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VWvg0BkEWfBzR/fT5pt491SEpfKq1CdcrAmpThPfGks=;
 b=kXANDMnkKl2YN4V4d8ugdiRsQgm58IYvMK2swF3Sc+dAARaOiKQ3kAwjyb5EIMENT+3MHkd/3heW2Iy9kPI7sP1pDDnn2qDQ7hwxGKTGoF+p4ZcYIzYJ+36aGH9dpz8m3Nrf8ktFvYTfiGpi9ybZmaCzrdOT5B4bV6hndEJ+R8CP3y/Ti4lFN4Si1fkxAzCL66E33nxegJrHCPltSxbjOPo6dEulGnwgWdZ8LSX4G1IYbA+YR6MaYsRn5lzvwCmIY9JLgrCI3RirsZfeOHnrAeBqo01BjNWhmEZD/o29QPIaIo6siWcf4ouM27i//H0PDxINV5MATfxbYimH4ZgxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWvg0BkEWfBzR/fT5pt491SEpfKq1CdcrAmpThPfGks=;
 b=uulNAWbdR6R1/GB6geXC2LKtaaRCxDwcTYJMgyabnjZqeFqsenV01uKB/altdMsL0EUaKSX768epoPk0v8wU7jjiyU5d8tfdgg6noljnOrP4oHosrxf4gedaMEEW3d8nB+0/LACfkrhqm0ysORkPQllkgzNAovnBd0eblbZUAZQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 21:58:04 +0000
Received: from CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::b980:ad7f:81ed:3a34]) by CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::b980:ad7f:81ed:3a34%4]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 21:58:03 +0000
Message-ID: <bad42db0-3552-df3e-8c40-a41b16f50088@amd.com>
Date:   Wed, 15 Sep 2021 17:58:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/4] Fix stack usage of DML
Content-Language: en-US
To:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, nathan@kernel.org, linux@roeck-us.net,
        llvm@lists.linux.dev
References: <20210909010023.29110-1-harry.wentland@amd.com>
From:   Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20210909010023.29110-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:408:60::23) To CH0PR12MB5300.namprd12.prod.outlook.com
 (2603:10b6:610:d7::22)
MIME-Version: 1.0
Received: from [10.254.38.27] (165.204.84.11) by BN8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:60::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 21:58:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c550bbad-2667-4acc-481c-08d97893e402
X-MS-TrafficTypeDiagnostic: CH0PR12MB5266:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5266F4C20EF0E3214F48D7A882DB9@CH0PR12MB5266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/IsBjFuYPWWAUD57pudMhlgYxfDJLdSlCzCvaRHoeCO1a+kJjP/53eAD8lGPaf/yWzRgsVB84mxeY62dDYf9rss2bDLr1lxpS8tXxZX3IJaiN9viG1qEhVEEkStrOJyXeQUidJEIO7vETxoqcaX6wQEgaOQZwcuPtpxP+4kqeWa6qjK+UH9K3Qzimubf52pQNr+Q4URbxDgcxIhyk8ptlDcgQfM9AKQUkQS/zKUIn3ApdU1H0cMMdzSb+yJ0Nqu3rsWnRnUvTMKCFL6FtEXy0cAVAGa9awuA4ouA4B80qRG05Png6S+CXL1jUnvPqGPOtdswIda1YoKdR4y3suOt7fCx3Pxnyw+4RymOc6CFHiBGRwQckM+MbTu6MS3k1PA9hhxcjZlLC0JkoeQ6mm5kCaRGrTBR2V1trTIQgq8dVdnMXImGEP3l22ye6QpVSxhRUZZy6gAdsQho4jDQwz+EtqXooMfnCpIej7+Xuz6RwYMYXH4sLe/8jZRF3Oj2d83F3zSlB5SlPGt4H8+WWf/a2262cbLNxCUVTUQXe4M52JyxKKQ+r/caLj8yGFjJD9eWMdbYZxX+5hS4H207MM7WuC/bMvCtSo3gn6EEg4VvTIg5hzJKATcPox/IgyEPL1vbhTgFYJfwj/JG8KpbcReN75a4FvJ8hGC/YHRrzIkj/9+J4qc/PEeFENTM47ECEPGt+V9VNpFZGvVrAS6A+P82R9I+qGlkjlss+9a3EA4NBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(478600001)(83380400001)(6486002)(4326008)(53546011)(31686004)(31696002)(186003)(66946007)(86362001)(956004)(26005)(38100700002)(66556008)(2906002)(2616005)(66476007)(36756003)(8936002)(16576012)(316002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z010VnNYM2Y5aG9Ea1NtMG5IS2JvRXF2YTdWTnYyam9IdzgrU0hoSjM3eXhk?=
 =?utf-8?B?WVN1Q29KQXBwY3VEZk1QN2dQKzIvMy96L3ovVlR6RjU1MFg1ajhYQ0YzdDZ4?=
 =?utf-8?B?am5GS0hwNWk4UW5rL00xYnNIZC93ODhSWTFVL1FFTFJleTFYY2gvNE5qRXBt?=
 =?utf-8?B?RXRZYm1QK04wSDRvRmNucGpMWXZ5Y20zSjJBS0s5V3hPYkNEdWVZeGRGc2Zj?=
 =?utf-8?B?QW1hQWlEa0pXelVNYWNMRGJXUlZFZGZWK21GSGl0ZUJ4TW4ycmd4eEZEK1hT?=
 =?utf-8?B?WDJQYzNtRjl1TCttZHA2Uk95aFRFSWoycDFleDlibElreENrZzRPRFhNbEs3?=
 =?utf-8?B?NW9odHNwRnRTakR6STA1YTl2SWkxTmlSS1c3eUE4Y09zNlF1djIyZjhmeWRH?=
 =?utf-8?B?RHVjVzlqamdkTlFQY3ZoRVRna2NRN3NKZjEzS055QUVxeG1OWE9iblJqSXVH?=
 =?utf-8?B?S0xxU1JaU0d0eHFvUEliTjBpSFpUbHZQQTgycVRpVFpoUUg1RnhsRytsOFpl?=
 =?utf-8?B?Y09HVVowZzlLUlZMK1lNUG1PMnF2WEdFUEpwSkhJOW1EalNOYkZyeEprV0cy?=
 =?utf-8?B?d25DMUhib3kzTHBlSkZoZEJOU2lOTEQyNWlFWHpRdWhvMzQram5uYnZjR3Zx?=
 =?utf-8?B?dmFYeHBkMi9OQit5anZDR3JXOWJBOGl1emdQRUIvc3o0cmQ2YmZtZk90NU1q?=
 =?utf-8?B?SjZpWUZZSVJLTmJSSDByUFdVR0ZpTUErUXdQSWFjNngxcllxcTN1QVJFdWtx?=
 =?utf-8?B?MnhCTFQxK1pBVEhEYlJGalMySk1SVHJZSnJtNnBPZ2k4OWM3ampwZU85Z2Zx?=
 =?utf-8?B?SENYUmd2RjI1Vko0dG9PUklFK2hzUGxtSTJoc1RVSHpvTzhUOXVpRGk1L2sr?=
 =?utf-8?B?WXYyWm5pTVhlT0hSa0xaaytxdkhpK0NtdTltS0V5dHVtNWI0dVFmN2xkWEVy?=
 =?utf-8?B?ZzRPV3p2MmFHZjV0cTZlZng0OGhWTkhEZXRmaFlKTFZqdkpEdWFsbHBXL1R2?=
 =?utf-8?B?UkEvVENmc2Nxb2tXV1JjR0xUSkFkRXpuN1lLSlBWM1FNRVNTS0t4VXFzYTJT?=
 =?utf-8?B?UDl1OVR5eTBWN2VZZWFnd05obHkrOVF3b0x5NDlsbmtqQmFCb3NzckY4MWtx?=
 =?utf-8?B?KzVHeWhPV0tCRHVKZmJCQ2pneGtaWlVhSTJMajduVUhZMHRCY1lKYmMyb0pv?=
 =?utf-8?B?Nkp1eGk1aVd4VGE3YnZxYWc5Q1hpTkpCRG5pWHUyOFY3Y21DS0lDbGRSMWNC?=
 =?utf-8?B?TCtYdFJFVk1aQUgwMFd2c2VXK3pZOXhqcW9HaWY4M3RHUEM0Zy9KMTM3bTVF?=
 =?utf-8?B?VWFZR0E2L1dlbDBucDZwR0tZK3ViOFBPUnNhUFkzdnl6d1Vvb2R4S0sraGFB?=
 =?utf-8?B?d3dUSUg0RXFDZ24xTk9JVlphNWt4cXpBQnlodGJ3aVhpdFc4RkhuSUI1VFox?=
 =?utf-8?B?cXgvczNYMUV2MDN5TUlvc1FKU3h6K282T3NFcWQwTUl1Yks1eFFUblBYMmhu?=
 =?utf-8?B?WU14UUgwREdVZklkLzB6MDlSRURCdW4yVDY3Yk5GTUd2V1RibUlFWlhGTkJV?=
 =?utf-8?B?azNPNzZJOEZRMXlSWW9yRE44WVoxRG05b2k1SWg1dTkxZ0FvYi9QQUtDYTNW?=
 =?utf-8?B?dkM5M0pVMlQ4S3BnYVdjMEFTTVF3SkpXZzJLUFNXYjUzNUpMOFUweG9QZzU1?=
 =?utf-8?B?U2ZEaFB5WmlTNDVDYzI2NFljNzVldHAxWXNjcVB3VVE0bUYzY2xMc0loS29X?=
 =?utf-8?Q?ZyQNwEUi3H5y0wIbln7IuW3PSysV1LG0K2AJlEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c550bbad-2667-4acc-481c-08d97893e402
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 21:58:03.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAQu+wvvbfim2tppXyh80NpOvTDq/lbSxAIfDOLZM/dJcFZ/dQ3fDaYWLlbI/yPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-09-08 21:00, Harry Wentland wrote:
> With the '-Werror' enablement patch the amdgpu build was failing
> on clang builds because a bunch of functions were blowing past
> the 1024 byte stack frame default. Due to this we also noticed
> that a lot of functions were passing large structs by value
> instead of by pointer.
> 
> This series attempts to fix this.
> 
> There is still one remaining function that blows the 1024 limit by 40 bytes:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6:
>   
> error: stack frame size of 1064 bytes in function
> 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]
> 
> This will be a slightly more challenging fix but I'll see if we can get it
> below 1024 by breaking it into smaller functions.
> 
> With this series I can build amdgpu with CC=clang and a stack frame limit of
> 1064.
> 
> This series boots on a Radeon RX 5500 XT.
> 
> Harry Wentland (4):
>    drm/amd/display: Pass display_pipe_params_st as const in DML
>    drm/amd/display: Pass all structs in display_rq_dlg_helpers by pointer
>    drm/amd/display: Fix rest of pass-by-value structs in DML
>    drm/amd/display: Allocate structs needed by dcn_bw_calc_rq_dlg_ttu in
>      pipe_ctx

Series LGTM,

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> 
>   .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  55 ++--
>   .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.c     | 158 +++++------
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |   4 +-
>   .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 156 +++++------
>   .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |   4 +-
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 156 +++++------
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |   4 +-
>   .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 132 ++++-----
>   .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |   4 +-
>   .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 166 ++++++------
>   .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |   4 +-
>   .../drm/amd/display/dc/dml/display_mode_lib.h |   4 +-
>   .../display/dc/dml/display_rq_dlg_helpers.c   | 256 +++++++++---------
>   .../display/dc/dml/display_rq_dlg_helpers.h   |  20 +-
>   .../display/dc/dml/dml1_display_rq_dlg_calc.c | 246 ++++++++---------
>   .../display/dc/dml/dml1_display_rq_dlg_calc.h |  10 +-
>   .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
>   18 files changed, 695 insertions(+), 689 deletions(-)
> 
