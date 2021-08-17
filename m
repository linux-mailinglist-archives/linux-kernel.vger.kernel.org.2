Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAAF3EE1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhHQA72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:59:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36278 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhHQA71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:59:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H0vwcq020158;
        Tue, 17 Aug 2021 00:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7i+p93t4s+HtQsLBEsxjdxFw2DPSemEV0l8nMMCaYXo=;
 b=lSo9LkbGYYeW/uGmvXFsxcVKH19DL3j/Tpe4XKeQpJcINK6DG5+h76qPW1w0HI5icyjw
 h/lDx4WkVhE7NxEALxuEmf2V1VwK6oVHDo8FyBGsMclumuqEX+XoIsKow3CLTxGie7vP
 WBJvYtsAfqCcsiVhSIM4bnwgcleTDDATdbCN6b+6vttwYduUnyMTBf1o7Q4PdMsuJSrY
 cxNMWqB6A5xojqmz+Btzd2XxevqpLrw/05xxYz+mJXZ5rKmD07rlm2gFRxXUhnqDFAiV
 X6rhfxdSrhIJb/L0Dohk8VCJQ6FKu+6fePaX6FZ53Z4DNlej5aoPTDhhA/BrMQ2xGmix hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7i+p93t4s+HtQsLBEsxjdxFw2DPSemEV0l8nMMCaYXo=;
 b=AjR2cjighjPTnGZ7If2re+PadnnFGE9BF8IgnpDFScF5o2wydDXg4bPl5K84QASZrvup
 HmmmKKLnYTlKMwiylv7KiM3BItokaHEcZpfxyX5cNdHLpb8KPc4GVGYpBJhXWeNgQhcN
 NgkTDXIi9mbbx56NyYi4O4dUUPexQDB47DWdpX0kRqYU5N0IPTKi3DAg7IK5fCA373lE
 +xyBHQVGqQv2n/wQiLDw/8T2Hz1JczXHJ2YXrmRdY+qX23/XwFV0O6hKKHf3Bp8/c8CI
 5l0UKXASXdBmSqnHraPoIv2dFYPkPr300DAbw4PwWezBRj5/d8hkHgVNH7hmnORphxYt mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af3kxubtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:58:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H0orvq059270;
        Tue, 17 Aug 2021 00:58:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vepf8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvQDqv5Uk0ZKFWX4cM+r/hQepz0N2WMuvyjrgmOdLi+xmAoYgcbEKahwEyfzdVLtsWi76uZzNJTex3ygSvcae61JwTtqmcr+F7RyjcYZl23hY//BqVXC/ByhoKyNzu688ciU/Jxpeobclvho5i0y6RAxmTHe4N8MOeSox36zh/OtpugBpV8y1In9KgmIVVd1KpwRu3Nfwu+CP50Ku3AIgqyrlJ2LgCWqTZm10SzoaiMtsXalr6WmaGLaXZtiRl665YCQSEbwjzXqsWhb93yPj2cdtZMwR7ijbUiICNmmTYj3tbivYCDkx/xtv2Q5JhqeE4qC/IgJTVbdoJp2qXL2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i+p93t4s+HtQsLBEsxjdxFw2DPSemEV0l8nMMCaYXo=;
 b=GxP4xz1jGaGjmCD95wj557PDBluTANhAfS7EpruZQcDgBEHGFEiHJ6FXYqH7Pdt+YQ7VF0OjZBIiJLnCVXVk7BKVEMPCfmJ5ddI5Md6lQihyt1PAbN1O+HqQtFNQ9zlBdBuhUu7zBxRaj5HIifVVpWAvGiUe57Skrp1Ky4IzcdECP5tNSc8iM+yeeJuzFkmhTi7hOU2nwFR1zdeSo4ee+WsmKEg1S5TtGGhOiVtJJ0VA6B98nKlDAU4eDjhjDgw6lWPTqtgshD33QdBtyo0NmL+2IOnTNtvNiq22KJ4YIZBz0RuoSohYMb2LHXqFQOkwbPfFg3J1ZC8s/9KtesADsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i+p93t4s+HtQsLBEsxjdxFw2DPSemEV0l8nMMCaYXo=;
 b=TxyKOgo/rXu7cNMFixfr3FXJlcRDWE68vdz433DV0Flle3+4F/FxapVJy+eBD0GPDysQ8pkhskSBMHwFevKhyWlgJMQHOwXVdb17CgfL7YTbqlk1a+ARjr6RzBMOnRTgbrI3K8xQ6j3NKnthxgfsN004o//kLhmi1oe0FZ6MI3M=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3301.namprd10.prod.outlook.com (2603:10b6:a03:14d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 00:58:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 00:58:33 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162305.b19bfa3f3ba7431a62ff205f@linux-foundation.org>
 <5dd4e07b-d2cf-63f2-fc0a-9b371b469a44@oracle.com>
 <20210816173959.950443c7516a2b178e2ec376@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <54fdf347-e12e-0d3e-6c33-8b1b7898876c@oracle.com>
Date:   Mon, 16 Aug 2021 17:58:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210816173959.950443c7516a2b178e2ec376@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0049.namprd21.prod.outlook.com
 (2603:10b6:300:db::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR21CA0049.namprd21.prod.outlook.com (2603:10b6:300:db::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1 via Frontend Transport; Tue, 17 Aug 2021 00:58:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4749635c-8031-4fb1-319e-08d9611a2310
X-MS-TrafficTypeDiagnostic: BYAPR10MB3301:
X-Microsoft-Antispam-PRVS: <BYAPR10MB33013610B5A7A3D125C10702E2FE9@BYAPR10MB3301.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHC8gikypl19Tbbd4EvPr8hFHLAcYAmAb08DPOMCrLzpTcesPLz+zTIoJdFFRg8tmM/3T1JVufe8NxOY/5miAs0htm3KTvU5vruhN4L41YnFMQFPJi31cYmWF6EdwaTh52Bsgk6Ew0UPgWq2+Gbi13v2lcvLy6rL/339R8Mbz28TKLS3mflk4/hNp1zB8A6uWWz8SESrBDxeh+jmEGz+hg3ULhvj/bpGnz+/AS6BtIE+/jvA5xXo8njkk/2cmaGUmh4+hqFKyM4a9hCjvfpdVpuYnBGKt7zcJLJ9BIAXCZNkACFQJQVeHWutX7fMzNC4umLCy+ki2qXPaycoJLKzUcqD4fTYmNvJx3CxqtqZmDQMcevX9KfE5wmOOIrLkeClKnPUmwBqhsn0STcHlu2AQNsVv6va0OuuIE4xPEqw+EXgox5TYymusCdq3ElT9LQzBn4VoeO1F5ivq9t4Qtul/B8+nSIp4hcCIjUfQABKnI1ZciS7jNoaYSHyDh551SQMWUkfv/x4gfQHgsaV4pvbQQMcO+ZYaXMa3/xPComdA4V1JfVXeDEIat6lzvDkim9ICFg8JAfEyJGZYl3/Ro2prm+V+wvgd/nW0MDNh86gWUO8e56x+K0xpT4Laz4Z23y6CV7D/TDk/icuPEjCRLDTfx40heiwfX75qXcICQucacr9lbn2T3gLjEX06nKsdeZ8cB3imAeJc9ihz6b2I4fJUoLSZJ16vzK3D2LHmjcu+1NjNwD/aYy13Xfhk6WfUrqhodxhFDmTqmuYEfW6jTbTsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(136003)(376002)(2906002)(6486002)(52116002)(956004)(83380400001)(8676002)(54906003)(478600001)(38100700002)(38350700002)(53546011)(8936002)(5660300002)(26005)(7416002)(6916009)(86362001)(31696002)(66556008)(4326008)(66476007)(66946007)(2616005)(44832011)(186003)(16576012)(36756003)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhVNDdpcU5Pdk5oK3JNRjI5TGhTcndXR1h0dFZiMHpjc3RXOTZSUkZ5SC9I?=
 =?utf-8?B?UUs4Y1ZVQ01KTzl2Ym95bDBNbGx1VjdkMU91NjV6ckxVTlpsWWJadldKL3Y3?=
 =?utf-8?B?QVc0bTk3d0dxK0RTUnNXWHVEVm5wZkkvT2c0aDc4Q3c3MzF6SlRWbTdSTnYz?=
 =?utf-8?B?SmM4a0hndkZsanBJUVZRb2FhN3lkNUpXTFVML0hHbFpucG5FQUZiMjBQYm1a?=
 =?utf-8?B?OUUwVmNUN2VUM3VzM0JJM0xkckx2VVZVV2JiMWJoR2tVMU1EQXVEWVRsOWlY?=
 =?utf-8?B?WlkzMzVjMUFkVjdJRFltYXJ2VWQwc003RXJqU1JKWnJGWE80VkI1Q21pUjd5?=
 =?utf-8?B?WGY0MlVTVFlXK09aZWhYazJ4cVJWRjROR3RiOHFVMldLSnpvRnZYdTdpYmlK?=
 =?utf-8?B?T3hUR0poL2ZOczF5aW1ZaUtDWmMrL0NVMG15UHVLaVMwMnZGOStCYzU1cGd2?=
 =?utf-8?B?L1JDbnRkeEF5SXI4bXBQcCt1SnFzTFJwcFoybXZvd094ZXRmMjBzcElweG04?=
 =?utf-8?B?Wmh5cUlURTg0bUNjZ2FHY1hqbm5YRlp6a0RRM1FIVXFra3VhVFQ5aFUxZWJI?=
 =?utf-8?B?SnJOdnhpVU5vaGpjVUc1WWlSS0RIcDhOSGZwSVV5WDZuQk5nTm5tQ0g2YnpU?=
 =?utf-8?B?TjRhZXREaENPOStFTUU3VVFJeTdWeUFJZ05pSHVXSityR09EbmZwRkh5YjFt?=
 =?utf-8?B?ajU0eGR3N1hCRHQ4MnJnK2J0NnBabUthZVNRV002WE9taU1MSXY4YU5kY1Ro?=
 =?utf-8?B?Y095cGlKcFZWRnFiWkpaalVkM2x3RTNIdlVFdGRNS1ZhL1B6c1QvbHgvNnFJ?=
 =?utf-8?B?ckVkM0xTTTdESHQvTGltaVRaZkNRMFVaWUZTditQd0d6VUpDSmx0WW54UGox?=
 =?utf-8?B?ZHFtTFd3MEVRWkNKUUhpOGdqLzdPVDVLSnhiSTBIZVNLVFJoSFM4RVp1bStl?=
 =?utf-8?B?ckRFQmxJdUYxSXFKeXF3dkpObzFwODl3VGxNSkhKNG1LU3I0NzRUSW9GeUQ2?=
 =?utf-8?B?SzhvdlJyeWhGMGpYb2ZOMk03Y0RwdnY2MlVNZTcwWG9KSDBJQ1BFZS8waXE3?=
 =?utf-8?B?YkFtbk1ZYmQ0ZFdJeThtL0J6YkJzMktUaGdlejZTdzZHdkxZbHBheHRVcTJu?=
 =?utf-8?B?VmxlRXVvaVV3OFQ1ZVBSLzBsZW93SWh3UkttSnliL1Q3cFRHcEhDWlFHNThF?=
 =?utf-8?B?c2JGbm5Kek03Y3lUQW5neWVCaVJ6b0NYNklxQ1B4TkJ5VHR0a3ZiM05vT29C?=
 =?utf-8?B?ZEZvN2pVajN2VGhvSTJHRS9MUjBNM1pocWRZQWFUOGFjRzNEdjBpSTVRcXZC?=
 =?utf-8?B?c0wzaEQ0YjR5MFdudXROVktyRW9JeG1yMUxvbTN1azhLVmtXR0swRWFaRUZk?=
 =?utf-8?B?QkRCNi9rZmpLcVZOelpJTzQxMHdlSDQwQkkwc3lFeWJWSmhnNm8zT3JMZnEz?=
 =?utf-8?B?T1IzaHpJMVlneFoxSUJycWo4ek1vdFE2eVZCVWVMZjR0VitTSWdVSzJNSXI2?=
 =?utf-8?B?WVBWdk5BQVUwQ1ZZNmN2bXFBYm5UMEQrTmNGdVRoeWZDK2N4RTFHWWh3Z2w2?=
 =?utf-8?B?bmV4ZDBLaEd3eEFNWE42RWE1ay9TTWpRWHRRaFFydjV1UWZlejRXLzFjbkVo?=
 =?utf-8?B?M0dtQlgzcnlrQU1rVGl1WURSVEhhWEwzaG9JQU1kV1ZkcXd3M2o2Y1Z0bllp?=
 =?utf-8?B?Q2xrcnVvL05JQzNzTTVnUmZlbTVsV093eGhiRkQvYktFV1k5RkEvSkxjcGNn?=
 =?utf-8?Q?k563n3Yybx3ra7CeI56dKyP0GvzoMcSIwKsEApZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4749635c-8031-4fb1-319e-08d9611a2310
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 00:58:33.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4z8QB2OhkkqJAJyOiPJmUlFiERvTZuKdNqrytnYtPXxAu2XMMzmo6dC2yolqMf3okKLGetube1uq6GSF5w13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3301
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170003
X-Proofpoint-GUID: r1xLxS7RtVOre2lHpqL9qppuZpwvjsSE
X-Proofpoint-ORIG-GUID: r1xLxS7RtVOre2lHpqL9qppuZpwvjsSE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 5:39 PM, Andrew Morton wrote:
> On Mon, 16 Aug 2021 17:17:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>>>
>>> And how does one know the operation has completed so the sysfs files
>>> can be reloaded for another operation?
>>>
>>
>> When the write to the file is complete, the operation has completed.
>> Not exactly sure what you mean by reloading the sysfs files for
>> another operation?
> 
> If userspace wishes to perform another demote operation, it must wait
> for the preceding one to complete.
> 
> Presumably if thread A is blocked in a write to `demote' and thread B
> concurrently tries to perform a demotion, thread B will be blocked as
> well?  Was this tested?

I must admit that I did not specifically test this.  However, the
patch series to make freeing of hugetlb pages IRQ safe added a
(per-hstate)mutex that is taken when sysfs files modify the number of
huge pages.  demote writes take this mutex (patch 1).  That synchronizes
not only concurrent writes to demote but also concurrent modifications
of nr_hugepages.

> 
> Lots of things are to be added to changelogs & documentation, methinks.
> 

OK.

Thank you for taking a look at this!
-- 
Mike Kravetz
