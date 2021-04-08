Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60372358FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhDHWk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:40:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:40:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138MdU24036965;
        Thu, 8 Apr 2021 22:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O1SKaZZc3+vzFgas/jD1skb3+agjYPys6ji+nUm3j+E=;
 b=C1BYbt86LXTgYzk+7YB9obytZiJJIA0J40fvQ7fr+QwSUWppe41BS44jg5UC7SClKd8Y
 rlfGWbTTa41GtuLyQByF8EFcdOKtzt+C1jPk4ycGO765fc1SXZrsibouJEbnZgtvwJGt
 zGhKKEncJ4Pgoj69+vJUHH6PuM/qT22PIFcJ4wtzXurlSN+9G1sIOoJzphMwMY76kf3a
 uvdWrodSNDTtNYKkJaWug5zSG9I2gmKDmRGDTwAVXxG7tcahapuoiay0jVmcu+Bl1REU
 Oxg1gsDDd6mxomnto65Wjb8kitFIGXUoqACzAB83gNdMVR9Rrv66bUYifPm4PsuCKvkE 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37rvas7hye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 22:40:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138MVCB8128269;
        Thu, 8 Apr 2021 22:40:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 37rvb1srb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 22:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZONH6Oh8HzBWw9J833rg7SI/EstAozNfakktxsEgLzxcccouGzmb0HuBoWt13LbYs67Rp0DjzswW3HzulX4yBkmzjofbRekYvtaw40iZQrNqPwaZZa4JtcA+qzALowdILD+h/NV0VF/G2AMFxFiWY1dQLTZseAzWL23jOqKQ1zaapexyDaKig7n7JctJfLU2Xn3iv6kmJi85m2FxEqiJ2bRfbQ4770mJK0ldtzpxs8Z+F/XrGSu1WYNC+DluvYW0Qz35uIjhN+ZMfVhM83l6c0Sc7mF4HF8qFJyHOoGSo5zH5R1GCgZSTlJmSfF3RnoycecEb+LFUGS7YOs56oBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1SKaZZc3+vzFgas/jD1skb3+agjYPys6ji+nUm3j+E=;
 b=AG1M3eSfTtHksSTKhE1f6HshMGlkI/eQmecSwkVCK/myiY0EMDP0JrVy9YzWlJyPW2SxATjyvcgdmBX0aU0dqm5HN0Z5dYzERdh5ArIpQToT+Sl/DAtgRwgScZrh1mcsCykPH3IwzuxdIWPZ4foy3+wcl4pz5e91Mrx6bjcdzxibsFi0Syez+B7ZIRZkXTun2zmgu6/7aR0bmv4ecvTt19XBqqVAat4s07H+s+1viykpZqrbNVB05UC7XdS0sIvCBTesyIIMQB75eJ9JJruxnGHV/vi3j3B1GiqOmodQAsklTYEY2cAywqq1quy4aO1s9K6VpB+sa5d6osxzNHtHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1SKaZZc3+vzFgas/jD1skb3+agjYPys6ji+nUm3j+E=;
 b=LNvfonuQkebXNXKicSRSh6T2EcMnJDVNeyUWsZhRCcASfuMYNQp/ona/ZKrfkhnGPFsF59Jglco4DIEuZxJFOiCkyRCgBILQ/GDv9viTdeHzqVOArm2OPmRE0QJcj+5vdWTIqIBQHlxIDrTPIE7FtdDxw5vECVrWsxX52chrIVU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5453.namprd10.prod.outlook.com (2603:10b6:a03:3ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 22:40:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 22:40:26 +0000
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
 <de625a4c-b5d2-696f-33c7-7876e0f81435@oracle.com>
 <178a2b05-ab9b-3d38-36c5-3950a3859322@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <934938f6-5ef1-a9ba-ed26-e1b5b6c6f437@oracle.com>
Date:   Thu, 8 Apr 2021 15:40:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <178a2b05-ab9b-3d38-36c5-3950a3859322@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:300:13d::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0016.namprd20.prod.outlook.com (2603:10b6:300:13d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 22:40:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443d7aa7-ec7e-4377-cf2b-08d8fadf4d80
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5453:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB545395A980BE54804C752A9AE2749@SJ0PR10MB5453.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w23aUxLv/DBrxXUXVP1AmEs+IjV6o/BcTBU5qWQ0CpSd8fLm1Kckg4ipMA/B1miSZosQJ7DCZGwk+p9nVTNNLN2OapqLiSpm7dbQNQLFNhuKTY1/olI0WlW94dcD0BDgVmH8FVoNatdE5+R9BtkK0FIJs6TQo+BEO4yY+rVSixnGNUE8SE2Uq01g3s2iV8aQEfzyrwqRSaCuFa/bMeQeGiyL8u2bqvEJfT1acTVBjlzMaiZPUO0uxOTGSslaUERwjzFxJqIFjoNvH3/w9G+ljWOthnUyECOoPg/H0J//L6K9pQJNzOHHnGqxfLU0Sm3G2EgCqQpGnIX6VkChzyzbKHfH4ExVmCv8JwC7e+WfCVbDp0eC38QgXAfKMvDUvnzUfQnQWpNDjANVgVCaOJ1N76hi3KoVP6AaHvrtCXA5hxwLoTrsANn0jTL5XLjp82gVnwdnMIestDJCCJ7151M+lFi5K+o8PSERxcANzmBe/J9gnQFpuT9Nj47UhRCE8gWTDhjbNqo6HC/uVCGGb38rXZaXXnspSrBfFkmB04obHI1gMXS06pEy43stR1qqhsx7IWnRaiH6zL3YhzGrSo4SxjQ8Bm+qhP/IUzGvO2mOuCdp6NlkuQ2DWJCktS7GUIl62nYSLqwjct31ETL3HrrKASQnW+XnE3AI1IUNFRurykodbFudljr0KWuAgcRSj0URrIaVv7Kf2yW8qMjRKacgqtPJdWMDMTQ3gJ5WoEyO7R0e02HAFkJPETkCj/n3SVDnJsOjwGdI/qdxBsRvaYOe6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(83380400001)(8936002)(8676002)(478600001)(6486002)(4326008)(44832011)(52116002)(2616005)(31686004)(38100700001)(2906002)(86362001)(956004)(38350700001)(31696002)(66946007)(66476007)(36756003)(66556008)(5660300002)(26005)(186003)(16526019)(16576012)(316002)(53546011)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?alpScyt1WW01c2xEVzJ5ZXhUYzhoQ01vSVkzNkFhR3lkbVZVdElkNSs4MGJz?=
 =?utf-8?B?dlJnaWVYVlI1bTEreEowN3R6UEY1TnpJME9HenkwWGsxNDdaaVAyM3RrVjZh?=
 =?utf-8?B?bS84QlBMUk1GYmhRSStoUlk0cVpBaGs2VkcyZ0JxNzE1M1g1VVp6MllGRTRY?=
 =?utf-8?B?N3NVSkRzOUdva1lkY3JpaWczSHErTE9FQVFPY0MrdEx2YVhIZXE0T0lxcEhk?=
 =?utf-8?B?MVgzNXBzQXVSbXU0YytCK1oyaU5XOWZOM3VuL01BTkU3UVMzQ3V6YkhSNkpX?=
 =?utf-8?B?aU15cHRUOUVBMXVFR2NaMDdESlpsU3Evb0czK1V0TkVvaHBkY1MzdzZLb3h5?=
 =?utf-8?B?RmRtQkZCVXBxa21STGVlVFhnOGY4ejlDTzJxcmJsb0E5bFRjdlJxQ2dTMFpW?=
 =?utf-8?B?ckpIcVQyMVhTVC8rZVRtRitXalN0ZVVsMEpQcG5IblAyeVUvd2d4bHVza2t1?=
 =?utf-8?B?UnJ5Qnl6bmhSTXVPK0d0cnBnOVJ0MWJxaEFyVFVMMXdubXcvZ2YwUFA5eWVp?=
 =?utf-8?B?Y2JrMUgrMkI4K1VoQjQvSXR4QjVWR2hSZ29QcW4yd01Jb0htS0Z1d0dJRXVH?=
 =?utf-8?B?NVIxak5LUWhCTy9VZGxNZm5uY08wUU5Edkc2dEJDSERCWVF0SnhPbnBoZWxu?=
 =?utf-8?B?eVNQYVg4dXNybFBYaDRudW9wR3NoVjBVVlA1RXN5U3RpY2ZmNmhwNi9oengw?=
 =?utf-8?B?aE9pbUVyM09lb01jNU9ac3RnS3RXWHBPTTR1RHdnNEhNMTM5SzVOUWZpN0Y2?=
 =?utf-8?B?VlhKd1d6c0JCYnR1OGdxeDBSUVpvTFlDaVk5S2hPS2wvY0VNRXRBYkZ6L1Zk?=
 =?utf-8?B?ejFTdUhjNU1tL2ZubUVBaW13S2hrYkVpbWkxa2wweDVuazFkQVlpSWtpOGs1?=
 =?utf-8?B?Zmp3QTVJZ3pqMklCV2g4dU5ieFBjem5ZV3RkZTVLbThzd0RIWitxLy8zWG53?=
 =?utf-8?B?eFh5ckxQVkdYTlBQbmRZdjc2S3ViWCsyaS9NeTZ4d2lWREVVY1N4RzJ6REx0?=
 =?utf-8?B?QkdUemVTeG1XSlBWQWNyVVYvWjc0ZVVYTGJydDNNWVBFUzIxVFlSK3hjeDF3?=
 =?utf-8?B?UnFDY29MQmdRWTQ1Z3kzLzdsQ1cwTXVHdGNUWGtUWmJLQnRiOGtZbkNEYWJ0?=
 =?utf-8?B?VEZ6Q2pLbjR0TndnUmwxSjAzQmVsSzVGYmxrcmF4MmxYc3Zybm1JWUFpUmUv?=
 =?utf-8?B?Q0wxSSt1a1YxNmZ6OGhvT0tFZDB1Rk0xUkFsKzI5NWdDYUVqUXIxQURPalVW?=
 =?utf-8?B?STdRY0I2bWlMd3BqbEhoRS9YdnVrc2VqMXpKZDZBQlRwQkhBSjdLdzFzS1Rk?=
 =?utf-8?B?MnBRUUFSMSt0OUpOTzFZVEZXWWpCc3Z1ZkJreEorM2RrUUNXSDFxNWwzaFZx?=
 =?utf-8?B?OWZFSFhVZUZmN3MzMzd4a2pNbVZ1aWpDWXhzWmNybmVKNGZMVm9Xbjh2TWhk?=
 =?utf-8?B?eCttWFFYMiswMzlzK3V0WnVNd3dITnZvYnNpMWoyQmZ6UXZpbkFpSFNUTURw?=
 =?utf-8?B?MTlvR0VOWkNxMlgzNUpvU3dOeThWZDR1UjZ2VkZ3WWdTa1BrQTJCM3QzVDBo?=
 =?utf-8?B?QjdBR1VKbXN3bkhUZ1JyRXZQdjZVUmtoQ0hxWCs1Ym1lRmtCcVhKSUNlUVRj?=
 =?utf-8?B?ODl5bFczbzZvZi9sZDlvU1RHR3NzdC9lUnlWTERkeUtKNndYVk5RRW1vVGJB?=
 =?utf-8?B?NWVVNC9MbVRSd3pqKzhsQVI0Uld4cTFBNUlEejJVTFFOeldib1I1ZFFzMytx?=
 =?utf-8?Q?uoWL3cbiLuNZtz2/+3435x+Iq0aDw5n88YfmnWE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d7aa7-ec7e-4377-cf2b-08d8fadf4d80
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 22:40:26.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xlltq2ZTdKkIQE+43lGabhf2DOduEfOoUVnk6RKLczVnE5OmP8G48ZHDltxj9fXY3C3xlz0FjERS9l23ajc7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5453
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080148
X-Proofpoint-GUID: crQhaScwYOCxnn7Dm12b0SfJZfTmw1tA
X-Proofpoint-ORIG-GUID: crQhaScwYOCxnn7Dm12b0SfJZfTmw1tA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 7:44 PM, Miaohe Lin wrote:
> On 2021/4/8 5:23, Mike Kravetz wrote:
>> On 4/6/21 8:09 PM, Miaohe Lin wrote:
>>> On 2021/4/7 10:37, Mike Kravetz wrote:
>>>> On 4/6/21 7:05 PM, Miaohe Lin wrote:
>>>>> Hi:
>>>>> On 2021/4/7 8:53, Mike Kravetz wrote:
>>>>>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>>>>>> It's guaranteed that the vma is associated with a resv_map, i.e. either
>>>>>>> VM_MAYSHARE or HPAGE_RESV_OWNER, when the code reaches here or we would
>>>>>>> have returned via !resv check above. So ret must be less than 0 in the
>>>>>>> 'else' case. Simplify the return code to make this clear.
>>>>>>
>>>>>> I believe we still neeed that ternary operator in the return statement.
>>>>>> Why?
>>>>>>
>>>>>> There are two basic types of mappings to be concerned with:
>>>>>> shared and private.
>>>>>> For private mappings, a task can 'own' the mapping as indicated by
>>>>>> HPAGE_RESV_OWNER.  Or, it may not own the mapping.  The most common way
>>>>>> to create a non-owner private mapping is to have a task with a private
>>>>>> mapping fork.  The parent process will have HPAGE_RESV_OWNER set, the
>>>>>> child process will not.  The idea is that since the child has a COW copy
>>>>>> of the mapping it should not consume reservations made by the parent.
>>>>>
>>>>> The child process will not have HPAGE_RESV_OWNER set because at fork time, we do:
>>>>> 		/*
>>>>> 		 * Clear hugetlb-related page reserves for children. This only
>>>>> 		 * affects MAP_PRIVATE mappings. Faults generated by the child
>>>>> 		 * are not guaranteed to succeed, even if read-only
>>>>> 		 */
>>>>> 		if (is_vm_hugetlb_page(tmp))
>>>>> 			reset_vma_resv_huge_pages(tmp);
>>>>> i.e. we have vma->vm_private_data = (void *)0; for child process and vma_resv_map() will
>>>>> return NULL in this case.
>>>>> Or am I missed something?
>>>>>
>>>>>> Only the parent (HPAGE_RESV_OWNER) is allowed to consume the
>>>>>> reservations.
>>>>>> Hope that makens sense?
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>>> ---
>>>>>>>  mm/hugetlb.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>>>> index a03a50b7c410..b7864abded3d 100644
>>>>>>> --- a/mm/hugetlb.c
>>>>>>> +++ b/mm/hugetlb.c
>>>>>>> @@ -2183,7 +2183,7 @@ static long __vma_reservation_common(struct hstate *h,
>>>>>>>  			return 1;
>>>>>>>  	}
>>>>>>>  	else
>>>>>>
>>>>>> This else also handles the case !HPAGE_RESV_OWNER.  In this case, we
>>>>>
>>>>> IMO, for the case !HPAGE_RESV_OWNER, we won't reach here. What do you think?
>>>>>
>>>>
>>>> I think you are correct.
>>>>
>>>> However, if this is true we should be able to simply the code even
>>>> further.  There is no need to check for HPAGE_RESV_OWNER because we know
>>>> it must be set.  Correct?  If so, the code could look something like:
>>>>
>>>> 	if (vma->vm_flags & VM_MAYSHARE)
>>>> 		return ret;
>>>>
>>>> 	/* We know private mapping with HPAGE_RESV_OWNER */
>>>> 	 * ...						 *
>>>> 	 * Add that existing comment                     */
>>>>
>>>> 	if (ret > 0)
>>>> 		return 0;
>>>> 	if (ret == 0)
>>>> 		return 1;
>>>> 	return ret;
>>>>
>>>
>>> Many thanks for good suggestion! What do you mean is this ?
>>
>> I think the below changes would work fine.
>>
>> However, this patch/discussion has made me ask the question.  Do we need
>> the HPAGE_RESV_OWNER flag?  Is the followng true?
>> !(vm_flags & VM_MAYSHARE) && vma_resv_map()  ===> HPAGE_RESV_OWNER
>> !(vm_flags & VM_MAYSHARE) && !vma_resv_map() ===> !HPAGE_RESV_OWNER
>>
> 
> I agree with you.
> 
> HPAGE_RESV_OWNER is set in hugetlb_reserve_pages() and there's no way to clear it
> in the owner process. The child process can not inherit both HPAGE_RESV_OWNER and
> resv_map. So for !HPAGE_RESV_OWNER vma, it knows nothing about resv_map.
> 
> IMO, in !(vm_flags & VM_MAYSHARE) case, we must have:
> 	!!vma_resv_map() == !!HPAGE_RESV_OWNER
> 
>> I am not suggesting we eliminate the flag and make corresponding
>> changes.  Just curious if you believe we 'could' remove the flag and
>> depend on the above conditions.
>>
>> One reason for NOT removing the flag is that that flag itself and
>> supporting code and commnets help explain what happens with hugetlb
>> reserves for COW mappings.  That code is hard to understand and the
>> existing code and coments around HPAGE_RESV_OWNER help with
>> understanding.
> 
> Agree. These codes took me several days to understand...
> 

Please prepare v2 with the changes to remove the HPAGE_RESV_OWNER check
and move the large comment.


I would prefer to leave other places that mention HPAGE_RESV_OWNER
unchanged.

Thanks,
-- 
Mike Kravetz
