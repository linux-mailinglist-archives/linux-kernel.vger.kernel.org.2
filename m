Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA70E319135
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhBKRg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhBKQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613061358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8772P6vmNybTNfCUnNYCC7Sd7vQziPC/FvJiYq/mKF0=;
        b=OIAt1EI0H+fD7pfveKBJCaX72Av/D+cFAH7OW9OWLE6OEwYVSmavQiWZOULOLrjri2HH+/
        T4v0YhXaMKmzpqHwZFqWA11/qvyLbfSbT57wT3Q4760JhvJoEqABzA4JW0WylIZBnHulJk
        AXic1E0sIpgXDP3i5Q8EtAhIa+9CFEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-MhuDq2VTMEisZjcwKw9DnA-1; Thu, 11 Feb 2021 11:35:56 -0500
X-MC-Unique: MhuDq2VTMEisZjcwKw9DnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09AE910066F0;
        Thu, 11 Feb 2021 16:35:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with SMTP id C71A360BF1;
        Thu, 11 Feb 2021 16:35:52 +0000 (UTC)
Date:   Thu, 11 Feb 2021 17:35:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 13/24] perf daemon: Allow only one daemon over base
 directory
Message-ID: <YCVc50BOTWI2PREo@krava>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-14-jolsa@kernel.org>
 <20210211132018.GE1131885@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211132018.GE1131885@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:20:18AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 09:08:57PM +0100, Jiri Olsa escreveu:
> > Add 'lock' file under daemon base and flock it, so only one
> > perf daemon can run on top of it.
> > 
> > Each daemon tries to create and lock BASE/lock file, if it's
> > successful we are sure we're the only daemon running over
> > the BASE.
> > 
> > Once daemon is finished, file descriptor to lock file is
> > closed and lock is released.
> > 
> > Example:
> > 
> >   # cat ~/.perfconfig
> >   [daemon]
> >   base=/opt/perfdata
> > 
> >   [session-cycles]
> >   run = -m 10M -e cycles --overwrite --switch-output -a
> > 
> >   [session-sched]
> >   run = -m 20M -e sched:* --overwrite --switch-output -a
> > 
> > Starting the daemon:
> > 
> >   # perf daemon start
> > 
> > And try once more:
> > 
> >   # perf daemon start
> >   failed: another perf daemon (pid 775594) owns /opt/perfdata
> > 
> > will end up with an error, because there's already one running
> > on top of /opt/perfdata.
> 
> Had to add this:
> 
> Committer notes:
> 
> Provide lockf(F_TLOCK) when not available, i.e. transform:
> 
>   lockf(fd, F_TLOCK, 0);
> 
> into:
> 
>   flock(fd, LOCK_EX | LOCK_NB);
> 
> Which should be equivalent.
> 
> Noticed when cross building to some odd Android NDK.
> 
> ------
> 
> Patch:
> 
> [acme@five perf]$ git diff
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 1c17c9e10ca6a656..2890573540f7d027 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -914,6 +914,20 @@ static int setup_config(struct daemon *daemon)
>         return daemon->config_real ? 0 : -1;
>  }
>  
> +#ifndef F_TLOCK
> +#define F_TLOCK 2
> +
> +#include <sys/file.h>
> +
> +static int lockf(int fd, int cmd, off_t len)
> +{
> +       if (cmd != F_TLOCK || len != 0)
> +               return -1;
> +
> +       return flock(fd, LOCK_EX | LOCK_NB);
> +}
> +#endif // F_TLOCK
> +
>  /*
>   * Each daemon tries to create and lock BASE/lock file,
>   * if it's successful we are sure we're the only daemon
> [acme@five perf]$
> 

nice, thanks

jirka

