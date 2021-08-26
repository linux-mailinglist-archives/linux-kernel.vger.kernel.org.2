Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5363F822D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhHZF5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 01:57:15 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28541 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230313AbhHZF5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 01:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629957386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q27/4SKSKy+09VUujjSfi9tQO/32wSMwGNAThNaqaeU=;
        b=b7TsBDzvpacyj5XoxCNL1ryxVcjlKj2Bvr1DlSxIWxTb/0u2TuJCFz9m8Dvd7Xzfg4RmMZ
        VBYAy0V1JB1wFdteK2OAbdMkh+GaD5/hV0Ewr4KKFpW5u+2lNGUIkZyU0GNzK1yjS6A6RM
        a+PRCozhpHhQ6GvkWH6gZcniDML8r5U=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-dz0vez9HMemWzjKPjmsvww-1; Thu, 26 Aug 2021 07:56:25 +0200
X-MC-Unique: dz0vez9HMemWzjKPjmsvww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYp5n+Ha3+5Do4p4aLB9/bOwSgw/eYawn7LECojV0ciGZpxW1JAj9FbKPgI3FBr7bkni6DDEedsMaCHXXX7n1xUQUnGxBWamHn1Ii8R8APGpJNjTOzdz6QDv3sF8dxTCUNZnVjo8vpHyjv/EUmB9/llmGeKFh52xeDOCTkDt+Aaz37NaXKjRJKXWxOptemlpQ6hiHEnpaGGo7JPsnqEBBFjSNxXki2rsJx4mBHTOLSNF8cWnC/DpL7TYqYjBdP3TbBNFR7kyqIHCNSyPSQtBixdF74XvUvkRipAUzPNEmxjkbxsuVx45PbtobyjmAxHuW1Mn1lWo973ceLchJWbuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkya9VPMtHw2rs0l+ZXcEAX+aLkbF1yms1CC7GcH74o=;
 b=isQcPlwHB49EOK8GK9cyudXLmZh9Rr2TGQkR591RaGXF+2DtnZjvaWHPSuElI/IqQf5JjtTVeRoVrBiqEdNtFtVgAl9QNnw+L7+ICrbSwPShKGhgJnSnqKFcaXtnV3w14W8E+bh5tjSrcUbAP3AzdNIgRr74Rb/AM1njzih7+Uv+14IIxjLZgMD/ogfyKVAN2oqW9mfXQ5HWhAaBwLRfJjMzboB/dfsuAjV9KC6k+PLZ0KIk69UhQ3aPeE+0NgNhUsqSF5EPrMmjxPIlpsnOa9WfFHojzF0QkHEAi2HjWLw10OCfM/5I08kmyINw3QUmWNqHgvnxFsBIerh4m08Gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 05:56:23 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 05:56:23 +0000
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: reflink deadlock when clone file to
 the same directory simultaneously
From:   Gang He <ghe@suse.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org, Wengang Wang <wen.gang.wang@oracle.com>
CC:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20210729110230.18983-1-ghe@suse.com>
 <5821fd0f-2018-dc1b-a5c0-f948a7debff4@linux.alibaba.com>
 <c7e1f0a7-e75c-d1e0-870d-dc480d070079@suse.com>
 <71608a14-58f4-dba0-d695-fee65de89192@linux.alibaba.com>
 <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
 <86e3d724-3147-ccaa-998f-0f857c575f7e@linux.alibaba.com>
 <a0a9710f-461a-99c8-92f6-a99bb11b3a4e@suse.com>
 <4ba3b404-824b-90a3-ef43-9ab6510ee073@linux.alibaba.com>
 <5a1af56c-3eab-5baf-62a3-1c98bac104ba@suse.com>
Message-ID: <db7119a5-f120-cebe-42a1-dc2f64db620d@suse.com>
Date:   Thu, 26 Aug 2021 13:56:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5a1af56c-3eab-5baf-62a3-1c98bac104ba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Thu, 26 Aug 2021 05:56:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc5b075-f122-444c-2c03-08d968563be1
X-MS-TrafficTypeDiagnostic: AS8PR04MB7736:
X-Microsoft-Antispam-PRVS: <AS8PR04MB7736FC037A78B80D3B841437CFC79@AS8PR04MB7736.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RuLYiOIfTYfnPtZjgKhWMHNxcKg7Qhs3APnoUHD3AYFruQOdh/4mOccb565NVwG8sCKh/OknJPOBT70beUa4H2kBvHpkb+ud40WMOommSc1gsvRLdSuffoLQQA1ooYR1w6Si/jiDsWveS7pjot8cJ2f2gQ3r8EtVB+WKk72OO+gYd/PVWRVy8BUjht21uVp3flzbe/RBM7Boq5FmLsFQw9S7MQTXNNty5q5Ae9GnrJGatxhEIEe8gPAChakeHwGS3nd+wOuEJXrnHgwCOWwuQK5mvl7ikgejiBZVRLKCzM7AaBTH5LNYwUJHm229Oyoie7eKlBzqI3WDz8Y5+DjzpApGfOIVrflf4PvI+uapGu2F4mryTlDesq3NOvRbH9S+pq0OiDD6v9ctqeEHwRXnRgfXTRkgcx1KslXV7rN2IT7CM2tQjQHgLDrL54M9fzeNST0TVfBdL56TeCgcIC55PKdiTSeu+JRMkqmFftapdkgCob85dzKDR5P09xpI/r+UJEH6BokeT/5JfLYe4DihYWxSNy1r0ep2LHOSv6EOLaAF2/ZQcewy6j8HDYQfVFQx8l5QIr+19CXxzwedhKo48cTT39hdqah+AwYbpvKRrMzRzkHj5vXCpmdoV9TdDlDTnfcWBoa0YXfwS3BxXNn/RbrIr7yPo5WqkvMQRmMYblOC2Fq9NPvn7S2UreHrBluJBT1AwWw24fz1Jhl+EAcj0mKBvdpjIzI3r5MbuWY96Nu7bf9vgQYJsf+3D2s9QwfUUA/17RpZzHj7AydAHkW97a4kERnwJBhKVwn614PSZCN7xwi2aNRyo7uZjzz7ppu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(83380400001)(2616005)(66556008)(66476007)(8676002)(38100700002)(4326008)(6486002)(86362001)(31686004)(31696002)(36756003)(26005)(53546011)(6666004)(55236004)(186003)(2906002)(16576012)(110136005)(498600001)(5660300002)(66946007)(956004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzR3CFH340gJjAVUmuSYt72XMAWETfe13TGwsR4ihQYRXG3wC8BoPQkGEktT?=
 =?us-ascii?Q?wGCAgzSMM/5qAAakLpFPeiqSbCV451wT4+fDiaHs3CHEO0nt1Fp0fxQiNBSw?=
 =?us-ascii?Q?OuB972LgIn885TeiQSkkrYfxw8RYfj6hFSMe2e3ErI/l+arpQRwHP6qviJgM?=
 =?us-ascii?Q?lLarYJ4EwSK3vPR0SJQJT2AykEuFkZPJX84CDUOjperBTdDzL77e9SqlwVqg?=
 =?us-ascii?Q?1fpvL+OCHRxoeHgp+YlD2Ak8AUliAKNNQ9XfxqNLPra5Ego7gCfbAdVRMvvm?=
 =?us-ascii?Q?OS4C+JXs9FnqeZkK8PfxmHoePebBerBr1tEG3T6OH8t1pDNaiMLDU2krdzjb?=
 =?us-ascii?Q?Daz4hYWp4nk54nizCNPWgV8pny3iArgXj0o2MCsX3x60RPZBjeRkpRn66Eab?=
 =?us-ascii?Q?0YbJnX9mQeo5gty46LdppuR8xOj0ljKWYgsLYwN15MxaI5v0BA29bfu+TlW6?=
 =?us-ascii?Q?McsShMkTMozWCo1zR04wshgmEyKj4c/C59dTOqGGg8niNty+XcdUg9HfRD5N?=
 =?us-ascii?Q?6J8tyTLia8h3GaTCyfpz1IqpiQoxrMN3GMzKUxvZKC4PPL4J/FLJEECuONzv?=
 =?us-ascii?Q?7HrcseRNRdQ8Kfp/DNM2IW2EpvdIOFF+/hN7INi71OTvLHMiaLTHFiTzTJSX?=
 =?us-ascii?Q?8Rh5t30LXd+2S72GbMlwTJmsbxcoGtUakoscdg4tnD4q48Zfbfs5QJEusibB?=
 =?us-ascii?Q?BCcFt3aSX6VG/2aR4jg8of3JUTC3yRmu1rIvpsUfDifuHHmtlsa2zuDemazv?=
 =?us-ascii?Q?pRZVCz+W+duizx8W2hEsxMQzCev9JjBS8/mDFukOFGWJMWkciydBamXRMdLS?=
 =?us-ascii?Q?znI9wqEgG1S8no6LsgO+QMP3aHmGa3tiFg6JnYHcs0RmdaHtBVVv2WJbH15X?=
 =?us-ascii?Q?vIIglB6wXVjKqEd6H/Cjn0tWV2GGLGLg9xkGN0hwjN7DZnmZ9NaLWFMa7F+V?=
 =?us-ascii?Q?mdVZNCxou1cq6WFl0LLYQNb2ZZxbi0wroEaPBs80DG0OJzHquGg3Jo6Mx+Li?=
 =?us-ascii?Q?alAf8ZyYCcSs3ym8NPe1e6JbWLaxLZNqs0TxSVmBLUekWQixVKIVtVf7DMP+?=
 =?us-ascii?Q?FNuenWlohmAZlFTpOgLlTLOdjC2xCt89xlYPkYyy4JkeEd+4TL8h2qS+WGIw?=
 =?us-ascii?Q?40nTW/SZJcXsYpKsWW2SL0k8ZQbfaK+SY1fVnCk3byxVczwTgIYpgBkuINWn?=
 =?us-ascii?Q?YAKctLnw9r6ctDUuyaZaRHdURzO8P7eJMgAiu+olQaari4/YBa0Yj4SeFoqZ?=
 =?us-ascii?Q?PSTxNkh/BVgshqXAuUnwPmo2CL0HxZQRQ7lxSaZ8UpyIeY/LxwBALqfo4O2g?=
 =?us-ascii?Q?sGpYn9jFmV1pRZD5n6JIsmuz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc5b075-f122-444c-2c03-08d968563be1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 05:56:23.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp7eb/kwMwv43NeacWCEtxMsz+XHfeOh13XZ8C8cXE/YMU1r2qoucP8JbW7j0zC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/19 14:31, Gang He wrote:
>=20
>=20
> On 2021/8/19 10:02, Joseph Qi wrote:
>>
>>
>> On 8/19/21 9:51 AM, Gang He wrote:
>>>
>>>
>>> On 2021/8/18 19:20, Joseph Qi wrote:
>>>>
>>>>
>>>> On 8/18/21 5:20 PM, Gang He wrote:
>>>>>
>>>>>
>>>>> On 2021/8/13 17:54, Joseph Qi wrote:
>>>>>>
>>>>>>
>>>>>> On 8/9/21 6:08 PM, Gang He wrote:
>>>>>>> Hi Joseph and All,
>>>>>>>
>>>>>>> The deadlock is caused by self-locking on one node.
>>>>>>> There is three node cluster (mounted to /mnt/shared), the user run =
reflink command to clone the file to the same directory repeatedly,
>>>>>>> e.g.
>>>>>>>   =C2=A0=C2=A0=C2=A0reflink "/mnt/shared/test" \
>>>>>>>   =C2=A0=C2=A0=C2=A0"/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`=
.`hostname`"
>>>>>>>
>>>>>>> After a while, the reflink process on each node is hung, the file s=
ystem cannot be listed.
>>>>>>> The problematic reflink command process is blocked by itself, e.g. =
the reflink process is hung at ghe-sle15sp2-nd2,
>>>>>>> kernel: task:reflink=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid:16992 ppid:=C2=A0 4530
>>>>>>> kernel: Call Trace:
>>>>>>> kernel:=C2=A0 __schedule+0x2fd/0x750
>>>>>>> kernel:=C2=A0 ? try_to_wake_up+0x17b/0x4e0
>>>>>>> kernel:=C2=A0 schedule+0x2f/0xa0
>>>>>>> kernel:=C2=A0 schedule_timeout+0x1cc/0x310
>>>>>>> kernel:=C2=A0 ? __wake_up_common+0x74/0x120
>>>>>>> kernel:=C2=A0 wait_for_completion+0xba/0x140
>>>>>>> kernel:=C2=A0 ? wake_up_q+0xa0/0xa0
>>>>>>> kernel:=C2=A0 __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>>>>> kernel:=C2=A0 ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>>> kernel:=C2=A0 ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>>>>> kernel:=C2=A0 ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>>>>>> kernel:=C2=A0 ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>>>>>> kernel:=C2=A0 ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>>> kernel:=C2=A0 ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>>>>> kernel:=C2=A0 ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>>>>> kernel:=C2=A0 do_vfs_ioctl+0xa0/0x680
>>>>>>> kernel:=C2=A0 ksys_ioctl+0x70/0x80
>>>>>>>
>>>>>>> In fact, the destination directory(.snapshots) inode dlm lock was a=
cquired by ghe-sle15sp2-nd2, next there is bast message from other nodes to=
 ask ghe-sle15sp2-nd2 downconvert lock, but the operation failed, the kerne=
l message is printed like,
>>>>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_downconvert_lock:3660 ERROR:=
 DLM error -16 while calling ocfs2_dlm_lock on resource M000000000000000004=
6e0200000000
>>>>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_unblock_lock:3904 ERROR: sta=
tus =3D -16
>>>>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_process_blocked_lock:4303 ER=
ROR: status =3D -16
>>>>>>>
>>>>>>> Then, the reflink process tries to acquire this directory inode dlm=
 lock, the process is blocked, the dlm lock resource in memory looks like
>>>>>>>
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_name =3D "M0000000000000000046e0=
200000000",
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_ro_holders =3D 0,
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_ex_holders =3D 0,
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_level =3D 5 '\005',
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_requested =3D 0 '\000',
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_blocking =3D 5 '\005',
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_type =3D 0 '\000',
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_action =3D 0 '\000',
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_unlock_action =3D 0 '\000',
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_pending_gen =3D 645948,
>>>>>>>
>>>>>>>
>>>>>>> So far, I do not know what makes dlm lock function failed, it also =
looks we do not handle this failure case in dlmglue layer, but I always rep=
roduce this hang with my test script, e.g.
>>>>>>>
>>>>>>>   =C2=A0=C2=A0=C2=A0 loop=3D1
>>>>>>>   =C2=A0=C2=A0=C2=A0 while ((loop++)) ; do
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in `=
seq 1 100`; do
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reflink "/mnt/shared/test" "/mnt/shared/.snapshots /test.${loop}.${i}.`=
date +%m%d%H%M%S`.`hostname`"
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usleep 500=
000
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f /mnt=
/shared/.snapshots/testnode1.qcow2.*.`hostname`
>>>>>>>   =C2=A0=C2=A0=C2=A0 done
>>>>>>>
>>>>>>> My patch changes multiple acquiring dest directory inode dlm lock d=
uring in ocfs2_reflink function, it avoids the hang issue happen again.The =
code change also can improve reflink performance in this case.
>>>>>>>
>>>>>>> Thanks
>>>>>>> Gang
>>>>>>
>>>>>> 'status =3D -16' implies DLM_CANCELGRANT.
>>>>>> Do you use stack user instead of o2cb? If yes, can you try o2cb with
>>>>>> your reproducer?
>>>>>
>>>>> I setup o2cb based ocfs2 clusters with sle15sp2 and oracleLinux8u4.
>>>>> After two day testing with the same script, I did not encounter dlm_l=
ock downconvert failure, the hang issue did not happen.
>>>>> After my patch was applied, there was not any side effect, the reflin=
k performance was doubled in the case.
>>>>>
>>>>
>>>> Do you mean the hang only happens on stack user?
>>> Yes.
>>> Why? since o2cb based dlm_lock did not return error -16 when downcovert=
 dlm lock during the whole testing.
>>> But pmck based dlm_lock retuned error -16 during the testing, then we d=
id not handle this error further in dlmglue layer, next encounter the hang =
issue when dlm_lock acquire the lock. Maybe there is a race condition when =
using dlm_lock/dlm_unlock(cancel) in dlmglue layer.
>>> Anyway, the problem belongs to ocfs2 own parts.
>>>
>> I meant if DLM_CANCELGRANT is not the expected return code, we'd
>> better fix the issue in stack_user.c but not dlmglue, e.g. some specific
>> wrapper.
> We cannot wrapper(or ignore) this error in stack_user, otherwise it will
> lead to a hang problem when the next dlm_lock is invoked.
> Based on comments from fs/dlm maintainer, the error -16 is returned by
> dlm_lock in case ocfs2 calls dlm_unlock(CANCEL) to cancel an in-progress
> dlm_lock() request.
> In fact, if you read the code comments in dlmglue.c, it also talked
> about the similar situation, but I feel the current code should still
> has a race condition, then trigger dlm_lock return -16 error.
> For o2cb stack, it's dlm_lock did not expose this error, maybe it is
> different in dlm implementation.

Based on my further analysis and BASTS traces, I found there are some=20
differences in behavior between o2dlm and fsdlm.
Usually, ocfs2_downconvert_lock() function always downconverts
dlm lock to the expected level for satisfy dlm bast requests
from the other nodes.
But there is a rare situation. When dlm lock conversion is being
canceled, ocfs2_downconvert_lock() function will return -EBUSY.
You need to be aware that ocfs2_cancel_convert() function is
asynchronous in fsdlm implementation, that means ocfs2_cancel_convert()
will return directly, then the actual dlm lock cancel is executed in=20
background.
For o2dlm implementation, ocfs2_cancel_convert() function is=20
synchronous, that means this function will return after the dlm lock is
cancelled and ast callback function is invoked.

If we does not requeue this lockres entry, ocfs2 downconvert
thread no longer handles this dlm lock bast request. Then, the
other nodes will not get the dlm lock again, the current node's
process will be blocked when acquire this dlm lock again.

So, I will send a new patch to fix this deadlock problem via dlmglue layer.
For this patch, I want to change the patch comments as a reflink=20
improvement patch.

Thanks
Gang



>=20
> Thanks
> Gang
>=20
>>
>> Thanks,
>> Joseph
>>
>=20
>=20
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>=20

