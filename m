Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7894C3BC29D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhGES3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhGES3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625509599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRRrtMgruURgChxNxWwRZrL7plq4LfVLAvPpmCv92RU=;
        b=XK91vIPuiVFWkedjaL15FkF9kQ0Lf63CoDdb5obdvVFh2eGhoPW1yPCYAKvSGuDryQ+hT/
        GK/IuCui3kaWp+n8HJtjoc8rzSvJKVOhNMFptQVSMLLg8q275u3ZSROij6kfBLW8I43gQP
        iN0DSt9gGyWn6236d84/Ceb7vdps9aA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-IxRkIFwyPF2KJ4EMOJb4Hw-1; Mon, 05 Jul 2021 14:26:38 -0400
X-MC-Unique: IxRkIFwyPF2KJ4EMOJb4Hw-1
Received: by mail-wr1-f71.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so6471408wrq.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 11:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oRRrtMgruURgChxNxWwRZrL7plq4LfVLAvPpmCv92RU=;
        b=q95FKyaaX0IIM+/gelIhjLldB8JRnL57zoVpNXEGdgWOhRH4Iv8hdAD4hjGtyMfrKf
         dvmJHe1Hiambjvyc3ACPM0Xk8xvEcUu4MBJphRAh9vdX6v3P7j9dYovHrE8nfs4JFKUH
         wsXFhfYfu8GiPvFhDdh/fd30RxPfma6s5QkXJmBFzxTfutpPKmMN2YOCkav8i/TxL+gu
         MaOC643v9F2LQHMUh2W9qTTTJq5esuV+4WDkNL/4aQrHeRn5JEb30nT9Smisw1QwX2ts
         2M3JV7KmYXo/HOZqdqC2KT/QEShTB4l/v402+8M1KPE9bbs+nuj4eKYGJzG5dMKEOEX8
         805g==
X-Gm-Message-State: AOAM532Yqff2PsODHQ+z7bHGYP8QkAubU/K8Yjbt8cj1/F/uW0TO/Pcb
        pcc4Y8hqpbt31HaJ81hsj+z3RvqIXnEDMxnCePVYFxjj8+UJHbgGvRJ+LJfypIEOmf+w4Fab27A
        JZy5JkJ04KUpPXh3ak/4EbqTc
X-Received: by 2002:a1c:2142:: with SMTP id h63mr16343502wmh.84.1625509597503;
        Mon, 05 Jul 2021 11:26:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxg6lV2mV2E4Ksstg1b9UaYYm1/na0HeVq/bH0oy4JNEBKaSdID8JncYLnj87O5OZ1B8dHdg==
X-Received: by 2002:a1c:2142:: with SMTP id h63mr16343485wmh.84.1625509597375;
        Mon, 05 Jul 2021 11:26:37 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id n8sm13899936wrt.95.2021.07.05.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:26:36 -0700 (PDT)
Date:   Mon, 5 Jul 2021 14:26:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        akpm@linux-foundation.org, yury.norov@gmail.com, ojeda@kernel.org,
        ndesaulniers@gooogle.com, joe@perches.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <20210705142555-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> On 2021/7/5 17:56, Andy Shevchenko wrote:
> > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> >> tools/include/* have a lot of abstract layer for building
> >> kernel code from userspace, so reuse or add the abstract
> >> layer in tools/include/ to build the ptr_ring for ringtest
> >> testing.
> > 
> > ...
> > 
> >>  create mode 100644 tools/include/asm/cache.h
> >>  create mode 100644 tools/include/asm/processor.h
> >>  create mode 100644 tools/include/generated/autoconf.h
> >>  create mode 100644 tools/include/linux/align.h
> >>  create mode 100644 tools/include/linux/cache.h
> >>  create mode 100644 tools/include/linux/slab.h
> > 
> > Maybe somebody can change this to be able to include in-tree headers directly?
> 
> If the above works, maybe the files in tools/include/* is not
> necessary any more, just use the in-tree headers to compile
> the user space app?
> 
> Or I missed something here?

why would it work? kernel headers outside of uapi are not
intended to be consumed by userspace.


> > 
> > Besides above, had you tested this with `make O=...`?
> 
> You are right, the generated/autoconf.h is in another directory
> with `make O=...`.
> 
> Any nice idea to fix the above problem?
> 
> > 

