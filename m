Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A8F3A7FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFONdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhFONcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:32:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42CC0613A3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:30:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso1837610pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDZeAXhtUGNxVigPWnCAmqvhZ5xmOZkpwoxu/kotpBc=;
        b=BkGuougKdpvJFSjPDCYcuDM+EfC9+Z6Iw8t63OKFUyvGcy9WEOaTZOyzUjDtlqxxWx
         b+f6+GiSSKCn4V8zlclen8CemZkaZyLB8FJKB0g3go6na2Mkb6J76IEsPQg2PB5YFP++
         oJX8/uFYscqhRRWgaBEXbZGZq7TD88YFqCsf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDZeAXhtUGNxVigPWnCAmqvhZ5xmOZkpwoxu/kotpBc=;
        b=mhF+P5AxfFqWg1gX6iG99wcjb6LB+bqEsj3nQcy3sjsq97GNVxhcA/EfInY5fYxQkW
         vD+i5VYZ82A0qdc1GX0kHDf1hKoJFWJCui7RvWwhT4GTQnmPzOMs+z8E69qo4evLJ8dj
         gurTY73UQO5UcfmiDrG2Xwb5iLI9iVmNsaVQDWWOq4qTSx25HVx0xWXb1AtY43O4k3aX
         1pUH0/5aIg9pD2bNWOkXUaUZ5VGLR2WOd1Cq0dh4oajevvUEHugttJ4xh7UUFkTjeZmN
         Eg5yRYXfZWYEnJcfrKqB6AyMVEJ/wwugJXOHRsudMulvFZn3moxrLlkBNwhSHXa48kgS
         pDIA==
X-Gm-Message-State: AOAM533R1e5Tf73Q7L4MxLfXwV4kVtI2nkjBLuTt2iKqjNsnXOofSB1m
        qvjvuAwZiJApu2CHSQYPTxLBmqidg9XfmA==
X-Google-Smtp-Source: ABdhPJxfml3Fqsrf3jLtipA51ToLJqViCTKS855/iP1nrQer+0Ky6R+3iiDFs1ISrhhH4wjEWSREUg==
X-Received: by 2002:a17:902:860b:b029:103:b23b:f1c3 with SMTP id f11-20020a170902860bb0290103b23bf1c3mr4306912plo.34.1623763849259;
        Tue, 15 Jun 2021 06:30:49 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id b21sm13258134pgj.74.2021.06.15.06.30.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:30:47 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id t9so11442807pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:30:46 -0700 (PDT)
X-Received: by 2002:a05:6e02:219d:: with SMTP id j29mr17936278ila.64.1623763835517;
 Tue, 15 Jun 2021 06:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org>
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 15 Jun 2021 21:30:24 +0800
X-Gmail-Original-Message-ID: <CALiNf28fb4rZ0Afun8wAWRYJY4gqc+-vRvDBZT3x2JgSPL_iVQ@mail.gmail.com>
Message-ID: <CALiNf28fb4rZ0Afun8wAWRYJY4gqc+-vRvDBZT3x2JgSPL_iVQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] Restricted DMA
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
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

v10 here: https://lore.kernel.org/patchwork/cover/1446882/
