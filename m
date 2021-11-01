Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F76442231
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKAVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:04:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39354C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:01:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 1so25522440ljv.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDtjUUVqt9XgvCkiF8UV0KJSKzhaYXkrtMs8KFbWrS8=;
        b=hPlSVyiXX/EZBkKOxYuDez+7b2s9EUBNHI/pp/DKfeLZli1omRWqcAGTxbn/5TAS8z
         NJPd8Bgj9Ptqffd6oVyG6WnhPvGFs4ImDDyBqKaaOvb0rdUVSWRJnrEtrdVKms2suzuB
         rz0fLtDEJjfR5SXuE0F5Ta++vm2izjISjipIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDtjUUVqt9XgvCkiF8UV0KJSKzhaYXkrtMs8KFbWrS8=;
        b=NuS3ei/EKrB4gNOwWy1JmBaCd5+nL9LW612HT24YP5B+rgvSihiq38RmescVwFKr0z
         +gJC9+oqAo1JjmxHxoSz+QDEZqASD1Q/6QbOXU2UfQsEeqyGCBH9Tap8vURNdhnhH4on
         JBSKWKByyi6nF2GZW2izrZMShBGR12EoKI0YVxztbok68uk5DyxpV013t/h1ceTSyYOe
         fBtExplfHhessvJX+QhDeb01f66O50AThzhrt0G4tgz5nbo1dZJAIaKJIcg9brjlDwP2
         UmQuy9xrh6EBP5XXdNuGDvuIUQzK98YkL3x+F4imxJYoboOSIylUtF9MT5QKvNjdTpF0
         YWkg==
X-Gm-Message-State: AOAM532cySDIEZ67ymBJoZkLsy6GnO876ZE+ftOtzOU4NaaLI3Qrc1y2
        QMeryJBreO9flAgCyfN922kiXkHiMOpiNYsa
X-Google-Smtp-Source: ABdhPJwkuPAMRxe2gn3Rp4yNcFks11UfpKSvT2HeY3VS+w0eKLCk6XyxGNIT590asHY71Swa8UIh7g==
X-Received: by 2002:a2e:505:: with SMTP id 5mr33522054ljf.310.1635800490330;
        Mon, 01 Nov 2021 14:01:30 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x20sm1500854lfu.196.2021.11.01.14.01.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:01:29 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id c28so38677491lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:01:29 -0700 (PDT)
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr30843900lfg.150.1635800489198;
 Mon, 01 Nov 2021 14:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572864855.3357115.17938524897008353101.tglx@xen13>
In-Reply-To: <163572864855.3357115.17938524897008353101.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 14:01:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
Message-ID: <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
Subject: Re: [GIT pull] sched/core for v5.16-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 6:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Make wchan() more robust and work with all kind of unwinders by
>    enforcing that the task stays blocked while unwinding is in progress.

Ugh. This not-very-important data is protected by a rather core lock.

Is this yet another example of "unwinding is so fragile that it can
screw up unless we take a lock that is seriously overkill for a not
very important operation"?

Unwinders that need locks because they can do bad things if they are
working on unstable data are EVIL and WRONG.

I guess I don't care too much about the pi_lock, and the actual
unwinding is hopefully done on tasks that don't care about it, but
this smells suspicious to me.

Why is that "stable wchan" so magically important?

               Linus
