Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE43654A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhDTIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:55:06 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:41248
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229749AbhDTIzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDTEczdJvbLx5L5mrb+jMizDcl5CUrWHtmmLuf9gFzhu5EfQorsv9VrSgXRekJsK4fRP+K0iZjSLNwN1Ny1EkWtKaZH693TRiCx/03XCWZQHuYX6xY0V7/sHa+7Yltqokp0Ru4Cz9Ig5LgfM0R3AYn2BEDG4O0GHqo/i87BY2KkyvACgKh0yIKoTw2HzefV8IRu0f17yAQQt8QUJQ0zBzwXzuQJX9pW+imL9oEx76uJlsu0xrjl1qipOziyWnhJhzvEeYZ7lUe/EkGCj0eCnCigc52mordOaGiqh33ecnzgIC7QMnkBTnkbkzCOUPszoSYKSARulpjhafo3dOUaR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ9fXCymCTc+15hlCDMbctpC/Ug8iDSoy6kXhCLOXTk=;
 b=D8rCw2HIKTvMS9IQC9MD86IcxmZvGaIuWTF6RDPHNwn5ZZWKg5+nA7Ke6S9CLJFE11THqOvMO5PHVAhJjfhGR7WqPV4UFGto7US861YDN50zD1XLJpwDNObiWR8y8MvTDSFrA8c6xVKMbN7mRR4rOkrx6EQuSFY6sT7uGOXEp8yH678abx47+P/Y1BKy3G1S5+FyMUeMDgw84EhkpEYzskA1kyrgTWXR99XgIUfABCh3ZTTIWAi90ksBnXJIhZs5ucqx33jC4eHIyukWdbNaall+FU7Nt/4OJ1hu94OznGfNtM6WwDymJbG8/5gyLOo0aF4R6hICBsc7uFBBaJ4X/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ9fXCymCTc+15hlCDMbctpC/Ug8iDSoy6kXhCLOXTk=;
 b=UwnO0Lc0l0Ma838UTQ3P0YCgs5Dp9TACewO0ISmJmmsywBq/2qBg/iTiLRPeZ7/JfdwEB9QF66KLOo9QlC9OCIwElrD8xU1Um4cdgPzFR1fAgJQMHq1RxYfIb49u8qxQp0UcL/3C/z7yO1NWpQCviHn0EVDz1UsUZIW135Ivh7g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by CO1PR11MB4785.namprd11.prod.outlook.com
 (2603:10b6:303:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 08:54:32 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:54:31 +0000
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, oleg@redhat.com,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com> <20210416133431.GA2303@C02TD0UTHF1T.local>
 <20210419121932.GA30004@willie-the-truck>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <1e13b428-1dbd-55ff-ed2f-5ac7f6562689@windriver.com>
Date:   Tue, 20 Apr 2021 16:54:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210419121932.GA30004@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK0PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d77676-1505-4d50-5e26-08d903d9e9cf
X-MS-TrafficTypeDiagnostic: CO1PR11MB4785:
X-Microsoft-Antispam-PRVS: <CO1PR11MB478535EEAF16734B3B52FE3C8F489@CO1PR11MB4785.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esFrorCydAl273KRx/58Hh6KbHYyIU5s0OauajPCSwmLWznVcdCxyDxgapVgtAZHzjVMLsO8istPH3VwqIg5gIjfoGTWr4hqzSy0eQBwkaXeUFwGNnxK8HB7Wpo6620EmHylPA5JaLOVosRfj8BMmNoOkiiWn40IiVyZfggHqUsoLTNbqD1oG1QBPMRuO9znGqgkEfLMbIqwN3XUvN+FAY731P3DlLlzaS//hFUb/jC6cvL9IIEr7WrUswlWdmF31McEMX4yQxekbpJkfl70pmzA7HWTKTFleir3st3m2y4urdZqc4S/UAyewbZjGn6A5BrqCxRQXC0VinCRavjV6EnCNleNp3TWq1eAfe3Uu9kS9KXXNui/pwcuGfTjVo9bKrkvBRAvLV93wi3HrihfUFKVD5FfUPTZ4FSJfaxD4IT+L1QgDfqxZPRSuTvsnOPte/8yvUZSO/IYSJZHCdzW2kKtR53ulAOM2yMDX4Hp/zsacwJEzB5423oiOLvKJZTTn7ron6oiSgI3fb6b5L9ACLZGKW3G1XSiw0jPLQxbTGDlz8qNoHrj8o1qzEb2MMyw4dRmmoV3Owqd5rKoaalmu3H86hptVwuZinU18vMHjNx+tRexZ95MiJk6DpGzvticneTftQtDwht9to41e34+lNGu+vyKUHoTn37rmDTR1BPx5nZ0YTKhSZg4NEtVHdKavbyruJrk0ABEwuOZYjvamA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(396003)(346002)(136003)(5660300002)(66946007)(38350700002)(186003)(38100700002)(8676002)(66476007)(31696002)(110136005)(316002)(66556008)(2906002)(36756003)(8936002)(16526019)(16576012)(86362001)(31686004)(6706004)(478600001)(2616005)(956004)(53546011)(6666004)(83380400001)(4326008)(52116002)(6486002)(26005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?THFlSExIVXhZNUcxUDBESHlLM28ya3Jta1FlVTJVOEZoTVBNSmw1WmRlK2tp?=
 =?utf-8?B?S2NKS2dpdTVxY2xDZTRZRVhCR1NnM2xOeUhTSTU0UU1vVW5ZdS9IaytZVWg2?=
 =?utf-8?B?a2xCeVZTRjF5QURUN0xsNHF5V2ZRbHJDZXczTjd4aFRvKytUak9jODEzTEow?=
 =?utf-8?B?TW41WjFTU0ZtaXFFditBRDNFeGVHYmh5TThRcDExeDdZejRoNkR0ejBDYkhL?=
 =?utf-8?B?V09sUkpMNjVYQjV4M1JTWW1nVEE2YWVZZWhYNkMwcW9CWStGVmdQdmVJZXBl?=
 =?utf-8?B?dDcwcG8rT254MVc3R0Y4N1owbGMveFJkdXM5RVBqNjlwMzV2SWowYW1wdTUz?=
 =?utf-8?B?UVRLMlBxcjFqOUNYVDZwb0xYNTY2ai9WcnF6YUd3RHM5aDk3QllySzVQTFE5?=
 =?utf-8?B?U0RqOE1VOEJrbmZHdG9ndEQyYVRCVDlQZ3NvSldTS25FZnQrL2FKNnpNbS9P?=
 =?utf-8?B?cmNycDRSTERWcVBMZHFoNm96MVZVZ2NYQ2RpYlFLKzBBRGRORTJ4YmhCbWo4?=
 =?utf-8?B?bWVla3JFeTducHBqbmpYNWN0WnhDeEI3aDZNZG5NWUFaeUZXdEJYZUFkVkJK?=
 =?utf-8?B?M3hTMmVib21nbllrK0xaT1AwOXkxRW9XcUZCQmlhY0FCMmhEdXhnNEhSZUV1?=
 =?utf-8?B?UEFtTXR4OTlxaldTMStWT3pUUmlZSEtpRXgvbnBLZE1YTjEvbmUrTVpmYVNM?=
 =?utf-8?B?WjVEZ2hWSkJ3Sk1jQlpDbjZoNTJUa3Q0eXVsanNvZ3BubEE4UXo0eWlEUExV?=
 =?utf-8?B?UDBNN1J0bk5HTVhPRjUybXRoWHpZUTJOb0QvNzR5dWpwS0g4YkdkM3lFYmdk?=
 =?utf-8?B?ZkEzdmJWb25FWGJNK1FyL0tlNDRadkgwYWNhcEptR2kyUG9MZnJOZ0Y5cE1P?=
 =?utf-8?B?dHY4cGxwdEZXSGdPbTJpYXJ6eGZuNk1DT0xDZzE0R3FRUVpjR0I1MWRlcVJN?=
 =?utf-8?B?Z2JtUmx0dytGUzRtajdWZDZpTXBid290cTY0eWh4VWluYS9sN3FSTXVDOVlB?=
 =?utf-8?B?aGNhSVFzZWxZdXNaa2ZJR1czbmhPK1hJaDhPdFhyc29qNWhjcURqWmNXUWpu?=
 =?utf-8?B?NkZISDdLWmtDNEViSTBBU2lsdGpIMjRCeE54WEIrQ1Q5blJzREh5L2RuakpH?=
 =?utf-8?B?am1oUUo0Qk0zM21HUC9YdmhDM0tlem1ic3p4bkhac2xua3FCaXYwN1huRkc4?=
 =?utf-8?B?cXpNN0J0ZGZqeTAxYzJJN2RWaFltWEtWSC81aGNLeERUWEhNQTZvYkFnK3l3?=
 =?utf-8?B?Y1hkQmxzTW1kTUcrVmEzbWRaY1dXd1R2UXFTSzVUbE5Gbkg2OEJXbE0yRS82?=
 =?utf-8?B?MGJHcHMzOUhsaXI5bkh3cW8rOXdFVVQwdUdHSi9JVmVwNU5IazFsTVcvb25O?=
 =?utf-8?B?S0ZiZWRjTkFTTFYzZ0FjYUg2SFRDWm5qT25jQjlYb2dRblpaRFliVURtUXhp?=
 =?utf-8?B?SHJPZ2tiSzJDWVVsdkF1Y1E2Wlp1S0xrdnZTSVNrbW9uL2F5MkZvQmE0SGJD?=
 =?utf-8?B?UkNjcDRudUxPOWErS2hSWFg2eWRKV3F4ZFlpNEFuc2ZVQW1xQ1ZtcUdZQVIy?=
 =?utf-8?B?ekxJQnhZRUQySC9GbGZ0Z1JxaUs4dkVnTFNCL0h0T1hnenp3Y1lTUllGbkNx?=
 =?utf-8?B?NlNBejdRbmdVa3dyaGZNVjR3MWUrV0xVeTJhb0NnVVlqYXVMKzRZcEFtL3Fn?=
 =?utf-8?B?RFpjSmI1VnUyd09NUTNBMkg1SFR3TkN5WDZCbldhTTg3bzd0SlpwSkNSUm04?=
 =?utf-8?Q?phLqUhcd44OeO0zsOns5E6bd20LpKYK1bL4egJk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d77676-1505-4d50-5e26-08d903d9e9cf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:54:31.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdqLZxJgiiDEEhugxKTZfpAiwTyNBXuThhUkywlACLHXUGNpL3l6DpKuA1+hW041Feuo7z1ZY2NmgB7IFcAyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/21 8:19 PM, Will Deacon wrote:
> On Fri, Apr 16, 2021 at 02:34:41PM +0100, Mark Rutland wrote:
>> On Fri, Apr 16, 2021 at 01:33:22PM +0100, Catalin Marinas wrote:
>>> On Fri, Apr 16, 2021 at 03:55:31PM +0800, He Zhe wrote:
>>>> The general version of is_syscall_success does not handle 32-bit
>>>> compatible case, which would cause 32-bit negative return code to be
>>>> recoganized as a positive number later and seen as a "success".
>>>>
>>>> Since is_compat_thread is defined in compat.h, implementing
>>>> is_syscall_success in ptrace.h would introduce build failure due to
>>>> recursive inclusion of some basic headers like mutex.h. We put the
>>>> implementation to ptrace.c
>>>>
>>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>>> ---
>>>>  arch/arm64/include/asm/ptrace.h |  3 +++
>>>>  arch/arm64/kernel/ptrace.c      | 10 ++++++++++
>>>>  2 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>>>> index e58bca832dff..3c415e9e5d85 100644
>>>> --- a/arch/arm64/include/asm/ptrace.h
>>>> +++ b/arch/arm64/include/asm/ptrace.h
>>>> @@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
>>>>  	regs->regs[0] = rc;
>>>>  }
>>>>  
>>>> +extern inline int is_syscall_success(struct pt_regs *regs);
>>>> +#define is_syscall_success(regs) is_syscall_success(regs)
>>>> +
>>>>  /**
>>>>   * regs_get_kernel_argument() - get Nth function argument in kernel
>>>>   * @regs:	pt_regs of that context
>>>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>>>> index 170f42fd6101..3266201f8c60 100644
>>>> --- a/arch/arm64/kernel/ptrace.c
>>>> +++ b/arch/arm64/kernel/ptrace.c
>>>> @@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
>>>>  	else
>>>>  		return valid_native_regs(regs);
>>>>  }
>>>> +
>>>> +inline int is_syscall_success(struct pt_regs *regs)
>>>> +{
>>>> +	unsigned long val = regs->regs[0];
>>>> +
>>>> +	if (is_compat_thread(task_thread_info(current)))
>>>> +		val = sign_extend64(val, 31);
>>>> +
>>>> +	return !IS_ERR_VALUE(val);
>>>> +}
>>> It's better to use compat_user_mode(regs) here instead of
>>> is_compat_thread(). It saves us from worrying whether regs are for the
>>> current context.
>>>
>>> I think we should change regs_return_value() instead. This function
>>> seems to be called from several other places and it has the same
>>> potential problems if called on compat pt_regs.
>> I think this is a problem we created for ourselves back in commit:
>>
>>   15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return)
>>
>> AFAICT, the perf regs samples are the only place this matters, since for
>> ptrace the compat regs are implicitly truncated to compat_ulong_t, and
>> audit expects the non-truncated return value. Other architectures don't
>> truncate here, so I think we're setting ourselves up for a game of
>> whack-a-mole to truncate and extend wherever we need to.
>>
>> Given that, I suspect it'd be better to do something like the below.
>>
>> Will, thoughts?
> I think perf is one example, but this is also visible to userspace via the
> native ptrace interface and I distinctly remember needing this for some
> versions of arm64 strace to work correctly when tracing compat tasks.
>
> So I do think that clearing the upper bits on the return path is the right
> approach, but it sounds like we need some more work to handle syscall(-1)
> and audit (what exactly is the problem here after these patches have been
> applied?)

IIUC, IS_ERR_VALUE could handle -1, did I miss something? Thanks.

Regards,
Zhe

>
> Will

