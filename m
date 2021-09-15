Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637340BE42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhIODbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:31:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236201AbhIODbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:31:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F2gnVl018578;
        Wed, 15 Sep 2021 03:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yV/rVujkAZGF3X1dJME29vyMCd+XerjP/Jame7HooNk=;
 b=cYSBTIISWbpFSWov58LEuOyv8h3GB8AIwE+LaF6EZr93xjVkl/y0qN1PnbnMH5jweQGY
 XpURHtiEiLAg31A2Pu7pxpKcFwjAOL0keTP2CUxTi/qNzN5EvxC0SNA0DH77gRYRYYgQ
 0byI5T1uliaL2DDqkwqYoyoQeqVEnOY1vu8my/GBppLQGz7eQj1oaUWsmOxZAfshUXQi
 jpesnHsO/bz4m35HPamSRiPNRfGdyMUHHX89oKh+DIVOFS/VA7sWlYVuKKZThN47MSqE
 QI1Od08HrBA16gQELvrwaV3tvI63Vah0ZCk+uCwNa7foEY3lUzOXcvRU3Nv+LGhd7R5/ lg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yV/rVujkAZGF3X1dJME29vyMCd+XerjP/Jame7HooNk=;
 b=IOzXGw9U8CeRwdMbYJoPR8+MAJe0sirKzxDLxicN7ZN5eZPnRZ2XFlksPKF5d15l3PnZ
 SXPxpuWKaZN6TVJr0EEjdIIXIZL2cOnWmxMmxL+jr2mNt/KnJhvwF3mjEI2YUDW+QSjR
 aNPpxQ2VwmqJm5S4ligj/m+iUshCvyY7hG+xXWknBymn3YF9fL17+tcYtcTnfPv8Q1lU
 Ijlvl7n3knSMtmjRxrdzanKqAh+oS6jgqcYBZ0MRx6Hpa8QuRt7Ww4vumrq7XLpBVRCP
 Rb/DjeOMmB/DQwMd9tNIZJGwxLaAfY1LIMeLz2QVRrv+LXCtkY/9O8cxXXANZB7JJZX2 cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5uuwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 03:29:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F3FAKn070786;
        Wed, 15 Sep 2021 03:29:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3b0hjw1stv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 03:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikglzu5XlatIBtcdBINlAldYDl9JzHQI2NwAdmCwttTtBP/pKhgP1mF6LfyTXgkNK1L6XQuRQjSlVRlX//7lzpKV/cUAuxMdSiN/j/SZjFPEQHL2bsTIENBwegrRnLLfp8nfrQvXClItbX5h20jCLOmAPlSKpZNyAOD+VKGgqTdYa30sQbf6RFQCWf8cQuC2tAjJqDHOMe59iEsxrMLN9FdgsfWUi8rDvtRW5yPxc+rBcvgq9kIluAfJEtrhwbBRk3XU/OzS90WMz08a/eNkjPZUPH66LI41DqBaWJGBsFbjTjJZDtkAVd3GVghUaDpVYztiHGwbAt6Qu73/KaBEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yV/rVujkAZGF3X1dJME29vyMCd+XerjP/Jame7HooNk=;
 b=QAOwWSDj/3R6hwEnA87CdOOuKO30M94EOzFXx+ENiXc93s0S2zyL4U+W2b0OY7iupq/vNkA5QmIZTnquoaQ+kQp3f+znB0+cnM8yeXVEX6KJrQEv6vWJBSB73IW6VuK6M2/GkKks2eK+6XcFMhHO9OZdqJ+0aa+SXkkk2HzxN/bJJkU1t8HMusiE5DGnB4QwDjbQ+1V+e6w/mi72px/JLxcwDfHSu26b3QV1fLsQIE5jwhgDqyUFiNHEzy9RrwqWfw0aWrUC+2fJJz/wf10ODxwgQq3TOSenD3FW9W4gfEbOpuf/rMk08v00TD8e9RKS+kDkyjOOF0vo6V0U/E6tsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV/rVujkAZGF3X1dJME29vyMCd+XerjP/Jame7HooNk=;
 b=uLqtu9xIDbe3Xr8znLgKuPbluCnRfAUwYyTlQzchZ1NU7nW1dX+ehjUrDg2tlJT/+ewRq92Q64mfFAUiIeVtnFIZGhXQoUwYgMwYc4ONMyVd/0Ral2F6G06uin8Q/+9IlJ+g4QsSasMbtSWZAg4qsOmSEojsej1k7c5E/QMQaCA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1664.namprd10.prod.outlook.com (2603:10b6:301:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 03:29:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::f091:1dd2:38a8:e986]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::f091:1dd2:38a8:e986%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 03:29:48 +0000
Subject: Re: [RFC PATCH v2 2/2] lib, stackdepot: Add helper to print stack
 entries.
To:     Vlastimil Babka <vbabka@suse.cz>, geert@linux-m68k.org,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
 <20210902000154.1096484-3-imran.f.khan@oracle.com>
 <ef0aa660-0cb6-dc21-f2ce-368b34f8af3d@suse.cz>
From:   imran.f.khan@oracle.com
Message-ID: <8ecc3437-8895-c12a-ecaf-f9625fa3e364@oracle.com>
Date:   Wed, 15 Sep 2021 13:29:38 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <ef0aa660-0cb6-dc21-f2ce-368b34f8af3d@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0151.ausprd01.prod.outlook.com
 (2603:10c6:10:d::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [192.168.0.2] (110.33.47.182) by SYBPR01CA0151.ausprd01.prod.outlook.com (2603:10c6:10:d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Wed, 15 Sep 2021 03:29:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344fb321-2585-4051-ced4-08d977f911ab
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1664E84079FD43ACA23F9E2CB0DB9@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8RJ9JZgKQgc2CkacnMgElgRwEc9fsn/350+1uyAMqifjZFTns79W25dqr2nhXBAYhEEGG631koGfoIemrHw8qdNbedOJZq2OG5650WZFMEnvmRV4O+UAkVGJ0mjGC5JsMU0GHNqIE2Nj5hFUfDEd5U4Es5xb21IpamMWyLQQTsB7IkM7p3nbqXNj1et+AWJAlnIws3SvmhafohpzRpllwIUohtqRLKKxGgxyRTsNiEkESJVhDQ4OrvyUjlOLDIJkgDnb0pX/tKyOJGYQ3EebL/N/byM82k8G1JQWxV6IaOPis/94YzPHXvROl8DVNL22WOLXaOhEqJSCtIytNIycG/DgAid67dv1cpJJ2yGjxMGz8/JdhXpFAr53rVwrPGxlO7vpAFUIxnYXgeR6QeHaOvU/63jE72NYXDGjYz0A1CwAXXNw6SlrcXV8eEFWvOTTdWGj+R63SVGEgJmmHRIGC3T6nFZWwuMPKPGXEfZ1gmP9LRyeg8IYSULWE5sT52gBydh2xx3CXlaYA1/99X5HsjsHxUkraYtn0DqJ+TrXl8dVLnVd01LC4dThBrkMObTf0EeC1YHLGxeyW7NeppHPT71aWvvtiokHNTdeMF5tspPOYUWB9xghiPCfLGGDCA6LT+hSaTYUTFOpoOii3kACiDJa+W8iilbQYHFI33LLYuMnUst3i9q+rJL2FJXZWscby1A1Wp+wKuH8wM7NL9L5xaeh5HDB+dpmMVpqUNa5Qi2TQh7SCR547Knwgg1vu6RSBm7MVuQw1xoDtxVPeMQ70HsK9DWiV+5sscVRv6s4Aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(136003)(396003)(346002)(36756003)(38100700002)(956004)(16576012)(86362001)(4326008)(31686004)(2616005)(316002)(31696002)(2906002)(966005)(478600001)(26005)(8936002)(9686003)(186003)(5660300002)(66946007)(83380400001)(53546011)(6486002)(66556008)(8676002)(6666004)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZEMzdhSXcvaS85dXNyNjc1NFRQNUZBa3RkVkNDWWxaWFc1Y2dHUjZ1NUV6?=
 =?utf-8?B?dTNEOFYwQnNwVm1uWXkrU3FzN3BPNE9JdmNvYkFlZ2ZNZ0NZZUlBaGNheGhi?=
 =?utf-8?B?aGFKMUZMY1VKNStqQTNZem1tYkMyS2hsc0hXcDMyRWJWVmpjdWcwZGRZUlZk?=
 =?utf-8?B?UEV6cjl2SnAvUTlMazR0RjFEcHlBdXJqS016SlBndHRaMTBSR0ZoQU5HNnh3?=
 =?utf-8?B?RUhQWlB3Z3FCNmVmditxSEdYMjF5VSt2cVZ6dWtKNkxZWmN5K3RTczJmTTlI?=
 =?utf-8?B?SDhjMC9QN0lKTlprVmNyc0I3RUU4VFZUcmdETTRvM0ZiWUJFUndrZUkrSnJp?=
 =?utf-8?B?TFY0bDMzTHJ0Q09TelZjdFl5d2FHNEcrRWRpLzduaTJnM3AwL0t6NXd3OWpa?=
 =?utf-8?B?bXJKVWNUWWZhcG52WWdCNnErTlRtTTd6THJhYVRrakJSZ1NVQTQrNFJrUWF2?=
 =?utf-8?B?a0FhdXBIRUtsTVJEd3VhNmY2V2N6dFFyOUFOQ2dQL3k0U0JvMkkvL0QxNnFM?=
 =?utf-8?B?aldDazVlQVMzTDdKT2tWWHpTbFJrV0tYUGRpbmE2OGd6UHFSWHd3ZTI5bUg0?=
 =?utf-8?B?SFRCVTM3OExJcS9iUzBFV1dnbU12Ly9ES0pueFhNWXk0eG1raWg4a1UwMUhN?=
 =?utf-8?B?ZThjSFNKa3FNVEdZM2NITjRXb0k3WVJOaTlEVGdWdGRUZEcvcU1DK3JkZGth?=
 =?utf-8?B?TVdDOTRsZ21wTHUvUGpnWm4xM2dtMVpRTjlmcVlxbmdEak9VL3pmdEJPZ0Q4?=
 =?utf-8?B?c1hmcUxwOFdvWC9pRGlmaHlMOUhLa2JjTjUxbWtuQUowejhkZU9oVzg4L1FI?=
 =?utf-8?B?cFJvd1BkTUxsdzJDenR0L1o2OEtybTJnM3BzdWNJT2lQbHUrR3Q4ZXVwN1p0?=
 =?utf-8?B?YWErckx0Y2lic0F4TzBiVXpBZUJFK1JWUHMwYk91OUo1eGU2TWxCRnFOVHU0?=
 =?utf-8?B?cm1GT1V2bmwxQzJ0T3liNDZNOHlvQnR1SUU4dFkyQjIvZGc4dkoxbTFNWmw1?=
 =?utf-8?B?ZWFKVzdwVlV5cCtnUjgrY2VGaElpQU55MS9pK09FZ1lYS0ZyQ0FLcGhCckNK?=
 =?utf-8?B?bzhwc3JLZG9GNUxVWFNFbXZGVjhtQ3kzUk5ES3dNUFpOOGZXSGRzcnhjcDhT?=
 =?utf-8?B?V1F5Wmt5aVg1ekJFRU8zOGZlSEkzN3RqaWRRN2ljcVZXcmdyNHhJemdhdzRP?=
 =?utf-8?B?ajZIdHRNYThVWGhqTEdwWHhiR3hPYVB5cUpEL3JyZlZsMGg2T0tJNEtDeFpj?=
 =?utf-8?B?L3RwRTlNbjA1UE5SK0NIUjhzZEx0dDJBNFhRYzRGU3A4azBRb3FDeVFLVmly?=
 =?utf-8?B?anQwc2VxcWxJS0pVU214eHAvS0pQeXp2cXJWZlFJSVZHaXRnd1Q4bHNZL3lW?=
 =?utf-8?B?aUFEdDQzQ0ZyUUtPRHdlYnZRaE43WnpYZ0o2L2N0Tm5ibjRrV2VFNXhLeTN1?=
 =?utf-8?B?Qi9EMDhZWDJaV0xVNmJCZnpXVXpEZDJYLzhFa0p6TzRXV3N1WDlNeTVPUUFj?=
 =?utf-8?B?L0NuL0xxbXBZNnNUY1plRUg2UGo1NXFxUEpJUGhQMUFZbzc4TUNUR1czbiti?=
 =?utf-8?B?QTloUDJ5TzhQQzNuNnBMMU8rZFJXc0NLNlNnUHFUMVcwVjE1dnJ6T0U1ZDFK?=
 =?utf-8?B?RVVaSlBLT2FQRVZpYURSYnE5SFNpMy9kWGsrcGpSY2M0TjdPQmdtbWIzRkhX?=
 =?utf-8?B?dEx1dWtBS3BFUXNvQWQwZzg5NDBiMHBsM2VYOGo1RDNwN3EyV2RVakNhT2hs?=
 =?utf-8?Q?HyWUb7/p3OohKhTK506US0U/hLVNP1owuMWpjVS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344fb321-2585-4051-ced4-08d977f911ab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 03:29:48.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ov16bysm5qW2KcXgf6I0EzmllHfs7snJkGLVUDfp03BGre+ayQtdAFUaF51qBETqQZJtijYtuxc1h0DeX/+Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150019
X-Proofpoint-ORIG-GUID: x5kqKOFVL278XM8jhrL9mQuUz-5nUhhV
X-Proofpoint-GUID: x5kqKOFVL278XM8jhrL9mQuUz-5nUhhV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/9/21 7:01 pm, Vlastimil Babka wrote:
> On 9/2/21 02:01, Imran Khan wrote:
>> To print a stack entries, users of stackdepot, first
>> use stack_depot_fetch to get a list of stack entries
>> and then use stack_trace_print to print this list.
>> Provide a helper in stackdepot to print stack entries
>> based on stackdepot handle.
>> Also change above mentioned users to use this helper.
>>

[...]
>>   
>> +/**
>> + * stack_depot_print - print stack entries from a depot
>> + *
>> + * @handle:		Stack depot handle which was returned from
>> + *			stack_depot_save().
>> + *
>> + */
>> +void stack_depot_print(depot_stack_handle_t stack)
>> +{
>> +	unsigned long *entries;
>> +	unsigned int nr_entries;
>> +
>> +	nr_entries = stack_depot_fetch(stack, &entries);
> 
> Maybe this should also skip stack_trace_print when nr_entries is 0, to avoid
> the warning. While the callers added by this patch check handle != 0, future
> ones might not.
> 
Agree. I have incorporated this suggestion in latest version [1]

[1] 
https://lore.kernel.org/lkml/20210915014806.3206938-1-imran.f.khan@oracle.com/

Thanks
   -- Imran
