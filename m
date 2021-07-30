Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9731F3DB365
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhG3GRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:17:00 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:29934 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237004AbhG3GQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627625813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MytfwjFGXohlB4tMB0kHFHPxd93nnSd1nNi1WhQewoY=;
        b=WqdCY7vL8zcS3LD5bf9ty4d6TRnyicmifeGXIYSWFjjhcmtPOKZZ9sqRyNTaadK+mQI8BH
        sp2+kzvCX0DiI8L3sJxUZiBv/lpW9b5iWgiYlR7bymTVstzk/w9SXnHS2wD1TtCRSgdABZ
        a/IAoL88vhXJ7yUVhhJJEMb3Nhnn6Ho=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-pcU9r-IXNOCGC2iZhHlHxA-1; Fri, 30 Jul 2021 08:16:51 +0200
X-MC-Unique: pcU9r-IXNOCGC2iZhHlHxA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzJMZIc5xXpYIKNEtTvQLwjYiMpUxOZk3PWeTY77GT7NbiXdlm8tW/jzEVZq7+4TBCs3nJUZAkhgBz5OEiIG4BAfnEK/qCPWc93kiHp4lFBUUqolJMeqR1USNwDEqvMudXFLWptJErjkhZvvX4JOev2HSsGhdHjxWhbIKDtRal2MTwvpbrmdghqzFUT+2JjBQBq6RBqv7H8YCmbeIoQb4xy1mAYis6yE37HE6DubL99DzSCaMoGgNdo4l7veaX0ghy7ZL1/PFfFvAd6PH1feJ5ebIxUAqcIc3u6xHDs/UKjSYelhgWYOC5/wXGgtX1mVNWVwR0ti9W//Xp3DUqaXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4/zNAz2nrYp2hzYpMlI3fpjBMDXkhcaH+P4eBlgwIQ=;
 b=lAZUi5f7RxljO3Ld+5Ay9lCv9XrmECB40G1ti7l5aDoxf069cLMULLbTyjT9k5xW9jNqNsS8OCtIZ26S+v+VREvrJDPIREeSVoEs4eteQ/55LjuCAS21YAcTZalcKhUt+2mMUi+cfInwnADS7tUBhC2WQvnTsGGZykXDq2RhJK5xT1A5XY1AEswudxNnGOf5cN4l2reCQ66YXZM6CkcMlWs1jGXDefFVyTAdozvaa+3ressVaCHNbjZiLwjtnCA7dfKNeZF18hpVC923XxDLZ3VJETdywdBDcEPxfXUxva6ci+SKtmpHnq2kn37yZqH2Nr/vlmPmQ5GuiJX+tzN3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM5PR04MB3075.eurprd04.prod.outlook.com (2603:10a6:206:b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 06:16:51 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::b973:ec65:6b36:1eaa]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::b973:ec65:6b36:1eaa%6]) with mapi id 15.20.4373.019; Fri, 30 Jul 2021
 06:16:50 +0000
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
From:   Gang He <ghe@suse.com>
Message-ID: <a3260130-23a6-ef9d-5b9d-0eaafcd3a217@suse.com>
Date:   Fri, 30 Jul 2021 14:16:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <F991B5E2-136D-406C-A180-C253B1742120@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 06:16:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb18d69-2335-472b-01a6-08d953219e72
X-MS-TrafficTypeDiagnostic: AM5PR04MB3075:
X-Microsoft-Antispam-PRVS: <AM5PR04MB3075F3DF307222CE24C4B02ECFEC9@AM5PR04MB3075.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWYR7ccRZ3OMCmZNQzWGhWVauGBXQ2J8eVbO9v0rihcTwFspRG/pCsrg8xnP7dvJY/vjekcHG8mnHHcbS2Jf4LXqhjbGlxdSHOBymGZkCbkNQSr+lybjiUTSWOEMsAc56rf6mNp82AXYNE37MgjWQnV+5Prx6C572bDieN2+zcCM4Jr6VK2ASvzna+eGWcFwAwcQrBUNJDbB3enRR0kzkH6ZE6/O3AYthoV3EUjxO8PnYjH9cDcwxnyb3ZndHnA9OIBvxwZZFwUBkI9R3Q1HQ2sX8chWVAfBS1hfVwb+TFDr98iSZqhdDHwmXuOAq7QmfQgA0XCNw87cigXweFsIqLrNI+QCZFeC89WY7PcNCPxvv5BmR/2ynAQW0dpVMdQltCW7JNnkPE8qzcw5qlMOu0HfDLbnMkoZ+96F815f2YUc+1txBWIW6iaiko3ztnLCOh3Xpb7n+pFBPgEEA2PtsEez+Gz++Oq1E8RCApE/sxA1yLcMRH3DDMK+9zSLWpx/2kkkU3aTSfEhdIv+6I0hM3hvGazrHLPgCKnz2xt9dQm8qY3DlA20v5UaDaiH5HC1WeRhnksEMBGCRuRncJkK9Rm1egehOUlj6WOKF01fjivwe8GwkWIu4lM8K5VAPa7UJm37oPItee23Qq66YlBpKGniuUb8Q27yQE7dwQyw3Fi3wn/mE3lc7xDp5thbCWpRBPMCgIDnAckdy3U6Lov/IKY5+imkdd9B6KTxERA3sYZPK882VmfxctRWeTV9416+T1Y5gc1eWsdYV0hz8oOu1OnuS8y7d3xA9Y5cP5QpA8i7/b5iZsKZ+kxgaSjkqipO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39850400004)(366004)(136003)(376002)(86362001)(38100700002)(2906002)(66946007)(36756003)(66476007)(6666004)(4326008)(83380400001)(66556008)(6486002)(8936002)(6916009)(186003)(956004)(5660300002)(966005)(316002)(2616005)(8676002)(31696002)(54906003)(30864003)(26005)(16576012)(31686004)(478600001)(53546011)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PeLbf2+OiZ8U2MV0IF2QTU4DdKZDMxz6LAcEyxMn1x35PH2rd496qcyxTKSV?=
 =?us-ascii?Q?LkDbDHR1aufQIG4GBf0UQ+b4eG7qG85XnvK1Sj1iBAgea0upMM1/FbQMSko5?=
 =?us-ascii?Q?DBi8g9HiMnQPDcW4z6BuTVNsBvLOEFz5QbncNsY3AVp3vcI59ACC8RL9zfdB?=
 =?us-ascii?Q?CxTc1Y7b5ToHfdshY+8hCDB0qRhTehDf8S9dBH31Xosx7ecUKgWXS6MAD1Th?=
 =?us-ascii?Q?DRqP8bLAp9vQTL3Yq0uUvepsB3f49FeFu8QIEwj7i2PC2A4WXZ19Zeg5FC1u?=
 =?us-ascii?Q?0khx3ae5ZrDTNQshZhsXodIujXoxgelbnG9yztGNvxaMXoQDSWEZSSlWpTKJ?=
 =?us-ascii?Q?DB3IWMirLww8AwuGON32YCQox/7jQmW8oNaO3Oz3Gevxe5WfxvjzpDipkgAp?=
 =?us-ascii?Q?0uVh95484tx13w23A4IMtraGvVuho+tQmnnjymIrUiRRzk72lWPfix6DrUhI?=
 =?us-ascii?Q?sj1UOsXweQWmr1/JnruJqJyS+vrTwGBSoiew+DgKSH37cMhzbArfyRNlOheO?=
 =?us-ascii?Q?2VG+nbq/VtPnG1bltKwZBHTWTPxhXfgI+F8S7K89ssA1u14zs61pFHBcJvVy?=
 =?us-ascii?Q?/i7IW+52axKJUzscEQ/xGjwftpMemmZrJ8WXB4edHeaIu+IwI//QLwm/4nsd?=
 =?us-ascii?Q?wncPAS3ssfpeIe3LhHTLX1zdhU/7XQ05e8OFKp8pASdUj2yMt6FTuzlAbRA2?=
 =?us-ascii?Q?Z6Uf2133wd2XGjGb5rC8TcLmNlFT0lf6snUI4/fqGG/Jel/ED++WiekUKuN3?=
 =?us-ascii?Q?vrEFs7vG7NkUpHxU7Dy9QgcHaqcSV1niTFlX7XQ8bnPRU4kCTVa+FZ81AoKh?=
 =?us-ascii?Q?tMywB1tRCggwAOo1kuDOgSTyf5uwt8bEei6WCf23uV9GIveOxPwGLVmrnBKg?=
 =?us-ascii?Q?eL09ZXiNuri6e/Ct6GY1lAFIqg9K3OIx3fFWa8/xkkU3WM7DBysN14M6ikGp?=
 =?us-ascii?Q?TJ1CHnYDD9sojrKWtLN4kCe18D9I4Xx4dgWZMeLGAbX9s/zkV8sJoHOL5yRO?=
 =?us-ascii?Q?1DAsF70BkhzEgyElw0zfqbX2nBvsCU+EGm1BkEP4X0jX9Itd/X1zNRmrQILr?=
 =?us-ascii?Q?GTl0JZ/TxeaOxphPGgp8wjAY5U7pvZAhtnzw4K5/4h7k8hO7ZI4gn7NipCo4?=
 =?us-ascii?Q?B1rgxN1U62MSqrcIiSt0BpjULOlfyMPMCSFoBhBLUqCPW4m+xlDJFiufHy5/?=
 =?us-ascii?Q?djRdvRSVjhcTitWgd1wK6Vem4uTwm1r6lxETr9kCLl31fEHF1tUxJsgjev4t?=
 =?us-ascii?Q?aePGidU/Ox+8brF5yYauX6nHnJYEqjm1bydVUOIaInxJ0VnPhZS3onn0/VTd?=
 =?us-ascii?Q?4DB/DdY10gqiKANQm2ndYFNY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb18d69-2335-472b-01a6-08d953219e72
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 06:16:50.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qic9ipOe6B4MkBpnxAN+vLZIn8DSg2B1rpbf7wU0uLlKxWbfAn1v9YiJytogwqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wengang and all,

This issue can be reproduced stably when you run the below reflink=20
command line(maybe you also can follow a "rm this file" command line and=20
  sleep some usecs) from each node repeatedly for a while.
Based on my observation, the reflink processes are always blocked at the=20
below points.
 From dlm_tool output and crash analysis, the node1 has acquired=20
.snapshots directory inode EX dlm lock, but the reflink process is=20
blocked at ocfs2_init_security_and_acl+0xbe/0x1d0 to acqure it's inode=20
dlm lock again.
On the other two nodes, the reflink processes are blocked at acquire=20
.snapshots directory inode dlm lock, then the whole file system is hung,
you can not list this file again.

The problem looks like acquiring the destination direcory multiple=20
during ocfs2_reflink, dlm glue layer cannot downconvert lock in some case.
e.g.
kernel: (ocfs2dc-F50B203,1593,0):ocfs2_downconvert_lock:3674 ERROR: DLM=20
error -16 while calling ocfs2_dlm_lock on resource=20
M000000000000000004661c00000000
kernel: (ocfs2dc-F50B203,1593,0):ocfs2_unblock_lock:3918 ERROR: status =3D =
-16
kernel: (ocfs2dc-F50B203,1593,0):ocfs2_process_blocked_lock:4317 ERROR:=20
status =3D -16

Then, I change the code to acquire this destination direcory dlm lock,=20
and hold the lock until the end of ocfs2_reflink function.
After this change, I did not encounter this hang problem again after=20
lots of testing. Second, I find the code change also improve reflink=20
performance, since the code avoids the previous ping-pong effect.

Thanks
Gang


On 2021/7/30 6:07, Wengang Wang wrote:
> Hi Gang,
>=20
> I=E2=80=99d suggest you list the call paths on the related nodes, Say cal=
l path 1 on node one granted lock A and is requesting for lock B, at the sa=
me time, path2 on node two granted lock B and now is requesting for lock A.
> With that, the problem would be easier to understand.
>=20
> thanks,
> wengang
>=20
>> On Jul 29, 2021, at 4:02 AM, Gang He <ghe@suse.com> wrote:
>>
>> Running reflink from multiple nodes simultaneously to clone a file
>> to the same directory probably triggers a deadlock issue.
>> For example, there is a three node ocfs2 cluster, each node mounts
>> the ocfs2 file system to /mnt/shared, and run the reflink command
>> from each node repeatedly, like
>>   reflink "/mnt/shared/test" \
>>   "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
>> then, reflink command process will be hung on each node, and you
>> can't list this file system directory.
>> The problematic reflink command process is blocked at one node,
>> task:reflink         state:D stack:    0 pid: 1283 ppid:  4154
>> Call Trace:
>>   __schedule+0x2fd/0x750
>>   schedule+0x2f/0xa0
>>   schedule_timeout+0x1cc/0x310
>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>   ? 0xffffffffc0e3e000
>>   wait_for_completion+0xba/0x140
>>   ? wake_up_q+0xa0/0xa0
>>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>   ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>   ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>   do_vfs_ioctl+0xa0/0x680
>>   ksys_ioctl+0x70/0x80
>>   __x64_sys_ioctl+0x16/0x20
>>   do_syscall_64+0x5b/0x1e0
>> The other reflink command processes are blocked at other nodes,
>> task:reflink         state:D stack:    0 pid:29759 ppid:  4088
>> Call Trace:
>>   __schedule+0x2fd/0x750
>>   schedule+0x2f/0xa0
>>   schedule_timeout+0x1cc/0x310
>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>   ? 0xffffffffc0b19000
>>   wait_for_completion+0xba/0x140
>>   ? wake_up_q+0xa0/0xa0
>>   __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>   ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>   ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>   ocfs2_mv_orphaned_inode_to_new+0x87/0x7e0 [ocfs2]
>>   ocfs2_reflink+0x335/0x4c0 [ocfs2]
>>   ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>   ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>   ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>   do_vfs_ioctl+0xa0/0x680
>>   ksys_ioctl+0x70/0x80
>>   __x64_sys_ioctl+0x16/0x20
>>   do_syscall_64+0x5b/0x1e0
>> or
>> task:reflink         state:D stack:    0 pid:18465 ppid:  4156
>> Call Trace:
>>   __schedule+0x302/0x940
>>   ? usleep_range+0x80/0x80
>>   schedule+0x46/0xb0
>>   schedule_timeout+0xff/0x140
>>   ? ocfs2_control_cfu+0x50/0x50 [ocfs2_stack_user]
>>   ? 0xffffffffc0c3b000
>>   __wait_for_common+0xb9/0x170
>>   __ocfs2_cluster_lock.constprop.0+0x1d6/0x860 [ocfs2]
>>   ? ocfs2_wait_for_recovery+0x49/0xd0 [ocfs2]
>>   ? ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>>   ocfs2_inode_lock_full_nested+0x30f/0xa50 [ocfs2]
>>   ocfs2_inode_lock_tracker+0xf2/0x2b0 [ocfs2]
>>   ? dput+0x32/0x2f0
>>   ocfs2_permission+0x45/0xe0 [ocfs2]
>>   inode_permission+0xcc/0x170
>>   link_path_walk.part.0.constprop.0+0x2a2/0x380
>>   ? path_init+0x2c1/0x3f0
>>   path_parentat+0x3c/0x90
>>   filename_parentat+0xc1/0x1d0
>>   ? filename_lookup+0x138/0x1c0
>>   filename_create+0x43/0x160
>>   ocfs2_reflink_ioctl+0xe6/0x380 [ocfs2]
>>   ocfs2_ioctl+0x1ea/0x2c0 [ocfs2]
>>   ? do_sys_openat2+0x81/0x150
>>   __x64_sys_ioctl+0x82/0xb0
>>   do_syscall_64+0x61/0xb0
>>
>> The deadlock is caused by multiple acquiring the destination directory
>> inode dlm lock in ocfs2_reflink function, we should acquire this
>> directory inode dlm lock at the beginning, and hold this dlm lock until
>> end of the function.
>>
>> Signed-off-by: Gang He <ghe@suse.com>
>> ---
>> fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
>> fs/ocfs2/namei.h        |  2 ++
>> fs/ocfs2/refcounttree.c | 15 +++++++++++----
>> fs/ocfs2/xattr.c        | 12 +-----------
>> fs/ocfs2/xattr.h        |  1 +
>> 5 files changed, 28 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>> index 2c46ff6ba4ea..f8bbb22cc60b 100644
>> --- a/fs/ocfs2/namei.c
>> +++ b/fs/ocfs2/namei.c
>> @@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct ino=
de *dir,
>> }
>>
>> int ocfs2_create_inode_in_orphan(struct inode *dir,
>> +				 struct buffer_head **dir_bh,
>> 				 int mode,
>> 				 struct inode **new_inode)
>> {
>> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inode *d=
ir,
>>
>> 	brelse(new_di_bh);
>>
>> -	if (!status)
>> -		*new_inode =3D inode;
>> -
>> 	ocfs2_free_dir_lookup_result(&orphan_insert);
>>
>> -	ocfs2_inode_unlock(dir, 1);
>> -	brelse(parent_di_bh);
>> +	if (!status) {
>> +		*new_inode =3D inode;
>> +		*dir_bh =3D parent_di_bh;
>> +	} else {
>> +		ocfs2_inode_unlock(dir, 1);
>> +		brelse(parent_di_bh);
>> +	}
>> +
>> 	return status;
>> }
>>
>> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_sup=
er *osb,
>> }
>>
>> int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>> +				   struct buffer_head *dir_bh,
>> 				   struct inode *inode,
>> 				   struct dentry *dentry)
>> {
>> 	int status =3D 0;
>> -	struct buffer_head *parent_di_bh =3D NULL;
>> 	handle_t *handle =3D NULL;
>> 	struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
>> 	struct ocfs2_dinode *dir_di, *di;
>> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *=
dir,
>> 				(unsigned long long)OCFS2_I(dir)->ip_blkno,
>> 				(unsigned long long)OCFS2_I(inode)->ip_blkno);
>>
>> -	status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
>> -	if (status < 0) {
>> -		if (status !=3D -ENOENT)
>> -			mlog_errno(status);
>> -		return status;
>> -	}
>> -
>> -	dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
>> +	dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
>> 	if (!dir_di->i_links_count) {
>> 		/* can't make a file in a deleted directory. */
>> 		status =3D -ENOENT;
>> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *d=
ir,
>> 		goto leave;
>>
>> 	/* get a spot inside the dir. */
>> -	status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
>> +	status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>> 					      dentry->d_name.name,
>> 					      dentry->d_name.len, &lookup);
>> 	if (status < 0) {
>> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *d=
ir,
>> 	ocfs2_journal_dirty(handle, di_bh);
>>
>> 	status =3D ocfs2_add_entry(handle, dentry, inode,
>> -				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
>> +				 OCFS2_I(inode)->ip_blkno, dir_bh,
>> 				 &lookup);
>> 	if (status < 0) {
>> 		mlog_errno(status);
>> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *=
dir,
>> 	iput(orphan_dir_inode);
>> leave:
>>
>> -	ocfs2_inode_unlock(dir, 1);
>> -
>> 	brelse(di_bh);
>> -	brelse(parent_di_bh);
>> 	brelse(orphan_dir_bh);
>>
>> 	ocfs2_free_dir_lookup_result(&lookup);
>> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
>> index 9cc891eb874e..03a2c526e2c1 100644
>> --- a/fs/ocfs2/namei.h
>> +++ b/fs/ocfs2/namei.h
>> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>> 		     struct buffer_head *orphan_dir_bh,
>> 		     bool dio);
>> int ocfs2_create_inode_in_orphan(struct inode *dir,
>> +				 struct buffer_head **dir_bh,
>> 				 int mode,
>> 				 struct inode **new_inode);
>> int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
>> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *os=
b,
>> 		struct inode *inode, struct buffer_head *di_bh,
>> 		int update_isize, loff_t end);
>> int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>> +				   struct buffer_head *dir_bh,
>> 				   struct inode *new_inode,
>> 				   struct dentry *new_dentry);
>>
>> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>> index 7f6355cbb587..a9a0c7c37e8e 100644
>> --- a/fs/ocfs2/refcounttree.c
>> +++ b/fs/ocfs2/refcounttree.c
>> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_dentry=
, struct inode *dir,
>> {
>> 	int error, had_lock;
>> 	struct inode *inode =3D d_inode(old_dentry);
>> -	struct buffer_head *old_bh =3D NULL;
>> +	struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
>> 	struct inode *new_orphan_inode =3D NULL;
>> 	struct ocfs2_lock_holder oh;
>>
>> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_dentry=
, struct inode *dir,
>> 		return -EOPNOTSUPP;
>>
>>
>> -	error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
>> +	error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode,
>> 					     &new_orphan_inode);
>> 	if (error) {
>> 		mlog_errno(error);
>> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_dent=
ry, struct inode *dir,
>>
>> 	/* If the security isn't preserved, we need to re-initialize them. */
>> 	if (!preserve) {
>> -		error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
>> +		error =3D ocfs2_init_security_and_acl(dir, dir_bh,
>> +						    new_orphan_inode,
>> 						    &new_dentry->d_name);
>> 		if (error)
>> 			mlog_errno(error);
>> 	}
>> 	if (!error) {
>> -		error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
>> +		error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
>> +						       new_orphan_inode,
>> 						       new_dentry);
>> 		if (error)
>> 			mlog_errno(error);
>> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_dentr=
y, struct inode *dir,
>> 			iput(new_orphan_inode);
>> 	}
>>
>> +	if (dir_bh) {
>> +		ocfs2_inode_unlock(dir, 1);
>> +		brelse(dir_bh);
>> +	}
>> +
>> 	return error;
>> }
>>
>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>> index dd784eb0cd7c..3f23e3a5018c 100644
>> --- a/fs/ocfs2/xattr.c
>> +++ b/fs/ocfs2/xattr.c
>> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_inode=
,
>> /*
>>   * Initialize security and acl for a already created inode.
>>   * Used for reflink a non-preserve-security file.
>> - *
>> - * It uses common api like ocfs2_xattr_set, so the caller
>> - * must not hold any lock expect i_mutex.
>>   */
>> int ocfs2_init_security_and_acl(struct inode *dir,
>> +				struct buffer_head *dir_bh,
>> 				struct inode *inode,
>> 				const struct qstr *qstr)
>> {
>> 	int ret =3D 0;
>> -	struct buffer_head *dir_bh =3D NULL;
>>
>> 	ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
>> 	if (ret) {
>> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode *di=
r,
>> 		goto leave;
>> 	}
>>
>> -	ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
>> -	if (ret) {
>> -		mlog_errno(ret);
>> -		goto leave;
>> -	}
>> 	ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
>> 	if (ret)
>> 		mlog_errno(ret);
>>
>> -	ocfs2_inode_unlock(dir, 0);
>> -	brelse(dir_bh);
>> leave:
>> 	return ret;
>> }
>> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
>> index 00308b57f64f..b27fd8ba0019 100644
>> --- a/fs/ocfs2/xattr.h
>> +++ b/fs/ocfs2/xattr.h
>> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>> 			 struct buffer_head *new_bh,
>> 			 bool preserve_security);
>> int ocfs2_init_security_and_acl(struct inode *dir,
>> +				struct buffer_head *dir_bh,
>> 				struct inode *inode,
>> 				const struct qstr *qstr);
>> #endif /* OCFS2_XATTR_H */
>> --=20
>> 2.21.0
>>
>>
>> _______________________________________________
>> Ocfs2-devel mailing list
>> Ocfs2-devel@oss.oracle.com
>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>=20

