Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E443887C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhESGp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhESGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:45:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC79C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:44:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s4so4897629plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crJApTk0fR8CS3cRDbB3V67gscNvYMiJEHMFrBZfWUo=;
        b=zDGZZs/er8Q9IuA9Imgu2QK64TdNwRQPa6zLFs3OWErIjQOBeBTCV7kAFI8XkEVKBr
         7bimA/liFg+A8v/bCayXSehaSTT0F7V13I/Q44TYvfDL10K/hpHYxVbbzgQSr9Ocp1KW
         OjhyTVZqfbu6yFKgiafgqAFXyy8hw1jzKdN/Qpnb81hAz+pcdvz1+YxUEqVBvhNjLBfp
         uZPrxYwQiNSc0Udlc4+QVfWruZN81uje9iEir53nWlq/lfHmC7bWlKHsBxeRdqXjIVFp
         LnRvKqglalyIDwsrVoT/VOk+EEY/tiruqS+80tcJK3sSdDz0WMgb/5lbceYP6Gsiljpb
         Ycgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crJApTk0fR8CS3cRDbB3V67gscNvYMiJEHMFrBZfWUo=;
        b=KWoaFo3ahb4rlX6W/sr7dYzhjWxdNNeQS17LkQHLpdQ88d1AL68AvreayvnDOm66uS
         eC7a6Jnr0AcjFOMkuzDmErFrsWkcY8G+6V6uBGTdg1bxjkWoGD96A+rE1xfgbmQhKJXl
         SoOuKYwPVLIdFie8I1vjkQOScHEvTIA49b6Suon3AJKLXn2H4AZKU5oK3GQtghK/7o0z
         d6amgAVrMD1hDoTUDGZYDyJvM4fVsQHOx01zkItwMapGatxF/WUySum1F7X2kw5woAfq
         ENNGl61gLsBZujNLB1fZAelk+QD+teWNWja/UJ4ojz0aFFJZv9YEhYN6jVQyX6G4hXlY
         MFDA==
X-Gm-Message-State: AOAM533J1WcHLcnKD2ST2uXSir6tnP/g65b3nNMGBFa+fBjATqwI+3fT
        kdeNKe/kzlkI5zVQjmYqr1REsg==
X-Google-Smtp-Source: ABdhPJy9tsWxCDo/o3R7ta1owz+e2PxTX//mYRmicr9Nz+qbfH9zpmvYaQDcpfama4JkK8fiYfECwQ==
X-Received: by 2002:a17:902:e8cb:b029:ee:f963:4fd8 with SMTP id v11-20020a170902e8cbb02900eef9634fd8mr9185136plg.40.1621406677878;
        Tue, 18 May 2021 23:44:37 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:9384:8c4b:dc2b:c4d0])
        by smtp.gmail.com with ESMTPSA id v14sm8823848pfi.25.2021.05.18.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 23:44:37 -0700 (PDT)
Date:   Tue, 18 May 2021 23:44:35 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        paul.walmsley@sifive.com, Nick Kossifidis <mick@ics.forth.gr>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210519064435.GA3076809@x1>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:48:23PM +0800, Guo Ren wrote:
> On Wed, May 19, 2021 at 1:20 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, May 19, 2021 at 05:04:13AM +0000, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
> > > vendors define the custom properties of memory regions in PTE.
> >
> > Err, hell no.   The ISA needs to gets this fixed first.  Then we can
> > talk about alternatives patching things in or trapping in the SBI.
> > But if the RISC-V ISA can't get these basic done after years we can't
> > support it in Linux at all.
> 
> The patchset just leaves a configuration chance for vendors. Before
> RISC-V ISA fixes it, we should give the chance to let vendor solve
> their real chip issues.

This patch series looks like it might be useful for the StarFive JH7100
[1] [2] too as it has peripherals on a non-coherent interconnect. GMAC,
USB and SDIO require that the L2 cache must be manually flushed after
DMA operations if the data is intended to be shared with U74 cores [2].

There is the RISC-V Cache Management Operation, or CMO, task group [3]
but I am not sure if that can help the SoC's that have already been
fabbed like the the D1 and the JH7100.

thanks,
drew

[1] https://github.com/starfive-tech/beaglev_doc/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
[2] https://github.com/starfive-tech/beaglev_doc/blob/main/JH7100%20Cache%20Coherence%20V1.0.pdf
[3] https://github.com/riscv/riscv-CMOs
