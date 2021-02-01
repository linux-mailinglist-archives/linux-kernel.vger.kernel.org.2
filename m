Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B548530A1AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBAFxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhBAFuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:50:02 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:49:13 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i20so15169570otl.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WF2alet6JgVDdHzOPxDujjaMDaBGqq2XJ+qxL2r7NA=;
        b=uwb4NXUI+XRYJBe83fi9EwODkFwNDCTEMXSskzJPmClnVAs1KR0r1XGiZSnclRHwHU
         tP/EMcEHtb0ZtMcXo9sJ7GHEzANZ30pxT/fUqIpW9nsC+frinO97IvNSFNZwv23+WYYv
         BAZYfys1nUobzHt+lGRXn8HK9FRAUCOkcFbCpVmLc8zCuQKciIId48Tq12A6CKs1Q4QH
         01HZdXvPRjc+YxzlOlFWNglx3NXiNuJjU3dWQLXBmwmxIhq9Z3iwSb7fzdpQWr82hSh6
         1eQSXIT2nt9nefeej6JUS8PF4JYFdZSGOZCnhA4o59kVm34qH5YWbAyzAWLWD3qlYBMG
         ON4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WF2alet6JgVDdHzOPxDujjaMDaBGqq2XJ+qxL2r7NA=;
        b=Q5iCMOWZV+VWAGH0twDVc/Mskl0l3+Fwp63ckSztEVpEpFClB8oOd+bLfJX701ZXNv
         Gsca/BZDikDiuIi7KJNNwXeSMidBDT0TvTQd1VD9xoR5k6A7/xf8D4gwo9kyasc1V+ZA
         ZRaNw+dAkYDXkv7Mk3lZRrAPYnCOP5sArwAw5VA+Y006eVfcdcSMRO02mKzZMVubJ+mh
         KTu/HwyA/0KOMF2ymiShdqBBpekE+MZVGctXPrF6doXQwDd1X4xE4JjVBQmWpHYSwZvf
         BLT/MOWMzp2lJFd/nMZ3bT2wX+ngklCpKkBKFkAfyfqG/ktHq0cJAeRqkU0Wl/4pNjXb
         NfNA==
X-Gm-Message-State: AOAM5332BcQkuO6HkbF3oOwGzZ8n3+NpYWg6XRfwEwHFFT3ZC6xZo+7u
        RdVPKiG8oYxuvkxMJXnD3TEtNXYz41U=
X-Google-Smtp-Source: ABdhPJwgwpCCslI5sJLXgYUhPqp6KOwwFElrohrmuXzaeb82h3/VMPDILOy1JVjACjZ/BwowSRrk6g==
X-Received: by 2002:a9d:20a7:: with SMTP id x36mr10579209ota.172.1612158552644;
        Sun, 31 Jan 2021 21:49:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14sm3991106ooj.26.2021.01.31.21.49.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Jan 2021 21:49:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 31 Jan 2021 21:49:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc6
Message-ID: <20210201054910.GA58001@roeck-us.net>
References: <CAHk-=wiOjOh4gNkg==Tyjho98cea06UtnZ4ePwMP3uK-9VLCNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOjOh4gNkg==Tyjho98cea06UtnZ4ePwMP3uK-9VLCNA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 02:01:43PM -0800, Linus Torvalds wrote:
> Things look a little calmer than last week, and over-all very average
> for rc6. So - like always this late in the release schedule - I'd
> certainly have liked things to be even calmer, but nothing here really
> stands out.
> 
> The diffstat is quite flat, meaning lots of small fixes, with the
> exception of one new LED driver, and a flurry of PI futex fixes (and
> one nouveau patch that is just a lot of trivial lines).
> 
> And all the stats look normal: average number of commits, and they are
> all in the usual places, with most of the patch being drivers (gpu,
> networking, sound, etc), but we obviously have all the usual suspects
> with arch updates, and a smattering of fixes to core code (kernel, mm,
> networking, filesystems).
> 
> A few known issues still, hopefully soon fixed, and on the whole
> things look quite normal apart from some mailing list hiccups..
> 
> Go test,
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Guenter
