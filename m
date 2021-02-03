Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1B30E4D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhBCVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231134AbhBCVR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:17:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DE7564F5F;
        Wed,  3 Feb 2021 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612387038;
        bh=Fnofn/VQSR+gZaBuO49KNNHYjAjducLJujSaPb2u89Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgTZDscXMDOz41v4tb4JslICYc5KGi66zkzsh21bpCyfuwa5EpjeQpcw3PrCoYDAQ
         qOLIT1JupYPqG7lUy75zLYm8MYwB4UOOZiLvLtoUNL3PpNxYOE7y7kwy2EDOexPcHb
         vn6fQCdLHVm7Aq2O1MCL/1Nulw25Y6QZ3gNC5ABUzbWGWfCxxRSg+lufRVrPTLXp4Z
         2Azl2H4FaHZR8rKcuv76P224FzRZfkuzLZJxiPUIiPSw49wtq5jgT5EOGiU8oUucBH
         HkozZmIplF36TZkkPzbPeDDOGHakpjB6xXJg2vvT8oSQ2i6sLfbMURYq0tJQYICd6J
         +WnPaNSetKX+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08E1740513; Wed,  3 Feb 2021 18:17:15 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:17:15 -0300
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 18/24] perf daemon: Add man page for perf-daemon
Message-ID: <20210203211715.GV854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-19-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-19-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:50AM +0100, Jiri Olsa escreveu:
> Adding man page for perf-daemon usage.

I see you decided to add it at the end, but for consistency, please
consider adding the bare minimum when adding
tools/perf/builtin-daemon.c, then go on adding the options and examples
as the features are being added.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-config.txt |  14 ++
>  tools/perf/Documentation/perf-daemon.txt | 187 +++++++++++++++++++++++
>  2 files changed, 201 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index c3ce48f1b379..153bde14bbe0 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -703,6 +703,20 @@ auxtrace.*::
>  		If the directory does not exist or has the wrong file type,
>  		the current directory is used.
>  
> +daemon.*::
> +
> +	daemon.base::
> +		Base path for daemon data. All sessions data are stored under
> +		this path.
> +
> +session-<NAME>.*::
> +
> +	session-<NAME>.run::
> +
> +		Defines new record session for daemon. The value is record's
> +		command line without the 'record' keyword.
> +
> +
>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
> index e69de29bb2d1..b0e1015476c2 100644
> --- a/tools/perf/Documentation/perf-daemon.txt
> +++ b/tools/perf/Documentation/perf-daemon.txt
> @@ -0,0 +1,187 @@
> +perf-daemon(1)
> +==============
> +
> +NAME
> +----
> +perf-daemon - Run record sessions on background
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf daemon'
> +'perf daemon' [<options>]
> +'perf daemon start'  [<options>]
> +'perf daemon stop'   [<options>]
> +'perf daemon signal' [<options>]
> +'perf daemon ping'   [<options>]
> +
> +
> +DESCRIPTION
> +-----------
> +This command allows to run simple daemon process that starts and
> +monitors configured record sessions.
> +
> +Each session represents one perf record process started with
> +control setup (with perf record --control.. options).
> +
> +These sessions are configured through config file, see CONFIG FILE
> +section with EXAMPLES.
> +
> +
> +OPTIONS
> +-------
> +--config=<PATH>::
> +	Config file path, if not perf will check system and default
> +	locations (/etc/perfconfig, $HOME/.perfconfig).
> +
> +-v::
> +--verbose::
> +	Be more verbose.
> +
> +
> +All generic options are available also under commands.
> +
> +
> +START COMMAND
> +-------------
> +The start command creates the daemon process.
> +
> +-f::
> +--foreground::
> +	Do not put the process in background.
> +
> +
> +STOP COMMAND
> +------------
> +The stop command stops all the session and the daemon process.
> +
> +
> +SIGNAL COMMAND
> +--------------
> +The signal command sends signal to configured sessions.
> +
> +--session::
> +	Send signal to specific session.
> +
> +
> +PING COMMAND
> +------------
> +The ping command sends control ping to configured sessions.
> +
> +--session::
> +	Send ping to specific session.
> +
> +
> +CONFIG FILE
> +-----------
> +The daemon is configured within standard perf config file by
> +following new variables:
> +
> +daemon.base:
> +	Base path for daemon data. All sessions data are
> +	stored under this path.
> +
> +session-<NAME>.run:
> +	Defines new record session. The value is record's command
> +	line without the 'record' keyword.
> +
> +Each perf record session is run in daemon.base/<NAME> directory.
> +
> +
> +EXAMPLES
> +--------
> +Example with 2 record sessions:
> +
> +  # cat ~/.perfconfig
> +  [daemon]
> +  base=/opt/perfdata
> +
> +  [session-cycles]
> +  run = -m 10M -e cycles --overwrite --switch-output -a
> +
> +  [session-sched]
> +  run = -m 20M -e sched:* --overwrite --switch-output -a
> +
> +
> +Starting the daemon:
> +
> +  # perf daemon start
> +
> +
> +Check sessions:
> +
> +  # perf daemon
> +  [603349:daemon] base: /opt/perfdata
> +  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
> +  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
> +
> +First line is daemon process info with configured daemon base.
> +
> +
> +Check sessions with more info:
> +
> +  # perf daemon -v
> +  [603349:daemon] base: /opt/perfdata
> +    output:  /opt/perfdata/output
> +    lock:    /opt/perfdata/lock
> +    up:      1 minutes
> +  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
> +    base:    /opt/perfdata/session-cycles
> +    output:  /opt/perfdata/session-cycles/output
> +    control: /opt/perfdata/session-cycles/control
> +    ack:     /opt/perfdata/session-cycles/ack
> +    up:      1 minutes
> +  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
> +    base:    /opt/perfdata/session-sched
> +    output:  /opt/perfdata/session-sched/output
> +    control: /opt/perfdata/session-sched/control
> +    ack:     /opt/perfdata/session-sched/ack
> +    up:      1 minutes
> +
> +The 'base' path is daemon/session base.
> +The 'lock' file is daemon's lock file guarding that no other
> +daemon is running on top of the base.
> +The 'output' file is perf record output for specific session.
> +The 'control' and 'ack' files are perf control files.
> +The 'up' number shows minutes daemon/session is running.
> +
> +
> +Make sure control session is online:
> +
> +  # perf daemon ping
> +  OK   cycles
> +  OK   sched
> +
> +
> +Send USR2 signal to session 'cycles' to generate perf.data file:
> +
> +  # perf daemon signal --session cycles
> +  signal 12 sent to session 'cycles [603452]'
> +
> +  # tail -2  /opt/perfdata/session-cycles/output
> +  [ perf record: dump data: Woken up 1 times ]
> +  [ perf record: Dump perf.data.2020123017013149 ]
> +
> +
> +Send USR2 signal to all sessions:
> +
> +  # perf daemon signal
> +  signal 12 sent to session 'cycles [603452]'
> +  signal 12 sent to session 'sched [603453]'
> +
> +  # tail -2  /opt/perfdata/session-cycles/output
> +  [ perf record: dump data: Woken up 1 times ]
> +  [ perf record: Dump perf.data.2020123017024689 ]
> +  # tail -2  /opt/perfdata/session-sched/output
> +  [ perf record: dump data: Woken up 1 times ]
> +  [ perf record: Dump perf.data.2020123017024713 ]
> +
> +
> +Stop daemon:
> +
> +  # perf daemon stop
> +
> +
> +SEE ALSO
> +--------
> +linkperf:perf-record[1], linkperf:perf-config[1]
> -- 
> 2.29.2
> 

-- 

- Arnaldo
