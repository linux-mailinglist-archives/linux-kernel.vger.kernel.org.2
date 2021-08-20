Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505CC3F2DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbhHTORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:17:11 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:12196
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235032AbhHTORK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mooVY6gFvaoP9Z81RLDpfKVIZi1STZM4cSlpzyPSfwlUqlg5exQNCcvRkWlLIyO08U0jVRwL92yTGfafE6OORDElRaAMTR6uZYf8s2x9Keq05u5H+wARISsL9aL69l06c1sJO2Hqjg3MFrCSWB2roBvrkhL9lKjrnqxpUCrxXq4XiYIGeN15/eXvKTrkzSVf7YmCfiqPUpD1DzAJby2Wv/zhNhcuOCh/ukfecG/XwqvZ28ttcVZVmO3+GtSwfaNuipF5E5Nhx4hVmeyECoIXupkbM0E3epD3wxTqMJSTnWrH6wGR2zUV4fDDb1985quqn0XXBrb6mKZu4ny8a0u11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7DanAfCoyEPAyUxtCYse+q/9ieuX9I1N5Q9M2Pfes=;
 b=gZDJ+7GmFQDMNsge5KTXf30pHxDBZhpyrWnHfX4PKturHyjSgrhbBJkhxy8d2GJTjYK8/0VCDgnhorzNgBPmaau3/a5P9OITpqy6Llmqc4N4DydD+nGgt55Dvg9r+VRlFGVLQyHukyyOvrCFTQlrDse4AlBVjgFzSYx64Jo81XFV6PkAnhnBh8AhPVgadIHdQH2tZZWjIVava3ctpx1480MmW4j9ZGzQg35DUhTS2n4U5vfqtXjmJ5j+0BUuMcorDAX2VBBTTzBXUTn+Pq/DMl2JZ9cblZBKwRKBvpyrLDdVA1piSipp2n64yhlT3gxHFE3yxn8PgpksljMj6Tsh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7DanAfCoyEPAyUxtCYse+q/9ieuX9I1N5Q9M2Pfes=;
 b=eymBB1ai0BA3Ha+WGzKTiDks2wt7dvkrTTskgvyahjc9+XrgdGuxqW4pr8PzdIQHRcv1jhgVR1y/RvrEfvWHnaqCNL2GX/UQWczKsgFzeP+iwIAB3Ck0RM5lM3mjtyl3SVrzuECqHFEGGcVCgE2bhNxmek03FujE+3h0Ljo7dNw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Fri, 20 Aug
 2021 14:16:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 14:16:30 +0000
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
To:     Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic> <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
 <YR4dr079URttZRrg@zn.tnic> <bf20583c-80d4-a037-c5dc-ba243ac6cb0f@intel.com>
 <YR7HtVf3OzM7/3qj@zn.tnic>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <20d8842e-197f-e413-2588-92652c1dcb47@amd.com>
Date:   Fri, 20 Aug 2021 09:16:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YR7HtVf3OzM7/3qj@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:806:6f::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.0] (165.204.77.1) by SA0PR12CA0006.namprd12.prod.outlook.com (2603:10b6:806:6f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 14:16:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69df8bd8-3b3b-410b-8ef0-08d963e51b0f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:
X-Microsoft-Antispam-PRVS: <MW2PR12MB253981B467D74484CE29DBA195C19@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiaUL5Y3JSoBF9dk7iuY9KQN9EbV0SX0WySnD8SRyYnA1auyaVPsO+ah0ebVsjXgDBV/AGq43mJYqbn84s/qRo2zFFi3dZgDRJSNH6IaOYKijdeWpGQy1gpULR4ecl2OQWbIiEB6LaO4TVSoqjFN19JiUgwg9A7c4qRWp+Gh+KjJDh61YyhFNrdVsFunnXl3WzSzVxUTSgTQCezvTjUxtslCyQjiQwU8Qqv88RvpS9hswdDn0aC4kxivOog3sKJCkFPvOMgZiyCaACtwCra0oj1O11Z28czgcWnCE5EzfMKMMkrHOL2g0w8eL9B5IWqykXkLeOcoG2fTJVLbV3t5nxCg6prTeCBrhJRNmUOyTDql7IHJaqT3WXHXomy/Jg7waMn0RTTTsvhJ4HbPAzWx3SJZ4eylPjiEheGT1n3Wr40MzTk8CA7nQIQjAT2QW4DenJAvP424BDWqBvqCTs8sWOTR5B7zFHMaLPSUU/26/OP3sCS75N0ZZhbpX0xnBJE6Fz5gIwtJpnSeutT7rYC1k8ZbMzqQgh5xoIIFbDAUqM6raMYE/9zCAgpT0c4m5jF8SWEU+L/UhSbBlNYOD/BqVzmlWQ39YvqZBz2lyED+qWJp0rzm2Onv4YGTxSYREFzIN3r4cGhDHw6OB8TiS9AirZuIYGefzKLVRt4vjkGS2jPyYkGoNWvhL1WR2YsmHQ3cnWWoO9vJv/j1jDeH4LF9alikPSV0f4+guDz/vt/bYgK1wlq/InqtP6p5ioUxMBL+cU6RtHcJPXoHiD9Wu2kQ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(66946007)(6486002)(26005)(52116002)(8936002)(53546011)(54906003)(110136005)(66476007)(83380400001)(5660300002)(31686004)(86362001)(8676002)(316002)(66556008)(16576012)(36756003)(4326008)(44832011)(2906002)(38100700002)(478600001)(186003)(956004)(31696002)(38350700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VlOEtQMzhJS284WjJZVTZqMVVncVA2VjkzMVUrRSt5UG91V2lJWnArTzN2?=
 =?utf-8?B?SVVGNmFIYXRlZTlTemdpVFVxQzN4ZDhhakxSd0l3ZjdHbUYrZElQNHhVNjlm?=
 =?utf-8?B?OVQ1dEltbWMySHYvNSsrd2NTNnZObVhqblkvZnR0RC93WVJpSSs5YWZRN0hx?=
 =?utf-8?B?WEhwQi9jRXM1ZmF5Qnllc0RXUDNHeDFRd1N0N3RtOUxXWDdQMncxYkxGQm9q?=
 =?utf-8?B?OUhESW5saDBPV0dsK3kvSUNsbm00WUxTVm01amwxSDlCVTB5YUNZNzRrMFFX?=
 =?utf-8?B?M3ZvN1NoSDlremdrU0tTVURiSUJzWnY1bzdqNk5LZnNubzU5QWlhSWczTldQ?=
 =?utf-8?B?WjlzeEFhMWFEWWZaRVFQR201bEZodVQxYkpTWmZheVRTUUxJY3VrTm1SRUlC?=
 =?utf-8?B?a09SSTROQUU5NDBDVGxNbHpyS24rRkgzNFpaMWZNazVGdEJNUUtNT211dUVS?=
 =?utf-8?B?Wk9KSTMvcXo5ZTZncUdvS1pobEJmcWlHcndDL2tibXd5OThvSzhrYmx6c0Y1?=
 =?utf-8?B?VjlNTGh2T1Uxa1hLSTVjQThteGFsbzlISkpoV3pNNUVLM09PaGpIYitseVVy?=
 =?utf-8?B?WGhhdHdpdFNiSWZoRjNCRkRKNTZIU1BhVjQwYVZtZFp2Q0hPL00xeHNuTHp0?=
 =?utf-8?B?M3BYWGNtb0FCdnhnV21XNVdLN0JVa2xLWjlMMVliUVpmS1l1Nk1zYW9ueWtD?=
 =?utf-8?B?bEFUbnU4US9YdmVMWjNSWngwQjBCbi84d0syTmxuM09zd3duR21YNlo0S3Fn?=
 =?utf-8?B?K2NRVGJvS2JHZUd4ZW4zZWU5VkpYdmIvVDVESVk0T3p1bGxMT3ZKbnVIWkhm?=
 =?utf-8?B?MUJIcFhLTGtKMjBNSkdKTCt4SktMZGZtTjQ3ZWw1TDUyZ2tpUGczSnZSbDQ0?=
 =?utf-8?B?RFBQZ3NVOFFkR1ZFVDYzNlY4TENxSHJWcVFvc2ZqTHdaNFhmcDVZZ2pVektw?=
 =?utf-8?B?WUlvK2t3S1h6d3VNTmRkUVdiS0E1dmhhVWt1OG1LN1lvNGgyL2RjcFUzS2hx?=
 =?utf-8?B?ZEpoUm1NWWlRbm94aVdNeU9vZ2ZxUVFVeUtuemY0bG9idGphaENmSTRlWGdB?=
 =?utf-8?B?SHlRSWh3UXdwY2s1Nkp6dUdPV01Fd1gxMHFyYmdycU1GcXdyUitWZDZtc3pa?=
 =?utf-8?B?bU9tVE40bkc1U29sMnhpY1ArOFNsVkNYT2lSb0pTNFVWRFdjaWtIVmdDdUYw?=
 =?utf-8?B?UTNlQW44NnYxMVExUHlWRkpxa3hYRGMxRkx5THovM09JdXZWTGNHT2JrVHh6?=
 =?utf-8?B?Mzd6RDNFTWtJRWt0UkpTUktLb25xV0VrTGFtNUFzS2lFcjFVZUdZZTExdzlM?=
 =?utf-8?B?M3ZYaUlCVWM3RzNmVFE3cnFubHJzU0k1QzYwQmFNWjhqVXdteEJ5U2REUUJw?=
 =?utf-8?B?eWJuTDQ4TzBjR2M1TmxuK0ZSSW1aenlIZ0ZhZTdtNXpTN2dxNmp4b3UyUUtu?=
 =?utf-8?B?YU1BdVVndUEvd2d2VDB0RmhZK1J1VDNHa0RWVk5NRlZIRTI1K3NvU0JUL3p5?=
 =?utf-8?B?cGQvb0pqZDRxazFGSVd4aEhka1Z1QjlnYnR2Vzk4bElXeDg2dXhpU29Ma20v?=
 =?utf-8?B?SjNzcXJlWEdtK3JSd3RrTDZXWWY0K2xUYk01aUs4SHVhREh3ZVA3TjVyU0R2?=
 =?utf-8?B?RHl5UVlBNlplTnUwaE5qMEVQbjVUK0MrMmt2VTRpd2Y0d0pvQ0hiV09oem9j?=
 =?utf-8?B?cUlYaEVvWXdoL0laQmVXR3RGZ1RVbmVBa00zcXV6Q25qMGJrVnl1UHhHeEFt?=
 =?utf-8?Q?HJD26Qwfj0WnJFSoWZbbfwREi3nuZaRE2mIbnq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69df8bd8-3b3b-410b-8ef0-08d963e51b0f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 14:16:30.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WMiZasI+ESH20Zn97pli7YWA5oYYkIlc1dYEXpKZbzFT46YyBBrOz3snCNzJ+7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/21 4:05 PM, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 01:39:46PM -0700, Reinette Chatre wrote:
>> I can confirm that the removed comment explains why m would be initialized
>> when used in the code that follows.
>>
>> How would you prefer to address this? We could add just the comment back in
>> support of future reports or perhaps by adding the default case back with
>> the same error that would be returned earlier when there is an invalid
>> EVENT_ID. Something like:
>>
>> ---8<---
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 57e4bb695ff9..05b99e4d621c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read
>> *rr)
>>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
>>  		m = &rr->d->mbm_local[rmid];
>>  		break;
>> +	default:
>> +		/*
>> +		 * Code would never reach here because
>> +		 * an invalid event id would fail the __rmid_read.
>> +		 */
>> +		return RMID_VAL_ERROR;
>>  	}
>>
>>  	if (rr->first) {
> 
> Right, I would normally not take a patch just to fix a tool because it
> cannot see it correctly.
> 
> But Babu has another use case which breaks the build so I guess that's
> serious enough to make an exception.
> 
> Babu, can you please explain?

Details:

The patch applies cleanly to RHEL8.5 tree but the build fails with an
uninitialized variable warning treated as an error. The RHEL8.5 Makefile
uses '-Werror=maybe-uninitialized' to force uninitialized variable
warnings to be treated as errors. The build error was found while using
the redhat/configs/kernel-x86_64.config kernel config. BTW, the 5.14-rc6
build passes and it does not build using '-Werror=maybe-uninitialized'.
The error from the build is below:

arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
uninitialized in this function [-Werror=maybe-uninitialized]
  m->chunks += chunks;
            ^~

The following patch fixes the problem.

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
b/arch/x86/kernel/cpu/resctrl/monitor.c
index 57e4bb695ff9..553cc6410442 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -304,6 +304,8 @@ static u64 __mon_event_count(u32 rmid, struct
rmid_read *rr)
        case QOS_L3_MBM_LOCAL_EVENT_ID:
                m = &rr->d->mbm_local[rmid];
                break;
+       default:
+               return RMID_VAL_ERROR;
        }

        if (rr->first) {


Reinette,
Are you going to send the official patch or let me know I will send. You
can add signoff from me after adding above details. We probably need Fixes
and Cc: stable@vger.kernel.org.

thanks
Babu
