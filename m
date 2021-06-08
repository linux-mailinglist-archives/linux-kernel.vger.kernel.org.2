Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FD39F698
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhFHM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhFHM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:29:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 05:27:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623155274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eq6F/tWEhhc8tNxPOo5+3bUumPQJPuM6OUl1sPoB/Z4=;
        b=VK7xdiBCtA8yJrNlaSRINjnxxTzDpE9p4I1GuMpLPW62URo5uoyjDIB1IEXrwrGfWqr600
        E0u+bfoxHnWwR0GLjpnE4WNz2Vv9pWDRODvK5dCP97yVhBWhsdd2CMKiArhmXyYBffOaoH
        Y/o/Ime2eZD392r62DEdQSuCUMoiISRqujvjkeDjgXsHbcnCWmIR/ysZuDLU66msDxWaDj
        YdRf3qnq4dAaAhQyil6R44iFM6VEWOM46LFGvgt9RiphFw78zAPdF68hOTUM7teRbtheBj
        vANAGQdGkG0ZA5NRZTgnsTRkPnrjq9mNQ/kDpxeiM3BKBkyYkPgqUpW+jXsF7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623155274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eq6F/tWEhhc8tNxPOo5+3bUumPQJPuM6OUl1sPoB/Z4=;
        b=CaRr1jRjdXX71CKZI4RCs3je4oR/TGJqf2X7K6lamh1Cnnpkz0SQwNDbm9jUD2Qj5yfcFp
        w8BsO8CkLin33HDg==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <878s3kzjtx.ffs@nanos.tec.linutronix.de>
References: <20210605234742.712464974@linutronix.de> <87h7i9zv3r.ffs@nanos.tec.linutronix.de> <eca0add1-849e-6a1a-8ea6-f6b72650c9c8@intel.com> <87eeddzs0l.ffs@nanos.tec.linutronix.de> <37df631f-9d3d-3035-6eeb-85ef33e580d5@intel.com> <878s3kzjtx.ffs@nanos.tec.linutronix.de>
Date:   Tue, 08 Jun 2021 14:27:54 +0200
Message-ID: <875yyozgl1.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08 2021 at 13:17, Thomas Gleixner wrote:
> On Mon, Jun 07 2021 at 09:38, Dave Hansen wrote:
>> On 6/7/21 7:08 AM, Thomas Gleixner wrote:
>>>> By the way, are you talking specifically about the _error_ paths where
>>>> the kernel is unable to XRSTOR the signal XSAVE buffer for some reason,
>>>> and tries to apply either init_fpu or the hardware init state instead?
>>> 
>>> 1) Successful XRSTOR from user if the PKRU feature bit in the
>>>    sigframe xsave.header.xfeatures is cleared. Both fast and slow path.
>>
>> It seems like the suggestion here is to inject 'init_pkru_value' in all
>> cases where the kernel would be injecting the hardware init value.  I
>> don't think we should go that far.
>>
>> If a signal handler sets xsave.header.xfeatures[PKRU]=0, I can't imagine
>> any other intent than wanting the hardware init value.
>
> Fine. But PKRU=0 is broken today...
>
> T1 in user space
>      wrpkru(0)

It's actually not wrpkru(0), but a XRSTOR with the
xsave.header.xfeatures[PKRU] bit cleared. But the rest is the same...
