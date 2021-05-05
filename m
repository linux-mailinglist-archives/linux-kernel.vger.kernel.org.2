Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3973735D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhEEHuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:50:10 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:48152 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhEEHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620200951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVCeEOusZv70UHXOl2srUtit/MMF41FzyPMgMbsM1iQ=;
        b=Y2Z0/k4UE0TSzGD7lGJJK/2SzW4XxiNRoi6x0KdTmNtcT8b7mWIAbX6d64VCepZdBd4XY4
        6BKDY9sk0mRGY8dJ2fOYsfP4j0qSneCnwoxErh9+jZwNCS7UNN9GFJBev3+hKPOPLt3Ekj
        JRspM6q/3YwlzmIIxC2Iev9pukcCGKg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-7-AVJJ6YrxN2GJDEvk6tp5dw-1;
 Wed, 05 May 2021 09:49:10 +0200
X-MC-Unique: AVJJ6YrxN2GJDEvk6tp5dw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvnaxXSDUG976wCf2GXvNHl5H3OoFolJTOZiObClVrsu3tE5JC+Khdz1Q7k9CudpPO8V/+VbQj7rzkTtEi8uAmQjrqBtL/1socH59DfYnn+utF/KyOxDo2BH+bDuBhT1lnJw4lhaeWA7dK3vfbSYZSly+rsbGaKalTVoHsEHIvaWfo3dyucBqcIfHtXc5F0TVTMDHKp9FrtsPZVW/3eWbg7r7sEk42cnSAwePPVsT2sa7TsdXDdI4Cb7+2cL2eN/Z2Jxei2qagE2Hrw3uA01rtfn+PDoU+YL+TeagjghpWkEjbdK6xMYfZxWFz3xaDUcZVVXVeAcQnjRZOVGCeaVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLH0B/l+nJ9HPEPY69ieurRI4S8KxULCwr0+UZFF728=;
 b=MavjwTN2Dai/WsVx1nGR7xAaqYdkjo0a2zV816JUUVomTJ0OalPhknSg563WFf9yP8zlmCX9CCiTIjAjMTFbMZWynye/TpqXJgZbvCq4YPYiZVRVNWkQlrf+Cayo4gBnIjimRZ2eA+S5viO66fit31HhyDNTmnbKb42fg0Qsa3stbOTqc+Uu1TEypLdBVMkoBQ7F5fnXJY8dVdhR6Ys5lOhw4c/YXzT9ljYz5WdAQTu7Tg/7MSQDcg+BvY1J264tFMF0GCvsXcl/HqhrcbbJZQbP5dkhK5m4B8S4UFAd41+hGFGOj8Wo7xEVSjx6KtwDkbJ4nR7L8I1wMI+z7IpBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB6770.eurprd04.prod.outlook.com (2603:10a6:208:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 07:49:07 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 07:49:07 +0000
To:     Davidlohr Bueso <dbueso@suse.de>
CC:     linux-kernel@vger.kernel.org,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210504155534.17270-1-varad.gautam@suse.com>
 <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
From:   Varad Gautam <varad.gautam@suse.com>
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
Message-ID: <fe1b29a0-af09-e270-de52-09bacac35d86@suse.com>
Date:   Wed, 5 May 2021 09:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.252] (95.90.93.216) by FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Wed, 5 May 2021 07:49:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2bae97a-e830-40eb-875e-08d90f9a431c
X-MS-TrafficTypeDiagnostic: AM0PR04MB6770:
X-Microsoft-Antispam-PRVS: <AM0PR04MB6770322560E20B869EEC6B86E0599@AM0PR04MB6770.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDuNon0VZyzIUU8LgB09cGlumQjHcXg0HDm0JB3jjxx5XceYErWKDN2k+8Mx2Caf7H5Qci2L/Kf7Cwqat+C9MxkKcuuLGoJem006bSVC68mwlUp+4FJVtwcps9TrlV6MR7usTVPIcMsu8TBsBaaGrkXxhUofQ/4t00Uem9gIzth0QFQ3zkAJrh3wsEYK1f04A7QhsJh+Mb+pFu3caMVsb6K41LA5HsLQ0Bee/MzLTO35yC7vgLCNJGmrQ5PPq1aCSgJf4YZ0LPP9PgxF6dcsPRlpfW0NRRWSDWl2XxYa/c6KjG72M8j/VM8Xv0mbnGicJSwjZ3/IZMO4kVCQ1BIiiQVLPuWDjeD0fPfpaXJ54qBJNLIJlGAWOWLvyOTpIrPX8D1A2nrNCOH7dcrrCfSe6U8HigIj3sLfskgoEej7F+4RYw36/Q4JYnKyfV1WiPNJWSPC6hJDFhn8Kyg2E4JWvDzXyvRVW/KSqNSjf4TcLu8+cRLiPyTkJxyPbEqftlOUR6VVocMv3u0SxGDg1pEg+uZjc7mbdkKgxJJeS6nA723qJDG0S7wpMhmGUNAUaPzG5+ISfgHgE3AIL3/3wr3SD11t+t6VzmOFD6K4kdRLNsOm15IU+0SmCgu2wfVf2vlUSXCBTvt2xl+1jXDNX4OKEk+GfZfbr2jSG0+V4u6g16OOmPoeiOHDWqkwM9Gg9wGF1w3TWNvYN46LrR8hXR2SXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(366004)(136003)(376002)(396003)(36756003)(6486002)(6916009)(31696002)(8936002)(31686004)(186003)(44832011)(86362001)(66476007)(66556008)(478600001)(16576012)(54906003)(5660300002)(2906002)(38100700002)(26005)(2616005)(8676002)(956004)(83380400001)(66574015)(52116002)(4326008)(66946007)(316002)(16526019)(53546011)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zucdWbWFpNEJGr8AiKAnZ5HlPTI38a3FdU3u0uo6ypiBsGphdACoAnbY4WhP?=
 =?us-ascii?Q?aU4TvANlh2n4Xrkhjo7TYwzL8ArUL3a5lQuE/jNVUnsEBkfW4z579L4OsAhn?=
 =?us-ascii?Q?EdUz/G6aCuhADXQ21O/d6lKJdFuWq2LtVuHDSN/vledkrFF2j6MjSnPuruH1?=
 =?us-ascii?Q?oND1GCsiorX+s3ORIaz+JSlMLQWOqRkTA1N8N5vffZhR6+tf+4FnuFsL8uGa?=
 =?us-ascii?Q?pkBQIvnlE7pHE4+OKaU6DfU+pv3W3Vq5y85ZCaC4cvCSGtUisQBzSngW+Kwx?=
 =?us-ascii?Q?a7cE2CgQI3y5iweH4XqcL+/2shJOdFeo88/4iGm2tDICBFpgxHFeRljXCZAP?=
 =?us-ascii?Q?dcnXXtyC8ujevPpUaYvDFgGF5YuJbUfzvP4fJENIuKScK9OH92GoBAgIENnv?=
 =?us-ascii?Q?Q2qKXGBU90i0ZueKPyQWJ3LiRIyCa5Ss/htYkYu2fvnNUVJFXsnes9wkfdjQ?=
 =?us-ascii?Q?c3d5f4JmmiPwTs3s/HxwuaV0PI+3g9bA2W7olw2DdcWf4GbSDTZRRpiKQm6o?=
 =?us-ascii?Q?eZRm/jBEPACzYxh/LvBJn5qg4x5a8m1NEbqik7bbhLyoAsM9gy21rpI3kxXk?=
 =?us-ascii?Q?BV6s+1aKgZoumNFLqzbOfu0hAfuBND68Ay5Itvyg4EtWizcFITy09rHBFKdf?=
 =?us-ascii?Q?eD2COj5nbvKkGDCgxBNiNiudg82jB4TWhYPj/UA3Y2NBwbLJjl0b8GPsGqMq?=
 =?us-ascii?Q?qmssqsVPNEpy/Z1td7bP24HRVZ8Pw6QEW5Zc8zySkAbvMPN9C7AIsXYYTqBM?=
 =?us-ascii?Q?IryrOXK/A8J49T5RImFZL0/zeR8YGZBsKrjyianEI0TEpUrEq02YWqfXcXX0?=
 =?us-ascii?Q?zt3ryIEJjbKqSRf1g7yvNSF2pcDgMjayNxQseKjkpoUCORjQ/+iwFhZEstur?=
 =?us-ascii?Q?yGDGyCWhKwPfJkqPdo3P/RETZ3CAeGxD3ATsWKxZgjE24Ap93K0GzORWEjXW?=
 =?us-ascii?Q?odPaQ3IDam1L7o0V/dmpex5OPAOQacXltR6mRHY5d8bynPB7Snb4hR34f3kK?=
 =?us-ascii?Q?CuAf5mm3v5Fx7UtngCc1OMLcZRJ5HWvs8V2zgS7Ve2oLr+DO2xoZjYfPgnqY?=
 =?us-ascii?Q?htyNWcnLlEcAIQtss1wzC5GRJL/P75Q3ek5UFEW1TbJ1EDBAKz79hE8v8lr9?=
 =?us-ascii?Q?d1gtjzkCceWv8KmbnRsEet0JXekE1SxXtYmm0hngOfvBlKCrCwUwwOvvH0Ox?=
 =?us-ascii?Q?mQKLN57a/WoQfvwKaHn1otUBJq7Uoqd1UE8/es/ffHoovhjMYcSrmRoZ+ufG?=
 =?us-ascii?Q?XIAt/HyV+b7ctd+TVQ7Vz/HAlcCWcg4vij0/EbxUEc6gzJ/QEDk+BbJHdYRR?=
 =?us-ascii?Q?PNP70ZkA5uAGm3Ho97Cvqkjo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bae97a-e830-40eb-875e-08d90f9a431c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 07:49:07.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up6iB9V8EqehImv3tYW2vVAGxKNzXCpWl02FeMhvx0kNphNNO8RFSdVvurAN3Q8naSS7Yvv4d6jWVXt89OxnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6770
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On 5/4/21 11:53 PM, Davidlohr Bueso wrote:
> On 2021-05-04 08:55, Varad Gautam wrote:
>> do_mq_timedreceive calls wq_sleep with a stack local address. The
>> sender (do_mq_timedsend) uses this address to later call
>> pipelined_send.
>>
>> This leads to a very hard to trigger race where a do_mq_timedreceive cal=
l
>> might return and leave do_mq_timedsend to rely on an invalid address,
>> causing the following crash:
>>
>> [=C2=A0 240.739977] RIP: 0010:wake_q_add_safe+0x13/0x60
>> [=C2=A0 240.739991] Call Trace:
>> [=C2=A0 240.739999]=C2=A0 __x64_sys_mq_timedsend+0x2a9/0x490
>> [=C2=A0 240.740003]=C2=A0 ? auditd_test_task+0x38/0x40
>> [=C2=A0 240.740007]=C2=A0 ? auditd_test_task+0x38/0x40
>> [=C2=A0 240.740011]=C2=A0 do_syscall_64+0x80/0x680
>> [=C2=A0 240.740017]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [=C2=A0 240.740019] RIP: 0033:0x7f5928e40343
>>
>> The race occurs as:
>>
>> 1. do_mq_timedreceive calls wq_sleep with the address of
>> `struct ext_wait_queue` on function stack (aliased as `ewq_addr` here)
>> - it holds a valid `struct ext_wait_queue *` as long as the stack has
>> not been overwritten.
>>
>> 2. `ewq_addr` gets added to info->e_wait_q[RECV].list in wq_add, and
>> do_mq_timedsend receives it via wq_get_first_waiter(info, RECV) to call
>> __pipelined_op.
>>
>> 3. Sender calls __pipelined_op::smp_store_release(&this->state, STATE_RE=
ADY).
>> Here is where the race window begins. (`this` is `ewq_addr`.)
>>
>> 4. If the receiver wakes up now in do_mq_timedreceive::wq_sleep, it
>> will see `state =3D=3D STATE_READY` and break. `ewq_addr` gets removed f=
rom
>> info->e_wait_q[RECV].list.
>>
>> 5. do_mq_timedreceive returns, and `ewq_addr` is no longer guaranteed
>> to be a `struct ext_wait_queue *` since it was on do_mq_timedreceive's
>> stack. (Although the address may not get overwritten until another
>> function happens to touch it, which means it can persist around for an
>> indefinite time.)
>>
>> 6. do_mq_timedsend::__pipelined_op() still believes `ewq_addr` is a
>> `struct ext_wait_queue *`, and uses it to find a task_struct to pass
>> to the wake_q_add_safe call. In the lucky case where nothing has
>> overwritten `ewq_addr` yet, `ewq_addr->task` is the right task_struct.
>> In the unlucky case, __pipelined_op::wake_q_add_safe gets handed a
>> bogus address as the receiver's task_struct causing the crash.
>>
>> do_mq_timedsend::__pipelined_op() should not dereference `this` after
>> setting STATE_READY, as the receiver counterpart is now free to return.
>> Change __pipelined_op to call wake_q_add_safe on the receiver's
>> task_struct returned by get_task_struct, instead of dereferencing
>> `this` which sits on the receiver's stack.
>>
>> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
>=20
> Right, historically we've always ensured that the waker does the state re=
ady
> write as the last operation, with or without lockless wake_qs. And this c=
ommit
> broke this:
>=20
> @@ -923,16 +988,11 @@ static inline void __pipelined_op(struct wake_q_hea=
d *wake_q,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ext_wait_queue *=
this)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&this->list);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_q_add(wake_q, this->task);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Rely on the implicit cmpxch=
g barrier from wake_q_add such
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that we can ensure that upd=
ating receiver->state is the last
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * write operation: As once se=
t, the receiver can continue,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and if we don't have the re=
ference count from the wake_q,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * yet, at that point we can l=
ater have a use-after-free
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * condition and bogus wakeup.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this->state =3D STATE_READY;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_task_struct(this->task);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* see MQ_BARRIER for purpose/pairi=
ng */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_store_release(&this->state, STA=
TE_READY);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_q_add_safe(wake_q, this->task)=
;
> =C2=A0}
>=20
> .. so while addressing the race against get_task_struct() vs wakee exit w=
e ended
> up breaking the case where the task returns before the task is added to t=
he wake_q
> (which actually we explicitly re-orded :). So at this point we know that =
the
> ->state =3D STATE_READY must be done after the whole of the wake_q additi=
on operation.
>=20

The race here really is about the lifetime of __pipelined_op's `this` argum=
ent only
being guaranteed for some duration of the call (ie, until someone sets
->state =3D STATE_READY). It is not about when wake_q addition happens, as =
long as it is
being fed a valid task_struct.

Commit c5b2cbdbdac5 (ipc/mqueue.c: update/document memory barriers) aims at=
 the right
spot wrt. reordering, except for relying on the `this` arg to find a task_s=
truct for
wake_q addition.

> Instead, how about the following which closes the race altogether and sim=
plifies the
> code. This basically goes back to a correct version of fa6004ad4528
> (ipc/mqueue: Implement lockless pipelined wakeups). And by correct I mean=
 keeping the
> smp_store_release() which ensures the proper wakeup semantics.
>=20

I considered that initially, but given that the race isn't connected with w=
akeup, I
preferred the current approach which makes this fact explicit by showing wh=
at's
valid/invalid during __pipelined_op.

Thanks,
Varad

> Thanks,
> Davidlohr
>=20
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 8031464ed4ae..43f0ae61c40b 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -76,14 +76,15 @@ struct posix_msg_tree_node {
> =C2=A0 *=C2=A0=C2=A0 acquiring info->lock.
> =C2=A0 *
> =C2=A0 * MQ_BARRIER:
> - * To achieve proper release/acquire memory barrier pairing, the state i=
s set to
> - * STATE_READY with smp_store_release(), and it is read with READ_ONCE f=
ollowed
> - * by smp_acquire__after_ctrl_dep(). In addition, wake_q_add_safe() is u=
sed.
> + * To achieve proper release/acquire memory barrier pairing, the state i=
s
> + * set to STATE_READY with smp_store_release() such that it is the last =
write
> + * operation, in which afterwards the blocked task can immediately retur=
n and
> + * exit. It is read with READ_ONCE followed by smp_acquire__after_ctrl_d=
ep().
> =C2=A0 *
> =C2=A0 * This prevents the following races:
> =C2=A0 *
> - * 1) With the simple wake_q_add(), the task could be gone already befor=
e
> - *=C2=A0=C2=A0=C2=A0 the increase of the reference happens
> + * 1) With the wake_q_add(), the task could be gone already before
> + *=C2=A0=C2=A0=C2=A0 the increase of the reference happens:
> =C2=A0 * Thread A
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thread B
> =C2=A0 * WRITE_ONCE(wait.state, STATE_NONE);
> @@ -97,10 +98,27 @@ struct posix_msg_tree_node {
> =C2=A0 * sys_exit()
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_task_struct() // UaF
> =C2=A0 *
> - * Solution: Use wake_q_add_safe() and perform the get_task_struct() bef=
ore
> + *
> + * 2) With the wake_q_add(), the waiter task could have returned from th=
e
> + *=C2=A0=C2=A0=C2=A0 syscall and overwritten it's task-allocated waiter =
before the sender
> + *=C2=A0=C2=A0=C2=A0 can be added to the wake_q:
> + * Thread A
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Thread B
> + * WRITE_ONCE(wait.state, STATE_NONE);
> + * schedule_hrtimeout()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->state =3D STATE_READY
> + * <timeout returns>
> + * if (wait.state =3D=3D STATE_READY) return;
> + * sysret to user space
> + * overwrite receiver's stack
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 wake_q_add(A)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (cmpxchg()) // corrupted waiter
> + *
> + * Solution: Use wake_q_add() and queue the task for wakeup before
> =C2=A0 * the smp_store_release() that does ->state =3D STATE_READY.
> =C2=A0 *
> - * 2) Without proper _release/_acquire barriers, the woken up task
> + *
> + * 3) Without proper _release/_acquire barriers, the woken up task
> =C2=A0 *=C2=A0=C2=A0=C2=A0 could read stale data
> =C2=A0 *
> =C2=A0 * Thread A
> @@ -116,7 +134,7 @@ struct posix_msg_tree_node {
> =C2=A0 *
> =C2=A0 * Solution: use _release and _acquire barriers.
> =C2=A0 *
> - * 3) There is intentionally no barrier when setting current->state
> + * 4) There is intentionally no barrier when setting current->state
> =C2=A0 *=C2=A0=C2=A0=C2=A0 to TASK_INTERRUPTIBLE: spin_unlock(&info->lock=
) provides the
> =C2=A0 *=C2=A0=C2=A0=C2=A0 release memory barrier, and the wakeup is trig=
gered when holding
> =C2=A0 *=C2=A0=C2=A0=C2=A0 info->lock, i.e. spin_lock(&info->lock) provid=
ed a pairing
> @@ -1005,11 +1023,9 @@ static inline void __pipelined_op(struct wake_q_he=
ad *wake_q,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ext_wait_queue *this)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 list_del(&this->list);
> -=C2=A0=C2=A0=C2=A0 get_task_struct(this->task);
> -
> +=C2=A0=C2=A0=C2=A0 wake_q_add(wake_q, this->task);
> =C2=A0=C2=A0=C2=A0=C2=A0 /* see MQ_BARRIER for purpose/pairing */
> =C2=A0=C2=A0=C2=A0=C2=A0 smp_store_release(&this->state, STATE_READY);
> -=C2=A0=C2=A0=C2=A0 wake_q_add_safe(wake_q, this->task);
> =C2=A0}
>=20
> =C2=A0/* pipelined_send() - send a message directly to the task waiting i=
n
>=20

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany

HRB 36809, AG N=C3=BCrnberg
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

