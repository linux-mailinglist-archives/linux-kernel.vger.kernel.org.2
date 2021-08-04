Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB72F3E0383
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhHDOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:41:26 -0400
Received: from gateway30.websitewelcome.com ([192.185.180.41]:49298 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237523AbhHDOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:41:24 -0400
X-Greylist: delayed 1408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2021 10:41:24 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id F23ED6CBD7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:17:28 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id BHi4mE9LKK61iBHi4mJlIh; Wed, 04 Aug 2021 09:17:28 -0500
X-Authority-Reason: nr=8
Received: from host-95-239-202-226.retail.telecomitalia.it ([95.239.202.226]:38680 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mBHi3-000vHF-KP; Wed, 04 Aug 2021 09:17:27 -0500
Subject: Re: [PATCH 0/2 v3] tracing/histogram: Add buckets to group data in
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210707213623.250212325@goodmis.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <b26103d8-cdeb-5b97-fe63-ffaf504a9c02@kernel.org>
Date:   Wed, 4 Aug 2021 16:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707213623.250212325@goodmis.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.239.202.226
X-Source-L: No
X-Exim-ID: 1mBHi3-000vHF-KP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-239-202-226.retail.telecomitalia.it (x1.bristot.me) [95.239.202.226]:38680
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 11:36 PM, Steven Rostedt wrote:
> Add a .buckets modifier to group the data instead of having every key saved
> in its own entry, and in a linear fashion instead of like the log2 modifier.
> 
> Changes since v2:
> 
>  - Rename "grouping" field in hist_field to "buckets"
>  - Updated documentation to describe the new modifier
> 
> 
> Steven Rostedt (VMware) (2):
>       tracing: Add linear buckets to histogram logic
>       tracing/histogram: Update the documentation for the buckets modifier

ok, I need this!

Tested on regular and preempt rt kernel.

Tested-by: Daniel Bristot de Oliveira <bristot@kernel.org>

[root@alien bristot]# cd /sys/kernel/tracing/
[root@alien tracing]# echo 'hist:keys=duration.buckets=1000:sort=duration' >> events/osnoise/sample_threshold/trigger
[root@alien tracing]# echo osnoise > current_tracer 
[root@alien tracing]# cat events/osnoise/sample_threshold/hist 
# event histogram
#
# trigger info: hist:keys=duration.buckets=1000:vals=hitcount:sort=duration.buckets=1000:size=2048 [active]
#

{ duration: ~ 5000-5999 } hitcount:        384
{ duration: ~ 6000-6999 } hitcount:        175
{ duration: ~ 7000-7999 } hitcount:         55
{ duration: ~ 8000-8999 } hitcount:        230
{ duration: ~ 9000-9999 } hitcount:         60
{ duration: ~ 10000-10999 } hitcount:        123
{ duration: ~ 11000-11999 } hitcount:         20
{ duration: ~ 12000-12999 } hitcount:         40
{ duration: ~ 13000-13999 } hitcount:        954
{ duration: ~ 14000-14999 } hitcount:         43
{ duration: ~ 15000-15999 } hitcount:         41
{ duration: ~ 16000-16999 } hitcount:         12
{ duration: ~ 17000-17999 } hitcount:         44
{ duration: ~ 18000-18999 } hitcount:          6
{ duration: ~ 19000-19999 } hitcount:          7
{ duration: ~ 20000-20999 } hitcount:          4
{ duration: ~ 21000-21999 } hitcount:          5
{ duration: ~ 22000-22999 } hitcount:          1
{ duration: ~ 23000-23999 } hitcount:          2
{ duration: ~ 24000-24999 } hitcount:         13
{ duration: ~ 25000-25999 } hitcount:         14
{ duration: ~ 26000-26999 } hitcount:         10
{ duration: ~ 27000-27999 } hitcount:          1
{ duration: ~ 28000-28999 } hitcount:          5
{ duration: ~ 29000-29999 } hitcount:          5
{ duration: ~ 30000-30999 } hitcount:          4
{ duration: ~ 31000-31999 } hitcount:          2
{ duration: ~ 32000-32999 } hitcount:          2
{ duration: ~ 33000-33999 } hitcount:          3
{ duration: ~ 34000-34999 } hitcount:          1
{ duration: ~ 35000-35999 } hitcount:          1
{ duration: ~ 36000-36999 } hitcount:          4
{ duration: ~ 37000-37999 } hitcount:          2
{ duration: ~ 42000-42999 } hitcount:          1
{ duration: ~ 47000-47999 } hitcount:          1
{ duration: ~ 51000-51999 } hitcount:          5
{ duration: ~ 52000-52999 } hitcount:          2
{ duration: ~ 53000-53999 } hitcount:          6
{ duration: ~ 54000-54999 } hitcount:          3
{ duration: ~ 55000-55999 } hitcount:          9
{ duration: ~ 56000-56999 } hitcount:          7
{ duration: ~ 57000-57999 } hitcount:          5
{ duration: ~ 58000-58999 } hitcount:          2
{ duration: ~ 59000-59999 } hitcount:          4
{ duration: ~ 60000-60999 } hitcount:          1
{ duration: ~ 61000-61999 } hitcount:          4
{ duration: ~ 62000-62999 } hitcount:          2
{ duration: ~ 64000-64999 } hitcount:          4
{ duration: ~ 65000-65999 } hitcount:          3
{ duration: ~ 66000-66999 } hitcount:         17
{ duration: ~ 67000-67999 } hitcount:         12
{ duration: ~ 68000-68999 } hitcount:          1
{ duration: ~ 69000-69999 } hitcount:          9
{ duration: ~ 70000-70999 } hitcount:          8
{ duration: ~ 71000-71999 } hitcount:         10
{ duration: ~ 72000-72999 } hitcount:          3
{ duration: ~ 73000-73999 } hitcount:          1
{ duration: ~ 74000-74999 } hitcount:          2
{ duration: ~ 75000-75999 } hitcount:          3
{ duration: ~ 77000-77999 } hitcount:          3
{ duration: ~ 78000-78999 } hitcount:          2
{ duration: ~ 79000-79999 } hitcount:          2
{ duration: ~ 83000-83999 } hitcount:          3
{ duration: ~ 84000-84999 } hitcount:          1
{ duration: ~ 85000-85999 } hitcount:          1
{ duration: ~ 86000-86999 } hitcount:          6
{ duration: ~ 87000-87999 } hitcount:          3
{ duration: ~ 88000-88999 } hitcount:          2
{ duration: ~ 90000-90999 } hitcount:          1
{ duration: ~ 91000-91999 } hitcount:          1
{ duration: ~ 92000-92999 } hitcount:          1
{ duration: ~ 97000-97999 } hitcount:          1
{ duration: ~ 99000-99999 } hitcount:          4
{ duration: ~ 100000-100999 } hitcount:          2
{ duration: ~ 101000-101999 } hitcount:          1
{ duration: ~ 104000-104999 } hitcount:          1
{ duration: ~ 106000-106999 } hitcount:          1
{ duration: ~ 107000-107999 } hitcount:          1
{ duration: ~ 109000-109999 } hitcount:          1
{ duration: ~ 130000-130999 } hitcount:          1
{ duration: ~ 155000-155999 } hitcount:          1
{ duration: ~ 160000-160999 } hitcount:          1
{ duration: ~ 194000-194999 } hitcount:          1
{ duration: ~ 335000-335999 } hitcount:          1
{ duration: ~ 437000-437999 } hitcount:          1
{ duration: ~ 452000-452999 } hitcount:          1
{ duration: ~ 457000-457999 } hitcount:          1
{ duration: ~ 524000-524999 } hitcount:          1
{ duration: ~ 623000-623999 } hitcount:          1
{ duration: ~ 627000-627999 } hitcount:          1
{ duration: ~ 629000-629999 } hitcount:          1
{ duration: ~ 634000-634999 } hitcount:          1
{ duration: ~ 695000-695999 } hitcount:          1
{ duration: ~ 706000-706999 } hitcount:          1
{ duration: ~ 720000-720999 } hitcount:          1
{ duration: ~ 768000-768999 } hitcount:          1
{ duration: ~ 1296000-1296999 } hitcount:          1
{ duration: ~ 1301000-1301999 } hitcount:          1
{ duration: ~ 1303000-1303999 } hitcount:          1
{ duration: ~ 1306000-1306999 } hitcount:          1
{ duration: ~ 1308000-1308999 } hitcount:          1
{ duration: ~ 1310000-1310999 } hitcount:          1
{ duration: ~ 1314000-1314999 } hitcount:          1
{ duration: ~ 1315000-1315999 } hitcount:          1
{ duration: ~ 1318000-1318999 } hitcount:          1
{ duration: ~ 1321000-1321999 } hitcount:          1
{ duration: ~ 1322000-1322999 } hitcount:          1
{ duration: ~ 1325000-1325999 } hitcount:          1
{ duration: ~ 1330000-1330999 } hitcount:          1
{ duration: ~ 1367000-1367999 } hitcount:          1
{ duration: ~ 1415000-1415999 } hitcount:          1
{ duration: ~ 1420000-1420999 } hitcount:          1
{ duration: ~ 1462000-1462999 } hitcount:          1
{ duration: ~ 1466000-1466999 } hitcount:          1
{ duration: ~ 1489000-1489999 } hitcount:          1
{ duration: ~ 1537000-1537999 } hitcount:          1
{ duration: ~ 1559000-1559999 } hitcount:          1
{ duration: ~ 3176000-3176999 } hitcount:          1
{ duration: ~ 3353000-3353999 } hitcount:          1
{ duration: ~ 3719000-3719999 } hitcount:          1
{ duration: ~ 5824000-5824999 } hitcount:          1

Totals:
    Hits: 2478
    Entries: 121
    Dropped: 0



> ----
>  Documentation/trace/histogram.rst | 92 ++++++++++++++++++++++++++++++++++++---
>  kernel/trace/trace.c              |  1 +
>  kernel/trace/trace_events_hist.c  | 65 ++++++++++++++++++++++++---
>  3 files changed, 145 insertions(+), 13 deletions(-)
> 

