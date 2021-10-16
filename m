Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8042FF6F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 02:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhJPA3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 20:29:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61794 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234077AbhJPA3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 20:29:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FMM4wF008108;
        Sat, 16 Oct 2021 00:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kNj5VEK7HiqS3SO6xOVTZiqDWBrWVXIOhO/paaSKCfU=;
 b=xsbm+mxlm7+p7Ykf9pvOd6wXQe2JFbnNzYsJfNd++cFNrR+34E5IF+y8nU5buvu42oZd
 GQ2kbgrH5hzf/HTxQ8QCtTXloUYSbrbmgAUiFjXwjO+9z7fDw33a1rxFeQyK36veyiBK
 lh00f+v+RuGzbnIhHLKiSXD/dZZZ1PZdSvl78j53lxrafAhPvAGX5DfHz9dTqi+Z04lV
 P053l8/PKR6qLGaFd8fDlj5t7DW1/Y5Xb419FVKH5Df+d5aBX7O3U0q7rfUcs1SMgqEL
 KtAyd2bugpcEsCDwNXg/HvSsPJfWBvbVUua7Jt80UOmZwMIteL+mRxRVm17f8N3CByle 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqbgftre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 00:26:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19G0LKF5056145;
        Sat, 16 Oct 2021 00:26:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 3bkyvghs4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 00:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fot4Q5PWm0XSZmf65+321WTC+WpKberw1gFfFgY0Jgarf+6bt1lKcV6fAZkDVM05m9D7TJym2skViovSEA2HpoNCEgMNlYmnqCu6g3eHn+viZ/H3OWMvAGNopXxIpYMFHVVU1IUhK2rKX/JjVyAY37xWnOp07gVBEVpBuyi+hwF3usUH1BzNThiTyMQYVFezIyzpLGSf0eCodOilSRa4+ip6okl0FMmql3cge1tkYAR6mwrWSXjbkmQCJNV3e/I8v6NCa/ERMrvtAPK15oZscemGh+C1fCHdDvG3bBlOpyx5EmXqbjRAnpBib7z7pAsYVkVE3yI5+y2n7eiNLdhy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNj5VEK7HiqS3SO6xOVTZiqDWBrWVXIOhO/paaSKCfU=;
 b=KfsMy0TlLn56mwiPaUsY2NcIazRScHqIHWi34PJHrsdzveL7j7Lbp1MGdQZAE38h8PWliNuiRVDLbHS95szQuJ+qJIUVSPU9YisPziAj/3xcfup66mZNSgX8A3LFYuqmzEAhxHhz9vMwJbNDrnvbXVl/g2nfx7FFBBRHYO/T7rmlngq+xWDS/u/s64A/JBo+enyAOcXdqGYQyGItIEktX2ZYwyKQVzrkWDbaFVFNSQtWdl3js4JjmaFHTZTdkzm3Uknk/+M3u7wXbrBUFsRiC5xBwP4k61I3VXq2uFIofVNw9J89bh4422EzZvyN9TX3HN5rbItkzp4TkHnelhHbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNj5VEK7HiqS3SO6xOVTZiqDWBrWVXIOhO/paaSKCfU=;
 b=tZJNjs6Xlj2yMvHnFfVUKH7IzYxWzntbUzCGC4OQITJf/mRLgcEhgWbVbeT1id/a6iAuXfTeLMnx54trXJ3JIqlVGNL+dYukDNOCoDDgojfpFuxyQS5Tnh9BvrPdBbkF5y0TIRIMqlPb/xcTqBEv8cwky2Ep37UCMq1SufvaKjI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1775.namprd10.prod.outlook.com (2603:10b6:301:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Sat, 16 Oct
 2021 00:26:51 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 00:26:51 +0000
Subject: Re: [RFC PATCH v2] workqueue: Introduce __show_worker_pool_state and
 __show_workqueue_state.
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
References: <20211005213841.736834-1-imran.f.khan@oracle.com>
 <YWRqxS4IMVW4ZCN/@slm.duckdns.org>
From:   imran.f.khan@oracle.com
Message-ID: <2e94a048-3300-19f0-2106-a838af0b3731@oracle.com>
Date:   Sat, 16 Oct 2021 11:26:43 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <YWRqxS4IMVW4ZCN/@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e::27) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [192.168.0.2] (110.33.47.182) by SYCPR01CA0039.ausprd01.prod.outlook.com (2603:10c6:10:e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Sat, 16 Oct 2021 00:26:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c810c28-24d2-48fe-9ea0-08d9903ba600
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-Microsoft-Antispam-PRVS: <MWHPR10MB177576BFF68EE8AA75B1D3FCB0BA9@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZF5tNKqk/5YLhoMunryTVfbQ+yJiIcbnQ4B9uXqU73t+RypnNKt45nX8RT1YcOHLjZc6MsHFQYEc5mS9PQDCk8JjhrB/4OR5MRH1ES/1a1a+M3fKZueNFzCQB8R9XYtLJbkODGOzi4nDQ2yiwbcZoFds9xHau2lH7UQRnSB8a05uR/zTcCtpfUMyHlHtmMjxd7cMt9q1IN7GVmRUz0pyY2TF/wsr0c/tbzkWXcg32hStgZ4JlaG6moonuVb+bukESRh/WGtxTLFdKxWcTxE5jfFsFnceZIDyUU2HCdOaavovLr84ZJHi4EiCvwVvyeRp/5gR7CEz9fhtkCVTVkPvT9C8BVlTUKTg62BDx1a0PIw8Yj/vQM0abqtWbdp1HbBJBNjU3LhJkDvE57QnAte2AUtUkzREWV+iyyQN/bBuEKCd2AdPBvu04ovZJdTx9O1JO7sa+WB59S4apkqjnkSW7sYklweg9yZwiL4IyyejGHwfGqBexpAPcxkig+tV4WOCHWzCMKaZT3AWCfbev/+0rkc/afOp8HUSbezto9zWvTAhick92IFH+xQuBN6e9zwiB4B44kMSYM7/68Q0Rs8WLiQra3e3Ad26HOUp0ZMYYxKwzaBCUpF6VoajthvtwxipfGlSca5djyjQxx3a24d54U7nG1LjBkVaTTwv4oE+wrs8T95+kVR1ItyTAxh4gTuTgV5YbdVt+jC1F/IlbM+ZyHeymqGNybR/YMhWkw17Eyr8lTAfBt+jxsp7LvOeVEoI2Zed93DNBFsJn30gjXC0RX0aK+5KtNeUqmfDWVCOyW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(956004)(6666004)(2616005)(86362001)(6486002)(31686004)(26005)(2906002)(4744005)(186003)(31696002)(16576012)(8936002)(6916009)(4326008)(9686003)(53546011)(8676002)(66946007)(966005)(5660300002)(38100700002)(66476007)(36756003)(66556008)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azc5SmZyZGtyNW82azFLbUc5eFVHSzl4WUFMZTE3aTAvSFJ5Vm5MdkRJSmNW?=
 =?utf-8?B?VHlPVnVzVXdURzhZZHg4Nm5iajVxendaODhHY3JFMWhPaWlza3NuN0JPN3JL?=
 =?utf-8?B?NVZXOGFKM2JNenc5d2s0Z003TnFwTjFOY3E4VVk1SkpCdnREVWJrUU1KNFl1?=
 =?utf-8?B?L2gxOWxCK3oxbm9hZHR5UmpGMWk0RzlQc0dCT0oxK05ydzFuVW5OenBBLy8y?=
 =?utf-8?B?ZjJwcjVuUUZtV1YyQnVjTVRpNnJEUjlwYVNCcXdIQlhkWXBMM2JXZGJrWXhj?=
 =?utf-8?B?TVJHQWxPcStrS2daTTRhcmRzb0hNTDdKdHorc1M4WldEdStyNVBvT2h0OUlm?=
 =?utf-8?B?RC9HTDVkU2lkeHFndFpQc2ZMcmhNeUM5dTZBRUFGdE1sWWhqQXJML0luZkVa?=
 =?utf-8?B?Y1FtNGFCK09lenYvOExub2xLRDZTaUdHYlpLSXF6ZzltQndnZFFwWGRxU2ZD?=
 =?utf-8?B?YTNnS3ZhMFJ6L2J0VC9RdjBsWmJmYnJRcUtvMWQ3WjRvMFhlWkNscHVDand2?=
 =?utf-8?B?VnVaRTBsMVcyajJqdk1QVzNSN3ZnUndxTDVkUFVHak1KUjJoSzE3VmVUVXpX?=
 =?utf-8?B?THE3Zk16eHJDM0h3YVB2R2tVMGIwT0srMXBHdExjSUJIQXlrRWtiN0o4a09m?=
 =?utf-8?B?aUFQU2k5a2VTK2lxNVI1Ym5kY2ltOGVxbzN2UUR4Z3pVQ0RDdzBNOGJSUk9y?=
 =?utf-8?B?Yno5ZmJZakhHcHlCZGpqTlE5dDVEc0swRklXb3o1Y2RPS2hURTMrM0t4WVpW?=
 =?utf-8?B?dHVnOWhhbnZnUDZvL2tuQzNGREdRU1BGeE5jV1Iyc1NXSGFsSGtQVVRKY0s3?=
 =?utf-8?B?bm1aWHI4M3lVbytCUnpRaC9ZVk94TXpyVFZQMXFLS09tRElxc2MyM0xOTWJX?=
 =?utf-8?B?RVVsaUtiN1U5T0pDVStYelpCU2lKMk1SRzY2MVl4L25jU2lvODVhR0N2Y1lT?=
 =?utf-8?B?NVFMQWpiVG02YjdLWm0wVHB2Um55OU8vbFJqL3hmYWhydUJ1SDd4VS9TSmJj?=
 =?utf-8?B?aU9XZG5oekdGb2prMmV6YkYzSEh0SVprQzllWWY3ckM1azBuNlU2OHZDLzVL?=
 =?utf-8?B?WU5pelM1T2lyZkpkbkZuUjdnd084R0lBVk50YU0wZUtnNFMxRUlDYlhiM2xL?=
 =?utf-8?B?eXAxeno3VGRmemU4QmJMeDBMTW1PcytCZUhoWUZBZ2hmVkR5eUpOZDJoOUJS?=
 =?utf-8?B?S1ZaN2xGaUE5cU4zK0RLb2NPejdwV3FHTDBpMU5iV0ZXQUUxNVo1S0lBMmVw?=
 =?utf-8?B?YVN4bDFJN05XU1V4Y2F5TU5MWmNIZmgvRFRYTGp5QWJuQ3FJVkxZbmkzNEdK?=
 =?utf-8?B?NWcyamhVbXhvbTRMZkJCK2FhWnZjd2hjeWFkeEloSFFhS040NU40RTFvVTl6?=
 =?utf-8?B?aDlFdHhFcHcxRlNSSC9VRWc5TGNZbytjQjFqclZGQ00wODYxOXpveTkrTVhu?=
 =?utf-8?B?SUg1R3JRdzd0di9uelpIUXk0bEg2VXN2aWRLV2thWnFSTnZXUTdJSEhBcUNp?=
 =?utf-8?B?ZExTTStjWUZiQjVHMTkzUXNydzRNOUt2MHRBbVhwVFo1VHYvVXpUdkZlRVZl?=
 =?utf-8?B?OGs4VGhYY1NwWTlxU2dWdHRXSjBPRWxkcDZOVnBTbTMzRnh3MTBvREIzRkh3?=
 =?utf-8?B?eXRpa2dsVjBUQmxqa29tNG1CT28zUG8rV2JHaEluVmIwc0pncWpDWm54ZEVs?=
 =?utf-8?B?OWYzYmhyZzhoaFlkNWtHSENDRy9MSm5BUlJ4ZXdoWVM1bW1UYTRXSjVvSldW?=
 =?utf-8?Q?oUJhR6M3EP6MEk14VcfBvnMVoGePh6xeKcnt84Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c810c28-24d2-48fe-9ea0-08d9903ba600
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 00:26:51.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxpvEmK6dPTwir8mXuWA+FVKqpe4XBKTurGmeWyes2fBQgXGnhu85/vB+yf5fa4OendH4vnMqGfEYxuQjUTI6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110160000
X-Proofpoint-ORIG-GUID: aIxIJJuwEjuS2URtSrl3mlg8iPS2y_jS
X-Proofpoint-GUID: aIxIJJuwEjuS2URtSrl3mlg8iPS2y_jS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,
Sorry for getting back late on this.

On 12/10/21 3:48 am, Tejun Heo wrote:
> On Wed, Oct 06, 2021 at 08:38:41AM +1100, Imran Khan wrote:
>> So divide show_workqueue_state into more granular functions
>> (__show_workqueue_state and __show_worker_pool_state), that would show
> 
> This is nit-picky but can we please name them sth like
> show_one_workqueue_state() and show_one_worker_pool_state() or just
> show_one_workqueue() and show_one_worker_pool() with the corresponding
> versions renamed to show_all_workqueues() and show_all_worker_pools()?
> 

Yes. This sounds good to me. I have renamed the functions as 
show_one_workqueue() and show_one_worker_pool(). On the same lines I 
have renamed show_workqueue_state() to show_all_workqueues(). These 
changes are available in v3 of the patch [1].

[1] 
https://lore.kernel.org/lkml/20211016002007.143661-1-imran.f.khan@oracle.com/

Thanks again for reviewing this.

  -- Imran
> Thanks.
> 
