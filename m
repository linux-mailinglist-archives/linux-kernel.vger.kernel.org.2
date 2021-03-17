Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115A233F96B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhCQThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:37:01 -0400
Received: from foss.arm.com ([217.140.110.172]:44762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233236AbhCQTgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:36:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432F5ED1;
        Wed, 17 Mar 2021 12:36:35 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B11C3F70D;
        Wed, 17 Mar 2021 12:36:34 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64\@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
Subject: Re: [PATCH 0/1] sched/topology: NUMA distance deduplication
In-Reply-To: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de>
References: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de>
Date:   Wed, 17 Mar 2021 19:36:27 +0000
Message-ID: <8735wtr2ro.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 17/03/21 20:04, John Paul Adrian Glaubitz wrote:
> Hi Valentin!
>
>> As pointed out by Barry in [1], there are topologies out there that struggle to
>> go through the NUMA distance deduplicating sort. Included patch is something
>> I wrote back when I started untangling this distance > 2 mess.
>>
>> It's only been lightly tested on some array of QEMU-powered topologies I keep
>> around for this sort of things. I *think* this works out fine with the NODE
>> topology level, but I wouldn't be surprised if I (re)introduced an off-by-one
>> error in there.
>
> This patch causes a regression on my ia64 RX2660 server:
>
> [    0.040000] smp: Brought up 1 node, 4 CPUs
> [    0.040000] Total of 4 processors activated (12713.98 BogoMIPS).
> [    0.044000] ERROR: Invalid distance value range
> [    0.044000]
>
> The machine still seems to boot normally besides the huge amount of spam. Full message
> log below.
>
> Any idea?
>

Harumph!

The expected / valid distance value range (as per ACPI spec) is
[10, 255] (actually double-checking the spec, 255 is supposed to mean
"unreachable", but whatever)

Now, something in your system is exposing 256 nodes, all of them distance 0
from one another - the spam you're seeing is a printout of

  node_distance(i,j) for all nodes i, j

I see ACPI in your boot logs, so I'm guessing you have a bogus SLIT table
(the ACPI table with node distances). You should be able to double check
this with something like:

$ acpidump > acpi.dump
$ acpixtract -a acpi.dump
$ iasl -d *.dat
$ cat slit.dsl

As for fixing it, I think you have the following options:

a) Complain to your hardware vendor to have them fix the table and ship a
   firmware fix
b) Fix the ACPI table yourself - I've been told it's doable for *some* of
   them, but I've never done that myself
c) Compile your kernel with CONFIG_NUMA=n, as AFAICT you only actually have
   a single node
d) Ignore the warning


c) is clearly not ideal if you want to use a somewhat generic kernel image
on a wide host of machines; d) is also a bit yucky...
