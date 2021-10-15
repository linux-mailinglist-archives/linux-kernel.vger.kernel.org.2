Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1433842FE17
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbhJOW3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:29:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:9936 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhJOW3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:29:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="314196833"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="314196833"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="481859455"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 15:27:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:26:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:26:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:26:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsVLZoiTxrs1745b7iHakYGRsBsZ4iuOlqATLxOId7IU1W7iAftEqVP+1KT06movbVMn6qZPMAQC57lYeSPpj3CO6h/7Snjjc2H+3vk8XrMfDbbTwooy+IQnwu8CsN5iS+99QPeScrL5e47rx9x88NKgJggm832I9yeKWrdstYSuV75JNuMQNEnThmaSgCjBMGiGP8weOP+5ZzLevs81q+nPlyBU9dvhjSiabUhg0/1o3UKwV2mUU5P1s3tkyWdBp+Bu5G+USPJrhnQYi3GvF/PG8gRXl77JMftz6Yd+6bgQIxXsGc/Z+hhAMgWmKkKLbasR/+82WnWOR0nm0CWtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x95I5RL5LT8fTotxDDhXPdaWQvgdrNisIQl7R6FU3mw=;
 b=MEDCOL1HjmtRy/cmwfV7z3+e6tmzJkayeKwemm4l0WLdmMkKsxzHchoum4WTiUeC2TvJacoGLsZDCFVS2RcbNmkHxVu1QZL/8JI1GeXa/TteEB1VNjoQyX0aFkTCth5Q6zNE7BuvIV2VnK9E7Ar1CpgEChh3i6cXGsxdJZmJ9N6iCAFI78G8TeyagNHDzpTK9vBk/8bIVCZwI6wm1I3LrOafkKHfod7YwVZv+4r7+xWRNqkqAYiJF+OQwqnA7P34uyM5Yq+GcCnCaMLKiknB5npe+IUgdKCOsq5HBYkRbbkMHh8wz7SDGNln6ETGv+7b+esYwPbaCdJEOaaMR9B2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x95I5RL5LT8fTotxDDhXPdaWQvgdrNisIQl7R6FU3mw=;
 b=pUxG37ytoaTrqsrLH7OLQu66Q3Fu8PZw6Q6q8l6Bkge0kvRzfUgCTIlUVbzhtIA90Wv6nPHi++q2X/PBUTKKsSNBNIkTXAefF9QHbaSSZ12GKBsCHOPTzvQypZaTzv1gGW+JuqYSieIQ86qQSSV9/4bSRF1BIv6CUEc8YSXWZVo=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:26:56 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:26:56 +0000
Subject: Re: [PATCH v2 09/23] x86/resctrl: Switch over to the resctrl mbps_val
 list
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <af0d23a9-61b3-8a2b-7f4c-4d2d6d510238@intel.com>
Date:   Fri, 15 Oct 2021 15:26:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-10-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:300:d4::12) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR19CA0002.namprd19.prod.outlook.com (2603:10b6:300:d4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Fri, 15 Oct 2021 22:26:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53b0086c-d831-4e1a-5dd6-08d9902ae54a
X-MS-TrafficTypeDiagnostic: BN9PR11MB5291:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB5291525BD241022FE9A8C9E2F8B99@BN9PR11MB5291.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgweHIJxBpjwy4NTjxnP6p7SJlBDdLaCXEHlGjX/SoGRdZK5webKiVOMSL0wqYJW4tHsuGnovXazw6rTcR7b8TdmIkpYuRNGDaMfr1Xyy5OmnXZyD8tZ2QnGe/D+zUVo8jO6sTc6nQqr9iB7LePF0WJEBxR2GSee0IVurD9CiiyaX24GC35v5bUHpy6ZnKZadRDJdx83gMnrKhRQ6E8hy/LuVYoz4jw8BPbT+lnmXT/Q8fRGCQEuipERd7sqjnxCZ07xiRYcWXXUeJwKzQ4S5NAZJn1S92zh/h8T94IgaDpUC03uJVp/8V7lVXUTycmZFED+UDs9pZObHBtd+xvCJaZa3L2HGkToOOnztX6pEePKIi4IKv5BoQbmpDIpkAFlBDGX+Pz3xPuouRYaD6lEKJJbgi7JgQiLWWlPEKOQc0JIIvt28+8/xlSGj1TS3EHaY+AxnazVIvLgJflPDu28vvx8xIL3OlUhs4ENkjaIZE8tGuMS3RthCNShtiEL6vMMGXJckBmgeqqJD4KieZ8Uc81uLXj7aBWJm/YIWcxIgXyzVtCpHnWJCuI+o4jrjUUC2Y68iCkv/GMYbwona0nHXiLV/m6AdOU2+mnXOw7v9Oi5bZQFCu8IoFY31DCUwC52caiZhVGYtvXEIlctZHcwRL8G4xuQR4jPGIHuTBYh1AJ1KE0MuU0s4SzS+Ksub2BLBzp7GJMA1OZZM0MiYW/d+At7UcMtreg6plh1488NJdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(31696002)(44832011)(54906003)(8936002)(38100700002)(2616005)(956004)(2906002)(66556008)(508600001)(16576012)(6486002)(31686004)(316002)(6666004)(7416002)(83380400001)(8676002)(53546011)(66476007)(36756003)(4326008)(82960400001)(5660300002)(86362001)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpmazFtTmhWRW92b1FpcDNxZGJMdkFvZ0xQLzNUUnRsV3QxbUNwU1FTdDFh?=
 =?utf-8?B?MWswcEFDUkt6dG1HQ0FHSHBvelZyRHdlSkFoZ1RrdlBEa0VjMVZ2NmxueVJz?=
 =?utf-8?B?aHhBbkxSUWtKVlpGbWpGVk9oZC9iMzBPaTh3UktUT3pVQWlWcEJydmtCR1Mr?=
 =?utf-8?B?cWZ6NkgxOUUrNHdmOVJUaU9rUU8wN3ZxSHZIRUpWOXo5RFRPcVFWVWlXY2lj?=
 =?utf-8?B?MnFNRjJtREFUdnJRU1lIbkxMbHQzZUhtQXhoVCs1RUYvUFo3QnhqWW85bThv?=
 =?utf-8?B?bngzak02YU1pc0xZUGFId0JNKzlFcWJFMVNCV1Fid01SMDBNdUF1alYwRUxW?=
 =?utf-8?B?M3FxUnpKeGdTaC8wenB4bWZJclFiK05SUkcvT1MxUThBdXAzenFmd0ExQkl2?=
 =?utf-8?B?SG1hNTQ1ZlRPdGdIQ3lIelF2aGZZQmNiR0doWkMxakppMzZCeU1qSTU0bHM3?=
 =?utf-8?B?cUFwT2hRaC9wOEcyazc3aVllMy92ZGpFeXpyV0NDSHBMZW5VRTJ4cHBmcDJs?=
 =?utf-8?B?OHZOYkJhYUdyckpGWXZxalhLRTRNelJsWEhGdDZIYktmU1k4U3Qyak9wWTBM?=
 =?utf-8?B?YUtiTlVSZnBGby9CWTJmWnAwdExGSnhtOGk2Q0JScFBSb2liNkZyV0hnL2R5?=
 =?utf-8?B?UXIwVCt4L0tNVnlqalhhTTdWRVJjK3Z1dldmc2ozV21LWG9zeWFPKzd3Q3Zj?=
 =?utf-8?B?N1hJcVNYcExaNUNwUlVybVVtejB1d3VqV1hHdE5rbDd0azRta0dTcjh4ZGh6?=
 =?utf-8?B?Z09DYzIyR0x0KzdaVTd1eVZYbUFhelBwKytGNXdZRitlSkUrcnpOVksrR0Jy?=
 =?utf-8?B?bW9ZRHYyOXBOSFYyTHZxZi9nQUNqbldJVzhLbVFMSENlVVR1cnZ4RUVEL04r?=
 =?utf-8?B?S1NOR29qbVJhS1VDWmJCOTBIbUhMMWJldmtsWXJHMURkUkcrYk1VTnU5aVo4?=
 =?utf-8?B?bjFYaHJ0MkpibkhaZDhFRm1KdjdJOW5zeHAvd3kzWTVPbU4zT2o0TStPSWlj?=
 =?utf-8?B?SDJDMG8xcWw5S0dmWGQrV1Y4emp2SkpxUE0xdGhqRDN1SENyNEhoWFhISk1v?=
 =?utf-8?B?NWlnbGRrYVVVckdITHVoSWIzYlpjaWtsKzJjQTZkMmJpZ3g5WE5TWU5jN2Vk?=
 =?utf-8?B?cEhlOUV2L0o1ajRqL29KVkdITzhLOEFSeVMzc0xPandTakRXZ3BhUjFpcDd0?=
 =?utf-8?B?YURiQTBZeEt3QXZmeVV3MFpRY2l0RmhVcllPTjNGZWpGYjVjUDFoRE5sYlZN?=
 =?utf-8?B?N2RVeVpET0pXV29iRGs0MXdwU2ZvRUlCOWJPNDdxKzU1ZWkvRUJ5WlNlRDhI?=
 =?utf-8?B?a3Z6TGl0QUxmeml2ZnFKQXVwdkxNb0l5Rk1tZjdsZnhCbzZtTm1SWGEyTzEr?=
 =?utf-8?B?TUNlekpCT2hxcjI3NDA3bGFJUlVRT1hXaURyeVN0a3dwSlZkWERoUk92bXlS?=
 =?utf-8?B?SVRpNTZsNndPeHhhczdueFVLYlp2Y0xrLzQ2N3pJRlNwUDZsWk1IclJxOXhP?=
 =?utf-8?B?dXVJa0dIV0ZnSWFReEJCYzhWNGtURklYWGZmNGpsYTgxNU82cDcrVWVQRitK?=
 =?utf-8?B?QTNHWmthTk5NRmc3Qktjeml3dWJscTZzelpLL2lhaUVnNTZJamhkRHRRMG5O?=
 =?utf-8?B?WFpna0RCc2ZrOVpYdE1xRU1INWxwZ3dFZVZFTHZNRWVUc0l1Vm9mYkphR3Vz?=
 =?utf-8?B?SHNoRDVTaXlYMnJWRHRwazNucmxsTEt3VkV2NE53RjBQcC9rSmN1T3VuQjB1?=
 =?utf-8?Q?VHLuX+s4qT2MXdR+x9wg2Bdg2wS9RbwyDQH+9t3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b0086c-d831-4e1a-5dd6-08d9902ae54a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:26:56.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hADE71wTJxMIdbNIgxfqgxVhMrALfF0UeIV/d3Cg2QFNmYyhQ/KfHGGBCLFVeWXylxFIjF2Y2t/xPsEeGk1cV8SJlwZM7nJDtAgycs1yJJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> Updates to resctrl's software controller follow the same path as
> other configuration updates, but they don't modify the hardware state.
> rdtgroup_schemata_write() uses parse_line() and the resource's
> ctrlval_parse function to stage the configuration.

parse_ctrlval ?

> resctrl_arch_update_domains() then updates the mbps_val[] array
> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
> call that would update hardware.
> 
> This complicates the interface between resctrl's filesystem parts
> and architecture specific code. It should be possible for mba_sc
> to be completely implemented by the filesystem parts of resctrl. This
> would allow it to work on a second architecture with no additional code.
> 
> Change parse_bw() to write the configuration value directly to the
> mba_sc[] array in the domain structure. Change rdtgroup_schemata_write()

mpbs_val[] array?

> to skip the call to resctrl_arch_update_domains(), meaning all the
> mba_sc specific code in resctrl_arch_update_domains() can be removed.
> On the read-side, show_doms() and update_mba_bw() are changed to read
> the mba_sc[] array from the domain structure. With this,

mbps_val[] ?

Should rdtgroup_size_show() also get a similar snippet?

Reinette
