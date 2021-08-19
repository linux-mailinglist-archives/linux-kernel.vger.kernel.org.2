Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8473F1AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbhHSN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238488AbhHSN5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:57:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8284E608FE;
        Thu, 19 Aug 2021 13:57:12 +0000 (UTC)
Date:   Thu, 19 Aug 2021 09:57:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v7 09/10] selftests/ftrace: Add clear_dynamic_events()
 to test cases
Message-ID: <20210819095709.392463ed@oasis.local.home>
In-Reply-To: <20210819041842.696873153@goodmis.org>
References: <20210819041321.105110033@goodmis.org>
        <20210819041842.696873153@goodmis.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 00:13:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +clear_dynamic_events() { # reset all current dynamic events
> +    again=1
> +    stop=1
> +    # loop mulitple times as some events require other to be removed first
> +    while [ $again -eq 1 ]; do
> +	stop=$((stop+1))
> +	# Prevent infinite loops
> +	if [ $stop -gt 10 ]; then
> +	    break;
> +	fi
> +	again=2
> +	grep -v '^#' dynamic_events|
> +	while read line; do
> +	    del=`sed -e 's/^.\([^ ]*\).*/-\1/'`

That should be "del=`echo $line | sed -e 's/^.\([^ ]*\).*/-\1/'`

Will fix in v8.

-- Steve

> +	    if ! echo "$del" >> dynamic_events; then
> +		again=1
> +	    fi
> +	done
> +    done
> +}
