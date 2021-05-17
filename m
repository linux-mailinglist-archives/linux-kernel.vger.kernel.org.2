Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B938660A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhEQUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:13:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5080 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235019AbhEQUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:13:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HKBKej027866;
        Mon, 17 May 2021 20:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JW70kGZo8a5CNALDiFOhJg1wgVeSunUHQWtZhhWpavo=;
 b=x42ezagvEbaTHPs6H3OBNdV+nVCirYw+rw1rSX/Z5SGw1P2H/x0feA4P9TWAqfchLbgg
 j57r02gphlGklstpRGdlsjvcHj5XozbSREBQYzCW5lbyBCkK1+aGFa5OlQr+8QeXdzoe
 WpDvi20mqjGwMwMoHYc2aK1tFqZ/JIwLtaY3rFlhULN4rTwt2LUEbKB14jD4MqPZ9Au+
 XxEsS7BPoT4LVDkusRiALPiF1ILrx3KXLHBlxmjQvnB/YMDwMgNiuJoq8dr8XjfFcxzX
 4xWprlck9rITWDgM77rc8CNwFWq1Vl4gGgKZYf0r9kO69At9XqYP7x24hCAz/QZwvTjM 0g== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38ker18brr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 20:11:31 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HK7OdI033744;
        Mon, 17 May 2021 20:11:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3030.oracle.com with ESMTP id 38j3dtn2y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 20:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6urC9wCewyF71oPfBJwj//CLWN9JIypiKJvnggXzzgKYKx4Ra8cRWQ71iKlnmh9PRPAru0S2dWVyzJsoIIYiVBbEKLkjm3J4ZInydmtACchgpGfa4Eo0tCVh7hj10ZZrNpxeskPexq0tWtWzhld04A5IZ9fQLO9uasA9lVCc/vUbUJD/2cT3/IFjkbL8Np+hi+4mDwYWDZmhE61uC8ipCVZewsZWrF+1PMoYM66fRbCpbBftSyqSnXNHbkBm59jxX8rvWSetj/8ODLkIzpTC/Kclpt7/Uewq6h2Brl4gIAos9CoRRFtZHzP6YjN0e/Q0TRNhHiRt0n/ePnKJtX0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW70kGZo8a5CNALDiFOhJg1wgVeSunUHQWtZhhWpavo=;
 b=TEvFgZU6ufv0My0hnkLml0W+EwhSdrASedXfmRVpYFtxioYHDVE1d4tp7oSLTJONTPdM53fh90rh1NtKPtOM8YU/SZ2qT2hfoTUdjkWnptS9j2Y5+hFktLdHPGMQqe9JyOGCHkKA5l3JTHTDLsuu5s7y/vvc9+qnv67DwUFjH60QKLtWyL07kOtCXK3tSxm5a0kEl2pXDdGjirhAJ3hAVWbhxptmAYuKtOByNEJL95AmG6GVmg/72oSpBLk+tjZBKyoCcp2kQp9MxyQ+vsnYo6ibz9f4eeGbGHaCSvvTzFz7Q/8R6nfHl2e79fA5T/0j3NxFAI3ts3GcmrKWQQxQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW70kGZo8a5CNALDiFOhJg1wgVeSunUHQWtZhhWpavo=;
 b=IgoWgch8ue9YdYusk/pMOV6PeiD7Cq3DKXThII0Cyz9ywi1oFVS8iVxiNOhf5df24w5aaEIqJsnZZJavNeqJAFIkkzXJnbNa+vhZb/nM9aph8b03y+hU9fKDgq0/CyxjhPM8FBKb8S7Fj0pB15CPSq+PXjzy2Gcn6X0gjga21dA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 20:11:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 20:11:28 +0000
Subject: Re: [PATCH v4 1/2] mm,hwpoison: fix race with compound page
 allocation
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
 <20210517045401.2506032-2-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <126534de-9679-0e22-bb2c-807f40edca38@oracle.com>
Date:   Mon, 17 May 2021 13:11:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210517045401.2506032-2-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0094.namprd17.prod.outlook.com
 (2603:10b6:300:c2::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0094.namprd17.prod.outlook.com (2603:10b6:300:c2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 20:11:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e03329f3-8900-494f-f9d5-08d9196ff464
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4413:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB441398AE06F785DE4224627EE22D9@SJ0PR10MB4413.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3W1I/Se9HnPhmKrev3Iheg9+BNib6rxDEWGlLo2n+LQtyz/QoGK+kldlUE3xfFgzXOQ0HKXfAwouy0dBQ0GD+2ANRVKRxyKMcrH+o0BSfpYb6WeZYv/yF8iaVRQ53hUbAgSzNztNBjXwIO4wL0/QKyxZA5m+SKRMdZ93wZ3B8a5oq74KkhhkU+3snNg5MEVs1INIWUSVkjFW5w45y3+IXFAZ5p70DckMblrmpXmNvRmQf7VNOfrvWtsZAe7JoIB/F1acwUnrkcao5BPOkZYw2wlRSykpA3RNv9QNOMuxASCkt8fdHBAHL1lb+vxtB+Qa66oNZFOA1OJaJYXiZdyg0o7WSN/bKuBsVLBbtqeeAWO3aCg434xW8jtuO+RWZP571NKxREwtgqdNDxKZ6X69Tgs3AGz26BwL3ruPP5aarfHIyIlZcw9sVZL1hwJ3AW1AGT+HlY863jZ9Felm25jMGiwuzV2t3tit9IfwKM4ASRDuiePnl32RoIQ+kk231MQwaFJYTi7Tk0DME6cPFZjImh0lWH/3k/xTdSPAidFEAabZP26/DWgOPVsoGP95RVcW/GERa2okCOqQCk2i0gvrJNpI7Yhm7mHV8ly+sZEM7RzUe/pEEzta/hGRH2kqv4xKXQjpLupGvdvBJgfTjNDq5GMXMUnYZtTuPhX3caajbquaPX+WUkO/9xryOG2IES6nYqyyRdlELITvihh8ytgxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(6486002)(52116002)(54906003)(16576012)(110136005)(956004)(2616005)(2906002)(316002)(36756003)(8676002)(478600001)(8936002)(5660300002)(31696002)(66556008)(186003)(16526019)(66476007)(53546011)(26005)(83380400001)(38100700002)(44832011)(31686004)(38350700002)(66946007)(4326008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0V4cDJJcEVna3ZnVDNMSHN6RktydE1mRDJ4TkxTZDBla0tqUEx5VEZSMWRE?=
 =?utf-8?B?dVdTY1Nua0RVM3VvbXZTcHUyM1JHc2Z1UGpDSGxmYXIwZ0hDZkdTNC9mc0ZP?=
 =?utf-8?B?andmTmxVVCtFZHBqV1JBdm9RWFRSQXpMMDBIUng2R0tSRmJJTEFrL2hMSzBL?=
 =?utf-8?B?b3FXeHRZTnAvSHhaRU9TRkJURlN0czNCdnVQYlJDdExHaENGMkcweGdqYlNx?=
 =?utf-8?B?L09qejUxdkxnOFlZMlNLUzE4ZzNEU3AzditqdDBuWUJ0bXBFdDRPOFFIMG03?=
 =?utf-8?B?WUQwNlByQjFBOGFTVGRzR0FTKytQaFZMeFEreG0wT3R1ZmdzZlJ4NFVlZ2JZ?=
 =?utf-8?B?cnptcUtWeFNpQlpKeHNNcFMrcnV2Y1JIUFdDazBpa1dsdUVJQ0RwVUJjQVFM?=
 =?utf-8?B?T09vN09hajdMcWZidjg1ajZBclpjMjZIV1JsRjVZMU5aREd4b0owSEszM2V4?=
 =?utf-8?B?ZHhSMXZVRkwvWG1yK3V2OE5XNjByVWE0aU02NlVMMk5JRVVzM3JRYnJXL0JF?=
 =?utf-8?B?SlA2dS9yWXZrdHlFYitFVWRZVnlmOHRNVXJvN1RKcm0vWmRtTk5sb1VJSGNC?=
 =?utf-8?B?RmhUbEhydFdDeW9jalJtbVZ1R1ZFUE1WWFJhaU1nOHBsL29GNkhTbEZJdjVw?=
 =?utf-8?B?U2UvVDI5dC9LNTZTOGo0V0ltRDB2N1huUkxTajVSbkk0K0pwWW9ZK0RMWmpm?=
 =?utf-8?B?SVBkTUd2MmpCV0dNWHpXaWl0QUVMdXZHMnBnNW1HdFhTVE1SNkFaTTJ4UEJO?=
 =?utf-8?B?VzlQVWxyOUlmTVBZdFdmeTIrd3RRbjlmZlA0NGE0bFljc3R2L01IWFNORFUx?=
 =?utf-8?B?ZHRkeDhnSjBackorcFF3dFJ1WXMvVWZZby8vd0JkQ3JDRVN5cytSa01YaEhz?=
 =?utf-8?B?YUFJZE8yeko1cDVTNUZaSU9SUklyYkhoaUZTcHZQMC8zMHl4Rmw0dVVhVWcv?=
 =?utf-8?B?cnZ5eTY4SU9RWm50THdML3Z1V0w4RlA1Z2o0cUFxYmhRTVFHb3IyMzJUbnNZ?=
 =?utf-8?B?V2VIRC9NRWJOUy8xVjNEK25mcWowcGh6aFBDNHZiMTQ5Zkx3Nmw1N2JXV2FK?=
 =?utf-8?B?Nys3d2xJaTFETnEzN0xOa0hPUkJYbG9vZy9tRmdQcHdlc3lvbEtUSlhhamdZ?=
 =?utf-8?B?QUE2VTZYV1R6Z3JFa2JscW54dnR1WTdHWGUvdnp4MGJRWDlXVTVrMk5tMFgw?=
 =?utf-8?B?S01IRUt5cjZLUzRKTDVtWHdqdTN5M1BMMUVkbDJtQ0lSZ3pNak1iYXU1My8r?=
 =?utf-8?B?cURXS1UrbkVieS8xNW5DcEdFeXh5RUVicXFpTWNacTZwdVR5RzhuQTFWNlJ6?=
 =?utf-8?B?ems1UGV6OXpyNnlMNWs5eXNzVVJiTnZnMkFydXgvaU93Z2dEeU5jTUJYQTh0?=
 =?utf-8?B?TXZPNU9WOTBjc2p2b3VLVnB3eERFU1ZueXNxTVFTYk5NbXlTd3dVUEd0Wmh1?=
 =?utf-8?B?ZzBlY1ErK05YNy84VUJ3c3pRc0krMVBQeEJTZEVVQXIxRVNSR0tiK0FOMENT?=
 =?utf-8?B?Z3ZiZXFuZE9RZ1FHdUJhais3UjRJckJXdkJzWUlOVDZuVEhRWmVTUFFodDd6?=
 =?utf-8?B?RlhrRHFuYUZzR3gwYzZEblRtck9tNlJYckpFZmgyUDVpckJmZEFKYWU3MkN4?=
 =?utf-8?B?UFBaS3F0S3JIVXNoUDV3M1BSSS9SUmROY21Mc0wzVW9DQk1ENlpxeERBSUt2?=
 =?utf-8?B?TWpzcDBHSzQ3S3V6ckJKS2FzdGtWUlJtbCt3L2VPRUZDY25sMFZSWTUzaTI2?=
 =?utf-8?Q?q+wLfQS8xODVqnuCaBjWORF/feWFHzI+D8ur70v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03329f3-8900-494f-f9d5-08d9196ff464
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 20:11:28.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tDsHaIKXhEF5xvSag/OsBc1ck8zSOAxJrkeweckAeU8Xq9FrqvmuC58Zt9Op848PvaskwHBGDsDGzWOJ9wQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170140
X-Proofpoint-GUID: 10LmEELFqhROXDVnAuJnMgeP5wbmepBS
X-Proofpoint-ORIG-GUID: 10LmEELFqhROXDVnAuJnMgeP5wbmepBS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/21 9:54 PM, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When hugetlb page fault (under overcommitting situation) and
> memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
> 
>     CPU0:                           CPU1:
> 
>                                     gather_surplus_pages()
>                                       page = alloc_surplus_huge_page()
>     memory_failure_hugetlb()
>       get_hwpoison_page(page)
>         __get_hwpoison_page(page)
>           get_page_unless_zero(page)
>                                       zero = put_page_testzero(page)
>                                       VM_BUG_ON_PAGE(!zero, page)
>                                       enqueue_huge_page(h, page)
>       put_page(page)
> 
> __get_hwpoison_page() only checks page refcount before taking additional
> one for memory error handling, which is wrong because there's a time
> window where compound pages have non-zero refcount during initialization.
> 
> So makes __get_hwpoison_page() check page status a bit more for a few
> types of compound pages. PageSlab() check is added because otherwise
> "non anonymous thp" path is wrongly chosen.
> 
> Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Cc: stable@vger.kernel.org # 5.12+
> ---
> ChangeLog v4:
> - all hugetlb related check in hugetlb_lock,
> - fix build error with #ifdef CONFIG_HUGETLB_PAGE
> ---
>  mm/memory-failure.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
> index a3659619d293..761f982b6d7b 100644
> --- v5.12/mm/memory-failure.c
> +++ v5.12_patched/mm/memory-failure.c
> @@ -1094,6 +1094,16 @@ static int page_action(struct page_state *ps, struct page *p,
>  static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
> +	int ret = 0;
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +	spin_lock(&hugetlb_lock);
> +	if (PageHuge(head) && (HPageFreed(head) || HPageMigratable(head)))
> +		ret = get_page_unless_zero(head);
> +	spin_unlock(&hugetlb_lock);
> +	if (ret > 0)
> +		return ret;
> +#endif

I must be missing something.

The above code makes sure the page is not in one of these transitive
hugetlb states as mentioned in the commit message.  It only attempts
to take a reference on the page if it is not in one of these states.

However, if it is in such a transitive state (!HPageFreed(head) &&
!HPageMigratable(head)) we will fall through and execute the code:

	if (get_page_unless_zero(head)) {
		if (head == compound_head(page))
			return 1;

So, it seems like we will always do a get_page_unless_zero() for
PageHuge() pages?

Also, due to commit db71ef79b59b ("hugetlb: make free_huge_page irq
safe") you need to make sure interrupts are disabled when taking
hugetlb_lock.
-- 
Mike Kravetz
