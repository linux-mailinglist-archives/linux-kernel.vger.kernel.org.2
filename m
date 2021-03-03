Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3564932C021
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386511AbhCCSQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhCCP4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:56:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4268C6023B;
        Wed,  3 Mar 2021 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786900;
        bh=UD3MGFn8SFT+0qrE7Lv5zjFQiwFVoZG5Ri611hrF1/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBI2GF4LfydKroGTcoASx3AAwunlGzRkyjhSNdEk2zcAjRMFiGKJDZBfW9KzWICSB
         p+9QcmaXKIc9CDJ44Bgje7HSp03YJ5wi348ZQTybQo4wreZH7HYJMURlOj4yuHhFUb
         P2XnCCbRCnu8odZ6pCWNnLv307LxltYm27IugNd5tItw+MaPWf42Ng59o/5jStYbCV
         JZP6vijzoAvNR1V6kdDrydvD0s7lYn69WGEuo8muD9KxWjRQRlGvbQcPOunuH4DD5W
         wxnaep49/ShBkoZtZbSo+qRrBFcns+xeUQIUgn5TapkILsMQECtJllusRv3ZqCuxZJ
         IxXqC2iV3+QFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4D8440CD9; Wed,  3 Mar 2021 12:54:56 -0300 (-03)
Date:   Wed, 3 Mar 2021 12:54:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf daemon: Fix compile error with Asan
Message-ID: <YD+xUIkuoEcDkElI@kernel.org>
References: <20210224071438.686677-1-namhyung@kernel.org>
 <YDYzRoig7zUWAVZM@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDYzRoig7zUWAVZM@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 24, 2021 at 12:06:46PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 24, 2021 at 04:14:38PM +0900, Namhyung Kim wrote:
> > I'm seeing a build failure when build with address sanitizer.
> > It seems we could write to the name[100] if the var is longer.
> > 
> >   $ make EXTRA_CFLAGS=-fsanitize=address
> >   ...
> >     CC       builtin-daemon.o
> >   In function ‘get_session_name’,
> >     inlined from ‘session_config’ at builtin-daemon.c:164:6,
> >     inlined from ‘server_config’ at builtin-daemon.c:223:10:
> >   builtin-daemon.c:155:11: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
> >     155 |  *session = 0;
> >         |  ~~~~~~~~~^~~
> >   builtin-daemon.c: In function ‘server_config’:
> >   builtin-daemon.c:162:7: note: at offset 100 to object ‘name’ with size 100 declared here
> >     162 |  char name[100];
> >         |       ^~~~
> > 
> > Fixes: c0666261ff38 ("perf daemon: Add config file support")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-daemon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index 617feaf020f6..8f9fc61691da 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -161,7 +161,7 @@ static int session_config(struct daemon *daemon, const char *var, const char *va
> >  	struct daemon_session *session;
> >  	char name[100];
> >  
> > -	if (get_session_name(var, name, sizeof(name)))
> > +	if (get_session_name(var, name, sizeof(name) - 1))
> >  		return -EINVAL;
> >  
> >  	var = strchr(var, '.');
> > -- 
> > 2.30.0.617.g56c4b15f3c-goog
> > 
> 

-- 

- Arnaldo
