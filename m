Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A838D45BECA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbhKXMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:50:46 -0500
Received: from shark3.inbox.lv ([194.152.32.83]:34820 "EHLO shark3.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244614AbhKXMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:48:06 -0500
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id CC82A2801B8;
        Wed, 24 Nov 2021 14:44:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1637757894; bh=75sNLLNwls2+KNRVD7vilr0a7Tknh17sk8NaXPKeUEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=kOWqXGMh1MKNJXcnRHIET77W2k9/uNKkGxKk+j+i+lqd23+Ilyvh1Svq262Mh6EZl
         IkM1/a+OmFthbZvyi1QVP9++EScuhEjcv2xv9zYbKbI2VpwHn9N3sjtvvsz2UnQUa2
         M8X6+jYCk3GdRnC8xNB8YXHnZanRvYJce0eyuggg=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id C2C252801B0;
        Wed, 24 Nov 2021 14:44:54 +0200 (EET)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id u3GP-13Psnpc; Wed, 24 Nov 2021 14:44:54 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 076E828018A;
        Wed, 24 Nov 2021 14:44:54 +0200 (EET)
Received: from mail.inbox.lv (unknown [79.105.116.237])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id 0795D3E601A5;
        Wed, 24 Nov 2021 14:44:49 +0200 (EET)
Date:   Wed, 24 Nov 2021 21:44:43 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        vbabka@suse.cz, neilb@suse.de, akpm@linux-foundation.org,
        corbet@lwn.net, riel@surriel.com, hannes@cmpxchg.org,
        david@fromorbit.com, willy@infradead.org, hdanton@sina.com,
        penguin-kernel@i-love.sakura.ne.jp, oleksandr@natalenko.name,
        kernel@xanmod.org, michael@michaellarabel.com, aros@gmx.com,
        hakavlad@gmail.com
Subject: Re: mm: 5.16 regression: reclaim_throttle leads to stall in
 near-OOM conditions
Message-ID: <20211124214443.5c179d34@mail.inbox.lv>
In-Reply-To: <20211124115007.GG3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
        <20211124103550.GE3366@techsingularity.net>
        <20211124195449.33f31e7f@mail.inbox.lv>
        <20211124115007.GG3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: G4mERXADmHlDpsG/LZpu5OT4taW+ND8/31T3z7QsmgxU9uyBr7wBfW6TGofmHgq/cWbD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> can you test this?

> diff --git a/mm/vmscan.c b/mm/vmscan.c

Sorry, I didn't notice the diff you provided right away.

Now I've tested it and the result is the same: 1 min stall:

$ mem2log
Starting mem2log with interval 2s, mode: 1
Process memory locked with MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT
All values are in mebibytes
MemTotal: 11798.5, SwapTotal: 0.0
--
MA is MemAvailable, MF is MemFree, A is Anon
F is File, AF is Active(file), IF is Inactive(file)
D is Dirty, C is Clean file (File - Dirty)
SF is SwapFree, SU is SwapUsed (SwapTotal - SwapFree)
--
MA=10402=88% MF=9405 A=844 F=1209 AF=391 IF=818 D=1 C=1208 SF=0 SU=0
MA=10411=88% MF=9414 A=843 F=1209 AF=391 IF=818 D=1 C=1208 SF=0 SU=0
MA=10405=88% MF=9408 A=845 F=1209 AF=392 IF=817 D=1 C=1208 SF=0 SU=0
MA=10390=88% MF=9393 A=863 F=1209 AF=392 IF=817 D=1 C=1208 SF=0 SU=0
MA=10371=88% MF=9374 A=883 F=1209 AF=392 IF=817 D=1 C=1208 SF=0 SU=0
MA=10360=88% MF=9363 A=884 F=1209 AF=392 IF=817 D=0 C=1209 SF=0 SU=0
MA=10338=88% MF=9341 A=892 F=1209 AF=396 IF=813 D=1 C=1208 SF=0 SU=0
MA=10357=88% MF=9359 A=888 F=1209 AF=396 IF=813 D=0 C=1208 SF=0 SU=0
MA=9998=85% MF=9001 A=1245 F=1209 AF=396 IF=813 D=0 C=1209 SF=0 SU=0
MA=6214=53% MF=5217 A=5031 F=1209 AF=396 IF=813 D=0 C=1209 SF=0 SU=0
MA=2410=20% MF=1412 A=8825 F=1209 AF=396 IF=813 D=0 C=1209 SF=0 SU=0
MA=8=0% MF=144 A=11368 F=2 AF=1 IF=1 D=0 C=2 SF=0 SU=0
MA=0=0% MF=126 A=11387 F=2 AF=0 IF=1 D=0 C=2 SF=0 SU=0
MA=0=0% MF=126 A=11387 F=3 AF=1 IF=2 D=0 C=3 SF=0 SU=0
MA=0=0% MF=122 A=11393 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=120 A=11393 F=2 AF=0 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=121 A=11393 F=3 AF=1 IF=2 D=0 C=3 SF=0 SU=0
MA=0=0% MF=122 A=11395 F=2 AF=0 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=120 A=11395 F=3 AF=1 IF=2 D=0 C=3 SF=0 SU=0
MA=0=0% MF=120 A=11395 F=4 AF=1 IF=2 D=0 C=4 SF=0 SU=0
MA=0=0% MF=120 A=11395 F=4 AF=1 IF=3 D=0 C=4 SF=0 SU=0
MA=0=0% MF=120 A=11396 F=2 AF=0 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=120 A=11396 F=2 AF=0 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=119 A=11396 F=3 AF=1 IF=2 D=0 C=3 SF=0 SU=0
MA=0=0% MF=118 A=11397 F=2 AF=1 IF=1 D=0 C=2 SF=0 SU=0
MA=0=0% MF=122 A=11397 F=3 AF=0 IF=3 D=0 C=3 SF=0 SU=0
MA=0=0% MF=120 A=11397 F=3 AF=0 IF=3 D=0 C=3 SF=0 SU=0
MA=0=0% MF=120 A=11397 F=4 AF=0 IF=4 D=0 C=4 SF=0 SU=0
MA=0=0% MF=119 A=11398 F=3 AF=1 IF=2 D=0 C=3 SF=0 SU=0
MA=0=0% MF=119 A=11400 F=2 AF=1 IF=1 D=0 C=2 SF=0 SU=0
MA=0=0% MF=119 A=11400 F=2 AF=0 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=120 A=11400 F=2 AF=0 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=119 A=11400 F=3 AF=1 IF=2 D=0 C=3 SF=0 SU=0
MA=0=0% MF=118 A=11401 F=2 AF=1 IF=1 D=0 C=2 SF=0 SU=0
MA=0=0% MF=118 A=11401 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11401 F=2 AF=1 IF=2 D=0 C=2 SF=0 SU=0
MA=0=0% MF=118 A=11402 F=2 AF=1 IF=1 D=0 C=2 SF=0 SU=0
MA=0=0% MF=119 A=11402 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=119 A=11402 F=1 AF=1 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11402 F=1 AF=1 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11403 F=1 AF=1 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11403 F=1 AF=1 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=117 A=11404 F=1 AF=1 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=117 A=11404 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=1 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=0 AF=0 IF=0 D=0 C=0 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=0 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=0 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=1 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=0 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=117 A=11404 F=1 AF=1 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=0 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=117 A=11404 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=117 A=11404 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=1 IF=0 D=0 C=1 SF=0 SU=0
MA=0=0% MF=117 A=11404 F=1 AF=0 IF=1 D=0 C=1 SF=0 SU=0
MA=0=0% MF=118 A=11404 F=1 AF=0 IF=0 D=0 C=1 SF=0 SU=0
MA=1007=9% MF=1145 A=10367 F=1 AF=1 IF=1 D=0 C=1 SF=0 SU=0
MA=10478=89% MF=10608 A=904 F=17 AF=2 IF=15 D=0 C=17 SF=0 SU=0


$ psi2log -m2
Starting psi2log, target: SYSTEM_WIDE, mode: 2, interval: 2 sec, log file is not set, suppress output: False
PSI source dir: /proc/pressure/, source files: cpu, io, memory
Process memory locked with MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT
======|=============|=============|
 cpu  |      io     |    memory   |
----- | ----------- | ----------- |
 some |  some  full |  some  full | interval
----- | ----- ----- | ----- ----- | --------
  0.9 |   0.1   0.1 |   0.0   0.0 | 2.002
  1.3 |   0.4   0.3 |   0.0   0.0 | 2.002
  1.0 |   0.0   0.0 |   0.0   0.0 | 2.001
  0.7 |   1.2   1.1 |   0.0   0.0 | 2.0
  0.5 |   2.7   2.6 |   0.0   0.0 | 2.001
  1.0 |   2.1   2.0 |   3.1   3.1 | 2.002
  0.2 |  89.5  84.6 |  53.6  53.2 | 2.001
  0.2 |  85.7  84.0 |  44.4  44.2 | 2.002
  0.2 |  95.9  92.5 |  38.6  38.4 | 2.002
  0.2 |  72.4  70.8 |  89.2  88.7 | 2.002
  0.1 |  89.9  86.9 |  77.4  77.0 | 2.002
  0.2 |  87.5  86.8 |  90.2  89.7 | 2.002
  0.1 |  87.5  87.0 |  69.3  68.9 | 2.002
  0.2 |  92.0  86.6 |  71.0  70.7 | 2.002
  0.1 |  87.5  87.0 |  55.1  54.9 | 2.002
  0.1 |  85.1  84.5 |  48.0  47.8 | 2.002
  0.1 |  87.4  86.8 |  88.2  87.8 | 2.002
  0.2 |  87.5  86.9 |  78.1  77.8 | 2.002
  0.1 |  95.7  86.9 |  92.8  92.3 | 2.002
  0.2 |  88.6  83.9 |  98.9  98.4 | 2.002
  0.2 |  98.8  85.5 |  95.6  94.9 | 2.002
  0.1 | 100.0  86.9 |  93.6  93.2 | 2.001
  0.1 |  95.2  86.9 |  92.4  92.0 | 2.002
  0.2 |  87.5  86.8 |  99.9  99.3 | 2.002
  0.2 |  92.8  86.1 |  94.7  94.1 | 2.002
  0.3 |  93.3  86.6 |  98.0  97.4 | 2.002
  0.2 |  84.6  84.1 | 100.0  99.6 | 2.002
  0.1 |  87.4  86.8 |  94.0  93.6 | 2.002
  0.3 |  87.5  86.7 | 100.0  99.5 | 2.002
  0.5 |  81.3  79.8 |  98.3  97.9 | 2.002
  0.3 |  88.1  85.3 | 100.0  99.5 | 2.002
  0.7 |  84.6  81.1 |  98.9  98.5 | 2.002
  0.4 |  70.7  66.0 |  99.3  98.7 | 2.002
  0.7 |  64.2  63.1 |  99.1  98.7 | 2.002
  0.9 |  48.7  46.8 |  98.8  98.5 | 2.002
  0.8 |  36.3  35.2 |  99.7  99.4 | 2.002
  0.4 |  16.7  15.9 |  99.5  99.2 | 2.002
  0.9 |   2.6   2.5 |  99.7  99.4 | 2.002
  1.4 |   3.2   3.1 |  99.6  99.2 | 2.002
  0.9 |  12.4  12.1 |  99.3  99.0 | 2.002
  1.1 |  27.3  24.7 |  98.9  98.5 | 2.002
  0.3 |   2.6   2.6 | 100.0  99.8 | 2.002
  1.3 |  10.6   7.6 |  99.7  99.4 | 2.002
  0.9 |  18.3  17.5 |  99.2  98.9 | 2.002
  1.1 |  34.3  32.1 |  99.7  99.4 | 2.002
  1.3 |  34.7  31.8 |  99.8  99.5 | 2.002
  0.8 |   0.6   0.6 | 100.0  99.8 | 2.002
  1.5 |   0.0   0.0 | 100.0  99.7 | 2.002
  1.5 |   0.0   0.0 | 100.0  99.6 | 2.002
  1.2 |   0.0   0.0 | 100.0  99.6 | 2.002
  0.7 |   0.5   0.5 |  98.6  98.3 | 2.002
  1.1 |   0.0   0.0 | 100.0  99.7 | 2.002
  1.4 |   1.1   1.1 |  98.1  97.8 | 2.002
  1.2 |   0.0   0.0 | 100.0  99.7 | 2.002
  0.9 |   0.0   0.0 | 100.0  99.7 | 2.001
  1.2 |   0.3   0.3 | 100.0  99.7 | 2.002
  0.7 |   1.0   1.0 | 100.0  99.7 | 2.002
  1.7 |   0.0   0.0 | 100.0  99.6 | 2.002
  1.3 |   2.7   2.5 | 100.0  99.7 | 2.002
  1.4 |   1.4   1.4 |  99.5  99.1 | 2.002
  1.0 |   0.4   0.4 | 100.0  99.8 | 2.002
  1.9 |   0.0   0.0 | 100.0  99.6 | 2.002
  1.1 |   0.0   0.0 | 100.0  99.7 | 2.002
  1.1 |   0.0   0.0 | 100.0  99.7 | 2.002
  0.9 |   0.0   0.0 | 100.0  99.7 | 2.002
  0.9 |   0.3   0.3 |  98.5  98.2 | 2.002
  1.3 |   0.0   0.0 | 100.0  99.6 | 2.002
  0.9 |   0.0   0.0 | 100.0  99.7 | 2.002
  1.0 |   0.0   0.0 | 100.0  99.7 | 2.002
  0.6 |  85.7  83.4 |  74.0  72.5 | 2.002
  0.2 | 100.0  98.8 |   4.3   4.3 | 2.002
  0.2 | 100.0  98.4 |   0.0   0.0 | 2.002
