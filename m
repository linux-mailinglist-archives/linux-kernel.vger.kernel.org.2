Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3B3F1BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbhHSOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:50:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:36532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238634AbhHSOuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:50:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213447825"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="213447825"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 07:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="489693148"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2021 07:49:24 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 07:49:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 19 Aug 2021 07:49:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 19 Aug 2021 07:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUypdRguzqxpjgE0l+zsjqcsSbcI6hf79HNet3pjDbcgZwC7YckjWiUlRc5jd73v/ThxAthKrM6ZTI7OwKBxIhZh1pE/BY2Z5GdT/0ciO2dvfTRsBoJ9RdoLLgRdYlfN4TwaVNj6QhyDVZdW/OuA8IC3HFHIruTj11DJ2YJt8JsgDPgSIkw7DLKswiLEYbGmZSrjnBvM49+Me59F6Q1OAXyOWx5CGLBeQKH/y+6Qq9nL3WKhx/WRejyu3g9havNyT3GsH/m2HpJqkCYVeZFG3+7NfQfLLMK7EVYBrpCHH3nYtgnpRK+ppc/osDxabB7Ab/FGpKhRkU+Cgwlbip/ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC+1M7sQJrxiKmB30G9dF2PLCmtA1eEgmxd6R0VCDQk=;
 b=VMf7LXD7FOLKfvcsopeUQfMBjZYT3Q8uCy2zvgUXkfeNPlfxco6SneDyhZFmKZ1FZ/uQWs33eNxXhXR+4ooiWg0R/YpKvUFDSdDfPb1ICHd4Gqh34rDsZDBWr9iDpgxr6QG38NCMdHKPre3+BHta7/35fa7OH4HhG/goV3o/RQDPXDEM28r8N/LropELbZB7oNjaWD2oiNPkNIJcZ905uenzYKK/iQ9H5kVdAPvjI07h5lKovvR5m9sAyYyTCL0oKf9Lsv7THU/ThfkFwRHyAFzCF2KBDz7sYfIdAvGdc/dpBE11HK4W0dEhdbw7Q/kzI83qeVhr/9m8sNc1+H1zIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC+1M7sQJrxiKmB30G9dF2PLCmtA1eEgmxd6R0VCDQk=;
 b=qdFK5pkHhoaEIJi0JFFkGYY/HCe/gnn08mJH10CSkVkE/xkmjJGAzWpHQwzBCwAQC16x7U1ROylJrX6s1XXT7mFXLYod34qw43qHpBtMr1QYDSkFFxlCz20SASD0vIjqaAoshFlyPB1QM09OJsK1NqURVWYgWKrUg6sjgPvoAZg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 14:49:22 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::b9bb:3f44:3f2d:5a4f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::b9bb:3f44:3f2d:5a4f%9]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 14:49:22 +0000
Message-ID: <422ade1b-8e88-d6dc-ae4e-799e729932b7@intel.com>
Date:   Thu, 19 Aug 2021 22:49:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.0
Subject: Re: [kbuild] drivers/regulator/bd718x7-regulator.c:531:8: warning:
 Excessive padding in 'struct bd718xx_regulator_data' (8 padding bytes, where
 0 is optimal).
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
CC:     <clang-built-linux@googlegroups.com>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <202108172206.9cbgvI53-lkp@intel.com>
 <4dabc78a-f9ee-4e7d-8bf3-ea1c6cef8530@intel.com>
 <CANhJrGOh+9PoMmsv-Q9petTV-hv9rv9nOitg0NCQHqXVXzJvvw@mail.gmail.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <CANhJrGOh+9PoMmsv-Q9petTV-hv9rv9nOitg0NCQHqXVXzJvvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.125] (183.195.25.149) by HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1 via Frontend Transport; Thu, 19 Aug 2021 14:49:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed9464e2-e133-40e8-24e0-08d96320881e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5613:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56132DBD2211455600E970D0FBC09@SJ0PR11MB5613.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPHme0srsz/+DkJ0mVQmeCD0LYaGfsICLbjtTbPgUef7JPjlc9y0fTBsVrAOf5iHmhtbYZ4OF6axvAABciMALDevyMUZVDTmbpikMeiljz4aqSoPeZQikIEpSJaj+DcFQJDcm7JjPvxAcXu8ksSLiTpuwoEDAbcxeDCmeRFWYvNhZtwPjsTxaLW/KjrSXvBs7ame3DUohEsybnE4SyJr25TxnlsX8VuSWygvQfdWajn593nKir1NDgkEUCTmgrkJ9VTLZVdaGUeB2qrsbqTe0ixy/OFpQHeXkXOzVAfwofiwtT+edjSYP3zGUIYvdovlYLf0cBg7D5hAts7OaGEq3NWLeDrajkGAjLGKhcMBhiNrUqufhkLf7qIpKo5C4KZI/W3nqlh2Zq1oV4zIay6ycZYWgDywUq2MxzQGAtKBtCzWK7aiPIWGCtDH/HmLKZAAVqhdDgPyn2XQm0/mXdGWfFZDPMPFmUUZMkmx8I/OZ77mauRHN8C8eMvvD8mpatCzUwI87YmJ2qunqPY1pzxWR8LjdHy3bm/JiVu8zsISc44AvKJuMhPdLK4QoezddCmcwwfNTxOTwCj5dmw/dM2jY7q3rCDWaGw71EHlnFh+ah8G4EamJUuPqyP72IIT/K3LrYjkWVtQE0nDbfQ5SK3RF9QFds9RJgb4RIhmpJnjCQaGYMRw8dr/SF/6uwhT4+nWZPGVOE5nyS4P+jZn3aqZWWe+xgeklZ9b7d+yz8KwyMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(83380400001)(2906002)(26005)(16576012)(66476007)(66556008)(53546011)(66946007)(5660300002)(6486002)(186003)(2616005)(956004)(36756003)(478600001)(31696002)(86362001)(8936002)(31686004)(4326008)(8676002)(6666004)(110136005)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxEZW51K3B6ZzVtVTF3MittTHNMUGZsREltZ0gyK00zSDd4V0xGTVJBWmhO?=
 =?utf-8?B?LzZEYXJ5elJYdVltVkxsWW9zU2pGREtVOHVvSmJ6VmI5R1ZBaHNmMHdOMnJN?=
 =?utf-8?B?VnQrSERyZmh2QkhrcjNkbzAycmdKOFg5Vk9rZkhjTU5uanZmZ29WQWE2dWN2?=
 =?utf-8?B?VzYwV2ZOMGN1RmhwZEZEOVdLMUJxdXozSDd2cWRxQVVHZzlXWUVlVEs3aTlv?=
 =?utf-8?B?RUJvcEgwZDMwMERJV2FYSVRzbm13S21CZjdhaGRGTlBpUEp0RmNveWxEQkpq?=
 =?utf-8?B?NEdKNnZhK1NFTkYvOEZ2WE9nM1lXdldNaG5udUVnNkRTYUZzSVBjWjNYTG52?=
 =?utf-8?B?SzF3VEV4NkhZVGxVNXdqbGVENlBzc2ZnNFVFNVpGd0tvcmcxQklncVdDWFJD?=
 =?utf-8?B?MmdOaGxBYU94T3FpSC9SUEVUczZSUWJJRDV4TlVsZlRiUXhmamwyVmNhblpX?=
 =?utf-8?B?dDRDVndHTHhoTkZGZzJrc3JwQTF6cWFhMlRBZDhwbEhaSjBKTzVnY0N1ZGZG?=
 =?utf-8?B?SVg2SFlmTHpINzVZbjE3cm9SeHh6WEJJcmlvbkRMU0RBc054UE8vMkhYS3JD?=
 =?utf-8?B?VlExQTYvYzc5eDNhVC8rWkhlYUlLbm5mVldPMmhwSVFWMWRIZTJ2bTM0S1ZT?=
 =?utf-8?B?YUJUS0xaQ0pTbXltSExqb3B6OWJUcFRvTDIwNDVBaVcrY2g4S2kySUVrcUpx?=
 =?utf-8?B?bW5tQ0lBNnNoVGh1YVJHNkVRTGhYRnM0djdXdFQxWXFyQXFadWs0ZzhQSmVU?=
 =?utf-8?B?WmhnaUZ3OTZzcHpFM2RBNHFDQVB1eEt0ZEYwNXMzM1RCZ0tCTFlub1BTZGJT?=
 =?utf-8?B?TE9QS3ArY0lRc21BbXA2VXVnZDk4Qkk3K2o4cTF6RGxkTWc1V05TK08rMUJw?=
 =?utf-8?B?ZHZXOTYwaVNreHJBRDhPNmp1KzRXRGhybTJIWXJDWHowMDhmd094UU1uVThL?=
 =?utf-8?B?S0c1L1ZGTzRFYzUwZ2xacisxR0t0OGgzbFJVQnRJZ1UrZDVBVzl1bkxDenZl?=
 =?utf-8?B?TlhsL3ZMNktMeDJ6YnQ3dnNxL2sydmZlL0JsNmg4S3M1RE9qdUF3MDFSOXY5?=
 =?utf-8?B?WGdRYWxjZlRPRVBnZHN6NXIwZWE3Z3VnWUI2ejBxTWVJVU1qQ2QxdnNxK1Vy?=
 =?utf-8?B?TEZabldvdDJ6NGF5VTl3eldsV3A3NXlEeDJRSC9aeGY4TXhtMFIyNTZSZjVQ?=
 =?utf-8?B?amFVUkZUV2NzQzJ2WUEzYm9vOUI1NEIrSXZjQlJwNlJvSjVINEh5TWx1d2dz?=
 =?utf-8?B?cStrcENsUmNaMXNnb3Q4UkdTQWcxU0xxclA1eHBIVzRmWWlHZURRSFV0UkRQ?=
 =?utf-8?B?eFNIdkRqdFNyblJJejF6SVlYTVFYUDR2TGxXMEpsTjRiTlZIaEd3WXNXTmFt?=
 =?utf-8?B?WER0bm1tcFptY0FCdEpOc1JsT3lKSHEzK2Q4bTZmVUl2dEViTHBlNWlTakpI?=
 =?utf-8?B?NEk0RGtPbXBiL2V6bWdRYk50YXhSeVduTlNsQ1BvK1IxVmt6QWtTN01laTVr?=
 =?utf-8?B?b01yVGg0Zk13WWl5eElmUlIxU0N1anVGR3N0L2lRdnhNbWtQcm02ZUVxVUdG?=
 =?utf-8?B?Q2RmQllkbjFtS1c5ajVtQnVLb2N1dHN6TmlPREhCbGwrei9Xc2dLK1VTSGkv?=
 =?utf-8?B?cWNKaTM2UENQSld4Vk9MSm5OaGxhaG1NZ2JqSC9LT2YzanNqZXZsdllxbkZL?=
 =?utf-8?B?bTduY0gyNkR4TXNNaDRTYkdPMGtBQWk2aVRQN2MyUXRTL1c3ZzJmS1VIM0dC?=
 =?utf-8?Q?3A9fsm1EV3W49knYZ8qAAINyjOhxFEoyIclbgiR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9464e2-e133-40e8-24e0-08d96320881e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:49:22.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxM7EJ5af7zFb53pfHl7GV79NVyGlc2lKrwHGTvyJjCjlwthV1emXlcxOtidL3338bFbgazcLbY5PpuumPeGrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5613
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/2021 1:34 PM, Matti Vaittinen wrote:
> Hi,
> 
> On Thu, Aug 19, 2021 at 6:26 AM kernel test robot <yujie.liu@intel.com> wrote:
>>   >> drivers/regulator/bd718x7-regulator.c:531:8: warning: Excessive
>> padding in 'struct bd718xx_regulator_data' (8 padding bytes, where 0 is
>> optimal).
>>      Optimal fields order:
>>      dvs,
>>      additional_inits,
>>      additional_init_amnt,
>>      init,
>>      desc,
>>      consider reordering the fields or adding explicit padding members
>> [clang-analyzer-optin.performance.Padding]
>>      struct bd718xx_regulator_data {
>>      ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
>>      drivers/regulator/bd718x7-regulator.c:531:8: note: Excessive padding
>> in 'struct bd718xx_regulator_data' (8 padding bytes, where 0 is
>> optimal). Optimal fields order: dvs, additional_inits,
>> additional_init_amnt, init, desc, consider reordering the fields or
>> adding explicit padding members
>>      struct bd718xx_regulator_data {
>>      ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> 
> I don't have a good feeling about these checks. Especially when a
> struct is composed of other structs - which may be modified
> independently of the code we are looking at here. Any unrelated
> addition of a member to any of the structs (well, maybe not the one at
> the bottom). I guess fixing all the users of these structs when
> something changes would cause quite a churn of changes... What is
> expected to be done as a result from these mails?
> 
> Best Regards
>      -- Matti
> 

Sorry for bothering, we'll ignore struct padding warnings next time.

Best Regards,
Yujie Liu
