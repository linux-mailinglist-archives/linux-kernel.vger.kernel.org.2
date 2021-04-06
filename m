Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15298354DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhDFH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:29:23 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:45901 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDFH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:29:22 -0400
Received: by mail-vs1-f41.google.com with SMTP id u29so7255286vsi.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 00:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyM/uX3bNRVEEpQyWz+heQsyz9AuEXH5GY8XvmdJ2M8=;
        b=W+4Aa6QzOWcKAq6imHFeSNF00ZGOAcXY03nxU1xpi6j+IJmdJMBo8Lu4mjURBUj+ns
         6CdZ4Piy3BXuSMsSobpSEzeEKuOLec8ySVWKBltS5bNNYexsu26b2AJCvl9Fu+BTA1IJ
         Uw07bINTVjXnNnHVdgd92DTi3tSyCKlpHxddbp+BprQIV+vhm0fWKtB61g2PhYhsdDXb
         fDgBX8z9KTdRZEmcf0MT0Kyj/hn/2KvX5x6rB9c6RVmD/CPU+qaBCb2Qt5/okw5j3rjZ
         bWblQ1zcfTpf0Uawp/lEhgboitskm6RkGvtGHcLJSVRp9VcGuYtbmc9wbwLT5RmaQD7b
         HAQg==
X-Gm-Message-State: AOAM533FKl8ghK06c7KDJGX/77ZnkTvCKyH7DTQXcb8vIji5C2mIOzzh
        PLSck5ibSzyZNAgKjQ0KVR6lO69vLUND0PuddzHAh3bQ
X-Google-Smtp-Source: ABdhPJxRrheCHURj0E2MRfmD4sDJxeC2/iWmE2pAfQHXfFzaRswrQd5da0Fd6b1HnnZCYlYkGTtsz4fvdwunMa9q754=
X-Received: by 2002:a05:6102:3010:: with SMTP id s16mr12429339vsa.3.1617694154355;
 Tue, 06 Apr 2021 00:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <4fdaa113db089b8fb607f7dd818479f8cdcc4547.1617089871.git.fthain@telegraphics.com.au>
In-Reply-To: <4fdaa113db089b8fb607f7dd818479f8cdcc4547.1617089871.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Apr 2021 09:29:03 +0200
Message-ID: <CAMuHMdV6X6tP5WddrTbowo9=YkZqzOTw71329o6mK=SiFqSQSQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: mvme147, mvme16x: Don't wipe PCC timer config bits
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Michael Pavone <pavone@retrodev.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 9:40 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Don't clear the timer 1 configuration bits when clearing the interrupt flag
> and counter overflow. As Michael reported, "This results in no timer
> interrupts being delivered after the first. Initialization then hangs
> in calibrate_delay as the jiffies counter is not updated."
>
> On mvme16x, enable the timer after requesting the irq, consistent with
> mvme147.
>
> Cc: Michael Pavone <pavone@retrodev.com>
> Fixes: 7529b90d051e ("m68k: mvme147: Handle timer counter overflow")
> Fixes: 19999a8b8782 ("m68k: mvme16x: Handle timer counter overflow")
> Reported-and-tested-by: Michael Pavone <pavone@retrodev.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applying, and queueing in the m68k for-v5.13 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
