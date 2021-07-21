Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BF3D1A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhGUW65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:58:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:7138 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhGUW6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:58:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211594970"
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="211594970"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 16:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="658479113"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2021 16:39:31 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 21 Jul 2021 16:39:31 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 21 Jul 2021 16:39:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 21 Jul 2021 16:39:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 21 Jul 2021 16:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwnk47rmpzc8W3w/ge8DH7q6JLy3vuxe0bV3utDHJv9HvPIM/7xSjAwGpTyUOEsGX4EIVbbdf+XjzTbBo8yn+oD/g6V5Setv6KPz0CNwFc8eJgBK+vCNU/jp+nmM3bPW1+QPtUBVEVSD/4FG5N4yXOC90HHzVE/CCoEQZAPXnKPxWDOeHy65fsizdZENWxgpqcfTfvURthHK4YN5OENKiRJm/58E88Ub3GGtJ5WkPkaEKXI5Lcl1AYCQX7/1FWPH6BqFpAqgQhCsBD9JJwhemSRbBN7X/XZzmsOMiOJ82y3VZG9VxkFr/hzXFmIB1p8vRTDu/TuNNcHSSmQc7UZ4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muvyjjHzdq4OMiqFcE1oguu1MUIoBqp8vsapMxbHMHI=;
 b=TF/mDqcyCIEQroPISm+b9OGRKWPC9WRAUCyRB2fsEjiZ+1c812S9jzLj9pwY1GLguEtoBMWdQb0yR/V+n7TbshfNmiAALrJd9S/hSkwezDgdSrKTA1sy3CYADcro5PnUwElsV3+ZU61rEwcyImmyYeaWdGoPIE/rS4V/RBfydbnIlZTzOFhlVevb7KlrkxgZtMLYdySnp6ZKFTZq8eSZKop8x9JNTFhEEKsFxoGc2siot5/YLCislblUnHFSz/mu+UxL09J7Pvtd9LOOlq+xtpaZrweoN3i4zWlliq2ryf/Udu/kwkKTGd6WVaxJ5vCdQYcCB+2WI1GBU4lz0QnWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muvyjjHzdq4OMiqFcE1oguu1MUIoBqp8vsapMxbHMHI=;
 b=NjqeheMz5cqKDBx4I6FH4c43wrSyRRxo119ql5z08PMR9RWvRNM1iuaKDuGwFwIElDxcLt/JKXnkPP0QqXXT5HZJye605BP5EjbpkmzRpW1tZIx4oEOM5ZsXk1DMtW/y9impY+reAUuLZDHPvylMzWVCBa6Z4V181fc5rcDLIZc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1506.namprd11.prod.outlook.com (2603:10b6:405:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Wed, 21 Jul
 2021 23:39:29 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631%7]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 23:39:28 +0000
Subject: Re: About add an A64FX cache control function into resctrl
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
 <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
 <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <26ffe50f-7ff4-2c4e-534c-edf23cb88df1@intel.com>
 <TYAPR01MB6330AE181BD8D6C18A36200E8BE39@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <22dc770a-dbf7-88fc-de46-46f6a21d7e28@intel.com>
Date:   Wed, 21 Jul 2021 16:39:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <TYAPR01MB6330AE181BD8D6C18A36200E8BE39@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:39:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06160f9d-e344-4e89-0445-08d94ca0c83f
X-MS-TrafficTypeDiagnostic: BN6PR11MB1506:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB15060B0E0CC6AF50D1296AB3F8E39@BN6PR11MB1506.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTL3J3BDJNPlP5QYdqQToRM26T3yFuBkXei9CWlmAoLNFpC2LGpC3pcBPz3Ol4dG1Zvl2EODaX/dhYcu213Hz0vYt8P6h/YOIx5+xWEYRgpVfzC6HkYnw/NHh9EtjbCLWA8PbXrXmV3ryWFr3VTIIwXRnMpKzcoOLAfgJTG8NtjVzdlUZ0cLqDkVC7lzlhPdJ8GXJIxYf3TwOxSq7IHTZlIM8tDL3Qyvwq8Z9VOhdxjDfCisRJtLeVutpD/G+NtcRW3sETUJS6ci+RZP5giwmxfNCQ+omoHmpm3kd0ilq/98rxYPhZcXzcBYp+zsrNEWwrYq5uTLOFUYJu10GifqgeYSJRmmevJnMl+6bEfHojYM3ewEC3Zta7Iufnbt6oocDJVT9Gzffie/hLdPuuwCKDdEkQqHCVr+lni7bhRd9x7/bCVuF80P4VwxkBprIAT6TfUg8W6pP+LFNnW77ur2bdZS1+vz+8lulz3tqzL9W89U2Ap9n9ahl+CYZp0i1h3mNqBtspnXL7Ik2wjZkBt5N/CpD7C29d8AZ1ZAdBNH+a/8GnHhLomtjM2NdBPlMoUDeEq4nebxWo86M0chmV45+5lKq6tvmdHxt1vgQ7a8oXz+WptYrVcvlWKbr/E9Dl03KxcjfJPeLO68s8H015pxpR23Hhw8rpK9coZFLU+irzixU1iNQIsAXoAVNTcJcAa+rgBikv8q4gNcdV1Quzaeh+xltnuNtmtNzsZTUjfanhc/K5yfw4cIY1lhSQMUPDQ7P9e5/daLqffUlIcfZFrLMrAyVaa9PYkF4doXNgkFCm2IOtqaPLSxGFwKKDRQ541C/76Z2uA+uugNDIwEaiWy3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(2906002)(44832011)(8936002)(186003)(966005)(316002)(107886003)(478600001)(36756003)(6486002)(86362001)(31696002)(5660300002)(8676002)(38100700002)(4326008)(6636002)(16576012)(53546011)(956004)(83380400001)(2616005)(54906003)(66476007)(31686004)(66946007)(26005)(110136005)(66556008)(43740500002)(491001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-2022-jp?B?WWIyWHlZSEdubmZDWGdKUmhaSVMzNHZHUDJ5M0dieFZ3TTJhSmdtd3ht?=
 =?iso-2022-jp?B?QnR4TkxHL2s4L3M3UitXK05IYkNCMmFlM2pvdWZlUk1meDMydjh2MlJ4?=
 =?iso-2022-jp?B?aGJ2RE4zbThDT2pKTGNqeGwxMlBBTkI5bTRBNzZpbW4yRkdIbDRBbUtm?=
 =?iso-2022-jp?B?eG00VWdmWi9pQmNZVGp5b05IeHlWTVlDdTJWYytaVldWaUJxdVoxbDda?=
 =?iso-2022-jp?B?SVFEU3ZGMHcxaTJld1JIU1RWSGdXNlA4b3VOUDllSnRxSTNOeTE3Qm1U?=
 =?iso-2022-jp?B?WHBNcFFSRDBnZUkzMnVtNDlrUENuSU5VM2prYSs0TlJKRzNmMkYzOEJD?=
 =?iso-2022-jp?B?SEdCVlgwNTVJQVl5Vm1YSkNLYzN6UzMrUmV5ME43eDFkSXVOV0JiSDRL?=
 =?iso-2022-jp?B?UGNjcHZGcW5PZU5lS0w3WE9yZG50Uk5ockxUd1kvMFNMMjNGNEgvS0Zo?=
 =?iso-2022-jp?B?a0pPY0NOdWdPNW1WeEdtZFhVT2hzV05Nc2NpWDR2QlZlWnJ2Um45Ymlk?=
 =?iso-2022-jp?B?V254SUJRa21WOG05eXJtZjU2VXZQcG1ha3NNR2ZuTDVmY25GZk8rSDkz?=
 =?iso-2022-jp?B?TC9ibzh0VVF4a3did1I0SHRINHh1YjJjSWJhTWxiYVdJcGZ1bFZjQ1Iv?=
 =?iso-2022-jp?B?d2JVNjhVSEY4UWtpbjc0ejZHQ0lrVG5YM2g0RWJhWTgyeWkxeFN6ZEF1?=
 =?iso-2022-jp?B?ZkFkMkh6ZkdMdUtyYnl0MFJhMXkyWTFNSVgxOTg5Zi9DQUpCSkRydElT?=
 =?iso-2022-jp?B?bk9OaS9LanR2cDNkQ081L2NhMlhDNVYyZGxGSU1raUM1c1R4bE04YVB5?=
 =?iso-2022-jp?B?c3RVVjYvbUVJTVB4dzRMSEVjNkRNOTgxSGVCTGlrNWZpeTAwZjBjSXV6?=
 =?iso-2022-jp?B?amYwaVhod0VnU1B4clJRNGMrNElGc1VhbUZrRVoyUGpDemFnZ1ZQUklL?=
 =?iso-2022-jp?B?aVZlVWlqcWhkdEtGeVQ5cmJHUk9yZ3JBSTlNb09ha1EvbG5LOXQ3R05t?=
 =?iso-2022-jp?B?V1I3L0FMNDJyUXphakFqZWVQaUU4OVR2VldOdHVJcnlSU3MwbzlrTDJ3?=
 =?iso-2022-jp?B?a2RzUHJuSFJGRlhjRXVtMmE2N1NhVzZHZnlyWEZoTFBrdDB4OWVWdHo5?=
 =?iso-2022-jp?B?NmphWWtkck9ZYnNvbm9DbVZ4YmVSLytQVlN0QUorVzgyS0JrSzAyNTNu?=
 =?iso-2022-jp?B?U3pYU203azBjeUphVW1lNTVRVjY4YUZZUHdvWlM0RG5NL1diMzkybmVi?=
 =?iso-2022-jp?B?WEZ5cjVVRG52UDVORGYyKzlRbzQ1NTJ5UWVWaGxJcW43REVXL0h6bG5y?=
 =?iso-2022-jp?B?NG5Vd1dpZEtCVER0b0J0dXFrZEtyUElPNDZ6Yi81Q2t6YTExNHdLZktY?=
 =?iso-2022-jp?B?RWhqQXpLRklseXh2R3VXWkE3TyswUURGQVJGQ2RoL3FZNmw2eSs1b0FP?=
 =?iso-2022-jp?B?Y1oydng2VzkwMEhmR3gvTHF6WGVUWHFIZzlWVXNqcC9tS2JMRGtOdTVl?=
 =?iso-2022-jp?B?SE5Fd05jditKNUdpQkdaZzBNbTljQ04xVDNZQ3F0QjUzTEltV2JFN01I?=
 =?iso-2022-jp?B?WkU1Q2RsdmExY3Njd3pmZVNVQWhzT01OckxvSGV4SWk4ck1pWklGYUQr?=
 =?iso-2022-jp?B?YkZwVkhrbXhoMTRiZkQ2OFVmWURVUldWU2FoSVd1K2ZjL2wxc20yUWlm?=
 =?iso-2022-jp?B?RmFHZ3RaNlg2YTlaRGlYaFN3ZDFaK3F4UDF4TElpWFFkNVR0d0Ywci90?=
 =?iso-2022-jp?B?S21tOEQ4Q1dxV1hkRTNmRytYdk5lRDZRNWtCKzU5VTFEMUNoV1V0OTZI?=
 =?iso-2022-jp?B?MUZGUzdFUThrbXNsTlBSaGdvRWREZzF5c1BYWjFHOE9qN0dJWnRVVUgr?=
 =?iso-2022-jp?B?UmpPMmxPdGVvQjZkbTdCcWZ2UkllUDJrbWF0dHdPN1UxTy9WVnA4dEVH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06160f9d-e344-4e89-0445-08d94ca0c83f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:39:28.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTa9BwuRlj4oY+tRX8r8bthzF7X4S553OBWlSsLplHepObl/0u/5lhDEOwK4phCssbDwlBKZARqn/EhTyUinGEP6tHXpWzYI60JBJszUuwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1506
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tan Shaopeng,

On 7/21/2021 1:10 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
>> On 7/7/2021 4:26 AM, tan.shaopeng@fujitsu.com wrote:
>>>>> Sorry, I have not explained A64FX's sector cache function well yet.
>>>>> I think I need explain this function from different perspective.
>>>>
>>>> You have explained the A64FX's sector cache function well. I have
>>>> also read both specs to understand it better. It appears to me that
>>>> you are not considering the resctrl architecture as part of your
>>>> solution but instead just forcing your architecture onto the resctrl
>>>> filesystem. For example, in resctrl the resource groups are not just
>>>> a directory structure but has significance in what is being
>>>> represented within the directory (a class of service). The files
>>>> within a resource group's directory build on that. From your side I
>>>> have not seen any effort in aligning the sector cache function with the
>> resctrl architecture but instead you are just changing resctrl interface to match
>> the A64FX architecture.
>>>>
>>>> Could you please take a moment to understand what resctrl is and how
>>>> it could be mapped to A64FX in a coherent way?
>>>
>>> Previously, my idea is based on how to make instructions use different
>>> sectors in one task. After I studied resctrl, to utilize resctrl
>>> architecture on A64FX, I think it’s better to assign one sector to one
>>> task. Thanks for your idea that "sectors" could be considered the same
>>> as the resctrl "classes of service".
>>>
>>> Based on your idea, I am considering the implementation details.
>>> In this email, I will explain the outline of new proposal, and then
>>> please allow me to confirm a few technologies about resctrl.
>>>
>>> The outline of my proposal is as follows.
>>> - Add a sector function equivalent to Intel's CAT function into resctrl.
>>>     (divide shared L2 cache into multiple partitions for multiple cores
>>> use)
>>> - Allocate one sector to one resource group (one CLOSID). Since one
>>>     core can only be assigned to one resource group, on A64FX each core
>>>     only uses one sector at a time.
>>
>> ok, so a sector is a portion of cache and matches with what can be represented
>> with a resource group.
>>
>> The second part of your comment is not clear to me. In the first part you
>> mention: "one core can only be assigned to one resource group" - this seems to
>> indicate some static assignment between cores and sectors and if this is the
> 
> Sorry, does "static assignment between cores and sectors" mean
> each core always use a fixed sector id? For example, core 0 always
> use sector 0 at any case. It is not.
> 
>> case this needs more thinking since the current implementation assumes that
>> any core that can access the cache can access all resource groups associated
>> with that cache. On the other hand, you mention "on A64FX each core only uses
>> one sector at a time" - this now sounds dynamic and is how resctrl works since
>> the CPU is assigned a single class of service to indicate all resources
>> accessible to it.
> 
> It is correct. Each core can be assigned to any resource group, and
> each core only uses one sector at a time. Additionally, which sector
> each core uses depends on the resource group (class of service) ID.

Thank you for clarifying. From what I understand this could be supported  
by existing resctrl flows.

...

>>> In resctrl_sched_in(), there are comments as follow:
>>>     /*
>>>    * If this task has a closid/rmid assigned, use it.
>>>     * Else use the closid/rmid assigned to this cpu.
>>>     */
>>> I thought when we write PID to tasks file, this task (PID) will only
>>> run on the CPUs which are specified in cpus file in the same resource
>>> group. So, the task_struct's closid and cpu's closid is the same.
>>> When task's closid is different from cpu's closid?
>>
>> resctrl does not manage the affinity of tasks.
>>
>> Tony recently summarized the cpus file very well to me: The actual semantics of
>> the CPUs file is to associate a CLOSid for a task that is in the default resctrl
>> group ? while it is running on one of the listed CPUs.
>>
>> To answer your question the task's closid could be different from the CPU's
>> closid if the task's closid is 0 while it is running on a CPU that is in the cpus file
>> of a non-default resource group.
>>
>> You can see a summary of the decision flow in section "Resource allocation
>> rules" in Documentation/x86/resctrl.rst
>>
>> The "cpus" file was created in support of the real-time use cases. In these use
>> cases a group of CPUs can be designated as supporting the real-time work and
>> with their own resource group and assigned the needed resources to do the
>> real-time work. A real-time task can then be started with affinity to those CPUs
>> and dynamically any kernel threads (that will be started on the same CPU)
>> doing work on behalf of this task would be able to use the resources set aside
>> for the real-time work.
> 
> Thanks for your explanation. I understood it.
> 
> I will implement this sector function, and if I have other questions,
> please allow me to mail you.

I will help where I can. You may also be interested in the work James is  
busy with. See his latest series at
https://lore.kernel.org/lkml/20210715173043.14222-1-james.morse@arm.com/

Reinette

