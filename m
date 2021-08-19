Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC13F1393
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhHSGci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:32:38 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:33828 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231292AbhHSGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629354711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2heOI5sYgK0aesScz8tswm+07Mjhqf7Lmae8C/Qc594=;
        b=E7fNf1Xf1YMknk5kPXxjpUB4ImcYBG4LBCUVkvsbHWYdWNZZQaEC6XNXDEcqe/KKIfaGR4
        3Q6O1XmbNYpe7+3EddIwxl634x3QRsGNfHOjB45yiT29Smi4y2I/qd2Gw93oLYd/KxJzxV
        15X58/71mbTWgvvg2oy3S8SWxdHaPvY=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-BFRLM51iNAuSdXxmDWggug-1; Thu, 19 Aug 2021 08:31:50 +0200
X-MC-Unique: BFRLM51iNAuSdXxmDWggug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gveH/yfS61tJaTZlUa20lYsKf5aq8RTkTVjP/M9bB++2AMLrxXVbt8d6V4i5vxPdl4tijkJJq4YuX2bgPbtDU75KTvmqCXqnbYyysknurBn7Y9+1Wy9JZzz54hrfjeiVvvWv6G+T4APJj3wLZtk9JkKzkSFnM3fW3XSgUGR4xi6IH9r3E+vwsWBWyi0FoMhOuXbVHqIObL9SqcCTVTDaxaD/xTqU/hJRzClTAj+G34DiSs342AXH231zQPjWqKmjRENn1YWDgfpinGqn4dizCY4n40mkm1fLxKL5o76H6nVL3E/3CBGooS0Ls83fv/c1tP8K+HrkGPtbPfSsQaqa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLJV0QgvtZh5aOuNO8Qm4aCuyLBV0FiSMgp72g7+A3E=;
 b=P1YHzh0P6NzPx02Y+JGrBPT7H4PduBk4K56Oy2vokWv819x111uqCBIcAUFreskByOx3og4uIjmCwEs+R045Xx8+rOxM06GSEROS4OQBvjFvPxKBrE2gFnsKRZ7jrzOQZGlkHPzYYMFleIT5qPXIqPq3PnxXfV/j+/RV+YxUCSenFhKwaPoxL/nYesdClNv9KXw96f6n53pjfZJ0lGu2alaQApFStLGd5h+etBXm5IFQM+Q5qhsKSYR1MaHKppEBVX13rhp1YxMP1oFTa2CUggUmDksxQIhc9Tg1wZCGCyIWnLTZUD+0ra6lv+Dh6i3mb/POhMbKNOH2tGickDwF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 06:31:48 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 06:31:48 +0000
Subject: Re: [PATCH] ocfs2: reflink deadlock when clone file to the same
 directory simultaneously
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org, Wengang Wang <wen.gang.wang@oracle.com>
CC:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210729110230.18983-1-ghe@suse.com>
 <5821fd0f-2018-dc1b-a5c0-f948a7debff4@linux.alibaba.com>
 <c7e1f0a7-e75c-d1e0-870d-dc480d070079@suse.com>
 <71608a14-58f4-dba0-d695-fee65de89192@linux.alibaba.com>
 <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
 <86e3d724-3147-ccaa-998f-0f857c575f7e@linux.alibaba.com>
 <a0a9710f-461a-99c8-92f6-a99bb11b3a4e@suse.com>
 <4ba3b404-824b-90a3-ef43-9ab6510ee073@linux.alibaba.com>
From:   Gang He <ghe@suse.com>
Message-ID: <5a1af56c-3eab-5baf-62a3-1c98bac104ba@suse.com>
Date:   Thu, 19 Aug 2021 14:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4ba3b404-824b-90a3-ef43-9ab6510ee073@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 06:31:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a6cf74-90fd-424c-3cef-08d962db05ae
X-MS-TrafficTypeDiagnostic: AM7PR04MB6886:
X-Microsoft-Antispam-PRVS: <AM7PR04MB688618AC8FB53317D197130ACFC09@AM7PR04MB6886.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99WYJmx/6YCbE/AbUQPDD9VV1jtukCN58nXqbDlUg9yEhNCkMj7WrPUjFHUn05QZBw5J5IlRD/VRzGWpLhJXONm33Dttc0DdfjWjexoZoGZAewPSPqWNvQgaNt1M5fVOalr23G4XEPDFH3rrdTt6qH5RiBxn7kEBC70UW3e+zFAV3NiW6MxqGnYGa0Nj1PeDvWvPjW4Riiwrja0Q2Kpal1zpuNcS2QIm3/Y4LavtuaD6LwGdiZ7z5CjctMassB93iLCk1MLAyoU77K+0bneCUY2QwyPYsZJhiebLlcBiNe8e+AeVWuLKbLAGCdaq17xNv7B2DZRMBW1EWGR0dZUpVZABt/TuMKTCVQ2d31hncOI/NrJnRodWdNclXt01sxkx5gYapzxnTdv0QOFvrQDN89a9Wli7vluk/9GNxbMNlud6mrYhRYV+8AYVAknk5NRkcfJ721zA4AUyOwgY9yd6DlIwCurhR3E9pnM6mn8sjKrkI/fve7HdlgGN5EF510n0r9yJjhuvbuZmbfVw4E0F1g71V3410GZR6waoArNKo1c50O+oV0kXcBHOGzqCl8YrA2/temAgOrHiAMezngIRX5mdp1uXj8pmC7/3jIN8Fc21QzIGcB0YrV4DGPGCom+wOIoZR8pAI2xJl5Od+dYlv4z7u8zTq9DXGJHiYDLVFlyKoRatYqmuk+OTWFQGAPvaazlxYYWRJtguySCEYGuKAwsjBhXUUuS7G1qQbl38SGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(8676002)(6486002)(6666004)(66946007)(16576012)(5660300002)(38100700002)(478600001)(83380400001)(31686004)(8936002)(110136005)(31696002)(26005)(36756003)(316002)(55236004)(2906002)(4326008)(66476007)(53546011)(66556008)(186003)(2616005)(86362001)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQT3wWC3QZ6s0K2e/n9388s62N4lq5U2Q+QVt53j0AuWEuqNFiadi9p/jOJh?=
 =?us-ascii?Q?yNA4AnfDPjcHHDta2thygts0tR2eaFNVTLCE8YOlA88ikhalP6MojFrCxpCl?=
 =?us-ascii?Q?nOrL5tKMiWCyq6H6zq1Ry3jvQkloL+BbQXfIDNp8l78h8iuL/2Rkt/zKhjAz?=
 =?us-ascii?Q?VLB5c+0x0l7qgBffTah9rAU51KRDEcgKobYqPA9+9JXVW6wxQSlJF6Ul9XHv?=
 =?us-ascii?Q?0uMjmx8WNsklJ4bU7LxMGomPd9GS8J5xeeCPvRxlG2xdJuyCym8JZ/r84v4P?=
 =?us-ascii?Q?twPHSRZkw6DnAay2LHr95cnlzXWES1KJOT8HopjAbFbU5Bu0rHFD+cKZVG2G?=
 =?us-ascii?Q?ufM0Wsm2OKTUESoR+zHnF2mpjpmGhaWiVkajrIOvF5+6XYSMOktlz57rQVTR?=
 =?us-ascii?Q?C+frmwhYUdSIWiROLm1BnK53RyAuP8nUWwQKiy2X6pwLoK1qRofTBQyAkDSV?=
 =?us-ascii?Q?9UYF5Dyk1vFvzG+8eeuMLdO6EWOQBPX3STe6yKJlgxHZ3ehuSuz49dVtXIhg?=
 =?us-ascii?Q?Xo0FkCglnZasBAfSDz1VSV3p3ASYDLRxDIFiasgV8DdxFKKfqqQkWd1IK0By?=
 =?us-ascii?Q?8Vqy7noulqRiwutyxvl/7jFwzm7mNxkuxoOcQgzP8DyezcSEN5UX1I1dX/vx?=
 =?us-ascii?Q?5MzL/aHY0UpzxawlOuOGO6gINP4vl8565+wP4p/UD1RbSLzWUyus9dfgK9Do?=
 =?us-ascii?Q?pecZpKdCeAJGI0c3/cRf3XoRET86djyLQ7RIpGXz7wrYQJGAhDBU7ttiuwRr?=
 =?us-ascii?Q?FaAV0+9GAQg3rYlK2HtBElgoqz+uZVOZIcGpeTpLhpuitiXTSwlBxSGFLQvc?=
 =?us-ascii?Q?JWbNnUOlJDPXRqarjLcOBasnTPCD1QSm3aDnLhmjLtN/yWLjWz4BAaO7Cqx4?=
 =?us-ascii?Q?btQfWvLWE4ritAcSXe8TUe9el5OFpM6pisXL8xyxUXj5MwjFV5YBFxAqt6A6?=
 =?us-ascii?Q?p131WzrIu/N9DlpvjxzdILgUzPfPGoUDNJRNyc4hJ8BG2RplcShZS17hGRcg?=
 =?us-ascii?Q?Kc5rrUy6Wm7wdrjmEnCFn0jLJlijoS+Uc5QvbH4qbjD2ivkrc6GVN3snnVpj?=
 =?us-ascii?Q?HuF5veZwwxaSPMBy9FjQFPW1hAUGFzmcj7eFtRv6baV/nuUgQ5XdGUIYOXnQ?=
 =?us-ascii?Q?O3PeqyfsQIRLtEEnbkhCbN+GnErgwnWg2lf1I3r/75e79xoABeWkO2eycrNs?=
 =?us-ascii?Q?jKsew4I5BhlGkPa0Xgy1US7yFFrjRCe023wxKjCGOgtSRllSYK0vU2PfPzng?=
 =?us-ascii?Q?XOKLPEClORm7cTlTOvbNLEBvLgxqV13BHED9gbJPN5ACbUb0FofdsL4g6AJH?=
 =?us-ascii?Q?2uY2vJAWmkiHJJ/ydQhH1xRl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a6cf74-90fd-424c-3cef-08d962db05ae
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 06:31:48.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUS1G70GLYHwfOSdFYoLGoYSGxLy3wItqDVv2o/DMJJqclpjEM0Rrkdx7bp48y4+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/19 10:02, Joseph Qi wrote:
>=20
>=20
> On 8/19/21 9:51 AM, Gang He wrote:
>>
>>
>> On 2021/8/18 19:20, Joseph Qi wrote:
>>>
>>>
>>> On 8/18/21 5:20 PM, Gang He wrote:
>>>>
>>>>
>>>> On 2021/8/13 17:54, Joseph Qi wrote:
>>>>>
>>>>>
>>>>> On 8/9/21 6:08 PM, Gang He wrote:
>>>>>> Hi Joseph and All,
>>>>>>
>>>>>> The deadlock is caused by self-locking on one node.
>>>>>> There is three node cluster (mounted to /mnt/shared), the user run r=
eflink command to clone the file to the same directory repeatedly,
>>>>>> e.g.
>>>>>>  =C2=A0=C2=A0=C2=A0reflink "/mnt/shared/test" \
>>>>>>  =C2=A0=C2=A0=C2=A0"/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`=
hostname`"
>>>>>>
>>>>>> After a while, the reflink process on each node is hung, the file sy=
stem cannot be listed.
>>>>>> The problematic reflink command process is blocked by itself, e.g. t=
he reflink process is hung at ghe-sle15sp2-nd2,
>>>>>> kernel: task:reflink=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid:16992 ppid:=C2=A0 4530
>>>>>> kernel: Call Trace:
>>>>>> kernel:=C2=A0 __schedule+0x2fd/0x750
>>>>>> kernel:=C2=A0 ? try_to_wake_up+0x17b/0x4e0
>>>>>> kernel:=C2=A0 schedule+0x2f/0xa0
>>>>>> kernel:=C2=A0 schedule_timeout+0x1cc/0x310
>>>>>> kernel:=C2=A0 ? __wake_up_common+0x74/0x120
>>>>>> kernel:=C2=A0 wait_for_completion+0xba/0x140
>>>>>> kernel:=C2=A0 ? wake_up_q+0xa0/0xa0
>>>>>> kernel:=C2=A0 __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>>>> kernel:=C2=A0 ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>> kernel:=C2=A0 ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>> kernel:=C2=A0 ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>>>>> kernel:=C2=A0 ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>>>>> kernel:=C2=A0 ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>> kernel:=C2=A0 ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>> kernel:=C2=A0 ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>>>> kernel:=C2=A0 do_vfs_ioctl+0xa0/0x680
>>>>>> kernel:=C2=A0 ksys_ioctl+0x70/0x80
>>>>>>
>>>>>> In fact, the destination directory(.snapshots) inode dlm lock was ac=
quired by ghe-sle15sp2-nd2, next there is bast message from other nodes to =
ask ghe-sle15sp2-nd2 downconvert lock, but the operation failed, the kernel=
 message is printed like,
>>>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_downconvert_lock:3660 ERROR: =
DLM error -16 while calling ocfs2_dlm_lock on resource M0000000000000000046=
e0200000000
>>>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_unblock_lock:3904 ERROR: stat=
us =3D -16
>>>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_process_blocked_lock:4303 ERR=
OR: status =3D -16
>>>>>>
>>>>>> Then, the reflink process tries to acquire this directory inode dlm =
lock, the process is blocked, the dlm lock resource in memory looks like
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_name =3D "M0000000000000000046e020=
0000000",
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_ro_holders =3D 0,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_ex_holders =3D 0,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_level =3D 5 '\005',
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_requested =3D 0 '\000',
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_blocking =3D 5 '\005',
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_type =3D 0 '\000',
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_action =3D 0 '\000',
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_unlock_action =3D 0 '\000',
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_pending_gen =3D 645948,
>>>>>>
>>>>>>
>>>>>> So far, I do not know what makes dlm lock function failed, it also l=
ooks we do not handle this failure case in dlmglue layer, but I always repr=
oduce this hang with my test script, e.g.
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 loop=3D1
>>>>>>  =C2=A0=C2=A0=C2=A0 while ((loop++)) ; do
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in `se=
q 1 100`; do
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
reflink "/mnt/shared/test" "/mnt/shared/.snapshots /test.${loop}.${i}.`date=
 +%m%d%H%M%S`.`hostname`"
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usleep 50000=
0
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f /mnt/s=
hared/.snapshots/testnode1.qcow2.*.`hostname`
>>>>>>  =C2=A0=C2=A0=C2=A0 done
>>>>>>
>>>>>> My patch changes multiple acquiring dest directory inode dlm lock du=
ring in ocfs2_reflink function, it avoids the hang issue happen again.The c=
ode change also can improve reflink performance in this case.
>>>>>>
>>>>>> Thanks
>>>>>> Gang
>>>>>
>>>>> 'status =3D -16' implies DLM_CANCELGRANT.
>>>>> Do you use stack user instead of o2cb? If yes, can you try o2cb with
>>>>> your reproducer?
>>>>
>>>> I setup o2cb based ocfs2 clusters with sle15sp2 and oracleLinux8u4.
>>>> After two day testing with the same script, I did not encounter dlm_lo=
ck downconvert failure, the hang issue did not happen.
>>>> After my patch was applied, there was not any side effect, the reflink=
 performance was doubled in the case.
>>>>
>>>
>>> Do you mean the hang only happens on stack user?
>> Yes.
>> Why? since o2cb based dlm_lock did not return error -16 when downcovert =
dlm lock during the whole testing.
>> But pmck based dlm_lock retuned error -16 during the testing, then we di=
d not handle this error further in dlmglue layer, next encounter the hang i=
ssue when dlm_lock acquire the lock. Maybe there is a race condition when u=
sing dlm_lock/dlm_unlock(cancel) in dlmglue layer.
>> Anyway, the problem belongs to ocfs2 own parts.
>>
> I meant if DLM_CANCELGRANT is not the expected return code, we'd
> better fix the issue in stack_user.c but not dlmglue, e.g. some specific
> wrapper.
We cannot wrapper(or ignore) this error in stack_user, otherwise it will=20
lead to a hang problem when the next dlm_lock is invoked.
Based on comments from fs/dlm maintainer, the error -16 is returned by=20
dlm_lock in case ocfs2 calls dlm_unlock(CANCEL) to cancel an in-progress=20
dlm_lock() request.
In fact, if you read the code comments in dlmglue.c, it also talked=20
about the similar situation, but I feel the current code should still=20
has a race condition, then trigger dlm_lock return -16 error.
For o2cb stack, it's dlm_lock did not expose this error, maybe it is=20
different in dlm implementation.

Thanks
Gang

>=20
> Thanks,
> Joseph
>=20

