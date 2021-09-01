Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A983FD3DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhIAGh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:37:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42716 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhIAGh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:37:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181697v2019479;
        Wed, 1 Sep 2021 06:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DtlX4sBbkYqluQQ4Pu7EAVK1woJmMbNxtrIF8KSCuCE=;
 b=HxB0ciPLe/mqmONLB7MmpX3YpTCsT3AEU1jxZGREZ94rZGUsyu57F8TCZCRaUhnusJK0
 Ubd+9+mXeSkzPbQNVRJIa/5gvf8TJjj89a2Rfrzw4xWaHIecSfQJPZDLg02BO4+IrMH6
 wL9J5XZNspoHjuE6BZauHHPTiSMElDRnar6GvxzqUQZm2i9wJ8JdxPST55HBEdhVuXa0
 1Y8Pv5nPKnyEuhskqJvo76ZtbzhnKFhKh3OjpqpdGfDzUyKbI05x5ZLnG7IKrD3HFHtx
 rGsXYpRFy571jMtbNXm9snayL/z4q1y8i6IGPQiJKPkKCMEcPxxIecgbD3mzEESuGIMa SQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DtlX4sBbkYqluQQ4Pu7EAVK1woJmMbNxtrIF8KSCuCE=;
 b=nvjYD+xqPltAlRaqFefAbUB2uXhNEAoEa+bnRm5Wd+HoC18p4bfRefz5rBnds+Op7C2N
 LiF7qBQK9Bx4CBgTN2JBKEKmYkSEml+aRWn6vbY5OfjhUmq5I7O3xctwXnV+Cm1zekTV
 CJb10L72NrwFi8mUURP79QzS/szRNd+0AT+QHtR+snIzf00emYiIoZqvWHa6d/B976Ul
 kRVjx1lJMYAmT1HeWZjhUgbomVYpAv5+DNz979z+DYg1JZBm24elcI0hS1li1pfTxUjN
 ArjbeV+2I/1v5/7tqnfffLWIXzafDvqrOM81dZ8WZVTriT1EYzqUwZPpEYlzUTuF9Ghq EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase02bjxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 06:36:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1816PrQi102130;
        Wed, 1 Sep 2021 06:36:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 3aqxwv23uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 06:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcsY55VwuHlz3Pd+Fr7lkcd4KyT1LjLGgJk9xXNlg0LPrzHVtkJV46SO51ZZJHy6I8wM7EUU1UQAAPtA3vI0J9Jh0bBzm61zoPA8MIQl8BZ9G9MucZJTrj6RBK3j0Xj/qyqxsFEaefN0phpWkP8CAM0lEdbWLuBqr4Zy/5/s3ii65VqWzllCR3s9n9yHuQh031sUXBI7QMtVe69H/pP60XGDLWmkiw8uG6osy7sKOeBbf0vl6UTXRX74Ouq+1hpQDQzISCTqmnvuzC83YwKF40ywB9zDQ4Us46aW87CWrfFbfr2n26j1nZaRSDzMe+Dvs0pma3NAvbXdJfyjYnVBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtlX4sBbkYqluQQ4Pu7EAVK1woJmMbNxtrIF8KSCuCE=;
 b=TfgGSH5m34GEzCUcFkV6cZDTMhTKOvEJELwhy0vNnupbTmrhHSFOHalRWPao7AHauAeqKjeimxVQpcESLS2hM4g+SuYu+CpX/hSPkN+vn7s6JMiD0EwriiEWedvjR6Ft0NIY6UyzTsOzvzAr+6Y66Rjs2ByasQWMPKEqdhP8PpcIQa3gZeeIksJB4zEfYCGUIGGdtc+3O/42LUTEauQh9wOCcAWDRPFeUoGPXytFiuMs1tusaj1pdz6YDuwUfh5JqpsNb2h/JuhdIwtsAnAjegbSvh5N5VQo38nmJ4E72ZG6rSfrPlWAGvxs1xMjM1gTG9PCeqgAVFpVoYQSFuP6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtlX4sBbkYqluQQ4Pu7EAVK1woJmMbNxtrIF8KSCuCE=;
 b=QPLM5PoaKdprDurW1YD8/FbWo/2zWuiofcRkjDne3TGw4hHhvioMMUzXLFiWnnHSElHUCuXwv4DqRiNCV44YJ6h+7tP6Z6Gh7exTn6VRapfBCzF/4csBBWVm8sV5CrKnNUhhHhBkG/VmEgZyc6jDNPG4tZvqJOpgC1/FsjqypUA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 06:36:41 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:36:41 +0000
Subject: Re: [RFC PATCH 2/2] mm, slub: Use stackdepot to store user
 information for slub object.
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oliver Glitta <glittao@gmail.com>
References: <20210831062539.898293-1-imran.f.khan@oracle.com>
 <20210831062539.898293-3-imran.f.khan@oracle.com>
 <2772cf56-4183-857f-d070-c54bceb5c8d9@suse.cz>
From:   imran.f.khan@oracle.com
Message-ID: <2fecb5e2-1c4f-7403-7ef5-b55271bdb032@oracle.com>
Date:   Wed, 1 Sep 2021 16:36:32 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <2772cf56-4183-857f-d070-c54bceb5c8d9@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:806:127::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.191.132.27] (138.3.200.27) by SN7PR04CA0228.namprd04.prod.outlook.com (2603:10b6:806:127::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 06:36:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 175b49f0-21ee-4efa-0adf-08d96d12db93
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4500047F66B7C2FC3123DED7B0CD9@CO1PR10MB4500.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrOOfozuTfn2xgWpbN0OdTE8NzOUyv0qrtVdtkft03mCU+noqppOlXvfazFl2Bj9k0Bzl6yqPd09Ib+patvZaDhzu4XzDnESxVL4cF6sm2NlTYMahNrPiBFksGLoPUhackAXdCH1pZkXPeyMhriFnR2YFRs72JzHkdGGLaiivybFwt1tlzTV0Nv/WHPviyU75LwPKErt13wenDXhxuzy3OOx2fd5BO1keUutXi3TdOAlizVPcsFnbD6uCjEtWrPk9VMjQ2nBkJDZaZ0RemGSAppev62iVtwbewfmnHB0BMKTa1uy+kgxp9y9HnfAVKiDWg46seO5hFE2e8jjFmXxrwoYWkhSvM+s7I43yPHPkun8jxC3IGFKfplcLBwmidD920VvLZ6hCjdlnqUKAeE9tpyyliafyKnHnLNwMWyhu/CxHTkMlMQJhnkEpCWXDmjhrFZQEVHTq/1mNSPRY/X0rPPsPRyATIEE2VRtpYeDK8fDX7DK/3/789A2GE+2FIwJdMVBAmZSzwhjLgkz7QPD9AX9LUOR3zWOm3HG7dyhv6SpFB0mWXoDEHuhrB5inVGyDJ764SZMmZIsc8Au9kj1ZvIdCrC23FtLJfJV8xRdjN10V7BK1ZBD5cOhql3EgFbFiDlf0L44MMOWlyzfg6SAP+NSMwMYvDnsHQ0hTHiw9+rv9odoxjhq1oNDQeTUWJ1k7gym1zhM63Ar8v7PJ1WjPD6hnDqF0RhyVvB++HnQogZ95ka9cHzIieX5Qs/hzSRVyQZtQMLKWECJNRZic1F6ktLvd7CUaiU72BBXGZrhwQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(66946007)(5660300002)(6486002)(26005)(36756003)(2906002)(53546011)(66476007)(38100700002)(66556008)(6666004)(966005)(4326008)(9686003)(8676002)(31696002)(86362001)(186003)(478600001)(956004)(316002)(2616005)(16576012)(8936002)(54906003)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnFReTBYcUV3bFUwZTlLdlkzU3NzVnlKK1h2Q2JBLzhVUzFwQ2hkKy9peHR2?=
 =?utf-8?B?TjJDaGNCNnVSOFU5TDRWaEkrajZHM1dKSnM1eGlXV0x4SmhOUjdSQlVHOGl1?=
 =?utf-8?B?Q1RwK1RpRTJ4U3ZrYVpRaUp3aENZREpzQk03eS94cVhpeEtLa0IwQm9Na2Ez?=
 =?utf-8?B?TUdwaFFKeTFaa0tIalJqam00VTEzR0dzRFBRSkJBSGw3b1g5QUMwZ2RsN3Zp?=
 =?utf-8?B?QjRIR1o5bEd1ME80TE9JZGhUMnNNOThtdE12RUlNa0tMeGY4UzFpQUd4MlIz?=
 =?utf-8?B?RDB6dGp5T2pxT3dVMkRGYlU5V2FzTkJybXFLT2FacXRtZnczaHg5V0VWa1Nj?=
 =?utf-8?B?Qnp2NFlRQ2ZBaEgvVnBlckNrdVVsQURsWm5QVFo4Q1Y3eHR4UENGbXhlcnhE?=
 =?utf-8?B?UnhOWmIrcTJjbjl5RU5NRlV5aWZURlpLWXJtdUl4MWdoM1JIcDdOM1ZYQSs4?=
 =?utf-8?B?MnV2Ujk4VW4yWlBJeFo0dk9LcmdzdkhUMWVqb2N6ZzExYm9sS3p5QTdnc3Ni?=
 =?utf-8?B?b1k4MUp2UzFEcTQ1aVlGYlR5d3hKaEcrZnlaSDVteExsRXI2cTBybkRVaU1h?=
 =?utf-8?B?dC9GU1Zyb2lGeC9kb1VaRWJudVoveDFkR20xR3R3UFpnWTlQYk1tNlpadEd3?=
 =?utf-8?B?dER4MEZoZjBEOVdvYlNhVGxxNXNLMDVSbHNRNVNvTVdtcGNaUkVVTTFONGVL?=
 =?utf-8?B?cUxpaWJvSzBRWEwwSEpaR2lzTzVIL2cxU0dXcmsyRGxlWUxSdGVKSk55bFRj?=
 =?utf-8?B?WDZML2xCMThkakZINW4vVUVSZjJaTHdnTDVvZmpzd0JCNVYwZDY2ZVpvSHox?=
 =?utf-8?B?Vk10UjFpSStic21vL3pIQXpMMUNDMUYrZFdBU3p1Y2VPbWMwNWN6ZHZGVEJW?=
 =?utf-8?B?ZU9mQTM2cU5DbGtreEtvQTlRTjF0ejJiOXNrQ3dlSUpUUE50YUdMU0J1emJl?=
 =?utf-8?B?RStSeG5iUEtaSTZ1VjFJQldabEhvUC91cjZxa0RBMmErbnhsQVQzVWpENlVE?=
 =?utf-8?B?TGRKaWY3cG5zNThWdFZtUGVIRzRUM1ZhLzdZb281L2pBUityVldwSTI5U0lH?=
 =?utf-8?B?czBaeVVtKzlGMDV0cTRWVU9XQytJOWhkYUpHWG9nMmZGYWFwaEsvaDZublZK?=
 =?utf-8?B?OXVxTWU3VW1RYUk5bkJVYUVkOGQ0bXc5ejJxdzIxUFF0WTJXNDBJdFNpMkpD?=
 =?utf-8?B?cjF2Y0VLVjNNRTd3ZVdkU2ZYamxMREdKamwyVzIya1dqcmxSTHExSy82aEdE?=
 =?utf-8?B?TFlPVXBCaCtzZWFtT0lycVZUUGVqMTRSRXZyQzNMMHR6VHZWdlM1TU9RcWxB?=
 =?utf-8?B?R3UrUkZNVmtnMEsrRDVaQSszUUUyU1VjZjZMa1k1dU9WelRiMStVbnpmZ0Ex?=
 =?utf-8?B?RHNDamQ5SmJiZXdQVFpkOVc0WmJiOUs2VmkxVmthSnJocDlBMWdCU1Y2WU55?=
 =?utf-8?B?TllXeFk0eG5DMkhpNVhIckQvaVFCNkhGcG56NUMxMUFmVHZhMy9lWmg1YjJP?=
 =?utf-8?B?d3pUZDFhWUNGREFMbjNzY0xsdVdTQlcrSG1yMFZFZHZDWWVva291bWZmRTln?=
 =?utf-8?B?TmNrRmtNM1BHNmw0VkdTbGtmUTZCSkFwZ3FLcHpMR0ZtS0pIOVgrK0hJUVlI?=
 =?utf-8?B?Vk11WXdBWWt1NlNPQ0lvWXNkdjNCeGNDZi9OU0tReU1kSGx2OWhta3ZWRC90?=
 =?utf-8?B?YVplNlU0RzBzbUs3UC9KMSsvYWpqTWVhU0lxSVJyUHAyRUUzR3plMFhZVXIx?=
 =?utf-8?Q?wrAXe2seS4G5Bn6VLvFnEQ7tzqM4cc55aP5jbNo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175b49f0-21ee-4efa-0adf-08d96d12db93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:36:41.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U8LkxqnyS7SLX8bCJXFaG1CW5u2BpoC9KnCvlYqoA+6d8n0sxJGYXLri1BxA9Fr+7obOsQcHATQ0yUQiecj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010035
X-Proofpoint-GUID: RLxHCwO5TdHCaKvyY0jp1e76zNtEjN7d
X-Proofpoint-ORIG-GUID: RLxHCwO5TdHCaKvyY0jp1e76zNtEjN7d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/8/21 10:06 pm, Vlastimil Babka wrote:
> On 8/31/21 08:25, Imran Khan wrote:
>> SLAB_STORE_USER causes information about allocating and freeing context
>> of a slub object, to be stored in metadata area in a couple of struct
>> track objects. These objects store allocation and/or freeing stack trace
>> in an array. This may result in same stack trace getting stored in metadata
>> area of multiple objects.
>> STACKDEPOT can be used to store unique stack traces without any
>> duplication,so use STACKDEPOT to store allocation and/or freeing stack
>> traces as well.
>> This results in low memory footprint, as we are not storing multiple
>> copies of the same stack trace for an allocation or free.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> ---
>>   mm/slub.c | 87 ++++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 48 insertions(+), 39 deletions(-)
>>
[...]
>> +
>> +static void print_stack(depot_stack_handle_t stack)
>> +{
>> +	unsigned long *entries;
>> +	unsigned int nr_entries;
>> +
>> +	nr_entries = stack_depot_fetch(stack, &entries);
>> +	stack_trace_print(entries, nr_entries, 0);
>> +}
> 
> This function could become part of stackdepot itself?
> 
Okay. I have made this function part of stackdepot in my new patch set.
Please see [1].
>> +#endif
>> +
>>   static struct track *get_track(struct kmem_cache *s, void *object,
>>   	enum track_item alloc)
[...]
>> @@ -4297,19 +4310,15 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>>   	objp = fixup_red_left(s, objp);
>>   	trackp = get_track(s, objp, TRACK_ALLOC);
>>   	kpp->kp_ret = (void *)trackp->addr;
>> -#ifdef CONFIG_STACKTRACE
>> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
>> -		kpp->kp_stack[i] = (void *)trackp->addrs[i];
>> -		if (!kpp->kp_stack[i])
>> -			break;
>> -	}
>> +#ifdef CONFIG_STACKDEPOT
>> +	nr_entries = stack_depot_fetch(trackp->stack, &entries);
>> +	for (i = 0; i < nr_entries; i++)
>> +		kpp->kp_stack[i] = (void *)entries[i];
> 
> Hmm, in case stack_depot_save() fails and returns a zero handle (e.g. due to
> enomem) this seems to rely on stack_depot_fetch() returning gracefully with
> zero nr_entries for a zero handle. But I don't see such guarantee?
> stack_depot_init() isn't creating such entry and stack_depot_save() doesn't
> have such check. So it will work accidentally, or return garbage? But it
> would be IMHO useful to add such guarantee to stackdepot one way or another.
> 
I have addressed this scenario as well in my new patch set. Please see [1].
Since both of the changes suggested here pertain to stackdepot and are 
unrelated to SLUB, I have posted those changes in a separate thread [1].

>>   	trackp = get_track(s, objp, TRACK_FREE);
>> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
>> -		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
>> -		if (!kpp->kp_free_stack[i])
>> -			break;
>> -	}
>> +	nr_entries = stack_depot_fetch(trackp->stack, &entries);
>> +	for (i = 0; i < nr_entries; i++)
>> +		kpp->kp_free_stack[i] = (void *)entries[i];
>>   #endif
>>   #endif
>>   }
>>
> 
[1] 
https://lore.kernel.org/lkml/20210901051914.971603-1-imran.f.khan@oracle.com/

Thanks for review and feedback.

-- Imran
