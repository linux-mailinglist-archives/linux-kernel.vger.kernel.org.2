Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECD4423DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhKAXWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:22:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19158 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232373AbhKAXW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:22:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1LwoZl031843;
        Mon, 1 Nov 2021 23:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9Ie73ki52DSrmKOWEGWef0BFISx1TleidBpYjtrt48I=;
 b=muC9q/3iSJRECobQOHHoeMIFiocOV0tT5OmblO/JL8Nsf4R48zmBEE3vxe7k5z2Nv2cE
 oiNVz53PKLbEe9DssUD1wIA4l2ub8GrHhLDZvXU7xiV9XjWtCUB4/jqq5+hGkFN1TU7A
 fHPpIBjTFGigZm5uTaGU1o0iIIKN97FwUE01R4igNC95ZXWEUfJkBKSU3b6c97WrWvmf
 SjQErNichsXqVa5Fqwf0vjvZoFGlkGBGHaSJSjiSyT9+BzHkphoDmZv+IQ/P0RA8jiRo
 X2oPWEeLoA57vvDd3ozvFXG5zBmowg/Nf2GW3CIVWkc03DpbBPTjzifJAQ9fv9Y6wAZx 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c2aa3c90x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 23:19:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1NFqsR009534;
        Mon, 1 Nov 2021 23:19:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3c0wv3gwm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 23:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAiPXBC3K39ZxUgA1Z1oDIViEevl3bX7HU1aOYiJR0JC6I9edejBd2c/ghcnoY42/r8/ENlaf6HsKPabU2xo1mXu/MKtGpqf8QH5vIkiwRll7XD++69OsAju09r6xo+8cNWN29yxOynpAo3PrtZKvX3xxHnvOYD8sOKN4QAinffu9ESzbwVbxwDrrLrXUCgathcwx6Aj1P1RBiI3UEGK6MNyXIQcpBDHrYCQ2RR82gzsiH50kPLBJPRI0mskTbM/+56Mr1eNBCmR4szx2IKxrA7D4Z/OhbMAyxUWLHyoa+xbRcjY9KSMZe+13MoxwCgV5OwJctmfkPlx+J1NEgyomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ie73ki52DSrmKOWEGWef0BFISx1TleidBpYjtrt48I=;
 b=YgNnbM5knmfFz6ANlDQ+DCeDnc4OCNz6pBt0MNVoTsBSceBAeqvTJ9Ie+kcBbWhq2OFQIpsF9zXB29RABa2OVfuwPLxNJqT9Ysdu1cbhqppIloIBQ1aOL5mhuS2zgLw2/LHXOC1jqtw47Tz9U1phz63Q2Jus8if/GB2ayPnzQedJZ4rUNeI6j8PM8DlXK7/FpCE/B4UTYuGyoMpnn53fOYDB+xX3wEB5GC/KRhw3BkEs8eXnPcIOpRxNBiHDY5T3Hdl/0uHf+RpXV/xyyW3GuSGznN2vvdhj7iOBCaQnpR7B6DuHZ66RR/p3bmLRgO+loIDQ0ngS48CTL0yS1irXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ie73ki52DSrmKOWEGWef0BFISx1TleidBpYjtrt48I=;
 b=UCvBEQPJb7bWOBZb/UuZY7qmgtfdmCq+Dji8UMCzXjWnVa7PdFfTyRou3WCJ/QPDp196piEUYAKE6Da3ZJVJ29K8PEvieL6NdOdFOjr5CZXbBoAKohhPHRdb9Na/6Vc1g/Wf+0GfS2MCDD+6Qd5VDSxhjLLRMEfMvR2d2T9oN3Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3253.namprd10.prod.outlook.com (2603:10b6:a03:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 23:19:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%8]) with mapi id 15.20.4608.026; Mon, 1 Nov 2021
 23:19:37 +0000
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
 <4374d9ca-fc13-1dad-14eb-5e3e47953620@oracle.com>
 <CAHS8izPf-NL_BQnC-xBXW+mcsQQdiUSfxwL1JtU_H6DnBjr_Qg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <89a1fa3f-2c9b-34c9-761c-d0f21d0ba233@oracle.com>
Date:   Mon, 1 Nov 2021 16:19:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izPf-NL_BQnC-xBXW+mcsQQdiUSfxwL1JtU_H6DnBjr_Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:303:b4::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 23:19:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f2d32b-fb75-4cef-733a-08d99d8e125a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3253:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3253BB21572D8813C328EDA7E28A9@BYAPR10MB3253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vvx3QmmPmb3ddKvmjGYLBFlRrl6bExKIHhzoH+HhbPwfwC6l/4tnK+v4jbMyF0mloVIxTVMU4dA1X1iGkEFGmrdsHkoCAG3j2r2h15IO9tFQOAjd6HnOD8xpX5RssTFjsNc9jLH0F6yCDwb/K8TgGw8FqcdjEbu3URaS955XVKH8A/7PHb93yqe9FFVzc1ENYIO0ocftAwsCoQOcmzYvRbGL3VPeKT/HmqeyZ5Oj5ZylJ5iTbIrwFyT+HiBrKyTmvnz1nQUe0cMJsiT7scUNrQBIYDU11fw/g1MU/b4waEdx2oClWyKxjvnFU1oGZlWFizXaBcsyZsJ/RsUhWUxqhW+3KHlfTMpi/Z5vrpjjvYW6iMGQez1aZ7h8gZu74Bp7v/cCmAUF/D3MGm598emrcPW4Bs+ddSdCDzvCYv7TFflJ2N/7X8P1Oi79vOWWN7ig1nWN9tK0/WclsM55AKiE9Za164qhIFfbbeR887DOZCgrmR7uqfOUJGiFz8Z9J25/55hfZ86IJKjtr0mbw8+iI0JqiHlNBpLtWQ8fXaTCcxEda4fmnm83uYYv8sLLC8a6kk+MecpYuLD2NUO0Ey1ElmPjCAfgTSe0MqbSv5n634BVTfCGme1scfnoLj51t2hit5hCSzIVApxt8A3TbXxc39T75J9j9zeNePtE1aXAO6SrL8i9e+lNRUVre+nq+tWv2cExPQzsdF+uzBjAeqO4SWu3zoJggz5p4rGbeRvRBj1pllh6fY+hJfM1NF3XQ8HrxVTMoyoOT9WPpEBw+9pA/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(36756003)(26005)(53546011)(7416002)(4326008)(6486002)(31696002)(38100700002)(38350700002)(31686004)(86362001)(5660300002)(508600001)(2616005)(6916009)(44832011)(956004)(52116002)(316002)(2906002)(16576012)(8936002)(66476007)(66556008)(66946007)(83380400001)(54906003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUl3UHM2REtIdldzZXNRUFZMbmJMd05xTG14eTQ3Zlo5RGdzaHZtMXRTL2FC?=
 =?utf-8?B?ZngyemwyK2JXajB2ZGw4WlZ6eU9aMVkrWGxYOVR1YjFNNlF6aHFwalNiQktp?=
 =?utf-8?B?TXBVS0Nad1oyMitoNkpwNG03cGR3ZEVCTVBZTWkxMG04dXljOFBTZ3V1Uzc2?=
 =?utf-8?B?cTBhN2QyVko2c0xrdjVLK3liNXVkekxkN2F6aDQzN2lWM1grT3VwZE5DSk5O?=
 =?utf-8?B?V2E4bk8zQWFqRmV6VDhnUlArSHZTSHZzeWdOZ2pPbjdPYi9abmFzdnUrOEx1?=
 =?utf-8?B?aDNWSjlJcDg2V0J3dm9IOUhUdm92VWt6ZkRQUWpyemRGYStpR1VuR1RkVGxH?=
 =?utf-8?B?RmRyR3Vka3NId2d2Y0Rva1lLOVhwVW1JOWNDcFZ0MFkxLzY4RFVPQWtKSW9y?=
 =?utf-8?B?OGUvK3FLeDNvVmk4MEt5eFpGSXNqTFZKYUZURkMvc00rQ0krL296MUVhRlU3?=
 =?utf-8?B?dysvSlJwdVRpVS81S3FTZ2hNVFYvakJmTGNHQ0xQTFdZejZJeHNnNTJEQjdD?=
 =?utf-8?B?TmZYbWNZOHkvMUR3TitEUnVhbnF1S3BZV1FCTmdsZzFVNEJPUG1VQzR4TWZp?=
 =?utf-8?B?dTdMUXVIVkZ3UGp0Um1CbkJweU0raUlrU1gweTdqdFh6WE83R2hqRzFPM01w?=
 =?utf-8?B?dUY1VVNpUDE2OWQwUFlYQnY2SkZJdW1tb1E5NTlqOUdNVWNsQWJSZGVZRG5k?=
 =?utf-8?B?YnpqRjFUL2E1VEFBT2JxMGM5RjlrU1V1dVc5RHMyaFZEdmJNUTRqOTdQa0JY?=
 =?utf-8?B?L2xvaFpkdkhRd1ZJbktrTU5WNUthOWk3SWEvYTN1Z2R2ZmlJc3JnR3JNcng5?=
 =?utf-8?B?RzkyL0ZLRVVYZTRLYXR0dzltSXRCdzlvSXRuVzRUMmJwZkh0VDNpb3lnUDVv?=
 =?utf-8?B?NFdDTlh5blphLzJDbjhLZWdId2RiMXQyZEc4OXFtbndiQUo1d3dXY3owVzB5?=
 =?utf-8?B?U0EyMjlFNTdhMjY5UklBeWNwSk1kRmxVcE9SQjF4YnV4ZjZXQU1RdlBLdk5K?=
 =?utf-8?B?QitUSG42ankwQ0RuaXAwRUh5d2hGSXZpSnZTKzdiU3p0YVdRTE5qYXBZcXRo?=
 =?utf-8?B?K0p5MnpmZGZNZGgrcDBXcVJkTlBDZTdDUk9QdXVmaTUwWVdxeDJSZ3NYbnIy?=
 =?utf-8?B?SFl1U1JFU2JIaFMwRlhNRjdFbWtDUDF5TFZsRE5VOGsrb1hqekpWOXl0NG1V?=
 =?utf-8?B?V3IyMXU1ZVZaUXF2SExFbUJrdXBOclF6aGFWb2dyWndzbklYYjFqYU52SGE0?=
 =?utf-8?B?WVZVbEpRZmowc09IK1ptZ3NFV1BqQktpZVhMZ0lnQnAzRmxTTnBJRjE0djNC?=
 =?utf-8?B?a0J5RFJkSzQxY0w0a2JQY1VObmpOa0xmS0ltSjBQdWFYQmJrd29vd1N1OWlQ?=
 =?utf-8?B?NUdYV1hubzdpQ2t6Q0RaMmU5YlJwUXRhYmF6WFdUTFFqWGFCMFZnQWVIMkNp?=
 =?utf-8?B?RlF6L1hFVDFaWFhRczhnRUFkcnBRTDBXaHRIMmcxd2JZL25laXFHNmd6K3g2?=
 =?utf-8?B?cEQ0Sng0WFkvemNtMCtBTFhTenN0SnBGdHhYVUZhblVjOUFTL2dGK3llSGJs?=
 =?utf-8?B?aGpQNEZvNzdNNXZGNGVQYlROSFJJMnFzZVA0aHJEWmVyQ0d1b0JIK1psWmJs?=
 =?utf-8?B?YzFQdTROMXZSdXI1cTdSSUwwZjVrckFmMkFXOW0ybG1qbUV6ekJQRzlrSzJF?=
 =?utf-8?B?akVZL1pFNkp4RnZobWxQYjltbkRFM2NyTmFqNjRUUVlLY3VYUmNLbGE1VkVr?=
 =?utf-8?B?aGJabDBDb1pYdUJ4TEcvcmswbDNGWDgrRGFCMk1uRXovdEVLdWZVdEJhYVNj?=
 =?utf-8?B?Q2E2WXM2ZGlRS0M0aGNpenN4YVBIbnZxRFBDWGJvRWtYR1hJazNGYmZnT0FD?=
 =?utf-8?B?WnFyWVdWRmpNUVFnRzhCV2h3T3Jaa1NScDR4VGRNQm1YVFpRK3VpcGlmUG1T?=
 =?utf-8?B?dmlnY0VPc3cwWWE1b1pCUGdmVHp0UXZxdGszYlVGOGt3U05FUW13VW85d3R4?=
 =?utf-8?B?d25PNzlGaUZzTE1DcmFLT1VWRzBUVFN1c0x4VXl6UXhIQ1o3VW5aTlR4dWFS?=
 =?utf-8?B?QW4xdTNtS3NnZDlOLzU1cE5ZbURKWkJIMVl5SHo5cEczcmdNY29La0grcmFv?=
 =?utf-8?B?eU9RQ2dIclhlcW9qekt1REZaTzZrWTJNM3pNd1lneWVaZmg2aFVYQ2xPcE80?=
 =?utf-8?Q?7Tm/SE8AYsbxUSkC+iqiMgE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f2d32b-fb75-4cef-733a-08d99d8e125a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 23:19:37.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/xn9PmDrml6KFN0fs4VNiZtoxV1g5Bznee8sJ3RluK2ewL9T4V8pJjaHJndf+vBiP7blAvNBLDgbJUS+SpapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3253
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010123
X-Proofpoint-GUID: DzJZ7eyApkFbpvLW4A_HVKvWdM1h6Ncg
X-Proofpoint-ORIG-GUID: DzJZ7eyApkFbpvLW4A_HVKvWdM1h6Ncg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 1:39 PM, Mina Almasry wrote:
> On Wed, Oct 27, 2021 at 4:36 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 10/20/21 12:09 PM, Mina Almasry wrote:
>>
>> I have no objections to adding this functionality, and do not see any
>> blocking issues in hugetlb code.  However, it would be GREAT if someone
>> more familiar/experienced with cgroups would comment.  My cgroup
>> experience is very limited.
>>
> 
> I will send V2 to Shakeel as well from our team and ask him to take a
> look and he has more than enough experience to review. If anyone else
> reading with cgroups knowledge can Review/Ack that would be great.
> 
> It's possible I'm a bit off the mark here, but FWIW I don't think
> there is much that is continuous or ambiguous here. For
> memory.numa_stat it's a bit nuanced because there is anon, rss, shmem,
> etc.. but for hugetlb we just have hugetlb memory and the only care
> needed is hierarchical vs not in cgroups v1.
> 

I agree.  It is straight forward from a hugetlb POV.  Just would like to
get an ack from someone more familiar with cgroups.  To me it also looks
fine from a cgroups POV, but my cgroup knowledge is so limited that does
not mean much.

>> alloc_mem_cgroup_per_node_info provides similar functionality and has
>> the following comment.
>>
>>          * TODO: this routine can waste much memory for nodes which will
>>          *       never be onlined. It's better to use memory hotplug callback
>>          *       function.
>>
> 
> So the memory allocated per node in total is (HUGE_MAX_HSTATE *
> unsigned long * num_css_on_the system). HUGE_MAX_HSTATE is 2 on x86.
> This is significant, but to address this comment I have to complicate
> the hugetlb_cgroup code quite a bit so I thought I'd check with you if
> you think it's still OK/worth it. slub.c implements these changes
> (slab_memory_callback) and they are:
> 
> - When creating a new hugetlb_cgroup, I create per_node data for only
> online nodes.
> - On node online I need to loop over all existing hugetlb_cgroups and
> allocate per_node data. I need rcu_read_lock() here and below.
> - On node offline I need to loop over all existing hugetlb_cgroups and
> free per_node data.
> - If I follow the slub example, I need a lock to synchronize
> onlining/offlining with references to per_node data in commit_charge()
> uncharge_page() and show_numa_stats().
> 
> I don't think it's worth it TBH, but I'm happy to oblige if you think so.
> 

No need to do anything extra/special here.  I just noted that you would
be allocating memory for offline nodes and took a look to see if the
memory cgroup code handled this case.  They do not, and have this as a
TODO.  I think that is sufficient here.

Thanks,
-- 
Mike Kravetz
