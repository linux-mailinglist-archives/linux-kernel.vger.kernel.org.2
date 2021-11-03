Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0964443A96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 01:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKCAwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 20:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhKCAv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:51:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78365C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 17:49:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x16-20020a17090a789000b001a69735b339so138409pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZZrLtjwjEJ3IPsG9yhz+Qsv7Mbcxqz9ceN0wVwrxJA=;
        b=JRgj/olnX5KG4c7O7Xm0Jry+oiIPPVRs0ttrw6gNfqqnI1KamWVto+1Pxon2fIWDB1
         x1F3THYxTFa5CE7AzpmpAplt8VFcFKfqy3d3MAGp0s5nJkBUy9JedsZ+4OS6KUAKM+vB
         DvCegoQKw1vFIw4wXLe3UECLM26Wd75Cn2MgSkM0NOQW/tEUxE7RV1jJdp+3GjtYuyB8
         qk4COR6f2KXYi8/R57t9nLZVLeQ2fx8WIoFzd2PpFjGLiu6nnZ/mrHGax9Rr3YH4SIxn
         s76DGqePmbOMyvjyajU4ySIeJgRloDb6/b5JkF/zEIEF+UPqSUTfuYb6YiGVu536BR06
         QRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZZrLtjwjEJ3IPsG9yhz+Qsv7Mbcxqz9ceN0wVwrxJA=;
        b=UWsA94ACFrr4fntoouwPtu4NeKCmHItikwDwixS4UnzNYwRP/SEbQTxAPz3aaWuTaO
         tJp7r9xrcsVK2oxqkpT5b4hJnmYnvVH/vgOL9H2JvlWjWn+uJ6oLrVklvUl9ioHJ4FHQ
         5sS61D9YvIsCTF4RSqXQZR1yMcsR783b/lxagnn8kHudVkP6KUrXPzAuRgtNzAIK7aCH
         pxi3JLJ1QdnDsUFzxboXdjvIxWdi/u7EAN8SfakezuKaa11ZC0+260wkiFwCjDXDMlRr
         I5u6h+Y6RhwoI/u5Xv9SvN0CvZnSaCvmDyD0+3ZeBMTpWDpUYDt86W9vhjRdtn+uGft2
         s7eQ==
X-Gm-Message-State: AOAM532hcHa55v7UqFtKy6oKM4+QwfFo9HHrPrDggWM+LOPlynhDdMB0
        Bvde8tmKYi14T77mUKhERrM/I5EKQ/D6zjntrT4qTg==
X-Google-Smtp-Source: ABdhPJwbP41jEB/HwdZ/jyTpqMsXVbZeJ+GyahtI6BJWNgrRKpi/yor5GNtI40x53AU7YBTd151lFNCU4w2eHv7w/mI=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr10700972pjb.93.1635900563928;
 Tue, 02 Nov 2021 17:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211015235219.2191207-1-mcgrof@kernel.org> <20211015235219.2191207-7-mcgrof@kernel.org>
 <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com> <YYHTejXKvsGoDlOa@bombadil.infradead.org>
In-Reply-To: <YYHTejXKvsGoDlOa@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 17:49:12 -0700
Message-ID: <CAPcyv4h1dqBm71OQ_A5Qv4agT3PhV7uoojmSB1pEpS-CXaWb5w@mail.gmail.com>
Subject: Re: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early failures
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 5:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 05:13:48PM -0700, Dan Williams wrote:
> > On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > If nd_integrity_init() fails we'd get del_gendisk() called,
> > > but that's not correct as we should only call that if we're
> > > done with device_add_disk(). Fix this by providing unwinding
> > > prior to the devm call being registered and moving the devm
> > > registration to the very end.
> > >
> > > This should fix calling del_gendisk() if nd_integrity_init()
> > > fails. I only spotted this issue through code inspection. It
> > > does not fix any real world bug.
> > >
> >
> > Just fyi, I'm preparing patches to delete this driver completely as it
> > is unused by any shipping platform. I hope to get that removal into
> > v5.16.
>
> Curious if are you going to nuking it on v5.16? Otherwise it would stand
> in the way of the last few patches to add __must_check for the final
> add_disk() error handling changes.

True, I don't think I can get it nuked in time, so you can add my
Reviewed-by for this one.
