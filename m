Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9363FE4C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhIAVTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:19:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:40680 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhIAVTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:19:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218880201"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="218880201"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="461093183"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2021 14:18:39 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:18:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 1 Sep 2021 14:18:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgfkR36CiYqLQy3d8/pN/4EENgkRVopgNJFmuUEB3yrHoTLeLd6ate/ylsn5rPlgWeiV5DWvsRDcMDpHx9jd2chTzebjsQTZ0YLgt0vC12mKKJl/s8MCHp5CGscclQQuuATIjHsQuAkaRS0qRqMNLz3H7Z/hZXDTpGERMrFAf49FaVdhn1WtL9eZfTaEITv4weRfhdWiYGsBdLNrTxE/0+8c57j8P3Zfj9rEYfTgdovWqhkpG4Cq/qcHda0nFSTJsaDuRZ4Kq+JJOj2NWscGbCLoJOTgPaQVKQ5L07pnkl7DB7q2Rb4ocftT22OkNEXffdD0yfIFZTVrxYIs2nQWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RKdYUdUD0POptcEw7mJmY8/wDE7PEvPBqxnCLnBh34I=;
 b=XEjhb9SfYvMshL3zgqT4/+Gq3Ape5kt6WOKzqxveMOUjtZkzPdhxHzugowtJocjG+ktvbwmQZDmvBFeRbZwCPO1GqCs+QXvPwOEot96DEw75Zdx0v5W0MW7daNR6OHdbGRIQ6PyZypvUHMv8DzEwEueRaLglrJLxxhr33vSXZNTNzry7vCctzHXLZehoqQ4C4MO07aM7RnZD6te8YL1+jXIj5505mrvdTMgifSbcDd7zVOqxGv+Ri3APhkZ6qH1Ohx3fsw73vZjNXvIdUqWbXlE484uT4IorikHWSRmqqLOrVPboI47cN3X1KDf2nfcrNx2XrC9Gnn8LZR17xuzg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKdYUdUD0POptcEw7mJmY8/wDE7PEvPBqxnCLnBh34I=;
 b=kBF4STfW6ROTKtnza6n4drDasNCY1GX9YdUx5U6T2h3zNUBWx3Xgiszimpr9zSGZB9mDMXJZpE14t9kMwvU2ZKG+MAn/4sgfdhcIFYeYHkWE/hcACU4EFMmAN3qVq5+yv4b9PPiN5ulnFrmyKUn7Bo76I9UTG/4khj2pJb+HcYE=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2257.namprd11.prod.outlook.com (2603:10b6:405:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 21:18:37 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:18:37 +0000
Subject: Re: [PATCH v1 01/20] x86/resctrl: Kill off alloc_enabled
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
 <20210729223610.29373-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <620fbdc7-8fab-ea02-75e5-8f5788a85ad2@intel.com>
Date:   Wed, 1 Sep 2021 14:18:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-2-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 21:18:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf9fd45e-1fac-4853-f7ca-08d96d8e0ffb
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2257:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2257C80D00D6F23EFBB0DD67F8CD9@BN6PR1101MB2257.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wx/ELleI23rs/l/9biDA/HaPWhVRatNQFbwTt2zKOHl1sZ8v157pethcybnZX/MBeLHW2rWnt1or1G8OeZlb/oFRjBjEOrng15d9M7ajcj/Ed9Nsc/Ro51sHgVX6O8d6kWdyWJlrTfqaTRbx+SWYPclHDlvyJMcwje5D3H6ZORGaWvdmjbKjmVOioyHyatbxtLLoZ2DDXBPDnpPwFpQ+7sdGxAhyaF4YfJSzImyq6LAtOPEK0qcm2POoLCQjJcYKV6g0RuPFs4bcJHmFX+z2xz1xCOqw9Fpv+rVqmNUS1rmZPDRD5sfToIaM1fLt/11iH27VCfcV0HzMW7k1i6rcNHWhKV4o2TAE0TAsZqYENlbsYZEwBjWybh1kijKBuh2jrffeGDur5rK+TH1638eN4rHT7srNzcms5tZHldIMN1VAF+IkLvbbeCtP2w8FtrW9+bbH1Gt6ZDLjJnOiRalGPZoQxvWYg/7tRf05Q2nCWX4HHQvn19xw8ecd70FlhCVW++Xf2wvUryPbfQITSzRo77tgMaURek/GAPys5FU1wvzcI/CneEipGPvGMiTPM2BsmlP9pVH4f0AI+A1MtgZDdUrTCwjGB6Z9thzyOvptsiP46G9qGtnY42qXhHKg7Zxa3pOoxCI8ppyg5it/Ow92/423S9BmvgLhrtAzdf07b/YICwuwISb4bRGuEhSvk/tzdSMbuSQndctBFvDlJ1yaE83D0emUuGdlrfrrSB/W5AzHyB4p9O3f1Rjs/8lyeUZU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(44832011)(186003)(6666004)(2616005)(8676002)(54906003)(316002)(16576012)(31696002)(2906002)(86362001)(26005)(6486002)(7416002)(36756003)(4326008)(31686004)(8936002)(66946007)(5660300002)(478600001)(558084003)(53546011)(38100700002)(66476007)(956004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGQvUGRKQm9ycXMxOE1POVBpSHluaEN0ODkxZ2VHUTZSTG1vdUltdDA5N20w?=
 =?utf-8?B?YWRoSTE1emdHdkpKaGcwMlBDU1V0b2gzeXVJQ3Y4U2lrcVovcS9qUUpCZ3Fu?=
 =?utf-8?B?bys5S25rQ3FicjlqVDd5L1BaSlpad25nbHhRS3BKTlc0NmNIWWNXVkpvbWV2?=
 =?utf-8?B?MHhvQkxLckR0MEtFMXNDb1JTblVUdjRYNSswdGdjVGJIRDgyd3dPamhGZ3BB?=
 =?utf-8?B?MkhzcU1USjl2cEsvOSsxQTMvM0ZyeC9tMm1uSkNBQk9xWHVJVjhwVDBKaFpR?=
 =?utf-8?B?Y0R1djlEeDNsdzhralZlczRlVnJrekM2T0pHQXhWTGxQQkJCcWVUWlN0ci90?=
 =?utf-8?B?YW0zRFN0eWFPKzhXMlg4ZktqVE4xNnM2MXRXNkx4Z3VmOWhTc2x0bzdsVGVq?=
 =?utf-8?B?WWdGZmUvbGNUTFMxMU5XWEdmdm5QVDRmVWQwSUpqMHIxaWxJOU1CS1JFY1py?=
 =?utf-8?B?dXB3cXZlSDBsS2ZJb1JHcmVwZC8vNnZoaXV6R3RNRjVTVEx0MFA4eVdKWkI1?=
 =?utf-8?B?ZXRJRlc3dnNSbFdzT0VJVTFkUnlhRHlNN2wwY2RIVGtpVjAyM0IvZlQ0czZk?=
 =?utf-8?B?MHh2RjlSRmxGTC9IQ1dSTVZJU3dza1E4V0xnR2t2VjArb1JGUTVnVlBUbjhN?=
 =?utf-8?B?TXNYYVJNc3hPSUdtRVZCRE5WVE5CN1JOZlEwbDNzWWd0OCs1Z25ZYndXQ0x1?=
 =?utf-8?B?Rm1WTkowNkptL3liMXl5Y3FwSkRReWJHUHVlOXYrNGhIQm1VQTJFZzc4VmRM?=
 =?utf-8?B?ajlsVmVjSm84MmJ3UlF6bk40OUdyK2dOdHl1NS9ldVJXZGlDMWcwd0FscDE1?=
 =?utf-8?B?cFVGeDBUQWRrMkJGZmVuQnJ2eVdzY1ovaHEwdVlFU2djeFdHc0U3OWhFSWpU?=
 =?utf-8?B?YlIwa3lYaXB3MFJqcUFPWUppWEhJSU96VnRXbTJHOHpaL2xMc08vbFJmdmR3?=
 =?utf-8?B?VUg0L1BsTjI5V2YzbnpCREF1NWZ1T0I4SVMwQ045Ui9hMS9NdzFWTWlEVElu?=
 =?utf-8?B?dGNIdDN6MlF4cHkzUUhxQ3Ewa0EzUTZCcjdmaWlFVHJHOGtQcjZvY252TWp4?=
 =?utf-8?B?U0d4WnRwTVlEamFjMHdON2dTQklQYXFrb0Irc3BsakZFemx6WFpvUzZkZjFw?=
 =?utf-8?B?MWh4cS81Wll3QU5uUkozOUVDS203TWJiQllMZ2V4TWZGd0hxWGNtWHZqZEZ3?=
 =?utf-8?B?d1hmbmFuNUNXejNoaEJjQTkvY3I0REdzQzRkWnpLZjNxWVVXY0ZqVFNiN0pO?=
 =?utf-8?B?NDVYZkJUR0Ywd3dTV2E5bG9WaTFqdmJyVzJlaCtTNTlWVUF3eWx1akRXVzhw?=
 =?utf-8?B?eERmN1l3RVdsZGNORnZ6MlBRWGlCaFBFblR2UjdMa2l5bUkrQXVwODlLNUNa?=
 =?utf-8?B?N1JMT2hPRXRrY1E5V2laTVlzZDJmaW9YR1FrT0d6Y2pUS09EczdSOFY2bGl2?=
 =?utf-8?B?T0Rya0RNNGY3dkVJMzFUYUJDSU5sNUVCQkhZNk02Z2E4RmdtNmMwdVNGNEpx?=
 =?utf-8?B?Ui83eE40Y2JVZm42THZWZ2xnQmp4b3ZnbVl5K1RlMHdIM3RjSFJaY1pYYUFk?=
 =?utf-8?B?aVJ0dlplSTZUNGVMdjBZYmpRRHlLMEVJMEo2eCtqcDJQdzRzVTMwaWxSeTF4?=
 =?utf-8?B?U0lPcGRhN1hxaUlNUGdvT3BRS0lFdmRteFJIRUdNbzNDTUVhWXBVTHp6c2dp?=
 =?utf-8?B?d1hQZGk4T2JkNC9HWVpyUlZUQTlsUElodzdkcFNncHgvOHpjYTdydzdqM01Z?=
 =?utf-8?Q?57yOer2gPpCd6ammiyjW9F94K6WV2syfr2qLTY+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9fd45e-1fac-4853-f7ca-08d96d8e0ffb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:18:37.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivEN8grYM964NXLp2i61kQmGUoJwKYQyAKHrDoWQKwfXLQZPFnOi4bIIsRk/amoaR4fGaXATd1od4o2vedAAEzq2IWh9moPofafbDpumSmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> rdt_resources_all[] used to have extra entries for L2CODE/L2DATA entries.

The double "entries" seem redundant above. Perhaps just 
"rdt_resources_all[] used to have entries for L2CODE/L2DATA resources." ?

Reinette
