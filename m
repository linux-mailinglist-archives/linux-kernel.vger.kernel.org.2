Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C964270E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJHSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhJHSq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:46:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 294CC60EC0;
        Fri,  8 Oct 2021 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633718670;
        bh=T9vYy8/rMW8C3rqZXvvVB66NGiOQRGjwwFqoZmuTpIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r78uVLqzk6HXG5uAitlw2jZ87gdnh+35aDSTQnkxIRrvVgDcpR3SM/l2zbLu6N93g
         WYYDK+/eFB0cmaI6OAlrkwlWZ0XZBaRN+iNWHEsDfPdJRX2PeuvFXs2oHTSLjekT/i
         S51QHsqPGfEpxv+m/mpoKkjYGE91XnnXK00evGJVHDVp5jTouNm25tM1wZdRP6t6PC
         MqBdAFM57W7Kpg+moGSZjp888eJdUZ+k4crQpR9z4m0WCqvU/az0QFJ5Ric/i8ur39
         njyQuTxHLzCBGJ1YaBvvwRlanEwZP29tPUOdb3a9dNhEXw8VjEvYmr+NzT0iBYQdlY
         3kQ7zXCa6IMyg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88D24410A1; Fri,  8 Oct 2021 15:44:27 -0300 (-03)
Date:   Fri, 8 Oct 2021 15:44:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH] perf report: Output non-zero offset for decompressed
 records
Message-ID: <YWCRi5Rb9sdQ1AV1@kernel.org>
References: <20210929091445.18274-1-alexey.v.bayduraev@linux.intel.com>
 <YVqiS0lzxuVlblrN@krava>
 <6ab9dd72-ccac-4ce1-6456-ef7786911639@linux.intel.com>
 <YVqn/FZ544RAV6Mq@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVqn/FZ544RAV6Mq@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 04, 2021 at 09:06:36AM +0200, Jiri Olsa escreveu:
> On Mon, Oct 04, 2021 at 10:00:52AM +0300, Bayduraev, Alexey V wrote:
> > On 04.10.2021 9:42, Jiri Olsa wrote:
> > > On Wed, Sep 29, 2021 at 12:14:45PM +0300, Alexey Bayduraev wrote:
> > >> Print offset of PERF_RECORD_COMPRESSED record instead of zero for
> > >> decompressed records in raw trace dump (-D option of perf-report):

> > >> 0x17cf08 [0x28]: event: 9

> > >> instead of:

> > >> 0 [0x28]: event: 9

> > >> The fix is not critical, because currently file_pos for compressed
> > >> events is used in perf_session__process_event only to show offsets
> > >> in the raw dump.

> > > I don't mind the change just curious, because I see also:
> > > 
> > >   perf_session__process_event
> > >     perf_session__process_user_event
> > >       lseek(fd, file_offset, ...

> > > which is not raw dump as the comment suggests

> > Yes, but this "lseek" only works for user events, whereas the 
> > PERF_RECORD_COMPRESSED record shouln't contain such events.
> > Currently, the PERF_RECORD_COMPRESSED container can only pack
> > kernel events. 
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

