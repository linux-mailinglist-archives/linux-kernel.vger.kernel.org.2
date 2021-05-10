Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB63783C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEJKrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:47:35 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:31835 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232130AbhEJKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620643093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iodBpKvTFsXCsxP+sgr6RUNkAhwptzbgDxU/HqcGCqQ=;
        b=HEpgr2Vko8lE5bGC5VFyLZOg8LjGoEx1RuwxG+vcwM6bAs6iBBIGk9d54zXT9x2+Jc3Tkq
        Imx8PB3StUdFB8hGU6Zp8L+YRDDLVzUBmkLki2PAPfll7ZNdTkzDxQLOhV3YNnRW7Gc7Ae
        oAkF0feJEFNQ5xHjliRftkVlATo8S8w=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-M8XWwrydPx6FouekxoK47Q-1; Mon, 10 May 2021 12:38:12 +0200
X-MC-Unique: M8XWwrydPx6FouekxoK47Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edKv3IS2AlyJRv3/DItNZ6cdVtmHFFPlWUrQAb989RpFcWQ6dvGo1VkslyhE5B8B2Zr9mhLzEPatEIxHlWCB7L0dqOir0bL2nhWkgUUJ6RDVhAta/LjNEbeSn34/DinetZxIXiaEGa3+AAlNG8DsoQi8F+ruz+m5hY7+LsfbOS+mdrDROMUUrsfMEaKKc3sQOrkWUtm/J5H8fAjvEhC3oR8nW9Lula4+mVKNHydEr7zmsUuQYKer0b4OC3psRKdIkYuhvSij/MpIZ/OVvMhkTbYZpC7PETbu+31OCQnHl/Sg5tgRs6LpV5VLIfB9H44R42hdNWN69Vadb0U8mYKMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPTFfrxl+O627vD7WPBSj9+2Ql+mA9loLDxkqUtRPBc=;
 b=bppaL54EpUaD9lL/x0PozxRL3ohwaL2e/yPe3mgFWt47LKWyfsGyhmEyxMtW8YPgYTgGa49uqx9JfKnYIWGQy5x2NB1dR12haiiTPAV1/MqUOReLCDrvGnA+64A1RmSm3ZAMStlxpW+OPQr7JK5dTATnmBKGVntOeqLMta73DBZ/5vSdto6yknQOWo5/5xG4AONWy0+fQ5Sr4EO3GvWv0p1yP+qEF/7ZObmNqbFyJHs3I3v7MfigtL+zHP2wKce8v+QFCiyb8ze1OUN22oxC4UfBGS2m23FHCDtNFL/36OnHoYWm+SBkLfcL/BUptzcE3EABiPq2EaJ/IEQb0s6WHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB6481.eurprd04.prod.outlook.com (2603:10a6:208:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 10:38:11 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 10:38:11 +0000
To:     Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
CC:     Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210504155534.17270-1-varad.gautam@suse.com>
 <b693cd00-0cd4-3d4b-04c1-1c007f1c26d3@colorfullife.com>
From:   Varad Gautam <varad.gautam@suse.com>
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
Message-ID: <422e6fd4-acc7-9db3-96c2-e8a17032a14f@suse.com>
Date:   Mon, 10 May 2021 12:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <b693cd00-0cd4-3d4b-04c1-1c007f1c26d3@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: FR0P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::14) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.69] (95.90.93.216) by FR0P281CA0057.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend Transport; Mon, 10 May 2021 10:38:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6fdb11c-fd34-4a77-19f0-08d9139fb533
X-MS-TrafficTypeDiagnostic: AM0PR04MB6481:
X-Microsoft-Antispam-PRVS: <AM0PR04MB6481518F7EA66D9C82C426FCE0549@AM0PR04MB6481.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkbPZVi9B7sn11XqxpXZwL5/r250luqi4zkHRfttRj8Z2PSzxG8tMWkfkRAw4zPOEX+uXF4kFbSU4+eqy8+piru61tMfUgttvewD0irBLDnJKZkBr2I1fvwVIHlRNaZAY8lOC+IscSjoi2rZ1w3bNCb85yT6ML/u62Q8/ZGly2AB7tiOFhas5vuoksPCSykfhrGbDpMMYriJdvlLr5PUGmPhc5JDHomZy55ibq7tPc8yAl3J6gEDnqN4vML0QKBk8EHnHCjR09n03glF2qPeePWm+LA1BNaBwCXIx6xTsvpv1JPRPbhMnQbSRm4YNIC76vjMHdfH5EFK5jRrNYAsEZx/JhXCEsbbM0z5J2eXhiGYHZa6tZtEhNuw4t/Psbp2/QJ6ZK9HUTMR1Szw376IUHNXld5ihMs4kkWTlzt7feHY1HcJ8I+RybmmZsbOn2/nIDAPX2wUWckF7gH3n2cYEsp21nP3BCPSNnVaizD4OiqCwHtNVcToz2ksa4SwTMkbKbYGHzVm7OTi4p6mUMjAusxD6iLDkBHsNh1000u4sGqBgnBoogN0It1fZ/5topLojOweK3UuW3vqy5m5xjcgOY0rGQtmlH6nJ2Mm8LquJzNWycAjyUlmDk/K+r2/gIbX+HkPYlQ8VwuhYtlPb7wpI3qGwsQAfuFQXr9OuCLFxOhEhMtxwt7yBsAzxPpS1VWViE5ZhJDOw/rtRZ3hwcGtR/G/lpNPOcwNNhj444UmE9Q4bJWrTkzTnnUOfimWYYtxHgiiNr3x6PtrvxYCy2tuIkNqMMoHnaKGWISt2kmg7ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(52116002)(186003)(38100700002)(38350700002)(86362001)(8676002)(26005)(16526019)(36756003)(478600001)(4326008)(31696002)(6666004)(2616005)(966005)(8936002)(956004)(5660300002)(53546011)(2906002)(54906003)(66946007)(66574015)(66556008)(316002)(44832011)(16576012)(83380400001)(66476007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9UAZ8Bdn7Vyc+zNCGiIkG3UMvt4fUmfL1lWciJxQw5i12URza0wJ6OOxb4MF?=
 =?us-ascii?Q?GyEvDlNr5ywrg7RXqpLwrsrdnZAEOmPTwdDfXuZR+ioPpZ+z4tCjQim09Uvg?=
 =?us-ascii?Q?nOW368+mAkfVkmVjM0/xdc0EpPGmrU/UqthmjKWmYlLdpXrEM9nPvKXMWVi6?=
 =?us-ascii?Q?vKos/qBnwMhRAfwjfNAe8GiBNwXScrAQpIx28yRSNtvZBFYRUph0MiksZFjG?=
 =?us-ascii?Q?VpEp/rRM8tfTFcm4T7ApKaPfx6K5XAu6DGBOXZm5gVALLyfyZSvWqB+sQ+db?=
 =?us-ascii?Q?Jsu7D0/Q3daR5oU9Ldx0t53tn0kvE6Q9Od4j9QWyI9Zu98hAKGDh94X1TNrI?=
 =?us-ascii?Q?w2/MTvIPfrCBc9pYwbadAbQv49N2Eewea3jI4Gj50V5UlucE+C5xXu+q4Dwv?=
 =?us-ascii?Q?fhW8ilnfk/l/Q6SVmmnOcTGCGxJXePml6pkpM9oW3Z2u9b0kKpEAlKLFeuB0?=
 =?us-ascii?Q?eN8j4thS1AL6bbzWZCw7105Po51bHIXhBcnWuWKVjkRLWvD6ADz59+v8qn3D?=
 =?us-ascii?Q?FU3UYi69tb7fmeiirMR8Aj5dC7PCLoXTOIaKo2+WXFlJgG5o2O9o76uEo0xp?=
 =?us-ascii?Q?t1B5Yw8ez0mrtTbHs7Te0Kcq+mxAAxckXxYQz3Sk9+n482P3ROBkDoOF47Mp?=
 =?us-ascii?Q?9Og+EfplXCmpQtijcu5lo86364Yugkx53eO0t7Qlgsr7ggDSsKbpTcuHgHGY?=
 =?us-ascii?Q?OQNeucq1mZo5kmeL06zsS4xyQF20foWtrJb9JSsyyu+w52ZS6z05iHy059Ol?=
 =?us-ascii?Q?O52FiLBp/wvGxxVaPOXXubMuxHGBfKCk1ien11jyh3fqbbK9zKsm8QyeAGcf?=
 =?us-ascii?Q?4Sm7eGx0xbjkaBLhDxxfatETXh4QP9WdJjx10lJWS0loEvtXbAWGvJ5OEbHB?=
 =?us-ascii?Q?ywF4rZwcogN0p7en3TnynOGHTRYP9f6jlHUuL72vRBczBpWypx71C0KSbKh4?=
 =?us-ascii?Q?vwpyoMsNyLwSEfRap3Ii3soYklhDWhibzgm5s7f9TAwN5Em4vSexwbCqr+T+?=
 =?us-ascii?Q?O+/Wzc7uvezQv36Zh6lOgkn8X4fc9mOssaXa4J0Z4se6PduIvC8qh4e8G1aH?=
 =?us-ascii?Q?z26P3pZvh1NUj3ycJfuhjl41TY5OxpsmxmFG+Az2dd7rvzBCIuN+DCPA0PJI?=
 =?us-ascii?Q?es0pcQQWsiYzUEt1WMYg9DpT4TSOyBIOJMdBZ5QiHs9zpUxjM8vQRvg4sJ9I?=
 =?us-ascii?Q?0RnkIg9Ht3RKSRyziInQX80aY0WvQPTBBLA1QsJFCni0HHxSu4Wkcl55PUyV?=
 =?us-ascii?Q?KZEDF7M9RqbSiggclzi5/ppG3SCM3/pflKWP+MAR3174ddgtf32WazQJob0W?=
 =?us-ascii?Q?8phuil9P6ti42utMfa1qJOK2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fdb11c-fd34-4a77-19f0-08d9139fb533
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 10:38:11.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy0sMR6IrmDisCVErDUKkmeaCziy2xj0Fm+eq/8eO1iGcuYJwFplRaIp1gMcBqW4ZABDEWUdQGpOMSpFGc2obQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Manfred,

On 5/8/21 7:12 PM, Manfred Spraul wrote:
> Hi Varad,
>=20
> On 5/4/21 5:55 PM, Varad Gautam wrote:
>> do_mq_timedsend::__pipelined_op() should not dereference `this` after
>> setting STATE_READY, as the receiver counterpart is now free to return.
>> Change __pipelined_op to call wake_q_add_safe on the receiver's
>> task_struct returned by get_task_struct, instead of dereferencing
>> `this` which sits on the receiver's stack.
> Correct. I was so concentrated on the risks of reordered memory that I ha=
ve overlooked the simple bug.
>> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
> Actually, sem.c and msg.c contain the same bug. Thus all three must be fi=
xed.

You're right, it's the same usage pattern.

>> Signed-off-by: Varad Gautam <varad.gautam@suse.com>
>> Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Cc: Manfred Spraul <manfred@colorfullife.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Davidlohr Bueso <dbueso@suse.de>
>>
>> ---
>> =C2=A0 ipc/mqueue.c | 6 ++++--
>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 8031464ed4ae2..8f78057c6be53 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -1004,12 +1004,14 @@ static inline void __pipelined_op(struct wake_q_=
head *wake_q,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mqueue_inode_info *info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ext_wait_queue *this)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 struct task_struct *t;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&this->list);
>> -=C2=A0=C2=A0=C2=A0 get_task_struct(this->task);
>> +=C2=A0=C2=A0=C2=A0 t =3D get_task_struct(this->task);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* see MQ_BARRIER for purpose/pair=
ing */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_store_release(&this->state, STATE_REA=
DY);
>> -=C2=A0=C2=A0=C2=A0 wake_q_add_safe(wake_q, this->task);
>> +=C2=A0=C2=A0=C2=A0 wake_q_add_safe(wake_q, t);
>> =C2=A0 }
>=20
> The change fixes the issue, but I would prefer to use t =3D this->task in=
stead of using the return value of get_task_struct():
> Then all wake_q_add_safe() users are identical.
>=20
> Ok for you?
>=20
> Slightly tested patch attached.

Thanks, I've sent out a v4 at [1] integrating sem.c/msg.c. Note that I went=
 with
context-local naming and used what get_task_struct returns as I don't see m=
uch
difference either way.

[1] https://lore.kernel.org/lkml/20210510102950.12551-1-varad.gautam@suse.c=
om/

Thanks,
Varad

>=20
> --=20
>=20
> =C2=A0=C2=A0=C2=A0 Manfred
>=20

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany

HRB 36809, AG N=C3=BCrnberg
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

