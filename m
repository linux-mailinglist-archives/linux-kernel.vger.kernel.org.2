Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D235A7D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhDIU3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:29:24 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:4619
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231946AbhDIU3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgDaUmoIWFRz7/Qr9AfuhyPxDZUePgAqZjBjS3u/swKiFVRBAiGf/en3t/yEla/7WELe8FJZXeLGqPfuwH/uewAcV3+29xR4EPY0OLl4GPn8fvYoHJ9Z/9h5Kq5bDX86hbqrZh59jDe9ulV1FMPX5pvcljRl7+t93Z7Qa3BhlY9wEy1qULHSY+2wGH34D3jXGdpufB2L3OKFRUJnTB1Eewz9iIVsB2u+aRbicl3GGQRWsfyd2joBAaKA87k1d/JAbj/TJFPU+vejfN4F0tyBNzX/3BA2+2pyNePOborkK9N70LLPY4h8bgjW4idcDgCIluPNMn7qHkOTVKfZEvgeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7mTJLRZvwWsXpm20D3ExKswHpUVeXTO4pr9akwO5ik=;
 b=lX+0P0AfKYJIWOSXO8imtS9e0sUxAxsor+aoQIs6dzKmNi1XquaXLfavqK4bRH/txbjepsKTqTCFd4mZtFR739DQ3Hljen8mWRt2wCWU8hvTAxSXQksz8FskVroTdtBNwWe4RErvvlShI2RaFfcG4gVFlTUYTz3Buj/0Adrz74aFjQEzR0Jvtp8hGR3uC6M4WuX1LONlVtYIU1CWsTy+3JfMijU7G4LwA60Imzq97rWQB5LxATdYKO0t8+B6nM8fL+Dv24w+W2Ly+mvFkYR6RcfAlP4Hu3waSjXaBEaPsxbBp8s33ALclOT4XVpqjIfHoVjFZlkjpEII1/t3oCnrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7mTJLRZvwWsXpm20D3ExKswHpUVeXTO4pr9akwO5ik=;
 b=g+AIOFcr6wnDJcZ68tuKR9djNrbzbdotdaht1wfijso/FP+BI+VWdU/AnQckvPCRyjufki99caaNneWpP3oaDyvIHAmgyytk+yCrBiIdceIrGpF1aNQEDC3iwmuuCezGMr1yR+iiySTg660Fdr36yfjQ4iTckeDXhs+2td7X5PI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Fri, 9 Apr 2021 20:29:08 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 20:29:08 +0000
Subject: Re: [PATCH 1/5] x86/cpufeatures: Define feature bits to support
 mitigation of PSF
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210406155004.230790-2-rsaripal@amd.com> <20210409174134.GH15567@zn.tnic>
 <cc5476c9-fe4e-6b4c-d323-37b90237b32b@amd.com>
 <20210409193929.GI15567@zn.tnic>
 <9dea10b1-bbac-3ed2-6255-8453570d857e@amd.com>
 <20210409201924.GJ15567@zn.tnic>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <15a095b6-1c9e-a80f-607b-1d262376252a@amd.com>
Date:   Fri, 9 Apr 2021 15:29:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210409201924.GJ15567@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.231] (165.204.78.25) by SN4PR0401CA0038.namprd04.prod.outlook.com (2603:10b6:803:2a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 20:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7a70f03-5688-4768-40d1-08d8fb96207f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42034AC31A02AA1C4958B6209B739@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9fcr80zD57VpiPnOsK26/vQHGHTkIkPGco6leD4QHyJzKF3oA5Gd0D3xTU2OZrWTGLBkdP8Gp1ERpsuT81yUQ5aIbngXQM1ytLVbIrYB/mFIkl2PBF6Uud4KwsB6BL6yO68AngyIZ4KEabYyJ/slEIuyeJ5MSpH7fGRb2hB/DWbW4pol2WvEas4Fer+cAD6StCL2PJblFxVVEiepqHu6qaZyZSYCGryWClWjSTlSMLqBcfZ0iU+k1vhzZcXlbzYTp8h3UzY5vH4DGzeCHJdW2ZjKFlTstoO00xQ7Y/XGWwxH4jj8PpGxkyFgC8YMEpJM3UPSQxa6GTuz+PsNbiPkroMtrq/rs0RCl/ogVd456M6Bcg+hMGmgrMt9StXy4qYosejYmdvwG+nDSOLJ5Rq8A7a9xUmyphaa/Z/j3LkWBi/oB4S3aY0ntUvF2mT7OM+UzA/KGNrOtuVR7rEg9XyEtSHrJa6MwWxant7AEwA9mO6Fybh/n/EyiS9wdxLWGSUJBxqSNH6tN0N+kOKg7ChUxYEAYf3uBluABdt3Tw3L9hO1/l+LM/ry4R+5NpeOeHg21rhoWV8vZ4iuLe8ZHmVT0bgVLfmR5WUNcP/pcn/XOpOKHMuGmpW0Q+yaX3Z5nil7WT6QcAiGyhrdU0xCcn4XAitjlwjoixjDaOgx8wHsJ+9KWkWHTNCDBxI5ZwQTVDbkLk3+XhOQOamibxzmg1w6EJTGyGJWqJGjhVhV93/nXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(31696002)(38100700001)(5660300002)(8936002)(956004)(2616005)(54906003)(6916009)(4326008)(316002)(16576012)(66946007)(8676002)(478600001)(2906002)(6486002)(31686004)(26005)(66556008)(16526019)(186003)(53546011)(66476007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VVI3RU9NVzNRRDdYVndpNGJqNVp1RTljT1l6dGVoL1ErVnJUM1lmdnFGcWQv?=
 =?utf-8?B?NEdxeXhZM2d4bVl5ZDRzT0tLdVh1MEx6VGFXeXVPbXI1TnhGcklhbTFCVHNV?=
 =?utf-8?B?TFNnamxwZUllVlJsa0ZaaVROTVUvMlpRTlF5L3FlbTkrQ3JjVlFNRE01Qk1L?=
 =?utf-8?B?cWl4R0FTWUh5WjB6TmszVHNVWXJLQ2FiWmZ5K2FNZ2hNZjdpQ0xGUUJVYitQ?=
 =?utf-8?B?UEhQUVpDK3JUS3U1bFFTY2N6a0FCSUNDRmxIUFloTzVwcUJJbmdYN29ETkdK?=
 =?utf-8?B?Ti9FYWpVUE94SmZGc3IvVXBva28yQ21XNC9ubFpXMDBwMGhGVXo3VVdmV3Nv?=
 =?utf-8?B?b3A4N1ZwbmFnZDlBanNaNnR6Ni9mSEs1WER4VkVBOW1FVkpaZnRQeVhhdGNN?=
 =?utf-8?B?NVpKalhla3lGZFFUOGszUzBVR1UvK1dUZ2dLR2htRWZFdFNuZGlJQUd6QS9B?=
 =?utf-8?B?T2RIWVY3ZFYxQU5ZYTFxeHNwTWtTWm5YTEs3T0hFMk1BSm9wRU04SFFZR01S?=
 =?utf-8?B?VFJhb0NIOGtVSXphYmdQdEdpUWU4ZUlDZEd5ejVtNXlySzN3UFl5dWhuOUxN?=
 =?utf-8?B?Q0xOa0QzbFBlcmNRM29OQUIvRmluRmVzSFNacnZoT1FYWFdFNzNFcjU0UldS?=
 =?utf-8?B?M2tzcmdseUYxV29GS1oxR3Jtd0VrNlB3L3VmZlloc01CVlpHV3Zvck9HVTIr?=
 =?utf-8?B?MlhodFZXTjBJdStlZ3FTSVNHTkhKQXZTbGFUdVlmbGJtRWduOE55eFovUEFR?=
 =?utf-8?B?ZnlCTHY3eS8yZitCZ0tVZVc2R3FLQlZvMFVLYUNZOW41UkNobEF2S3JZN2lV?=
 =?utf-8?B?OVVhY2VHczlmeFJCUld1bFFvdVUzRlE5MkJ1RjMvUDRBME9GRmdMalRKT3lh?=
 =?utf-8?B?TVNxaWl2RU9YejFEWTZ6VEs2QXNKa3A3eTQ5MDJPb0JEUWNrb0NLTWIwQzFT?=
 =?utf-8?B?SHlFNGdiQ2Z6RXd0cUpKYWh6aXh2RE01ekZJVVhrd1R4NndNQXNtcWJZRkFi?=
 =?utf-8?B?U2V4THZLRGlJNWhYSHIyTDVrT0NlV1BCbVM4OXdzSDdBWEF6Z2wxTFllNlFW?=
 =?utf-8?B?Z0c1WnVlczR5bWF6b0VnSlYxb0JrbHlpcE5MUy9XbG0xNkZwZ2JnY1JBOU0z?=
 =?utf-8?B?NFRNaDhPQjhidGNaYzVtb0ZJME1yWUlqWUlaT3ZVS3h1ajlyamdiK1B3cGRa?=
 =?utf-8?B?NXhuQ2xtcE96a3JxTnZ4eGhEbU1Bbkp0NXl2WUU2eDVKbThDOU5oMktVOXNj?=
 =?utf-8?B?dkJVRUdWaVZvS0Jxc1E2b3diTSt5MUY0cVA5T1V4YVVFS3d6NDVwRndMWnRn?=
 =?utf-8?B?ZmdaY25ZT21SMUwrcjJOMDNhT1hxc2x4UDZRR3g1Tm4yNW5xaU9ldW94SnRH?=
 =?utf-8?B?NGtvdU0weCtZKzF4Z2dDT09FYTRQZFBwMnRpcUtua04xZ0JDM2hOdTBIZjFV?=
 =?utf-8?B?UkdLRXo0QVByNGJUT1pqd2l1SXJKWDdZcElRNTlUWEFFZWZDcUw5NGUyZUNp?=
 =?utf-8?B?aTZTWENwdEZhZDFQZi9aTmMvZjZBU1E4S1E3UUQxaXQwYTNVNFA0U2p1dkVT?=
 =?utf-8?B?Y0tGcFVXTk1EaGpBazF0VXVUOTIwSFZlSGxjd1YyT24yK3E2WTYxRmZzM05C?=
 =?utf-8?B?MUFtQW02eFRGOXZmQmZVTFV2SWtxeVFiZGZueHI5N003KzV5bTRlY1BoK3Rq?=
 =?utf-8?B?UEJiYk1LQlBrL3NyK1NDL0VETnp0Tkw4SXU2T2tmR3JFa00rRXE5TDR0aHZW?=
 =?utf-8?Q?xEkTO8pQAeGtyt4ogc9CZ+jLbAiVvRL+zejK/Ic?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a70f03-5688-4768-40d1-08d8fb96207f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:29:08.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWCKMbWG5MD2WDQSi6/LMsY0wdg/6z7phk91T+90jgiedVr+mCE3qcWNFo51dRZWvOm3YhcTSgDkri36EWOsQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2021 3:19 PM, Borislav Petkov wrote:
> On Fri, Apr 09, 2021 at 02:45:23PM -0500, Saripalli, RK wrote:
>> Yes, these options should be fine for now.
>> Like you said, if we get the need to add prctl and seccomp, I can always do that later.
>>
>> What do you think auto should default to?. 
>> In SSBD case, I believe auto defaults to prctl or seccomp.
>> Since we will not have that here, we should choose something for auto.
> 
> Or not add it yet. Just have "on" and "off" for now.

OK

> 
> Which begs the question should this be controllable by the mitigations=
> switch too?

> 
> I wanna say, let's have people evaluate and play with it first and
> we can add it to that switch later. As long as we don't change the
> user-visible controls - if anything we'll be extending them later,
> potentially - we should be fine usage-wise and from user visibility POV.

Agreed. We can add this later.
> 
>> All the other mitigation x86 mitigation code goes into kernel/cpu/bugs.c.
>> I think psf_cmdline() or equivalent also belongs there and not in kernel/cpu/amd.c.
> 
> It being AMD-specific, it can dwell in amd.c initially.

OK
> 
> Thx.
> 
