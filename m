Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C903F31A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhHTQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:41:00 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:13089
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232025AbhHTQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdyfSsuYaR8jYf5HZxUhWd4RuZEFs/ClpncWHH+wMbSuhwU76z/1ux5hXPGRBgKpDsjHWdaceCZEUfNQkddIrkytDK6yumHMULEAIwm4OY9s+NeEsj2SRKLcXoBtcIh1scGQEFVeyDpqlrQ3a3nyfJtkNAtyHH6ShSZgk1NmusTNCIAqDBQYTiiJqodlZPhBVxud+hd+s4Z/mIwd6UL6xXLSIkgETLZEpmpj6ah0r4Zi+eX+/Kwqixe0ew65WqEigpHRhzLv+IG9DSDSkI9X2/lvGNdtY5Wg11z/lMfPGQaRl+KFAv5Hjb4d3/LeFagmDuL+pGHbyJd/goa2BnH8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qloLyOOMpmLGlKxzhaCRDY9QTBz0QsHN+caoDJbutXw=;
 b=a7AnFtzdPbm8kiVReuQDu6ULS46fDJDZI/7u1spHhIiFKigT9vlcavujPo6gzWl4EUVO4S2ZCOX7GvS4pGbIoVAzxWtUN45zVwvGR9T7YMFr0zayw6fXfgQl7ICLrMrseq1g6UsGIOEF+FTQK8kzb/NPG1rY5NPckB5F6qTIDjDwQ7Bux2OfHa/bTfp5FRosc4qNCtRsnAPXPER5VHfLyC810GYEvV8ex3saQaRRO+U4WSqCJWZAvNhs5FlZOCqwpfQKGs1/UYADAEBF8f6lH8Y3I7H3eFHFic2pxFznVzmPVuqKhAWkUyH3XMk6CMm8yKrXUH4bU8qe1Kq4k+EMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qloLyOOMpmLGlKxzhaCRDY9QTBz0QsHN+caoDJbutXw=;
 b=Nsi8aTrM+MsQQlBc3tRoT003T3O8+FYr0WFA8WVaTfiOdkhJiiSUf3Y75eST4npxGdTOEGsIs/1c3ipCXAEqne9GCLatUaTQ0tJAsgm0uESjyKPYwkwFK5TJPtR/5Bk3zBByNcxBuHp/E3jkwO4kVW4/ysAQAkSgWPTfwMgnm3M=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0194.namprd12.prod.outlook.com
 (2603:10b6:405:59::20) by BN8PR12MB3523.namprd12.prod.outlook.com
 (2603:10b6:408:69::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 16:40:11 +0000
Received: from BN6PR1201MB0194.namprd12.prod.outlook.com
 ([fe80::9ab:d10c:1fb8:7d5e]) by BN6PR1201MB0194.namprd12.prod.outlook.com
 ([fe80::9ab:d10c:1fb8:7d5e%10]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 16:40:11 +0000
Subject: Re: [PATCH] x86/resctrl: Fix 'uninitialized symbol' build warning
To:     Babu Moger <babu.moger@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, Terry.Bowman@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        reinette.chatre@intel.com
References: <162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <d0450e83-8e31-611f-5224-12742764e4d0@amd.com>
Date:   Fri, 20 Aug 2021 11:40:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:805:de::33) To BN6PR1201MB0194.namprd12.prod.outlook.com
 (2603:10b6:405:59::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.84] (165.204.77.1) by SN6PR05CA0020.namprd05.prod.outlook.com (2603:10b6:805:de::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend Transport; Fri, 20 Aug 2021 16:40:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cfdbf31-19ce-44cf-ec33-08d963f92d9a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3523E21E24CD876BCCE55CFBCFC19@BN8PR12MB3523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zbuZ5EKN2QezZVJ3JhVTlYyxiJNQKREku6NjCwjrIz27xE46GO7fJcuvzueSd8hrQtcXL5HnxA+PpTJyE9geXw3AcvsuKw24NDZcznDxniXheyecLlaa6Xs0NH3TWnDFOgXZs+kr11LTRfpSIasE+RVAOb+IdmjtMfxFLNtq+kqHh+QOEH0dNK7+r1go4ofiJktGSQI1h5H4eo5GAOFYbZLs2Cd/4oR3a5lHtLRVmEbk16z0HEGEl9l+d1bhtBVZbyzCU1en2pPPvLHzOE8UuDB5wXHoZAKNsI+kC9Q8LYf5eKXO2J+PzZ1zi5mtl94f32x96CAtItucRCus7EfDiXjrtc01/FsEtynAhx5hVYfHwMRxP01TNW9TelHc/qyHxaROWymV/fahw/3dTjyaxXTB46SnjBrq4rLMJJwXaoBgOBk1r2KD6+cwbcMlMGtIKL5vz6kjfm1TrFfXn8ivdEkzSf5DqtS4d76NCWyZ1a8J9X1S489v80RSSK8j5xNODYXw5Hc5QxmDrdznsR60q3QlB/u3EeyIdsDLQDIVWIhkudvHqBSFUq+RnawqSSOUQS4gXQLM74bz0WqcSsaUHoROKsb51Hf+zQ+CqlxsK8Ca9SIPSCTaYJmrzfS44hWOWVLgCg7n0Icf/LlEw1NDrhs84Jiz+pfftkDc9sRI8iPdgmhaDTQTRa/8KasRd0wx9Z1GAc66yYoCSbnx4FkC9Z1bAzJi79rH90JtSfioHdUhd/NbPPwIrD6ASa19Mo+zWkWX2KYWtStl0pqVphQHk8D5AmKDxQADdQnUL1xmWwsajZRubNveF5H0FhMM7Bo4wIzbcv0Mgx2qBrXs2eFZtzIYcwpx4uBvGiXyYr/PNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(2616005)(956004)(86362001)(31696002)(8676002)(36756003)(478600001)(31686004)(38350700002)(186003)(38100700002)(66946007)(66556008)(8936002)(2906002)(6486002)(53546011)(16576012)(316002)(5660300002)(52116002)(26005)(4326008)(966005)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ditxd3dyZjdyNmtiME83SUdtL3lNM1c2T3VBQkZ4cDRyalBxQnlCQm4zKyt0?=
 =?utf-8?B?RDJpSitzUkxjVm1wblgyMk92c3pCVlZXSnpZQVpBUWZqU0R3L1A4MlliMHU5?=
 =?utf-8?B?Qm5aWW9nbU5YaUpHUTFsOHgvUm5rOC9pWUJoTldyeWxpcURxSXQ0RmtLQnVR?=
 =?utf-8?B?bmQrTWVYV3FFR0NPRFFKa0I4dWlDU3hQaUFMbzlTRW85YjZCZ3VDYmhkc0hH?=
 =?utf-8?B?VG04MjZ1N1BsS0JmeEc2MGtPVW56T2xJeE1uRExHS2w5a0FuZFBJbnJuRk5z?=
 =?utf-8?B?TmxpYzB4RytaUzYvNnkrRmlEeDBSNmFDMkY5VmNzWFUzSThGYUprclBtOVlE?=
 =?utf-8?B?WStJQ0phUWRtZFg1Q2lXV04vSTgxazViNWY5WXMzL0pTZmg4eDVTK0xkQyts?=
 =?utf-8?B?ZUVvb3k4QmRRelB1M1gvTVFuVGlzMkRtbWhCVkRuSW1FWnFOVnhYMVd1TmhR?=
 =?utf-8?B?c1pCS2FTOHF4WVFndE4vcCtIQ01jNHFWT21uQVFLY3ZlSkRIVkxqd2NmSHZp?=
 =?utf-8?B?OGhYOG5SSS9zZWhpV2Jvc1czMDFrSVB4OHpXY3pQQ1d3UGN0Q29rUThobUhO?=
 =?utf-8?B?RUYzaXBhWjJ3MThJUm5oZ0J1OUFnbzhuc0dHeitQalloa0h5eEwycEtyb1E3?=
 =?utf-8?B?b09sbEJ4UEE0dGJzZE9OeTRRS3N3c2JTclpFWGJVSUQ0Y1FaVDJwOXgraDd6?=
 =?utf-8?B?UWhDME4xRUhTVEc4Z1AxN1N4ZnRmcE8rK3pPM0o0NFZIdXhRcllVVlBwTERV?=
 =?utf-8?B?VHRYQVNaUTdQWi9LWS9hRmRudW52ZS9tUDV2VEUvemY5TmFhTlNtTzlYMzJs?=
 =?utf-8?B?ZW12S0thVmJVQWtxcEZSY1ZEOVNoR2g5b3FzS1UzTE50dURwaXFGdEM1bGVZ?=
 =?utf-8?B?S3FJTXUxaW02Vnl2M1dxU2VQUWVseTlKM2djVW53NTUwZVNORWI2WktiVjJ1?=
 =?utf-8?B?SUg3cUdlaHdSN2t2bTliMDhsS2MzQ1ZjMTYwZ3M5WFMyaUVKeXNjb21NWllu?=
 =?utf-8?B?c0hES1ZPOUVzTnl3UUhKMmhabmkreTFaeTMxQk9TdE80N3Ixa3duOGVPcUdU?=
 =?utf-8?B?YmNFVnF4NjgyL2d0eUFlRXdKQ0lZdzJkR21BV1FrRmZHZG5zU0RrK0VGbmth?=
 =?utf-8?B?VVY2aTJuazE1eElIdjlXeHNMMjlaRDZLejZYaGtDTUEvNCt0Ni84R2drQnRk?=
 =?utf-8?B?NmpCUUxDN3VpRC82THFaZjVOaS80N2Y4TVc1M3BQOGRFSk4wa2xlMFhZY2RB?=
 =?utf-8?B?dU9CMWkrV2c0dXpVS3VWSk15MkhtcUtEVWM3YmV1U0x2b0FIdW0wVlN5V3Vh?=
 =?utf-8?B?cm5vMGdPbkNRb0xHcTlNcXdEeEJkMWVHeWlnUG9pNzQ1WGJmUUFzNi90L0Fk?=
 =?utf-8?B?bEhWeGhlRWZkRVllK0FDcEtEdnh5eHZId1ZPdk8rT0ptSzVhUFJrYWxoalpj?=
 =?utf-8?B?YjJzNElEYndKODVwdUNsWU1xV3FrbzZPSEtLcjZBRm9JRk1ZZEhhcjNtQ0xC?=
 =?utf-8?B?SXdocW9IOUdTUCtnYk14Z2RKNWlKcEM2ZzBBdE80QmpRTFRmNlJndlFEMFZ2?=
 =?utf-8?B?UUhML2NiUUp1OTI3anlBT0V3NjRuZVlXZVRFMi95R3gwczh1aEhqcmIyeVk5?=
 =?utf-8?B?L0FtRDA3QUZ0TUxqQnV4QmpwYjJ1Sy9YZFJSM1p6UHg0YkdsZ3BBOGx4MVd1?=
 =?utf-8?B?ejJSYjNxNUE2SExDT2RBQ1pSNlRKa0s3YkNaMHlmdjlQZ1JRVlhxallqcTJI?=
 =?utf-8?Q?PAT9j9g7HuY7zifuBPWVNggkSXtnQxx2YVf6/Z0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfdbf31-19ce-44cf-ec33-08d963f92d9a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 16:40:11.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxwiRQu070s08eezvnF9qQwOZl4CM4UXKVmjHnDauIxOiJ6R07KODcgsRXbzDmFU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 11:33 AM, Babu Moger wrote:
> The recent commit 064855a69003 ("x86/resctrl: Fix default monitoring
> groups reporting"), caused a RHEL8.5 build failure with an uninitialized

Don't mention RHEL in the commit message, just use "commercial Linux
distro".

> variable warning treated as an error. The commit removed the default case
> snippet. The RHEL8.5 Makefile uses '-Werror=maybe-uninitialized' to force

Ditto

> uninitialized variable warnings to be treated as errors. This is also
> reported by kernel test robot. The error from the RHEL8.5 build is below:
> 
> arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
> arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
>   m->chunks += chunks;
>             ^~
> 
> The upstream Makefile does not build using '-Werror=maybe-uninitialized'.
> So, the problem is not seen there. Fix the problem by putting back the
> default case snippet.
> 
> Fixes: 064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")
> Cc: stable@vger.kernel.org
> Reported-by: Terry Bowman <Terry.Bowman@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/6118d218.4ZZRXYKZCzQSq1Km%25lkp@intel.com/
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 57e4bb695ff9..8caf871b796f 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
>  		m = &rr->d->mbm_local[rmid];
>  		break;
> +	default:
> +		/*
> +		 * Code would never reach here because an invalid
> +		 * event id would fail the __rmid_read.
> +		 */
> +		return RMID_VAL_ERROR;
>  	}

It used to return -EINVAL, you might want to do the same?

>  
>  	if (rr->first) {
> 
