Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33035319177
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBKRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhBKRLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:11:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9292164E87;
        Thu, 11 Feb 2021 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613063452;
        bh=ErLkorkez6UPatXvEwAqDcGbrjhv7rz60Ia1Tjb57mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWWiaClVrhP+gnom5QxULHjQagcNmC9qD/BvZB5QxNW+pUmyQWLhJpxNKG7p+VHKK
         ighMK4dj4TbxUnY31Fh2HFGvCI3oQxLMIauK1wuUbzVdfRrhpMDtRpiJX/wN26SSGo
         PDcAcK1OBocQJydRF/ctU3OiUZB40eg7cYHPhy5XlvMUvPShqqappc7R6xnI2FgFbR
         ampDV+0SS1BZpc0GKvbgLCdvfDK1kxLS8eyVqqJIviVaRN3b5jnLKndBVZITeH10UX
         JSgur5AyZzIZSidfmiR/7ieWqLNUMonAKzSSCZw4yN85/hF8lJuC9xMI9IU95iAW/7
         C8Z1rFVEAuvlg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0E3B40513; Thu, 11 Feb 2021 14:10:48 -0300 (-03)
Date:   Thu, 11 Feb 2021 14:10:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
Message-ID: <20210211171048.GF1131885@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-7-jolsa@kernel.org>
 <CAM9d7cgURTm6UVUkOo8Tfv_zRGWBAtHqdLKxdSXYmToajjgALg@mail.gmail.com>
 <YCVfMmYmPTm2r6ct@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCVfMmYmPTm2r6ct@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 11, 2021 at 05:45:38PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 11, 2021 at 03:01:12PM +0900, Namhyung Kim wrote:
> > Hi Jiri,
> > 
> > On Tue, Feb 9, 2021 at 5:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > +static int daemon__reconfig(struct daemon *daemon)
> > > +{
> > > +       struct daemon_session *session, *n;
> > > +
> > > +       list_for_each_entry_safe(session, n, &daemon->sessions, list) {
> > > +               /* No change. */
> > > +               if (session->state == OK)
> > > +                       continue;
> > > +
> > > +               /* Remove session. */
> > > +               if (session->state == KILL) {
> > > +                       if (session->pid > 0) {
> > > +                               daemon_session__kill(session);
> > > +                               pr_info("reconfig: session '%s' killed\n", session->name);
> > > +                       }
> > > +                       daemon_session__remove(session);
> > > +                       continue;
> > > +               }
> > > +
> > > +               /* Reconfig session. */
> > > +               if (session->pid > 0) {
> > > +                       daemon_session__kill(session);
> > > +                       pr_info("reconfig: session '%s' killed\n", session->name);
> > > +               }
> > > +               if (daemon_session__run(session, daemon))
> > > +                       return -1;
> > 
> > Shouldn't it be 'continue'?  If there's a problematic session
> > it'll prevent others from being processed.  And it seems this
> > code will try to run it again and again.  Maybe we can put it
> > in the KILL state (or a new FAILED state) IMHO.
> 
> so if there is misconfigured session, it will get executed,
> and then we catch that it exited, like:
> 
> 	# ./perf daemon start -f
> 	[2021-02-11 17:38:19.718166] daemon started (pid 1167439)
> 	[2021-02-11 17:38:19.719757] reconfig: ruining session [cycles:1167440]: abc -m 10M -e cycles --overwrite --switch-output -a
> 	[2021-02-11 17:38:19.720861] reconfig: ruining session [sched:1167441]: -m 20M -e sched:* --overwrite --switch-output -a
> 	[2021-02-11 17:38:21.132511] session 'cycles' exited, status=255
> 
> session will be removed
> 
> when the config is fixed and updated, daemon will pick it up:
> 
> 	[2021-02-11 17:42:59.241140] reconfig: ruining session [cycles:1167642]: -m 10M -e cycles --overwrite --switch-output -a
> 
> 
> daemon_session__run fails only there's no memory for allocation,
> if mkdir fails (for other error than EEXIST) and if fork fails,
> so pretty serious errors, where we want to bail out anyway

I know you love documentation, that is why I think that it would be a
good idea to have these questions and answers in a FAQ for 'perf
daemon', don't you think? ;-)

- Arnaldo
