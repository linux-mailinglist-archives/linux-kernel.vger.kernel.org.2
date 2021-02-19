Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC931F87A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhBSLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhBSLhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:37:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0675664E86;
        Fri, 19 Feb 2021 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613734624;
        bh=gHEQU1XxqU4aw2PyVE3yrc+QG1v7YGb4x9pQeqe0F+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXQB7A65neqXQ3sM1T3YsTZM4QChDAjvr2nqf/1kftUrVdxQaRwvMaSITtStOJvGL
         qjvL66DXk1056QyauvNYqcXA7+pmZ5ZuaQz5wCIHT7YkcHL6Gp6A8ZiVbpUeakrYBr
         1/LZJgURpodH5eJgCwKHzXtGY6zvEsEEvzxqVs3y2enHn1gbbxNSPcXVGejwlNU1kZ
         bz0c7d0lMmfz14xOMWXVAesCeMHoGbGdIIrXVfk4p7M4KXxZC7Ng60ErFTs3qjjtSV
         FShhDl9/Sqkgaa+T5WC7hrhQIaY4oDDmAZ8lH5KQKNzrDrAKowgMnlKkVuCYS7tuuI
         rC5T+1MpYcS0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D672F40CD9; Fri, 19 Feb 2021 08:37:00 -0300 (-03)
Date:   Fri, 19 Feb 2021 08:37:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] tools/lib/fs: Cache cgroupfs mount point
Message-ID: <YC+i3HDX2H4fB9ea@kernel.org>
References: <20201216090556.813996-1-namhyung@kernel.org>
 <20201216090556.813996-3-namhyung@kernel.org>
 <20201229115158.GH521329@kernel.org>
 <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
 <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com>
 <YC0S858hMZG6o/tt@kernel.org>
 <CAM9d7cj=XrpTDQuJ1vhax0drpO8rcbjQgUi3Gj8Q2476U7SmgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=XrpTDQuJ1vhax0drpO8rcbjQgUi3Gj8Q2476U7SmgQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 19, 2021 at 07:05:59PM +0900, Namhyung Kim escreveu:
> On Wed, Feb 17, 2021 at 9:58 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Fri, Jan 08, 2021 at 02:51:44PM +0900, Namhyung Kim escreveu:
> > > On Wed, Jan 6, 2021 at 10:33 AM Namhyung Kim <namhyung@kernel.org> wrote:

> > > As you said, I think mostly we don't care as the accesses will happen
> > > in a short period of time.  But if you really care, maybe for the upcoming
> > > perf daemon changes, I think we can add an API to invalidate the cache
> > > or internal time-based invalidation logic (like remove it after 10 sec.).

> > Ok, we can have something in 'perf daemon' to periodically invalidate
> > this, maybe do a poor man inotify and when asking for the cgroup
> > mountpoint, check some characteristic of that file that changes when it
> > is modified, or plain use a timestamp and have some threshold.
 
> I thought about this again.
 
> We don't directly access the cgroups in the perf daemon.  It just
> creates new record processes so they'll see a new mountpoint whenever
> they started since this cache is shared within the process only.
 
> That means we don't need to care about the invalidate in the daemon
> but each perf record and perf stat should do it when they are required
> to do the work repeatedly.
 
> But looking at the code, the cgroup is set during event parsing (-G
> option) or early in the command (--for-each-cgroup option).  So cgroup
> info would not be changed even if the command runs repeatedly.
 
> So I think you can take the patch as is.

Its in perf/core branch on its way to Linus soon :-)

Thanks for checking it.

- Arnaldo
