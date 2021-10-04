Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B1E421538
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhJDRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:37:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18958 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234034AbhJDRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:37:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194HHURi019448;
        Mon, 4 Oct 2021 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xe8hYBo/rL7gJTQALFCSEiQFaML4p/Hv6VFPJKmdiUs=;
 b=SqjJtie3pAPmTbfPDoRMypJx4/9vmqsC4aqLodgNc+NImDq/L9zrcD1meUWm1R1RZjHd
 AuVTcjjrMSJb4wr3xr+5eKk7sWxTzuISXp7AJ48msRcIZTlJsWVarAVHE/RFHkpx6BTT
 LlH4LBFYbDgH5IAS26+Ixr5AHj7/lx4i2AwBmklijf2YmD+b0ASprVaX9ed72a2XOQY1
 XzUINMbX/ParxKSzTwSIyK7vZh1sIWTaaAcOiSiWnUUfIq+tJfxvc7x6wNP42CaFa6j9
 nCYlhfT4e3sowHOBgahxKKDE6TvTgQvm5WvI0KsmfnTaHbW+kkXVZaB1bnTrfNadN6tQ Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p59gxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 17:35:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194HYbor195294;
        Mon, 4 Oct 2021 17:34:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3030.oracle.com with ESMTP id 3bf0s57eqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 17:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGrg4rEU4K5ZKk+T2DSK5hfRGNCw+RqDGu/FEd1ggKJuoS10sLfLb3OAdLNqdZ1noDGo/4q13X/Dm0XCC/Id3dpG0OcIkykP5s5dc5e3qy8GkgCPCdbvpzr7GmcMtyPHxgD/o+V1+JnV8HRsPT67ywBHn/2Wh0x1j3cfI8X6BzoNhcyMDYSfsAGAb+f5eO8stV0dnaLobkhGlNudnQCf+qLhSEDeepmj73/l/+AzeJKt7XYu4Gg09bxPhlRRPdTtA5dDnhyRioiL6rMykQX+PrEV7HlZUQxI7oVA96bz+b2yhe8p9aqlyD9mHHPSwsFir8Myz3J9SqlTeSL5LpwRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe8hYBo/rL7gJTQALFCSEiQFaML4p/Hv6VFPJKmdiUs=;
 b=dR7UgZoCvCiWFA2Fj99j+C3ibUZUiH/P26hLB+hbVLzlO7IrPrV2HV0US5tzj6XXCSp5hmIQswsI4pXwM22arBZCBiLYLQxrN5inU0ma2cqJ/q7gPJmB8AD2ixMkxFQYtqktjevCkFNC0KcYfu9GgvPStTD9E25yD1g2sLB1cN71ati/Guv3gDNWjRhR2X26gX0blUITAj9DQXcYlVoI0dhBG+zXPf1nEPsO3NA/NDjmpo6sw2US96VCkI62cIkZHu4QT1RXlcsa6ABE/D6MJDRibNYfArSOBNAa853nLqWrTn4WEOrsM5HyNbV/hsXMUIQTTGvE37tmAITKJxNfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe8hYBo/rL7gJTQALFCSEiQFaML4p/Hv6VFPJKmdiUs=;
 b=d9rwxHQ2+C+atxxINACkmnoxmOjgQlEWp01+CzXtE0DjUH7oJgAssIaltBje9/zfD8chtE+kZD/rsfjNqgGY8MtRgY6ty+84LSxeJO+Cfq8rqzCxvXcLmuQxhPHFk4W0h7oDyEiiRQ3fdS9U74Zkb7LUNFvhLcGBWTUz66X6wH8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3810.namprd10.prod.outlook.com (2603:10b6:a03:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 17:34:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 17:34:52 +0000
Subject: Re: [PATCH v7] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210927104149.46884-1-yaozhenguo1@gmail.com>
 <c83bffef-53ca-5448-38b5-27282ba97499@oracle.com>
 <CA+WzAR=eVOYamSoEyuphiL89qXh+=0kBZAPkxAnuqamMWgrTSQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <669bd927-397e-f2d8-3be4-798b9d7c4e8d@oracle.com>
Date:   Mon, 4 Oct 2021 10:34:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CA+WzAR=eVOYamSoEyuphiL89qXh+=0kBZAPkxAnuqamMWgrTSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:300:94::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR19CA0051.namprd19.prod.outlook.com (2603:10b6:300:94::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Mon, 4 Oct 2021 17:34:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf5a162b-021c-49cf-788b-08d9875d45be
X-MS-TrafficTypeDiagnostic: BY5PR10MB3810:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3810F6B9EAD42D04187B7FCEE2AE9@BY5PR10MB3810.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnpYi+hnTr0SfZ0TGdzam55ZyBhM48ZCqtxr6cy6aZ2AOZOFQtyYtPxMfXWVDKQ7ZZYYDrKFNorioe/8QmZiW54zu/KZDTfVO0/wKBRjNwkvOvFGARMvD2o6KV2mxEFaPWV9k2HNXN2s8QtbhdPWY2sxZ+2VTadZrXIjYhdwGHGl3yslZXqVs0YCDIjXnSzAko6nrEmBeEzMnztNK7D5r/UYJ7R2wRSvAHqmAMLyW8xJJIH2kjvmvTGblyeJD/OzO6iX5OT6SrOq98QEmEMdXAfSAMyyBm1xadub0rrymG/oQtTUqgJeYtQjlK6cXzYJkpXH8cnIuCf721F+F3HsRBlYwvqH5df6r79w2VLeiI1DvLbhBeE6gyuTngnqfLAYSZGFhQHjcqZQBPOOcG/zYwMxvoWprK0iwcAEC6yHKYu+qMXts37O+A1k/GSBOilYYms+8uV5RajVQVDClvqIQOvj4HQQHqVlmfRbNu+k1AOZfwLQqZVd0w5Mv05gtS6GNxDwaZUwQ5suwCwe6VtF/n1rBb6vPCCktPW1ShHmBjbosXS1+Gw9IaolUHqxbtCrMgGhz+xlPyvlMXDTi9llreSOqeH3iAZnWUINPcOczaTflNV+HJQJ1oltfxCxBKHvQnFXrqm6G9vsuT6C82TXeiShfdTwFN9QlXtcF3y8t+7JFtk29DwxToQ/Dry4IO6Nh6U+GyyZ8FziP+R6ldZ/+k4mFQ+1kDa+cOvZH2kN6i11oyUxSxYH28SxWZqJJ/xoVJG+IAY3kduKhquwV2HFbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6916009)(26005)(44832011)(31696002)(508600001)(2906002)(53546011)(956004)(2616005)(5660300002)(36756003)(52116002)(83380400001)(31686004)(8676002)(186003)(66556008)(16576012)(66476007)(8936002)(86362001)(6486002)(4326008)(38350700002)(38100700002)(4744005)(54906003)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZUd1FHNCs1RTdibHAvbmZCY3FpNjNabkVidmc5NUY5SFRhdE94T2l6VTIv?=
 =?utf-8?B?Y2lwd1RTRksxQTg1VnN2SlA4RmVOU05kTzZhNjRScGtkOUFTcklaNXUwNjla?=
 =?utf-8?B?aEptQjRRNTNIR0kzS3Avak5sWkI4cEpYaWdwelRKMnZXdk0rM2YvWXEyY1hR?=
 =?utf-8?B?cmo5TlhlbkZsbGxReGhiVjE2eVl1bkQ3S3hFK09tbnRDOGNsalBYWXNKdVhh?=
 =?utf-8?B?WklNK0tuT2tjWDFYdHZsMlZ0dkZiakZpWFZHOU9zdTVXY3BrSWR3TFZXQWRU?=
 =?utf-8?B?RzllNnFMdU1oanVLcVA2SFVqMmh2ajdqcVJUcGdTaHNWZnU1OHEvbVphV3Yw?=
 =?utf-8?B?MVF6Um56ZmJXRG1HWkEyOWIxQXY2VjYvcUN0SE5ZcUZhQjZ5ZHp6ZVE2ZGJ5?=
 =?utf-8?B?SFNHL3pTOXNCcEhhZ0thUDJjLyt3SURWSlNXUC81WGIwNEM5SWl0d2p0eFo4?=
 =?utf-8?B?NU1rYUFLY2RoSVQ4K0FOakIxUWM4Yk1IS0F1Rzl0RnZMdjB0SWhTMkxyZ0dk?=
 =?utf-8?B?YStIdi9MYXhIRDdpU2d5cU1aMmJaejVCWnNTbkhCaDBXbjJpWWJGck5PcFhD?=
 =?utf-8?B?cWFTZHRGU3VKcDFIME9HVmtwLzRxNDM3RzZ3VndIbTBtSTJya3d6SjRqYjlE?=
 =?utf-8?B?bUlubTNqTVI1RjBhbDVkamhKUVQ3N1FOK29xZ20vUUtTUWlzbGdPM3BGYytG?=
 =?utf-8?B?eldiUlFYQm1aQ3dqN3Z3VS9YRW9jaUQyWUVLSnJvcGF2UWhRWnUvb09NWmNu?=
 =?utf-8?B?ZDNvN2gvTDZwaHFSaFRCQkhWOGVabjJTbTZ1REtEVmVobSsyNGhyUHNDcGdC?=
 =?utf-8?B?TmRCUExLcERxS2JsQ1dTRjhIMzFyMk5DQTZIZWltTmt6OGpKc2U4am9KbjNm?=
 =?utf-8?B?UE5FZEhWMStRekkrQ1I0WkJMbkxFdXZkVWhCT0FCLy9JRFBvVE1SMFRINXNP?=
 =?utf-8?B?MGs4MEZENkE4YzBGR2RlVFN0NnpFakp4TVVpcURSQUNOSnUzc1htaTA1ZTUv?=
 =?utf-8?B?Vk0yYW0zcU50cGY0ejQvNkRuTU5lZE4ybVNiSlc0SSs3TmtKT2hFV1podjht?=
 =?utf-8?B?RVM0TEp1WmZEZEdEdW1IUTlvd2duWXNCYVdyckE4bGwvQTlTNzE2Y2h0Tko2?=
 =?utf-8?B?KzB4ZXorbGV4aWE5TGVUbXFoWHAyamJ0M1VvZ0FZSGJPSVd6bTBTSTNHNHpS?=
 =?utf-8?B?bkUxMkE2WHptRlFYNWkwdVkvZWFrZi9MUWpRblV5dmhuMlZwVmxPUG1WdVlV?=
 =?utf-8?B?UDJPeTJhT0djWnhEK3pWVUtnK1NQNmkvMDg1Q0lldHBRcVFiMDl5MnhvQlBm?=
 =?utf-8?B?ZDh4MVYvNmdMMFMwSmdUem9HU1pyMnZJWkh0SGhuYU5pUE5WL3dqYXlaMVdY?=
 =?utf-8?B?akdyem5aMExmVmxYY3c1UjBHVmQ0ckU1bmdlcGVKM2VpdnFJaVR0VmtPMWRG?=
 =?utf-8?B?VzhuZ0FLOExxNHdkeEhaM3pmZi8wVjl2b29ZVHp2MjgrK2RkR0VNWDdCTk5M?=
 =?utf-8?B?WWRSMGRrUDRvd3Q1bmhML3J2dXVwVEtTVkFaUy85cUw2b0Q2S0Y0R2hSMFpk?=
 =?utf-8?B?c1BrRXlDUENYdGM5RE9zSnlDblFZa3NSUWNTZUhielJ3YWNDcmtnSml4V0hW?=
 =?utf-8?B?NFpQUERrWWpTdDZzeW8rd2Z2T3h1SGpnYkR0U1ppb25ET3JiTXZZSDlCd0Mr?=
 =?utf-8?B?ZVdCK0Y4VC8xSCtsU0hjVFhxdXNWR1hLMFJDcXFOa2FNcGZVbVBnTHJ1YTFO?=
 =?utf-8?Q?z5nmCN00D+oKxiHQRL0bw4+cLN1+jIghAmssPI8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5a162b-021c-49cf-788b-08d9875d45be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 17:34:52.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVasbj9/P3oa6bSbAqZHDvT4OhafYyZVZoI0rEFyZB2yCVvDegQDBzLBQ0atfJETPSQzqqI66LnuZetfdSnt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3810
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040121
X-Proofpoint-ORIG-GUID: JbCKXeCggu3MyM5nAL2GHjgmboMwJ81o
X-Proofpoint-GUID: JbCKXeCggu3MyM5nAL2GHjgmboMwJ81o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 8:06 AM, Zhenguo Yao wrote:
> Hi Mike:
> 
> Thanks for your review. I notice that this patch has already been in
> linux-next. Do I need to submit another version of this patch or
> provide a new patch to fix the problems  you pointed out?

This change goes through Andrew Morton's tree, and he will decide how to
update.

My suggestion is to send a new version with suggested updates as well as
my 'Reviewed-by:".

Thanks,
-- 
Mike Kravetz
