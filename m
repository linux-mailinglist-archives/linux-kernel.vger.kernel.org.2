Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC043ECA88
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhHOSSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 14:18:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51394 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhHOSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 14:18:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17FIHINJ028754;
        Sun, 15 Aug 2021 18:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nuQZ+jIUIuFnbdJQgAoHKFFsH1Ov/Yaiuam62YzfxkI=;
 b=djAe7oN9Ppiuk6x9SzXq47ONSrdoz47dxhDj++xfif98mZeZCpTFE3BvCzW7UNIeNszk
 s5V802Usak8/mvr0q5iNqRIgHNRz2WMB7rnrwCUrEWiBONOeHGGlwliNEUlX8/CqHenc
 0M2Ng0qiNQEb6PZkkcCn7gdhgDqgfKRh2OtnhM3AhE3u4vfCfLDgImR63/5+4c/Y1/JM
 oydLsMeAvk4fAjE0wDhtGDAHfL6O5vR2A9nV1JTTFzBX+7+gSaEvZ9HRnwnLVtMa0HZU
 uCMujZgygXHnGLMts5o9zxe+bzcgEuxZUPVamIeXkIgyoxO+YUbB9HJgAJ9jEA+XmsPL xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nuQZ+jIUIuFnbdJQgAoHKFFsH1Ov/Yaiuam62YzfxkI=;
 b=rUamoNJ0/TaqKZ/Bk1b7T2Cy3mvXsfYsEXApp2S1hj3KF6xGYkxtvsH4Q6AJ4EKThJ4q
 GOsMdk0xaTnUVihnX8KImJ50Ci8nw/QaU1L9wdO/GFcNFpBeFAY9W+vwZZnHaYbgJSX6
 Hgoa6LflWofLoF0d/7o/fLK1wT4jkROmWhgXC0tBtbM1gKTN15tXaGpPo8QRl2jDjE3t
 YeSZkkheH6nruextCU4r5MTsTWE/lAYco9rhBE//OpQxtxZZvZdNaLWA01EjC5+15Vt8
 WQsmPBFy85JHka7k+Nm6WLRsplv2X3/XQfCWtV7kKOyuq4h5TtU7cnWiYOISyLjJq7Vk tQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af3kxrb57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Aug 2021 18:17:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17FIElT2119136;
        Sun, 15 Aug 2021 18:17:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3ae3vcky8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Aug 2021 18:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL8KFZNNxtv3lsvSWl37ac/3rjzPE7ik9pVEgoY5kUnVIAfm47AdMXYpCYm+WCZlOOfkkoitUacn4LGupq4H9TXoYUpGLmsAhcJAUON293wbOly5zKxuMYKobvrRyRWAXgCzH6pEA3zDxKvscAAq5cD4DAMLtkPsc5Z7YDn7B9/SZJ+Def6RQYw1L2E0VTH49SO3d6q7N3Wh38ShOgvA6yGWqRIMDaP+dhJty0fDGgsmclwZX/iFoqnhnxcvxiib7yuKSG4Zv9KxRuSgHTEQMTK4voX57mOSj2tGRifd5L0qSLH4MuRUOT2J9MrvkZOGg/b3Xt+YCijgiDEiSQKehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuQZ+jIUIuFnbdJQgAoHKFFsH1Ov/Yaiuam62YzfxkI=;
 b=mtgbomn9HVUtPRi/r5OOTavpueWbkAJzyEVG/OcXh9oYsnqp6gLCF4ajGdh8yFTUDszoOb67vi6yIZTaAqO5FVNdm+mX42aWoVeaHWBwzJC14gDH4hbRddj0YojqqiBHpm3G5I9Z3RIrd2HeRQ5Mj4EGYOfMiX81Fat2NAzGshpx0ouk7kXU8Lliy/vZRUEoTsqU3qe2ANDDPp2YWUeflN+KHBu11gFcM76IGPfQSv+HQQgjkNUUgid5Z11aqXfoylCuYXzNNQl5Y2qreTXEEo67PK6RxNJmBkcxYrPaWwBQH9gEImMJT5IeBHxs2KFZpjE4aVVYppRmyQt26gjEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuQZ+jIUIuFnbdJQgAoHKFFsH1Ov/Yaiuam62YzfxkI=;
 b=tpscMar7SbDiI84KFFKxPzGN/yVJabxE/vc6jkl9gDi+e2kDCuJqwW0C5iT/+7WH6sjSQV9a0tAM/rZ0v5/9fEEsqwQiBzbTcMtKKHNEGG2hE6IuDnmMP3CTZZehuJ1qWkA9MFUE0FbSZyxbz4rphuOmPvyC36bUXsLELt+wrd0=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2614.namprd10.prod.outlook.com (2603:10b6:a02:b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Sun, 15 Aug
 2021 18:17:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.022; Sun, 15 Aug 2021
 18:17:10 +0000
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 alloc_huge_page
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000fbad4305c982f836@google.com>
 <20210814150652.c61e3c09a58222260fa2d02d@linux-foundation.org>
 <YRhQwOvZNBRZqk9O@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5810d827-c050-52b6-1b98-8deb99ceda9c@oracle.com>
Date:   Sun, 15 Aug 2021 11:17:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YRhQwOvZNBRZqk9O@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0038.namprd12.prod.outlook.com
 (2603:10b6:301:2::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR12CA0038.namprd12.prod.outlook.com (2603:10b6:301:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Sun, 15 Aug 2021 18:17:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f332c34-ec9e-4444-88c8-08d96018e5f9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26145E6B3FEE533E44FBB285E2FC9@BYAPR10MB2614.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLxIe8IcijU2mz2GdrtBJueqacfP2bfp2ujxAPMG3uWs9Wi9eIZ+Wh6pj8rFulgUrpPg6MkWaK00F8OKsMPf643NnXCed3N1UWpo8TuC3nioTvbtNkPqM8AlVVGQySuPlG4wFHyfWwaiq1tnNT92Na/MiXfBGXYgH2w2E/cYSRh8sNsrpQSa88aP1NK3NKQDFT4xi53/KhI0g1/EX2g8lgWRHIcGnJ96OHkD+QgbXZmgEhVkFpyQUY/Parr8w0rbi+M9oPPSM+wZbKcJ3QUbrGp3sVpFjnig3OK2yQYlNc75formFoETeofiMESK5kbhyZ6blXEIBwgVkbh4KazO1N/Uv9ultKbUjlwGIXGlJCBGbjDG+UcMS10Q+6pwuX7GctklGKvJOW32ydAkD78agg+8nx1Yp+jQpOFMOH5j2Vd9aQhWTdHx2H3YpJFKZMNhe/4A7qx3YLRxLnNdh2IltBrXmIEWPhZykeTf0WnK49rsYMy+t8EZ0KCCS7KVX7JzQC5acMwT474By1UkaAbXFqIJE/B6YUb6IvCGPub+w4M8SeTjQN+efa1Iz/qfKriD4mz2PcBk0G+vLOHsl1GEix559s95iVxQEKe8RkkSwLgKla5kmbZHxZIed3/S4isK4IO1R5RTFep8+mMswc0F3NNSpVK/pyiGHnJfnEVfAnGUHwD3/HXUasfarosnuNZUNH9fntCvWCP7ZaLHG5lKI5k1LPxhIk7Gp7G/cy9RRp9SLHuFcRiP1oqMwTADQbe04u8W+v/Z9yDMno6/N3/eHJFuatkPaoymhXb4LPAdW4rEYPUEkv9e5nO/gIFhxACaz8iDt3Pm7oKaQcJ5Z4MNL/6k2BJM5G59a9N4m4c1m6Th1hRKaK9SMeWpdqtbiC/w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(5660300002)(316002)(44832011)(2906002)(956004)(66946007)(2616005)(16576012)(52116002)(966005)(4326008)(36756003)(4744005)(38100700002)(38350700002)(186003)(31686004)(8936002)(53546011)(478600001)(8676002)(31696002)(6666004)(110136005)(66476007)(66556008)(6486002)(83380400001)(86362001)(26005)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVWYkdKeHZua1MrRTNZNjRVakl0M3M1S1hHb1hiU2RUOVh4RmVGSWJnbVkr?=
 =?utf-8?B?S0krYVlKSUtjSXFyZVBFMXpYSnhMQ3o5QmlYUFVOMnpwZGFyMXM3SFlXdnFm?=
 =?utf-8?B?NE5EdGlIa2haTGdhQVdZUXRScTZCRnNMUW1VK1kxV09JWHI2b3BrdERxSnBS?=
 =?utf-8?B?cUpSdEt2VUhjaEdlMFVicUI2dThvUnJmM0NDMUxROFd0dGdaQnlicjduSm5t?=
 =?utf-8?B?Q2RicjBObHMxNzh5ZmRkUGs3UGxOL3g3WmFNSE93dkhpQjNqWTVVV21Rbkxv?=
 =?utf-8?B?UFVWMkVoSC8zbFoxa3R5OERVeUlsejk5MXFEMFpqVy96dTdkRkdiKys4Wkgx?=
 =?utf-8?B?Q0hWQTRSM3pBL1VXVkFSMTJDSFovMGFBbHRTN0FuWThxR3VrMzllckFRSVNK?=
 =?utf-8?B?U25qQ1NlZFY5S1hTd1ZyU3pueHZ3MmtEOElUU1ZGYUkyMDVXWW9DYW1mTmdW?=
 =?utf-8?B?SlFleHFkcHFQN1ZFK3FJNS84NmRwb0hIV0haQkRPcmhVRnd6M1hBK0txZXFk?=
 =?utf-8?B?SEtoMXc1NGJLYmVMZStIaURsaFgxMEdzQ2svQzZBcDlxUGZIcUsremg4WFVI?=
 =?utf-8?B?clpCSC9aTERFNmRIMUVod3pVdStlbVFQTVRkd2JTOVU3bjZTRVBNRkRnSUlE?=
 =?utf-8?B?QlA1Z3JqL3VLUVZRTjVGZEwxcXpoWjNJazB5WG90R3R2OGdUbkVhUkQ2S3VD?=
 =?utf-8?B?SjBzdmxYWFRSNEFzY0gxK1BodUpnNlRkZTRNakkwZm5xQlNkQVVFdWlDRTE4?=
 =?utf-8?B?NjZxMmlFbEpJNGxrM0FmTXZpbFBGUTdzSmp3c1BPakNub2pwUmdWUjVuTWpC?=
 =?utf-8?B?L2pSWVBGb21kNEUxMnFXWXU1RUVFVm4yS2R4djFkaTBCOFF1eEgwSE03dGlB?=
 =?utf-8?B?bFREL2hMcnlGRmU1VVdnME9zT1JLdk9hVWZ4YnV4bXZaTm1yaXJkZU1KK2NI?=
 =?utf-8?B?SU9uQzhPS05pL3FwL1p6T2oyakNIM1JzQVF1bVBuamE0ZkxhbDRrOE9rK2Z1?=
 =?utf-8?B?ejRCQ05BTVhmVk81KzhCVHA1TzJxMG5kNFRkb3NtM2sxaWJNZ3RkWGlrWTk2?=
 =?utf-8?B?MnpqTHJ2dDVyQ2J4YUhjNXhaVGVWUTlkbGsxTS8rTkkvQitKeUxWTkVuTlc1?=
 =?utf-8?B?UVNyWDhYMmVxNnV1aWdTaDhKV3Ezaks2c0dlS09kWXlNT3AxbFA0NGo2dUJy?=
 =?utf-8?B?Rm81TzhoRHM1T3greEZTUkxEWm1Sbzc5Yk5hd3g3dzAzalVJanNFeTBsdjNj?=
 =?utf-8?B?eUpwZjN1NlRhdzJySFYrRWtYeW5GYzBQYUxzb0s2M0MvMDNxaVQzRkJiTzRC?=
 =?utf-8?B?dG5mdnFxOEFmNlhKcmQ1Y0ZuNEtYVDRBTmsreUx2VTg2NTZESzk2TlIzTFNQ?=
 =?utf-8?B?ZWNvdTZKejF0UStwYzBVL3lEcWJ3UDczNlR2WG5PcE1yMUcxWHp1Znl4SFd5?=
 =?utf-8?B?Vm5kQTUwaWNFQVFjK1I4Mzk4RENIcnV0TTFhSFhsbTNtZlFRZ0VNWlptRzNL?=
 =?utf-8?B?ZmRxWGpYeS9DVlhoN1ZuVUJsUnV2UEsxbG9pSThwc24ya09SWm10NGtKZVhB?=
 =?utf-8?B?SWMxUmxjOHRDZ1FFaWJxYTRMa3V4Si9FRVRac0dJN1kwQ2NZbXcxeVpJUytv?=
 =?utf-8?B?aWFwWmU0Q1E5RDM4alMzakZQc3hkbzF3RThVU3ZSb2JPMVFnbC9KZTRURDlZ?=
 =?utf-8?B?RmxWZFVpU0tSN2NPU3kxUXBmeHhpejdjRTBCUUFPa2hwblpleW5sRmJVT01V?=
 =?utf-8?Q?XlsJQn+wyA4Dk2g01N6AVZaff2s7Mgu3sEHwGJh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f332c34-ec9e-4444-88c8-08d96018e5f9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2021 18:17:10.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVqrnTkuOzVJMfl1Fi260JfnfzwnxWa+SnnPFXbPZ589J4a2IexIkilvvHoONoOxF7JWcPfW8RCyQ3ANs30S4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2614
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108150126
X-Proofpoint-GUID: l4rqz9DOhV5ephV6KOtNeG9jh6BU9zDv
X-Proofpoint-ORIG-GUID: l4rqz9DOhV5ephV6KOtNeG9jh6BU9zDv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/21 4:24 PM, Matthew Wilcox wrote:
> On Sat, Aug 14, 2021 at 03:06:52PM -0700, Andrew Morton wrote:
>> On Sat, 14 Aug 2021 04:07:23 -0700 syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com> wrote:
>>> HEAD commit:    92d00774360d Add linux-next specific files for 20210810
>>> RIP: 0010:__list_add include/linux/list.h:71 [inline]
>>> RIP: 0010:list_add include/linux/list.h:86 [inline]
>>> RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821
>>
>> That appears to be
>>
>> 		list_add(&page->lru, &h->hugepage_activelist);
>>
>> I'm suspecting Mike's surplus page changes?
> 
> Is this not the same as
> https://lore.kernel.org/linux-mm/846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com/
> which is already patched in your tree?

Yes, I believe it is the same, and already fixed.  RCX: fffffffffffffffc
makes me 99.9% confident.

I can verify on Monday.
-- 
Mike Kravetz
