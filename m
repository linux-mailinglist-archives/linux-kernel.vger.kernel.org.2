Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EC3256E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhBYTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234220AbhBYTh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614281759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mfUJf/iB9lMsr6TyPZwSuzA3Biu76FS2X7sZp1siFc=;
        b=c1nwszKd9zFGvKXxvbnl3APyaKeyOrkxIvWa1yQqUCEHQl+OSmkigUGUCZapHyqiWoy8m5
        e0+nCDOfHD3vP1KJNG788MiCbjnxVSRXdP42HBLqb6WwMhJgXBJduWHs61sk2UMDjijyxI
        267Vt4TAa86OoWuFAdEHi41reF0/lb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-i2vZoR94O6iHeh_beZGgdw-1; Thu, 25 Feb 2021 14:35:56 -0500
X-MC-Unique: i2vZoR94O6iHeh_beZGgdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766CB835E22;
        Thu, 25 Feb 2021 19:35:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id 968375C234;
        Thu, 25 Feb 2021 19:35:54 +0000 (UTC)
Date:   Thu, 25 Feb 2021 20:35:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: perf test for daemon
Message-ID: <YDf8GYWlEhYqGkXv@krava>
References: <20210219194619.1780437-1-acme@kernel.org>
 <e368e5d0-0005-0b67-aaeb-042eef9c24be@huawei.com>
 <YDf2wUG9JiXKEzL9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDf2wUG9JiXKEzL9@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:13:07PM +0100, Jiri Olsa wrote:
> On Thu, Feb 25, 2021 at 06:39:22PM +0000, John Garry wrote:
> > 
> > Hi,
> > 
> > I notice that "perf test" when run without root priviledges now hangs at the
> > daemon test - is this expected behaviour? Can we skip and warn the user
> > instead?
> > 
> > I'm checking acme perf/core today.
> 
> ugh, I'll check.. looks like control fifo files are created with wrong permissions

could you please try the fix below? it's passing with non-root user for me

thanks,
jirka


---
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 617feaf020f6..8f0ed2e59280 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -373,12 +373,12 @@ static int daemon_session__run(struct daemon_session *session,
 	dup2(fd, 2);
 	close(fd);
 
-	if (mkfifo(SESSION_CONTROL, O_RDWR) && errno != EEXIST) {
+	if (mkfifo(SESSION_CONTROL, 0600) && errno != EEXIST) {
 		perror("failed: create control fifo");
 		return -1;
 	}
 
-	if (mkfifo(SESSION_ACK, O_RDWR) && errno != EEXIST) {
+	if (mkfifo(SESSION_ACK, 0600) && errno != EEXIST) {
 		perror("failed: create ack fifo");
 		return -1;
 	}
diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index e5b824dd08d9..5ad3ca8d681b 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -140,10 +140,10 @@ test_list()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -159,14 +159,14 @@ EOF
 	# check 1st session
 	# pid:size:-e cpu-clock:base/size:base/size/output:base/size/control:base/size/ack:0
 	local line=`perf daemon --config ${config} -x: | head -2 | tail -1`
-	check_line_other "${line}" size "-e cpu-clock" ${base}/session-size \
+	check_line_other "${line}" size "-e cpu-clock -m 1 sleep 10" ${base}/session-size \
 			 ${base}/session-size/output ${base}/session-size/control \
 			 ${base}/session-size/ack "0"
 
 	# check 2nd session
 	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
 	local line=`perf daemon --config ${config} -x: | head -3 | tail -1`
-	check_line_other "${line}" time "-e task-clock" ${base}/session-time \
+	check_line_other "${line}" time "-e task-clock -m 1 sleep 10" ${base}/session-time \
 			 ${base}/session-time/output ${base}/session-time/control \
 			 ${base}/session-time/ack "0"
 
@@ -190,10 +190,10 @@ test_reconfig()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -204,7 +204,7 @@ EOF
 	# check 2nd session
 	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
 	local line=`perf daemon --config ${config} -x: | head -3 | tail -1`
-	check_line_other "${line}" time "-e task-clock" ${base}/session-time \
+	check_line_other "${line}" time "-e task-clock -m 1 sleep 10" ${base}/session-time \
 			 ${base}/session-time/output ${base}/session-time/control ${base}/session-time/ack "0"
 	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
 
@@ -215,10 +215,10 @@ EOF
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 EOF
 
 	# TEST 1 - change config
@@ -238,7 +238,7 @@ EOF
 	# check reconfigured 2nd session
 	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
 	local line=`perf daemon --config ${config} -x: | head -3 | tail -1`
-	check_line_other "${line}" time "-e cpu-clock" ${base}/session-time \
+	check_line_other "${line}" time "-e cpu-clock -m 1 sleep 10" ${base}/session-time \
 			 ${base}/session-time/output ${base}/session-time/control ${base}/session-time/ack "0"
 
 	# TEST 2 - empty config
@@ -309,10 +309,10 @@ test_stop()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -361,7 +361,7 @@ test_signal()
 base=BASE
 
 [session-test]
-run = -e cpu-clock --switch-output
+run = -e cpu-clock --switch-output -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -400,10 +400,10 @@ test_ping()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -439,7 +439,7 @@ test_lock()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}

