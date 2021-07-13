Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33B3C7544
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhGMQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:53:00 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:54084 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231651AbhGMQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:52:59 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7E5C018283013;
        Tue, 13 Jul 2021 16:50:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 3E288C4198;
        Tue, 13 Jul 2021 16:49:55 +0000 (UTC)
Message-ID: <bf25e7b270fb247475254254fece22cf6abbd0ef.camel@perches.com>
Subject: Re: [PATCH v33 13/13] MAINTAINERS: Update for DAMON
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Jul 2021 09:49:53 -0700
In-Reply-To: <20210713123356.6924-14-sj38.park@gmail.com>
References: <20210713123356.6924-1-sj38.park@gmail.com>
         <20210713123356.6924-14-sj38.park@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3E288C4198
X-Spam-Status: No, score=-1.21
X-Stat-Signature: m1hg9osk3yog6buqp66cwwxmd5bntbpx
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19uh9H0cVpDv7YV+HEpen90R6heGT0nwvg=
X-HE-Tag: 1626194995-818137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-13 at 12:33 +0000, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit updates MAINTAINERS file for DAMON related files.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Markus Boehme <markubo@amazon.de>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a61f4f3b78a9..d492ae8b77de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5114,6 +5114,18 @@ F:	net/ax25/ax25_out.c
>  F:	net/ax25/ax25_timer.c
>  F:	net/ax25/sysctl_net_ax25.c
>  
> 
> +DATA ACCESS MONITOR
> +M:	SeongJae Park <sjpark@amazon.de>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	Documentation/admin-guide/mm/damon/*
> +F:	Documentation/vm/damon/*
> +F:	include/linux/damon.h
> +F:	include/trace/events/damon.h
> +F:	mm/damon/*
> +F:	tools/damon/*
> +F:	tools/testing/selftests/damon/*

Using "F:	<path>/*" means that you are maintaining only
files in that specific path and not any subdirectory of that path.

Are there subdirectories in these uses of <path>/*
that you are avoiding?

If not, the proper use is just a trailing forward slash like

F:	<path>/

I believe this should be:

DATA ACCESS MONITOR
M:	SeongJae Park <sjpark@amazon.de>
L:	linux-mm@kvack.org
S:	Maintained
F:	Documentation/admin-guide/mm/damon/
F:	Documentation/vm/damon/
F:	include/linux/damon.h
F:	include/trace/events/damon.h
F:	mm/damon/
F:	tools/damon/
F:	tools/testing/selftests/damon/


