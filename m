Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A28319147
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhBKRkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232018AbhBKQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613061949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7kjWgf6y8prVSBddTaqW/VuNMnHuHGQXBpyst2KGzw=;
        b=izpk+4M0xD0aPudJJcpOUl61lw3XSO/Ew0hkIu7jKh52f+KidQn+v1qw5O4b9/vPdtQSFi
        os3pUE6QSmn74reMq2gnrY57UupGHb+puU7seIMr3ZxWUQpbJvkLV2Pm1jecVJH401AGQ9
        FI0F5hMxK46hA4lkhS1yOjbejJVXvTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-hCCo7VP9NSu_kj8hZ9UyUA-1; Thu, 11 Feb 2021 11:45:45 -0500
X-MC-Unique: hCCo7VP9NSu_kj8hZ9UyUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63A7A195D564;
        Thu, 11 Feb 2021 16:45:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with SMTP id D20E45C1BD;
        Thu, 11 Feb 2021 16:45:39 +0000 (UTC)
Date:   Thu, 11 Feb 2021 17:45:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
Message-ID: <YCVfMmYmPTm2r6ct@krava>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-7-jolsa@kernel.org>
 <CAM9d7cgURTm6UVUkOo8Tfv_zRGWBAtHqdLKxdSXYmToajjgALg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgURTm6UVUkOo8Tfv_zRGWBAtHqdLKxdSXYmToajjgALg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:01:12PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Tue, Feb 9, 2021 at 5:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > +static int daemon__reconfig(struct daemon *daemon)
> > +{
> > +       struct daemon_session *session, *n;
> > +
> > +       list_for_each_entry_safe(session, n, &daemon->sessions, list) {
> > +               /* No change. */
> > +               if (session->state == OK)
> > +                       continue;
> > +
> > +               /* Remove session. */
> > +               if (session->state == KILL) {
> > +                       if (session->pid > 0) {
> > +                               daemon_session__kill(session);
> > +                               pr_info("reconfig: session '%s' killed\n", session->name);
> > +                       }
> > +                       daemon_session__remove(session);
> > +                       continue;
> > +               }
> > +
> > +               /* Reconfig session. */
> > +               if (session->pid > 0) {
> > +                       daemon_session__kill(session);
> > +                       pr_info("reconfig: session '%s' killed\n", session->name);
> > +               }
> > +               if (daemon_session__run(session, daemon))
> > +                       return -1;
> 
> Shouldn't it be 'continue'?  If there's a problematic session
> it'll prevent others from being processed.  And it seems this
> code will try to run it again and again.  Maybe we can put it
> in the KILL state (or a new FAILED state) IMHO.

so if there is misconfigured session, it will get executed,
and then we catch that it exited, like:

	# ./perf daemon start -f
	[2021-02-11 17:38:19.718166] daemon started (pid 1167439)
	[2021-02-11 17:38:19.719757] reconfig: ruining session [cycles:1167440]: abc -m 10M -e cycles --overwrite --switch-output -a
	[2021-02-11 17:38:19.720861] reconfig: ruining session [sched:1167441]: -m 20M -e sched:* --overwrite --switch-output -a
	[2021-02-11 17:38:21.132511] session 'cycles' exited, status=255

session will be removed

when the config is fixed and updated, daemon will pick it up:

	[2021-02-11 17:42:59.241140] reconfig: ruining session [cycles:1167642]: -m 10M -e cycles --overwrite --switch-output -a


daemon_session__run fails only there's no memory for allocation,
if mkdir fails (for other error than EEXIST) and if fork fails,
so pretty serious errors, where we want to bail out anyway

jirka

