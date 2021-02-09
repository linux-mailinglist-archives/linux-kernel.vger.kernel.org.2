Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7C315704
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhBITkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:40:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57574 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhBISTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:19:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119IFHOb170662;
        Tue, 9 Feb 2021 18:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=E499UG5zbGECCT3Ob9e4EdNVAFPCGmbr8C4D5QHIu9I=;
 b=PwipQlxQkuAOzYDy/gxy07sWaedduVWoSvlozAhDwu52DcppxeicRZMY+AUglNV9Urr0
 gog0yiTtyWDM54lMovcwPIfc2cx25sIDLNYnp0380/rNK0D+G9cwF19gsKsPvy33P7v+
 2YGHQvRYveBjXwZLznxP8XHffQLfd6TyK84jLaEd1CZNzcY/gsL+2RtByxm+whIOBNjm
 oscLI1X1i9XlQucJnK220JGg4BJBsxXcuS6Zru72VDwcyj0tuMt+ldTiEpp8ANsFzRH+
 3NnhSbGlC3WaCzo99bzyNsrl8rMoiDXkmuPcUz3eccTJJ+JQ1cSUfr4Tk5eeHhBsMTp3 qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36hk2kghk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 18:18:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119IB03d029591;
        Tue, 9 Feb 2021 18:18:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 36j51wf3sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 18:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5oRZMX4yjJnzw93JA9CSAk8z6MzpCWcWkXUT1kmFltKsNmN5+nmGpefLoZvsQu0zsUx+01r6vBeupbOMQVH9XfdIolSjA78j62ReqHjz1xokXltynj8Iuw+udXD+HHQRjycnikM7C4xqztEsuyF3+8SPBIvetEqmLNCh93EpWBhOjWpBmytChCBZshhu/IMWkoQq/kI1nU4Mo3u9D+9oHJISsApCnHzaTtFZKRqUgUwtYt1fHyO3SEW460IoRTvxGzF1cDJubfcBYy7enxy0P7syzUrJKe16FeSsHcbsEErNa7irDR/fALDUIaYXKuN9WXKPXNFPz1hNMHeo8kDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E499UG5zbGECCT3Ob9e4EdNVAFPCGmbr8C4D5QHIu9I=;
 b=k1ZyorwQocfkjEofAoASi/srxsqmYDOZNVpYm4vWWfZURlgaK3Vm+mQCJY0TYgK6Pn7LkCIf8QQvRD2dm+8AhebncarXvOWVBo+2DpWLu/dKCK9xd5r3E9oPqGNCbK9f2fsLgUIN/1OonyqkmTqX5AzMfoX8BzNH0gh5uRnXEMQI/oPd5PZeZk13Kv1YRRDEzDst1tZSIQlVfP9d9OZ6+txvGEs+HRUwcBOMlz5yezO5Au+6QzGdFsoa1Dmpq7cXc6khhjZSCLLNtZ1mI2ppE2x+/k8Azqqisi+1znaaoeveavLh+zBpo+KuZ3xdQKVUumakMtdMhd4tyIj1FZJWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E499UG5zbGECCT3Ob9e4EdNVAFPCGmbr8C4D5QHIu9I=;
 b=ylbAmlYbpGRPtd1DVT/1ol8Rw1RSEl67yLc5zfhL2kh/xMJmJM6yACc3m9wHEmQt2fyJkX7RLYIIhmYp95TpJXn2FiBaHihfzMw28V7UkUIb/bluEgoKduL3HAFivnr2ah17++vaBofqf3bjXyURWlO2MJwAS01xT1E9PtfOJ8U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4802.namprd10.prod.outlook.com (2603:10b6:303:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 18:18:17 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.027; Tue, 9 Feb 2021
 18:18:17 +0000
Subject: Re: [PATCH v2] mm/hugetlb: Remove unnecessary VM_BUG_ON_PAGE on
 putback_active_hugepage()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210209071151.44731-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5eb05d5c-8bfc-8306-d767-0a0fc842fb46@oracle.com>
Date:   Tue, 9 Feb 2021 10:18:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210209071151.44731-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0044.namprd21.prod.outlook.com
 (2603:10b6:300:129::30) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0044.namprd21.prod.outlook.com (2603:10b6:300:129::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5 via Frontend Transport; Tue, 9 Feb 2021 18:18:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ccf5a1c-6151-4877-67b9-08d8cd2712ad
X-MS-TrafficTypeDiagnostic: CO1PR10MB4802:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4802A27AE0DFFFF8791AD49CE28E9@CO1PR10MB4802.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dZ5L840BzSPB+Iig+5Fmd9dzVrHir77/T9FBRUGAploR2TpnvlejgZrMnJCRYmoHNIuock7+rqlFehqedfTj7vfKVXYLzoNzvLtnr+c/pUyuLpZkysszcQ6pZ8N3haZHbT7Ly9gWDBaJ0lOu/pn8njtEYHaBek5tTdHBISaH2MCCGwVPT+VtTELkvVnA431hUptFWdVtPKemaAHr5DY6amFVJZFPmauaLnCX87/QWEaqUCH6vdUNKQcyR94cAthZK5scZxbYLf+/F/gfxUjUdm4C+VLYkgCQBY6mMpaaNg4pfHFUb9dCF92d4Tlt6b9aFOKv3tJ2Ly+njrzZrdH0hUgW3XDoMON0x/Om/HNKruPHMqXc2f/M1n6G9ErcZyjOSDpzr2hG4f2NAtef4FfUtetobgEwfABn0M+H9Z6A3TDLQmVp297IOfuoiGCdCH+7WRLZ/ESodot4xOvSEoosY1unHkWkDB4fq91s8FNlPAQGGWvct9qKGID5cAj+yCHhZ/SiT9woBBPohwk6v4xRuZapJ+xVZjj1HuQzU6lTjwC0WFMGGbXnwWSsf3aWX58umx+tiyiNFQzlDemhKzgupscW9eiBwL6cdf7ReNcExo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(4744005)(5660300002)(52116002)(2906002)(478600001)(66476007)(66556008)(66946007)(8936002)(26005)(44832011)(31686004)(36756003)(53546011)(86362001)(956004)(16526019)(186003)(2616005)(31696002)(4326008)(6486002)(316002)(16576012)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2xWWk8yYzJ4dEJPb1RIelR1SFM3T3kwUFpOUm9hNVBvRTFGalJpWjRpWmNK?=
 =?utf-8?B?eWxYM040ZkNRaGMwVGZGSlE1b2tTcUFSZVBJclduSE85MjVGRW9rZWgwZE55?=
 =?utf-8?B?ZE1RZlpPZ3R0b1pUbk9OTjN5OTFXZWVKc2YySk9pQnA4VkhtUGRCOTZWOTAy?=
 =?utf-8?B?aDM0L1Q1c3N5RDcyelJHTVp4eitRam1tNG1ZS25WcUJGRzF0bndqRW5CYzJj?=
 =?utf-8?B?N3Y4YlJhTkUxSUR3R1hibWZKdEU2Yk1vOGs3eE1FVDl3SXd0NzU0UjdmVVR0?=
 =?utf-8?B?VXdCZUhvMFZHK2dQTjQ3MUgxenVjQytWdTZiNXoyMmRzK21GS2M4T2o0K051?=
 =?utf-8?B?UmptUU1aQTVZb2NHTUp6bjNpbkw3VDdOQ3lERW9UZjJuV2t6ek4ydmNTalA2?=
 =?utf-8?B?a1NTOTc0c0xjYVh3bUF2MmMwdVFOWEZrMGFmRnZ6V2N2bS9GM05BQ0g2RW83?=
 =?utf-8?B?RE1xUndqU21CZEpQY2ZIRldBUUZvc3lnRGNEUGZpQzBzNlhqNlBlK0hKR2t5?=
 =?utf-8?B?QmNEdHpBQ1RBLzgvdGdBa2FDN2hFUlZWQzBRTlpicnZReEhXcFVPWGJwQjYv?=
 =?utf-8?B?cnZYODg0cUhYR2RkdUdTaCtoU0QzbmZNWHdZbzJkbVNXYktoOUpBMmUrV1NN?=
 =?utf-8?B?cGlGaFpFd3VRR2RmN2lSOUlMZmlwOGVZUGpGYVc0bk5hK0VqR2JNUGZuMjRq?=
 =?utf-8?B?NjMyTWRyem1hYW16OFlId09XVFlPY01JUk9QK0FSMFR4YkRKZWlFZ3RPZmIy?=
 =?utf-8?B?SEVHb3lzWmJZMDNaOW1hOWo0b01kZFo0WXN6bWpDNmJLY3VIZUFyNmJqMCt1?=
 =?utf-8?B?RXdnYTY2NHRwUTVHU3BTdHpucGh6aythcDk1aXNHSzMrUkFFQjhaVnVibEZo?=
 =?utf-8?B?amROZ002ZktkNWw2VFp4d0s1OGlvSVBJR2l4WlA2V1VNSXVNYi9jOUN2Zjlv?=
 =?utf-8?B?K01peS9ac1h1Y2RpaTVHQi9iUlYrRWE2QXhoMHBRRE1mS3pzMDJPZEJGUUow?=
 =?utf-8?B?UHBPdzFnUGh2RDB6UEg4amZVVm1TelZPV1V0SFRyRGQ3dFVZRDQrNGw4eFFN?=
 =?utf-8?B?c25kV0ZhQys3KzNqNjgyZkdZVS9Wbm5hRitZcEdRU3Z4TUdzT1ZoVzFHN25I?=
 =?utf-8?B?Wm16bGdEclBNVjdaM1ZFQmVXSDJvcXI4THNWZVhob3JnM3NTd09DenMzSytU?=
 =?utf-8?B?QXJ0Kzhza1JXNUJMSEVGQ2c4T3RpR3BidEk2dVlxM2tkNFo4L05rVGRzVUYw?=
 =?utf-8?B?M2I1OTBKYXRGOFpnVnVob2JxV1ZUMEVXK3FoVExxUjlyWE9Od1h2VUdETUFm?=
 =?utf-8?B?RU1sRTFWSDdkMzE4NWNyd25kWTc2L2k0WHNDSnFiNVpibytNSWkvTWpNZGM2?=
 =?utf-8?B?TzFaV1Q3N1pxeFZTSHFoc1BqUXJTbTg1a0kyK3BpQlAwYlV2cmV6M0pGMVNy?=
 =?utf-8?B?bWhabmxEcW5VSTRpdDZpR2d2SDhQTUIrOUdoMHE1enl5TkFEbFFHaGs2YW8r?=
 =?utf-8?B?YUtURTZhLzVRTUhqR3NYdjhuZDFsMXdSbGpHZnc1M3hKdWF5K01tMkJYeFh2?=
 =?utf-8?B?SW9hSEhqbmxWQ202ZFphaytGNm5XbnQySWxtcW5SWStPQkhQVTl3b3JRODZk?=
 =?utf-8?B?N1hBZWtsMnJ1S09aWFpSTm01ZjltRUJTZUdhekE3aU41WUNUcXVraFRlbG9F?=
 =?utf-8?B?NVpubWQzb3d0UmlyazFtcUwwT3VKWWxQQ1hzTHRvb3lPeFZPbkRjVnI4MnE3?=
 =?utf-8?Q?UD2uu2IemxStmrYB65c8DFs3IsZE6Fb2TtmJHEJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccf5a1c-6151-4877-67b9-08d8cd2712ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 18:18:17.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lK3caB1EFMoyAUNTrG0yUbNvAieoooUEHKRQzxjCdji5MOApb10LQSpOzSGCsVTTrzHXZEzoTkAgVCFF/27Jqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4802
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 11:11 PM, Miaohe Lin wrote:
> All callers know they are operating on a hugetlb head page. So this
> VM_BUG_ON_PAGE can not catch anything useful.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 06719fdf9fd6..cfa06fd1b8d7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5577,7 +5577,6 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  
>  void putback_active_hugepage(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
>  	spin_lock(&hugetlb_lock);
>  	SetHPageMigratable(page);
>  	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
> 
