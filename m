Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CB3117B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBFAPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231784AbhBEM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612529815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AA91MnBgvlIxFiOcioYnxLC4QDcpL1Xixn6HBYTlWRY=;
        b=IohhLGYPNSC7/j/Vdb2rBoBhFcbYcyaGX4zrus2/zHjlpe9nAUHogUu94pgETV4pQ3ziYU
        obWcXJPDPyHwSUEZv8BY1AQ+WSngV0SLJgnxj7U6WMYnU3sYHmX43VBfYkW5ViMjIauDTh
        CslKCEwVsHc9/qUfFmOvENFLekRYZPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-jq0XsNbkPsu1wbQAvsuNQA-1; Fri, 05 Feb 2021 07:56:51 -0500
X-MC-Unique: jq0XsNbkPsu1wbQAvsuNQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47716192CC4F;
        Fri,  5 Feb 2021 12:56:48 +0000 (UTC)
Received: from krava (unknown [10.40.195.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id EC9685D9F8;
        Fri,  5 Feb 2021 12:56:42 +0000 (UTC)
Date:   Fri, 5 Feb 2021 13:56:42 +0100
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
Message-ID: <YB1AihrsetqhIYIc@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
 <CAM9d7cg6qEeq--PPxyC9Bq8VNw91O_M+PgnNQ-Sk7n_tKOE1yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg6qEeq--PPxyC9Bq8VNw91O_M+PgnNQ-Sk7n_tKOE1yg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 09:14:54PM +0900, Namhyung Kim wrote:
> On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> [SNIP]
> > @@ -263,9 +605,16 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> >         signal(SIGTERM, sig_handler);
> >
> >         while (!done && !err) {
> > -               if (fdarray__poll(&fda, -1)) {
> > +               err = daemon__reconfig(daemon);
> 
> I think it's confusing since you put the reconfig function here.
> What not split normal and reconfig passes?

hum, not sure what's confusing in here? I've been known to
produce confusing code, but this one seems clear to me

> 
> I mean something like below
> 
>  __cmd_start()
> {
>     setup_server_config();
>     daemon__run();

what's daemon__run? the daemon operates in the while loop below

> 
>     while (!done && !err) {
>         ...
>         if (reconfig) {
>             daemon__kill();

you don't kill daemon for each reconfig change,
we detect changed sessions and kill/restart only them

>             setup_server_config();
>             daemon__reconfig();
>         }
>     }


so basically the current workflow is:

	setup_server_config					<--- reads config file, prepares session objects

	while (!done) {
		daemon__reconfig				<--- check session objects states and run/stop them

		if (fdarray__poll(&fda, -1)) {

			handle_config_changes(&reconfig)	<--- was there a config file change?

			if (reconfig)				<--- yes,
				setup_server_config		<---      change session objects/states
		}
	}

thanks,
jirka

