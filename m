Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E758A3BE05F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 02:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGGAxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 20:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGAxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 20:53:22 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C81161CAA;
        Wed,  7 Jul 2021 00:50:41 +0000 (UTC)
Date:   Tue, 6 Jul 2021 20:50:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Daniel Bristot de Oliveira Subject: [PATCH] tracing:" 
        <bristot@redhat.com>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
Message-ID: <20210706205039.64182493@rorschach.local.home>
In-Reply-To: <CAM9d7chmHmm3tjJik5EQDOJOdn7G0D3W9EJUogf_POnyTe6tcA@mail.gmail.com>
References: <20210706154315.3567166e@gandalf.local.home>
        <CAM9d7chmHmm3tjJik5EQDOJOdn7G0D3W9EJUogf_POnyTe6tcA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2021 16:20:07 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> >  { bytes_req: ~ 1400-1499 } hitcount:         30
> >  { bytes_req: ~ 2000-2099 } hitcount:          6
> >  { bytes_req: ~ 4000-4099 } hitcount:       2168
> >  { bytes_req: ~ 5000-5099 } hitcount:          6  
> 
> For consistency with the log2 histogram, I'd like to see
> 
>   { bytes_req: ~ 100 } hitcount:  3149
>   { bytes_req: ~ 200 } hitcount:  1468
>   { bytes_req: ~ 300 } hitcount:    39
>   ...
> 
> Or, if you really care about the value range
> 
>   { bytes_req: 0 ~ 99 } hitcount:  3149
>   { bytes_req: 100 ~ 199 } hitcount:  1468
>   { bytes_req: 200 ~ 299 } hitcount:    39

(Let the bike-shedding begin! ;-)

I actually dislike the log2 notation. For example, I just ran it with
this:

 ># echo 'hist:keys=bytes_req.log2:sort=bytes_req' > events/kmem/kmalloc/trigger
 ># cat events/kmem/kmalloc/hist
 # event histogram
 #
 # trigger info: hist:keys=bytes_req.log2:vals=hitcount:sort=bytes_req.log2:size=2048 [active]
 #

 { bytes_req: ~ 2^5  } hitcount:          8
 { bytes_req: ~ 2^6  } hitcount:          2
 { bytes_req: ~ 2^7  } hitcount:          4
 { bytes_req: ~ 2^8  } hitcount:          2
 { bytes_req: ~ 2^9  } hitcount:          2
 { bytes_req: ~ 2^10 } hitcount:          3

 Totals:
     Hits: 21
     Entries: 6
     Dropped: 0

And I don't know if that first entry is: 2^4 - 2^5 or if it is 2^5 - 2^6.

And to me '~' means "approximately", but I also took it as "not exactly".
I used it as:

  { bytes_req: ~ 1400-1499 } hitcount:         30

To mean, it's "approximately somewhere between 1400 and 1499" so, I kept the "~".

Now for your suggestions:

>   { bytes_req: ~ 100 } hitcount:  3149
>   { bytes_req: ~ 200 } hitcount:  1468
>   { bytes_req: ~ 300 } hitcount:    39

Suffers the same fate as I dislike in log2. Is " ~ 100" 0-100 or 100-200?

>   { bytes_req: 0 ~ 99 } hitcount:  3149
>   { bytes_req: 100 ~ 199 } hitcount:  1468
>   { bytes_req: 200 ~ 299 } hitcount:    39

I feel is farther from log2 than my version. Stating that "~" means
approximation, what does "0 ~ 99" really mean?

So far I prefer my original version.

BTW, we are also working on a user space parser for this, thus the
output format of all hist logic is going to be a user space API (if it
hasn't already become one.)

So we do need to get this correct for the long haul.

-- Steve
