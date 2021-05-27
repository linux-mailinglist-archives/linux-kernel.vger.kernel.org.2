Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D72392F19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhE0NIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhE0NH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:07:58 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5B6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:06:22 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 5so63246qvk.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgPMjyY5jAkXYAxU2M6Xs7JOfdHxgDuWupSEgAOvuBU=;
        b=HyAvfwEBrieOghAofexhSawgJJukm2YnQ2fAt2CFdEKEbDS1O9qhSu7HLdewyRfCVz
         gEA6t08wyk35Bk0UPING6Rrv8blJD9d3z2B2GuwI2wJTrYZe4msm0UUHcQ98yGMgAfAw
         jsaa2ecYO9Gel1C3uwINW+EKRzQM0HGE52Gr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgPMjyY5jAkXYAxU2M6Xs7JOfdHxgDuWupSEgAOvuBU=;
        b=d+nFwzKS7YJb4+98kpWJ/TZPiXk69MuzTeC1mHKOnn7C0cS2jKV25KXl7JCQ9c5sPO
         4orgntAa3oeZ1t/aNVxa1mK26aHBZziW1A+5uJ8esdo0NhcQ0QdfQM5onbEliJmUWAD+
         IQ1C+y2qWO3xmKhOWjcDvKQO2Od7Hd9lY3VEosZoVrXOfyY6107rmiJEJI+/faap449I
         knkzfiC+jOCTeYrDUY0FwFUPnHC9KggcWLCIgs8fMOa0EGDn8o47WkxMdXziDjFegC3X
         Fs+jmpTOb1RfMcAbxrv90TOFBR3LjSJqi/hwiQxQhywM7qFCOwZJqVdRUgb9iGYG3i74
         VpGg==
X-Gm-Message-State: AOAM532/OhH4D1ayuJxgXbBgpnY0EO1grMqRwMbw3yEzL/zpdZXtYq/M
        Ua6wr8RGwRGjbMIG3zHmmi17BmeZ9IfwaA==
X-Google-Smtp-Source: ABdhPJyEB17bKboB9H0ivh+76MF/E3OSX4/4Oqjr0JCG9pi7Dr8WD6IHSGn9lp5SK/8iTBHel8Gewg==
X-Received: by 2002:a0c:ee46:: with SMTP id m6mr3254869qvs.8.1622120781041;
        Thu, 27 May 2021 06:06:21 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id w4sm1252327qki.57.2021.05.27.06.06.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:06:20 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id h20so482227qko.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:06:20 -0700 (PDT)
X-Received: by 2002:a02:a505:: with SMTP id e5mr3414377jam.10.1622120419476;
 Thu, 27 May 2021 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 27 May 2021 21:00:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-dUFSCOz4=jmEm8ZcX+zQXKzo6yPg31iLLLG3FAr+g1w@mail.gmail.com>
Message-ID: <CALiNf2-dUFSCOz4=jmEm8ZcX+zQXKzo6yPg31iLLLG3FAr+g1w@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Restricted DMA
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

v8 here: https://lore.kernel.org/patchwork/cover/1437112/
