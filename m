Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A932FC2A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 18:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhCFRHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 12:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCFRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 12:07:03 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED92C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 09:07:02 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l14so1607680qtr.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpqFU/WH93rAnDj1yFPOUMsML7kE15FG7OpMRmI6VOk=;
        b=lqUa3JgA7vwzlGmAnIReW+CDdgbpUq1hHgrXc7tsb3EAg5ZpHTuO59ZvYQ06oeoCmL
         NFKLBBs4hVllSFacz+T27+DzAV8eufHWwEwuEw6j4I4xAVQ/JXdXPqVeOY5dMjm3A5KS
         rOUoq/Z0GGiHgqFQjmoGzoE57zRpPiVqZCN3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpqFU/WH93rAnDj1yFPOUMsML7kE15FG7OpMRmI6VOk=;
        b=XRHVA3LEiFSB0glyEb2Dy+omQKd2MUrtYImHhQDGSAXXMCPoeSNzbmOXsCSPoKsZBu
         VKs99Rh9o118V+7TdYrhIbCfx6nnn1/0/xmHZF4wFahTfLOXEqw3Zzg3OTu2kk04OrnD
         wm/KgPwC9E5rziqPzr6kbiJ1a3B3+9SsyZ2919DqeWtAiKtGgPGbx4cKgR1WcOMhV1rd
         gzjplImsnkD0W8s+VxkJ7EjJD4z9LbJpjC2d9VknyBb6f/eBF5XJJhOJw+cBKEHb+sxI
         fIwGc7H2iMtMqIzRWpfsfNRbatCvyi3UH5v4e4Nj3rHm2PiADHgLnl63QnKMg0gVaRsW
         JTfg==
X-Gm-Message-State: AOAM531BspgBOoMGEwpdsOkm/+JHC0SGMF/YgWUaEM80q3dmlEeFCK8U
        rto6fccmq+jfxKlePIZa4UUU7CiSqeFVWxc+XWWcPA==
X-Google-Smtp-Source: ABdhPJwJhKkiF/NoD+K9iea6Lhx4ktdxz5R3+GzHT8+pww/oN3UHClY2jcu37KlVeR9ufDL/9rQhi7Iy0vKl0v4zYDg=
X-Received: by 2002:ac8:480e:: with SMTP id g14mr14104704qtq.249.1615050422018;
 Sat, 06 Mar 2021 09:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20210305120930.14297-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210305120930.14297-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 7 Mar 2021 02:06:51 +0900
Message-ID: <CAFr9PXmDp7UwWnT+49Yciy-gvYiQOd3cus0W_QnGKm-LqziHCg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/irq-mst: Support polarity configuration
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>, Daniel Palmer <daniel@thingy.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

I'm trying to understand the logic behind the changes.
It seems like the polarity of interrupts is always the same between
the MStar intc and the GIC? Low level interrupts are handled in the
mstar intc and become high level interrupts to the GIC?
I think for the Mstar MSC313(e) and SigmaStar chips all of the
internal interrupts are high level so I never noticed this behaviour.
I can't remember seeing anything that handled this in the MStar kernel
code I looked at.
Is this specific to a certain chip or does it apply for everything
with this intc?
The register values being lost if the chip goes into suspend to memory
makes sense for the MStar chips too I think as everything that is not
in the "pmsleep" register group seems to be lost.

Thanks,

Daniel
