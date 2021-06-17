Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6813AAC66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFQGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQGea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:34:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C864BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:32:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g22so4128176pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqsCA/yjikDS1aCYzllqiH9HoLVcQQhYIn5qSeonABE=;
        b=kDczImboY2eVAJ3+sYnRR25HrludaTlIxUHPV26t7zvADYlkn+EAot8vmNZFxS6ckk
         NyqXP6vgSOkhkXMigW38BKTSHGkozev95CT8sd0RyYFWHSEXQf1vzK9yA5xbK5UPbuEq
         Bn0NNhaz+a2zeBhstpYyx1baPQ8VKdD07y9nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqsCA/yjikDS1aCYzllqiH9HoLVcQQhYIn5qSeonABE=;
        b=UH8u+tUwUWIDl+NsaJOD8P9cfDxidhiblh3CyA73YsOtGjH6ZwyGAAjffBZXiQOdB8
         cRrxjcV3BP9quAY2kWP0jgTYikW5iMSlC4bqqh6auY61g62wgHEWl4pCExNwYqDD65cJ
         ZOicwUNBgRCbCez1DACcmjTLOdFYr/Buw/X3HLsprxpcHGtjaJIW1MSsz3UmqaBHhc8R
         L+nlfmcKOzuN2piL+UWd6udS/lOM/wqo9NBg7b+Km+5iFeeV6Z1kCESVi1NssqSfjC5U
         3ofVJ9121/vRHWfvHOUeOCUEgTTjeNXvxeAgmqHRTMpzAC0AhIYEpKsq4Q5Fafu03vAF
         P/5g==
X-Gm-Message-State: AOAM530C00C4fB0/GibhpzwVf4rlYYjvrWBeAIxj4DLB+e9BpO8httX1
        mwQGXukKhWPlGhEPSrC+g4OnTn7L1mZ7HA==
X-Google-Smtp-Source: ABdhPJyA0qwXGmJW43gJInNwkxfg9z35nKCwMTeOGnVu2ilp0mGxfUGM2wg311lmhhjcEZ4FHc7ByA==
X-Received: by 2002:a63:31c2:: with SMTP id x185mr3560079pgx.97.1623911543151;
        Wed, 16 Jun 2021 23:32:23 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id k1sm3933418pfa.30.2021.06.16.23.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 23:32:22 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id k6so4148092pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:32:22 -0700 (PDT)
X-Received: by 2002:a92:c852:: with SMTP id b18mr352877ilq.18.1623911531698;
 Wed, 16 Jun 2021 23:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617062635.1660944-1-tientzu@chromium.org>
In-Reply-To: <20210617062635.1660944-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 17 Jun 2021 14:32:00 +0800
X-Gmail-Original-Message-ID: <CALiNf2_qF7OY0LHToNYx0E79BWMt2n7=nepPPLf+7YV3=KFEyw@mail.gmail.com>
Message-ID: <CALiNf2_qF7OY0LHToNYx0E79BWMt2n7=nepPPLf+7YV3=KFEyw@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] Restricted DMA
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

v13: https://lore.kernel.org/patchwork/cover/1448001/
