Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB69367584
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbhDUXHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:07:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30324 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236626AbhDUXHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:07:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LN6koA026618;
        Wed, 21 Apr 2021 23:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ava2MEWmSsORBr+FNbhh55CW0UfxyNScH9EyWPwqPCQ=;
 b=RV+2zyi7g5a9eojPm1EP0jtsyQoruqdgtXoISDfVdiS7ou0V5iWQRIWSzE9vNrpyle9A
 U4wJ+ZGz6eo2J+NTp7hmxW+GuQFakkxJ2/qb6ECO8yKH+6YySyqLQob0pkQbNuzEfLv+
 V9NYSdfOWd5VVwqYEOtiRLVL33iVszQ33C7hsIqIV6OmRMR+OHzCSKb/NJgUGgrYjn1D
 /kMKtYbELYUu5rhnKZszN9VIqx6t3SHDdCVKT1ED0tV/bBef33zi2+dms3dBiPHrfDAE
 /wUELYZelghlt7fE/q7djiu6iMIJKhkrX9fjj6mUvLqqg8op8W2FiXoxbj7MTNxI9zOh GQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 381dum8vpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 23:06:46 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LN6i2w051595;
        Wed, 21 Apr 2021 23:06:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3809m1ac78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 23:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZx6cTIT1GAKsj4FhdbrijPW6jPtLYi2l60wKxchXBL168LC1aiM6Z+nUg72W1R+RozEaemm37Diy74NxIsZ9O2yLeVDBotHmZV5i0uev/zK2k6fGHhHfaFnhtmjjI4qDgWPQArV+2vKKSPRj0QXH9TeWKdYTfcMo4KU54MskB4v4h/g1aZLypKB5FOenal7wYDFAUJ4obcZckYcK7YD/fLtZPTBGzL09VnWNN+PetncLuChBzNbchOEKcmME1jnxGT+NhAEH87XF4ycje2/w/RJ7GehKDv30HxRRvuFl27E2drcPDEfHgRxjskcPwGqsHUzYZk0yRd6fus9V78bMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ava2MEWmSsORBr+FNbhh55CW0UfxyNScH9EyWPwqPCQ=;
 b=Psobgw0CjKMvNZhTQ3Urkz7/PBgFG33Z9Qxrl/OU5rEcy51/YuXhGndW1Wls882wWLxWLgm3c/eIroKDYFLPtm32Oc10C11QSh74/MIV6YBtPV9nZS1dF+aQjFLxoV5gPh2Vl3b2P5T9NS4oQUFUjm7jbq6SeQlj8mzsqFe5MseaVghAAzPTb1w7kwRZp5+fy3gV/IeO75XOaOhQ1CRuuzwXlQj9q0VVJF53fDk3U98e6jZmqSIRHGJRSxwDNYhx60sG0qEJ54WQ0GZjn/36jyMytFEKlJW+FiMBUeP6T0SNmSSMrX3BAbfdqwRiqF4U3h/ZcYfCT2SsII5BHEfXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ava2MEWmSsORBr+FNbhh55CW0UfxyNScH9EyWPwqPCQ=;
 b=WtTIhQbTlWhKJNai8FkftMmT6g5YhK5+/Boh/Ad4Rr3Vl9wVb0SzFXNd905usD4x+Xd/id2NsqvCoA98xfdjMBrNK8kgAFitzQ8QdT+UZjqTQw2B77PHNfJ2AEgZPLg7TcPAwC+dyGqBrIHZAZ0qx8JXlhRzYYZcXyejToEgf+0=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3969.namprd10.prod.outlook.com (2603:10b6:a03:1f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Wed, 21 Apr
 2021 23:06:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 23:06:42 +0000
Subject: Re: [PATCH 16/23] hugetlb/userfaultfd: Take care of
 UFFDIO_COPY_MODE_WP
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-17-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3cde4e9c-6887-6ded-2f34-2d031569badf@oracle.com>
Date:   Wed, 21 Apr 2021 16:06:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323004912.35132-17-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:300:ef::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0011.namprd22.prod.outlook.com (2603:10b6:300:ef::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 23:06:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a10163d-1d02-43ed-26ea-08d9051a2029
X-MS-TrafficTypeDiagnostic: BY5PR10MB3969:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3969B15C6FD43D6766D78E56E2479@BY5PR10MB3969.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYstwgSdKnOfU9NjDSitEMInhJXTnqeMYK5isJ0AAUZFhBQ6Ui5zp8DRWD2ZnmdOIg29ZCV8AY2yndYv8rqHPeyYEt8dJEIeX50IVL6mRVI/8cffS1DDMs3D/ZmIEkYaK0n5CvVUoF0gwRvO4Z06Jrz0gYpFTry6sX5dr/oFvRCZCh2wiuXgv5N0EhnDFhQS+ulJVAKlY2ssOzFzaQzpM3Zf4CYD/rkrkni71ygMvkewGNnzAzHGmHBhZUffxAjfD1d9qtMqHaumIylQSj8Z/jQlBb1js9VPbYct3EzwWTKV9CVQzFltN5xWNmfTp+KlHOmJCjib7aywva1nRyx5E9IhbwTMQkjTLdOoTPtjhYHoEBYkV2loJ5GKGXVfBLGEJVO3JfUaG9rSz5Wpun5JdBbhggRyfRy+pKpkSPykucvogQNHPPKRXxnfMyHY8xEeMzVmPlJFQZWnpWWFp63d4LJWojbhLvUirbIw8OYDEYNweAM1/KXZzGTnwT/79rWq798CcObxtkRVisFEdmDDzrbmH40OAcx2QQFCcAuizXHb+7K5jUXfeFkMn7cfIK0SDFmbFqZB/UXjFu5Ya4EgJDvhiZfQYDONB6VoE9ioCFuYS3XYstIDV3AIXWUrIGHuqvGhvd0bOCGoucBLa4BdWKj4PWDeSVt8eyirOKS6OorK2RD4VynE4xfNgxHLK5AF44fQMwAA2hlc73gCr16CNaBLiHnDBrl0K7yNXUeL0Mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(346002)(366004)(38350700002)(316002)(86362001)(16576012)(2906002)(38100700002)(26005)(83380400001)(66476007)(66946007)(7416002)(54906003)(66556008)(31696002)(2616005)(956004)(36756003)(186003)(31686004)(8676002)(52116002)(16526019)(5660300002)(8936002)(6486002)(4326008)(44832011)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDNDRFFHcDBPVUtyUXludDhvTmxyTWhNWXYzWEZBdUtGMlhUbUpVZjB6RHN1?=
 =?utf-8?B?VEdQWldjdkJnczhDK0tJUUVwREdpa255MFE2RzRaamZBSlRnTEVncUh5VWcz?=
 =?utf-8?B?LzZneERtbjc4N2dOOFFVS255c1gxYmdFb2dJRkU0eVI2ME5najN4ckE5cHNh?=
 =?utf-8?B?Z0VMYWJYd0JXTHA5OUxTb1BQZDN0SEJhSWdjNUU1eU5hM29WYTY5QmJMSVdt?=
 =?utf-8?B?Y1JJaVFzQVExZDdENkF3ZExuWTN5QW83YUg0U1VNSEREVEF6em5SSUdWbWQ2?=
 =?utf-8?B?WVBUQUpuNTE1S2NLZ3cyWVZEQ1RZckRkbDF1bElvQXc3bFRNd2lYb2plbUZU?=
 =?utf-8?B?M1diZWFYVlAxUmw3bmNsZWxVcmJaUnR4aElxUUt1RGN2TjZmWFVwczVhQXgw?=
 =?utf-8?B?ekVNSnpOVDNTbjFrNEo3NUVqVFB4N3NrMUtXajZVYThvT29PaDczVUNlM3lS?=
 =?utf-8?B?RWh5OEU2ckpHbTVpc1l3b0VPY3hqbGEyL1FNNVZOL09ydk05blE2ck9qSlNY?=
 =?utf-8?B?N1c2cWJQQ2pIMkQrcTluRUhnQ1B1QU5LdnYxV2xWdllTN2Z2eGhLaUJOS2wz?=
 =?utf-8?B?YmEvZjZwclZ2Q2s1alkxREptZVdTRGp3bjMxck5GWVpKMzh6aGVGOUE0bnE3?=
 =?utf-8?B?NHZKRjRnS1FmbVlELy9TODJnL3ZIbmlKWGtvdjRud2lmV2tSMWVNVnZDNHZH?=
 =?utf-8?B?N2FubTl1Q1B4SHNWU3RWU2NiQ2k4QUJFaFowdk96ZllaTTlaT1FnOUd4K290?=
 =?utf-8?B?bnVSVVR5RE50UzlrcUhqK3djM3hLMG9CTkVDbkNpS1RkQllmZFlaVnhEMEpK?=
 =?utf-8?B?MTJXcThORUg0Nm1FNWcySzBxeWViaGFMdEttWGdpNUUvVVhyS0Vrd0gwVEtZ?=
 =?utf-8?B?aGt1dDEvbVFBTVA4cERIU2xuYWhVeUxZaEcvR3ZXekVsQjNPek1UUzQ3NlFt?=
 =?utf-8?B?c0NpWThHbjU3UWlwQlBQc1NqbjJHYUk1QTJwN3JqRTdoMjdhSFkvSHpldUFV?=
 =?utf-8?B?QWJqKzJmL0E2eC96L09tVGdXMnREYjQrT1RDamdyTzFNQXl2U1NoQ3ovSytV?=
 =?utf-8?B?b2ttMlNIV1crTlJzT0JZSlQ1eUdpNURVQTQ4Yy9iZzByRDlPMzlwU0loNyt4?=
 =?utf-8?B?M2lreHdlYmxBODV5bWw1VGt4RGNQZTNxMzRuL0gxTU1yT0UvS244WC9HclFy?=
 =?utf-8?B?ZWVQNHhEMDlNYWpjdHBwM1ZMeThyZ1hRb1l4Mk1QaHg1QW4wb2ZXWFlhcmor?=
 =?utf-8?B?eWJBWjQ2WHdvUXU5bVJ1UlNCS1lWUmFBdnc3V0pQbUlVL2NxRGFLZWxDS0RF?=
 =?utf-8?B?UHFGaWdmaHJlcXRlbUtKS21Cb0xaemE3NEdUK2xOS2JoMkYydk12S25JVUFF?=
 =?utf-8?B?NU8zd0dGTzBSZFEyOXBFVEZRVFZUSGZSWXBBbHFlK2ZsTVRKOHpvK1R0Tjdy?=
 =?utf-8?B?SndMNU1qelhOejlBNXg1bVNZNnEzV2hPTU90VWFnYTl6bm1hdEdlRVBudnF1?=
 =?utf-8?B?TXpQTlBZM2YzMVpLTTVpTHVTZXRMWHRYUjI2Y3lZQ2NTQmRJN043eEhPYURi?=
 =?utf-8?B?OFEzWlJZWnNwOTV3WGZXem40Ty9BQWE0RFVPT1JaMFhXTmZ4VzJtWEh5Rm1p?=
 =?utf-8?B?RkxWR2tyUnUvNHkxZFV0aTFJQm13bW42azZnUWJWdEoraG5EeUNxWms5ZXEv?=
 =?utf-8?B?aFRkQUloSWswV3MvRjlvdTVnM2VrOUxCK1dtMUhCMFcwa2tVbXJhWUxmM29C?=
 =?utf-8?Q?CKpPFYZjEh4swdqpBGR1GpD5to+f9q9h/a8bUtU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a10163d-1d02-43ed-26ea-08d9051a2029
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:06:42.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxaodaGkV0mDWhY4l5clkErc3uqxaZ+inMSTEJYZ6FbOuGzGR6+Uq6mKzNV0KxbGrkxP2w+jvCeiVw7SFLK03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3969
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210152
X-Proofpoint-ORIG-GUID: AVZIGLpz7U_Hy1HA4DV1bY3JeP4FYGYd
X-Proofpoint-GUID: AVZIGLpz7U_Hy1HA4DV1bY3JeP4FYGYd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:49 PM, Peter Xu wrote:
> Firstly, pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout
> the stack.  Then, apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with
> UFFDIO_COPY.  Introduce huge_pte_mkuffd_wp() for it.
> 
> Note that similar to how we've handled shmem, we'd better keep setting the
> dirty bit even if UFFDIO_COPY_MODE_WP is provided, so that the core mm will
> know this page contains valid data and never drop it.

There is nothing wrong with setting the dirty bit in this manner to be
consistent.  But, since hugetlb pages are only managed by hugetlbfs, the
core mm will not drop them.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/asm-generic/hugetlb.h |  5 +++++
>  include/linux/hugetlb.h       |  6 ++++--
>  mm/hugetlb.c                  | 22 +++++++++++++++++-----
>  mm/userfaultfd.c              | 12 ++++++++----
>  4 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 8e1e6244a89d..548212eccbd6 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -27,6 +27,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
>  	return pte_mkdirty(pte);
>  }
>  
> +static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
> +{
> +	return pte_mkuffd_wp(pte);
> +}
> +

Just want to verify that userfaultfd wp support is only enabled for
x86_64 now?  I only ask because there are arch specific hugetlb pte
manipulation routines for some architectures. 

>  static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>  {
>  	return pte_modify(pte, newprot);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a7f7d5f328dc..ef8d2b8427b1 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -141,7 +141,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
>  				unsigned long dst_addr,
>  				unsigned long src_addr,
>  				enum mcopy_atomic_mode mode,
> -				struct page **pagep);
> +				struct page **pagep,
> +				bool wp_copy);
>  #endif /* CONFIG_USERFAULTFD */
>  bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						struct vm_area_struct *vma,
> @@ -321,7 +322,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  						unsigned long dst_addr,
>  						unsigned long src_addr,
>  						enum mcopy_atomic_mode mode,
> -						struct page **pagep)
> +						struct page **pagep,
> +						bool wp_copy)
>  {
>  	BUG();
>  	return 0;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index def2c7ddf3ae..f0e55b341ebd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4725,7 +4725,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    unsigned long dst_addr,
>  			    unsigned long src_addr,
>  			    enum mcopy_atomic_mode mode,
> -			    struct page **pagep)
> +			    struct page **pagep,
> +			    bool wp_copy)
>  {
>  	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
>  	struct address_space *mapping;
> @@ -4822,17 +4823,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
>  	}
>  
> -	/* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
> -	if (is_continue && !vm_shared)
> +	/*
> +	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
> +	 * with wp flag set, don't set pte write bit.
> +	 */
> +	if (wp_copy || (is_continue && !vm_shared))
>  		writable = 0;
>  	else
>  		writable = dst_vma->vm_flags & VM_WRITE;
>  
>  	_dst_pte = make_huge_pte(dst_vma, page, writable);
> -	if (writable)
> -		_dst_pte = huge_pte_mkdirty(_dst_pte);
> +	/*
> +	 * Always mark UFFDIO_COPY page dirty; note that this may not be
> +	 * extremely important for hugetlbfs for now since swapping is not
> +	 * supported, but we should still be clear in that this page cannot be
> +	 * thrown away at will, even if write bit not set.

As mentioned earlier there should not be any issue with hugetlb pages
being thrown away without dirty set.  Perhaps, the comment should
reflect that this is mostly for consistency.

Note to self: this may help when I get back to hugetlb soft dirty
support.

Other than that, patch looks good.
-- 
Mike Kravetz
