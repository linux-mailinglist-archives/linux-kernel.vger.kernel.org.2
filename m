Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501A543FC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhJ2MeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:34:05 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:30362 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231604AbhJ2MeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:34:03 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 2AFDE400C5AB8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:31:34 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id gR2kmhhVxOnCIgR2kmLhMj; Fri, 29 Oct 2021 07:31:34 -0500
X-Authority-Reason: nr=8
Received: from host-79-27-6-113.retail.telecomitalia.it ([79.27.6.113]:40436 helo=[10.0.0.44])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mgR2i-001d0H-Cz; Fri, 29 Oct 2021 07:31:32 -0500
Message-ID: <b2c51cb7-1561-a23b-bba2-d8a8c5d27691@kernel.org>
Date:   Fri, 29 Oct 2021 14:31:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V7 8/9] trace/osnoise: Remove STACKTRACE ifdefs from
 inside functions
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635452903.git.bristot@kernel.org>
 <2cab388e4faaf3fc3496a1c18ec09a8bc7c36c3f.1635452903.git.bristot@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <2cab388e4faaf3fc3496a1c18ec09a8bc7c36c3f.1635452903.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.27.6.113
X-Source-L: No
X-Exim-ID: 1mgR2i-001d0H-Cz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-27-6-113.retail.telecomitalia.it ([10.0.0.44]) [79.27.6.113]:40436
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 23:29, Daniel Bristot de Oliveira wrote:
> Remove CONFIG_STACKTRACE from inside functions, avoiding
> compilation problems in the future.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: linux-rt-users@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/trace_osnoise.c | 44 ++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 0c3a93f51b08..eaa6396e3262 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -635,13 +635,19 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
>  /*
>   * timerlat_dump_stack - dump a stack trace previously saved
>   */
> -static void timerlat_dump_stack(void)
> +static void timerlat_dump_stack(u64 latency)
>  {
>  	struct osnoise_instance *inst;
>  	struct trace_buffer *buffer;
>  	struct trace_stack *fstack;
>  	unsigned int size;
>  
> +	/*
> +	 * 0 is disabled, so it will never be > than latency.
> +	 */
> +	if (osnoise_data.print_stack > latency)
> +		return;

Oops, I placed the comment, but forgot to place the check. This if should be:

if (!osnoise_data.print_stack || osnoise_data.print_stack > latency)
	return;

-- Daniel
