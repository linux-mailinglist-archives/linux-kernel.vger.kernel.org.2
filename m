Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457C4045F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350848AbhIIHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:08:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:55397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhIIHIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:08:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="207817745"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="207817745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 00:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="548382129"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 09 Sep 2021 00:07:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 9 Sep 2021 00:07:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 9 Sep 2021 00:07:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 9 Sep 2021 00:07:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+dWeWoYjlJFY3vOAWpAQA7U9lqF/bNfPAatSVGEzvcR3oLjCbWEul9QOA37UpNtBkE4jBISADN+uyUKGuRLqYwZgQpRUiyg+WQUhawJNI2V7sy4aQdXL3DuXfR4fqrNiEiskqzabtDBKDsiSuty4o2BNH1sxtoy1bJRhszv+EiqxNEM3RdM2EkLJqkas3XJaoZRIvd49V+Czg9iPyKh9CHyy6rHYS8RFoPp4miSdVq9TOv5kNaIALRK0Nlfrv8Ce1k5GA4LQXl7C3W2d0Vf5Naar0mvm1xxPQ8R0joy6hb40P+VQ3aH2nQus2OQ674wYWGIfPwAn4MrhdP6HMj6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Z6amq7DSeWFwqjP6IqaGnAVAsn4AMX8HlkipbX9wCLM=;
 b=FG2JklC5SSB4unBL7HyYAmIgBzcp1m0Oo5T4TcpujV8X9ZwYKX8Xpzt5TDETkL/0XAKuGZYuVBhp3nk5C9zlGUJXnVwwq9H47lhK/1Vi/ShJU+hzAUkg64Zqh3x9wOxgMMWPI+BALmz+g/SKgPd6OFZoTsHhgDoN8mzBKdydvWv+yNDL39vclIXBtf50Zs5WiuUIeOT5HGjtreJfi4wpLB7PBK/emgkFp4zqZwIer4OYxlswSVhRYtzfI9E2IrWm2+jbaPiz0bL98N1HiN5nkTpGD4FlHnRs1mGdObs1oQ1VFfJvcM6LG6NcilhAf/YrHPY5be+hF3Ycke3PAogC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6amq7DSeWFwqjP6IqaGnAVAsn4AMX8HlkipbX9wCLM=;
 b=AjRQ/OH9dt2YB17cCrggZVi27U//hfpKHtGXdBqFPXREIoyRk91vGpPHxgT1o8/i9vSbJM/FpIQZt7AlSOV4R3nkOL4He3c5TCPjsf8H0x7j3VRl1bw7S0ak/1ofos9aeDZioZXPjjnRnXWeLOUHSWZfV0mq839yUPL+7N2JONg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 07:07:42 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::44d8:67f3:8883:dec7]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::44d8:67f3:8883:dec7%3]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 07:07:42 +0000
Subject: Re: [LKP] Re: [xfs] 2bf1ec0ff0: stress-ng.mknod.ops_per_sec -45.4%
 regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
References: <20210804143800.GA21457@xsang-OptiPlex-9020>
 <a149d14e-48e0-bad9-4283-e560f03a941f@linux.intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <ec35eb2e-a488-ecfe-22c6-bf86d7eef145@intel.com>
Date:   Thu, 9 Sep 2021 15:07:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <a149d14e-48e0-bad9-4283-e560f03a941f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
Received: from [10.238.3.74] (192.198.143.17) by HK2PR03CA0051.apcprd03.prod.outlook.com (2603:1096:202:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend Transport; Thu, 9 Sep 2021 07:07:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c037bd3-6b48-40c6-dbe9-08d973608431
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB1358BB051DB4A5350A8B6AA4EED59@MWHPR11MB1358.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJyyKVC+7g50paGVlvdmC4SmZeJbkzXsLsw2V8YDZ0fmEmkl1bEMtkhhYmbleVAFJUS/TjkwVbSTpSaFWj3tfGHUscGJZUtB5u8JKgmxwM5yihugY7oUglxkAf+JwIY7iyaIxbG/cOcDp2Sd7cJaQ937YeXiuEJtPefGFZEnNr/8ZcGj+3rO1MHDuJWCYdGXWuOclifeEg9scnaiVt+5nkzBqnVvXDlDlMoecVjYzfFgqtn0Xs7RonR8QHi/TVN1XUvrVZkt16GST+HHQ3FcJaMwIri/jSHRoCrt5EUrdoSs5v+J0NQWbvb+jo86Y/ftcghudm0rG/RdWhiXIjj9mp50WAnxH0DJl170DNWxoR8AOT4VZQAC1zHqk5LB5mVPIRmEcI5NSdx8nzUJCFX5rW7NDDqlcU7Q4etfXk/7A22Yg88GQHkCMYSp9RMGc3zCjck5Okbc800139HN3fPYxuQQxIu30Jkj/z9tTyWy7GcMo8RRooBtCMcNGNQv3+15dX7P6Asob1mQmdBLB6LJBCUzfkzcjbX2hiue6YBOGEHK460nVlyE/kGC4lpBAFieztW74LltKgQxTRNr+b0Lea/5c8J70KY7Mmkabi9fyuvbWlx0etQc9brsTtAeKsgCnIl1HdrZ3ACUWETYnpYg8+D6gPs8ncjMrhgtaG0qS3grYw0wAteZABCAz0bY6w0VkFtCFdZXupS1tOir/C20i8AnVjzJFTVh23yyJmfMBkOuDKkBWwH/8L3BCrFKooGqncqt1W4MgWK0xXn9gg+TDz950+1VAgkgl0RaqYOwkKMSGRjD5A/+3MEHMBS8/noOSoTpqmf4ZjSKECMZxs0DERLCsZ3n2AUsXzvBFimcNEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(8676002)(2906002)(16576012)(110136005)(31696002)(966005)(8936002)(956004)(316002)(53546011)(66476007)(38100700002)(54906003)(31686004)(6486002)(36756003)(66556008)(30864003)(2616005)(26005)(4326008)(186003)(83380400001)(5660300002)(66946007)(86362001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEs5N1BWNzNCVzdiOWJEeWF3M0Z0N3o2bHllVWFXNzc5engwcUhzaUdvRXRq?=
 =?utf-8?B?VG94Sm9LTWUrSVJCK2NOc2JQK2V2ZWFNNWJNbk0rREtqMkRSS0N2M1hwV1FL?=
 =?utf-8?B?S043clpVYmh1dTM5L3NpaVl5bDAwRXpldCtlSm5BeG42c1NRMFdidFMvS3Y2?=
 =?utf-8?B?ZURmWVR3WXQ4VC9rd0kwcUpISElPdFVPcUpraU5LNzNONjFzZUhNSzNGVEtJ?=
 =?utf-8?B?U0RBTkpHbmJCNXlzNXFGQ3dkY2poaUthTytlbTRlbkNVdVlKald3K3pQbE5y?=
 =?utf-8?B?VU40MnUwZEJiMTBEUm5YQXdvNkx3OGw1OUhORWNOSUdYclRrTDVQUWl5TWFG?=
 =?utf-8?B?UVNNRFZqRzJlZDZrMHpVUHpYajBLVi9KYnVzZDQ2VklqTlQ4UmZwNUVSQWh3?=
 =?utf-8?B?MkJlbXZvTXFjaGw3WHdYbFZZdnl6aU9lOWNFTGtvSVhhVWZ4bDVaSm1mOGs4?=
 =?utf-8?B?ZWt0OHNzWng2TTIyM3FoWVRwV2Mrby9Cd2RWbmJuNG5BdHdFRXMxUDE1VDRB?=
 =?utf-8?B?MVpORUFMa2FKeFZ2SGppNENEUk11ekZqVVNEamdMQTlxQ2NlWDVDem9NcGMv?=
 =?utf-8?B?WGtuQ0pZTWxHTjRKYitRaTZwU2RNVkhMWTVpN2J6aWNINWZBbFc4SlpLTXdi?=
 =?utf-8?B?RXV1OXI0V1g3T2ZqYVBQNHk3YnJJTHVXTUVpaWsrQ2ZxNDhyYVJobXd5SHRZ?=
 =?utf-8?B?TjQ5NE8yVWtrZldVNitEd2c0dTZjUThSY1JYaWt0R3YxOWIwRGM5NjE4aHZ1?=
 =?utf-8?B?S0RRSDlPdWZuOUJiQ1VzUDkvQWpSM2JldmNFbmtUVlZraEliVU5ISnhuTmpL?=
 =?utf-8?B?aytCUlNkcEFFOTRPa0tmNitjQndRZThOMUc1VnpkazlQYlFSS1hsTjhZeGlz?=
 =?utf-8?B?QTdCOWhUUzBRTFk5ZjhGOFdSd1gybmUrZUN3Q2NyL1hpQjIyRndoaGQ4UjNs?=
 =?utf-8?B?WmdRMFArQWtORXJzR2dLSmd4VDltanlFa3JMSE90N0o1bzhOTXEvQ3IyS0kz?=
 =?utf-8?B?eFIyM3V4TzlJTU1GazVXdWhqa2FwSkh6R25ETHVYUXJRenRaVGsrQlJtM2xz?=
 =?utf-8?B?ZmIyT2hiWEM3enA5Vnl5SWY4QjVPZ1ovK3J5WWhEcjZDQUtiRUY1aDBHR2FD?=
 =?utf-8?B?ak1LZXVXY2YrbEZwT0NuRTR4a0dkNXpqaGFkRXJJbDkzWm5XQXlqUGlyT3VP?=
 =?utf-8?B?S3EzRStpTmV2OGFXaGFDdmV0dUNXcGZFbEVJR1ZNaGFQeTRLQlZETi9qMkhO?=
 =?utf-8?B?ZjJtdHVLcklaamNnWE8xdkFvTkpITTRINktCSmV0VzZHTDVNSVlyajRQczJC?=
 =?utf-8?B?Nyt5M0tWMlpYQUxBL1FMYjU3UU9LdEJUVzc0Rm9Rb1pYQks3MlN3MmY2YTR1?=
 =?utf-8?B?bUZyQlVQS3ZLN3daRVYyL2V6QmRTemJydEdET1NDKzk0VEwvWTEwckl5NUlZ?=
 =?utf-8?B?ODNEMnFVU1ViYVJQTFlqd2dNamRNK2k5c3VjWW5JbXRvbEhYK2dzRk9hR2ZS?=
 =?utf-8?B?NDVxV2RzblRvV0NCbjFPbFJsVTlSZEhlcDg2Z2ZsYnRRdGk4MWdKZHdUNGNh?=
 =?utf-8?B?Z0dIVS9CMCtCQ01SdlpvUnlONXpEVUg5ZXprNVdiUjV0ekFBeVVPM05OM3Q4?=
 =?utf-8?B?MGdmOVFoQzkzZzdmeWtmdlhaOW9lN0VzbTcycEMxVGxoNnlFUHJVNks5ZUZ4?=
 =?utf-8?B?dS9kV29XbmN5T2VaVW1zemlSS0U2dTMwRWhJbVc1VTJCcTdhSlkxeG1XL0hE?=
 =?utf-8?Q?TqpaoqKz7DlEi+618XC7HNJxkxqK4+YmRkXUwwL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c037bd3-6b48-40c6-dbe9-08d973608431
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 07:07:42.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsDu1bUIbFLaYG2sf9L/GxUK2lNLz/uSXE+WCGhXoo9B/wLH4gjav7ECPLs2aQE9EU19jMzFaBsT6KsHoDulRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1358
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 9/3/2021 3:43 PM, Xing Zhengjun wrote:
> Hi Dave,
> 
>    Do you have time to look at this? Thanks.
> 
> On 8/4/2021 10:38 PM, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed a -45.4% regression of stress-ng.mknod.ops_per_sec due to commit:
>>
>>
>> commit: 2bf1ec0ff067ff8f692d261b29c713f3583f7e2a ("xfs: log forces imply data device cache flushes")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

We noticed the commit 2bf1ec0ff067ff8f692d261b29c713f3583f7e2a is actually a
fix to the race introduced by commit eef983ffeae7a1cdde8c3338155ae2dd74b8621b.

Then we did a test for stress-ng.mknod.ops_per_sec between commit:
  eef983ffeae7a1cdde8c3338155ae2dd74b8621b
and its parent commit:
  3468bb1ca6e8840789e13c7b9d8b0c556b4fbe79

We got:
commit: 
  3468bb1ca6e8840789e13c7b9d8b0c556b4fbe79
  eef983ffeae7a1cdde8c3338155ae2dd74b8621b

3468bb1ca6e88407 eef983ffeae7a1cdde8c3338155 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
        112:1          456%         117:1     dmesg.timestamp:last
        103:1          553%         109:1     kmsg.timestamp:last
          1:1            0%           1:1     pmeter.pmeter.fail
          1:1            0%           1:1     stress-ng.mknod.pass
         %stddev     %change         %stddev
             \          |                \  
     47979           +80.6%      86655        stress-ng.mknod.ops
    799.29           +80.6%       1443        stress-ng.mknod.ops_per_sec

It's like commit eef983ffeae7a1cdde8c3338155ae2dd74b8621b bought 80%
performance gain. But it introduced race issue.

Commit 2bf1ec0ff067ff8f692d261b29c713f3583f7e2a fixed the race issue
and lost about 50% performance gain. Suppose we still have 30%
performance gain with race issue fixed. So it's still a good change.

We will close this report.


Regards
Yin, Fengwei

>>
>>
>> in testcase: stress-ng
>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
>> with following parameters:
>>
>>     nr_threads: 10%
>>     disk: 1HDD
>>     testtime: 60s
>>     fs: xfs
>>     class: filesystem
>>     test: mknod
>>     cpufreq_governor: performance
>>     ucode: 0x5003006
>>
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>>
>> Details are as below:
>> -------------------------------------------------------------------------------------------------->
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install                job.yaml  # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
>>          bin/lkp run                    generated-yaml-file
>>
>> =========================================================================================
>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>>    filesystem/gcc-9/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/mknod/stress-ng/60s/0x5003006
>>
>> commit:
>>    45eddb4140 ("xfs: factor out forced iclog flushes")
>>    2bf1ec0ff0 ("xfs: log forces imply data device cache flushes")
>>
>> 45eddb414047c366 2bf1ec0ff067ff8f692d261b29c
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>       87135           -45.4%      47612        stress-ng.mknod.ops
>>        1451           -45.4%     793.24        stress-ng.mknod.ops_per_sec
>>       23.00 ±  7%     -51.4%      11.17 ± 12%  stress-ng.time.percent_of_cpu_this_job_got
>>       13.80 ±  7%     -50.7%       6.80 ±  8%  stress-ng.time.system_time
>>      211458 ±  2%     -62.4%      79605 ± 14%  stress-ng.time.voluntary_context_switches
>>        0.30 ±  2%      -0.1        0.18        mpstat.cpu.all.sys%
>>       13993 ±  2%     -38.1%       8659        softirqs.BLOCK
>>       27747            -2.3%      27103        proc-vmstat.nr_slab_reclaimable
>>       76223 ±  3%     -57.3%      32548 ±  5%  proc-vmstat.pgpgout
>>        1170 ±  3%     -57.3%     500.17 ±  5%  vmstat.io.bo
>>       10752           -47.7%       5624 ±  6%  vmstat.system.cs
>>       32820           -34.5%      21499        slabinfo.kmalloc-rcl-64.active_objs
>>      512.67           -34.6%     335.50        slabinfo.kmalloc-rcl-64.active_slabs
>>       32836           -34.5%      21508        slabinfo.kmalloc-rcl-64.num_objs
>>      512.67           -34.6%     335.50        slabinfo.kmalloc-rcl-64.num_slabs
>>       24913 ±  2%     -42.8%      14251        interrupts.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
>>       71844 ±  6%     -19.9%      57564 ±  3%  interrupts.CAL:Function_call_interrupts
>>      206.50 ± 37%     -42.9%     118.00 ± 41%  interrupts.CPU1.NMI:Non-maskable_interrupts
>>      206.50 ± 37%     -42.9%     118.00 ± 41%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>>      173.17 ± 26%     -31.7%     118.33 ± 38%  interrupts.CPU2.NMI:Non-maskable_interrupts
>>      173.17 ± 26%     -31.7%     118.33 ± 38%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>>      189.83 ± 34%     -40.6%     112.83 ± 25%  interrupts.CPU49.NMI:Non-maskable_interrupts
>>      189.83 ± 34%     -40.6%     112.83 ± 25%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
>>      181.67 ± 25%     -38.3%     112.17 ± 24%  interrupts.CPU50.NMI:Non-maskable_interrupts
>>      181.67 ± 25%     -38.3%     112.17 ± 24%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
>>        1895 ± 16%     -32.8%       1274 ± 20%  interrupts.RES:Rescheduling_interrupts
>>   3.127e+08 ±  5%     -12.2%  2.746e+08 ±  3%  perf-stat.i.branch-instructions
>>       10683           -49.8%       5364 ±  6%  perf-stat.i.context-switches
>>   3.866e+08 ±  4%     -14.2%  3.318e+08 ±  3%  perf-stat.i.dTLB-loads
>>   1.949e+08 ±  3%     -14.7%  1.662e+08 ±  3%  perf-stat.i.dTLB-stores
>>   1.538e+09 ±  5%     -12.4%  1.348e+09 ±  3%  perf-stat.i.instructions
>>        9.31 ±  4%     -13.6%       8.04 ±  3%  perf-stat.i.metric.M/sec
>>      127426 ± 14%     -32.6%      85864 ±  9%  perf-stat.i.node-load-misses
>>   3.078e+08 ±  5%     -12.2%  2.702e+08 ±  3%  perf-stat.ps.branch-instructions
>>       10512           -49.8%       5279 ±  6%  perf-stat.ps.context-switches
>>   3.805e+08 ±  4%     -14.2%  3.265e+08 ±  3%  perf-stat.ps.dTLB-loads
>>   1.918e+08 ±  3%     -14.7%  1.635e+08 ±  3%  perf-stat.ps.dTLB-stores
>>   1.514e+09 ±  5%     -12.4%  1.327e+09 ±  3%  perf-stat.ps.instructions
>>      125399 ± 14%     -32.6%      84480 ±  9%  perf-stat.ps.node-load-misses
>>   9.563e+10 ±  6%     -12.3%  8.383e+10 ±  3%  perf-stat.total.instructions
>>        8.31 ± 20%      -3.9        4.45 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>>        8.30 ± 20%      -3.9        4.45 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.calltrace.cycles-pp.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        2.08 ± 19%      -1.6        0.50 ± 72%  perf-profile.calltrace.cycles-pp.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        1.85 ± 25%      -0.7        1.14 ± 31%  perf-profile.calltrace.cycles-pp.do_mknodat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        1.04 ± 27%      -0.7        0.36 ±106%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_fs_destroy_inode.destroy_inode.do_unlinkat
>>        1.08 ± 27%      -0.6        0.46 ± 77%  perf-profile.calltrace.cycles-pp.destroy_inode.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        1.05 ± 27%      -0.6        0.45 ± 77%  perf-profile.calltrace.cycles-pp.xfs_fs_destroy_inode.destroy_inode.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        1.04 ± 27%      -0.6        0.44 ± 78%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_fs_destroy_inode.destroy_inode.do_unlinkat.do_syscall_64
>>        0.89 ± 17%      -0.3        0.58 ±  9%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>>        1.21 ±  8%      +0.2        1.45 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>>        8.13 ±  9%      +2.0       10.16 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.children.cycles-pp.__x64_sys_sync
>>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.children.cycles-pp.ksys_sync
>>        2.09 ± 19%      -1.4        0.65 ± 25%  perf-profile.children.cycles-pp.iterate_supers
>>        2.25 ± 18%      -1.1        1.14 ± 26%  perf-profile.children.cycles-pp._raw_spin_lock
>>        1.40 ± 25%      -1.1        0.31 ± 54%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>        1.85 ± 25%      -0.7        1.14 ± 31%  perf-profile.children.cycles-pp.do_mknodat
>>        1.08 ± 27%      -0.5        0.55 ± 43%  perf-profile.children.cycles-pp.destroy_inode
>>        1.05 ± 27%      -0.5        0.54 ± 42%  perf-profile.children.cycles-pp.xfs_fs_destroy_inode
>>        1.04 ± 27%      -0.5        0.54 ± 43%  perf-profile.children.cycles-pp.xfs_inactive
>>        1.04 ± 27%      -0.5        0.53 ± 44%  perf-profile.children.cycles-pp.xfs_inactive_ifree
>>        0.93 ± 21%      -0.5        0.44 ± 24%  perf-profile.children.cycles-pp.__schedule
>>        0.49 ± 25%      -0.4        0.11 ± 76%  perf-profile.children.cycles-pp.pick_next_task_fair
>>        1.05 ± 20%      -0.4        0.69 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
>>        0.66 ± 19%      -0.3        0.32 ± 30%  perf-profile.children.cycles-pp.schedule
>>        1.00 ± 20%      -0.3        0.65 ± 13%  perf-profile.children.cycles-pp.update_sd_lb_stats
>>        0.60 ± 20%      -0.3        0.29 ± 31%  perf-profile.children.cycles-pp.xfs_ifree
>>        0.89 ± 17%      -0.3        0.58 ±  9%  perf-profile.children.cycles-pp.worker_thread
>>        0.44 ± 26%      -0.3        0.16 ± 45%  perf-profile.children.cycles-pp.newidle_balance
>>        0.49 ± 39%      -0.3        0.22 ± 35%  perf-profile.children.cycles-pp.xfs_fs_sync_fs
>>        0.40 ± 49%      -0.2        0.17 ± 29%  perf-profile.children.cycles-pp.xfs_log_force
>>        0.31 ± 29%      -0.2        0.11 ± 56%  perf-profile.children.cycles-pp.schedule_timeout
>>        0.24 ± 60%      -0.2        0.06 ± 50%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
>>        0.38 ± 19%      -0.2        0.21 ± 30%  perf-profile.children.cycles-pp.xfs_btree_lookup
>>        0.42 ± 14%      -0.2        0.26 ± 35%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
>>        0.30 ± 27%      -0.2        0.14 ± 37%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
>>        0.25 ± 30%      -0.1        0.10 ± 39%  perf-profile.children.cycles-pp.iterate_bdevs
>>        0.33 ± 28%      -0.1        0.19 ± 20%  perf-profile.children.cycles-pp.try_to_wake_up
>>        0.26 ± 31%      -0.1        0.13 ± 23%  perf-profile.children.cycles-pp.schedule_idle
>>        0.16 ± 36%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.__down
>>        0.16 ± 35%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.xfs_buf_lock
>>        0.16 ± 36%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.down
>>        0.21 ± 39%      -0.1        0.09 ± 52%  perf-profile.children.cycles-pp.xfs_iunlink_remove
>>        0.19 ± 28%      -0.1        0.08 ± 43%  perf-profile.children.cycles-pp.xfs_buf_item_release
>>        0.21 ± 33%      -0.1        0.10 ± 35%  perf-profile.children.cycles-pp.xfs_difree_inobt
>>        0.14 ± 16%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp._xfs_trans_bjoin
>>        0.18 ± 30%      -0.1        0.08 ± 80%  perf-profile.children.cycles-pp.wait_for_completion
>>        0.15 ± 27%      -0.1        0.06 ± 53%  perf-profile.children.cycles-pp.up
>>        0.15 ± 33%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.xfs_difree_finobt
>>        0.15 ± 27%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.xfs_trans_alloc
>>        0.10 ± 29%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.xfs_log_reserve
>>        0.04 ± 77%      +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.balance_fair
>>        0.05 ± 79%      +0.1        0.15 ± 31%  perf-profile.children.cycles-pp.smpboot_thread_fn
>>        0.58 ± 16%      +0.1        0.72 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
>>        1.24 ±  8%      +0.3        1.52 ±  4%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>>        8.31 ±  9%      +2.1       10.40 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>>        1.30 ± 18%      -1.0        0.30 ± 54%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>        0.75 ± 21%      -0.3        0.44 ± 20%  perf-profile.self.cycles-pp.__percpu_counter_sum
>>        0.43 ± 25%      -0.3        0.16 ± 45%  perf-profile.self.cycles-pp.down_read
>>        0.72 ± 13%      -0.2        0.47 ± 12%  perf-profile.self.cycles-pp.update_sd_lb_stats
>>        0.35 ± 15%      +0.1        0.43 ± 13%  perf-profile.self.cycles-pp.irqtime_account_irq
>>        0.08 ± 60%      +0.1        0.16 ± 18%  perf-profile.self.cycles-pp.timerqueue_del
>>
>>
>>                                                                                                              stress-ng.time.system_time
>>                                                                                     20 +----------------------------------------------------------------------+
>>       |            +                                                         |
>>    18 |-+     +   ::                                       .+                |
>>       |      : :  ::                   +..               .+  :               |
>>    16 |-+    : : :  :                 :       +.    +   +    :     +         |
>>       |:    +   ::  :                 :   +  :  +  : : :      :  .. +        |
>>    14 |:+  +    +   :         .+.   .+     + :   + : : :      +.+    +.   .+.|
>>       | +.+         :  +.+.+.+   +.+        +     +   +                +.+   |
>>    12 |-+           :  :                                                     |
>>       |              ::                                                      |
>>    10 |-+            ::                                                      |
>>       |              +                                                       |
>>     8 |-+                    O   O   O      O   O       O O                  |
>>       | O O     O    O     O   O       O      O   O O       O                |
>>     6 +----------------------------------------------------------------------+
>>                                                                                                                                                                                                                                                                       stress-ng.time.percent_of_cpu_this_job_got
>>                                                                                     35 +----------------------------------------------------------------------+
>>       |                                                                      |
>>       |       +    +                                        +                |
>>    30 |-+     ::  ::                                       +:                |
>>       |      : :  ::                   +..    +     +   +.+  :     +         |
>>       |:     :  ::  :                 :      : +   : : :     :   .. :        |
>>    25 |:+  .+   +   :                 :   +. :  +. : : :      :.+   :        |
>>       | +.+         :  +.+.+.+.+.+.+.+      +     +   +       +      +.+.+.+.|
>>    20 |-+           :  :                                                     |
>>       |             : :                                                      |
>>       |              ::                                                      |
>>    15 |-+            :                                                       |
>>       |              +       O   O   O      O   O       O O                  |
>>       | O O O O O  O O O O O   O   O   O  O   O   O O       O                |
>>    10 +----------------------------------------------------------------------+
>>                                                                                                                                                                                                                                                                          stress-ng.time.voluntary_context_switches
>>                                                                                     260000 +------------------------------------------------------------------+
>>    240000 |-+     +                                                          |
>>           |      + :  +.                  +                 .+. .+.          |
>>    220000 |++.+.+  : +  +.   .+.         + + +.+. .+.+   +.+   +   +. .+. .+.|
>>    200000 |-+       +     +.+   +. .+. .+   +    +    + +            +   +   |
>>           |                       +   +                +                     |
>>    180000 |-+                                                                |
>>    160000 |-+                                                                |
>>    140000 |-+                                                                |
>>           |                                                                  |
>>    120000 |-+           O                                                    |
>>    100000 |-O   O         O O                          O                     |
>>           |       O   O                   O    O   O       O   O             |
>>     80000 |-+ O               O O O   O O   OO   O   O   O   O               |
>>     60000 +------------------------------------------------------------------+
>>                                                                                                                                                                                                                                                                                     stress-ng.mknod.ops
>>                                                                                     95000 +-------------------------------------------------------------------+
>>    90000 |-+    .+. .+.                                     .+. .+.          |
>>          |.+.+.+   +   +.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+   +   +. .+.+.+.|
>>    85000 |-+                                                         +       |
>>    80000 |-+                                                                 |
>>          |                                                                   |
>>    75000 |-+                                                                 |
>>    70000 |-+                                                                 |
>>    65000 |-+                                                                 |
>>          |                                                                   |
>>    60000 |-+                                                                 |
>>    55000 |-+                                                                 |
>>          |                                                                   |
>>    50000 |-O O O O O O O O O O O O O O O O O O O O O O O O O   O O           |
>>    45000 +-------------------------------------------------------------------+
>>                                                                                                                                                                                                                                                                                stress-ng.mknod.ops_per_sec
>>                                                                                     1600 +--------------------------------------------------------------------+
>>         |      .+.                                          .+. .+           |
>>    1500 |.+.+.+   +.+.+.+.+.+. .+.+.+.+.+..+.+.+.+.+.+.+.+.+   +  +   .+.+.+.|
>>    1400 |-+                   +                                    +.+       |
>>         |                                                                    |
>>    1300 |-+                                                                  |
>>    1200 |-+                                                                  |
>>         |                                                                    |
>>    1100 |-+                                                                  |
>>    1000 |-+                                                                  |
>>         |                                                                    |
>>     900 |-+                                                                  |
>>     800 |-+   O O   O O O     O O       O      O O     O O O     O           |
>>         | O O     O       O O     O O O    O O     O O       O O             |
>>     700 +--------------------------------------------------------------------+
>>                                                                                                                                                                   [*] bisect-good sample
>> [O] bisect-bad  sample
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
>> ---
>> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>>
>> Thanks,
>> Oliver Sang
>>
> 
