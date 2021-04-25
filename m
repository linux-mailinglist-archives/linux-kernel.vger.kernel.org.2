Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E098F36A9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 01:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhDYX41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 19:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhDYX40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 19:56:26 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62640C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 16:55:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso27989512otl.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 16:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9lPtXooIdT1tUZPsR4uol16UV/mbjeFq41uqRxKYuNA=;
        b=PmyeB27lVFddy/v1mEISExHgeJVeCDB6BFapI9qNG5dW9kNrx+ZADYg2PmlP8koZZp
         Pak6xMtzMoa374qJJnIogWOBIvhBJZfQi8KWIDdBdWN6nq3Na9iLuOoThJXqfXLvrE0K
         6ZIFV9S3RBVJnO+EfSGITGEB7lriOcWYhKtN97cqcniK48xg+bwTEMiyF+0DjFBMG/nE
         ES3xJ1wVSEC/+dl/ph7Xb+NCT/4M9Sp4ieYWYZFN6qi4DObLeR/aHSbOb5l9/DRjykuh
         l3LwoQHWSfy2UkmbktL1AYw7Ts+wPQ9djSUVJ5vn73aN2tGo0TE8wLE3gu9EMgsprMEw
         slKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9lPtXooIdT1tUZPsR4uol16UV/mbjeFq41uqRxKYuNA=;
        b=auzYwk0eYeLEcfZWfvaocPc0pEH/haXPyub6mjzVD4+JwS4/Rfn+R8ik2TYta0BnkP
         GYLNlcBqCNAZn9w4K7oizQaVnSMXAKcB4lPcjVSSnGbQCCeDP1oUF1qkRI6i07eg1yPd
         UgjkmYk0GlFrmx+GfmO0/CAg/W/ouqRtock4qF2ThqYkjZKOLaKIhbu5sGT/3gxJusE+
         UELIBjMLhoryEmsy6V0wvgQsPALpti5ZhOixYrzi4NuQ3G5a+wvMr2lvnKweeLpKeEuE
         tebVAXVOQgN50sIC0yU1Z3dGW7HNffdvsMFM8+3tbfjVIZ4lD8ORV5wN99Mzr6wSHPvV
         ybZw==
X-Gm-Message-State: AOAM532qW0S8PdIv8ZiYtmcnLMlpdTv5IgNmM+xm2vZg9eMzDkFQvuqm
        Lwuv4RnowDnZW9uHpX9qiMlqfhJXWEE=
X-Google-Smtp-Source: ABdhPJzXuQUjQD5B5yFSzdQBaqQm8v1LZdbmho2QJlIm6aC8p+lbVnJdKmbANrScVLyq7W4M+tnSdg==
X-Received: by 2002:a9d:d05:: with SMTP id 5mr12595347oti.312.1619394944643;
        Sun, 25 Apr 2021 16:55:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z123sm2574339ooa.7.2021.04.25.16.55.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Apr 2021 16:55:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Apr 2021 16:55:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12
Message-ID: <20210425235542.GA116247@roeck-us.net>
References: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 02:06:35PM -0700, Linus Torvalds wrote:
> Thanks to everybody who made last week very calm indeed, which just
> makes me feel much happier about the final 5.12 release.
> 
> Both the shortlog (appended) and the diffstat are absolutely tiny, and
> it's mainly just a random collection of small fixes in various areas:
> arm64 devicetree files, some x86 perf event fixes (and a couple of
> tooling ones), various minor driver fixes (amd and i915 gpu fixes
> stand out, but honestly, that's not because they are big, but because
> the rest is even smaller), a couple of small reverts, and a few
> locking fixes (one kvm serialization fix, one memory ordering fix for
> rwlocks).
> 
> Anyway, this obviously means that I'll start the merge window for 5.13
> tomorrow. But I'd ask that even developers champing at the bit to get
> their shiny new code merged please spend a bit of time running and
> checking out 5.12.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 461 pass: 461 fail: 0

Guenter
