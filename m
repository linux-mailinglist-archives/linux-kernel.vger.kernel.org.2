Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1338342FE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbhJOWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:30:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:53472 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235611AbhJOWaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:30:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="288861556"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="288861556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="528391057"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2021 15:28:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:28:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:28:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7vpTyUrYj0A/KwXDh6wK/6gfPSqSSfE2fHZkL6qo3EOBrexy9kRfJ7RYx7OZoJHKxUnyKV9RAe14z1PwtJyF/XxC8ESs/z6ehc8LvKHXEL2EWYFRi5pRosD2ghJjVxhJEVUeoE7U2ZErJTw/SbPKwUOi3ZegnuTgKivT+4QoPkM+SIKcis5NN6+EyMs8O1F788VoX/S6IN1s/O9Q2I0XnTXxXKk5BYf20vSK90cZAH9/fICVcZQXMgungJP7mcw3mPbFdIQElslLgP+sOavKb9F3cNOjx4KxE5awand5LgGe1vWKWhuOhSjDitxHAEMvpgZgyzJst9FOzanvw44Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92nyYsm/we0czLIfi6cVTjy74LSGdqaV4kRfDlXp2QA=;
 b=ZC03WRaYWLPemNXmVoWK/TwGme/bwYt/wHNs77zX4epwz2yAxDUl++MeVpSmBvLbEJ44sZtUHSygz+ZWbtHQiZq/WWE/PGV7ZNGEs+byuhoJ8e+jxKWHciik6RApXPiTjYllVy+/9KpZ+pkPEkw0DHKwGS92bluc5nC23r7ra0HUzBnbyYAmMhy59iLl34bihrN596TdO0JVSIx4T8hF8OhgsPkEw1LNkHy4wjqYu8kc2s/jzCmssEjr8EIlzl2lgfQTJw+7sO1Tx/ldheLdPwU/qVQkdf+yo1y/aMqc6jZFTkyfo+S5uzlcvK4Jc5Xp0ZM2Gbl1RSE6gt2As5k6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92nyYsm/we0czLIfi6cVTjy74LSGdqaV4kRfDlXp2QA=;
 b=W99fbI/0cqdlYe+ahAuP/HzhwibZfa1BgeRB7wDX2shrE7eZ0RWEGDmu8a9Bp8AnYHLWDPWWrlspYqst+RROvDBgfj3cMHVLBmiY8T2gICxRex8olMMPYKi7h7W0zRvBww7zzGDa6YFTuhlf+zG/HOCpHiHYf4TOpHuzILpxy4g=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:28:04 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:28:04 +0000
Subject: Re: [PATCH v2 12/23] x86/resctrl: Abstract and use
 supports_mba_mbps()
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
 <20211001160302.31189-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <11cb7dfe-52d9-9318-6a66-29b8c4df0e42@intel.com>
Date:   Fri, 15 Oct 2021 15:28:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-13-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 22:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 980d4d62-4b70-46fb-54a8-08d9902b0e24
X-MS-TrafficTypeDiagnostic: BN9PR11MB5291:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB529145816F99754C0D103A34F8B99@BN9PR11MB5291.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBYzYIgcsjzRW4G827t+0rQ75eUnRKWiHfAZLFUsrBhxkgOHI3F0XQqjhWSaQCYeHI8a37oX/TSa4l53patyzNL2k+f4ZAj5W0meW/qD3BfpH9j+7fZ4nKA86cVx+F1h4/LlfaP/GK0MhO1CClgdpuWymlMxl/ME7xHRHV2EkJ5OmggmRGrBNv9ziukXC/bQdix85Dv2mF0e1lHGjyxUuYoFAom7XO5sRObW8l9/B67HvRztaIRI5Hc7wgMs/O4VCQNjFaEEYKBzI5vko85IlK0WEiUgYkVPBNnFy2ETOu4Jfp4Oa/V0CGW1NGEDXzi3iIK3dUixor6617wBDSdgxkufTGOnLUa+lVCVD4IHnuuqTlcHmWRjmoKY6mbc5TjISsboOVTOxjY1ML1dbgk6uyKtyoCifnJH6GnrwsRleyp9h7PV5I7wRTny3gYdxRXyTlVgHiogiDb3xXB2H6DC2zHhLTZ7WSK173Gh345hnJSilEKsApFDr6l3LZrZrPSEsk64K+vxpdQXm4MaEDxXIt7X6tP1dz5K9rEJcDQq1O/gln9kZAZNeoCpXZwFDq2P9Us0p+yObCzrT7cGVICMiXClaYpbw3WHnTpX87sumdAamfl3xNgLMTuXlOZWPhyho3Dboj5r8XS2IpvyU0nH4CLomrlQaQFL6cU25haXSQA3hjzJBkfQezh46cfUiYva0bCuCwgSN+7b5zJSXMYzQH+u2qVn/6NC8/Wm4TS1oRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(31696002)(44832011)(54906003)(8936002)(38100700002)(2616005)(956004)(2906002)(66556008)(508600001)(16576012)(6486002)(31686004)(316002)(558084003)(7416002)(8676002)(53546011)(66476007)(36756003)(4326008)(82960400001)(5660300002)(86362001)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWoydmg4QXRUWUNBeWdhei9ESnRKd0VEellRbEUyMjZndWZCTWFLc1pxSEFv?=
 =?utf-8?B?MEtzUmoxS3FScXMrWVM0b3FWd3crazJ3TEczQUNhSTg3RXphVWowOGg3T2VM?=
 =?utf-8?B?SWdUTFBSTnVkcms0clVBWnVST0hsZENsa3F3bk5BWmo1UTRRV2MxSHJXLzA1?=
 =?utf-8?B?OWduTTkveE10TWppWlE1V0JXcXFLNHNObUw3Qkl0aEMzMmVYK25HcGx3T0ZP?=
 =?utf-8?B?TVZYNElpRkQwM1d4QXNEMWpKb1psYzBWTmRQUkg4eGJMMm8rTmZvT0cwczhI?=
 =?utf-8?B?M0FQVVFkRXlVMlpkZmdmTjFkSDhwTGJXRytkSkdUYTlDam5TM2VCVStab3ZC?=
 =?utf-8?B?aDhidVZpU25zOXFCUzJpcVA5OXBqK21hMmp0VTZuSGJCRFN4ekMvaExaMTJE?=
 =?utf-8?B?L2xGb1RrOVZwV0swRU5jVnFJaWdkT2NUVjVjVTliZVRSc3o1LytYZEtkem1Q?=
 =?utf-8?B?SU5TNnR5cjQvd1hvQk1vTVZPU3BGdXNiUStEY2FmMHQ0Z0ZDWVZheHp2K3Rs?=
 =?utf-8?B?S0NKV0twV3JpV1ZQWG1yZTBVSGhqbTg4dXVSdzMzdFlaM2NDenF3TWNBQzdB?=
 =?utf-8?B?NDJ2SDdpY2wxeWI4OEpSdGt0YmVKRVFZTTlxT1FkWXdMU1BzQi9Rc3dZQzRI?=
 =?utf-8?B?S2tqOC95L1FOS2dpOHk1SHdEaXNhaDduN2xFeExoRTE2bEJrRGNsMmpiQm5W?=
 =?utf-8?B?bjZ1eFltR2FjMXllcW5xZTIrc2ZGM1hKcmtFb0hIVTlKN2FzNWswWm1YWGF0?=
 =?utf-8?B?KzhWNkVUUWVWSktiWlpMbjFFcWgza29OUzlIVEpWTGZ2blVWT3c5VzliVzlt?=
 =?utf-8?B?MElYaXp3MThRbjgzUTE1cW9ZMWhkUnR0QXdLdUl6NlY4VkdvaGg2aVFaUnlK?=
 =?utf-8?B?OEtINmpMZDk5aGVaMHVwVCs5clVsV1FQQVR0eXROOEwvMzF6NkJVeTRPZU11?=
 =?utf-8?B?Zm52WjFYUEl5ano5RGIrY0pLZlBJbVk5VmFmOE0yU2FIQXVBL3A5SjRPU3l3?=
 =?utf-8?B?MEZuWFBQM2N3OU9SUlhidU82MVhYVEY0WFNSWWdhTmJOcWJYeUVrSGFwUnI0?=
 =?utf-8?B?OGdvQ2NHb2h6WDM2R085dGc1N3hheVE4V3JocG9iaUhBZmRCdWQraTQ2dzJa?=
 =?utf-8?B?bGtHT1lFamU2U2RLQ0l0ZGkvcDk5eVhoMy93VVlvek5ESFdqa05uL1FZQ0Zh?=
 =?utf-8?B?TDZoRTlYdlplbkp0MkpPNGovbU1mRXRRMVFJc2IxbVE0ZWx5UFNRNG1zZWJW?=
 =?utf-8?B?dk5oMkwzNXdnM2RzUklKTzdHbFlhNFZXUXVLVXVLeTFVWlJsbi9NdDBLS2Zr?=
 =?utf-8?B?b05mYkVtUm9qeFdGQ08vMWFPODlVZEJtL1Fzcmd2RXNCVTRZR0E4ZE1FdnZz?=
 =?utf-8?B?QUVZY09HTlhVUkhycEpWeVN3M1AvdWZqZ1pFTGpzT1M4bFJwS2dVblFKVUVR?=
 =?utf-8?B?N0wyaVFMdE9NYWFlS2wwRmRNL1JFRjZraE5nZmZKWTl2UGViNlhpam53Z2Z6?=
 =?utf-8?B?cnAzZ20zZnhiam5Bc3pxeFlpc1p1UGFzTEtCaU1kTFNzaVJlczNkSmxoeVNh?=
 =?utf-8?B?NjRXT2NBc2lvQUJkMmdBcTB1OTRNMTNOeGo3SVdMNWFkWFZIaXRFbUYzdUFq?=
 =?utf-8?B?TW55b3V2cVNTNktNbEk2b2dzUXdSQXE2K3ZNSlFZVmlpVGFncjIxbnE1eFZQ?=
 =?utf-8?B?T3RibnliZ2NMUkZWZWU2OW5wcXNmK3pUVGRpNEo5UEFlMnVkaytMOTlkNVZI?=
 =?utf-8?Q?nHW1suY1cCcD3ZcIqRxsESVAwprL3Bqm4gFWcUo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 980d4d62-4b70-46fb-54a8-08d9902b0e24
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:28:04.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2v0759lEnOnWhr02HroKbiv+R0rYDhjeWKJKIIdX4JyZU9ScSlxaydZFWGgPsQnK7G0wdMXD7nCeolBUczKSoXou5w2OmKoFf3F4a/j2L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> To determine whether the mba_MBps option to resctrl should be supported,
> resctrl tests the boot cpus' x86_vendor.

cpus -> CPUs

Reinette
