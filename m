Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C03CB0D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhGPCqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:46:44 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:42206 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233114AbhGPCqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:46:43 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16G2e7Us031344;
        Thu, 15 Jul 2021 19:43:30 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-0064b401.pphosted.com with ESMTP id 39tw2gr595-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 19:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fexGVGBnAjiTC+xDYzHUzA/Rdczr80PfjAgtbIg7ia0tOiEsUPfsgDzC1e4U7xBGYclzmzsImEuAjRbES0it3jpupbdQ5fb/O6HIY/RnHumCss8tBik5u/yGESHya1nuDJnqcRKIgWV4aaPU5vhCc1fOHlj9QX16CClZ/0WhBbKME3RgS6KaN8X7sATpmpcK8YEEtjwiZpawEsm4YTKIZiyea3hGdoxZuXx8MoSbcW1CG9vQ3ByGkAcsi/ZvPCMOokUuYMGRmGV4X+WpubyO64XecnBUsYw33nhv5E4oViTnTPwNGvh1PuH4lMk+OjnmU9hPCJdCtTcojBJoQ35f+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrbqNkT5ay8S+x3YTkU+L3xKSrIvBApHSLQJdZe06Fo=;
 b=HcJxB4VfIWp4zR47+WJ/RyjeOqyWZY5QWuBbowGC5XqE32kss0koL+LR+XO+K5JWyQkZNFrQlpEmCvMS51533UOaltv5n1WHyBg9SJMDdzpHkm/jM8GLLTxe99kdHTN31187L5FQ9l3pgjXWvGkhlqZKGOkRM//Ejoatt9CjGhGweZVCua0P0GI1xUbc1yv1p2hwAx5f40Vd9X6JdiSVlRXTChkuFNK9RMcZfZuiQzqBPlxGOyjJ8QGQMWWE1Amkyqp9pF3iDlmzsJKAUSW1PObnPV+o/k/SihEqHwhOarAtSab4DmvERYjoOwAVWkYzu1nkfRHLHNUqRGwt4F82qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrbqNkT5ay8S+x3YTkU+L3xKSrIvBApHSLQJdZe06Fo=;
 b=SmDl4DM9scGcPRsFZzp0eLHHx+qRRRg1trnZckHkhF0MbbZZmKwxdquO3lAVo/MMfpXKPDhAzCrloLofxBaNARPu+UIFl4pdRwbfMneVSQI7ES1r4+HBJMJMepoF+BGLTB4Zitb6Mkb+G3ghEJpy6SQFHffRqO9FPRHJJAkTnN0=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Fri, 16 Jul 2021 02:43:28 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f%9]) with mapi id 15.20.4331.023; Fri, 16 Jul 2021
 02:43:28 +0000
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xie Yongji <xieyongji@bytedance.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
 <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
 <e20c3d90-db24-7722-3f89-adadb83a9bf7@windriver.com>
 <c05b358b-1e96-c002-085c-b25e416e7be5@redhat.com>
 <97704aa6-46eb-2462-a4d9-2bf93144a5ac@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <ad686185-37d6-63c7-b222-49356be16d1a@windriver.com>
Date:   Fri, 16 Jul 2021 10:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <97704aa6-46eb-2462-a4d9-2bf93144a5ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To DM8PR11MB5637.namprd11.prod.outlook.com
 (2603:10b6:8:33::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR04CA0080.apcprd04.prod.outlook.com (2603:1096:202:15::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 02:43:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e697c4e6-cc40-4eae-72f5-08d948037d96
X-MS-TrafficTypeDiagnostic: DM8PR11MB5655:
X-Microsoft-Antispam-PRVS: <DM8PR11MB5655A8CFF0B82FBE99E615D38F119@DM8PR11MB5655.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: os1fUPdubaTwilnEZZ/21HjnjlVZ8OznMkeYC9xqVcdqol97wvMFducHtXS1rrQ18QTPh6usJG4EXFTEoI9xg4258xXpB3wPMbrUnEGwNH+YM1N3N02DLYBO+vIOTy/GqmYkGVtYdZ3ct2aXw4nUiFUlcCuU6VHXCNJZHrvZ4kdh7amPi85hEU4hAFehEyAjXMixoc5fuk9/YyQ7ZqseyJ+FCTocMiqgipIQvZOhhTA5xPinRXv9xAo659O85eZMrYA1gfN1+nU2+VJPqKdU37INvNQKb/eV6Ono6KbEAVCV1rchzQwD0z119D12OCw0r3zJHjHwBpNFTHvILP81eKA+u8p1NNmYAGWMxq6V4+m9cMAHNU/XOh3pWdE37lm1Q0bTrQdoy44fCNev8F62hIu8VVNUG+5n65GubqJlZ7yacz5x7ulPNMYo0Q26oCEgEg1VRRhEGWCISDmnCpO0iCQOQn5UMbVIuo0OIJVxExTDQjB7l2HNc7IFnjzqmGPI30dltcD0182++fF2eP/Pjk+fEFfDYZ0sQBJVHqYI8+6Gc/RuKTb8nNhKEYQSnT7ODN06zv+UXIDWnF1UheLn6b1hLoPcuuzuOGaJRjVOt124up/wbHg4opQIVtGjfV6Oy/fMu6DToft8gBe0EVpjrmNr0uaET8Glzc9TZxsVGMHdwXl02hIBfaihhQL0pdUOCaWJhSSO0+EufddltxI4jic3XmZjTgn5iqTfCCh4RZOVI0o5aH9MmgZIiQYbLLElJcpFalJdsry+aTbQ8dkfa0GispG9ghR5Yy20aFwqcMNyZHf8pKP+tByPSjyCC6i5e5NQKsizwrWHZQMZdUCKnUUlTTCMSb2V5u/p38keEbRgHb+gsyKIi7j2hMzaHYnLsFeFbKZt5nzqlFKOIiBPsQYrGE2TQ8nUTe36F4Zi0I4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39850400004)(136003)(376002)(38350700002)(2906002)(36756003)(6666004)(38100700002)(8676002)(31696002)(86362001)(110136005)(6486002)(31686004)(4326008)(83380400001)(186003)(7416002)(66556008)(8936002)(26005)(53546011)(966005)(5660300002)(6706004)(66946007)(16576012)(54906003)(52116002)(66476007)(956004)(478600001)(2616005)(316002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFpqclhKcjBmcEl0Nzcva0JVSjZLNURGYUlUT3huRTJKOUZUM0xrL05iVS9Z?=
 =?utf-8?B?TGI0ZTNDRU1ad1VnWlF4L3g4K0ppM2QwZjR5dHJzQ25hSExEY2xFaTlYclR3?=
 =?utf-8?B?RnhzdkMyNCt6c0RaSThrVHVLbEhGZytXd05UT21CeGpmUG5sYnBNK0RLaGFU?=
 =?utf-8?B?MUY0QVFaL0JaUEJ1NDcxNUQ0NVNlMjBqeVVGY0s2TmxyMkgxTXpMK3JSTTg4?=
 =?utf-8?B?Q0Eyd1hyMjF4V1l5T3V5THBjNWpKd3F4U2N3MFJKYzRhajJhV3cwRU9vQmhz?=
 =?utf-8?B?RUc1dUJMaG50ZnAwMmxxM25WVEhFNExIdmZwRnZQSUlCODhRM0lnTDBMRXkv?=
 =?utf-8?B?dHRWWFJha3pNRnZDU3dXZVFqZnlqOGM5OThmS3E4VVVIaHhHNFpTai9KMEhw?=
 =?utf-8?B?WEtPVERyblpXVnpaQUJmanR2VGQ4WDJoU1Q3K1B2L0hURHpXUngvZmhpZ2I5?=
 =?utf-8?B?UmZzdW9sRzhlQ08zQ0VCOHJrMTg4Nk1RWnhUL1NmMFVtblAzUEFOcHB3T0Vm?=
 =?utf-8?B?RkYzY3VGd20yc0x1Vll6QUZ5NWNqellGUkU0bkhieThUNXdFZllEdTF1YjY5?=
 =?utf-8?B?NjlCNTc2UFpodEJ0c1hNQVorL2lVa3EycVhvUVQ4S3l4VWJlWElGRXBDS0RB?=
 =?utf-8?B?VDBBdE9CRjRCK3M4K3BUK3NVQWN1YTRtWkI2OUVkZ3Z0RmJENSsrTEtzakU0?=
 =?utf-8?B?K0czcjExR1pnMnlxVlB5bjJZQ0dFclNWa2FUc2V6NVFlVVJvd0tzckNCcW04?=
 =?utf-8?B?RGdxbWhQdXIvejBwblJhdVRmTk9WcEZnVFJyR3V4OERXQ0FoamdHTWUvb2ZO?=
 =?utf-8?B?c0NiNzRGelNvQUJ5dVdma0Y3Z3pwSDhkbk5tSHF0U3g5WUJ2QXVuMnVIeTdy?=
 =?utf-8?B?VDlBUy9PRzhwS2NLQjVMSVFLSFRzL2IwRTI4eS9leitJWm8zaGJXMW9DMlk3?=
 =?utf-8?B?YzIwZnZvRWpCNnNqanBRQ2VENmhqekZQQmNQRmtIS0FYNkZLVDFkTklMRmhK?=
 =?utf-8?B?U1FybmdxZFBTU3pBNERHbVBoWno1a1VXMmYrVUVrTEhDcWhMbXVOZ2FsMVFH?=
 =?utf-8?B?b0M4WTZNL3I2TlNkUWpxSUg5OS93Y1JiWExvWldsbDBXQkUrVzRFak9OcCto?=
 =?utf-8?B?S3BOYWErS0F5L3R3MXVjemhQUXlyRHdscFMzeG9yUVRuOWNRQjFINnpaQjVs?=
 =?utf-8?B?TkJOMXZWaW5BLzhsbmF0bE9QOGhvcFIwMjFmaHhlUlBhMVBuaEcvRXY1VjRW?=
 =?utf-8?B?R3JxWWJiaUpVeTduTkxGazMrYldQQVRHdFFQTDBkZ1pYdHFvSE55Tk1PSEo1?=
 =?utf-8?B?dGlxVW81Z1h3cGEyWDF2U24xbWxEK3VUUE1XbU51UGhWY094WUlDQ3dLbURM?=
 =?utf-8?B?RWxpa2k4a1VJSmxWMUZTZFZSN3JZQVVQTlo5YXFqMWgrT0lXU0JWRlBNUEdt?=
 =?utf-8?B?dEdPWWM4QnFsU1dSU2kwTnZWbDBZUzNicHQ3K1pOZ2dpMk1wZHZUWXc0dXFD?=
 =?utf-8?B?YXhKSU1EQVFmTlk0eWF4LzN3anhpcHR0RDBKTnVEUmVyRmw2anN2R0lwYjk5?=
 =?utf-8?B?ak9RL2JweSsxY3hab0c4OWZBeVM4alAxV0drUUExQnpzVU9qNk9NbzlZejhL?=
 =?utf-8?B?K0c5S1Q1K0lBaFdKaWlIVGpnYVF1VWQ3aTVtVHdhUVIxM0VxakE5S004Vnc4?=
 =?utf-8?B?T0FqcEpOMFBtTHRvVjZKTCtKUlluUmZSMkdkR0pMSFR3bFZYdVhSV0JmcnFC?=
 =?utf-8?Q?KDR8MZL2Zcyapia3pUms30F6NlxfQBOBcjSgMa2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e697c4e6-cc40-4eae-72f5-08d948037d96
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 02:43:27.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmKeUDFC2e4qXiJ4LjiHmtycnb4P7itn5ze0jQfUBnKaqob+3X0A/FOEN11TS0wSA6q93w4PreUuvm028OoH0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-Proofpoint-ORIG-GUID: Zz0lU_ayoXvGbd-k4oU5Jl3PjJThqhea
X-Proofpoint-GUID: Zz0lU_ayoXvGbd-k4oU5Jl3PjJThqhea
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_01:2021-07-14,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/21 10:26 AM, Jason Wang wrote:
>
> 在 2021/7/15 下午7:05, Paolo Bonzini 写道:
>> On 15/07/21 12:10, He Zhe wrote:
>>> The following was provided in this thread. The commit log contains the call traces that I met and fixed back to Apr. 2020.
>>>
>>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
>>
>>> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
>>> ---- snip ----
>>> 001: Call Trace:
>>> 001:  vhost_signal+0x15e/0x1b0 [vhost]
>>> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
>>> 001:  handle_rx+0xb9/0x900 [vhost_net]
>>> 001:  handle_rx_net+0x15/0x20 [vhost_net]
>>> 001:  vhost_worker+0xbe/0x120 [vhost]
>>> 001:  kthread+0x106/0x140
>>> 001:  ? log_used.part.0+0x20/0x20 [vhost]
>>> 001:  ? kthread_park+0x90/0x90
>>> 001:  ret_from_fork+0x35/0x40
>>
>> This call trace is not of a reentrant call; there is only one call to eventfd_signal.  It does fit the symptoms that Daniel reported for PREEMPT_RT though.
>>
>>> https://lore.kernel.org/lkml/beac2025-2e11-8ed0-61e2-9f6e633482e8@redhat.com/
>>
>> This one is about PREEMPT_RT, so it would be fixed by local_lock.
>>
>> There _may_ be two bugs, so let's start by fixing this one.  Once this one is fixed, we will examine the call stacks of any further reports, and diagnose whether the second bug (if it exists) is related to vDUSE, PREEMPT_RT or neeither.
>
>
> For VDUSE we may still need the patch since it tries to relay notifications (eventfds) which means the recursion of the eventfd signal.
>
> But looking at the comment in the eventfd_signal() which say we should check with eventfd_signal_count() and delay the signal into a safe context (e.g workqueue etc).

The main concern when adding eventfd count at the very beginning is "Deadlock or stack overflow" in the inline comment. If we can avoid deadlock and one depth of nest is acceptable, I think it's safe to set the max count to 2.

The author of the eventfd count kind of also agrees with this.
https://lore.kernel.org/lkml/3b4aa4cb-0e76-89c2-c48a-cf24e1a36bc2@kernel.dk/

Thanks,
Zhe

>
> Thanks
>
>
>>
>> Paolo
>>
>

