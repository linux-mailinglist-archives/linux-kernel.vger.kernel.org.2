Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D63F1016
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhHSBui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:50:38 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:27529 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235258AbhHSBug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629337800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aW+eJ970p+4SLr0ZUikoZNunoJk3lLirIULLFnG7JzQ=;
        b=OeNt23QDBh2rUcAd/+W6nfXJpovlXilUQjQxYCmlCdUhE9dMUPADQgcTnI0mCoue48FabP
        kowvqpnm0GtJ8e/oe/RzokAye37mf7cMaOYqPQFMaou0DHT08wxT0Q9z+5VocsEZlVJtWB
        YENsI2eaON5rMKuf++ojezpHrNWIMTo=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-cxKwwCpZPTOVsYgLjnIXHQ-1; Thu, 19 Aug 2021 03:49:59 +0200
X-MC-Unique: cxKwwCpZPTOVsYgLjnIXHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVUoqMVNkeHvqXFa2yBJhHBPcUshD6o9k1mv3urweH0DMQ+O4tJMWNMwnWGRQ/Oz/nZN58FNIkiiLPSj1wQmZoYZOo7IjP7HaTp9XUtYkVdT0EEHwKcSupvj5Mj/F9Suo2U1yWMLP7br0CdRuSNgp7bBdR1/jZHJqDTCgeGXnCI+E/aqG8apqQv/lgiU/GrxoITtczmPR228dQ07ei0AQwHjrVhOPS92yqcJX9zDpQ3GpxJBhrNK9A+yrbtqXupdiAik59WaeEdTfDISTAM3Qd5rbtZbLypeR7dgTf3LeQI209uMxZhEC4jl9mfS4dRGXcuQBvg7u87SW7SwTduPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P87XAgdTEanpeHo2kOOWvshohZ8Ntj63DAGx5iPm2Vw=;
 b=Duww9mzl+dduR7pgfcGPAH8MluoASztYMJH56WTXNGKEiDjg5SrjAqlMrIPRWnpBEZZ1T5Lu1vkU8aXeFKhjKi0w6vSIxZpdMIqP+QHWF8CEYfgBPk5m8VK/UOpCesISTT9go2meGATWoxKuF+EZJF94nl3bmoKsWXiWd0R50nVVS+Q7/rDLe1DgKaNweVdRbv5VA/qEfj3SkCtJ7MQa35MQf2e6AQF5UNWw4LdL+hZ/NAdwjurhIBZr5NYyhXhE0iy4FouW81O0u8ZD4+SfVJ+vm72DmFC+ner2CeoXr28OOI4ZZ7vnRvaQ6efkd0EBeJDvlgYETpDspCMmSo5S9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR0402MB3941.eurprd04.prod.outlook.com (2603:10a6:209:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 01:49:57 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 01:49:57 +0000
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
From:   Gang He <ghe@suse.com>
Message-ID: <a0a9710f-461a-99c8-92f6-a99bb11b3a4e@suse.com>
Date:   Thu, 19 Aug 2021 09:51:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <86e3d724-3147-ccaa-998f-0f857c575f7e@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.110] (111.205.14.52) by HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 01:49:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12169c8-6e0b-47e2-8b41-08d962b3a61d
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3941:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB39411DE278E13162EFAF945CCFC09@AM6PR0402MB3941.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cr2pmSwxdnf2DgKoZLaxCqc/xOLcFn03mxGADK4cI9T8l7e7iod/QjOBH3QfKRl2NDELMudbUkvSa9mlK4UQJV/EdB9OmbrUuV0Is/oHOh5/1TJXTy4ObvnjJBAMhSZWW0dvPlX9VcN1Xr2hs7tXgd0bQFH27lQgXhg52MRrDklKnexWH+QtkPeyxuLlx7FPiZFSj+QBpNYBrK4tUVEs12lo2vdh34kbkC6JX+vnzoYuYX1I/YMUP9pAgaAr3+OvbbWK5QHIgTIry3Bvcrwa+O8rMiIuBe8y+U3YBuYfwyXl+n0XspG3SBkqQeXaWNQZBAaOiezb6FGyYrDblMWvxCfi8gmMjUtgJcgqUA7peX51o14MKx8kLxPQG82B31SxixzoT2jOiiFyuAbB7MFUP5Byihkm8q3ZwsoTsy7XO1Scwof8h46Q990Cxa/ulIITD6Y5o4gYhc6Tc1ANR6RWR396QYFpYCUppvzV/7jjomUQ2IUrrsDBKzvRi3QfkRS91iOrbC32alH+ZdfQ0023cxFR8K/eKlG0qKqdYaxG0e9yBssKeBBkouYOCdQNixL26EKMgydG5lqVcKIqt04Mc7136DZCFPpJ6T5k7+0DOi28sikeGMgdlflUX0boAfZnGNdc2gr4Gvpvh9onh0XOYrtcc5euSSpov1kTdt8xlgvaLc0DGeNDxcnHM+R6e9KMncNN/MHxvtC5OtOdpr3RRWT+LlNigAJKh5Brm73Hqw6Cukwm3pobtLSeWekwziQ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39850400004)(136003)(366004)(5660300002)(4326008)(86362001)(478600001)(110136005)(36756003)(83380400001)(8676002)(186003)(53546011)(8936002)(956004)(6486002)(66476007)(16576012)(2906002)(26005)(66946007)(31696002)(316002)(31686004)(2616005)(66556008)(38100700002)(13296009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jl8GDJLXno7GGrQQMPPkgrDtmuTwzgwEFnM9quT+XPRIj/62d6jg86Erh5Ix?=
 =?us-ascii?Q?xsYdI/xrL8HKmlDen9eh2wQctfAV2ZCUTu9ZUQgqoWC6xbAYdKonD8bkHj6q?=
 =?us-ascii?Q?NQtNlDKOtKbOGhyKznv+fATGRNZiNHYZ5jDU2B/Y40mS7R9+wkkffhz/Zj6F?=
 =?us-ascii?Q?qUkJgbrIGLuObnXVWqoSnaVcF6lrcN7n6cmvQNQVENdQsNfC0Ty0YZ6d1Zns?=
 =?us-ascii?Q?Q+qfoMnUSpketUvFwkavAM+x9fd8Yv/NpDvzem1/WwmUODnp59XeTOsfc/KQ?=
 =?us-ascii?Q?6n0ESxq94hAUEPQSotYO2KtxWW95FOTCnwnFMUcaRbiZd0sJCAhnEnXSpCnY?=
 =?us-ascii?Q?nofALwBM2MacnLF7dO7W4+IMQhK/yPH2a40x9mD60o+VnTlldUoMi/vuqIdT?=
 =?us-ascii?Q?JuwgLZGTVn0vd8b1g7LdrAy/fNrj6SD9R2ZVRR80da+eQsA2/aOKm2Zy1Xs+?=
 =?us-ascii?Q?fDX+6EKZTcCFVBq+ulBpvcSK0In/ONnWkOiehhWRQF0hfUUG9VwR20M+FBho?=
 =?us-ascii?Q?tNA3lqO5HvoH4FnxVv6/puOEf5Lyzr/Ar7MKhg30aN0cpT5E+obLxrcgrhZT?=
 =?us-ascii?Q?8dPziBFR0bf6moGSAQ44DpVBetjqjumEk0jsxDXSHF7w1oVhm6UJrpI3OMZ9?=
 =?us-ascii?Q?pwU0+OH73A4ytt/3ZG3tzajfxIcaFG0pm0A4P875wqZEWBemPatKTA6PfnSb?=
 =?us-ascii?Q?7GemQMcUiKN3Jg/Hv6LSwgCueHgKYOv6RR2hpxiUGhc2J/k8KOMMjV5yldpp?=
 =?us-ascii?Q?yxRzR847q2zbl3A2B0EEQQ1yDvmmXNlW08zxKmdhAV0kQCwA/d2hvHVXdlj6?=
 =?us-ascii?Q?oFz4WncgaHHd1zClSKdQs8vPu7sjIgMt3/D2gAWgYf59vY1XeMZ37U883Idn?=
 =?us-ascii?Q?6pBnnA86UphtchjR4MK1Ufmy9Spc3jkkjbf+Z2tA/Api4gX+/oq/LG6bLFXU?=
 =?us-ascii?Q?rhWDMEV6QQfs28jLr+u1nJlXg7nPwok/djrTuL8ydB+eYJ2+Gz/lUmV/k0lY?=
 =?us-ascii?Q?V5kpB4ha0FVDQAUqvTIoGBGXHlPHyVTWMcMJc7b1rjShz30Q0MA1ProCDkDK?=
 =?us-ascii?Q?LEkHcfwaze0AAceceIYUhzOZAVI3k2pvpSUcYO6tlthmx5ROlNmXc/8U6FWg?=
 =?us-ascii?Q?/SzMwsfhtu3j7B2QReKqsgZs0ht+ELinpUrejeNpp4wMFNNNvzSDbXRMr9bD?=
 =?us-ascii?Q?YWvmO5QlAyaJtw88TlspTYpEwAYze3tra5MWp1VYZOx8JLLkYPMmPkVBrP6y?=
 =?us-ascii?Q?9yE35tlcN+HDz3TXoH/6GvZ2oBxU6Doz5sTMM9et5jUz47yOrjZlalu5onh2?=
 =?us-ascii?Q?i2//7OwkmR95Syho7meBI9nT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12169c8-6e0b-47e2-8b41-08d962b3a61d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 01:49:57.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUbcMMFdpK4cZCXGkxdOLxPLWdfmaDSQBhOKzj8Y46Ij0fUnRiZKC5y3ZLLKBr50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/18 19:20, Joseph Qi wrote:
>=20
>=20
> On 8/18/21 5:20 PM, Gang He wrote:
>>
>>
>> On 2021/8/13 17:54, Joseph Qi wrote:
>>>
>>>
>>> On 8/9/21 6:08 PM, Gang He wrote:
>>>> Hi Joseph and All,
>>>>
>>>> The deadlock is caused by self-locking on one node.
>>>> There is three node cluster (mounted to /mnt/shared), the user run ref=
link command to clone the file to the same directory repeatedly,
>>>> e.g.
>>>>  =C2=A0=C2=A0reflink "/mnt/shared/test" \
>>>>  =C2=A0=C2=A0"/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname=
`"
>>>>
>>>> After a while, the reflink process on each node is hung, the file syst=
em cannot be listed.
>>>> The problematic reflink command process is blocked by itself, e.g. the=
 reflink process is hung at ghe-sle15sp2-nd2,
>>>> kernel: task:reflink=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
tate:D stack:=C2=A0=C2=A0=C2=A0 0 pid:16992 ppid:=C2=A0 4530
>>>> kernel: Call Trace:
>>>> kernel:=C2=A0 __schedule+0x2fd/0x750
>>>> kernel:=C2=A0 ? try_to_wake_up+0x17b/0x4e0
>>>> kernel:=C2=A0 schedule+0x2f/0xa0
>>>> kernel:=C2=A0 schedule_timeout+0x1cc/0x310
>>>> kernel:=C2=A0 ? __wake_up_common+0x74/0x120
>>>> kernel:=C2=A0 wait_for_completion+0xba/0x140
>>>> kernel:=C2=A0 ? wake_up_q+0xa0/0xa0
>>>> kernel:=C2=A0 __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>>> kernel:=C2=A0 ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>> kernel:=C2=A0 ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>>> kernel:=C2=A0 ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>>> kernel:=C2=A0 ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>>> kernel:=C2=A0 ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>> kernel:=C2=A0 ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>>> kernel:=C2=A0 ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>>> kernel:=C2=A0 do_vfs_ioctl+0xa0/0x680
>>>> kernel:=C2=A0 ksys_ioctl+0x70/0x80
>>>>
>>>> In fact, the destination directory(.snapshots) inode dlm lock was acqu=
ired by ghe-sle15sp2-nd2, next there is bast message from other nodes to as=
k ghe-sle15sp2-nd2 downconvert lock, but the operation failed, the kernel m=
essage is printed like,
>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_downconvert_lock:3660 ERROR: DL=
M error -16 while calling ocfs2_dlm_lock on resource M0000000000000000046e0=
200000000
>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_unblock_lock:3904 ERROR: status=
 =3D -16
>>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_process_blocked_lock:4303 ERROR=
: status =3D -16
>>>>
>>>> Then, the reflink process tries to acquire this directory inode dlm lo=
ck, the process is blocked, the dlm lock resource in memory looks like
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_name =3D "M0000000000000000046e0200000000"=
,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_ro_holders =3D 0,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_ex_holders =3D 0,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_level =3D 5 '\005',
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_requested =3D 0 '\000',
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_blocking =3D 5 '\005',
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_type =3D 0 '\000',
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_action =3D 0 '\000',
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_unlock_action =3D 0 '\000',
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 l_pending_gen =3D 645948,
>>>>
>>>>
>>>> So far, I do not know what makes dlm lock function failed, it also loo=
ks we do not handle this failure case in dlmglue layer, but I always reprod=
uce this hang with my test script, e.g.
>>>>
>>>>  =C2=A0=C2=A0 loop=3D1
>>>>  =C2=A0=C2=A0 while ((loop++)) ; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in `seq 1 100`=
; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reflink =
"/mnt/shared/test" "/mnt/shared/.snapshots /test.${loop}.${i}.`date +%m%d%H=
%M%S`.`hostname`"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usleep 500000
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f /mnt/shared/.s=
napshots/testnode1.qcow2.*.`hostname`
>>>>  =C2=A0=C2=A0 done
>>>>
>>>> My patch changes multiple acquiring dest directory inode dlm lock duri=
ng in ocfs2_reflink function, it avoids the hang issue happen again.The cod=
e change also can improve reflink performance in this case.
>>>>
>>>> Thanks
>>>> Gang
>>>
>>> 'status =3D -16' implies DLM_CANCELGRANT.
>>> Do you use stack user instead of o2cb? If yes, can you try o2cb with
>>> your reproducer?
>>
>> I setup o2cb based ocfs2 clusters with sle15sp2 and oracleLinux8u4.
>> After two day testing with the same script, I did not encounter dlm_lock=
 downconvert failure, the hang issue did not happen.
>> After my patch was applied, there was not any side effect, the reflink p=
erformance was doubled in the case.
>>
>=20
> Do you mean the hang only happens on stack user?
Yes.
Why? since o2cb based dlm_lock did not return error -16 when downcovert=20
dlm lock during the whole testing.
But pmck based dlm_lock retuned error -16 during the testing, then we=20
did not handle this error further in dlmglue layer, next encounter the=20
hang issue when dlm_lock acquire the lock. Maybe there is a race=20
condition when using dlm_lock/dlm_unlock(cancel) in dlmglue layer.
Anyway, the problem belongs to ocfs2 own parts.

> IMO, we'd better directly fix the stack user hang first, and then optimiz=
e
> reflink performance.
Before we fix the potential problem in dlmglue layer, I suggest to=20
accept this patch first. Since the dlmglue layer code is kind of=20
compliant, we need to carefully modify this part of the code. But this=20
patch can workaround dlm_lock failure(-16) problem for pcmk stack,=20
meanwhile, it also can improve the performance.

Thanks
Gang


>=20
> Thanks,
> Joseph
>=20

