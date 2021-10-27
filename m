Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077843D798
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhJ0Xir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:38:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6392 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhJ0Xiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:38:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RMdKkr028933;
        Wed, 27 Oct 2021 23:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tRHNtuydyrtJQ40rZ8HqUFf04SLPQGiX/93IMjpfyHI=;
 b=CG71DOiOodtSzQx7TZFCiq454y/3fXeMWUMouR1X+QDV6znajRxGPypk6AL9Jj2rmFFw
 j3dD4Q49uT2zz8HMRTuJQUgawD+UE1cZeoyTeqTA2GRqX3fdrKAKVsZgKYkA2Rk2wOot
 gFFwg9cDcjhZ7admMCDQwGP3F+ru9A6RNta7LsSCJic1T9dpQ9EF7p9GHPa+6OdZqgnF
 Gmb9Ii0iW1dl1MLfg9Rl0awybnbZPbzea7V0yQTc7MKPfdv9KNsGIU/ZT8O76XHvp9qM
 g+V5i/IsJl6rnd8GtuvFHhgWT9AyXAWwHX1uA+gnpcS54EMMbcpgI2D1opUWsz0NMzAW KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fjp729-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 23:36:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RNZwYK093381;
        Wed, 27 Oct 2021 23:36:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by userp3020.oracle.com with ESMTP id 3bx4grw1aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 23:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs6L4HECHiXQ+ZDj4xLIsKMpxR4z04sVruRmb4OtW2x1VvCk5StNnYg84aYQwc2enEGXZZ9inSVCeovtlFtbVAY9ohdLVwa1wzugWJT4YOwh0GCUPkZY1w3F3kM27CvnUmJu13k8znX/X4+AlZbz0QBMuh/FM0rFLmlDGqWzzP1OSzhzhltUzTuWX7mORqihH3r0Xc2loVFSjTZpRcOwi2NYLnKW+/0OL7orRXrS2DfZQ8gtw8yGoEE39Ndx9tCrpP7aBEcxFO5UWpspIGLYZY67B9GHuuZ+MjNPCXPSZnJy7TVnClxPQykm4LdpABdh7LPzkgQ7B7cVfy+D7o8EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRHNtuydyrtJQ40rZ8HqUFf04SLPQGiX/93IMjpfyHI=;
 b=GaL4L3cgEq5BtCRQX/RQkv4aJiC3rOuIRVAe1iOfIQdqnlxdrJfALT1AUhzfFcTxspHcEk9grtaX4S12IebCUkiAzUA+6w0Zc3S+SKyv9LmuXg9MWkmxp+EZhY1WdUvzfzAPz0Hnmj97T2V2I+cICIrwA8O9WH9CSs15NYGE39HY0xceHw5FZbEd8/MQzQ/yTpe/TmWBQjx71Iznv29PfzjdXBjmIBiMwwq8JmfXO8cgtQK2H+zIN/gmBz1aZH/pIOb6kEqZJB10IH0YbJqNgayXbnZR2/kDwsdgG9jfdR3NL37QHCeHnMEFfJzxQRu87TMxwFjeioFfk/HPWg2cHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRHNtuydyrtJQ40rZ8HqUFf04SLPQGiX/93IMjpfyHI=;
 b=d/hZ9Tv2tVaCUPafyziKZ3+aTMi5rZDKF2ptXYqf367ny00YRfny0jd9eoiSS0XxkvD6dbzengJaWiCTWgEuiyvkJcN5i1spd0YPOnBrCC1toHu5OGXli+MD3LYmy4m7eEkRLMZvRB/8JTF1se+EPJyY4YGQ7GGVIvXp/GRk4Ks=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4066.namprd10.prod.outlook.com (2603:10b6:a03:1fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 23:36:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%8]) with mapi id 15.20.4608.025; Wed, 27 Oct 2021
 23:36:01 +0000
Subject: Re: [PATCH v2] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211020190952.2658759-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4374d9ca-fc13-1dad-14eb-5e3e47953620@oracle.com>
Date:   Wed, 27 Oct 2021 16:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211020190952.2658759-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR07CA0078.namprd07.prod.outlook.com (2603:10b6:100::46)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO2PR07CA0078.namprd07.prod.outlook.com (2603:10b6:100::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 23:36:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3470cd3b-0d10-4ed6-c8b4-08d999a288d1
X-MS-TrafficTypeDiagnostic: BY5PR10MB4066:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4066C55855787D7F66BCB7B7E2859@BY5PR10MB4066.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svBUkGIbCbWt89kjtFFol9s9xUnn/NXacvCzdgMii1TFzh4qtuhYMxfQe+gu324C/I8n7qn4oAmIJRgW+YYtEqad+VK3FULKRUdPaGUwGsXFg7VeBk8Y6/z89brlk2Sl444iiqNDvUSq7czgRRq2K3U88KErDiJ4KKk0JZW6oWKbd3gZVUfJnmSteJDqhm5/5/i96jj4uTi6ys+f74iAD8RXJt4PRcUBXE7LiTsIDZR4UJOY6SboeJ093qVnEXsuVRh6E+zwY5FVrvhvUTa8HaNfR7Lr5v3Fygjkac3mFpa8iXsZOq0/12DpggcqUEF13AQ+UUFWdif2iQykGU02qKAr8DcE4P8z27bHiV55vNnBeCyf0ZZtL6WfK4fhlHk5TJjBZXj1SM5ra7DlV352yTbDhRox0jR8n0xf2sL7xIggsO4aGeY77njVkyg0PS+AVXJKkwCG64U1oyEqS4EVeR2rvXOJiFiXIgoXzDN26q2zCKM9TdsPJ/0M3n5NCRhfrVnP4YYz+qyfo3iHXllOE4SUcakDsFNaOlJbpZ7gWCHfhGVuv4bIv/6oemYR58/EhE0o9fjPck/cQFkkYgz8V8Im/rT2EqnwD397GdaF5IPbTc31epnll69MW83DhHeMxnAQ8wIldN9rupEfjYoQi3LkyuvH4apq1Cv2L3nxcsI4jbXEAEjMofHY937Ec+yWK/VJu1dEwF1z8dCcR1TYc+8+EVA3s2/bMMyiqjiu8gXs1jJSis+DDli4tZwrTIKr82KHbhXzgrGcUjmo/hVnvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(66556008)(66476007)(66946007)(31686004)(956004)(52116002)(38350700002)(38100700002)(83380400001)(86362001)(31696002)(2616005)(8676002)(44832011)(36756003)(8936002)(7416002)(186003)(5660300002)(53546011)(508600001)(26005)(54906003)(4326008)(16576012)(316002)(2906002)(6486002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVFRG52ZkNXUklNeG1xYWhUWHk4R1Q0TGFhZ0NBV0Zsc21RN0VZaXh5OS9h?=
 =?utf-8?B?cGVqMXRyVm1wR0FJOEdzTEJlVUFrK29iYUs4Q2NLa1c5cnB5NjlmMWMzU0NJ?=
 =?utf-8?B?QjRLWHdTcURkZitNY2JFcGd0VURUNlRYS2lYMWljR3ZUYUFodUF1Yi92MWdp?=
 =?utf-8?B?WmJKSndab3RrMVo2RCtyZ3RJVElCa2F0WnRLUnk4YzFwSzFOTTAweDJNK3JT?=
 =?utf-8?B?N1Q4UjBOT1c2NjE4Z0MwTmlkaWxiWUhrTTBmWXFGNWo0aysxY2l1UEVneDN3?=
 =?utf-8?B?M1BrNXRDOWNmaGdjSmpSSWF1LzdsamxydlhGc3c0S3NFaGx2SG5IeHdtQXFW?=
 =?utf-8?B?VUhGVmdoZldaNCtaZDJYN1dubjAwUXYzVVlLaXRPdDJmYUJJOW9Rby94NGJL?=
 =?utf-8?B?WGFJNElOVWNkTk4wbEpqOUZ4Y2pkd2RlMTlKWkh2M21zNjVqRXFGMVNOTThj?=
 =?utf-8?B?MWxFT1ZhL0xnOWJqU2VSS0dPM1R3SVoySUo3R2F6bHJDeU45UjJCVWUyV1pp?=
 =?utf-8?B?LzkxckhEcVRVeDFndEdxbTV5UFF4RVhONmFmTk5SOUttODlYTzdqWTljdlVY?=
 =?utf-8?B?ZktIV1JubGFiMGV1Wm9LdldJY3U3ckpieGZOR0g4NEd0dFo4b2pVWXlseTVI?=
 =?utf-8?B?RnduOHZOekNXa1lZQjRqYnQwTDBBS3FhSStScmFZK0ZEei83MVBmTm1zQUpx?=
 =?utf-8?B?MEMxQmduMThvdHZ1WE9la1p6SG4yQnhta3RLWXRmK0ZkN0p2VnBsMFZQK090?=
 =?utf-8?B?cDRIam5ES0lXS0tjWHdwU283eXpHVVQ1dDFPb0FyYm40Y3VLVzdmM0JEYWx5?=
 =?utf-8?B?Ui9rR0F3eENWb3BCNlUvSmd6QkZMbWs1TVJwS3QycHZBcGI3SmNIWTNHQnhL?=
 =?utf-8?B?WjdyM2NOTHd4c28rR010ZDQ2VHRUSC9uSXNNT2hxNWIvWGFkcTdJK1ovV1lk?=
 =?utf-8?B?TG14SzRSZ2JCU0tiYUMwdGdCNytCdlZEUWJxTzRrRVZ6VG5neXR2cElDMjFm?=
 =?utf-8?B?djVWRjdRcDlNWHZ0cFErNksvdFIyajZQSTZWMnFab0hMeHpJUjNob04vaWtu?=
 =?utf-8?B?bXdoR1Y1dHcrWTBhaGVKNmxqNWpLZTdRZ0J6YjZHR0ZvY0NxMnhlL05XelVx?=
 =?utf-8?B?VlE3ZTBzZUVDZ2ZCVkk4WEY3MXJXdXFvdU9BRUtPZExGUU9rSWdZWHcrdTAr?=
 =?utf-8?B?a0JGdDJuczk3WEtjdEg0MXdrV3Z5L0FHUXhUTmQ4bHY3RjR0ZytxRUFpUndY?=
 =?utf-8?B?aFg0NTk5NW9FU25HSGlSQ3VTam9oUVg1emxYQ3laekRUWUhQaW9ISkVvZk9Z?=
 =?utf-8?B?WXNrRGRVWDVJT3lncEM5Q2hreFZ5c3hNbWh2SmpxQmVMS2JRMVVPVGl6VkhL?=
 =?utf-8?B?bU9Rb0Y0bEsyd2hrREw5ei81TUFOaHFCclk5ZUxpTFB6VFh3cjh2d1ZNM2Jv?=
 =?utf-8?B?ODhPV0Y0aHZKbUNPalk4TTVyNTgrVExqaEQ1MmE4RkVNQzB2aEpkUUJsUDJV?=
 =?utf-8?B?K0VMNDJsdTJQTUhjVmNySkZMUndsZzlpRUJvdHQ3dnZlZmMzTEU0d1A4b0VL?=
 =?utf-8?B?Y2NoUUFlVldGN3g2d0pnVzk1bUNDQnRJNU02WkdjWGhSK1U1NHZscWxQd1Rv?=
 =?utf-8?B?N1FtOFNLQk9VTkh5aFNqc0pwdjNvRmlyR0pDUy9taXEyZzRSM1QzbTJXeTJC?=
 =?utf-8?B?SnFGOGk4SHJTeDVRY0lXMWIwWFBxcjNnNWh5cW9lT1BYcmZ6YWxQNUpsUkNR?=
 =?utf-8?B?SzZYVi9OdFJUeVpNdS8xdmd4ZEkxNm1CeTdEblRhRVdVUXcxSEJRWTVTVkwy?=
 =?utf-8?B?eDZNTFl4SGpHL0w2NWhINWN2ZVJyeDNLclB5d2lUcnpKYnRHRTdlTFhDMEk5?=
 =?utf-8?B?OWtoL2ZqZWZ5dWNaaU1uTDZ6TVBaN2VEcVRweXlZV1pOazlQczhsakJ4VUVX?=
 =?utf-8?B?SW84QldPOXVZazdpOGppQ1N4Q1R6amoycjF1V0ZuQ01NcjlkY1E0K2ZjRjlo?=
 =?utf-8?B?T2JSck5HMzl1MHMrSW9nS0d0NUZ2eElyTm4xU3JIdnF1UHZhZ280MzdTRWEr?=
 =?utf-8?B?dFNIaCtybGQvWGRoTGpHdTlEcUJiaUV5aGtDRkh5bVZ4MzBrYXlocVl1SmJi?=
 =?utf-8?B?Mk93VnBXY0JKOUtRcjN5OHpRYStOMHNmYkZCVGFYdzZDdXZPb2RZWGhLL0NI?=
 =?utf-8?Q?icblRSXZ31pcURIIP6dl/Wk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3470cd3b-0d10-4ed6-c8b4-08d999a288d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 23:36:01.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QXgTYi/PptthfmUaLBAv4LCYaqLSDpNm0cngI1vDKLeL+o96073XsaVut8NjrSy2yy8Wlg5GOFUccQBrEsyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4066
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270130
X-Proofpoint-GUID: H74JjB5TmXs1sWM71zbVZ5Kwp_voCwnj
X-Proofpoint-ORIG-GUID: H74JjB5TmXs1sWM71zbVZ5Kwp_voCwnj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 12:09 PM, Mina Almasry wrote:
> For hugetlb backed jobs/VMs it's critical to understand the numa
> information for the memory backing these jobs to deliver optimal
> performance.
> 
> Currently this techinically can be queried from /proc/self/numa_maps, but

                 technically

> there are significant issues with that. Namely:
> 1. Memory can be mapped on unmapped.
> 2. numa_maps are per process and need to be aggregaged across all

                                              aggregated

>    proceses in the cgroup. For shared memory this is more involved as

     processes

>    the userspace needs to make sure it doesn't double count shared
>    mappings.
> 3. I believe querying numa_maps needs to hold the mmap_lock which adds
>    to the contention on this lock.
> 
> For these reasons I propose simply adding hugetlb.*.numa_stat file,
> which shows the numa information of the cgroup similarly to
> memory.numa_stat.
> 
> On cgroup-v2:
>    cat /dev/cgroup/memory/test/hugetlb.2MB.numa_stat

I know that cgroup can be mounted anywhere, but I think the conventional
locations are mentioned in the man page.  Why not use them?

v2 '/sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat'

>    total=2097152 N0=2097152 N1=0
> 
> On cgroup-v1:
>    cat /dev/cgroup/memory/test/hugetlb.2MB.numa_stat

v1 '/sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat'

>    total=2097152 N0=2097152 N1=0
>    hierarichal_total=2097152 N0=2097152 N1=0
> 
> This patch was tested manually by allocating hugetlb memory and querying
> the hugetlb.*.numa_stat file of the cgroup and its parents.

I have no objections to adding this functionality, and do not see any
blocking issues in hugetlb code.  However, it would be GREAT if someone
more familiar/experienced with cgroups would comment.  My cgroup
experience is very limited.

> ￼
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Jue Wang <juew@google.com>
> Cc: Yang Yao <ygyao@google.com>
> Cc: Joanna Li <joannali@google.com>
> Cc: Cannon Matthews <cannonmatthews@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> Changes in v2:
> - Fix warning Reported-by: kernel test robot <lkp@intel.com>
> ---
>  .../admin-guide/cgroup-v1/hugetlb.rst         |  4 +
>  Documentation/admin-guide/cgroup-v2.rst       |  7 ++
>  include/linux/hugetlb.h                       |  4 +-
>  include/linux/hugetlb_cgroup.h                |  7 ++
>  mm/hugetlb_cgroup.c                           | 93 +++++++++++++++++--
>  .../testing/selftests/vm/write_to_hugetlbfs.c |  9 +-
>  6 files changed, 113 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> index 338f2c7d7a1c..0fa724d82abb 100644
> --- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> +++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> @@ -29,12 +29,14 @@ Brief summary of control files::
>   hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
>   hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
>   hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit
> + hugetlb.<hugepagesize>.numa_stat                      # show the numa information of the hugetlb memory charged to this cgroup
> 
>  For a system supporting three hugepage sizes (64k, 32M and 1G), the control
>  files include::
> 
>    hugetlb.1GB.limit_in_bytes
>    hugetlb.1GB.max_usage_in_bytes
> +  hugetlb.1GB.numa_stat
>    hugetlb.1GB.usage_in_bytes
>    hugetlb.1GB.failcnt
>    hugetlb.1GB.rsvd.limit_in_bytes
> @@ -43,6 +45,7 @@ files include::
>    hugetlb.1GB.rsvd.failcnt
>    hugetlb.64KB.limit_in_bytes
>    hugetlb.64KB.max_usage_in_bytes
> +  hugetlb.64KB.numa_stat
>    hugetlb.64KB.usage_in_bytes
>    hugetlb.64KB.failcnt
>    hugetlb.64KB.rsvd.limit_in_bytes
> @@ -51,6 +54,7 @@ files include::
>    hugetlb.64KB.rsvd.failcnt
>    hugetlb.32MB.limit_in_bytes
>    hugetlb.32MB.max_usage_in_bytes
> +  hugetlb.32MB.numa_stat
>    hugetlb.32MB.usage_in_bytes
>    hugetlb.32MB.failcnt
>    hugetlb.32MB.rsvd.limit_in_bytes
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 4d8c27eca96b..8ba0d6aadd2c 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2252,6 +2252,13 @@ HugeTLB Interface Files
>  	are local to the cgroup i.e. not hierarchical. The file modified event
>  	generated on this file reflects only the local events.
> 
> +  hugetlb.<hugepagesize>.numa_stat
> +	Similar to memory.numa_stat, it shows the numa information of the
> +	memory in this cgroup:

        hugetlb pages of <hugepagesize> in this cgroup.  Only active in 
	use hugetlb pages are included.  The per-node values are in bytes.

> +
> +	/dev/cgroup/memory/test # cat hugetlb.2MB.numa_stat
> +	total=0 N0=0 N1=0

I would not include the 'example' above as nothing like this is used
elsewhere in the file.

> +
>  Misc
>  ----
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..0445faaa636e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -613,8 +613,8 @@ struct hstate {
>  #endif
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/* cgroup control files */
> -	struct cftype cgroup_files_dfl[7];
> -	struct cftype cgroup_files_legacy[9];
> +	struct cftype cgroup_files_dfl[8];
> +	struct cftype cgroup_files_legacy[10];
>  #endif
>  	char name[HSTATE_NAME_LEN];
>  };
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index c137396129db..54ff6ec68ed3 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -36,6 +36,11 @@ enum hugetlb_memory_event {
>  	HUGETLB_NR_MEMORY_EVENTS,
>  };
> 
> +struct hugetlb_cgroup_per_node {
> +	/* hugetlb usage in bytes over all hstates. */
> +	unsigned long usage[HUGE_MAX_HSTATE];
> +};
> +
>  struct hugetlb_cgroup {
>  	struct cgroup_subsys_state css;
> 
> @@ -57,6 +62,8 @@ struct hugetlb_cgroup {
> 
>  	/* Handle for "hugetlb.events.local" */
>  	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> +
> +	struct hugetlb_cgroup_per_node *nodeinfo[];
>  };
> 
>  static inline struct hugetlb_cgroup *
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 5383023d0cca..4b807292f7e8 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -92,6 +92,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>  				struct hugetlb_cgroup *parent_h_cgroup)
>  {
>  	int idx;
> +	int node;
> 
>  	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
>  		struct page_counter *fault_parent = NULL;
> @@ -124,6 +125,15 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>  			limit);
>  		VM_BUG_ON(ret);
>  	}
> +
> +	for_each_node(node) {
> +		/* Set node_to_alloc to -1 for offline nodes. */
> +		int node_to_alloc =
> +			node_state(node, N_NORMAL_MEMORY) ? node : -1;
> +		h_cgroup->nodeinfo[node] =
> +			kzalloc_node(sizeof(struct hugetlb_cgroup_per_node),
> +				     GFP_KERNEL, node_to_alloc);

Do you need to handle kzalloc_node failure here?

alloc_mem_cgroup_per_node_info provides similar functionality and has
the following comment.

	 * TODO: this routine can waste much memory for nodes which will
	 *       never be onlined. It's better to use memory hotplug callback
	 *       function.

Extra credit if you do this here and in alloc_mem_cgroup_per_node_info. :)

> +	}
>  }
> 
>  static struct cgroup_subsys_state *
> @@ -132,7 +142,10 @@ hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	struct hugetlb_cgroup *parent_h_cgroup = hugetlb_cgroup_from_css(parent_css);
>  	struct hugetlb_cgroup *h_cgroup;
> 
> -	h_cgroup = kzalloc(sizeof(*h_cgroup), GFP_KERNEL);
> +	unsigned int size =
> +		sizeof(*h_cgroup) +
> +		MAX_NUMNODES * sizeof(struct hugetlb_cgroup_per_node *);
> +	h_cgroup = kzalloc(size, GFP_KERNEL);
>  	if (!h_cgroup)
>  		return ERR_PTR(-ENOMEM);
> 
> @@ -292,7 +305,9 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  		return;
> 
>  	__set_hugetlb_cgroup(page, h_cg, rsvd);
> -	return;
> +	if (!rsvd && h_cg)
> +		h_cg->nodeinfo[page_to_nid(page)]->usage[idx] += nr_pages
> +								 << PAGE_SHIFT;
>  }
> 
>  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> @@ -331,7 +346,9 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> 
>  	if (rsvd)
>  		css_put(&h_cg->css);
> -
> +	else
> +		h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -= nr_pages
> +								 << PAGE_SHIFT;
>  	return;
>  }
> 
> @@ -421,6 +438,56 @@ enum {
>  	RES_RSVD_FAILCNT,
>  };
> 
> +static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
> +{
> +	int nid;
> +	struct cftype *cft = seq_cft(seq);
> +	int idx = MEMFILE_IDX(cft->private);
> +	bool legacy = MEMFILE_ATTR(cft->private);
> +	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
> +	struct cgroup_subsys_state *css;
> +	unsigned long usage;
> +
> +	if (legacy) {
> +		/* Add up usage across all nodes for the non-hierarchical total. */
> +		usage = 0;
> +		for_each_node_state(nid, N_MEMORY)
> +			usage += h_cg->nodeinfo[nid]->usage[idx];
> +		seq_printf(seq, "total=%lu", usage);
> +
> +		/* Simply print the per-node usage for the non-hierarchical total. */
> +		for_each_node_state(nid, N_MEMORY)
> +			seq_printf(seq, " N%d=%lu", nid,
> +				   h_cg->nodeinfo[nid]->usage[idx]);
> +		seq_putc(seq, '\n');
> +	}
> +
> +	/* The hierarchical total is pretty much the value recorded by the
> +	 * counter, so use that.

'pretty much' ... so use that.  Here is one place in particular where
input from someone with more cgroup experience would be appreciated.

-- 
Mike Kravetz

> +	 */
> +	seq_printf(seq, "%stotal=%lu", legacy ? "hierarichal_" : "",
> +		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
> +
> +	/* For each node, transverse the css tree to obtain the hierarichal
> +	 * node usage.
> +	 */
> +	for_each_node_state(nid, N_MEMORY) {
> +		usage = 0;
> +		rcu_read_lock();
> +		css_for_each_descendant_pre(css, &h_cg->css) {
> +			usage += hugetlb_cgroup_from_css(css)
> +					 ->nodeinfo[nid]
> +					 ->usage[idx];
> +		}
> +		rcu_read_unlock();
> +		seq_printf(seq, " N%d=%lu", nid, usage);
> +	}
> +
> +	seq_putc(seq, '\n');
> +
> +	return 0;
> +}
> +
>  static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
>  				   struct cftype *cft)
>  {
> @@ -654,8 +721,14 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	cft->seq_show = hugetlb_cgroup_read_u64_max;
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> 
> -	/* Add the events file */
> +	/* Add the numa stat file */
>  	cft = &h->cgroup_files_dfl[4];
> +	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> +	cft->seq_show = hugetlb_cgroup_read_numa_stat;
> +	cft->flags = CFTYPE_NOT_ON_ROOT;
> +
> +	/* Add the events file */
> +	cft = &h->cgroup_files_dfl[5];
>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>  	cft->seq_show = hugetlb_events_show;
> @@ -663,7 +736,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> 
>  	/* Add the events.local file */
> -	cft = &h->cgroup_files_dfl[5];
> +	cft = &h->cgroup_files_dfl[6];
>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>  	cft->seq_show = hugetlb_events_local_show;
> @@ -672,7 +745,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> 
>  	/* NULL terminate the last cft */
> -	cft = &h->cgroup_files_dfl[6];
> +	cft = &h->cgroup_files_dfl[7];
>  	memset(cft, 0, sizeof(*cft));
> 
>  	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> @@ -742,8 +815,14 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>  	cft->write = hugetlb_cgroup_reset;
>  	cft->read_u64 = hugetlb_cgroup_read_u64;
> 
> +	/* Add the numa stat file */
> +	cft = &h->cgroup_files_dfl[8];
> +	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> +	cft->private = MEMFILE_PRIVATE(idx, 1);
> +	cft->seq_show = hugetlb_cgroup_read_numa_stat;
> +
>  	/* NULL terminate the last cft */
> -	cft = &h->cgroup_files_legacy[8];
> +	cft = &h->cgroup_files_legacy[9];
>  	memset(cft, 0, sizeof(*cft));
> 
>  	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> index 6a2caba19ee1..d2da6315a40c 100644
> --- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> @@ -37,8 +37,8 @@ static int shmid;
>  static void exit_usage(void)
>  {
>  	printf("Usage: %s -p <path to hugetlbfs file> -s <size to map> "
> -	       "[-m <0=hugetlbfs | 1=mmap(MAP_HUGETLB)>] [-l] [-r] "
> -	       "[-o] [-w] [-n]\n",
> +	       "[-m <0=hugetlbfs | 1=mmap(MAP_HUGETLB)>] [-l(sleep)] [-r(private)] "
> +	       "[-o(populate)] [-w(rite)] [-n(o-reserve)]\n",
>  	       self);
>  	exit(EXIT_FAILURE);
>  }
> @@ -161,6 +161,11 @@ int main(int argc, char **argv)
>  	else
>  		printf("RESERVE mapping.\n");
> 
> +	if (want_sleep)
> +		printf("Sleeping\n");
> +	else
> +		printf("Not sleeping\n");
> +
>  	switch (method) {
>  	case HUGETLBFS:
>  		printf("Allocating using HUGETLBFS.\n");
> --
> 2.33.0.1079.g6e70778dc9-goog
> 
