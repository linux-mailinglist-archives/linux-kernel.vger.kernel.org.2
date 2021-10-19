Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABCB4336D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhJSNVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:21:20 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.125]:30340 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhJSNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:21:19 -0400
X-Greylist: delayed 1281 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 09:21:19 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 9425B532C9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:56:21 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id cofFmLf9X6dDycofFmweEe; Tue, 19 Oct 2021 07:56:21 -0500
X-Authority-Reason: nr=8
Received: from host-79-18-63-114.retail.telecomitalia.it ([79.18.63.114]:58576 helo=[10.0.0.35])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mcofE-002I56-3p; Tue, 19 Oct 2021 07:56:20 -0500
Message-ID: <f0c50222-a9a8-d0e5-d705-d9d670467142@kernel.org>
Date:   Tue, 19 Oct 2021 14:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH V3 13/19] rtla: Add Documentation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <cover.1634574261.git.bristot@kernel.org>
 <7e205854656f41afe9a35e6390d3e3cbd724706f.1634574261.git.bristot@kernel.org>
 <877deaut3b.fsf@meer.lwn.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <877deaut3b.fsf@meer.lwn.net>
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
X-Exim-ID: 1mcofE-002I56-3p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-18-63-114.retail.telecomitalia.it ([10.0.0.35]) [79.18.63.114]:58576
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 19:43, Jonathan Corbet wrote:
> Daniel Bristot de Oliveira <bristot@kernel.org> writes:
> 
>> Adds the basis for rtla documentation. It is based on libtracefs
>> Documentation as suggested by Steven Rostedt. This patch also
>> includes the rtla(1) man page.
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Tom Zanussi <zanussi@kernel.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: John Kacur <jkacur@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: linux-rt-users@vger.kernel.org
>> Cc: linux-trace-devel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>  tools/tracing/rtla/Documentation/Makefile     | 223 ++++++++++++++++++
>>  .../tracing/rtla/Documentation/asciidoc.conf  | 118 +++++++++
>>  .../rtla/Documentation/manpage-base.xsl       |  35 +++
>>  .../rtla/Documentation/manpage-normal.xsl     |  13 +
>>  tools/tracing/rtla/Documentation/rtla.txt     |  56 +++++
>>  tools/tracing/rtla/Documentation/utils.mk     | 144 +++++++++++
>>  tools/tracing/rtla/Makefile                   |  20 +-
>>  7 files changed, 604 insertions(+), 5 deletions(-)
>>  create mode 100644 tools/tracing/rtla/Documentation/Makefile
>>  create mode 100644 tools/tracing/rtla/Documentation/asciidoc.conf
>>  create mode 100644 tools/tracing/rtla/Documentation/manpage-base.xsl
>>  create mode 100644 tools/tracing/rtla/Documentation/manpage-normal.xsl
>>  create mode 100644 tools/tracing/rtla/Documentation/rtla.txt
>>  create mode 100644 tools/tracing/rtla/Documentation/utils.mk
> 
> So please forgive me for being obnoxious but I have to ask...do we
> *really* need to add yet another markup language and docs build
> infrastructure to the kernel?  I'm glad to see documentation, of course,
> but I would be gladder if it weren't a silo completely separate from the
> rest of the kernel docs.  Is there a reason why this couldn't have been
> done with Sphinx?

I am not a document format specialist, neither have a strong opinion on this, so
suggestions are welcome. I used this format as a suggestion from steven, it is
also similar to what we have on perf...

The idea here is to create a set of man pages. I saw that it is possible to
create man pages using Sphinx, but there are so many options that it is hard to
get started...

I also noticed that bpftools uses .rst files, but uses rst2man to convert the files.

Converting the current files to .rst is easy.

So, could give me some directions on what you think would be the best way to
create this set of man pages?

A link to a project that creates a set of man pages using Sphinx using a
Makefile would be a plus :-).

-- Daniel


> 
> Thanks,
> 
> jon
> 

