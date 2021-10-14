Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A442D2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJNGst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhJNGsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634194000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aRaTURW0NzaG+vFgsUzyHhcr9bbkPDdtsqC5vNQk7M=;
        b=ORxITZhZJfhmM/ASVicSkbChPlAxXz+DsnW2uEdJw/ugxJQwwX2gYq32WYJv3hKA7cqfOK
        o8mAkJwlrgrwvRUAjWMsGQshMkxat3wjECLrtAFX+Pv78IURgspld2q4jh1jOcjAx3UR5r
        jHlt4ZpJAyyFhTp5nUIYpMO1H1MN8Ms=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-TyUem9HGPDqo8L9KSfI1aw-1; Thu, 14 Oct 2021 02:46:39 -0400
X-MC-Unique: TyUem9HGPDqo8L9KSfI1aw-1
Received: by mail-wr1-f72.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so3784548wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3aRaTURW0NzaG+vFgsUzyHhcr9bbkPDdtsqC5vNQk7M=;
        b=pFXxreWJ1v0aps9NxfA7PafhKkPg63Gk0VlJA/jWJf+qk0TVLmg+3r8i9SznyLIu+W
         kOgp59E6lXx7UEvmJ2bHohL94nIF4OPW7sFbhISC1gaw2YGltcnObwRYiNeGxJ6wM017
         Uz1EszlY8Aum1YvJgF82TNEbMttYj0ol2fmSX6Lac690vsNNPJjk6pVHUUkINOskEuMV
         mm92k/VYj+APlbKom5OIrerwwoc8RS3awj8i+UDmuSi7OvyuOTtE5BE8th4Y7ge+xaIP
         LWOzmz1QRb0Gm8iqnDGydmoD8jj8l3St1Lz91QEgNDkzk3SOkKT17X/mUSvjMvakEzot
         1Uvg==
X-Gm-Message-State: AOAM5323XpwCrfTtC6S9R7Z2xhkc2EM8vapIqAtd/XLDYX/5oKYEqIDn
        40QSoGv/gdQkkDFM+Mua99zmd3QJe2U+U0MSXHPOl2OqJQa1tgidQO7zUv01Ojka/UhhHj5+217
        Hr15sbnf07BTMwQqr6XzNJ156
X-Received: by 2002:adf:a550:: with SMTP id j16mr4599769wrb.180.1634193998359;
        Wed, 13 Oct 2021 23:46:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv+Pnw+UVOv19MRjLpSh8C0rkR7LTixke3E/27nwPF/uYtKLZ9Z7wZ39CdZDFJTPqNUjXc6g==
X-Received: by 2002:adf:a550:: with SMTP id j16mr4599752wrb.180.1634193998182;
        Wed, 13 Oct 2021 23:46:38 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n7sm1513659wra.37.2021.10.13.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:46:17 -0700 (PDT)
Date:   Thu, 14 Oct 2021 08:45:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v3 0/8] perf session: Extend reader object to allow
 multiple readers
Message-ID: <YWfSIRxh5Fu4m75f@krava>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:06:34PM +0300, Alexey Bayduraev wrote:
> Changes in v4:
> - set/unset active_decomp within reader__process_events

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Changes in v3:
> - removed struct reader_state in [PATCH v3 1/8]
> - fixed repeating code in [PATCH v3 2/8]
> - split [PATCH v2 4/5] to [PATCH v3 4/8], [PATCH v3 5/8]
> - split [PATCH v2 5/5] to [PATCH v3 6/8] - [PATCH v3 8/8]
> 
> Changes in v2:
> - introduced struct decomp_data suggested by Jiri Olsa
> - removed unnecessary [PATCH v1 1/6]
> - removed unnecessary extra line in [PATCH v2 4/5]
> - removed unnecessary reader_state.eof flag in [PATCH v2 5/5]
> 
> Patchset moves state info and decompressor object into reader object
> that made possible to split reader__process_events function into three
> logical parts: init, map/unmap and single event reader which are used
> in events reader loop. This approach allows reading multiple trace
> files at the same time. 
> 
> The design and implementation are based on the prototype [1], [2].
> The patchset was separated from [3].
> 
> Tested:
> 
> tools/perf/perf record -o prof.data -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -z -- matrix.gcc.g.O3
> tools/perf/perf report -i prof.data
> tools/perf/perf report -i prof.data --call-graph=callee
> tools/perf/perf report -i prof.data --stdio --header
> tools/perf/perf report -i prof.data -D --header
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> [3] https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> 
> Alexey Bayduraev (8):
>   perf session: Move all state items to reader object
>   perf session: Introduce decompressor in reader object
>   perf session: Move init/release code to separate functions
>   perf session: Move map code to separate function
>   perf session: Move unmap code to reader__mmap
>   perf session: Move event read code to separate function
>   perf session: Introduce reader return codes
>   perf session: Introduce reader EOF function
> 
>  tools/perf/util/session.c | 193 ++++++++++++++++++++++++++------------
>  tools/perf/util/session.h |  10 +-
>  2 files changed, 141 insertions(+), 62 deletions(-)
> 
> -- 
> 2.19.0
> 

