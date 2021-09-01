Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E13FE4FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbhIAVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:32:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:42413 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344756AbhIAVc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:32:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="279884686"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="279884686"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="461096753"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2021 14:31:30 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:31:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 14:31:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 1 Sep 2021 14:31:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrKthoL5QcsVuHrBcw/dMbua2frt5aAgspfChLSQVL2/yWE3GU9kq7AIcdd9v7jkDQwkglBvXkEtXIbPczaI4kAAi//0679c4aSAVgv4QOqmIhhRUrv6PIqtJgAv0TOnBcHFTFUJApFkOE5st7qmuNHecaZpLEFIY5XrPrxLd+p+H6xg4aNrjfsA9naxp5uv5srsx+m5J8+EQraExAw+OTqBsTZbHJtgC1MNlltrozVcZ9W5o7zNE66SJJrEzJLb+er91keqFgJs6qaE9u233Tkg/VQdQoL6vnfjOLBJFeS+jWQO1BF6sOaoIEnjEoYA+6d4kqV9TXUwqzRCQ8/1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l95ZoFUpMniQSOoQO06URfDZJLkIkeZXiqiykA7aHv4=;
 b=Uwm3EqyWGGbAhjnKW1sdCpkypVvzCM7TsPkg/Mq/O5ri4xNCG+AXyQULpIw1IFi3N/+mbVeTJ/dkCyuYQgnEVkU+02dyjaItLytxJWxMpW/MZvc8MKhqSLsQ+rXcAUlUqmP9XWzBTVblvfZaP99zfcc1dnkKKLWlz1DqV6LTYknwhLZHtB7xkUFs7WOIrkZNH3XA+HCxANtB0DpNUDcUM5pnNF1+YAPSq1Xi73GWMGvWXup4PudmVvF06PG8o5JDSzFnKiALLW2PpD/Exy4/Uijgf4HDAbPIwI/5Q2ET07lXBqNa9Gd99BrPn/aM01oZcg6A5pYy3CdENGFNQ0pCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l95ZoFUpMniQSOoQO06URfDZJLkIkeZXiqiykA7aHv4=;
 b=foy5yzJN7di4JDCpsNaABdy9QmOfuY25KLAijVM1YAqCZqR58wm0KtjM0/3aCGOBoNqpJODW+LVVaS66ALgWUMDVw7KrZBV0WD2b6+/eXAP/WNS2h2TYhopeUf7OyEW+lupbnLTMD0HGG2wTrqEDZIio5nKsIHhmpB4OKAPXY1s=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1905.namprd11.prod.outlook.com (2603:10b6:404:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 21:31:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:31:20 +0000
Subject: Re: [PATCH v1 11/20] x86/resctrl: Calculate bandwidth from the total
 bytes counter
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
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-12-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <15febd4d-11d9-8456-60ee-994e66efdc98@intel.com>
Date:   Wed, 1 Sep 2021 14:31:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-12-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:300:95::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MWHPR13CA0039.namprd13.prod.outlook.com (2603:10b6:300:95::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Wed, 1 Sep 2021 21:31:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 278e06a1-a7de-4482-2661-08d96d8fd6a7
X-MS-TrafficTypeDiagnostic: BN6PR11MB1905:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB190539BE5A0E9A1A699CE3B8F8CD9@BN6PR11MB1905.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2tkcUGpVEUA0RTIqkgP4TYrBfsBC4ZsoTYLXvFg2vLTdXE3+MhUgKudn6hKJJVJ0SYw7332cu2VdDscNeeJ6CHkarehdz8yq22jzZsI9iBzEmPkzi58dUdi7cBNCixH1HsHvzwODuhb1pTZRF2yZKYQSsIJxjrQs68wntF1OnfMygSVC/hNOBBMtShszBg6qoBUTcem45M0I9b0/PijWVzYBcDyfMpcR2eEgQrdusZC8RbAa67+TGtiLHUQAA99hwUJXmpWs3WaXUvDnCMUtH5vpUp4X/IIBJ2ULUMs+AvAgM44bRhGO2p/YBNs1Yp1oEXb5IogkJ2qRONcdJrFTkmn57BLduwVc185qTc53Lh5PQ7+9piDKu13rmOfyUQYvF5iERP8MkQrugbFi6f42aMRwJqTKqb1rL0S3DcxB32OkULEeC9rSr+tSsmR+9rtasBuQ+/uX5x6K/KSv4NAX+xpwhG+JMXM4FPhbpeaKoYENWgS8Yj/x5NKCTTlJnoZoXWUHHWm9z43l9+NSlqL2NfLLsSy64D9Y6acnMwgDD1DOTr2UkBwfoGjO3VPvDqXzrMwggXevinUbUjq0Q3yb8qeMOGC42e3nUU3k1ilny6+C8uIPtuvXnTOBTlw+zL+YgpduRTIfYNg53n9J38eVM0218FRwsEVb+Kjh7rg5BQCrnTmBwly9J7AjzvTD5eq0HSwScZv+iKQaBajpUs4kO0bsZoPxlJAI38cUFWQGGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(53546011)(31686004)(8936002)(5660300002)(478600001)(66946007)(38100700002)(66476007)(956004)(66556008)(31696002)(2616005)(8676002)(54906003)(316002)(16576012)(44832011)(186003)(6666004)(36756003)(4326008)(7416002)(86362001)(2906002)(26005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1huZlk1YThpTGRWSjhDZ05ZcXVHWnpaQ1VtN3kwbUZXT2NqN3R3bG5paU9Q?=
 =?utf-8?B?NkNXSjRhSmJxODRoMzNpT243aWZWNDJLS0VNM1I5WG9qMURYSjFLNEovMXkr?=
 =?utf-8?B?OXBVM1AvZ2lyenFKRDZOMFZCMGR2UXBvU0kzOEVsb1NsaTZlb3h1UjZENzNq?=
 =?utf-8?B?YWE3RXhLNmRXK0Yrajh5RitNN01VZWdIZVB1RDBuZ2xhZ2RtT1VOT1ZqT0Ux?=
 =?utf-8?B?SjBITFlhQ21zTmFyb255eGRLbEl3NDJRV1JuWUliY1laYmJZUHdlOXo3RjFo?=
 =?utf-8?B?MllZN0xVUkQyK2R5VHRNN01rMUZYT09lSHlPVVMwMWo1VmVpUmNBU1o5R05N?=
 =?utf-8?B?bGcyQmhFTFBPMUVYL29QOU1qajkzMlgxTUEzS1UwT1lmMjNCN2pOalBDelFi?=
 =?utf-8?B?YXY1S1IzQlFMdW42ZGlUZXBrRnVLMUFKbmtnQWVzM3AxSTdqaTg2bXJteU8w?=
 =?utf-8?B?VGxHMDQrWFI2aU5sRVp6VzNteEwzQk93UkdGTXBFTllXdDhHMVpTRUtJcWpu?=
 =?utf-8?B?T2JLRGZZM3gzTTRXUWVPRkwzRFhId3ZFYzdsMkhsQVN1VlNpOFpkcStUMlNq?=
 =?utf-8?B?NlVmbHJQMmN5T0NRTXRTbTc2R3haeW9HUWIrUjViUzA5aVhyRHR6NUdPaTJp?=
 =?utf-8?B?V2ZpMnB3ZDg4emxrWnh3VnFTaDRVcnd2RWtwWEdUb2owL3NDazFCNTd1RVM3?=
 =?utf-8?B?a09DSXBVWFNtcGhEQTJxZ0hlY2RCeERSd09WM2I1TmtINStwTUhuRGg3WjJC?=
 =?utf-8?B?eFNOZ1pSWkNVUlo0SHRMUnRKS3lXSjlnenVZRjBZaEI2Z05JVzhNRlB5RVRK?=
 =?utf-8?B?K0lWM2d5TGpJbnRrN01kQ29STUxNMzI5YjE3VmthVWtQbHNLTXBwL0xVUVZB?=
 =?utf-8?B?UWZ3Qmp6VEpaSit0OGVsUE1Xa1UzejBPQmdROWlSZTBRMCt2b1p3ejFEbFB6?=
 =?utf-8?B?eWpXTmtmaFNRdnQvaHMrYkwyUUNqM1dlZjVDRmxiVlNuLzJNbldrLzRhbmpU?=
 =?utf-8?B?aDhPRTdJN3JYYnRyWHZSam9KdG9zcWJjdi96Yy9iTkd5WTVubVZNQ0tyanBS?=
 =?utf-8?B?enBtTTUwRS8yUmN4U2ZlaUNiK1dJV2JsSm5ub2p4NDJ5L2hsdU5ERXFOZ2d4?=
 =?utf-8?B?R1NmWEl1NjBsOGxnM1NJUlloenBOYTJROXdoWUp1a0lmTnRpaCtBUUhpTkZ6?=
 =?utf-8?B?Zm9xNmVVNE5hbUpYaW9GMzVIcU5UYUVZTldnN3VwdVZZdDA3Y1AzVEdjdlJq?=
 =?utf-8?B?eURBMnpuR1F0cHhrYitqcVZwNzEzRTdaY0kvOW50N1J4R0Y5bHFTTUxtTnlZ?=
 =?utf-8?B?UHhna1Fjclk1WVZCVWlwMmZzT3h5My92bVBBU04rY0dmeWs0UEprRjNxVUh1?=
 =?utf-8?B?NkpTczhqNHdTQjJHeDFxVnBNbHNMZjZscjFiN25WcW5pYWRFRXVOVW1GTzh5?=
 =?utf-8?B?a3dUTjBCano4SVVoYnBXUjZxUFhoMUxxOStPUTNzQmRJSURaMmtaWW5WM2xs?=
 =?utf-8?B?U3lzM08rbUszZDFtS2NZeUNIYmx6Qkp1WTFKQ3VLU2JRQVJUenJlZ3N1ZWRI?=
 =?utf-8?B?NWU1UGkyOHNsVEVqRDlxVHAwa3FsUFUvZ2JrSyswa3ZidTZxL3p2U2tTV1Bw?=
 =?utf-8?B?YWY2MXBaaGJPcHBHU1BnYWtmNFVMVGZHblJnK212TmVjRGxlWHYzUmdCVVpB?=
 =?utf-8?B?VHlXdUV4RFJKeVF2WlRDUkh4SGpBL29EZFVyVXFVN2lhbEZCb2RiVTMxNUNi?=
 =?utf-8?Q?cMBFbkuUOtgAmXF+nO69l5SnExTEknN/s81OkOb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 278e06a1-a7de-4482-2661-08d96d8fd6a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:31:20.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5u5gdSb4TJI/QLo/vusICZQd/+92igLJpdXoHRYEcEgvllYuzJzXHYd4s3nUVUk7mSBGSu8oTXgN1AoBusdHAPZU6U4x5MUjvEMK8wr7zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Apologies but I find the changelog hard to understand.

On 7/29/2021 3:36 PM, James Morse wrote:
> mbm_bw_count() maintains its own copy of prev_msr to allow it to
> calculate the bandwidth as the number of chunks counted since the
> last time mbm_bw_count() was invoked.

ok, I understand there is an extra copy

> 
> The prev_msr and chunks values are in a format specific to the
> architecture. MPAM's monitor scaling can be enabled for some
> counters and not others. If the value is changed once the bandwidth
> counter passes some threshold, the prev_msr values need to be
> converted to the new scale. Having two prev_msr values is a
> hindrance to moving this logic behind an architecture specific
> function that returns the counters number of bytes.

Above talks about format ... it is not clear how it connects to 
introduction where there was mention of an "extra copy"

> 
> Change mbm_bw_count() to calculate the total number of bytes the
> counter has seen in the same way as __mon_event_count(), then
> calculate the bandwidth from that. prev_bw_msr is replaced by
> prev_bw_chunks, the chunks value from the last time mbm_bw_count()
> was invoked.

It is not clear to me how this change connects to either the extra copy 
or the format comments. It describes the changes made but it is not 
clear what the problem being solved is.

It is also not clear to me what the impact of this change on the non 
software controller flow is (where data is read from user space). What 
is the impact now that these two flows no longer track the previous read 
value separately? Would user space still see similar data as before this 
change? How would the software controller sharing control of prev_msr 
affect the data?

Reinette
