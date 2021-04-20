Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F90365462
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhDTIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:43:34 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:60129
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhDTIne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETo7w4upNJbTBoIse/BzgAbwdPQ0J/QRMkGdDtSwLdqhaT3RfqwukX3meWbFeq/3d+GlY5SdsagBHRzZFrl1DXrYMQKnIIJORDaQ2pyacCTj4FqbtvTB1/OodTn4pKyEeGAPFUao23VXXt9LXrqEtcAoztLmKJR7rXYPgvDUWpuLNiH3qSNmuhfrdgC3F7R+cwdhC15E0Nboh5T6+nRhTVbASCMkbEvSdUDsJn7+DLSXfJG69C6OHGIQ1gl3TF/FyouKhPI9MeiK1wXaXtkMvHISZ6UNrLZM5snzdtJOUavyhFNdjEOBxE+7zb19959U8BHw/8rdcrXbgXigfxJIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kqMc8XC4x8SdevsW1L+ueIpnjRcxOQb8RZL3eUtwfo=;
 b=apjoSF70bLdUyxCZItsStANdzuJ5fgh4k/07UHdkaiOjnPtNhCejpohbjHQ1C4cGp6DxLHUys2tTg9AJ0q7doCxLXOeupZ7bQusZ5I08Us7COrPWqgmlPoB0gcjSGvYNgOu8cIdbNT20WS0ehmHI/e6jJlWV2DC0o4kKPzRUo7kq+9Xbgf2ae3eVWm1TW0yqze1ttTc/wOYShRfQZ1pY2lGqf4kYW7clhR5KWkXERDO+mPIhWKo+MRkbl98DY+IsL/f2HdYs0NwjhIetHNVrwieojJi85AifrArVTTm4ZHH1juWndis9u6hUS9sn28Xt+qIafMEXCS7iv+zn6K7LhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kqMc8XC4x8SdevsW1L+ueIpnjRcxOQb8RZL3eUtwfo=;
 b=RBheptuMO3YJD0J1gEQKEuocXIRK5KEl1IQEuuQI5CG9K9KjL60sNORWGs43o3l8wdKR8NCFZinmOTl6sOikiMG+ThQTiyhcHfzQNs3TcFhNWmjh7IA56k7LGrYRfWYup91ANc2GWqMq+BAns1gJDx3pao9P2WUIpXqatFeaHQo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1534.namprd11.prod.outlook.com
 (2603:10b6:301:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 08:43:01 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:43:01 +0000
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     oleg@redhat.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <9b5b340b-66ad-41c9-865e-32724e33a5b8@windriver.com>
Date:   Tue, 20 Apr 2021 16:42:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210416123322.GA23184@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0140.apcprd02.prod.outlook.com (2603:1096:202:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:42:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d969856-4959-4d01-81b8-08d903d84e64
X-MS-TrafficTypeDiagnostic: MWHPR11MB1534:
X-Microsoft-Antispam-PRVS: <MWHPR11MB153456BDD9E5A87D292B60528F489@MWHPR11MB1534.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etz2FHCbF0LKv8XF9PjlDW5mESVF5SMxwvsh6dIuUNxhdwJqfoHP4pG6EwTVIiZVC6lMgMgfJ8K7ZWsGCsC8Z6nMMb1QQMH3dvHaAzffMqCJIoFf6S+bY7EMEPIwpoLyAE5CXBXp86AyV1b9Fml8aisR0OyAiCNVGEAj3oL25g2fNTbBVElmCHRFqi8wi7uJnCVGMNYC0Tlqk6Lsyeh1AqvzzNItviNW/1r3y0G6U0lgjg9TQGl5sKh8dfgMoIDnTDTwqw5gaRH55y4QLTYHLmg5ZMhucmUcHci/b6HDtMYy7QOpxGqi0TvDH51ZZKvZwvMC7EndfQU5YozhuqC+9tAw3BTRphPlpynCzrY8Mde804E7TKimEv+6+LZVBEP8TVlv7QagNipmruMrPruzwemmnZNmUNRnWtgJxxock4lJpzV6OL5K+h0nbr5fpgq5vCJEvB0Nwq0gDD5mhjKsC8GU/jAHmBoJoHaVnyl2fdFmWYwJJ24WWSRgBa/GTQZUmSQJWMfQxhxjNhZz3GtkTRzoWnArIfrAM2i9HQJfbM1oYndgLq10xVv/RpJFxCjwr0rsr2HtghyFSL0RL40HapgxYZ9t3PBPMaPc/KxIK5bGWqjbyIZbu+QzoVAxTSVBVRCHJ33ruEQl3QNW4JT+tlDhRlFTsnTkwu0FlHeQBEacapQBvn55b4i8647nRkEPzBoP2dYIDyo/ucwRqafOuJuUITFul4W+NIKKMeNAw7NsmDeLlKRxxj5aUU8P4aVW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(86362001)(31696002)(38350700002)(66556008)(6706004)(53546011)(6666004)(36756003)(2906002)(6916009)(83380400001)(5660300002)(38100700002)(31686004)(8676002)(66946007)(478600001)(4326008)(186003)(8936002)(956004)(316002)(2616005)(16576012)(16526019)(26005)(6486002)(66476007)(52116002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eDgzZ2lLcndsNll1WnBkQm5aMTRmdW5qa1Jrc3F5MFJHRkJwR0ZoNTllRWlX?=
 =?utf-8?B?T0ZiWVUwQWJlYlp4L1NkTk9tZ2c5SHlpZ1FqNVZDQmpmQ1B6b0RVTFB5b3Mr?=
 =?utf-8?B?K1hvaGZ1S002WGptUERxUXlwWVNJdTVsbzlqZTRvWHdzUkxYVHdmN1Nla0JZ?=
 =?utf-8?B?dDNOcXFjVnE3WWV1ZXprcHlxVkhVN3Y1aGFGaFdDZTI5cG41THRDZmZUTVV5?=
 =?utf-8?B?cHlLUXBHZHVKaElHdjMzMWJNY081Yk5GVm9Mc3dtUmx2UnhPbGhzZGdTNFdF?=
 =?utf-8?B?WFpyME5WY0ZsQ1dLRFlQVzlZOFhtSk1EcXNLRUJaQnkzRC9jK0Z2UEYrelpF?=
 =?utf-8?B?aXo5MDNteVdpR0VxUlo1ZXFEajRUNGN2SDc0U2E4QnE1bGxJNVFaS0tkanBR?=
 =?utf-8?B?VnhHY2s2L0tPTkd4YmNmNnNwYy9UUXJ0dUVRNVc0UTVtYkYzYXlTcW9iV1Zt?=
 =?utf-8?B?TkdCVGIwTTBVaUNjT2tHWUJickM3RlIwSjdLbFI2RUxWRE1qTGc1UUtVOFQr?=
 =?utf-8?B?N3pGMy9QZDRUVVZTaEIzQmYzeEVEMndhbzhFLzZ1TzBTTzlwM2w0NzVHNHpu?=
 =?utf-8?B?Y0wrQUdVNC9zN3FjNXZoTWYvQWFVR2RYRzc0R2s0bVVub3NWSWN6cFVpYmVL?=
 =?utf-8?B?U1huTm5UU3Zzb3EzbzFkL0lqcVJzNzd3L1pWczZjbFUvSFArZWp2cHYwdjAr?=
 =?utf-8?B?OHFCbXJOd0JoclI3bjhTbHRSM0d1ZDlGbUYvVVpBSG1rWEJLNEttVnFMRVF5?=
 =?utf-8?B?eTFRR2R5M2ZpSTFSb0o0TGxHb3FRNndsUkpJMlUzdWdnRnczN0JuMnJwNkdD?=
 =?utf-8?B?bGFvV0NvVWtIZjJ4azBsV3N2cmNjUVcxNG9Vb1NVUVpibUNFWVpMb3dYMkFv?=
 =?utf-8?B?c3hnQlY4NXVSYm5Td0VYWjBCSUNMODlVbXJwNGNYaEVZSEVxNklkNGpNSFlh?=
 =?utf-8?B?bWdoZ1ZvWklhRUdCOTNVbms1Z281aFhVa1FFaVFhSXFWaUd2QXZtdTZxRnhZ?=
 =?utf-8?B?bVVCQUlOKzRZVU1ZaWJpeU11MTFlZG1EWkh1c2FzelJXRUd1Ylp6eTNhN3lZ?=
 =?utf-8?B?S09acjhFNVFpYjZsUmJjcUFoWVQ4a1dpc2ZoamZWWjY0RElUK21PWldYMS8y?=
 =?utf-8?B?dmQvSlBrNm91Rjk3THRBNE5MRUtQc2dKVVd4Z2FRVFpTdGdyRm1kTk5mSGNi?=
 =?utf-8?B?b2J1NWc3cTArM2tOQkQrME0weGpESCtJVzBBL1oyVmZPQStZU3N6ck9yNnNL?=
 =?utf-8?B?cjk0K1JZOVlUdS9WQ3VleU0xKzNIeWpvUFc3ODF2ZXhiNCszdkUwQlhQcS9G?=
 =?utf-8?B?aWUzMFludXA3UUxGam03dHZ1U3FGN0VSM0NiRXc2bzF1ZG1HRGFXSHFrUW9j?=
 =?utf-8?B?eUV3TUNWUWNTeGhES0xrSEcrZFdlVGV2aG80YVU4Rmt4QkNLbVUrYldUOUwx?=
 =?utf-8?B?QWwvMjBZSFowdTQzMXQySXNuYk5GVXRBalpjYUdmYitVMEhUMlZyUTBXaEoz?=
 =?utf-8?B?dTRRL3lqL2djSm90OHZFYmhFOVZ0c05zZnNKbHdOR0t6RG5TVmN4MXhrcEk5?=
 =?utf-8?B?QnZiQllsYnNwRjREUkxmUnFCam1rQ0pvZzdySWdMVC9vQUFXZjFEUmZqNWtG?=
 =?utf-8?B?eFcxUnZIRjU0c3Q2N1ZwU1N6NjE5aWZ2YU45NVgyWnRFaDJhUVFjaHJMYkd2?=
 =?utf-8?B?N2YyNTNwODFUMEEvRGMzSElucmYvWHFTOGVmd0JsNjdMYVJ5NWtpZDhNRk1K?=
 =?utf-8?Q?V3gtxbZQRIAfc9F15d4pHpWbDndnLbJM9b6u3Ag?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d969856-4959-4d01-81b8-08d903d84e64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:43:01.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbK8izOq5ULYEx+5sR75RnS1mhAWn/NkhCDw+9nWbnsDXGXr/RtsmxgaZLVT4u92c/rwp/uQ77zJOcxY5h/Log==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/21 8:33 PM, Catalin Marinas wrote:
> On Fri, Apr 16, 2021 at 03:55:31PM +0800, He Zhe wrote:
>> The general version of is_syscall_success does not handle 32-bit
>> compatible case, which would cause 32-bit negative return code to be
>> recoganized as a positive number later and seen as a "success".
>>
>> Since is_compat_thread is defined in compat.h, implementing
>> is_syscall_success in ptrace.h would introduce build failure due to
>> recursive inclusion of some basic headers like mutex.h. We put the
>> implementation to ptrace.c
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  arch/arm64/include/asm/ptrace.h |  3 +++
>>  arch/arm64/kernel/ptrace.c      | 10 ++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index e58bca832dff..3c415e9e5d85 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
>>  	regs->regs[0] = rc;
>>  }
>>  
>> +extern inline int is_syscall_success(struct pt_regs *regs);
>> +#define is_syscall_success(regs) is_syscall_success(regs)
>> +
>>  /**
>>   * regs_get_kernel_argument() - get Nth function argument in kernel
>>   * @regs:	pt_regs of that context
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 170f42fd6101..3266201f8c60 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
>>  	else
>>  		return valid_native_regs(regs);
>>  }
>> +
>> +inline int is_syscall_success(struct pt_regs *regs)
>> +{
>> +	unsigned long val = regs->regs[0];
>> +
>> +	if (is_compat_thread(task_thread_info(current)))
>> +		val = sign_extend64(val, 31);
>> +
>> +	return !IS_ERR_VALUE(val);
>> +}
> It's better to use compat_user_mode(regs) here instead of
> is_compat_thread(). It saves us from worrying whether regs are for the
> current context.

Thanks. I'll use this for v2.

>
> I think we should change regs_return_value() instead. This function
> seems to be called from several other places and it has the same
> potential problems if called on compat pt_regs.

IMHO, now that we have had specific function, syscall_get_return_value, to get
syscall return code, we might as well use it. regs_return_value may be left for
where we want internal return code. I found such places below and haven't found
other places that syscall sign extension is concerned about.

kernel/test_kprobes.c
kernel/trace/trace_kprobe.c
samples/kprobes/kretprobe_example.c


Regards,
Zhe

>

