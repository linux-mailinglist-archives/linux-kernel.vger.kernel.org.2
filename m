Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA87B41A13E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhI0VS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhI0VS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:18:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C199C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:17:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e7so19023831pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=llnw.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JLK/sRP9I8Wlr+P16AIpY8iwsR/LeBc/3r2jJEyV9+M=;
        b=MLsXgdgEfYiZnTCSOSviYe/vWLecYqTiMgSmbLz9hNdVt/iFfJjdDMe5Ki9FfF4+fi
         piKeRePfkqMQijTnNQUp3p/EkmTknRbReMYjQp3rAT1CbNRyJ0/YOFjAIiQV6JzDlrK4
         8FFMHNE+TQDURRnMyfOly21j523SG3sA40Yz+CcsjIi52NU6EJzKFPpHRR7MAF/Hcunm
         dnI/VTHT3/GEMfd5MHEhA8YtTZQFAUVgsaNQusUCyoyQOYBmNFp2L8KOIJndLneeVCU9
         PmXgFLHaDX8eDrgaZo8thJsfLXPbhYGxX2lWsNTUSO8zdEs0uRzXX1GKU2DvgDu3YR4R
         VUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JLK/sRP9I8Wlr+P16AIpY8iwsR/LeBc/3r2jJEyV9+M=;
        b=cmWvQgmoeYjp/IDPUgllNoyK6I5h219A9Rgqc/O93OIes+sB4dsjXzetQ00QFDrc5r
         vCJID9sATHVS0nxTwDABRqOJa1DXIa90ll6h+BzrNdjDC20AXcvjGUBR8BS4NUfAB1lb
         ANdZlfoMj4FIj861otwx1R8mB5bUYDK+c00Xx/Batix9BNT9iqJtiNKKheXJwJZL2jxN
         QG1vIiKBu2vfBGlBBJvMiKjwrlszO5e4DGPADnSRTOMXycH8UnUwB6iy0HIxVI6ea8aC
         ls11RU5rlSGG6hIoQR/AlkqMLwAo0gLMRoXEbFcqozqfuuwBiUEffZ7ZYg3I6D8xNkqA
         ZTRg==
X-Gm-Message-State: AOAM530Nnnc4lmhxLLG6r/becYNLOkj3OGdKJl8nVgoaMFWV8Yzb0Q9c
        XIY4rEUX5pECk26KBVWgZVkr3A==
X-Google-Smtp-Source: ABdhPJxD0IrKG948IZYTdp1EHmpPNjp0LH3HT44kue1APLm8pe3Bt5IJ0OMxeKccvYGPC0RAW1G/lQ==
X-Received: by 2002:a62:2c51:0:b029:329:932b:9484 with SMTP id s78-20020a622c510000b0290329932b9484mr1975282pfs.13.1632777438957;
        Mon, 27 Sep 2021 14:17:18 -0700 (PDT)
Received: from [10.50.24.214] (wsip-184-181-13-226.ph.ph.cox.net. [184.181.13.226])
        by smtp.gmail.com with ESMTPSA id d18sm20267747pgk.24.2021.09.27.14.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 14:17:18 -0700 (PDT)
Subject: Re: [PATCH] fs: eventpoll: add empty event
To:     Eric Dumazet <edumazet@google.com>
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
References: <20210927202923.7360-1-jlundberg@llnw.com>
 <CANn89iJP7xpVnw6UnZwnixaAh=2+5f571CiqepYi2sy3-1MXmQ@mail.gmail.com>
From:   Johannes Lundberg <jlundberg@llnw.com>
Message-ID: <c675343d-a5bc-dce0-bcde-8a952682e698@llnw.com>
Date:   Mon, 27 Sep 2021 14:17:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CANn89iJP7xpVnw6UnZwnixaAh=2+5f571CiqepYi2sy3-1MXmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/21 1:47 PM, Eric Dumazet wrote:
> On Mon, Sep 27, 2021 at 1:30 PM Johannes Lundberg <jlundberg@llnw.com> wrote:
>> The EPOLLEMPTY event will trigger when the TCP write buffer becomes
>> empty, i.e., when all outgoing data have been ACKed.
>>
>> The need for this functionality comes from a business requirement
>> of measuring with higher precision how much time is spent
>> transmitting data to a client. For reference, similar functionality
>> was previously added to FreeBSD as the kqueue event EVFILT_EMPTY.
>
> Adding yet another indirect call [1] in TCP fast path, for something
> (measuring with higher precision..)
> which is already implemented differently in TCP stack [2] is not desirable.
>
> Our timestamping infrastructure should be ported to FreeBSD instead :)
>
> [1] CONFIG_RETPOLINE=y
>
> [2] Refs :
>     commit e1c8a607b28190cd09a271508aa3025d3c2f312e
>        net-timestamp: ACK timestamp for bytestreams
>      tools/testing/selftests/net/txtimestamp.c

Hi Eric

Thanks for the feedback! If there's a way to achieve the same thing with 
current Linux I'm all for it. I'll look into how to use timestamps for this.

