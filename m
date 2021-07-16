Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43753CBAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGPRBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhGPRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:01:18 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC5C061762
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:58:21 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id y17-20020a4ae7110000b0290262f3c22a63so2586878oou.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zF6RFynJImZVZ9iauRKVrADk1+eSALtVWbPASLHhoSw=;
        b=CYfZq/00WLjjWY1y5nRSBmHv2gLKV/HPnda9tFP2NnVUU0Wmm+FGSaRVjx7ugR8Wu8
         gVqOAn49/fcLFt2j5zQor/oTx+Jc8rdVjMNfSyuGOUUPuFt7FC/Ok1UjIuCgrVE4R1wQ
         g97bIBeGzSYqzNZwtdBTzPpYJlV55FMfIxS5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zF6RFynJImZVZ9iauRKVrADk1+eSALtVWbPASLHhoSw=;
        b=OCx1njsYrS5/FPkl25VgRT6e3IxSdxe3BDPbkv23nX19kdVyLNBZ1m/WVxedPFsKjr
         dR+mOUMIzK5djnm0oTFQDv+IWDwsN6eLbl+IrP6sNR/CRlPPLM0BLoU3K6Y+FU+RgbAD
         FpCx06CMz1j/nLsgpaQR9NLW06I8Acvom3qMzMIfX/kRV9SjtFRrPT6qAjV5CeP6CBrb
         2Rm2qglLv4iCtExaV4cBNbIql3LrmD9f/B6mN0EeWAZeV+ZG7kOXoIFXYPW3Gx4jZsb5
         78MBggTqDabiVrCDwNUOP8SPHlNeka7zgja0XXX/boBFju3FM2qPscCbs6Yil5Np7iMe
         dGOA==
X-Gm-Message-State: AOAM531uyLO7PQTQvaBORUoC77Weeqia9kpSJ54bkMLzWJ52kRTjVrJj
        Uzb2XVMOEHUtUug6jAhmVbCSO4SSlCxK1Q==
X-Google-Smtp-Source: ABdhPJzKAtWLS3ocP228TJ/bFALUrLmC/rk8blb2JSk7WUgpFiDoEc9831cIdJ+r0otU4GxGCk1WqA==
X-Received: by 2002:a4a:91cb:: with SMTP id e11mr8343583ooh.53.1626454700315;
        Fri, 16 Jul 2021 09:58:20 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id y5sm1359943otu.27.2021.07.16.09.58.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 09:58:18 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id y66so2194944oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:58:18 -0700 (PDT)
X-Received: by 2002:aca:304f:: with SMTP id w76mr11034037oiw.77.1626454698098;
 Fri, 16 Jul 2021 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210716155311.5570-1-len.baker@gmx.com>
In-Reply-To: <20210716155311.5570-1-len.baker@gmx.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 16 Jul 2021 09:58:07 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPSL4bFpyjRYGEOG=Df8dOXc19LYBO06wdFN_k8OkiwKQ@mail.gmail.com>
Message-ID: <CA+ASDXPSL4bFpyjRYGEOG=Df8dOXc19LYBO06wdFN_k8OkiwKQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtw88: Fix out-of-bounds write
To:     Len Baker <len.baker@gmx.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 8:54 AM Len Baker <len.baker@gmx.com> wrote:
>
> In the rtw_pci_init_rx_ring function the "if (len > TRX_BD_IDX_MASK)"
> statement guarantees that len is less than or equal to GENMASK(11, 0) or
> in other words that len is less than or equal to 4095. However the
> rx_ring->buf has a size of RTK_MAX_RX_DESC_NUM (defined as 512). This
> way it is possible an out-of-bounds write in the for statement due to
> the i variable can exceed the rx_ring->buff size.
>
> However, this overflow never happens due to the rtw_pci_init_rx_ring is
> only ever called with a fixed constant of RTK_MAX_RX_DESC_NUM. But it is
> better to be defensive in this case and add a new check to avoid
> overflows if this function is called in a future with a value greater
> than 512.
>
> Cc: stable@vger.kernel.org

This kinda seems excessive, considering we absolutely know this is not
currently a bug. But then, LWN nicely highlighted this thread, which
reminds me that even without the Cc stable, this is likely to
unnecessarily get picked up:

https://lwn.net/ml/linux-kernel/YO0zXVX9Bx9QZCTs@kroah.com/

And I guess silencing Coverity is a desirable goal in many cases, even
if Coverity is being a bit trigger-happy.

So, *shrug*.

> Addresses-Coverity-ID: 1461515 ("Out-of-bounds write")
> Fixes: e3037485c68ec ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Changelog v1 -> v2
> - Remove the macro ARRAY_SIZE from the for loop (Pkshih, Brian Norris).
> - Add a new check for the len variable (Pkshih, Brian Norris).

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.
