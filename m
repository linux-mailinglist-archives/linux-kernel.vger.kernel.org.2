Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1931D9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhBQM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhBQM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:59:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE01D64E4A;
        Wed, 17 Feb 2021 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613566710;
        bh=LuuTZFC1X9pim/XLsOBXERDNf+hidyPvmXjt6nSvnLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1Yb0vfxWPHRCJFBuuIBDynYRiPc+oDKTR8hHnIgK2ZeqslARNnJ5F0DbGPomS0RC
         CQIjk3IgYwiv3WmMIVOFCRLA1bZ41OChTznf7bmaIvv/+i/+zLPT76F7KXo+d22ofg
         7sqW0OuxFdWEnIOYZrhYhsxjdO4sl0JefWnP4QAb3M+V8NPboDfpuNr5MleI+3v9r/
         dCtIKa4BHOrzxXKqrRkIQnqKwjH/MdatZle9xqzVxdmAEdACsxpIWPm95Ux9DZARcA
         5sEgxk62lQt9X9tyO9gF3CQ4Pu7s93pLLg16FsXPRgBnspSfY3s0EkGehDhDxlnAMt
         vS8nzB3I3O0LQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D2D6C40CD9; Wed, 17 Feb 2021 09:58:27 -0300 (-03)
Date:   Wed, 17 Feb 2021 09:58:27 -0300
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
Message-ID: <YC0S858hMZG6o/tt@kernel.org>
References: <20201216090556.813996-1-namhyung@kernel.org>
 <20201216090556.813996-3-namhyung@kernel.org>
 <20201229115158.GH521329@kernel.org>
 <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
 <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 08, 2021 at 02:51:44PM +0900, Namhyung Kim escreveu:
> On Wed, Jan 6, 2021 at 10:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Arnaldo,
> >
> > On Tue, Dec 29, 2020 at 8:51 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Dec 16, 2020 at 06:05:56PM +0900, Namhyung Kim escreveu:
> > > > Currently it parses the /proc file everytime it opens a file in the
> > > > cgroupfs.  Save the last result to avoid it (assuming it won't be
> > > > changed between the accesses).
> > >
> > > Which is the most likely case, but can't we use something like inotify
> > > to detect that and bail out or warn the user?
> >
> > Hmm.. looks doable.  Will check.
> 
> So I've played with inotify a little bit, and it seems it needs to monitor
> changes on the file or the directory.  I didn't get any notification from
> the /proc/mounts file even if I did some mount/umount.
> 
> Instead, I could get IN_UNMOUNT when the cgroup filesystem was
> unmounted.  But for the monitoring, we need to do one of a) select-like
> syscall to wait for the events, b) signal-driven IO notification or c) read
> the inotify file with non-block mode everytime.
> 
> In a library code, I don't think we can do a) or b) since it can affect
> user program behaviors.  Then we should go with c) but I think
> it's opposite to the purpose of this patch. :)
> 
> As you said, I think mostly we don't care as the accesses will happen
> in a short period of time.  But if you really care, maybe for the upcoming
> perf daemon changes, I think we can add an API to invalidate the cache
> or internal time-based invalidation logic (like remove it after 10 sec.).

Ok, we can have something in 'perf daemon' to periodically invalidate
this, maybe do a poor man inotify and when asking for the cgroup
mountpoint, check some characteristic of that file that changes when it
is modified, or plain use a timestamp and have some threshold.

- Arnaldo
 
> Thoughts?
> 
> Thanks,
> Namhyung

-- 

- Arnaldo
