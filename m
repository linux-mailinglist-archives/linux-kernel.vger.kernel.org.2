Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5930F569
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhBDOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236610AbhBDOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akIDH/nqnd2l3Y4F6QpFR8EQh40BTc1icx5sAwOuZmM=;
        b=Q86wbrCM0GYleomLKHqpNGy5wZNNyjqiQsL28IGIPC6PkUZdvCtluMjB1FtponDR3HreVH
        NcsSDBF92UNum8lTl84jQfG1fSMaui/fs+pBnnLzGfUNP9FPwgSgsY1iv9GK7JazCYeQY+
        BoxaFy1Rnh6r+RI8wcggGDRX+9Kf9Ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-pVjKX0D6MnW1y5ej6j6Erw-1; Thu, 04 Feb 2021 09:49:42 -0500
X-MC-Unique: pVjKX0D6MnW1y5ej6j6Erw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8277B1935780;
        Thu,  4 Feb 2021 14:49:40 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id ADF9C100AE2B;
        Thu,  4 Feb 2021 14:49:37 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:49:36 +0100
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 04/24] perf daemon: Add server socket support
Message-ID: <YBwJgC4QX5re1VNw@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-5-jolsa@kernel.org>
 <20210203210423.GQ854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203210423.GQ854763@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:04:23PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 31, 2021 at 12:48:36AM +0100, Jiri Olsa escreveu:
> > Add support to create server socket that listens for client
> > commands and process them.
> > 
> > This patch adds only the core support, all commands using
> > this functionality are coming in following patches.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-daemon.c | 101 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 100 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index 8d0ac44ec808..756d60616d7d 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <subcmd/parse-options.h>
> > +#include <api/fd/array.h>
> >  #include <linux/limits.h>
> >  #include <string.h>
> >  #include <signal.h>
> > @@ -7,6 +8,10 @@
> >  #include <stdio.h>
> >  #include <unistd.h>
> >  #include <errno.h>
> > +#include <sys/types.h>
> > +#include <sys/socket.h>
> > +#include <sys/un.h>
> > +#include <poll.h>
> >  #include "builtin.h"
> >  #include "perf.h"
> >  #include "debug.h"
> > @@ -37,6 +42,78 @@ static void sig_handler(int sig __maybe_unused)
> >  	done = true;
> >  }
> >  
> > +static int setup_server_socket(struct daemon *daemon)
> > +{
> > +	struct sockaddr_un addr;
> > +	char path[100];
> > +	int fd;
> > +
> > +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> 
> Minor, combine decl with use, since line isn't long and its one after
> the other, i.e.:
> 
> 	int fd = socket(AF_UNIX, SOCK_STREAM, 0);

hum, sure, but I'm missing the point.. I think it's less readable

> 
> > +	if (fd < 0) {
> > +		fprintf(stderr, "socket: %s\n", strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	fcntl(fd, F_SETFD, FD_CLOEXEC);
> 
> Don't we have to check its return?

yep, will add

> 
> > +
> > +	scnprintf(path, PATH_MAX, "%s/control", daemon->base);
> 
> Humm the safe thing here is to use:
> 
> 	scnprintf(path, sizeof(path), "%s/control", daemon->base);
> 
> Using it like that would avoid the bug in your code, as path has only
> 100 bytes, not PATH_MAX bytes ;-)

right, will change

> 
> > +
> > +	memset(&addr, 0, sizeof(addr));
> > +	addr.sun_family = AF_UNIX;
> > +
> > +	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> 
> strncpy may end up not adding the final \0 see the NOTES in its man
> page. Consider using strlcpy instead. See:
> 
>   bef0b8970f27da5c ("perf probe: Fix unchecked usage of strncpy()")

hum, it's memset-ed to 0 for that an there's -1 in the size,
so I'd think there's zero at the end, but we can use strlcpy
to make it more obvious

SNIP

> > +		fprintf(stderr, "accept: %s\n", strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	if (sizeof(cmd) != read(fd, &cmd, sizeof(cmd))) {
> > +		fprintf(stderr, "read: %s\n", strerror(errno));
> 
> close fd
> 
> > +		return -1;
> > +	}
> > +
> > +	out = fdopen(fd, "w");
> > +	if (!out) {
> > +		perror("failed: fdopen");
> 
> close fd
> 
> I.e. goto out_close;
> 
> > +		return -1;
> > +	}
> > +
> > +	switch (cmd.cmd) {
> > +	default:
> > +		break;
> > +	}
> > +
> > +	fclose(out);
> 
> out_close:
> 
> > +	close(fd);
> > +	return ret;

ugh, I overlooked this one

thanks
jirka

