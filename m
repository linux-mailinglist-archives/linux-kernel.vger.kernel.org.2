Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E94424D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhKBArd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:47:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC4BC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 17:44:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x19so7951810ljm.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wp3R+DkLsT+T3YFoaJRIQIAYG7GAntJAXplDMUWd84=;
        b=QtBmRWZR83NCW2csJHPlbE12FMx+9r1wlUflS7a1ivTNjOWkmht93vyMN+4cUmk7xz
         fI++ujKaX5Xmgic2PeRnf55VSeBcdPabRbOfUKwhlS8puywYcn5QxRXi0dM7BDOc4MG1
         S4lO208Qp7TtLEtNczYjepazrKZhJCYWvruSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wp3R+DkLsT+T3YFoaJRIQIAYG7GAntJAXplDMUWd84=;
        b=tXvDkVL7xgFaXQOqJVidBSEXrW9JwI/XUgfWctU9OSwdGT4ja4RQIJ1TsvkSEjf7p2
         O8akS/PipfcbyGbOiAizco22jNB90SyPtnwuRa2mHQxv/2nDmOQtIKCM97U4wLm+lqcb
         wmuUIFpH6M735ubLe+K1dlFdYrDBVjQd9yTOi2uwLEIaK5V1Kte5GxGe5wuiLSzKH2e0
         3NBvmrc1ZtjT/pt9lqEmmkNW9a/KTnG4i1KFZD1W0ytfLYvLjf8+5tFPSsh5B2+J5Q7Y
         1zxsOKiy8N2VK54LkqDy1iQ+RP1ANvRhgCo+yF8If1TS4odY+0LRGx7XGC8KL9BLe/EV
         EOzA==
X-Gm-Message-State: AOAM531vNPR2AxUO6AVDYQ01cZhmoT29/ZlHfSjnlQjcoHaMWzDNljLf
        fdMxrNWNFBn9U7h7hV3tqCQoOo9oiKddd0Ip
X-Google-Smtp-Source: ABdhPJwDH2sSJg1FuNCcWVsNQWXEuFscCu703WcHjRxxDx59a9gbJgpMxMEeCujraGO9CT0UaD1xMQ==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr36552714ljg.158.1635813896420;
        Mon, 01 Nov 2021 17:44:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f6sm59843ljk.45.2021.11.01.17.44.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id g3so984412ljm.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr34106005ljb.56.1635813895143;
 Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
In-Reply-To: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 17:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
Message-ID: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 4:59 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - Add LSM/SELinux/Smack controls and auditing for io-uring.

I started doing the merge resolution, and then I noted that there is
no sign that this has been discussed with the io_uring developers at
all.

Maybe there have been extensive discussions. I wouldn't know. There's
no acks, no links, no nothing in the commit messages.

So I ended up deciding not to pull at all after all.

You really can't just decide "let's add random audit hooks to this"
without talking to the maintainers.

And if you _did_ talk to maintainers, and got the go-ahead, why is
there absolutely zero sign of that in the commits?

              Linus
