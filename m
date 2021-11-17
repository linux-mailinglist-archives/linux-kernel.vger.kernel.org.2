Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C5453D60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKQBBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:01:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47920 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhKQBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:01:37 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH0IuQg023615;
        Wed, 17 Nov 2021 00:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o6qOGs14RnWH3fZbFUWdGAD1vqOzjaTWOVhYwhw1b1c=;
 b=VRL0R12DlXGQnV92hYDi1p5U5rEkeSYrfzd/Gw8KSitUDSIHr5M58gJlNJqRs/IkgxSs
 Q4T9BEvpUzI3ODqIDRTLWC3sA2TM5Q8V0n0nkFGq1ES4SIOL8D2KvZB+YD589BpVFEH/
 9ezBR2DwuaTkRg+ryIElX/qtM3JGogu9sAT4+gtvWeLsLigSkzUYk+rLlxhgwey0lqIz
 Id3cmikZ8VcM5whlzfgBYAVfShvNxb6NEmJi9o2Udr3m9ERZA9ZlCusEWNt7BBW7eOZi
 gaMxqQEe6G7vibdpZVnodnXUXSXkhr1hHo5XozOdhKix1aKoXYmF03JRqRMdBOalwuGm zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxwbmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 00:58:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AH0oQbL101793;
        Wed, 17 Nov 2021 00:58:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3ccccpdjh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 00:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoH1unbaPH6DNSs3XcTlOEeiDzPm7ZmaTHn6dW5tKmK8nhCVEsCjZKKKkEmGqRXR/X26HSOCFJ9TcPjDVzvb5uf9wBMsMt78tzkWZgwvdXZ6mq+Hg4jgBHgGrZXkT6RV4Vk/t5dFiMGo7NNw+QkJuIthVnZ6WAObgC/D8yVC5PVFVzZStezvxn9Av4h/0c6qPX9vLrdW/EkaEr70jxy/lOtutAF0UgK1TR5bkVkLW75IZXPpImadjjYHwfBmnr2u3bDFmu8opRx6vo/0x/6Bw1VjhGvPb6RL9+z/HXQK8w9QHQnypqEUf258B9YiWoiUcbepSFWgmrJj20ZoMiqogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6qOGs14RnWH3fZbFUWdGAD1vqOzjaTWOVhYwhw1b1c=;
 b=P+eWzifOFoNbPMtlKWUBuco+EBYB4Mid3fiEFYeRkX2fv2esqav6RP+l60ssKsoM109P803D3XGXpHq4EZ0eQSftKhtdyYMj2I9I3s/SpS2BO1YOJDqDgUTxe7DhGE39j07ah/PcEMErZhz0rPrXXM5ik+txy0LL9b+Joi4mjRrTGjifLX+AjJPKtizKfAXQApX9HPYGqFWmUnm9H06piShTUf6nWEVhklFsl8J/TKZMde8ynKbT+FUYOWvReemDr+0/ElQLbyK6Fa1WwdZe3A7+LaTXmgnsGfXCetlhT0yjIzUaBm4+HmOBya/x7r7sdHHqzH1kIG21ip6ev9Dkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6qOGs14RnWH3fZbFUWdGAD1vqOzjaTWOVhYwhw1b1c=;
 b=h9ptAtIHUxf4I2bEiFoKZHLdp1B/c2wbZswj8pPSR8MkGAFSzthStgdsrghlfTaMcPeq2yZXGVNsWnZmixc/OXFcgwjFu7ta/RFn0IQrrI8IlyBrSJgzcxbJ4SXC82Ogrq6U7Lvar/UpuEe86Jq32xhNllGlG4i2risWH6nsU9I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Wed, 17 Nov
 2021 00:58:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.019; Wed, 17 Nov 2021
 00:58:31 +0000
Subject: Re: [PATCH v1] hugetlb, userfaultfd: Fix reservation restore on
 userfaultfd error
To:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Xu <weixugc@google.com>,
        James Houghton <jthoughton@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211116235733.3774702-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e448b1f0-8826-ca7b-ad3e-bb6e21a22aa6@oracle.com>
Date:   Tue, 16 Nov 2021 16:58:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211116235733.3774702-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 00:58:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f387c4-1e2d-41a1-93b0-08d9a9655fe4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4509971E6CA4923DB3D6B0FDE29A9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPKF0lYEGXIsuTK9Y9Lz9eJuUx6RwZkTp3GnNHa7N1wybhvotdeOLktlvnPBwqEAEnLeswuIJDoxYOWbNNXP8+twM1UB5mLxcbV0nf4Sqkc8/vO52hIAl8KQ2cZW8M0xFqqsBna1wtbLYQTjyeLtXv/r8EVgss9g1SfF0G6rbrkuQEp0iKf6vBSngxEgFCIPS8U4vBZun32D2elofHmO3jdVhhyqsQkCFIz/FNTYYurmufpGG788RSgAPNWcevfAlRMQ3r9QwUAqKs8R5z+ooob1Y1eX/pVu2VJErIa1dirY11QwU29GVcvdDwDuUQOdozvcDk5CxqQvrN5+iVvQbZAu8wceCvycCktuAVgZhimgf9s2hxP4ZR6DWCHl8op42QHN4SlEOciMrPMJyVQBbQmL7sDNJVlIutdK26CjAzcODEOsTXnOXlzt2/dYo5lPKcFGmKg9w02UmaRvaGXxMtNjjIh90DHQTJEakDvzuT42dkClYlWkaV0GHgtjbf6KA4ih4/Ush0/nf/PryHGfw3HrTurKHoVDdeYX/LP/hsFTxDyOFTb9rnST5bMSfB6AqxA+QRnqpjP1+FaUqKPshojU8fHtRf2KKpEIpwPAH+pVEzlS3xNhieEbzPlNiIFYb36uYkVtvGhZjeFxBtdfxg8OH78N8voLHEc84YaNJFH1xZu8cHliALHeQF/2A7Xz9DTwgueSkcLrjCSehnM/2wGIwc4UQqDR1m0YTuCIh7/gNneA4qH50REJGS+47Gm62sf0wltHgR3/Oj22BjTQSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(53546011)(8936002)(66946007)(2616005)(186003)(8676002)(6486002)(26005)(31696002)(508600001)(36756003)(83380400001)(66476007)(52116002)(16576012)(31686004)(956004)(38350700002)(38100700002)(54906003)(66556008)(86362001)(4326008)(316002)(44832011)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNnc1phMVF2UE9qOGhRTTBvVEgzUEZOc1I3ZWU5b0MwWjF6ZnNPNHZwU0hh?=
 =?utf-8?B?eTVHOElIRlRFZFV6NFJjeGZwaWhtdVM4RGZwTVFFUE1jVU5lTXczZGJGK0JL?=
 =?utf-8?B?N0NqSHNEaWFvcVV1SFE3LzhPTUlDSFFsbG5ySGZyUXZGanRwSHI4dUx1WjB0?=
 =?utf-8?B?dExtK3I3dGY3dG5DcHJNdmhWWittU29RT2tqYjZ1SHowOG02Rm8vVVplSnVF?=
 =?utf-8?B?R0VlRWdqdTZuQnB1RmJxd01Ka2FnYU1Kak05aG01RzdVeEVtWG1yTzg3SXlZ?=
 =?utf-8?B?d0UwcUF3UG5RVU8vaXhZeVc5MWZyN3A3WTlicXo5eG5pYkhvaCtnVHhtZkw2?=
 =?utf-8?B?TWN4QnBhWjIvMlJjdzgyZVNqRzdRZFpnQzZzK2VjbmhQQk1kM05RU05kaHZC?=
 =?utf-8?B?TG9jTW5JVSt0S0h4SWRJNWNncmRjczgwdCt4QklzZm11VUdnaXQxeHk2RVpP?=
 =?utf-8?B?RUgwbE9XZXlPRGRSdEwrbjQxN3M4OE5sbmNOSnNvM1k2U21rUDVvU081SDVZ?=
 =?utf-8?B?NWhqaDZCN050Uk5UcHE0S0xDUDlUdG45VVRLK0lmZkhvTnYrYnJmeFhvclJK?=
 =?utf-8?B?M1lzOGY5ajV3bEZZeWFVQnpUSDNHTWZjaENxRWpVWnRrYm9EdmF4eVlyalNH?=
 =?utf-8?B?RDVLMGt4V3l3eFh2RFJGK1JHOW1wOXRyVDRIL293eXgyYTZuTnV5bWxyRnd1?=
 =?utf-8?B?NzlGbUJoM2ZtN0tTK2Q2aFk1TDZkcDBkZVV2d0ZBaEVWRlZaZmF3YWlmL2VW?=
 =?utf-8?B?R0J6aFUxZmgrQ1pQcnBOcVZwTVowakxBN1d4ZEUrSGRQbzY1WW9LbWtkRmhU?=
 =?utf-8?B?QUk0NDhxdnNPRFYzS1I5S0d0Ukd3WDNCVEpWczVMRnZxOXhnQWMwZVpiMHJn?=
 =?utf-8?B?VWJKTlk1WGQweUtFZHFCYkE0ZnFEYTFoMTlVRjkxTThYU2Q4MEQra1NXRDVi?=
 =?utf-8?B?QUxUS3hycXd6K1VobEk1bFU3dzlWOENDREwvNWxUN3BGbkpRaEtTdDhYRG54?=
 =?utf-8?B?UVZYR0tiZGg0MVZNSTBTUkgzMkp1c2JTZ01ERE1oY3Q3aFlDN2M0Uk5VMXhy?=
 =?utf-8?B?OStjVnBLS1RVZU9NdWd4MzdnSFhFUkt3S1h1dlFrMXhmRmZ4SU5oWDNDUGRY?=
 =?utf-8?B?aGVhODdHUTk4VDVlOGlpUEtRUlJDSlNaaHBiUXUvbkhZd3JHeXBhVGNsWWpw?=
 =?utf-8?B?RUwzR2dKc0d6RVQ1NTExSGFheTZDTEU0ellzOU11dVZudHhWZ1d0WjlKa3dD?=
 =?utf-8?B?T2N3NTB6UXpYczVxc2dGODJ2dkhCU2E0NW9CREJxZ0ZSSHZwQnBsY0YwUVVS?=
 =?utf-8?B?bGFnSEo0SDhmNThoK0Noc0RlbFRwQUltK1JGamlxanJNSGhCWHBvZ3hHT0do?=
 =?utf-8?B?WnZaWkJLRWNBeGUzcVVUcFdNTldUejRUYlN3TXE5ZWN6bm5NM09mUU5MQU5p?=
 =?utf-8?B?UHdCM1hXVEh2TmVPMWE2WHV3eDZoSWt6TjlsUkpWSnhVVG1DczN3WlU5RW5r?=
 =?utf-8?B?eFc4b0VRZEtjN2dacDhWYzJ2VkFTUmgveG5qdTNaUE9XS0FLOHFYZlh6bjBt?=
 =?utf-8?B?RnZoOUpPSHF4QjB6UWF6Vm5pZUpyWmhaU2tjQ1Mrd1k4NUp6ZEIrb0UzZEQ2?=
 =?utf-8?B?RXF0dTRTSWFLOUc5ZlJBS3c2SjZhWC9oNmY0d01DQ2hrbmxqa2lhMkFUZEN1?=
 =?utf-8?B?QVh2dVhZTzZiMUFyY0xPZW5MQ1hUM3dpSkppdmIrcHJNYWN1cVpyL2YvL0U2?=
 =?utf-8?B?Mit1MXBHSURvOVFVMGZWd0VvdmcrWjkrUEhjZG9LNUs5aGZXL0hlWGgwaUZ4?=
 =?utf-8?B?SUN4S082Z05EU0wyUGRtQWdnRElRTjUyS0M2aGRScXpUNFM1RkdlRU5zNkc4?=
 =?utf-8?B?L0htcFI5STdIbWp0QmRGSnJWUlhsV2pYQ1B4SHI3REZFZkI3Tjc5NWJpdnhS?=
 =?utf-8?B?bWd5cWt3QWl4VTZJQWkrQTRtQUpubTdEVk1VRVYrdlBxMXh6S1BLWmg5U2Iw?=
 =?utf-8?B?WnNjU1BlelNDQkFYbHhtUmdwK0xhaGVwVDUzWithYVlhSzhxVCtURjJuZjZq?=
 =?utf-8?B?Zk9mOU9jeEp1S3ZjYk1VOEIxaGlDaEduTklnY1JRdUpCZVdvVGhmdFF4SjVk?=
 =?utf-8?B?YXhqVHpOVy85elJuODhlODlBaE5LYSt3WTBLakJnNEhPbmNhZ0FPZ1lzSnUy?=
 =?utf-8?Q?DNW7ULjW9oaLrH/pvIIL228=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f387c4-1e2d-41a1-93b0-08d9a9655fe4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 00:58:31.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01MLG54aw4EBDjzz9PMUBw0seHrLmOBXN10lQF+MHlyYQ6pF2Hamlklr/RkTeGzMaQ7hM4Of+KPPexTGLPb3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170002
X-Proofpoint-ORIG-GUID: 3bhdRltO_yaQILQPcDaeUs4z0C0K3Jkf
X-Proofpoint-GUID: 3bhdRltO_yaQILQPcDaeUs4z0C0K3Jkf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject:   Re: [PATCH v1] hugetlb, userfaultfd: Fix reservation restore on userfaultfd error

To:        Mina Almasry <almasrymina@google.com>, Andrew Morton <akpm@linux-foundation.org>

Cc:        Wei Xu <weixugc@google.com>, James Houghton <jthoughton@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Bcc:       

-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-

On 11/16/21 3:57 PM, Mina Almasry wrote:

> Currently in the is_continue case in hugetlb_mcopy_atomic_pte(), if we

> bail out using "goto out_release_unlock;" in the cases where idx >=

> size, or !huge_pte_none(), the code will detect that new_pagecache_page

> == false, and so call restore_reserve_on_error().

> In this case I see restore_reserve_on_error() delete the reservation,

> and the following call to remove_inode_hugepages() will increment

> h->resv_hugepages causing a 100% reproducible leak.

> 

> We should treat the is_continue case similar to adding a page into the

> pagecache and set new_pagecache_page to true, to indicate that there is

> no reservation to restore on the error path, and we need not call

> restore_reserve_on_error().

> 

> Cc: Wei Xu <weixugc@google.com>

> 

> Fixes: c7b1850dfb41 ("hugetlb: don't pass page cache pages to restore_reserve_on_error")

> Signed-off-by: Mina Almasry <almasrymina@google.com>

> Reported-by: James Houghton <jthoughton@google.com>



Thanks Mina and James!



Technically, the issue was introduced by commit 846be08578ed.  See the

'Note on Fixes tag' in c7b1850dfb41.  It is true that commit c7b1850dfb41

should have taken the 'is_continue' case into account when deciding whether

or not to call restore_reserve_on_error.  However, this issue first

showed up with 846be08578ed.  But, this patch depends on c7b1850dfb41 so

I think c7b1850dfb41 it best for the Fixes tag.



> ---

>  mm/hugetlb.c | 8 ++++++++

>  1 file changed, 8 insertions(+)

> 

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c

> index e09159c957e3..25a7a3d84607 100644

> --- a/mm/hugetlb.c

> +++ b/mm/hugetlb.c

> @@ -5741,6 +5741,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,

>  		page = find_lock_page(mapping, idx);

>  		if (!page)

>  			goto out;

> +		/*

> +		 * Set new_pagecache_page to true, as we've added a page to the

> +		 * pagecache, but userfaultfd hasn't set up a mapping for this



We did not add the the page to the pagecache.  Rather, this is the case

where the page already exists in the cache.  Right?



> +		 * page yet. If we bail out before setting up the mapping, we

> +		 * want to indicate to restore_reserve_on_error() that we've

> +		 * added the page to the page cache.

> +		 */

> +		new_pagecache_page = true;





How about changing the variable name new_pagecache_page to page_in_pagecache?

Then it makes sense both here and below when actually adding to the

cache.  I think we could then drop the above comment.

-- 

Mike Kravetz



>  	} else if (!*pagep) {

>  		/* If a page already exists, then it's UFFDIO_COPY for

>  		 * a non-missing case. Return -EEXIST.

> --

> 2.34.0.rc1.387.gb447b232ab-goog

> 

