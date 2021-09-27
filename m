Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E241A084
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhI0Utg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbhI0Utd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:49:33 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9F4C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:47:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v10so26895006ybq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlWbjGxhbYGI6aPovE04MfJwkVfFMUYH/V34f3oOVnQ=;
        b=SjCgp4wrt5kSPUeas8UpdhjsSOrHlPPCvG0sb+b4BlMQcAsF9JmkXJewZ+KY45MYiU
         msKfXRPzGNS27Csp6gieTQBsroIwEXK3P1HCcV2otx0HW2IltWp62ZPgFBXL5Mp2vq7V
         0UXgjdrGSkc+63s179XkzBC/SrOyf6tPgVOJvn/vXM+1dSbFIfSBrye1ZyjyqcwI+8n0
         oacYarYFFCdjXqP0u4KCNrWJCElcgCwKP5MnQZUOq8aS3BdU7tVw25Za8y3YGiTAIsbT
         QKhoK9pyQuU4b9VDl1wRl44WpGUeFs0Omo+cbYWwDeKSIfIslOEg/Q5m7piy/Yv+d4vJ
         quBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlWbjGxhbYGI6aPovE04MfJwkVfFMUYH/V34f3oOVnQ=;
        b=P21vYYLH/Tr4g4v9LSldeCKnZyGX47w24F58cH+ymHcupgZqqygNxoe/h5up5kRIZI
         O/XPdy4lzRKVkUfedO7YqcxWM0uKBBvrfa1NM9pSIfETJuLTsyPRYsvaU1ggl1zw7LVI
         XqUgefIMwuS3vLW42yZaQJG146iZHketuJRxNfCK5kH6rvb8ATTiId+1SpV06RNzE/el
         GflctJHEHg2IBcBITpZDW5MtkySxdg77UH4/8nAI6WoIyt7gkEirAU2xjev71+sbZMVs
         u45ZiuXroCYERUcZQIa9SB+3VGPk9zCJkR17lRmEZelGxz/WTBVuf3EZ+iZyNLDdfSLN
         QWHw==
X-Gm-Message-State: AOAM531V8JF83B4gdwK4LqLBM60op5EppQo7jFHT14tpVvqVEIB/AvIY
        +dNEY5X1aLP6Vbz6wYlM0v07qN4q9tzvXkA3//PTU6nsrf+cDw==
X-Google-Smtp-Source: ABdhPJwqcxg4MtDog6ZYOa5r1p+JBx8DeiZvPof5BqvjxC1KLLJUROLJZaIBtcUMdNntZGBW8QpAHCh9lmRWVuY6qIA=
X-Received: by 2002:a25:d258:: with SMTP id j85mr2355281ybg.398.1632775674567;
 Mon, 27 Sep 2021 13:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210927202923.7360-1-jlundberg@llnw.com>
In-Reply-To: <20210927202923.7360-1-jlundberg@llnw.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 27 Sep 2021 13:47:43 -0700
Message-ID: <CANn89iJP7xpVnw6UnZwnixaAh=2+5f571CiqepYi2sy3-1MXmQ@mail.gmail.com>
Subject: Re: [PATCH] fs: eventpoll: add empty event
To:     Johannes Lundberg <jlundberg@llnw.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Alexander Aring <aahringo@redhat.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 1:30 PM Johannes Lundberg <jlundberg@llnw.com> wrote:
>
> The EPOLLEMPTY event will trigger when the TCP write buffer becomes
> empty, i.e., when all outgoing data have been ACKed.
>
> The need for this functionality comes from a business requirement
> of measuring with higher precision how much time is spent
> transmitting data to a client. For reference, similar functionality
> was previously added to FreeBSD as the kqueue event EVFILT_EMPTY.


Adding yet another indirect call [1] in TCP fast path, for something
(measuring with higher precision..)
which is already implemented differently in TCP stack [2] is not desirable.

Our timestamping infrastructure should be ported to FreeBSD instead :)

[1] CONFIG_RETPOLINE=y

[2] Refs :
   commit e1c8a607b28190cd09a271508aa3025d3c2f312e
      net-timestamp: ACK timestamp for bytestreams
    tools/testing/selftests/net/txtimestamp.c
