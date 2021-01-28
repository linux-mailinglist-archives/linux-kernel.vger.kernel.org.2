Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6972306FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhA1Hnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:43:41 -0500
Received: from mail-eopbgr140094.outbound.protection.outlook.com ([40.107.14.94]:19164
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232157AbhA1Hm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:42:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEQAP0Vw7JRvhf4L3Imj8GBLOnU4Yfe41BP3Dw62SkqBPlkTZ+6W/Os2ltfYBwbCsaYnodW+P6vDlGt1sSjFU6io8/PmKoqX1RvR2Z7OyZHSwr6rgixf8WtyA9jRwca1lyuIaqWyu+gGIhTDvCV3SV7tae3gocrHmqEugImGLZR1FOgHKOUN2G/6rp8nuA5pq7NT2T79wRzQEdpR0jIjnfjo6ARX/pxu9GjuWcZLrXHg/TwNt4nr/lEcQc2mNdSRtn9Y3ddqebl0o7x7tMidswnlKFAqc5mvPjDozHtWeWAupUcea8dCb9tnjz4R7wm+fLNlkmDdginTwoc7zbLBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1qrNaxGVEWfE9scEi3H0Ue1HoQ0Gc3oxkVySoNh7yk=;
 b=JU42O6zxy5WvSl0ZgNu5srGrRXKSCr9CjgMjgaR465j42SxG0qmn5wnthYmxw6tBi5oeD3/bBn/xfYhptFMH17/FoORS7vej7PylVDmcDgGWauD+NHwoS8NwgG2Fn0s09u5odyx+KzKHJ5J3RbjXMTc7sBvqQmnVWg37crFukQZnet1Xbfp1C/diFj1i8sj2siQjpGUXNIjWVXlaI1pUzGQdOBP3kGc9d6p+dgFfzBm2f1fwHj4/Z1vFfxy/6ir2B5Qd5RZnL3ulpo+pIAtzeQRPAGG07BiqC6X5jsFduLj6pGbR+IDtpBRnK297Ltx/6V8YFMca6L7wgT5BT3i2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1qrNaxGVEWfE9scEi3H0Ue1HoQ0Gc3oxkVySoNh7yk=;
 b=r2LEU5kKZ1Ekd4xH++oivg1LEqJH/QJ+0iEnhKatX5Ax3qplLkUpjcf/0dZ/a7HyZ4sX35sj/32v8Fqe0Su2RwxDFGOcSMLwaUczFh1HsymUxLxZ/rW9ClI8D/Jg9Bu4MPOhwAgurczJbCswloOqSzK4H4Z5bl4B0Y6GANXjUh8=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nokia.com;
Received: from (2603:10a6:208:6e::15) by
 AM0PR07MB4036.eurprd07.prod.outlook.com (2603:10a6:208:50::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Thu, 28 Jan 2021 07:42:05 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::e965:2884:260b:b29a]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::e965:2884:260b:b29a%3]) with mapi id 15.20.3825.008; Thu, 28 Jan 2021
 07:42:05 +0000
Subject: Re: [PATCH 1/2] qspinlock: Ensure writes are pushed out of core write
 buffer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
 <YBHsqIjop6X0Z+1c@hirez.programming.kicks-ass.net>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <f1070b0f-7e3e-0f51-da7b-2ad9269b2ee6@nokia.com>
Date:   Thu, 28 Jan 2021 08:42:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <YBHsqIjop6X0Z+1c@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.169]
X-ClientProxiedBy: AM0PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:208:55::21) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.169) by AM0PR04CA0116.eurprd04.prod.outlook.com (2603:10a6:208:55::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 07:42:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1c2db44-68e6-42e4-a989-08d8c3603585
X-MS-TrafficTypeDiagnostic: AM0PR07MB4036:
X-Microsoft-Antispam-PRVS: <AM0PR07MB403638F18227E387C57E34DD88BA9@AM0PR07MB4036.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Id7VHBsMUwvScsFEl1wrGNG9TIWFlG2XDwGSQa1qcOHzSawxvWpCwvcMCVuw7ZBoHbZ0dGNbf2IC7LaekYxuKocjb8KFYbAwIQw1w2nRaCX1Vl149OmAJ6Jd8FbCPRmf4YquJljaHQpKnbIpttQ/h7HFHq7BW4Bpi4bNrVIwYbdMs1Y2UFOjrdxmTWzFHUwBzL4MUMgFVU0MJLgQCTyYjRrvJ9kbKw2OJMKccjXKw9Sj3rzwHv8GgGQFSoYEJ++Mtq6BCZyMbbvLHrpkYYEJK5WgkbDKAJeoD66riMX5K4bLiYjtPgD15DWTx8QuKmrzVDrxLwO1QyKMJiriJ/BzIbgtsvPOOc0Fypz8mNnJoutKWX3/cO7QruaRpSjCsTKW4AGl5CGg7arp/L8yw0TNb4Ab/HfkmbAAqKe1iITU3jvFymFoG1AtOFVIBSAfCZW+RLLQ+2N+hWzwvu+Ye/fBD+WQlhkvdqakg/NELIkOA4aVUVb6RKmuBYwyckmyO/sxMLeF7bp5z8cUVH56aCaAnYyuu1Xvb9IubOfkR+9LFhX3LUpyJMLZjtWSVI8Ha97RyLE2P45knIAUalHf8yFr2kFXKFBxi7Onuc+prVEy7p0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(316002)(31686004)(8936002)(36756003)(54906003)(31696002)(83380400001)(956004)(44832011)(186003)(2906002)(2616005)(86362001)(52116002)(16526019)(53546011)(6486002)(8676002)(6916009)(6506007)(6512007)(4326008)(66476007)(66556008)(26005)(5660300002)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ai9COXl5RFZFUUg2NFJsTUtBVEtiKzE5aTJmblpDNTMzWDcxOWVlWFNBVmg4?=
 =?utf-8?B?cHlJL0pkYXYrYXFxdVZObzNJbjl3S1JOL3Q0ajNvSU5jcVBCanRRcHBLQnc2?=
 =?utf-8?B?dXYweFdabmlCaFJQZm8vOE9ISzlkR2gzd2JjODNrcXZJSURLZ3BOQ3ZWenBr?=
 =?utf-8?B?Y1h0ZUsxVzRvdjJITDNyQVcxMEpJWk90QlRDVGNKRitTNHYvV29EZWExZzZv?=
 =?utf-8?B?bWV2M3F2bVR5UUtBUm9JcXd2NTlYd2FPcHlYZkNYZHRnNENNcEpEZk1mdEQy?=
 =?utf-8?B?anI1NFRua0NNajJjOXFWMjNVOFNvMWhFV3lTeHBRemRkUUo3RU8xMStFeEZ6?=
 =?utf-8?B?QmgrUTlpcFgyUnpiQlE0dHVOQkcvN3B6cVovMjdIQ3JEbjFhVU9uZ0Q0am4x?=
 =?utf-8?B?aks2cDJJa1h5bC9PVUwwTWhpYVMzaS9SYS80bEU4Q2V6ditJWll0ZEY0bXBt?=
 =?utf-8?B?TFYrSVFxcU51TDdkU1lFdUN1T2h0NXp2T2tJN3JaV1pqMzFRVkhsNjMrK0JR?=
 =?utf-8?B?YmhZQ2Z2SU0xYzVjZ2ptVmxQSkpFcEpKTTVvL2lqZDh0KzA3UkZXdFpXQVF0?=
 =?utf-8?B?T2Rubk12U2dDTFo0QXVQczVXZlN4bTdJbXdSS2pnc3Q1dFdQQ2VVaW9LUVh6?=
 =?utf-8?B?OE0wTVRNSGZQSHNZMkRvUTJBTEljOWsvbXJRMDVBMmdsZE90aVBjUi8zRVA3?=
 =?utf-8?B?Z1ZlRkVraHRldDJ4YnFIQVlReXhXcWVmTWl4eFZhMGNmd0JFNzh3Mnl6Szdo?=
 =?utf-8?B?S29hdUJscW9jdURLc25iZ0gydUZLSmxGVWNYQ1JBaklydDA3dGdUcUxCRXBr?=
 =?utf-8?B?L0dKeU9CL28yelFvWGlUNjJYeFVNdTRnSExEQnBkQW16aVUzSmRBZkd2cGU2?=
 =?utf-8?B?aXh4cmNiOGtsUXZOVHV6aUJ4WlpERzVYRVBJWGtjVy9EcE94ZUY5SExhRVl3?=
 =?utf-8?B?TVRuNlEwUU5BdGdWRkxJRG12YjFzVFFkRzdPUnJtS3FRMW1qU2xtc0NDRzRZ?=
 =?utf-8?B?VXJmRFVRNjJNcHRGV2RFU3cyWjRla0FVOHE5anNsVWFIaGZpM3dsbFRaWSth?=
 =?utf-8?B?amswdUpsYnFPb2YzbmhUOWZpRGZBT2JqdjRxdGJVNUZvdnRYZEVsQkxUMzhV?=
 =?utf-8?B?cVpOU3ZpR3lobTNDSU0xNGRzOGsrc2JNV05yRFIxUmx0WEJTZzFjWXR0YUlj?=
 =?utf-8?B?Sm05YUlOQ2xMeHRVQWFpUEFHWHFOSzVFRWtyZm9MYUdXTzVGdzZaeGY3K0hJ?=
 =?utf-8?B?N1FiTXVvc1UzWS93VEEwaEtNamx4cERBUjZ0aGdoSUw2R2Rsb3NuYzJ3R0Q3?=
 =?utf-8?B?aEVZNXpGZHNZc1JscExNYVprOEFDNkYzMnRKa3N2UEx4a1loOXdMMmtPb2ww?=
 =?utf-8?B?RXlSUGM2RjBHbCtFeXpma2pTNWdRZytCTkZuZWsvWE5MbmdyOTBzbWVPTUNx?=
 =?utf-8?Q?DWd2Co+T?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c2db44-68e6-42e4-a989-08d8c3603585
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 07:42:05.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2X+tD1PxL892siw+tocDwzjYwbdenwcJlD9Hvo+0+WpE9X3pRVcfKmx5sojkg7fHg3g/LitJQo+BYMifTKHeHh4D1UzEVlIEyfHVK2+l1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 27/01/2021 23:43, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 09:01:08PM +0100, Alexander A Sverdlin wrote:
>> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>>
>> Ensure writes are pushed out of core write buffer to prevent waiting code
>> on another cores from spinning longer than necessary.
> Our smp_wmb() as defined does not have that property. You're relying on
> some arch specific details which do not belong in common code.

Yes, my intention was SYNCW on Octeon, which by accident is smp_wmb().
Do you think that the core write buffer is only Octeon feature and there
will be no others?

Should I re-implement arch_mcs_spin_lock_contended() for Octeon only,
as it has been done for ARM?

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
> This comment is utterly inadequate, since it does not describe an
> explicit ordering between two (or more) stores.
> 
>> +	smp_wmb();
>>  
>>  	/* Wait until the lock holder passes the lock down. */
>>  	arch_mcs_spin_lock_contended(&node->locked);
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index cbff6ba..577fe01 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -469,6 +469,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>  
>>  		/* Link @node into the waitqueue. */
>>  		WRITE_ONCE(prev->next, node);
>> +		/*
>> +		 * This is necessary to make sure that the corresponding
>> +		 * smp_cond_load_relaxed() below (running on another core)
>> +		 * doesn't spin forever.
>> +		 */
>> +		smp_wmb();
> That's insane, cache coherency should not allow that to happen in the
> first place. Our smp_wmb() cannot help with that.
> 

-- 
Best regards,
Alexander Sverdlin.
