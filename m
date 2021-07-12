Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406903C7034
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhGMMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:18:47 -0400
Received: from pv50p00im-ztdg10021901.me.com ([17.58.6.55]:34354 "EHLO
        pv50p00im-ztdg10021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235968AbhGMMSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1626178556; bh=vdFtZajA4O+YDN8L9a698v557aFPRwz9gmpayQOVWFM=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=tieL+BVbXLZVxmiI/rYU1GELky7DtDRyoNTwdfqCdmXOvmnDLTboL9o9qNRwH40L7
         1pLDAzG5QcpBDuQEHTewR7GsI5GBwR9Zh/0AeYDKTSwMhckqY0t1r2XDYHiYzOK5n8
         9iT2WTOHG4TvMzCZl++vjKSZldKqp1l753ktEgDHD81Lf1AkBXD30zoC9ROuNF5ncw
         WqpmyPhWBzVrgV4yx7241vBuoL7ApTYb2bImKDXXaMaQOEW6MDLKUjB/3QjzHUdCd2
         LufYmnrT+hPdnSiOBIpqWvrWt7+Wepp4MQDZAqGn4ZLz7L8Q6QZDZTfGO21pFRzSX3
         /Zcgc1pQSjIwA==
Received: from 192.168.1.5 (unknown [120.245.2.75])
        by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 32427880568;
        Tue, 13 Jul 2021 12:15:53 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of
 check_wait_context()
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <1c4c058b-3745-5586-4961-79d83fb5b049@redhat.com>
Date:   Mon, 12 Jul 2021 23:03:10 +0800
Cc:     Xiongwei Song <sxwjean@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0272AA9-17F9-405C-A046-7AD62918747F@me.com>
References: <20210711141430.896595-1-sxwjean@me.com>
 <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
 <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com>
 <1c4c058b-3745-5586-4961-79d83fb5b049@redhat.com>
To:     Waiman Long <llong@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_05:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107130079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Regards,
Xiongwei




> On Jul 12, 2021, at 9:04 PM, Waiman Long <llong@redhat.com> wrote:
>=20
> On 7/12/21 4:18 AM, Xiongwei Song wrote:
>> On Mon, Jul 12, 2021 at 12:43 AM Waiman Long <llong@redhat.com> =
wrote:
>>> On 7/11/21 10:14 AM, Xiongwei Song wrote:
>>>> From: Xiongwei Song <sxwjean@gmail.com>
>>>>=20
>>>> We now always get a "Invalid wait context" warning with
>>>> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, see the full warning below:
>>>>=20
>>>>       [    0.705900] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>       [    0.706002] [ BUG: Invalid wait context ]
>>>>       [    0.706180] 5.13.0+ #4 Not tainted
>>>>       [    0.706349] -----------------------------
>>> I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is =
experimental
>>> and it is turned off by default. Turning it on can cause problem as
>>> shown in your lockdep splat. Limiting it to just PREEMPT_RT will =
defeat
>>> its purpose to find potential spinlock nesting problem in =
non-PREEMPT_RT
>>> kernel.
>> As far as I know, a spinlock can nest another spinlock. In
>> non-PREEMPT_RT kernel
>> spin_lock and raw_spin_lock are same , so here acquiring a spin_lock =
in hardirq
>> context is acceptable, the warning is not needed. My knowledge on =
this
>> is not enough,
>> Will dig into this.
>>=20
>>> The point is to fix the issue found,
>> Agree. I thought there was a spinlock usage issue, but by checking
>> deactivate_slab context,
>> looks like the spinlock usage is well. Maybe I'm missing something?
>=20
> Yes, spinlock and raw spinlock are the same in non-RT kernel. They are =
only different in RT kernel. However, non-RT kernel is also more heavily =
tested than the RT kernel counterpart. The purpose of this config option =
is to expose spinlock nesting problem in more areas of the code. If you =
look at the config help text of PROVE_RAW_LOCK_NESTING:
>=20
>         help
>          Enable the raw_spinlock vs. spinlock nesting checks which =
ensure
>          that the lock nesting rules for PREEMPT_RT enabled kernels =
are
>          not violated.
>=20
>          NOTE: There are known nesting problems. So if you enable this
>          option expect lockdep splats until these problems have been =
fully
>          addressed which is work in progress. This config switch =
allows to
>          identify and analyze these problems. It will be removed and =
the
>          check permanentely enabled once the main issues have been =
fixed.
>=20
>          If unsure, select N.
>=20
> So lockdep splat is expected. It will take time to address all the =
issues found.
Thanks, :-).

Regards,
Xiongwei

>=20
> Cheers,
> Longman
>=20

