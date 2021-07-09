Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDE3C23B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhGIMyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhGIMyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D15736138C;
        Fri,  9 Jul 2021 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625835126;
        bh=Wtc6at4EMqah+8lowzdqgZUoTzKBCQyUdjkUDeV9SJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCc+tS7QS3rSYo8B2Ur55ib22wyOTkpQDcFL5F2FC+3CF19rilIMwARhbSOqWLb+z
         ZIK1Ro8VA5kAUEnoM1SbxupTej9e9FJ6lFmxT+PMiwf0s6y1ZOKJIod2BB4/fglcoJ
         7fmDmpDbjdUpUUMAkb9Zv/TDA3Vo2DIALPBw9MJQxXEHGCQfVrEejdB4b93IELSIRV
         edEvrIAOg/SBu5oBsKNJ2Qs+lxijAlZmS/rlgqYOyzg3LH0OFFlwfKa1taJSGvW9BI
         QqywldFABFDFabVuie/Ywug8SWCMo8lMiUMPPwpXnde4SZS74h3TOFqt6PsgPWJObL
         H6NQ3ZY4EynhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 567B040B1A; Fri,  9 Jul 2021 09:52:03 -0300 (-03)
Date:   Fri, 9 Jul 2021 09:52:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Liang, Kan" <kan.liang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf stat: Add Topdown metrics L2 events as default
 events
Message-ID: <YOhGc+81IjLKRXVS@kernel.org>
References: <1625760169-18396-1-git-send-email-kan.liang@intel.com>
 <CAM9d7ciuJFpFJC+DSdSg=3VeK_YUgSiWdTE++LZHk4ir6NGLtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciuJFpFJC+DSdSg=3VeK_YUgSiWdTE++LZHk4ir6NGLtg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 08, 2021 at 10:31:34PM -0700, Namhyung Kim escreveu:
> On Thu, Jul 8, 2021 at 9:04 AM <kan.liang@intel.com> wrote:
> > With the patch:

> >  $ perf stat sleep 1

> >  Performance counter stats for 'sleep 1':

> >               0.59 msec task-clock                #    0.001 CPUs utilized
> >                  1      context-switches          #    1.687 K/sec
> >                  0      cpu-migrations            #    0.000 /sec
> >                 76      page-faults               #  128.198 K/sec
> >          1,405,318      cycles                    #    2.371 GHz
> >          1,471,136      instructions              #    1.05  insn per cycle
> >            310,132      branches                  #  523.136 M/sec
> >             10,435      branch-misses             #    3.36% of all branches
> >          8,431,908      slots                     #   14.223 G/sec
> >          1,554,116      topdown-retiring          #     18.4% retiring
> >          1,289,585      topdown-bad-spec          #     15.2% bad speculation
> >          2,810,636      topdown-fe-bound          #     33.2% frontend bound
> >          2,810,636      topdown-be-bound          #     33.2% backend bound
> >            231,464      topdown-heavy-ops         #      2.7% heavy operations       #     15.6% light operations
> >          1,223,453      topdown-br-mispredict     #     14.5% branch mispredict      #      0.8% machine clears
> >          1,884,779      topdown-fetch-lat         #     22.3% fetch latency          #     10.9% fetch bandwidth
> >          1,454,917      topdown-mem-bound         #     17.2% memory bound           #     16.0% Core bound

> >        1.001179699 seconds time elapsed

> >        0.000000000 seconds user
> >        0.001238000 seconds sys

> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

