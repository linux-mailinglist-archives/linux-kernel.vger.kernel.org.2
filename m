Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA67F3098F0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhA3Xv2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:51:28 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:43881 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhA3XuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:22 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-vxHeuP0xM1Ox5VFFZlxQiA-1; Sat, 30 Jan 2021 18:49:03 -0500
X-MC-Unique: vxHeuP0xM1Ox5VFFZlxQiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E054F10054FF;
        Sat, 30 Jan 2021 23:49:00 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2855760DA0;
        Sat, 30 Jan 2021 23:48:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Subject: [PATCHv3 00/24] perf tools: Add daemon command
Date:   Sun, 31 Jan 2021 00:48:32 +0100
Message-Id: <20210130234856.271282-1-jolsa@kernel.org>
In-Reply-To: <20210129134855.195810-1-jolsa@redhat.com>
References: <20210129134855.195810-1-jolsa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
we were asked for possibility to be able run record
sessions on background.

This patchset adds support to configure and run record
sessions on background via new 'perf daemon' command.

Please check below the example on usage.

Available also here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/daemon

v3 changes:
  - several patches merged
  - add comments to daemon locking [Namhyung]
  - split patch 1 to multiple patches [Namhyung]
  - add missing allocation checks [Namhyung]
  - add comments for session state transitions [Namhyung]
  - add base directory check [Namhyung]
  - use ',' as default for -x option [Namhyung]
  - remove extra close before dup2 [Namhyung]
  - add new reconfig test for empty config
  - add --base option

v2 changes:
  - switch options to sub-commands [Namhyung]
  - use signalfd to track on sessions [Alexei]
  - use stop command to stop sessions [Alexei]
  - couple minor fixes [Alexei]
  - more detailed changelogs [Arnaldo]
  - added tests

thanks,
jirka


---
Jiri Olsa (24):
      perf daemon: Add daemon command
      perf daemon: Add config option
      perf daemon: Add base option
      perf daemon: Add server socket support
      perf daemon: Add client socket support
      perf daemon: Add config file support
      perf daemon: Add config file change check
      perf daemon: Add background support
      perf daemon: Add signalfd support
      perf daemon: Add list command
      perf daemon: Add signal command
      perf daemon: Add stop command
      perf daemon: Allow only one daemon over base directory
      perf daemon: Set control fifo for session
      perf daemon: Add ping command
      perf daemon: Use control to stop session
      perf daemon: Add up time for daemon/session list
      perf daemon: Add man page for perf-daemon
      perf tests: Add daemon list command test
      perf tests: Add daemon reconfig test
      perf tests: Add daemon stop command test
      perf tests: Add daemon signal command test
      perf tests: Add daemon ping command test
      perf tests: Add daemon lock test

 tools/perf/Build                         |    1 +
 tools/perf/Documentation/perf-config.txt |   14 ++
 tools/perf/Documentation/perf-daemon.txt |  187 +++++++++++++++++++++
 tools/perf/builtin-daemon.c              | 1448 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h                     |    1 +
 tools/perf/command-list.txt              |    1 +
 tools/perf/perf.c                        |    1 +
 tools/perf/tests/shell/daemon.sh         |  475 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 2128 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/builtin-daemon.c
 create mode 100755 tools/perf/tests/shell/daemon.sh


---
Example with 2 record sessions:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

  [session-sched]
  run = -m 20M -e sched:* --overwrite --switch-output -a


Starting the daemon:

  # perf daemon start


Check sessions:

  # perf daemon
  [603349:daemon] base: /opt/perfdata
  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a

First line is daemon process info with configured daemon base.


Check sessions with more info:

  # perf daemon -v
  [603349:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
    up:      1 minutes
  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
    control: /opt/perfdata/session-cycles/control
    ack:     /opt/perfdata/session-cycles/ack
    up:      1 minutes
  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output
    control: /opt/perfdata/session-sched/control
    ack:     /opt/perfdata/session-sched/ack
    up:      1 minutes

The 'base' path is daemon/session base.
The 'lock' file is daemon's lock file guarding that no other
daemon is running on top of the base.
The 'output' file is perf record output for specific session.
The 'control' and 'ack' files are perf control files.
The 'up' number shows minutes daemon/session is running.


Make sure control session is online:

  # perf daemon ping
  OK   cycles
  OK   sched


Send USR2 signal to session 'cycles' to generate perf.data file:

  # perf daemon signal --session cycles
  signal 12 sent to session 'cycles [603452]'

  # tail -2  /opt/perfdata/session-cycles/output
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020123017013149 ]


Send USR2 signal to all sessions:

  # perf daemon signal
  signal 12 sent to session 'cycles [603452]'
  signal 12 sent to session 'sched [603453]'

  # tail -2  /opt/perfdata/session-cycles/output
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020123017024689 ]
  # tail -2  /opt/perfdata/session-sched/output
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020123017024713 ]


Stop daemon:

  # perf daemon stop

