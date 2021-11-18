Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E03455813
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245178AbhKRJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:35:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64124 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245159AbhKRJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:35:17 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI9AkMC009987;
        Thu, 18 Nov 2021 09:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3RkrvSP78vPPPH5sVAD/c09Gh/ipcES+SSqPIT0YeBY=;
 b=R44lVKKSlQVQpxiXMO1c2mgxtOZ9JwgEFTHJBdje4T4K6j1MSBMXCmWLKhbBhnUKmAnC
 g9kXtmoVBvoIYxpTTjYwKDPEpk8fJ7F78fK9O26SLvs2WRVAOZt53qbSakZ2udeL1gER
 YOqTKPp1WXGlY3ZfV9+kEjfJZBFoIQnMnM4CF7/YBpuYM+yvapickt/n/yNli13oOf+f
 DGEFwV21Sn0PlKdBQ+H7NziXCWSVLxKeC7UfhOQLv0gGmPJKeYF2Iimsq8gwVpTsLE/1
 LUj0e+B6esabzv4dSMj/3E7QxrfKJIf9dcLvQoy5ChaLcKxX3J3QZQDN0BW+Iijle7FF Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd382e60w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 09:31:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AI9H9Qx058376;
        Thu, 18 Nov 2021 09:31:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3020.oracle.com with ESMTP id 3caq4vq8tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 09:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcaiNo8jVy8s1F7o3RmTl3BaZVmwrBETmhwZNNEJ3J+kwac2/18uqREYuYwUApZP+qYppXZThLKtPRZdPqpfRxwBFCtJJr4rUz/raxvbd3YHytnkAjPcb4GcOrJU6jxR2qe8AypzN3pmWFb77HqVkYHUvMusscxf0O3jIvYiLwg2jos7vBJDL9fi3qIxPDepFNvUV5Q6TKvzxVJqEFx6nRtQpSBOUMUlAiqjKIcNbYYT5rr/FeQD30N9CSCmkHZ+Dd+VRc+xmbEzW3Fj0SDAt9MY7GNSkxH/O+HVrwpQs/u2pRT4ISI/IXu4VBjJ73U1qzRTbd48Q4JWVWBXXPXGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RkrvSP78vPPPH5sVAD/c09Gh/ipcES+SSqPIT0YeBY=;
 b=cU0SjMrPS7Knz4Q9ki7R1RT4bhLxP+PyJdRtcraEwA5v9buaLyyRYMxemYlDzJSurBDCzjFgBDevmf2PyA+z5aogJqbbkk04cckEmWOt4T1y6R2NNSQu96/ZQR0bpJttm3QrRTJIYN1isIudJ/nF+32zyDTb67E//W5f1Mol+jaAkClaedH9zn2BqWCuGLNKKQWWSorG0BL3mhKVY4/HmPUNaQ1yijY9MDHWnu54O3JBOcwNy1N/hEWGM48vUUCRRJJXYJu4QrsIPz2/mNRUyhyVB5IvjgtLwsWgjwZh013gycNU52gD/eKcEW8UfROKK8lpj0/s3ytrg6t18E+5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RkrvSP78vPPPH5sVAD/c09Gh/ipcES+SSqPIT0YeBY=;
 b=ym7VlIOqG3jTNxeqzMCQUr1/tL/vAbU0u4mG2K3zjFTDKMKvzW21OAd9HizhebKSuPc8sRwwvd9mutmsoz/C9t3jXUOcWZdlFhfUSQU38ooDKZv/IExswGMYKb9dacKp3IIQECCYK6s01BQp1ctBrRtDfAmcM94uPX/ZECXe5AM=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by BN6PR10MB1538.namprd10.prod.outlook.com (2603:10b6:404:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 09:31:34 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::a196:9a75:2ed5:2f1b]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::a196:9a75:2ed5:2f1b%9]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 09:31:34 +0000
Message-ID: <f4aaf005-8b72-9b68-87bc-8019f0199f0d@oracle.com>
Date:   Thu, 18 Nov 2021 09:31:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V5 46/50] x86/sev: Use C entry code
Content-Language: en-GB
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
 <20211110115736.3776-47-jiangshanlai@gmail.com>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20211110115736.3776-47-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::16)
 To BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
MIME-Version: 1.0
Received: from [10.175.165.165] (141.143.213.39) by LO2P123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Thu, 18 Nov 2021 09:31:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f49be4d-e808-4b04-7a22-08d9aa763607
X-MS-TrafficTypeDiagnostic: BN6PR10MB1538:
X-Microsoft-Antispam-PRVS: <BN6PR10MB15382C42DD86BC13E531CA02E89B9@BN6PR10MB1538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGxYyVb2q3z/vH7zJsk4Yi43NaRrGSLSjFAY7FsMbzhhABfXNuiz9/J286hfgynHsu/pfiPqdgoUVmte7KPsxXRvcGQor2WauL/7760tt/yTYuIWzQBIaFYPqt64L571w2SwnFDlexkQdY3kEv6qqOL6n7RBzdHF/3KmZD7dIVvBM/OQYYZ3lb0LlLP2Z4tyd2PsCq96gasnhvx2C70Pz3WpKuNAYMUWF91m83cEnPwlNHtoWt9Sw4H9z4AqB7XPryEWbQ7UHn71mtKBuzFBsoiX0MzHHnhO6px9RfyhaTwdV9WWI7XtO/8T1SCGRYVl9qDtxOen9pUOA+lWIM/kuCKF2PbCjbBz6KxpzAc7yxk52nkWFWkkk1fbgB0AVlpyCQzqPsODVEbREyyINCrSYA/dKLr2+//wHKTE2Hx0PYW+BR/6JWdrVOvEuZzBFKYyBk14pkPmbGYZ/CMTzmVhm/X5IrNc18LQUUES8PIJqpUBL/my1MIPjyqeqkxyds70Ixv3uwNQYa4OG9E4jdx5zIqpt6FKIoXEC5lNDr/Fo2O5gH4POxR9daS1yIpLcYB0mmEieJTk6iWEIFdh2GiY4onDv/SZzsUbDeeWm3L8lVLpqsReYpDgiLqyGk/HC43vzg6q9/QcSjnoIxTy19pE2id+oqTRN3GdOk2bYEERYvbWRqOAszaegQxgmmVBOe4Q5w0C29ZYUNWbMjVUkSza22jY/RC6/nb/hXmiKxxTFqDrCvqmFKHklVjUxoRB6pDF4Y6QdScLR1ToQF3WgN7nTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(53546011)(4326008)(6486002)(956004)(26005)(66946007)(8676002)(31696002)(186003)(8936002)(66556008)(66476007)(2906002)(6666004)(52116002)(83380400001)(2616005)(54906003)(7416002)(508600001)(36756003)(44832011)(5660300002)(31686004)(316002)(38350700002)(38100700002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1J2VUlRTkRxOUo1THlPVTFPT3N2cFd1U0UwSmtEZG9JRXQ4eUFlSU5tbkZL?=
 =?utf-8?B?ZW9hdXhKOFpvSkw3aHl6NDhTamZ4cHBTSXI4YmpXRjBKOXRMUG55Qm50MnN6?=
 =?utf-8?B?eXcrWStVb1lETzFHelBlKytGODNnNGhnQnBNc0tQLyswMDVzZlFrMG9kQ1pw?=
 =?utf-8?B?RlQ1ZWJxNzhlNHVVUUhnMmZ6TWpHQUtJU1ZEZFo2bTE4eS9MdSthWEdUOWVN?=
 =?utf-8?B?SjgzVWNkSFdwOFhaVlRBS0h1d3VwTzNYd0VWc0VGN2RaQmNPV1Q0T1lqYzlT?=
 =?utf-8?B?aS9pOGFKN1FzYWx3RXN0UzNoK1JKLzVGNkhWZmhVVUxEcDIwTDJSdXVkaHd4?=
 =?utf-8?B?b0crajR0TkVzSHhGOUVHQzdVeFZXWFU4NEpQYTRBNk9aSE9BaXdKVGFvMnRN?=
 =?utf-8?B?ZXVjWVFqYTluUGVwcS9yQ1BqcWRpMXdHOGQyeVFMZWd0cjdqY0xsWnI0bU4r?=
 =?utf-8?B?Tm1BdVVqTHVCbkxpZSt3OFIyUi85bU1mV2xwNDJBUDhBVmlXVU5JOTRPOUUy?=
 =?utf-8?B?VFVBUTMvdWp0MVRVRm83Qm1KdDg2dzNrZk1qSjYxNHlTZm93NjFnZmJqK2VX?=
 =?utf-8?B?NDJoeFRySThQR0NZSnhCSHNJOXBnTVRTdnpwS3lzUEhtS0pFanVFRERuWE1k?=
 =?utf-8?B?TjVZUWxneThNRTVmSmVLR1BtdURLN2RVc3hRM3JyTERTeTloTExGSm1SV2xP?=
 =?utf-8?B?WHM1NlBWMmhRQ0s0L3VscnY1SW9jOUJGSlQrUlQ1NjBrRWp6cWN2Y1ZLQ1VX?=
 =?utf-8?B?bkZwZThUZGFuWnhseFNaQmVpUVp5aGIxd2diS2lUK3Fld1Y3VzhFWW1Ecjkw?=
 =?utf-8?B?UWpscEoya0JkQVlEU09PcnpvZmttZVFxVVFVdnBCb3FiRWhzZXE5Y1N6UzBl?=
 =?utf-8?B?cnNGaXNhWnJpZVNBcjFqQ1FkK3R4djhWZTVzeE9rVktNQ2duZUJtcDZ3Q1Vo?=
 =?utf-8?B?cW9vWit1aTFzUXRNMGdxY2h5RWE1dWcyTGZNZUJLRldYaEVxZ2RNRDRZWkZW?=
 =?utf-8?B?ekJraTlFRWtDY1ZyOHZpZWxJZU10SW03K0RSSmRmRmYrSU9MY205VEpINXB6?=
 =?utf-8?B?cjBUM3FKS2phaDNiQmpBUklQWXJEeFF1Wm5tQSswZ3g4a2lLRnJDREVSZ2th?=
 =?utf-8?B?aENsWXlWOFBlVDRNOXZOYWZGZ1dRKzBWeENEcnJtSDN0L2xWOXlIMXkyZEVY?=
 =?utf-8?B?RGVJUDRRTmcwTXlya2xpSXFFUk1aK2lkMnN1REl5RDBjMnk5aDNxRkdPM0ts?=
 =?utf-8?B?eGRVTmJrWTdKRUZjVGVlSlJBNzZlTGhkOVlGOWNxY1V2SW55eXpSMStmZllm?=
 =?utf-8?B?VWRGbFprdTVTQWtGTERKZ3pwU1diaXJ5dWM2NEo3S1BybUw2L2UyTnZjSzVL?=
 =?utf-8?B?ZnZPZ0M3bmZoWVJ2UFNLY0pjWTBONmZXZWQzS0MycFNQZkYzbndqTDREbSsz?=
 =?utf-8?B?aG1KUzFxRTlxRnRocU92NFdQYWZ4ZUhVVTFFUHRiZlJ1M2prYUM3YU1RN3My?=
 =?utf-8?B?QUhTbFFBRXJQZkd2VTlJSW84T3NZeWxsV2dmVlRpbG9OVnI4cUpoT1pYSm13?=
 =?utf-8?B?SU1rOUplSW9kem5kWEE1dDlqZUtVRnhrN0ZrTDRPbElmRWx3S1B3VjdIbTUx?=
 =?utf-8?B?SzVVS2dVZ1FOMVNxdnpMUmVkSzJLMGZuVFNndE4zUjZRTis0Ull1cDBPTm1Q?=
 =?utf-8?B?VnJpbFczclhzY3ZqckJNRUUzbHFObEJ6MnZJVXNnS1ZBY01TRGJvaDF4ZkJ1?=
 =?utf-8?B?eVN2ZSs5NHQ0M1V4UnFMNENCWHR1ZG1LZWdncmFEcEZuMlBXRkxrVWx4REJl?=
 =?utf-8?B?NkFVOGZFbkFOWDZQYXVaSUQyL3ZOWCtnTHBGS2htSG03emJxUWN5aXN2NW1C?=
 =?utf-8?B?TEw3MUlZTG4zRkZSdEtqWUI2aThNZ1ZlUGdoVE5OL2ZVZk1GREZDcXJET1BD?=
 =?utf-8?B?TFlab09WdWNlK1Y3WldYZm80NHRyKzUzdjdPbWdPM21hMGMwMzlZMGtiV1Va?=
 =?utf-8?B?ZnZrVTRRYWg5cHlQNHFmQlFqQkNMUE12MC9jRGNnZDhVK1BuZ2VaVmErdGtp?=
 =?utf-8?B?ZFdNTk12VDNCanV1emdLS1VmU2ppYkI0dmlMYlNWdTNpYXJsWjVhc29KSXRi?=
 =?utf-8?B?NzVIVCtQaHdXMkpJU284c2NHdWhMUmhlM3N0Zkd1M2ZMdW9jd2dqQ3UwUHZB?=
 =?utf-8?Q?MKMvkV0i4Gbnt6GjVlko/nc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f49be4d-e808-4b04-7a22-08d9aa763607
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 09:31:34.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwYjmzQDdUotd7eCS9mH3PCly2Qb6eL4i2pirSo6w4+k58zqH15a/1FAPBwwOSalbWhRTgYg3gV+rpwJyNKtJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180055
X-Proofpoint-ORIG-GUID: 5xdFjFryiOvb-gkdkQupKRITdCJ7Tf2g
X-Proofpoint-GUID: 5xdFjFryiOvb-gkdkQupKRITdCJ7Tf2g
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2021 11:57, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
> use the function directly in entry_64.S.
> 

A drive-by comment as I was looking for SEV commits...

Typo in definition names, ETNRY -> ENTRY, (which impacts most patches 
between 38-48) would likely cause confusion in the future.

Regards,
Liam


> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>   arch/x86/entry/entry_64.S       | 22 +---------------------
>   arch/x86/include/asm/idtentry.h |  1 +
>   arch/x86/kernel/Makefile        |  1 +
>   3 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 944cf85e67da..dfef02696319 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -527,28 +527,8 @@ SYM_CODE_START(\asmsym)
>   
>   	UNWIND_HINT_REGS
>   
> -	/*
> -	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
> -	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
> -	 */
> -	call	paranoid_entry
> -
> -	UNWIND_HINT_REGS
> -
> -	/* Update pt_regs */
> -	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> -	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> -
>   	movq	%rsp, %rdi		/* pt_regs pointer */
> -
> -	call	kernel_\cfunc
> -
> -	/*
> -	 * No need to switch back to the IST stack. The current stack is either
> -	 * identical to the stack in the IRET frame or the VC fall-back stack,
> -	 * so it is definitely mapped even with PTI enabled.
> -	 */
> -	call	paranoid_exit
> +	call	ist_kernel_\cfunc
>   	jmp	restore_regs_and_return_to_kernel
>   
>   	/* Switch to the regular task stack */
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 931b689f464c..84ce63f03c7f 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -426,6 +426,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
>    * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
>    */
>   #define DEFINE_IDTENTRY_VC_KERNEL(func)				\
> +	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(kernel_##func)	\
>   	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
>   
>   /**
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 28815c2e6cb2..9535d03aaa61 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -52,6 +52,7 @@ CFLAGS_head$(BITS).o	+= -fno-stack-protector
>   CFLAGS_cc_platform.o	+= -fno-stack-protector
>   CFLAGS_traps.o		+= -fno-stack-protector
>   CFLAGS_nmi.o		+= -fno-stack-protector
> +CFLAGS_sev.o		+= -fno-stack-protector
>   
>   CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
>   
> 

