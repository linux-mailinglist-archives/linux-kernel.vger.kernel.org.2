Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6292730FCF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhBDTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236783AbhBDOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61cY2haHQh/0KR2HuqkGx27VjalgwkcE6qYdpiegMPk=;
        b=Z7OlDOgvqlOnTEnuDh1PR062T9GvOKxUKvkx/eyW72KHrk1hesWU5nPmf6Cq1vfl97oVoT
        QKESMHCTlaT+xX/raQ37UkDz40zTkdBWewQKgrnGvZqSXRpM0zP29zYxsWmdNXE85zA/u+
        SEVxHzX9EiwGi7KDbiUC/QEksAMAQto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-C49vkJ2WOTaouGWEgscxKQ-1; Thu, 04 Feb 2021 09:50:28 -0500
X-MC-Unique: C49vkJ2WOTaouGWEgscxKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AC375B399;
        Thu,  4 Feb 2021 14:50:26 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 910EC19708;
        Thu,  4 Feb 2021 14:50:23 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:50:22 +0100
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
Subject: Re: [PATCH 05/24] perf daemon: Add client socket support
Message-ID: <YBwJriLJ2TPYBpcS@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-6-jolsa@kernel.org>
 <20210203210547.GR854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203210547.GR854763@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:05:47PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> 
> close fd
> 
> > +		return -1;
> > +	}
> > +
> > +	return fd;
> > +}
> > +
> >  static void daemon__free(struct daemon *daemon)
> >  {
> >  	free(daemon->config_real);
> > @@ -211,6 +282,40 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> >  	return err;
> >  }
> >  
> > +__maybe_unused
> > +static int send_cmd(struct daemon *daemon, union cmd *cmd)
> > +{
> > +	char *line = NULL;
> > +	size_t len = 0;
> > +	ssize_t nread;
> > +	FILE *in;
> > +	int fd;
> > +
> > +	if (setup_client_config(daemon))
> > +		return -1;
> > +
> > +	fd = setup_client_socket(daemon);
> > +	if (fd < 0)
> > +		return -1;
> > +
> > +	if (sizeof(*cmd) != write(fd, cmd, sizeof(*cmd)))
> 
> close fd
> 
> > +		return -1;
> > +
> > +	in = fdopen(fd, "r");
> > +	if (!in) {
> > +		perror("failed: fdopen");
> 
> close fd

ah right, thanks

jirka

> 
> > +		return -1;
> > +	}
> > +
> > +	while ((nread = getline(&line, &len, in)) != -1) {
> > +		fwrite(line, nread, 1, stdout);
> > +		fflush(stdout);
> > +	}
> > +
> > +	fclose(in);
> > +	return 0;
> > +}
> > +
> >  int cmd_daemon(int argc, const char **argv)
> >  {
> >  	struct option daemon_options[] = {
> > -- 
> > 2.29.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

