Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585EE38DBBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhEWP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 11:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231789AbhEWP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 11:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621785497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwQGgcSmB7dG/47GYIT4VaAOEmDWh3RBmeIzEPIXRbU=;
        b=aC4dEqPj0x7Dv9ailkuT95kZkLFHnH/3n3auKSDQGrPppz67qXSTYQr3WBAlPPcJa64YKj
        Jfxq2jdm8CfmxeEh4tf2y5tHgTH6NNwGiMIxOSfWFWTJ3xiXJS6T441UX5eIo5dSS61sTv
        YtPCWFdF+kj+DgNDE6yiwrHa9FhD6xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-uI7KKo-9OsOViaBlYXoOFA-1; Sun, 23 May 2021 11:58:15 -0400
X-MC-Unique: uI7KKo-9OsOViaBlYXoOFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8BD501E0;
        Sun, 23 May 2021 15:58:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id D97D910074E0;
        Sun, 23 May 2021 15:58:11 +0000 (UTC)
Date:   Sun, 23 May 2021 17:58:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v6 2/3] perf tests: avoid storing an absolute path in
 perf binary
Message-ID: <YKp7km95KCUhykig@krava>
References: <20210521172753.55399-1-dzagorui@cisco.com>
 <20210521172753.55399-2-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521172753.55399-2-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:27:52AM -0700, Denys Zagorui wrote:

SNIP

>  	free(cmd);
> +out:
> +	free(pythonpath);
>  	return ret;
>  }
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 3bba74e431ed..53f3dbf02f58 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -22,6 +22,7 @@
>  #include "cap.h"
>  #include "strlist.h"
>  #include "string2.h"
> +#include <libgen.h>
>  
>  /*
>   * XXX We need to find a better place for these things...
> @@ -388,3 +389,14 @@ char *perf_exe(char *buf, int len)
>  	}
>  	return strcpy(buf, "perf");
>  }
> +
> +char *perf_exe_path(void)
> +{
> +	char buf[PATH_MAX];
> +	char *dname;
> +
> +	perf_exe(buf, PATH_MAX);
> +	dname = dirname(buf);

I think this is equally bad.. once you get out of perf_exe_path,
dname might be screwed

> +
> +	return dname;

just return strdup(dname) in here?

jirka

