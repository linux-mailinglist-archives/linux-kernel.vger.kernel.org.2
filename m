Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC0403DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349772AbhIHQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbhIHQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:37:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52EC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 09:35:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q21so4519261ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/CD7q4lRf3l90tKGwh31iBz8sR18RIbkvh+kQs4q6M=;
        b=f1gpcvbBjzV0Vm0wz7RQH8RDntk92/pjFLLx32TukeAf+s+smWjbD1JJKUuyzC5Y+P
         cvIXCoAfcv5/effowPdo9BrzGu7kYvv0jdQWDzZcdGyKP/TJIAqnMjZ/AYmoMwyaOone
         BBnGnX1ZMy1EWSCZSlABnG0LSuu6IbSx7eZQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/CD7q4lRf3l90tKGwh31iBz8sR18RIbkvh+kQs4q6M=;
        b=C0xgpmQVBugPPbyVXAcsg00/q4HxHxTF5IBcBSt7I780rLsQDBvRcHpHjVx7qpJ5qU
         jqcPG+/etOOGLEm5IUtPV+wkfcdK3maeSbJKzPtHaehGeJD8lf//wwkSC5jw0LyA/ENk
         xBVuL2MBIreJfNJTf9A6bHUzmN7l5lsrm607aj3lFYcbXo3aLRorQDttUk1CV5tmmmQP
         9YI9ALo2U3aAC9qL0XhO2ySgN/z2V9L+GTeofjcKl7DuTtrhs/mzsX3kvbhOZn1IN3Za
         OvOMqHKYsdskpegUHbZa4JGXngghMEsvjFz42txchixZ3GncMM9thWah5L7VPioZT3Rz
         d4rA==
X-Gm-Message-State: AOAM530H499kMmYEWuFG+0XxJNYRcSE4wK1Z9pIdBd+dodIY5PGIlq45
        PUaXXJwijUAJEPhYgBEuk9KQnsv7zu2Lko9HQjE=
X-Google-Smtp-Source: ABdhPJy3b3VvPPlP0Aqfy9mVhB8BfhE5joHi2zQxjiyZoRJDHzZAndRXvGvLetiVYq7tf7eTSKoQ9g==
X-Received: by 2002:a2e:9049:: with SMTP id n9mr3500821ljg.425.1631118949156;
        Wed, 08 Sep 2021 09:35:49 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j10sm233507lfk.224.2021.09.08.09.35.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:35:47 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id y6so4543826lje.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:35:47 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr3409449ljm.95.1631118946988;
 Wed, 08 Sep 2021 09:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210908151407.217052-1-linux@roeck-us.net> <20210908115350.555941ba@oasis.local.home>
 <0e88250a-21ac-800b-e6e4-eb7dc459b04e@roeck-us.net>
In-Reply-To: <0e88250a-21ac-800b-e6e4-eb7dc459b04e@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Sep 2021 09:35:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+GSbv4ks-vo8d33nZ7n_HTEhhcFtog=r7Pr+hrC_V-w@mail.gmail.com>
Message-ID: <CAHk-=wi+GSbv4ks-vo8d33nZ7n_HTEhhcFtog=r7Pr+hrC_V-w@mail.gmail.com>
Subject: Re: [PATCH] trace/osnoise: Do not use 'main' as variable name
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 9:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> FWIW, it wasn't gcc 11.x, it was gcc 8.1, which is the only gcc version
> that I can get to compile nds32 images (more recent versions either fail
> to compile gcc, or fail to build the kernel with assembler errors).
> I'll just stop build testing nds32:allmodconfig instead.

I'm actually just about to go back to that patch, since I have been
reminded about it independently by a couple of emails now.

So the 'main' noise will go away shortly.

              Linus
