Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225123EDBE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhHPRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:01:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31236 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhHPRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:01:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GGpuYJ019582;
        Mon, 16 Aug 2021 17:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CHQy5tEym2dje+KTgJEkQHStpWdIsh2YQnwloaZ11+Y=;
 b=dee33HX3+RnK8XoYdHC/N943chaUCJ5EFzslt/gJ1XYsyPGbDSBT8U2yiIA5wCHYKzmp
 zOQLU0xwV24mp0JLh/Rz0dnp19XlTeBvCIAzuOCcKZAi4/BGtWUEETWmSYmyZcU3GloV
 FjsNtmK8IIIiE2TJx6nTA0SkQRiDI8yFl1hg80iV+iLOsdZSiCWjZA+eiy/sD305xaGp
 e4ChqrKNiYEOGBZ2dbqyDcpu7lGZdjFL/eCvgwvbYKZiR6lhgwElEsL1LR28bierhv+G
 ilmNMG6LzOodk8roVJQlYpY4RVk/E8zrtnv7Ux61KwaUktO869IxQ2ATH3/IEBedEIy2 pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CHQy5tEym2dje+KTgJEkQHStpWdIsh2YQnwloaZ11+Y=;
 b=Ixjxc1w1Fm8I1IuFfrdreTKkPOvBu2z5Epn8k3UeE7sEb4USWHq2eaWMk2yaxb5WwovF
 o6M8U4bSZTI7+z9H88ShPglLJ6v2kLmJZjP+OA/zFMlt9cMggZq7PG2y8t0iF5pePRMd
 HOQlIk9YCdgMRgPNpy/rs2YgAD4BurQ0fnriIpiajCZ3p+CKTSqqddCicDHEVjHgKAKx
 GrYS03eNdqY3Sv3HOIZVrgXXoGK824ckevQey/Byw2zpY60d+Aaa10w1hvFbKbBFo/g7
 cH1+YtqIBS9xJOIKqMQow/xnxnK7FOrp8m25kbWvvY65X5eUaKGy0nojCL7vFS9C0fBe Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd1ypc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 17:01:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GH0lPj178524;
        Mon, 16 Aug 2021 17:01:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3ae5n615mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 17:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj+DJVy1hiKeO+VyuVBuz06JBvBrbHmdCMkfe4P6lU533WUczgv4YVkHgfHXrTBJElYXbB6t45Y9rTy1Tcx6+a8OG1926oKOmWOGeLcoDmf8WROrwwHGqqndaAHtYrB+lbM3Z3GFM8dfqAHS1zguToyGatHBeaFxvmVmtlBvdmaX4ojQ+TXqH64z3Gsb5XyXoMe23SvwRsHLmLsyuBHh8pgcIpUmxqJ5TbZYu9zVvFJA5/tM2P6psOE2H3A1B4TGL9xPM2aC4By+ye4jmUxGJuI0biDkibTvHh7ItJgmFeYIWfGhoFdsWlOCL2w99CjQ+9XEewjo+Wn1Yi3rcIk2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHQy5tEym2dje+KTgJEkQHStpWdIsh2YQnwloaZ11+Y=;
 b=HeTqPPjW2vxMq0LjFj9pTTtfhRomt6wLOJX1U/2RC5B1iwuOalUOUMHYJbU5RH1pnPXmcQS6oCS0TD+YMa6Gn130L7PhFalVmwePGqUfeg4nhWpWd4L4dE7GKIFV1H27a4J3RmvTsTETPtY56LxYXt3/EZ9phl8F4xty4nwqpGRUVgX8Z2jzqGq8kB9bwoiwnn/Mb6fsB6bzr1SiDPxzBDAJPD/FTpkox9py9+8jQ09HJLm26YtGZoj4ysdq5HOAhEDrvzkCeXGpHTzmNfDLD/ejKEyLhqmUzN7IEeXct6gLvE+KLSNP5M/fBxflpiRjq9K241kV2zI0jVW1Vlm99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHQy5tEym2dje+KTgJEkQHStpWdIsh2YQnwloaZ11+Y=;
 b=BT3jQRct82/VALI6fh0Ai4hncfKamoWEZ8eI4fUi03ZRSF4JmTDcJeQfTQIV852v7sjJvnRQ7agwFeuSAvxhZMBQKg0brYWLkfYLnJHzRM8UJG5PuxMcmc2gNngNhTXnVIFnimkI4fX9v0oP1/HRy5KU9pWkFwfbY9Wo3OiwdIg=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 17:00:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 17:00:38 +0000
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 alloc_huge_page
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000fbad4305c982f836@google.com>
 <20210814150652.c61e3c09a58222260fa2d02d@linux-foundation.org>
 <YRhQwOvZNBRZqk9O@casper.infradead.org>
 <5810d827-c050-52b6-1b98-8deb99ceda9c@oracle.com>
 <CACT4Y+aEo5qWg0CmjUQsi3UXwmiCwmK93XUnt+DfRUtD2YLTmg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0dab09ed-2277-bd7e-42d1-1fee3a3e7947@oracle.com>
Date:   Mon, 16 Aug 2021 10:00:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CACT4Y+aEo5qWg0CmjUQsi3UXwmiCwmK93XUnt+DfRUtD2YLTmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Mon, 16 Aug 2021 17:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc82218-8bbe-4036-d03c-08d960d75f30
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-Microsoft-Antispam-PRVS: <BY5PR10MB414833329B37F89A05E8C716E2FD9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vm1eCHajPPMebXxUmHoWzIL6k/Rccacn1xG/fu9LSwvi5MvIJ/kpzS5+JpJ6QGz1HMNoX7YfI06t4n1lscjJaNsnQwmoktqcM42c+l2wROJZR2ijeasduB6j1KCbgF/4GVK+WhN9U6DzDESi/WzdEc+GAISvMWC1xCm22qWoIyA/WMe7m9iAwoAyk/6iU3ISp4W1xy55tTdEjk5854ChobESSroh0+imCv1ue2J1zMvkcrftSFzYFwhu94gxzlVY5tKlNrkTSokdym9Jiibt2Ojlhwsn65y2iXsGpQjB1fKDI+tAE32mUfwTFrh1smfxE7sOuTx63Co30vJlm8zqEYa6Lf5vhid/7T7hL7rj9Wr3mhX58r5mb9SYvN+Q+Rw6H5a/adxJgQ3lobwQ+qqJXiP2Bak2sEMkVXtsUPWH4ft4mNFPOrRdRPOS4y6KkhlT4aQ9AvjDtyYzCkfuMa+70WS8kXsGi3SVFx6/aOAYE4q6eQoEkXWxGbpLCm8ZXt9QOjA72QRXpjqpGgBWghu/3Vo0WrDRL/FjeXLHPLYK5jQM9xmDE7B+arX9OOXYSBumhg3HVUl+EsKBdCbc7pBvipq3ZnxY1wkLt5YTB5O8MxFtOaFDzzjq8yWzhwxqJg39HNoR+lIgqgfSgJWyOidH9VcyaOSbfkiIt38kqbWEo1UaQvAvx6OY4ZBRuLOvxD+0s/WJFppeEYCW6WV+CW8xg938tf3BPn8ZtoOpQX1lJDL/ec5D36pweWPWy+IU6bwD+XQcyO0R+qTuTqgaUBmd2kJmHgBOfmPEh6UMNU+mlFBiwey3exJLWjz2HOCtud8psm9qtUZj2UJrPkWYV/VlU76CJ0hDAzPNXcuo3UhRROgvT9PWbi+WoZWnJPRRIAe9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(53546011)(5660300002)(31696002)(83380400001)(956004)(36756003)(31686004)(52116002)(2616005)(44832011)(316002)(16576012)(2906002)(6916009)(186003)(4326008)(66556008)(66476007)(966005)(26005)(6486002)(38350700002)(478600001)(86362001)(38100700002)(66946007)(8936002)(8676002)(54906003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnBkdGM2M1o3RXRqVncxRkpKVWllZkw1S3RCb003eFlWWXJGVXlqbnhDNU9t?=
 =?utf-8?B?Q3o1aHMwUDhIZXNhSFdoelBmS0M0azF0ZUU5dXdBQzYrTEl3aUJjTXJLYngv?=
 =?utf-8?B?TDNSU2tEQ09QMjJIRUlyMVUrNFZJeXlodFNvVmZUOVlGMFViQ0daV3lnNEoy?=
 =?utf-8?B?L2Qrc1VnUGY4c3pJSFROQWJ3ZEZVTzBhYzNaS2N0OHNTTko1THhaOElJMGlM?=
 =?utf-8?B?V0svN09WUU1NODY2bktRTjVUUXprd1ZoU3MxcWtiWmFxYWFnTjlMR2piY3Mw?=
 =?utf-8?B?cHhvdnVtL1RkVHYzM3h6b0s0cFRNSE13ZFRyc0RkZGJHRllVR2ZHandvdkFz?=
 =?utf-8?B?aTVTeWxYSEFsL083NWUzTU13MnJXRXFaQzJPUDJFNWM5QkhlYkxDYTR0dVo5?=
 =?utf-8?B?akx3TW9LVHRBZFRLR1dnYkdRbGxDbWc2cnQ4eno3anh6ekdpR2Q2V3pTZE00?=
 =?utf-8?B?NzZyOW15OTB4cEJZY24wbldudExGemFtaGo0MWp6TWJheEhBYkZzY0VERGRL?=
 =?utf-8?B?ZmpuUmtLQ0FIRUJQdjAwNHZLZUF2M01BaC9ZUkdTdFBhYTNTWU9YL3NReGNw?=
 =?utf-8?B?U0tDbThqRFU2TFZhRHZQenFLUEhMU0JRUVpCYmJjZkdYYUUvWGNwY1MwTGZ3?=
 =?utf-8?B?enIrdFVZaGx1bFBsSFpVWTB0Sk1FZWxLZVduNksvYUdwT2lMMmdoU2tDdkMv?=
 =?utf-8?B?MmhvTHlsK2owd2p5NzU0Y21obStCUE5QQ3VCazgrYUtzYlo1YTAzbUxrNUpL?=
 =?utf-8?B?Y1FtM2RNY0tuUXZVNkpwOGRURlN5RFd5L0tCN0RraElkcEhMMFVWWmMwRlBF?=
 =?utf-8?B?dDh3TUsyeDdhYVFMdDlnMnlRQ3hMQ1ZleGZVRVVJRVQyMGxubFZwbit2RXJq?=
 =?utf-8?B?dXgvZmJ5aUU3TDd1RkR6eUJiOW42TzhYWktkVjdqU1RXbCtIL0x0QmlBM1c3?=
 =?utf-8?B?VTJOV0RDSTdnVDN6bXlqSHA3Slk5N1dnT1YwOHZQYnhXd0NSUW9zdmRiM2d6?=
 =?utf-8?B?bzF2eHdpa2REUy9uVlpXamJnVFB3VjVObE1FajFUSUo2ak5WZFAxL2JIRmM1?=
 =?utf-8?B?cjlZS1lNZ3Fza2Q1cE1rWXFhMGZka1hlT3o2UHlTcmgxZzJUT3FyUEtwbnpN?=
 =?utf-8?B?cE9MZkpoNlVBZ3hRbjVnOXZYVm16R1l3aEJhb2RiaGZON3VpRVJ5eEtocDhM?=
 =?utf-8?B?SXdMZWZDRzJuaG5ZSWFnZkM5ZlJ0UExBOXRVcEpja0UxbHBoMzZKemR4bCtm?=
 =?utf-8?B?ZFQyOVZudW1ZTUVqOGdvWERPSGxPa3RLeFRkdFZZc3FFQkVCVWNOejZRcnJN?=
 =?utf-8?B?UjJiZHlsWTJ0UlBYdFRmUSs3dzAzRGVmdEFISzBmeDd5RllSVmx4dDdEMjNN?=
 =?utf-8?B?K3NXVXBtUW5KWXA1SXo2VmgrYW4zeGcxdkk3c3R3bkpaS2xBcmZNanpZZytD?=
 =?utf-8?B?d01JcWUxdTN5ZVBtTFdzT0hHZWNZQ20zVFFGWDVsY0tjMGI1VDdtN2VYWDJY?=
 =?utf-8?B?Q2pUU3hEckNGb1FuaHlmelNuaEZRS1Uxb0pnNWpTckZQK2xKcmkxSkkweUha?=
 =?utf-8?B?R3VZVUo4cVdmK2M4bGZvWkdXc3hjaWl6K1ljZzJFZHlqbzRWck5qRVMxUi9W?=
 =?utf-8?B?SHVQZHpuNGZFeFdJdzRjMjlJSjNIeXpaOUZYTG95TUdzU0RsYnpuQ1BmOEJk?=
 =?utf-8?B?emNuQ0xIUDU3Y2wwbFN1cHFUbGZ0TDlaWFJZRHZhb0JoSVkzd0xqbUdSWUEv?=
 =?utf-8?Q?FCyCsAmfScPH/OQLLY6H6fETI9mFpxQ4W1sqgw/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc82218-8bbe-4036-d03c-08d960d75f30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 17:00:38.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdRQ4C7WdasouGpA57dICvSQmld2fmkLuwMg085qSwXuDRiyVqFLn865X9/KqrGJvcsgzkJMgUu44d4APe2Gqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160108
X-Proofpoint-ORIG-GUID: TWFbgBKtbEj6E6iOfcCSH6gSHzxA6J2v
X-Proofpoint-GUID: TWFbgBKtbEj6E6iOfcCSH6gSHzxA6J2v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 12:47 AM, Dmitry Vyukov wrote:
> On Sun, 15 Aug 2021 at 20:17, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 8/14/21 4:24 PM, Matthew Wilcox wrote:
>>> On Sat, Aug 14, 2021 at 03:06:52PM -0700, Andrew Morton wrote:
>>>> On Sat, 14 Aug 2021 04:07:23 -0700 syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com> wrote:
>>>>> HEAD commit:    92d00774360d Add linux-next specific files for 20210810
>>>>> RIP: 0010:__list_add include/linux/list.h:71 [inline]
>>>>> RIP: 0010:list_add include/linux/list.h:86 [inline]
>>>>> RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821
>>>>
>>>> That appears to be
>>>>
>>>>              list_add(&page->lru, &h->hugepage_activelist);
>>>>
>>>> I'm suspecting Mike's surplus page changes?
>>>
>>> Is this not the same as
>>> https://lore.kernel.org/linux-mm/846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com/
>>> which is already patched in your tree?
>>
>> Yes, I believe it is the same, and already fixed.  RCX: fffffffffffffffc
>> makes me 99.9% confident.
> 
> Let's tell syzbot about the fix:
> 
> #syz fix:
> mm/hugetlb: Initialize page to NULL in alloc_buddy_huge_page_with_mpol()
> 

Thanks!

I verified and removed my .01% of doubt.
-- 
Mike Kravetz
