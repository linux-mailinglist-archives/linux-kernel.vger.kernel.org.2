Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009231960C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBKWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBKWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613083929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5D7tx96hW8+iSr7h+SWJ+R1lPALPC4lcJQq6hJqdBtk=;
        b=D860JI0X/iFRXKJERUjm6HMJ2TV3LM6ZbT55eql1GR1Lp0nOcqweJGfcuNY0W93tVULMA2
        cdjQVzBUa3SHAPu/+w9sdE/CL1LlgntmA0kEuHMzjRfdsXnx73NVmnppEubY++u5zWDqxn
        kxI+rvOfnersDoAiemOWWZPuM8SOpr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-OuLTCceuNxe7Tg90bgHOtA-1; Thu, 11 Feb 2021 17:52:07 -0500
X-MC-Unique: OuLTCceuNxe7Tg90bgHOtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6D9107ACE8;
        Thu, 11 Feb 2021 22:52:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.118])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33FB55D764;
        Thu, 11 Feb 2021 22:52:03 +0000 (UTC)
Date:   Thu, 11 Feb 2021 23:52:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <YCW1EtGBtcLbcj1V@krava>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-7-jolsa@kernel.org>
 <CAM9d7cgURTm6UVUkOo8Tfv_zRGWBAtHqdLKxdSXYmToajjgALg@mail.gmail.com>
 <YCVfMmYmPTm2r6ct@krava>
 <20210211171048.GF1131885@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211171048.GF1131885@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 02:10:48PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 11, 2021 at 05:45:38PM +0100, Jiri Olsa escreveu:
> > On Thu, Feb 11, 2021 at 03:01:12PM +0900, Namhyung Kim wrote:
> > > Hi Jiri,
> > > 
> > > On Tue, Feb 9, 2021 at 5:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > +static int daemon__reconfig(struct daemon *daemon)
> > > > +{
> > > > +       struct daemon_session *session, *n;
> > > > +
> > > > +       list_for_each_entry_safe(session, n, &daemon->sessions, list) {
> > > > +               /* No change. */
> > > > +               if (session->state == OK)
> > > > +                       continue;
> > > > +
> > > > +               /* Remove session. */
> > > > +               if (session->state == KILL) {
> > > > +                       if (session->pid > 0) {
> > > > +                               daemon_session__kill(session);
> > > > +                               pr_info("reconfig: session '%s' killed\n", session->name);
> > > > +                       }
> > > > +                       daemon_session__remove(session);
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               /* Reconfig session. */
> > > > +               if (session->pid > 0) {
> > > > +                       daemon_session__kill(session);
> > > > +                       pr_info("reconfig: session '%s' killed\n", session->name);
> > > > +               }
> > > > +               if (daemon_session__run(session, daemon))
> > > > +                       return -1;
> > > 
> > > Shouldn't it be 'continue'?  If there's a problematic session
> > > it'll prevent others from being processed.  And it seems this
> > > code will try to run it again and again.  Maybe we can put it
> > > in the KILL state (or a new FAILED state) IMHO.
> > 
> > so if there is misconfigured session, it will get executed,
> > and then we catch that it exited, like:
> > 
> > 	# ./perf daemon start -f
> > 	[2021-02-11 17:38:19.718166] daemon started (pid 1167439)
> > 	[2021-02-11 17:38:19.719757] reconfig: ruining session [cycles:1167440]: abc -m 10M -e cycles --overwrite --switch-output -a
> > 	[2021-02-11 17:38:19.720861] reconfig: ruining session [sched:1167441]: -m 20M -e sched:* --overwrite --switch-output -a
> > 	[2021-02-11 17:38:21.132511] session 'cycles' exited, status=255
> > 
> > session will be removed
> > 
> > when the config is fixed and updated, daemon will pick it up:
> > 
> > 	[2021-02-11 17:42:59.241140] reconfig: ruining session [cycles:1167642]: -m 10M -e cycles --overwrite --switch-output -a
> > 
> > 
> > daemon_session__run fails only there's no memory for allocation,
> > if mkdir fails (for other error than EEXIST) and if fork fails,
> > so pretty serious errors, where we want to bail out anyway
> 
> I know you love documentation, that is why I think that it would be a
> good idea to have these questions and answers in a FAQ for 'perf
> daemon', don't you think? ;-)

heh, sure.. I can add something like that as section to perf-daemon man page

jirka

