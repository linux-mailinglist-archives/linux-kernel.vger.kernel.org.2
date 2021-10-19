Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34358434207
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJSXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:23:05 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:52801
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhJSXXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv2QCofqxXtm1kNeJOb0oiUQrR7tkypBqgD81QOqwJ7vQ4RnWM2nhNZ7Igmc7jsco3SmtLqm8J9lePkM64ECScYCbLRMzL/ZGpQBYA4eFHNNdtDRnqj2xrlOB3eUVdVVfwIY10uhLlsT5kYJ8umT2tOayJo56PRhQq+CbabRsHyBb1Ag4CUgFEwltDnkY/kt83yFp+cHrn8bfjfRpKkqU4vQS2mSLI82Jw56ZMlqdP8NGLzCGsAP2g3qsmbJNBTuxqxFivbClR3xBwyXSQZlsHSdhHukpppHzKoJTDHVS1nbPYV1qxzMjZhwvMAiAAetJIFmeu9WICoXjEMkx8xSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCEYF7jhMii5g4M6Ypb5HSjcM7DWLbQthpOYJ/lb+mI=;
 b=goWCgHOgIrv+WPcZqkIbiXrjjPiptTLd0IiMdXAEmj5W3phYqkmaDql7NKnK6uJ9aCl19CKFWzE1BsqA7ErSyqjzYdjCZab41iVIR8WCy3D53SQUBCpiXExgHGDO3xupWhokJ1kDa9JQykcaUCw675Cog6sEEVwLevAbRv/dY4uXQpl/3wiHDVE8pwKLkdrQ/+y2T5ZKNIqwb7i1/bHW/hnuRJXSdhVFl6Bv0iWdk4VYXUQV1iK416MMrcZeGMybnd3BV6XvbaGmbw4uitmzh1rHxhwU6EizZkhaSMOBNeby1jpFitUE/zbfn8U4pHCRl8yY2xv/YrP3npxL7EvPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCEYF7jhMii5g4M6Ypb5HSjcM7DWLbQthpOYJ/lb+mI=;
 b=IrcDG0VCQNB40exStBF5sbnsIzX+Uz6TvZ4fqRIAvT4t8wH90vVJV+FbhWE4tbx9Tha5jYWUQYFdpUUs61Zi9MmhMHymQCVO2X6/3wGZJjNwlxyma3RFIoktBavydbuf3DtS97yj9KwUOkKBXBF3Hb6kc7eN0G8PVe2wv5Myius=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1168.namprd12.prod.outlook.com (2603:10b6:300:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:20:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:20:47 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-18-james.morse@arm.com>
Message-ID: <887f8946-6d2b-27bf-a49b-f83af05cbc68@amd.com>
Date:   Tue, 19 Oct 2021 18:20:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001160302.31189-18-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 23:20:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b54064d3-e48b-4ead-5088-08d9935714f3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1168:
X-Microsoft-Antispam-PRVS: <MWHPR12MB116808656C33E1B05DBF126695BD9@MWHPR12MB1168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suZi1XFCoTTMMCnMw/X6UTtw7i7kvbGAoZTgirjicYcwWq8XMKVI9vvqksBZSNmh4dlUUocvHE7LpikkGlMp3tV6vgqGEvVeokrO8MG0VH1PyBlstkit8JqYmil9T6PQQvoCRSR3r+1KTk/yN5UT5FCfbgSqmuPd9d9YTeaMWRBQRQFIcpueULqJrJnHXsHb5KMDTMqpmHW9KlajmN7kmQ60us/h5DLI4h9BowoE7e5nM9sH3G4V8LHTBAFIT7INoFlOZg7eHRz97r5CK6tfDU3Na3642oIU/8UbDiOy/u8StYHTHQtodYEwFhhAoL5Z9qDP4sph1Mig4+XItiCRt4HTxQJsIuC3btsufgtxGe12oPXj2PunjtC3n8d/vxHYSBe2u9/2WLMN7sJ1efnDqbX+/27FAkiMac8AqIg/EHZh9iPP4Aob7sJz4A9Sp/jALI8PFldVttoRQVhT734oc3H+6wJ5KoK/Z2nam+C0gFfF3b//YQpGZOKZu+bdsyxwa8qJi2OgT8ww25dWYWkVmI5K02PoYuOtWk9lJt8p0+z2nsNcJieSgriQyh6Xj3riAQz+Yiz59eHgOxHp7hPSaKYe6o2rQ5DzrHHbmqzODxVRTIhwX6LyMlNJE1x9fUxBP9cV5FSNfN83sM3keCH1bXgGatpuxAT+4/A32FH4AJCzJ4rjvDNM+jz1KXiOuOs/WgZjz448t34QOqKwLZ4OW6RkvSu2s2AyftAZ9V55qWzyItar29FjsQR+1MuwGxJ8D81mSjdZ+jIY5tfUhgJl2yxK9sh47gUap5YOypqUoGtag+8jRtTMPuxjxVEkJV2p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(38100700002)(53546011)(31696002)(26005)(31686004)(83380400001)(8676002)(6486002)(66476007)(956004)(508600001)(66946007)(186003)(44832011)(2906002)(66556008)(2616005)(4326008)(5660300002)(316002)(7416002)(36756003)(966005)(16576012)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1BCbmk4Q0ErSGNEajI3Y3YxejVuQzNibmhpcDd6TzlYaGd0NXNQa2tlY01a?=
 =?utf-8?B?clp3U3dKc1RwWGZwMHZGYzlkZW5BRFB1KzQ1K0xrNWFmRmVqbzJTRmJ2RFUv?=
 =?utf-8?B?ZkM2MEJTMU0vc0VZNkxKRm9lZEtZT0t2bjNXVUdVNW9PcDRZSzlmWGxGOVFO?=
 =?utf-8?B?YUZqUzVDa3NWL2h1LzJhTmpRQ1NwSnB0cVNudW1hb0NHUjlNQ2lUR2tsNkV6?=
 =?utf-8?B?eWVUeDd4bGR4eWZ5YWlxcWxDOEVoOFd2cXZGcWovWk1mZGVvNU5qQ0YyTUx5?=
 =?utf-8?B?MWZjVmRnUTYydThCeVNYTnJUaENzQk1kVnpVdzl3L3dHRFdEQ2JBelA0bUFP?=
 =?utf-8?B?ZXBxUmN6dXA3N3UwYXVBZ0h5SDRFY3BUMm1hQVhyaFJyekpXUmowWGpNem5M?=
 =?utf-8?B?aysvcFBOMEd1RzU2WlR4TzNTakx1MXMyRldOdHV1RXU1eG01VzdxNG1ha2FL?=
 =?utf-8?B?T2Q0SEpLMnVROTBMSk9Id0FyelJTQ3lFNzAzVUloMmlBNnptK29yR09sWnFH?=
 =?utf-8?B?ODlCVDNHYkg1cUpvODN3NVVDVG56YVhyMUgwdkdJdTI1UWNYQTdqMzBRS2Nm?=
 =?utf-8?B?UnVMY00zUlRKZWg2Y1lMNU5temlSOGV1Z1VjN2lOcXFxb2txbnlHLzBlc2w2?=
 =?utf-8?B?NGJjMEcrQmg4YU5Wa0tSQ2FIYmVsK2hCbnV5MHBTelVKV0hjSXlLTExUZG5t?=
 =?utf-8?B?R2FWWmtpaHB2d0JiZXJPTUkvc0FnUnY2VmhkT0FPTDNxZUxzLzBFeEZLbnI5?=
 =?utf-8?B?bUJLSnp4MG5ydFZGeVV0Q0t6dkcvVTlFT1hHekdPUW9QSVQ5cFQxMytlMFVK?=
 =?utf-8?B?dnNnazRSWFdJOTA2eG15TVRraWJpT0VzaFdDcktWeW5LanQzODREaEdzcDQ0?=
 =?utf-8?B?WmZyM0RMZm8venRxR0hFaytudVRacFppemZMRTNWYjhxNzIrQ0tJV2tzc2hN?=
 =?utf-8?B?SUNGYmhrS1BVTnlaYWs1S0V0NTBzVThtNlVHYyt4WUIwRkhZZFVBdnhEaExt?=
 =?utf-8?B?b3Z1eW5iUnlra0hZajhyNWcvWmo5TGZJcTRkYUdaSU5BbkRKRCtWelV2M243?=
 =?utf-8?B?NTlmR3lmc3pVRytzOGd3dUN4ZGExb1Jlc0NzL0J3VHZab3VoblgrK2JoV1ZR?=
 =?utf-8?B?L2ZhS09pVkduQlRPdzNIMVZxUUloanNmWjU1SXlBdFhZU3J4QW1KN2syOFF1?=
 =?utf-8?B?by9vd2Z1MVVDeWcxdmJxVjBaZy8wME5LZ0ExcmZoWFZhdEs2MEc1VXIwTmox?=
 =?utf-8?B?eVZUSmt3T05JcDBFc3JZVkhIQVBzTE5UZnVRa2dlVjlaYzk2aDJBYkNwd1ZB?=
 =?utf-8?B?bHhaaDdtbmxESGs0encrdWY1Zjh5MXU3R1grZTFTNHdVVEVlUVUyenZMN0Nk?=
 =?utf-8?B?OHdITjVrdGVEc0d4SWhVUytWNFZZb2o1THRkenF3VENHVHQ3UFhVTTUxZ1Vk?=
 =?utf-8?B?M2MwSGEvZDNubWU4QTh6a0ZHaUtiM09zZ1BabTlNRnduK3RLOS9CYWRDNjl2?=
 =?utf-8?B?SElwQzlRaVZtMkFoR24wRTRwWm5keHpaNXBUQmVVRkI3bTViWnRlbHZZT3VP?=
 =?utf-8?B?Uks1UWRFNUlpWmFJMVh0MllnTlhCVGtKM2JUVnpkQnJrUXVUanZnMldDRUQv?=
 =?utf-8?B?WENGMEUrWjBtWlJLM1Y3MGZaY1lvMStaTjJWdjFmeE80b2xaUzZxMWpyYitG?=
 =?utf-8?B?RGVhTHgvU2lhVWQrK0JBUUs1eWYxUitUNWFhWnc3eDZXcVFKV1JuUDB3cVNw?=
 =?utf-8?Q?4QK3+Qeqz8pPHBD5DMHpXCagzJ/wMgONoyRC2UP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54064d3-e48b-4ead-5088-08d9935714f3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:20:47.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/21 11:02 AM, James Morse wrote:
> __rmid_read() selects the specified eventid and returns the counter
> value from the msr. The error handling is architecture specific, and
> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
> 
> Error handling should be handled by architecture specific code, as
> a different architecture may have different requirements. MPAM's
> counters can report that they are 'not ready', requiring a second
> read after a short delay. This should be hidden from resctrl.
> 
> Make __rmid_read() the architecture specific function for reading
> a counter. Rename it resctrl_arch_rmid_read() and move the error
> handling into it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Return EINVAL from the impossible case in __mon_event_count() instead
>    of an x86 hardware specific value.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++--------
>  include/linux/resctrl.h                   |  1 +
>  4 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 25baacd331e0..c8ca7184c6d9 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  
>  	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>  
> -	if (rr.val & RMID_VAL_ERROR)
> +	if (rr.err == -EIO)
>  		seq_puts(m, "Error\n");
> -	else if (rr.val & RMID_VAL_UNAVAIL)
> +	else if (rr.err == -EINVAL)
>  		seq_puts(m, "Unavailable\n");
>  	else
>  		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);

This patch breaks the earlier fix
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.15-rc6&id=064855a69003c24bd6b473b367d364e418c57625

When the user reads the events on the default monitoring group with
multiple subgroups, the events on all subgroups are consolidated
together. In case if the last rmid read was resulted in error then whole
group will be reported as error. The err field needs to be cleared.

Please add this patch to clear the error.

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
b/arch/x86/kernel/cpu/resctrl/monitor.c
index 14bc843043da..0e4addf237ec 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -444,6 +444,8 @@ void mon_event_count(void *info)
        /* Report error if none of rmid_reads are successful */
        if (ret_val)
                rr->val = ret_val;
+       else
+               rr->err  = 0;
 }

 /*

