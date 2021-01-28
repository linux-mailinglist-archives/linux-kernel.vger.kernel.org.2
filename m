Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA935306FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhA1HiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:38:06 -0500
Received: from mail-vi1eur05on2105.outbound.protection.outlook.com ([40.107.21.105]:40800
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232014AbhA1HhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:37:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3/X2hBQm+4bcjQikWuvR1vgaS7sj60fH9AIr6ApYSF91FV3Vaihl2D6/lJn+0ymwVnAYAd5YAai9vKqIokcT0G/vTH6ybrMwPSXvFyB7dxLyP8yUNrEc/qgWofKJizz7GnVGVUgCwvjAYBxw4FTNUU7vvrXTXl1BOTg8+GKMyv/tk2WQgzuC1nOInGKXJDXI/6Q8FQuxMNtV48ykR2w8+YsjbQZgTEvaWwi4SSdgjLyBNI5LaA1wdH6Gso4C7SmU0veAwGhYETW4f6yU52ejRzukEBDq436Q6EKrGVVFkuhA+vF/Mx23Mc0X9vwKZmvDL8yyKWm88gPxIZn3w/e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL13ODPs4W+ymXpahJMDU2VwtYyuHAJswRQqzrpX/KI=;
 b=QOyLuzlUMMIYkwh/QuPheu2MEvU9d5R84cym+RIvCevhnPQqQYsn6jWh2mgtzMEgp9eslYwh9PVb7uOjpyd/PvSw+AAWpfEEdnjZJJdU2Qyhz58e7D2zmjs/0wT73JJk1FEkhGS/tXPGZnSkbRk9MSmYGO9j8OgTdDW5NA3uUHR53AoTveYAL51QaFmqFrAQM0Gx+ltrUCImA4ZFmnCqOxaEZFoO7GY8H7DFDe4NOoUs8hfmjR1FfWCXAQuyroytT6bPCVbpmgoDrnL0jlqmOao9RM4Kb64OmK0FnndCOpFf1VLZXac//9ljkjniS+xcvmWCC7mzb+BbsOCjbKRrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL13ODPs4W+ymXpahJMDU2VwtYyuHAJswRQqzrpX/KI=;
 b=v5oVmlAgipzGCMhupYVQxZ1SKeJXWscmRMHD/q11DkfUdut2wS1p6reeKYGLiPfbw4qK8EAVZbghMupfhDEsy801KeKPhyR8rcB4o6SQTuQYpE/Roqx3r4FiaBBflYw5cKOiAXVQT6P7y5ulp8X1+7coegwU6gsRT5YBEO7KvpQ=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nokia.com;
Received: from (2603:10a6:208:6e::15) by
 AM8PR07MB7393.eurprd07.prod.outlook.com (2603:10a6:20b:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7; Thu, 28 Jan
 2021 07:36:27 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::e965:2884:260b:b29a]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::e965:2884:260b:b29a%3]) with mapi id 15.20.3825.008; Thu, 28 Jan 2021
 07:36:27 +0000
Subject: Re: [PATCH 1/2] qspinlock: Ensure writes are pushed out of core write
 buffer
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
 <20210127222158.GB848@willie-the-truck>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <c932770e-8a19-ab32-7b4e-33fc36981b77@nokia.com>
Date:   Thu, 28 Jan 2021 08:36:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210127222158.GB848@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: AM0PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:208:1::32) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.168) by AM0PR04CA0055.eurprd04.prod.outlook.com (2603:10a6:208:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 07:36:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e9e0bea-5f49-49ae-226d-08d8c35f6bab
X-MS-TrafficTypeDiagnostic: AM8PR07MB7393:
X-Microsoft-Antispam-PRVS: <AM8PR07MB7393A59DBE99709D203F647488BA9@AM8PR07MB7393.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjAKS4htau/AFMtwOYOFjS2Qpoxb4Yh2xMDTJqQBVg0JtbwcRIx7YVMn3Kb27dR8RmBD0Ev0ExhoQJWBW7Wfv1WtlW+lqhV7lRqEcNj+ZNkw41O0N/ZHNLYz/iSotEmsfEnUstzTuJo5Vk/obPV3KCqxq/wje7BBG7xKhmajytDGNifdxIAB2N06B8vYsmGFkTx00fgeL4AjxunppK4YmHFPHIDYSKR8VqgNgGpFh0Fw/bVh+O0+mHhch2oEU5FkfEGcwDsAvfk6NJRXQ8pF21GwnPxv8J2j09qqiHCJzWqz1rte+kEHr/fvzDTOyOD9+l58ThtSG85gLXpAPda/KxGVUdbwRDrlkHgxyJ55FtvRFzgyOEbMqjXWsTL1s0NtH7ORirzov7vyE2dhf3jVVzvU1uN3ixeDr+c3NGOXGTKpba5bqaQc4PK4CmwuEfmgJEHjTYlZEPq3NrGy59EVTyeFjQj7qRm0YIG9JqebzbKgQsqXJDBNnmsfOPsevxpGQ3eWLX4zVr3PO0YfbWD1ZbRjm3E1mb5Ra9tRbHtDkkcDAsGq9PHGvBtsZPp/GfuSaXB6TkR/zRncaSQNYrfg5zm7EC3qt+YmamWalJryva7dFHNd1/eSy2X5yf8SzF5zrySjsukKDODK579QAp4S7RM2RH7KiacxQnTh1C/fbBKYgAz2GLMT93kX4FH3+lhJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(186003)(956004)(16526019)(2616005)(36756003)(26005)(86362001)(478600001)(966005)(316002)(31696002)(2906002)(6512007)(53546011)(6506007)(6486002)(5660300002)(4326008)(31686004)(66946007)(8936002)(66556008)(66476007)(83380400001)(52116002)(54906003)(44832011)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlBMclFEVjlQdGxQMHRwbFdDdU8rOFp0VkNUckVXUG5CN0VaL0RkOXdoQjc4?=
 =?utf-8?B?YzE1SzhXeGMrSUlrTm4vdk9FemVqZkVZZWxtalY0Q3ZWeVRyK2QwckVsd0Jp?=
 =?utf-8?B?cUpkZXBVT20xU1NnTU1DUVkyTEFSQnJRblR3NzdBM0hoZWYzbWxXRUhrZ2Ns?=
 =?utf-8?B?UmIzdzJQcE04RmZNcmN3RHRndU9HM3JYdXppRDdMY050bW5YVDM0anhoaHMy?=
 =?utf-8?B?ME9sNGwwSXR1dTYzeDlOc3U4SWNVMEhmdXVvcW5aaEpIWE52RklldGNXMmw0?=
 =?utf-8?B?dmUvM0ZPTituWHJ0Q0RaWkdMdVVFa0ovSDdWc1VITXZaNFFIdWNSR0Zhd0xk?=
 =?utf-8?B?SmRYTXovZWhyZ1ZDZ3NaU1JqSWxsQjBtUk52TEFZNDR6ZmQrYXRrNGVNanlH?=
 =?utf-8?B?KzMrNHF6TWtZZ21XRmdwekZ1L1NmQmpSeW5nM3NyMmlZbUlzckhkdnMvUmxv?=
 =?utf-8?B?QjB2bGwxUlhjeVJoVGpXcWJ0SHhMclNjVWt2Sm1ibzdIN0QvYnZnQ3R4S09s?=
 =?utf-8?B?SjlxckVDWFhnU1hKRWJaeVNFVFBydmVrNE4vRHplU1FVUEhnUmxIWHpqUStw?=
 =?utf-8?B?VXh3RlY0bDBtK2dMUVo1SzFaUWFqVUlRRmdpbXpCM2xXQmlvVXJrNFluM3Rn?=
 =?utf-8?B?N1FwcFZWOEJxcXJ1eGVBVGpDS211Z2tSNWx4cndQVzk3c0dpczBYQ250SHh0?=
 =?utf-8?B?ZndpSm82ck5URUlhdW92dUVRNUJOYjZaa3VJUm1LRzJhalZpL0RTNlRYTEpx?=
 =?utf-8?B?UDR6TEtOeVRqVkpteFBHL1dOeWZzd2VNUDFONWFGT281aUdlalhTMlE0cUVm?=
 =?utf-8?B?TmNHTEYrckFnejJSUVpNWHVyejFDVkZDcW5oQlBsQ1liR3VUVDNZYm9RZVZU?=
 =?utf-8?B?ekllQjg1N3dUNG5KZjEvS0tQendXT0pkNU1hK0lNVkw4VkV2VlNGTTdQbjI5?=
 =?utf-8?B?bjU4b0pLVkNTdHM2NVNDN0duck01WlVYTkljSXg4blkySVZsMGp2MEVYMkZX?=
 =?utf-8?B?UDZZTlBsUzBBZTMrM0FIcnBiaElyMks5SUxkcWZ6SCthWVE3TU5OalJSV3Jy?=
 =?utf-8?B?ZjlXS3NpNTJoK2xSTm5OMzgzcHdycmhNMW1vK1Q1OWd1T204cjhIakplL0Zq?=
 =?utf-8?B?aTFiTHZuUml3T1BvS1VlUVI5ZHVFVkYwSGl6RHdhN3NJdXFtYmZIRE1zQnc1?=
 =?utf-8?B?WkZKR1hHS1h1VHVOemZXWlNxRHhJMnRSeWxsYWdtbmlIUjhWNFl3U3FHRWVQ?=
 =?utf-8?B?ZWFPNElJM3dqMlZNRWNxR2dGRWtsUWxITHY3dU81czNLTVM0VTVNT2VFUlhQ?=
 =?utf-8?B?S0o5a09pSW45bTl5blNQMDY2TTdoR1QwRGJzQ3AvWVNveWNXU080ejZxZDBX?=
 =?utf-8?B?US91Q0xrNG5jVEU2VmlvTXlBdjB6cmk0bkthY05vb2l0cjI2bGYrNVpkaUt5?=
 =?utf-8?Q?590zhqdh?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9e0bea-5f49-49ae-226d-08d8c35f6bab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 07:36:27.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+pf8FIP7xQYOacD4V9Ah1U2Psr0uwf4Qxw2tOkvzi4SAYsTG+jRxWaoFZvcQ/+UuBjz8PGG4r1b/2NuUfEEupo/VviN2QNMACnb5HdWNek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 27/01/2021 23:21, Will Deacon wrote:
> On Wed, Jan 27, 2021 at 09:01:08PM +0100, Alexander A Sverdlin wrote:
>> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>>
>> Ensure writes are pushed out of core write buffer to prevent waiting code
>> on another cores from spinning longer than necessary.
>>
>> 6 threads running tight spinlock loop competing for the same lock
>> on 6 cores on MIPS/Octeon do 1000000 iterations...
>>
>> before the patch in:	4.3 sec
>> after the patch in:	1.2 sec
> If you only have 6 cores, I'm not sure qspinlock makes any sense...

That's my impression as well and I even proposed to revert qspinlocks for MIPS:
https://lore.kernel.org/linux-mips/20170610002644.8434-1-paul.burton@imgtec.com/T/#ma1506c80472129b2ac41554cc2d863c9a24518c0

>> Same 6-core Octeon machine:
>> sysbench --test=mutex --num-threads=64 --memory-scope=local run
>>
>> w/o patch:	1.53s
>> with patch:	1.28s
>>
>> This will also allow to remove the smp_wmb() in
>> arch/arm/include/asm/mcs_spinlock.h (was it actually addressing the same
>> issue?).
>>
>> Finally our internal quite diverse test suite of different IPC/network
>> aspects didn't detect any regressions on ARM/ARM64/x86_64.
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>> ---
>>  kernel/locking/mcs_spinlock.h | 5 +++++
>>  kernel/locking/qspinlock.c    | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
>> index 5e10153..10e497a 100644
>> --- a/kernel/locking/mcs_spinlock.h
>> +++ b/kernel/locking/mcs_spinlock.h
>> @@ -89,6 +89,11 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>>  		return;
>>  	}
>>  	WRITE_ONCE(prev->next, node);
>> +	/*
>> +	 * This is necessary to make sure that the corresponding "while" in the
>> +	 * mcs_spin_unlock() doesn't loop forever
>> +	 */
>> +	smp_wmb();
> If it loops forever, that's broken hardware design; store buffers need to
> drain. I don't think we should add unconditional barriers to bodge this.

The comment is a bit exaggerating the situation, but it's undeterministic and you see the
measurements above. Something is wrong in the qspinlocks code, please consider this patch
"RFC", but something has to be done here.

-- 
Best regards,
Alexander Sverdlin.
