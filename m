Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14536E74B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhD2IrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhD2IrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:47:05 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C021C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:46:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t24so8399458oic.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYJ/i+SyDWuXeltdyQRtqtcL95TciOlmlQ2w0jknE48=;
        b=pL/eJr3nZ1xPXLcRvl0U4RW4El5I8fT5ZC3v52Qmlslf9BOJWoOnByIYODbo7VWxZN
         gvNtg2QGNUyVoKYRtfdyuchvx2ZUZczbs/bhGEgyt3Kyh73GiDnclQczVT3mWr1tNnVF
         n8jvU4dfHi25Dns1SHDJJW7HWJzxfAvoVX/Za5OJoueFl8wCOnNX5g40cfRddEas7dln
         4ooWV7jq0UDZwy6gz6025xNHxdIqg7qF9rhuiF3ds/2Sg9hjzM0JLq4ipWf4sxnj0dWW
         WvXstLLdiaOeVizGBD/xIIJBj7j+rNoCtfHxsn684meB9CcHSoHwTwapwZLWUr8Iz5KB
         F7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYJ/i+SyDWuXeltdyQRtqtcL95TciOlmlQ2w0jknE48=;
        b=luuk0njeMGHibR91NDjuJneBINaP+bMahaRK4nUKf+hDWJuGH2CbQboxFgwQKTzXzt
         C3Ea9k0xUrxJ6Nhf1jogeiLZp9A8ly6VgrUy5SOW3TBfPhfjHDFYb262SBypVI3xII9j
         8TBwoSEmajFB0233dlM7gdOUJiPo+hW+FDLv98WACfxY/KYeN94nKELxizR41BhYJXgf
         pUyFxyq6+Ug6LthE3v4zUo9HyHiHz55cdNVuXbJeSGmEZ1DcCOh0D/vIHmoVOJMfi2SB
         NKAhQmEFZX78W7qKRPx7rbIHGQB7snNrhaT4xQa1gMrBPyg1ZJsJHaEXc+NKFuG72BoW
         NrHQ==
X-Gm-Message-State: AOAM530bNbSbTshzTOfkrAgWrnVfFM0v3zzFi13mEkbX6FQPhkllXYbv
        pRaMGay9apo3TjZL+rkoxgfgEZg+98ohGb078wEHRA==
X-Google-Smtp-Source: ABdhPJyCkp8J3VRA0ewFkoQykIwlYkcZbVoeMyqGaTtHvZE/zViErogzzqFjCPiXR/2ErhCqVeYfbzmswfnNNdh7rQs=
X-Received: by 2002:aca:a814:: with SMTP id r20mr1142692oie.104.1619685978667;
 Thu, 29 Apr 2021 01:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210427170859.579924-1-jackmanb@google.com> <CAEf4BzZimYsgp3AS72U8nOXfryB6dVxQKetT_6yE3xzztdTyZg@mail.gmail.com>
 <CACYkzJ57LqsDBgJpTZ6X-mEabgNK60J=2CJEhUWoQU6wALvQVw@mail.gmail.com>
 <CAEf4Bzb+OGZrvmgLk3C1bGtmyLU9JiJKp2WfgGkWq0nW0Tq32g@mail.gmail.com>
 <CA+i-1C2bNk0Mx_9KkuyOjvQh_y7KFrHBU-869P+8oTFq8HdVcw@mail.gmail.com> <CAEf4Bzb1ZNotcB44cDauAkAbs4R=UvPRKP1KWNbLg1k1jH25mA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb1ZNotcB44cDauAkAbs4R=UvPRKP1KWNbLg1k1jH25mA@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 29 Apr 2021 10:46:06 +0200
Message-ID: <CA+i-1C3YJQt60FBaOg3pHD+BG6kuUK1Z8RiZ87O9+WSr1Ynbyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 at 20:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
...
>
> Yep, let's cap. But to not penalize a hot loop with extra checks.
> Let's use int64_t internally for counting and only cap it before the
> return.

Cool, sounds good. Patch incoming but I'm on interrupts duty this week
so might not be today/tomorrow.
