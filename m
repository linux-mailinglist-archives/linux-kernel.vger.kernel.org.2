Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597233A7592
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 06:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhFOEIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 00:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhFOEId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 00:08:33 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 21:06:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id e18so21678621qvm.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 21:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDA/6rYFbIzGwN3DJJ3v30Ilg60B464lccTuq9RZZyA=;
        b=fMG07OU4hKhOT0Ejr3qOHcrU08EN3G1+RpniZ8liKpsJESj8tYmvpPMQZbf905Arqa
         jTNjk7/cw8NTc05aXCrTOb4W4H63TAdnEqedfWvkUqde8aQCNzpKVfF+WTvNV5ptv2qS
         TsIum45Bdbkm1pBXJPvJDobZEXMxEtOKj24Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDA/6rYFbIzGwN3DJJ3v30Ilg60B464lccTuq9RZZyA=;
        b=SyFdRgqyd80JlQI0gh72dW60j1CCcsFF/iveSd45V1QkT6GOC7pQCqONkQgXZhp62n
         U3YfePdQKMdlhGnYQ4UFdtL8HzGcRs/WK7aMXN72ABDk9T83zza+3fPCd0gwjeR1CZT5
         4zyLLTFaUPlOFenU7qiRFnkgj3t4mWPFLIpZdws/a7oZeMCNDcC7lFlRcwGY+0SZY3b+
         4uZ5FotVN87Bmfx8qs9BTS3iLkG0u2trS1v1ddIs2iFaHKY18xH5kkzKhyEZcstrmJqW
         wXKIOPdRMhjvNTTSNpsFHb9gLfu1wiMRU+sqH42d2rsSrT3XgxFWTpSVQ4ZdesS8jWhP
         Ph4A==
X-Gm-Message-State: AOAM532i6OS7Xk5DcKTWY67/5NCkV2WroT3FB1mKa7P4NnMIkveWc/P0
        Wn0ie6ETyT08+D2S/LoRa/RWGMb750F+WA==
X-Google-Smtp-Source: ABdhPJxKQ+SMM4PsEgAzzhHy1mOdreKSuJIoKivcF1tpJnWk/v/H023EfjS0ArA/OaxzJTLe2Cx/5A==
X-Received: by 2002:a05:6214:428:: with SMTP id a8mr2597918qvy.3.1623729989093;
        Mon, 14 Jun 2021 21:06:29 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id u17sm9155912qkk.119.2021.06.14.21.06.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 21:06:28 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id r7so1858589qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 21:06:28 -0700 (PDT)
X-Received: by 2002:a02:384b:: with SMTP id v11mr19686288jae.90.1623729977741;
 Mon, 14 Jun 2021 21:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org>
 <20210611152659.2142983-2-tientzu@chromium.org> <20210614061644.GA28343@lst.de>
In-Reply-To: <20210614061644.GA28343@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 15 Jun 2021 12:06:06 +0800
X-Gmail-Original-Message-ID: <CALiNf29cE-T7xf+nUZF2pjT8osaXj+wb4MibtdSkAU_K13wuMw@mail.gmail.com>
Message-ID: <CALiNf29cE-T7xf+nUZF2pjT8osaXj+wb4MibtdSkAU_K13wuMw@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] swiotlb: Refactor swiotlb init functions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 2:16 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 11, 2021 at 11:26:46PM +0800, Claire Chang wrote:
> > +     spin_lock_init(&mem->lock);
> > +     for (i = 0; i < mem->nslabs; i++) {
> > +             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > +             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > +             mem->slots[i].alloc_size = 0;
> > +     }
> > +
> > +     if (memory_decrypted)
> > +             set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> > +     memset(vaddr, 0, bytes);
>
> We don't really need to do this call before the memset.  Which means we
> can just move it to the callers that care instead of having a bool
> argument.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review. Will wait more days for other reviews and send
v10 to address the comments in this and other patches.
