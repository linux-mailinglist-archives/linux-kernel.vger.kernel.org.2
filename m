Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54F415273
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhIVVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhIVVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:12:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B37C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:10:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g41so17266517lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GP6CZBA3eD/IT4DzplzBkxmwKra5+3ru6Q3LIyU/W9A=;
        b=KqSSJtCeked0SA1tw/NjFwzUk1jRrGMLi5V8kYMtiu7V4P6830H33s76KRGF3uMy6N
         u7Pc12nQ5gfzOhaoMByd+dxZFQ0sG8BD0uu2/A+2aejrflzaBvY7PnAXLpGDxOCK2wkT
         mb1upbY4uHLAqEGFsh3W1U9+aPS45OucgtjF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GP6CZBA3eD/IT4DzplzBkxmwKra5+3ru6Q3LIyU/W9A=;
        b=lkl6jriAf4CmeIp8yiju7tlhEVFWC0F62IVCTm75J6yTBIqKQyRNEnycwvEjAvf2V3
         aRTPc+LMUR4tBscN3UiTJY8cWnmgknzYb1M5yFvcr13hTswlapsmilEBzqpv49ko8ZJe
         egaGjKlSGJfHd2XKJWiIJJXG0wG4EwMr/Dj7lTJMUPFWBE6NqYyk7zQ4i/LvLrMOvbhP
         qyqMScBO1GxxskoUjo2svuo2Hw/ZN883aIxaP7/cOKOB0p1fbfndh1I05LCPeYAj6ZaV
         QUyiY9Cf1CVb1irujPeRDI47Pg8AmzhV8OYttCBtYVOnjbSwEn0/BK8EOv9YXG1XALeW
         3Q1A==
X-Gm-Message-State: AOAM532kPRstAGaYz3aK/xwaHa7ARItmR/XFbYu3PKzMHEfjuNN+3ZK7
        PwLPzWHsxzVksa6m3pMvDb/raqHJcpdcImYefHc=
X-Google-Smtp-Source: ABdhPJxHvrSCib+RrAKshS05W5gD3N6nQ3S5Wfqc3StazeOjlc5czL2E5LOBhwySprRrMXyFpVJPYA==
X-Received: by 2002:a05:6512:3f21:: with SMTP id y33mr1023370lfa.606.1632345052016;
        Wed, 22 Sep 2021 14:10:52 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n9sm263829lfe.188.2021.09.22.14.10.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 14:10:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id b15so16837402lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:10:51 -0700 (PDT)
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr1466277ljd.56.1632345050955;
 Wed, 22 Sep 2021 14:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com> <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
In-Reply-To: <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 14:10:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
Message-ID: <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Make the regular security_locked_down() function do that, and add a
>
>     if (WARN_ON_ONCE(!in_task()))
>         return -EPERM;
>
> so that any bad cases get flagged and refuse to continue.

Actually, no, I take that back.

It's not the "!in_task()" case that is the problem. That's just the symptom.

The real problem is that we clearly have some lock-down rule that
seems to care about credentials and who it is that does the lockdown
query. That seems to be the real issue here. Doing lockdown checks
from interrupts should be fine.

The security layer really seems to be doing odd and random things.
Maybe we should have some debug switch with the above WARN_ON() inside
current_cred() (and a number of other 'current' users too). Just to
see if there are other cases where people look up basically random
credentials.

When the security layer is confused, that's not a good sign.

                 Linus
