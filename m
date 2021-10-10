Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2774D428066
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJJKPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:15:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:16980 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhJJKPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:15:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="290218758"
X-IronPort-AV: E=Sophos;i="5.85,362,1624345200"; 
   d="gz'50?scan'50,208,50";a="290218758"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 03:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,362,1624345200"; 
   d="gz'50?scan'50,208,50";a="440395299"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2021 03:13:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 10 Oct 2021 03:13:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 10 Oct 2021 03:13:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 10 Oct 2021 03:13:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 10 Oct 2021 03:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVsrlWN0SEQuOz4srOR2mLzuJTO4W5prXAkqb1bpTQTVCFhSPpOYLmTgNhFl/oeAdJ4qjZjN/8b6UGmU5VMwDiv08qKr7TjpjZygfKM/zH3jaWKGh9FuGOK8XzTrlQzQI37c3alrLNZNgnkK+UCOoCviVfnH1CViElvMuOgTDfN15q3s7+f1IDyMczJrSRaT3VIyyx8+bzdNcXWRn+1i8e684ur/moGlE9lZt+ySI1SkLqLV+Rxt5XlVk3lL64YhvobnE5Jk9oJd7LkP8UULwTlOAc0CUmr9v+uKeqPkUcdNQR4OjNjwRcGiQQwVMiRpwv9cfUt5rHEuT7mPTUnhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShUiC2aJ8SIS/qwnr5V9YM0s4aAIQQtSYt3NmPAb3uQ=;
 b=NUhxE6y51wIh2+t15/Sov+YFwHI1HEouqTXp1RlZvCcPKC1UZ3Rc2mIWGeDgZoZAwU2BjbMw0UwS6apWhMBj4zTF48Qa6bC3Bwpv9qYfvhIhdnShVUn3hoeIZ66wFPcUpTwOok4+9PqG99THXpc/2jUas7GB0J0gvp64COXu4Cx/bBWmr7v9FUif5EJWzZmH6IzdU1uB/cteFO0Cu6nzzWqa7uKwToIQ6FfmxMYFrv/rzkEQm/dnFx2AyY8oVLAlYO57/Vx7ciY3dcTYtYwI+sk9mvC+QUUU1KCHkmVwvFHJPq8CkRhNRUK26ExnLpxWaCNaCgnEgMNzAZgj27+pqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShUiC2aJ8SIS/qwnr5V9YM0s4aAIQQtSYt3NmPAb3uQ=;
 b=PgFnNxepOmJUcdNdWVpV/oW3jw4+hJLdBRNcpU8CXVF5u05JtqmtcW8cZW2zk3txQ0KAGZp/ip6UN0RKu1oDs/MpPsCzrxFFmE60L6WT5H1tF+PWr39lkW6Kv+uRZmnqK6FcTkUHf5R3cyf63TmBeLA/JT2G8WGoycWG/dBZ3Mk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Sun, 10 Oct
 2021 10:13:33 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%7]) with mapi id 15.20.4587.025; Sun, 10 Oct 2021
 10:13:33 +0000
Content-Type: multipart/mixed; boundary="------------X27Al6Wj9IyXGABHi6Mrc0QN"
Message-ID: <c1210006-652f-32ef-8f5d-3d1dc026c711@intel.com>
Date:   Sun, 10 Oct 2021 18:13:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.1.2
Subject: [meghadey-crypto:crypto-avx512 5/6]
 arch/x86/crypto/aesni-intel_glue.c:683:27: warning: Value stored to 'data'
 during its initialization is never read [clang-analyzer-deadcode.DeadStores]
References: <202110012233.slVpKlUF-lkp@intel.com>
Content-Language: en-US
To:     Megha Dey <megha.dey@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Tomasz Kantecki <tomasz.kantecki@intel.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202110012233.slVpKlUF-lkp@intel.com>
X-Forwarded-Message-Id: <202110012233.slVpKlUF-lkp@intel.com>
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.254.215.56] (192.198.143.18) by HK2PR06CA0017.apcprd06.prod.outlook.com (2603:1096:202:2e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Sun, 10 Oct 2021 10:13:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 814ba328-aeaa-4375-2811-08d98bd69d68
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5661:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56615C60CA760AAEB3CAFCA1FBB49@SJ0PR11MB5661.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EETIDfQBUNpuADvFzCBTa9T27RHHHQCP7pWFiHe6Afa9w+oZv+PL7l1Kui4LFKGn7n4CaYUJKsqdz0WI4rbBD84vzasYD1iNd3ffVQNOP7lfwsXP6phYwFKOZ8KgrwdZFMBHUBiGXTMxhsaQruLVfMt3ukE5fYZOvaZT/AGU8Tizj7ARGZp3osYMIxdXSCTtoXSESPqV6arN7CKwO7cojPJ4BrHXL7qsCbebZ1DMxdpGYrYMWO2PkOTWG+VWuu3i/EaHcwbVLRDaB1QtMmvMA0MOcrEGy+4Lfv+7SOFvuBziDHfLuL3HT7+QtKSas56CI2z8Sj9jjhxHi2/wujNfmO4ein8iM+DFwRhLQn7hLA6l3ZwDsTB+dQ0LqCo7hG1GtWFhKcws8b1Dw4cn++sD0WT3hK63FxXDcP+rakcg9ZVkX2T2A2JCvCOKe3ZIusuBTOrro/uTE7ndG4iite9qpoLkMhDEolvnx++BxCRAMG7/05x5ZQQ7oDPLXeq9ISaNXObtPVxg44wGdKv8crDTGZhpB04bUqNhhlXUcyVTm8hw8EvuJcyus1coyYEJ7Lx82DZT0fxhT3ljmWs/JtL0QNUEMBpKs20Pa4Ucs4IhCqn9FDGY7uw5WQklxuFuFci+AsRjHodbl/Jlw8kXD1AltYEsVTFHG6oUmCmhTZHzQVlf6UeYiTOO7+EZBuvpPq0NgsEXXCnbmxSmqXrnSh7RHgKjIPpJJ51Xx7M0ilhEblEc0VfcYY6bHCwJmJAPbD9cK9+7ybNIKgKe0EyJ+bftH8CzBumGxXEWoBZx3LkHLZ5rVQLfRhXL+13EBUO0eQUo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33964004)(6666004)(38100700002)(66946007)(66476007)(66556008)(6486002)(956004)(2616005)(86362001)(83380400001)(31696002)(26005)(8936002)(8676002)(107886003)(36756003)(2906002)(186003)(5660300002)(316002)(4326008)(966005)(31686004)(16576012)(6636002)(235185007)(30864003)(54906003)(37006003)(6862004)(4001150100001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjR6RlFodkt4c1kxK01FdkN1bHlPOFplLzUxeVZzelh1Z1dxOUozQzRKZU82?=
 =?utf-8?B?QWJUcUtrK05KdUE1VXRidjhEU0w5VkRhb09LMUlxNDJFM0ozcEpFZmNFOEJW?=
 =?utf-8?B?Wk0wdDN4bVBzK3huMUkyRHRnU1FGbmZWMkRqeGp6aFBvK3MvM3U0bEZveUlX?=
 =?utf-8?B?bFlCdk8ycDR4WDF6OEtMWUMySGcrbTh2d1BSY05nVXBvOS80amJhQ3RkU2Z1?=
 =?utf-8?B?N2Vrck5saE43cFlFK3VSWGpERnFKMTl1K1pDcGlmcFFSNlNaZVJKcjNGRXFZ?=
 =?utf-8?B?OUkvT2c4Y1ZEeVdYTVoyR1VzOGhwYlhoOWRibnQyeXNLTUczRGl5VDZzT1Mx?=
 =?utf-8?B?MGNaTnQ1YVpGWDVqYTJLaW9yNnZ5eDRteDJ6ampGczcxUENzTjdwc3lic1BZ?=
 =?utf-8?B?bnFhMW5oWHp6eHFRSDRqUGlWV3lJbW1JMXJnbnZwdmpmRWVuTlc2L2haM29E?=
 =?utf-8?B?V0VNVTYrYkRiOWRucm5uOUZOdldlYzJkSEpGVGRPL3EwYkkxNnhVNmJVMHg4?=
 =?utf-8?B?QXpRc1N2NXdpaDJUdjE5YVpVUFVkWktqdUtZNTd4bnk1MnBRRXQreVBvdGpU?=
 =?utf-8?B?Z2I3ZnRnaWM0VVlYNEQxMHhOLzIwSTBEU1hMKzlCVjRNWnFNZ0Fmb2xBdmVk?=
 =?utf-8?B?UGFBbXkyZ0w1YllXdWM1REtGU09rVXVLWmxJSWJKTjNmQnhJUWcxcElET2lF?=
 =?utf-8?B?SXFGQkkyOWttYW0zVUhCSVorYTNRd3dXR2tUK0FVZ3g5Vm96M2x5Nkl1NzVF?=
 =?utf-8?B?K2dTVSs2U3YrS3ZMeXJ5TWx2NzVvUTlSeFFJdFUyNG1jZnFlcndQSTBaVXdq?=
 =?utf-8?B?b1FoUWhTNW1hTlJkRDBOYUhseERDQ29icjk2T3hmOUxFaUpVMzFTU2NVTkx5?=
 =?utf-8?B?cGUyN2lkd2xFYXJudFZrL3VSbytvRC83T1ZXNG9rN1R1NkVJYTZqaWdXMzNS?=
 =?utf-8?B?TWVZdlNEQ1BxVVJKT08yZlkzcWxxWjIreHd0VUxIcWRGVG11d0drQzhRY2Vm?=
 =?utf-8?B?UHFuVE9SbVJ3WHQyN1dkMDlDMitoc2RQVFZ6VGtHUG54RTlVZ2dsdlQ5NlJu?=
 =?utf-8?B?RTRDbmc5aWhuNCt0SEdNY1FLNDJ5T0VKMGlnOHpjdGM3MHVYWGdzT2hkeFJv?=
 =?utf-8?B?U0pVQ3ZuOGhDSXdONUxHS2Z6Nm4weHBsY0JQMlNRaHdvMkY4QTlnVmFkYlE5?=
 =?utf-8?B?YWJ0VzB1RkdYM0RZT2lnNzV5eVdQMTIzZlpYZDhyWFRNeGZqbWpJOStPOC9Z?=
 =?utf-8?B?YzJNcThtY3ZiZ2xGQTZtd0Z6OUxERGRIakZ0aW9LcHh1VGtFRVVwM1dzaW4r?=
 =?utf-8?B?RW05dmI1NkxhaDhaN2Rzbk5JL1JEL0haaXdJTjFWYVptU2N5WlNiNkc1Q1hv?=
 =?utf-8?B?ZUxlMU9KUUZwSWhlVFAyRUk2c1JMRkFKdlprNktPaXF1VjQrVnFoVHg3eEND?=
 =?utf-8?B?Mjlxb1ZuM1NDTnl4bGVxUFpIQ2FwMm1uZFpwSDFZNDdCVlNobUxhVXlEd0oy?=
 =?utf-8?B?bHRoWjVKaXlqYUtCWDYzcXN3Wm92dzJyUzk5aGRNRGJOT2s5LzYyQUVXVHBx?=
 =?utf-8?B?TlRVdWJ1WnBPVmVpRS9JeXN4cGJESTI1M0xSSmRVUFUyQldhYmxacDFSSGcz?=
 =?utf-8?B?VTB0MjZYZnp5ZzlRNGZkbjh0RXFvZmZXWXg2YStGT04zeElzWlJ3Vzc5UjV2?=
 =?utf-8?B?ZHIxTlo5dXE5UEFNWUp6R3VUblhIcE1tR2pNbjlMTithZHlpeXBEazV0RG4z?=
 =?utf-8?Q?TsayMCniexsGMHVO+Th9/7GT4nXYay2zGfDKpXn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 814ba328-aeaa-4375-2811-08d98bd69d68
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2021 10:13:33.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Blhq5KOyWYnXRoBLYlUdZaB97C41gw4/EbDf+7lbI9xsUZJZi7VHwdGMU3C0UdfJEEx62aYfNxScCgd3Rw4Sqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5661
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------X27Al6Wj9IyXGABHi6Mrc0QN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://github.com/meghadey/crypto crypto-avx512
head:   9c8c2ca77f6e2575a130bddb9767d068e1162d71
commit: 377aede9f10ee28be954473668bc6d33c6c9db75 [5/6] crypto: aesni - AVX512 version of AESNI-GCM using VPCLMULQDQ
config: x86_64-randconfig-c007-20210930 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 962e503cc8bc411f7523cc393acae8aae425b1c4)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/meghadey/crypto/commit/377aede9f10ee28be954473668bc6d33c6c9db75
         git remote add meghadey-crypto https://github.com/meghadey/crypto
         git fetch --no-tags meghadey-crypto crypto-avx512
         git checkout 377aede9f10ee28be954473668bc6d33c6c9db75
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> arch/x86/crypto/aesni-intel_glue.c:683:27: warning: Value stored to 'data' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
            struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
                                     ^~~~

vim +/data +683 arch/x86/crypto/aesni-intel_glue.c

cce2ea8d90fec7 Sabrina Dubroca 2017-04-28  676
e845520707f85c Dave Watson     2018-02-14  677  static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
e845520707f85c Dave Watson     2018-02-14  678  			      unsigned int assoclen, u8 *hash_subkey,
83c83e658863e4 Ard Biesheuvel  2021-01-04  679  			      u8 *iv, void *aes_ctx, u8 *auth_tag,
83c83e658863e4 Ard Biesheuvel  2021-01-04  680  			      unsigned long auth_tag_len)
e845520707f85c Dave Watson     2018-02-14  681  {
a13ed1d15b07a0 Ard Biesheuvel  2021-01-04  682  	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
a13ed1d15b07a0 Ard Biesheuvel  2021-01-04 @683  	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
e845520707f85c Dave Watson     2018-02-14  684  	unsigned long left = req->cryptlen;
e845520707f85c Dave Watson     2018-02-14  685  	struct scatter_walk assoc_sg_walk;
83c83e658863e4 Ard Biesheuvel  2021-01-04  686  	struct skcipher_walk walk;
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  687  	bool do_avx, do_avx2;
e845520707f85c Dave Watson     2018-02-14  688  	u8 *assocmem = NULL;
83c83e658863e4 Ard Biesheuvel  2021-01-04  689  	u8 *assoc;
83c83e658863e4 Ard Biesheuvel  2021-01-04  690  	int err;
377aede9f10ee2 Megha Dey       2021-01-20  691  	int hash_key_size;
377aede9f10ee2 Megha Dey       2021-01-20  692
377aede9f10ee2 Megha Dey       2021-01-20  693  	if (static_branch_likely(&gcm_use_avx512))
377aede9f10ee2 Megha Dey       2021-01-20  694  		hash_key_size = 16 * GCM_AVX512_NUM_HASH_KEYS;
377aede9f10ee2 Megha Dey       2021-01-20  695  	else
377aede9f10ee2 Megha Dey       2021-01-20  696  		hash_key_size = 16 * GCM_BLOCK_LEN;
377aede9f10ee2 Megha Dey       2021-01-20  697
377aede9f10ee2 Megha Dey       2021-01-20  698  	/* Allocate gcm_context_data structure on the heap. With the
377aede9f10ee2 Megha Dey       2021-01-20  699  	 * VPCLMULQDQ version of GCM needing 48 hashkeys, allocating
377aede9f10ee2 Megha Dey       2021-01-20  700  	 * this structure on the stack will inflate its size significantly.
377aede9f10ee2 Megha Dey       2021-01-20  701  	 */
377aede9f10ee2 Megha Dey       2021-01-20  702  	data = kzalloc(sizeof(*data) + hash_key_size, GFP_KERNEL);
377aede9f10ee2 Megha Dey       2021-01-20  703  	if (!data) {
377aede9f10ee2 Megha Dey       2021-01-20  704  		kfree(data);
377aede9f10ee2 Megha Dey       2021-01-20  705  		return -ENOMEM;
377aede9f10ee2 Megha Dey       2021-01-20  706  	}
e845520707f85c Dave Watson     2018-02-14  707
e845520707f85c Dave Watson     2018-02-14  708  	if (!enc)
e845520707f85c Dave Watson     2018-02-14  709  		left -= auth_tag_len;
e845520707f85c Dave Watson     2018-02-14  710
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  711  	do_avx = (left >= AVX_GEN2_OPTSIZE);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  712  	do_avx2 = (left >= AVX_GEN4_OPTSIZE);
603f8c3b0dbbe2 Dave Watson     2018-12-10  713
e845520707f85c Dave Watson     2018-02-14  714  	/* Linearize assoc, if not already linear */
2694e23ffd210c Ard Biesheuvel  2021-01-04  715  	if (req->src->length >= assoclen && req->src->length) {
e845520707f85c Dave Watson     2018-02-14  716  		scatterwalk_start(&assoc_sg_walk, req->src);
e845520707f85c Dave Watson     2018-02-14  717  		assoc = scatterwalk_map(&assoc_sg_walk);
e845520707f85c Dave Watson     2018-02-14  718  	} else {
2694e23ffd210c Ard Biesheuvel  2021-01-04  719  		gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
2694e23ffd210c Ard Biesheuvel  2021-01-04  720  			      GFP_KERNEL : GFP_ATOMIC;
2694e23ffd210c Ard Biesheuvel  2021-01-04  721
e845520707f85c Dave Watson     2018-02-14  722  		/* assoc can be any length, so must be on heap */
2694e23ffd210c Ard Biesheuvel  2021-01-04  723  		assocmem = kmalloc(assoclen, flags);
e845520707f85c Dave Watson     2018-02-14  724  		if (unlikely(!assocmem))
e845520707f85c Dave Watson     2018-02-14  725  			return -ENOMEM;
e845520707f85c Dave Watson     2018-02-14  726  		assoc = assocmem;
e845520707f85c Dave Watson     2018-02-14  727
e845520707f85c Dave Watson     2018-02-14  728  		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
e845520707f85c Dave Watson     2018-02-14  729  	}
e845520707f85c Dave Watson     2018-02-14  730
e845520707f85c Dave Watson     2018-02-14  731  	kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  732
377aede9f10ee2 Megha Dey       2021-01-20  733  	if (static_branch_likely(&gcm_use_avx512) &&
377aede9f10ee2 Megha Dey       2021-01-20  734  				IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512))
377aede9f10ee2 Megha Dey       2021-01-20  735  		aesni_gcm_init_avx_512(aes_ctx, data, iv, hash_subkey, assoc,
377aede9f10ee2 Megha Dey       2021-01-20  736  				       assoclen);
377aede9f10ee2 Megha Dey       2021-01-20  737  	else if (static_branch_likely(&gcm_use_avx2) && do_avx2)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  738  		aesni_gcm_init_avx_gen4(aes_ctx, data, iv, hash_subkey, assoc,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  739  					assoclen);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  740  	else if (static_branch_likely(&gcm_use_avx) && do_avx)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  741  		aesni_gcm_init_avx_gen2(aes_ctx, data, iv, hash_subkey, assoc,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  742  					assoclen);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  743  	else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  744  		aesni_gcm_init(aes_ctx, data, iv, hash_subkey, assoc, assoclen);
e845520707f85c Dave Watson     2018-02-14  745  	kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  746
e845520707f85c Dave Watson     2018-02-14  747  	if (!assocmem)
e845520707f85c Dave Watson     2018-02-14  748  		scatterwalk_unmap(assoc);
e845520707f85c Dave Watson     2018-02-14  749  	else
e845520707f85c Dave Watson     2018-02-14  750  		kfree(assocmem);
e845520707f85c Dave Watson     2018-02-14  751
83c83e658863e4 Ard Biesheuvel  2021-01-04  752  	err = enc ? skcipher_walk_aead_encrypt(&walk, req, false)
83c83e658863e4 Ard Biesheuvel  2021-01-04  753  		  : skcipher_walk_aead_decrypt(&walk, req, false);
e845520707f85c Dave Watson     2018-02-14  754
83c83e658863e4 Ard Biesheuvel  2021-01-04  755  	while (walk.nbytes > 0) {
83c83e658863e4 Ard Biesheuvel  2021-01-04  756  		kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  757  		if (static_branch_likely(&gcm_use_avx512)
377aede9f10ee2 Megha Dey       2021-01-20  758  				&& IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512)) {
377aede9f10ee2 Megha Dey       2021-01-20  759  			if (enc)
377aede9f10ee2 Megha Dey       2021-01-20  760  				aesni_gcm_enc_update_avx_512(aes_ctx, data,
377aede9f10ee2 Megha Dey       2021-01-20  761  							     walk.dst.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  762  							     walk.src.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  763  							     walk.nbytes);
377aede9f10ee2 Megha Dey       2021-01-20  764  			else
377aede9f10ee2 Megha Dey       2021-01-20  765  				aesni_gcm_dec_update_avx_512(aes_ctx, data,
377aede9f10ee2 Megha Dey       2021-01-20  766  							     walk.dst.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  767  							     walk.src.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  768  							     walk.nbytes);
377aede9f10ee2 Megha Dey       2021-01-20  769  		} else if (static_branch_likely(&gcm_use_avx2) && do_avx2) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  770  			if (enc)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  771  				aesni_gcm_enc_update_avx_gen4(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  772  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  773  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  774  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  775  			else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  776  				aesni_gcm_dec_update_avx_gen4(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  777  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  778  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  779  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  780  		} else if (static_branch_likely(&gcm_use_avx) && do_avx) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  781  			if (enc)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  782  				aesni_gcm_enc_update_avx_gen2(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  783  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  784  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  785  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  786  			else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  787  				aesni_gcm_dec_update_avx_gen2(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  788  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  789  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  790  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  791  		} else if (enc) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  792  			aesni_gcm_enc_update(aes_ctx, data, walk.dst.virt.addr,
83c83e658863e4 Ard Biesheuvel  2021-01-04  793  					     walk.src.virt.addr, walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  794  		} else {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  795  			aesni_gcm_dec_update(aes_ctx, data, walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  796  					     walk.src.virt.addr, walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  797  		}
83c83e658863e4 Ard Biesheuvel  2021-01-04  798  		kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  799
83c83e658863e4 Ard Biesheuvel  2021-01-04  800  		err = skcipher_walk_done(&walk, 0);
e845520707f85c Dave Watson     2018-02-14  801  	}
e845520707f85c Dave Watson     2018-02-14  802
83c83e658863e4 Ard Biesheuvel  2021-01-04  803  	if (err)
83c83e658863e4 Ard Biesheuvel  2021-01-04  804  		return err;
83c83e658863e4 Ard Biesheuvel  2021-01-04  805
83c83e658863e4 Ard Biesheuvel  2021-01-04  806  	kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  807  	if (static_branch_likely(&gcm_use_avx512) &&
377aede9f10ee2 Megha Dey       2021-01-20  808  				IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512))
377aede9f10ee2 Megha Dey       2021-01-20  809  		aesni_gcm_finalize_avx_512(aes_ctx, data, auth_tag,
377aede9f10ee2 Megha Dey       2021-01-20  810  					   auth_tag_len);
377aede9f10ee2 Megha Dey       2021-01-20  811  	else if (static_branch_likely(&gcm_use_avx2) && do_avx2)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  812  		aesni_gcm_finalize_avx_gen4(aes_ctx, data, auth_tag,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  813  					    auth_tag_len);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  814  	else if (static_branch_likely(&gcm_use_avx) && do_avx)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  815  		aesni_gcm_finalize_avx_gen2(aes_ctx, data, auth_tag,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  816  					    auth_tag_len);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  817  	else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  818  		aesni_gcm_finalize(aes_ctx, data, auth_tag, auth_tag_len);
83c83e658863e4 Ard Biesheuvel  2021-01-04  819  	kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  820
377aede9f10ee2 Megha Dey       2021-01-20  821  	kfree(data);
e845520707f85c Dave Watson     2018-02-14  822  	return 0;
e845520707f85c Dave Watson     2018-02-14  823  }
e845520707f85c Dave Watson     2018-02-14  824

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------X27Al6Wj9IyXGABHi6Mrc0QN
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
p4LK/w8baa2Ml2QCAA==

--------------X27Al6Wj9IyXGABHi6Mrc0QN--
