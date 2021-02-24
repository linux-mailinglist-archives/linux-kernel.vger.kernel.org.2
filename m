Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86461323B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhBXLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235033AbhBXLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614164879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwikFej3RL0CZJY9+yS7Zo6x46gCYURZjb6JZAuGJg8=;
        b=KqvKs9d0hXSeVpQpvAtmckLTmzpUGY6HA/nFSDvp7rQwCr06fd/kgTBJEk+EaDdcJQLzhV
        Tb7GlVhIb5nqbl4Zcmiwh0qQ2H3tBAZVGLG2AxKvhLzyCtYHJJ6kqTUtCPsrwzNu2s4Nbp
        llPQp25E+gg7MCD/DvPRVnXPcKu4WIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-7ejCefaZP3OCLK8P1waffA-1; Wed, 24 Feb 2021 06:06:51 -0500
X-MC-Unique: 7ejCefaZP3OCLK8P1waffA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F98C801978;
        Wed, 24 Feb 2021 11:06:49 +0000 (UTC)
Received: from krava (unknown [10.40.193.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5044860C5F;
        Wed, 24 Feb 2021 11:06:47 +0000 (UTC)
Date:   Wed, 24 Feb 2021 12:06:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf daemon: Fix compile error with Asan
Message-ID: <YDYzRoig7zUWAVZM@krava>
References: <20210224071438.686677-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210224071438.686677-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:14:38PM +0900, Namhyung Kim wrote:
> I'm seeing a build failure when build with address sanitizer.
> It seems we could write to the name[100] if the var is longer.
> 
>   $ make EXTRA_CFLAGS=-fsanitize=address
>   ...
>     CC       builtin-daemon.o
>   In function ‘get_session_name’,
>     inlined from ‘session_config’ at builtin-daemon.c:164:6,
>     inlined from ‘server_config’ at builtin-daemon.c:223:10:
>   builtin-daemon.c:155:11: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
>     155 |  *session = 0;
>         |  ~~~~~~~~~^~~
>   builtin-daemon.c: In function ‘server_config’:
>   builtin-daemon.c:162:7: note: at offset 100 to object ‘name’ with size 100 declared here
>     162 |  char name[100];
>         |       ^~~~
> 
> Fixes: c0666261ff38 ("perf daemon: Add config file support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 617feaf020f6..8f9fc61691da 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -161,7 +161,7 @@ static int session_config(struct daemon *daemon, const char *var, const char *va
>  	struct daemon_session *session;
>  	char name[100];
>  
> -	if (get_session_name(var, name, sizeof(name)))
> +	if (get_session_name(var, name, sizeof(name) - 1))
>  		return -EINVAL;
>  
>  	var = strchr(var, '.');
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 

