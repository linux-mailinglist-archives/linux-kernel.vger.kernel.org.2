Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AFB32AE19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360524AbhCBWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:21:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376453AbhCBVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:21:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122LF7Hn097822;
        Tue, 2 Mar 2021 21:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Omz8PoAJSsbfMvZoz/Moesn9KvSIu8n5M8chfCpinPU=;
 b=V3l36RDYerLtRyaGvVCu8viguqwv3lcUvU0EmazYLrqqDdHS9BIG2SjsOXKOSxoGtexp
 Npd7QSp5ssjBG+LNYURMyn5Cz1EXkVZStIk+ZDGKOEA7ZEKVmwt515x+eRkPn1GKZBC2
 P3Mjo2rUtq+AoyejohNIZEeNJT62wOhjgWpT4NQaDZCn+PnKYimr9qN4OEnB9GWEKMTI
 GYv98ySjgYtI16EpKBj0Si2xq3NjWOAPpNMsTfbq6l9N++0mIdPxhIhVTbQ4SIdyJ8UG
 ojmgw2rKH1qeQPRrGYBW7CIL76FE3zMG0NS2rwbgA7z2q5waX5zYsweIhph3EoemI8Tz rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqn16fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 21:19:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122LEx5l058393;
        Tue, 2 Mar 2021 21:19:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 36yynpq7yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 21:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ041PCNBE0jXM4QE90RQdYbBkG1suSwe4JKJXaOV5Vstdt8yejMI9eqAeOfLuXufm9rwHahR4WG/cx8zBlFfBzRDESODyDh3Duj3cAHmngUeVQwegt2k3hiR6pKWkc2tkKIxMwqzsJfUnLxIt/kQF4g9So3OcqXbjFlLtmlcmcXbXM2FGmkcLrzq7YvZoNap/RzXXuLZ1DPFX2Y27Hm+eqXSgQzQ7zde7CXgZfxG+qatznjcaItC0CCAIsV+l8U0PEEl15Cv21y6ovU38zpFfl+jipLEp5r3sMHZa0Bf9p8VBjIoeO3b0hDqMjCMB7rt7T0PjANR3FtZHZvHwWZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omz8PoAJSsbfMvZoz/Moesn9KvSIu8n5M8chfCpinPU=;
 b=UjN2DRkam3sF+OdY8ZFz+yJPxN9jr06U21Ax20O9/igLCSTHP0UyS5psOoC8j3xLlix32sIcorLw3VB0UGNCc2KqTgy46hzDK/9+ZdcvIaSnXdEWmxnFfgsz9BE0Olf8yi86QFrRQZ+v9Nbd7390QSemvcJJP12cyOtP4Ht93q/gDwCfiWxs2M3Usf3C5LCTMVnGFhqsrZSgtE+XMj9/u+GQm7AGiiOb6kq58BVknUTEtgeBc5Cc0lr9wswnWrSasDMk2g21JfsGBb6uVbWcXfLSE9UayoWGWFMZfblU74Jzg7n5qScvZ+KK2Ak556wsrkMtzEZ6PZzJn3jMG2i20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omz8PoAJSsbfMvZoz/Moesn9KvSIu8n5M8chfCpinPU=;
 b=fm0Uiyxx5chks8UMmjuIRToIWuolS6dx7b54DHSR50N3JukXvtpBQRCadFn5Qk247tN1EXipf2QNmuLtip41/P1QYNO0nfCv98msbS9zFc/CU+beNWldT4p8i6aJT2XXpPj/WIOEGR5aY+sT4kCGLO7bPJWNQKeT5s3KFNePUd4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2614.namprd10.prod.outlook.com (2603:10b6:a02:b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 21:19:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 21:19:37 +0000
Subject: Re: possible deadlock in sk_clone_lock
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
Cc:     syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
References: <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
 <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
 <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
 <YD4I+VPr3UNt063H@dhcp22.suse.cz>
 <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
 <YD5L1K3EWVWh1ULr@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <06edda9a-dce9-accd-11a3-97f6d5243ed1@oracle.com>
Date:   Tue, 2 Mar 2021 13:19:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YD5L1K3EWVWh1ULr@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:300:95::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0030.namprd13.prod.outlook.com (2603:10b6:300:95::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Tue, 2 Mar 2021 21:19:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 374e7e66-f59a-48d1-c8c6-08d8ddc0e212
X-MS-TrafficTypeDiagnostic: BYAPR10MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR10MB261419E16E4663C8EAB42EEFE2999@BYAPR10MB2614.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADSOvWjLBWQ4FWA4bq6JA7R+VeNYTG0W9DpysZ9YqMUSBhrohU3VPcAsLw2gdamYHpNXbeuozoS8gOVcSGPvkBNAomLl84uAXd6p5mmGQKIBoQeedWmtTAxWF7HftrcsHRi//AnO8f1bd5kA+ImFWMPu9Qb0SCSILgasV66WiGyqSGn3K3gQ3FzChNdQdB4k4V//zygDOjBqYcZYaRhlTpfl4tT678kbu/Wjy8fF/YbGp5KctTFL6xJvaX88GZobOs9HzwNTody8A7TV6YKBsAhU/hkVMErGF4KC6TZl6LV8kNQ48faNmXhh1QWnp+cm1g0lGjOGbZrU+wLDKpCmcHboxwNQJxV+3KCaLIUxxnzxFbZjVlZQFk1hXmsiqUVqFOWYy6yK1RtE6n10ttDobbEjQlP14krQAgLSSOqgeBryf3uC2xHoYQL8nCE82ji8r2+/7UEGySritrAr7hX+0jk/1+ym/JMJh1S7gYWyD2kUsHHDNFj0/iiBw7x9lsHKxa8HEoclGjFwKpwQJlrXAge0XEgA4QM7U5hBrlH5q9/CJh3r01a/x/dX6tXQUccQD86jDZMGQ+LPcNUmxzF1XQmU/caBO2ydx97Sy6ysBfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(16526019)(86362001)(478600001)(31686004)(52116002)(316002)(36756003)(16576012)(5660300002)(4326008)(83380400001)(54906003)(26005)(110136005)(186003)(8936002)(66476007)(31696002)(956004)(2616005)(2906002)(66556008)(44832011)(6486002)(8676002)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TTFrQWVWaUM3eGhVUDNTbjdXTGswSHhWdTRDMi9jZllXYXhTS2NYZWxJZXNI?=
 =?utf-8?B?QnF5dGpZTUhOZVV4Ni83WDNocHBWSWduNktJa1N0c2lIYjVBa1RyYUlDU2tk?=
 =?utf-8?B?d0czYXFiaVBMVE9iaUJGSFBxc3BZcnlob2gweDJNRzRzZ3RoU2NGUkZDa0I1?=
 =?utf-8?B?bWl4cHN1d2p1R0lzMkZhM05QS1k3aDgyTW9iUWcwNDAyZFhWUHFhRDZrTUls?=
 =?utf-8?B?dXNXVWhxVnFkZnBWMHRKWFhYajNid2RoMkpic3dUZnJad0srMVZFTHJCTE1D?=
 =?utf-8?B?MXdUNEE4SUhpVEpoZGZ6K2Ryb25vMzhQOGlkY2gvTk91R1NqNWxiZVZHb3Jv?=
 =?utf-8?B?NDg4aW8xaFpGcDZ0WHQ4QzNrMWpFQ1RFRWRNdUtYSHZBaTc4UnFYTWw0eHlT?=
 =?utf-8?B?aGJrUmdmTXRJRWdnM29tR1MraFJ3R2tqaSs4dGJzdXVDdDVXd0I2MjVUVTI1?=
 =?utf-8?B?UmZDS2VtT0xGNGNmZ3NBL1ZOcjdmSUJWV05TSWxrZVlGTUgyOW8vMlpiMVlX?=
 =?utf-8?B?dHovY3l1VkdhSTNGWXFYZTJ5STNRRnFuYXJnUHpDcGdzZ3lndy9TUXVhZklV?=
 =?utf-8?B?L2psU3gyNDVEZkVUaVFsSjBxR2pGMGlJcTkzWlpyNmtUUEJRcDFJMXp4SVBX?=
 =?utf-8?B?Rm50UTB4clhDb3JKRlo5QnlOSWhUbkpZWXdIYkhoRFlrUk5vT1hlZk9wUVA5?=
 =?utf-8?B?Ly81U05jLzUzdHNCSzZvajcwYU4rdkxnTytmanV4QUR5WVV6eFFwVzB0bEhJ?=
 =?utf-8?B?VzhZcFM4aU5aeWp4S2Vkcy9rQWZpU1Ira05IYWhCeWFHVXNocDRFdVo2WGtJ?=
 =?utf-8?B?V0pXODVZT0FlU3NTOVJxQ3NRcTZBaWQzTk5xSC9KMmlndGNQNE8za2VDR3lk?=
 =?utf-8?B?Z2czNzhqdCtxZjNCSUJjZ3VsbThjeC9kYW1mTExaaG4xWmVCdklhbFRlcHRO?=
 =?utf-8?B?TkZLQ1pBVmw5YTFqWUdXSmpnU28zd1IzMzQxMnhlT2xRUnE1VGIyQ01meUls?=
 =?utf-8?B?UDQvMWxMLzR1ZTJhNy8wZXg1aCtNUHlmeWc4VnNaa3JiMDVBL1dlNHRwQTQ1?=
 =?utf-8?B?S1hCUFJyTzBtWXdBdzdjenBCMEgrZTFqK0pNckpjYldNQ2x1dyt1OHpCRkJ0?=
 =?utf-8?B?M3poME1TM2Vjdy96ODlaWXIvenhKRW51aXhmTXpMRWRZYTUvSlRiSVZnR0NX?=
 =?utf-8?B?ajUyY1JGSGp4K0xqY3RPYllncjhRN3g5bFRPZWVKV2I1dUg4OGlOa2xrdEhh?=
 =?utf-8?B?MXdhWlFTNkNpRmFDOVdyRlZUUDRKbU1LMzJvZmc5djErcXY3QnZvbkFUbWZv?=
 =?utf-8?B?bGFURUNIQ1JnZytkUncwV095bnYrbk03K1FITXE2dHZEQXRucDVDMFEwTHUz?=
 =?utf-8?B?VHpnL2E1U1lrUWhaTndCTkxxS1NTVEtmRXRJNk5uSExHeEQxWEpaRDl1REx4?=
 =?utf-8?B?Vi9YdkxZYzJhNjN3QWVMNmJLUXM5NUFXemxKVFZ2U1JweStRNDJFUjRLZXky?=
 =?utf-8?B?VHZxSmQ0blVZcHprOHFuNWNQZnRnYTUrWWQ2R2x6YW9lakNFNWppVzUwQXEx?=
 =?utf-8?B?STZJM1RzTGxidHA4cUJuMnpGdERiY3BaRkF0WFdnME5LZW9aZURrei9HZVNY?=
 =?utf-8?B?T0NVMXNIanErRmVzVDAxK2FVVk5UR201bEVtU251cGhGcjM3WVhjamNQUEdY?=
 =?utf-8?B?cEZRNFZDMVBzdVFjek5vVTRFdE83bEd6TTk1T0hxcjVrLzFzUGNSZHYveXhH?=
 =?utf-8?Q?Zge0G3emc3Kh98XK7lfcC3Y20hwitMvM1ADoyEK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374e7e66-f59a-48d1-c8c6-08d8ddc0e212
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:19:37.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Phzk4Pp10oCf3zPlsUrNPbo/z1U2Jj1HHs2RXtn5kGCF+XJ1Fy9Te2IKYYcR1SUPapZFRJqz62wJf7I5A4zaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2614
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 6:29 AM, Michal Hocko wrote:
> On Tue 02-03-21 06:11:51, Shakeel Butt wrote:
>> On Tue, Mar 2, 2021 at 1:44 AM Michal Hocko <mhocko@suse.com> wrote:
>>>
>>> On Mon 01-03-21 17:16:29, Mike Kravetz wrote:
>>>> On 3/1/21 9:23 AM, Michal Hocko wrote:
>>>>> On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
>>>>>> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>> [...]
>>>>>>> Then how come this can ever be a problem? in_task() should exclude soft
>>>>>>> irq context unless I am mistaken.
>>>>>>>
>>>>>>
>>>>>> If I take the following example of syzbot's deadlock scenario then
>>>>>> CPU1 is the one freeing the hugetlb pages. It is in the process
>>>>>> context but has disabled softirqs (see __tcp_close()).
>>>>>>
>>>>>>         CPU0                    CPU1
>>>>>>         ----                    ----
>>>>>>    lock(hugetlb_lock);
>>>>>>                                 local_irq_disable();
>>>>>>                                 lock(slock-AF_INET);
>>>>>>                                 lock(hugetlb_lock);
>>>>>>    <Interrupt>
>>>>>>      lock(slock-AF_INET);
>>>>>>
> [...]
>>> Wouldn't something like this help? It is quite ugly but it would be
>>> simple enough and backportable while we come up with a more rigorous
>>> solution. What do you think?
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 4bdb58ab14cb..c9a8b39f678d 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1495,9 +1495,11 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>>>  void free_huge_page(struct page *page)
>>>  {
>>>         /*
>>> -        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>>> +        * Defer freeing if in non-task context or when put_page is called
>>> +        * with IRQ disabled (e.g from via TCP slock dependency chain) to
>>> +        * avoid hugetlb_lock deadlock.
>>>          */
>>> -       if (!in_task()) {
>>> +       if (!in_task() || irqs_disabled()) {
>>
>> Does irqs_disabled() also check softirqs?
> 
> Nope it doesn't AFAICS. I was referring to the above lockdep splat which
> claims irq disabled to be the trigger. But now that you are mentioning
> that it would be better to replace in_task() along the way. We have
> discussed that in another email thread and I was suggesting to use
> in_atomic() which should catch also bh disabled situation. The big IF is
> that this needs preempt count to be enabled unconditionally. There are
> changes in the RCU tree heading that direction.

I have not been following developments in preemption and the RCU tree. 
The comment for in_atomic() says:

/*
 * Are we running in atomic context?  WARNING: this macro cannot
 * always detect atomic context; in particular, it cannot know about
 * held spinlocks in non-preemptible kernels.  Thus it should not be
 * used in the general case to determine whether sleeping is possible.
 * Do not use in_atomic() in driver code.
 */

That does seem to be the case.  I verified in_atomic can detect softirq
context even in non-preemptible kernels.  But, as the comment says it
will not detect a held spinlock in non-preemptible kernels.  So, I think
in_atomic would be better than the current check for !in_task.  That
would handle this syzbot issue, but we could still have issues if the
hugetlb put_page path is called while someone is holding a spinlock with
all interrupts enabled.  Looks like there is no way to detect this
today in non-preemptible kernels.  in_atomic does detect spinlocks held
in preemptible kernels.

I might suggest changing !in_task to in_atomic for now, and then work on
a more robust solution.  I'm afraid such a robust solution will
require considerable effort.  It would need to handle put_page being
called in any context: hardirq, softirq, spinlock held ...  The
put_page/free_huge_page path will need to offload (workqueue or
something else) any processing that can possibly sleep.

Is it worth making the in_atomic change now, or should we just start
working on the more robust complete solution?
-- 
Mike Kravetz
