Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4003FF710
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbhIBWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:22:56 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:31897 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhIBWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:22:56 -0400
IronPort-SDR: PYZ+NIRvI/eplJBuQp7mjtKfvNfEtaML2OMRHWCIdyxtfcNkWG0c6Xr4T2tYF4IUazet29VHFh
 Okl1WFOu6USYmC+Epb/onhnfCQApSTzDs7lctSwd/77YQ1Z6xQPYam/vQRnjFhoavtal+JmpRP
 XoGqBm7oiRo3/BXCRtbMIcmbmL4P9JJh0mKbrOAFJwjPZ5+oe8mxbQzSd27qM8ij58KbMtDN2y
 xJX7ZEq2BbIgjKj7hzBtMbH3Zd40mfwKT06wOr5Fy5QqcYPYGqNPko7XF46KigaHq+Ockak6Zs
 Q59Q0OXxNIpOJuZPatglOY9u
X-IronPort-AV: E=Sophos;i="5.85,263,1624348800"; 
   d="scan'208";a="67936561"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 02 Sep 2021 14:21:57 -0800
IronPort-SDR: yU1HWBHHRAEUHUo59GbicS/kyr5ibWc1Rj04iAsrvqC/JpOnHq8XNbMCtZV8lsooAk+VXuK6rr
 Q85fsL7AgW0M2N9aINRSnEvbFvxW5AjMeU+M+tvo+Kq6pHcGKPnpqIv8U3DapDamaMPGhTFjM9
 4MMnO8nvwG+fhsJ7mPgaUdyKFIytFVqNytr4kw9uqVRsVwXMDGZ7S0zBqWAiORWDwv0pPrjQpF
 vrA9UXPKzhVv7ufY+N5u4zPYP1ykSYNDbiZfdd9LYKXgUdUAM0gZLLJFIPPo5C+UPYlW0EKRK8
 QN0=
Date:   Thu, 2 Sep 2021 18:21:53 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
Subject: Re: [RFC][PATCH] mm/page_isolation: tracing: trace all
 test_pages_isolated failures
Message-ID: <20210902222152.GA25844@mam-gdavis-dt>
References: <20210823202823.13765-1-george_davis@mentor.com>
 <4f680b5a-9076-3ba4-caea-bdd6eafeb899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f680b5a-9076-3ba4-caea-bdd6eafeb899@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:53:31PM +0200, David Hildenbrand wrote:
> On 23.08.21 22:28, George G. Davis wrote:
> > From: "George G. Davis" <davis.george@siemens.com>
> > 
> > Some test_pages_isolated failure conditions don't include trace points.
> > For debugging issues caused by "pinned" pages, make sure to trace all
> > calls whether they succeed or fail. In this case, a failure case did not
> > result in a trace point. So add the missing failure case in
> > test_pages_isolated traces.
> 
> In which setups did you actually run into these cases?

Good question!

Although I'm not 100% certain that this specific failure condition has
occurred in my recent testing, I'm able to reproduce cma_alloc -EBUSY
faiure conditions when testing latest/recent master on arm64 based
Renesas R-Car Starter Kit [1] using defconfig with
CONFIG_CMA_SIZE_MBYTES=384 while running the following test case:

trace-cmd record -N 192.168.1.87:12345 -b 4096 -e cma -e page_isolation -e compaction -e migrate &
sleep 10
while true; do a=$(( ( RANDOM % 10000 ) + 1 )); echo $a > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $a; echo $a > /sys/kernel/debug/cma/cma-reserved/free); done &
while true; do b=$(( ( RANDOM % 10000 ) + 1 )); echo $b > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $b; echo $b > /sys/kernel/debug/cma/cma-reserved/free); done &
while true; do c=$(( ( RANDOM % 10000 ) + 1 )); echo $c > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $c; echo $c > /sys/kernel/debug/cma/cma-reserved/free); done &
while true; do d=$(( ( RANDOM % 10000 ) + 1 )); echo $d > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $d; echo $d > /sys/kernel/debug/cma/cma-reserved/free); done &
while true; do e=$(( ( RANDOM % 10000 ) + 1 )); echo $e > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $e; echo $e > /sys/kernel/debug/cma/cma-reserved/free); done &
/selftests/vm/transhuge-stress &

The cma_alloc -EBUSY failures are caused by THP compound pages allocated
from the CMA region where migration does not seem to work for compound
THP pages. The work around is to disable CONFIG_TRANSPARENT_HUGEPAGE
since it seems incompatible with the intended use of the CMA region.

> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Regards,
George

[1] https://elinux.org/R-Car/Boards/H3SK
