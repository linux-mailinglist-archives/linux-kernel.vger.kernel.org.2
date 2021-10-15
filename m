Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9242FE08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJOWV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:21:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:47871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbhJOWV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:21:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208797669"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="208797669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="492725389"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2021 15:19:41 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:19:41 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:19:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:19:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWpiNMqiWlowZegkoowkcaMZAB0wUvj0+JaAYMkhj7h5q+bP0GC8ics4Kq3t0t1/nFDbsdoo+XsdBGFDGMbAfHFWywvOZ02NYHdhpx2nMJrjs4LMlneMsv9p46gpRI/kaXlRbiDA68/805fxK4VRypImNckSVuZRMByd1EBL8zX43WXpk9dN51GXG75B4pQQOdjjbFOEsNop2OLM0mhvp9asKGU21yWaIC26CFnYTNBR+vpaJ/M2JczCyz+PHuz8h5EmPeqE0aZVNCjDCPm0ycLzzzRpQKlHDQqnMNFeKCEhyflN94MtfeEiJzyJ2E8r3O/b5ri5Kvj20T5CgqTQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv82ipnrzbQ14231FV4i/OI7M8Z8l+JxBmZJ8XYhkUk=;
 b=TRXndw5F9UMgyyh+PPY9Yde2Tt/CniFdOs7xUBxWlVMsGhIe3ciEjw1OHCbwbG6v7a5R/6GQYcn7O18tS/PXRTfouSY1j+tr2G2R3Ox8Vpn++iJgHejh4m69GuqeZfoNazwAtV1M1ejkT/nnjPkwEGkKJaAVz5xJzusOxlyQ1jWUk6kkCQSgczcKccKV2RDFZo9qCHLsJmlcbTO5ocnNVkVCJ9m7Eb1RBueQtRV7hvlUl/wFtLiF/Jhqg5F1n3grzL2gkAU8XYlbK4UMf7NRTXtYcy1BRIrqimOTfGOc3CVv7oKy25yBgCQ3gslKyos0xk1fYHt/nazHuebDxGJFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv82ipnrzbQ14231FV4i/OI7M8Z8l+JxBmZJ8XYhkUk=;
 b=n7zdMy1fUiXIS2f1s6azhzrAhKwEL5062XuIhnmhnDgn0wvaOmXq4NiX0s9lkSGuVZFWN9wzM0H6LhJ38ualC76U1IHPIXVKdbcBzEO+glXiclJvWZNR+Euij3v8nZ3+6E3puY1d4KOihcLxUG9Wpbd15GBZm4FAN+YAAkok/TU=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2178.namprd11.prod.outlook.com (2603:10b6:405:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Fri, 15 Oct
 2021 22:19:31 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:19:31 +0000
Subject: Re: [PATCH v2 03/23] x86/resctrl: Kill off alloc_enabled
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
 <20211001160302.31189-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e7b0c232-6643-cd3a-1fae-80d368090e39@intel.com>
Date:   Fri, 15 Oct 2021 15:19:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-4-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW2PR2101CA0027.namprd21.prod.outlook.com (2603:10b6:302:1::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.3 via Frontend Transport; Fri, 15 Oct 2021 22:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2af5d451-6826-4c4a-cfa3-08d99029dc66
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2178:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2178005CB4DDBAEE15CD37F1F8B99@BN6PR1101MB2178.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pilmlbrow3cRJLMzuByf679bR4akZsgN6X7p6XsImvfP2Suc0ItDGFqMizvwYa0+1VLl/x0Zxmk/kFW4MyusUdVQvPlrfUmykjEICzz0nqLyvWHL67wbQwYU+d+LyDU8EegJ8ZaQesg8QXSrdTWasR5Uq7LHIEjqZ/b4DqwdKZbiZWdcSVNKQGqHTMSiy3dQwaygEeCwxWMcOvGQSha0ykGPqhj1N5WQBwFRifmsMW5jrPdclG+37btTK+cA3dCWmRxtFIlnnWJbEbmbZgBumE1Jzmlgq2b4vYKELMk3xyrKCgsC+6Qi3RuL0onGUu9a3W++os7smSYWuBttOen2pnYNpfjOv29HO6xNL8n2l48GP1MPJJ9ffXmI01k4dVaVuyj6dQVQH5cHM5kjI7+YJbZMyDTCRtyWgq2yPdP1PkOYRSZSemPPWkKTPZsHj7I/9ANLTFRAAQsU75aDNMMRSGK0CZgbuVS/TmjWmCnyhJkwwigLeE0RqHBlDwwESGxhmxkR5bFk8y2PhSLUs+3lFSzIHqAusgZNvfKy6Nrty8S2PJea/y+vIUfl2lvZDr7zybnwmPJgBUgzgPmjThJdjl8MRnIwNif7yqjiX3TwdW4mkKt0iBwttMJ95VyNwqNXS1BJ3gLGAS6olrgkzAL1NK3FJK7fXPjQE59+4Xh3+llCwA9h7kyEj0LY0AcU7A8hzxdKHQCE/AFmmtB4y+YnDZGJK9yKdYEzbwvcckFYvn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(38100700002)(4326008)(4744005)(2616005)(66556008)(8676002)(82960400001)(53546011)(2906002)(66476007)(36756003)(54906003)(86362001)(7416002)(16576012)(6666004)(508600001)(186003)(5660300002)(316002)(31696002)(44832011)(31686004)(26005)(8936002)(6486002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lmRkY5bzAwMDlVTVBFQzNzb0V4cE96SlpzT2dCbkJIYmZBcE5Veks3R1Fh?=
 =?utf-8?B?OEF6bmhNaFkxNmtYT2JUYUVjTzFKMVp2cW9xUzFGaEsrS0dhM1NRN21hT1Vj?=
 =?utf-8?B?WWVWNlRvYWwrOWw0bHc5eWxjcFEvOFBLWmVFeVVBWWNINFY4MTRzMEdYUTA5?=
 =?utf-8?B?Rmd2VDBjc3ZhUkRzWXhOeUk2ZkE0dG4yR1VjTmRmZ29kTTd2M3NkeTV3S3NB?=
 =?utf-8?B?cTg0UmZxL09ndzFaQ2s0VDFlVjlsQktkenB5eko2M2xDOWd5U2dqZUlyNG1x?=
 =?utf-8?B?OE12bkR4emdMTy91SGVVRVhBMTN3YVZUVHR5aGp3alViN2p2M084MEc4WUxW?=
 =?utf-8?B?Y3pmaTF3bTFKR2xPTWU3aDNEU0hSZmpnbmtiYlU4L2NvTEZ4RXcwTVFkWVdF?=
 =?utf-8?B?YVFXVXNRQWs2TmZKaWZGeHc4dE83ZnhVVTR3ejU4ZUlEZ2w5OUl5cmNXVCtX?=
 =?utf-8?B?WE5rVVk3VEkvS1Q1UGJld2lYUTRKbGpBVzFZMllPcWhzYXBvR3pZMG5Nakd1?=
 =?utf-8?B?KzEzU3NkQWVuSFhTM29XZmFYYUQxUWtNZmZHY1lWVmhTZTlCQTdlTUFJRzIw?=
 =?utf-8?B?Zy8wNWtXbWREdC80WnBvZ3lXZTdJeWhydGU2R2UvTHVNNlczR2gvUWowOSs4?=
 =?utf-8?B?OEk0WkpyRWpoUUVkbWdVNmdzRDI2cGhHMDh5eDVGZkFzcTNjcnZxWmMvYUgw?=
 =?utf-8?B?QWJnWWJwNkJWYXoydUU3L0YzMXFndnhxV2VGVm44ejJ3Q001OGJaeVpsRXdT?=
 =?utf-8?B?OXhicFM3UEhHc0RvL1lnYkMrL3BaTGxiMHNHb2s2SkhUelk1cGZNRlFRSzBW?=
 =?utf-8?B?VkpRY2NOUjFaUVFLWlN3MnlXdG9UYm9qczNIbjl0dE1jYW54T3dsYTVsUW1E?=
 =?utf-8?B?YXlWR2pIK3RhUWpFbjdsM2lIR3VMOXhBbHRyVVhCdWIxdHNzZmU3VU5tNElj?=
 =?utf-8?B?QkxkZjl3K3ZLZUJ4TkVDYVZERVhUY3ZRQUJFaFB3dE5WTURMaWd6K2Q4d3Bv?=
 =?utf-8?B?TEliRFliN0sxVC9od1czSlJzM0FEdytOdjIvU0hHTDVaTk9aYk9aN0F5dFVI?=
 =?utf-8?B?b25MOEpOTndSbXZSYmYvSlN1YnN4Sk8vSU8xRnZ0REdySTZqRnp5VmkxazNN?=
 =?utf-8?B?SWR6VVJIcnFtamU0TjQycmJqVGxtWVdKbkhsYmJmRjhRamkxM2VBRnBoRzFP?=
 =?utf-8?B?cnNrRlJLS0RzTUl4amJkQkFxMEJLRjdRK1c5NmF3RCs1ZytXVzNsQlVXSFlh?=
 =?utf-8?B?RmI1S0FvRGZMdWFYRFNhZlRaaFhxc1lIa3k2Y1NCQ01JTEc2Vmp2NUJvbjlw?=
 =?utf-8?B?Vmh4RXNvM2llWkJWZmJ3K1ozaHA0OWxWTnlSNy9WdGhhS1pRR0FGcjIraU5y?=
 =?utf-8?B?WHB5aG1ucEVkcmgvc3NhMkxyY1NtSDRRTGZqbGkyUzE1MUMyWXdNL2lmalps?=
 =?utf-8?B?dnN4OE5ZaElUU0xBd1BvSmVObDlNYkV3K09QTFNJY2xtejBrYWovc1VIVVJj?=
 =?utf-8?B?VUtPc3dsQ3MrUWl5bjZ5UzdLTURNZUMwdXFQMHp4RlZTUXJmb2t6WmluSnJl?=
 =?utf-8?B?WW9JczZBbUFFMGhHU3NkdlNFZ1BWUllBeFBwcldHeU5za0dJUVh5b0svcWFX?=
 =?utf-8?B?aXRtTGQ0OGQ1bkhkczNFLy9GOG85U3ZYdDkvTURIRDdBazVqNnFpaWw5cnBI?=
 =?utf-8?B?eDNsUGJUWjVHRjArN1dRTVdDQitxcmtYT3dKTW0zNVorN2ZnYk9JN1RmeWJn?=
 =?utf-8?Q?nEJbYVNb3bJgs/nyH+VHElxcMPJzbueDliECG5G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af5d451-6826-4c4a-cfa3-08d99029dc66
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:19:31.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBczra6iOoqTuDtEfp1D/hrIEmUKzLEVS3w6u1cLbT4/JSQ9EL+MYgmnLxMNahfsoZivSACo09jpBMjgekz0lMuMkpycp0SX0q3p1MVjFg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2178
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> rdt_resources_all[] used to have extra entries for L2CODE/L2DATA.
> These were hidden from resctrl by the alloc_enabled value.
> 
> Now that the L2/L2CODE/L2DATA resources have been merged together,
> alloc_enabled doesn't mean anything, it always has the same value as
> alloc_capable which indicates CAT is supported by this cache.

This impacts all resources, not just cache, so perhaps it should read 
"... which indicates allocation is supported by this resource." or 
equivalent.

Reinette
