Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198FC402B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbhIGPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:19:47 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36025 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345016AbhIGPTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:19:46 -0400
Received: from [141.14.12.104] (g104.RadioFreeInternet.molgen.mpg.de [141.14.12.104])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E817961E64846;
        Tue,  7 Sep 2021 17:18:37 +0200 (CEST)
Subject: Re: QA: Monitor Linux log messages as port of release (candidate)
 testing
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <458e0604-1fe9-bed0-d22f-84540b05ffb1@molgen.mpg.de>
 <20210907125354.GE4989@roeck-us.net>
 <38ac012a-c16e-1ba0-b386-156bb8ddecc4@molgen.mpg.de>
 <20210907144737.GF4989@roeck-us.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <6ff370ce-9905-b07e-99cf-4e2861d2872f@molgen.mpg.de>
Date:   Tue, 7 Sep 2021 17:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907144737.GF4989@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenter,


Am 07.09.21 um 16:47 schrieb Guenter Roeck:

> On Tue, Sep 07, 2021 at 03:50:39PM +0200, Paul Menzel wrote:

>> Am 07.09.21 um 14:53 schrieb Guenter Roeck:
>>> On Tue, Sep 07, 2021 at 10:40:31AM +0200, Paul Menzel wrote:
>>
>>>> Thank you for testing release candidates and releases [1]. Is your test
>>>> setup documented somewhere?
>>>>
>>> Not really, except its source is available at github:
>>> 	https://github.com/groeck/linux-build-test
>>
>> Thank you.
>>
>>>> If not happening already, could the Linux messages (at least up to log level
>>>> warning) also be monitored? For example, in Linux 5.14, a new warning snuck
>>>> in by cefc7ca462 (ACPI: PRM: implement OperationRegion handler for the
>>>> PlatformRtMechanism subtype) [2], which could have been caught early on, and
>>>> fixed before the release.
>>>>
>>>> The test summaries would then also notify about possible behavior change.
>>>
>>> Logs are available and can be examined at kerneltests.org/builders.
>>
>> Sorry for being blind. Under *qemu-tests*, looking at build #1831 [1],
>> clicking on *stdio* [2] under *Steps and Logfiles*, I do not see any Linux
>> logs.
>>
>>> Reports are generated manually, so it would be way too much effort to add
>>> build warnings to those. Besides, logs are way too noisy to be useful in a
>>> summary e-mail.
>>
>> Just to avoid misunderstandings, it’s about the Linux run-time logs.
>
> Run-time logs are only provided if there are errors or runtime issues
> (crashes, warning tracebacks, or test failures).

Could this be changed to always publish them? Or is that too demanding 
on storage?

>>> Also, Geert's build reports already provide build warnings and errors.
>>> The same applies to reports sent by 0-day. Indeed, I do see at least
>>> one 0-day report against commit cefc7ca46235.
>>
>> How can I find that report?
>>
> I just searched for the SHA.
> 
> https://www.spinics.net/lists/linux-acpi/msg101721.html

Alright, that is a build time thing. I am looking for runtime things.

>>> What would be the point of adding yet another report of build
>>> warnings on top of that ?
>> If the functionality already exists, great. But to be clear, it’s about the
>> runtime logs.
> 
> If there are (new) runtime issues (crashes, warnings, or other test failures),
> I usually analyze, bisect, and report the problem against the patch introducing
> the problem unless it was already reported elsewhere.
> 
> For example, there is currently a backtrace in arm64 tests:
> 
> BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
> 
> which is due to ACPI code being called from the wrong context.
> Another example is the cirular locking problem reported in various
> mips tests, from mtd code. Both problems have been fixed in -next,
> and the fixes will hopefully be pushed upstream soon.
> 
> The qemu tests do not log build warnings. I used to do that, but it
> was way too noisy (some builds used to produce hundreds of build
> warnings). Also, there is no logging data if there are neither
> crashes nor warnings or other test failures, for the same reason.

Thank you for the clarification and your QA work. Sorry about the 
misunderstanding about compile/build logs and runtime logs.

> If you are looking for complete boot logs, I'd suggest looking at
> test results from kernelci.org.

Thank you. I am going to do that then.


Kind regards,

Paul
