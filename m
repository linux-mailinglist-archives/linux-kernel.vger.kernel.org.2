Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD032A671
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384526AbhCBPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:05:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52087 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444910AbhCBMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:41:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 086C964F04;
        Tue,  2 Mar 2021 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688286;
        bh=PsEBrE1M2DU71pnN+2mQbVw4Vli0jK/AS3fK2I93fOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9Nfmkax+2rGR/3vchrdsvPWDZZXhbdNte8z5IzXeT27hge732vOLFbYjpHngJGp2
         gJe5TE0WMTeyGmJxXDn8TYt7lj5orDELjoWn/QceuQb9jQ5klJy84/YR/Kq2IuEAaM
         G3UCEkmMzv6KUuioXk7gA8ouIcxaiqNYFTvLuBnBGCqaQ3tZTFm/E3VJvFAgkjGth8
         bTDNuo78V5pk0n4yS1qc1wUrnGRJ8ZdESZWucdTNOlVk4sGlOdBKARRcZnk+/ORxO7
         H4Va9mFllq4aJsZNt9L+iPAPxdDfoEwjmdHHDAhAhue2RltX9cbJ87mC/QUJtsaDT+
         ZokLKVvnUjfWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0B4040CD9; Tue,  2 Mar 2021 09:31:23 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:31:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dmitry Safonov <dima@arista.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf diff: Don't crash on freeing errno-session
Message-ID: <YD4wG8+/cvLTQjOF@kernel.org>
References: <20210302023533.1572231-1-dima@arista.com>
 <CAM9d7cibt7MdaZq2mX73N0gYViE7EGg_TcwkU6uq3NS7rgVSkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cibt7MdaZq2mX73N0gYViE7EGg_TcwkU6uq3NS7rgVSkw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 02, 2021 at 01:47:55PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Mar 2, 2021 at 11:35 AM Dmitry Safonov <dima@arista.com> wrote:
> >
> > __cmd_diff() sets result of perf_session__new() to d->session.
> > In case of failure, it's errno and perf-diff may crash with:
> > failed to open perf.data: Permission denied
> > Failed to open perf.data
> > Segmentation fault (core dumped)
> >
> > From the coredump:
> > 0  0x00005569a62b5955 in auxtrace__free (session=0xffffffffffffffff)
> >     at util/auxtrace.c:2681
> > 1  0x00005569a626b37d in perf_session__delete (session=0xffffffffffffffff)
> >     at util/session.c:295
> > 2  perf_session__delete (session=0xffffffffffffffff) at util/session.c:291
> > 3  0x00005569a618008a in __cmd_diff () at builtin-diff.c:1239
> > 4  cmd_diff (argc=<optimized out>, argv=<optimized out>) at builtin-diff.c:2011
> > [..]
> >
> > Funny enough, it won't always crash. For me it crashes only if failed
> > file is second in cmd-line: the reason is that cmd_diff() check files for
> > branch-stacks [in check_file_brstack()] and if the first file doesn't
> > have brstacks, it doesn't proceed to try open other files from cmd-line.
> >
> > Check d->session before calling perf_session__delete().
> >
> > Another solution would be assigning to temporary variable, checking it,
> > but I find it easier to follow with IS_ERR() check in the same function.
> > After some time it's still obvious why the check is needed, and with
> > temp variable it's possible to make the same mistake.
> >
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, tested, added a complete set of steps for a problem to be
reproduced and applied.

- Arnaldo

    Committer testing:
    
      $ perf record sleep 1
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.001 MB perf.data (8 samples) ]
      $ perf diff
      failed to open perf.data.old: No such file or directory
      Failed to open perf.data.old
      $ perf record sleep 1
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.001 MB perf.data (8 samples) ]
      $ perf diff
      # Event 'cycles:u'
      #
      # Baseline  Delta Abs  Shared Object     Symbol
      # ........  .........  ................  ..........................
      #
           0.92%    +87.66%  [unknown]         [k] 0xffffffff8825de16
          11.39%     +0.04%  ld-2.32.so        [.] __GI___tunables_init
          87.70%             ld-2.32.so        [.] _dl_check_map_versions
      $ sudo chown root:root perf.data
      [sudo] password for acme:
      $ perf diff
      failed to open perf.data: Permission denied
      Failed to open perf.data
      Segmentation fault (core dumped)
      $
    
    After the patch:
    
      $ perf diff
      failed to open perf.data: Permission denied
      Failed to open perf.data
      $
    
    Signed-off-by: Dmitry Safonov <dima@arista.com>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
