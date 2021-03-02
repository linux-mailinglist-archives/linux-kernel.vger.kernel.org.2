Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD632A0AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576334AbhCBE1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:27:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhCBBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:17:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1221ESX1176459;
        Tue, 2 Mar 2021 01:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VyrBXnv/InW/sO+lmsicUiGh+FLSU4LXyl1ngTCXvNs=;
 b=PMk45FXYj8I91w2H+8pBswwCXz3s38iKoYPVyE0cWyf6HrSad9BDxDzqHnOCJ8Qu973e
 JmNC2zJxyjcsF3+bPfZV7hIm5L2lRijSN93p8L4zxog3vvwzBGxpcJ3Ty++FioDKvUqP
 Pf2V5HcV0b/Jkx0sexfb6fYxrCiQaWANpx+tzo5I7JnRute6ZlCtRzkcixrHp8GqlDfr
 zeFmKMlwvuqR1krxwNOI9pJ7X50qB4swrCi0zPkryMQ5HICV0x1SR1aMjMIfjOC6Dbwr
 Ol6LJQQo9PujDF6drOQlqhF4K1u2zArygGk0qBQSsS+AdbtKqWkHcqL6BTNFT//ALKay gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ye1m5ty8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 01:16:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1221EtgD045965;
        Tue, 2 Mar 2021 01:16:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 37000wadcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 01:16:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F33/xHFrf2ElU4vSz3jDiHg4ZGhNbhBShCWV50mIIsH7dKd7Fz6sv95CmUJ/S7MNXtKQL8jgD2eMGqspCTF58Rg20iqvRAzkHx0X3iQWLec6sC0ebAZ32f1pSzHvBc++Ip9dry1sb2H66P3svhWsEGbxwsCu9oEAqFg05FgNITxwlImlxLgZEGmz3KD5eJiml2pyyr8OvU6HtSytJEykh8i/1DzFGfTuH7/+xx1P67DXTq+dzQnUV584dhXMbaBn5BO2060ym42/lOsIh3tZIz2Hr5nqU7oVaPqTQ2xW6pW1WEEICMxO3wtlH9QdLLlhGCUj8uh5WMG0hl9bCZRnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyrBXnv/InW/sO+lmsicUiGh+FLSU4LXyl1ngTCXvNs=;
 b=l0TtNTURLG3Iy4zZp3/c4KRzB7QvFiuTbr0C70lXnxQssLY+E3RejR3vXfGecHeO02C3uupbdLfocwVQX8qZCBAtd8KIu9ZDsO5IJ7xjSOXn2Jwe7DZHd/DJUxp8qUEi0oSK4PGs3He+5CXut4bUFVUdF+C50o5cpd1FR86zC8Lw6ewZmxr9BOnQrWK5yc7WvuS57S54ddU4ARmNrUSaCiqZwnXGIsr8KrvpkR3wKbX9mNNnuc0pYxrOx50WCGuGtPaRrfnOBD/SvvJdLGFFV0nQaRNg1mWwcSQXauJ3ZgSdPirnnXB/9mBEDXszj+Vgzz0I1+x3txyFyC37kxvHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyrBXnv/InW/sO+lmsicUiGh+FLSU4LXyl1ngTCXvNs=;
 b=fDOJrOTzeMktQ/JEGx+BDKanC/zPVUcPVSA99U/WdgQV76xCCA8Oqgq+IDRXwYAnJJbaqrpqZQTvgN9i/EabYojNpt1+tjAc7xXm7UYfTcTYI+R8yzpmN9Au29w6KFlaXnRBzGmpL9ojj9IaUM0VGyJMKW4szxMc07KDagutGic=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4528.namprd10.prod.outlook.com (2603:10b6:a03:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 01:16:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 01:16:32 +0000
Subject: Re: possible deadlock in sk_clone_lock
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
Cc:     syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
References: <000000000000f1c03b05bc43aadc@google.com>
 <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
 <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
Date:   Mon, 1 Mar 2021 17:16:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:303:114::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0364.namprd03.prod.outlook.com (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 01:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3b6381d-3180-4102-9eea-08d8dd18d080
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4528:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4528A56B9F5362F3648F63A0E2999@SJ0PR10MB4528.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxd1BbDz2a5SvA53FcY1VLFBNG2T089RUs3DHO2hXTvecGOfEr3sZQqISQ2KbZjZ6YNaHkI6tzYVOuToE3bynSTMn1t3DbYnTylrDOMoNIrVo9m+w2KoCh5zog13aGLKA2TttIHI2aAtGOQerLC+uGmva8BSvW1FbBroZRi50Ucg2cdPlZw2JiKarzRZiANNNeXadFLw/41derMKjH7SQC2sZo7WTjQuVPEmB1QT3IejyGvkS/R81j3CNs/ThGZ+g4UIk1Rig762we6RNFeyfTQoW6yLmDlBskUF2VFABOQ6uSSUQpvPUxg8LBqJ3WlMYPQLyO8hTueNkVL5Kkco+NB95DbNMxyxzuonyew7vuSQ4e/AopHJpJE2a8rvAxcsRFiiOe9aZbKeeQbot/hziRzU7cWe4h9FeqsDR6WTjwzmUdXaZ2JevTjL1/pbBICH1+vha9v8cnJ7tPWlLReM97JOq/hCNw6ALKXNjCV2/D5N+QtXKXjcyywBREbwWWpS1aZ1JnJJKzyE+9A1U/6bfF/bgSUnTt04Hlvg2Z0GZa2ahhJaIdGpAFdGdCPcYfplhL9v9o0Lo0P6ZDJnUPZ57rBuXRfZwT/1m2rNH60J7Mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(2616005)(52116002)(956004)(44832011)(31686004)(86362001)(8936002)(4326008)(53546011)(186003)(110136005)(16576012)(66476007)(316002)(54906003)(2906002)(6486002)(8676002)(5660300002)(36756003)(83380400001)(26005)(66946007)(478600001)(31696002)(16526019)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHZuZWliL3Jabld2UUxuL0tpUys5TVZHdXRFSFV4N2g2U1lSYTdmcWF0ckIz?=
 =?utf-8?B?N1V5MkpEcHhDQitLc29PL2R3QTdKTGlJN21VUDcxeUM4SExtQU5naE5UbEZr?=
 =?utf-8?B?dmg5UnJZZzJpNzJlQ3h6ODROanoxNHpwemFmdW5QWGFyaW4vMlNXL280R242?=
 =?utf-8?B?M04vbml1aDlVWEpTdFFoNmQ2bzVtZmNWdjYyOUdHTC95QzFJZzdjdS9zbGRJ?=
 =?utf-8?B?Q1pLL2hUZUVHYUtKWURPUGZBT3ZWY254QmdhQ0ordlBDbE1jWnVud2hZODV1?=
 =?utf-8?B?c0gwNlM3blRGUUdxL3YyT0dVZ0NIWm1zdCtDb2FYRndRUVM2TjhpK085STNn?=
 =?utf-8?B?R1J6cU1PRzZPbU9WTWZyTzJIOTMrYWtuVDJNN0xRaFMyTkhhMXpHNWxEU3JN?=
 =?utf-8?B?eWNxblBmMDVEOFlaUGlwdC9DY3Y4cGZ1eDNMUFI0K0VoYnpXS0dhS05DcG1G?=
 =?utf-8?B?aUdNUUVPcXpJbTVYc3NxMkZWc2llTlpTaldlVkFBUVVSS051WTRldVNpdmpi?=
 =?utf-8?B?UU45dG1McVpyazJIZmI4TlF4QkJuMmFST0dXUHVkY1ZGeFlBYkhSZmo5TmhC?=
 =?utf-8?B?T2N5MkM4OFVVdmFqVFY3RnlYZG5jL0JXN1ZuMTBjS3A0M0hmRGMrR3QzVDdE?=
 =?utf-8?B?UzFhSXVYL0k0d3dXdjJkVmt6K1Z2N2RML2lWME9xTzR1WmpCYWhhQ3prY1k5?=
 =?utf-8?B?c2JwaU45MmhuYmlCODhndmEySEdHdGlsNDkrK09JaTVWOUpaeDNhSUlnc3dJ?=
 =?utf-8?B?MThCdmRxQzhsMzJDa21saURBQlpIbXJrN0s4QVdRVzFpa2NCcDdNVC90S0tj?=
 =?utf-8?B?dUtzWmQ5SzJRRGNPTUpwWnZHL1lvc1NERk5oeGZlbzBrdXZpWW5aM3ZrQ1JH?=
 =?utf-8?B?cmp0VGJpNTdEY0w3eU83U2FWNU55VkJtZi92emQrZDFjMkt1cFFCMm0xVWJZ?=
 =?utf-8?B?QnBnYTZrUXMwNXgycE9VWXg0RkJCUWdsRnRmSWUvaWN0SHRrVUtPWDRvTWgy?=
 =?utf-8?B?NmZFNURyeTRwZVdiNi82UUNzOUEzclpIaVp2U2w3VWtMZHZHcnB0cWFBMlVR?=
 =?utf-8?B?bnp6TGNxcTBsQy9xZlJjQ3kzblhGVHJON0JsUkl0QnF0Qm1DL2Jwc3NJZHRK?=
 =?utf-8?B?bGJ3Y0ZKdzNyYmIzbTVSNFU4R3cvdjZEQWY5NUxlbmh3MklXaTMxazdVaVMr?=
 =?utf-8?B?VkRQQ0wwa1ZsMitmVS9jL3lEQlZzaUlkQU1Nb00wcEdBcFUxTnVCaXBtUTlo?=
 =?utf-8?B?c3ZLM2d6RktRUStPdnJ5WHU0bkhoQXE4ZzRvT0hsV2ljWWl0NmtEYlBtZWUy?=
 =?utf-8?B?TU9COVpqeHhXbVQxeUNZbmo1a1NLeW5WaXFONTdrWkR3Z2xOL3NhZEU5dmhM?=
 =?utf-8?B?dnlCY3RQWGc0aE1zaG8vdkZ2Ym9aY1R6UzE5RncySnk4dllzalRTSjUwa05S?=
 =?utf-8?B?dEJCWEpmOC9tck8wdndzcnV5OFVqQ3JLWkk2WnBHSjAyemM1V21wRWdIWWJU?=
 =?utf-8?B?TFgwMStWdTRwRFZoT05xd2RQV21INndCU3ptOHNOeXBkVVd5a3dBV0g3d09y?=
 =?utf-8?B?VGlpakg5V3I3S3grZEphMTlzK1p2M1phNytFVVhyYmNnRlFVeEoyZW9DSjZP?=
 =?utf-8?B?YVM4SER3Z1l4WnZ3M2tvTGVURlNRNXdHb0JQczBVbVFqdFJxMEN3VzlYWWdZ?=
 =?utf-8?B?WXpvS1BaQWY2NHYzVWFLZkQ5cmV0ZGI3U24xQzBURDhmK3E3dFhFVkNUNmhn?=
 =?utf-8?Q?68loHDTZHHmEHdndBonmap/oW8o/aI6s8+fRmPl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b6381d-3180-4102-9eea-08d8dd18d080
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 01:16:32.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hR/p8+mdbk7g9DFNySMJERogkX1DfrapAY56PyR5JHShbCjYvkd9lWIRKudZLYt/AYOhWvWORTLEfZlfO0+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4528
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=908 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020005
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 9:23 AM, Michal Hocko wrote:
> On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
>> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
>>> Then how come this can ever be a problem? in_task() should exclude soft
>>> irq context unless I am mistaken.
>>>
>>
>> If I take the following example of syzbot's deadlock scenario then
>> CPU1 is the one freeing the hugetlb pages. It is in the process
>> context but has disabled softirqs (see __tcp_close()).
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(hugetlb_lock);
>>                                 local_irq_disable();
>>                                 lock(slock-AF_INET);
>>                                 lock(hugetlb_lock);
>>    <Interrupt>
>>      lock(slock-AF_INET);
>>
>> So, this deadlock scenario is very much possible.
> 
> OK, I see the point now. I was focusing on the IRQ context and hugetlb
> side too much. We do not need to be freeing from there. All it takes is
> to get a dependency chain over a common lock held here. Thanks for
> bearing with me.
> 
> Let's see whether we can make hugetlb_lock irq safe.

I may be confused, but it seems like we have a general problem with
calling free_huge_page (as a result of put_page) with interrupts
disabled.

Consider the current free_huge_page code.  Today, we drop the lock
when processing gigantic pages because we may need to block on a mutex
in cma code.  If our caller has disabled interrupts, then it doesn't
matter if the hugetlb lock is irq safe, when we drop it interrupts will
still be disabled we can not block .  Right?  If correct, then making
hugetlb_lock irq safe would not help.

Again, I may be missing something.

Note that we also are considering doing more with the hugetlb lock
dropped in this path in the 'free vmemmap of hugetlb pages' series.

Since we need to do some work that could block in this path, it seems
like we really need to use a workqueue.  It is too bad that there is not
an interface to identify all the cases where interrupts are disabled.
-- 
Mike Kravetz
