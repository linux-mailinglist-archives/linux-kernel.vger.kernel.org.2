Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3668D34B163
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZVdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:33:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46934 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:32:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QLVfYu154615;
        Fri, 26 Mar 2021 21:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iqLxD2kwUh0YYMKMS1hmJQnYcWmqpXzCWavPjM4/Nr8=;
 b=RgqKi6ZZQEzLHWGwB4dQR+DoMdofqI5x4TNOKCCjd1QKm8uAqXQYxKWOTIFr0/gW0YDh
 4hcwoTlXfkf6FvSGtrqvBUC/hmdqJ/vWwnJWKf/DA8QkIxNyeM/f2sfcOHHPqLV433FD
 XwzCAEw+c56CZqbyvG3e8ZiB2yUY14lCqVVxnVD9m/YLv+efulOzwdp/zLqOXvRtmjZs
 uwNLQMzF3WZuVwEKR7BEJX5OH+IkSgNw8xlKltS3cnerGP+VzZUsoVnD9eYfBJJLskTf
 q7ESQoDo9c6o/GD/b8Fxpvqoqt5uSUp8+4k2uioC4mgh1uvugCSTtErHnhYjy20x5BEs 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37h13huec0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 21:32:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QLUZZm061266;
        Fri, 26 Mar 2021 21:32:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 37h14nmbjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 21:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc3ibsMd7OOp2iNxDBad1I1YlZeoFEVKpXcAvFBf98pnSX16WV6swc3ZGa2h3dtz84EDn+QrAwu7VM8aHswtHw5AkxuGPLW+p8WxhFW/X1x5Tsgr8gxkbQd6Nm8pNAOpqLNJaRcZlLQFFvs3aCvkhZdrVyTcCJWpj2zyox5n3FE9YxljPrcKqs5Ts3Nn9nNHUFgaONv86SG3Av5z8idD1C0Zc3iKKMc7ATA61l13I5SyAfEv/JhPaw19E9MA29GFAwadg3UAe54uxl8fEsYVRHcAkvOcqDf93+VQ8I3HhQHxWtJrILJg1b6QNEsnKIWDORiSa2/XN+YL2jf6PG6NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqLxD2kwUh0YYMKMS1hmJQnYcWmqpXzCWavPjM4/Nr8=;
 b=Q0asc/GzBKXAWcoKZBtjMPmMGGwjpeE2pG7o2UiJbZry3BjmuMeu8fo9pE8C/Qj71cjWR/imusO+/E2629wu//jlDIezIk0Kfs5uWNBZkKo2+MCLfnIim9UUHDAZ9brNsDmtqEXDP5/iuEAML9VXqpDP/ej5JYlf7wSrOCDHr+FxNWG7o6K/XcUDCqd3a//Ho/zdciDb42AxXtWydQnHUxjFScXY6oG2Sx3tVZPQDcxSynynTCrHbL+xtNNIOc258q5SrZ3ZOO3hhRO4a/oVzbNyP4TpgBOxuVkZvlLRJx2pOj29kyzVwjf0Jqso0Y43zgTuaNSfpOo5QYzzxR3lKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqLxD2kwUh0YYMKMS1hmJQnYcWmqpXzCWavPjM4/Nr8=;
 b=QlYt5DURf8YkhsMQQ1dbIlKL47/7bwcgHB94p8nTgeYY2TiZRq5qFkvOqMKKk2RirMGAQn0KmXbckNPgqvzBlCrTnuT5uB6EwtV992ekshl5V7qqC9ACUt/o8XKV4/oj4RO8GMB4R0jmEygLFa9iR+xUhXcm/Vxh0CIGxxNNGls=
Authentication-Results: lge.com; dkim=none (message not signed)
 header.d=none;lge.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 21:32:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 21:32:04 +0000
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
 <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
 <YFzuw0S5S/aG7nVk@google.com> <YF0agS53iGkFo41Y@carbon.DHCP.thefacebook.com>
 <d1e712f3-c2f2-dcad-85c0-dc152bb8eecb@oracle.com>
Message-ID: <0f7f3c4e-530a-5cd2-2719-259e509366e4@oracle.com>
Date:   Fri, 26 Mar 2021 14:32:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <d1e712f3-c2f2-dcad-85c0-dc152bb8eecb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:303:b6::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 21:32:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74482a0-e5a0-4ac7-f470-08d8f09e9968
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4704EB524804CEC53481F92EE2619@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9czpiYXsVso24fK1GguEaKYoyZeZWYacVWjTqis/bZ3a3CoOmhRuW+1Duz5uDZ16/ao0kWEWkoQ7Zs7284zJ9FzEdTixNj8Ffdwatw22tfDZzM9xJyaPPS3QMZh4gRr82+SRc922Dk+EdmlBB8SIlouOCDyfDQCsowRw+Njfd9jb0X+RX6M+3lRDdmrk2k9ST7ucAiYS/XkY+rAykeX9p3Gp0wm7G6jHz9BQoQQiXjG95z3Z2b61Wt/7EMdqQFCENuTgpAO0mV+rv/fizFwojzjVA1N85ek+T7AZkLA/CRP3aD3bisnVcgOZdinWJzicFkVqcDGKNl43BT/pIzIiCitIlAUQgVFlEC/5ZUj053voHzsHXHzPfObimgDTM4OKyPvMEWX+9t9vCCgHStsxSw1iyQR1huoDmpQvlFt+AfqwdV73Y68ibi4kOLkHKWvrradkzDfknRbXOO7H5ey13IBSnaGW9sZO5qD5MInwmtkRBVaxhJa9IjJotS94aOAQv9bWX7vVH8Pmly518ZDOWhbnh1uBWLHl8vmPOz+7lN132CvbCSDZjjIfpjVDNkHK3Ib2Fa/ttpksN3rMHrY1YtuiBQU25cijc2cNNI9EQRMvsEJcPKROYeI0R7nIT6kSA2QkZDgGqosO/2EDW1vWYNcBpM3KzNvo6Yx/WZqfT4w410jAiwZ4hgJy9j19LxuJ9SsoCSP/HzVhD1QGxib5lYBH2YoS01k9CcEpea0vlj+AXKGBumWWy00FcbGWnBlt4D60tM1go225EMBnaLHcZ2aiFkNnAUhhZFlMeKaWNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(36756003)(31686004)(66556008)(86362001)(38100700001)(83380400001)(8936002)(2616005)(8676002)(956004)(66946007)(66476007)(5660300002)(31696002)(54906003)(16576012)(316002)(966005)(52116002)(7416002)(4326008)(44832011)(478600001)(16526019)(2906002)(53546011)(110136005)(186003)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dWI5RnlqeXdSd0xYbGZtRjRKQktCcmtXMGJDT3poQWxaVzdzRWcrUG8xZTUw?=
 =?utf-8?B?MnpITFlmUnJKM3oxaWxrVndFaW91TVI4ejFjNzNmSjF1WHRDdm5Pc1RkY0w3?=
 =?utf-8?B?WVRweUc2WURCVThGU2hGVnUwNmFLc3F6Q2k4SXlJY1FjdjJFSzcrWnJSNjEy?=
 =?utf-8?B?S3QyLzBUUUJxbmVmTGkybmdjY2MyZ3dadWl6Z1VURUJiNDdYbXg0ZktpWnBv?=
 =?utf-8?B?MUhPWlhmamVyU1JFWmFNSWY0MzhqRUVLTXBzbFJqM2tzVThJdFFNb3lnK2dh?=
 =?utf-8?B?QWFoODdyVlFYL2xKYnp6L3Z5T3dReS9ldUVnSFRsWnZ1L3laS1BPbWVOZzVs?=
 =?utf-8?B?SkQyOWZXcFRMQTZsd3k3ejJHNldiNHBWRUxvc3krZWFGZVkxMVAvNkVqTGJF?=
 =?utf-8?B?M2dCSmRlTk11TUY2YWkydWRaeUY0U1VWUk1USEg0b3ByaTA0eWE1NnQ0Zll2?=
 =?utf-8?B?dXltczI5MG5TVEN0QkxTOWJyVDlBQmNOc2ZzcllacFZ5NmNyM0VoQ3h5cDB4?=
 =?utf-8?B?eG1CZ29iWE5OWmhlbEtyN3pqcHdvRHZya050Mkk0NUtHcHF4YTJOajdKOWlx?=
 =?utf-8?B?RkhkMWdhUzhSMGxobkFSSCtycHJ6UWx0YWRJWjlMTHFkby9PRlEvdVdRRHNk?=
 =?utf-8?B?aFJORjhzYldubzhWODdWYklGeEFzeHd4ZWtJU01TRmFPUzFGZk9NTlVpblpu?=
 =?utf-8?B?QnNTZEcwdFI1UmJzMFVFT2FsczA1am4wZy9UWlRHU21ady80U3A5ejZOZGFX?=
 =?utf-8?B?VFA0QzFESW9qYlcvb0twUVVxekJLZ3dFcGNkTHZKeXNTUGpxS01jWHcwNU1D?=
 =?utf-8?B?VTlqM2JxeEVnMGZJVmhwcHdDUDQ1ejU2dEFsQ2UrcDBDVXpuakhsTi9GSHdE?=
 =?utf-8?B?UThzOUFIM09IYlNTNHpLY1FRbzlVcU5oeXd6THZzMEJHTnlTNTB1NUVUN09U?=
 =?utf-8?B?cUNyWlNCK3ZUV0JqUStCekQxOU9wRTJycmUvbE9uNW0wS1BqWTQ1KzQ5aC93?=
 =?utf-8?B?enpTYm1WQ2MrSWZ5dnV4QVF0Z2hvQm9JN0VQYWhIak1xN0J3b3h2anlaS2Nn?=
 =?utf-8?B?Q2U1aS8yVkN5dUR3U3J2WGJZNXRyUnhmMjZqS2dvaFpLR1pFWGM5RjJrYVAw?=
 =?utf-8?B?MVYzWW9CUm9QY1hBcEk4amRlV1ZBaW0vcjkzR3pJd1p4dzNiREw4STFTNFBn?=
 =?utf-8?B?MExYKzA3NzRveFR1clM5NGI4N1pnTTVVdEkxYVZhd2IxSS9tVWtoTVdCZmpp?=
 =?utf-8?B?SnlYS015WXVSZ3FjNGFDNkhlREMxcWY1YTlSMXNKQVNUcjBMS1gwRit5QzdE?=
 =?utf-8?B?c3FwRkRvMktOMUFiOC8wTDVJdk9tajdhSFJlSlQxM1ZPNksxVjJJaFJpSG1L?=
 =?utf-8?B?ZUpNMEkxS0J5T1pWTlh3NWEwaXRwQ0xKMnhjTWtnZGpDekRHY2hRQ1FxeHVu?=
 =?utf-8?B?ekljVkk2TzBUa1RveFQzUTI1b1dvNmRHdjNEVGhOZVFGdVN0Ym5iVFBkRDM5?=
 =?utf-8?B?MG11bkZyZGdYZFJWWUR5OTZaanJya0VDS1JoQlNwNHpkcXVGejBGUXN2ZnEy?=
 =?utf-8?B?VmQ1VmpXY3NJaWI0dFhBbUltS21XQnU5c1l3TWNPejhDRHdXV3RLNmovTm52?=
 =?utf-8?B?NGlOQUFlNzNqV3VRNDNLemFkM3BqNzdwTk53dEFWbjlMaGV3YUNYZE1QTVpE?=
 =?utf-8?B?YmdCRWlyanZ2STljVFdROVRWVXg3TFJlblJwZ0xhS2FINmsyZmpReDZESTZp?=
 =?utf-8?Q?YnlSyRN9blp+mOT+zV/2ah9s93DcNqkC0PegWIV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74482a0-e5a0-4ac7-f470-08d8f09e9968
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 21:32:04.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1RSELztj0ntPy+Md/Zn3pAUY3ISmQybM48pe/UaN9ZXktD/eYkniTsFEcIEqELMPtZeLNzMNRu69y8OryufhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260159
X-Proofpoint-GUID: Rp-gWfq3Fa2sjtI3xFINhe9CnLE5YH1c
X-Proofpoint-ORIG-GUID: Rp-gWfq3Fa2sjtI3xFINhe9CnLE5YH1c
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 4:49 PM, Mike Kravetz wrote:
> On 3/25/21 4:19 PM, Roman Gushchin wrote:
>> On Thu, Mar 25, 2021 at 01:12:51PM -0700, Minchan Kim wrote:
>>> On Thu, Mar 25, 2021 at 06:15:11PM +0100, David Hildenbrand wrote:
>>>> On 25.03.21 17:56, Mike Kravetz wrote:
>>>>> On 3/25/21 3:22 AM, Michal Hocko wrote:
>>>>>> On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
>>>>>>> On 25.03.21 01:28, Mike Kravetz wrote:
>>>>>>>> From: Roman Gushchin <guro@fb.com>
>>>>>>>>
>>>>>>>> cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
>>>>>>>> It makes it a blocking function, which complicates its usage from
>>>>>>>> non-blocking contexts. For instance, hugetlbfs code is temporarily
>>>>>>>> dropping the hugetlb_lock spinlock to call cma_release().
>>>>>>>>
>>>>>>>> This patch introduces a non-blocking cma_release_nowait(), which
>>>>>>>> postpones the cma bitmap clearance. It's done later from a work
>>>>>>>> context. The first page in the cma allocation is used to store
>>>>>>>> the work struct. Because CMA allocations and de-allocations are
>>>>>>>> usually not that frequent, a single global workqueue is used.
>>>>>>>>
>>>>>>>> To make sure that subsequent cma_alloc() call will pass, cma_alloc()
>>>>>>>> flushes the cma_release_wq workqueue. To avoid a performance
>>>>>>>> regression in the case when only cma_release() is used, gate it
>>>>>>>> by a per-cma area flag, which is set by the first call
>>>>>>>> of cma_release_nowait().
>>>>>>>>
>>>>>>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>>>>>>> [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
>>>>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>>>> ---
>>>>>>>
>>>>>>>
>>>>>>> 1. Is there a real reason this is a mutex and not a spin lock? It seems to
>>>>>>> only protect the bitmap. Are bitmaps that huge that we spend a significant
>>>>>>> amount of time in there?
>>>>>>
>>>>>> Good question. Looking at the code it doesn't seem that there is any
>>>>>> blockable operation or any heavy lifting done under the lock.
>>>>>> 7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
>>>>>> the lock and there was a simple bitmat protection back then. I suspect
>>>>>> the patch just followed the cma_mutex lead and used the same type of the
>>>>>> lock. cma_mutex used to protect alloc_contig_range which is sleepable.
>>>>>>
>>>>>> This all suggests that there is no real reason to use a sleepable lock
>>>>>> at all and we do not need all this heavy lifting.
>>>>>>
>>>>>
>>>>> When Roman first proposed these patches, I brought up the same issue:
>>>>>
>>>>> https://lore.kernel.org/linux-mm/20201022023352.GC300658@carbon.dhcp.thefacebook.com/
>>>>>
>>>>> Previously, Roman proposed replacing the mutex with a spinlock but
>>>>> Joonsoo was opposed.
>>>>>
>>>>> Adding Joonsoo on Cc:
>>>>>
>>>>
>>>> There has to be a good reason not to. And if there is a good reason,
>>>> lockless clearing might be one feasible alternative.
>>>
>>> I also don't think nowait variant is good idea. If the scanning of
>>> bitmap is *really* significant, it might be signal that we need to
>>> introduce different technique or data structure not bitmap rather
>>> than a new API variant.
>>
>> I'd also prefer to just replace the mutex with a spinlock rather than fiddling
>> with a delayed release.
>>
> 
> I hope Joonsoo or someone else brings up specific concerns.  I do not
> know enough about all CMA use cases.  Certainly, in this specific use
> case converting to a spinlock would not be an issue.  Do note that we
> would want to convert to an irq safe spinlock and disable irqs if that
> makes any difference in the discussion.
> 

Suggestions on how to move forward would be appreciated.  I can think of
the following options.

- Use the the cma_release_nowait() routine as defined in this patch.

- Just change the mutex to an irq safe spinlock.  AFAICT, the potential
  downsides could be:
  - Interrupts disabled during long bitmap scans
  - Wasted cpu cycles (spinning) if there is much contention on lock
  Both of these would be more of an issue on small/embedded systems. I
  took a quick look at the callers of cma_alloc/cma_release and nothing
  stood out that could lead to high degrees of contention.  However, I
  could have missed something.

- Another idea I had was to allow the user to specify the locking type
  when creating a cma area.  In this way, cma areas which may have
  release calls from atomic context would be set up with an irq safe
  spinlock.  Others, would use the mutex.  I admit this is a hackish
  way to address the issue, but perhaps not much worse than the separate
  cma_release_nowait interface?

- Change the CMA bitmap to some other data structure and algorithm.
  This would obviously take more work.

Thanks,
-- 
Mike Kravetz
