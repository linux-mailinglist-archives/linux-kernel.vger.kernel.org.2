Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5725C428DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhJKN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:29:40 -0400
Received: from mail-sn1anam02on2065.outbound.protection.outlook.com ([40.107.96.65]:11629
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235197AbhJKN3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRSLbtN1949lYJj58QbGg/emFJQFVlt/ubfSs/6ZomDH/aFPfN2cWfi62b7kbhogmyyj5CFTZg8TjBu0Va3Mlx5U48EX4l4amzsteQL1Sq1M3OCpvvx9Ws1eYkrXgZZur2hcPTrA+C2/MGmx7PuQPTNs3zzeiuF8Ig3Oi7c9Qyf1FgejMPSJcBcjB6kvGXW+a/tCArfYvkFD0QHclSsBaXEbDqP0Z8WWJD4T5XJUgQPTrGydhaYkF6B0NjWyfA+mEevuoCoR9dkXJ4wLKbIRujEUHG7Nrj7mJje0mnB/nqqRDJiKxN9uXWaX6RHrOzCAFUkzhejSiBalzl8dMm9PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXwavDZkWHRLbZXRikjxTLkbVNQGgNMch3O4FuSFTl0=;
 b=nkJfVtm/W7AZO/kX75A3c3YO9msOERd4RXiKgrLNVhgLetrHK84l64Av1I0PBHzfVpyJ0l7PQ45bIifQo308SY6QdfiqGJ8sV1JhPbdjLhT9qnUiRwOVcKgPCTGLJ1GSGh84PWnVr/MDcnRR2LDfNTtHemS6NzYdee2TVkeEvJVU+kxtmEVy86j4/tAByrJegYavaXbZu3OQxfAjwiJQNDq3hFZ42CHqS34JfxNki8vUwjFiIx0OFXOAIijIHqTMoXfZR/cbJEPqoooYdnx5QNN031GJm6AzUrTEpmXkiCdQKG7VnBXQDFIph7ML6ms22Yw8FKdCCX9dwrwoprLOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXwavDZkWHRLbZXRikjxTLkbVNQGgNMch3O4FuSFTl0=;
 b=EwQevYT8nVR5ocmc/DB+VLCEnFQfa4KmiGJQ6vB/eXW/inlgZU9ZkcNnsajmdf5W9Hv3N+TwVzXDyqbAqLbVufrLDWC9usDVlr0ZjIxTqDkbs1/Ut419r7laZK4saawmD2JN/m4rOKlYNnUyD2ZDdHIId+Ebo1G8LcGTmUNkATI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 13:27:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 13:27:38 +0000
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
Date:   Mon, 11 Oct 2021 08:27:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YWQ3963xcO3xbFo5@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::9) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 13:27:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb73abfa-3462-4878-d0cf-08d98cbae4a9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5150:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5150052B820362724D5AE5FFECB59@DM4PR12MB5150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JoOsuCrxc1Rt2dbtgniKo6Kka+tV7XkXtsOqANw1ORlgGKG3C5t6OGSgY4pAhZ0HEJO7qQaUq0HKx9++saGpDkoicJE2yDNnVDjiC0vMmnJvLdBs4W5WAHXEI9sDpH2QQeVGkHwYpIYdyLVDIC5afPFR2Eo+UR6aAYEzIrIX+QcHF43vhplsByt/W4+Pbe6vJ6CUrKliVaH21o3YCGBonfpdYzdfhRdvnSQVixm0C8XALYX5+v1dgUNMbfkYGbdvFrqWPS8YhYVEU90WGL7M+HeuBSwI47rrx+o5/aMXTTeq8166sqFbM9wknYFhb3vgqVmZMQG28He00DHqF5PCdw3P0FiGjGtffQXu8CRvTi7+uoh/IKq3l3TWrdWjvhh8/WFlzxhH7wvS9imfstI+GK0fp9NsGrM09SLQQLd7hjQ44DSsNpFeZ4q7FVvBL9zo7N+YPARU97rCjhkDwTW5YkWY3cJNp3st/HNdeJ1oQvZ/OtiZ6Q/LBFUxHr4aBobc2NJo3yyoOs/0/vqgVCJRP8QuIsd8MZlnOvfg0VlsB4MYZjKg+rYe3hR41yndwVRCut3r9u224CB5wiMTcjdJ/HvQEbe47i08rsUBBZSNB55EDJsfZ3SANw+yGO8mOYEznqOtMNHVldOCU7bO8noJVTGiEjTlFi5bXsCozNseX5KYSZVgP2aw1mcFZLX5dPyZTq4VM1vG6sF92s8BQVwvVArPLE4UMZSbrWMDTg/3xiwJUH5/dwNXB3O9gLOXJe3Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(8676002)(2906002)(956004)(66476007)(316002)(110136005)(5660300002)(86362001)(66946007)(7416002)(66556008)(26005)(16576012)(54906003)(2616005)(31696002)(4744005)(186003)(38100700002)(31686004)(508600001)(6486002)(53546011)(4326008)(83380400001)(8936002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJYNFdYUWVtdnAvMU5tY21CckNrTEovTERjQzFIdlRKSnZtcitZMFBGNW9a?=
 =?utf-8?B?VXZ3M01naERVM01NSk00ZkVqa3RrWDJMN1ZHU3pBVnowZGtYQ0daNm5SbUQ4?=
 =?utf-8?B?SEkrbG51ZW0xNlM4bFlwQ0hWRFNqTytEajZFaHdBdHdYT045bWF5aTN4YVd1?=
 =?utf-8?B?L3hBM3dvcDlKcm9XaUlCN3dqYnh1OVM0WW1xR2NNNWkyckVaditYUGQ4dElM?=
 =?utf-8?B?WWlqY24vVmNid1BpR01HSWxGazdreW9sZjBXWDZFY3h1c01SQ3FzeWY4bGpM?=
 =?utf-8?B?WGtzUUM3SUtldmN1WFlteURMZEorOHJyUEVZbHFieU9yNlFZdGZSRE50M3ZS?=
 =?utf-8?B?cWZuMlB2QTJHZXgzRnNjUU1weStZM0F1R0labEhKL1ZLRmdTYm53bTk0VWRo?=
 =?utf-8?B?M0lhT1U4OTg3YTRXM3B3WGxWVmdzRFY2aFpwMmFFYmdHUE80QUVjbmdnK2RG?=
 =?utf-8?B?TWJIcUdIN0MzczhhV0xJMU9iKy9CSit2NW8yWnYyN0NZV2lpWHFLUnYzR1FZ?=
 =?utf-8?B?dEd2TTN1RFBHajlrVWxvSFk2MnVQUWdFa1RPeFBYV2FEejhhcWJlV2pkSytF?=
 =?utf-8?B?VHhXVms4Lzc2OHJOT2U4UHpFZnVEbnRJQWtscUI0enNvL1JXYS9lT0prUFd3?=
 =?utf-8?B?RkFtNFVnbVI4VEhFNTNzTlF6M1pWQnNmaXZHMHRhZGtxQ3phMVVyZGwzdE5G?=
 =?utf-8?B?MmY5VDd5bCttTUJqSUVQZ2N3cHUvY2kwN0NtWGozRE8veXBmU29oZVVqSTBn?=
 =?utf-8?B?OGI5TTFIWHAzQjJvRTZPSmF3Sm56dVNReW9mUDh4cllyOThQaDhqZ2E2Vnpu?=
 =?utf-8?B?RWYyQjNjKzdpc3VkVGVmN3BzeHRtK25CeWtpcDhJNndReUYwbExGUWw1aVNj?=
 =?utf-8?B?L29sSCtMYlRHb3hsemt0ejRTN01ZbERBcy9wNS9BcFhnSVlKSXNQdHNCM2NT?=
 =?utf-8?B?L0grU1hBQVVpNHFhVkw4c09lbzg5SnJ0Z3JKTm5WSTJ0U0xjb1ZYb1kxNVgv?=
 =?utf-8?B?OGZ1MUo3TU9NblpkS0owNXpCSmJlVlNNWUJRZlVIV0ZVanQxWnRGdXJRa0hX?=
 =?utf-8?B?cFVQaThheFRoc0R5UE5OaXhIWXRlVitBMm8vaU50azdXeGNsamRDemJkTmU3?=
 =?utf-8?B?QytmaG5DMytqL2lnQXVXY21Pc2I2eFZJaUNvSW5wTEhLK1l2NXlYSmtLNDN2?=
 =?utf-8?B?cDlOT1hNbTdIVU9JSVNsRUk4UlJnM2VpeEZ4UURJV0l0MHpRdU5CT3dEOFpL?=
 =?utf-8?B?ZXdUN1RyK2VVV096UzhmbVJJV0hqNk1EVDFpRm9CMjRycFNCcTFlLzlWRUxQ?=
 =?utf-8?B?cXRpM3B0TDVoc092bWxqUnF4OGlPWnhtVml5MXpUWEluZlZjNE1DYXdCTm53?=
 =?utf-8?B?YTRzeUQ2WUo1N0RmMkpPVUc4aEZUODZaeC96RjlGOGFWRytvQ2NnS1hGREZF?=
 =?utf-8?B?cThJT000K3dNUjBHOWlNTlFOdlZQSXQ0UFlFc2RnTTEzYXRldXJUd0Q4RjVZ?=
 =?utf-8?B?VTVldVZlbDg3algrUU51YThjRFk4SFczWG9CRlQ1MHpFS0FkK1hkcHpPRTB5?=
 =?utf-8?B?N1Y0b1FnSkpBUWpJaXpXZlBYcTEzb1VydVUxMFJwNlRDVHpWNlVCNWNuajk3?=
 =?utf-8?B?cjd0LzhVdTcrdzhpVGs1Q2ZoT1cvR3hSNHpCOERBRUVMU0ltdGJCbGtiVEts?=
 =?utf-8?B?S0tNdVdhdHA0YUZ0VnNqSjB6MWlITGxhRndKVmFZNkRva2MyQkpRTUZTdGda?=
 =?utf-8?Q?32x35s4sB4F814brKvsBHHM0pXOK2h5jySlv3fl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb73abfa-3462-4878-d0cf-08d98cbae4a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 13:27:37.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RICe1CyaXsY6ZcQrShcV5ss80kD4imTSgOp4EOcVy5ZlhHdfQnNOsl4j5Zm+DDftw41+/ngih0iaNdnyS/1NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 8:11 AM, Borislav Petkov wrote:
> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but otherwise, yes
>> this looks fine. The help text could also be updated to mention problems
>> with AMD Raven devices.
> 
> This is not only about Raven GPUs but, as Alex explained, pretty much
> about every device which doesn't support a 48 bit DMA mask. I'll expand
> that aspect in the changelog.

In general, non-GPU devices that don't support a 48-bit DMA mask work fine 
(assuming they have set their DMA mask appropriately). It really depends 
on whether SWIOTLB will be able to satisfy the memory requirements of the 
driver when the IOMMU is not enabled or in passthrough mode. Since GPU 
devices need/use a lot of memory, that becomes a problem.

Thanks,
Tom

> 
