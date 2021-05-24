Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668638DFE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEXDbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:31:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60866 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhEXDbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:31:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14O3TXbg064056;
        Mon, 24 May 2021 03:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MKUiFAifY/VMoAjmxc8VECBOfQJveMVL1GFqvagWOww=;
 b=KYxJ+y/g1MMKAQmdIhSeyyhLEYZxm6S+xCdq1fyQnYrFHn8QYAEeEM9gdmmH68J+2yTS
 iookR0dZOZnkGlpR73IWS9tOjiznIA897k14wKXfJQMfyFdmsTrzfw6mX9+f5aKeaK3b
 GU6IyhyLcx5ZGIHM5gchysHGyXx6UUwe92ENi0CEWJ+YCpLjFyMyFleT8vrL4QRMTw5V
 kbzrURQ9g9ZB414JIF/MAhn4YBHHaKO0UDo4Xox635zo+F1bKzSLpm3GimrN3XYjSGbk
 /WShKRz42GBGdNeC6Gt+Tr3NZ13ITwHk+mQ2FDCl/dt2EwLlPstvPyq3L+4B9ApPB2Wy Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38pqfc9u6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 03:29:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14O3AxN5180245;
        Mon, 24 May 2021 03:29:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 38pq2sx6mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 03:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKb2RjxIyjrc2PQ0w3qvPm8ESi9G0JRuFcAemU/D8RiOEobesJEXHuVRJvO6OjnaJLnuOlHFOlCHBqwSPqEdaxHfkdfg+n47SbC0czLBt3Vii0iEWA9n+gM8pdSvw83I9ZRFC0p5TFt6/Qb3ym/SqXE7vVJDr31l+5pGHmBamUnLlLnp3g1RzNE3U1DCU87Fns8k4AzmmZlN+kCSerAZQSaqIAxUg9ED7VKFGbIT+774JRJ30dxzMcD4O5QpYaQio3itXywyF4OVoGDAuKjRTuhIFSyb/NCVFh2nvgGrcELIjB9bsjvA2r0FwTNBJ7tjk+sy9T+QgpkqnwZ9A9D3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKUiFAifY/VMoAjmxc8VECBOfQJveMVL1GFqvagWOww=;
 b=aFMwbGiT02vW3vh9yaxOvi42lU+GhcMsB0JvHqtuFSzv1F8tdK/BdZAg6/kPuHFBheexRy7giD1sQaf88wZBV2G0QT4r0CzyMe/leHAMI2GyKfhTtlQIbiEgPxsZHMOF4wp0eyS7MMxoQhoYwi8dV787m1lxVOGbkff4lWT4JdHnzSWoX+Y3LtOg8T2bSZDLqVjMUJvll6uPZ7eE0Q/0TcqTk3wwqGqzuorBdHBkcbDCroWCx/Lxwq0KcIm+V9kDgDr6A3QDEhsa8x5yzc0uIDiCAdIl/zUYnF+cCqAqsUrhxP0MjhKNer1m8GJnHo6O9DxNWfxm1me3ryyyySDaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKUiFAifY/VMoAjmxc8VECBOfQJveMVL1GFqvagWOww=;
 b=jU/AFflCs3oQoV7ObclFu13SGRNXglSMXLec7c+wWFDCaWi+EFkCoImjYttGF2CbMvEBGTas5Ou3GjbisLT30Fgu/epRLMOEg1DlDng6AMuOtI5hqS4XbynwsjjEnIhGaq6J2plaN7qkycYzonSEEf3ZKfeMx0De7b30jCLph9w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1949.namprd10.prod.outlook.com (2603:10b6:300:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 24 May
 2021 03:29:29 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::9813:f794:8bbc:5752]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::9813:f794:8bbc:5752%2]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 03:29:29 +0000
Subject: Re: [RFC PATCH] x86/apic: Fix BUG due to multiple allocation of
 legacy vectors.
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210519233928.2157496-1-imran.f.khan@oracle.com>
 <8735uhddjw.ffs@nanos.tec.linutronix.de>
From:   imran.f.khan@oracle.com
Message-ID: <8e1b9002-aa2c-5314-54f6-d5156703e25d@oracle.com>
Date:   Mon, 24 May 2021 13:29:22 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <8735uhddjw.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [1.129.227.205]
X-ClientProxiedBy: SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.20.10.12] (1.129.227.205) by SN6PR2101CA0010.namprd21.prod.outlook.com (2603:10b6:805:106::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.2 via Frontend Transport; Mon, 24 May 2021 03:29:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c869dd40-7359-4721-2c3f-08d91e642383
X-MS-TrafficTypeDiagnostic: MWHPR10MB1949:
X-Microsoft-Antispam-PRVS: <MWHPR10MB19498E311BAC5836A294947EB0269@MWHPR10MB1949.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNn3RvSkA4oBnEZhihImUyFzZS4P53jcceq+xadVpNF3n5HZOR56ZMgHjNjcAxePOz1yJyJI/R5nx9o0H+STyIJmPYwLXNmDfx0NkBJchbrx21GDh9K4wPYVIymYHF5U4m4K4ArmfiLhJNdoYkn8fbKfarG0DF/FJEpprWA3QWjEUd+EWnW9XW2+WPN2rAz/k0v96GcTasyZigDUQw3TRhmR5H9ESigWvgNA92SvQ/Wb9/ZDI829/7JAk4c1p9EBxpqwMRJ4PUSPMJvFrCAk6mhTHrZvzQL/s1QxlCYj3dXojK/BZuVly/cPYpas3uYYjKhM5C4amkJPxjBkrJO3EocZM6u3kJwLHsFh/HySB7JUO85VtgpDIX4QeXjkx1zRjM3NcPC7IW+jDltblc0shf5d7B43aVM1n2CKCCtAylZqrE3CiXv9XML5t+Du7k7Q87VIS1I4G/hJ2FK8yWya6P1+D+8YDJekf0O5Or/KR+sEzQ5zHnd+SuhZgI8PNBT5vMcjl9Pq1GcPxSKoKWMZ169kOebdnRGsd1eOQspkusa7+6DxTozCMB04Cue+tthLP038xZdOJFP8UHvPMVhWZ4fOcEkOuxZZWJAZ3F/VBSDK8jF8HTkkm8Eyjyd5vCtmb+TrBD7SXZIczxPMQvKJmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(66946007)(66556008)(6486002)(38100700002)(83380400001)(2616005)(186003)(31696002)(66476007)(316002)(9686003)(16526019)(956004)(8676002)(16576012)(8936002)(478600001)(36756003)(5660300002)(26005)(31686004)(2906002)(86362001)(53546011)(4326008)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVBqN1BIZlU0MVBIUWNYZEZXZDdqZndkQXFMSnJKNSs5a1c1Nk5mSi9YSnlO?=
 =?utf-8?B?WUpXZCtxMUNyWis3MFFoczFkVGNyNUpVTzNtQWxlTXlEcVN3azQ4K2xndGJz?=
 =?utf-8?B?cVQwNWxaY2ZSNFF1K2NRQWNPSXF0VEVhL0NQbUJVeksrMGRBQU0zTVArek1F?=
 =?utf-8?B?REkyTXVwRDlPeklTTk0rSlNFQ2oxTmdRUjhSS1ozY0hDN2dkUHhoUlBCbk1D?=
 =?utf-8?B?dS9jQ25GdTZtZVNRMjhhQ0VtZWcrS2pLNnpveW5kWDVjZjNOeHlEUWw4OENN?=
 =?utf-8?B?RHUwWFYxcnZvUDFMUGJaU1poc2x0Z25XZllubklSN1RPaXIrQnE5L1lsKzAx?=
 =?utf-8?B?R0owT3N6ZWJhT2FUMHk2TEQvNjBaemFwczh5QnI3dXoySzVpNHBQdlArdlVh?=
 =?utf-8?B?SmtaVWJKd0dHV2xZcy9JT29zaVo2QlVtcEYxd2FHVXhrVE0zcjljY1JQRlJy?=
 =?utf-8?B?QjI0Q01hYjd2UVlpV1ErZ2FXV2lPSVBwa290cU52RlZpekdqNkRvd2wva2pH?=
 =?utf-8?B?bUs0dW1vQ0dDRGVQaERNUFRmOG1OTU1VQ3NBbmxlVlB5NnB5Rkhka0NBaW9P?=
 =?utf-8?B?Rk1BTkhYVHlUNlRVc2JJTXNZQVVwWFNQKzluNVpsYU92VkFVYjF6NEpCMXhG?=
 =?utf-8?B?Y0Qrc2tMdkpxTHI2VmZLL1c0Wk9JZks1bkRVNWN0SEM3c3JFMWY5L0ZIOXBI?=
 =?utf-8?B?NGhBV0ViSkprdUFzR0tMWFY1VW1oTW9WUUpvMVU0amJndC9IaXJoNVdaRFBR?=
 =?utf-8?B?c3drV0VjVnpwZE1Jc1cySytic0FtZFBHK1g0NlZFWDlNUFpLZGlqMWFnZmZi?=
 =?utf-8?B?ek95UHlubzNTUWpjOTlzVTFod0FpdWorZFVsOWdJRlF2NndlWnY2THVPRitW?=
 =?utf-8?B?NVJEL3grY3pTaGp3aG1jNTg2SE1KR1NGTWN2QmdsT3ZlakFLTXJmcWh4QXVR?=
 =?utf-8?B?ZmNmdmJ0WnNkY1UvS1B1TGlTSUc0TFExK01PbjNYcnZ5TlFKazgwcjNmVTNv?=
 =?utf-8?B?THp4VmJFR2F5Uk5GWTNRemI3RVlmVG45dmhnNndaZnFLZFFuaHdaSXdBMVZo?=
 =?utf-8?B?SE4rSkt1UThLVGZVczgyc2MrQVdFd0RRdkNwejRoRlZ1aUQ2ajlJSEU5VGQw?=
 =?utf-8?B?RWZQQ1RxRjROZXc2bEFLQzlDN3lNVVh3NXY0WkVDdHBCakRRNTBpNkc5ZHhj?=
 =?utf-8?B?M29lRVp6QVVQbCsybVV2S1NPUmY1MGowbk9vWXdGdUJmMGc0M2xKTmlYem5H?=
 =?utf-8?B?WHQ2NFFIMGpaVnNhRmU0ZUdBUER0R09EekY3Qi9WaVE5RzFVNWU1Y0FyVGc2?=
 =?utf-8?B?THcvL2dqVTV5L0M0MElaaXdsSGJOcXJIeEoyaXhmSzdueXhydUtuU211aHVu?=
 =?utf-8?B?cVkzREh1UGRvK0k3aWtYVHpOanhZN2pVTHlESThqOVpJTFpjUUlzZHA1VlVT?=
 =?utf-8?B?eUl6RFlCRWJZbE1jUnBvZHVxaWQwVXB0cEZ1aGdhazl0VGhHeFF3cERwUHh4?=
 =?utf-8?B?WWpobnNuK3lJTzhwRWdEZU9zdUIrOHYyYTdXWlNOam9wenFXR2F3VXVFbWJh?=
 =?utf-8?B?V09PWE03SnplSHZvWHBYRGFNVm5weGgzMk5xWFptSHA5S1E0NEZOYkkycXFa?=
 =?utf-8?B?d2owSTMxMjdkNS9sNENVNk93enhuWU1mbWdXbzNxVTFNdUlzZ2p6eldQa01y?=
 =?utf-8?B?V3ZXRitKRmJZQUpvdFpGS3lMTXZCNGxTQ1RFVlZEUXVYSnl2VVVEd2tVL2hY?=
 =?utf-8?Q?JrumM16T0BqX0kwPmo2BpHL8wcopagQfIs/KymV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c869dd40-7359-4721-2c3f-08d91e642383
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 03:29:29.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYiTIWcXZERD0SFImjwq0QqSpJnMPECxsaUKe67PgtdmU3mg+jytzaWyqFfntX3rj5KeLdaYVEfYZ9cZP0fQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1949
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=956 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240023
X-Proofpoint-ORIG-GUID: TI3O1bSye1Rejoxh-w2vQrPLwGf1Ys-c
X-Proofpoint-GUID: TI3O1bSye1Rejoxh-w2vQrPLwGf1Ys-c
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/5/21 6:17 pm, Thomas Gleixner wrote:
> Imran,

Hi Thomas,
Thanks for the review.
> 
> On Wed, May 19 2021 at 23:39, Imran Khan wrote:
[...]
>>
>> [  154.738226] kernel BUG at arch/x86/kernel/apic/vector.c:172!
> 
> please trim the backtrace. It's not really relevant for understanding
> the problem.
> 

Noted.

>> This patch marks these legacy vectors as assigned in irq_matrix
> 
> git grep 'This patch' Documentation/process/
> 

Noted.
>> so that corresponding bits in percpu bitmaps get set and these
>> legacy vectors don't get reallocted.
> 
> This is just wrong.
> 
> True legacy interrupts (PIC delivery) are marked as system vectors. See
> lapic_assign_legacy_vector(). That prevents them from being allocated.
> 

Taking current ML tag v5.13-rc2, I can see lapic_assign_legacy_vector 
getting invoked only for vector 2 (PIC_CASCADE_IR).
I do see that lapic_assign_system_vectors is assigning legacy 
interrupts, but this is invoked only for boot CPU from native_init_IRQ.

>> [  154.858092] CPU: 22 PID: 3569 Comm: ifup-eth Not tainted 5.8.0-20200716.x86_64 #1
> 
> I have no idea what this 5.8.0-magic-date kernel is.
> 
> Have you verified that this problem exists with upstream?
> 

I have not yet tested current mainline tag (v5.13-rc2)
on this setup because of some pending porting stuff.

But I tested ML v5.13-rc2 on qemu based x86_64 setup (4 CPUs) and
observed some difference in system vector assignments depending
on whether kernel is booted with or without noapic option.

If kernel is booted with option noapic, the io_apic_irqs
bitmap is not set by setup_IO_APIC and this happens because 
skip_ioapic_setup is found as set in this case. But in absence
of noapic kernel parameters, io_apic_irqs bitmap gets set by setup_IO_APIC.

Now in case of booting with noapic option, the check "test_bit(isairq, 
&io_apic_irqs))" in __setup_vector_irq will fail for system vectors
and __setup_vector_irq will end up returning corresponding irq descriptor.
This irq descriptor gets assigned in per cpu vector_irq corresponding
to secondary CPUs.

But the corresponding bitmap in irq_matrix still remains unset,
because invocation of lapic_assign_system_vectors via native_init_IRQ 
happens only for boot CPU.

As a result of this if any of these vectors get allocated for secondary 
CPUs kernel will hit the BUG condition given in apic_update_vector.

Even my current setup that was crashing with in-house 5.4 and 5.8 
kernels, boots fine if I boot it with noapic option removed from kernel 
boot parameters.

So even though I have not yet tested current ML tag on my test setup, It
looks to me that cause of my problem is there in current ML tag as well
and gets manifested when kernel is booted with noapic option.

Please let me know if I am missing something. If you need additional
data (vector traces, debugfs content for VECTOR domain etc.) from my 
qemu based experiment, I can provide that as well.

Thanks,
Imran

> Thanks,
> 
>          tglx
> 
