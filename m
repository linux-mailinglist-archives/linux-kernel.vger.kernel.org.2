Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AAF3FE47D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhIAVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhIAVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:05:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44057C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:04:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y128so1098539oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Er+bUfyfPvArhYuBPd9KcOdL9ky31FKA1apq9cDnwfk=;
        b=jc108vPKn+qoC2+EtUZK7f8iWMtJBLiSI/k3pDpscWBvuMzAYdCnqmZ0tXum3oWpGa
         GghPMV+NZld70nm9K8c3N/sytLAQDNSWHYZEt/gz0x+kXWmE+z8yq3a+I31qlZeTa6ad
         Q8C11zOwXse34JREiZdLUgjbLseCYofrlEPlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Er+bUfyfPvArhYuBPd9KcOdL9ky31FKA1apq9cDnwfk=;
        b=VWz+7teybnJuayGgYimqA3Ip7R3WAph/Tln+8e4r/HTL2YoIXhW8L1KrggK4c1YODe
         qDB/Sb19huRxTjxS+C/IaunKpdL+dYq1bRdqK7wUXAjXinTSVXXiHK5JfOp5c0a+CZSB
         jnHCesoA8nEwOba4oabRKSO7Ih6Pp/t11WNtf0FURARNnCsipU2ywLCr/FvwFva1Z2nr
         eME9MaeOfEt95Zfxf59KKs6L7OHNiFVKKiPmmUHbGsZIoqxB5BCSkbPxtCxfxdAuW31n
         saoxXr4rHt4uSyxs/QLYBLuAFvYuuxaSG6ecynZRY9MalNEtlGPtWof/HtV1aoTCaqeW
         bc6A==
X-Gm-Message-State: AOAM530aYgnLiC118pso0WFntvj3NKkD6HDy0A30XOGZ+HlQqzrtEoku
        QrNRDoAjOS8LptwGR9kKda275TuJXEwXfg==
X-Google-Smtp-Source: ABdhPJxnIy6V+B8lz0DilZmOl39F8vP7mZ6FIrFKVxcciG2zaouqpXExhUMPY9Kh0j/P+t9vW4GXbw==
X-Received: by 2002:a05:6808:b08:: with SMTP id s8mr1165000oij.97.1630530257560;
        Wed, 01 Sep 2021 14:04:17 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id 8sm137554oix.7.2021.09.01.14.04.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:04:16 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so316425ooe.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:04:16 -0700 (PDT)
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr1141610ool.66.1630530255934;
 Wed, 01 Sep 2021 14:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210830123704.221494-1-verdre@v0yd.nl> <20210830123704.221494-2-verdre@v0yd.nl>
 <CA+ASDXPKZ0i5Bi11Q=qqppY8OCgw=7m0dnPn0s+y+GAvvQodog@mail.gmail.com> <CAHp75VdR4VC+Ojy9NjAtewAaPAgowq-3rffrr3uAdOeiN8gN-A@mail.gmail.com>
In-Reply-To: <CAHp75VdR4VC+Ojy9NjAtewAaPAgowq-3rffrr3uAdOeiN8gN-A@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 1 Sep 2021 14:04:04 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNGR2=sQ+w1LkMiY_UCfaYgQ5tcu2pbBn46R2asv83sSQ@mail.gmail.com>
Message-ID: <CA+ASDXNGR2=sQ+w1LkMiY_UCfaYgQ5tcu2pbBn46R2asv83sSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: Use non-posted PCI register writes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 1:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 1, 2021 at 11:25 PM Brian Norris <briannorris@chromium.org> w=
rote:
> > On Mon, Aug 30, 2021 at 5:37 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wro=
te:
>
> ...
>
> > This might be good for many cases, but please read this commit:
> >
> > https://git.kernel.org/linus/062e008a6e83e7c4da7df0a9c6aefdbc849e2bb3
> > mwifiex: pcie: use posted write to wake up firmware
> >
> > It's very much intentional that this is a posted write in some cases.
> >
> > Without ensuring this doesn't regress, NAK from me.
>
> Can you ensure that from Chrome / Google perspective, please?

I mean, the context link should be pretty obvious. But sure: with this patc=
h:

(a) all my least-favorite audio issues to debug return (audio is
especially latency-sensitive on the Rockchip RK3399 systems I have)
(b) latency spikes to ~6ms:
# trace-cmd record -p function_graph -O funcgraph-abstime -l
mwifiex_pm_wakeup_card
# trace-cmd report
   kworker/u13:0-199   [003]   348.987306: funcgraph_entry:      #
6219.500 us |  mwifiex_pm_wakeup_card();
   kworker/u13:0-199   [003]   349.316312: funcgraph_entry:      #
6267.625 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [001]   352.238530: funcgraph_entry:      #
6184.250 us |  mwifiex_pm_wakeup_card();
   kworker/u13:0-199   [002]   356.626366: funcgraph_entry:      #
6553.166 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [002]   356.709389: funcgraph_entry:      #
6212.500 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [002]   356.847215: funcgraph_entry:      #
6230.292 us |  mwifiex_pm_wakeup_card();
   kworker/u13:3-4057  [000]   356.897576: funcgraph_entry:      #
6451.667 us |  mwifiex_pm_wakeup_card();
   kworker/u13:0-199   [004]   357.175025: funcgraph_entry:      #
6204.042 us |  mwifiex_pm_wakeup_card();

whereas it used to look more like:

   kworker/u13:1-173   [005]   212.230542: funcgraph_entry:
7.000 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [005]   213.886063: funcgraph_entry:
9.334 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [002]   214.473273: funcgraph_entry:      +
11.375 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [005]   214.530705: funcgraph_entry:
5.542 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:1-173   [002]   215.050168: funcgraph_entry:      +
13.125 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:1-173   [002]   215.106492: funcgraph_entry:      +
11.959 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [005]   215.484807: funcgraph_entry:
8.459 us   |  mwifiex_pm_wakeup_card();
   kworker/u13:1-173   [003]   215.515238: funcgraph_entry:      +
15.166 us  |  mwifiex_pm_wakeup_card();
   kworker/u13:3-1768  [001]   217.175691: funcgraph_entry:      +
11.083 us  |  mwifiex_pm_wakeup_card();

I think it would be enough to only modify mwifiex_pm_wakeup_card() to
retain the posted version, but I'm not sure how that fits in with the
rest of the author's work. I suppose I can give a later version a run
if needed.

Brian
