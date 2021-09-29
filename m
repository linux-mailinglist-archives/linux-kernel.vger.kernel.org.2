Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426141CBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbhI2SZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:25:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24448 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244341AbhI2SZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:25:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TIGbqp013612;
        Wed, 29 Sep 2021 18:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UuwSj9V523tYqF3PQqm5hUeONVdytSjTb35/1gFMdIE=;
 b=YgojOVOpw+qztxhFeBuVhy67EjHjBgEn2mMMgfhapHY9t36tmNuG3vecCHMzjuqpWyW3
 YJZdmDL0QFGG9YQh5kp7BCT2ZqxhMKhY0G6g2oCE+Yj3CcQp36RUOfYiTKkEMMCkcjpM
 Zkfmxm0O6LORVujOCyCTb210k1BAvKsAlGjkIWne8ED7WD90Nqaz5J3kgUSzN0xZ1Tke
 aCb5Pi5ZK3IrehLyNZrK0S/ak+m5f0QLJsDujVRV2dbxXGp83jZgF+E7eldpoQGMp/AM
 763eJiwj4RVgsgGwClCO9FpmQn+KOHm/MIrEoKYwPi7rZscUacbHB8ajywdCLkuQxTyu HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6cwx8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 18:23:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TIAB69005014;
        Wed, 29 Sep 2021 18:23:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3bc3cenu3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 18:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJUS5puJhicBXYx3OqVuImr8xJze978FveS64/UPYT3+DdEkgFp4MRXRciKIu/07Kb0XqKFjoZaEVq+oeskNTHtVZfc0t5jjx42FnAV91j6T9Ye9+ZCToZisz0HOdsJKcLcoVs1KFy8yLq/jsMdD1e9aoC8124eM3KvPfQChs1gxhGDR6mjyEFeGiKPYe7NFO5h7BNTxXkcP/GEYvxcq7jz7L+tIhNK8y4AOw8apgRiyRf1vYcSKz5k885w0UcfQahzFuwPECPhfcuQdC4DWsOnBMCwYN0pAErISERs2qOFnw/jGm778zimi6bgdDCKXN2vn/OvOUWf7OBsIYfX0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UuwSj9V523tYqF3PQqm5hUeONVdytSjTb35/1gFMdIE=;
 b=IAdamRxN5MiGFB9gDw4aHUyzOcGIuhsEN3ciPmpo9ue5KLyn5I3WzmRwHwEUpwUqm9gAwqED8qRo+1vWXaTvQ2QoY6+WdYJrAh9v6/Sf6ZoKnWD1ycxePoeNjBuke6Xlb9u5Aquv70Ex+ghujNXo4wyMZ/T7BIL0CDwXz1s/E5g5N1/IvgE5ehVv7x93Wrwcicmyix8w3VxB8aXnu9QEb1CJXJOO4kRI2L8TwJ0xXylAV0ZbDzBt8AHloPzxRM5oaX004ynD6rzMv3LSAxNYPNYIwzJIW3QKOHmVUJm7xd35abWt3h0gvepsvpEdNenxoZ5wle+40Knx6vQtm4ymqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuwSj9V523tYqF3PQqm5hUeONVdytSjTb35/1gFMdIE=;
 b=zmuFLPVs/N9zGpLiCnZmEnxKwBtoKLrXntIbeQ/j0m2DoAWqvbEFBLVCmRFbnBv7sohlue9GgwEqCyZPzTg2KzSqElNj87JI+UqPPvHmU+wmZ2OF29rSW2VlfDSfhLL7KT2ZYoej//BgNW5LFL1wcfFl9kahKKKaQX8xtZ8k+oM=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3908.namprd10.prod.outlook.com (2603:10b6:a03:1b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 18:23:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 18:23:01 +0000
Subject: Re: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs interfaces
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-2-mike.kravetz@oracle.com>
 <878rzma1se.fsf@linux.ibm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8a50e26f-5d4b-1a52-fe96-8b01917120ae@oracle.com>
Date:   Wed, 29 Sep 2021 11:22:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <878rzma1se.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0359.namprd04.prod.outlook.com
 (2603:10b6:303:8a::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 18:23:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ce506c-e883-421b-0940-08d983762b73
X-MS-TrafficTypeDiagnostic: BY5PR10MB3908:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3908BC3842EDB5B311590168E2A99@BY5PR10MB3908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNCctxIJ201Nge4/IdI+HvsGB4QawEyvyjU+HFoC/VNDrEgcrbYKM65FMnyiYq56EM059crUfyHu36oBWstXgibvxw8jMWEokXlAsPslb//gy7pXmVKY9ZMs0P0um6kzjXcWwDCdsKeBAbCnwaXfQY3gPGCBn+bp/X/+042yVMXmOi8tzy3fnlm2vH6HlV3HstkZ4D9uPUFKcq7VCbNBeOdS1hLXBgGlkdu6D4Xu70Lvt6ja7Gov0h1PtoLaWoUinOQI5aJ7kvtkhZ/tgFKBlTpAXrWytIrcK/fMYX+V509M1rn8wdQfhYs5M3tZhIKrDmUUIBUPOk43nmW1L4ob6i9+MYX+98n3hgRFEM6cxerAvMAxjSiIFm52ctyNHivTS636bUinB9BFwaU59nVwppEGlKuRxBcwykeWn0JtUecW9F3zCE5P81uteHkooOv6d+iljZHa/8UxmfCXfxm6ZbBWebe9CEGwGjeb42FERUPoZk0SdVTfFSrtXIOWKlb6x+VQuNU+PYS09yfI36I2rWxOrVeEi5GNJuyGbgxwokqWaECbdlfh3i4qMnrBxYZWxc86ZhQ10CZuF2g2KAc6Khidf64UHbZDqQaZUT1FqYdkMY7NLHDEt2WLnpVbjklHPfzQLpoOeq/Fikm2cngT6aWk/9iX7nWeA5lCR/IE2sOgFrZJ3rvoUVtu1McLJPjnmUhaAp03CgAqnsmR4xKLqF10Dl+Hs5MPKtTolcjlb9lf6drVoj28gO0yzNPpavYAS3YsZoW5pxsrG/tR1pig6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(2616005)(66946007)(2906002)(956004)(8676002)(7416002)(66476007)(66556008)(36756003)(8936002)(6486002)(508600001)(86362001)(316002)(54906003)(16576012)(26005)(6666004)(4326008)(5660300002)(53546011)(44832011)(52116002)(31686004)(38350700002)(186003)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdFREVxUjRCRU1rbmJLWHNJcFdSVDI4M2RrOHdqUzU3aVJKdm9CNWc2NlJV?=
 =?utf-8?B?dk5NWTI0UmF5ci9QbmNteFpCTmdRTkF4dXZRa1FFL04wN3VTL3dUYUZvWVpQ?=
 =?utf-8?B?OHB5VUltNm1Sb3A2RHlOWGJXRjZkMERCcGw2MzhRT1Z3MDVoM201T0NybTht?=
 =?utf-8?B?VU1ERXhrS3hXNS9mL2hYTW9nN3FxRUl6Q05keGhNcmhqSDVEbEQrZXFwcm1O?=
 =?utf-8?B?MnQzRjU2ZXJPWStuaTJMbjRXUXc4TkZjdThUTEplTXV2ODJDdk5Uend6NDVy?=
 =?utf-8?B?Q0ttSHFlRXdWVWwxN0x1UkYzakZUUVQ0MGVXRTZ3ZjNEaThvb0xjeThBMWxO?=
 =?utf-8?B?bFlJMkxrZDFmMGt0bnRYMFZ5M0tuTWdCMElWaWprWmlkUGxEcWYwNll5bURR?=
 =?utf-8?B?cGFkTXNjTUZIK1YyVFBpbTk1OU0vd0dnYlA2Zmw2QUJOUFF1Z1dqRFBja1NS?=
 =?utf-8?B?NlBYdVNWNlFQekJBbSs0eUh1QjdDTFQxNzhhZE8rcFluREEwNW90dUFDUzU5?=
 =?utf-8?B?NUtUY1VWZThNd2tqdDYySTlPU0t1MmxrZkYyZHBDUUlEZW50ZUxNK1Izcmxh?=
 =?utf-8?B?YmVPNEJnbVN5OVRmVkZIWE1WdGk5R0lYSE0zeHpzNHIzaWszVTArU1JPcXNQ?=
 =?utf-8?B?aHA1c1ZYWTcrMkprZHdyQTVIL1VaZDZPVGg3RnM5UjJjSUtzbXQvWmh2dWNm?=
 =?utf-8?B?WWlOb2YwTG9WdmVVMHpJRE82cFBXejVuZlFFSG5YMmZxUmJ6dWZRVHpiaHhB?=
 =?utf-8?B?UUpHL2pRdmU2L1MxUXV2RTVraWZMNkk3ZTNiTUcvazladzI4VndHa3dYTldB?=
 =?utf-8?B?T29pT1V0bTRsNmQwSGttc1ovbkNLZndIQzFEZGl0THlLaVVJckpuUWdpVDFr?=
 =?utf-8?B?ZktKMXhEamFPRXRWQjFYV1dTRHVFZEFQQWNrMTY1MHVNWWZCeHZCMjFMVHI0?=
 =?utf-8?B?SVp2Y2Y3ZkpsWk1jUEJnVVhyRHFtS1c5ZkJQYS9PNEFCUFFEbVR5MWZ5MXl0?=
 =?utf-8?B?ZnFtTWNKN2lhTHkwbllaTG4wQ3lBUHhwTlp6NjR0cmNUYWJLZ3J4QTU5TUdX?=
 =?utf-8?B?bW5LUE5oWXdqTG1NeEFySm5zL24yakRZWEx5QlR6YndCWWJEemt5aThGeGww?=
 =?utf-8?B?SEpXYUMzTGJlY2M0QXNrN0IxcENEaTUzV0ltSVZGUE1zV3BiVGlJendIWEpw?=
 =?utf-8?B?OVMxMGR2MWJqYTlPMlFvRzN2QVRoSy82dTM4VXdEaGVEUnBFUW5nOVJteGVB?=
 =?utf-8?B?ZnliSGVZMSszVmd5MVkxK2ZSRU81M3pXYk10K2x2SisyNlZQQjJqVFp5L2tv?=
 =?utf-8?B?SFZoL3ZUQU9XdmJGd2paZ05OQllELy9ibWxjTXJWTVNFdmYwWTJyREpiMDI4?=
 =?utf-8?B?RERkOG03ZFB5Rm0rTGJBWXVFRUlKUVNWTkQ2SXVRRlN0RkV2S21RSmNCZFhM?=
 =?utf-8?B?c1I4clQ1aFY1UzJYMXNNa3czaFdVSDYyZXdiMis1dXc1bHNnOXd0RXh1cFZa?=
 =?utf-8?B?cXZPUDV5YzJoa1JMT091WWRDME9SV3FsQTdGVUF5Q2RCSUJ4TFNKeHA1ZlR6?=
 =?utf-8?B?cnVsclI0TVhyaGhzWHRLMDZ0dVcwZlFHSDhYMGF4eW4xbEthMUVlTXlzVk5u?=
 =?utf-8?B?cTlsSTV4ZjlVUnVwUng0YUpWQkwxK2hvVzYremFJVGlPc3NEQXNpQWI0VWtv?=
 =?utf-8?B?UXBRckpMWDU5dlFlRUpkNE9aaTJQdXRzK0sybkp0VWdiblV1U1BQT3hwVmVt?=
 =?utf-8?Q?INbuKPR/G1c55z1ydOQzH4sVWFSGd1RxJl6euXk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ce506c-e883-421b-0940-08d983762b73
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 18:23:00.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQSKmEMMQ8ElNQBZAhcP+xIy10jiVNAenztjXHO0di6H9qfX/c4CD8kFtzQ4Ld3n7+1B8CU2Tg27e4xUkprjYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290105
X-Proofpoint-GUID: M0a8TZurdIjmbcmutCBko4ZugiLf5Bf3
X-Proofpoint-ORIG-GUID: M0a8TZurdIjmbcmutCBko4ZugiLf5Bf3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 12:08 AM, Aneesh Kumar K.V wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
>> Two new sysfs files are added to demote hugtlb pages.  These files are
>> both per-hugetlb page size and per node.  Files are:
>>   demote_size - The size in Kb that pages are demoted to. (read-write)
>>   demote - The number of huge pages to demote. (write-only)
>>
>> By default, demote_size is the next smallest huge page size.  Valid huge
>> page sizes less than huge page size may be written to this file.  When
>> huge pages are demoted, they are demoted to this size.
>>
>> Writing a value to demote will result in an attempt to demote that
>> number of hugetlb pages to an appropriate number of demote_size pages.
>>
>> NOTE: Demote interfaces are only provided for huge page sizes if there
>> is a smaller target demote huge page size.  For example, on x86 1GB huge
>> pages will have demote interfaces.  2MB huge pages will not have demote
>> interfaces.
> 
> Should we also check if the platform allows for
> gigantic_page_runtime_supported() ? 
> 

Yes, thanks!

Looks like this may only be an issue for giganitc pages on power managed
by firmware.  Still, needs to be checked.  Will update.

Thanks,
-- 
Mike Kravetz
