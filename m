Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600EB347D37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhCXQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:02:15 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:61761
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236862AbhCXQB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwV9pXQc3NDnhA58g3n4RgePaLVxWnfIiX56lRzRMQ8K4z7F8JePvNEqirPaWc4FPGjbdgSu8hN7gt8SmHv/q9529GBTYztQ4ioghGyrinczgUYMXu8UTKn2/WzlxRC0UNdfbAzlojsQahZHbcOxysu6VVIRCT0ED1ENFu4ksZ0aONozNoCPDVdmn4eHgE3i0QGe5E3HCNwGC5hsOwICCGumsUXp6ioOHuUqOv8GSo6gRDI+cE1g0iDiu/C15sUABf1zukYFGRP5HNk+mhfSvZ+vi+RSuCQt26cp2taAOZfbjfVAg/HWlYD5Uc89/YXa1dXPt8ZHrQs+I027H0kcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRiSXRSMTyhgC5JrtC8XDA2GAiTIdSH5hAhHVDr1OOk=;
 b=fE86JfBqHPXX9BKZfnNwQ3jybNg4hgNS0/XNwUiEGVR0KHnrk53a9HtUeVRsxolw4F9soMOyT8jhrBw7VeTU60MtRvIcKofhl+rNGWEykCgNJ2o/VZDYPbg39dVYc8DZY6s5kM0qYA+p7hM6EhGP2uEZtvEmMluBULDo4MCsqkRGwwPGNSjiVcTz10HP9EobX9/Sr3JQbLqNUcEkuN5SqNDo7ebOKzloBbc91BUm3s75f43U14waRKhfvt/2GdbDQuQGKDNrivhO2WYJIYAERmguNidp6AZi89j15ZgcC03kPyEykdaH3ExT6ZEI6j7VS/mPAPwRtdeAqdEbmroLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRiSXRSMTyhgC5JrtC8XDA2GAiTIdSH5hAhHVDr1OOk=;
 b=etwd+Aus2Tz2ob5swhBwVA3l2AdgEyVbUZuQ6Q116Xvq5QSJnH+EHBF4WajKHAjYzDVobBU3634+hjfa8cYStRv86TbEYW5WQPe4P+N3lQYOWoPL+gjq7X4PoEtE4ih3KIrvMr8vef05LmSIRJ+UjmQkCJn5uIpHxcTJJcSN0wE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MWHPR12MB1327.namprd12.prod.outlook.com
 (2603:10b6:300:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 16:01:56 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::c977:4e9:66b8:a7e]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::c977:4e9:66b8:a7e%11]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 16:01:56 +0000
Subject: Re: [PATCH v1 2/2] ASoC: amd: update spdx license for acp machine
 driver
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     shumingf@realtek.com, flove@realtek.com, derek.fang@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1616118056-5506-2-git-send-email-Vijendar.Mukunda@amd.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <1038aeb4-d9da-6b45-2b09-b0bd399d752f@amd.com>
Date:   Wed, 24 Mar 2021 21:49:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1616118056-5506-2-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15)
 To MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 16:01:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25570335-7a0a-44c8-1903-08d8eede25ca
X-MS-TrafficTypeDiagnostic: MWHPR12MB1327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13271DBF1BF859734B19B34597639@MWHPR12MB1327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSx1fNvx17wR1kt81OuhWxVq5GIgT0tQel5ERaWpqoD628weKZdhUvOTU99FCfTCihp+RSOMtaQOTtGlaShlDBrkqN1XG+4w8uZvhUCee8iIWWL/Z7+iPUVfHYbNiHCQ5bsf25FfTkaAMHPkjyOBtv1ob7nGarld+XJ+JqJadfgJrJ8BA03SoOLGenLqd/c3WxXoTI0+N/Qyx2/BrJt2/L91BSARvzNcY4XLC1mN89SSdH2UIdT4hB13cntNVnaH7B0ObSJrluqckKDjRILa2j5YNt/DPVXV8kZVMEioM355C7vj6UhhokJn3ok3FbjzcMeOekUmapYS1uywaCeuV1YncFkd678lp3Bi2Qbb0ur6/pi+ft0/WQ5TpJxCfghpXIW33Pmc4ErzC+k3aVOi2n4D3GBMy5mlZ7ses67u6LoApEc+5q0fbzpON0ep+M5IAdaKjM1iMcv1TRT/0sYZJvWZbgYgnOfAX1YWoIHpvvfF+iZjmY9QCU1ca78e6YxhXY3t8yH3ce9bQCtZ3YHTq+xozciC98XpvDp0qWl+NSZzPxvjwult4udg68Aw61p7GXRUE2rT1Hs+h96Sd7L4YhqWS8LmtLton7Rd4i9oFtz6NTXoN0M41R6GXYfr0U78xjTLA6afQ6G/tB2uHP7+23AG9gwEgRDZdhqCYQyF0BvAOfG78gVsFFAYKrWAjMf1oo1/spFpgbX86DSQcH0Xvf4I43Ltd+BhLCJdCSegagg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(38100700001)(16526019)(2616005)(956004)(6666004)(4326008)(7416002)(86362001)(8676002)(2906002)(6486002)(186003)(31696002)(478600001)(66946007)(15650500001)(31686004)(16576012)(36756003)(54906003)(8936002)(66556008)(316002)(26005)(53546011)(66476007)(83380400001)(52116002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Yjczd1gxK3lTYjRVelJWNzR4MCt6akpXRytLdHh5MTZvdElnUzJvaTdYUEJM?=
 =?utf-8?B?eExyTTYxSk9QNW55TjlKeEh0NEhDZDVoWWtwN1haWHFUK1dySndJWGpScUM3?=
 =?utf-8?B?eGcrYUdwNjlHK0ZUU3NKTzQrdURTWGw1RTVRUE1NSldrckMvcFFvK1NRSmVL?=
 =?utf-8?B?SVY5NHR6NTV4QmJ3R2ZveVJCSmxCcUJQck0wMzZWZFp3YUl6NjlrUnlWWlJm?=
 =?utf-8?B?YnNsemZsenhMSzJyOWZTTVR5enBqU1lhRk5YVUk0cGZ4RXpnbS9KSEgyNytt?=
 =?utf-8?B?bWc0bkJSTnU0VWZNc291TWlqOXM1azdjd1lkUHp4REZXUTVyS1ZlVFJFVjZq?=
 =?utf-8?B?VDBWcktTMzhzOWU2VnFwY0duTHJ4eWJodTNCWStQbWdCVDI2c0FFUDQzbjhG?=
 =?utf-8?B?UHJSZVV2SjhKS05LUFVMalY3NlRVT0pwR3lMOUNBQ0JjdU52ZkhhQ2xPUzRy?=
 =?utf-8?B?aSsvTmd6VnFleEw1OXBtSUpiQU5UZkcwZk44NmJzM29NVlFsdkVkOWRHNEtX?=
 =?utf-8?B?TnJpbStzN1k4cG9VdlNqVEpKRmdqQjIvdW1kZ2VtYWE1aUhSeDBGWEhlSkRK?=
 =?utf-8?B?dXFRM1o2YjBBdW5ueWNNZHR5N3VnLzdpc3J3cXZNZVNjczF5WGdWaW9UdTFl?=
 =?utf-8?B?bFFJRFVqQUE3cFVIRWJjUzQ3dHVEeGN6ZWNVdi9ldTdPdXhRMlBQOVM1d3dW?=
 =?utf-8?B?QkIyRG5XbjZGYzRuY2xnZmxvVmhEWGVlb0RWb013YWhZMFlucVpUY2RTcTZD?=
 =?utf-8?B?Q200WGxDZ3pPT05KRE5EYzY4cmxkRU9RYTB4OXZxT1hMVzR2cVArcTVTWmNN?=
 =?utf-8?B?Uk5rc1QyRE4vVmlLUnIwRkcvZUlWWU8wdVVLNTVYTUgrcTZYYzRKMW1ENk50?=
 =?utf-8?B?NitNcnRpaS9PTnVXRTlrazZoZ0F0U0tVRjhiZHVoWkRrT3B3VS9xSVNKTzh0?=
 =?utf-8?B?NFdoQ3ZuNXMza2g1cU1idklnNDVyUmg1QVY4cDFXZVFmMm9GK3I3bTlPbzdF?=
 =?utf-8?B?aVBiQXVhMDJZQ01OYVE2ZDFFYVo1UVFqNU1sQnVNQTNDQ3pyRTRVZ1piU1JT?=
 =?utf-8?B?YzNKUWVsV29qUGQrM0FKcXQ2YmE1ak5meDVMR0FyZ2xZeVZnWnptSEJTSXZP?=
 =?utf-8?B?dmZNdFdEd0txdmZVczlHU21LQmMwbFFER2R5QzJ3Z3NCNXNEeFRjZmlrRTZN?=
 =?utf-8?B?MUZ3Wk9YSis1bWtCalU4OHdxd1JnRlM2UlhzaXM3akJvaGxlS1JlOGRNSWs0?=
 =?utf-8?B?Yk1UTk5TZDFkalNGUlQxc0RjRE43RWkxUENCRFNjV2RRTWNMeGtpUXFiRUlh?=
 =?utf-8?B?Q2ZZaEcvbGxRV3RNaXF1MFNZd0FLTlJJNHRiaVIrTFFqTlk1aHhRdS9vcUxw?=
 =?utf-8?B?clJGbUo2aGtNTzNnOS9pSUM4dDlGZnNWREFXb0dBS0ptVDNxUjQ0Nlg3K1RP?=
 =?utf-8?B?OTBkZ2RqY3ZrRnV6RVA3RndOek9ER2FwR0pHMkFPdElvZDFiRFVVTWtTUlQ1?=
 =?utf-8?B?Y1lsTVBYWTlMVkdwSkk2STY2RzBSUEJzclU2djUrS0NVckJXbXlyZjIxUm9D?=
 =?utf-8?B?djRveWNtWlRreEZjTm93QVlabVpPQS85NTArUHN0TitLc1Z2NjBYL0hTNzY1?=
 =?utf-8?B?Z004QUxlcStYZXFQemFNQWJjd3VQZVRBZHBoZFdSdzRrLzQyVXNWaDg5QnJE?=
 =?utf-8?B?WjFubXpWMUtpYjBYWU4wV1JhanFhS3F0THYyY054dTZGQ3UzNDlSTXloYk14?=
 =?utf-8?Q?bgvQTaB+rU1CdOYkaZBu2aXAvPIovqzBGUggR1a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25570335-7a0a-44c8-1903-08d8eede25ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:01:56.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkjPcwaBKSyFeJRYvmMJj7DyOa2VNp+DvrhJAOtRJ2+FjcShOKedg5nu+pXbsH6K74nuyQ4S4X7urMycuc4Cmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1327
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 7:10 AM, Vijendar Mukunda wrote:
> update SPDX license for acp machine driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 29 +++++------------------------
>   1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index e65e007..84e3906 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -1,27 +1,8 @@
> -/*
> - * Machine driver for AMD ACP Audio engine using DA7219 & MAX98357 codec
> - *
> - * Copyright 2017 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> +// SPDX-License-Identifier: MIT
> +//
> +// Machine driver for AMD ACP Audio engine using DA7219, RT5682 & MAX98357 codec
> +//
> +//Copyright 2017-2021 Advanced Micro Devices, Inc.
>   
>   #include <sound/core.h>
>   #include <sound/soc.h>
> 
Hi Mark,

I see in the same patch series patch 1 got merged and this patch hasn't 
been reviewed.
Should I resend the patch again?

Thanks,
Vijendar
