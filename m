Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3599D4390A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhJYH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:59:00 -0400
Received: from gateway20.websitewelcome.com ([192.185.66.3]:28336 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhJYH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:58:59 -0400
X-Greylist: delayed 1357 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 03:58:59 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7E415400D0072
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:33:59 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id euUZmJ9r0gm2UeuUZmCkLj; Mon, 25 Oct 2021 02:33:59 -0500
X-Authority-Reason: nr=8
Received: from host-79-18-63-114.retail.telecomitalia.it ([79.18.63.114]:60730 helo=[10.0.0.35])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1meuUY-003rzQ-Aj; Mon, 25 Oct 2021 02:33:58 -0500
Message-ID: <be7cbe08-9657-f5ac-4053-0cf2b9c26a78@kernel.org>
Date:   Mon, 25 Oct 2021 09:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V4 02/19] trace/osnoise: Split workload start from the
 tracer start
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
References: <cover.1634820694.git.bristot@kernel.org>
 <90bfad2bdd348f85b1ff473077de676f75ab445c.1634820694.git.bristot@kernel.org>
 <20211022222517.744bbca1@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211022222517.744bbca1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.18.63.114
X-Source-L: No
X-Exim-ID: 1meuUY-003rzQ-Aj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-18-63-114.retail.telecomitalia.it ([10.0.0.35]) [79.18.63.114]:60730
X-Source-Auth: kernel@bristot.me
X-Email-Count: 14
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 04:25, Steven Rostedt wrote:
> On Thu, 21 Oct 2021 14:56:40 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> +/*
>> + * osnoise_workload_stop - stop the workload and unhook the events
>> + */
>> +static void osnoise_workload_stop(void)
>> +{
>> +	if (!osnoise_busy)
>> +		return;
>> +
>> +	trace_osnoise_callback_enabled = false;
> 
> I know this is just moving this code, but the original code had this
> issue too, but there should be a comment here to why we need the
> compiler barrier.

I will add a comment, like we have on hwlat.

-- Daniel

> -- Steve
> 
> 
>> +	barrier();
>> +
>> +	stop_per_cpu_kthreads();
>> +
>> +	unhook_irq_events();
>> +	unhook_softirq_events();
>> +	unhook_thread_events();
>> +
>> +	osnoise_busy = false;
>> +}
>> +

