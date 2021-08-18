Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D13F004E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHRJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:22:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:47979 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhHRJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629278465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkF3GEacGb04BKUSE10rvD0oQXmAdJ8511Ny+07gIeA=;
        b=D3lbLjVFubtccv47rsT3btRX3LhiBw5R/1nzk63lpSVTfKV7fBm6ch4CQ/mhfWFsLZeEac
        QeXfvw6GkwxrgM2YjmC80yJ7Zl0wncb8r1fCNpirmJErjq/fPtwBG+E5VtO9lhYrWDIT6v
        7kNoN88MOJNh7QkD+nTnPVdmbAKkogk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-bMPwOKCQOL-xgzdSPcREBw-1; Wed, 18 Aug 2021 11:21:04 +0200
X-MC-Unique: bMPwOKCQOL-xgzdSPcREBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilOhlpRiS0pFwHsCLAChWIt9WqspUVvgZoFIRtwYl3/1/O2cIOutCW5DwnfPtmvBJc4/T7LxdW5tCKbFY3bmPrzcpLM9SSib80XTc96BsnFULyS3SRfBzveOFzb0EFFLwIu9e/dMo23/BjI3nCKt95B9TuBRAgEnDRYctheiGT88Va3QKiI6V5YI6nh+nqNjTsgg4kYsTfOnUmwAsoIaj18T3nEokYq249bxxQ3dlHt/flizWyUaAmF1bwU0977Mcw/trK1Qeh6u4tG/8miSg9KbCwwfFvMMYwjw9QfqQgPvCtBQXBWrNgBO1F3HruQusGK9jArOTJFXQIN6rKOWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qiCAqprNJWMbr3wXf1R+zcRHbsv/PP6HbdhJ1paRDg=;
 b=aRbv34evyRQxBcjTwxOznztA9Y9Q3XZH08uI6Mz7sipkky3mT25jeFOxWHx93f2Lfb72GDEs7EWhQfEfcKYKVODuhXz/iMQPJlhNDYeIrqcqXIxvGzoZIFH081ao8YHLEzUSgL+JxeU7Bqc3wDJgcEtTkzZx7irSmV7qj1BKMvCCyc2t1n6Z4Io0ntfeyvCYZ9bc816KiCkFp9PM8drRcx3BC3+oZv+m24NcubMf2Ssrch19zfW5PSOBL1MvndtaDygJNkUgIJSVTTZgZt774B+7WZwtdttVb7x9N16w3CudxG0l2FLqPv8YN52FhIaH0WUArPj3UCBOsqdrCfl6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 09:21:03 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:21:03 +0000
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
From:   Gang He <ghe@suse.com>
Message-ID: <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
Date:   Wed, 18 Aug 2021 17:20:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <71608a14-58f4-dba0-d695-fee65de89192@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK0PR01CA0054.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 09:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1213b730-baaf-4bff-a480-08d962297fdc
X-MS-TrafficTypeDiagnostic: AS8PR04MB7624:
X-Microsoft-Antispam-PRVS: <AS8PR04MB7624AB81F1616B23D63FC896CFFF9@AS8PR04MB7624.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfUwP1eTQrNrRLjuKzorK7ZOaaqMME22kreKf3LwAlUyTvGHGkznbf86msx1nY32t1bP7cj32GzcOff0EHPaYZrzE40UO0nU7lXj2G6qMgFn1XsGRsVtzVMXvMHqwGbBwjB4wonTZgsBlaPhktyGPdHr6jrosBrubfTvXIQ9qc4CTUN6eylOUEBE/lkzCOwY9bRdMfrtTyqhsFIeSyMCMu8k2Z5F1Xm3bdSkdJJ+6t9wTkZa2WUKVx7JTozEh6KA3DTP0qt1ct9Mh4mjqZbjm38uHMXRXtbL4xqVgzV0z8ai4MIyddDaoGkI6xvshGA8FUidQLIh99+L5NVN22jdG1xdQQfUzOa2nnP8vxrspY0yC0r6lKAmbcoIjYH12v+er7yte33hk3TkHAPXKMLI/PwQ7f8R3k2y9K9KrfkpVatEv0iXw5955m8LdXkFT2B+kd0GWlzd2XVrv92Q4haH5BzlEv8msOVfDkqr5Yq9cjiQIl2upnvCV3eZnbGc7jCWTffOK3J+SzFQrlDERjfJHSUHKxfoiJfYBeN9AMTNXZ7Mzrhr7WGSXJ/+9+gC6bnRu2vIjVfQPf6TsKKRdqPK4YxrThxkck6UFoGSOSqdQc44G7doBIHuNqCR6Q7XZRUgZEWVH9B/yr8jJjpWURTKVsvW555DxUMujUT60CcMU7oFACw2oxFZyjFNNEIwGuaQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(31696002)(66556008)(66476007)(36756003)(53546011)(110136005)(316002)(66946007)(31686004)(83380400001)(38100700002)(5660300002)(186003)(6666004)(956004)(2906002)(2616005)(55236004)(8936002)(86362001)(6486002)(26005)(478600001)(4326008)(8676002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJej4C1Sc3YW6eB3oCPAGZ7+/USTm2k7mkcCnn5rTU9XhqQvDgNcIC2kZqsS?=
 =?us-ascii?Q?QYKtS2J/QIpo047J12m0xbGLG3btrl74/yduKEYX1paAWgkQLBxpV5g0wyE8?=
 =?us-ascii?Q?Nq4TFEI+TjY5DUBQPGL68kFyEfqgypqTXfmHh0SEBqJCXDOkpUtZIQwsbWqB?=
 =?us-ascii?Q?3N6n1VeaM/k1e7IPTynWGhtOSULeEvBOT3+PKsP6Nyg7qcXpWCPGUfj/cblL?=
 =?us-ascii?Q?fLtawAel7sv+qfzU4yum8NiSwEI2Ubs2ucDx15Kw7K96kkr4p9zih9omeHyI?=
 =?us-ascii?Q?xYRU/zPAP/qZxbbJarOY3kh/Fu0tv3TR2qJ+9JF4J9f5WCbteuo5iHaG/Ll/?=
 =?us-ascii?Q?V0/4PT+QI6R9+NwPtOURxxkSRXM2DUeMYiQwRonRywbxkyi0tl0AonSY/jio?=
 =?us-ascii?Q?+oA+yIXqCkgTSkVmVz6vbudqtz4jpc1FWkTe/TZsgZg5xDYfSv21YAU1yAlb?=
 =?us-ascii?Q?hy70JIo1NAzSh3AencuR7QpI9EUR6OpxyL7TW0sNyOye+10iJfREB5yLGhsk?=
 =?us-ascii?Q?1BgFHPdvwMi9oiUMXZBYzL6GiBcy8TapGDwKR6Ci+yyZYhjhHe/uoxrgVpzJ?=
 =?us-ascii?Q?ig6QqpsO+Qx1UsT1ZtrhWkAXliLu6kWRyT8DMdG4aIA5w1hfcB2M6xbWHipO?=
 =?us-ascii?Q?Ki0PV60SkS8QTBc0uzRt/PnSCy/MCpdQpiVR3agRokSjHQMWwKJHiRhsRX07?=
 =?us-ascii?Q?eYQBLQl9xZBtTNjC+htZBLUnpU6PO7wsYUuJEqY6a2s7WLW+k4vLF5eb1x0a?=
 =?us-ascii?Q?s0tfAD//hOdG2kx9/r8U3L8G3SetV/XYlAGMf04u1RXSacT5I+QwtQoASbTm?=
 =?us-ascii?Q?+PWRQSf9wddWO0Xzp1AxzKqiizbebmfPQoIzq2j1Ekp6eqZa7hjetH/K1n+d?=
 =?us-ascii?Q?sDzHIsDnJlJ3Hks68XhFKiUTkgKF4dJcsTMvqzBbI2Z2jGh1czrQgO3bi0AJ?=
 =?us-ascii?Q?+OVEp+ZTf1PeClYOnTpUDboOx7JkZ21TQlxf8F86xIdb6wCJHpvYdGzJP6u+?=
 =?us-ascii?Q?msmUubJJymc7NgU7S2oPmcAECHG/KHA7FOMHTnk7q4F59RC6KJoWGE8sEeqU?=
 =?us-ascii?Q?UByoQTRDH3K0r7dtRG4MDSGZqgElPsU8nDbYcboz23Dbj9hzkgYssxc8NfPp?=
 =?us-ascii?Q?GkY4/KxVuIVbpuPQiaGsg48oNdX6RfsWVCSQjkNUUkrPb3Yy98GXzTY4gG76?=
 =?us-ascii?Q?bZgv77RVibmPHVTYb2ZBlE9oT3byCHPXDSsrtGZFdbJWPtYtZXVuue2OCxgo?=
 =?us-ascii?Q?gzCd/iq/TWfyBDkGeE1vxXzYuCcufvbYHgBseCRhJ4zQHRM0K98PjUZW2t/c?=
 =?us-ascii?Q?qVbcceKFp1KLlNwEbxV1ODpi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1213b730-baaf-4bff-a480-08d962297fdc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 09:21:03.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfHLYFg/HXhOJd5RSraZXnSMbfbw8EuwJUP+fo9ixQUw5Cw/0vTjgBYP33ACmPEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/13 17:54, Joseph Qi wrote:
>=20
>=20
> On 8/9/21 6:08 PM, Gang He wrote:
>> Hi Joseph and All,
>>
>> The deadlock is caused by self-locking on one node.
>> There is three node cluster (mounted to /mnt/shared), the user run refli=
nk command to clone the file to the same directory repeatedly,
>> e.g.
>>  =C2=A0reflink "/mnt/shared/test" \
>>  =C2=A0"/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
>>
>> After a while, the reflink process on each node is hung, the file system=
 cannot be listed.
>> The problematic reflink command process is blocked by itself, e.g. the r=
eflink process is hung at ghe-sle15sp2-nd2,
>> kernel: task:reflink=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sta=
te:D stack:=C2=A0=C2=A0=C2=A0 0 pid:16992 ppid:=C2=A0 4530
>> kernel: Call Trace:
>> kernel:=C2=A0 __schedule+0x2fd/0x750
>> kernel:=C2=A0 ? try_to_wake_up+0x17b/0x4e0
>> kernel:=C2=A0 schedule+0x2f/0xa0
>> kernel:=C2=A0 schedule_timeout+0x1cc/0x310
>> kernel:=C2=A0 ? __wake_up_common+0x74/0x120
>> kernel:=C2=A0 wait_for_completion+0xba/0x140
>> kernel:=C2=A0 ? wake_up_q+0xa0/0xa0
>> kernel:=C2=A0 __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>> kernel:=C2=A0 ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>> kernel:=C2=A0 ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>> kernel:=C2=A0 ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>> kernel:=C2=A0 ocfs2_reflink+0x436/0x4c0 [ocfs2]
>> kernel:=C2=A0 ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>> kernel:=C2=A0 ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>> kernel:=C2=A0 ocfs2_ioctl+0x25e/0x670 [ocfs2]
>> kernel:=C2=A0 do_vfs_ioctl+0xa0/0x680
>> kernel:=C2=A0 ksys_ioctl+0x70/0x80
>>
>> In fact, the destination directory(.snapshots) inode dlm lock was acquir=
ed by ghe-sle15sp2-nd2, next there is bast message from other nodes to ask =
ghe-sle15sp2-nd2 downconvert lock, but the operation failed, the kernel mes=
sage is printed like,
>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_downconvert_lock:3660 ERROR: DLM =
error -16 while calling ocfs2_dlm_lock on resource M0000000000000000046e020=
0000000
>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_unblock_lock:3904 ERROR: status =
=3D -16
>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_process_blocked_lock:4303 ERROR: =
status =3D -16
>>
>> Then, the reflink process tries to acquire this directory inode dlm lock=
, the process is blocked, the dlm lock resource in memory looks like
>>
>>  =C2=A0=C2=A0=C2=A0 l_name =3D "M0000000000000000046e0200000000",
>>  =C2=A0=C2=A0=C2=A0 l_ro_holders =3D 0,
>>  =C2=A0=C2=A0=C2=A0 l_ex_holders =3D 0,
>>  =C2=A0=C2=A0=C2=A0 l_level =3D 5 '\005',
>>  =C2=A0=C2=A0=C2=A0 l_requested =3D 0 '\000',
>>  =C2=A0=C2=A0=C2=A0 l_blocking =3D 5 '\005',
>>  =C2=A0=C2=A0=C2=A0 l_type =3D 0 '\000',
>>  =C2=A0=C2=A0=C2=A0 l_action =3D 0 '\000',
>>  =C2=A0=C2=A0=C2=A0 l_unlock_action =3D 0 '\000',
>>  =C2=A0=C2=A0=C2=A0 l_pending_gen =3D 645948,
>>
>>
>> So far, I do not know what makes dlm lock function failed, it also looks=
 we do not handle this failure case in dlmglue layer, but I always reproduc=
e this hang with my test script, e.g.
>>
>>  =C2=A0 loop=3D1
>>  =C2=A0 while ((loop++)) ; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in `seq 1 100`; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reflink "/mnt/sh=
ared/test" "/mnt/shared/.snapshots /test.${loop}.${i}.`date +%m%d%H%M%S`.`h=
ostname`"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usleep 500000
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f /mnt/shared/.snapshots=
/testnode1.qcow2.*.`hostname`
>>  =C2=A0 done
>>
>> My patch changes multiple acquiring dest directory inode dlm lock during=
 in ocfs2_reflink function, it avoids the hang issue happen again.The code =
change also can improve reflink performance in this case.
>>
>> Thanks
>> Gang
>=20
> 'status =3D -16' implies DLM_CANCELGRANT.
> Do you use stack user instead of o2cb? If yes, can you try o2cb with
> your reproducer?

I setup o2cb based ocfs2 clusters with sle15sp2 and oracleLinux8u4.
After two day testing with the same script, I did not encounter dlm_lock=20
downconvert failure, the hang issue did not happen.
After my patch was applied, there was not any side effect, the reflink=20
performance was doubled in the case.

Thanks
Gang

>=20
> Thanks,
> Joseph
>=20

