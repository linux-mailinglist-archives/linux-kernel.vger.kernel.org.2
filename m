Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C4330B071
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhBATgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBATgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:36:45 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BB2C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:36:05 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 63so17513013oty.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWBkNAaNFyDailoNLvfd01F/RWQlC5hp7A6f+h/cyqY=;
        b=TZxvbVNiXKihvb482TRxj/6WLckWUH8R84HUFz+GyZcJj4bDdqokogc8XZdjFuz66J
         B5QIJRO4vCDoGUNuyOgOqgmW4qpUurcYdQlvQjwMAo1AQsqhPVzf3x57z1YVHxjLLjMw
         BBPPaSfpe8ATUSfRZboIsbLfkbp2hi++WS0OCvjShV6qCf3THh8G2i3/vW4NTkCUBy83
         qtF4MRc/5EkX8POcuGFwClV2jvLeIQ/dCU/onWhEa3tZJ/1pr/lwn/AauK+RlpCaSDdu
         vD0tFxi8yEzu4n2K4AQ2p2GH3p6j7qrx3lQADHKCizJNfZatHNzTyRm4avKI55+xUqZn
         kkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWBkNAaNFyDailoNLvfd01F/RWQlC5hp7A6f+h/cyqY=;
        b=kf2HXPL5pSMvu0S3JNUowHoyU5lUg7J26A6QWJC0CPLvX988LshzAo3WBUcUWjdJCn
         JE/Wrgb1fSODBecSPTo/M6v0pmTqMlbPJSFow/jt3pzW6SDjUPWWtWylVg6H8DmPfPA+
         F0XjhU5cZXsmsJQAGt8qSyq0FiSK0t824Bj8dSN1Z9V9R8JeL03BmQmnIwjEBgNd+wzS
         Uwc5/nIEIEzFNsaD9xu/WmDZmTkthXAFlmeJC1vvbRoPJErYeGLqU5wd0DJr0Q17BsZJ
         73+KBxdiV5uD/UQureEdhxCOI+kG6TR6xbYchbivG1Ov/+S5cHraZhwGIucV9CYeOMQM
         yR/Q==
X-Gm-Message-State: AOAM530Nl32amgtoZH4r0AUjbU+gWVSt/FjX/kkWG6EQPfT44oaZJnKO
        9t/TrVv+/EIBQc0wFtvs2p0pywxPiyy2Br9y+s2Tfw==
X-Google-Smtp-Source: ABdhPJzyuAUli/LaOAe8RusYWEo21XH5hUPI02qphfk+PAI/Wvf6MAfQb2fhO5ryBBYE9EV4k+dZ9B02fM5dWCkJKOo=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr12655165otn.205.1612208164558;
 Mon, 01 Feb 2021 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com> <20210201183017.3339130-4-jxgao@google.com>
 <YBhOrK+kea7PNmXn@smile.fi.intel.com>
In-Reply-To: <YBhOrK+kea7PNmXn@smile.fi.intel.com>
From:   Jianxiong Gao <jxgao@google.com>
Date:   Mon, 1 Feb 2021 11:35:52 -0800
Message-ID: <CAMGD6P0qc0FZagmimTCuYsbJXo-WBHjtgoWSRzs63EULybTzNg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Erdem Aktas <erdemaktas@google.com>, Marc Orr <marcorr@google.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        gregkh@linuxfoundation.org, Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Keith Busch <kbusch@kernel.org>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 10:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> > NVMe driver relies on the address offset to function properly.
> > This patch adds the offset preserve mask to NVMe driver when mapping
> > via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> > depends on the page size defined by CC.MPS register of NVMe
> > controller.
>
> ...
>
> >       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> >               nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> >                               iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
> >       else
> >               nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> >                                            rq_dma_dir(req), DMA_ATTR_NO_WARN);
> > +
> > +     offset_ret = dma_set_min_align_mask(dev->dev, 0);
> > +     if (offset_ret) {
> > +             dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
> > +             goto out_free_sg;
> > +     }
>
> Seems like rebasing effect which makes empty line goes in the middle of some
> other group of code lines.
>
> >       if (!nr_mapped)
> >               goto out_free_sg;
>
> Perhaps it should be here?
Yes you are correct, it should be

     else
              nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
                                           rq_dma_dir(req), DMA_ATTR_NO_WARN);
      if (!nr_mapped)
              goto out_free_sg;
+
+     offset_ret = dma_set_min_align_mask(dev->dev, 0);
+     if (offset_ret) {
+             dev_warn(dev->dev, "dma_set_min_align_mask failed to
reset offset\n");
+             goto out_free_sg;
+     }

Thanks for pointing it out.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Jianxiong Gao
