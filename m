Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5995B3648E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhDSRPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233867AbhDSRPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:15:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA7160FEA;
        Mon, 19 Apr 2021 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618852474;
        bh=XD78cwDu2a8BJ4X/XEEZNa8qb0b06ha1xoejm1Y+pP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgOCAAZAepUrogygaCfzNXIHujRRBhWbBzbRudqp0jiX9MDfQFhkk0ClqCZXULesl
         4XGlXztDma+C+BVds8yqjtC6W0lfE31JKQ6IDBZpocobw9C+m2VxK0vWDSj2JHfHD1
         3N9lyVQ9Yyfs/tDQ65QjKTp1atNL+iGE7/PpElWWlWofW3KSbWb3clEnSiNnhS3df+
         hSHUy2xEnuRctIo0M7TNcWamSAinbLb3gwuRz1bGW/T7aHviQbTrjto00E5dd1S1Ug
         IuBvWjlaZRIJLdulSWn6T7Li3pYVdW7N3YcYLrhohQW68uG4I8Ac8+OaEiu9PjIX9e
         NTWJ2yh1rfWeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D129540647; Mon, 19 Apr 2021 14:14:31 -0300 (-03)
Date:   Mon, 19 Apr 2021 14:14:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf data: Fix error return code in
 perf_data__create_dir()
Message-ID: <YH26d0r10woPIoFB@kernel.org>
References: <20210415083417.3740-1-thunder.leizhen@huawei.com>
 <YHglwGXW7IV4W6qV@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHglwGXW7IV4W6qV@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 01:38:40PM +0200, Jiri Olsa escreveu:
> On Thu, Apr 15, 2021 at 04:34:16PM +0800, Zhen Lei wrote:
> > Although 'ret' has been initialized to -1, but it will be reassigned by
> > the "ret = open(...)" statement in the for loop. So that, the value of
> > 'ret' is unknown when asprintf() failed.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/data.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index f29af4fc3d09390..8fca4779ae6a8e9 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -35,7 +35,7 @@ void perf_data__close_dir(struct perf_data *data)
> >  int perf_data__create_dir(struct perf_data *data, int nr)
> >  {
> >  	struct perf_data_file *files = NULL;
> > -	int i, ret = -1;
> > +	int i, ret;
> >  
> >  	if (WARN_ON(!data->is_dir))
> >  		return -EINVAL;
> > @@ -51,7 +51,8 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> >  	for (i = 0; i < nr; i++) {
> >  		struct perf_data_file *file = &files[i];
> >  
> > -		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
> > +		ret = asprintf(&file->path, "%s/data.%d", data->path, i);
> > +		if (ret < 0)
> >  			goto out_err;
> >  
> >  		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> > -- 
> > 2.26.0.106.g9fadedd
> > 
> > 
> 

-- 

- Arnaldo
