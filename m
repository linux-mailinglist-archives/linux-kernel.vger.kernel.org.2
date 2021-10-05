Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00684222D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhJEJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:57:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7356 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233910AbhJEJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:57:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1959R4Jg004524;
        Tue, 5 Oct 2021 09:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8k5RmKlDGUKVb+T6JlupdQqHj9Hj5IBSKKAADetvCT0=;
 b=QXXZURESfys51VLxRqxxhDHf4bjeBWRfCdkmRybwPtk6mG0uhn+oYY9ZtaPLr2EAIG0L
 ZHttkR+WRgcxb8s8RVju3skeQQLOEt4MQWdY2tOxJIgKfzKK4wj4pYwFkMSH7fZDlWuT
 QUC0DWJCHWs1i3808PZDVmVLMJh+XJrQV4lgxXEP8hhq9lQf6JDfb8Bv/KfEbtiXKlrJ
 6RXsctqVjF4+3IRshSw08hTaTYiEd5zu2iNdjgCafmG8sZGRDtW+yII1chdO2NGvXdcg
 7gJD4ypQhoQleIWdKa+8fkoTDIBL9deKdAeC3yJcjdkDSNmokWmw7mahilepmKl1Nu71 eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dwr36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 09:56:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1959tuOf034524;
        Tue, 5 Oct 2021 09:56:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3bev7sycuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 09:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4ol+gU29KidRDEEBe12i4m1Nscb+7SJFHzz1c34NTqlTXuSE6thys90Bd5psTJFSGcc2CQzx26R0xKj3WMLfwUWn0RL+Itm8YEny/lEZa7lodymEhQ3k11JzDtQLjckSXB4kh0MylHPaL8lbg6DBdUlN38gRomMaa86H0TnNRRw4ccfOmwDs43JZy1s6HMfnYsFkho0AydaRoKJp22gUodbtLvu0D/BTEo7xjOon4DsHdRVmbL0l/+1u/gY+PHSGBTkcgDuXsXVbWKp+Ti3h6ZcVZNaf/rDwToqMkDn0Ia4tdowJTlXx8+hNzl/IjI+/NIgV73w0oKJo3R6kKCDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k5RmKlDGUKVb+T6JlupdQqHj9Hj5IBSKKAADetvCT0=;
 b=LHCiz8ghhBxoSgm4FfJDaX7r90Ch94/2V+pFBbUXeNqvPBmXE/W3I5btL0BVb+3i/4daRStLPKRVxZWDgZmavK8Gl/bNGxLQDowOrosYdBEeJCs5/z9KWvqeQDqDdHp7u83jk89zbkqs0yg0WMlqHRN/AQC/v6PGJH9Pe/v0yu1+5kgnt6MD0E94mNgnjIQY9RsBIPpkyZeYy/F3QiCUtj0XuKLkFHaXwTqQBWIGhErXdIBd3k4Ais2GOAg0cnTsMS75SDqKAD+oxz2X67Qk40KigHMGX+gvCLMhYDOUabKxChdA+PkWJ8SIUt8+0LXTxv2Zkny0emKN/yn5W+vyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k5RmKlDGUKVb+T6JlupdQqHj9Hj5IBSKKAADetvCT0=;
 b=hq0e0IdIM1BlKP+R1SqMUhGu3Jgjs2AyRHLoJeySLJp40kjIOel+aU3SEI/gQu50/DyLTuVMn/Sphzu7i7FbSvSNycUmyHyqEO1e33BxiYlLYxAgZ3syDRa0QlehIf9J63ytjwGA/JgQR7D15A97NMPbMzPuGZeo4lB+rjPzy2U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1421.namprd10.prod.outlook.com (2603:10b6:300:24::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 09:55:57 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 09:55:57 +0000
Subject: Re: [RFC PATCH] workqueue: Introduce __show_worker_pool_state and
 __show_workqueue_state.
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
References: <20210928103106.391694-1-imran.f.khan@oracle.com>
 <YVsvAQ94ucYdGNVM@slm.duckdns.org>
From:   imran.f.khan@oracle.com
Message-ID: <447be1eb-87df-6941-1e5c-db79918dc77b@oracle.com>
Date:   Tue, 5 Oct 2021 20:55:47 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <YVsvAQ94ucYdGNVM@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0051.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [192.168.0.2] (110.33.47.182) by SY6PR01CA0051.ausprd01.prod.outlook.com (2603:10c6:10:e9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 09:55:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e29798-708c-457b-de49-08d987e653d1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:
X-Microsoft-Antispam-PRVS: <MWHPR10MB14219B8F25EF846022A4ABA0B0AF9@MWHPR10MB1421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSjhgDHLaRDdCQlDOZI/DjLZBvsTL9z9FqddsQUi5RYZPF4g6K3R/aBK8ycyxJFEafuFiB45fAMdUi0FHpE2WYsgktEsMEXHSeJ04R6AfhgKDI75CslRSEoGVfTBgD9fT54XToQVKePdGZKx+hQd6T6mrMZvtZSmsC9R/3v3O0D58EABrmXWLr5rz1uxYAoayKGXzRs7kHvWtZ8OH/dytAZYerUS4NCbWBb3w+XOzsT8Js+hNvPY/tahtCVLH+6HqTvoXepIOWhf+mlMq68JbOanAD+B+h229ISBC/btcG0R2OYNNv9m7HdKij14mHYXN+FlLAQcPJEBqRg+yhJ18zU8IBHHwVZLfKfYsMWeE7Lz11UmkFkMeA0op1fUSc+979TZy3WzF8ey3QkRMqNtKCssoeZpWUEIC7+5+ps73M1XkFg7LjghNSjJpeh9u2GZvmZevaEJGcld8ZwEpLxkA5ALyIZhKEVSNjbEBxAivq7qO868CpCcHGpJ5qq604e4kUqZMBsa8M4VN1w0874/EN4hsHQT4Wko1/I5fOcxHbKtvd4QH06WTZ6pCaVe9J+deBA4I9yE3HTN4DHpnCiLYQVKjiuUdVZh4E4bENpHrhTi/4TO9fMPzk9REHUo5zVAjFhXaiA+P/zBjKT2vYIpIqBZyFvyucL0tRZpv/jBtTmF8cQKiQ9fJxss6QZ+2cSQnJGYNex0ZeVhchC1UD+TiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(316002)(16576012)(4326008)(6666004)(508600001)(2906002)(26005)(31686004)(6486002)(8676002)(186003)(956004)(2616005)(66946007)(38100700002)(9686003)(5660300002)(83380400001)(8936002)(86362001)(36756003)(53546011)(66476007)(66556008)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBYQjNUdTdJR244UVNwTG9CeEg5QVYwSDU1RzFwOHk2TDhBU2VTZmNBayth?=
 =?utf-8?B?MzVLTjRGeE1XQXdiZHdsUFhERGJUOEw2UEFKd2IxZGd2NVFITy9BZkN6SHlB?=
 =?utf-8?B?VVRqK0Fob1cvU2lJekVJaHROTi9nejNmWUY4U1VBNkdJNGVPT3JLWWhNWjdv?=
 =?utf-8?B?Zkh6VjBRYUFWcEROYVVHSGtyWXFVakhRcFBKbjFSeTh4T0hKOWdUR0h1R1or?=
 =?utf-8?B?MGI2cEhEMkRCMkMzM0RtUG9VcjY5UlpZN29NRWtxSWJZWnBmMUIyTEVSc3VL?=
 =?utf-8?B?cEpnN29Hb0pTZzA4OWRaMkRUODlSdjFTRmVSOEYxYVdUZXQ1ZmRINHp6M0Na?=
 =?utf-8?B?K1RTaHU2UHVVaU5TOGNhTGlZUnNrcmsxVHZrM3p2ZTFNR25UQVBqcDc5TVhG?=
 =?utf-8?B?TVFxeEVWb25JQ0ZQelBiOGNJMXRDK2ZEUmFzVTNyUGRoZVhPNFQ4dXhoR3Rk?=
 =?utf-8?B?YzYzZjAyUjVjRDhwYUtocjc3cStGYmVuQ3h3Smp3bFdQSTYvZXllclFENmRw?=
 =?utf-8?B?eWZwVi9wMnI4VHdxRjdWVVRxMHAxKzk4V2tSRmN5eVJQbGtXSVZoZzg1WEs3?=
 =?utf-8?B?Uk1ieGNzVWFSRVZud2xQK2JqN2RFVS8wVU10YVhsZGFTRTNWWEwxRUozZm9Q?=
 =?utf-8?B?c2ZYbWUvR1B2bW94YnEvZUI5WU83Q0lZblF1TlBEbDJUR1V3eXRwQmY4eTZw?=
 =?utf-8?B?STMwdXc1Q3RuUnlZSEcyc0llYWlWaDkvNnNjREgvVElRV2V4VzZ1QmFMeGRG?=
 =?utf-8?B?MzkwUTJCanQycElBZ1Y5alVEcFFaR3J3WnlXSnpobmNsWGpwUjR4STlxZy8w?=
 =?utf-8?B?Y2F3MmU0N1BsdCtveVdZRTB3OG9YYWxUQi95anY3V2RCKzFHV3Y4RVlPTXA2?=
 =?utf-8?B?MG1iZDFDUTl5VEZrcVVmaEJWeFpkT1BmeVgyYlVtQlZVRjVsS1RXcm9ZYXdi?=
 =?utf-8?B?VUxKSkwrZXlWRzdDTENibGdmT1Zwa2JHQUNmaG96T3EwQU5kRjZRRysyRkpW?=
 =?utf-8?B?OENPRzEvRUZDcS9mbHdmNHhnNFZMdDJwUXZFVHRmK2lSUzVwd2VBUDdZanVH?=
 =?utf-8?B?ME1pZWhRZDJ2ZHhWSWVjYmFSNDhwT1hEQlRuUHI5OS9QcDIwSTc1Q3dGSG1s?=
 =?utf-8?B?ejZzclg4alZ6ZURFM25YeExxU0pXdzZBcmZvUFF4V1pucUxBV1VhQmRaVEpE?=
 =?utf-8?B?a0FDV3dpUGI5Ujc3NU1PeXV3WDcxdVRRUUc2VklzcnI1YnZTYmJjYmVwMlVQ?=
 =?utf-8?B?TlhuaDBNaEsxMjI4SFJGQjdRM2ZDdTN4MWtWUTJUaHpyaUNNR3FMRHV5ZDNi?=
 =?utf-8?B?Nk1vWXdiWDY1dEpjOTdOZlFBMVZYQ2xzNXlyb1lNTzl1T29INzFjTzFWbWps?=
 =?utf-8?B?bEhxOE0rVENlWXJlODhnWllIRHB6ODQ2aUVpQVY0QzRUdjN6dm5hSnhtTm5I?=
 =?utf-8?B?NlYyeTY3eWFtM21MdEJ5cHJYeFRpUFRkeEswYXFQdWNKNmpUT2lvaUNDVU95?=
 =?utf-8?B?MzBNa1p6VjRNaXNzck5pOVlyM1FWMDNjUUVkV0t6enNKTWtjYTNSVkpibXBN?=
 =?utf-8?B?Y0ptVGxRZnQra3ZUTlp2QlROY2JRZTVKbmhVTFFJRW80WlZzSzVLTWdMTHZY?=
 =?utf-8?B?RzNCQTRGT0w1bSt2SmpDVXl0bk9xSXVHSUVZcndlQ1MydFVFd0Y3N0VpUHkr?=
 =?utf-8?B?RXowL1VVNm1sS1pZODI3S1l0UXNZTC9ReVdlTUhML1NoV2JDSTJSS1IvQUUz?=
 =?utf-8?Q?1nk1q0t8l27POgv2+aGeqTtEnyxhrtxfqJKxnb/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e29798-708c-457b-de49-08d987e653d1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 09:55:57.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYK874Qiv9nlDP1jmDomWXWOJXvm+8sU3rKyO7YkwqBq2RoN4bysZrxmYYDtvUVH6tBjtaLbazEgxg+aAyxg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050057
X-Proofpoint-GUID: ps4g39rtV4pxGGXtZGQkXhiA9_wrlHUK
X-Proofpoint-ORIG-GUID: ps4g39rtV4pxGGXtZGQkXhiA9_wrlHUK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/21 3:42 am, Tejun Heo wrote:
> On Tue, Sep 28, 2021 at 08:31:06PM +1000, Imran Khan wrote:
>> Currently show_workqueue_state shows the state of all workqueues and of
>> all worker pools.
>> Divide it into more granular functions (__show_workqueue_state and
>> __show_worker_pool_state), that would show states of individual workqueues
>> and worker pools.
> 
> But why is this change good? Are you building something on top later?
> 

The main motive was to dump data pertaining to only that workqueue which 
is being destroyed in destroy_workqueue.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cfae0c8d5e2e..e191646dd3e4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4447,7 +4447,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
                         raw_spin_unlock_irq(&pwq->pool->lock);
                         mutex_unlock(&wq->mutex);
                         mutex_unlock(&wq_pool_mutex);
-                       show_workqueue_state();
+                       __show_workqueue_state(wq);
                         return;
                 }
                 raw_spin_unlock_irq(&pwq->pool->lock);

Please let me know if I am missing some information that may be helpful 
here and can be obtained only by dumping the states of other workqueues.

Then while going through the code, it seemed better to break 
show_workqueue_state into more granular entities which can be used later 
for cases such as one mentioned above.

Thanks for reviewing this.

  -- Imran


> Thanks.
> 
