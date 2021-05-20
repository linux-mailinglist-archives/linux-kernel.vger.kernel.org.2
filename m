Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7018638AF41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbhETMzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbhETMxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:53:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621515108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3xFIgLG8VbxqA7fAkiqQPj+DCPXmppnaBD63xBqlzI=;
        b=bxWFLS6UXQgyC9XUY5Qp33i3La8iQhK2xQ6rfqUKBF26CuP0n9pC+hRKMiKgNg4wowGSFP
        XWeZEisHXG0FIesJfWK8jyaY1D/OH3qhM2WUWt0ZxsZtSin4eqDRvEi4+Eg4cHJMViwIwO
        XGrk8Pl7lDAl2IJY2z9KHQQWiHvNM8KJ7vcQmv7GWJpId13gu8sGWif1umxVK7X/ckrPd7
        N0gO/8NY+tGs2nlHgIiHQx8DpEaoYN/jo1qc46XCunJWzZAVn4XsktH3jyYX/syvEA1RNj
        ViF9E7KYhv0kn3D7t7WwabSzSNzkQU0J4BqxKtIMA4IBzgNa9DyjqQjyrQbbTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621515108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3xFIgLG8VbxqA7fAkiqQPj+DCPXmppnaBD63xBqlzI=;
        b=M9gPm8uAE9Si+m0qKumiPUGsYCH9/on8NpNwsWMpHH03jjOxa97fyMSSHvkjumE7ixeRWG
        V0+md2ta4rFy73Cw==
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        X86 ML <x86@kernel.org>, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: BUG: unable to handle page fault for address - EIP: __kmap_local_page_prot
In-Reply-To: <CA+G9fYsogFQZSeFyGinZ_EQOEW11cmU5oxuEoDuwyCVNaXv3yA@mail.gmail.com>
References: <CA+G9fYtAbUGO9oAtL8eZ9Pu-_a1wx3y8Tk=pDO3Fh3dEwoRGWg@mail.gmail.com> <87mtsqd0c1.ffs@nanos.tec.linutronix.de> <CA+G9fYsogFQZSeFyGinZ_EQOEW11cmU5oxuEoDuwyCVNaXv3yA@mail.gmail.com>
Date:   Thu, 20 May 2021 14:51:48 +0200
Message-ID: <87tumxbmaj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20 2021 at 12:40, Naresh Kamboju wrote:
> On Thu, 20 May 2021 at 00:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The below patch did not solve the reported problem.
> after applying this patch
> CONFIG_HAVE_MOVE_PUD
> disappeared from the config.
> but still i see WARNING: and BUG: when running LTP mm tests.

Yes, but that's a different warning ....

> Test log link,
> FYI,
> i386 kernel Image running on x86_64 machine.
> https://lkft.validation.linaro.org/scheduler/job/2749690#L10139

Sorry, but this webpage is making my browser go apeshit and finding
anything in that gunk of user space messages is a pain. Can we please
have a proper plain dmesg?

Thanks,

        tglx
