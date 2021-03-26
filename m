Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17E034AFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCZUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:01:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56608 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhCZUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:01:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QJsH5F192722;
        Fri, 26 Mar 2021 20:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z4a6SqPDOQkHJ5MeCIf5THzlAVKr11k2fq30qwnW2EA=;
 b=NUGpcN9NFPXTyczW04zr5hd6LVhbicDZphDxuvfSZkWmvtS8TATMAET42aw9XEhsYpM4
 sIETJitm7k+cnfhvsxxDxXgacTOqWWXzGNnVHOoNtskmeOOHhjZqX0vIotnn8Szud9xR
 oMxiIQtpggPRYCWhoPaClWo6UNNC3KXTkpUMq3qHAsoMPFR5Qssxnwa6/LJJd8bdDQ1i
 2gXJ17zzsMzYqTVhsybewW2EJzq0h/ZzKavtv/loTX3ok3Zyo3ZKwYI+h94tVuxDVYU0
 opp3o/TGCdflvBra0g9ZO/TE1+PuVtJ4UEEOxqwmbhGwrpoFqFCeaaZe5WU9/cD8CJV8 lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37h14238j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 20:00:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QK0bWk172723;
        Fri, 26 Mar 2021 20:00:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 37h14nhkx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 20:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnZEw9F6agE5f5Rhj32xO8PD8uY6x34q4E4RsmXTddgPBYniyCDz8vlcUGiQkGHA8DXhoCsplOyGS2a5pvA0+rpmBsC+qPWqoy2a8n68N2HTqxHvcliom/ed6+dhU7FYM2wyYLVfXN9fOAIZLfB63vOx3uBoH54P8CQgxQOfEBf3hUCG6My7M9zKl4JqzdDFja1YVMkuFAciHYe1rSJ1e3sBMSsY8rci3rFOaHpGr7raeMeXlt6EiCWFzlg3SVQ0+Ylga7nUuzeVjGhp5W7M+EqQv7Ugj4VJH6+PrEFSCBEA3mpZrBJoz+0bNDniuYeGw09WcEQPg+wjb9aYPjFdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4a6SqPDOQkHJ5MeCIf5THzlAVKr11k2fq30qwnW2EA=;
 b=Ig340hEJQK/B9Rk6GTj/Uog71qwmXNYCo7+QMTYnLvgqoQfjCGfPGxpUQCYAW4fQupCJiAnXKcc5fuif7mLX5LlSVFFG8+jUWu5tEc2nbV+mgOpyxnfgQEViqAEeRGmN7ixzOOY9vmmUukeCQcCc6sEvD+vdA6qr4U1CLDv9c/pffg+KjBmVr81CjxY98Pr3S4BeBdjexht09itXAGEpTR98TdGIbpG/OeVzRrjW1FEE0LXGnXAHUZYPhs9aPHuEBansveCcDcnbI61ctGY9s3Z2MQRvnaP34iWg9K7GG30/jBpx9w5S1PIafti+8PAE9EfbN6kcqV5+G/EoKBUcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4a6SqPDOQkHJ5MeCIf5THzlAVKr11k2fq30qwnW2EA=;
 b=tZoRzS9oCssjLwFeI49k8xis2nzd1fdnLz0alEuPWGIwmHz3zohchKLXG1phAT7eLZukaASc4xwzX3uii1JfHJJY6Tee+wkvFq99o2BNc4ptdggI3HUEXNEO3/5Ol5TMsRThdPxxInMgfyMIdZ4fBmzLYl6rlFSYkdtKVW4+qZk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 20:00:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 20:00:52 +0000
Subject: Re: [PATCH 0/8] make hugetlb put_page safe for all calling contexts
To:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <7c74ca0d-59fc-9dc2-6e4c-4357ad76649f@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e12c8bfe-c726-cf40-ce26-7c7fd8fc7702@oracle.com>
Date:   Fri, 26 Mar 2021 13:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <7c74ca0d-59fc-9dc2-6e4c-4357ad76649f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0360.namprd04.prod.outlook.com (2603:10b6:303:8a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 20:00:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5556b03-0897-4415-7ebc-08d8f091dc20
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2664ECA5132971DE1A29773FE2619@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCtZV67BVLOLqdENNSWXHJtVIL4cWbfVFYMDz5ISbstuQinAxtVkRAQLa9MkWdSPrjGF9/heyvJc5UvZja+dwUdjjROsK8RLnuei4ijcSKDj9BY6aPde34zGquilvCh6OIMmyH9kwpPgxoKlTovq7pdzT9CUWviZpBWoDZXanRoT6e8QSUgUiYNXRujgafB2eUg+k9lQfH3LCaRJ9G1qHsZjT+avkHtpT2ctKwtR6nBZUtnqyP4MV04Le1+6L5lSklyeG07+aAofnIIUDnBKY/MNdsfO5+R6giCN0UDJq9qsBgiLTSyzQ9Ue1+LJojRAmSZa/34DGfqjHo5PfUn7XwEMPJKrFPsd/HdWO4JzR0o6lPNHBrqGpcxA+4wMUOj7xXF214CUkJ/2n4cWYUHBP0xW/xjH54mWBeAR5IlftxOjnTvlgAkoP5smXWGT8h3zukbLc8k41khur99/ASWJ4Jis/ifXYBAwky35RcBG7hXYwhuZfaJbu6RYud+KITOKCI9uzydOwr6bIWbSpHEh1S7l/KF9VWc2/jVheGZ2r7CeC3LSzq1dRhsNVjjTGOfKsnQ6g9tFLXFiuXYIAq/4WDcmGCwnvKVz+1tegSfSWIEC/XHvjePuLbYMG9lChnM9MN88nnordS7zueB84F2Kgy+OrO9GyfVZrwu8Fmx2Meg2MuAJIvu3swIfPV9HjnowPlp7REo9ql8EH3zyLnQeig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(44832011)(4744005)(16526019)(4326008)(26005)(38100700001)(186003)(7416002)(66946007)(52116002)(31686004)(53546011)(86362001)(956004)(478600001)(2616005)(83380400001)(5660300002)(8936002)(16576012)(8676002)(316002)(6486002)(66476007)(36756003)(66556008)(54906003)(31696002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0ExZGJJNm1uSEtGNXNwT1NZYnNIaDk1ZUZIOFhTL1dKVWVDdzRHM3k0Njhr?=
 =?utf-8?B?d25TVXcyWlIyeGs5eXorajR6TnI5SXR6dUNoUnVhRE01ZktycDdBU2hIQTV6?=
 =?utf-8?B?M201ZGtwWE5SbE9BYjJtRHhaMVVPdkpRYkZtNlVLdXVTSWc0RWdwcEw0bE5s?=
 =?utf-8?B?T1hEeERXQjZQQUkxTGkyQWNyZVQxSzFIdEp3U2N4Ym9xNGlSS1ZpR2pzYTlx?=
 =?utf-8?B?QzhYbUlIbG9uME43VFAwdGg0MjdGV2V1YlYwdW5IMTZOUHVOS2xEc2VPb2Zj?=
 =?utf-8?B?T3pzRXFmbHFuRWhzWlYwUGNMSGtiNFFGblorR1FBUDBxMEpsRHRuam40K1Zv?=
 =?utf-8?B?akRPcGJDK3ZlQlN0YkYrblJEOHd4alFrMmRsNDBvczNCb0hJSGZ2RzIzR1RE?=
 =?utf-8?B?Z3V3Rm1mL0cxdXFRVzROT3RQd2ZZbkdsMEROTmdRME9CUTdCV3Z1WWVCNGhJ?=
 =?utf-8?B?YzZ5bFFvOWtOWjF5Mk9rRHNmeGJyMktHZ2prbStHVFdHOXc5Q0lRNlNFYm94?=
 =?utf-8?B?NnRPeHlHSGY2MmQyOWtnazFIY0gzdzlycEo1T3BsU2s2TFpqUjVMdjIrWXpH?=
 =?utf-8?B?ZVJNWnZPTTlaenhyd0pEVXBJYVRkYzdVdGtQM1Y1Z3JEZGc0TmNlT3Iya1pr?=
 =?utf-8?B?MWwybUsvZWxVbjZjcnNrWDdxMDlHOEtnWjBaVTZKRTRUeG9FZUR1Vk1ISFhP?=
 =?utf-8?B?TTVtVXZsT3dIVkkvQzNGSzZMd2dlY05oTkZrSXI1UEdyZUkrWTlvSytDRDh6?=
 =?utf-8?B?bWV0V3ZkanoydDZJVjlYMGhNYzZ6MWU4aWJESTdWWXlTWk5YV2xZY1RCVDJX?=
 =?utf-8?B?S0I1Vmo2eEh5ejZjNllaNlZzUU1GOGIxVk9yUXBOaGJjbkZFeHg2NTFzZjVS?=
 =?utf-8?B?bVQ4emhuaDY3cExJSitEcC84Z1Q0U2ZXcWJUVU1lQTdvZS9vTWpBRjkrWVVa?=
 =?utf-8?B?NGNYQ2J3T0NpMkk2QlVNbS91WmNqQVRHK3d1QWFxYXlTdE4wYkx4VEd0bTFP?=
 =?utf-8?B?UEJRNlRTUS9RUTB0ZXNFYVJtcE5xaGJieG5YSzN1L3RydDNsckxQQ0lEL2lR?=
 =?utf-8?B?NXdiUk5LQ2xBb3A4UElsRTR1WWxZUnVldU41VGN6dFpmYkpYZDdBWDNWVkQ2?=
 =?utf-8?B?OUxWamowWTRlek9VWC91T1MwbVJNVE50d0VzejI2aHUzZXFkZzVzV3JLSk16?=
 =?utf-8?B?M0NzUk1teG91Tk82VC9YOFlXdDBBNnRJUlNxOGV1c2taRWdEY0M3MndvVGZW?=
 =?utf-8?B?YzA4c0h2WWpFVDY2SWhDWkdHelY3c21Qd05FR3JEODFMSTNZc1hPdGpiSFdr?=
 =?utf-8?B?NWtSVzBtRjNMaWJ1cjdWM0NKVngrZ2VKeE81NU1zTU5pT3ZXTmVxT29TMi9Q?=
 =?utf-8?B?T3dQeEppay96b0t0L3VXQms3NlhMUHZLWnNtVXB0S3JwSWR6TFBpcEtlaG9N?=
 =?utf-8?B?WjJ4bnBDT05SRGVJY0x0cm1zaVh4LzF6RFVQR25hdjZsdGhWbE9sZ2UxUzZp?=
 =?utf-8?B?Y0JoWmo3cFIwL3J5UEJXQXN3Y09KejFWa1FGdDd5a0lpb2hzWld4Wmo5SGln?=
 =?utf-8?B?T251bEZLNndmQUxMS21aamZReVdTVkNldStYa3huaHVkR21mNXhtbnQ4eXFQ?=
 =?utf-8?B?c3RBdXJmZWV1UkprMDVRcjRiQVlWc3ZydnR5QitOeTBBQVhjejFXK0RYVENO?=
 =?utf-8?B?Njg5eFZYcEk1YkdWMVViS1N6eFJiNjV6eC9UYk16Vy9WektsTEZoSEhsaWZJ?=
 =?utf-8?Q?wZqkfbJle9H71e9a0vD4xakKj8ayNdvTeQc6YHQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5556b03-0897-4415-7ebc-08d8f091dc20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 20:00:52.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqYHOlDxQNehbxxWF6hm6qEJBJNFqLKK9CldicewICSeLuB/jXvnuuSaj9glxSJSAcZRpyWfHCqP9UxyvQPcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260149
X-Proofpoint-GUID: UjE3pN3TBK0T8_G57hcZyvD1qYvNPdnG
X-Proofpoint-ORIG-GUID: UjE3pN3TBK0T8_G57hcZyvD1qYvNPdnG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 6:42 PM, Miaohe Lin wrote:
> Hi:
> On 2021/3/25 8:28, Mike Kravetz wrote:
>> This effort is the result a recent bug report [1].  In subsequent
>> discussions [2], it was deemed necessary to properly fix the hugetlb
> 
> Many thanks for the effort. I have read the discussions and it is pretty long.
> Maybe it would be helpful if you give a brief summary here?
> 
>> put_page path (free_huge_page).  This RFC provides a possible way to
> 
> trival: Not RFC here.
> 
>> address the issue.  Comments are welcome/encouraged as several attempts
>> at this have been made in the past.
>>> This series is based on v5.12-rc3-mmotm-2021-03-17-22-24.  At a high
>> level, the series provides:
>> - Patches 1 & 2 from Roman Gushchin provide cma_release_nowait()
> 
> trival: missing description of the Patches 3 ?
> 

Thanks,
I will clean this up with next version.
-- 
Mike Kravetz
