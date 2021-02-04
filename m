Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57F430FCD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhBDTa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236945AbhBDOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAESHwW0WdZS/OpPzSsfCxam/5nXUCVRWHrWA65Cmj0=;
        b=bL9Azq2HJHfhyV2q98GSbHLzRJnTEA3Slp+6tjYLJMzyl0NXkJKq1oEmDW/i1LrdpR2xVW
        6ed4pYvzaET5NE4Doxw5ow3qWUqkVRHIHsB/L7p3Ai9XRoa0QfvnVvlqm5/m6HrqMwpuz6
        Kr/aems5TEX+3reMVkYzOE74t2FQuSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-EBK9w85QO6SBYoI8R0sZ5Q-1; Thu, 04 Feb 2021 09:52:31 -0500
X-MC-Unique: EBK9w85QO6SBYoI8R0sZ5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41653100C615;
        Thu,  4 Feb 2021 14:52:29 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD78C19708;
        Thu,  4 Feb 2021 14:52:26 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:52:25 +0100
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
Subject: Re: [PATCH 08/24] perf daemon: Add background support
Message-ID: <YBwKKVRN1M8glFyN@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-9-jolsa@kernel.org>
 <20210203211611.GU854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203211611.GU854763@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:16:11PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 31, 2021 at 12:48:40AM +0100, Jiri Olsa escreveu:
> > Adding support to put daemon process in the background.
> > 
> > It's now enabled by default and -f option is added to
> > keep daemon process on the console for debugging.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-daemon.c | 66 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 63 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index d0a0a998e073..324666058842 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -488,6 +488,13 @@ static void daemon__kill(struct daemon *daemon)
> >  	daemon__signal(daemon, SIGTERM);
> >  }
> >  
> > +static void __daemon__free(struct daemon *daemon)
> > +{
> > +	free(daemon->config_real);
> > +	free(daemon->config_base);
> > +	free(daemon->base);
> > +}
> 
> Please use zfree(), and also please rename it to __daemon__delete(), in
> other cases this pattern would be daemon__exit(), as the daemon
> structure itself is not being freed, just its members, ditto for
> foo__new() calling foo__init().

ok, will change

SNIP

> >  static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> >  		       int argc, const char **argv)
> >  {
> > +	bool foreground = false;
> >  	struct option start_options[] = {
> > +		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
> 
> 
> You forgot to add the entry to the man page

it's in the man page patch later in the patchset

thanks,
jirka

> 
> >  		OPT_PARENT(parent_options),
> >  		OPT_END()
> >  	};
> > @@ -667,6 +716,17 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> >  	if (setup_server_config(daemon))
> >  		return -1;
> >  
> > +	if (!foreground) {
> > +		err = go_background(daemon);
> > +		if (err) {
> > +			/* original process, exit normally */
> > +			if (err == 1)
> > +				err = 0;
> > +			__daemon__free(daemon);
> > +			return err;
> > +		}
> > +	}
> > +
> >  	debug_set_file(daemon->out);
> >  	debug_set_display_time(true);
> >  
> > -- 
> > 2.29.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

