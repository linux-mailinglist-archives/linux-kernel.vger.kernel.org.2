Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5402745D24A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbhKYBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:09:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:44775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346394AbhKYBHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:07:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235354492"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="235354492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 17:04:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="675052268"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 17:04:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 24 Nov 2021 17:04:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 24 Nov 2021 17:04:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 24 Nov 2021 17:04:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqtErgb6OUgS1AW+QyYruS0At56UPfto9XAYJ70xqVtBnayRWHkmO1hhst7lX2qa4VqjwCHEvnvwbKGUSWAEeXPez+U8GC+Drvq6hD+urM13JKF7g84JyfgIpqyX9EykxWg6QnV+08PT9bP46JAhoMIm2mOJCvTX+nDFJXXQD5R8lHi4r6uqhZ/2bQNHkLAWg+ZhfB1IbU4c6JwIyYv1EiCnDk47nrP7tOig3pUzhIVYuonDIMCcecgkDYp0U747dcmt4W6ZJkWBwxCVhyarSc2fevkwHS4vUiM+tRYkD2nb0FHss9pHQ3xPN7YZQL9sMmW0wI8aVFXHJizhkrFj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNiUSIgXHpKm1x+ZU8KcCQw0sllBh0YEDq0BDzd14uM=;
 b=U9JSc/SlnDje9ue/ObYXx+3AqhK1oKqpeZtMLRveJ5hDbbohYjVzwz4UyAPq/ftjeK0vyBPWUcC1wwYjOZfVH/adjBUHJPnkmU7v4ElVHv5dHfPrys/EYKxcq07RZl9zLTx48Q/B5htQbCwubNGQgFwddKmG8+855IZltPoJVypwjrI0Xf6dHdNEHTK2KkAjbdqQlSDa4Kng730C2nNcFMlLV4Yyk2byfB1UhyvxQHncR8cFOdcJ+VkxlRE16qVx5aDPUk3ezV2aI9ZewU20S0TOIez65SNBIzPJ1iiO5pfV35gj/Rb+pLKBpwPa/2iIjmHTDijbc4O38U4mQBc7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNiUSIgXHpKm1x+ZU8KcCQw0sllBh0YEDq0BDzd14uM=;
 b=XPkS2pJJN85gN8rhHSA96G33qaU6APIwwCURn26u0HXEEhL3Hy3bxqOJINM5JC8ROLD7z5W/oIIhcla0UIu0+DS6aZO5rSU9TgnTP8ZaVgPH41uxHc9l2nllhXjJFhCcu7Luqkl0ik+pIh+iVa5gPfHSqgLV7UrizmeRy+w9iZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 25 Nov
 2021 01:04:28 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Thu, 25 Nov 2021
 01:04:28 +0000
Message-ID: <6b79948d-5e22-c8f7-74a5-37fb345b0e40@intel.com>
Date:   Thu, 25 Nov 2021 09:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: arch/x86/events/intel/uncore.c:847:4: warning: %u in format string
 (no. 1) requires 'unsigned int' but the argument type is 'signed int'.
 [invalidPrintfArgType_uint]
References: <202111202115.uSvWnxj7-lkp@intel.com>
Content-Language: en-US
To:     Kan Liang <kan.liang@linux.intel.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202111202115.uSvWnxj7-lkp@intel.com>
X-Forwarded-Message-Id: <202111202115.uSvWnxj7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.142.18) by SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend Transport; Thu, 25 Nov 2021 01:04:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22d6f640-c013-4adb-4f05-08d9afaf87f3
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5677:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56773A8DF48195520A413948FB629@SJ0PR11MB5677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/oe4Rfv0SKhrKfo2GRqn2gNXUnb2dPzaJomB2THscXExoVSlRBbpLlJ46VNSIgUQimBy4DKWWiM/S8mdPej9wearfw46j//mRhIvzIRjRiG3ZOIn1Ab3Ox8wlvUsq2TxEqItM2iidIhOPDQqiyYcfkuqjkrDhuzMmRbe7X8d/26P9IPo/2spMHJOORMqN3aaXT5xEuxFMXhdgnctHAZj+E24P3FDSm+YtYz3eEnDrIHy/fZ4m09KPBRo1fJnnZVpRm5HVnEQrL2atn+uAu+2h5iGT3pdd+7f+ij51Q3Ab/5bjob9IAnhr6RfQqGALRpdOS0+MJmrH1s+BpmiDpnhuQ6h6T1Y+ixd6yqmNCmeISwkFGnf+ahkpY3QeBisKKNCBN+zD/o+r9R69lNYdvNsz4KO90KO2YLWrasmeBI1zNJMBNJRuETmNAvOx3ZWkDJzY44NXq0ARTgRKCDnQrVpg2/t3HILRbMgPz967r2/Hjh9PQFB4b4r9WOsZdgSjAlvwItU7DUwjdtvjywdwVbjKdN2gPY3lWxuvGOOolQi78cbNGakQR9FWg3EXeYzK6esiEtGXlLaHvgcK+xZv3YUpi55YdHz2AzBAg/A1elGI/0ksCT2WgBEWcZy7KT86iI3yUPFwOiP3ZwQiUcdbCNwlMwmyJxeU8AoPIn6a3oEaONpefrqDH6jp1/6euqR/nkkvtQcVeAs5VIaCqyT4RXS7Rj4UiKNqTtyCN9Z/N9I9Sk0/Q+ZfLTS9FjthTFWMso0G5AeCr5P259K/uNkxHf2v5+HmmVGS8+rxBVL/c+FKNjkbZ03MssMw5eXmBkpYSJqVFW/bBSw7rDh7UUlZx06tDuey2Ut7xLISoPkUP3ldk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(186003)(86362001)(26005)(36756003)(966005)(38100700002)(8936002)(2616005)(8676002)(956004)(66946007)(66476007)(66556008)(6486002)(31686004)(6666004)(54906003)(16576012)(316002)(83380400001)(5660300002)(4326008)(2906002)(6916009)(31696002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STl6eTNob1FqSzhjek9RMzlXb3dMZjJTUHRJSlArTHFOV2p5Ty9iSXNEQzFp?=
 =?utf-8?B?THc4VHVsWU9vSUVkWW5kK2JkeXBhbzQyRENlWUUxNS9Jams2eVZKVzNqZHRS?=
 =?utf-8?B?VlY4UmVrZkkwamJVcXVlbWkxN2xyV2xWNndQajkyMWI2aktjRnJwV2hqdHdB?=
 =?utf-8?B?dGIxblVjVWlaLzEwcDBlaDFkMkNCSFB1TlM3enBFdWFXdWpEUkg1Mldydkpz?=
 =?utf-8?B?K0dkb2xMTEozOFV2aVZtbHM5Tnc1Y2htWUFzU2FpMFp3bVQvV1V6Ti9OdjVH?=
 =?utf-8?B?U2hHTWhKUC96cUFENnB4NzdRRmh5MTFtdXVDZks2eVJrL0VkNEd6VlhkRE9h?=
 =?utf-8?B?ek5OWXYwelQzWWNQWXg0dTRUWDh6TlVnUmRzbzBtN1dTTWJ6bW12cUpXenYw?=
 =?utf-8?B?Q2ZsMFFJZG13QTgzbnZkSDRIcnZzY0wxQnZCa0hwOGRBNnFXZnQ5NWJMTmxo?=
 =?utf-8?B?Q3lWTSs1ZGF0SlJ4VTRmc1RDVHFMV2dwU3c2cXRWTkZWcXFUYVAvM09oUGs1?=
 =?utf-8?B?VWRueHYrTkd0c1pkMWFyNENUZXREdEQyaGxZRDgzenVjejlDYndidklZM3ZU?=
 =?utf-8?B?cVJlRzVTVDJMSTNWdGFzTWFsRFNDdTY2TTNuV1VnMCt6RE05U0Q1ZjZxZVdC?=
 =?utf-8?B?eVFSNGgwbStRbmZ4QnBvaVc1aUtKZC9SalZUaUhaZzV6cmoxbG10TURPQUdE?=
 =?utf-8?B?eUc1QnhLMXB2eXIwWmRETW4rRkM0YjgyM1VUWFJIMXlRTG1vQXNId2ZGYTJt?=
 =?utf-8?B?Wlk5cWJYZHpyMmxwUHJWQmVNSi9Cd0ZtUTdtYVRBeHdOMFo0VkdyelRwdjhF?=
 =?utf-8?B?RlgyTFZrb0tUaWRmQVFjL2M3bDd1Uzk0cmhSTDNpR21CckJ4U0dKczI1blRW?=
 =?utf-8?B?M3Rjc2FaV0w5UFMwZHhDV29ieVdyaDJXSnR6MExMNjBXVVRreHNFZVlSdStJ?=
 =?utf-8?B?Z0YxV1BMMmRQWmRTTE1MeHpiVCtibzZzTEYzVVVXM2xCZTY0cVRKcVl2Nzlr?=
 =?utf-8?B?SVdOVWtKaEpnNis4ZkQrVVZZNU9PbjdubitiN0NXZDNGSGlydDl2TFNQYTRU?=
 =?utf-8?B?cE4yR3U5RUhXdWhLcFVsZ0llSjhuZnJ2eDM2SldmRThoTHg1MTczY2pvS3Fn?=
 =?utf-8?B?V1RhVXlEcWhTcEUrVVRvZW5yN3JGMUNWMkRaZzBhQThDL0srVWJlRjc2RE4r?=
 =?utf-8?B?bkNMMlV0N1B0T3Z5WGFidFRkb1BZbHR3OVJnUnkzR2ZjRm1RYzNpeUtCRWhR?=
 =?utf-8?B?c2xGVXZ2Y0VFeGtpd1FXVzZRSllVQTI2Nk02WVpiVnNwOEYraERkK3d3WGlT?=
 =?utf-8?B?eEVRdXlHcWs3eEk0WVEyWWxQc282d0gvTzhVc1E3bVhZeVN6ck5EZ2puOU14?=
 =?utf-8?B?VFhmYTQxV1EyN2dxSC9oKzd3UUxuWFFlOFFVbE5QS0hIZSt6VTlOQXlOalRv?=
 =?utf-8?B?UHA3NTM4eVQ1OVQzMlFnTHpacEZSVmNNU1l4UmVSOElWcENGajJVNWQ4Tk93?=
 =?utf-8?B?VktoV3JnWlJtL2pGVXZnS1NDRDhOM0c1MzBWTG9jUll3QkF0RDRaVEN5Nk44?=
 =?utf-8?B?MHZJN0lkejExZ2QvSzNKRk5JS2xxK2F6RjltbFhHSzhwV2FVZ1V1L2NwaElh?=
 =?utf-8?B?M1dUSjV4MzU1c1NwWTYrNWVDWmw5QnRVMnRSOUE4cjNFODVuVWF3UVN6dFpZ?=
 =?utf-8?B?NEUweTc5eHVTSlRLeFRjNHR1aVd3MkNta3I3T2lPNzZKUUxMMjEycktyUmhv?=
 =?utf-8?B?ZHk4YmNPWnJJVU5SYTYweWdlN1hSSC9ZK2ZKVDR1ZS96YVg3MnRCeTloK1Yv?=
 =?utf-8?B?Z3JUZnVFS3NmUkVxdnBVK0tZNVQ4RG5oQVVQTFhWeWVkRzNkbGdmSHlSbHBr?=
 =?utf-8?B?SzVqeFBxMFVDWjRlZ0N1amlrRDhvL1ZwaGErZzFJdEtUNXM3RWFZcis5Rmd6?=
 =?utf-8?B?WU4rM0t3RVhsTVBYQ2ZmbHNoTTRKZmoxYlVNQ0ZiL2p4V2FnYldnd0NXS2Jn?=
 =?utf-8?B?Rm9kTkNhblZZMm5PZWdYbmgrTUJlUlFJWlI0eHEvQmY2ckNJZ0FHbzRtazdF?=
 =?utf-8?B?K1ZWVTJTajhhdEt6L2Q0OFRNZXBDWGhpcWZJNVE2S00zKzk5RlZnVFU2WFNT?=
 =?utf-8?B?UDd1SnBoYUpLeTBrK2hWU3preUhjMEdtYkZ3bWxWeHJ1TUFkNmhCZlhkYWpl?=
 =?utf-8?Q?r2mUvs97Y5ViSs5RGZ3BzeU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d6f640-c013-4adb-4f05-08d9afaf87f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 01:04:28.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgsnE420U7Ke8XqK7AQyXgHzj1bBzuGx8A2TW8sQDHN/U4Mp3G0eNfeTaIvJhDfXiYfq56CjS/lg+RaAC8/Cmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
commit: d6c754130435ab786711bed75d04a2388a6b4da8 perf/x86/intel/uncore: Generic support for the MSR type of uncore blocks
date:   8 months ago
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

 >> arch/x86/events/intel/uncore.c:847:4: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
       sprintf(pmu->name, "uncore_type_%u", type->type_id);
       ^
 >> arch/x86/events/intel/uncore.c:849:4: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
       sprintf(pmu->name, "uncore_type_%u_%d",
       ^
 >> arch/x86/events/intel/uncore.c:849:4: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
       sprintf(pmu->name, "uncore_type_%u_%d",
       ^

vim +847 arch/x86/events/intel/uncore.c

314d9f63f38509 arch/x86/kernel/cpu/perf_event_intel_uncore.c Yan, Zheng 2012-09-10  836
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  837  static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  838  {
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  839  	struct intel_uncore_type *type = pmu->type;
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  840
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  841  	/*
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  842  	 * No uncore block name in discovery table.
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  843  	 * Use uncore_type_&typeid_&boxid as name.
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  844  	 */
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  845  	if (!type->name) {
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  846  		if (type->num_boxes == 1)
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17 @847  			sprintf(pmu->name, "uncore_type_%u", type->type_id);
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  848  		else {
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17 @849  			sprintf(pmu->name, "uncore_type_%u_%d",
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  850  				type->type_id, type->box_ids[pmu->pmu_idx]);
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  851  		}
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  852  		return;
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  853  	}
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  854
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  855  	if (type->num_boxes == 1) {
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  856  		if (strlen(type->name) > 0)
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  857  			sprintf(pmu->name, "uncore_%s", type->name);
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  858  		else
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  859  			sprintf(pmu->name, "uncore");
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  860  	} else
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  861  		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
d6c754130435ab arch/x86/events/intel/uncore.c                Kan Liang  2021-03-17  862

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
