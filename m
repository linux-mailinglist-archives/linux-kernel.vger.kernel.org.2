Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B20419804
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhI0Pha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhI0Ph3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:37:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:35:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g7so11499150edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=qo7WDwrWUucyfRUY7TpUsM4OGtaHM3n/evZ2sEUNJRY=;
        b=YhkYUdznBz/Hde+mSO5o3KeuI3wMYDW5RSDFSXkzbxcEQAyxS8EEaZ2LMzkX0SAArD
         P5oxMWXxIz79InT9ndrUurUaajcp2xi4ZVnmw1pFIQnl1sRG45Wom9qEkv5nK8Auh1qO
         GRoZIKHVR06atdgUebz2Ovey2tU1azBTJnspcbR4MiWK8SA7mElHy4laDR2XVK1ej9dq
         seljGlWkQNsUzbb4PrJl+ZH8Hyqcmfma11f+bN9PEPsjiJiDSxNKGSYcB1fu5nKS6wrh
         pnj9gbzErdK2ZVwO7iK+2xKIbGS6YhbFYjicvwDG5Z2HHYxqBowWh7joCvtpfthMN6FG
         c/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=qo7WDwrWUucyfRUY7TpUsM4OGtaHM3n/evZ2sEUNJRY=;
        b=SxpK4tCZBpfYgrb/8jsHPSI1e8DyuWhuefPVrxmzM7LqxQnUAvJxrmeuRyVpG9nq2d
         IChRjEoOVG7qnBUETDg9O45V307ft/dhC3BPw0XjD64uUR8ReCJq5o9DZPrSKAoQkSpQ
         apgcsfD0Mx1wDVKTqaPjGyrxE/thFSOfD4CZVzWr4YkV7s+Bb1PEFqlaaS67Zx6Ds76X
         Jvutnn4qXva/GQgyMKl62IjI7NqebrLtRNvfXFWiruiMoPxJpDH3p3KFGf5fxDWuK9yP
         SN0VJYIeAKUioRkQNoRFx9aphICgRnD46Za8FpwNjfpr1YPHyEpwiLLQrkXopFSUkBHV
         56Iw==
X-Gm-Message-State: AOAM533BRank6imjfOoKvpdaYGlZd8cmpvJpW3od7hjCzCmFJMKxAdju
        ir/QmLlsjZMjJFkCIdlKPz0=
X-Google-Smtp-Source: ABdhPJwM7OwM7OZqTD7KZiNdGpF1/C4+zgwUasnMpKvbNQpwjkVE6UgdmOLoJVK5VUgFDlQfKtKo1A==
X-Received: by 2002:a50:d9c5:: with SMTP id x5mr574208edj.37.1632756949991;
        Mon, 27 Sep 2021 08:35:49 -0700 (PDT)
Received: from [109.186.97.74] (109-186-97-74.bb.netvision.net.il. [109.186.97.74])
        by smtp.gmail.com with ESMTPSA id d3sm10919961edv.87.2021.09.27.08.35.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 27 Sep 2021 08:35:49 -0700 (PDT)
Message-ID: <6151E490.4020403@gmail.com>
Date:   Mon, 27 Sep 2021 18:34:40 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] char: xillybus: Eliminate redundant wrappers to DMA related
 calls
References: <20210926072925.27845-1-eli.billauer@gmail.com> <CAK8P3a3C+a9-hg4nbFFHR4i6e5HmchD4ZgmijJLs5RLBaCBsBQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3C+a9-hg4nbFFHR4i6e5HmchD4ZgmijJLs5RLBaCBsBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/21 10:47, Arnd Bergmann wrote:
>> +static void xilly_sync_for_device(struct xilly_endpoint *ep,
>> >  +                                 dma_addr_t dma_handle,
>> >  +                                 size_t size,
>> >  +                                 int direction)
>> >  +{
>> >  +       if (ep->make_sync_calls)
>> >  +               dma_sync_single_for_device(ep->dev, dma_handle,
>> >  +                                          size, direction);
>> >  +}
>>
> These wrappers should not even be needed. When the device is
> marked as coherent in DT, the dma_sync_*() calls are supposed
> to do nothing, in a relatively efficient way. I would not expect
> the extra conditional to give you any measurable performance
> benefit over what you get normally, and it should not make a
> functional difference either.
>
> Can you remove the inlines and the ->make_sync_calls flag?
>
>
Thanks, I had no idea that the sync functions neutralize themselves this 
way. That is, since commit 591c1ee465ce ("of: configure the platform 
device dma parameters") from back in April 2014.

So indeed, I shall remove the the @make_sync_calls entry and related 
wrapper functions, and resubmit an second version of this patch.

Thanks again,
    Eli
