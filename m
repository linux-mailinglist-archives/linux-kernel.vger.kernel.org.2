Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E2319133
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhBKRgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:36:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbhBKQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613061314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZT/hCsSo2CNy9Zz0Zab1ekjR8V8muOEoOgltSUxz/UM=;
        b=gR/4/IveV73eOppYXY9bQwQXKY/36YMQxeFiPCmkVXrc/zXBiZofhVuANyZzBXzzHmsdcN
        BJpMKmaLxAalAd+W8gmupQpCud2YLYar8YOvfXC64SVs09zNpiZRQcn8PvN/4YE/Oa4tIm
        Vib/UfksSu5ftb0Eh90DWhY9fhaYjHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-9My_2YR8OvaYi6T5W98EJA-1; Thu, 11 Feb 2021 11:35:10 -0500
X-MC-Unique: 9My_2YR8OvaYi6T5W98EJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 972C9803F48;
        Thu, 11 Feb 2021 16:35:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with SMTP id 04F4E10016F4;
        Thu, 11 Feb 2021 16:35:04 +0000 (UTC)
Date:   Thu, 11 Feb 2021 17:35:04 +0100
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
Subject: Re: [PATCH 05/24] perf daemon: Add client socket support
Message-ID: <YCVcuD+1Y478xVwi@krava>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-6-jolsa@kernel.org>
 <20210211125205.GA1131885@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211125205.GA1131885@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 09:52:05AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 09:08:49PM +0100, Jiri Olsa escreveu:
> > +__maybe_unused
> > +static int send_cmd(struct daemon *daemon, union cmd *cmd)
> > +{
> > +	int ret = -1, fd;
> > +	char *line = NULL;
> > +	size_t len = 0;
> > +	ssize_t nread;
> > +	FILE *in = NULL;
> > +
> > +	if (setup_client_config(daemon))
> > +		return -1;
> > +
> > +	fd = setup_client_socket(daemon);
> > +	if (fd < 0)
> > +		return -1;
> > +
> > +	if (sizeof(*cmd) != writen(fd, cmd, sizeof(*cmd))) {
> > +		perror("failed: write");
> > +		goto out;
> > +	}
> > +
> > +	in = fdopen(fd, "r");
> > +	if (!in) {
> > +		perror("failed: fdopen");
> > +		goto out;
> > +	}
> > +
> > +	while ((nread = getline(&line, &len, in)) != -1) {
> > +		fwrite(line, nread, 1, stdout);
> > +		fflush(stdout);
> > +	}
> > +
> > +	ret = 0;
> > +	fclose(in);
> > +out:
> > +	/* If in is defined, then fd is closed via fclose. */
> > +	if (!in)
> > +		close(fd);
> > +	return ret;
> > +}
> > +
> 
> So I had to add the patch below to deal with this in some systems:
> 
>   cc1: warnings being treated as errors
>   builtin-daemon.c: In function 'send_cmd':  MKDIR    /tmp/build/perf/bench/
>   
>   builtin-daemon.c:1368: error: ignoring return value of 'fwrite', declared with attribute warn_unused_result
>     MKDIR    /tmp/build/perf/tests/
>   make[3]: *** [/tmp/build/perf/builtin-daemon.o] Error 1
> 
> And also to not leak the 'line' buffer allocated by getline(), since you
> initialized line to NULL and len to zero, man page says:
> 
> 	 If *lineptr is set to NULL and *n is set 0 before the call,
> 	 then getline() will allocate a buffer for storing the line.
> 	 This buffer should be freed by the user program even if
> 	 getline() failed.
> 
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index e0880c5ee39c89bd..0a282c4e23a9fd9a 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -344,12 +344,15 @@ static int send_cmd(struct daemon *daemon, union cmd *cmd)
>  	}
>  
>  	while ((nread = getline(&line, &len, in)) != -1) {
> -		fwrite(line, nread, 1, stdout);
> +		if (fwrite(line, nread, 1, stdout) != 1)
> +			goto out_fclose;
>  		fflush(stdout);
>  	}
>  
>  	ret = 0;
> +out_fclose:
>  	fclose(in);
> +	free(line);
>  out:
>  	/* If in is defined, then fd is closed via fclose. */
>  	if (!in)
> 

ok, thanks

jirka

