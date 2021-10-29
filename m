Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275AC440565
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2WZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:25:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:64183 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhJ2WZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:25:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="316960899"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="316960899"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448269839"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2021 15:22:34 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 15:22:33 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 15:22:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 29 Oct 2021 15:22:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 29 Oct 2021 15:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMmtwsLOrEA810XRFO7OJkKIGYl6xOYpgA0MzPSyTneZUulq8qhzfxvP1qRgiJHo+5L0J8z423cSyVN0T+wu2TIxHWgic5aoWXsOLehIXsJnteA87B2j0re0IAsXpVi4c6neRcD0Al/0pp+CXKoR2tBmAt2bBlXAA2egNd+f5E9cZhtL1zClyh7wsso7nd4grObXnX2/ejvHZdoclPGRBSeFVhYIkjD/k82Ep3dPPFvOguob4nDoAU1Gw4dQj6enSAmmZCUDJyyxklxQNeK6wOZWQJwvt3chIFBR+AE3KF6JbaRCPUCs/DZ7AMyjdwS62KXiIaTz66s8NsUCZnP15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrM6SaI6MzWI2BAmEUv1lVB/VdvVlvoaYQ4nm7dQE2Y=;
 b=LdY2MxKXgxCcWSA5z0WLb++EOafwpgafTt7m9y5cgNHYxHsVRyxB0vlfnQcK4J/GeYr7ufQ0v1j6xhgnq6jKo/a7SYoyHaUZkCoWlSBQJUpoP4T3azsPEKedJ7XK/y1MV5RyYjF0cYRX0h0nHEXfQZjsDQpaN6JJFiM62ShHHKKI4p2tX+r+Ki3PkO7hYqaH72+Z11HjdVkdCa/BhselcOHacLv2BkQxK3eR/iFxicY45Sa7EoXzbTb4exiPs3jVDtEgN+461rL87Kzu/X2W1+2OUt7kbNXdqF77bY/CDVPngJPmQ/XUkagzpQu5McPcAYG7OigMwJY8GjRNl0OBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrM6SaI6MzWI2BAmEUv1lVB/VdvVlvoaYQ4nm7dQE2Y=;
 b=M/0EdjANtZLM9k3H8+saIUHbJjUfz9SCBrkI+7IRro9VhtO63GB2cTuYs80p+q0A9wdyvquuN2X+kKdTicD0F4WATPYUhBSJJ0LfEENnIIQO67JfjyEy7obVimBCnCxA+QgRnmDqLDrFOqycYZa970XD/u3Z5bemWvS4CFRu4wo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3969.namprd11.prod.outlook.com (2603:10b6:405:77::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 22:22:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 22:22:08 +0000
Message-ID: <bcdf2daf-ae8a-9047-e171-3dd36a98a66a@intel.com>
Date:   Fri, 29 Oct 2021 15:22:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.1
Subject: Re: [PATCH v2 14/23] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
Content-Language: en-US
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
 <20211001160302.31189-15-james.morse@arm.com>
 <091863be-f15c-18cf-9f1e-1f447f216098@intel.com>
 <f59842eb-887d-4134-c913-75376bc35fd4@arm.com>
 <ecc4420f-5a28-cf1f-2537-b651a31e6db3@intel.com>
 <76b70d56-b4b2-6fec-693a-a2105f446ec6@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <76b70d56-b4b2-6fec-693a-a2105f446ec6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW2PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:302:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend Transport; Fri, 29 Oct 2021 22:22:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40f9e9b-5a0a-4795-89d7-08d99b2a8b76
X-MS-TrafficTypeDiagnostic: BN6PR11MB3969:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB396903211C8C17DD7A3357DEF8879@BN6PR11MB3969.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2ytvvgnXCTXZds/NWg4Tk3Xqr1WcOInUpSyAy5bp7142kBEHZmwYjLCoAck822HdjKn+QWkwtXp9LyJzcJkxK3MfSzeVylbX/s6tTEKQn+K4VSUhvL6ismD5pXL5EgiYfDFeVX6L6jvZitsM5Rt8yMj3GZvtnWeM/Jnw8Xr/8PpyEnQpoxRoUL7GUlJnVCOAoDb1Kkk/149zw9NVfdg4w4P8hUywocQbYFLtnh8yQVprfg6P2xIAyz6k+yzOgxscujL4Ugq+BaUvEzctMS12nsALx9fGP/SvOdxYcNOPVqlpzjTK+3VcDBQCYwW+qhVM88SZiDdRlyeg6h7+Rk0fvMJy4qyLZN81uBtpLe3y1xFKlWNYNWvvHflHM8rjnbzglSZ7BIlr4VC9iQ0LL+ciANqXTjJFBNnvOwLZS3Ei7p5YrEweZYCMDSEAXWIgDb2uyo2tp7xyQvq8PY6hKTuCMT7bWCIbC0kve4KiEWj+to3uwBz7z0Dugn62Phckvi5JhQ0SLJNTE4Mw+mka6wRNypf0kb236qgJ6l5BpO/EJ7HwX7fqIUQse219Jetur2ip4THulRZ3lxKdxoWQXIALmCtviSkCscdI1SMGCJ9IpqJk7Ses9ZxeiDq6Z32Moz6SA46dWNTnirs29HdkUl5aFkBxrELM4/BkiQYKyIAPZMDdIcAebkOM00gduOjS/smMc7jx8Ew2AdHQwOy+mQl/V4tMC6V5QrUy6vgrFy8jbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(7416002)(186003)(2906002)(4326008)(66476007)(66946007)(66556008)(16576012)(26005)(83380400001)(36756003)(6666004)(956004)(2616005)(5660300002)(82960400001)(31696002)(8936002)(31686004)(53546011)(54906003)(44832011)(6486002)(8676002)(508600001)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJzNWlMSEdiU1RUdTB4ZDBWZ2lXRWIzQnB3SWNua08xZDd6N2t4YjhQckhE?=
 =?utf-8?B?K1N6U3dyMWFwd09EQlhtcTc5czBab1Roamoza2dKZloxTkM2RW84YVZCenlR?=
 =?utf-8?B?ajFNTlNmNjhYVHl2TkVQYTdkc2ZteFl3ZEkxOWpnNkorY25JbkRra0NaK2tx?=
 =?utf-8?B?TmVnRE1yV3MyNTc0Z2hRaS94S05zWWYvdnZmYmFwUzM4cUk2dXRwa1lEbURY?=
 =?utf-8?B?cHBtYkNDdmY1VWFEOG0vOW9YUUduUER4Q1ZpdkM2RzVFNThLS0U0Qi9hU3RD?=
 =?utf-8?B?clJhaUNiZkJYMHh4Qm9vQm96YW5tWHp2UHdsTjB3ZzZkTUNoODhEcEZpNEVY?=
 =?utf-8?B?Mk9JUFp3UFcvaFRHcndBVlZpVjZvRzVFajNhNVg5OEdvV3dvTzBWKzIxN2ow?=
 =?utf-8?B?Q3V3WUE5WTRzSHVhdXNEWmsvUWR4NEhVMkhJVTRHQWtWWGFwZTVxSnZIaDNY?=
 =?utf-8?B?Vk51NDdjWURvcTFXRTNhbUY3NEJ5b0FLeDVTNU1KQ2R4QTRmdnhGQ1I5MUU2?=
 =?utf-8?B?dlRLODN3UCtFYjhTV2FUQW1PK1dQdjJtS0RmWmlVNVRXWGMvcnFpOTNjcVdI?=
 =?utf-8?B?eVhQQ2JUcjlFN3hDZlJHQWwzTTRnUlZ4RmZ2MUsxWm4rcE9YS3pKYzFGazlp?=
 =?utf-8?B?TUkrSlpITG13YjVCcFRVUDdZUFl0WENpU2s3dTZjejdRK3BSL3VHY2prM1lI?=
 =?utf-8?B?dUJqNndZOGtpeUlmdEdhSytZVkdPYlJLSEdEc1pQNTNJakEyUXl0SVFGdWFB?=
 =?utf-8?B?WndKT0w2dmlnNnRIbzJrc3FSdG5zY2ZPcTBOMlJmclJyZUJIeTVlb3IzaXpr?=
 =?utf-8?B?di83MHlQR241NWNHd3BmNW9aa05DNUtJeHVuZGNFZmFFcFc1RHNJV21aRnJa?=
 =?utf-8?B?QVY0UXlyRlJWUVV2RVhkbHY4MEtYQlZVdHI2dkVxblZmbVdtZjhoU3hsK3Rt?=
 =?utf-8?B?dXJOeFUvNkc2YzJzQTlOTUpYb2M2aStvT25qbUpIOWRxM1o1SDdIS3AxK1Bo?=
 =?utf-8?B?dnp6eGNDaU5ma2E0ZkNSL3ExTHNsQnd4a2JLSjdRbm5BbWkwcTV3YkJRSTZi?=
 =?utf-8?B?QjNLbTI0YlY0cTNway9PQmlJV3FEYWhOcjBxSDY3dlJCY0ZJVnBRdFExV1ZX?=
 =?utf-8?B?cUlIRm0vam5NckZzTW5ldmtmbjl6VUxFTTRKSkVVd2t6dnhDTmJXM1V3d2gz?=
 =?utf-8?B?TElvNTNRMGtvaDZ6Uks2cjBONUc1ZmUwVmVNTk9ya2IxUnhoMHlqeWgvOXRQ?=
 =?utf-8?B?eDd2dEZrSTNCSDgvelJpOE9xcnJHRHRwRWhpNGZtbE5aSlpDOVZveDhLQ3B2?=
 =?utf-8?B?MzhzVXpyR2Q1ZVNqT3h2eE9xdm41YXJKUStWMFNHRWdEajJYb2xyTHlkUVBp?=
 =?utf-8?B?MVpUUjhPNm1YVWtlZHkzU2Y0Q1dFREZOdXNqaXJYU1Q0WW91UE8yQjQ1dUg2?=
 =?utf-8?B?YlF1cGRyeDBFY2RzOFpVRFNwWDcydlJ5VmlQY0tob2piU1RTQjN4V0pNdGxj?=
 =?utf-8?B?TGpXMGM5UXlSelVYaUJBQThWc2JnRDdWYytMaVUxeldqSEhQaXhVWW04QXc3?=
 =?utf-8?B?K1VGMWhzMGRqd25wS3M1MHkzMnM1dEVNODhhV0ZVRkFKeTdDbXhUZ3F5RTM2?=
 =?utf-8?B?bzJrK0t1azA5VDFCeWdqMzU2b2R1dVBka3ErbXVKc0c5a3lKVVJlcnlRczdI?=
 =?utf-8?B?YWhXbEFQTk9FaDFWUDZyOFNQUTNGeTZGZkdzTmRvd2xPdzNPc0d0aEVPNW82?=
 =?utf-8?B?cWRoaGw2MjdiWWFZVFZSN2hxMUoraTFiQ0tsL2l0WlNJaFB5V2JxSm5xTzZU?=
 =?utf-8?B?ZXdhVVp5YzlNL2xsZmh5aXhPdm0yTjgzbW83aENPZTluMjNhN2MrdndOTWZw?=
 =?utf-8?B?Y0Y4RnIvSDR3RVVBT0Rydmtwa1p3VG9iRytSNFVSVkxUcm94dDVPVXR3dDZF?=
 =?utf-8?B?T21ha1lIQlNuek9FVFU2V09obnBwdFc2NXRZa2lCcFpBVnVhZVk4dWY2YlZo?=
 =?utf-8?B?ektzL25ETENyY1dibTAzQzVLZ21jaW5mSXVHRG5Fd09tM0ludlJPclQ4anB1?=
 =?utf-8?B?UEk5azMwT1IwdGpXeWVVbEdBdVhRRXVkS1E5OHZ3OEtUaDVXZXdMMG1GS3BZ?=
 =?utf-8?B?bnVZbzJyTERyT0U0U2pyVWE5S2YrdDB2RGxOc3Z6V2hnWk9pOGxTV3N2M25Q?=
 =?utf-8?B?VEZHMkkyRjJIRnRJcEk1KzU3TTg2NS93SDQ3TVhDMmlYUHdLR0huQk81MWw0?=
 =?utf-8?B?eUVDL29BZkkyRDI4TGI0VG9kei9nPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a40f9e9b-5a0a-4795-89d7-08d99b2a8b76
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 22:22:08.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Wiz/4sjBWYwLqtxiUCHlgcx9BjAlkG9Jqdhux2uuFLsJGMD0ygxYN2Aoftn0WV7YIxJWNyLEPllEs0Ky98eezvtwrp2Wx2nMKr842pMnv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3969
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/29/2021 8:50 AM, James Morse wrote:
> On 27/10/2021 21:41, Reinette Chatre wrote:
>> On 10/27/2021 9:50 AM, James Morse wrote:
>>> On 15/10/2021 23:28, Reinette Chatre wrote:
>>>> On 10/1/2021 9:02 AM, James Morse wrote:
>>>>> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
>>>>> second. It reads the hardware register, calculates the bandwidth and
>>>>> updates m->prev_bw_msr which is used to hold the previous hardware register
>>>>> value.
>>>>>
>>>>> Operating directly on hardware register values makes it difficult to make
>>>>> this code architecture independent, so that it can be moved to /fs/,
>>>>> making the mba_sc feature something resctrl supports with no additional
>>>>> support from the architecture.
>>>>> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
>>>>> register using __mon_event_count().
>>>>
>>>> Looking back I think 06c5fe9b12dd ("x86/resctrl: Fix incorrect local bandwidth when mba_sc
>>>> is enabled") may explain how the code ended up the way it is.
>>>>
>>>>> Change mbm_bw_count() to use the current chunks value from
>>>>> __mon_event_count() to calculate bandwidth. This means it no longer
>>>>> operates on hardware register values.
>>>>
>>>> ok ... so could the patch just do this as it is stated here? The way it is implemented is
>>>> very complicated and hard (for me) to verify the correctness (more below).
>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> index 6c8226987dd6..a1232462db14 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>
>>>>>     static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>>>>>     {
>>>>>         struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>>>>>         struct mbm_state *m = &rr->d->mbm_local[rmid];
>>>>> -    u64 tval, cur_bw, chunks;
>>>>> +    u64 cur_bw, chunks, cur_chunks;
>>>>>     -    tval = __rmid_read(rmid, rr->evtid);
>>>>> -    if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
>>>>> -        return;
>>>>> +    cur_chunks = rr->val;
>>>>> +    chunks = cur_chunks - m->prev_bw_chunks;
>>>>> +    m->prev_bw_chunks = cur_chunks;
>>>>>     -    chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
>>>>> -    cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
>>>>> +    cur_bw = (chunks * hw_res->mon_scale) >> 20;
>>>
>>>> I find this quite confusing. What if a new m->prev_chunks is introduced instead and
>>>> initialized in __mon_event_count() to the value of chunks, and then here in mbm_bw_count
>>>> it could just retrieve it (chunks = m->prev_chunks).
>>>
>>> (I agree the diff is noisy, it may be easier as a new function as this is a replacement
>>> not a transform of the existing function)
>>>
>>> __mon_event_count() can also be triggered by user-space reading the file, so any of its
>>> 'prev' values should be ignored, as they aren't updated on the 1-second timer needed to
>>> get this in MB/s.
> 
>> The resource group's mutex is taken before __mon_event_count() is called via user-space or
>> via the overflow handler so I think that mbm_bw_count() can assume that the prev values
>> are from the __mon_event_count() called just before it.
> 
> That is true. But changing this to work with the overflow+corrected value directly means
> it doesn't need changing again as each of those steps are moved into the architecture
> specific function. Changing this would make the later patches noisier, and we would have
> the same discussion on a later patch.

ok

> 
> 
>>> __mon_event_count()'s chunks values hasn't been through get_corrected_mbm_count(), so it
>>> would need to be rr->val, which is what this code starts with for the "number of chunks
>>> ever read by this counter".
> 
>> The value could be corrected in mbm_bw_count(), no?
> 
> It could, but the aim of the series is to move all the architecture specific behaviour
> behind an arch helper.

ok - I am still working on understanding how these helpers are organized

> 
> MPAMs counters read in bytes, and when they don't, its up to the MPAM architecture
> specific code to fix the hardware values before resctrl gets them.
> 
> There is no reason for the mba_sc code to be architecture specific, it operates on the
> counters and controls.
> 
> 
>>> The variable 'chunks' has been used too much here, so its lost its meaning. How about:
>>> |    current_chunk_count = rr->val;
>>> |    delta_counter = current_chunk_count - m->prev_chunk_count;
>>> |    cur_bw = (delta_counter * hw_res->mon_scale) >> 20;
>>> |
>>> |    m->prev_chunk_count = current_chunk_count;
>>>
>>>
>>> The 'delta_counter' step was previously hidden in mbm_overflow_count(), which also had to
>>> do with overflow of the hardware counter. Because a previously sanitised value is being
>>> used, the hardware counters resolution doesn't need to be considered.
>>> (which helps make mba_sc architecture independent)
> 
>> This is the part that is not obvious to me: is the difference between the two individually
>> sanitized measurements the same as sanitizing the difference between the two measurements?
> 
> I agree get_corrected_mbm_count()'s rmid check and shift hide what it is doing, but it
> boils down to a multiply. The existing code is (a - b)*cf, which is the same as this a*cf
> - b*cf.
> 
> I'm not worried about this going wrong after 18-and-a-bit Exabytes of data is transferred,
> at current memory speeds that would take decades. But: none of the 'cf' values are greater
> than two, and the hardware register has two bits taken for error codes, so there is no a
> or b that hardware can represent, with a cf less than two, that overflows a 64bit unsigned
> long.

Thank you for answering it in this way. This seems fair. Could the 
commit message please elaborate more on the changes involved? The 
current summary of "Change mbm_bw_count() to use the current chunks 
value from __mon_event_count() to calculate bandwidth." is too cryptic 
(for me).

Reinette


