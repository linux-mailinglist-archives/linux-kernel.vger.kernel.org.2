Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67945DC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355591AbhKYON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:13:58 -0500
Received: from gateway20.websitewelcome.com ([192.185.67.41]:30774 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355589AbhKYOL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:11:56 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7B3D140140031
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:45:40 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id qF4FmojqHnUhfqF4Gm08Ma; Thu, 25 Nov 2021 07:45:40 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:43162 helo=[10.0.0.34])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mqF4E-003AMJ-E5; Thu, 25 Nov 2021 07:45:38 -0600
Message-ID: <f815794d-bfb6-3e76-3572-3c1cc059c492@kernel.org>
Date:   Thu, 25 Nov 2021 14:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V7 05/14] rtla/osnoise: Add the hist mode
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635535309.git.bristot@kernel.org>
 <1d9826696a1e8c3584158c0dd570b8b22db708db.1635535309.git.bristot@kernel.org>
 <20211124171212.537b43c3@gandalf.local.home>
 <20211124171503.584c8dd2@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211124171503.584c8dd2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.34.250.122
X-Source-L: No
X-Exim-ID: 1mqF4E-003AMJ-E5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.34]) [79.34.250.122]:43162
X-Source-Auth: kernel@bristot.me
X-Email-Count: 29
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 23:15, Steven Rostedt wrote:
>>> +	/*
>>> +	 * Set the size of the bucket.
>>> +	 */
>>> +	bucket_size = params->output_divisor * params->bucket_size;
>>> +	snprintf(buff, sizeof(buff), "duration.buckets=%d", bucket_size);
>>> +
>>> +	data->trace_hist = tracefs_hist_alloc(tool->trace.tep, "osnoise", "sample_threshold",
>>> +			buff, TRACEFS_HIST_KEY_NORMAL);  
>> FYI, we changed the API (haven't tagged it yet, so we can do that :-) and
>> the above needs to be:
>>
>> 	data->trace_hist = tracefs_hist1d_alloc(tool->trace.tep, "osnoise", "sample_threshold",
> Or do you think that 1d should be the default, and we have:
> 
> 	tracefs_hist_alloc()	-- 1d histogram
> 	tracefs_hist_alloc_2d()	-- 2d histogram
> 	tracefs_hist_alloc_nd()	-- Nd histogram?
> 
> ??

IMHO, the function names in your second email sound more intuitive, i.e.,
tracefs_hist_alloc()/tracefs_hist_alloc_2d()/tracefs_hist_alloc_nd().

> We haven't tagged it yet, so we could change it again (and then your code
> will work as is).

two birds with a single stone :-)

-- Daniel
> -- Steve

