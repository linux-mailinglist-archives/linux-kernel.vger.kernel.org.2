Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29D3EE1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhHQBFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:05:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35048 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhHQBFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:05:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H0uPUB028743;
        Tue, 17 Aug 2021 01:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x4AK6/Cerv/+PO+VpL4X6EALSkQQYQsOvUVdgv2+geo=;
 b=XhYkqT9lBROepES+aGdD/pq8hi5fWZeE1fyXEWQJoI+RWhh6KrqFa+ZJS1whVENR7Ils
 CiFaivEdj/7dAeAj5QQGbvXvIhXuQ38cf9OorhASXW+4QoGyEnEcFiEFengz7vMUchkK
 WCJFqGf/A3jA6D2R+wpsWAxhZffLAbzUIJ2aST7rjQQt8bOaocqMbAzHVjv/RpqIz6iD
 udPTTVSlwhAlneE30yb+ryvXF/fpZSGxMi0zZ6lgcPE2zNT/Ycx79OBL1GsUW3PWXzx2
 hRzhU8wDADFf2kQytISW6G1LouejtxLamJUq4J94pOSIq4z0P5XjX4KXUtibtCaIwIgT 5w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=x4AK6/Cerv/+PO+VpL4X6EALSkQQYQsOvUVdgv2+geo=;
 b=x3hD1kCcv+FDVTQSRI7V6xhTDOqtp5j5MMmEPuSDLWk6BPaIyxZau0dFcC4K5a7P4fKf
 sNvDasqBVmUWHb7wFZ+3t5zNTWK1LIuLkpr3JDoYUk85YP0DCq9gbtxMpw938Bm28usX
 LU86LifMnQj9+4JJd4oZ6db2Lso2KrE2y7zHyvHPBQnL2MGM31XHlP9MXv4/CnW1Hy1f
 pcMGE7M08NsuYlS3pjChoPj6zmE19JYKSv+D51V029T1Z1+cIkLJLRsVvM6+1PIUsYUc
 L3utvXVC29JRZoQDw/18HyduSlv9AadGDFNye/jU1Rw3/EjuDF+fs9BM/juvRSfszYgI FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbagke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 01:04:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H14sZV091938;
        Tue, 17 Aug 2021 01:04:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3ae3vepqt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 01:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQWum8KLaz2YGjSe9MyQ7AMc9EkXwXgxe7LYtZwNt6vcrnJiMP9wKwJYf0StubbxZXAd9sh3QTuLvQ0iW+GRc/CQ4xGEBATZF4DY2zlDIN6M4ky2I7EJHhHbKNJijv/YYJWk5QLbUl6gyipD7jDO9aclvtKYzL3JAbboGWWMr2RjOQ8hGabI+i84TC53nxE/r8Y6Q3rZC0NtcfyWWxA6pScsfKd0RKPakcCFpVQfEGqGIxq546ujlA8QOS51ntfDVwmj5F+dWzZQlqnfKFg6rzUoVNurs//NpMK3NcZk9xLPCDGj9wESdxxwAAw0zuVKHv3tO4B67akkIKhBnH0CPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AK6/Cerv/+PO+VpL4X6EALSkQQYQsOvUVdgv2+geo=;
 b=g3JEFNWCUv88GctI48D6J61RbQBKVrOJymg45rPc7/9XqPeodWnKPGyKM7509A8oq1jRxfME5+13IFWhIXh+7MyvkP9j04j5p0ivNXNY7rboQw1mvhr60ugH8zm0wAI5DAcaoLQ7u7zuUEKinkl+lmzsqkr+VH6AZMJ/CsI81tPU6rn6tuvRDMSOaLXAVfpTv2v59kfs2cL+9b3Fyez4+6Ea9NIEksRGCMOQHTAHrsWys+wqjaZ7t3Dx4Fr9Uuet7+OlPUfpHSSSEcT9Vn6D1iTNq7eCphoACGh8faCHSsvbujbLwokgMRQHXAkgBcQfTLRIgLKktpNGXsuw/FPBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AK6/Cerv/+PO+VpL4X6EALSkQQYQsOvUVdgv2+geo=;
 b=qr+Jm0d5Rl5VLTHYxrGZg9sXOnLoFvThXz64N/lIK3f9PP8+G1dGLoeRpj0pnNGlkBJ1yeHZglUbQeHUuMhXuFp/NNacogS0sAywSlkRLGIY3l2Liv6woPjLDFAmhx458CSeRIHX/cuS/A8msnh0cI5ZQAl6ATKGg3PN8r5n9dA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 01:04:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 01:04:54 +0000
Subject: Re: [PATCH 5/8] hugetlb: document the demote sysfs interfaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816224953.157796-6-mike.kravetz@oracle.com>
 <20210816162829.a228c4629b411900702b7f5f@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a87f3a90-9949-153f-fb97-c5381443a963@oracle.com>
Date:   Mon, 16 Aug 2021 18:04:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210816162829.a228c4629b411900702b7f5f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Tue, 17 Aug 2021 01:04:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce969619-d772-4b1a-8e85-08d9611b0601
X-MS-TrafficTypeDiagnostic: BY5PR10MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR10MB41159926D7A02C1ABE1A1F3DE2FE9@BY5PR10MB4115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crsEuROQeZ9OuuWnUegfUY9mJ2UysKB+WfdHV4/UyyVjE3wkzRkAVWn+EzuM2zSdmlGqCchKM9WhGqcu2bGRf/nTrkEq3sI4bfDuMM8zq5tcNq3Zk5unnFVGjBpgv6rb+JQbUTQD7AZkAyOJ4BXMlubtaMpEkx/Mz1oRTaWVj38FVgJnuWnFygmWmp67u22umGHee23z8rItc1Q23/G71aQFr26yse/Q/ByhAS98U/fLWbJF+XmKF8OzqZwHivCD5kf1V5c9oIu5Efq3Q+RaiaVNw7rxIDvcWV3Oi2MozlOyVYjE2xN8tH+4ypGOLniijNkl4LT4/f65VTOMvHgI9VrhBQYuOJbNeI0TP2FLPidZs+nsgzNxWZ7d/huyUcrOxbxhswi0BMk6Xi7W6afjj/qFPVlWEB9lKvnGvjtZeD6V1ISW1lL/4mkLt/7jaBBGflMzTEedsAXHNi5RsVtljoR0L0TKecx45C7kddD7Q48aQafGX/aACn/d5swtdxCJH/QNUYWzzw1ArY6Xr2dC8iLa8A2VkX8THuamimgtt0+GW6sBucoP+GDK9jHSEc5V9kOAmbxZxkelRV4MH21emErYKSKu3Atps1uAFLkcEpbHgMkkUimU2uDyijQ2XwFtNhhkwZX4+ri21zOWkkc58y/F2LYqeqcP8tanGpw88v/amkSX8xSO3EdT+atzqe6EAqLBIdItW3c71d6QcKtU1X2Tg2lUR0NkYF3821izgNYPZZlPPc5+STzsfU0rJpISoYV89TLeDGuKTN+NiMHgCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(36756003)(86362001)(53546011)(66476007)(66556008)(4326008)(26005)(66946007)(83380400001)(38100700002)(38350700002)(31696002)(186003)(5660300002)(956004)(8936002)(478600001)(2906002)(6916009)(52116002)(316002)(6486002)(44832011)(2616005)(7416002)(8676002)(31686004)(16576012)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHRvcEJPQ0poNkV5Lzg3LzMwN2VObTFIV1lLRFpBVExtRVNjNUtGV2VIMG5x?=
 =?utf-8?B?OHhpaDZwRXNVSUJRY1NCT2tvWGdPTGxGRVZMSzFMTFFFaTZiWEp2N3JpWTV6?=
 =?utf-8?B?eUt1aElMbUI5UzFtZUhkdzllZ0tWWE1UeUxKR1hDVVVWU2VOa1pidmppektp?=
 =?utf-8?B?UTJ4R2FmTjg2UU5qOFJEc3pXV25VM25VZGhMZXdRdUc0UDVrWGQ1V01kWlVx?=
 =?utf-8?B?dkhzYXJrTmlNRWR6MTJTbElVMW1wY0RWaVpFWktMZTZKUXZxeDk2Q3ZNZVJ4?=
 =?utf-8?B?QjVRNENnQ215eWx1K3pja0xoRXhIakhkNWhGODFuM0ZOUDdXSUsraTNJaStB?=
 =?utf-8?B?S2I2Rzl4RlRaVlZGbHBvdS9senZHd3Q4U0F0YnhYV2k0dVFYcURsL1hpRUZG?=
 =?utf-8?B?dkJURk91VDQwZmZ4VWlnOHdrdkZDSGxnQkhRTk0xM20weThiTjMySmhCNmZ6?=
 =?utf-8?B?OEpBWDNsNEZzUUJqNkVzUDg2dWF0OEFDN05tMVRTNGZia1R3cGJlMEp5cmJk?=
 =?utf-8?B?em1DVlhPaEd1UmRVVUhJMnVObUp4VFgyeG1rY3Frb3FTR0k5WXBBU1ZWdnZl?=
 =?utf-8?B?cW5aRmt2aFpjcThuYWh2R3BYb0JuYXdGU0pINlNpZVUwTjJBdTZHWWNpNExY?=
 =?utf-8?B?RDErejQ2VGxmdWNHRXV2TTlhTjRqZS8yNXpaakZ6QzlpVjIwbHVhMFRiYUgw?=
 =?utf-8?B?OTRhN01PTWpLS0xmTDZIak5FZEphdjBKR2phU3RMeFpOSFNrQW9HUVpMdUlW?=
 =?utf-8?B?cVJ3dzNqdmszSCtWRVJxdlVheEh4Q1pYN2IvOWU3WmdyUzgvcGppejdxNENl?=
 =?utf-8?B?dk84dmtRUkxTRDIxS0ZnQmV4TTkxTUJ2cmZTZWpHVlJwYnVpbG9yVjU3VERu?=
 =?utf-8?B?NCt0ZW5YWDErWkcvSGRmNGdmUks2ajdxTG1tbnFmVEEyYVN2bmpnUDhJcHNT?=
 =?utf-8?B?NW1IZS9FclhHL2s0WWFDWFdOWlFRS3pZcmFkdUpLdHVidmRvQ29aRzc5K1lu?=
 =?utf-8?B?U3RraGRvbFptbmwyVGlLUzdJdVFORTJ1RVBGTkowREg2VHptZ2tlOHJmSW9Y?=
 =?utf-8?B?aXB1Sy8xa0xoU2pNVml3REE2MnpWcUVHTUhabW8rUEhWUmQwbGZHNmpwWEJB?=
 =?utf-8?B?VUlsRXN1MktMN0dNWUw3RXZNQk14UG12WlQwdkdVZnBaNWRIazRKdUdVSHF0?=
 =?utf-8?B?UUhWamFaSjBZdXFnaGp0LzIwalhkNEdYbERjaDZQUXB0NGp0L3BFRzNKQi9V?=
 =?utf-8?B?dEN2RStJZU9pdlhDVmFMZlJzdXNadDVsNmR5N3AyRmpDcDBaMnp4QkVoYVYz?=
 =?utf-8?B?QzE4c3UwYTlqMUJ3QTBiU3BWMlN4M1FXQTZrV2xramdLRWVNRy9zTlcvbGxY?=
 =?utf-8?B?QzJJNStSMUVSVTVxcVZ2Y0MrbzQ1TnVKaU10Sk1LejhEamJDZHpCK0hyNWxy?=
 =?utf-8?B?Q3BjR0RBR2FzN1NHUXRkVC8vTTVybDFTZitKTVIyMUlqd3liTkk4Z2dPWjhy?=
 =?utf-8?B?RUl3Q085QzUyOTN6L0lheS8wL1l3UFE3L09RTERnMmM0VWdjUVBSSjRzZXRS?=
 =?utf-8?B?UnU1NjFDN0M2SVhsMFlENVMycWFaTkhSQlZERWpJVU1KVzNSTHBIb1F2Ulc3?=
 =?utf-8?B?aVRlNmVaZ1NGWDRRNVd6TzErWDFKM2JudXlKaTJlNXFBdEJKVGV2dUlzQUtS?=
 =?utf-8?B?MnBmczhHejJhYWJLcTNCejV3TG84V2dja1hRMVdkYWx4d3ZVck5QRFNiZnNw?=
 =?utf-8?Q?cR8Fu9XBEjNs6vq5Pr6kZ08i9t53Uy3AlWhG5hp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce969619-d772-4b1a-8e85-08d9611b0601
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 01:04:54.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8606ThfvznDX+oYfRRlvtBJsuRUfFJ9+I4EJk8SR4fBXTonF1bJWZ0MrHnWmnJ498YzAN4dlc8aYkG0re/kBYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170005
X-Proofpoint-ORIG-GUID: wXh8IViVFTj9LX9PFsPW_Hn0M5Qx-ef2
X-Proofpoint-GUID: wXh8IViVFTj9LX9PFsPW_Hn0M5Qx-ef2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 4:28 PM, Andrew Morton wrote:
> On Mon, 16 Aug 2021 15:49:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> Describe demote and demote_size interfaces.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  Documentation/admin-guide/mm/hugetlbpage.rst | 29 ++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
>> index 8abaeb144e44..902059a0257b 100644
>> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
>> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
>> @@ -234,8 +234,12 @@ will exist, of the form::
>>  
>>  	hugepages-${size}kB
>>  
>> -Inside each of these directories, the same set of files will exist::
>> +Inside each of these directories, the set of files contained in ``/proc``
>> +will exist.  In addition, two additional interfaces for demoting huge
>> +pages will exist::
>>  
>> +        demote
>> +        demote_size
>>  	nr_hugepages
>>  	nr_hugepages_mempolicy
>>  	nr_overcommit_hugepages
>> @@ -243,7 +247,28 @@ Inside each of these directories, the same set of files will exist::
>>  	resv_hugepages
>>  	surplus_hugepages
>>  
>> -which function as described above for the default huge page-sized case.
>> +The demote interfaces provide the ability to split a huge page into
>> +smaller huge pages.  For example, the x86 architecture supports both
>> +1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
>> +2MB huge pages.  The demote interfaces are:
>> +
>> +demote_size
>> +        is the size of demoted pages.  When a page is demoted a corresponding
>> +        number of huge pages of demote_size will be created.  For huge pages
>> +        of the smallest supported size (2MB on x86), demote_size will be the
>> +        system page size (PAGE_SIZE).  If demote_size is the system page size
>> +        then demoting a page will simply free the huge page.  demote_size is
>> +        a read only interface.
>> +
>> +demote
>> +        is used to demote a number of huge pages.  A user with root privileges
>> +        can write to this file.  It may not be possible to demote the
>> +        requested number of huge pages.  To determine how many pages were
>> +        actually demoted, compare the value of nr_hugepages before and after
>> +        writing to the demote interface.  demote is a write only interface.
>> +
>> +The interfaces which are the same as in ``/proc`` function as described
>> +above for the default huge page-sized case.
> 
> Are these new demote interfaces duplicated in /proc? 
> Documentation/admin-guide/mm/hugetlbpage.rst says "The ``/proc``
> interfaces discussed above have been retained for backwards
> compatibility.", so new interfaces need not appear in /proc?
> 

The new demote interfaces are only in sysfs, they are not /proc.

-- 
Mike Kravetz
