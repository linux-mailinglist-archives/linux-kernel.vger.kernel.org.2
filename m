Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0FB37809D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEJJ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEJJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:55:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84572C06134E
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:54:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q2so13188716pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsG0kiz0NRABZofCxSQspiIrXqavy4umxXhfkY+/Sxk=;
        b=W+HYriAR9Do/fBW2QstFckigQIl1nRoVqh8kV8zVcpd71XHdedwgr9ODHG4afQkOIy
         ynwXu3yhnIcmMABVDj/QNeRt0F7V/f3la3pyVX+S+CEgEQdWOUMw7w57whXmk3tKqZQ+
         S7fuzxNEGgGmhiunD9+8473p2BUhLcDS4p74Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsG0kiz0NRABZofCxSQspiIrXqavy4umxXhfkY+/Sxk=;
        b=Tp/ON7eA9XNJyh0ziIGaG+fRJctiLgzch99C5CFhBRWTWsICnNusagIhzmK6jmrW2g
         HBzvbw548Z/4Kbi3YrFMFKKQ/AoqHm/xc4B+PiQIpSI158rBHWrxxC6UhBfT3VAVbQLe
         lZb2qKMVlxNM2VF0DxOOOwbesJI6yDmdCJWEBwGhTNaB3mlwrpvO1oEEd6Yx2afT8Y3Q
         vDfllwbHL7I0ceW9yV3nbfOUVNG/U5hGfEqHMOvxZ2bysJABxCOrjrCV/tr2Wmm/QJI3
         Sv8dbZh1/ZaL78kB5NfdWlQMr6TFWetHk+LjSYE5myFI7BgtCOcd8B5DXqdjPUPaRm2L
         JaNA==
X-Gm-Message-State: AOAM530UlfqdPqpUeKRd9t5cLXm2YDL+6prA5Yxwu9c8UHYPrmRZldeC
        5MKA5SjU9A7DggRM2VZaDXdRy39TxDccRQ==
X-Google-Smtp-Source: ABdhPJw7N9PAcDO7bbkwvgHLMO/TVYfHBWWRQtt4HuQ8dq9+HW/IOpsO3Yp+FBN9yMPmRV/+li9KSA==
X-Received: by 2002:a62:808b:0:b029:252:eddc:afb0 with SMTP id j133-20020a62808b0000b0290252eddcafb0mr25202174pfd.41.1620640460688;
        Mon, 10 May 2021 02:54:20 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id g29sm11149171pfq.148.2021.05.10.02.54.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 02:54:20 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id m37so12905407pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:54:19 -0700 (PDT)
X-Received: by 2002:a92:6804:: with SMTP id d4mr20856971ilc.5.1620640447894;
 Mon, 10 May 2021 02:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 10 May 2021 17:53:57 +0800
X-Gmail-Original-Message-ID: <CALiNf2_h8r6jpd1JqTwNEmW22KK8aT9B4djLKkYP7Hhnju2EKw@mail.gmail.com>
Message-ID: <CALiNf2_h8r6jpd1JqTwNEmW22KK8aT9B4djLKkYP7Hhnju2EKw@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Restricted DMA
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6: https://lore.kernel.org/patchwork/cover/1423201/
