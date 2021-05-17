Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DBD38353E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbhEQPQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:16:36 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:21600
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242251AbhEQPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLROVC/zBrqLuHBPETommSi1Qv0FyRKlYHLr944rrt1mxYBqd1ZcKeNQUjP/a5x7kOmhc9Yyzph9NhyrBh6xeKp1+we0D5b6eTfB2mSlAHE8dNB3FA25BsBNC7/1Fxd6QXjyFUuS1TNiJf7jOd3HUJKwMDKQV/KB+YdM0r5i+5muZ/OfKyfS09Z3NgNVHWca7EI8VLzrPyRK0LEgABpNFAqw/pSGmQN39MJa68d63MPEiL18f6fskjwH4n2UlDfEkYJltTVWgFJ40LCbUJd46HpbaWP6NL40pf5me2O3v5HppvSZ16ypBvJbDJoiSAjUsFw27+5MQRrg1GQDJTWi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fr8MVXonNcTdFBbG2pqsz1aJ3pd0BQzhmZmwmiRla0=;
 b=CieD9CXzm4URFfeyvG0Wpk7r6e/JQkGdzZMUvRmuZmsipe+JCOZ43Xs3oIFJtn4xFQWJnvcikvZ37hgEALmz/cI9DAPDEf5hqO1nBJ0WACxH+16pvyNBeoxzc0xRfKmDbb/OROfkr0hBFTDUTOD0YMi63tgqN5cR7bSt2vW3hOWbtivZ168jWgGl5wx0SQg/llsiOITEVPySlwGBvi73qJlMLQch4Rd8PVDA8sVilTcCn4vg5RzQSEUYCE7BnxpW5hCY1YTYqBwbJADfLf6MtduhscGH6nGghrk5t8AoSeDVV44WfrF0/rAli8oBF+u9ijNjf8brzbIzSauAfd4Bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fr8MVXonNcTdFBbG2pqsz1aJ3pd0BQzhmZmwmiRla0=;
 b=m4TCkdR1FeV7hQdGSHUA3JtBnFE+ixB55/ewsPBAkZiui33/07LuBlJXzWQlHjC9ukIRrG2HSBtyv0uFVapj8X/YSll5CzyqHeTukvuJuWUTnMqk8W1I9MO6Um19g6HxSRLaWwb46FVsr/Fd0CJKF6QO6nnL8wU3qIKtcwtYuR4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 15:05:17 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4129.031; Mon, 17 May
 2021 15:05:17 +0000
Subject: Re: [PATCH] x86/sev-es: Invalidate the GHCB after completing VMGEXIT
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <fa408ec4020d7ab056875ec8c80d793b75f20a39.1621019553.git.thomas.lendacky@amd.com>
 <YKJio9XDepU+CR28@suse.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <41e721f6-aeef-d334-a5ff-79530d87e4c1@amd.com>
Date:   Mon, 17 May 2021 10:05:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YKJio9XDepU+CR28@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:806:d1::11) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 15:05:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a80ff0-aa3f-4077-6910-08d919452e38
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3178A910D6411592CB5128DEEC2D9@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnklHHKH3mozrk1H14ZTzNiWE14Klu5CDjwEPuvAh3bXdg8qfrHkYB6rv8Rn6T0S/4MmuwYze722Cq0S0DhjIHrep7DvpEJcjfA46P3Sti4+b/mU1kN4DYSAgX2Ef4xRhNWUtZiqsvfcQ/jODSbJ50O2uR8Eb5Fe+2n3TWbo0eEUVbQhp/bYLjwDmE8Ia/VZezhHk6RDc0D2UlJpDNaJyZQACBAqWzK9776WuuBHu9Dkq4XS1RFRScBGJSieMsAMqHl0HN6YXrB0zS6aDsmEFw1111iYI4CKpKy6Gy5jadG4l4kDrSsyoYO19ST0V4AT03/Mg4Sc2M+RUx9biAPGaC6OqLJp9bkkBZxu12lM/2ORZz04SBxMZq8jtN+eCKP04NjV4OxDi97/Z9o8heGSVG3zfdRjrXDD9rfIUy0bDKfAPjbAiz0l+D74L39t+a3WrwJvm/slJcEg/wpZSN54xzzebXJMG8ersWNnqaxC3rPlW3smJX/UE5cS9GBDnOJ9rYBta5DRL0Q2em3lxH04jnA/dH9ldEE6rBS4NnF1fJN4RkYQScuPM7hs9FHXRQjEC0BcIcuIBhU4vFPIsPdDBryrkqYCAw94hlUZLXxgWa9dy9uQB5APFagjfcxKvHxeYMPe82tRwJbuFp9tSQIGMHMh5kBv+CTHgWN0AiHpofdG+A4TUmj2jorJrP6MetuS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39850400004)(366004)(376002)(8936002)(8676002)(26005)(6512007)(66556008)(6486002)(66476007)(83380400001)(66946007)(478600001)(36756003)(2906002)(38100700002)(31686004)(86362001)(4326008)(53546011)(16526019)(6506007)(54906003)(5660300002)(31696002)(956004)(186003)(2616005)(316002)(6916009)(7416002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXFZODBYU1NRaC9ldXlXUTl0ZUo3elliQk1pRmlzNmJhbi9Ca09oaSthT1pS?=
 =?utf-8?B?VG1xWWFCS2FNK1pMK0RkOEtld3hOOFc1bnpRRUxzUlJHTTBpbHdacHNEWkJw?=
 =?utf-8?B?QTF1ZW1IWWlyNU5FMytTVGVLLzlRaDlGS0s0WFhYL3NZT2phd3pMb29LSWk1?=
 =?utf-8?B?cjNhTk1WOVRCZkFaK2p4TU5rbEhaOElNL1NGQjZKVktpRE5hdTJUVUtQOE8r?=
 =?utf-8?B?Y2U1b3JzaUFSS1Z1UVJmNW42ZVhoRlhEQjV5M3FxbUExL2V1KzVHR2drUFhI?=
 =?utf-8?B?RDlFdUtjRnduVnp5U3ViUVZuU0J4Z1M2Yk1uSXh3VSswZ1FPVzBBOEROQW1G?=
 =?utf-8?B?VVZlNnFVU2VLQllDN0tJN3libU0wcUNPQUtkRU9wT1JLSWtVajlqZVp1Ukh1?=
 =?utf-8?B?bGd0T3VQNWFic3hIY3I0OXdVUjUyVTFuV1pSaE1EdDdmSW0ycUpaQ1hXSjJ6?=
 =?utf-8?B?Q1NHOFQyZ1hPbUxMcGtScGt6YklHWCtmanFDZVRNV1ZGWGVsbGk0NEhjeGtL?=
 =?utf-8?B?a1VOOVNjQXhnT3ZpTDZsRWdab3JNKzBPMzZQYmJETVVybjZXa3krS2tnVE81?=
 =?utf-8?B?dHBuUktXQlJwdnJsbVJaZjZtdnAzZHlmYkR6NEZxazR2YndaL2pkeUVYTU5a?=
 =?utf-8?B?V0RydDlsSDZiOXFZNnp2WTEvOFB5bU5UVWxGNVhNUUtRaTJjK3pSUEo1cnJa?=
 =?utf-8?B?RzZJN0l2bVlzajdOMWxHWDVKRCtLcEQ5KzFLYUh2cGdLeUdzL09KUnRqd1Vu?=
 =?utf-8?B?cHZnd3RLQWpOb0dzNXg0bHZLc0piMnhuQThCL3A2U2FybmJ2RmdoVTZ3aGk0?=
 =?utf-8?B?cU9EVlJCaVF1R0dsVFE2L1pQVVhtc2JIQW5Fc2FtNXoxMW5wRTVsRHdCMG16?=
 =?utf-8?B?YVVpeDF5dEwxUSt5dGVZNW1xL3NTdE9lOHFkMnVXdXVCWW0wMHpTbThLbWdI?=
 =?utf-8?B?bXNJbXJKNzliZmNYVGlsRklHRTBuSlpmdnVoU21palQrOXVidnFZbm5yczFC?=
 =?utf-8?B?blZGQW5XWGN5a0ZsOHdUcUI5VEVJYmVTLzgwelhCSjF4NmNTMmNIalhXVzVp?=
 =?utf-8?B?SkhocEFraU95NzlCenJSa0lRaFRoeGVJWnlPTkhnOWJZcnF3WjFMTnBPRVEy?=
 =?utf-8?B?VEp1d2JUVmVEQVdkWWIrZHovRHRtYmZtNGFrWnVFaFBnTlorTlFsWXlxY2Fi?=
 =?utf-8?B?WEY5eitQVUJ3YlBiYmJsTUs3VGxIcjNrVEh2NWZKV2UwZjU0TmZsV0pRODJi?=
 =?utf-8?B?RHVab05pa1VOVkZET09GU0lXYUJnbUpaN2ppYmZFaFpONTdzRzRjMHRQRlJ5?=
 =?utf-8?B?MUdKY3Fab2RwUjBFK012cXdWL3V4QWRFUVpBVFhJV1dkVkIzZXQ4c29XSVRm?=
 =?utf-8?B?OFhOOUlHS0w3d28rVXFvd3RhOFFGV0kwK2pXYXBDRzFObW1LUTdESEJDZ1g3?=
 =?utf-8?B?bUFGVFE0TXFSZklEQWx0citKQy9sQW9ZY0J1OEZaNTZSckpMZFhnR0xCMzFY?=
 =?utf-8?B?RjN6SjV3R1dGaEFsWW9qQWZpWjFNWVliNnhFSDZxdGt5THpxZjhCaDlwTW5E?=
 =?utf-8?B?OFZ0L2Z6RGtjUThpeWtDWStOcXpIdkxrOUs5Y3U2UWVyZ0wxeGVIS2hIVlA2?=
 =?utf-8?B?Mk1xcVgwZDBQL2RycndKSEFLVDBLbHovYzR2QUJuUXBuZFN4eDErYkZlZlRK?=
 =?utf-8?B?aUc2eTV6SEpKb3FEMDRkUmYyYmlkUGl2aStsaFV3SHVWRzNIcmUraHRGU1Bl?=
 =?utf-8?Q?3e8HjDFnGGtPHaiqA+DQH8izkllmcgc3T4Kjrqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a80ff0-aa3f-4077-6910-08d919452e38
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 15:05:17.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pu8zuO9fsn5yCR9hgtrhAu+RBmu2XdP0amlre6Ij4g/gQlqUVmGRVeTdte8ivytcVlAhnc6Zv4H4WGX426/uzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 7:33 AM, Joerg Roedel wrote:
> Hi Tom,
> 
> On Fri, May 14, 2021 at 02:12:33PM -0500, Tom Lendacky wrote:
>>  arch/x86/kernel/sev-shared.c |  1 +
>>  arch/x86/kernel/sev.c        | 37 ++++++++++++++++++------------------
>>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> Having this change in one patch is okay. No need to split it up.
> 
>> +static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
>> +{
>> +	struct sev_es_runtime_data *data;
>> +	struct ghcb *ghcb;
>> +
>> +	data = this_cpu_read(runtime_data);
>> +	ghcb = &data->ghcb_page;
>> +
>> +	if (state->ghcb) {
>> +		/* Restore GHCB from Backup */
>> +		*ghcb = *state->ghcb;
>> +		data->backup_ghcb_active = false;
>> +		state->ghcb = NULL;
>> +	} else {
>> +		vc_ghcb_invalidate(ghcb);
> 
> A comment would be good to explain why the invalidate here is
> necessary.

Ah, good point. I'll add that and send a v2, but I'll wait for further
feedback before sending the next version.

Thanks,
Tom

> 
> Regards,
> 
> 	Joerg
> 
