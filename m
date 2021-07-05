Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE53BC2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGESpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229939AbhGESpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625510546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxieeAsO+aYesQyPodozZxutTsNb3aB6Ym4RXVeMxF8=;
        b=Qc/Y976XLaN2XGyao14eqlGzITLS5A45gwE58S8bUhnWPgfFZIVx7eh/9B47/BYETMfMZg
        m6/YYm7NI943rlW1nIG+b0Y6y0H0zj8gtyGVf+OnTgyw4QbcmM5LJkGXD1iJ80CT2u6k/M
        NNozdGMJ5oF2mIRipO0CVqrEq6O4oCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-bm9IgCIvMu2ebXfgnZih0g-1; Mon, 05 Jul 2021 14:42:25 -0400
X-MC-Unique: bm9IgCIvMu2ebXfgnZih0g-1
Received: by mail-wr1-f71.google.com with SMTP id x8-20020a5d54c80000b029012583535285so6478451wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 11:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxieeAsO+aYesQyPodozZxutTsNb3aB6Ym4RXVeMxF8=;
        b=QcograKWNUZ+dFDTolpwwQJCRbCawfIwLs1EWeuquXyPUKQRRwBvIywnIHOGJ1NcwL
         FEBSYLbiR12SkWVfCH4RLibirLTafh6t47w8XNummV1Hd657lJOXgXfrmOsDKs3BJjgv
         W80oBVukI9Gt07xCPhaqUwTt1EJ+ox3lwqtV00ShJiKD881woMtkr1fdznGeRYWDkDS7
         NNB5ez4P4tuan913C9O5GPME7xICwyjo5sRgm4MevIP9MjXRKQXyZ0IImdYmAdhN1b02
         ++msL8nSgZAp+zkTPQ/aVhTMwpK6KuWvjVsaUqCYNAURKS43gFmO8P7+sK0piUgOI0i/
         7SAA==
X-Gm-Message-State: AOAM533Hab8UPHgmVQx3aq2hMvL6R96CHwqxK/b+8dtSOx102XfWXAed
        ktV+sylcrNIVJV4GzKpRJiX1EFcWpU59nW/L9OliSxbXzWedii2vQbjqjmvZlpdc0fnrH7QrSxv
        HPbbQPXmfnBKkSI8QvTRJ2J6b
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr15993590wmq.16.1625510544103;
        Mon, 05 Jul 2021 11:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlJJFPAXlaTcZQswco9ajV7a/O8ZHwJcSxi3zqI4tlkfUQnVjdSqzPKdDB74yLS1uXV1+ndA==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr15993574wmq.16.1625510543917;
        Mon, 05 Jul 2021 11:42:23 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id o3sm14223510wrw.56.2021.07.05.11.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:42:23 -0700 (PDT)
Date:   Mon, 5 Jul 2021 14:42:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, jasowang@redhat.com, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com, akpm@linux-foundation.org,
        yury.norov@gmail.com, ojeda@kernel.org, ndesaulniers@gooogle.com,
        joe@perches.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <20210705143952-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
 <20210705142555-mutt-send-email-mst@kernel.org>
 <YONRKnDzCzSAXptx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YONRKnDzCzSAXptx@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 09:36:26PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 05, 2021 at 02:26:32PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> > > On 2021/7/5 17:56, Andy Shevchenko wrote:
> > > > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> > > >> tools/include/* have a lot of abstract layer for building
> > > >> kernel code from userspace, so reuse or add the abstract
> > > >> layer in tools/include/ to build the ptr_ring for ringtest
> > > >> testing.
> > > > 
> > > > ...
> > > > 
> > > >>  create mode 100644 tools/include/asm/cache.h
> > > >>  create mode 100644 tools/include/asm/processor.h
> > > >>  create mode 100644 tools/include/generated/autoconf.h
> > > >>  create mode 100644 tools/include/linux/align.h
> > > >>  create mode 100644 tools/include/linux/cache.h
> > > >>  create mode 100644 tools/include/linux/slab.h
> > > > 
> > > > Maybe somebody can change this to be able to include in-tree headers directly?
> > > 
> > > If the above works, maybe the files in tools/include/* is not
> > > necessary any more, just use the in-tree headers to compile
> > > the user space app?
> > > 
> > > Or I missed something here?
> > 
> > why would it work? kernel headers outside of uapi are not
> > intended to be consumed by userspace.
> 
> The problem here, that we are almost getting two copies of the headers, and
> tools are not in a good maintenance, so it's often desynchronized from the
> actual Linux headers. This will become more and more diverse if we keep same
> way of operation. So, I would rather NAK any new copies of the headers from
> include/ to tools/include.

We already have the copies
yes they are not maintained well ... what's the plan then?
NAK won't help us improve the situation.
I would say copies are kind of okay just make sure they are
built with kconfig. Then any breakage will be
detected.

> > > > Besides above, had you tested this with `make O=...`?
> > > 
> > > You are right, the generated/autoconf.h is in another directory
> > > with `make O=...`.
> > > 
> > > Any nice idea to fix the above problem?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

