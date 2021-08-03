Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A83DE3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 02:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhHCA6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 20:58:48 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:60560 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232768AbhHCA6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627952314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZPoBW4zHSrpMXoC9reXPxLiQrOaK5eMxN8Bv8J1Cb0=;
        b=Xy+eqL76d6tOFZhlauNpptxsBlcUyjb2xzj7YODMCyL/5iSZa2yL7q7SmgjAd5S8if4Oj+
        o+5Ilz1p/NtDZu8ExvaQdFNBpO6RZf30Sbh8YgTvkrIwFAd8868x0WdYY0vV0Q4eOGR/NI
        W6lXdGgEKilQBSEHBfZ1NjJZbK4424I=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-OGAXA_KpN52GfU4M34ehJw-1; Tue, 03 Aug 2021 02:58:33 +0200
X-MC-Unique: OGAXA_KpN52GfU4M34ehJw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlGa1ER2anBuFvhLc6k3EdxCnq3eAKH8q+dYTCXQZpqLXQySWWFdGTOSQZS9wVr4GIWmW+p/51GMyIVmT+wNW3OTM8F/eXSYhB/5lKasrVw8aH/e6d+M8eK9ZP+Z/w2CT9vRA7hOBjbN68q0RnRHzSfay3sOpV0StRS5gVux2LOlaNfr37OcPWSDWzf0akkq3eo4jHeHwgYlnjJxjfYkhcvbV/GULcm/HBurqzivyVeZT9Mou3QK41p6kqx6gUd2gsy7hzehTI8Y4VcJ67bCns7ytk5kL0Yl0LDUB+DGmJCPr4OYfyLYMCCutf2JCA5arniozJIdhwjmbtQzais0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE+TjighNf9rnRKDomyRTd/u6cDZAc4pNUnoqyvD3AM=;
 b=GTrSCk0wD9TiazAUjQPMA21UuDUhdmmY2klB3nMIMRzcKIGZIbpv4aZd3YFpXPxywWzSr6ZE6o/t7iWKF2/z1XtgwuiaP/WNU5hVkTTah4rNwYlZ9KNsnFvnoxhBsd7PCiKxmllixthFZuxN7r9ysH6z/2IG9o64U7qqldMeCuTM4HceMt/D8h0ztKiSm27t4vO5QLzzBICjwL73rS4rglqLYAofwQUMgqfDIPdfKTGoooc3bEVRW4Qxj0IIQPCfAyj8rpzFig9ZGSofGE7dt9wrk3KRMly8b4r2svo9xupIyUWHj9J9FnHfifdmCwMXhnIECHC0lgiYJhb1nOIGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR04MB4727.eurprd04.prod.outlook.com (2603:10a6:20b:3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Tue, 3 Aug
 2021 00:58:31 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::b973:ec65:6b36:1eaa]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::b973:ec65:6b36:1eaa%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 00:58:31 +0000
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
 <5670866c-927f-2c27-42c2-0242181522a8@suse.com>
 <FF6AEBF2-EA93-44D7-B5E1-25D02DFFB403@oracle.com>
From:   Gang He <ghe@suse.com>
Message-ID: <32229540-2542-8b27-7dce-04e1cef98971@suse.com>
Date:   Tue, 3 Aug 2021 09:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <FF6AEBF2-EA93-44D7-B5E1-25D02DFFB403@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.110] (111.202.190.44) by HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.8 via Frontend Transport; Tue, 3 Aug 2021 00:58:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18b4e980-5b05-4b35-4a42-08d95619d006
X-MS-TrafficTypeDiagnostic: AM6PR04MB4727:
X-Microsoft-Antispam-PRVS: <AM6PR04MB472719EC0BE7D89582276E10CFF09@AM6PR04MB4727.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OayftpzZBm138wfN8ZKYFAQkziFOuYVZy1sFWRdxfTVl/8svObj2YP1tbxu6m+YPaPjWyL/6XqtEfLPX9RZxvk6J2pEY+DDEvw7dIxtVBhgELjc0Q2FL2s3QsxB5NfMKGtuG1qU8mmMNlDOeK5P1+0tnyEXNtEqOMXlM5UhVRe+xCDf7z7vG7mgpyEZVSMpL2FAsexnbvxu/8HfXy+jWjYOkoZc/RSd4vz4MXeJA4FGv5fYPRyEYGeKRWZiM0BTxqKynjzqWxZuW+FdUivmIbgkb8mWEOvwQlOJHobz2I32lyHuFrXm1po+KU0O9bGRdVKdutHyy4C9u/4ry86ITDvBZmh/nl7tZj9Wfb0j8Q8iYpsC7PfYH+LpiIP3VHGunoduIX6ULuC69XvXSDVuZKXIBt+qZveBwY6TpjN7V1HIk9cBpwbUDzg/QIJNMnpfs3uW/083HUGgBlfmryJaGvLDtkU6nYBHQXRgJFNPsZ2efT5KSvzoOBaK5qtcLn0/lDh0BwxmirV7p79pmowgU3Eu15Dgy3Kywc3FFxRmf4pJAk3fGHR6aXrkfjG2DgzEEXs6qjKXRMRHbUghELCtG7Y+BZNE1DlfuDu+XbrLRzv9Eo5OdaPiQ7bklYzIRZmkltaryY5q3v/4nROypXsAvQN0novfrj38BVRT0d9EybGBkO3AYlw7QqdXa3Zsp2kSeo0hYwnptbE4WhgSFPjqbq1vHXYtq+tAwMh/MgnkGi+mt++nyHby0ybRp93apUYbLh/gGKcwnjGceflP1kZWN9G7sKcrr9kYZF8yosGlRpCRqTdOFyl0imZHvfUdyo7z3oDUC46A1e8XbYHhLPvDFhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(8936002)(66556008)(66946007)(8676002)(956004)(2616005)(36756003)(6486002)(186003)(30864003)(53546011)(66476007)(5660300002)(31686004)(2906002)(31696002)(6666004)(16576012)(316002)(38100700002)(54906003)(508600001)(4326008)(966005)(6916009)(86362001)(83380400001)(13296009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JC7B/RLj82hiJSY73oFZ1vadezl0Z6Mwv/KtnkmDRuDx7XiasAk1he7Hud9G?=
 =?us-ascii?Q?HuMYv5PO6wmRQ4yJaIxBLUGtQ6n7R8Xy+sCkNfY+0JCOCIkooyXj0Q4fVY23?=
 =?us-ascii?Q?iFDWsaUStGixkp2Dj+YqU7S3/gOUYH78sDDPc4wyx0M2z9iWUtnE7V6eUyjG?=
 =?us-ascii?Q?A4i4JnuQRcR6IlPpzQ6yeZug8jGCMX1/ytWDk9uZ6stxdK3gjf5YcGXl0AIR?=
 =?us-ascii?Q?4dWO9ukEUE+Mh+jAVXBaZl98eRplWsJ+yfb1ZKiWSrYeekEyx9LIfS3T+H5/?=
 =?us-ascii?Q?bkPN/aJzMfcISxbuORbKEznTxBgfkbdyNhywqkO5QJ6LjUHyFFbNY/CgkAh6?=
 =?us-ascii?Q?eNQxbelawY8q6JEGDfu9yiM+FFX5b1dnDvMURbcOTDgvlZZg4TpXEOpZHtSy?=
 =?us-ascii?Q?fYdZiTwf2wfb3xIMiZkK46eGYSGulc6YBdhBUZXANExokuVyW2xid/9P0goz?=
 =?us-ascii?Q?HmWhEL771mU6I3/qtT+xN5VoPzGSwoZGncOAM0JBfmwM6cm/ZePAoK9hnDvS?=
 =?us-ascii?Q?QUH/88yCTXdVvIZbvbb/39ulvnbWcWHmEA7tHuV39IQ+ZgW3zVtnPwNDCSW5?=
 =?us-ascii?Q?c9waLmGXSnDfC3RnTYpOu0HCNCQZk4yNuwvMWFQ74OTw/FKrs6H5OpokObWM?=
 =?us-ascii?Q?5M8VsBErqM20zmd2tf931v+EHztF+z5pVsSaHJgMDdgm+GGYFRDF1wHMP8WW?=
 =?us-ascii?Q?dgbCFbNyMHrDP32a1oRzvms+brzuGDITO8UDxDPxdFY7ytzADzn181hYs5i4?=
 =?us-ascii?Q?x5F9oYMP77qhtwC/Ck1GY24xnp2v1V6gbUUSEa6efXPySs0CJr9VeYbmjcAl?=
 =?us-ascii?Q?NoY7F2vOB2bxapZH50bnVFulcaBQblKt8DPF33fitLX2RsMjJ+aOxv6XiYym?=
 =?us-ascii?Q?nWTowvsZ3M/Et1JHWV0M52WtalEE+51GGHnfEUu2y1fSL6oj8khkx6kTFhJ4?=
 =?us-ascii?Q?pcHyhq+7A3PSzdP3Q7Gnoz9lQ+iJbPPcRSabIMgQwUj9q3wu3O1DjM4e+RtL?=
 =?us-ascii?Q?ED8AtGTDdf7xWA+krENYKHkV35f3Ma8tR0Yk9bYJv2EtNuhOqSOtEsTmifzk?=
 =?us-ascii?Q?KOs6BRDjYAm//n05Z+7RPat0CVjgzFGngzgc4oRQ07M+BiuEGHxjpzxo84Xl?=
 =?us-ascii?Q?CwVkll3j9I8Sik3GhVwKJoripE/ZQt9RMjLiKkaIpRQbyMs9Lk48Rd+E6BjK?=
 =?us-ascii?Q?hvCEubDYzL2P5WY13fLDk66cMyDV84JD3IkKmuoUi6mqjHn/nZnpR8gmmwyV?=
 =?us-ascii?Q?7VU51f6PaD6BhdIZMuYgV5epZ+yfkNImlb/7ThXdOPJm/GHVGmrnCZCpe21m?=
 =?us-ascii?Q?4bdCVmkgujEtqhLlRzDtdnf3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b4e980-5b05-4b35-4a42-08d95619d006
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 00:58:31.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9mNKJ3DyXdI+NNQhF/o+dskdEOi1Ui5095wsH6x8TTupVQRtKMZ358//6IcwznC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/3 2:22, Wengang Wang wrote:
>=20
>=20
>> On Aug 1, 2021, at 9:35 PM, Gang He <ghe@suse.com> wrote:
>>
>> Hi Wengang,
>>
>> The ocfs2 file system is mounted at /mnt/shared,
>> The test file(e.g. 40G VM image) is located at /mnt/shared/test, the sna=
pshot direcory is /mnt/shared/.snapshots, then the user runs a reflink comm=
and from each node to generate a clone file repeatedly like,
>> reflink "/mnt/shared/test" \
>>    "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
>>
>> after a while, the reflink process on each node is hung, the user
>> cannot list the file system again.
>>
>> The problematic reflink command process is blocked at one node, like
>> __schedule+0x2fd/0x750
>> schedule+0x2f/0xa0
>> schedule_timeout+0x1cc/0x310
>> ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>> ? 0xffffffffc0e3e000
>> wait_for_completion+0xba/0x140
>> ? wake_up_q+0xa0/0xa0
>> __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>> ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>> ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>> ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>> ocfs2_reflink+0x436/0x4c0 [ocfs2]
>> ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>> ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>> ocfs2_ioctl+0x25e/0x670 [ocfs2]
>> do_vfs_ioctl+0xa0/0x680
>> ksys_ioctl+0x70/0x80
>> __x64_sys_ioctl+0x16/0x20
>>
>> In fact, this node has acquired .snapshots directory inode dlm lock,
>> but the reflink process is blocked at ocfs2_init_security_and_acl+0xbe/0=
x1d0, the process is wait for getting
>> .snapshots directory inode dlm lock.
>> The reflink process on other nodes is also blocked at getting .snapshots
>> directory inode dlm lock, then the file system cannot be listed since "l=
s -l" command also need to get .snapshot directory's attributes.
>>
>=20
> I still didn=E2=80=99t get which locks are involved in the dead lock part=
y.
> If that is not clear, it=E2=80=99s hard to review your patch further.
.snapshot inode dlm lock, the node has acquired this lock, then
acquire it again, this is a deadlock key point.


>=20
>=20
>> Why the the reflink process is blocked at ocfs2_init_security_and_acl+0x=
be/0x1d0? I feel it is caused by multiple acquiring the .snapshots director=
y inode dlm lock in ocfs2_reflink function. For the deeper reasons, it is p=
robably related to dlmglue layer or there is any factor which blocked .snap=
shots inode dlm lock to downconvert.
>=20
> I suggest you take tcpdump in your system and get clear what was going on=
.  So you can remove the words like =E2=80=9Cfeel=E2=80=9D or =E2=80=9Cprob=
ably=E2=80=9D next time.
> If the problem is in downconvert, we should fix that instead.
I think we can fix it via using one time acquire the lock before trying=20
to investigate further. In fact, this way also can improve the=20
performance in case the user run the reflink to clone file to the same=20
directory simultaneously.


Thanks
Gang

>=20
> thanks,
> wengang
>=20
>>
>> Thanks
>> Gang
>>
>>
>>
>>
>> On 2021/7/31 0:35, Wengang Wang wrote:
>>> Hi Gang,
>>>> On Jul 29, 2021, at 11:16 PM, Gang He <ghe@suse.com> wrote:
>>>>
>>>> Hello Wengang and all,
>>>>
>>>> This issue can be reproduced stably when you run the below reflink com=
mand line(maybe you also can follow a "rm this file" command line and  slee=
p some usecs) from each node repeatedly for a while.
>>>> Based on my observation, the reflink processes are always blocked at t=
he below points.
>>>>  From dlm_tool output and crash analysis, the node1 has acquired .snap=
shots directory inode EX dlm lock, but the reflink process is blocked at oc=
fs2_init_security_and_acl+0xbe/0x1d0 to acqure it's inode dlm lock again.
>>> So the reflink path on node 1 have .snapshots inode lock granted and is=
 blocking at the new created inode under orphan directory.  BTW, what=E2=80=
=99s .snapshots directory? What=E2=80=99s the call path to lock that .snaps=
hots inode?
>>>> On the other two nodes, the reflink processes are blocked at acquire .=
snapshots directory inode dlm lock, then the whole file system is hung,
>>>> you can not list this file again.
>>> So there are reflink paths on the other two nodes blocking at .snapshot=
s inode. But what lock they are granted already?
>>> For a typical ABBA deadlock,
>>> path 1 granted lock A and blocks at lock B
>>> path 2 granted lock B and blocks at lock A
>>> Per your description, I see this:
>>> reflink path on node1  granted .snapshots lock and blocks at new inode =
lock
>>> reflnk paths on onde2/3 block at .snapshots lock.
>>> I don't see how deadlock formed=E2=80=A6 the new inode lock is granted =
to any of the reflink path on node2/3? how?
>>> thanks,
>>> wengang
>>>>
>>>> The problem looks like acquiring the destination direcory multiple dur=
ing ocfs2_reflink, dlm glue layer cannot downconvert lock in some case.
>>>> e.g.
>>>> kernel: (ocfs2dc-F50B203,1593,0):ocfs2_downconvert_lock:3674 ERROR: DL=
M error -16 while calling ocfs2_dlm_lock on resource M000000000000000004661=
c00000000
>>>> kernel: (ocfs2dc-F50B203,1593,0):ocfs2_unblock_lock:3918 ERROR: status=
 =3D -16
>>>> kernel: (ocfs2dc-F50B203,1593,0):ocfs2_process_blocked_lock:4317 ERROR=
: status =3D -16
>>>>
>>>> Then, I change the code to acquire this destination direcory dlm lock,=
 and hold the lock until the end of ocfs2_reflink function.
>>>> After this change, I did not encounter this hang problem again after l=
ots of testing. Second, I find the code change also improve reflink perform=
ance, since the code avoids the previous ping-pong effect.
>>>>
>>>> Thanks
>>>> Gang
>>>>
>>>>
>>>> On 2021/7/30 6:07, Wengang Wang wrote:
>>>>> Hi Gang,
>>>>> I=E2=80=99d suggest you list the call paths on the related nodes, Say=
 call path 1 on node one granted lock A and is requesting for lock B, at th=
e same time, path2 on node two granted lock B and now is requesting for loc=
k A.
>>>>> With that, the problem would be easier to understand.
>>>>> thanks,
>>>>> wengang
>>>>>> On Jul 29, 2021, at 4:02 AM, Gang He <ghe@suse.com> wrote:
>>>>>>
>>>>>> Running reflink from multiple nodes simultaneously to clone a file
>>>>>> to the same directory probably triggers a deadlock issue.
>>>>>> For example, there is a three node ocfs2 cluster, each node mounts
>>>>>> the ocfs2 file system to /mnt/shared, and run the reflink command
>>>>>> from each node repeatedly, like
>>>>>>   reflink "/mnt/shared/test" \
>>>>>>   "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
>>>>>> then, reflink command process will be hung on each node, and you
>>>>>> can't list this file system directory.
>>>>>> The problematic reflink command process is blocked at one node,
>>>>>> task:reflink         state:D stack:    0 pid: 1283 ppid:  4154
>>>>>> Call Trace:
>>>>>>   __schedule+0x2fd/0x750
>>>>>>   schedule+0x2f/0xa0
>>>>>>   schedule_timeout+0x1cc/0x310
>>>>>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>>>>>   ? 0xffffffffc0e3e000
>>>>>>   wait_for_completion+0xba/0x140
>>>>>>   ? wake_up_q+0xa0/0xa0
>>>>>>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>>>>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>>   ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>>>>>   ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>>>>>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>>>>   do_vfs_ioctl+0xa0/0x680
>>>>>>   ksys_ioctl+0x70/0x80
>>>>>>   __x64_sys_ioctl+0x16/0x20
>>>>>>   do_syscall_64+0x5b/0x1e0
>>>>>> The other reflink command processes are blocked at other nodes,
>>>>>> task:reflink         state:D stack:    0 pid:29759 ppid:  4088
>>>>>> Call Trace:
>>>>>>   __schedule+0x2fd/0x750
>>>>>>   schedule+0x2f/0xa0
>>>>>>   schedule_timeout+0x1cc/0x310
>>>>>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>>>>>   ? 0xffffffffc0b19000
>>>>>>   wait_for_completion+0xba/0x140
>>>>>>   ? wake_up_q+0xa0/0xa0
>>>>>>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>>>>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>>   ocfs2_mv_orphaned_inode_to_new+0x87/0x7e0 [ocfs2]
>>>>>>   ocfs2_reflink+0x335/0x4c0 [ocfs2]
>>>>>>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>>>>   do_vfs_ioctl+0xa0/0x680
>>>>>>   ksys_ioctl+0x70/0x80
>>>>>>   __x64_sys_ioctl+0x16/0x20
>>>>>>   do_syscall_64+0x5b/0x1e0
>>>>>> or
>>>>>> task:reflink         state:D stack:    0 pid:18465 ppid:  4156
>>>>>> Call Trace:
>>>>>>   __schedule+0x302/0x940
>>>>>>   ? usleep_range+0x80/0x80
>>>>>>   schedule+0x46/0xb0
>>>>>>   schedule_timeout+0xff/0x140
>>>>>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>>>>>   ? 0xffffffffc0c3b000
>>>>>>   __wait_for_common+0xb9/0x170
>>>>>>   __ocfs2_cluster_lock.constprop.0+0x1d6/0x860 [ocfs2]
>>>>>>   ? ocfs2_wait_for_recovery+0x49/0xd0 [ocfs2]
>>>>>>   ? ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>>>>>>   ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>>>>>>   ocfs2_inode_lock_tracker+0xf2/0x2b0 [ocfs2]
>>>>>>   ? dput+0x32/0x2f0
>>>>>>   ocfs2_permission+0x45/0xe0 [ocfs2]
>>>>>>   inode_permission+0xcc/0x170
>>>>>>   link_path_walk.part.0.constprop.0+0x2a2/0x380
>>>>>>   ? path_init+0x2c1/0x3f0
>>>>>>   path_parentat+0x3c/0x90
>>>>>>   filename_parentat+0xc1/0x1d0
>>>>>>   ? filename_lookup+0x138/0x1c0
>>>>>>   filename_create+0x43/0x160
>>>>>>   ocfs2_reflink_ioctl+0xe6/0x380 [ocfs2]
>>>>>>   ocfs2_ioctl+0x1ea/0x2c0 [ocfs2]
>>>>>>   ? do_sys_openat2+0x81/0x150
>>>>>>   __x64_sys_ioctl+0x82/0xb0
>>>>>>   do_syscall_64+0x61/0xb0
>>>>>>
>>>>>> The deadlock is caused by multiple acquiring the destination directo=
ry
>>>>>> inode dlm lock in ocfs2_reflink function, we should acquire this
>>>>>> directory inode dlm lock at the beginning, and hold this dlm lock un=
til
>>>>>> end of the function.
>>>>>>
>>>>>> Signed-off-by: Gang He <ghe@suse.com>
>>>>>> ---
>>>>>> fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
>>>>>> fs/ocfs2/namei.h        |  2 ++
>>>>>> fs/ocfs2/refcounttree.c | 15 +++++++++++----
>>>>>> fs/ocfs2/xattr.c        | 12 +-----------
>>>>>> fs/ocfs2/xattr.h        |  1 +
>>>>>> 5 files changed, 28 insertions(+), 34 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>>>>>> index 2c46ff6ba4ea..f8bbb22cc60b 100644
>>>>>> --- a/fs/ocfs2/namei.c
>>>>>> +++ b/fs/ocfs2/namei.c
>>>>>> @@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct=
 inode *dir,
>>>>>> }
>>>>>>
>>>>>> int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>>>> +				 struct buffer_head **dir_bh,
>>>>>> 				 int mode,
>>>>>> 				 struct inode **new_inode)
>>>>>> {
>>>>>> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inod=
e *dir,
>>>>>>
>>>>>> 	brelse(new_di_bh);
>>>>>>
>>>>>> -	if (!status)
>>>>>> -		*new_inode =3D inode;
>>>>>> -
>>>>>> 	ocfs2_free_dir_lookup_result(&orphan_insert);
>>>>>>
>>>>>> -	ocfs2_inode_unlock(dir, 1);
>>>>>> -	brelse(parent_di_bh);
>>>>>> +	if (!status) {
>>>>>> +		*new_inode =3D inode;
>>>>>> +		*dir_bh =3D parent_di_bh;
>>>>>> +	} else {
>>>>>> +		ocfs2_inode_unlock(dir, 1);
>>>>>> +		brelse(parent_di_bh);
>>>>>> +	}
>>>>>> +
>>>>>> 	return status;
>>>>>> }
>>>>>>
>>>>>> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2=
_super *osb,
>>>>>> }
>>>>>>
>>>>>> int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>>>> +				   struct buffer_head *dir_bh,
>>>>>> 				   struct inode *inode,
>>>>>> 				   struct dentry *dentry)
>>>>>> {
>>>>>> 	int status =3D 0;
>>>>>> -	struct buffer_head *parent_di_bh =3D NULL;
>>>>>> 	handle_t *handle =3D NULL;
>>>>>> 	struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
>>>>>> 	struct ocfs2_dinode *dir_di, *di;
>>>>>> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct ino=
de *dir,
>>>>>> 				(unsigned long long)OCFS2_I(dir)->ip_blkno,
>>>>>> 				(unsigned long long)OCFS2_I(inode)->ip_blkno);
>>>>>>
>>>>>> -	status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
>>>>>> -	if (status < 0) {
>>>>>> -		if (status !=3D -ENOENT)
>>>>>> -			mlog_errno(status);
>>>>>> -		return status;
>>>>>> -	}
>>>>>> -
>>>>>> -	dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
>>>>>> +	dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
>>>>>> 	if (!dir_di->i_links_count) {
>>>>>> 		/* can't make a file in a deleted directory. */
>>>>>> 		status =3D -ENOENT;
>>>>>> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inod=
e *dir,
>>>>>> 		goto leave;
>>>>>>
>>>>>> 	/* get a spot inside the dir. */
>>>>>> -	status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
>>>>>> +	status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>>>>>> 					      dentry->d_name.name,
>>>>>> 					      dentry->d_name.len, &lookup);
>>>>>> 	if (status < 0) {
>>>>>> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inod=
e *dir,
>>>>>> 	ocfs2_journal_dirty(handle, di_bh);
>>>>>>
>>>>>> 	status =3D ocfs2_add_entry(handle, dentry, inode,
>>>>>> -				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
>>>>>> +				 OCFS2_I(inode)->ip_blkno, dir_bh,
>>>>>> 				 &lookup);
>>>>>> 	if (status < 0) {
>>>>>> 		mlog_errno(status);
>>>>>> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct ino=
de *dir,
>>>>>> 	iput(orphan_dir_inode);
>>>>>> leave:
>>>>>>
>>>>>> -	ocfs2_inode_unlock(dir, 1);
>>>>>> -
>>>>>> 	brelse(di_bh);
>>>>>> -	brelse(parent_di_bh);
>>>>>> 	brelse(orphan_dir_bh);
>>>>>>
>>>>>> 	ocfs2_free_dir_lookup_result(&lookup);
>>>>>> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
>>>>>> index 9cc891eb874e..03a2c526e2c1 100644
>>>>>> --- a/fs/ocfs2/namei.h
>>>>>> +++ b/fs/ocfs2/namei.h
>>>>>> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>>>>>> 		     struct buffer_head *orphan_dir_bh,
>>>>>> 		     bool dio);
>>>>>> int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>>>> +				 struct buffer_head **dir_bh,
>>>>>> 				 int mode,
>>>>>> 				 struct inode **new_inode);
>>>>>> int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
>>>>>> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super=
 *osb,
>>>>>> 		struct inode *inode, struct buffer_head *di_bh,
>>>>>> 		int update_isize, loff_t end);
>>>>>> int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>>>> +				   struct buffer_head *dir_bh,
>>>>>> 				   struct inode *new_inode,
>>>>>> 				   struct dentry *new_dentry);
>>>>>>
>>>>>> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>>>>>> index 7f6355cbb587..a9a0c7c37e8e 100644
>>>>>> --- a/fs/ocfs2/refcounttree.c
>>>>>> +++ b/fs/ocfs2/refcounttree.c
>>>>>> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_de=
ntry, struct inode *dir,
>>>>>> {
>>>>>> 	int error, had_lock;
>>>>>> 	struct inode *inode =3D d_inode(old_dentry);
>>>>>> -	struct buffer_head *old_bh =3D NULL;
>>>>>> +	struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
>>>>>> 	struct inode *new_orphan_inode =3D NULL;
>>>>>> 	struct ocfs2_lock_holder oh;
>>>>>>
>>>>>> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_de=
ntry, struct inode *dir,
>>>>>> 		return -EOPNOTSUPP;
>>>>>>
>>>>>>
>>>>>> -	error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
>>>>>> +	error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode=
,
>>>>>> 					     &new_orphan_inode);
>>>>>> 	if (error) {
>>>>>> 		mlog_errno(error);
>>>>>> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_=
dentry, struct inode *dir,
>>>>>>
>>>>>> 	/* If the security isn't preserved, we need to re-initialize them. =
*/
>>>>>> 	if (!preserve) {
>>>>>> -		error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
>>>>>> +		error =3D ocfs2_init_security_and_acl(dir, dir_bh,
>>>>>> +						    new_orphan_inode,
>>>>>> 						    &new_dentry->d_name);
>>>>>> 		if (error)
>>>>>> 			mlog_errno(error);
>>>>>> 	}
>>>>>> 	if (!error) {
>>>>>> -		error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
>>>>>> +		error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
>>>>>> +						       new_orphan_inode,
>>>>>> 						       new_dentry);
>>>>>> 		if (error)
>>>>>> 			mlog_errno(error);
>>>>>> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_d=
entry, struct inode *dir,
>>>>>> 			iput(new_orphan_inode);
>>>>>> 	}
>>>>>>
>>>>>> +	if (dir_bh) {
>>>>>> +		ocfs2_inode_unlock(dir, 1);
>>>>>> +		brelse(dir_bh);
>>>>>> +	}
>>>>>> +
>>>>>> 	return error;
>>>>>> }
>>>>>>
>>>>>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>>>>>> index dd784eb0cd7c..3f23e3a5018c 100644
>>>>>> --- a/fs/ocfs2/xattr.c
>>>>>> +++ b/fs/ocfs2/xattr.c
>>>>>> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_i=
node,
>>>>>> /*
>>>>>>   * Initialize security and acl for a already created inode.
>>>>>>   * Used for reflink a non-preserve-security file.
>>>>>> - *
>>>>>> - * It uses common api like ocfs2_xattr_set, so the caller
>>>>>> - * must not hold any lock expect i_mutex.
>>>>>>   */
>>>>>> int ocfs2_init_security_and_acl(struct inode *dir,
>>>>>> +				struct buffer_head *dir_bh,
>>>>>> 				struct inode *inode,
>>>>>> 				const struct qstr *qstr)
>>>>>> {
>>>>>> 	int ret =3D 0;
>>>>>> -	struct buffer_head *dir_bh =3D NULL;
>>>>>>
>>>>>> 	ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
>>>>>> 	if (ret) {
>>>>>> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode=
 *dir,
>>>>>> 		goto leave;
>>>>>> 	}
>>>>>>
>>>>>> -	ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
>>>>>> -	if (ret) {
>>>>>> -		mlog_errno(ret);
>>>>>> -		goto leave;
>>>>>> -	}
>>>>>> 	ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
>>>>>> 	if (ret)
>>>>>> 		mlog_errno(ret);
>>>>>>
>>>>>> -	ocfs2_inode_unlock(dir, 0);
>>>>>> -	brelse(dir_bh);
>>>>>> leave:
>>>>>> 	return ret;
>>>>>> }
>>>>>> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
>>>>>> index 00308b57f64f..b27fd8ba0019 100644
>>>>>> --- a/fs/ocfs2/xattr.h
>>>>>> +++ b/fs/ocfs2/xattr.h
>>>>>> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>>>>>> 			 struct buffer_head *new_bh,
>>>>>> 			 bool preserve_security);
>>>>>> int ocfs2_init_security_and_acl(struct inode *dir,
>>>>>> +				struct buffer_head *dir_bh,
>>>>>> 				struct inode *inode,
>>>>>> 				const struct qstr *qstr);
>>>>>> #endif /* OCFS2_XATTR_H */
>>>>>> --=20
>>>>>> 2.21.0
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Ocfs2-devel mailing list
>>>>>> Ocfs2-devel@oss.oracle.com
>>>>>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>>>
>>
>=20

