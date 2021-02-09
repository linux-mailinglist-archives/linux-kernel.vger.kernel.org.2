Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D690F314EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBIMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBIMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:37:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A480C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 04:36:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v24so28090084lfr.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlO/IHS+gsLGXDK9MI6n2G68BWNFddAvWp2ImdoQBSU=;
        b=ANVoCoLTdRpeNuFdAnXRfBbcVVqmgxnSyOFyu/rCK5rR7OfuDQkZCI++TdUasGDvXJ
         nviLh3US2gOoW/xBZtF+PVDcPxNT2bi5gRCrZrFqVwzF6kLa7gz9OlxonMOJZDYws8kS
         Jxl8F3DWuMvuvjYcX7AVnexOv5+VmEDwuDl6dzqJJDJFopoT0CqK+crFlk3BXpOmXhzD
         qypY8NJYsStm0Zd8qYoTG9LqPDhaxv89+fkQILj8srlfemB9FzdAt+VRhdx/cewYPbe+
         qOAJyhgbIHAeT/eawqUAq+TuBBjRvaKojLG9F3BHhsVDqZ5VWNkk8V29QPmtdr+N29+F
         taGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlO/IHS+gsLGXDK9MI6n2G68BWNFddAvWp2ImdoQBSU=;
        b=D1u/9RLm2twof2gGAbkF2Sm5rtJskB1zmGqjcviJbcf8+EcbY6Ui2ryTGjjVmxlhH/
         LeP/sB5K8CZYmkJLff6dFLWhH/N1LQx5SLDX0AS/uMRq73eu/mOAWQRNXm8oa+OqiHfN
         4rV3am9ROasdCjVL6wp50MSjRuZTgWR/iAkT8OJ4YMnuHQaPCi04PBLf2zwRxYBYHzju
         HcA7N7FivtMIQ9Cdt2t/CgyStgXtDOkuwdH25E7Pz+tzwLU9TTsSSYxr80bSg32ax+EH
         Ped1uSr26oas8GBtLh2vb88YiiEaDbX3mKz5p5Pz/5UR2fz4PZxgRL/SM1vDUkHai+XW
         fE6A==
X-Gm-Message-State: AOAM530RoQIXLyQH+JewpwCJxfbsG3DcbBnKDV3mIZQSnz8gR3hRgAgo
        YkWDrzDImeVKNWxSDsazXlXe4rmMoga2rB2XYsHPOqudV4S7Kw==
X-Google-Smtp-Source: ABdhPJzLWP2m9ZyklHdcfgz4+xI8GHZZFrzP3zKXNsAXGCce8LymSyD62L38I3SdSjyQcQplaY+oPxoqbLa8Hg7mKj0=
X-Received: by 2002:a19:e308:: with SMTP id a8mr2836867lfh.194.1612874197036;
 Tue, 09 Feb 2021 04:36:37 -0800 (PST)
MIME-Version: 1.0
References: <CAFA6WYNazCmYN20irLdNV+2vcv5dqR+grvaY-FA7q2WOBMs__g@mail.gmail.com>
 <YCIym62vHfbG+dWf@kroah.com> <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
 <YCJCDZGa1Dhqv6Ni@kroah.com> <27bbe35deacb4ca49f31307f4ed551b5@SOC-EX02V.e01.socionext.com>
 <YCJUgKDNVjJ4dUqM@kroah.com> <20210209093642.GA1006@lst.de>
In-Reply-To: <20210209093642.GA1006@lst.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 9 Feb 2021 18:06:25 +0530
Message-ID: <CAFA6WYO59w=wif8W16sG6BnzSjFhaY6PmRUTdSCu9A+zA7gzBw@mail.gmail.com>
Subject: Re: DMA direct mapping fix for 5.4 and earlier stable branches
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        obayashi.yoshimasa@socionext.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, 9 Feb 2021 at 15:06, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 09, 2021 at 10:23:12AM +0100, Greg KH wrote:
> > >   From the view point of ZeroCopy using DMABUF, is 5.4 not
> > > mature enough, and is 5.10 enough mature ?
> > >   This is the most important point for judging migration.
> >
> > How do you judge "mature"?
> >
> > And again, if a feature isn't present in a specific kernel version, why
> > would you think that it would be a viable solution for you to use?
>
> I'm pretty sure dma_get_sgtable has been around much longer and was
> supposed to work, but only really did work properly for arm32, and
> for platforms with coherent DMA.  I bet he is using non-coherent arm64,

It's an arm64 platform using coherent DMA where device coherent DMA
memory pool is defined in the DT as follows:

        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                <snip>
                encbuffer: encbuffer@0xb0000000 {
                        compatible = "shared-dma-pool";
                        reg = <0 0xb0000000 0 0x08000000>; // this
area used with dma-coherent
                        no-map;
                };
                <snip>
        };

Device is dma-coherent as per following DT property:

                codec {
                        compatible = "socionext,uniphier-pxs3-codec";
                        <snip>
                        memory-region = <&encbuffer>;
                        dma-coherent;
                        <snip>
                };

And call chain to create device coherent DMA pool is as follows:

rmem_dma_device_init();
  dma_init_coherent_memory();
    memremap();
      ioremap_wc();

which simply maps coherent DMA memory into vmalloc space on arm64.

The thing I am unclear is why this is called a new feature rather than
a bug in dma_common_get_sgtable() which is failing to handle vmalloc
addresses? While at the same time DMA debug APIs specifically handle
vmalloc addresses [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/dma/debug.c?h=linux-5.4.y#n1462

-Sumit

> and it would be broken for other drivers there as well if people did
> test them, which they apparently so far did not.
