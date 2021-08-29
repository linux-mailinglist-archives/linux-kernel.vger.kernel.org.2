Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEDF3FAA23
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhH2IY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhH2IY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 04:24:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F4C061756;
        Sun, 29 Aug 2021 01:23:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q14so17536770wrp.3;
        Sun, 29 Aug 2021 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=TinTxBGGYceb6/8jQNfG0B2WM8DTWHd+X/Zt0ongoKI=;
        b=Krx3/JDXhi7ffSvtEk9h4+dF+DSkY4xPUVgsvCO4/SVQFhTBIxFUM8rMyRLbB5f0GK
         0HaKUeBxHp++xT3mVzt0nkQbZFpCGHLdadrgZGltGA9F2AugaKr+RsVglEpb6e6xRwdJ
         nFvn53R8OpZ3jueWpQQszvTRxgCn+8tcMXa2y9SMMBP0t62BwyAgmhSvhDXvVqYHWDR4
         fZHYTnxXQesVh+vzrLGtZly0vn4wL0ReSO7vzXoCYsl9qjhY08X8uh+xyPUGXRubcORV
         Dv1yHMEZ8y/Kqkhj8qo1qAuHpoNUM8/0yUpDedNhH1Gjci0snrjKcSaxLQjniiKjYqQA
         fZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=TinTxBGGYceb6/8jQNfG0B2WM8DTWHd+X/Zt0ongoKI=;
        b=haeoR4ByKSm8WA3/qnOaNQnRvz7p5nurlkmGsrUEVq3FmGn0Rdt0uG9qjcFKLHZjSM
         3CaVqrEgSjhuU9s0AAqFxPcT+nTDPiQKfdp7i3tYZYFjta9/oCQ46ooHDtxrXvNuj2Nv
         bZFMlrZJICObw3+jpypho8Ud6oLZmCG1PwBpQlhbtRG5B3YJyKc5bfleMNPySjZYOc/U
         8Wx6h2ihRmPGb3VrAzFj+036TFkRWYD7MTs3IKQsU8zr2ucqHFjloi2huXU7spl2q/xY
         HDeX4YY/7hQyrAOoWNquStTogjWa2Z+0uKmi7FX9rLVs8IhGqeARIt739MxxH4j0tIiW
         q/bQ==
X-Gm-Message-State: AOAM532B6FhCh265jwtelhE+ZVpAZCT/teczbRwQLLgtLd6drA+0qcg6
        9EIsiARG5ta6mV5psy5gFao=
X-Google-Smtp-Source: ABdhPJy8o+XmSdFIDv4hFYAuadm9F1r4D+Fk81cu43FJ1vta++Tm6/rI+oHbnQa3qaQmzl47eVqDrQ==
X-Received: by 2002:adf:b781:: with SMTP id s1mr14088916wre.319.1630225414651;
        Sun, 29 Aug 2021 01:23:34 -0700 (PDT)
Received: from [89.139.98.169] (89-139-98-169.bb.netvision.net.il. [89.139.98.169])
        by smtp.gmail.com with ESMTPSA id l19sm3031891wmj.34.2021.08.29.01.23.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 29 Aug 2021 01:23:34 -0700 (PDT)
Message-ID: <612B43EA.2090009@gmail.com>
Date:   Sun, 29 Aug 2021 11:23:06 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 0/4] char: xillybus: Remove usage of the deprecated
 'pci-dma-compat.h' API
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr> <612A50C4.2080209@gmail.com> <CAK8P3a1=tZkb-rxj5Ys_FgUa=qoKPD6fpPjEMHXDL0QwwS0zgg@mail.gmail.com>
In-Reply-To: <CAK8P3a1=tZkb-rxj5Ys_FgUa=qoKPD6fpPjEMHXDL0QwwS0zgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/21 00:26, Arnd Bergmann wrote:
>
> The documentation was updated 11 years ago to only describe the modern
> linux/dma-mapping.h interfaces and mark the old bus-specific ones as
> no longer recommended, see 216bf58f4092 ("Documentation: convert
> PCI-DMA-mapping.txt to use the generic DMA API").
>    
Thanks, Arnd. That's exactly the kind of reference I was asking about.

And of course, a thanks goes to Christophe as well for drawing my 
attention to this issue. A bit surprising it didn't happen back in 2013, 
when the driver was included in the kernel. Or possibly in 2014, when it 
went out of staging.

As for this patch set, three out of four patches make modifications in 
functions that should be deleted altogether. Their only purpose is to 
wrap DMA-related calls made by the core driver, so that the pci_* API is 
used for PCI devices, and the dma_* API otherwise. As it turns out, this 
was a lot of nonsense code from day one.

I'll prepare a patch that removes all this.

Thanks again,
    Eli
