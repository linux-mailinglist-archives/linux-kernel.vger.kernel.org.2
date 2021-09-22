Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA38941540E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhIVXpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhIVXp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:45:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54671C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:43:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so18971233lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9k72VTW22NLqhNCFibUNzlVRlOLQo+ivDkN/xGzIL0=;
        b=iAQ5fOkNypbYTDMHDwefmxHPG3BnavaFtPjdsc6K5IFf8v4Aa05F1WOz/dqXf9D5eN
         VU9v9NDhqobgAH7LoBpnsbaNZxLD7pRX/kq2DnHdo1fZh5AcIdAV8GkZH4839jcnx9EZ
         W1YcQ3jdEj1KMiYH+mn3Qra281xA8lW3Id9vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9k72VTW22NLqhNCFibUNzlVRlOLQo+ivDkN/xGzIL0=;
        b=4XaYzVg3GgKFIsaGUGW+WHLetpcZ4wvBL8T+l/M0GE1u/GGzQF5+P/BDkkHP13QJSh
         4SSy7j74LPqrcL5QOO1oF3sgKLxe++OorAYv3GFnDKiGheO1cyRtzeFQYzVfB+jdaras
         CFoGZ1mwMQAFtHidcFyj+T8LchLmqS05zEh/FPR+1Lr58FZfggMvq5dMncpjBn7Hghhz
         i/iN0kNRSq7Uzxu6mNOx9Lae/Cs1SLBfNDEUI800zfD46gnZL0TOlaNXH+rCmO9NHQZB
         /IxMdTBAHOhMJ8WVngVvd+Ah6cmoE2EaR5l+/HHZBKmeLlAqgLYe6q0+nmVLEeKKR5UK
         rHaw==
X-Gm-Message-State: AOAM530APaRiFNTe5lAiX0PxkJziYJkb5GwVy6kn1MbxIEm5rFKAeOMz
        HGJzCfRoq5moqh+LM92vs2gvWSCq6qM73arWwxM=
X-Google-Smtp-Source: ABdhPJzMTHhvk0w+7PA/EsHn77tESR+xblRq8EwrY5TqBFTJznY7URRmLn+XxHWSyxCHqbUIkNcbmA==
X-Received: by 2002:a2e:6f1b:: with SMTP id k27mr2054847ljc.117.1632354234203;
        Wed, 22 Sep 2021 16:43:54 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u13sm290749lft.132.2021.09.22.16.43.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 16:43:53 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u8so18242208lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:43:53 -0700 (PDT)
X-Received: by 2002:a05:6512:984:: with SMTP id w4mr268356lft.141.1632354233111;
 Wed, 22 Sep 2021 16:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com> <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
In-Reply-To: <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 16:43:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
Message-ID: <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 2:40 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The basic idea, or problem from a LSM point of view, is that in some
> cases you have a user task which is doing the lockdown access check
> and in others you have the kernel itself

I don't understand. In that case, it would be a boolean for "kernel vs user".

But that's not what it is. It literally seems to care about _which_
user, and looks at cred_sid().

This is what makes no sense to me. If it's about lockdown,. then the
user is immaterial. Either it's locked down, or it's not.

Yeah, yeah, clearly that isn't how it works. Something is very rotten
in the state of lockdown. But that rottenness shouldn't then be
exposed as a horrible interface.

Why has selinux allowed the SID to be an issue for SECCLASS_LOCKDOWN at all?

And why is selinux foceing it's very odd and arguably completely
misguided "lockdown" logic onto the security layer?

Yes, using "current_sid()" in selinux_lockdown() is clearly wrong,
since it's not sensible in an interrupt, but lockdown questions are.

But why isn't that just considered a selinux bug, and that

        u32 sid = current_sid();

just replaced with something silly like

        // lockdown is lockdown, user labeling isn't relevant
        u32 sid = SECINITSID_UNLABELED;

and solve that issue that way? Just say that lockdown cannot depend on
who is asking for it.

         Linus
