Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EF3DCFC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 06:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhHBEgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 00:36:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:44304 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhHBEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 00:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627878952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53+BxbYn3jYmjuMoqyId+EFhsBdBaImd3EtP/BV+RDo=;
        b=mvYBvILR84Y+R0jL9xX78iXIGABOI9rKbZrQiqOVyuZjqmPDNow+qjWsKZRiP5/98cvCYW
        YQLwbwlSj6a6Jqmx7OtG5OwTJdgQoEyk5qpY3KWa6ujd2oasQqI70MRksDR1PpYm/X+DPx
        ZdorhamvPWO0Z5TNDqnwE3fQyVfKzbQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-5-l0mcg9ccMsSgKGFTyN_aOQ-1; Mon, 02 Aug 2021 06:35:51 +0200
X-MC-Unique: l0mcg9ccMsSgKGFTyN_aOQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj4Hx4he3qwYE30kZK4FL2t88TV/3CuvRRY9SmEIbONncmNNA1//3j4smfilLjZb0vlKL1SVsIATIz3hYtzcPc1cu3slVizt2foB+S5OxW4ZRo/YT8QdCJFmgU8vIquls93K/xrq4c7wDsfYv62vJheGhYQeYKl6AujxFoAuN49dr7KX4mZ+WyubQCrL4v5m9YZHym20y2UIUTCjAQT2bnt4PqHK8GHxTe22W3RLf0R6iG6CszpLIkHrYpuMa8bdjCZEaAa7EaXlJrserID0eNulTMIAheVREk5OCByoVdOJCgwsyi1kHG4Ii7mnblYHb8tSYOyYlmwfdyPobQJqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqgBDyXqUcycKOTJDPD5rqWoQ2uvfhXZ100s5dKREqk=;
 b=JPQP+cy3LkJQxBaivTF8mNINd9VQe1QjxIRR1tOLhP9GPo50d0Lh5PAW9h/dK5lfPEZAFKufRjf5e5N8Ck31Ml3LyAf6tlYN9NAlXV6yIPG/qtPdgXQlzZJX2qQMGtOIXnu9ia4hsDR3FxRx2Q0MdiHPdPgw6GhfBS8SnHHPWRj2yLpKRIv7SV98H72xn7gjqsLr7JVweA1LVPw8QK1rUmsBDPCN3SyOiHSDe9HEqNmFB8e/6qKnpzSbbLgMzpHUFD8ScYps2FGnul9wdsJLZ/TGoUHrjQEb8ATlYrg49gwDMnnHcC4OIiBlHUiATRZ5HPGADCp1CzYFwOkIlaoHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 04:35:49 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::b973:ec65:6b36:1eaa]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::b973:ec65:6b36:1eaa%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 04:35:49 +0000
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: reflink deadlock when clone file to
 the same directory simultaneously
To:     Wengang Wang <wen.gang.wang@oracle.com>
CC:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <20210729110230.18983-1-ghe@suse.com>
 <F991B5E2-136D-406C-A180-C253B1742120@oracle.com>
 <a3260130-23a6-ef9d-5b9d-0eaafcd3a217@suse.com>
 <74425299-19FC-469D-884A-A3BBE1E66EFF@oracle.com>
From:   Gang He <ghe@suse.com>
Message-ID: <5670866c-927f-2c27-42c2-0242181522a8@suse.com>
Date:   Mon, 2 Aug 2021 12:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <74425299-19FC-469D-884A-A3BBE1E66EFF@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 04:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977a3338-bd0b-4418-b474-08d9556f00c2
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:
X-Microsoft-Antispam-PRVS: <AM6PR04MB64078DAC8F0240C42A0D9626CFEF9@AM6PR04MB6407.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ixen3k9cU/7WWjg6LTI8/zREw3s4SadfXq5Ni84Qr7kWqjavExmeuVljbUF/Vo+0+aMox+hh5SZfo4pycRg4dBZNS5h6SxvW4T2ktFqbVeJg8Q3qLl+9Zo3+WaP3bmIiABhIQaWd8afsCnmzDfbA4qr9/sZZ34OfPw3FysVYsbnqrC7nxU76U17V/hvjuZq+5zG8PV0D7LCT3yBkDRnQcyfnLdyAI/VOca5+KeAHzBU2CLSjqxncnPtUAL1AO8LigP5mf6PNEIemIivXNxQb5ouTieOwBi+4MgxLcMYJ0lCPFfTqjDgqOkC89SMC/WbcGorElJvVwkbLBvpLS/YzlNF+0vcjNbA9kSnYwivr9jFDBul3UmjFSxnGcvtMVLjxBTWHQOs6Elcw7AjEKQ11r80GnJuGelTz2ihk75Fu+DWvPd7wR52cmSDwpGkgI6OUuv8UTQZcwnLiOINTa/s68Q4WUSUIMCZBc0y/CAy4Zg4EbTpDRkn9eJwGMfuGd7S+fcN/1ax+WksZREr15OSVw/1duYzKwpVsi9bSSSqUwbyh6mbhM8oKMocfZTJ8t/1EJkiuZ5sOw3QHgdO+T5KbBtgwSGpqwZ3hPE5L4H34V4UEEGYq0jm+tanr9SiHHGM6LYZI6723pR+ayR4U5TL/Y6tNU0EtmOj9g/o7gVWfP3pPcZTxRssC9RAU/GTjTGUHqfTVeloV5vpYt+U4Sxh7EoexnR262Aic6NrcdGNpZSoHsH5VsztKKW+KissLwwV2QoSCJjJOlSDJqA/GW90T/kSKNSodYq7V717/C7qOYrr5UCNPiOtWGeOgOrEfN3h1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(376002)(366004)(346002)(396003)(38100700002)(4326008)(53546011)(316002)(30864003)(54906003)(8676002)(55236004)(26005)(2616005)(956004)(31686004)(8936002)(6916009)(16576012)(6486002)(186003)(31696002)(36756003)(66476007)(2906002)(66556008)(66946007)(966005)(6666004)(478600001)(5660300002)(83380400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZE5EnFTXPoCa6Utdx4gp1gLSgqoAcp695kTix0ZfdAp2PVLSbLqFGlBH0xFr?=
 =?us-ascii?Q?RDsrtUHV1w4cIKA1wg50gG/JhDs6Fq+hOpdPhwGvMgY8x+u2+MHewivwJ6T5?=
 =?us-ascii?Q?csLhKG0Qf08PW0O6sWG8gkkabcKZR+F9vhK/qglLRiJIDNN/+G9ALohFkACj?=
 =?us-ascii?Q?FwLHz3zTaFtlT89MSQ7VFp/4Lz+M2I7abObKQQ8/l8O4JDTBPSbEj4UdLdOa?=
 =?us-ascii?Q?IL6SBrGvrNm2ka6WLRbd1wXgMdB1IZ3lyc8pDncBR7tUCWIZv7iiVj6nyxga?=
 =?us-ascii?Q?qIvoOP36fZE3apurgCnPVKJ5Cwi6kKFHIV73uw2ezhEkIVoRHqhFT59gVjz5?=
 =?us-ascii?Q?dGEdp+1MFVCGw6beuDFK2/LEaPVfAlp/TtnAA1T84G8RiK0iBI4S7La55nn2?=
 =?us-ascii?Q?vap8OgfBy2TypgphbR0U0Z0B9P50EZTJXolK8Z4rJl4Y0Ys9tquH1weDq/Wh?=
 =?us-ascii?Q?s6OZFVOcToX4LkptfzoQn7gOluVzed5B1NLs5OITRcIB9d1K7nX6MrhrjOu3?=
 =?us-ascii?Q?ykXcFLMEQ97baM88VyN3tfoqXxozkK5sY/LqB7TVGb+vI+DdnN4CI6WOfCq5?=
 =?us-ascii?Q?6v/otjPqvBYY5aT5zQa15ymlxj1X+6LCrjuwF+u3YKeuyPReXwSuVCO3pSAp?=
 =?us-ascii?Q?KyFYzFhSe3qWoG8FxCs7kHafAismr9v5ItX87KvRclKDoqShU8mOD+Qg+5YO?=
 =?us-ascii?Q?QlQ6oRZt1SlZpWG10CwxDz5rFH4kO5sgjh2Y3iLcjvMGIUSbScQ4OQL0Hj2E?=
 =?us-ascii?Q?GIg7HH99QyqaPFZLzF60TyFzkcbExeGdHSTlDUIuHyYiRJkHtpMb+9TB2CFM?=
 =?us-ascii?Q?cjFlx8sno3B1uhAV57ScWtCDn9e5Xb8fArVoeJFk0TAE+osIcpddbDCpo+dU?=
 =?us-ascii?Q?l7KGJ4gz51mwuSYpf2bw0tM7FF9pbAM60jcvvsy6Z2dQK78MpST/ReKOtobx?=
 =?us-ascii?Q?4FbI97ijIN0CbKKvFJ10MPRg4yXbvfL/TIq0S2Ihv+IPj/DlzlqgbWJ7XTG0?=
 =?us-ascii?Q?y+nGdcoPIBTUo2RwIpPqhAAYvDRU1A6X56b8zbkN2fDs29raa22XQwBvRbwp?=
 =?us-ascii?Q?/oRCKd6r7MT1iPtj7Yj6q5T75vuqwAZ5Am45E10P1m0UbW1zMqe8bsWF4jui?=
 =?us-ascii?Q?iFkCaVJ3GL251sONiu13z81Y+2CI1RbRUv/wRwFAA+TalDmT5MtofmwbyEx9?=
 =?us-ascii?Q?3OmtVNk41c9QAjIkd8qxdgg9WZ8+QMrnwMydztFjt8fF8k3vF2am3zmmdV8D?=
 =?us-ascii?Q?XQYiYhwPmdIBF8Mh4exFSXDAGAlJUjMGnQvGxt83gPClPS8JaRH9XEhYrX3J?=
 =?us-ascii?Q?T9iwAG83qQmE+gduo+y+rYOf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977a3338-bd0b-4418-b474-08d9556f00c2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 04:35:49.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7C5kZbUjtCcB5glLVHHILByOS8vMzRXwccq7U+9ge2yuhI06O837rjswICR0tG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6407
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wengang,

The ocfs2 file system is mounted at /mnt/shared,
The test file(e.g. 40G VM image) is located at /mnt/shared/test, the=20
snapshot direcory is /mnt/shared/.snapshots, then the user runs a=20
reflink command from each node to generate a clone file repeatedly like,
reflink "/mnt/shared/test" \
    "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"

after a while, the reflink process on each node is hung, the user
cannot list the file system again.

The problematic reflink command process is blocked at one node, like
__schedule+0x2fd/0x750
schedule+0x2f/0xa0
schedule_timeout+0x1cc/0x310
? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
? 0xffffffffc0e3e000
wait_for_completion+0xba/0x140
? wake_up_q+0xa0/0xa0
__ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
ocfs2_reflink+0x436/0x4c0 [ocfs2]
? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
ocfs2_ioctl+0x25e/0x670 [ocfs2]
do_vfs_ioctl+0xa0/0x680
ksys_ioctl+0x70/0x80
__x64_sys_ioctl+0x16/0x20

In fact, this node has acquired .snapshots directory inode dlm lock,
but the reflink process is blocked at=20
ocfs2_init_security_and_acl+0xbe/0x1d0, the process is wait for getting
.snapshots directory inode dlm lock.
The reflink process on other nodes is also blocked at getting .snapshots
directory inode dlm lock, then the file system cannot be listed since=20
"ls -l" command also need to get .snapshot directory's attributes.

Why the the reflink process is blocked at=20
ocfs2_init_security_and_acl+0xbe/0x1d0? I feel it is caused by multiple=20
acquiring the .snapshots directory inode dlm lock in ocfs2_reflink=20
function. For the deeper reasons, it is probably related to dlmglue=20
layer or there is any factor which blocked .snapshots inode dlm lock to=20
downconvert.

Thanks
Gang




On 2021/7/31 0:35, Wengang Wang wrote:
> Hi Gang,
>=20
>> On Jul 29, 2021, at 11:16 PM, Gang He <ghe@suse.com> wrote:
>>
>> Hello Wengang and all,
>>
>> This issue can be reproduced stably when you run the below reflink comma=
nd line(maybe you also can follow a "rm this file" command line and  sleep =
some usecs) from each node repeatedly for a while.
>> Based on my observation, the reflink processes are always blocked at the=
 below points.
>>  From dlm_tool output and crash analysis, the node1 has acquired .snapsh=
ots directory inode EX dlm lock, but the reflink process is blocked at ocfs=
2_init_security_and_acl+0xbe/0x1d0 to acqure it's inode dlm lock again.
>=20
> So the reflink path on node 1 have .snapshots inode lock granted and is b=
locking at the new created inode under orphan directory.  BTW, what=E2=80=
=99s .snapshots directory? What=E2=80=99s the call path to lock that .snaps=
hots inode?
>=20
>> On the other two nodes, the reflink processes are blocked at acquire .sn=
apshots directory inode dlm lock, then the whole file system is hung,
>> you can not list this file again.
>=20
> So there are reflink paths on the other two nodes blocking at .snapshots =
inode. But what lock they are granted already?
>=20
> For a typical ABBA deadlock,
> path 1 granted lock A and blocks at lock B
> path 2 granted lock B and blocks at lock A
>=20
> Per your description, I see this:
> reflink path on node1  granted .snapshots lock and blocks at new inode lo=
ck
> reflnk paths on onde2/3 block at .snapshots lock.
>=20
> I don't see how deadlock formed=E2=80=A6 the new inode lock is granted to=
 any of the reflink path on node2/3? how?
>=20
> thanks,
> wengang
>=20
>>
>> The problem looks like acquiring the destination direcory multiple durin=
g ocfs2_reflink, dlm glue layer cannot downconvert lock in some case.
>> e.g.
>> kernel: (ocfs2dc-F50B203,1593,0):ocfs2_downconvert_lock:3674 ERROR: DLM =
error -16 while calling ocfs2_dlm_lock on resource M000000000000000004661c0=
0000000
>> kernel: (ocfs2dc-F50B203,1593,0):ocfs2_unblock_lock:3918 ERROR: status =
=3D -16
>> kernel: (ocfs2dc-F50B203,1593,0):ocfs2_process_blocked_lock:4317 ERROR: =
status =3D -16
>>
>> Then, I change the code to acquire this destination direcory dlm lock, a=
nd hold the lock until the end of ocfs2_reflink function.
>> After this change, I did not encounter this hang problem again after lot=
s of testing. Second, I find the code change also improve reflink performan=
ce, since the code avoids the previous ping-pong effect.
>>
>> Thanks
>> Gang
>>
>>
>> On 2021/7/30 6:07, Wengang Wang wrote:
>>> Hi Gang,
>>> I=E2=80=99d suggest you list the call paths on the related nodes, Say c=
all path 1 on node one granted lock A and is requesting for lock B, at the =
same time, path2 on node two granted lock B and now is requesting for lock =
A.
>>> With that, the problem would be easier to understand.
>>> thanks,
>>> wengang
>>>> On Jul 29, 2021, at 4:02 AM, Gang He <ghe@suse.com> wrote:
>>>>
>>>> Running reflink from multiple nodes simultaneously to clone a file
>>>> to the same directory probably triggers a deadlock issue.
>>>> For example, there is a three node ocfs2 cluster, each node mounts
>>>> the ocfs2 file system to /mnt/shared, and run the reflink command
>>>> from each node repeatedly, like
>>>>   reflink "/mnt/shared/test" \
>>>>   "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
>>>> then, reflink command process will be hung on each node, and you
>>>> can't list this file system directory.
>>>> The problematic reflink command process is blocked at one node,
>>>> task:reflink         state:D stack:    0 pid: 1283 ppid:  4154
>>>> Call Trace:
>>>>   __schedule+0x2fd/0x750
>>>>   schedule+0x2f/0xa0
>>>>   schedule_timeout+0x1cc/0x310
>>>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>>>   ? 0xffffffffc0e3e000
>>>>   wait_for_completion+0xba/0x140
>>>>   ? wake_up_q+0xa0/0xa0
>>>>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>   ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>>>   ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>>>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>>   do_vfs_ioctl+0xa0/0x680
>>>>   ksys_ioctl+0x70/0x80
>>>>   __x64_sys_ioctl+0x16/0x20
>>>>   do_syscall_64+0x5b/0x1e0
>>>> The other reflink command processes are blocked at other nodes,
>>>> task:reflink         state:D stack:    0 pid:29759 ppid:  4088
>>>> Call Trace:
>>>>   __schedule+0x2fd/0x750
>>>>   schedule+0x2f/0xa0
>>>>   schedule_timeout+0x1cc/0x310
>>>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>>>   ? 0xffffffffc0b19000
>>>>   wait_for_completion+0xba/0x140
>>>>   ? wake_up_q+0xa0/0xa0
>>>>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>   ocfs2_mv_orphaned_inode_to_new+0x87/0x7e0 [ocfs2]
>>>>   ocfs2_reflink+0x335/0x4c0 [ocfs2]
>>>>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>>   do_vfs_ioctl+0xa0/0x680
>>>>   ksys_ioctl+0x70/0x80
>>>>   __x64_sys_ioctl+0x16/0x20
>>>>   do_syscall_64+0x5b/0x1e0
>>>> or
>>>> task:reflink         state:D stack:    0 pid:18465 ppid:  4156
>>>> Call Trace:
>>>>   __schedule+0x302/0x940
>>>>   ? usleep_range+0x80/0x80
>>>>   schedule+0x46/0xb0
>>>>   schedule_timeout+0xff/0x140
>>>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>>>   ? 0xffffffffc0c3b000
>>>>   __wait_for_common+0xb9/0x170
>>>>   __ocfs2_cluster_lock.constprop.0+0x1d6/0x860 [ocfs2]
>>>>   ? ocfs2_wait_for_recovery+0x49/0xd0 [ocfs2]
>>>>   ? ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>>>>   ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>>>>   ocfs2_inode_lock_tracker+0xf2/0x2b0 [ocfs2]
>>>>   ? dput+0x32/0x2f0
>>>>   ocfs2_permission+0x45/0xe0 [ocfs2]
>>>>   inode_permission+0xcc/0x170
>>>>   link_path_walk.part.0.constprop.0+0x2a2/0x380
>>>>   ? path_init+0x2c1/0x3f0
>>>>   path_parentat+0x3c/0x90
>>>>   filename_parentat+0xc1/0x1d0
>>>>   ? filename_lookup+0x138/0x1c0
>>>>   filename_create+0x43/0x160
>>>>   ocfs2_reflink_ioctl+0xe6/0x380 [ocfs2]
>>>>   ocfs2_ioctl+0x1ea/0x2c0 [ocfs2]
>>>>   ? do_sys_openat2+0x81/0x150
>>>>   __x64_sys_ioctl+0x82/0xb0
>>>>   do_syscall_64+0x61/0xb0
>>>>
>>>> The deadlock is caused by multiple acquiring the destination directory
>>>> inode dlm lock in ocfs2_reflink function, we should acquire this
>>>> directory inode dlm lock at the beginning, and hold this dlm lock unti=
l
>>>> end of the function.
>>>>
>>>> Signed-off-by: Gang He <ghe@suse.com>
>>>> ---
>>>> fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
>>>> fs/ocfs2/namei.h        |  2 ++
>>>> fs/ocfs2/refcounttree.c | 15 +++++++++++----
>>>> fs/ocfs2/xattr.c        | 12 +-----------
>>>> fs/ocfs2/xattr.h        |  1 +
>>>> 5 files changed, 28 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>>>> index 2c46ff6ba4ea..f8bbb22cc60b 100644
>>>> --- a/fs/ocfs2/namei.c
>>>> +++ b/fs/ocfs2/namei.c
>>>> @@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct i=
node *dir,
>>>> }
>>>>
>>>> int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>> +				 struct buffer_head **dir_bh,
>>>> 				 int mode,
>>>> 				 struct inode **new_inode)
>>>> {
>>>> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inode =
*dir,
>>>>
>>>> 	brelse(new_di_bh);
>>>>
>>>> -	if (!status)
>>>> -		*new_inode =3D inode;
>>>> -
>>>> 	ocfs2_free_dir_lookup_result(&orphan_insert);
>>>>
>>>> -	ocfs2_inode_unlock(dir, 1);
>>>> -	brelse(parent_di_bh);
>>>> +	if (!status) {
>>>> +		*new_inode =3D inode;
>>>> +		*dir_bh =3D parent_di_bh;
>>>> +	} else {
>>>> +		ocfs2_inode_unlock(dir, 1);
>>>> +		brelse(parent_di_bh);
>>>> +	}
>>>> +
>>>> 	return status;
>>>> }
>>>>
>>>> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_s=
uper *osb,
>>>> }
>>>>
>>>> int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>> +				   struct buffer_head *dir_bh,
>>>> 				   struct inode *inode,
>>>> 				   struct dentry *dentry)
>>>> {
>>>> 	int status =3D 0;
>>>> -	struct buffer_head *parent_di_bh =3D NULL;
>>>> 	handle_t *handle =3D NULL;
>>>> 	struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
>>>> 	struct ocfs2_dinode *dir_di, *di;
>>>> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode=
 *dir,
>>>> 				(unsigned long long)OCFS2_I(dir)->ip_blkno,
>>>> 				(unsigned long long)OCFS2_I(inode)->ip_blkno);
>>>>
>>>> -	status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
>>>> -	if (status < 0) {
>>>> -		if (status !=3D -ENOENT)
>>>> -			mlog_errno(status);
>>>> -		return status;
>>>> -	}
>>>> -
>>>> -	dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
>>>> +	dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
>>>> 	if (!dir_di->i_links_count) {
>>>> 		/* can't make a file in a deleted directory. */
>>>> 		status =3D -ENOENT;
>>>> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode =
*dir,
>>>> 		goto leave;
>>>>
>>>> 	/* get a spot inside the dir. */
>>>> -	status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
>>>> +	status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>>>> 					      dentry->d_name.name,
>>>> 					      dentry->d_name.len, &lookup);
>>>> 	if (status < 0) {
>>>> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode =
*dir,
>>>> 	ocfs2_journal_dirty(handle, di_bh);
>>>>
>>>> 	status =3D ocfs2_add_entry(handle, dentry, inode,
>>>> -				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
>>>> +				 OCFS2_I(inode)->ip_blkno, dir_bh,
>>>> 				 &lookup);
>>>> 	if (status < 0) {
>>>> 		mlog_errno(status);
>>>> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode=
 *dir,
>>>> 	iput(orphan_dir_inode);
>>>> leave:
>>>>
>>>> -	ocfs2_inode_unlock(dir, 1);
>>>> -
>>>> 	brelse(di_bh);
>>>> -	brelse(parent_di_bh);
>>>> 	brelse(orphan_dir_bh);
>>>>
>>>> 	ocfs2_free_dir_lookup_result(&lookup);
>>>> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
>>>> index 9cc891eb874e..03a2c526e2c1 100644
>>>> --- a/fs/ocfs2/namei.h
>>>> +++ b/fs/ocfs2/namei.h
>>>> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>>>> 		     struct buffer_head *orphan_dir_bh,
>>>> 		     bool dio);
>>>> int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>> +				 struct buffer_head **dir_bh,
>>>> 				 int mode,
>>>> 				 struct inode **new_inode);
>>>> int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
>>>> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *=
osb,
>>>> 		struct inode *inode, struct buffer_head *di_bh,
>>>> 		int update_isize, loff_t end);
>>>> int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>> +				   struct buffer_head *dir_bh,
>>>> 				   struct inode *new_inode,
>>>> 				   struct dentry *new_dentry);
>>>>
>>>> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>>>> index 7f6355cbb587..a9a0c7c37e8e 100644
>>>> --- a/fs/ocfs2/refcounttree.c
>>>> +++ b/fs/ocfs2/refcounttree.c
>>>> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_dent=
ry, struct inode *dir,
>>>> {
>>>> 	int error, had_lock;
>>>> 	struct inode *inode =3D d_inode(old_dentry);
>>>> -	struct buffer_head *old_bh =3D NULL;
>>>> +	struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
>>>> 	struct inode *new_orphan_inode =3D NULL;
>>>> 	struct ocfs2_lock_holder oh;
>>>>
>>>> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_dent=
ry, struct inode *dir,
>>>> 		return -EOPNOTSUPP;
>>>>
>>>>
>>>> -	error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
>>>> +	error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode,
>>>> 					     &new_orphan_inode);
>>>> 	if (error) {
>>>> 		mlog_errno(error);
>>>> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_de=
ntry, struct inode *dir,
>>>>
>>>> 	/* If the security isn't preserved, we need to re-initialize them. */
>>>> 	if (!preserve) {
>>>> -		error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
>>>> +		error =3D ocfs2_init_security_and_acl(dir, dir_bh,
>>>> +						    new_orphan_inode,
>>>> 						    &new_dentry->d_name);
>>>> 		if (error)
>>>> 			mlog_errno(error);
>>>> 	}
>>>> 	if (!error) {
>>>> -		error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
>>>> +		error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
>>>> +						       new_orphan_inode,
>>>> 						       new_dentry);
>>>> 		if (error)
>>>> 			mlog_errno(error);
>>>> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_den=
try, struct inode *dir,
>>>> 			iput(new_orphan_inode);
>>>> 	}
>>>>
>>>> +	if (dir_bh) {
>>>> +		ocfs2_inode_unlock(dir, 1);
>>>> +		brelse(dir_bh);
>>>> +	}
>>>> +
>>>> 	return error;
>>>> }
>>>>
>>>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>>>> index dd784eb0cd7c..3f23e3a5018c 100644
>>>> --- a/fs/ocfs2/xattr.c
>>>> +++ b/fs/ocfs2/xattr.c
>>>> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_ino=
de,
>>>> /*
>>>>   * Initialize security and acl for a already created inode.
>>>>   * Used for reflink a non-preserve-security file.
>>>> - *
>>>> - * It uses common api like ocfs2_xattr_set, so the caller
>>>> - * must not hold any lock expect i_mutex.
>>>>   */
>>>> int ocfs2_init_security_and_acl(struct inode *dir,
>>>> +				struct buffer_head *dir_bh,
>>>> 				struct inode *inode,
>>>> 				const struct qstr *qstr)
>>>> {
>>>> 	int ret =3D 0;
>>>> -	struct buffer_head *dir_bh =3D NULL;
>>>>
>>>> 	ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
>>>> 	if (ret) {
>>>> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode *=
dir,
>>>> 		goto leave;
>>>> 	}
>>>>
>>>> -	ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
>>>> -	if (ret) {
>>>> -		mlog_errno(ret);
>>>> -		goto leave;
>>>> -	}
>>>> 	ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
>>>> 	if (ret)
>>>> 		mlog_errno(ret);
>>>>
>>>> -	ocfs2_inode_unlock(dir, 0);
>>>> -	brelse(dir_bh);
>>>> leave:
>>>> 	return ret;
>>>> }
>>>> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
>>>> index 00308b57f64f..b27fd8ba0019 100644
>>>> --- a/fs/ocfs2/xattr.h
>>>> +++ b/fs/ocfs2/xattr.h
>>>> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>>>> 			 struct buffer_head *new_bh,
>>>> 			 bool preserve_security);
>>>> int ocfs2_init_security_and_acl(struct inode *dir,
>>>> +				struct buffer_head *dir_bh,
>>>> 				struct inode *inode,
>>>> 				const struct qstr *qstr);
>>>> #endif /* OCFS2_XATTR_H */
>>>> --=20
>>>> 2.21.0
>>>>
>>>>
>>>> _______________________________________________
>>>> Ocfs2-devel mailing list
>>>> Ocfs2-devel@oss.oracle.com
>>>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>
>=20

