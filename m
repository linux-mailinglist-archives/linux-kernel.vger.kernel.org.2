Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F54A31CB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBPNoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhBPNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:44:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC2C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 05:43:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bl23so16613171ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4aIEOUjOCrSjLDXb3mtmGNuNkXiSZIhPKzU5zM+aPQ=;
        b=buncBvKPoDgi0mDnNxcMtJUW4SBhK1bNmdC5f+v/hQTv8lmNwxCoBI4WE2VR3MNGuA
         N+qnbz2mtngGoLCQiJMUWBKoVLmqQH8Dkw0rER13qkahBHeXieNixC1cS/4+I9PB62RS
         KQV+HChSOcQy0VTzRbiEytQMJiO56rKxjjqJgnauyxWGA4uf+09V+otQ+Ek5foCRuxp1
         WafmVcb7Prh/18Kw+8tv7XOaCHyvz5uKczY+84ard8unxSMnu0RiALTRoaLWs82Mv1Vn
         kqZgu2+9+4vRj5kMyiM7/c/34S0pm3DGa3h6NS7fm2FJhZLCdr4k5UXt68Y3hQrgLQ20
         0YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4aIEOUjOCrSjLDXb3mtmGNuNkXiSZIhPKzU5zM+aPQ=;
        b=X8GToQLUvoUImBuG6VbcZdEyBeTMD1MTefTmIeDWMOW1vd1nlToBXg7+fDBsGjvsrn
         7kvLVkDU7V3UmCiIqDeSYtj+J1oCQDnAsFxqCTImVbPCNHF/UcqGEzLBoYQQeg0AmgqU
         n1OY1LMsYCSFq08jWiss0ei9i45xljZzaFMXbOUXvR/dgLQDYedBAOlfZkYc/cFhSvk3
         Sfg4ZZGquvesWn3XqwxSwqKV67LUC/sGRMGSXiQGnAR1Cw5gjTibmHqTtpC1bIzvdfzz
         K5GySxrpsw3TUYLdlAopOty6xBiCCMjUhNs52Q8yVyD6rHln1nds0qgIeXg13p4ulvHQ
         oyeg==
X-Gm-Message-State: AOAM53099wDoe/Xm3vjrXGd+121ObBfsDlP/hM9BviK6gTpCRt2pOkJc
        Nb2EA34qLurlWFfNTE3UIgVDCyurxfCN+Tc/zC3lHQ==
X-Google-Smtp-Source: ABdhPJwNiuPUvaLufGG9a0tPuHT7VrdTNyIONpTy7saz/PN9GNeWzcq1nq86MBlPBPSx6AlQhTFZdN7QElpujVjK1Do=
X-Received: by 2002:a17:906:4a8e:: with SMTP id x14mr17745633eju.445.1613483020380;
 Tue, 16 Feb 2021 05:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-7-ben.widawsky@intel.com> <20210211120215.00007d3d@Huawei.com>
In-Reply-To: <20210211120215.00007d3d@Huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 Feb 2021 14:43:29 +0100
Message-ID: <CAMRc=MfhKMH+CcGxo_8j58c-NT_gQsZRqSjeH5mV3vCKUTWvhQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] cxl/mem: Enable commands via CEL
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 1:12 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>

[snip!]

> >
> > @@ -869,6 +891,14 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> >       mutex_init(&cxlm->mbox_mutex);
> >       cxlm->pdev = pdev;
> >       cxlm->regs = regs + offset;
> > +     cxlm->enabled_cmds =
> > +             devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> > +                                sizeof(unsigned long),
> > +                                GFP_KERNEL | __GFP_ZERO);
>
> Hmm. There doesn't seem to be a devm_bitmap_zalloc
>

FYI I've implemented both devm_bitmap_zalloc() as well as
devm_bitmap_alloc() and made them part of a series I sent out to
linux-gpio two weeks ago (surprisingly - it's nowhere to be found on
lkml or spinics or even patchwork :/). The patches didn't make it for
v5.12 but I'll respin them after the merge window, so we'll have those
devres helpers for v5.13.

Bartosz
