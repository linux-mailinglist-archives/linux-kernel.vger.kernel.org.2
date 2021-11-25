Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA545DB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbhKYNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:52:07 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.96]:38836 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348552AbhKYNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:50:06 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E06571DE27
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:46:54 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id qF5SmPe3dHrvkqF5SmAYIg; Thu, 25 Nov 2021 07:46:54 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:43164 helo=[10.0.0.34])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mqF5R-003BvE-JH; Thu, 25 Nov 2021 07:46:53 -0600
Message-ID: <5609acbd-ba55-8c90-ae86-07a60d249009@kernel.org>
Date:   Thu, 25 Nov 2021 14:46:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V7 00/14] RTLA: An interface for osnoise/timerlat tracers
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
 <20211124171148.1530418d@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211124171148.1530418d@gandalf.local.home>
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
X-Exim-ID: 1mqF5R-003BvE-JH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.34]) [79.34.250.122]:43164
X-Source-Auth: kernel@bristot.me
X-Email-Count: 43
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 23:11, Steven Rostedt wrote:
> On Fri, 29 Oct 2021 21:26:03 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> The rtla(1) is a meta-tool that includes a set of commands that
>> aims to analyze the real-time properties of Linux. But instead of
>> testing Linux as a black box, rtla leverages kernel tracing
>> capabilities to provide precise information about the properties
>> and root causes of unexpected results.
>>
>> To start, it presents an interface to the osnoise and timerlat tracers.
>> In the future, it will also serve as home to the rtsl [1] and other
>> latency/noise tracers.
>>
>> If you just want to run it, you can download the tarball here:
>>   - https://bristot.me/files/rtla/tarball/rtla-0.3.tar.bz2
>>
>> To compile rtla on fedora you need:
>>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
>>   $ cd libtraceevent/
>>   $ make
>>   $ sudo make install
>>   $ cd ..
>>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
>>   $ cd libtracefs/
>>   $ make
>>   $ sudo make install
>>   $ cd ..
>>   $ sudo dnf install python3-docutils procps-devel
>>   $ cd $rtla_src
>>   $ make
>>   $ sudo make install
> Add a README to the above, so that people will know what dependencies there
> are.


I agree! Will add in the next version.

Thanks Steve!

-- Daniel

> Thanks!
> 
> -- Steve
> 
> 

