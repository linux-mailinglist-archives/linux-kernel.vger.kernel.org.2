Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63599347DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhCXQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:39:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36668 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbhCXQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:39:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OGYclj010328;
        Wed, 24 Mar 2021 16:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OFbZxBpwaC83M0KAWlD8Am8tBLv0dCPGbVJ4bgIiZqg=;
 b=VkIYIBx4OxaBKZ5wOcGe2Xxyz+shAnxqhHHkx/FMSFPKjGuXYb2eeHxcht/Jts9QBoMj
 1awkSqR7AQwri05k/0sOBmd/hI2baJKPe9R6Wk63x5kUzNJfYJLqtU6GgSs8m/YPBN7K
 Sm55Fu0YxF8CT3aRMPLiLGBAPUHaIns9GMUhpojHU29xYZBAE+KJ6xRUnzihkGg4Bs0H
 xrxjJv8TsV/8xSyzbsOnVEHqF2y4MVwYKz1RTvX+McoilbRHgNuhgQd/KJ1jJswthCvO
 HS5k0efF8neWr4WEqrjEhnDuwy1ey1Rwj6XepdPk14GUbNf2e9F65sKxNQqJm00ePEBY Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pn3ckh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:38:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OGZDAx021228;
        Wed, 24 Mar 2021 16:38:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 37dtmr1ytr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJlEnVjHqQHT3soUh5mQEyZGJxxO/X6nQ/LIp/EMnSUkWSkjE0D6h5n9WmhvARLF007aP4uNbPrQL8YtdBAD3GetEB+IL2jtDpcqWbP3RJvdPOTAdIGBmrY5skpn/DPXAuDiIlQCjGHYz6cGGntRAmB5f9boRQUV+a3zL3k3Vpif2q3Zc0bjXTJoLCVBnkaQj+Oiz9rbpeV4THRVXf7z0AF8t+cEusfV4P0yoIDp2UCb8z18SFxPeibhmXLGBQ8A/dEUUQRvA7KDKKufrD0k3E06vLvu0ccri17tp4u9k96CmDSjZ+dZJJwMe8BOxu2Hz8L2KG2ekbffIRH89WwBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFbZxBpwaC83M0KAWlD8Am8tBLv0dCPGbVJ4bgIiZqg=;
 b=ekRKuCL09QYESvEYZa04WgyPzrXz8y8Lg+vB2O8NpsYUMDRnbdOVL65l7+JjS4rEMP6qpE8A0gxaiLe8h8cHc3MXTzb/9tZYHlbqJ6pV5lEtPfJMNnj5gI5HChhJllRBuzXTxGX9Uv+j69/7ree5K593vPEoRdLrUYXP1Gn0CvDz0q0mj1qh7lfuwUu06Z6XO1lxPJBgLlepFRFfCzAqgiaSsdPylr4uCZcRmetuA2Qe3+scn/aFYA83HSGFgozy/0P+wYNyRsLr1cbBA9tpuqQGTM9Ma3IyjZHitnNurdcQCTuL+86Ab3kLft3RyLTmPl57qHSWFhqHt8vm6SXAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFbZxBpwaC83M0KAWlD8Am8tBLv0dCPGbVJ4bgIiZqg=;
 b=sTbJlnGQCp/ylAOJZIQ+5Nnek0uqUA+63Kr0D9FTeXJ/zxwR52inf8WLx6Ouk0rM4s5MaJYz4AXakb4IxMI1cdexClsY2Ky/bFdHeB0svZdHS9pPUABd4yzCNF/xkoEUlOp60twKhcSLoepQZjwChWfRQZryzMFnG4TpV0pLtyk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 16:38:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:38:20 +0000
Subject: Re: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-6-mike.kravetz@oracle.com>
 <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
 <fd723ea8-da7c-bd59-8d8a-e506be1b3af5@oracle.com>
 <YFmfegQjCKuY05jy@dhcp22.suse.cz>
 <d1fb9303-0053-947d-e714-c9414c456a08@oracle.com>
 <YFr7EbGx25KsYfVg@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <43595c4b-7f3f-f812-b4fe-66c900718e85@oracle.com>
Date:   Wed, 24 Mar 2021 09:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFr7EbGx25KsYfVg@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:300:ee::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR04CA0047.namprd04.prod.outlook.com (2603:10b6:300:ee::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 16:38:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1149037c-4adc-47c4-a0d8-08d8eee33b9b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR10MB266450251E001D128DD83BA6E2639@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sedux9RbfOXIivNKLuLxOuFxZqvYQNZW6fqXtt/NsjinVj9qmkI9zbHGoWAq6w2+XYbseQzUUyN5X6gDgsP8Et/V8L3Y5Hj+e9da1Vz0mLF30dSMAYSfWTr9qq1llUM4jin6xc0634WvEuHiYsGrVjJ2U1n4+sQfGYhxvKd7MBDknqc8WyFWebWV1RjOnNlqzyhEC0q5FQZTrJPOm/OPeLMfnz6YAvRJ3S0HgRoo63/O0hlEuGk/lywyqglj+6cZmKZTHS7c2u6VGHdkKSQ+IL0mtNCEDYP0DT9HIn8eB57i8fmFTyERqhn1lSa6SXVjqXNJiQe+RFhvXPmFZIVV/ubzTv51bF2Llbg7pE28aG4iT5xemrs6n0lmin8d+OBWW0Y6/cNmY9EaxQVK/Ww6yTbKtHwkwTSTxl+qk063VOUR6gzLtGsyaYn5ejTblJ0p77bCSYOOoCUxQ3ean/HNjiu1T2qNG6a9iuS2i+sWlj5PXQ3DVAMH51qdqWLvoNkV/wfun4s0ntcdyOd9uF1R6gU16oA1wXLaSIsTX0LWRziYybyfYCBmis8XNGkun2ZAXgzWKZVpIy1XaGYO3yoR/uF5HB8ycGStPHOhQ3FI8ZT7s2Wf6YPWYd++QOpKrr/8+QoBpvM+RoPrD0Jj+vQv76Rhg/VsXAFz6rnxTSBe4Y/scLLe/EIfda/YZT9PgvBTZsKiNY5xRqGm/4w3g7/R7IeCBl++T9kMMq3D+1m9z/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39860400002)(66476007)(16576012)(316002)(83380400001)(53546011)(956004)(2616005)(2906002)(6486002)(36756003)(8936002)(66556008)(6916009)(86362001)(478600001)(5660300002)(8676002)(54906003)(31696002)(26005)(66946007)(7416002)(31686004)(52116002)(16526019)(4326008)(186003)(38100700001)(44832011)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bjNqS1ZDWXFFbVhrd3pQWmZSSGZNWmwzN2RBMmxIaFlSczBtRzlrQ1J3Rnpl?=
 =?utf-8?B?eXBORFQzNTBBcy80ejhDTjNzakVheENGcVJrbVgxNmJaYU9xamNhMXlyeUVs?=
 =?utf-8?B?SVpFMVk0T0FQTFlvNkpLdlhWRnA5dnN3UUMrZ0NyMlNTeldMYUhxZnFIcnI4?=
 =?utf-8?B?bVBXdDgyYnFyaE40cVB0cG83MWQzZ1p5aHFhNDkvSkE2YUF3OHM4OCs1V0Q3?=
 =?utf-8?B?Y2IwMUxDV2xBRmkvemhZNnhjbnkyWUYrNUtmRnM4ZjlpNVNMcmhSQXpuT0RW?=
 =?utf-8?B?YjJjVHFEenA1SXUrc1dYaEZBYnEvZzNOQ3M5Yi9yL3djaWhNUnd6S1p1RjQr?=
 =?utf-8?B?N2l4cnh5eVJST3NoNDFLUUo0MFNtbXhrME13WGQyR2NBTnNaU2NhZnlqTTBp?=
 =?utf-8?B?Y05paTNJSGRtZUNDZkM0K2xEWUVqcjlEbjRGazVoZEg4Q0ViTkxGNG1mc2pn?=
 =?utf-8?B?TTNqSnMzKzJWYitpYlU1VGdiMjlZY1NiWGpRbXhTakhKZUt1a0tOUzlNNjRi?=
 =?utf-8?B?a2h1RTRiYkNrM1dadmdSNGpKTWU2ZDNxanRMME84MkwyVkw0WU5jNTI2NmxU?=
 =?utf-8?B?dlVENTE5cUE0Mm1oU2dDS3VZeDYzUGJSWU54ZThmcEMxZmNBZTFpSVFWOEpD?=
 =?utf-8?B?NVFqZkpPMTA5eTdWSjN6Ri9zRkliZ21ZNHNNKzNuNG9nd3k3a2JGV0pta2ti?=
 =?utf-8?B?Q25oRmxEeXJRNldwYjlPV21xNDJzczJrRmF2MHA1WkpqNVRqRldGdC9lbDEv?=
 =?utf-8?B?WHg1RS82WVRUUWtKZEphYVBjTnYyVjhxbVZwM3hlcHVMbVgxZG5KaXNsNHBr?=
 =?utf-8?B?aW9tblBFdDZITGNmVitDMXQwQ0pOYmhTZTAySnFFd1lDNW5FWS9zUXo4SHlZ?=
 =?utf-8?B?dldaZXI2dnQ3VS9rRzdOVXl4OU13UWsyRHB4UmIvVEMrWUdUREJVRHZrTEVi?=
 =?utf-8?B?QVJnVVgyOFNOZjVPa0ttblF4YnpoclR5T1ZSMUJwbDI0VDcxcG52QU9MbGVQ?=
 =?utf-8?B?S253eXhobnZvWFZGRG1MdWdpTGcrM1BEWUFQYWtpdkNlN2hIanY4SDFaVHZM?=
 =?utf-8?B?OFpiUE1NRlQ5cDhZRy9PcFdCZ2NCd0pFM2l4VlQwRlBENk9ZWGZQZXpSMTR4?=
 =?utf-8?B?Z05BR0trakRaYzh5WGxUTVFTdU11UUp2ZDUwSkpwZGVBM3NPM2QxSTRqVHVu?=
 =?utf-8?B?WC95dHZJZCtxOEVGRGRCNlB0UGZCWDI1WTZ1VXNNYzNvd2tLWGZDQmp3QUVt?=
 =?utf-8?B?TWJnU1R3azVpeXJoWUh4dFdSVTZaeVYyS2JEamlUWnBFWUhwMll1NDFNMzJK?=
 =?utf-8?B?RnJsSHNFZC9QKzFqQmo1bENsVDhEc1ZyTmE3WEllQnVDMG85SXY0K2hFTndu?=
 =?utf-8?B?RlZPbkNyTlpQSWJPVHNVaXJxNnVtNmFmSDdiMTZnVVIyeTJDdmY5VUZjd3c4?=
 =?utf-8?B?elQyV0ZCOWVicXNvS1ZBakVhVGlha3ZhSXB2NndMQWg5ZDNCVW1XcEREZGE5?=
 =?utf-8?B?WmdHZlp5YWsvQUtnMk1DMkN6Mk80a2NyY3VMY3ZjNkdRZkZyYzhkYTlDb0s0?=
 =?utf-8?B?V3ZiTC8wWWYyVW5UbThsTFpuOVBCVDdrQm1TMVRnK01yN0RmVTlRckhieGc5?=
 =?utf-8?B?cHJDNGY5MEFSWHM1L3ZjM3lPZ2xoVERwa2ZYMDhKVVFGRmluTUJjK0hIaUJp?=
 =?utf-8?B?ZmtxRHlEWFZlKzJUQWdjaFQzUWlZbXdCYzh2WHNEZFBNZ2xUTjh5T0xEZGxR?=
 =?utf-8?Q?8TCRgKAm7xHz9DjDhmJ2Bd8DR7VXATenFtze49a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1149037c-4adc-47c4-a0d8-08d8eee33b9b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:38:20.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pup+HOIoOdUHEqFFsaLD0lE4RZC3A/OH13W/r2HYdZ4uzLUfaaKMRwv5uZ+ATcn7b4EMuKV1LQYqNNkyjODYJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 1:40 AM, Michal Hocko wrote:
> On Tue 23-03-21 18:03:07, Mike Kravetz wrote:
> [...]
>> Since you brought up cgroups ... what is your opinion on lock hold time
>> in hugetlb_cgroup_css_offline?  We could potentially be calling
>> hugetlb_cgroup_move_parent for every hugetlb page while holding the lock
>> with interrupts disabled.
> 
> I am not familiar with hugetlb cgroup code TBH. But from a quick look
> there is not much of heavy lifting there. If we find out that this is
> really visible we can do the lock dance with cond_resched and retry with
> the iteration again. Or is there any strong reason to process the list
> in a single go?

AFAICT, the primary reason for processing the list in a single go is
that the lock protects the list.  If you drop the lock, the list can
change ...

I have come up with a (not so pretty) way of processing the list in
batches of pages.  But, I dod not want to introduce that if there is no
need.  Perhaps just take a wait and see approach for now.

I'll see if I can come up with some timing information to determine
if/when we may have an issue.
-- 
Mike Kravetz
