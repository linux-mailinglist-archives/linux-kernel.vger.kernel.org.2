Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F040A79D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbhINHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:36:57 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:46029 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241119AbhINHgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631604880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3idExvRg/Y3IA79kMFhT/dcVfmbWeNK31riQvcNLxg=;
        b=L4rj6WIOpsynxvBMDOMSrohxtT9uXH3yCybirqUtmo+D0lwcwAAaWmsj8w6CTTx6XoKtLI
        Ze9geAOBjQnE8X8xHnzGlCfBHTGcIgE4fsGTRL718sErmnfWssT5aNZrc8sHKbJ2R6B2P4
        IOOjQ7sjJ73HASJrKClAc6PIZfDdx9E=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-tfsUrqL2NU6zumCdKTi0rA-1; Tue, 14 Sep 2021 09:34:39 +0200
X-MC-Unique: tfsUrqL2NU6zumCdKTi0rA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+qp/w1URw2HKXvFlowueAUFcwkLTMDZOCYh7ldl8muVdQ1WVuiMgVncZ2MWet7Bfs5XjzvokuXAKYOXDi32twOkUlCIMTI0QViOb+V5NIEbo9wHFpz9u1Xpu9UMjTXidnNqOaMtwtRo33iYpkruZtR3Ad5Nz78J+iUKLd2IlinFMJ92QxaK4DcjMuuj7uB66PHyUj70tqgfgCqqkiFu1XFSlr0XdMhH8NnULh1ceTdisv+gkCybFs+sq4mNGKyI9j8QAAl7RCyRdhYIMuh/hamzL4buUWYNZMFRD05vsl8eyK7D8oV8BjcQN9N2wPt3qyJ6WObXrUgLcu7kCR0HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9BeA5wJ9xssYsJjk2JKGrCp0Zd98UJ1SZoERlM8SAcw=;
 b=SJUNqkFfPZQlE8fXH73zepDwLHaCH3Vm3iNkAsg0bFs/oalAseHN2engz9gaH84cqtE1/DnNAVaPFpWdxwtia1lnugBhxO/ee/fcgUKYVOrLSHftGy+L7BRKptfmX0MWY/QKrbSjlLBERC8Z8v65WtEI+0uenRucWsD+i7DcPlb7phDobNlYxl9KpfxSI3MuQ4EC3/GXBCsNbWOT+SR0chB3Ws2n6lbObiZr6fmAIob6xwE8nwabv5/2vRcryrgr/hgPmJKE0LiKitLFMPWjmqQ0nExcE132+i3p/J8uFdRe45UKWvdzlpo4VYtK9RenHYupBSl6yIs7xqC2/K9VGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM5PR0401MB2531.eurprd04.prod.outlook.com (2603:10a6:203:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 14 Sep
 2021 07:34:37 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 07:34:37 +0000
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
From:   Gang He <ghe@suse.com>
Message-ID: <60b3e52b-fdab-5255-3339-de3d95555dca@suse.com>
Date:   Tue, 14 Sep 2021 15:34:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <3672BDE0-3D94-4522-9059-A75C91784415@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 07:34:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d86016-0d00-4032-bfda-08d977521af0
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2531:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2531EB31B799DBDE7ECA35E3CFDA9@AM5PR0401MB2531.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGccbj1lCUt+8B8Q0sqCMrqqZYRcPBfqTDNfKaTur7kXOniA3ivakR5gxT2a5OzNIP6xW/FOUxTu/LdWqzALeP5i1poNRsarD+fWE07E+ymd7VQFVqMs4fkUTcL6cxmaBIJW0aS1AIuxGX1+rqZ4eCQgJSKMZ5C705T3QUWeSvTTJUlr4AZrhX1HTb/yJEgh+krazOD++rBbRY38ESm/Hdcs6gbtj9tgQusbriv0+ACKKGSR8270y834OHjIRvVauajOo3/PKlkWvj7wNBmOB/zg8czIwE0WNJOKJMaaDOYmd4AwfroGPjZZl9JGmVnDRb0HANuvDMB38t6hgE3Ubbr4xM0+uNG4r/9glH1WcOLrORY/iChSv47cHDpnITfzFPcg3dHRI2u8n/XTCJzrjuPVtPeQsldvdPupzTtzODXrgotLnkzRsXvVB+aAPY3hTeYHN4KqW4wd6VTtsYCR/yKo/kRnvdkdNM6njQJyHCtQ4weO8urS5zvDUzpGHKHGUDqL5xZjRFmvXQ47zXWEl7aMMHp6k1iZ8VKUF/Ya5Nm2wKdvxSRKZfMJYdonhfCWuxPw9aufCKlQXzhCAnFKJFSt90LgMA8xTbgB9IBy8ArNAsN1vTwr1Ad/51CCJJ94Weyh2Ob/nZfeW174Md9j3TP0uW/g9GLoXy0ihlekbQfVUrTCZ/jV5KSf8vEkrpZoISlxscpggclI5WLXfBMh5NbtgmKBb7WhnHO63+ExzWt39Z7dT1VI2kwdTkBQPekriis+C8Qjkcl9A+0azh8sbHOfaAG8Q5Rajl9ADHaD2ek/kTSltGcXs9nkAAbcKH0HxgghsajnRcu23Zm0F9kwg5ZerLVciFRLppw2ECcNeNpi3OiyN6M0ERDNymPuqMCg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(366004)(136003)(86362001)(55236004)(16576012)(6916009)(8936002)(31686004)(8676002)(5660300002)(316002)(53546011)(38100700002)(36756003)(186003)(6486002)(2906002)(66946007)(4326008)(31696002)(6666004)(66556008)(66476007)(30864003)(54906003)(956004)(966005)(26005)(2616005)(478600001)(83380400001)(10126625002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3FwPU6gdYeAXZgbx/tN6S/bpjSr657BETdzLIOsshdSU1k9Cr9bLg/xpGJW?=
 =?us-ascii?Q?Prsdbyvrw0O8hDRZjYE5QEZK0aMb4muplUd5R+fn+aLUEEU7vx6wST5ku71E?=
 =?us-ascii?Q?xduQcdqg2JVyabKeJplAe5caqkwvsG4LO7bVTPOpUBpJV796AmdsslUFOjF0?=
 =?us-ascii?Q?zn/d8wZhl74aCZm5B5//mHWreD3d1J/wNHvd/QNiJ5vEULi/y0flMpcS6PVS?=
 =?us-ascii?Q?b+Z7JSRLy0JbiLTq1Trj0Q8PapY1WQK9zis4I7Gou8STmU8kT2B1nknadEwl?=
 =?us-ascii?Q?ZwUx5cJZsSK36IPku5YAHE8uzj6bqUpYKqMuD0ZAP5WnqLzBBHcLl4vLKr/E?=
 =?us-ascii?Q?XGV0ydLJLfV7uG4VBWewq3I45yeRBOCLiVnWj2z213Ux2Pt8vPTMY8pb5/rJ?=
 =?us-ascii?Q?6unveszIddizodCcScy8eeMF/VwlQwz4gT9ez3893GF+5Y5oJx3kNHpJYOJi?=
 =?us-ascii?Q?f2IwuDwYFWisoQYTK8QmVFFUnXypHMdwGfIoExK2Qfnfscih94VQNqq7+uto?=
 =?us-ascii?Q?lN5nU1WqEj+uGFu03/xHkHQmR2m/x6R+nXyyzfqdPJEi7p49QsWffWUy0EEq?=
 =?us-ascii?Q?Itrj8UVQORW8fGDHTJoVX1A2iXK+VDQnsbCxpPzsJp85/rsk6+LQzk7RFNbS?=
 =?us-ascii?Q?x2U36YYyS11rDrQ3nJDYPxbl6DLJjyEucRUEMleDXFYZAtp+dFek4mN6OQEG?=
 =?us-ascii?Q?+4Crfnas3CN6UFx08t96vZvgzLjVPoLjwcppYqLI+yq5Bq+yY5hXJjy+6hl2?=
 =?us-ascii?Q?KJCLbd3/v4hDMZjWxypOV+HysJ5SIEeD88y1nxfLbNuTS2F6vVhEoYG/MBQQ?=
 =?us-ascii?Q?a9OC5cFbXsM7Y4g0MGgB1w3sNZwBtFULZk9O8Q7r/pcQoAaalsKF4S515nAD?=
 =?us-ascii?Q?jdt47gSiOYD51I7YZrtJ9E/pAexnjKK8dpTh8z4uiYSZ1SuneYYVqHw1q4Ov?=
 =?us-ascii?Q?bs0iZ7PV8z4E1p87TlHVyP4q9MKhC0heDJUeVomgR+fdqe0Fk/Ou5AmUxWTS?=
 =?us-ascii?Q?18caW/DRA4LH0CaKoSdszp6iDJtv+hNolL+8hfHbMMxeb2zjUVF1PvxlBI33?=
 =?us-ascii?Q?QRmSvf1Exx/BWbEbsscdzelGCXrnp+SA7OS7CXEGzYw3clB0UoHajlQfWY6Y?=
 =?us-ascii?Q?umbJwiPqOKmpINFF0Ai3Cha9AaihSG9hchijSIkMXVUSdP29T33I/nXUKyQN?=
 =?us-ascii?Q?W1kiZcUG4Mu4+d8MipMsmHZ5E8sJ+sfBMPVaYUEiPW/SB7q5gqx0enEnQCH9?=
 =?us-ascii?Q?FC/Zj4JzXNgARE59E/5XGqcQ/8FMipvOtxgcbcTsztMq4Istqkz0kRhlKJMN?=
 =?us-ascii?Q?EHI/Wln9jchyXdVFZ3MC9uZ6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d86016-0d00-4032-bfda-08d977521af0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 07:34:37.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3AjaKn5EjnpAciIRI9893uK3Rvx+yDYfPtEeOZH3cp9VorP19AvtZl4lMw4plRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2531
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wengang,

Sorry for delayed reply.

On 2021/9/9 0:00, Wengang Wang wrote:
>=20
>=20
>> On Sep 7, 2021, at 11:06 PM, Gang He <ghe@suse.com> wrote:
>>
>>
>>
>> On 2021/9/7 23:57, Wengang Wang wrote:
>>> Hi Gang,
>>> Sure, I will look into the problem you are trying to address. Any bug f=
ix and performance improvement is welcomed!
>>> Well, can you please provide the analysis on the tcpdumps between the (=
two) nodes that covers the reflink operation with/without your patch to sho=
w how you saved dlm locking ping-pongs?
>> The code change will hold the reflink destination dir inode dlm lock, re=
lease it until the whole reflink process is completed.
>> The current code will hold/release this dlm lock three times during the =
reflink process. If there are some concurrently reflink operation to that d=
irectory from other nodes, the ping-pong effect is that directory inode rel=
ated data will be synchronized(multiple times) to the disk when inode dlm l=
ock is downconverted during one reflink operation.
>>
>=20
> I think the above can be a good summary, but not details or the locking p=
ing-pong procedure.  I need the details to understand the situation. For de=
tails, Which locks are involved, what are the locking types, which nodes ar=
e involved.

The problem is clone files to the same directory simultaneously, for=20
some users, they like to add this task to each node as a crontab job.
The main impact factor is the destination dir inode dlm lock in this=20
case, each reflink operation will acquire/release this dlm lock three=20
time. For parallel environment, each node will contend this dlm lock,=20
that means there will be some lock downconvert costs(sync the inode=20
meta-data to the disk before downconvert).
For the code logic, I think we can identify this problem clearly=EF=BC=8CI
do not think we need performance related tool to help us.
Here, I can share my test results for clone files to the same directory=20
simultaneously.
1) test script on each node: https://pastebin.com/y8EcCjWK
2) Performance log of current parallel reflink:
    https://pastebin.com/qGSedy8E
3) Performance log of parallel reflink after patching:
    https://pastebin.com/xkyxtNU4

For the performance logs, the test time has been cut in half for every=20
hundred reflink operations.

In sum, I think this code change logic is simple and clear, can improve
the performance in the above case. Of course, I also want more people to=20
review if there is any risk after this patch, e.g. add dead-lock risk, etc.



Thanks
Gang


>=20
> Say like this (just for an example, not related to the problem here):
>=20
> Node 1                                         Node 2                    =
                         Node 3
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94      =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94            =E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94
> dir1 meta lock EX
> orphandir1 lock EX
>                                               dir1 meta lock EX
>                                               orphadir2 lock EX
>=20
> 												  dir1 meta lock EX
>                                                                          =
                          orphadir3 lock EX
> dir1 meta block EX (again)
> =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6..
>=20
>=20
>> According to my test, running the reflink command to clone a file to the=
 same directory repeatedly from three nodes, the code change can shorten th=
e previous half of the time.
>>
>=20
> I am not sure if above is a typical use case.
> What else cases did you test? Did it help in case only one node do the re=
flink?
> What if there are concurrent file creating/removing operations going on u=
nder the target directory when the reflink is going on?
>=20
>   I think when you are trying to make a performance improvement,  you sho=
uld provide the performance data for different test cases, like this:
>=20
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> Test case desc         | orig performance  | performance after patched   =
|
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> test case1 (details)  | perf data               | perf data              =
                  |
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-
> test case2 (details)   | perf data               | perf data             =
                   |
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> =E2=80=A6=E2=80=A6
>=20
> thanks,
> wengang
>=20
>> Thanks
>> Gang
>>
>>> And what cases did you test to get better performance?
>>> thanks,
>>> wengang
>>>> On Aug 30, 2021, at 11:25 PM, Gang He <ghe@suse.com> wrote:
>>>>
>>>> Hello Joseph and Wengang,
>>>>
>>>> When you have time, please help review this patch.
>>>> About the deadlock problem which was caused by ocfs2_downconvert_lock
>>>> failure, we have the fix patch, it is very key.
>>>> But I feel this patch is still useful as a optimization patch, the use=
r
>>>> case is to reflink the files to the same directory concurrently, our
>>>> users usually backup the files(via reflink) from the cluster nodes
>>>> concurrently(via crontab) every day/hour.
>>>> The current design, during the reflink process, the node will
>>>> acquire/release dlm lock of the target directory multiple times,
>>>> this is very inefficient in concurrently reflink.
>>>>
>>>>
>>>> Thanks
>>>> Gang
>>>>
>>>> On 2021/8/26 15:59, Gang He wrote:
>>>>> During the reflink process, we should acquire the target directory
>>>>> inode dlm lock at the beginning, and hold this dlm lock until end
>>>>> of the function.
>>>>> With this patch, we avoid dlm lock ping-pong effect when clone
>>>>> files to the same directory simultaneously from multiple nodes.
>>>>> There is a typical user scenario, users regularly back up files
>>>>> to a specified directory through the reflink feature from the
>>>>> multiple nodes.
>>>>>
>>>>> Signed-off-by: Gang He <ghe@suse.com>
>>>>> ---
>>>>>   fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
>>>>>   fs/ocfs2/namei.h        |  2 ++
>>>>>   fs/ocfs2/refcounttree.c | 15 +++++++++++----
>>>>>   fs/ocfs2/xattr.c        | 12 +-----------
>>>>>   fs/ocfs2/xattr.h        |  1 +
>>>>>   5 files changed, 28 insertions(+), 34 deletions(-)
>>>>>
>>>>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>>>>> index 2c46ff6ba4ea..f8bbb22cc60b 100644
>>>>> --- a/fs/ocfs2/namei.c
>>>>> +++ b/fs/ocfs2/namei.c
>>>>> @@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct =
inode *dir,
>>>>>   }
>>>>>
>>>>>   int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>>> +				 struct buffer_head **dir_bh,
>>>>>   				 int mode,
>>>>>   				 struct inode **new_inode)
>>>>>   {
>>>>> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inode=
 *dir,
>>>>>
>>>>>   	brelse(new_di_bh);
>>>>>
>>>>> -	if (!status)
>>>>> -		*new_inode =3D inode;
>>>>> -
>>>>>   	ocfs2_free_dir_lookup_result(&orphan_insert);
>>>>>
>>>>> -	ocfs2_inode_unlock(dir, 1);
>>>>> -	brelse(parent_di_bh);
>>>>> +	if (!status) {
>>>>> +		*new_inode =3D inode;
>>>>> +		*dir_bh =3D parent_di_bh;
>>>>> +	} else {
>>>>> +		ocfs2_inode_unlock(dir, 1);
>>>>> +		brelse(parent_di_bh);
>>>>> +	}
>>>>> +
>>>>>   	return status;
>>>>>   }
>>>>>
>>>>> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_=
super *osb,
>>>>>   }
>>>>>
>>>>>   int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>>> +				   struct buffer_head *dir_bh,
>>>>>   				   struct inode *inode,
>>>>>   				   struct dentry *dentry)
>>>>>   {
>>>>>   	int status =3D 0;
>>>>> -	struct buffer_head *parent_di_bh =3D NULL;
>>>>>   	handle_t *handle =3D NULL;
>>>>>   	struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
>>>>>   	struct ocfs2_dinode *dir_di, *di;
>>>>> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inod=
e *dir,
>>>>>   				(unsigned long long)OCFS2_I(dir)->ip_blkno,
>>>>>   				(unsigned long long)OCFS2_I(inode)->ip_blkno);
>>>>>
>>>>> -	status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
>>>>> -	if (status < 0) {
>>>>> -		if (status !=3D -ENOENT)
>>>>> -			mlog_errno(status);
>>>>> -		return status;
>>>>> -	}
>>>>> -
>>>>> -	dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
>>>>> +	dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
>>>>>   	if (!dir_di->i_links_count) {
>>>>>   		/* can't make a file in a deleted directory. */
>>>>>   		status =3D -ENOENT;
>>>>> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode=
 *dir,
>>>>>   		goto leave;
>>>>>
>>>>>   	/* get a spot inside the dir. */
>>>>> -	status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
>>>>> +	status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>>>>>   					      dentry->d_name.name,
>>>>>   					      dentry->d_name.len, &lookup);
>>>>>   	if (status < 0) {
>>>>> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode=
 *dir,
>>>>>   	ocfs2_journal_dirty(handle, di_bh);
>>>>>
>>>>>   	status =3D ocfs2_add_entry(handle, dentry, inode,
>>>>> -				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
>>>>> +				 OCFS2_I(inode)->ip_blkno, dir_bh,
>>>>>   				 &lookup);
>>>>>   	if (status < 0) {
>>>>>   		mlog_errno(status);
>>>>> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inod=
e *dir,
>>>>>   	iput(orphan_dir_inode);
>>>>>   leave:
>>>>>
>>>>> -	ocfs2_inode_unlock(dir, 1);
>>>>> -
>>>>>   	brelse(di_bh);
>>>>> -	brelse(parent_di_bh);
>>>>>   	brelse(orphan_dir_bh);
>>>>>
>>>>>   	ocfs2_free_dir_lookup_result(&lookup);
>>>>> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
>>>>> index 9cc891eb874e..03a2c526e2c1 100644
>>>>> --- a/fs/ocfs2/namei.h
>>>>> +++ b/fs/ocfs2/namei.h
>>>>> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>>>>>   		     struct buffer_head *orphan_dir_bh,
>>>>>   		     bool dio);
>>>>>   int ocfs2_create_inode_in_orphan(struct inode *dir,
>>>>> +				 struct buffer_head **dir_bh,
>>>>>   				 int mode,
>>>>>   				 struct inode **new_inode);
>>>>>   int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
>>>>> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super =
*osb,
>>>>>   		struct inode *inode, struct buffer_head *di_bh,
>>>>>   		int update_isize, loff_t end);
>>>>>   int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>>>>> +				   struct buffer_head *dir_bh,
>>>>>   				   struct inode *new_inode,
>>>>>   				   struct dentry *new_dentry);
>>>>>
>>>>> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>>>>> index 7f6355cbb587..a9a0c7c37e8e 100644
>>>>> --- a/fs/ocfs2/refcounttree.c
>>>>> +++ b/fs/ocfs2/refcounttree.c
>>>>> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_den=
try, struct inode *dir,
>>>>>   {
>>>>>   	int error, had_lock;
>>>>>   	struct inode *inode =3D d_inode(old_dentry);
>>>>> -	struct buffer_head *old_bh =3D NULL;
>>>>> +	struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
>>>>>   	struct inode *new_orphan_inode =3D NULL;
>>>>>   	struct ocfs2_lock_holder oh;
>>>>>
>>>>> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_den=
try, struct inode *dir,
>>>>>   		return -EOPNOTSUPP;
>>>>>
>>>>>
>>>>> -	error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
>>>>> +	error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode,
>>>>>   					     &new_orphan_inode);
>>>>>   	if (error) {
>>>>>   		mlog_errno(error);
>>>>> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_d=
entry, struct inode *dir,
>>>>>
>>>>>   	/* If the security isn't preserved, we need to re-initialize them.=
 */
>>>>>   	if (!preserve) {
>>>>> -		error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
>>>>> +		error =3D ocfs2_init_security_and_acl(dir, dir_bh,
>>>>> +						    new_orphan_inode,
>>>>>   						    &new_dentry->d_name);
>>>>>   		if (error)
>>>>>   			mlog_errno(error);
>>>>>   	}
>>>>>   	if (!error) {
>>>>> -		error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
>>>>> +		error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
>>>>> +						       new_orphan_inode,
>>>>>   						       new_dentry);
>>>>>   		if (error)
>>>>>   			mlog_errno(error);
>>>>> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_de=
ntry, struct inode *dir,
>>>>>   			iput(new_orphan_inode);
>>>>>   	}
>>>>>
>>>>> +	if (dir_bh) {
>>>>> +		ocfs2_inode_unlock(dir, 1);
>>>>> +		brelse(dir_bh);
>>>>> +	}
>>>>> +
>>>>>   	return error;
>>>>>   }
>>>>>
>>>>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>>>>> index dd784eb0cd7c..3f23e3a5018c 100644
>>>>> --- a/fs/ocfs2/xattr.c
>>>>> +++ b/fs/ocfs2/xattr.c
>>>>> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_in=
ode,
>>>>>   /*
>>>>>    * Initialize security and acl for a already created inode.
>>>>>    * Used for reflink a non-preserve-security file.
>>>>> - *
>>>>> - * It uses common api like ocfs2_xattr_set, so the caller
>>>>> - * must not hold any lock expect i_mutex.
>>>>>    */
>>>>>   int ocfs2_init_security_and_acl(struct inode *dir,
>>>>> +				struct buffer_head *dir_bh,
>>>>>   				struct inode *inode,
>>>>>   				const struct qstr *qstr)
>>>>>   {
>>>>>   	int ret =3D 0;
>>>>> -	struct buffer_head *dir_bh =3D NULL;
>>>>>
>>>>>   	ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
>>>>>   	if (ret) {
>>>>> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode =
*dir,
>>>>>   		goto leave;
>>>>>   	}
>>>>>
>>>>> -	ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
>>>>> -	if (ret) {
>>>>> -		mlog_errno(ret);
>>>>> -		goto leave;
>>>>> -	}
>>>>>   	ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL)=
;
>>>>>   	if (ret)
>>>>>   		mlog_errno(ret);
>>>>>
>>>>> -	ocfs2_inode_unlock(dir, 0);
>>>>> -	brelse(dir_bh);
>>>>>   leave:
>>>>>   	return ret;
>>>>>   }
>>>>> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
>>>>> index 00308b57f64f..b27fd8ba0019 100644
>>>>> --- a/fs/ocfs2/xattr.h
>>>>> +++ b/fs/ocfs2/xattr.h
>>>>> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>>>>>   			 struct buffer_head *new_bh,
>>>>>   			 bool preserve_security);
>>>>>   int ocfs2_init_security_and_acl(struct inode *dir,
>>>>> +				struct buffer_head *dir_bh,
>>>>>   				struct inode *inode,
>>>>>   				const struct qstr *qstr);
>>>>>   #endif /* OCFS2_XATTR_H */
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Ocfs2-devel mailing list
>>>> Ocfs2-devel@oss.oracle.com
>>>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>
>=20

