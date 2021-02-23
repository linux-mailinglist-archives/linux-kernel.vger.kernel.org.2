Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAB3223D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBWBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBWBpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:45:15 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDDDC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:44:35 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x124so3683695qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2LlCCT6zt358q3HdAnMzHHVxdjb2JCGvdj5DHbQbFY=;
        b=enjeBWihK/qhVzZdUUZ1nTSacCyf4mFjGMHWHuea5iiyYT44dZoUS6Uo4FR0o9PMHY
         06msOISTL65F4REAtjvQHAAhGWHuH33jTFUohh++SuVZcGmKQWR891ZRiMk0b5kSl7An
         LwI5S5NldfBrK5BEtQJ6QJeB43dnB945gc8js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2LlCCT6zt358q3HdAnMzHHVxdjb2JCGvdj5DHbQbFY=;
        b=GoRyoWT/sAd72gZagFKLgS4ULFRCBi33TJjzp+W9Rz1csNrm4OTvlRGJpOaWW6ZmTk
         CV58Ul2J4peyLconko2rKpI0c90SkFDtw9x+tmjeb+1kJa0fBkUMZ20CVJ5FqYWut98m
         wPbI0i5YfJ/gQcCeT7+H7MqkpJyIzvMX/n2rd2ZCcoY2KeDfUqSpdSkx7KEjRtQ8xDOf
         ZP4F+BPnCw7MI2NMncHwCp3AOg7f4XUB0C0BxOyp/XRe904vyAy55GjxhBvla+C0LpRj
         QVsBJo8gzof7NSGie54iY2npmG5O5NPCZMSHkUS4RKzFI7nalHHfFenl1garcOOoc0I9
         KopQ==
X-Gm-Message-State: AOAM533nXgLKL7ZCcOARSrGiR/hPqk7vPt8l0WJ3msPNadVqFn55Kadp
        tNryBhnhw+dbCcXmJ5+zRD4QkfpHS+xkp2yJoLbobRjQSko=
X-Google-Smtp-Source: ABdhPJw858HVZIWbHL+u++qtIQfY42d7VcRXfkLZLkj6Q7cWPABWtwGIMWCbKgKSxuVAxQe1guSCEm0AFoSKjx10idg=
X-Received: by 2002:ae9:de85:: with SMTP id s127mr7564183qkf.468.1614044674272;
 Mon, 22 Feb 2021 17:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20210211052206.2955988-1-daniel@0x0f.com>
In-Reply-To: <20210211052206.2955988-1-daniel@0x0f.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 23 Feb 2021 10:44:23 +0900
Message-ID: <CAFr9PXkvJN2AwTFTXLoTFj988LD+53eW4Y28nJ2M+7YygBJ58g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ARM: mstar: Basic MPLL support
To:     Arnd Bergmann <arnd@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

On Thu, 11 Feb 2021 at 14:22, Daniel Palmer <daniel@0x0f.com> wrote:
> Daniel Palmer (7):
>   dt-bindings: clk: mstar msc313 mpll binding header
>   dt-bindings: clk: mstar msc313 mpll binding description
>   clk: fixed: add devm helper for clk_hw_register_fixed_factor()
>   clk: mstar: MStar/SigmaStar MPLL driver
>   ARM: mstar: Select MSTAR_MSC313_MPLL
>   ARM: mstar: Add the external clocks to the base dsti
>   ARM: mstar: Add mpll to base dtsi

The first four patches have now been merged.
I forgot to send these to the soc patchwork so I think the last 3
didn't show up on your radar..
What do I need to do to get the last 3 merged?

Thanks,

Daniel
