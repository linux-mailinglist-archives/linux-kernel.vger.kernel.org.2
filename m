Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77103AAB22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFQFjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:39:39 -0400
Received: from gw.atmark-techno.com ([13.115.124.170]:46138 "EHLO
        gw.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQFjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:39:24 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 4B9CE80425
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:36:38 +0900 (JST)
Received: by mail-pg1-f197.google.com with SMTP id u7-20020a6345470000b02902211e79e4c1so3036782pgk.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r4K6MpRTPV0jY/7atoPTp6yk6TP7qhEuUGZiRkCr2zQ=;
        b=szgqpBmRzDRlyiDz91wq6V02l2SSxrlkKD1167oToofZAGyL7aiI4/jP1suLjCATv3
         JRBA5jlTRNLb+PyJbMDmigvsCdCdtTtsUkE8FtefDXbdXzcVsD24iCt3i9fsMmMTZsBG
         1lwdF57wekjdQuIasmFXTzG6JMwzvAdwR2DlYdfNgk87qaYoi6RkXI5Q47EzCdIilhU0
         5s4VXy+Qgygu0vWolitgA3bofCYFGdHM+x7P0EIV/ujD1IgJluSYT3L3E0bYF+BQHgMB
         gvDp9Mq7hHMJ6UW9abFJpBvRLGnpvrJzrtc4CKx9i9LD7iCUvgeUpHABn2CLAaDqbfx4
         N8mQ==
X-Gm-Message-State: AOAM533YiwsJPQ7jwDaSdNqaHV+ILNxtUOZURUcc/q+6Ri8Abe4OsGnj
        brXmcexMfsG3Z5tvRjsnkIp5NNC+58NdiuxrG9v6wTofY2ssELurYAmkcFDaD+Qv3PY5VP2kfFr
        z0a2bRzONXkyvd5/+IvlsVE0r/jOv
X-Received: by 2002:a17:90b:3696:: with SMTP id mj22mr3678202pjb.42.1623908197373;
        Wed, 16 Jun 2021 22:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztIscCdlZzD+giyPAZOggDuCPdjDOLTlJ90UW2jHvI7/gp0XO7pZjbkYSBv6oX4Oss6ySEEA==
X-Received: by 2002:a17:90b:3696:: with SMTP id mj22mr3678172pjb.42.1623908197065;
        Wed, 16 Jun 2021 22:36:37 -0700 (PDT)
Received: from pc-0115 (126.88.200.35.bc.googleusercontent.com. [35.200.88.126])
        by smtp.gmail.com with ESMTPSA id y27sm3846134pff.202.2021.06.16.22.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 22:36:36 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1ltkhe-00FfYs-Dp; Thu, 17 Jun 2021 14:36:34 +0900
Date:   Thu, 17 Jun 2021 14:36:24 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Jianxiong Gao <jxgao@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YMrfWBLsJxCRhX5U@atmark-techno.com>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora>
 <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617051232.GB27192@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote on Thu, Jun 17, 2021 at 07:12:32AM +0200:
> On Thu, Jun 17, 2021 at 09:39:15AM +0900, Dominique MARTINET wrote:
> > Konrad Rzeszutek Wilk wrote on Wed, Jun 16, 2021 at 08:27:39PM -0400:
> > > Thank you for testing that - and this is a bummer indeed.
> > 
> > Hm, actually not that surprising if it was working without the offset
> > adjustments and doing non-aligned mappings -- perhaps the nvme code just
> > needs to round the offsets down instead of expecting swiotlb to do it?
> 
> It can't.  The whole point of the series was to keep the original offsets.

Right, now I'm reading this again there are two kind of offsets (quoting
code from today's master)
---
static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
                           enum dma_data_direction dir)
{
        struct io_tlb_mem *mem = io_tlb_default_mem;
        int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
        phys_addr_t orig_addr = mem->slots[index].orig_addr;
---

There is:
 - (tlb_addr - mem->start) alignment that Linus added up
 - mem->slots[index].orig_addr alignment (within IO_TLB_SIZE blocks)


I would assume that series made it possible to preserve offsets within a
block for orig_addr, but in the process broke the offsets of a bounce
within an memory slot (the first one) ; I assume we want to restore here
the offset within the IO_TLB_SIZE block in orig_addr so it needs another
offseting of that orig_addr offset e.g. taking a block and offsets
within blocks, we have at the start of function:

 |-----------------|-------------------|--------------------------|
 ^                 ^                   ^
 block start       slot orig addr      tlb_addr

and want the orig_addr variable to align with tlb_addr.


So I was a bit hasty in saying nvme needs to remove offsets, it's more
that current code only has the second one working while the quick fix
breaks the second one in the process of fixing the first...



Jianxiong Gao, before spending more time on this, could you also try
Chanho Park's patch?
https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f

I frankly don't understand many details of that code at this point,
in particular I have no idea why or if the patch needs another offset
with mem->start or where the dma_get_min_align_mask(dev) comes from,
but it'll be interesting to test.


Thanks,
-- 
Dominique
