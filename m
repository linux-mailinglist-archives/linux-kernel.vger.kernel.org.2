Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB6C30F5E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhBDPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237155AbhBDPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612451194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nN/FJ7/vfiKKu0V0ZsPlNW24BqROSQkdzOLQ5ffuIwM=;
        b=UENhhiQCKDg0gyMW2Mjgt+eHpnb/HapNvxOZmLUjupMYk+lnAoeERNUND72oiIOWrrvx8W
        ytZNgZO65DUJYAL7ZNdDDrNId0RX12pxOKGKkEHaIhZRXJxYjy4Q/9xHgDYg5BD0yqe0Ps
        1J2os5BMfWL+bhcGEl5OEFWtt1nqFdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-rTIVjuKkOb6uvmKjfm8srA-1; Thu, 04 Feb 2021 10:06:32 -0500
X-MC-Unique: rTIVjuKkOb6uvmKjfm8srA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8059A1014E77;
        Thu,  4 Feb 2021 15:06:30 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id D89E9100F494;
        Thu,  4 Feb 2021 15:06:27 +0000 (UTC)
Date:   Thu, 4 Feb 2021 16:06:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexei Budankov <abudankov@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 09/24] perf daemon: Add signalfd support
Message-ID: <YBwNc/0H8/J6v77c@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-10-jolsa@kernel.org>
 <20210203212409.GW854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203212409.GW854763@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:24:09PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > @@ -351,6 +355,103 @@ static int session__run(struct session *session, struct daemon *daemon)
> >  	return -1;
> >  }
> >  
> > +static pid_t handle_signalfd(struct daemon *daemon)
> > +{
> > +	struct signalfd_siginfo si;
> > +	struct session *session;
> > +	ssize_t err;
> > +	int status;
> > +	pid_t pid;
> > +
> > +	err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));
> 
> 
> I saw these and recalled we have a readn() function, shouldn't we be
> usint it in this series?

right, but the read call in here needs to succeed with the data
size otherwise it's an error

but perhaps we could use it later for the control descriptor
read/write, I'll check

> 
> Its even in tools/lib/perf/lib.c
> 
> > +	if (err != sizeof(struct signalfd_siginfo))
> > +		return -1;
> > +
> > +	list_for_each_entry(session, &daemon->sessions, list) {
> > +
> > +		if (session->pid != (int) si.ssi_pid)
> > +			continue;
> > +
> > +		pid = waitpid(session->pid, &status, 0);
> > +		if (pid == session->pid) {
> > +			if (WIFEXITED(status)) {
> > +				pr_info("session '%s' exited, status=%d\n",
> > +					session->name, WEXITSTATUS(status));
> > +			} else if (WIFSIGNALED(status)) {
> > +				pr_info("session '%s' killed (signal %d)\n",
> > +					session->name, WTERMSIG(status));
> > +			} else if (WIFSTOPPED(status)) {
> > +				pr_info("session '%s' stopped (signal %d)\n",
> > +					session->name, WSTOPSIG(status));
> > +			} else {
> > +				pr_info("session '%s' Unexpected status (0x%x)\n",
> > +					session->name, status);
> > +			}
> > +		}
> > +
> > +		session->state = SESSION_STATE__KILL;
> > +		session->pid = -1;
> > +		return pid;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int session__wait(struct session *session, struct daemon *daemon, int secs)
> > +{
> > +	struct pollfd pollfd = {
> > +		.fd	= daemon->signal_fd,
> > +		.events	= POLLIN,
> > +	};
> > +	pid_t wpid = 0, pid = session->pid;
> > +	time_t start;
> > +
> > +	start = time(NULL);
> 
> 
> 	time_t start = time(NULL);
> > +
> > +	do {
> > +		if (poll(&pollfd, 1, 1000))
> > +			wpid = handle_signalfd(daemon);
> 
> Shouldn't we check for -1 and handle that differently?

ah right, check for error, will add

> 
> > +
> > +		if (start + secs < time(NULL))
> > +			return -1;
> > +	} while (wpid != pid);
> > +
> > +	return 0;
> > +}
> > +
> > +static bool daemon__has_alive_session(struct daemon *daemon)
> > +{
> > +	struct session *session;
> > +
> > +	list_for_each_entry(session, &daemon->sessions, list) {
> > +		if (session->pid != -1)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static int daemon__wait(struct daemon *daemon, int secs)
> > +{
> > +	struct pollfd pollfd = {
> > +		.fd	= daemon->signal_fd,
> > +		.events	= POLLIN,
> > +	};
> > +	time_t start;
> > +
> > +	start = time(NULL);
> > +
> > +	do {
> > +		if (poll(&pollfd, 1, 1000))
> > +			handle_signalfd(daemon);
> 
> ditto

ok

thanks,
jirka

