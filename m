Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF93F62AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhHXQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:29:57 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:60129
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229557AbhHXQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLIYRNj1TWqzon0StNzFSXEYv6atn+GXjqmt8e+B/1itSq1ZL0kW9sasJlOpAXo0e+rG/p97iExF7TTnOQ8Ft14Ux9hQqCXNXdW1/rNzOWBFCbk7262RPqRd6eTCCeATZTJnpaJRCht2oCBJLBipxMzJNq1q5NNRM7DUC4v8pF9nags0lhpBbmeZnSo+0/xzDwB14Bo4eyzu9EFBX3GQPmRdB+NMR3N+cRtyKQ7HOAKLrv9Tiuinh6ZgZ5CpOMqDbbGxfqny0gtz3PizFkdE5jAlTSpbBgOKOjGky7My8cn0AY90CItd/9AV+TXWw4y6CrN1z22WakQsQWTmBWEkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+iMHMODc5bAGiRTYHT6WMiRG8CkX81UXRQT96evf1k=;
 b=AruyLhnEbvEDyRWbJmcS5/KUxtTXFost7FvmLZMmj3z3zKVUTkoXbiuC/Flu6K5Bp2h0+Xi/7NgXd/p3rkfrZM9hjS+9bMPlh9IUZ9j0ylUlyYRORIyragzUf/KK4BrlRu1a3n/zCxWcQgxdoGsUkTBkRfFnOw2ND956kXBgZPRvlXTHBgxf9qqUO82PKHyzEmCTQtmPy32DGRGxfbRw5Vz+BcOnqVSQp2UoWm5NjzkuIUr7tGTHi8Bb6cAz/mcZ/s952K6Bahvq4a2+xb2Q4wtQAsHU6cqs5thvk/Bq5vwyl6+3sltxovtKs+KJAFWHWBR/yKj76Lfo6Bgp6r35FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+iMHMODc5bAGiRTYHT6WMiRG8CkX81UXRQT96evf1k=;
 b=AVbL0eWlpD6N7GlVMdTXPh9n7g8L7dVarsjiLVAOdudyU9eL3TdFheXq5WGIFHhg9TTL2LG0ZylhJtRaH2YH2FfYqb7UBLDIi4GPrEe600wcjd/louZMUXuXpl76QLlidy5RQbxfJNvMRyXGEkx2T12sQt4WAJwqsO7PfiJFDEo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 16:29:10 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e%6]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 16:29:10 +0000
Subject: Re: [PATCH 2/2] usb: dwc3: pci add property to allow user space role
 switch
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
 <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
 <87pmu36ypp.fsf@kernel.org> <1d9ecba4-d180-2193-66a3-3812759e1916@amd.com>
 <87czq27r5w.fsf@kernel.org>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <05c17f61-30db-6d10-d980-d3973dedfa5e@amd.com>
Date:   Tue, 24 Aug 2021 21:58:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <87czq27r5w.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::9) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2401:4900:16a4:35a1:f52f:38ab:363f:1bfb] (2401:4900:16a4:35a1:f52f:38ab:363f:1bfb) by PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 16:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7dd7c9-8736-4758-b955-08d9671c4cf0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5049E200110CE54B7D80A605A0C59@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrrQ7HYEtCP3Rdohi5A5hqe9JGFku1IGhiE58CMRXOb17zrJabhMVPaK74fQReB6sy0QemCtmVfyC/HPytWnKdGZP/IH3+evkXTSKEed6iHDA0kkPXm9kFrXDSpjAKF8cDFZCAyuAiNUnmSr5ZvdVuIGv2oTYkXkqQg3PtTIZywms9BKfPm3e2NbG5BCqaWWTFZqA19y9wCUOWC37Ao2C9X7Cklw2u2WYIfs+PnB2VhY1zj+ORdqlKm1vk+Uc7c3BSnVqPFFYDakOi4m9+Z7YasuffL62u8zQwcPMAg9VJDcc8JaAm5T+6HsDNTH0ZnuMNReSZ14O41/xP68EcqjDXupwMryAT1qLWTrzbrVuUOxkztWiX4YrizLUFLJOxam8SLYhfOkO5Ld25r/yhlDtit4r/0uxntDXyQkistfCE3Au4lK+K55ifAN0B/amZRUfZ92MaSBZX1+warwUVZq27qRSnFb0/uaDmyQnN3z2WEJQm/hxm2ybJ7+MeJrkXFtIdt1oDCjjNY2k7W7k1EyzZxnerSiF2ywr/AT1izxKglg4qqMcH7dINud6nIZG0LOLsYq4SB9/9hdzMfDzUdF37keTYMZgaysaK1uPTWlGC0kfJleTaAFhkHTHnQWETQwuj98ROY64QSE+7oHj/9/TuChOy9+j2BeSDUC2Al57OI/stmk1S3A7FZxgEJgoOo0UVZRQ1TDcrkbJGSyRT2BG8gZH5oaNT8ace9CXWDNdV18oEPi5b8lXw/e1LL3N0Nq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(66556008)(66476007)(31686004)(66946007)(53546011)(6666004)(4326008)(86362001)(5660300002)(2906002)(31696002)(316002)(36756003)(2616005)(478600001)(8936002)(38100700002)(8676002)(186003)(6486002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NYTXB1NVdlVnpwTWx2VjJnUU1nMFE3TVhvTVRRQlhxL1dFaEFZNUhQQXFH?=
 =?utf-8?B?citCcEhEaERTV1dsQmlXR00yUERyRGRoMUxUdnh1YnFIUVNYZWFuT2JNeGcz?=
 =?utf-8?B?b1JydlkrcjN5UmthWEhMRktKMDNaTWo5ZWNBTjY1M3lseHhqY1RrYndCbEV1?=
 =?utf-8?B?V0FhcWIrMTk1R3oyaXF1akd6RTU2RmZmUzRBYUtrM0Y2Um5FSmFrMWNxWmRt?=
 =?utf-8?B?T1ZWNkxjeTY3T04vYWdHeGwvUExzR0NxRG4wbTNlYlZobFpJZUwvMEQ3K2kr?=
 =?utf-8?B?bi80cnZQZnpWNnBwalF5SzFCL3MxLzFhcHRFb0FOUHR0NlBjVXJiUFl0cXc4?=
 =?utf-8?B?azUwam16UUZLU2VzbDJ1K1BqSXo1ekVFL3BlbGhwZC9OdkUzaVFiRkZhcWla?=
 =?utf-8?B?MHl3WldoNEdlcm9xSStEcncxekg5Q3h1amNMY1lKWFlOQWJOOHQxQitvL0Q2?=
 =?utf-8?B?TFpzU0RZTC96QnE2M0xoOEhQazhVejVUUHJyeXc3UzVyS3M1dStzbWdzMFpa?=
 =?utf-8?B?UGdzZWpiYjlobW1Jd3BTVjUzYVJqQVhHR3hReFhHTlp3SXBnZFQxVjRPdnpN?=
 =?utf-8?B?M3pWRmF6cFNnSit4bThBWW9nR0NjUFNnWVpXYnZZSWdZakJ5RTNKNEEvck1n?=
 =?utf-8?B?aXA2ZXJKM3B1M1NDYU1WUlJLdjRtTi8rcTFiejZsa2YwSElSS25admJuTkpM?=
 =?utf-8?B?c3lGcS8vb21RbWVVNWtNdlhzWkQ4OHp6N2RyQ0NWaU1wenpYaG93U1hFbGo5?=
 =?utf-8?B?c3NnTmhKVEhzY2pVMlZDRlpSeWY1ZHJpSkUxYmdubUlmNHhqNEhvUGFOMWgz?=
 =?utf-8?B?Q0ZkT2UzbFB6RW03MFdsOGprNHNIL1FVdGJnc3E4S00rMGxSS2hxeHJ6bEE5?=
 =?utf-8?B?M2VIVXV3Ukh2TWxwYnFramNSZFE0N0VHTmdDWHZKelJYS0Npckg4TzZieUxr?=
 =?utf-8?B?R0haU3VPTjQ5eDUreW1CUXJZS1Y3YlRRYXc0QkErUjYvYklscW14V3VTSHd6?=
 =?utf-8?B?cGNCdGxNU0doaEwzNmMvY0oyWnZPMWtvb2p2Z09wUS9EWWhXSkY0eHZmMFVO?=
 =?utf-8?B?WnlJdmk3alkwb2pxUVM1eGJtQkErZGFLRHVXRXRFL0JQaUtKMEtyOGM1YjF5?=
 =?utf-8?B?bnJya0RxVU93SkxocXVVL0FoSjI1eG8xaXZRdnIrc2UvS2s1QkFZU3lGak53?=
 =?utf-8?B?aFBMb2J5Zy9iM2ZLekd4ZnI2RGh1ckZuNWxQL3QySXFEdXJYSnA4YWhvUHlG?=
 =?utf-8?B?NUxoRURSWWdmd2wwT1pHVVFIOUcyMkRyOG9ZOTl5VGxWZU9ucmp0VDBNVHFz?=
 =?utf-8?B?VXNwR2JUUE5tUmtaSTVIWHhyRGhLUzJ2VXoxUFFxMFVuZjdnUVFZOXVkKzRZ?=
 =?utf-8?B?WXE3Zmh1T2JkWFVYUU5IbmpPM0FpU0NOc09qRzNJWncvQjlFWm1QbjluektE?=
 =?utf-8?B?aEpmNkp1Q3lYbWttT0tRbHpFczA3OWt6WjkyekhlSnVtL0h1WUUyeFVnS0pw?=
 =?utf-8?B?VGE4bU1GQVJReDRjYWhVZytzSmJ3K3AzOGdodEN6MEd4V2tGTGhxeUt2YTZ0?=
 =?utf-8?B?a3p6clJzdGVkRThqVUREbXVQK1FUTE5Vc2dUTE1LbUlreUo2bFZFNGNSaXRK?=
 =?utf-8?B?amtWekpZWkFubVZwZ2FCZDl5aFJ6SWU2VGJKdVJUVzRnOEhacFJLck1wTmdr?=
 =?utf-8?B?MnpST0R2UGsvQjVOcy9YWjhCalU4cGlsdTdUN0RsNUFxazVzUmI4ZEtCS096?=
 =?utf-8?B?UUVMYlFQaldpRWMvamFxSENQQm92N3V1UFh3SU93dm1jdFpPY2MrclRFRUxM?=
 =?utf-8?B?dXA1ZjNRcW9GRVUyMjNRK1ViSGJzUEUyYU5MS1E3MWZxRHF4MG80aEtqc1JW?=
 =?utf-8?B?Q1RnQlFBbzEraDVuK2orMjE1VkFKNFBhWGVCbW5uVEQ5TkE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7dd7c9-8736-4758-b955-08d9671c4cf0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:29:09.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Vad8c2iWOiTrgEU9hncxkdTltd8fs9QMEbn0SOXg6IusduTN0hdN/BWW/xPjSr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/2021 9:47 PM, Felipe Balbi wrote:
> 
> "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com> writes:
> 
>> Hi
>> On 8/24/2021 1:49 PM, Felipe Balbi wrote:
>>> Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
>>>
>>>> For AMD platform there is a requirement to enable user space role
>>>> switch from host to device and device to host by means of running
>>>> following commands.
>>>>
>>>> HOST:   echo host > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>>>> DEVICE: echo device > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>>> A more important question that needs to be answered: why?
>>>
>> Our customer platform is not completely capable of OTG i.e with type C
>> controller it does not have PD to support role switching. Hence, they
>> have script which triggers the role switch based on ACPI/EC interrupt.
> 
> sounds like some generalized version of this text should be added to
> commit log.
> 
Sure i will resubmit this patch with this description should be ok?

Nehal
