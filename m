Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EB318C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBKNk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhBKNVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:21:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCAD664E7A;
        Thu, 11 Feb 2021 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613049621;
        bh=8uHnF8chlIvP+4xo52R4mAyVueiT8FN7qv0ldkJ0cwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcvTzta8NUiDuFjCjekoE2rz/F6Hw8DmtEHy8UqYkJgSoKzw8oiEE6P3ODUEclpKj
         EUWfu8Dt1skUEguPs8pAo/c2GnDe2uT8QsS2gCa/ECRmtNVYLECxxG4MYCIao68WYM
         vunqXL7JEeIVHm4tBmkTgXLxrAqJqjLnd+Ysgz9va/egYMcfPYxXSlrhfa02iUuhRY
         Dciv9sHYYGWZm3iyZzE/3UiLKaZ4kx1hZ4+Qyfh7o7QhETSUVvKxGnf4bLRSbjKy+C
         Z2BjYRIfL85DkJn05pel+v7WTGCaxr++x0/qO20meg0dQMqFJiG0sp4dW2RluQiA8X
         6SvRpoMQvgcsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 794BA40513; Thu, 11 Feb 2021 10:20:18 -0300 (-03)
Date:   Thu, 11 Feb 2021 10:20:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20210211132018.GE1131885@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-14-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208200908.1019149-14-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 09:08:57PM +0100, Jiri Olsa escreveu:
> Add 'lock' file under daemon base and flock it, so only one
> perf daemon can run on top of it.
> 
> Each daemon tries to create and lock BASE/lock file, if it's
> successful we are sure we're the only daemon running over
> the BASE.
> 
> Once daemon is finished, file descriptor to lock file is
> closed and lock is released.
> 
> Example:
> 
>   # cat ~/.perfconfig
>   [daemon]
>   base=/opt/perfdata
> 
>   [session-cycles]
>   run = -m 10M -e cycles --overwrite --switch-output -a
> 
>   [session-sched]
>   run = -m 20M -e sched:* --overwrite --switch-output -a
> 
> Starting the daemon:
> 
>   # perf daemon start
> 
> And try once more:
> 
>   # perf daemon start
>   failed: another perf daemon (pid 775594) owns /opt/perfdata
> 
> will end up with an error, because there's already one running
> on top of /opt/perfdata.

Had to add this:

Committer notes:

Provide lockf(F_TLOCK) when not available, i.e. transform:

  lockf(fd, F_TLOCK, 0);

into:

  flock(fd, LOCK_EX | LOCK_NB);

Which should be equivalent.

Noticed when cross building to some odd Android NDK.

------

Patch:

[acme@five perf]$ git diff
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 1c17c9e10ca6a656..2890573540f7d027 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -914,6 +914,20 @@ static int setup_config(struct daemon *daemon)
        return daemon->config_real ? 0 : -1;
 }
 
+#ifndef F_TLOCK
+#define F_TLOCK 2
+
+#include <sys/file.h>
+
+static int lockf(int fd, int cmd, off_t len)
+{
+       if (cmd != F_TLOCK || len != 0)
+               return -1;
+
+       return flock(fd, LOCK_EX | LOCK_NB);
+}
+#endif // F_TLOCK
+
 /*
  * Each daemon tries to create and lock BASE/lock file,
  * if it's successful we are sure we're the only daemon
[acme@five perf]$
