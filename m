Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DDF349288
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCYM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhCYM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:58:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82F216197C;
        Thu, 25 Mar 2021 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616677134;
        bh=3LrsipEpAqwg1GZXXdVTghzJH5OWtIGQ2aYlktyB+F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtFvpmlJYF0SEOYsrVbdALV9W6wkiLxZCriqGiaQBoOJLVR2QL2GjfhNftlOn2BNW
         gb2j1gH2/pKjcqaGZIkI9A8SxSiXIP3DhztULeYvXEfK8rJ7UKl4HXwj3XFg7Ccqp7
         eeyq7JdOvbekOArNhvGSHy3n8T7mlKfS+hw+zRbEs9uGhJxsP5x13AxKxSiyqxsn4Z
         IuAfY2SYm7+PDR/zAJEKXrdypE4RSWpsmHCWMXAsLLVb0sid4Vno9gdknTN7jGCyDs
         4mV+TX4EpAuPF9hJ4BYIvYqr/ZDKE9eJCpF+20PeND0rbY99d58WF0q5uPFMktwcft
         PxCOM+YEJe5UQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89D01406FA; Thu, 25 Mar 2021 09:58:52 -0300 (-03)
Date:   Thu, 25 Mar 2021 09:58:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] tools: perf: Remove duplicate includes
Message-ID: <YFyJDCk/S+el4SDi@kernel.org>
References: <20210323050139.287461-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323050139.287461-1-wanjiabing@vivo.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 23, 2021 at 01:01:39PM +0800, Wan Jiabing escreveu:
> sys/stat.h has been included at line 23, so remove the
> duplicate one at line 27.
> linux/string.h has been included at line 7, so remove the
> duplicate one at line 9.
> time.h has been included at line 14, so remove the
> duplicate one at line 28.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/perf/builtin-daemon.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index ace8772a4f03..632ecd010a4f 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -6,7 +6,6 @@
>  #include <linux/zalloc.h>
>  #include <linux/string.h>
>  #include <linux/limits.h>
> -#include <linux/string.h>
>  #include <string.h>
>  #include <sys/file.h>
>  #include <signal.h>
> @@ -24,8 +23,6 @@
>  #include <sys/signalfd.h>
>  #include <sys/wait.h>
>  #include <poll.h>
> -#include <sys/stat.h>
> -#include <time.h>
>  #include "builtin.h"
>  #include "perf.h"
>  #include "debug.h"
> -- 
> 2.25.1
> 

-- 

- Arnaldo
