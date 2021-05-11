Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D33379D94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEKDUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:20:41 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:59443
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229736AbhEKDUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO8xQmC4TFaYH5CjfzkbGk6ejujf6u4LxXlO+gxjyttfVEk2M7eHEy1aDVpra5ASNV6BqU/f7/AAgk9nVKcvkaFQ+1ckWJThAmKaJna4PX+rG80IJmwnyLfeAaEFE4flhEA1Hy2OxZeU9ZI5Fq5CBjnb+odHcUbhw8bu0W8gJBeYcol/OAeL+83zyFST16Zs1VHIQATgxoldwU81LEFucM9JpD2k0azj1bvSvQzb1Wd94XyLHfWKf1puSlsUCRPpLCtVAzFWKhSnyJXyS+Xp59H+/3mOaHtSocpyBZRvWSqNxJi7GlA9T6yYXBVMXfYoeIOmgpndQe+/MBz8rZfeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn09UUEkWkY9EMWJioc6BNoSpap1fc2aLbPACepQi+o=;
 b=Xe+ln82PXXv6RhPrHpKn9NqOqsYbVpAzzx7a+VAGfQx6F4YJ0iOcR/i46LOPmhy//53Sz8t8GDD8YmfiPKEGMxwhKw2AfhL3ZHd0Ju552JR0D7GgLEWwfj0Ze9kfYGu52xHTpJAF6O0MF0pQSyRCefz7KtjkDMJihkVq/1IMAMt47OV/DMaR66YnWO8bBtIPiC/VGd96CFQvog5ukVoWgABL40c+p1UBMOArwjaZBPeTYG5AHJSr8koDLjPGAdrZNutXsg91sF+Dwk4blXmiykPkI1Nr/WleR3eoI/vro29ynUg8avrQp8Bs7KbntXmiqlXZ16f6KIjllwg1AmNwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn09UUEkWkY9EMWJioc6BNoSpap1fc2aLbPACepQi+o=;
 b=H1jlQHaf6xwWJqO3BC2WNPaWwtBrE0KTe+KF0ls5H7vUnUmGr5dN5gagjeCb7eEp4RnSsKtRBoNOQzExKhSSOEwP4PlT/PtgI2DXV6JyuRI/jcnKLRCv55FQ+qcDykCLHIlcOvP3HBGhx9NNnMT0SJ4azHbv9tndgAjteobmFpU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by CO1PR11MB4772.namprd11.prod.outlook.com
 (2603:10b6:303:97::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 03:19:29 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 03:19:29 +0000
Subject: Re: [PATCH v2 3/3] audit: Use syscall_get_return_value to get syscall
 return code in audit_syscall_exit
To:     Paul Moore <paul@paul-moore.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210423103533.30121-1-zhe.he@windriver.com>
 <20210423103533.30121-3-zhe.he@windriver.com>
 <CAHC9VhQXawubMsKg2F282k-bJqZFT=vNurZAeAPKLU1ZZpYKeg@mail.gmail.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <c8493e20-c7fc-67e4-f2cc-81601535f21a@windriver.com>
Date:   Tue, 11 May 2021 11:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHC9VhQXawubMsKg2F282k-bJqZFT=vNurZAeAPKLU1ZZpYKeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend Transport; Tue, 11 May 2021 03:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0725d13f-5b25-4160-ebe4-08d9142b96a1
X-MS-TrafficTypeDiagnostic: CO1PR11MB4772:
X-Microsoft-Antispam-PRVS: <CO1PR11MB47723D26D158D225C441CECD8F539@CO1PR11MB4772.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrboQVA0q1ci8W1M+TL1MDAWPRJBAJFTsHtM5xSNG870pWOxlNZvG+9pnNdO6UxKOlpICC/TEnXG5RbHwCE+XEco8M7LU3MIFEwr4viOIB6vcwmTkMTsW9Ow2UzfSqnI313yrQQd3CnFkoIXw5zUemlm/eXBJdy5i53gZMWC4zlPFbifzGVyXxeziNfzrhOHWVOjnwXBmDMP6fhWzKsKbaxsM+3CbZRv4ENyEnyafuVjPxJzG3LLa0Z6tlRDVKMM7s3t8+HtL9+8qBBks66g2oMVwzFEtMPeuYCdE+/4V23XKZEq4cYOV4MdczHXyWeFLbEjKB/PmcJxmgb5T2ivPDtfoJ/OYJOj7+cj41ArKrzn8P4Tl9tD0be1LU/Hh9EQciRJiV33CEW14SdQkPf+5oJs8u8KVN2ACT99rJzJhX5E1MkY82yhl7rWC9Lp7objnp5RHIuPN9nld6R+KA7+dQDtr1KMTxIOLmyZXVmjiGpYJQX8VnKYQsi5x9va355ODGf/V7fzyX1jTvM3WRkcr4wvD1Z20uYtpehZ4BCb/FFiAFcOItKAf/vtCyC4ngzv7jbTgKCNdKFK6OIxznkbAj4IPfTghLWXQXwPpEcniVomFAWH6gV9mpCe5ow1myqXVMUjsSazt+3SbhLJQ4RaUqcyhu6HqTZS4oYgGk1BxvYfvc5MB9IMkRc/RFeXQhpoJ0UUDMSSRY8PjUFQ6oQMjFouMnMf/8SLP4soWA7dCJ50PuF1DTm1xbLb+MmuncyXQ+vduSmufnP4yCXxEnUkuKE1GmZaXpHx+ELuRAUTvelBpHnMnyQoU6McofWE0u2S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(2616005)(66946007)(956004)(26005)(31686004)(4326008)(16576012)(478600001)(6666004)(316002)(8676002)(8936002)(6916009)(83380400001)(52116002)(6706004)(66556008)(53546011)(36756003)(966005)(66476007)(2906002)(86362001)(6486002)(38350700002)(38100700002)(5660300002)(31696002)(186003)(16526019)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0NYQ3lIdTFuYkQyTXRLU0JPT05LejZUNzd2a3lpMFRlVWZRbEdlTzUxMUJT?=
 =?utf-8?B?Yk1zTmVPRHVReUw5UWNPSWZNcnVodVJuTFZtWU51WlI5ZHBOMmE1NHNMcWxG?=
 =?utf-8?B?TmY2bHFXOXNPcHpmckI0U1hwSGVOMTlGeS9XdGVuSXVhM3QwcEsrVkR0TStF?=
 =?utf-8?B?N0hLYmdPQmdyUEFhTStBN3NnSnlVNXJLZDUwdUdFN1dNRnQxYUhZbmxiZktl?=
 =?utf-8?B?b0NvUHAvMHZJUVNqdWdwS1gvWGdycVVncTh1U1ZGTDl4d3hZSjNreDVrakxs?=
 =?utf-8?B?NXZoRDl4UEJxWTlRdmxHbE5zSFRGa2I0T1dMT1NmOW5CVS9paGpUaklCdUFj?=
 =?utf-8?B?aEsxbjc5OVhsUnhSb3M2WEI5QjhxVHFwUWZqa2FPT3Q4ZCt1MUJkNy91dmcz?=
 =?utf-8?B?MURhV2F5Q2pTN3orSkUyUVlOK3kyVERDMVhwMTIwV1d1eTMrTUNHeVMrMnlR?=
 =?utf-8?B?VUxKOHBsbXJrQmt0d2pFbmVvelZKUER6WWlnRlNXc0hkVDBYZzE3ZkJpSTFR?=
 =?utf-8?B?SmpBZVJBMFRKZFRCbDEyM1JmNVdPYnl2RGtsQ1RLTW1FVzlQOXRTUzJqOWZu?=
 =?utf-8?B?WXhtbXVjOGlqSWZwQm9Ja3lOVjBLL0g3anFnOHpheHVaYzdUZk84NURKeFZW?=
 =?utf-8?B?ZWEwT2ZpUWUzT2Qzc2RObWV2UzkrakwyNlFwelpUMHBNZ0kzZ3BFcjZtd2VH?=
 =?utf-8?B?N29vcmlzamhLSEtwQ1dacDBHTWJGaHRpTUdQd2Z1MWl0ME82TEF0QW9FbVpR?=
 =?utf-8?B?eHl1bU1ITGRscHMweHgra3BmSDkveE5UYit1TzdlWjFBbDIwemtjbDd5VlE2?=
 =?utf-8?B?U05wMzMycWs1SVN0ZEI5Y3M3ZjZ1Ny94cHBEa2JuQkhGaGo5V1JtL0hVKzZW?=
 =?utf-8?B?bTlsSGFDbEljZE9NdEF0YkMzeW92R2VtNDlZSjE3Rm9OK0NWcjNubE1BMmNN?=
 =?utf-8?B?K0xMQ2VkMDAwSW9jTnMyQmIxMSs5bWxraDFSem9vQm10Rzg3Sm5XRERhVTQ2?=
 =?utf-8?B?enhWVUJXOFVyK0JuYnNRM25MM2g4QjJhLyt1S1B2VUNUN29JWkkrYjBwUDgy?=
 =?utf-8?B?cHovR2tZdEZzYUxJeHZmaDRDOE9EYmdSN3Q4NTZTSnZlUVRzdjFocHBuWW5N?=
 =?utf-8?B?dnAzM2pEVGZYZ1RMVW9jS1Zmckh6M0tYdGRteEFhMCtXQkprOW1ab1RxYUVE?=
 =?utf-8?B?RXlPSDJhbGRmaGNVRmloMm9oYTN3ZGhHVU9kQkZFMXZpUklwSUhnN3RMV3Nt?=
 =?utf-8?B?dG93emI4M3lBR3dvcE9LVUIvVXM3a3FuWG5aMExlemt5bkoydzh1U1hManYx?=
 =?utf-8?B?ejR6Zkg5bTJ5KzFWeXdOQXVscmt5QUFJbDB6akhnWWM2V0VZUUlsa05LL1pQ?=
 =?utf-8?B?ZWJTUzhkN2JGT0xSYUFVcG1pTU15d29jOUtNOENTQ2V1YjUxZy9Ec2l3QlpH?=
 =?utf-8?B?TGE4TitLNFdSRTYwazZNSDE3bGxWbE9rNGhCWkEySnplaGVscGRRbE03cGc3?=
 =?utf-8?B?UUdVRWdHcWozUzQ1bERjUnlRS0FiZDlDNEp5OHJsZHowdy9pY0FqdE8wQkZs?=
 =?utf-8?B?UGc2RTgvREFLTHZ2b2FFQkJUTVl6MnpJdldUTDhGaW5KbUhCMlQ5c1dOVGk1?=
 =?utf-8?B?ZkowaXdMb1ZCZVU2VnpmdVptajdrUWNnU3ZrWjRXYzhVYnlhVWF6WDJ4aytN?=
 =?utf-8?B?eFFGclJ3RlFLTndGb0piSjdSd0UvTHNRMnpxcUxuaXV3R3QzbmxURXZPRTJm?=
 =?utf-8?Q?guHmxgl7slUfyfVj/AGBxRiqyr3ATcCFcWmTh1o?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0725d13f-5b25-4160-ebe4-08d9142b96a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 03:19:29.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRhSiEoghj6i6icqV1A3XpJSnSaeoLQAMmfVSPDCYV985OhEowoVrZvFDptToZwt1gragB5rgyUlUvc5YJ41Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 6:38 AM, Paul Moore wrote:
> On Fri, Apr 23, 2021 at 6:36 AM He Zhe <zhe.he@windriver.com> wrote:
>> regs_return_value for some architectures like arm64 simply retrieve
>> register value from pt_regs without sign extension in 32-bit compatible
>> case and cause audit to have false syscall return code. For example,
>> 32-bit -13 would be treated as 4294967283 below.
>>
>> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
>> success=yes exit=4294967283
>>
>> We just added proper sign extension in syscall_get_return_value which
>> should be used instead.
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>> v1 to v2: No change
>>
>>  include/linux/audit.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> Perhaps I missed it but did you address the compile error that was
> found by the kernel test robot?

I sent a patch adding syscall_get_return_value for alpha to fix this bot warning.
https://lore.kernel.org/lkml/20210426091629.45020-1-zhe.he@windriver.com/
which can be found in this mail thread.

>
> Regardless, one comment inline below ...
>
>> diff --git a/include/linux/audit.h b/include/linux/audit.h
>> index 82b7c1116a85..135adbe22c19 100644
>> --- a/include/linux/audit.h
>> +++ b/include/linux/audit.h
>> @@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
>>  {
>>         if (unlikely(audit_context())) {
>>                 int success = is_syscall_success(pt_regs);
> Since we are shifting to use syscall_get_return_value() below, would
> it also make sense to shift to using syscall_get_error() here instead
> of is_syscall_success()?

In [PATCH v2 1/3], is_syscall_success calls syscall_get_return_value to take
care of the sign extension issue. Keeping using is_syscall_success is to not
potentially changing other architectures' behavior.

Thanks,
Zhe

>
>> -               long return_code = regs_return_value(pt_regs);
>> +               long return_code = syscall_get_return_value(current, pt_regs);
>>
>>                 __audit_syscall_exit(success, return_code);
>>         }

