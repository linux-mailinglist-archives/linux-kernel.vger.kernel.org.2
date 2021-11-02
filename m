Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19444330D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhKBQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:19:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52542 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhKBQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:05:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D71E41FD4C;
        Tue,  2 Nov 2021 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635868949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JlVo+e56fzGXmTMRyE6MjSjxKScNH08XBgyqebErkQ=;
        b=qoiUc1EUltN0LAyDnx4uqbquAI2p0wQbZn+b5o4iK0BgKara5k6edJWwK/VtYG7XhbbkPG
        Dv2xTeyypnE3UvqHsTDRnEO2KOZtH40uK24USJFDkTUnqrBOl7N94rAdNYkkLhM3UKyb6K
        +NazNazYw+3Z+XSP8Bs2yzxfLZ4IVQs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABD2813DC7;
        Tue,  2 Nov 2021 16:02:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JNXlKBVhgWFnXgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 Nov 2021 16:02:29 +0000
Date:   Tue, 2 Nov 2021 17:02:28 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: task_group unthrottling and removal race (was Re: [PATCH]
 sched/fair: Use rq->lock when checking cfs_rq list) presence
Message-ID: <20211102160228.GA57072@blackbody.suse.cz>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
 <20211013142643.GA48428@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013142643.GA48428@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello.

(Getting back to this after some more analysis.)

On Wed, Oct 13, 2021 at 04:26:43PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> On Wed, Oct 13, 2021 at 09:57:17AM +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > This seems to closes the race window in your case but this could still
> > happen AFAICT.
> 
> You seem to be right.
> Hopefully, I'll be able to collect more data evaluating this.

I've observed that the window between unregister_fair_sched_group() and
free_fair_sched_group() is commonly around 15 ms (based on kprobe
tracing).

I have a reproducer (attached) that can hit this window quite easily
after tuning.  I can observe consequences of it even with a recent 5.15
kernel. (And I also have reports from real world workloads failing due
to a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on
unthrottle").)

My original patch was really an uninformed attempt given the length of
the window.

[snip]

On Wed, Oct 13, 2021 at 07:45:59PM +0100, Odin Ugedal <odin@uged.al> wrote:
> Ref. your comment about reverting a7b359fc6a37
> ("sched/fair: Correctly insert cfs_rq's to list on unthrottle"), I
> think that is fine as long as we revert the commit it fixes as well,
> to avoid a regression of that (but yeah, that regression itself is
> less bad than your discovery).

I say no to reverting 31bc6aeaab1d ("sched/fair: Optimize
update_blocked_averages()") (it solves reported performance issues, it's
way too old :-).

> set cfs_rq->on_list=2 inside that lock under your code change? If we
> then treat on_list=2
> as "not on list, and do not add"?

The possibilities for the current problem:

1) Revert a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle") and its fixups.
(Not exclusive with the other suggestions, rather a stop-gap for the
time being.)

2) Don't add offlined task_groups into the undecayed list
- Your proposal with overloaded on_list=2 could serve as mark of that,
  but it's a hack IMO.
- Proper way (tm) would be to use css_tryget_online() and css_put() when
  dealing with the list (my favorite at the moment).

3) Narrowing the race-window dramatically
- that is by moving list removal from unregister_fair_sched_group() to
  free_fair_sched_group(),
- <del>or use list_empty(tg->list) as indicator whether we're working
  with onlined task_group.</del> (won't work for RCU list)

4) Rework how throttled load is handled (hand waving)
- There is remove_entity_load_avg() that moves the load to parent upon
  final removal. Maybe it could be generalized for temporary removals by
  throttling (so that unthrottling could again add only non-empty
  cfs_rqs to the list and undecayed load won't skew fairness).
- or the way of [1].

5) <your ideas>

Opinions?

Thanks,
Michal

[1] https://lore.kernel.org/lkml/CAFpoUr1AO_qStNOYrFWGnFfc=uSFrXSYD8A5cQ8h0t2pioQzDA@mail.gmail.com/

--WIyZ46R2i8wDzkSu
Content-Type: application/x-sh
Content-Disposition: attachment; filename="run2.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0ACGROOT=3D/sys/fs/cgroup/cpu=0ACGTARGET=3D$CGROOT/queen/pri=
nce=0ACGSTRESS=3D$CGROOT/stress=0A=0Afunction worker() {=0A	echo $BASHPID >=
$CGTARGET/cont-$it/cgroup.procs=0A	exec stress-ng -c1 -l 100 =0A}=0A=0AVAL2=
72=3D"0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef01234=
56789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef=
0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789a=
bcdef0123456789abcdef0123456789abcdef0123456789abcdef"=0A=0Afunction slab_s=
tress() {=0A	local dummy=3D/sys/devices/system/cpu/online=0A	echo "Starting=
 slab_stress"=0A	# the crafted value length causes fitting into kmalloc-512=
=0A	while true ; do=0A		for i in $(seq 100) ; do setfattr -n trusted.foo$i =
-v "$VAL272" $dummy ; done=0A		for i in $(seq 100) ; do setfattr -x trusted=
=2Efoo$i $dummy ; done=0A	done=0A}=0A=0Amkdir -p $CGTARGET=0A=0Aslab_stress=
 &=0Apid_ss=3D$!=0A=0Aecho "Starting run2.sh" >/dev/kmsg=0A=0Ait=3D0=0Awhil=
e true ; do=0A	it=3D$(($it + 1))=0A	mkdir $CGTARGET/cont-$it=0A	# sub-HZ qu=
ota so that throttling can happen after exit=0A	echo 2500 >$CGTARGET/cont-$=
it/cpu.cfs_quota_us=0A=0A	worker &=0A	pid_w=3D$!=0A=0A	# grow the load in t=
ransient cgroup=0A	# randomize runtime to avoid aliasing=0A	sleep 1.$(($RAN=
DOM % 100))=0A	# kill "synchronously"=0A	kill $pid_w=0A	wait $pid_w=0A	# th=
e magic happens HERE, needs machine specific adjustments=0A	sleep 0.07$((40=
 + $RANDOM % 50))=0A	rmdir $CGTARGET/cont-$it =0A=0A	# now, we've removed t=
he cgroup and it was likely unthrottled too=0A	# then wait for someone to s=
tep on it=0A	# better stress kmalloc-512 so that data are quickly overwritt=
en=0A	# let the CPU idle to do some rebalancing=0A	sleep 0.5=0A	echo $it=0A=
done=0A=0A
--WIyZ46R2i8wDzkSu--
