Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9692340F35B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbhIQHio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:38:44 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:44934 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238827AbhIQHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631864240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SmpBqRhoQWA4DdSc58c7W7AfwrdLuwVl98cHn/vS/E=;
        b=LilAgWTjfTjcUAG7StZcFbOtSoslw9HI39Z544QNvdb5D3bbrQKkwhNajkVw58jEk2pcTk
        sU61PU+j/Hf/px1vJXUh1yzP/VQIDJHhEIA7JjTRnOqO5dpEu8UKfI9yUC04hIwmnOfQ6o
        vwS4RP8JW/+Sfq1OtfEJnIRWep/xADM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-34VE90aPNmqyjB7o44XIkQ-1; Fri, 17 Sep 2021 09:37:19 +0200
X-MC-Unique: 34VE90aPNmqyjB7o44XIkQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc4S8GGO1LnIGB7wAHdIkFek9UKtKhI3o73WEVOMJ4QKyZIeAKS3pbGVWMZ2IzoEjfgydxhvfEdT1KDVjZgaP0KWpdR+aAiFQxqpu0VDn9BgMLPIedXfe9bXXA6wSTQIqpCrh/87G7nEZlSOfPiiNzhj+uw5yUHJT9phGqZYKfy8luWfuzGhr1f+gG5uwftAIuwtAECfmsjLKv+bPvstcKr9DXMc2RgSVX8Qj9o4qQO/mqc3L2cA/JykET7u7y1CogHgzr9HLjQYHnjOVmkeD9MgxcUoTeyk42EO86w1DrXwazklUOMdfel5wFGfK+1PVcmR/l03gnvIhnJtKvIHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GmZZB/CmiUb9nJhwfEEQ+J1fIbO0R6g/RMvO0Lx7aUY=;
 b=PJcr287BVqpMcEnuiXiHuWPivpAT0X5dtbd9S5Kg1+f56YESR9/AGeZDqe+ILZq0E1ZT+ju7qdW0FKcl6W30EiN+QDojLP4LbGrFn7/zYfLFbMknMMlBoPBQ6zB+Xgt6htctgSiiKAjrQIQLnYzeVOSju+G9bX66Uju3A9I4Osz5XkN3tpefsKgVCDFR3FBs8DMqOPTBgKUQAMNs/oIUbxclO86vtGukKSeRpt15I712adszsrT/iDWhk20UmkGp+iuid72zh1qy1GCWKk9MWMLe+ZhqzW45w6lGzRIq3Y9G70EBnO4u8PwB831GMKr9aS7ym7cRH2fNE34Qf+flyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR0402MB3382.eurprd04.prod.outlook.com (2603:10a6:209:3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Fri, 17 Sep
 2021 07:37:17 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4500.018; Fri, 17 Sep 2021
 07:37:16 +0000
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: avoid getting dlm lock of the target
 directory multiple times during reflink process
To:     Wengang Wang <wen.gang.wang@oracle.com>
CC:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <20210826075941.28480-1-ghe@suse.com>
 <744d756c-7640-d312-37ef-126755324e8a@suse.com>
 <3FF09C2E-2855-457E-8533-50BBD8EECEF1@oracle.com>
 <2abbfd28-da40-3218-f226-0621cb683716@suse.com>
 <3672BDE0-3D94-4522-9059-A75C91784415@oracle.com>
 <60b3e52b-fdab-5255-3339-de3d95555dca@suse.com>
 <8BD8816D-FF28-423B-99D1-642EE034D2E3@oracle.com>
From:   Gang He <ghe@suse.com>
Message-ID: <45cb2ddb-028a-56f9-8750-98830fe0a4be@suse.com>
Date:   Fri, 17 Sep 2021 15:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <8BD8816D-FF28-423B-99D1-642EE034D2E3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Fri, 17 Sep 2021 07:37:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf62235-2b25-4c67-bcbb-08d979adf929
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3382:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB33829CB306ADF67F74BE1FFDCFDD9@AM6PR0402MB3382.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F7iZFJcTGJLP4rr2CuJLLA4IeVE/Men2lHU9shicDcnmLYBRu0awSnm2sHp0/WSaoVCjjl2CqxH19AOPfucE5gB6uQAknT4THvSFYSy0dv/O4ppHtdl3ZKImKHCG7zyz2ALQMn34WMazB9asoAmuCJu76h8gqgcdiLkLx2Ut56aiD+hFoLYjw4edxgKeretaAtSOVlEWU9qBqP4QxbEfX/ksMpPjTvaxbIlubdlGlG7xpCaHan6IlLAi3bBOmywX+O4Mqaxn2vFehU8wDIPnGOQoqhgaHGq8XpH/Po4noUh6Asm5UWtCoBrZHf0iWpxjVL9Y0EnQq1QCUjGZTW4zyhXjmP6tu5zgGWqw6gjLqwwZ9gQLU92ax4Ay+0ASYPrt2Pa3RDMIrk1kQj/b5p12xCtsKcXEtRHnfdURQ7XK5wLi9UDKnWrw3Uk7ltdI5OYRGMHDJPJQsjp0o4e4cK2QLxgGuRqHwc+SE2/3foYI59Wu2nqMeaHbN90zzzFMnGirxc8Z+kg9Gkfuy6Y2riW76pLSiQjJO6Q2AYRWogb715zQ5kCQFXHiYqqjfWCAN+H4tAOlJrlO7b4dLcOCl4ULgFheM/4/0vNAbsg8NTk++MBOXvpGjoz46n2SiqMP5NHj/q5ommTtV3xtDjKkJVQb7NtSFyZ+WbSua9zwHswPRw6h7XjAhm2lY4vrRvabd6mvnEWvQ6U27pLQrdveDIPt+KxFCn9cZsT44og1lponqnbpRvZcuC5f9yZXlmqPOIvUNnNUsWTs9vLJwLW2zVp7moumPrBiFhippBVlKDjC7QuqBbxDuPx6efWRbd/aysJVG4oV8bZlIII4UN6O7gB3F5f4WLfvTZNpLKnAFtuFR1Ud4yZ7V80XWrSRieMbXvj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8676002)(36756003)(83380400001)(6486002)(31686004)(66476007)(966005)(38100700002)(2906002)(6666004)(4326008)(6916009)(316002)(66946007)(86362001)(5660300002)(31696002)(55236004)(26005)(53546011)(8936002)(30864003)(54906003)(2616005)(956004)(16576012)(66556008)(186003)(10126625002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MuchKX8FOhbIdrpj5cn9ob1DmZ+nvDKqMirGVoBbv7ibjawhPHlwkF9G1blj?=
 =?us-ascii?Q?3SlAbq78UIj8KV1C190tC17YdDrRGR3XfUFdxoTSehwxZ2HMM4Ky0vVeWJb0?=
 =?us-ascii?Q?hLCPWJL5V24t0Ac3ETB+nMtSYA7jExhzqkPrP67BTNvAF8rLLSi0XzXuAY8U?=
 =?us-ascii?Q?RmDgLu6DfXTIWcNK80wi5gzfcoYtN5RnPYci88Z/bYlagdr3Q0F8KVjNTlYa?=
 =?us-ascii?Q?GUCp5rMLd+lOrNfk9qDNUjez/RTTB3VLwaFfm90Ktdb4OIyzx+4BLcH3+/pr?=
 =?us-ascii?Q?uQvgXw/5NwKwYValSx73zIS+3xRSpWgSO+HkJeygEgXRsYRAXwztXBls494c?=
 =?us-ascii?Q?6DHtvE/CRCuy+5xKcS0o38jOPLKuj3wo6jP/y1JDW1e2+871+4dc1dcOGCEg?=
 =?us-ascii?Q?bHaaJ0+r6gDu3XkSmmuiY6OgbsVHpLAohWzsGxsiXA2rRWC7loqlvgXJwEba?=
 =?us-ascii?Q?6FJMvzOzGNNsJz0bmGEN3u7mr5ZKL63om4qAKPJcgebENn8uH9nMmgbRkgS0?=
 =?us-ascii?Q?0c4WEzhdjxImp/KBefqpaIusYaL26x+ZB+bNtmXrIq/ioTBsf7sJk8ZE7uVY?=
 =?us-ascii?Q?yWB+xxKYzxfthyPYB9YD2wdyrYwbLpToVKS0i4WOwx76A8sBYVd32qGgyOg7?=
 =?us-ascii?Q?4l6xI+6OcX42V7Alu2EcTEbjVqYp4KIzJnIexK2HmYGZ2M1z++LC7OYDpAJS?=
 =?us-ascii?Q?qmNMTO8CDf5lrgBjSO9HmsIN0CSkb9Aug1x+meBxwVpVhKH+pbhNc85Ivebx?=
 =?us-ascii?Q?9qPKHhsEibP6X/i4hyoZoQyqSaWMgCstsHjrFx76g5Pi3Ph20iNDe6sj9oMq?=
 =?us-ascii?Q?Ano8hXC9pvUZMsCWgq2IEiRfpEQWXTmAn6ngfZke0TlWUZyD8NIYoUnwr25X?=
 =?us-ascii?Q?Xy2SmKdEvRqbrotNKJdSl+DiO3Z2gwu+SBsuy13DhnXDYP1RKNOKdua6vW82?=
 =?us-ascii?Q?WrLMUfUxs+5wsOiT7aDE871oRJdNN5ARxcH0tDaLNvnAEpiNafd+HHGi87ay?=
 =?us-ascii?Q?syq7qyVe1MD6QBLn4Tj7lbxnxLO/XnpLLJMD/zJJ/RHL7KgtuHnLzdN1C74U?=
 =?us-ascii?Q?ZVz9yF0UMYkKKL0G9RWd4ky0bg82wMzs9cR2lHbG7Mqw4rWUhmnMgP5/8hd8?=
 =?us-ascii?Q?uEdHGiCyu2SEImx50EHYzi5ryhNmWccoC6pxe7pdHLGwMcbArcgzjnot/PWO?=
 =?us-ascii?Q?Tlua6728h7DXuaK6DXmnqNlkyzI/6Js+t+ZqEm9cvzuPybgASxxyrES83FrZ?=
 =?us-ascii?Q?K0GT7rfTNq1gO4mYmllYHm37+IYZ6CXLfcrWrofAKmogv/BX5wceGHlxf4FK?=
 =?us-ascii?Q?AYghCcZ25prjmVHhLRkHJn7E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf62235-2b25-4c67-bcbb-08d979adf929
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:37:16.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtl5QUeTSNHYu7AyPewHC0ykbUJG9cW8LdOWmPOkk61Phb0Cm20QqsUT9r+6sZsD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3382
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wengang and All,


On 2021/9/15 1:50, Wengang Wang wrote:
>=20
>=20
>> On Sep 14, 2021, at 12:34 AM, Gang He <ghe@suse.com=20
>> <mailto:ghe@suse.com>> wrote:
>>
>> Hi Wengang,
>>
>> Sorry for delayed reply.
>>
>> On 2021/9/9 0:00, Wengang Wang wrote:
>>>> On Sep 7, 2021, at 11:06 PM, Gang He <ghe@suse.com=20
>>>> <mailto:ghe@suse.com>> wrote:
>>>>
>>>>
>>>>
>>>> On 2021/9/7 23:57, Wengang Wang wrote:
>>>>> Hi Gang,
>>>>> Sure, I will look into the problem you are trying to address. Any=20
>>>>> bug fix and performance improvement is welcomed!
>>>>> Well, can you please provide the analysis on the tcpdumps between=20
>>>>> the (two) nodes that covers the reflink operation with/without your=20
>>>>> patch to show how you saved dlm locking ping-pongs?
>>>> The code change will hold the reflink destination dir inode dlm=20
>>>> lock, release it until the whole reflink process is completed.
>>>> The current code will hold/release this dlm lock three times during=20
>>>> the reflink process. If there are some concurrently reflink=20
>>>> operation to that directory from other nodes, the ping-pong effect=20
>>>> is that directory inode related data will be synchronized(multiple=20
>>>> times) to the disk when inode dlm lock is downconverted during one=20
>>>> reflink operation.
>>>>
>>> I think the above can be a good summary, but not details or the=20
>>> locking ping-pong procedure. =C2=A0I need the details to understand the=
=20
>>> situation. For details, Which locks are involved, what are the=20
>>> locking types, which nodes are involved.
>>
>> The problem is clone files to the same directory simultaneously, for=20
>> some users, they like to add this task to each node as a crontab job.
>> The main impact factor is the destination dir inode dlm lock in this=20
>> case, each reflink operation will acquire/release this dlm lock three=20
>> time. For parallel environment, each node will contend this dlm lock,=20
>> that means there will be some lock downconvert costs(sync the inode=20
>> meta-data to the disk before downconvert).
>> For the code logic, I think we can identify this problem clearly=EF=BC=
=8CI
>> do not think we need performance related tool to help us.
>> Here, I can share my test results for clone files to the same=20
>> directory simultaneously.
>> 1) test script on each node: https://pastebin.com/y8EcCjWK=20
>> <https://pastebin.com/y8EcCjWK>
>=20
> I am pasting your test script here:
>=20
>  =C2=A0=C2=A01 loop=3D1
>  =C2=A0 2 while ((loop++)) ; do
>  =C2=A0 3
>  =C2=A0 4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in `seq 1 100`; do
>  =C2=A0 5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reflink=
 "/mnt/shared/testnode1.qcow2"=20
> "/mnt/shared/.snapshots/testnode1.qcow2.${loop}.${i}.`date=20
> +%m%d%H%M%S`.`hostname`"
>  =C2=A0 6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done
>  =C2=A0 7
>  =C2=A0 8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f /mnt/shared/.snapshots/testno=
de1.qcow2.*.`hostname`
>  =C2=A0 9 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "`hostname` `date +%m%d%H%M%S`=
: loop - $loop"
>  =C2=A010 done
>=20
> I think your test script would heavily depends on the size of file=20
> testnode1.qcow2 and how fragmented it is. =C2=A0That would impact the num=
ber=20
> of extent records to be copied.
> Let=E2=80=99s simplify the reflink procedure with your patch applied:
>=20
> 1) lock destination dir
> 2) extent record copy
> 3) unlock destination dir
>=20
> Apply this to multinode case:
>=20
> node1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node2=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node=
3
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=E2=80=94=E2=80=94=E2=80=94=E2=80=94 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =E2=80=94=E2=80=94=E2=80=94=E2=80=94
> lock
> extent copy
> unlock
>=20
>  =C2=A0 =C2=A0lock
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0extent copy
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extent copy
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock
>=20
>=20
> As you said, you saved the time of down-converting by serializing the=20
> reflink opertions targeting the directory. But seems you skipped the=20
> impact of extent copy.
> If extent copy take much more time than lock down-convertings, your=20
> patch may slowdown the whole reflink operations among the three nodes.
> The time for extent copy depends:
> a) number of extents to copy. more extents more time
> b) CPUs load on the nodes, higher CPU load more time
> c) OCFS2 device load, higher load more time
>=20
> I don=E2=80=99t know if you considered above factors when you did your te=
st. =C2=A0I=20
> was ever playing reflink with well fragmented 50GB file (though it=E2=80=
=99s not=20
> OCFS2). When load is added, a single run of reflink take 20+m.
> So I=E2=80=99d like to see your test for at least this case:
> I) make the reflink source file 50GiB long (with FS cluster size 1MiB) an=
d
> II) make the reflink source file well fragmented (suggest 40%=20
> fragmentation) and
> III) add some CPU and block device load and
> IV) add some file creation/removal operations under the same destination=
=20
> directory as the reflinks do, and collect the time for each operations.=20
> Do it on all the three nodes.
>=20
> For II), I=E2=80=99d suggest 40% fragmentation ratio, some example output=
 and=20
> time for reflinks
> debugfs: frag /file1
> Inode: 592130% fragmented: 40.00clusters: 51200extents: 20481score: 40
>=20
> [root@wengwan-ocfs2-3 opc]# time reflink /ocfs2/file1 /ocfs2/dir1/reflink=
1
>=20
> real0m6.837s
> user0m0.000s
> sys0m6.828s
> [root@wengwan-ocfs2-3 opc]# time reflink /ocfs2/file1 /ocfs2/dir1/reflink=
2
>=20
> real0m3.799s
> user0m0.000s
> sys0m3.799s
> [root@wengwan-ocfs2-3 opc]# time reflink /ocfs2/file1 /ocfs2/dir1/reflink=
3
>=20
> real0m3.802s
> user0m0.001s
> sys0m3.801s
>=20
> I=E2=80=99d guess you may get negative result comparing to original kerne=
l for=20
> both reflink and file creation/removal.

I create the similar files(include lots of meta-data blocks), and clone=20
them to the same directory,
Based on my testing, it looks the performance is not be improved between=20
the current code and the patched code.
So, I'd like to revoke this patch.


Thanks a lot.
Gang


>=20
> thanks,
> wengang
>=20
>> 2) Performance log of current parallel reflink:
>> https://pastebin.com/qGSedy8E <https://pastebin.com/qGSedy8E>
>> 3) Performance log of parallel reflink after patching:
>> https://pastebin.com/xkyxtNU4 <https://pastebin.com/xkyxtNU4>
>>
>> For the performance logs, the test time has been cut in half for every=20
>> hundred reflink operations.
>>
>> In sum, I think this code change logic is simple and clear, can improve
>> the performance in the above case. Of course, I also want more people=20
>> to review if there is any risk after this patch, e.g. add dead-lock=20
>> risk, etc.
>>
>>
>>
>> Thanks
>> Gang
>>
>>
>>> Say like this (just for an example, not related to the problem here):
>>> Node 1 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Node 2=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Node 3
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>>> dir1 meta lock EX
>>> orphandir1 lock EX
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dir1 meta lock EX
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0orphadir2 lock EX
>>> =C2=A0dir1 meta lock EX
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0orphad=
ir3=20
>>> lock EX
>>> dir1 meta block EX (again)
>>> =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6..
>>>> According to my test, running the reflink command to clone a file to=20
>>>> the same directory repeatedly from three nodes, the code change can=20
>>>> shorten the previous half of the time.
>>>>
>>> I am not sure if above is a typical use case.
>>> What else cases did you test? Did it help in case only one node do=20
>>> the reflink?
>>> What if there are concurrent file creating/removing operations going=20
>>> on under the target directory when the reflink is going on?
>>> =C2=A0I think when you are trying to make a performance improvement, =
=C2=A0you=20
>>> should provide the performance data for different test cases, like this=
:
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>>> Test case desc =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| orig p=
erformance =C2=A0| performance after=20
>>> patched =C2=A0=C2=A0|
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>>> test case1 (details) =C2=A0| perf data =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| perf data=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-
>>> test case2 (details) =C2=A0=C2=A0| perf data =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| perf data=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>>> =E2=80=A6=E2=80=A6
>>> thanks,
>>> wengang
>>>> Thanks
>>>> Gang
>>>>
>>>>> And what cases did you test to get better performance?
>>>>> thanks,
>>>>> wengang
>>>>>> On Aug 30, 2021, at 11:25 PM, Gang He <ghe@suse.com=20
>>>>>> <mailto:ghe@suse.com>> wrote:
>>>>>>
>>>>>> Hello Joseph and Wengang,
>>>>>>
>>>>>> When you have time, please help review this patch.
>>>>>> About the deadlock problem which was caused by ocfs2_downconvert_loc=
k
>>>>>> failure, we have the fix patch, it is very key.
>>>>>> But I feel this patch is still useful as a optimization patch, the=20
>>>>>> user
>>>>>> case is to reflink the files to the same directory concurrently, our
>>>>>> users usually backup the files(via reflink) from the cluster nodes
>>>>>> concurrently(via crontab) every day/hour.
>>>>>> The current design, during the reflink process, the node will
>>>>>> acquire/release dlm lock of the target directory multiple times,
>>>>>> this is very inefficient in concurrently reflink.
>>>>>>
>>>>>>
>>>>>> Thanks
>>>>>> Gang
>>>>>>
>>>>>> On 2021/8/26 15:59, Gang He wrote:
>>>>>>> During the reflink process, we should acquire the target directory
>>>>>>> inode dlm lock at the beginning, and hold this dlm lock until end
>>>>>>> of the function.
>>>>>>> With this patch, we avoid dlm lock ping-pong effect when clone
>>>>>>> files to the same directory simultaneously from multiple nodes.
>>>>>>> There is a typical user scenario, users regularly back up files
>>>>>>> to a specified directory through the reflink feature from the
>>>>>>> multiple nodes.
>>>>>>>
>>>>>>> Signed-off-by: Gang He <ghe@suse.com <mailto:ghe@suse.com>>
>>>>>>> ---
>>>>>>> =C2=A0fs/ocfs2/namei.c =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
32 +++++++++++++-------------------
>>>>>>> =C2=A0fs/ocfs2/namei.h =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
=C2=A02 ++
>>>>>>> =C2=A0fs/ocfs2/refcounttree.c | 15 +++++++++++----
>>>>>>> =C2=A0fs/ocfs2/xattr.c =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
12 +-----------
>>>>>>> =C2=A0fs/ocfs2/xattr.h =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
=C2=A01 +
>>>>>>> =C2=A05 files changed, 28 insertions(+), 34 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>>>>>>> index 2c46ff6ba4ea..f8bbb22cc60b 100644
>>>>>>> --- a/fs/ocfs2/namei.c
>>>>>>> +++ b/fs/ocfs2/namei.c
>>>>>>> @@ -2489,6 +2489,7 @@ static int=20
>>>>>>> ocfs2_prep_new_orphaned_file(struct inode *dir,
>>>>>>> =C2=A0}
>>>>>>>
>>>>>>> =C2=A0int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>>>>> +struct buffer_head **dir_bh,
>>>>>>> int mode,
>>>>>>> struct inode **new_inode)
>>>>>>> =C2=A0{
>>>>>>> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct=20
>>>>>>> inode *dir,
>>>>>>>
>>>>>>> brelse(new_di_bh);
>>>>>>>
>>>>>>> -if (!status)
>>>>>>> -*new_inode =3D inode;
>>>>>>> -
>>>>>>> ocfs2_free_dir_lookup_result(&orphan_insert);
>>>>>>>
>>>>>>> -ocfs2_inode_unlock(dir, 1);
>>>>>>> -brelse(parent_di_bh);
>>>>>>> +if (!status) {
>>>>>>> +*new_inode =3D inode;
>>>>>>> +*dir_bh =3D parent_di_bh;
>>>>>>> +} else {
>>>>>>> +ocfs2_inode_unlock(dir, 1);
>>>>>>> +brelse(parent_di_bh);
>>>>>>> +}
>>>>>>> +
>>>>>>> return status;
>>>>>>> =C2=A0}
>>>>>>>
>>>>>>> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct=20
>>>>>>> ocfs2_super *osb,
>>>>>>> =C2=A0}
>>>>>>>
>>>>>>> =C2=A0int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>>>>> +=C2=A0=C2=A0struct buffer_head *dir_bh,
>>>>>>> =C2=A0=C2=A0struct inode *inode,
>>>>>>> =C2=A0=C2=A0struct dentry *dentry)
>>>>>>> =C2=A0{
>>>>>>> int status =3D 0;
>>>>>>> -struct buffer_head *parent_di_bh =3D NULL;
>>>>>>> handle_t *handle =3D NULL;
>>>>>>> struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
>>>>>>> struct ocfs2_dinode *dir_di, *di;
>>>>>>> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct=20
>>>>>>> inode *dir,
>>>>>>> (unsigned long long)OCFS2_I(dir)->ip_blkno,
>>>>>>> (unsigned long long)OCFS2_I(inode)->ip_blkno);
>>>>>>>
>>>>>>> -status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
>>>>>>> -if (status < 0) {
>>>>>>> -if (status !=3D -ENOENT)
>>>>>>> -mlog_errno(status);
>>>>>>> -return status;
>>>>>>> -}
>>>>>>> -
>>>>>>> -dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
>>>>>>> +dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
>>>>>>> if (!dir_di->i_links_count) {
>>>>>>> /* can't make a file in a deleted directory. */
>>>>>>> status =3D -ENOENT;
>>>>>>> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct=20
>>>>>>> inode *dir,
>>>>>>> goto leave;
>>>>>>>
>>>>>>> /* get a spot inside the dir. */
>>>>>>> -status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
>>>>>>> +status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dentry->d_name.name,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dentry->d_name.len, &lookup);
>>>>>>> if (status < 0) {
>>>>>>> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct=20
>>>>>>> inode *dir,
>>>>>>> ocfs2_journal_dirty(handle, di_bh);
>>>>>>>
>>>>>>> status =3D ocfs2_add_entry(handle, dentry, inode,
>>>>>>> -OCFS2_I(inode)->ip_blkno, parent_di_bh,
>>>>>>> +OCFS2_I(inode)->ip_blkno, dir_bh,
>>>>>>> &lookup);
>>>>>>> if (status < 0) {
>>>>>>> mlog_errno(status);
>>>>>>> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct=20
>>>>>>> inode *dir,
>>>>>>> iput(orphan_dir_inode);
>>>>>>> =C2=A0leave:
>>>>>>>
>>>>>>> -ocfs2_inode_unlock(dir, 1);
>>>>>>> -
>>>>>>> brelse(di_bh);
>>>>>>> -brelse(parent_di_bh);
>>>>>>> brelse(orphan_dir_bh);
>>>>>>>
>>>>>>> ocfs2_free_dir_lookup_result(&lookup);
>>>>>>> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
>>>>>>> index 9cc891eb874e..03a2c526e2c1 100644
>>>>>>> --- a/fs/ocfs2/namei.h
>>>>>>> +++ b/fs/ocfs2/namei.h
>>>>>>> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0struct buffer_head *orphan_dir_bh,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0bool dio);
>>>>>>> =C2=A0int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>>>>> +struct buffer_head **dir_bh,
>>>>>>> int mode,
>>>>>>> struct inode **new_inode);
>>>>>>> =C2=A0int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
>>>>>>> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct=20
>>>>>>> ocfs2_super *osb,
>>>>>>> struct inode *inode, struct buffer_head *di_bh,
>>>>>>> int update_isize, loff_t end);
>>>>>>> =C2=A0int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>>>>> +=C2=A0=C2=A0struct buffer_head *dir_bh,
>>>>>>> =C2=A0=C2=A0struct inode *new_inode,
>>>>>>> =C2=A0=C2=A0struct dentry *new_dentry);
>>>>>>>
>>>>>>> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>>>>>>> index 7f6355cbb587..a9a0c7c37e8e 100644
>>>>>>> --- a/fs/ocfs2/refcounttree.c
>>>>>>> +++ b/fs/ocfs2/refcounttree.c
>>>>>>> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry=20
>>>>>>> *old_dentry, struct inode *dir,
>>>>>>> =C2=A0{
>>>>>>> int error, had_lock;
>>>>>>> struct inode *inode =3D d_inode(old_dentry);
>>>>>>> -struct buffer_head *old_bh =3D NULL;
>>>>>>> +struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
>>>>>>> struct inode *new_orphan_inode =3D NULL;
>>>>>>> struct ocfs2_lock_holder oh;
>>>>>>>
>>>>>>> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry=20
>>>>>>> *old_dentry, struct inode *dir,
>>>>>>> return -EOPNOTSUPP;
>>>>>>>
>>>>>>>
>>>>>>> -error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
>>>>>>> +error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode=
,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0&new_orphan_inode);
>>>>>>> if (error) {
>>>>>>> mlog_errno(error);
>>>>>>> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry=20
>>>>>>> *old_dentry, struct inode *dir,
>>>>>>>
>>>>>>> /* If the security isn't preserved, we need to re-initialize them. =
*/
>>>>>>> if (!preserve) {
>>>>>>> -error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
>>>>>>> +error =3D ocfs2_init_security_and_acl(dir, dir_bh,
>>>>>>> +=C2=A0=C2=A0=C2=A0new_orphan_inode,
>>>>>>> =C2=A0=C2=A0=C2=A0&new_dentry->d_name);
>>>>>>> if (error)
>>>>>>> mlog_errno(error);
>>>>>>> }
>>>>>>> if (!error) {
>>>>>>> -error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
>>>>>>> +error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_orphan_inode,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_dentry);
>>>>>>> if (error)
>>>>>>> mlog_errno(error);
>>>>>>> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry=20
>>>>>>> *old_dentry, struct inode *dir,
>>>>>>> iput(new_orphan_inode);
>>>>>>> }
>>>>>>>
>>>>>>> +if (dir_bh) {
>>>>>>> +ocfs2_inode_unlock(dir, 1);
>>>>>>> +brelse(dir_bh);
>>>>>>> +}
>>>>>>> +
>>>>>>> return error;
>>>>>>> =C2=A0}
>>>>>>>
>>>>>>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>>>>>>> index dd784eb0cd7c..3f23e3a5018c 100644
>>>>>>> --- a/fs/ocfs2/xattr.c
>>>>>>> +++ b/fs/ocfs2/xattr.c
>>>>>>> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode=20
>>>>>>> *old_inode,
>>>>>>> =C2=A0/*
>>>>>>> =C2=A0=C2=A0* Initialize security and acl for a already created ino=
de.
>>>>>>> =C2=A0=C2=A0* Used for reflink a non-preserve-security file.
>>>>>>> - *
>>>>>>> - * It uses common api like ocfs2_xattr_set, so the caller
>>>>>>> - * must not hold any lock expect i_mutex.
>>>>>>> =C2=A0=C2=A0*/
>>>>>>> =C2=A0int ocfs2_init_security_and_acl(struct inode *dir,
>>>>>>> +struct buffer_head *dir_bh,
>>>>>>> struct inode *inode,
>>>>>>> const struct qstr *qstr)
>>>>>>> =C2=A0{
>>>>>>> int ret =3D 0;
>>>>>>> -struct buffer_head *dir_bh =3D NULL;
>>>>>>>
>>>>>>> ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
>>>>>>> if (ret) {
>>>>>>> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct=20
>>>>>>> inode *dir,
>>>>>>> goto leave;
>>>>>>> }
>>>>>>>
>>>>>>> -ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
>>>>>>> -if (ret) {
>>>>>>> -mlog_errno(ret);
>>>>>>> -goto leave;
>>>>>>> -}
>>>>>>> ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
>>>>>>> if (ret)
>>>>>>> mlog_errno(ret);
>>>>>>>
>>>>>>> -ocfs2_inode_unlock(dir, 0);
>>>>>>> -brelse(dir_bh);
>>>>>>> =C2=A0leave:
>>>>>>> return ret;
>>>>>>> =C2=A0}
>>>>>>> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
>>>>>>> index 00308b57f64f..b27fd8ba0019 100644
>>>>>>> --- a/fs/ocfs2/xattr.h
>>>>>>> +++ b/fs/ocfs2/xattr.h
>>>>>>> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>>>>>>> struct buffer_head *new_bh,
>>>>>>> bool preserve_security);
>>>>>>> =C2=A0int ocfs2_init_security_and_acl(struct inode *dir,
>>>>>>> +struct buffer_head *dir_bh,
>>>>>>> struct inode *inode,
>>>>>>> const struct qstr *qstr);
>>>>>>> =C2=A0#endif /* OCFS2_XATTR_H */
>>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Ocfs2-devel mailing list
>>>>>> Ocfs2-devel@oss.oracle.com <mailto:Ocfs2-devel@oss.oracle.com>
>>>>>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>>>
>>
>=20

