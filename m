Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70A3535F7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhDDACF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 20:02:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57428 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhDDACD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 20:02:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13400poZ151621;
        Sun, 4 Apr 2021 00:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ja+Kw9wxxPWF+aJqUWmGwnWOFPnE1HYuTSd9tsVr7P0=;
 b=w732KJbQSKlRvyoE665uKFCH0/4ZZxaCvZyPZkOXJOovp9YvF2us5QfxbrEwJ0VFoNB1
 8EtM+35tC5YdHXxCasz/q0hxOA/TIElXf/X/DWqh6RqcXs2YuCqyjn1Xc93GyasTGYxZ
 +wQWJzt9kzIuxCU7UChdGlHdmmaTvR2MgjKnkT3cG5OE76HtkfKPQVsEx05mttVysiAX
 iTiip1WkwL0KF7A2R0kQfgXq4O1vVwRqsPQPDwaWynXL+YqPxemTzNzE7N7vEhUI1oDv
 rZDa2vpjw7JmV0VUpxSq6ggLP1kXJeepNG9qmUvk8V3zpYMdXziVnPRqBfd0Dx9IdN4S ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37pdvb8vjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Apr 2021 00:00:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 133Nxo5W196342;
        Sun, 4 Apr 2021 00:00:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 37q1xk8f1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Apr 2021 00:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+lWK1tDsgPHrki7OvcaLg7rmidWmAbw6vdOymz9ZzIWfQ+kGxGPBalF2bCAzgDfYDxC0Kp/yWGju+gp/5xL1o8ienYHjALYNT6rDTl/pHsIRbe269wJsKYoX+cXpi65cqSun9p1GcBE9R7cmeuWx6XyHmyYIFV1WZcXLdzHugGXinWIHUQT94oMfABsCS0uk6N6vGnB9A6p7F9rn8ZA79e8GXIiw7Kzj+gzd5Wj225r43Ov10JkTdOXdED2Q/NpX29QchPcJbCpwM2mstQf5W1du92iIVu6tvgauckD1oegV/3INJ8OGhgEgpAqSia7tPFzcGtu9t/ijy/WSRbXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja+Kw9wxxPWF+aJqUWmGwnWOFPnE1HYuTSd9tsVr7P0=;
 b=G9SRujKa47fEyR6wv2r/fERnUsjLLAFWLRuX//mUVz95XNDTFEogBJNIIMKwOYafkNrajKgD027w4zj/P9ro7J+OzvZTcPn/tt1iB9MnBfTvZJ1Wuqm4RS8dDbLwFOytYUi/sq8ai2vBHhVc96TmxO5zZqbtyi9X+LISKC17gvobAk58fgJUhyEblfJvVcEWLHXhXN6KsYA9EfaLN0BI04AVRdrWymAEThrRdqvjgiHUIAKh/XTXxVcXIxTa6VBwrbPSjwsqh25z+OdPDi6bJLmkbCrqe7mfjPdntqQGynjjdRksZf4AJj69CWyDAFbgQ+wQufMvgMWCR4/azC5rVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja+Kw9wxxPWF+aJqUWmGwnWOFPnE1HYuTSd9tsVr7P0=;
 b=zaanXyj66fm0uRrLRIYCqLBKBHfY6O89zKDnVB/M8qOV+oCz7XAHbaTyX5H45QX0n7O8H3idCfgVjjmF2gGIsqf1oKomYniFc+gt+mDd77G2Uo7ecIjU5qm2pjfPqJejl5aY5WtSKnIBbUw6oXldj3HVzEHYilwTuhJZopajgfY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5455.namprd10.prod.outlook.com (2603:10b6:a03:3b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sun, 4 Apr
 2021 00:00:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 00:00:47 +0000
Subject: Re: [External] [PATCH v3 7/8] hugetlb: make free_huge_page irq safe
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
 <20210331034148.112624-8-mike.kravetz@oracle.com>
 <CAMZfGtUUWD4WkTOXL3D--jfbHYXUuYQsWtiX0k3UD=_x2SC78g@mail.gmail.com>
 <b0b081e2-9d78-77ab-684f-a0989a7f1d27@oracle.com>
 <CAMZfGtXjhq41iHDy-9gB5Uf8iYrXV1G_eeDgH1XPL-6WgROcuw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9e146133-16f4-cdfc-0174-fe1ed53cddc7@oracle.com>
Date:   Sat, 3 Apr 2021 17:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtXjhq41iHDy-9gB5Uf8iYrXV1G_eeDgH1XPL-6WgROcuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Sun, 4 Apr 2021 00:00:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dda252c-b28d-4625-2974-08d8f6fcb2d2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5455:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5455024CA9246F7E0352120FE2789@SJ0PR10MB5455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEKCbS40uNnavUqqXlcqzaaoG/enmV4aKURysjIVt4E/ljIi8Rs+GneY0lP29qyY3OIg73NnJQrJrOBXt/cqNmQ8xcx2u7r9dqCx3ct0bsa0ZplWHaoYf+inWnIAlopaIGo49DeWkcMBLD8CV2QT6iSRMybQSgYMRNp0UG8jqgcfh2BoxnVoGJvyG0uGsOlNYEU5fgr9LjmxJmgh1Y3bGBcx2+rfk+F5GenfBCUQfNCy1BzI7RMvNeFh902HkEh18VuGu+fKbXhfcR/Xr3R0QHmSX+iIl1C+IVkorCa7mweOUTGdz8Zd3CMSxjeYymGst8d7fAswC50SVSzy8Wssxve1aWPjZQU8zw4UWc+G9X65G66SJkCWKunj8CSsn1P+EZn6h2rzjgjTq1jNm3NuixfWbftTgMc/cyR7A8QERBe6UWKLtY+J1xfxR4jTGpOGldKBdWIzslJHdrNJ+nqNkoEy94igH0QFN1NAVZ/LDZ4S7xFwvzLOT1TtQAOo49d2/gF6+LjBu6FOyefCKzrqpQxNFpPJgy5KI6mGu1YQ8KDUhfClkCmt1rZ7FXVQ+wCHyAptoyZMtObtqVkk5zzFJFnTucJd0rjR0D9q+OA50nY+yPDnUDcMFdT0xUfGE6JZec/2tLDNHChVg68UrB3BkmcblipL2wgdItAYb7eS+edqvqRr430j2uuwWZtj4mcVdcyemV2SCkXJyf0DpK0lCWMBlQZ4Bx/TfzrxITZF+t7c/kpiV1D1QGt10Hhf1PMggsqQ4BC31St/WOXx1OM0RbrC9j2MSc0SsSoPbsTLklY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(38100700001)(966005)(83380400001)(26005)(44832011)(478600001)(8936002)(7416002)(54906003)(6666004)(316002)(36756003)(16576012)(5660300002)(6486002)(31686004)(6916009)(31696002)(66556008)(86362001)(2906002)(53546011)(52116002)(186003)(16526019)(66476007)(8676002)(66946007)(4326008)(2616005)(956004)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TnVibDdXTVhxOTVrS25ZdEJIekdDRys0M2dTK1pEcUJ4U0Z0RmNyd0F2RGc2?=
 =?utf-8?B?OVBqWUNXOEwwVGtvVTFCZCtCcXRaNVVTUW43ZHpyZTdwZHFOUTBYN3BvYnN0?=
 =?utf-8?B?VDFraUVKRXBpUi82Sng5RkdqVk1lWGpQcHhkTnRtUnZKb3phb0dyRThMOS92?=
 =?utf-8?B?cjl0dk5nd3FyaXdsRDBJTStldXJmaElCVldBUzFkRXJ0bm81b2lQdE81MURn?=
 =?utf-8?B?UUljcXFuZ0U3RDI1dFhaSTI4R1pBY0o1OVlFVzFpTnE3Q0lITzRYbkhxbjJs?=
 =?utf-8?B?VWtCM0hEMStIZmtFOE9vYjdBQU9hTlltaytyaFpkVnFVYmc5RmFxMkJUWCtr?=
 =?utf-8?B?aUJRS2VzMkVpdHlmTzRSRFROWmVZaFdQYzBYbWpxMmVmT2Q2L1FaWUROTjBm?=
 =?utf-8?B?SVRTYStDQnBxdDQrRzVjZElxeDQ4L2UyYWZ4RHdiWXh4akZnbGdQeE5nRzVx?=
 =?utf-8?B?QWVGOTc4eFJULzltZzN4VVJTNmVQcVM0SGRsT0p2UDBEREx5TmpCWVZ1dkQr?=
 =?utf-8?B?T3NldnNzdnVJZzVwRG5ZajA4dlZPUmxmcjBUZjA5Tzlrd2ZFakV3RU8xUmZm?=
 =?utf-8?B?VWhlNVdoSnhPK2d2eUVIRGI0RTlCWTJtTkZxaU51bmJVUFd3RnFCVW43Ly9F?=
 =?utf-8?B?aE5kUmo3d0drTEpqL2swZmZRbzlVQ2NkdG9wT25xUzVBeEdESTJhQkt4bXZW?=
 =?utf-8?B?cmc1L2paaVRNRnVZcjdSSnlNRlErdG9RdWM1VUZYRWNOSHFxVS9wejhjM2xL?=
 =?utf-8?B?MkVtSGcwQnVJT1dwR2ZKaWl3VEQwakJ6azR3T05NN2NpSkFWTVk5Vm45VmNr?=
 =?utf-8?B?TW15TExKTXJDdDRmYkhWNk5ubndSY2xxMUxHVGtTenJ1cWlBRXA0NHViclhq?=
 =?utf-8?B?Uk1GOVBOcTByRXlqdFJPTkFZVk5kVWdtcWlrOTJzdWhtbXVFSmo0VjZJc0sy?=
 =?utf-8?B?U0FmV0QwRUFRN2dNa0RudTdTWlRsYTlxVHZLWGVDU3MwTGU0dU9LdTBQNXg4?=
 =?utf-8?B?MUJHRU9aLzJnNEFnSE55d05YNDl2b3ppVEF3b0NZUGxsUTlSRFAzc0dFYTh5?=
 =?utf-8?B?ekJFd3ZaM1AzbEpjclhpdDlLR2lGVWtPU0lKd2pSSHZnYWpUWExPLzJuTm8x?=
 =?utf-8?B?NnZrRkZycWc3T0ZFSjV1aFRXT1FxL0ZFVUZZem0rbTA0OGxldDV5REJMaFo0?=
 =?utf-8?B?ZWhCQW5RRjQ5YXdkRVEwU2FRQWNUZ1lMZi9SeEduNURNTTZ0RGZBb2gzY0Nl?=
 =?utf-8?B?TWV5cGFCTVdaL2hTWTJVOWY0RFVvVEpTQ2NNdkluK1IzWVBLMWhmb2xDbmdS?=
 =?utf-8?B?TVhYcVVxdjRrUmxSTnk2NGR2QkZBRTRoUWNLWUFYRDd2UEppMUxXbzBRQVZo?=
 =?utf-8?B?S2E1MXh5VnZVYWhIWE9YQmRBM0JJS01sWkxsMVVqdUEvdjc3N1ZMenlIZEZk?=
 =?utf-8?B?dTljb09mMEF4ai9Na0V4NGpXMEFwUms5N2FFSUxFZ3VabXJvcU1RNGNjOWlm?=
 =?utf-8?B?clFQQUVjcDNqcVVKaURGUGxReEx4SktLQUNTTW0wdXNidk5vUmpxcUxZUGUx?=
 =?utf-8?B?UTJQKzJSak8xYkNNRXJoeHFBUWtJYk0vOW9ZbSt6ZlM4aGpvNlJHK2pzR0Zr?=
 =?utf-8?B?ZFpjUjBtTW1tQ01od05WYmVDaHNaVkpjV1p4WWxJN0ZtOTF2T2JXeW1UMnRF?=
 =?utf-8?B?ME0ybUJXQzR2VTdvRWxFMUZRclhPWGs1YWpJOEUvQlhMbzBPODVBTU80eG9x?=
 =?utf-8?Q?hJiZ2jYswNWxxLmNR3ueg0+BoJYgibtxBTixqxs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dda252c-b28d-4625-2974-08d8f6fcb2d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 00:00:46.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R44qptEf5R549Le+0vyMj4L/GShkFhY98ekMDFGf1wUvA1Do4yuQfbDRADc29kER90QcMC8MoZ02unpxx8hVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5455
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9943 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030171
X-Proofpoint-GUID: 8yjRCVqLLGlQ1h1tpZGp2yZzJeBiVpAz
X-Proofpoint-ORIG-GUID: 8yjRCVqLLGlQ1h1tpZGp2yZzJeBiVpAz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9943 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 10:59 PM, Muchun Song wrote:
> On Sat, Apr 3, 2021 at 4:56 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 4/2/21 5:47 AM, Muchun Song wrote:
>>> On Wed, Mar 31, 2021 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>
>>>> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
>>>> non-task context") was added to address the issue of free_huge_page
>>>> being called from irq context.  That commit hands off free_huge_page
>>>> processing to a workqueue if !in_task.  However, this doesn't cover
>>>> all the cases as pointed out by 0day bot lockdep report [1].
>>>>
>>>> :  Possible interrupt unsafe locking scenario:
>>>> :
>>>> :        CPU0                    CPU1
>>>> :        ----                    ----
>>>> :   lock(hugetlb_lock);
>>>> :                                local_irq_disable();
>>>> :                                lock(slock-AF_INET);
>>>> :                                lock(hugetlb_lock);
>>>> :   <Interrupt>
>>>> :     lock(slock-AF_INET);
>>>>
>>>> Shakeel has later explained that this is very likely TCP TX zerocopy
>>>> from hugetlb pages scenario when the networking code drops a last
>>>> reference to hugetlb page while having IRQ disabled. Hugetlb freeing
>>>> path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
>>>> chain can lead to a deadlock.
>>>>
>>>> This commit addresses the issue by doing the following:
>>>> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>>>>   changing spin_*lock calls to spin_*lock_irq* calls.
>>>> - Make subpool lock irq safe in a similar manner.
>>>> - Revert the !in_task check and workqueue handoff.
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
>>>>
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>
>>> Hi Mike,
>>>
>>> Today I pulled the newest code (next-20210401). I found that
>>> alloc_and_dissolve_huge_page is not updated. In this function,
>>> hugetlb_lock is still non-irq safe. Maybe you or Oscar need
>>> to fix.
>>>
>>> Thanks.
>>
>> Thank you Muchun,
>>
>> Oscar's changes were not in Andrew's tree when I started on this series
>> and I failed to notice their inclusion.  In addition,
>> isolate_or_dissolve_huge_page also needs updating as well as a change in
>> set_max_huge_pages that was omitted while rebasing.
>>
>> Andrew, the following patch addresses those missing changes.  Ideally,
>> the changes should be combined/included in this patch.  If you want me
>> to sent another version of this patch or another series, let me know.
>>
>> From 450593eb3cea895f499ddc343c22424c552ea502 Mon Sep 17 00:00:00 2001
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Fri, 2 Apr 2021 13:18:13 -0700
>> Subject: [PATCH] hugetlb: fix irq locking omissions
>>
>> The pach "hugetlb: make free_huge_page irq safe" changed spin_*lock
>> calls to spin_*lock_irq* calls.  However, it missed several places
>> in the file hugetlb.c.  Add the overlooked changes.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Thanks MIke. But there are still some places that need
> improvement. See below.
> 

Correct.  My apologies again for not fully taking into account the new
code from Oscar's series when working on this.

>> ---
>>  mm/hugetlb.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index c22111f3da20..a6bfc6bcbc81 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2284,7 +2284,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>          */
>>         page_ref_dec(new_page);
>>  retry:
>> -       spin_lock(&hugetlb_lock);
>> +       spin_lock_irq(&hugetlb_lock);
>>         if (!PageHuge(old_page)) {
>>                 /*
>>                  * Freed from under us. Drop new_page too.
>> @@ -2297,7 +2297,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>                  * Fail with -EBUSY if not possible.
>>                  */
>>                 update_and_free_page(h, new_page);
> 
> Now update_and_free_page can be called without holding
> hugetlb_lock. We can move it out of hugetlb_lock. In this
> function, there are 3 places which call update_and_free_page().
> We can move all of them out of hugetlb_lock. Right?

We will need to do more than that.
The call to update_and_free_page in alloc_and_dissolve_huge_page
assumes old functionality.  i.e. It assumes h->nr_huge_pages will be
decremented in update_and_free_page.  This is no longer the case.

This will need to be fixed in patch 4 of my series which changes the
functionality of update_and_free_page.  I'm afraid a change there will
end up requiring changes in subsequent patches due to context.

I will have an update on Monday.
-- 
Mike Kravetz
