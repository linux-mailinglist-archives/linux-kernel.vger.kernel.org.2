Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D091D3A3764
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhFJWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:52:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFJWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:52:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AMiIAT042126;
        Thu, 10 Jun 2021 22:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=s2DKdB8grOLszjG6PICQs0hw0Jap0URGIEDEhBDy8GA=;
 b=crxJzrh9vih6evDoHYEylB7WzYjGcglvq/tYRh+mKUrpJ4P8qznj1XtwylSPOYJORDsS
 cDagKCbb0jaQX7mbo6NI0/9adZBjwMzwmrd3E4LnSwgCgNQwGYhSWu7wRC+lVkjvfc1R
 WueJx9vn/wgXRKsJDcy68zEh2EW8dMqaA7ZNha2R61elsyAy46/YHWPfDV9rHwxcdkM3
 tCqcPspiCVtwQ+1Nc95ifDSNcHN3dSZfGjD3BK4wgxzBiMQARJ+jIOqWhEBUeMi9r92K
 i9N3ohboA3zhw7Qd9cuW9epWNzLMVcXV5a4N904QxQyhgyY/DqnBAjeHLj3i0FrUZ9rA Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3914quuqs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 22:49:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AMkTwN157433;
        Thu, 10 Jun 2021 22:49:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 38yxcx09rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 22:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7mfwHUEqn4fj5ElUAKzE5Rl7OfuPGNxpBYUEJ9lJmsuTPyBpX/FEhtqpc/GStUs+qbUBJyuUQ2AjKPRlyTXxUOyM8R2f80deFSbJROE3EjR0X8gtgJ85Y9Mpf9jL/G22Xwy3SgpklARLdi4IW6qpmIvzoGARcwstjLUQ6rzIa2U5qLLw1Mw91269s3PJL46r1KsghtZoNxrQOvB8jvBkONvrmWZlEalK4epbhKc3Ix6Ry0xrzeSo/1oKXt3CdooBIRHzvzDPSZPUPQNFYJJLpKXLR3kv1xYmchs/51WA2ibUDQ+MpJHqfUDFc9DxU7v+tyhXeXC9f/J/0EQ5wpaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2DKdB8grOLszjG6PICQs0hw0Jap0URGIEDEhBDy8GA=;
 b=nW6uFb4IES2UU7VhmXD6YI5vOB08Obw89AjigRoiDKHVxv/Qqc3xRxjOfTSbDhpGdC1UUDtt8WUSImJB1B0Cdk5oN0+npikJ2Dd2sfnKu60y414XieDM5DVaeT96RrjcF31VtXF3zhsdXOC/uO5hnryUZFq9mweeyG67BiZsKw+HdEhnpNafbX6aPDSq/o5yLDvRp3S4Auuu7oJsR9PjkwarXu91kOlLauTBCooxnwIilpykIwPVLZ0nAruKpED7eXujrY1xA5CtH/8QCvZftTRcs9KnZUsyLE0zEmTZdZ45pfe5Ma4ylJHwhkzUObemDPwleQEewxgcPCllkpJpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2DKdB8grOLszjG6PICQs0hw0Jap0URGIEDEhBDy8GA=;
 b=ikY9AVsFrz2fdW28pYCw9ccNjfjx1PfFU6XFHpG8eVjKbLq3qs6rH4AE76HXDsOtUZuf1hxlLEvrvVFii8jyx2jgYXUKahcwjsJWRQnIRRSsWHr5SEpxYZLkuYJhzym98/nKHZ/sAjrCONWD1IpFBL/q90oBRcWQnmrCZUI8H6s=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3096.namprd10.prod.outlook.com (2603:10b6:a03:151::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 22:49:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 22:49:37 +0000
Subject: Re: [PATCH 4/5] mm: sparsemem: use huge PMD mapping for vmemmap pages
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210609121310.62229-1-songmuchun@bytedance.com>
 <20210609121310.62229-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e1383b21-1ad6-a74c-d4b6-e759e7371a89@oracle.com>
Date:   Thu, 10 Jun 2021 15:49:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210609121310.62229-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:300:ee::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR04CA0036.namprd04.prod.outlook.com (2603:10b6:300:ee::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 22:49:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28665a20-0846-4beb-604d-08d92c62064d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3096:
X-Microsoft-Antispam-PRVS: <BYAPR10MB309683F0C306F41D4C9BF281E2359@BYAPR10MB3096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdSyT74OLvbza1Qq+sXCHSAzxFY366Nk2aGDHtoGnmfLt+IsR2Et9EcZ9VldF31Jhl1vLCblTaULJDeVQqyt84oYhJr0jT7yWbtMzFGgbx+DnPI51hXMpOGQ9Ix1j4DZePEqGOJAlOl7ehMANzycEp3uYYAy8GLYzS1nMxKiT0hPbjtdHhHFq+D7j2CnqtEeGenvmBpkuO87UqmOe+Sg/nzXcApmRxPVr23een70XQIDWDHPY9xfA5XEon4dSdaGOgPrAa7e9VJmQo5v0VUXrXdHSnY8NhNASUyNs3PymtW7sWxuKVgAp6Qv7XvQw3tfXGwy80e6caKrNKPPM1l2RhMZMXHeomRa6IjVMljlAFxxGzVliqy+kRVjUPmwyAv0fHVO/2Eo2jt9IyHJoOpTIFG5ue70Ysez77DMU1J9yulHG/xvrZBlAfVUqCJsRm2C/MbLPN5EiyWUzKNDkI+3hLG4e9Tx1Bw4vJkO0uQDUpNpQ4WppcFbEbBTUOiXM0kd4TpNnNZjEU2u22P+Tc3Cd+VWJ8aGaDhZZGD3jPDfqKthCyl3lDqWuZoiFzAKVNZIW3grl4OcahdqkOP6PSgQV1eqxyumNWDmZfGGwTueqg/wGWiirgt6C5zteFHhV94AJA0mEZdIigzShHiUozEgdybZ5yhMKGRHPsTYi+M/x2Whc2fc9960WuBp1FoR07U0dlY7bKdGNgLl899jRtdbFJap0GWw8Kkbc9fDvXYBuFDTEcCCuMN4Hb53+qh3fC3E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39850400004)(346002)(38100700002)(16526019)(7416002)(38350700002)(31696002)(52116002)(2906002)(83380400001)(86362001)(186003)(66556008)(956004)(66946007)(2616005)(31686004)(66476007)(5660300002)(4326008)(53546011)(8676002)(316002)(36756003)(478600001)(16576012)(26005)(6486002)(4744005)(44832011)(8936002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFNSS9KM3htbEpzWjhOZzRNRzlnQ2lnNFNRcWt1ZFVqTEdvb3N6djh5TTIz?=
 =?utf-8?B?Z2JaMjNKaUVKeGJVdnQ4cGt2OG44cXBJUldOaGtRZzk3ZmVIQnN3emlZL0Za?=
 =?utf-8?B?ZlU4bHpjbWFmZU1ySmh3TUNVRU1PeE96R0lXMVZPOHNjRjhUN0hGM0xnUkln?=
 =?utf-8?B?UWh2MW5ISzhqRmQrT2gwd1B5MDlhVzlyQytmcGY5UXNDLzd2Z1VjRE1tS3Ji?=
 =?utf-8?B?YjBKRlhlVUJtK0pMMU9BcXd3MTlhMWpSWlEyamt0QTZmUXhyVWxJYTF4eGxI?=
 =?utf-8?B?VTEzcFZJOGJCeFh6ZGcyV0E1aC9pelh2QUJ5SUNPcXEvS1d0QzRLckN6NnlY?=
 =?utf-8?B?Mi9uZ2NHVmJwajBaNFZ0RVVuZElJMFJNVGJ4V3ZsOUZhdDB1M0lwSGFtT1ho?=
 =?utf-8?B?OEwrMHpGbTFDU2hTR2VXUTdCb3krWDVFRFhZUjJETHI4ek1SRUlsd1hnWVdu?=
 =?utf-8?B?YUNJMUQ5K0hSOGhOZzhWcEFiR1FIdGxNblI4cW9HWFRGcmpHREEvaTlqYkNy?=
 =?utf-8?B?MEVzY3dxYU1TcmUxMjdtU3Q5dVJwMlpHdUhzb3RBYzBlelhhb0V1dCt6ckRS?=
 =?utf-8?B?ellrVDlTR25xSlVQcHppcnZVWG45QzU2Q0dYV1NHWGZNWkJkb3lpUHRKaFdH?=
 =?utf-8?B?M1dOUCtUc2huV1hLZTBXVllyS0h0Zjh5Vnl3ZGdrM1ZaekUzUWtVNWpOM1JB?=
 =?utf-8?B?SE9LakRYQ0dDZkx2MlpBRCs2c1Y4L2ltbVZCZ0Y4MDUyRHJYTmhUNkt1NHhL?=
 =?utf-8?B?dWphb2FwanozNktINGpwdHFKd1VOQkd4M1pkbXJTK3c5YWxLUDZQRDEwcE8v?=
 =?utf-8?B?THFMdHd4NVhQSUZoNXdaeUZITTNwamlBdzZjcEpuZGpqQk1yeEhGblk4N25L?=
 =?utf-8?B?Z2lES0FGU3NySnBuTTZWVFV2UUNLYkNlQnAwRUZkRk9JejBYdHV5c2l2NmhM?=
 =?utf-8?B?T2ZYR2RXZG9MZVpOQTBlQ01Mc3d0SHJOblpWMndyQkUyejNmVHp5NnZRMVBw?=
 =?utf-8?B?YTQ1Q2hFVW1McmxWSjBmWm5OVlFUVmorZUZZNVR1dWsyQ3F1ZkpyR1lPQXhq?=
 =?utf-8?B?YnpkWnc1V255UUlGdGVkTVZsZXpTQWVPTitDL0xuR21OUnFXeEEwYURkQ3ox?=
 =?utf-8?B?all4Mmt1ZGdKdk5nOUI4cmRhM1IxbEdkeEJJSWYrUDBKRzExL1FRa0F1RFMy?=
 =?utf-8?B?QnhEUjUwZnJORG1rS3hBNGdzcDVrVGs0L0dCdDFqSW9nMGxWYm9DQUdsOEpi?=
 =?utf-8?B?WjNLRkYvT2cyUGM5WFBONVNkK3JJUkdON1lFSkZRT3JLeUJOR0YxKzREbXlI?=
 =?utf-8?B?QStnNFRuRkRoWmJSSVFMMVZnWXY5eFZ2ZGt6VHQ4WEJGWkpSQllCcnZXR2lE?=
 =?utf-8?B?TWdTRUQ5LzV2OWVDNnNpeUxRZ1F3UHY3T3hmZTNWcG1idmJHZFAreXVObmFE?=
 =?utf-8?B?VzJ5ZkxEK1lTTzNrUHBLejZzVmxyR1pMRXUxY1hVNFVtVmVqaU83a2wvaGxP?=
 =?utf-8?B?MlN6NExNRDBzU3lFSEJyMTNmaTJwUjRUbWVXMkJUWmNXT2c1L2ZISW5KZjJ2?=
 =?utf-8?B?ZHVaZFVTZ0JIMm1DeXg1STdNcW43dkJFUjhta0w2VVdVaHhLeWhibzUxRzNO?=
 =?utf-8?B?SzdJZzhONE1ycno3YTByUEdHMDgxQXJrUGtTY0MvUUpYcW1zZTNrNGR0TjA3?=
 =?utf-8?B?NDdyQ09BemFHMm0zSnZkVzlrWERMT1VkVHNkbEQzL1ZrWkxDbFRILytqL3hK?=
 =?utf-8?Q?7hxXkb/a7qop2CiK5jIIQiJirCoEl/qXCVttmXb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28665a20-0846-4beb-604d-08d92c62064d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 22:49:37.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuBD3fxUdti2Bf/0vL1M/MeUoAP0611n2CpoPqM0AJtUPz1H58YkEGnQcHobLC4Xkl0DZJ4xeU6Cd+hH5NqS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100136
X-Proofpoint-ORIG-GUID: Lr0WFke8N_n5AaE_MR_7bZXa8BsP_P52
X-Proofpoint-GUID: Lr0WFke8N_n5AaE_MR_7bZXa8BsP_P52
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 5:13 AM, Muchun Song wrote:
> The preparation of splitting huge PMD mapping of vmemmap pages is ready,
> so switch the mapping from PTE to PMD.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 -------
>  arch/x86/mm/init_64.c                           |  8 ++------
>  include/linux/hugetlb.h                         | 25 ++++++-------------------
>  mm/memory_hotplug.c                             |  2 +-
>  4 files changed, 9 insertions(+), 33 deletions(-)

This pretty much removes all the code previously added to disable PMD
mapping if vmemmap optimizations were requested.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
