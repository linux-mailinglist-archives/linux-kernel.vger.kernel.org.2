Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAB36B58C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhDZPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:17:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:51903
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233674AbhDZPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:16:58 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AAneOy6MUUrqHIsBcTj6jsMiAIKoaSvp033AA?=
 =?us-ascii?q?3SlKKSB9WMqeisyogbAnxQb54Qx9ZFgMkc2NUZPvfVry7phwiLN7AZ6DW03ctH?=
 =?us-ascii?q?KsPMVe6+LZogHIPyHl7OZS2eNBfsFFYuHYKVh/gYLE7BKjE9AmqePqzImSie3T?=
 =?us-ascii?q?z2hgQGhRAsldxjx0BQqBHkp9SBMuP+taKLOn+sFFqzC8EE55Uu2HABA+Lov+ju?=
 =?us-ascii?q?yOsJrnZBIcbiRXjTWzsQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,252,1613430000"; 
   d="txt'?scan'208";a="379717776"
Received: from lfbn-idf1-1-708-183.w86-245.abo.wanadoo.fr (HELO mp-66156.home) ([86.245.159.183])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 17:16:15 +0200
From:   maranget <luc.maranget@inria.fr>
Message-Id: <8846FB06-D0CD-4880-93A5-E6D959AF23C1@inria.fr>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_4129437D-23E6-49C9-9DA9-818553C0A52F"
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Documentation/memory-barriers.txt: Is "stores are not speculated"
 correct?
Date:   Mon, 26 Apr 2021 17:16:15 +0200
In-Reply-To: <a1c077a9-cae3-724e-a2e5-832cf5a86708@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        szyhb810501.student@sina.com, stern <stern@rowland.harvard.edu>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        peterz <peterz@infradead.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
References: <20210426022309.2333D4640475@webmail.sinamail.sina.com.cn>
 <20210426035043.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426093000.GA2583903@yquem.paris.inria.fr>
 <a1c077a9-cae3-724e-a2e5-832cf5a86708@infradead.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_4129437D-23E6-49C9-9DA9-818553C0A52F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 26 Apr 2021, at 17:13, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> On 4/26/21 2:30 AM, Luc Maranget wrote:
>>> On Mon, Apr 26, 2021 at 10:23:09AM +0800, =
szyhb810501.student@sina.com wrote:
>>>>=20
>>>> Hello everyone, I have a =
question."Documentation/memory-barriers.txt"
>>>> says:However, stores are not speculated.  This means that ordering =
-is-
>>>> providedfor load-store control dependencies, as in the following =
example:
>>> 	q =3D READ_ONCE(a);
>>> 	if (q) {
>>> 		WRITE_ONCE(b, 1);
>>> 	}
>>>> Is "stores are not speculated" correct? I
>>>> think store instructions can be executed speculatively.
>>>> =
"https://stackoverflow.com/questions/64141366/can-a-speculatively-executed=
-cpu-branch-contain-opcodes-that-access-ram"
>>>> says:Store instructions can also be executed speculatively thanks =
to the
>>>> store buffer. The actual execution of a store just writes the =
address and
>>>> data into the store buffer.Commit to L1d cache happens some time =
after
>>>> the store instruction retires from the ROB, i.e. when the store is =
known
>>>> to be non-speculative, the associated store-buffer entry =
"graduates"
>>>> and becomes eligible to commit to cache and become globally =
visible.
>>>=20
>>>> =46rom the viewpoint of other CPUs, the store hasn't really =
happened
>>> until it finds its way into a cacheline.  As you yourself note =
above,
>>> if the store is still in the store buffer, it might be squashed when
>>> speculation fails.
>>>=20
>>> So Documentation/memory-barriers.txt and that stackoverflow entry =
are
>>> not really in conflict, but are instead using words a bit =
differently
>>> from each other.  The stackoverflow entry is considering a store to =
have
>>> in some sense happened during a time when it might later be =
squashed.
>>> In contrast, the Documentation/memory-barriers.txt document only =
considers
>>> a store to have completed once it is visible outside of the CPU =
executing
>>> that store.
>>>=20
>>> So from a stackoverflow viewpoint, stores can be speculated, but =
until
>>> they are finalized, they must be hidden from other CPUs.
>>>=20
>>>> =46rom a Documentation/memory-barriers.txt viewpoint, stores don't =
complete
>>> until they update their cachelines, and stores may not be =
speculated.
>>> Some of the actions that lead up to the completion of a store may be
>>> speculated, but not the completion of the store itself.
>>>=20
>>> Different words, but same effect.  Welcome to our world!  ;-)
>>>=20
>>> 							Thanx, Paul
>>=20
>> Hi all,
>>=20
>> Here is a complement to Paul's excellent answer.
>>=20
>> The "CPU-local" speculation of stores can be observed
>> by the following test (in C11)
>>=20
>> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
>>=20
>> C PPOCA
>>=20
>> {}
>>=20
>> P0(volatile int* y, volatile int* x) {
>>=20
>>  atomic_store(x,1);
>>  atomic_store(y,1);
>>=20
>> }
>>=20
>> P1(volatile int* z, volatile int* y, volatile int* x) {
>>=20
>>  int r1=3D-1; int r2=3D-1;
>>  int r0 =3D atomic_load_explicit(y,memory_order_relaxed);
>>  if (r0) {
>>    atomic_store_explicit(z,1,memory_order_relaxed);
>>    r1 =3D atomic_load_explicit(z,memory_order_relaxed);
>>    r2 =3D atomic_load_explicit(x+(r1 & 128),memory_order_relaxed);
>>  }
>>=20
>> }
>>=20
>>=20
>> This is a variation on the MP test.
>>=20
>> Because of tht conditionnal "if (..) { S }" Statements "S" can be =
executed
>> speculatively.
>>=20
>> More precisely, the store statement writes value 1 into the CPU local
>> structure for variable z. The next load statement reads the value,
>> and the last load statement can be peformed (speculatively)
>> as its address is known.
>>=20
>> The resulting outcomme is observed for instance on a RaspBerry Pi3,
>> see attached file.
>=20
> ?attached file?
>=20
> --=20
> ~Randy
>=20

Oups, sorry I forgot the attachement:

=E2=80=94Luc

--Apple-Mail=_4129437D-23E6-49C9-9DA9-818553C0A52F
Content-Disposition: attachment;
	filename=LOG.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="LOG.txt"
Content-Transfer-Encoding: 7bit

Mon Apr 26 09:07:19 UTC 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results for PPOCA.litmus %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C PPOCA

{}

P0(volatile int* y, volatile int* x) {

  atomic_store(x,1);
  atomic_store(y,1);

}

P1(volatile int* z, volatile int* y, volatile int* x) {

  int r1=-1; int r2=-1;
  int r0 = atomic_load_explicit(y,memory_order_relaxed);
  if (r0) {
    atomic_store_explicit(z,1,memory_order_relaxed);
    r1 = atomic_load_explicit(z,memory_order_relaxed);
    r2 = atomic_load_explicit(x+(r1 & 128),memory_order_relaxed);
  }

}


exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)

Histogram (3 states)
11057696:>1:r0=0; 1:r1=-1; 1:r2=-1;
2     *>1:r0=1; 1:r1=1; 1:r2=0;
8942302:>1:r0=1; 1:r1=1; 1:r2=1;
Ok

Witnesses
Positive: 2, Negative: 19999998
Condition exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0) is validated
Hash=bb2426936c19f1555410d1483dd31452
Observation PPOCA Sometimes 2 19999998
Time PPOCA 3.30
Revision 45690d9d0f7a956a6d3dbaf9e912efb22835756e, version 7.56+02~dev
Command line: litmus7 -mach vougeot -c11 true -o R.tar PPOCA.litmus
Parameters
#define SIZE_OF_TEST 10000
#define NUMBER_OF_RUN 100
#define AVAIL 4
#define STRIDE 1
#define MAX_LOOP 0
/* gcc options: -Wall -std=gnu11 -O2 -pthread */
/* barrier: userfence */
/* launch: changing */
/* affinity: none */
/* alloc: dynamic */
/* memory: direct */
/* stride: 1 */
/* safer: write */
/* preload: random */
/* speedcheck: no */
/* proc used: 4 */
GCC=gcc
LITMUSOPTS=-s 5k -r 2k -st 1
Mon Apr 26 09:07:23 UTC 2021

--Apple-Mail=_4129437D-23E6-49C9-9DA9-818553C0A52F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_4129437D-23E6-49C9-9DA9-818553C0A52F--
