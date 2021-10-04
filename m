Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83612421A42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhJDWsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:48:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57260 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233501AbhJDWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:48:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194LnS3n010255;
        Mon, 4 Oct 2021 22:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7ojUDqY96zYK4Of9JDJTts5CSwlIEp/+AJDMVggdwh0=;
 b=f5HMscZ+xf5QEfn4FhfBTgYl8gZEp8F3w1+1iCn/H25+gsi9KJhNk6Dz+vuwp3d80Vl7
 BsNX5vTzHpuzk0l/Bci1GE3xl4aegpe7ZQwXoC/++/2R2fuVO/dReC/ovEDsObEBbKou
 +Cxm2g/ZLTHyar6pY0WLPLv5q6EkeObFGA+06ncUdLnQ1dk4dxZe1L+V2LawLO0scH1B
 RDlbGTcNsNsdGIkh4WZmFc/PKxARJQFup4LXZLcVLSRDB6wjbOk6vsfuS6HqpYVMFVAS
 v6t/bPsc9raUFM/ugTu+W5l4yr7NndQEm4nmAQyjvPD8VESWvygJ56PaMdWIGVuR3mYE sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upuan4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 22:46:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194MecxO179542;
        Mon, 4 Oct 2021 22:46:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3bf0s5k2af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 22:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAjIbRkX49c28N2jlkr/BjEQOdaPpg5YpNiQu0s2zNlDIN+Y94KIC85d5eMrx8cbGXgRZiy3EEq5vmE37Fgc9+LBxSt6uQp8nd0hVRUJEPvhAha01vckSpR4VtpniS6uBBOU+/t3U+occ2geuCWB032BvyRUNIpyvjcV9EVa2bYbDQVW9WTjljlytaJ9UgUEgj7f6SVSI8id/K3wXMr7sx3qxR8JTTPO+c7xmt9IcEjU9xAdrjdooLXG54y2V0qhaycnp7AwsRnOF4/iVWHYpKoxbe9r3+NTI52r9L9RxQaC0RKBN0Jpeytusxpi/mRaqMEgO/Ac27lYXX/2f6RoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ojUDqY96zYK4Of9JDJTts5CSwlIEp/+AJDMVggdwh0=;
 b=Xx+k3i4w0nh42N8v+CDV22lOotFhAjTzDwULQBzNRy0JZDEGzGZi7VOD6T+Gt3jPvjaCSrnQSGqHniSBd9oODVQK5sI2kg03BnZ+4cNenrzTSNUlu8t0iZthRADIy16F0MFJSq4AiSuJqjv1NTpZrSwpgzd+AV/FZD8ZEL65dZ/lRwSG47CNbif8i5Fiq59pFeaYuCtSWHGTZX7681iv76SJ6HAMOnB0MWJU5GrNsI6zdBW8/vP8bo0HLSq8JKTgomlYCuTcB0VN1708iuxvCfO5Mf3GHoL53rKgz7iwogYOjhNabFHqfsr8NoMub/PtsQm/j46zW0ADdUwBkxM/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ojUDqY96zYK4Of9JDJTts5CSwlIEp/+AJDMVggdwh0=;
 b=cR636uRu91dI9oEsjNWSAgMW8gKmQU2/bEpErhQKoXBS5TFmqYPKHKXoqkofCMH2Ihlauz3JeFkebUXcj6SgA3yehiOPfLmYGnXvNIHJOD6szxnR/mvkst9NkkwA+wIDOejaehNxcAuTyGm3+OB9xQEGV2kcUBk4FQ8c/aeMeXs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2902.namprd10.prod.outlook.com (2603:10b6:a03:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 22:46:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 22:46:47 +0000
Subject: Re: [PATCH] mm/hugetlb.c: remove dead store in demote_size_show()
To:     Nghia Le <nghialm78@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        nathan@kernel.org, ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        lukas.bulwahn@gmail.com, kernel-janitors@vger.kernel.org
References: <20211003114113.109463-1-nghialm78@gmail.com>
 <YVm2MHbhEU0b7HPM@casper.infradead.org>
 <ccee8f63-f5dd-6231-5625-a67ad3b80a6d@oracle.com>
 <20211004034441.GA114074@ubuntu>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <356bc080-703a-ab45-f6a0-9c7cdcc8abdc@oracle.com>
Date:   Mon, 4 Oct 2021 15:46:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211004034441.GA114074@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0069.namprd21.prod.outlook.com
 (2603:10b6:300:db::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR21CA0069.namprd21.prod.outlook.com (2603:10b6:300:db::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1 via Frontend Transport; Mon, 4 Oct 2021 22:46:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b8653d-6ece-409d-48c6-08d98788d8d4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2902:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29022B3B92F9E5AFCF5A0036E2AE9@BYAPR10MB2902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJo7CyH1x29Zl6n08/X5raEngjKL5Wq5H4bDvEQe8jOk8JgSpedHThXKS7TU2qutAJt3TNDMKoDfRuXlg2yNvszzqPR4eCrzcoKJ9x/1i+2rjZcbEfRQxVk/UYegcMG7kn7rOVsgvanDeytbzf+nE39ghUjkFWnkd2kOtY2i5/v+R+7slMl9RPA6BUE0+GvaEpXouFM40xw2neJ8WBQZj2NRDfzEWwOZ6HZGQlc6tw4+5wfwmqaGre6w1wlJLZIw2aYl2Ml2PbDm0GIJ7HwfqJf4TrPdWe+OOs3fePkVE8doZ4rpzr37A+fNB9TKbu3UmZFbXJy+vzY9/rIRTzzFKDQ5U2eQrF7qBbi39o/xR7rrx9XXQ4+Sd0jZlfOKCIm62tnwxV5WMTloX9ykq1OnPvL4tDK/1Ss8TGgIMIEe3rYvUSNGgIDQzpMjYzh1x4vrRudHQspka58eYIaosyXHD+KyyyyAu34h5/OiRJylqldUNWztmWmA/HVzpyzmD3kq8mEEweBBEUlLsm/Pl4YMjN+IUEHCrlCjS+j3ZXLlRVut0sfiFjVfjS40oCwi/Fvuh/RN4bhq3YGEbIG+iEFT/6ADWiovBqvx0hEw7aSKuVss6cPrTjRdfo17sUN6DFV+XFnVlJZgkez7BUJ8h81Pj4K/z4Jk4EAdKPw47EHdoV/QYSLvLSsCBfCBAoh+BKofkhO+kkMPtRRmOtAktgVtZQc3gY8xLgIH/xtTUA1IV1drQg/1N84df0U18T6TLv6EjmsJVNLpsK3dtaCbA/NhWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(38350700002)(86362001)(8936002)(38100700002)(5660300002)(36756003)(2616005)(8676002)(956004)(26005)(66476007)(508600001)(2906002)(6486002)(52116002)(7416002)(66946007)(53546011)(31686004)(31696002)(6916009)(16576012)(83380400001)(316002)(4326008)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2YvKzhYeGo5aDlZWXU0cmRrZ3M1WDVKQ2I1RENiSmExYmpsK2Q1UXVjNXE3?=
 =?utf-8?B?MUtMdUNNZlFnd3NPSFp0ZFlWZGI0eDZXMUJGK0NzcFZYZi9mL3FSOWwvaDhZ?=
 =?utf-8?B?V1Fld1p3akFZTGR0ZE1UZFN5bDJYSnliaFExVmFJZkNxakJmdEh3QWVYeEho?=
 =?utf-8?B?VWlmQTRoemhJNURseEFJM3ZzOGtTR1ZCaitXd3JhWExZd2VXTk13UERiZmZ5?=
 =?utf-8?B?UEU4UHR3WngwUFZmUkd4YVpSN3BSSWlJeERtSTNYdG9tc09OSVFENFVKRHVr?=
 =?utf-8?B?MGJNTWlBYXE2K0Z3UXllcTdHc2FseTF5UytuQytXY1FQcTZGOUxxWFJ1QTUr?=
 =?utf-8?B?dERlRDFNSzRZbmNTQVVVS1Y4Q2cycUo0N0VvNWlRODZvejd3OTNkR1hZTGM0?=
 =?utf-8?B?VlluaUxpV3ZDUFBFNFY1blprZUhYcDczU1dRdVNZY1pxMFI0b3FValpzMm8z?=
 =?utf-8?B?bG90Z3ZJRjdyc1k3Vy8wNVhYREQwaTZueHpNMGxJMGZQeEEwaUJUSGNpbnRk?=
 =?utf-8?B?U0k0ODltMVRrdzZLeXFZZTgxWHFWc2YwRTl3QTkyT0NIUDlZRjJEd2pDU2Rk?=
 =?utf-8?B?SmZLT08wNmg4SnFzNHFJTDllbmFsTzNiZ2tPVGo1c0VneFZjbWVWQUl2MGNw?=
 =?utf-8?B?dVdxVno3NkpaUzFGR09KMjUvdDRUekZQLzQvcVdjNEx1OFFpeW9pTmhuZC91?=
 =?utf-8?B?Tm1CblVWRmU5ZjlsZFJaR291R3FxK0lTZWVOb1Q3dlZ4d3VMMndtdUl0d1Za?=
 =?utf-8?B?anEvaWl3TG0xYUp2dVZKKy96U2ErRW1YcnpmTFRvSFUyRUJMVjNhVkhaaWlI?=
 =?utf-8?B?cXF3OWU4d2NCUVo2dXlEa0hTLzMvMlJyWXhCdFprZTJHK0lTOUMrcnFMV2d2?=
 =?utf-8?B?YTlJRXBnbzRzOFd5Y0V6Vm5yRHJxV0grUW4wK2J0K2daeEhmbnNFSnBFajdr?=
 =?utf-8?B?QkVRTWk2ZTVyWnB4T1k3UEZ4U2NUVlcwMFJ4cFpnVVdzVzdpRk41SmlibmJz?=
 =?utf-8?B?S1JuSTBCNlNWQlNOMjNnNVJHZjMxZmhrUFFEVEFSWVRpdkkyVlkyaHRqc1Zm?=
 =?utf-8?B?NWRCcTgyemxUOUxaN2kxa1RLWUUzeVJPYnBOeW5udkpXc3Q2YU1wQUsyZmp5?=
 =?utf-8?B?V3pvZG96dU4ramdvMEx4MW1zRUVaSWJHemthV3VlbzlyY09tTmtuWVpYdHVn?=
 =?utf-8?B?N3hVbklnYTgxVkJSRU0xakx3L2pFZk56RElUVGpzVmxnN0dCOWEyMTFSRE91?=
 =?utf-8?B?SlRVeGJmYXRnT2cwZDBFTENuNGh4bEg0MEMzeXBpeXJVV3grMVRRR291dnhj?=
 =?utf-8?B?Y0JETS9tRjZEdmRoUlNBYzBxT3NOZjBhcjFBdE9hUWUva2k5T1kveHpRZFBt?=
 =?utf-8?B?eG12ZmFoL3NVSXZxK0NJME1ZbDI5a2lsNmxuallNamc1cmUySGhGVHdDRWhx?=
 =?utf-8?B?WVJ2SjNEb3p5aUhHRVhnalNNeHk4N1pEZEk0L2dveTVxTzhIUFRoT2hjYWxL?=
 =?utf-8?B?RHcvLzVzT2krRGF3NU95ZWwzV0g3d0FhaEdIMUwzTVJZaVJHSWd0bFo4STBQ?=
 =?utf-8?B?OUh2V3ZydUM5WDhtRUJ1Vnkrd0NxZmNkSDFLU2VicStmZVp6YXh0dE9RcDln?=
 =?utf-8?B?Zy9Xc2pqVFFjS2dHalJkektJOE1MQnhpVjA5RnZ4cm5pNjVZcldUSzNTWFpw?=
 =?utf-8?B?djlTWmc0amJFQzR6RVhwbUw1ckE5aFJRQldXSnFKU21FaUdVcG5rYkYwUWQ2?=
 =?utf-8?Q?4j+MvN8QwmfQx96Ve6AuV+Ay2N8AL4NZ8oRvlOh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b8653d-6ece-409d-48c6-08d98788d8d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 22:46:47.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvd3Sj5vM+iOGGrBBhsoiTYQSfojFmPIEZJHk+GLaSzS87zQm4wCjKCZhcsXpw3mmOEeHa78QFJa8bt+4Z87xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2902
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040149
X-Proofpoint-ORIG-GUID: zgnSNZIwHnb3H1LJSs6rEm5k5glG89wh
X-Proofpoint-GUID: zgnSNZIwHnb3H1LJSs6rEm5k5glG89wh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/21 8:44 PM, Nghia Le wrote:
> On Sun, Oct 03, 2021 at 07:36:54PM -0700, Mike Kravetz wrote:
>> On 10/3/21 6:54 AM, Matthew Wilcox wrote:
>>> On Sun, Oct 03, 2021 at 06:41:13PM +0700, Nghia Le wrote:
>>>>  {
>>>>  	struct hstate *h;
>>>> -	unsigned long demote_size;
>>>>  	int nid;
>>>>  
>>>>  	h = kobj_to_hstate(kobj, &nid);
>>>> -	demote_size = h->demote_order;
>>>>  
>>>>  	return sysfs_emit(buf, "%lukB\n",
>>>>  			(unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
>>>
>>> I'd suggest this function would look better written as:
>>>
>>> 	int nid;
>>> 	struct hstate *h = kobj_to_hstate(kobj, &nid);
>>> 	unsigned long demote_size = (PAGE_SIZE << h->demote_order) / SZ_1K;
>>>
>>> 	return sysfs_emit(buf, "%lukB\n", demote_size);
>>>
> Thanks Matthew for the clean code.
>>
>> Thank you Nghia Le for spotting this, and thank you Matthew for the
>> suggestion.
>>
>> This is still just in Andrew's tree and subject to modification before
>> the next merge window.  I am still expecting additional comments on the
>> series.
>>
>> If another version of the series is needed, I will include Matthew's
>> suggestion.   If not, I will ask Andrew how he would prefer to fold in
>> the changes.
>> -- 
>> Mike Kravetz
> Thanks Mike, so we will wait further comments from Andrew and others.

Yes, I received suggestions for other improvements to the patch which
contains this code.  I will be putting together another version of the
series with at least these changes.

Thanks,
-- 
Mike Kravetz
