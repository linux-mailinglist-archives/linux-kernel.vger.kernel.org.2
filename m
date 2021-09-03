Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0F3FFE06
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbhICKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:14:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:47862 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349006AbhICKOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:14:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="219086255"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="gz'50?scan'50,208,50";a="219086255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="gz'50?scan'50,208,50";a="500283920"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2021 03:13:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 3 Sep 2021 03:13:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 3 Sep 2021 03:13:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 3 Sep 2021 03:13:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 3 Sep 2021 03:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=addDxbSq5ozw8uDv96EeGv8Qrcqu1KjwiUAVtL85BjaGwicVXUh0KOMIDp5PNkfEFb/dCI/d2eIZJ/fWN1atB7GhrTbisSTCn2g9pyMtjDubkwHl33KPlhBCwC6TJayc/I6fFVRHvrap90wROa3ZHbaDrVnb3r8aF9jeBeu8CvMsR3JSREAJYPiYJE4vow2CME6+J8Qvxk7gTbkpiHsFpn28IVg9J6Zi8xLXkeN4ATFAUtQ1A+/rnMk71PjlxXT9xdtUgzAi+FaeOfhe6kmNNv8QjaXVxXay36GmYbxxEXzS6/bSZwD7cMpdjldJSBqcCfz/Z986nlHcn2dNv410+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NMcsMqk49QQFa+Yq+6t3oR8PKZWeoYbEQB4/DUIgAq4=;
 b=LZYq8tTZQVz8cpn+FuFWwHrSO7BCdMi7HKTDmHYEMP3ypU5sO7mOy5SP/pyNwh8igHkDwWqieyysNQZUe1aJfhHbPOn+rX3gPEuBe1g5oKJrVaTRFSj977xPsB2use8gs1i0MDYZ0UiVOJN0faquJkKZqHQJgzyRsItewRf+/41dvVz9dam+oXk015M8isRL1hLqV/bvXeX4oJP2nr4cwEbT5izwiXeEuxsURjX45q1bn8+ldKWDZxobXAoEaRSbGJa7N7DAsIKUlFKfmnvqUsh/pZR1Xz/aWK89Qd82SC40Bh/TNZ4AwtVByhmfMsUtp4lPZCiuVaKlCycnlAnqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMcsMqk49QQFa+Yq+6t3oR8PKZWeoYbEQB4/DUIgAq4=;
 b=gA0J8D4Cpyi0zuwP4BaMhqtFPx+LnBDvwUhOyVvOUTAXEGBohaRXLa6Mz2xMlLI+dT3dhGocXD7kGo4jgPgAqQr5FdJRLekVqSLVtIbwTkaqPFqIJHfgYE3SQ1NT8+l11D/1818It5PX8pqCB812D55MR5LxZyezkMLoQlZGf5A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5597.namprd11.prod.outlook.com (2603:10b6:a03:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 10:12:56 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 10:12:56 +0000
Content-Type: multipart/mixed; boundary="------------BXkrA8oR0OzEu0ps0fU1KxNN"
Message-ID: <bad7afc4-633c-8ac8-190a-548e24fe63ac@intel.com>
Date:   Fri, 3 Sep 2021 18:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.0.3
Subject: [jolsa-perf:ftrace/direct 5/8] kernel/trace/ftrace.c:5150:4: warning:
 1st function call argument is an uninitialized value
 [clang-analyzer-core.CallAndMessage]
References: <202109020147.jGOq0K6I-lkp@intel.com>
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202109020147.jGOq0K6I-lkp@intel.com>
X-Forwarded-Message-Id: <202109020147.jGOq0K6I-lkp@intel.com>
X-ClientProxiedBy: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.112] (192.198.142.21) by HK0PR03CA0112.apcprd03.prod.outlook.com (2603:1096:203:b0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 10:12:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff55166-88a2-4ffe-ca26-08d96ec3660e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5597:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB559779F68AC597C6505A4485FBCF9@SJ0PR11MB5597.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCoRKjBkwa39Z/yJtaZLji4MGMvHK153T4PuE50efaYG0YCuy/iKt0O1dk5Prq364iNfXSIROQjuDh8ODZaAQQ2dVayga9G1qIi+TdMozQxHuBZlXfoHGALwKALOEBmII60QX9QB21r0RchetK2yt3YrLYAafGQbuKUt0XWgiW9RP9kwZP4VZ55OBmZFDi3DeDRb01jREengTC2Yt7i78Y5o10Hnv59NqPZ6kGhi0jLh20x6yE31zHbyzks8ipATiY6Z4E0ZAc6SaZXBoe0DDvmWNrh1lma7jynkBdqrynUKyBfHISO1dAUJN4VOi3P1XmaQvk2LQhlMv2tlrMWbCdbrSbT0tWjYqKzWWZ5UeDLZXnBxVBDPb9sdGoSrT4sUJR4gTKCfgPBFEFlw9o1AA69QKyLVRqsOV4ZGsoOW9hLW798PAgPlBkHSWwdMNQWY2BMmV4uajj9nluUOkbQJxm3dgWEG73WzS2dGFAdaUDCJCNpaZQlOJArOgWC3/DyHaszt1OCr2zNarZf7dWfnNYhCklE74kMjfO2IJZHL9pIXE6qm9yZVPpMrNy+h2Dhj/V11gUx9js49czFpTRCb1UCMXE8p1cXTxUchnpJ0unt/DyDGULQlSmAN9078EB+GL2pwkWnOrBrtzAAKPNw0mpK6VWik4RpUpn1DGVD4XkfvjATq8UNJlJrH6KCTpsQcd3ER78FTQgVkh9T73x0lv+yVyuUhITE/nV+7Qe2u9fucQ1UDO0fasLUkKe5toaeuZkk/d1KoGTV5BJY08Lrh8NLoSrDPMDHHOcXIIjSQgi8ehCnFeCQsJ8OeUnjF4bOO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(235185007)(8676002)(6916009)(26005)(478600001)(4326008)(8936002)(966005)(83380400001)(30864003)(31686004)(4001150100001)(66576008)(66556008)(66476007)(6486002)(956004)(36756003)(186003)(86362001)(2616005)(16576012)(33964004)(66946007)(316002)(38100700002)(2906002)(31696002)(6666004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGt5Skd2YWQwMmZNRmJVaEJGZW1JR3NmdHVGMnJRVUdpNVFlZ3g2ZVgwYUVj?=
 =?utf-8?B?QnNEbFRMYzljSlVLSHpsNkdOTWZFT0R4a0NKUkltUGltQUs2TjZORGRuL0JJ?=
 =?utf-8?B?WlJ0WFRrdFhjN3BFd0E2T0NXZXcrakJ5OTFRaVJOQjZVVlVhZWJNWXk2RGpM?=
 =?utf-8?B?UlpucG1RQXJPLzFXTzNneWpmd1duT2MxYnRkbmtKOXgyczJoeGp0d0xQeVpF?=
 =?utf-8?B?aHFmMlVudzNWOXJXeVVqVjV0RHVtVncvb3ZjNlhZVjZVME16OGhtdGw0RWpw?=
 =?utf-8?B?VEpxbGZPZWk0dmxES1FMUG1veTVudEhmVkwwQ09Nem1uczRZKzl1TCtaOEpL?=
 =?utf-8?B?S216S3pEQUdFQVdFekxRNnFnVGkzSnlWb3NuT0dkeG03WDA5MDRINk95MlM5?=
 =?utf-8?B?MXBJWmRjN3JZSDFVbEpCSjJlam16Z1BrdHlmSU9JamtubUpkd25aeGZBdW5G?=
 =?utf-8?B?YUZIclJGVDE3Y0t0dmYzamFoUDhPUzRCV1krYlBBUVpPNHlSNWdBbFRpYmJo?=
 =?utf-8?B?T2lSTlRkVEtNVWpZY0ZpRldLRmlQQko2UXZjaGtPOXJPb3lLZzZYaU1mNjc4?=
 =?utf-8?B?eWV5UmwwbWVQck1pQ2huSU1HZjdYcWxRRFI1eU1MT210M29PTnoxZzJYYTBn?=
 =?utf-8?B?MWhFVVVobGV3aVlwa1g2QUxPTmRhZE9ETE9nWE5HMm9EOTB3VUI1UFo4dUFF?=
 =?utf-8?B?d3RMZlpzODBNV0F1UzVIUWFjMzFHU3BPWTcxdEdQeTQ1bWpOS0VLMFNENWZ4?=
 =?utf-8?B?a3VKWGwvbWxBeUhKVmdyUmN0VnhRdzJRNzVqVmlXaDRQZWlQYk1YdVBGcGJa?=
 =?utf-8?B?TXgyZkhxNnhYUlpPc1FHc0IxSVZyVHRyNkoyb29NTDZKVUpYRld4M0xocW5M?=
 =?utf-8?B?MVlTQmNPZzF4UUtIc1JycnJmMFA3SDNDaTFObVZ4UURxVE55bVN1VXdKQ2pH?=
 =?utf-8?B?MXpML2RIai9KTlFDVlYrY1lmbXpFSnAxNFV1WDFXc2xNZmRsV3pPa1I2QkUr?=
 =?utf-8?B?c2tlOUNNS1BmQW51eGJSaXdkTU9ma205eEdUNDA2Z3laMkxyTWR5dXhFTGdw?=
 =?utf-8?B?VUpVaEFnelZRbWk4YWVDL3dRYm9UOTd0Yzd0dnVqSDJsTUNGanRiMDdoc3Rh?=
 =?utf-8?B?VmlUOEVjZk9scEpqYXVxbXNERVBnQ2pYdmw5R1I1S21WeFdZb1p3b3NLSTY0?=
 =?utf-8?B?QkRZdE1oRmZ6eDVxYXJDVFp0K0Rzazdvb2wrWUtTaXRqcUU0VWVuTW9ZSllB?=
 =?utf-8?B?U3JUWWF6OVBrOEFvclI4eGREcktheUl5RnJrVjBUWmx0dk1LMXRyaUtZNVFJ?=
 =?utf-8?B?ZWJGdHcwTUhIc2hxdDJ2ZHcxY29RdGtGd2Z2NTYyd25Ed21SQlNlN2hNVlQ5?=
 =?utf-8?B?aGZJNmJqNmNMbmhyd2F5VzUvM2gzYWhKM0tON3UrRVRKcXBoRkpjU1BkZmZ3?=
 =?utf-8?B?MUJ3M0o5M1JmYVBJMjNQZFl6bHFKTVBmVnV2b2RUTkN2UzlubElDNEJyeGFi?=
 =?utf-8?B?MDZCd0xQdEpwNHNob3p0NHpDOGhEYmloSEczOTYxRy9Ud0hsSUJEeWQ0VG1N?=
 =?utf-8?B?Z0NKTHZoU2lsWHA1a1pSbjMyRFNQYk8wVEVPcnFUZFJ0VyszMVJTOWJaS0Nq?=
 =?utf-8?B?V01vN2xpNERSKzRHNXRzSnJhNVdEQVkrUVN4Q2w0VGxneDZkcURGQ3BtaEh3?=
 =?utf-8?B?djVvSENhQUZ5TE5HdTNzM3UyRUlxMHI0MjNpTjJveVBxbVlvWk0zYnJkeDZI?=
 =?utf-8?Q?EzZOQhVdZepzCFaelFSuaz1axhzBM4GID8+4bbg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff55166-88a2-4ffe-ca26-08d96ec3660e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 10:12:56.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acaE7Vdi05X1LxsPSZ5V5H9r320JfHL8BiEGfudSj052l1sodoAOiF8hcNcKkhTEHIImmEXLAV/3mknZIKa22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5597
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------BXkrA8oR0OzEu0ps0fU1KxNN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git ftrace/direct
head:   95a037919f1906d8bf164fb0c0066c9f298df139
commit: b45bdf4de5473d5c15090eceeb72a2d5082cde2d [5/8] ftrace: Add ftrace_add_rec_direct function
:::::: branch date: 32 hours ago
:::::: commit date: 32 hours ago
config: i386-randconfig-c001-20210831 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b1fde8a2b681dad2ce0c082a5d6422caa06b0bc)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=b45bdf4de5473d5c15090eceeb72a2d5082cde2d
         git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
         git fetch --no-tags jolsa-perf ftrace/direct
         git checkout b45bdf4de5473d5c15090eceeb72a2d5082cde2d
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> kernel/trace/ftrace.c:5150:4: warning: 1st function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
                            kfree(entry);
                            ^     ~~~~~
    kernel/trace/ftrace.c:5114:2: note: 'entry' declared without an initial value
            struct ftrace_func_entry *entry;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:5122:6: note: Calling 'ftrace_find_rec_direct'
            if (ftrace_find_rec_direct(ip))
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:2391:6: note: Assuming 'entry' is null, which participates in a condition later
            if (!entry)
                ^~~~~~
    kernel/trace/ftrace.c:2391:2: note: Taking true branch
            if (!entry)
            ^
    kernel/trace/ftrace.c:2392:3: note: Returning zero, which participates in a condition later
                    return 0;
                    ^~~~~~~~
    kernel/trace/ftrace.c:5122:6: note: Returning from 'ftrace_find_rec_direct'
            if (ftrace_find_rec_direct(ip))
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:5122:2: note: Taking false branch
            if (ftrace_find_rec_direct(ip))
            ^
    kernel/trace/ftrace.c:5127:6: note: Assuming 'rec' is non-null
            if (!rec)
                ^~~~
    kernel/trace/ftrace.c:5127:2: note: Taking false branch
            if (!rec)
            ^
    kernel/trace/ftrace.c:5134:6: note: Assuming the condition is true
            if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
                ^
    include/asm-generic/bug.h:121:23: note: expanded from macro 'WARN_ON'
            int __ret_warn_on = !!(condition);                              \
                                 ^~~~~~~~~~~~
    kernel/trace/ftrace.c:5134:6: note: Taking false branch
            if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
                ^
    include/asm-generic/bug.h:122:2: note: expanded from macro 'WARN_ON'
            if (unlikely(__ret_warn_on))                                    \
            ^
    kernel/trace/ftrace.c:5134:2: note: Taking false branch
            if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
            ^
    kernel/trace/ftrace.c:5138:6: note: Assuming 'ip' is equal to field 'ip'
            if (ip != rec->ip) {
                ^~~~~~~~~~~~~
    kernel/trace/ftrace.c:5138:2: note: Taking false branch
            if (ip != rec->ip) {
            ^
    kernel/trace/ftrace.c:5147:6: note: Assuming 'direct' is null
            if (!direct) {
                ^~~~~~~
    kernel/trace/ftrace.c:5147:2: note: Taking true branch
            if (!direct) {
            ^
    kernel/trace/ftrace.c:5148:12: note: Calling 'ftrace_alloc_direct_func'
                    direct = ftrace_alloc_direct_func(addr);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:5084:11: note: Calling 'kmalloc'
            direct = kmalloc(sizeof(*direct), GFP_KERNEL);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    include/linux/slab.h:579:2: note: Taking false branch
            if (__builtin_constant_p(size)) {
            ^
    include/linux/slab.h:596:2: note: Returning pointer, which participates in a condition later
            return __kmalloc(size, flags);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:5084:11: note: Returning from 'kmalloc'
            direct = kmalloc(sizeof(*direct), GFP_KERNEL);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:5085:6: note: Assuming 'direct' is null, which participates in a condition later
            if (!direct)
                ^~~~~~~
    kernel/trace/ftrace.c:5085:2: note: Taking true branch
            if (!direct)
            ^
    kernel/trace/ftrace.c:5086:3: note: Returning null pointer, which participates in a condition later
                    return NULL;
                    ^~~~~~~~~~~
    kernel/trace/ftrace.c:5148:12: note: Returning from 'ftrace_alloc_direct_func'
                    direct = ftrace_alloc_direct_func(addr);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kernel/trace/ftrace.c:5149:8: note: 'direct' is null
                    if (!direct) {
                         ^~~~~~
    kernel/trace/ftrace.c:5149:3: note: Taking true branch
                    if (!direct) {
                    ^
    kernel/trace/ftrace.c:5150:4: note: 1st function call argument is an uninitialized value
                            kfree(entry);
                            ^     ~~~~~


vim +5150 kernel/trace/ftrace.c

8a141dd7f7060d1 Alexei Starovoitov      2021-03-16  5093
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5094) /**
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5095)  * register_ftrace_direct - Call a custom trampoline directly
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5096)  * @ip: The address of the nop at the beginning of a function
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5097)  * @addr: The address of the trampoline to call at @ip
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5098)  *
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5099)  * This is used to connect a direct call from the nop location (@ip)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5100)  * at the start of ftrace traced functions. The location that it calls
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5101)  * (@addr) must be able to handle a direct call, and save the parameters
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5102)  * of the function being traced, and restore them (or inject new ones
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5103)  * if needed), before returning.
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5104)  *
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5105)  * Returns:
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5106)  *  0 on success
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5107)  *  -EBUSY - Another direct function is already attached (there can be only one)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5108)  *  -ENODEV - @ip does not point to a ftrace nop location (or not supported)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5109)  *  -ENOMEM - There was an allocation failure.
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5110)  */
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5111) int register_ftrace_direct(unsigned long ip, unsigned long addr)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5112) {
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5113) 	struct ftrace_direct_func *direct;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5114) 	struct ftrace_func_entry *entry;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5115) 	struct ftrace_hash *free_hash = NULL;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5116) 	struct dyn_ftrace *rec;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5117) 	int ret = -EBUSY;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5118)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5119) 	mutex_lock(&direct_mutex);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5120)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5121) 	/* See if there's a direct function at @ip already */
ff205766dbbee02 Alexei Starovoitov      2019-12-08  5122  	if (ftrace_find_rec_direct(ip))
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5123) 		goto out_unlock;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5124)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5125) 	ret = -ENODEV;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5126) 	rec = lookup_rec(ip, ip);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5127) 	if (!rec)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5128) 		goto out_unlock;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5129)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5130) 	/*
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5131) 	 * Check if the rec says it has a direct call but we didn't
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5132) 	 * find one earlier?
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5133) 	 */
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5134) 	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5135) 		goto out_unlock;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5136)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5137) 	/* Make sure the ip points to the exact record */
406acdd32d3e7d5 Steven Rostedt (VMware  2019-11-15  5138) 	if (ip != rec->ip) {
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5139) 		ip = rec->ip;
406acdd32d3e7d5 Steven Rostedt (VMware  2019-11-15  5140) 		/* Need to check this ip for a direct. */
ff205766dbbee02 Alexei Starovoitov      2019-12-08  5141  		if (ftrace_find_rec_direct(ip))
406acdd32d3e7d5 Steven Rostedt (VMware  2019-11-15  5142) 			goto out_unlock;
406acdd32d3e7d5 Steven Rostedt (VMware  2019-11-15  5143) 	}
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5144)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5145) 	ret = -ENOMEM;
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5146) 	direct = ftrace_find_direct_func(addr);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5147) 	if (!direct) {
8a141dd7f7060d1 Alexei Starovoitov      2021-03-16  5148  		direct = ftrace_alloc_direct_func(addr);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5149) 		if (!direct) {
013bf0da0474816 Steven Rostedt (VMware  2019-11-08 @5150) 			kfree(entry);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5151) 			goto out_unlock;
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5152) 		}
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5153) 	}
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5154)
b45bdf4de5473d5 Jiri Olsa               2021-05-18  5155  	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
b45bdf4de5473d5 Jiri Olsa               2021-05-18  5156  	if (!entry)
b45bdf4de5473d5 Jiri Olsa               2021-05-18  5157  		goto out_unlock;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5158)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5159) 	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5160) 	if (ret)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5161) 		remove_hash_entry(direct_functions, entry);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5162)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5163) 	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5164) 		ret = register_ftrace_function(&direct_ops);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5165) 		if (ret)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5166) 			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5167) 	}
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5168)
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5169) 	if (ret) {
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5170) 		kfree(entry);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5171) 		if (!direct->count) {
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5172) 			list_del_rcu(&direct->next);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5173) 			synchronize_rcu_tasks();
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5174) 			kfree(direct);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5175) 			if (free_hash)
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5176) 				free_ftrace_hash(free_hash);
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5177) 			free_hash = NULL;
a3ad1a7e3968900 Steven Rostedt (VMware  2019-11-08  5178) 			ftrace_direct_func_count--;
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5179) 		}
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5180) 	} else {
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5181) 		direct->count++;
013bf0da0474816 Steven Rostedt (VMware  2019-11-08  5182) 	}
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5183)  out_unlock:
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5184) 	mutex_unlock(&direct_mutex);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5185)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5186) 	if (free_hash) {
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5187) 		synchronize_rcu_tasks();
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5188) 		free_ftrace_hash(free_hash);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5189) 	}
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5190)
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5191) 	return ret;
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5192) }
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5193) EXPORT_SYMBOL_GPL(register_ftrace_direct);
763e34e74bb7d5c Steven Rostedt (VMware  2019-11-08  5194)

:::::: The code at line 5150 was first introduced by commit
:::::: 013bf0da0474816f57739daa006c8564ad7396a3 ftrace: Add ftrace_find_direct_func()

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------BXkrA8oR0OzEu0ps0fU1KxNN
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--------------BXkrA8oR0OzEu0ps0fU1KxNN
Content-Type: text/plain; charset=UTF-8; name="Attached Message Part"
Content-Disposition: attachment; filename="Attached Message Part"
Content-Transfer-Encoding: base64

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmtidWlsZCBt
YWlsaW5nIGxpc3QgLS0ga2J1aWxkQGxpc3RzLjAxLm9yZw0KVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBrYnVpbGQtbGVhdmVAbGlzdHMuMDEub3JnDQoNCg==

--------------BXkrA8oR0OzEu0ps0fU1KxNN--
