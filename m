Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE8422DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhJEQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:29:58 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:19617
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231196AbhJEQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbwZe8Bv0ML6HC9PLZfFnY940XYaK2gY+TGu9GHSF+mvV5Yig3IMYGfzP/AM0ze0z7Ml/ypaOjAqgVrzEouRge13kHyADXb1Lq+AQ2fbZ2niFXHI6xNLOcBlAR2O72BMbqVE5cyH/1HyHLhKmHeE/PvazNMHsPVITc01oEZ9yKnq2xgKka9TpAEiu+JG/tb4FBTcbDADeoMYtnvixuuPdtnfUj/5UYOVLidNHRb9tq/42re2KYiXcGqPnHTJG9SiwBBO7QCRHrkHkjiSLm9p7WKfv0qKHre4uPqJp3Rv3uIRBpZTvN0MPCyoodDa5G9fNDjuyv0/UW35N/6SjvrV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2508T91V5QiPKYoMNJ1dVR/H43vF7CNPsijtAHUjvQ=;
 b=gg9fypYksrwtpzR73rupZmr8w4VFvfXZ+Tci217gtRhgUtYalmnTY7JzNh5MPUl2R3EkEnzewbWY+Dr1IsutmUzj5Sd0aw+thYik59EGsUgvMtOqfSouLVmx1Nd1kGKGWfoC/tq6o2xsbBgLBiBJe4oJ/zXgkrHMuLjTW9DBs2w9BxOhXHxRpdyWY1o8CzvHJMh+mekvJXV2szMIgpZHzUqEm4xyySr8nMKnwzDrZH490hO1BFA/DCE2R9nnrYaFWXhRWXOEP4ZtkKAwM/q+aCCQOqQYlV3cWTV5714j60Mh8fk1EdcBN/XoGehTe2QXUk08L7qqV7SAI6A9Yt7IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2508T91V5QiPKYoMNJ1dVR/H43vF7CNPsijtAHUjvQ=;
 b=FZ5NI7hFjt2UMUqwsPyP3a5BJ27+1mw9n0cD3LRKmoaEXo/+1SCKRt4kB9/m8StlBvISmMNs8M8pV2PrCcq+WWhYSOxzSY2xStTicBu47xeAuSgt2EIwLIV/EUoBvcpzLeFvLyYBdmy5Pgueeul0UHRqJWy6XUpj3wS/WAsyTyI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 16:28:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 16:28:03 +0000
Subject: Re: [PATCH -v2] x86/sev: Make the #VC exception stacks part of the
 default stacks storage
To:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic> <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic> <YVcGdpVuSsieFL8W@suse.de>
 <YVcSuVqmTPiw4YLk@zn.tnic> <YVdx/SRNkeRFnIuX@zn.tnic>
 <YVsY95SXNN4uTCCl@zn.tnic> <YVt1IMjIs7pIZTRR@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <eb92de7a-e0d2-cf2e-f05b-599d27a58012@amd.com>
Date:   Tue, 5 Oct 2021 11:28:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YVt1IMjIs7pIZTRR@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0045.namprd05.prod.outlook.com
 (2603:10b6:803:41::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN4PR0501CA0045.namprd05.prod.outlook.com (2603:10b6:803:41::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.15 via Frontend Transport; Tue, 5 Oct 2021 16:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa96fa45-da1a-4d15-e905-08d9881d1a6c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5231E3C2D6FC1553F22A4F30ECAF9@DM4PR12MB5231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXsrIqo0+ncNAhaXkXZi8VNnL3RLB9AO2qV8B0T1yc88j3WwvihJifZF3N5+ab9+s3JgvkkvMQA96eYq45V9i/A+Uvfd034RIOhV6aMOtVbslJbh7gXquXE5QTWCw9oqNj6k01JHzcC7IQlm+iUAw8r6/fejSwX4GGHxgXr3Tmw7Q1sBfQOvfmwemhWNqIqLsFfTOh35rwTDZ9/i4v4hBqoJFYZrlicFl+YYIaHRZGKy9Zl94AdDi+VqTTMjIFyjQL7iraqf/3wePAAALbzMQPGltiOqFRAFe203BchwdqxK3KVf9z6eHehQi8nelmyuibfqzU4TxLwOeN7UlTtSquwwGEaKP9CQ2U5j6QZCrlEBzG/lzEpn9/QL2QCVI+D7QQVeO2yUhdHrAVa6eiLNqDDOvDnajt+iUcV3HtDLfVw/Vcepi2echTVM160jgKBJ9zmeq0KVJatWuze5OovVFxs11h0ba0GaUMT3kmBwj/DWDpo+YiOSqj9Jj2IWeThWv4g4p+lEzBhXmLIMvGa4geBogweCOMJjT9ghEScHeHuy9NeBd/btatyArjKhTiW9Xw5V9tq/0/vD9gXp0qElLrEqo7CBqHx9vi7gwDawGrNkXY3QC6+1Pg6GTTdch4WnDdCbJP5lUFrYnfkQiSy9LDmDRhn0E1o7kmg5p3r9W1+l319196TQrdp4tqR+J0k5P7rzJdgSmrU3rDCCRdnxvJnPrziic88bAi/AyXgUbuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(83380400001)(26005)(53546011)(5660300002)(86362001)(8676002)(4326008)(2616005)(956004)(186003)(8936002)(508600001)(66476007)(66946007)(66556008)(4744005)(316002)(16576012)(38100700002)(54906003)(31686004)(110136005)(2906002)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3JZVjNHMTM5enVjWk4vZFVEMHl6N2xha1EwNisrOVpWb1U3ZVdQRGFhbnlj?=
 =?utf-8?B?Sk5GRW1RZjh1alFHYnpINXpPOUxoVytHU3M1ZXFoZTAxWVIxdG1heHJhSDlL?=
 =?utf-8?B?OTZHdFZ0OWkyMDVJK1hWK25JUXhmQzM3TlpYa1Irc2ZvMUJQVnFBSk02RTdO?=
 =?utf-8?B?V2pBVkNHeFhiTVc1OVJscERFbUpMRUp1NndDME5QcktiUjFhN1BCbzFZN1Fr?=
 =?utf-8?B?T0JISjRGNEVGTnpYdlR4aDRCUythd2VUb3J1bzB2ckljZ3kyQ0liSGNLQWVP?=
 =?utf-8?B?NGVNMkpRRW1FdnhhMFIxQWgxTlhIU1FEUE5jSFJmMzVTSm9VNHNQa0ZwWUVG?=
 =?utf-8?B?bm1sZU9JN1RxeDdESVZKSGVsZFlITzNZWlZZeXFrR281ZGE2cHpDM3Z4OEZn?=
 =?utf-8?B?eFZyUUUvb2Q3TzZXVDliYnRoK3FJMno3NjJqemZvOWNFN3N6S3U1MEdMRUs5?=
 =?utf-8?B?VXVHZmoybmtwK1dzY3U2VUVTTlBMalpvb01EL0w4UENPUldtNGZjMXE1WlNB?=
 =?utf-8?B?MlNRVDk1enE3dlBLZXNUMTR6dWJOejFOU2RGVnlyRHlCeUdRM1VMaEFTZktl?=
 =?utf-8?B?SUdHSFVVV2xXa2pVbVZqbGlaVmcyRDJEU2RNU3hzY0FRa0IrMTlqU0VyajI3?=
 =?utf-8?B?Q0R5cE9DNTlQVnVzb0M0VzU1U3U1VjJFUjVmTm5hRHZCcUJ6ZGZxdUZhSXFa?=
 =?utf-8?B?WmFQdW9OTjEvM2FKOVBOcGJGTmtraW9YNlNRNU9nekFQOWw5TEV0NXN5NmI5?=
 =?utf-8?B?MEgzY1lUemVveGMwUWZWU1FTc3ozY0RJdUg2R3JYRmRuR2FJb2I0cEpQM2or?=
 =?utf-8?B?M0drMTN0WUxGYkVuWkkzSG5raU0wYmUwSGQ1TFlLSmRlRkRGT1FlK0VnWjNU?=
 =?utf-8?B?cFR2ZDhUQm5qc2NmYzBrM0ZqYWpHVmFVSU9RSWMydDlZZTFrbVhWMXowUS9k?=
 =?utf-8?B?akRKZUd4Q01ma01iaGZETXBJTDlVK2RlMGNod0Ura2FZSDNkeHp5WWZwNjRO?=
 =?utf-8?B?dCtIcXhBdlpLSVY0SlhFKzhHVVF3d3NJT2RSSXhLTVUrZXF5Q1dVeWtHdGsx?=
 =?utf-8?B?bXUzdkFpTEJuU3JKeW90ZlhUblc0eFNCMG5RV1JmZGxnUG4zOEw1Q0p3cGll?=
 =?utf-8?B?NGtzWXhCU3l3cE12c2p0dk83WGN2VXhueWNjczJ0Qy9xdGZ3WkxkOUNpdzlQ?=
 =?utf-8?B?TFRHZ29wZzhlTWswN1FkZloyUjVnYXRVMkFZZ00xL0FzbFpNSnJucWdNRW91?=
 =?utf-8?B?dVFvS3ZtZmg5b3N3cE8vU0c1Vy9CZWkxUnlkT3dLY0V2YUhtclNxbG1OZ0ZH?=
 =?utf-8?B?d25TZ0c3bWhqMmZYZkx6aXlXZkxpRHJVQXUvYjlORG16SzlobFo2UDhjUldp?=
 =?utf-8?B?QkVEVDlDQ1BPM2dWNFc0dlo1ZGszTUdBZHNkSjluTk9Hd0FSTk8vRlA5Q3Nj?=
 =?utf-8?B?a2VsaFV1TU9ZOXdaNTlWUmQ2WHZnZFRQWEZnbm1uMkpwbDRQRndrdkY4VkNP?=
 =?utf-8?B?b0d3M1ZHb0tIR1pGcTNOd2pVelFNSFZvY2kxMy9VejdzVjR4VTgrSHJiVnpB?=
 =?utf-8?B?UG5xYU9xb1NMN0lWQllzbW1QdTBUZGRFSUV2STdoMWZvdkxkOFF1MCthcmNz?=
 =?utf-8?B?MHNrNEdtTnowZUNSOGt5VHRHU1FpcGQ0Y0ZGU21xUmI5R1N2QVRBYjNMTWlo?=
 =?utf-8?B?cmUzNGhnc1dkc0JGRlk3bVViYVpDRTQ2MkNVNk5sOGVIVzJ2RHRmTko1TnV5?=
 =?utf-8?Q?IykYbVBstjGqlL8EhalNwnhuCC9iowsnQRE0Qn+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa96fa45-da1a-4d15-e905-08d9881d1a6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 16:28:03.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSg44kXJQt2IWIXuzryUk8Jrmohr15JftMCwnNENYsQpT/agbAiisQ7HmMvGA/PmtpROSYdyQwpZqcXMrOxLTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 4:41 PM, Borislav Petkov wrote:
> Yap,
> 
> here's v2, now tested. It seems we do need that optional_stack_size
> second arg to ESTACKS_MEMBERS(), thx Tom.
> 
> ---
> From: Borislav Petkov <bp@suse.de>

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> The size of the exception stacks was increased by the commit in Fixes,
> resulting in stack sizes greater than a page in size. The #VC exception
> handling was only mapping the first (bottom) page, resulting in an
> SEV-ES guest failing to boot.
> 
> Make the #VC exception stacks part of the default exception stacks
> storage and allocate them with a CONFIG_AMD_MEM_ENCRYPT=y .config. Map
> them only when a SEV-ES guest has been detected.
> 
> Rip out the custom VC stacks mapping and storage code.
> 
>   [ bp: Steal and adapt Tom's commit message. ]
> 
> Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")
> Signed-off-by: Borislav Petkov <bp@suse.de>
