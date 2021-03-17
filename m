Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09A633E2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhCQA24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:28:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57266 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhCQA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:28:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H0DvPQ020518;
        Wed, 17 Mar 2021 00:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rrMNDZRHw3/5tvJ/f0NFSDfikPvbKq3hmNNorlrRR2A=;
 b=BotGGNAaKObMl3sMWg29bBOzhvk98KwJnFV98nD4uaByf8M1dyNnX2Mn26HXFJnfSom+
 0ArL8dZNks3vqNf7fLlLKg0awVypdXaO3c6DN8vf9AjDZJJRmWMB4fSv1VEan3iozJmu
 M0Nv5hu/bR3PipXNp75dx8STp3hHuWJGUMt0VuA6NNZalWSRcjLLwyEzdcP7SM44KuEo
 qQND9BT0+Swf9FcKZKVx5bZNEFt2zoYKYWcy6YZl+xppKPXsOor5M62/dvY5o+5lxW6A
 atAKIAnQNX6m/9C8au6PZXtuxLJlBqY+7twEnXuKh91nzajBYf+u/Ygh0+QUSZokDYGK Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbjfs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 00:28:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H0Fuuv030412;
        Wed, 17 Mar 2021 00:28:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3797b0t5hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 00:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0fGQjEtNt/Z80/nJhN8CrWr/pCjg1/Su7ITzLeYdA5Q0LJ2XHz/Wp5se3UsQyoDpGIUUetlXgjKsL4bcevisfJFRws19QLxW0nCZKhIIjxG1f2GIJYF6ttJ3PuvzYmQhPmOwwDVLwScXJl0T8PPe6mqs2BSLPzgKWQtso07rEGijWDdk83FCH+DzouSBb735dspZC8wa6PebbJcdfUGTrXSu1dSb+FKXLO5Rfx2P8czs8wg7ZF68yCUECLxBty5oqUNdvt4F1NZdqguCmPnwMQmRuD6n4a7DoMvlYBdglJynBO5Fwr6af47fl/v6lxg/OJS3DDztlF18KflmShN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrMNDZRHw3/5tvJ/f0NFSDfikPvbKq3hmNNorlrRR2A=;
 b=is8fwilzAdMq1zk5eTq18PhXmJ70WvopqBIb+pXx/vdYkdVbl2bF/uMADCPbMXN0qgQkIbjVIz0lOXzo5Tqkpkn77iqMQMpXFy//zEUKZwlG5DjIw1EF02CZKhkVSRi5Pmdlsa5dsyA0pIiWv1CfeRHvhm9z5GrqE6qAY8ajoYMho0B1BpVRyi7ZD1LN7GgE4XUpZkP7Fc4oC4pxWnkAuGKXyzeXwsy7NIjbUyWe9gfVf5EQovfcnaJJ2Iwk7j98fkfpLdA/ffHjvuvpsBnW9FiF+NwWns2FOSZPpzn94PK8922zOeezh8BtADaE3ApaYqz4LelH8dXsk4MrWSy6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrMNDZRHw3/5tvJ/f0NFSDfikPvbKq3hmNNorlrRR2A=;
 b=Zubxfj2WpBfOA9uynEF6w+s5zlQQ90qU2S7k6IgP2F0zff3iW2VCkNG7OQ5xHwcyVZEbov2o8xvUF+HDXYX4c6uSaE8ITZDV4F4axq0MvYYAN8B3OGmZCQKL1pe55LQrRTBvzjn+KVtI25WwUHb9mamlpbLIu7dp3PL24gKBD74=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3542.namprd10.prod.outlook.com (2603:10b6:a03:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 00:28:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 00:28:22 +0000
Subject: Re: [PATCH v2 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210316022758.52993-1-linmiaohe@huawei.com>
 <d87264fb-0005-4f8b-7551-a5439108e9e1@oracle.com>
 <4b3e9ea6-69e3-493c-342e-92117f274e06@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <952e9130-a084-20a7-aa7c-486fe9ccc8c6@oracle.com>
Date:   Tue, 16 Mar 2021 17:27:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <4b3e9ea6-69e3-493c-342e-92117f274e06@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:303:69::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0012.namprd04.prod.outlook.com (2603:10b6:303:69::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 00:28:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43caa8f7-c145-4a64-a93c-08d8e8db920c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3542:
X-Microsoft-Antispam-PRVS: <BYAPR10MB354258E730B19E6D392DA2BBE26A9@BYAPR10MB3542.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgGcW9VnYYMOETKSJl3iksu951+AGTeGDtzm8mvE49i3hLIMQwttvi+WbTMnU5GGhwZTloD0GNMwS/SVqQ72f3Pe8lGdDdo9SFOg5Pc9F78tQ+waxG4ROMKEBiN7FG3sLEmStCcRub7aVdquP989hWe5MNBpzxcFj24Am7AIxZFaLpbf0Kv3mFuH9t1r0ydNT1fgJvUa+mhEtML45iASOPRWoyQ57d6D/dF9myfp/O3jbPGQertZsasV0TdU40Vm5Z378c9xIGvJ9WKPLK7Q4dnzuc+vTI9KhVxFJjmHWXpww2ol9/EOHd1137EjXjhtAu0RYHV8DGcPOGupJshA6kvcqjMUlMhzT6MwQTyKTDvBUunVycBpR5CxvhZR4dhSwouBYKjQKrGEW4yN8sbLr2DKFgfJVBJpvSIa2ocOTzzXULIl9+YEJ7KQhZMl32d2qDJO1oT0Tz87Zi4fRNVxqZ6i917JAkRHGfPez3nk0u0Eh1f47ydgyo+S3ZiMEQwy54UuBND3VlNbrQBO0E/DPCvjuryUAa34z22GK8sF4gKjztSwq5E5xsw7r3ylO5OSsAQrTcIAr7fBFECKKvDFEO8QZHsSeJL4Cd3qNk+6YPuPX/NhI7RMII4vAG/SPz5MQOG+xRDJ+uJSt0YZjK7HuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(83380400001)(316002)(31686004)(478600001)(8676002)(186003)(16576012)(6486002)(8936002)(2906002)(52116002)(6666004)(44832011)(16526019)(4326008)(66946007)(31696002)(26005)(66476007)(66556008)(53546011)(956004)(36756003)(2616005)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEhtRXZQVDZ2alkxMUJkZUJta09qejNiU3BLclVTek5May9HZkcvcmZza1F0?=
 =?utf-8?B?U1V5OXVsbzRIaUdIK0d5NlVoaVRxM3p6bzZnV0JnalcwbGErYUROWmd3ZUVn?=
 =?utf-8?B?dUx3Qms4L2k1TXBmdXU5SlRVclo0Z0NPZGg4eDcxZ1lXa0V3THJod3VEMGUy?=
 =?utf-8?B?SGRURzdTWTRPSEhVZXdvb1VqajU4eVFHSERBVTdBeU95K1pZT05aZlpLT0t0?=
 =?utf-8?B?WUFlTlRwV2VkRW0vMjdhamJOMExEZDNiZDhyc3ZWYU5kNmFyYWNWMit1azR0?=
 =?utf-8?B?VnZYZ3VhSVVLa2pnc0xvY1Urbm5WL2ZwV1ExVm11RjNZeHVweE1IejVpb1lQ?=
 =?utf-8?B?KzJNa1F1RkozRHhtNnpCOHI4bjR2NEZMZ21peDlSWGIrUTM5NVp6ampCN0Jx?=
 =?utf-8?B?UXBzRjk4VHJtZFppQVNUcVZCZ1hJTUI5WVZFSnk0Q1lVZlNXc0FSZU9LZXEw?=
 =?utf-8?B?UTVaZ0JVa0RVTlZ2L2dTZVNGRWI5SDdrZWRGNUI3WklkNHBuMW54ZHIyNlZY?=
 =?utf-8?B?ZGNxMk5zKzZUaDFiUDMzTk5DNG01a3FxcTUySjhtSFRzcEpQVTZpQzdkNFM3?=
 =?utf-8?B?UmxsbmI3NXJRNnlqSGlDSk1lcm1XUTB0SE9aNC9ST0pFcjBZTi9IQlF2YWFr?=
 =?utf-8?B?RVhndm5Tem9IVHdaMlJhSWQwZXNlTUYvRkRNd1h2Y2g4eHhVTlFvdytyKzdV?=
 =?utf-8?B?aFlsTWw0alJGWmJWaFhvWlUrZlc3TkU1Y1VWUmd2Wmo2RlhEWFhTd2RLRTI2?=
 =?utf-8?B?SFdSQ3g3dDN6YU9PNnVkRzFaVEdPMW9XblFkQlpLZGNBT255VGtwNmZpQWlk?=
 =?utf-8?B?ZEhPZkdaelZVSk5Vc2p5M3NwN3lacUVaVUlLWmtqMlVFU2N5WXpyV3ZKbU9j?=
 =?utf-8?B?WDBxcDZLdXFUL3VTS05yNUcwRlpGdkdETnlSQWF3K01NTnJsbEd3VTJHZ0pq?=
 =?utf-8?B?UWVGT3B2RE1qWU9WQ0REcFd3ZkJvYmpIYUVNS3o0dlBDZjk1d2JhNzk4WjFM?=
 =?utf-8?B?dERnQXpia00xMmtmQjNMNmF5dUNuN2NicjJNbUkvRWI0a2M3SlNWUEdubjhP?=
 =?utf-8?B?N1NIRU1VNXBRdEtsck95aEdmVi9VVkV5RU40QjFQLzh4dVBNM25BUFZnUXBq?=
 =?utf-8?B?K1ZaSUZpZ0hOVXIrYVkveUpFQnZyeCszQjVXN3B2eHAwaEhtMGZmTGE5Zmlh?=
 =?utf-8?B?QjFNZlkyeXRMYWw4UTlhVlJCaEdJZXZwVXZpZ3J5ZW5ONk1xVWpzUWg5WmR2?=
 =?utf-8?B?bG9mdkM4alBiOFFFOUtnK0JoWld2SlgvUi9ZK0E3TEJqbWpBbkVldW0xdUlX?=
 =?utf-8?B?czFZUHZsc1RnS21jQ3RCV1d6Snh0UlJaYmRCRlZPM2RrWlRNYzNEWHlVTFpO?=
 =?utf-8?B?R1hETllmTzFESU1NNTRPaUhhbVpORHViOW9KNGYrY2NNTUhSb2Q5UmIzUnJy?=
 =?utf-8?B?V29QYVFiM0RlRE9DSVhwMm13Q2NYMk54OXBUZlcxRmZjTmhCM015RlhzaDZU?=
 =?utf-8?B?N25yUGk4WUFWZ00vYWl1YXU4NGxEMmMrTEkyTXlOWmJFMFBKbUdhMkZHWmxX?=
 =?utf-8?B?YXpteTRlN2g4QXJZWFRsbzlFNTNWbmRhMU1xUm5Tb0ZVTzRoWFlZMTEvc1JC?=
 =?utf-8?B?YjNuQmNnRk55dXhvSjNBcERDbmswckxNQUI3bENZWGJzWFJMSE5ORVlDZllr?=
 =?utf-8?B?cUdFY2dOK3JyRE1QT3VZdU40OFNDL1NrSFhJbGluVjNscmdsVXllOVJVNG0w?=
 =?utf-8?Q?Zt2p+cHDdSfQPPoQnV4hDuHctpbZwkxZyYdN1P3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43caa8f7-c145-4a64-a93c-08d8e8db920c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 00:28:22.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zLYzRO5VpCSaXxOn1DKTGLfUky/0q2ezBAvTrv8iwNShbXS33cAeM9fmU6uUdUyNgB9+e1Z5blk8YvbkSaMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3542
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 11:49 PM, Miaohe Lin wrote:
> On 2021/3/16 11:07, Mike Kravetz wrote:
>> On 3/15/21 7:27 PM, Miaohe Lin wrote:
>>> The fault_mutex hashing overhead can be avoided in truncate_op case
>>> because page faults can not race with truncation in this routine.  So
>>> calculate hash for fault_mutex only in !truncate_op case to save some cpu
>>> cycles.
>>>
>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>> v1->v2:
>>> remove unnecessary initialization for variable hash
>>> collect Reviewed-by tag from Mike Kravetz
>>
>> My apologies for not replying sooner and any misunderstanding from my
>> previous comments.
>>
> 
> That's all right.
> 
>> If the compiler is going to produce a warning because the variable is
>> not initialized, then we will need to keep the initialization.
>> Otherwise, this will show up as a build regression.  Ideally, there
>> would be a modifier which could be used to tell the compiler the
>> variable will used.  I do not know if such a modifier exists.
>>
> 
> I do not know if such a modifier exists too. But maybe not all compilers are intelligent
> enough to not produce a warning. It would be safe to keep the initialization...
> 
>> The patch can not produce a new warning.  So, if you need to initialize
> 
> So just drop this version of the patch? Or should I send a new version with your Reviewed-by tag and
> keep the initialization?
> 

Yes, drop this version of the patch.  You can add my Reviewed-by to the
previous version that included the initialization and resend.

All the cleanup patches in this series should be good to go.
-- 
Mike Kravetz
