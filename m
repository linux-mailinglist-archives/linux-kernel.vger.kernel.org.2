Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B971832303E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhBWSHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:07:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:07:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NI3wx3091160;
        Tue, 23 Feb 2021 18:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WV/qko2l8qmGiMPCR7Npul++fKeEPLwtmFZrb32YiKw=;
 b=BNUwdt+fxoGoU/CvLiEN4KXa/wvI479G8HiBA/AKGoPfrknFP82qAFzMZn4ym5U9PwBL
 21liNC1EDRTDC/YIfi7BEqThpRYUIqtlF3HYQG1jJyacXHYGUAIj23a41yfwHO+9uwOP
 8ucYv2T0S+O6Y6ap8l9RFsvZea8aLb3H4yJDPbTgaUsvsiauk/fO4yeTIC9Xarhtw0v8
 5JTAviGQEP/NQ3v+fhqx/lEq6rKdsAy6b4xtBQetavjWXlTJok19KCJ73nA3yOfR0lTR
 6v06GP0CntJBS+RUeYKKGG1nDk/Jb26zbMPuOskqSCy1AZSg/kZICpgOwHw9eWG7j7Zf EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm8asn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 18:06:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NI6QhH029534;
        Tue, 23 Feb 2021 18:06:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by aserp3030.oracle.com with ESMTP id 36v9m4x8r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 18:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eznWlO2WV482effnZR6SWvYyV++sCcpngfCSRWTjy/TKUOLd5QTcm2lKX0HdHHtRKkuxxwNKFQrD4xs/JYAXR0TK7CDj24Mt1pa6v+Wi4ut/0wuWR4xhL6AYMQnZTVqyuw6yfBnceEsS0Jj0GqobPgkhik7NrGM6s5kEveLgeTpq36UBSU4XIvm9dYqaYkFhCJLYxvcTKzyxPY/orO5knDaNRxokDHuJrfZu0sSYEH3uuFVFIdi7esJz/u2V4ns9Uee4HNCPhe3mlAT87ka6B+rM4B6Uc501OZqF3NbFLOEZ7GY+5STvJCl3O3Kga1DqXY+HZk/zFtLFKDgUzyTmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV/qko2l8qmGiMPCR7Npul++fKeEPLwtmFZrb32YiKw=;
 b=LVeGTboQ/gKj7woUDkd6bo+fT5Cd1ccCcBU8GruDim+9uRpirdMUUO1dOR6HjXOZZxc0gyLZqNJmt9S2nuz8r9MWQNTRA588HnvpgvZ5/TrIvaLYuQSNMfJP/ipV1L81Ph7n//ihnVvv4FK7CvrE80fRCTIEubhzwVl10CyrHeKeabt0wVzmkWAGA086Zlpuhp21bj0oNP+R8epKvSmppWW/hjizRaSYWgfQEUEOiMMP+9Z/Zuv+18hgGfX/HMMfoVXVf+w0SdHApa88cGE3PSIrcAQ8ptHwGrp8j+qqQcnN9Ej3KwGDaRT9HPIAq5ee5pD3nUFQJBlRdyjFYIlFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV/qko2l8qmGiMPCR7Npul++fKeEPLwtmFZrb32YiKw=;
 b=Y5w6ht+YhN6SU95laZt+6WnmyUXsWre11B3dNQyEOaR9bz3j393gh/GAYP7naqIpOzf9+pY4GEBdjEb5rjo6Akwtbq6gnnGO8HlEN0RLKlCfpvuqMyHeaSB5jOD6E7JbYQhLenZ/L8iYa10dwCPx8yHavTfvn2UXQanQGGBQAi4=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3874.namprd10.prod.outlook.com (2603:10b6:a03:1fc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 18:06:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 18:06:14 +0000
Subject: Re: [RFC] linux-next panic in hugepage_subpool_put_pages()
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20210223155740.553df3ee@thinkpad>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3c536d3c-a180-301b-5cb7-c737a178a9d7@oracle.com>
Date:   Tue, 23 Feb 2021 10:06:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210223155740.553df3ee@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:320:31::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0040.namprd18.prod.outlook.com (2603:10b6:320:31::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 18:06:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0537bd6a-d8a5-4bd2-0751-08d8d825b545
X-MS-TrafficTypeDiagnostic: BY5PR10MB3874:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3874D4696DAC1175FA9DBACDE2809@BY5PR10MB3874.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dy0QaSFREW5SjQLnnnghWvMxhtqQfnnt3jeC2mZVLAaQRFA8BWaqEXK9qTIV4wTfhKS5RyCNJIshsGe9txFXlhXoXxgCO77Evi07nNoZHxRzElYBdWvov/sy/mWolGNpF0EvFrLr5E4CuNUUtbvysnX+hACLhyeu0n5Hn8NMhwTPLODJIN4GuFoVT7f6a92513SE43DMQcp8TnVVbAM5XVUUSWXo6tWNWOIu/5ya0oGoC7CpD4I6qUGTAtepMlXwWaPb1h/bpf72G3WYXMrOg4rz6LEDEX2qzaOika0iHkHjyU59X2rDSQNBaV5Jk9c2cAaQfzUeUfnd9sRlx3ZrBjPQTcQOl4IQoShSwATQ+fkme9WUQsaWQSMSVLN4qHBAdn6ZwPwBXrMmQ6z2CuBJYLnlYbysJnnghH8hFUMSfZliHct6UCBbSgNcTZEELQHf97WQ5+9SCNZr8SjpITu0YuoSC5VCJ/3fDfmX8DM929feFSApEDUM1wZRxgxH01mC+KUtTzCOpX/bEtlH5kc+u23s3yn6uWaPHM6uMyEIC8lhPiIDd4wB8Z2RJQ6GI2dArhiKyNtcF/pArB9zUbnzMHWd036NFGO9yLb8wxXbyVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(376002)(346002)(8936002)(83380400001)(6486002)(26005)(2906002)(53546011)(8676002)(478600001)(54906003)(52116002)(4326008)(186003)(66946007)(31686004)(16526019)(36756003)(31696002)(2616005)(66476007)(956004)(44832011)(66556008)(16576012)(316002)(86362001)(6916009)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZzBXeVp1clZyVWw4YzRweWk3MlBKTEZza2FYU1Q0anVDV3hMSWtXVExXdW05?=
 =?utf-8?B?QXU3dnZLYVFlZWhPejcwdlRhS1ROQ3NockhCSGVmL09DeVlRaXpQblQ1dyt2?=
 =?utf-8?B?RGhKOHI1aml0SStxaGhvWDk1ZEVUanRjZGtOTEdrRmFoQm1Eek5uTVEyOEt6?=
 =?utf-8?B?MXhtYU01RFByczU5RjAxWWxEY0JQMmJ2eGZwUndmb0E0WDVCcjZJS1M4Y1lr?=
 =?utf-8?B?N3hQKzdVQmwwYWxQekFaNzFYUnk5VFhrOU1YTmdqT2hsSkd5bmIwZFMzSzVn?=
 =?utf-8?B?bFN2TjJWZlRIWkdsVkE5VmtoODNqeVVURVJicVE2WllTZ25MNGdxWDMwaGFH?=
 =?utf-8?B?aHRwUG9EbTQ5MEh0bG01NW5WMExoOXpJeERJa2cvTUVCT2Zlcm1rYm9ud0F4?=
 =?utf-8?B?a2VERTdVOTJGQVRjYnFPZWZTRUFNMUI4d3pZa1BUNHdqZENDUkptN3ByUjRM?=
 =?utf-8?B?Q0RpMWUwTEtickQwZDNmeVZoeXZpWHNHYWhiR1VOMXNnVmlFYlNlNUR5UUQz?=
 =?utf-8?B?UmNYbUttWTlTa2lRc0tGSjl2SVExZ3FUWlNEcFNmSXNZU0NMeEwzT1VQM0dV?=
 =?utf-8?B?R3pjVG15WkRjN2pFSXNIdkdVTi81OG0xc2NiV1FqNVo0L3djVlJaYkE2U3hY?=
 =?utf-8?B?NUR4K3BFOHdMaG1EK2lLc3Z6QURPYkxYTjlGN1Y0Y2lwaWdmQlBtQW1UeDRi?=
 =?utf-8?B?UXRnVU5ubm5LQjA0Q2FDbk5OQ1V6Vlp4Rk9WM1dYVWcxNmpzQUZKYmJUb24y?=
 =?utf-8?B?VitiQVZMbWNDYlJtK1hSZW1WUU9zb3JGWXNNMEEzcHZYdjAyTkI4UlJQcitU?=
 =?utf-8?B?ZEVIR3dXbU1QTUt1NDBrS3RqUDJ0VFBIYWRnS0tmUlAwSG15TFR5Z3I5MFJH?=
 =?utf-8?B?VFVEYm9pdHVkOUFMa1cvUUM1ajBqZUlhczJEbXpRdWd6WEJyaURwNUFTVEor?=
 =?utf-8?B?WVQvd3QwbkdtSnRZbm91cWRtTTMxM0JPcXZBc09YZ3hHaVF1SDJDbzlTc3dD?=
 =?utf-8?B?YUhvdGhGTm40M3RMZFZiSUducm9USi9WZTRneDBCRGNFUEJVbmNxMWd4YXBF?=
 =?utf-8?B?UlZROS9DWnJoYXcyNnYyMUNnNG9ZanpDQXpObFAzZ3MzdllUZmduVXRHdkh2?=
 =?utf-8?B?eG96engzTUJIV3RtYXZ6UnI2WkxFUlJTV1o4VThZT0tMRnhIMEFVUG1JdUE5?=
 =?utf-8?B?dlZWODdCVFpXYjc0NEtYZ2d2TWxvK0lqUUdteG1JTjNrS2JrSVFDUXhkcG9m?=
 =?utf-8?B?SlZrU1ZvT0xTNUpMVHQxdFFvRHp5bmFackZ2VWtybVBsY0JibjFaN0VYdlFa?=
 =?utf-8?B?djlWMGJIRDByODE0T1BBZENqYzk4MGpsZlFhZHJidEh1T3lPRFhVVU04U0ZP?=
 =?utf-8?B?dy8vUkR1THRvdmg5TkFscStwcnVScHFCMEhwMzN4a2cyK003R0hBcWNvSEtS?=
 =?utf-8?B?ME91elBFMTh2bDhNZTkvWGN6VE91RzRzS1ljYVdzTHZEMDlpVGo2dTFuSCt2?=
 =?utf-8?B?VXo4N0dBRTdjNHNJR1psMUsyUTBUUkg0eEFjcWVUbSt6Yk45dXVsbVU1dklB?=
 =?utf-8?B?dTczaHJacWZ2cm5KeHFGME8rZTI4NnptOTREYmV1VHJ2L1FQMldqT1J5eFFU?=
 =?utf-8?B?eVdxWnJ4RjRBQ20zSDJ0WEFSbi91YXJNZ1JoaU9KMjFNQ2laOHdZT0xiM3ZJ?=
 =?utf-8?B?cWZNWTMybTVPWUErM3VMYnI5dDRQdXNiSTIvd080b0xmb1ZDMXZiMFVUamhi?=
 =?utf-8?Q?RX3MNFyh+4XR/PjjzXebk7dDSYk/ruVMPIIGvk/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0537bd6a-d8a5-4bd2-0751-08d8d825b545
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 18:06:14.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3GAnR431SDCWu+Z3LA2Qku84zVXBIPyJmHy+9yFqC+TfHy5bM7NJ3OeWnjVJGjyqGUEVetAhuFRL9GaX8epqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3874
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230152
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 6:57 AM, Gerald Schaefer wrote:
> Hi,
> 
> LTP triggered a panic on s390 in hugepage_subpool_put_pages() with
> linux-next 5.12.0-20210222, see below.
> 
> It crashes on the spin_lock(&spool->lock) at the beginning, because the
> passed-in *spool points to 0000004e00000000, which is not addressable
> memory. It rather looks like some flags and not a proper address. I suspect
> some relation to the recent rework in that area, e.g. commit f1280272ae4d
> ("hugetlb: use page.private for hugetlb specific page flags").
> 
> __free_huge_page() calls hugepage_subpool_put_pages() and takes *spool from
> hugetlb_page_subpool(page), which was changed by that commit to use
> page[1]->private now.
> 

Thanks Gerald,

Yes, I believe f1280272ae4d is the root cause of this issue.  In that
commit, the subpool pointer was moved from page->private of the head
page to page->private of the first subpage.  The page allocator will
initialize (zero) the private field of the head page, but not that of
subpages.  So, that bad subpool pointer is likely an old page->private
value for the page.

That strange call path from set_max_huge_pages to __free_huge_page is
actually how the code puts newly allocated pages on it's interfal free
list.  

I will do a bit more verification and put together a patch (it should
be simple).
-- 
Mike Kravetz
