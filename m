Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A853D1681
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhGUR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhGUR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:58:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFCBC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:39:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b29so4191126ljf.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVG+jbRDBSu+eXxXtQp1KBYPh+7m/khOUuuf9tJsJlQ=;
        b=o0knBKRqF+/V/tbZpHxFHljIbk4FsvpfHxd1B4gIGEd6eXlgdOM3oy0vhGXit4qYj3
         Eau+h3HBB/pRHR7jWtV+eRigTywh20vgTGPLE+kHjvhHEv1ehZ01GA/4VF8wU23W+Ykv
         EAJaX4O9jgr3FMsTBKsz07UN/lmzQ6HdWBm6TBVUW892tdubZjbTaGBZjMx8ZAQYJ7cO
         SIVhMpC2buXAwwPSCIZ6N/RAcaDc5RF3LZMUFdeqUaD0NYg0nDfSDZZ7xZPyjVy6dWbV
         rhw5saUHGPTXtEGx/ZJc07ntkyzEClVwkS6wR2VacLMcAJDIjYQMxoqoQLbUfqU+ZYCH
         QWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVG+jbRDBSu+eXxXtQp1KBYPh+7m/khOUuuf9tJsJlQ=;
        b=iebTwF5m/bBDSCyElOWFlAYbTzJMDc0bwktU2MMEKcH/5UKt94jjFClq9uk3n1FeWF
         6bl8QJ/eYSVSVTKKcBTJ6Wco1S1WZ6NL8NQ14S/IQwR/4wiIDE1V5cW+Mhlo5xwI4yZg
         3yYwjDY03C1jzpzOm5EuRraTQW+T/RRAMH7ZuD1gkFg+bDssUOtk1ieT0sc/XfDN2Hm4
         9sHOG+egq8RioqH1FklnPq2FZEDtwRubo7PJrIE6AZjOFstslvr6ydcxevX6uGj1I7CQ
         g1JBaba0QP+fnZPHn8FVuDNAqN81E44XZ+95GH+ZAcPFelzdOdgRZY3PoSYLWY66iOOG
         ryVg==
X-Gm-Message-State: AOAM533kF/LizusuekLf/mN5TW2qaM+HuaMF6AhHAuNxeBcQQSthA8Z/
        C8coyqAmVvMRGJvJXzobTMcgJlgWpfyPHxpQgCQ=
X-Google-Smtp-Source: ABdhPJwoLGwmM+TS2dyBgKCbp5Ry4yu+pA8iXsy3Lf/VOi5eurQ/S0y3MgQ+JBpzeMSSwEoknDX2czlo24N5L0fkqf8=
X-Received: by 2002:a2e:890f:: with SMTP id d15mr31953878lji.37.1626892756146;
 Wed, 21 Jul 2021 11:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210715170011.GA17324@lst.de> <20210716083934.154992-1-rm.skakun@gmail.com>
 <20210716093551.GA17981@lst.de> <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com>
 <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s>
 <CADu_u-Psn5QpOyZ18_NCPx14DYxmGmSqVod=_RBC3A_A93tGUw@mail.gmail.com> <20210719092235.GA31566@lst.de>
In-Reply-To: <20210719092235.GA31566@lst.de>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Wed, 21 Jul 2021 21:39:05 +0300
Message-ID: <CADu_u-OVTGFpDw9cP+VHMAW8fdG3mtMZDCG3Tu92fF286zVFDA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Roman Skakun <Roman_Skakun@epam.com>,
        Roman Skakun <rm.skakun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fine with.  I've queued up the modified patch.

Good. Thanks!

>
> On Sat, Jul 17, 2021 at 11:39:21AM +0300, Roman Skakun wrote:
> > > We can merge this patch and create a new one for
> > > xen_swiotlb_free_coherent() later.
> > > Yeah, no worries, I didn't know that exposing dma_common_vaddr_to_page
> > > was problematic.
> > >
> > > This patch is fine by me.
> >
> > Good. I'm agreed too. Waiting for Christoph.
>
> Fine with.  I've queued up the modified patch.



--
Best Regards, Roman.
