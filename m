Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137F8402B02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhIGOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhIGOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:48:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEEC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:47:40 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so13032755otg.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nci4/B41QF+oBe4qv8ng7lSjST0iQqji29tw2osdDUE=;
        b=h1YB1wsEW0fCLIr9u5LXZ9btrD1/NYZm1fzH7u9cRNdW+a21qPor8apqb5VWBaLWik
         7tLKe/waXUlPFtVmutNV1M2YTJ8jVZDaApi2b/AKVCot6RVibp+asxzInYstCeMHoImA
         UmhRRP4A5jEG9PZkh9991Yrx1q2STZW3DWtD8girtJLo3zIZsb67wefr2SUKRAtWvlkC
         pubQjsTtAYTL0kBkgZeAbYo2dUwV0Xqjayb+VtKUGahfTFRKrHqju8ccIRZFmWsuqwKR
         sfS4l5HsMWcW7cWe9sWiMLqz9NDoSqls5uH+akXmDkPiHPXkrvWDysiVCjoyA7EWSfFU
         XteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=nci4/B41QF+oBe4qv8ng7lSjST0iQqji29tw2osdDUE=;
        b=aP9C+IyTKoKMPM2XaM/U15dglSfGqzh061hkj/rvF9vuM5XljVpk7SPFsdGPvEYDds
         Kvg7SKyixngsWSV0FnPJpILLD+5F33v1UjJwTLUSbpAr/U8Hs5H0oJhpM3o/UHd4o4xH
         BX5Ojkys2C45khxCt5aJerrG9qXY9MCj3N9GQ87hrWvC4T7yHeulPq2WYMpV+YG3Xq2G
         neoYG+nN0zeUWkflK4Rs6hSgiMiOiYoO7OizO96P4Vk3SHaTY+sF4YqUxIKqa9JYKmo3
         /8ErCaBg4b73oNwkQUteO0PESZ9GGZ4ASOa2NtDzvSet+7gZd0vonSWtgUJcZWk6RSG9
         tY+A==
X-Gm-Message-State: AOAM531t3zlGWm20YYVbwsLnd2MgiRYIPoy/Vu30lYs32HER0lcqHQTU
        gcz6V7weT9iFFLi7DFr/CliMofGKlJc=
X-Google-Smtp-Source: ABdhPJzyPvBNhOVWwvtm2OiBhbOqNt8xeGdpW6vU2u5fiMloYNfAY1+MP/eKZuQfQKu8ZiP13bfSuQ==
X-Received: by 2002:a05:6830:1dac:: with SMTP id z12mr15390372oti.52.1631026060234;
        Tue, 07 Sep 2021 07:47:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7sm2244637ook.8.2021.09.07.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:47:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Sep 2021 07:47:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: QA: Monitor Linux log messages as port of release (candidate)
 testing
Message-ID: <20210907144737.GF4989@roeck-us.net>
References: <458e0604-1fe9-bed0-d22f-84540b05ffb1@molgen.mpg.de>
 <20210907125354.GE4989@roeck-us.net>
 <38ac012a-c16e-1ba0-b386-156bb8ddecc4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38ac012a-c16e-1ba0-b386-156bb8ddecc4@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Sep 07, 2021 at 03:50:39PM +0200, Paul Menzel wrote:
> Dear Guenter,
> 
> 
> Am 07.09.21 um 14:53 schrieb Guenter Roeck:
> > On Tue, Sep 07, 2021 at 10:40:31AM +0200, Paul Menzel wrote:
> 
> > > Thank you for testing release candidates and releases [1]. Is your test
> > > setup documented somewhere?
> > > 
> > Not really, except its source is available at github:
> > 	https://github.com/groeck/linux-build-test
> 
> Thank you.
> 
> > > If not happening already, could the Linux messages (at least up to log level
> > > warning) also be monitored? For example, in Linux 5.14, a new warning snuck
> > > in by cefc7ca462 (ACPI: PRM: implement OperationRegion handler for the
> > > PlatformRtMechanism subtype) [2], which could have been caught early on, and
> > > fixed before the release.
> > > 
> > > The test summaries would then also notify about possible behavior change.
> > 
> > Logs are available and can be examined at kerneltests.org/builders.
> 
> Sorry for being blind. Under *qemu-tests*, looking at build #1831 [1],
> clicking on *stdio* [2] under *Steps and Logfiles*, I do not see any Linux
> logs.
> 
> > Reports are generated manually, so it would be way too much effort to add
> > build warnings to those. Besides, logs are way too noisy to be useful in a
> > summary e-mail.
> 
> Just to avoid misunderstandings, it’s about the Linux run-time logs.
> 
Run-time logs are only provided if there are errors or runtime issues
(crashes, warning tracebacks, or test failures).

> > Also, Geert's build reports already provide build warnings and errors.
> > The same applies to reports sent by 0-day. Indeed, I do see at least
> > one 0-day report against commit cefc7ca46235.
> 
> How can I find that report?
> 
I just searched for the SHA.

https://www.spinics.net/lists/linux-acpi/msg101721.html

> > What would be the point of adding yet another report of build
> > warnings on top of that ?
> If the functionality already exists, great. But to be clear, it’s about the
> runtime logs.
> 

If there are (new) runtime issues (crashes, warnings, or other test failures),
I usually analyze, bisect, and report the problem against the patch introducing
the problem unless it was already reported elsewhere.

For example, there is currently a backtrace in arm64 tests:

BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163

which is due to ACPI code being called from the wrong context.
Another example is the cirular locking problem reported in various
mips tests, from mtd code. Both problems have been fixed in -next,
and the fixes will hopefully be pushed upstream soon.

The qemu tests do not log build warnings. I used to do that, but it
was way too noisy (some builds used to produce hundreds of build
warnings). Also, there is no logging data if there are neither
crashes nor warnings or other test failures, for the same reason.
If you are looking for complete boot logs, I'd suggest looking at
test results from kernelci.org.

Thanks,
Guenter
