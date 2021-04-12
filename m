Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1239235CE87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbhDLQpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbhDLQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:35:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18052C061247
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:28:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w8so13872441lfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZnpGTTVy12LfI0sdZ4E7fBRBWOOqVoEC2alh6kMWDY=;
        b=ETzMw5s2kXuc9Y/2ra+bvdUF33rGFaBIkySx0hcWLWbidoSKgMVim2dAvjamPpV0QM
         4TyYhczD2W2l+0e5Njug1LuCt5A6wO1oEXj8ZDZXUo+eIaFLexZJcPDPlggOza31nZ1t
         ApPObtQ9fKw6tJfPWayLLxkYUpk9TiOIbuaW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZnpGTTVy12LfI0sdZ4E7fBRBWOOqVoEC2alh6kMWDY=;
        b=MUANPKNZs97OzzUA2ATqezJZU3Lzl8kBHcWSHxFUkZuj8RIgu+0JgT4ZpyZYR7ox+I
         UKPHtEZbjzs8S/RmJvcU/VrBKOljMx6BPadwleJTckuC0uIZMo3dHPqXy+mBSKuTQb7b
         PwCQWYQBf0XkQllwOjj1SLoktQD46cd4i89s0IRxMo0TawcPVbvYAU62NM+pJ+1H1dnm
         XZZPxYtFvZozTyhK8UIpXF52F4/EKAv8uYFgbbff17vu3viQF4k5vjbvBzRQiIUo3hnL
         oVrhKSpiwLfcHVa8PcMFF+qpQ4cfJEsQ0SjMcVttT6gSaYMHRTfg3OiJYfywUJNjFJyu
         eezA==
X-Gm-Message-State: AOAM530jedWE3gW/w0xnIIPUDnRnEp9WpVF1kpIlWYs3eXVYDh1z5EvB
        dFjH3F0QU4rvUW989ajPoF7i7C0PZiSBx5Fu
X-Google-Smtp-Source: ABdhPJxmxtARoxQDpaKu5f6HuwILhEYpdpehg/gG8Xfb+M14HqGezHb22QjoC0IPfoWZJx/IITabLg==
X-Received: by 2002:ac2:54a1:: with SMTP id w1mr14702124lfk.48.1618244925477;
        Mon, 12 Apr 2021 09:28:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n1sm919268lfu.282.2021.04.12.09.28.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:28:45 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w8so13872362lfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:28:44 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr18962348lfo.201.1618244924698;
 Mon, 12 Apr 2021 09:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
 <20210412051445.GA47322@roeck-us.net>
In-Reply-To: <20210412051445.GA47322@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Apr 2021 09:28:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYcwWgSPxuu8FxZ2i_cG7kw82m-Hbj0-67C6dk1Wb0tQ@mail.gmail.com>
Message-ID: <CAHk-=whYcwWgSPxuu8FxZ2i_cG7kw82m-Hbj0-67C6dk1Wb0tQ@mail.gmail.com>
Subject: Re: Linux 5.12-rc7
To:     Guenter Roeck <linux@roeck-us.net>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Qemu test results:
>         total: 460 pass: 459 fail: 1
> Failed tests:
>         sh:rts7751r2dplus_defconfig:ata:net,virtio-net:rootfs
>
> The failure bisects to commit 0f6925b3e8da ("virtio_net: Do not pull payload in
> skb->head"). It is a spurious problem - the test passes roughly every other
> time. When the failure is seen, udhcpc fails to get an IP address and aborts
> with SIGTERM. So far I have only seen this with the "sh" architecture.

Hmm. Let's add in some more of the people involved in that commit, and
also netdev.

Nothing in there looks like it should have any interaction with
architecture, so that "it happens on sh" sounds odd, but maybe it's
some particular interaction with the qemu environment.

             Linus
