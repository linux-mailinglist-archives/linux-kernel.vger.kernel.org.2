Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B013B5483
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhF0Rb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 13:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhF0Rb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 13:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624814973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yKxLMKBG+NPE2J5wfdFrFJq5rwPKVdeNp6vqQqN9Cs=;
        b=IpgKLvLuAr4N1J0RGg0+a1fXFQCkrMCimDTVDe06ScqLtYy/wHMWosgTkYBqafuBIanX0G
        tCx4HDahBVBvoPLwQZhMnes8mDVfX/ZwIrTtHjjVbINnfO4nme4ClRNjkyiMIT/TudeAgb
        fLjmlDFrgCOK1BOvqhX0YExVM+dSNjI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-cgj-LZ2fMsGciwjPwjzHwg-1; Sun, 27 Jun 2021 13:29:31 -0400
X-MC-Unique: cgj-LZ2fMsGciwjPwjzHwg-1
Received: by mail-ed1-f69.google.com with SMTP id r6-20020a05640216c6b0290394ed90b605so7969921edx.20
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 10:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yKxLMKBG+NPE2J5wfdFrFJq5rwPKVdeNp6vqQqN9Cs=;
        b=j/wwrqWGbysKJIuPJCvtXfVUU67HWeJFQozsQMd+KNOmojuXLb2HON61cQH2481557
         HKP3Y9pQSZ9R6CA135CDcW+v/YIfobK4MKFXWnLU29qYLbL8YlBaAweBVEXdgPKcaBDQ
         InxtmEzuoZJep9Jha4z0ONWwaFcRX7Y2gDr1wc8lTqpyix69nZyhYLL8QCJHKA4hrzu2
         NZKFR7JxspeKTChbWoUURnpM95lQYwAT4E6635cpFTlRw9s7klQI4ubimIJ34XBuw0Vw
         H9+CjNC3WJFicmddkAiXUIL4ktw9917odMUddBl+vyvlLOqGWY8mZlhJGgTbO+ENHU2L
         d4yw==
X-Gm-Message-State: AOAM531qZP0NMB++9XVPxD8oOimKIP5Ro4GGj4lL69ALTVZRPobgZpwQ
        T3J4/Mw3eRiiyH//dQ04/yI2baqY9vV0AKDUkk4P387B9EDa+eY6s9aGHpgr3+ezitPpFPUhPNs
        tv1dCS9ycpKVssgu69ZSeO1sl
X-Received: by 2002:a17:907:9841:: with SMTP id jj1mr20621575ejc.94.1624814970496;
        Sun, 27 Jun 2021 10:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz2HuIcVtEVr7kTNorvqVIrr9WUeJp2+b3JayF/IOvAaPPz+/ZgGJ674+nrRgjVPwAldx6nQ==
X-Received: by 2002:a17:907:9841:: with SMTP id jj1mr20621568ejc.94.1624814970373;
        Sun, 27 Jun 2021 10:29:30 -0700 (PDT)
Received: from krava ([5.171.209.125])
        by smtp.gmail.com with ESMTPSA id f5sm5703703ejj.45.2021.06.27.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 10:29:29 -0700 (PDT)
Date:   Sun, 27 Jun 2021 19:29:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf session: add missing evlist__delete when
 deleting a session
Message-ID: <YNi1dspuN/cdNAKr@krava>
References: <20210624231926.212208-1-rickyman7@gmail.com>
 <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
 <YNXD2xN2wrZgdbwO@krava>
 <4725ef2249540b6876daea3714a38a6be59223e6.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4725ef2249540b6876daea3714a38a6be59223e6.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 05:45:59PM +0200, Riccardo Mancini wrote:
> Hi,
> 
> thank you both for your comments.
> 
> On Fri, 2021-06-25 at 13:54 +0200, Jiri Olsa wrote:
> > On Thu, Jun 24, 2021 at 10:39:34PM -0700, Ian Rogers wrote:
> > > On Thu, Jun 24, 2021 at 4:20 PM Riccardo Mancini <rickyman7@gmail.com>
> > > wrote:
> > > > 
> > > > ASan reports a memory leak caused by evlist not being deleted on exit in
> > > > perf-report, perf-script and perf-data.
> > > > The problem is caused by evlist->session not being deleted, which is
> > > > allocated in perf_session__read_header, called in perf_session__new if
> > > > perf_data is in read mode.
> > > > In case of write mode, the session->evlist is filled by the caller.
> > > > This patch solves the problem by calling evlist__delete in
> > > > perf_session__delete if perf_data is in read mode.
> > 
> > ugh, I'm surprised we did not free that.. and can't find
> > in git log we ever did ;-) I briefly check commands using
> > sessions and looks like it's correct
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > > 
> > > Acked-by: Ian Rogers <irogers@google.com>
> > > 
> > > It is messy that in read mode the session owns the evlist, but
> > > otherwise not. Imo, it'd be nice to make the ownership unconditional.
> > 
> > yep, would be nice
> 
> I think the root problem is that perf_session__new has different behaviours
> depending on perf_data and perf_tool and that it probably does too many things
> for a __new function.
> If we split it into multiple functions and then, say, we create two helpers
> perf_session__init_read and perf_session__init_write, with the corresponding
> perf_session__fini_read and perf_session__fini_write, then the conditional
> ownership won't be a big problem due to having these two cases clearly
> separated.
> What do you think?

yes, interesting idea, let's see how the code looks like ;-)

thanks,
jirka

