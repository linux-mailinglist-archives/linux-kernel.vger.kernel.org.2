Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE53D3A9E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhFPPBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:01:30 -0400
Received: from pv50p00im-ztdg10011901.me.com ([17.58.6.50]:33803 "EHLO
        pv50p00im-ztdg10011901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233764AbhFPPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623855562; bh=Fxv7Bj1AajXtkyEFDdpK+ukwiNrawcGJx7omFg1wVWs=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=084Yt9clt51OQdxNr30J6x4ufiwYwweF2vcXYjhk0F0/jvqmmq1/VeGtYbZWiPpJO
         QJl4mRoVDBlQyJ0+PVSmkWJfXLRbaEEl1MQZogijQiNVnsB+Gb4bo7BcyyzTO6vzF8
         Y8rfLGRhiGC8opnPHh4GNKRusB9+nDuCG6xaiGSmoawmCpoBOuIANrpVkR/fx5D0kr
         3bEJvKGntxFanxlsBvguKAxTiflSrF24+hfb+A+fiRWzWQZfBTXByA/PUGHNRIN8SF
         C7S0101RRGBd/sKN8d6HQ1erqN8AzoDF2VQ0LW1gq8aZQEq3l1rK4Uijv8gMni37U3
         Kugtmc1CwXVQQ==
Received: from 192.168.1.5 (unknown [120.245.2.120])
        by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 4C86C8002A3;
        Wed, 16 Jun 2021 14:59:19 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] locking/lockdep: unlikely bfs error check
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <a341e1f1-39a5-dca3-9454-8eabe085928b@redhat.com>
Date:   Wed, 16 Jun 2021 22:59:16 +0800
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF7CB29B-0B34-4462-B793-732C1EF9DC40@me.com>
References: <20210616144210.278662-1-sxwjean@me.com>
 <a341e1f1-39a5-dca3-9454-8eabe085928b@redhat.com>
To:     Waiman Long <llong@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-16_08:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106160087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2021, at 10:48 PM, Waiman Long <llong@redhat.com> wrote:
>=20
> On 6/16/21 10:42 AM, Xiongwei Song wrote:
>> From: Xiongwei Song <sxwjean@gmail.com>
>>=20
>> The error from graph walk is small probability event, so unlikely
>> bfs_error can improve performance a little bit.
>>=20
>> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
>> ---
>>  kernel/locking/lockdep.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 074fd6418c20..af8c9203cd3e 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -2646,7 +2646,7 @@ static int check_irq_usage(struct task_struct =
*curr, struct held_lock *prev,
>>  	bfs_init_rootb(&this, prev);
>>    	ret =3D __bfs_backwards(&this, &usage_mask, usage_accumulate, =
usage_skip, NULL);
>> -	if (bfs_error(ret)) {
>> +	if (unlikely(bfs_error(ret))) {
>>  		print_bfs_bug(ret);
>>  		return 0;
>>  	}
>> @@ -2664,7 +2664,7 @@ static int check_irq_usage(struct task_struct =
*curr, struct held_lock *prev,
>>  	bfs_init_root(&that, next);
>>    	ret =3D find_usage_forwards(&that, forward_mask, =
&target_entry1);
>> -	if (bfs_error(ret)) {
>> +	if (unlikely(bfs_error(ret))) {
>>  		print_bfs_bug(ret);
>>  		return 0;
>>  	}
>> @@ -2679,7 +2679,7 @@ static int check_irq_usage(struct task_struct =
*curr, struct held_lock *prev,
>>  	backward_mask =3D =
original_mask(target_entry1->class->usage_mask);
>>    	ret =3D find_usage_backwards(&this, backward_mask, =
&target_entry);
>> -	if (bfs_error(ret)) {
>> +	if (unlikely(bfs_error(ret))) {
>>  		print_bfs_bug(ret);
>>  		return 0;
>>  	}
>> @@ -2998,7 +2998,7 @@ check_prev_add(struct task_struct *curr, struct =
held_lock *prev,
>>  	 * Is the <prev> -> <next> link redundant?
>>  	 */
>>  	ret =3D check_redundant(prev, next);
>> -	if (bfs_error(ret))
>> +	if (unlikely(bfs_error(ret)))
>>  		return 0;
>>  	else if (ret =3D=3D BFS_RMATCH)
>>  		return 2;
>> @@ -3911,7 +3911,7 @@ check_usage_forwards(struct task_struct *curr, =
struct held_lock *this,
>>    	bfs_init_root(&root, this);
>>  	ret =3D find_usage_forwards(&root, usage_mask, &target_entry);
>> -	if (bfs_error(ret)) {
>> +	if (unlikely(bfs_error(ret))) {
>>  		print_bfs_bug(ret);
>>  		return 0;
>>  	}
>> @@ -3946,7 +3946,7 @@ check_usage_backwards(struct task_struct *curr, =
struct held_lock *this,
>>    	bfs_init_rootb(&root, this);
>>  	ret =3D find_usage_backwards(&root, usage_mask, &target_entry);
>> -	if (bfs_error(ret)) {
>> +	if (unlikely(bfs_error(ret))) {
>>  		print_bfs_bug(ret);
>>  		return 0;
>>  	}
>=20
> I think it is better to put the unlikely() directly into the =
bfs_error() inline function instead of sprinkling it all over the place.

Sounds good. Thank you for the suggestion. I will update the patch.

Regards,
Xiongwei

>=20
> Cheers,
> Longman
>=20

