Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480A73D6A24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhGZWiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:38:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25468 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233380AbhGZWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:38:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QNHYQm000683;
        Mon, 26 Jul 2021 23:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=okJJbOnaIcCbRMP1/+42JpV46bqqXL8xaSoPqzGqfaw=;
 b=Ylsq09QXbCFVC91YIwHm5/ZKG8+0kIzwyDk3iAcSkc6aZXHtx6LQffB+4i+bt+osy6ag
 AhBBTtpLAHO6E/U/ujp0j9THTg1+IRIqtqfhzuY6le/uNSyxJ3ZnVoS+BCdvzZfPpL7/
 Xu88ZCAccKlZX3ceRnmCYGIB8S0XAc0n5S3ciRfwN+EgKN7nrCbRoxRLYlLJJkGsM/lD
 DKpgEUww7Mmiq5ylcp4dMGtAlZG04oSixtmVcgHfryAgs6T/Em87l2+oUaxRWeNWhlLX
 5X3McS9Onr8mQcyafI4snDZKc6hKSTDlQXO+UvLaWyCY/tY5ls8NuMQdu52Q0oSTsc+U IQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=okJJbOnaIcCbRMP1/+42JpV46bqqXL8xaSoPqzGqfaw=;
 b=gY/XWE+Z1MzTrYlYN1WHNoUs3Y/6mmOR/RZ2RAz30AuTJD8xUv8j/IkzguPCRoBXDcO/
 hOoAMyqJWNDBDDHPnL7I3jupkVkxGJBzWbMzLU23BHeehO8wAuvyBYxyxjSBpdys/CGj
 Fawl0IkNs/lkqXmE9OcVepTeUKQTnq6w6e81cs8ww+rWe/Qo67OT+0rZk5OhIns2/zfk
 VHiSqxR0uPL76i6OJJYE2d0RC34zq9JbW59Uv8Epf990tM1Ml3t7y0nL7nVzspIsonAT
 M7iBJE8cBZD0U60pjp+9aikzpqLeBBAjq8gKPtABcH1DlC9Gw5B7KM8EZqUEqV3bRxAP HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a23538d26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 23:18:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QLagXN135506;
        Mon, 26 Jul 2021 23:18:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3020.oracle.com with ESMTP id 3a234uaje8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 23:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG4bZB42LV0dMTd8kM2yxl7nif6e08NY4wz1aEM2fDEG9zSWVwNFUn2ZWg3gOKBzz5/+sAhVwWQ16yz7TFBESpRwTladmJWVxpjdc7KPmeqp6kPxwHrUPB6mXRTZ+l6M6vPB3weGbQSJj7Er74UNYwl472GRSI6Pd/uK0w3+3C17h40gTQpOUCJVcRgKCcTcO5BsDR4aIeAIy7lcXFw3ZW6eIHIxThnhhlSIuXoFphr1mZJrudLNr+2JihS5RAVPOkcEBahbLWJyAxDAedosSZOnYjB0RxjI4VtoQZYeWtaXMQHdbw/nkRyAafbS6OYbc1BbZrwMdNmnrjb3yA8jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okJJbOnaIcCbRMP1/+42JpV46bqqXL8xaSoPqzGqfaw=;
 b=POyr7QNXBFs6uGveE50iENEEGluSAwqQRipAIXIDDX9D//yEp8085WC+nP9R/YoGAKBkoN/DciDGbvdHTLEqlkEfFP1GZn8ojlkJW46EVw7OvvXS7MPs4EkWInt3GcbvWgkzaN3j+BJEAp/nhGVTV3Lf9BtxPzPzBmW7iFyxyXro/q5p1xrFsmFHUJwjHIqF7FVgU1Co59jniXGCYcbnPyAvVBVmwcB9LpzKGPxlSvavShSGGBUF7ztQfV8rl+hRj7pt0mFXGI9D/O4xrig4qy2Zs7OL+ouHCjRbx0/o+Ny+lxF7tJuYWkDcvygEEWw8MIj694XPuk72SI4/7UtBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okJJbOnaIcCbRMP1/+42JpV46bqqXL8xaSoPqzGqfaw=;
 b=KEJO+PcBrlpyUG54190DA9IDITQggKfWDCrJpKVDYtrZIDGKdr9WcyThFAcM5et4E9QjGVtZtDD9eGzhUy95PQ6WGxQ9L62mYCSUbSyOPhdA0e3Doeuo4LCfGT1hLbJU96b0w0P3hIJsutuhoppBfCBSZ5yJdU7FA02nKeRiBL8=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2853.namprd10.prod.outlook.com (2603:10b6:a03:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 23:18:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 23:18:05 +0000
Subject: Re: [PATCH 2/5] mm: introduce save_page_flags to cooperate with
 show_page_flags
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com
References: <20210714091800.42645-1-songmuchun@bytedance.com>
 <20210714091800.42645-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fea1d845-209a-e2d5-6fcc-dbf17c949861@oracle.com>
Date:   Mon, 26 Jul 2021 16:18:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210714091800.42645-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0045.namprd22.prod.outlook.com
 (2603:10b6:300:69::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 23:18:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdef8e00-ee26-4ba0-6017-08d9508b9efb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2853:
X-Microsoft-Antispam-PRVS: <BYAPR10MB285319846D319FF7EBC545A7E2E89@BYAPR10MB2853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fv8/68SBvdH6nJeJz/T8fQNxBCfWhTVCBrCaKHmbTYYJPJOl+fP3fD3MuMoXf31/oPFb9vcFeABxccxXPfdVPlC01KHkHfAxAp/g+DxIQV8mx3WNQ2Z6b6jzGJNoVwjt+GMBYZPAnf+yfQAGuYzaZjH26xdp+dVPJwYX5Rn6KkwAaoanx6ub+YtzVApAM6QpKyploGNkUWuBpLd8o8D+/06uRKY1DI32wAT03jj59N8pZy9w48ScMkQSZ1P6GGr+ErvQQkXCqN2elqe8vYR14mvrzOiupHm8IsjOjOiaQPYvgszfLlbABuHViW5n2PYV9fpbxKRB6gWvRy0VyqJUYEaOGp6pu52atak9CrTmPaVm0KajgUODhlLstsqecIwm+H30ZVXeWq5qV2bydSOCdIgmtXacD5q0kMrFpEka8aKP59hjGRx/Pe18Qg4ztV8rUC/EHPZnOE1UDpA6GxM0OPlBSZyW7l3SHwGm/IzVcP7QBiztURRo5qprR5qcQj2L4Err6EnwpH7rDDCIMy4cCxVV5gLopQEGlHEvNf4oQBVuPMgjGWLACWDa2n4ifS7lNRlPhPyVFrW0sjJlfP/BagCflF2sBbkgys0w9jVeuQW9WlpPMOAYvhP4Y6zqgZpNhVLgmV9/ZrmRBKeAjwju58l0RJs7zYjbVrpeuRiaUvgaK4Elyshjb/yMubqLVTViIabLkTeTmX2yy7Hcm+QxP3/kFG9WNg9D+kZOUEy/daEzaj3RUMv0CWVI/LmC+bdr6p+KRuKCtFlO0TLYoaAbyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(4326008)(2906002)(186003)(36756003)(6486002)(66556008)(38100700002)(7416002)(31696002)(86362001)(956004)(478600001)(31686004)(16576012)(52116002)(66476007)(66946007)(53546011)(5660300002)(8676002)(26005)(44832011)(38350700002)(8936002)(83380400001)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGZLWE5iS0JZZmNNbjRVUnhjMTNEMzk0UVk5NjJnNEZuVFhkQXd2aFdxdXo2?=
 =?utf-8?B?bDdaZGhHRXZWMHpzZlEvTG13M0hGYVZSRzIxMkdNY2Z6aDdJSHVWL0QwUFlT?=
 =?utf-8?B?M2FYcGJMMys3eEswcXdFa1BSRU1MSlNWNUE3V1U3UnREVngyM3BQQVpxcWd0?=
 =?utf-8?B?RExTUzhZUnliWFdsaDIwMmVCTlBKbmcwMFZ3b1lrTlp6RmpUNnNBZ0lHckox?=
 =?utf-8?B?RDFnTTdHOElwWG9hRUNXQnZvZ3FSRHQzRGFSSXRUZXhTdEljQXVsTnJhUnI3?=
 =?utf-8?B?dDB4VFNBYnhLSENNeVU2VmFMR3cxa0c0SUNzUFZRTzN4dGlMQkt0bXNxT0pP?=
 =?utf-8?B?MURYZ1p5Rzd0dVBKWHc3RE1ya20vbWpaY2EvMS9qZTlxMVRYU2dTMEVPUzBI?=
 =?utf-8?B?L0JiTGVFRDlLenNmektaN2FiTUdMeEZ2akNDRHFPcjhTNC9SVU5QWmdHSlZJ?=
 =?utf-8?B?TFlMdE5iR3R6MHlTdTFGQ2xEdHpKVXV4Sjl1Z0duR1VQYTNXMm40Z0NSMFYx?=
 =?utf-8?B?RmNUYnFDRm43ZUhSRnF4Z1lHTzl2QSt0emczejQzanQ5VUFQZEJkNk9tcllB?=
 =?utf-8?B?bmx3c3pBenk0Tno2ZzVvUENBcHY4c29pbG1lYmM5dnhBOFdwOXpjeDFLTGp6?=
 =?utf-8?B?WTE3b2lxTU9QZlA5VmFpSzBlQ0c2RWFaV0liOHZtT0JHTWNsWCtCTmxuMkRy?=
 =?utf-8?B?R1pRb1RSVXd4di9tU2RNaDVMTWJlQ0JHcnFEWFpXUTk1RW9VYnBGMHFTQkdl?=
 =?utf-8?B?TnNPTG5RaXpmZmxuWFl6VytWWG11VXFiQ2F1bGFRTW1jMi9wMkcxS3F2Y3hr?=
 =?utf-8?B?VHplVTZ4Wm45emtXcmM2MklSRzQwNDN6V09kZTE4OVRJbm1WQWdielFaZ1FG?=
 =?utf-8?B?TmtncXVoZHYxVWYxYXlVWUdKb3krNGxNQytzRDV1NVZnZzhIeUF3Qnp6Rjc1?=
 =?utf-8?B?YlluZUpFOXNyYzNFWDRUeWYwR0J4eW1HWEErOXVaRnZWRGZKbWRlbXFxVHRj?=
 =?utf-8?B?RE5JMXBmREF4MXBLUFFRa29qNms3bXVFM2tYb1YwRnFNWGJJUVdFbkh2bWZu?=
 =?utf-8?B?cnpUbG13enNYTVJvMzdqdGZyMFV6MExqdEVrWDJ5ci9rY2RGK2JJdjFqK2Rp?=
 =?utf-8?B?R3R4NGJ1Q2tvMmhqSjJMUHFqYUFNVFNqWDNzZnU3SEpOY0pxSlhDUkI1b0xE?=
 =?utf-8?B?V0dDcXBuTlBzMlcyMnRPeTBKMWsvS0xDUXM5NjNvMytxRkl6S0ZLdWNNTE5k?=
 =?utf-8?B?dDIwa2UxNzh0Zkhtd3lMQXVhb0E4T3dMUUc4RHRKa2ZpaTBhb0VsYTRvOFBT?=
 =?utf-8?B?RWF5U09yTTZ0c3o3RUZDRi9oSXh0aFRieDc1c3VXWno1ZGxvSDNCVWtiVlVj?=
 =?utf-8?B?THExWHdubkIzVVlYdk5DdHFzbytVTTY3OEdqWTJMOHJjdG1DTk9PcW53Smlk?=
 =?utf-8?B?ZXVBR3lEeUlITFdNN2d1TmtLY0RpVitZc2VISzJCMmhndm85YUlrWklhekRD?=
 =?utf-8?B?SzV6R1JJTHh1QnptKyt4cUJSUjl5S0NXOHBxcGQwbUFJMXRSSkFubVZCRGlX?=
 =?utf-8?B?ZXRsWDY4cVVka3dOOHdMVTBIbUVEKzBKZTJXYlFBMkRlSm83cVV4dFh1NEd2?=
 =?utf-8?B?L3QvcDRab1hlQkZ4dFRHOVM4c1JqWUNVSUloMzZqZmdwS2dLV0VMcmFabWVS?=
 =?utf-8?B?aGtXMm9xYjdJM3M1L1BpSnFBeHF5TVNqMFNBSncyYjBsbThSVE1zYmdrbnIv?=
 =?utf-8?Q?aoH2RDGXJoOMAlyWT2G0BD5UJJTLLM2YzRDP1FU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdef8e00-ee26-4ba0-6017-08d9508b9efb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 23:18:04.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTzvVjOBTA7DGWBby4y6eYorK1A8L1o12bWEQxQZMHr5gD5NHapClMso60SC0HdwBoaykbFjOMqljaljl1JiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107260127
X-Proofpoint-GUID: 2UoKD74EgkvRxFUksg9d6553a5Ra4Fix
X-Proofpoint-ORIG-GUID: 2UoKD74EgkvRxFUksg9d6553a5Ra4Fix
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/21 2:17 AM, Muchun Song wrote:
> Introduce save_page_flags to return the page flags which can cooperate
> with show_page_flags. If we want to hihe some page flags from users, it
> will be useful to alter save_page_flags directly. This is a preparation
> for the next patch to hide some page flags from users.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/trace/events/mmflags.h  | 3 +++
>  include/trace/events/page_ref.h | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 390270e00a1d..69cb84b1257e 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -121,6 +121,9 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
>  IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)		\
>  IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
>  
> +#define save_page_flags(page)						\
> +	(((page)->flags & ~PAGEFLAGS_MASK))
> +

Looking ahead to the next patch, this is changed to hide the PG_head
flag for 'fake' head pages.

IIRC, all vmemmap pages except the first will be mapped read only.  So,
all vmemmap pages with 'fake' head pages will be read only.

It seems that all the modified trace events below are associated with
updates to page structs.  Therefore, it seems these events will never
experience a 'fake' head page.  Am I missing something?

-- 
Mike Kravetz


>  #define show_page_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",				\
>  	__def_pageflag_names						\
> diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
> index 643b1b4e9f27..53d303048d27 100644
> --- a/include/trace/events/page_ref.h
> +++ b/include/trace/events/page_ref.h
> @@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  
>  	TP_fast_assign(
>  		__entry->pfn = page_to_pfn(page);
> -		__entry->flags = page->flags;
> +		__entry->flags = save_page_flags(page);
>  		__entry->count = page_ref_count(page);
>  		__entry->mapcount = page_mapcount(page);
>  		__entry->mapping = page->mapping;
> @@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  
>  	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
>  		__entry->pfn,
> -		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
> +		show_page_flags(__entry->flags),
>  		__entry->count,
>  		__entry->mapcount, __entry->mapping, __entry->mt,
>  		__entry->val)
> @@ -77,7 +77,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  
>  	TP_fast_assign(
>  		__entry->pfn = page_to_pfn(page);
> -		__entry->flags = page->flags;
> +		__entry->flags = save_page_flags(page);
>  		__entry->count = page_ref_count(page);
>  		__entry->mapcount = page_mapcount(page);
>  		__entry->mapping = page->mapping;
> @@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  
>  	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
>  		__entry->pfn,
> -		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
> +		show_page_flags(__entry->flags),
>  		__entry->count,
>  		__entry->mapcount, __entry->mapping, __entry->mt,
>  		__entry->val, __entry->ret)
> 
