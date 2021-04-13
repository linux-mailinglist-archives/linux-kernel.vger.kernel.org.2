Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78435E02D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbhDMNgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:36:47 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:15073
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237619AbhDMNgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:36:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obpknW91rhbn1e9C69aUV35B4Gen95YVzhEGsMlDiQ7dMA+/9d2VDuFexmyC4djOs4r4zjD8xukhQ9QpM8mpJpa/1QgbH2xTEdnUqzc5XqOHLGGof1+r+3i5jo4SV8Hh1sWZdwO482TgYwaH/7Yr4DOPNRvkvgGCbXyjd9/vu+ZFuHyVMTBe01+g73E2WMbOppaucj7UISsfaoRim87rd+xUlSCz7ecB9LIbKCePCOQbmWhQcaUOWJB6M8VNMfFqKZosFYgi3y/lp0mylNqPZWq1Jez3Hj6g7hDgQHomuxOLMKZqcGMkfIm6J3ShtS/a/8DO++xwGrQS9mTDcMU2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zlr3TQ0acqlH5PtRKy7J/wadPsuR2EqT2yHLS2kxtd4=;
 b=dWXUIuDywr41Xhc/3m8YG/oLE3gQli1kGqIvvWpgTtAt7sp/kFdbC6JkffKnT6OM5XvxwWhwUJYmtSUOOq7+DhYxFfEzRC2/tXT/NOfCipA9GPsmmAkOqU++Eavy85o4MSZbK/UMwzkcqM6/Q5s6goCPmCGhKC/fkT4vEyhcEIb8xEPMd6upKYOiScdz3LNhovxjykls3x6OW3D9yl0MoPcn2qrbo3c6YIYqR/5VYKSzzlcLAwUDKeV1Ue3i0R8a5tVrS4AfL4SQ03Fmh3uZ6BSF4C0cHRuUGOx0qqTb6C3YUgMx06zMmWvIVCZ8UXmUN4nXst8zOUAWhYmKoZZP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zlr3TQ0acqlH5PtRKy7J/wadPsuR2EqT2yHLS2kxtd4=;
 b=jKZs23IbQ5/EvFoXCLyAef0mb8s/znmvUUd/N9FE7YQnFnIKwdEs6mEvkcvCFpsn34eV7jIIjbaDBGcswt494NWWCA/s1EP3wZpsgQrx0nMfVpz1L6WzdHToe33hffQCOYbW/1/lwttkLypFMHPyVp96TbqIFgzXRF+ADSJnfvc=
Authentication-Results: live.co.uk; dkim=none (message not signed)
 header.d=none;live.co.uk; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 13:36:23 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 13:36:23 +0000
Subject: Re: [PATCH 1/2] Revert "iommu/amd: Fix performance counter
 initialization"
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Alexander Monakov <amonakov@ispras.ru>,
        David Coe <david.coe@live.co.uk>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-2-suravee.suthikulpanit@amd.com>
 <f156768c-37fd-a4e8-3959-a5bc5dae918c@linuxfoundation.org>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <c48c9579-e123-7dfb-47ca-a93856731f6f@amd.com>
Date:   Tue, 13 Apr 2021 20:36:11 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <f156768c-37fd-a4e8-3959-a5bc5dae918c@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:820:d::19) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by KL1PR02CA0032.apcprd02.prod.outlook.com (2603:1096:820:d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 13:36:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a9f9cb-e955-4134-f1f6-08d8fe8120bd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB488631A5921A63A7D46AACACF34F9@BY5PR12MB4886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuU+R+kiqrcVaMXeEQ8Kl/omJwlKMn5ikZO3fGOL72XdS1oCK3ETEI8hvZ9kwXNrOz8+f+LGuaJnYTIrOl3d213zMA/ux2UmRH/5xRTQCfqr2ANQXl5ZgRubAyia9s7QDvA1+rhTjB8QOVbdbeyGoL5ZfSlTVOVErmAbcFPXtbWBwKwb0CSeixsLIspB12CzeBMWjGxuQKMKzwu1ZWurkC4cL3+hI6ZlKJ1iHipuu5S7S8Dhc1w/DJhUlYgrl4sJyTwhPGxlgEjWl3MngoP/vDKPZuL+h3rp0VwXqiC9/k+bqGqUD3ULMQL9zS/pURgjkX80Vx+v4DXLhXKwSYQaDWiulTHzNJB4JfbQgwMteo+CIheygJ4r4NwSpjGdVKreRW6iinsI6WoRZqFNrbJEgN1fsgHogW4DmAnNze7NJV4twAj7NpylQnRJOecOMF/rLKl01AF8I2gPDmKUcKrbWADrxRVYBSNRBi4zu6b5Yx/yedFUfdyWP3oebodD3vqsnoKKaZvy0JXjferQApUbibjL328Fqbyy7RObcxWCujBddkJ+Y84tz+Y2Q9fSSPqg4HpnsGff5eNxH9wuI47ZZCymNgxcId4iImZvypOUCFx8oflx1LoDxgFFCJvw/eKDTO3z8glQ/n8lhlUuFB3eyF6ny3Sh7GrTv/vrkOd3ClECZXw0Pad0yqtLIaW6eosQ7rEI8+LJIMiaxdWcvg7S0lw2+o7ohlg1fWh3J5y+ZkbZ62rbQwZkM67EMgZKjvcZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(2906002)(2616005)(36756003)(7416002)(66946007)(52116002)(38100700002)(6486002)(16576012)(5660300002)(66476007)(6666004)(956004)(38350700002)(34580700001)(26005)(83380400001)(66556008)(478600001)(31686004)(86362001)(316002)(53546011)(31696002)(54906003)(8936002)(8676002)(16526019)(186003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVhrTzJKai9Ba0NwM1I0Q0pVRnlBdGhmaTRIZFpoc2toY3RUeXl1MHlSTU1E?=
 =?utf-8?B?aW82Ni9pekxPYS9kMitUdVJLbEJiUzFDSy81TmhkZC9oRUtySkh1T3dVQTJY?=
 =?utf-8?B?KzZqNWRPYXc3U01JZVJJVm1zTXJWWi9Dc1dINkpFRnVtdE5pY3o4OWpiWHNH?=
 =?utf-8?B?eHNYVUh4eWprZkRFc0FIRjIwUm1yK0k3dWNuelpYUWZPRENZWXpHbzVaUTRp?=
 =?utf-8?B?SVRQWWt2cWJIT2wxVUdHT0NGd0QvWE1DSDIzN21tWE9nZnNjRnlRS2JTY3c4?=
 =?utf-8?B?cVBsWDV0Z3hXYzhwSnd1ellwUHZEWGJVUzBNWnY0MFRtbXV1SkxhZlFSaFBW?=
 =?utf-8?B?K0s3b3p6dVU2VHMwbUp1Q2kxcnlQdmVtMDRFcFJkSS9WSkd0d3F1b1VBV3pm?=
 =?utf-8?B?Ulo4OTBrQW5UNUxXajFGeEJPWXFyS0JYQWJxay8wTUlUZWpTSC9CeEI4VkEv?=
 =?utf-8?B?U2xEcWtlWExSYjNpZC8ydkIyQUViUi9ZWGt2THovZXh3TTlxNTY0a3o3UnV0?=
 =?utf-8?B?eHdmditqS2FHUVVzblZURFFLVzJqTlFCbTRhM29jSTF2VUJDTU5pQTJoWkdG?=
 =?utf-8?B?eHZsRkNma284TlVOdUZSNXlVeHFKTFJWT2FyakpnYVhKRXNMTkFIS3hXNE55?=
 =?utf-8?B?MUc3a3JRb2pGQm1sdk0rRi9ZTzNBWm96MFI4a3ZINTFiKzlZS0d3TzlIaFJC?=
 =?utf-8?B?cWREL1hkcEJDei9SZjZ0bkcxT0tEeCtITUlRK0VhM2FtcGYvbFN5eG5pVHdE?=
 =?utf-8?B?TFJYVXlGd09Jd005WFcxd3lLVnltVGpLTGZZY3QwNG1hYzErY2RzczFheklU?=
 =?utf-8?B?UWNQcEFMSTJIeEFoeFU0SHpmRXpId2lyR2NYdk5pUENFREtWK2FMSFY5U0tv?=
 =?utf-8?B?bm5pWVdMUkc4Ykh5TDhnVFNJMUdNSmZpYjloWldCWmpUVEZiVlZTN1JSOEpY?=
 =?utf-8?B?OXhzRkdkZU9icnpIR2FtWC9NMXFXZXBiSHdvZkp0YmxQY1pTK1hIU244dm93?=
 =?utf-8?B?K0Zzdks3UElPNlMyN0NRZE53U1pFUGZQdEt5emVGeEZWaGFJTE8vWkdJL1JP?=
 =?utf-8?B?ZjhPQzdTeXlncFZLN01KWGpKbXI3V0NwSjZyRk0xTlFJWEE0eHEwRjRnQWt4?=
 =?utf-8?B?eFNMWHo3SnQ5YXFEeHZ0WGFGYmtuWjNmQUd1ZXl5T2tUbnczU2hPREVNdGtS?=
 =?utf-8?B?bGczbnBRUXZVZWk0S00vaVFkbW5UUW1YQTFpWDRkWHhNVGxwYkNvSnN5QmhN?=
 =?utf-8?B?MXZPL0VhNGVZaStTSnVUVmVHdHI5K1dwQ0tITHpaam9Mcy9NQ3lCSVlxdnJO?=
 =?utf-8?B?ZFozRUdZLzY2MkcxQUQ5OXFJOUdEMGl4MUZndFJON2ZpWUZkems2dFZpTWZt?=
 =?utf-8?B?enpKQWdJN0YyeURoazJ0M3pVOC95czNyT09uOXNRWlhsUjF1U0R2TU1nSW4v?=
 =?utf-8?B?NlhSUFd3Zyt5dFlha0dkVjdzM0NVY0xuTTJFeThIa3lDY2JzeFg4bTJYZU5P?=
 =?utf-8?B?djFtT1dWdENmNklrdGk4YmN5VU1HQVhuT3VVWnRoS1gyUU9BUVFRNWdubVpU?=
 =?utf-8?B?Ly9ySWVZRTRoM3J6ZUFPd2pRSDQrMVJqN3ZxRFc3bCs0V2ltSk1ZeExkMEpG?=
 =?utf-8?B?MXdjNFUzZHZ1MFpnTStKcmpYU0hrd1lEdjFxUjdtVFo1YkczR3QzVEVxcU5O?=
 =?utf-8?B?Y3FoUVdGVitHT3VEcG40dXdJb1hlVjVxNGU5UU4yYXhhRjBiZUJEU2Y1dTRS?=
 =?utf-8?Q?mkVgqZR50qHhmJdb70Ua/W/ZH9o7wv9lXDZmBYB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a9f9cb-e955-4134-f1f6-08d8fe8120bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 13:36:22.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejamrMd1K2UJs+eiguGpXWFyiL2c6yKvfzVP9qQ3oV+FSfuwM9ahanNebuY+gcfWGSBthfr71t7vwcFrTOBUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah,

On 4/10/2021 12:06 AM, Shuah Khan wrote:
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 321f5906e6ed..648cdfd03074 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> ....
>> @@ -1729,39 +1728,17 @@ static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
>>       amd_iommu_pc_present = true;
>>       /* save the value to restore, if writable */
>> -    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
>> -        iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
>> -        goto pc_false;
>> -
>> -    /*
>> -     * Disable power gating by programing the performance counter
>> -     * source to 20 (i.e. counts the reads and writes from/to IOMMU
>> -     * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
>> -     * which never get incremented during this init phase.
>> -     * (Note: The event is also deprecated.)
>> -     */
>> -    val = 20;
>> -    if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
>> +    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
>>           goto pc_false;
>>       /* Check if the performance counters can be written to */
>> -    val = 0xabcd;
>> -    for (retry = 5; retry; retry--) {
>> -        if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
>> -            iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
>> -            val2)
>> -            break;
>> -
>> -        /* Wait about 20 msec for power gating to disable and retry. */
>> -        msleep(20);
>> -    }
>> -
>> -    /* restore */
>> -    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
>> -        iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
>> +    if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
>> +        (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
>> +        (val != val2))
> 
> Probably don't need parentheses around 'val != val2'

This is the result from git revert. Also, the logic is removed in patch 2/2.

Suravee
