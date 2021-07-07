Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32823BEC49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhGGQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGQeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:34:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37BEF61CAC;
        Wed,  7 Jul 2021 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625675493;
        bh=q3UZp4Bb5WE6sKUFwga1SnOoXIo6qLfr7YAeANlc1jY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IL3ImziBya+z2bYsK2ayEYkWoBMzZ36yHVR78MHkjK9j+zVSlURfh39Uz6M1S4PZr
         HGGIwMn3n5mz6xlhbhih1ZM5eW3ZcTde2OZyd/1Lc8R6i254Tv5DjJMEBHjOjauB2Q
         RDRkupuwaTPXgHk7PuZQ5B4utDhuSx0nKMqt5UiJ7He0LazxvP0AqL1AAmplHfjbz4
         0gB0dhK8S3uHVoZ4zgDe7x2aB5rVL47pyX82cAxGMUmy415kHmTAiSjQEVDwvvz3XD
         CbbLDdaFqr0M0jRgu3HOqab4LZDII2+4MFxQKrAQhe/xPzFTxBRm3xtcswqLuoOmSk
         oLe27Gyc/dF9Q==
Message-ID: <816bf11b48928351b3e6003ba32efd9baf8b0442.camel@kernel.org>
Subject: Re: [PATCH] tracing/selftests: Add tests to test histogram sym and
 sym-offset modifiers
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Date:   Wed, 07 Jul 2021 11:31:31 -0500
In-Reply-To: <20210707121451.101a1002@oasis.local.home>
References: <20210707121451.101a1002@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-07 at 12:14 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test to the tracing selftests that will catch if the .sym or
> .sym-offset modifiers break in the future.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/trigger/trigger-hist.tc      | 18
> ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-
> hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-
> hist.tc
> index 2950bfbc6fce..adae72665500 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> @@ -39,6 +39,24 @@ grep "parent_comm: $COMM"
> events/sched/sched_process_fork/hist > /dev/null || \
>  
>  reset_trigger
>  
> +echo "Test histogram with sym modifier"
> +
> +echo 'hist:keys=call_site.sym' > events/kmem/kmalloc/trigger
> +for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> +grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]* *}'
> events/kmem/kmalloc/hist > /dev/null || \
> +    fail "sym modifier on kmalloc call_site did not work"
> +
> +reset_trigger
> +
> +echo "Test histogram with sym-offset modifier"
> +
> +echo 'hist:keys=call_site.sym-offset' > events/kmem/kmalloc/trigger
> +for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> +grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]*+0x[0-
> 9a-f][0-9a-f]*' events/kmem/kmalloc/hist > /dev/null || \
> +    fail "sym-offset modifier on kmalloc call_site did not work"
> +
> +reset_trigger
> +
>  echo "Test histogram with sort key"
>  
>  echo 'hist:keys=parent_pid,child_pid:sort=child_pid.ascending' >
> events/sched/sched_process_fork/trigger

Acked-by: Tom Zanussi <zanussi@kernel.org>


