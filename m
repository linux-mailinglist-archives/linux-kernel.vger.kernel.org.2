Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E945A0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhKWLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:09:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:60757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233462AbhKWLJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637665580;
        bh=iHMBuiS6NA57Im1nsN6hxnDvT25qjhF1O/kXlthv3+0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kB6KEt1tfgYibUyjL/EKUiAD4W/qZfamF2ghaauLBiDS6YyJ/5qJqJvFsD8+N+VAb
         5rzYiXVnWA3rIjvhK2l/AvVjM+e+hHlaAICVgYXD5YZGY5XhlDoGe4gn2/q4KqKqxk
         j1aDPhGZmfh5RI99cMmLrkAzDzQ0SWvu0WijOOIQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1mJUvH3pjQ-00njgI; Tue, 23
 Nov 2021 12:06:19 +0100
Message-ID: <56b8e72693d5a0247beb95482bdfacf1a158a859.camel@gmx.de>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 12:06:19 +0100
In-Reply-To: <20211123091304.GC3366@techsingularity.net>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
         <20211123091304.GC3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UW7zPsWz7laCjBdOEtep7m0xMCMksrn46s/yL7I7FzkfYJipKFC
 AWvXNBgP6Py5QDKRkPvy3H4ysFz4WmlVtJuvTrbdvNAbE30sulz0N799duw8uET3Ll1CzOK
 lXX6zKyZPJARNXsLYQGqkDHqrxh8fqga2APdh1ogPD5moDv60rQd09FZHmhaP8F+7U0yc2U
 ELpaKLJjAEUZbS0vALv3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:erfRfKJAyy8=:Te38DExQX1W2/T2FkS594n
 o9aV6WDu65qX+hOOIpnr+k5qNeQV9caxIIxEkM18fTa8kxg7e6vmzCTZKhws1hN4XP16LebT6
 AuQimSIqNOL7QK4nPyw71Usa7uc6lovGxBscrluU2XBOSY/YYNNzrkcAIsl64Kc+jhXYQQdGG
 ZR42xl5+9mUxN0MsqkzejdeHDZgKlC3c4FSOXboHGqBJzDw9hJFoxcU8zhl5s75xO/mqd74sf
 CpKaR29S0gpMUMYDuJbQpww75z4T2HZfRc+5HupMQJQo4+/9mUP/h41rYZV1fGK9N6+Ow2n4L
 FmMW4E0Rz7I7KsK7XG1vKmrRNv8vnkuFwVWWvoFPPj+0jl9C0/BJ1p7P0pbx85KtZTIbWfY4I
 PLJvwC7hJfSPSaIATl/SrOZiAY1QK7aMqdeeGxyYxEI+AhZMCmswQQdJMBGThEoPCyDBcYDtn
 iinm0CzXQFh4f8F9JQNdvA2Gbq2R5UYYe+veA2bIMnrLuA1n1NS335zkBJSLVuLvOkAbPCyTA
 WDy5wcbjjRR5opdJUpm4kgagJ2Uf2KAQRUnKCaKEKf/IFI+9vpRD0PICBHQfmswaeqaTmQ1KS
 5igMHC9B7SLTtns4hyC5UhVbvmSpGvOsrSiAb23pcCzZ7B1aEO5fvDnvxPTkv9xgcCQB+woxF
 Z4a7w56e7UK5jeds1Y1wHwfzI86zQt+70rYdS/FPRNhNG94BhHDVlKaG3N4UDU+xNALzqyxfu
 FP7Icn8oScvja0c83lJ6JkOyOo628nUF0jGYclM4ULmVtzmaCXgBSYv3vwjB7FMcP2766XLEW
 z5bbTe7YIo5KbS4WVwUzCxvK72yWo6XSYFo+OEiaQjwitukt4q9+0rTrJpNwO48QmJAT8Zxvw
 vBK33KLybs68qYRfbNtP4S2I6S2jvn//jR1ZdlvqMFsZuhPXhapoI3INohVPpxKxdKd3Aa7Hi
 BpDThrcbyPmkmbkSPE/SBY0DAKt/qO+D8QwBZTb20VMgScJbNx5SmO8xHg3ye4RGDEZldQNgE
 HvAIEUdopZTTFqNUFQdrnAslj31wc1tJQxfGcGBMmnqXc+Ot2rnrG2dM/RXQ2CktClqzntoNa
 Nc7vAJ/8gNdt3o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 09:13 +0000, Mel Gorman wrote:
> On Sun, Nov 21, 2021 at 11:57:20AM +0100, Mike Galbraith wrote:
> > Greetings,
> >
> > FYI, something in this series causes LTP controllers::memcg_regression
> > testcase to hang forever.=C2=A0 Verified via brute force revert of the=
 lot.
> >
> > After letting box moan for 4.5 hours, I poked ^C repeatedly, but runlt=
p
> > didn't exit/recover gracefully, and ps hung, so I nuked the box.=C2=A0=
 All
> > memcg_test_1 instances were stuck in reclaim_throttle().
> >
>
> I'll see can I reproduce this but do you know offhand what the test is
> doing and what the expected outcome is? A possibility is that this is a
> test that is driving the machine near OOM (or at least memcg OOM) and
> getting throttled instead of getting killed.

Here's the hanging test 4.

testcases/bin/memcg_regression_test.sh:
test_4()
{
        ./memcg_test_4.sh

        check_kernel_bug
        if [ $? -eq 1 ]; then
                tst_resm TPASS "no kernel bug was found"
        fi

        # test_4.sh might be killed by oom, so do clean up here
        killall -9 memcg_test_4 2> /dev/null
        killall -9 memcg_test_4.sh 2> /dev/null

        # if test_4.sh gets killed, it won't clean cgroup it created
        rmdir memcg/0 2> /dev/null

        swapon -a
}

testcases/bin/memcg_test_4.sh:
# attach current task to memcg/0/
mkdir memcg/0
echo $$ > memcg/0/tasks

./memcg_test_4 &
pid=3D$!
sleep 1

# let $pid allocate 100M memory
/bin/kill -SIGUSR1 $pid
sleep 1

# shrink memory, and then 80M will be swapped
echo 40M > memcg/0/memory.limit_in_bytes

# turn off swap, and swapoff will be killed
swapoff -a
sleep 1
echo $pid > memcg/tasks 2> /dev/null
echo $$ > memcg/tasks 2> /dev/null

# now remove the cgroup
rmdir memcg/0
