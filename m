Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970F333D64F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbhCPPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCPPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:00:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9CCC06174A;
        Tue, 16 Mar 2021 08:00:39 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k2so12969136ili.4;
        Tue, 16 Mar 2021 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tbz96+rxny8J82X7hbX/9a0BDi/EpimzsJipF8+VGW0=;
        b=Y2PCILLXRZsUqAuogyJ/UoyDOEq4tP4EBO1vrj+uVaXsJ5Fl4h/7646bRdN+YXGj9E
         BVNPLIWW3quPffAmdxBGfgZq8bgt2PixVrMNj3XKcBPIJhUWV+fqzflTHE1gbUvmHVpi
         G11Oc0LMEuQER9rwarwtPxvuZwwbiIYeFevUR5nmykGwLxXO96zJFkQsy9r0+B0iMNAv
         IN3ZY3MtsG0i4axEj6ugrTsk0ROHQ7CCiABkLRrCLCR5iggLJtwXZfRC+sZBqslHb2Sb
         ocewQtfp+w7e4TB3K/VNn2R4JR047Qd2srwywiiUYvD74rewhANrd2IUq48f6859Fvgs
         sEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tbz96+rxny8J82X7hbX/9a0BDi/EpimzsJipF8+VGW0=;
        b=S/95+je7vO+x2jaq5F94grKBYETxFdpgq9z5yXwuvHuPqIrYgNO0Y8MH+6GlZ0viW/
         H91ITfxQS1dqTCgMxET4wy40vY0QqvtjAIpw5kds5XbNF9ygzHACQNP1plfmEkMMYLZF
         qLjCfgZE2wz9qaJNC2mias/BZYDo+UuHzuh2UEVFdls0yJdCYbrxp81pNKjd2bAoBX7t
         cMQja31mRduGn0HPJP9L5vYDJijHwV2sgfUwxHaCVitzdm78iEfi80tXKGBi3egqsf+9
         R93QcSeDiopbIFjlj8955YAhCyRdSWGnBzZrWXnZI90VotobjRn98iB8GPEgajvo8jLm
         ut5A==
X-Gm-Message-State: AOAM531pYeoAweL09IlfBhQ6uMHrPm22PWupeIw1X7p/tRwVtifuGzBe
        R6/bZC4A4yDCivdnLgCiHiM=
X-Google-Smtp-Source: ABdhPJxWl/Ss8IgojCB80uGaYNl8T5f5XPhHAYATvsrNV++iLm2d8c0Mc45pByMjb+pj0XvUcLcjKg==
X-Received: by 2002:a92:d2c3:: with SMTP id w3mr4390045ilg.181.1615906839205;
        Tue, 16 Mar 2021 08:00:39 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id r18sm9553739ilj.86.2021.03.16.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:00:38 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Tianling Shen <cnsztl@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
Date:   Tue, 16 Mar 2021 23:00:33 +0800
Message-Id: <20210316150033.15987-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
References: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2021-03-16 02:23 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Personally, I'm not so fond of the <foo>-%u node names, and prefer
> <foo>-<function>.  With the former, it's way too easy to have a silent
> override in your .dts(i) stack.
> Cfr. commit 45f5d5a9e34d3fe4 ("arm64: dts: renesas: r8a77995: draak:
> Fix backlight regulator name")

How about using `lan-led`, `sys-led` and `wan-led` here?

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Thanks,
Tianling.
