Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCF36B071
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhDZJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:22:22 -0400
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:49792
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232364AbhDZJWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlTZ7yi4QbwZLNJVWs9r0+tN0aF2n8Z+FCAEHn/ueZ1umroMAxehPWQ4KBS4DFFIMug2pARTPEkPnn/y0FVB/gChz54+ZcNJOnyEAP1G2pxyUQNEwG/ogWSLXRLUhACXHg9KCZcJq256GPs0l+2ZeK1rHSL1yZXNktx6dYyrfF1dP9pWcbBiTBSu65YK4Ahu9VkMsu/lntaRGCoYZAWjbaofOmfKDdq8Pjwz81tv7BOG4hmGviBdXhPegcrMRAdt3AGPTqqL0T0Jw2cDgYdMchfyirKZziEoQ6wfOPCcuP0ENIrVsjrf3H3JQGOVHMMV6NiYzBRhp/rQLgDuE0eV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJkXbQ1WQ7mBCrgxjaqNVe4r1ks4dGd/D6n9OTywAoc=;
 b=FEJT38tZZlsdoQ0G8I/sTTkC4Y4NooZ7mnqskrQ1iFp3PXx+UWB1eWOUlrviQXyDpaveQqCAgWencF6bPcdiPzuiYaRJs7nsJydDzEYwNLBQmLLvCsA52ZNJhxnlWdYMLr9gXf9g1Vo3wjKdLFjLdcPdscyCkX+qEcST5t9MNh4xfIdF78DzpYL9me85hQ/t+4iDzvD2mxIEGNpfHvowXSFINWdW2y6ElMUwkp2fOFBO8B5tqv3pAdUX72b/XVK3G9+7GO7Jy4UoEEcYFiudE8PJk8KqEcCyzIywScV+bk+sWYdKOK+W5mqJ7zETiLGFdBJYf5vzVl3OZuClDp0bRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJkXbQ1WQ7mBCrgxjaqNVe4r1ks4dGd/D6n9OTywAoc=;
 b=iMssWuxxw0Iy7bc4+Lg3MhmX4O9GpVIPd0WqbKhCtxCH7DlZvWktOJo6MC4DbZXjFY6b2RHH964HyK4NIMHTReymAmuNw2S255gx1au5pQB/ra5OvFBThK3EVcNBdqYuGKRxDAgxM1IZC9za0ueIi/to1kBZu368wNbJ3ekEqVs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1631.namprd11.prod.outlook.com
 (2603:10b6:301:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 09:21:38 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 09:21:38 +0000
Subject: Re: [PATCH] alpha: Add syscall_get_return_value()
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210423103533.30121-3-zhe.he@windriver.com>
 <20210426091629.45020-1-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <255b68e5-e90e-26a9-fadd-6c8fd6fa3db5@windriver.com>
Date:   Mon, 26 Apr 2021 17:21:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210426091629.45020-1-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0165.apcprd02.prod.outlook.com (2603:1096:201:1f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 09:21:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6a57e9b-3b91-48c4-d9c4-08d90894b190
X-MS-TrafficTypeDiagnostic: MWHPR11MB1631:
X-Microsoft-Antispam-PRVS: <MWHPR11MB1631CF451DE25D6D69AC62428F429@MWHPR11MB1631.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac67/DIJQ2AKRlJT1Lv2d45qf/a4aovjrl83UQoo/wEoRK6P6PShjjbGL8+2aJ3SQePQQjY+mY5A9oOS/WkmaG9bG0l2LC9WhgSXPU21S8al42RtbEjl70q1s8w+KT/fWy4EiSZ1bAzXulR8Hrc811x4muiDx/SLvYORZhxm/7RQucHnpKVsf+n6hm+ZbidBdYbMVCpARj8mzNZOKjPcvijwuqjZ7lpgf6tCXN3p9upqOTKLJNj8LURI5Uhf4A7Ap+dqB54DgOqvVT8W9EwoCr1eQJm2xvUUbFcSxug1pAOEMDpsADAqFd3e/+zX4eBWVER+e1cPLhUIh9YcF/6as81bahkmjGbwsU58TCWAMAGzRDwcrlFGFlh8akhWcLZi79WgErcz3+gwqszmRkXqYyLmybocUcmzqPiyRqdlE34b6ziJfJkL1V7ZtLKeT7bwV/vmOxWXYT5di/3Eu9cCAMVkkIi7ejxSCTnCLrCz5S+euDLil3B+UvdMP+h/RztYGueqh/cOWNvTpZdj6pl+3tDVxMqC9Nvu5u8hcZXma97qW1B4qMpHBlQghTzq0IzIsDrMBnmDimAyQgPYby/+GDQt1Q/jxE0kSnqsezU1jDSBgyY33BR2NFNL8jlcDRLIX0NlbhYY/nEYrlaaXbO78IAEpr/C7UwtrS4A09eK3hpCe2TYitbn5ODgnUYe+52AXxVCsq369v4nmM62tAz7OOd55nGnoIOVur5VlE/RNmFMYfuJM8Rsehwh0ULZMdBUJ09R7qajTDBlgsoTmFtUJgtc4hJcYhyY3ymQOz8EuWkIPx1Qgra2XG/EKVy8hu7/un6gyVO067Qzuj+MbDMbbIy7sVEzlK51mzrZyOKHqD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39840400004)(366004)(316002)(186003)(956004)(6706004)(26005)(5660300002)(16526019)(2616005)(8936002)(7416002)(66556008)(66476007)(6666004)(6486002)(478600001)(66946007)(2906002)(31696002)(966005)(4744005)(16576012)(921005)(36756003)(38350700002)(31686004)(38100700002)(52116002)(8676002)(86362001)(53546011)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1Y5T2FZNlRTeHVEYlN5UXFyTVRKa3JOU082YUswOHhJa2F1UXFGQnA1Ukwy?=
 =?utf-8?B?bUlEMlc0Rmt6WDNwMFd0cnpjci9kWUZmTmQzTFM1aDVaSnpwQ2thZVRLdGNT?=
 =?utf-8?B?S2F1MVd1RDV2RWc1V3hJV3llVjF2TGsrcjlNdmlSVVE1QnR0YzY4NHVRUHh3?=
 =?utf-8?B?UDFZUFlLQU1TUUNjVWpSanllMFdEWHVrcVJVdjJhaW84QXFTd1JBL3hEMEJZ?=
 =?utf-8?B?cjJEU0x4NkJmQitIdXpyS1RxU2JZL0sxL1ZPalVFSm95OTcxZEticmpRN0Rx?=
 =?utf-8?B?c1BoeG9tZ0J1em9icDE4elJIUUplbHZkTVZGNUhOZDd6K3B3YjgxNFE2MkxM?=
 =?utf-8?B?TVVoeWVUekJXdndOV3U2am5nMlc0L2g2N0x1VFRNcno4WUdWUThBWFp1TFNr?=
 =?utf-8?B?Q1F2NmtKTElUMEJGR0l4VGJsOXh5ektqMjZEbVZ3V0U4ekRJNDJqWG1Qa3cx?=
 =?utf-8?B?ZHJWd200OUZtNHdlcUhHZDA4UC9DelhQdlJmRUp2ZmJsTGR5UG1XaFd1L2U2?=
 =?utf-8?B?ZlNrSE56WURlVUJGT3RFSFhGWERtQ2RPQmlhUUdtbTdrQW84QXdzbEtaQUhz?=
 =?utf-8?B?RnA5Vjh1QldEYzJjekVZYU91ZDVHZ0NyTS9LWjJ3ODJGV0NxRllmcVB4QWlJ?=
 =?utf-8?B?NE1pQ3c3NXVHOWV6WFVUeDN0ZmVtRUVxYlE5M1Vmb0R1UWxUV1ZKWVhZeEZH?=
 =?utf-8?B?eFVLWHFINWlIcUZFaHpOWVk4VEF2aFRaV3dGYU5yakU1MjRGVHc5UWp6dmdN?=
 =?utf-8?B?TmtHUXhqZmZqMlBYS1daUHVDWE1tSXdrVkg0R2E5anNXdGVTWXNtaFR5L1NT?=
 =?utf-8?B?TGgvd1pIVlhEaFJCT3UrRHVvbkFCK1NCR2JvS2pHZGVRMWVjUm9NbkNyNGRl?=
 =?utf-8?B?amNyb1FTU1ZMRmozSmxmWlhHMVBzVCtoaWdZY2JYTEVLb0ZWd3JzNm1oYnZl?=
 =?utf-8?B?aUhPRDJNZkFxODJiRWZ2dUd5L2RyNWZnSi9mUDhvS01DT3crWWhQeEhrMTM1?=
 =?utf-8?B?Y3doQTBZVE9PWWxGa2FDaytOMjhldVMzTjdDK3lMUEVPaThuaG5zRFBNZVI2?=
 =?utf-8?B?S0RiNllWRWliTTI5NkhNQUl3a056dzVFVzYwbGxwcXY1L1JGa2tkakZUMkJ4?=
 =?utf-8?B?LzRZVllmQ051Z0hnUnFsc2xYL1BIb2tOVzFjV1NTelRBQ0QwV1A3VXE5T3p6?=
 =?utf-8?B?aHl5QW5HK2N4Y2xXa0phajBHRW5jdzMvTzBUbzZhWjVtU1E3WlRBVGFhK1Fk?=
 =?utf-8?B?NytrT0tPSmFkVzh2WUgwVGlnclREU0dWZXEvd0M4SldUZkl0UlFKWkl4cTkx?=
 =?utf-8?B?ZVVzMmZNK2JSQWUxRXVXdkpBcDdhZUFRcGdQdXMyQ1psdzhQY1JKMDN6TVRE?=
 =?utf-8?B?dndlbGxKM3pmakVDbnFETEtiZUQ3VnVFbnZzalBmdmN1LzVabEgzMkdOeG5z?=
 =?utf-8?B?VDlJT29PMUUzN3BZKzZYUEJkUWtRV05UelVuNmJXVVQzdXVZTjFreFJJM0N5?=
 =?utf-8?B?Y2cvL1dOYjAyTHo3NE9LdVB3blNXRjFHUGtKbW83T3IyZDBqS0NxaUc0V2s1?=
 =?utf-8?B?TWlWVFdDckdIbzNBcUIzQm5TNkdqTGFQcENNOTVlWkVVaUpUSXdLL1AzM1RZ?=
 =?utf-8?B?WCt2YlRQK3BkY2F1V0tjd0Z5cU0wVnBqTGdjeTBxZ3VrVjBzcjQ4Q3NMS2Iv?=
 =?utf-8?B?R0l4cE9iWHVGNGxuejFTbEIwcTZ1ZjVXTkVSdC9KNzNrRmJjWXFwYXRlZGZv?=
 =?utf-8?Q?5d/Pv0DDTaRCgOfPNRuD9uRW7gtcqTrmYIIftsG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a57e9b-3b91-48c4-d9c4-08d90894b190
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 09:21:37.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hQuPaFDTMtGQYF5e9A/4BYAzzjxV9qNJ8guCWrF83An5O5VTLpUTs7C0m0/x9F5NCaeGshI9fq7RQtL1Rkx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1631
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is depended by https://lore.kernel.org/lkml/20210423103533.30121-3-zhe.he@windriver.com/

Thanks,
Zhe

On 4/26/21 5:16 PM, He Zhe wrote:
> audit now reuquires syscall_get_return_value instead of regs_return_value
> to retrieve syscall return code . Other architectures that support audit
> have already define this function.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  arch/alpha/include/asm/syscall.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/alpha/include/asm/syscall.h b/arch/alpha/include/asm/syscall.h
> index 11c688c1d7ec..f21babaeed85 100644
> --- a/arch/alpha/include/asm/syscall.h
> +++ b/arch/alpha/include/asm/syscall.h
> @@ -9,4 +9,10 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_ALPHA;
>  }
>  
> +static inline long syscall_get_return_value(struct task_struct *task,
> +					    struct pt_regs *regs)
> +{
> +	return regs->r0;
> +}
> +
>  #endif	/* _ASM_ALPHA_SYSCALL_H */

