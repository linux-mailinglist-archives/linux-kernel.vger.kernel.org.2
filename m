Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6642CF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJMXSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhJMXSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F28C3611BD;
        Wed, 13 Oct 2021 23:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634166969;
        bh=+15ZoIbv/uEpT2AdMTN75zWx6H2AWH4qDe4G5cpnCGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fuGVDU8AOCWO3jZACmuAKT5yB83y14eP6fDTuLUncKc0egH2mg5UHtW0H+GIEun4F
         HwGtuDwpwwm62RN8VFuIlOahsaW58aEwYYCCOSJZooDZIl/p5ha3NCw2tAx5jp06X4
         hd3bIcgqOOKA2eZ3pSWraJJ9Rk24bTN549xqYlcKfUlCF/Jk0h76JMYsCqeRZJuaDh
         j1cptebpwXSj9OdzJ70BhZu/pgDZ7JjnDB8fuQH/bIORty6oB4rLRyetioEXs5UuqM
         64UhyBimF6pfKyJvk4GTHDsxehS/WSwh4wUJkZjrKDTvuzULLfhwIn6ga9kdrdDPFq
         WbJ6v1U8ge5uw==
Date:   Thu, 14 Oct 2021 08:16:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2 0/2] tracing: Fix removal of eprobes and add test
Message-Id: <20211014081605.69401833c1ceb18a9c308e7d@kernel.org>
In-Reply-To: <20211013205111.587708359@goodmis.org>
References: <20211013205111.587708359@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 16:51:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> When doing the following:
> 
>  # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> 
>  # echo '-:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> 
> It errors out with -ENOENT. This is because the "match" function does not
> take into account the "timer/hrtimer_cancel" part. Fix it and also make it
> work more genericly like kprobes and uprobes.

Thanks for update. This series looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
for the series.

Thank you!

> 
> v1 at: https://lore.kernel.org/all/20211013234206.37dd18ffcc2a2cbf4493f125@kernel.org/
> 
> Changes since v1:
>  - Instead of just fixing the missing system/event, have it be more like
>    kprobes and uprobes.
> 
> Steven Rostedt (VMware) (2):
>       tracing: Fix event probe removal from dynamic events
>       selftests/ftrace: Update test for more eprobe removal process
> 
> ----
>  kernel/trace/trace_eprobe.c                        | 54 ++++++++++++++++++++--
>  .../ftrace/test.d/dynevent/add_remove_eprobe.tc    | 54 +++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 5 deletions(-)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
