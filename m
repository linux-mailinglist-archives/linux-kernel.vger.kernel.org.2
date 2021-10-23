Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796E44383CD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJWNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhJWNeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 09:34:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F627C061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 06:32:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so4688309plr.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuIaLCMcDEM369IISxPV7zzCb/arzy8V+3dfLhg5fFE=;
        b=RZyqXddBBH9QsfNlSpiDzlrapdAqMfGvlZVStbzf04n+KRTcygGUnozaFPLIoHN6Xr
         ojpybP17c1XmTNceTm0k/UbW3p961vAqnNbHrY3JECEeLzq4JJZ0+1o6bxWb1NduWWgw
         yJr6UP45eQsFklL+JoDhLlT3g0ddQ4i74Ak9DJf+isZG+66qrA1TIseEJi8xkS7WTUx7
         atwvdnySxzQx/xy4YxnFhBcHTxNREPwqaT+cREIgCW+vHBrnar3rMITTlV3q0vvrOXhm
         TrfzqK1msenxNbp96oawjijMbNSYMfjhEj4/A38RhLvt+7gs9WINBf5csGWQWwoXyDdJ
         oxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuIaLCMcDEM369IISxPV7zzCb/arzy8V+3dfLhg5fFE=;
        b=7MZq6o1wqFQh41XsxDYG8nB/GLcPeiDkhRodr4MZR32w0XqP1td3f9pV3WGwoiJvqt
         lM88mSPFRlaHErazyjIRFw383vHuFk4693tBzUd7STz7I8KClFb8Fz92jtKGUYaNalYb
         /0yBaxaS+wfcSpY6z9M4v3s5smsp1aWu93pWcoCqnPiFVJ6J4vptMwp54CWkA+EmlAqn
         2fi2UkQBNein67Y7ifNf2/pxSPkTzgDDqoGxUltv+UYnZBLbQYWb7P7uBQ6taQuC1qy3
         qVUeJGFkvG+MxfzpzTUiLXf6oSagkCtFLAdBHuN9xFCjurDgB5x2Fm2klvUBTGmzBuJ5
         o+ww==
X-Gm-Message-State: AOAM5339I0jz5gfXwF5Q+KpyJRnxa1FEhgrALUR3w4T2SbZCE7iGyIWZ
        hUmwF9tuqOynuD6OZ2F7fZyKnw==
X-Google-Smtp-Source: ABdhPJxbQacCtpiovt97B4gZTzo6wbNRQoow0Lb+DW+mMFONZh2kEgkGiUQmNXdcIv0VbQkxF9Z9SQ==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr1157355pjb.96.1634995919733;
        Sat, 23 Oct 2021 06:31:59 -0700 (PDT)
Received: from integral.. ([182.2.37.49])
        by smtp.gmail.com with ESMTPSA id h1sm3927542pjf.10.2021.10.23.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 06:31:59 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Date:   Sat, 23 Oct 2021 20:27:15 +0700
Message-Id: <v9gnbpcz7rxYUfmUijR-ammarfaizi2@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211023090246.GA4323@1wt.eu>
References: <20211023090246.GA4323@1wt.eu> <20211018045828.GA15329@1wt.eu> <O2kEogG8Ln8uUQ-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Oct 23, 2021 at 4:02 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Ammar,
>
> On Mon, Oct 18, 2021 at 01:53:29PM +0700, Ammar Faizi wrote:
> > Got it, agree with that. I will address your review and resend this as a
> > patchset v2 soon.
>
> Just checking if you have anything about this or if you're busy. No
> stress, it's just that I prefer to send batches to Paul since he
> rebuilds and retests everything each time, so I'm keeping your first
> patch and another one on hold for now.
>
> Do not hesitate to let me know if you don't have time and if you want
> me to rework your patches myself.
>
> Thanks!
> Willy

Hi Willy,

Sorry for the delay, I got extra activities this week. Sorry for not
giving any update lately.

  1) I can send the %rsp alignment fix patch. I will send it today or
     tomorrow (GMT+07 time).

  2) I can't send the syscall change used for exit. Because I only
     have x86 machine. So I can't apply the changes to other arch(s).

For (2), basically sys_exit doesn't close the entire process. Instead
it only closes specific thread that calls that syscall. The libc uses
sys_exit_group to close the process and its threads.

^ It's not really an urgent thing, because the nolibc.h may not be
used for multithreaded app. Even so, I don't see something dangerous.

For (1), it's urgent, because the alignment violation causes segfault
if the compiler generates aligned move, often when we compile it
with -O3, usually that happens with SSE instructions, like `movdqa`,
`movaps`.

Preparing the patch...

-- 
Ammar Faizi
