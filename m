Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0C3F21B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhHSUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:40:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:22113 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhHSUkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:40:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="280378752"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="280378752"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 13:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="573725611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 19 Aug 2021 13:39:54 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 13:39:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 13:39:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 19 Aug 2021 13:39:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 19 Aug 2021 13:39:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrZc7WMdUZgRRAv7FehO7YdZDZqa9q/fIUurQHl7CDXKu5kY+qZ6P5hxCMn42/reKiYoptsUHq+r0Dfj1OfKoI18jO4/BsX86Jb7z0uica9s7mo1eS5bQ5NSD3GhzfEIOP6beieO7Dl3X3bGL0MxEnZ0r5hrI60qxGLmhFvL1EeDbnz6Twg8j9O+JsQZnPe/LPqSVS+SvgXUigEhnaOx+jzsKBLLxHgY5nY2EQZDuUS41woCtpL1CBP2UB3iUHQJUy7FRPoCapLlm0ehaadDlBhb9PutJ3itjjqkYL1vGIGXMaTeaVeoScT1H6tSJEYzoD5saZMBZVdzG2cKm9ndCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfRzMlDXbOxg48CLGpc9IGFyvoFz2fIwlFrf0K065G8=;
 b=Usq6oaeZfuivsHy5qTw7WMfhmhg0hnhhgFbIdHnu4WU0AJa/gWsYnv6Tkem1dBvukH5xrHE32JHbuukQrNYgjnFQhTtXVITiffj4dLY4gWi6G+pGF+7gIlWGBJVrNdwXQjkoAvaKoniwzQEFJ65L1b/ihJde6OIvEk7CwaEQ/gsLXBz0xtI2GODCzzuqY+F5r+Hd/9eTrM2ySR5o2wiEpTmP/YugYyd2EpdUMPX/2Q8Sg0/br5bWGWzl0dPvtZT3O7QypOmtEkFRXEZ6GnGMjGcBnKEu3fUmvOsLzUOfp+prcuFkYHWiQYC9039dNYEMg9mWOYsBWVJjS2y9JX9ZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfRzMlDXbOxg48CLGpc9IGFyvoFz2fIwlFrf0K065G8=;
 b=jBqZcac5WVDdpc8kgHVBzBbCqv+RxN16T71Nugk85ZvTfvuQ0bpet+YUGhSgiu6He80o8xvK26Nic3Hs3j4DMS0E5FOJQtEO4U/xLIBG+q2GINOmlVv3z2UfMm0q8M8bVWA4jTZCuUacfYz2ICO/35hHLan3ms2PZ7lh/B7lmu4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CH0PR11MB5753.namprd11.prod.outlook.com (2603:10b6:610:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 20:39:49 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::90ee:ab23:e916:ef2d]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::90ee:ab23:e916:ef2d%3]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 20:39:49 +0000
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
To:     Borislav Petkov <bp@alien8.de>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>
CC:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic> <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
 <YR4dr079URttZRrg@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <bf20583c-80d4-a037-c5dc-ba243ac6cb0f@intel.com>
Date:   Thu, 19 Aug 2021 13:39:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YR4dr079URttZRrg@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.215] (71.238.111.198) by SJ0PR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:332::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Thu, 19 Aug 2021 20:39:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39961b9-788d-48e5-457b-08d963517d51
X-MS-TrafficTypeDiagnostic: CH0PR11MB5753:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR11MB575356F533B6B4E4C9C1D86AF8C09@CH0PR11MB5753.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /86pk1KI+7fA+P3k7pQK1Ep5PdkvI1AJigKh4S/jqE8Je9F/xfPFhGpt42Y0rgx+xnHgu4FfMjqCrvA8XTPpW8leUUnyyofyCf26iuXBR3waeKIBVRM/roucBrj/On7u87t7PZXjG1jomHYH2lxucdtpDGFAS0NdbyUGuUiKHSS6YxL4OPyCsML+LmDGydpCSY/L5DSaO1lQI50lQm0ltrg713K1Ahn3vPNbCq6/8oCfP/L0tsDwCQaCuFB5PWLZwtVMTtVnO9KgnU7HKUE/faACAk8ogzTyekSBjtmgVPJD8A/95V+kyPewndFWferHwVDzu3EU7LRFg7ys+vQbHwcmvWVybpWTgb4jF/wh+NRZOHBtlshSM8aas8fvfkIQLaWZVHx5nVqqI45jLBoZJgQuPlosbPYjEeAZ0enRZhaSy3jnwcLDCOxbyaai7rE6Uut7iMuXJJBcAerhT7DUdkIXDhevXBbfnBYAqHP4VaI0oz2wAlIT8owj/s9n6KosD+mzo0TgIR3vIgKDlhGDc0t3nOTSGl0QzDwimJOCrc61B5MZa24JOTCXLsl+6d976DFojuQdgzmMJrv3zI9D8nHZQeMUjCxKTXKpZ4FHsH58dGpKmRKa5dvldxQpw6aEb2mXgB3QinprsoJ46jh+Hce4FtB+ig2thZe25hX0m4kIdo6+hqQyuHSjUgv0zarDkFnMmoPdnNAb2Hke8WkeB38ApBQorulMBpFLxNUJndFd2y5i0OshP/uTaBwt3STluXFt9yDf/fqyBc3xLvUYhTSP2Tk/noyDjkjR0KTIPZQ4y1vk9QMrF/1h/U06vAQBEL77vJ3Du+/l/ehWYgnepr3HDB19SH6zXymPRXUOd9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(26005)(6486002)(66476007)(5660300002)(66946007)(186003)(38100700002)(110136005)(16576012)(54906003)(316002)(36756003)(86362001)(66556008)(8676002)(478600001)(956004)(31696002)(2906002)(2616005)(53546011)(44832011)(966005)(83380400001)(31686004)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhFNVJzQjk2SDZTWFJ4MnIrZndBNVJZMGlEc2x2eU5SWlFycklydit2eGxZ?=
 =?utf-8?B?TGtWc3diWWlFWXhzWFlVMVBPN29WZHozYlh1cjVSdGFFV3V1akJnK1hLQlB5?=
 =?utf-8?B?TkRZZVZnY1h1TUJ1bmp4V0ZBM0JFY2ZvR2Jyd1hIR1JDRVFQQW0xcWk5c1F6?=
 =?utf-8?B?Z0l5WUt3b3BkdUs3NGpzT1IrdGxQcDRYZ1dZbXU4dWVhZWVJNkc5b0R6K3di?=
 =?utf-8?B?Z3pYRjMzWitSOW4zOXRZckdlVDd5K2xxWDBkRGpMb3NBQkhIanpQbi9QV1kw?=
 =?utf-8?B?ZnpNRmNxYXZUODMxQXZZL1VuNEZUSXBnQUZYaVlsamRkU0NQcWVtNEplZXlL?=
 =?utf-8?B?QWptdE9laGlPWHprK2UxK0l6QU9mUmdsdmZYeFU0Ym9uVjdnVDBkN1JyUHh6?=
 =?utf-8?B?QU9hVktTeWdTRTJZZUdIKzlIWjgrSFkzclc4TEorY240ck1GMW1jdisrYkRt?=
 =?utf-8?B?UEF1R0crUGxPQ1hNY3o3eXFoMHFkSkluWkdPdFFEeko3eHZjdXVFNDFKcisx?=
 =?utf-8?B?K3RkOUthNHlzRFFiT1ZXazUrbXhhSVdOMTlLTTBTWXhQdE9Tb3JRNStrQmpT?=
 =?utf-8?B?ZGU5MCtDUHpxTmdhTGhoc0YrcFJES0M2eitpZEN3SS9rSC9xUHoyMG0wOXdj?=
 =?utf-8?B?QkhqMXlhczBqNGt0ZDYxY0V6a1BHVTdhNXV4RjIyNk9iWnBXbC9nazUvM1ZJ?=
 =?utf-8?B?a0NCSFdXUi81aXp6aHk4bXo3WDFETE16TlQrR2NESUtXb2dIdmdRQ25NbGVS?=
 =?utf-8?B?ZEhDSFc2VWUwNG1rbUU2R1Boamh3ZjZya3l6QzJEN3lmR2FFTTVDVThnbDRr?=
 =?utf-8?B?aU85a1R4SnV3RnA5U1pGOGkrRVM3c2lPWFpXMTladXBWbktlTlpibkc3Y0w2?=
 =?utf-8?B?bnQxYlROdUNUZ3lzc1QveGx1SE1mNi9CdGM5SGFwVm9HQ2QzeVNTM1p2M0Zo?=
 =?utf-8?B?TEpicHBqTDhSazJBQTAweGhkNFp4bHBtbVlHQzlXV0hDdXh5K3FyNzVQQjhH?=
 =?utf-8?B?SEJFTFFLTXd4eTdKR0RsTUw3Z0RnM1FwZjlQSnU3dHZFQ1BlaEp5cCtDMXNa?=
 =?utf-8?B?VWVRMFo1bFRValMram5sd2NuajRZUW4vb00wL3JIcHBScE9rclFHQmpRZXNG?=
 =?utf-8?B?MHN0cEdKYWx2anVLS3Z5dFZLaldUd1QxN0NzQk9EZTFJMnBWODRKVThoRTFL?=
 =?utf-8?B?ZU53U2dqaWxzQjRNb3RrOTVCWFZ6cExXUzJycHhBbHlVNUlOTmo1VytEWkRO?=
 =?utf-8?B?SExUTEtIWjJQZVRGUHVteEJjNWpieUhpZGNMWHdjS0ZxalNhM3RTbGN2UUhS?=
 =?utf-8?B?RVZCcXhuT3JVNC9Cb3lGNFI5MUpNV2V0NnpRcEdkSUQ1VGZQMVVYdmhHWmlx?=
 =?utf-8?B?dWVRbnBKSXRGNGI3SUprRTFSUlZGNHUxRGZWRTVkMVdyL2NmVWY3TlY4RVdD?=
 =?utf-8?B?OHVhYzA2WWJhaGZSMXVJMGVTZzRSM1VZWWQxcEk0akZJZ3Zjc3pUMDgyOHVa?=
 =?utf-8?B?UXdCRk13RGhNT2g2bzNLcUFtU251TnI1ZFcwdTV1eUY2dVFLUHVYa1ZQdGRL?=
 =?utf-8?B?MklDOUpNRzBPUEhPb3VhS1djdVVscXJQcDlxcHBWS2FhMWdIOC81RE82WDE5?=
 =?utf-8?B?Vnl3WHVPZGRva0phME50VXkyKzEwSEZ0ZVF1L2pqc1hFY0E2VmZQN2dnS2FV?=
 =?utf-8?B?am9Ma1E2YVZaLzFiTWYxV25GMWFjUGM4Z3FtR3h0Rnh6aTl6bmlxdC92Y3RR?=
 =?utf-8?Q?uohSK+56kcKCj7aa37yAj9bLlciaP3c9+PEWfiX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c39961b9-788d-48e5-457b-08d963517d51
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 20:39:49.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvcWDsFOT91q1UuOoQb6KUl5UKe34DXYzWRlUEW11Fyeva9YPqemwKdNRTl5XBf4XIjReqP0nQTP6wQo5zyXQZvl0kW7iYTNSJ+PzZrbTpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5753
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav and Babu,

On 8/19/2021 2:00 AM, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 02:15:16PM +0800, Chen, Rong A wrote:
>>
>>
>> On 8/15/2021 4:42 PM, Borislav Petkov wrote:
>>> Hi,
>>>
>>> On Sun, Aug 15, 2021 at 04:36:40PM +0800, kernel test robot wrote:
>>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
>>>> branch HEAD: 064855a69003c24bd6b473b367d364e418c57625  x86/resctrl: Fix default monitoring groups reporting
>>>>
>>>> possible Warning in current branch:
>>>>
>>>> arch/x86/kernel/cpu/resctrl/monitor.c:310 __mon_event_count() error: uninitialized symbol 'm'.
>>>> arch/x86/kernel/cpu/resctrl/monitor.c:315 __mon_event_count() error: potentially dereferencing uninitialized 'm'.
>>>>
>>>> Warning ids grouped by kconfigs:
>>>>
>>>> gcc_recent_errors
>>>> `-- i386-randconfig-m021-20210812
>>>>       |-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:potentially-dereferencing-uninitialized-m-.
>>>>       `-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:uninitialized-symbol-m-.
>>>
>>> AFAIR, I had already asked you guys to make those reports more useful
>>> as, for example, adding a link to that randconfig above or even
>>> attaching it so that a person - not a machine - reading it, can
>>> *actually* act upon it.
>>>
>>> But that hasn't happened.
>>>
>>> Until it happens, I'm going to ignore all those reports from you.
>>>
>>
>> Hi Borislav,
>>
>> Sorry about it, the actual link is at https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/PZVMY3VJU4QY4HQXHK3MLPQ2KZ5CNAYH/,
>> and it's still an internal report that the robot don't know whether it's a
>> false positive or not, we'll update the mail contents to avoid
>> misunderstanding.
> 
> Aha, ok, smatch thinks that m might not be initialized because
> 
> 064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")
> 
> removed the default case:
> 
> -       default:
> -               /*
> -                * Code would never reach here because
> -                * an invalid event id would fail the __rmid_read.
> -                */
> -               return -EINVAL;
> 
> I'm guessing that comment which got removed too, explains why that's ok.
> 
> Adding folks to Cc.

I can confirm that the removed comment explains why m would be 
initialized when used in the code that follows.

How would you prefer to address this? We could add just the comment back 
in support of future reports or perhaps by adding the default case back 
with the same error that would be returned earlier when there is an 
invalid EVENT_ID. Something like:

---8<---
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c 
b/arch/x86/kernel/cpu/resctrl/monitor.c
index 57e4bb695ff9..05b99e4d621c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct 
rmid_read *rr)
  	case QOS_L3_MBM_LOCAL_EVENT_ID:
  		m = &rr->d->mbm_local[rmid];
  		break;
+	default:
+		/*
+		 * Code would never reach here because
+		 * an invalid event id would fail the __rmid_read.
+		 */
+		return RMID_VAL_ERROR;
  	}

  	if (rr->first) {



