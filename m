Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE36B31C981
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhBPLPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:15:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhBPLPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613474014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StUGz/4UtDVkUfOUmYPH0sVJfgkVqzYBCdEf0FlM4KI=;
        b=IjLp5DjNHxGgZStIYePAO+pyLt9hd+YhCynekHkYbBtFSBCQ9jHajDW+euAm36FoUkcgkk
        4EcvbPL9HwqwXlO3Jxz9MHF361lbVVzZ/zFNwUFHHzpp9Rm2bqk99ezbY4fpwo86Tm7k6C
        OYAGArecZkDVgfgHyNWpUkQIkUhQsSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-lc2zrWgBNW6nxh8a7eDgQg-1; Tue, 16 Feb 2021 06:13:31 -0500
X-MC-Unique: lc2zrWgBNW6nxh8a7eDgQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B635B801975;
        Tue, 16 Feb 2021 11:13:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 140CB1970A;
        Tue, 16 Feb 2021 11:13:24 +0000 (UTC)
Date:   Tue, 16 Feb 2021 12:13:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] perf tools: Add lexical definition of event name
Message-ID: <YCuo01Wxxe/MCrC5@krava>
References: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
 <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com>
 <YCpqVuneU+wWtmMC@krava>
 <CAM9d7cg7Znpwo8RKAibkmuMVoinGFa9C4WGJsUnfb728wdG-Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg7Znpwo8RKAibkmuMVoinGFa9C4WGJsUnfb728wdG-Ag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 05:23:18PM +0900, Namhyung Kim wrote:
> On Mon, Feb 15, 2021 at 9:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Feb 12, 2021 at 06:03:17PM +0900, Shunsuke Nakamura wrote:
> > > Add the lexical definition of event name so that the numbers are recognizable.
> > >
> > > A64FX defines an event name that starts with a number.
> > >  - 0inst_commit
> > >  - 1inst_commit
> > >  - 2inst_commit
> > >  - 3inst_commit
> > >  - 4inst_commit
> > >
> > > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > > ---
> > >  tools/perf/util/parse-events.l | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > > index 0b36285a9435..33f627187415 100644
> > > --- a/tools/perf/util/parse-events.l
> > > +++ b/tools/perf/util/parse-events.l
> > > @@ -205,7 +205,7 @@ bpf_source        [^,{}]+\.c[a-zA-Z0-9._]*
> > >  num_dec              [0-9]+
> > >  num_hex              0x[a-fA-F0-9]+
> > >  num_raw_hex  [a-fA-F0-9]+
> > > -name         [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
> > > +name         [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]]*
> >
> > I can't see anything broken because of this change,
> > also numbers are defined few lines before so we should
> > be fine
> 
> But this change makes the syntax ambiguous with numbers
> and names. I don't think it's a good idea.

I'll check again, but we already have hex numbers above
which could easily clash, but the syntax context makes
this work.. tests should help to clear this up

> 
> Is it possible to change the event names not having numbers
> at the beginning like inst_commit0, inst_commit1 and so on?

that'd be of course much better

thanks,
jirka

> 
> Thanks,
> Namhyung
> 

