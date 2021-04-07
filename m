Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C423576BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhDGVXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:23:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhDGVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:23:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137LBdDu091958;
        Wed, 7 Apr 2021 21:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MYMiiyPkbAWNisvkG7vZ1i2V0HX26vzZVVIUYuwP6rw=;
 b=HWFMeTSCBwbpnubh3vLsfIonihPIzTkmuN0/FLbApGjggNJn/fyjXX2F6XZW8LHRmkQv
 M2KIpWktTBJbpnq3NtIx9v78Ats+CqH++YOERlyrZ7hy/qnWIJFrdodYw0IopUHzP/83
 gW8eyxDigX7LMia2XBZHOJw0nxBWrboWeCTH7/k+5oSj4g/0luuau399YjCoqIHx5UzB
 IR1yW2e1PpWqmk3RA67EPWZurBbGJY6PHTGQCpCr9nNFzp2TIzit1KB4FBUUBTbHlnc+
 u2QGaseB3dp0wG1gexV3TaTKo5rvioqWYfiFzrWpYkUGmMij2OpNT/viykwplaFZp8go ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37rva640b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 21:23:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137LA1g9155248;
        Wed, 7 Apr 2021 21:23:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 37rvbevpaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 21:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UATqDUfJ/aWx2AECxL3tjSjhWLhgH+OXb63OiJONIndkzxkOIWMS/ta4jZ2M+Vpaw/DYqavVPOQjyXhCp6hkoWb+RBiPgkZ7WfuaPiXg5Wb9ru7qs55w9/pTDkDv66/fF7fz1fmwW9QZB2+QLtuT/JJO4GQ30nE/5sfh/Cv1MuXTzTiplz9Q845/VbRWjFc9CZHV+8qhmPNLBTOtxAyZHzpSs2QHyJTh/HrIb9K0L9zJtp4cpZP3t0wbGC3rsYJZ/4447a87fx3EUkqQOCrixnO3MmiNCLHcMcmsWbG0y9WtxB/aP1epjQH4YdTbuUuRQlxc6NCA0sStq9LLlEcerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMiiyPkbAWNisvkG7vZ1i2V0HX26vzZVVIUYuwP6rw=;
 b=KA33NTzT2NvfhPCJ04cxH2S9yqOtYZBL5mER5mtubkBYWH64axKUpI33KoG/6kIh72gsmkPa0m21xVbjkhwyPAi8Zka+b+wn/wr0Fe+uqerzbiUWo7tAF/XDBfXuNgJXte/MdYpKUiLzT5jYoDbd22O5EiSp4gDD0bkNfIKL2fgSXbi+YDw/YoGpdatmAF5masRsrI9AuSZCBbAhPSVX3J7JcMGNS3oLfL6Vv0lcHuDoH9I+WeZN39/SaTJKb7TTNTq+ASMd9z655OLhs+HDRV+VfTFRaryBomxIsQi6H9MD3Vyrp9ppODMUvsqSzApVxpb/zyYzolCWrVOYXjomew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMiiyPkbAWNisvkG7vZ1i2V0HX26vzZVVIUYuwP6rw=;
 b=a67nh+74LlsMQKh/dHWqjjv4ytoMnxbI4uLLiwywcg7WDBhwaE5ytG3yEmY7uMs3YygHE8XDGdlc8x1K/4++DsUBGDY26ElG+JoVA5dQk19KRf/ZwmoAYe+8e8Ib7/Ukb/rE/sFwZ9peGk0Yc2GYlJJVjWkQQAhCpCL4tF5ZAEU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS7PR10MB5277.namprd10.prod.outlook.com (2603:10b6:5:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 21:23:07 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d973:8f33:7333:2717]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d973:8f33:7333:2717%9]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 21:23:07 +0000
Subject: Re: [PATCH 2/4] mm/hugeltb: simplify the return code of
 __vma_reservation_common()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, hillf.zj@alibaba-inc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-3-linmiaohe@huawei.com>
 <e958d731-67d4-a56b-aa1d-a8054cf232f2@oracle.com>
 <40114ff5-ba3d-ca66-3338-25db80a015da@huawei.com>
 <aaea15d4-c8e0-ee37-8ceb-35326b7ad1ae@oracle.com>
 <1926967f-3805-2baf-6b86-24039c6513ca@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <de625a4c-b5d2-696f-33c7-7876e0f81435@oracle.com>
Date:   Wed, 7 Apr 2021 14:23:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1926967f-3805-2baf-6b86-24039c6513ca@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 21:23:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6569a597-c1a0-44d1-4946-08d8fa0b562b
X-MS-TrafficTypeDiagnostic: DS7PR10MB5277:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5277C56CE8C813F956C80DE9E2759@DS7PR10MB5277.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0QgisW9JO1j/JZZiUwD3GLqyTFnEFlwto8DG3b0HAT4b0tYbPPmLd3W13+p+KqDiBHyexWzyA51dbQkjA77GKmeqDZOZ9ucBu/Epce43BV+PaID9S2aODd11Oa4zGHOVkLQzNc6hU/uUSiSU19hYTn6Ca+6KKVza3yiBc5UYtkIEbH7Fv4gCylSpUBuccv2QCxvukB1/WAnkxSBgapkQTSg2PnC5cj20bQvn8oU8f68B7+eSS3c58Y175hhs8uJGHb2JzmsCnrGCDX6arrsFBXPdhcNSb5F28LX5ebC+4iqWJyMxMjBpinl5wkQFa0nq8YbBKc9SbQPklEM0w/rHvAJsNkkecAUziiKfORsQfmn7AMOE5VqZdGDt0E9saE+PEpX7iGjYO//EojFFJOEfOHnP/CAgHmOJ1P46p6Ox/3LR/4VN+Siw21L5L04unoSQ3SxRAmR1VjhVLTR8YGJfbM9Vx5IxeIebfoHezjinpNVGEOrlCjeMiEdnAk7KsLOxoiGZv7xEh5Lu+Wxx2OImwMJD+BY02qFc+kQjl68rN3fKSA7avPiYomTit9ik1/pdY919ai+D9rpcJQaL1zFz1HuESIYgk1DwaXt2sAjqa9H6pXVpvZxlZmrds2qeAHBIr3LuAuujF5ks5/81Wmf0FP/aFS7sQpXIOgpsOKrhrFVeG/hRAHnty8yFXtJyrJOYqEr7pSrLTVx3moMcLv6K167cmpbMiey+s8RcBOmpi3px6VbqVN/nDPfZDA+kajc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(86362001)(38100700001)(31696002)(8936002)(36756003)(2616005)(956004)(8676002)(44832011)(4326008)(6486002)(38350700001)(31686004)(16576012)(66476007)(316002)(478600001)(53546011)(66946007)(5660300002)(66556008)(26005)(186003)(16526019)(52116002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R0fSxm+za1/AhaPYeC700/trL98Q6oQQS/Nzgab1LDwQcgyQtu00dgqf5PU+X8nNIqXJO8gG8g7vY1z0Iut3RglpcQzNWMSyMqAnyUL37JWNpLJVdTxYZStsLtcT8WT8WXsd233QYSghNxnhoIOvkn0Z/MSfzF+zn9w67dFs36h5XcZujAYOz+l5MV1uhSU3NMgU7PZN9KZU8IcgV4h+TBhANUUQ0wTg8ahDMoLUVHB8dx1hchD8NACL17zavk4nMQhWjlUdCRYE/7/+N7Gyi708iTs1iBgoqqStND0eitvLLu9J7cK/lNsgy9u2ICt4ssmCh6xMAAub8G4hzX9NLxAyNJvXsBk44A6wFSdGtBSE4NUXtytnLPC8E44mIZTRnuIinuzRtOHovFVgmwzfiEYFVw3YyRDsFcn4qlVAZLJiX3fXEEAMNO0fkdIBMp9WzvbdhljUcSWTeCbOJuv6dXMrDek3NpQyQMI0M3HD2ZtKoJeBUrFmy4PL0/1f4RyGGli1Rx7orRvlSYT6UTH6TLaszGJW1YnfMV1iqO/9T5caAqTs370rM8I0eJ/KQt0XW2s0E3b+vN0nS/oIO0MH2J+MMZDts3Y77SjsT7Uj83KlDnN0iXjYi19lzteP9FdwMkQQkH2L0i4k8VsPptI0sSc4GQZT+7TY2MIbGhGzniym09YYEnWG+4Rlkwpmu7TBUJycvEeqG00O65I0oRnwDupGHmSVSQcaefxr+66L2qM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6569a597-c1a0-44d1-4946-08d8fa0b562b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 21:23:07.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj9cGrQY6OfalM6pFctwFFUsDg0WJCGKSoA0k+GTBiEl4G1zziCfZJ+bNGps8Khw9BrNrwrr+s5ttF4JAd7aTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5277
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070150
X-Proofpoint-GUID: qtYvChUU_0aeE2NwmvDs6SMmaI5sd2An
X-Proofpoint-ORIG-GUID: qtYvChUU_0aeE2NwmvDs6SMmaI5sd2An
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 8:09 PM, Miaohe Lin wrote:
> On 2021/4/7 10:37, Mike Kravetz wrote:
>> On 4/6/21 7:05 PM, Miaohe Lin wrote:
>>> Hi:
>>> On 2021/4/7 8:53, Mike Kravetz wrote:
>>>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>>>> It's guaranteed that the vma is associated with a resv_map, i.e. either
>>>>> VM_MAYSHARE or HPAGE_RESV_OWNER, when the code reaches here or we would
>>>>> have returned via !resv check above. So ret must be less than 0 in the
>>>>> 'else' case. Simplify the return code to make this clear.
>>>>
>>>> I believe we still neeed that ternary operator in the return statement.
>>>> Why?
>>>>
>>>> There are two basic types of mappings to be concerned with:
>>>> shared and private.
>>>> For private mappings, a task can 'own' the mapping as indicated by
>>>> HPAGE_RESV_OWNER.  Or, it may not own the mapping.  The most common way
>>>> to create a non-owner private mapping is to have a task with a private
>>>> mapping fork.  The parent process will have HPAGE_RESV_OWNER set, the
>>>> child process will not.  The idea is that since the child has a COW copy
>>>> of the mapping it should not consume reservations made by the parent.
>>>
>>> The child process will not have HPAGE_RESV_OWNER set because at fork time, we do:
>>> 		/*
>>> 		 * Clear hugetlb-related page reserves for children. This only
>>> 		 * affects MAP_PRIVATE mappings. Faults generated by the child
>>> 		 * are not guaranteed to succeed, even if read-only
>>> 		 */
>>> 		if (is_vm_hugetlb_page(tmp))
>>> 			reset_vma_resv_huge_pages(tmp);
>>> i.e. we have vma->vm_private_data = (void *)0; for child process and vma_resv_map() will
>>> return NULL in this case.
>>> Or am I missed something?
>>>
>>>> Only the parent (HPAGE_RESV_OWNER) is allowed to consume the
>>>> reservations.
>>>> Hope that makens sense?
>>>>
>>>>>
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>> ---
>>>>>  mm/hugetlb.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index a03a50b7c410..b7864abded3d 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -2183,7 +2183,7 @@ static long __vma_reservation_common(struct hstate *h,
>>>>>  			return 1;
>>>>>  	}
>>>>>  	else
>>>>
>>>> This else also handles the case !HPAGE_RESV_OWNER.  In this case, we
>>>
>>> IMO, for the case !HPAGE_RESV_OWNER, we won't reach here. What do you think?
>>>
>>
>> I think you are correct.
>>
>> However, if this is true we should be able to simply the code even
>> further.  There is no need to check for HPAGE_RESV_OWNER because we know
>> it must be set.  Correct?  If so, the code could look something like:
>>
>> 	if (vma->vm_flags & VM_MAYSHARE)
>> 		return ret;
>>
>> 	/* We know private mapping with HPAGE_RESV_OWNER */
>> 	 * ...						 *
>> 	 * Add that existing comment                     */
>>
>> 	if (ret > 0)
>> 		return 0;
>> 	if (ret == 0)
>> 		return 1;
>> 	return ret;
>>
> 
> Many thanks for good suggestion! What do you mean is this ?

I think the below changes would work fine.

However, this patch/discussion has made me ask the question.  Do we need
the HPAGE_RESV_OWNER flag?  Is the followng true?
!(vm_flags & VM_MAYSHARE) && vma_resv_map()  ===> HPAGE_RESV_OWNER
!(vm_flags & VM_MAYSHARE) && !vma_resv_map() ===> !HPAGE_RESV_OWNER

I am not suggesting we eliminate the flag and make corresponding
changes.  Just curious if you believe we 'could' remove the flag and
depend on the above conditions.

One reason for NOT removing the flag is that that flag itself and
supporting code and commnets help explain what happens with hugetlb
reserves for COW mappings.  That code is hard to understand and the
existing code and coments around HPAGE_RESV_OWNER help with
understanding.

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a03a50b7c410..9b4c05699a90 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2163,27 +2163,26 @@ static long __vma_reservation_common(struct hstate *h,
> 
>         if (vma->vm_flags & VM_MAYSHARE)
>                 return ret;
> -       else if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) && ret >= 0) {
> -               /*
> -                * In most cases, reserves always exist for private mappings.
> -                * However, a file associated with mapping could have been
> -                * hole punched or truncated after reserves were consumed.
> -                * As subsequent fault on such a range will not use reserves.
> -                * Subtle - The reserve map for private mappings has the
> -                * opposite meaning than that of shared mappings.  If NO
> -                * entry is in the reserve map, it means a reservation exists.
> -                * If an entry exists in the reserve map, it means the
> -                * reservation has already been consumed.  As a result, the
> -                * return value of this routine is the opposite of the
> -                * value returned from reserve map manipulation routines above.
> -                */
> -               if (ret)
> -                       return 0;
> -               else
> -                       return 1;
> -       }
> -       else
> -               return ret < 0 ? ret : 0;
> +       /*
> +        * We know private mapping must have HPAGE_RESV_OWNER set.
> +        *
> +        * In most cases, reserves always exist for private mappings.
> +        * However, a file associated with mapping could have been
> +        * hole punched or truncated after reserves were consumed.
> +        * As subsequent fault on such a range will not use reserves.
> +        * Subtle - The reserve map for private mappings has the
> +        * opposite meaning than that of shared mappings.  If NO
> +        * entry is in the reserve map, it means a reservation exists.
> +        * If an entry exists in the reserve map, it means the
> +        * reservation has already been consumed.  As a result, the
> +        * return value of this routine is the opposite of the
> +        * value returned from reserve map manipulation routines above.
> +        */
> +       if (ret > 0)
> +               return 0;
> +       if (ret == 0)
> +               return 1;
> +       return ret;
>  }
> 
