Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AD367C65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhDVIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbhDVIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:21:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:20:47 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r5so28930385ilb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BktECYBH/xHVGxDXNo4Rc6r/8IEdgyWc2mDrQ18gIJM=;
        b=BC2Z7dWmz0+RdT/XQKgh1K4ZkXJWhtVP5f0aeqau16cKa9TxEulrDttNm/OJj6Mh7t
         UyOvttg8zei2cv/nltxGkE0p3bcuSz0WfMCJrDJbCm50bzbAxl15NHtEWBdONDfWW0Bm
         8ytbqnnr0G3b0l9nz1ILNC8uPEz+czqvEKbV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BktECYBH/xHVGxDXNo4Rc6r/8IEdgyWc2mDrQ18gIJM=;
        b=EHf9xM0Ag2tIGBaPQGRI3/bcpYbe2AS4ZUcpJkWrXMn0+W3tXrV43/cxwF/oB2O/o6
         NBI/putMtgXthAEJ86e4zGDKmuReJ/xyGlrcz+L+wStuJjzefJbzr6iAx0pmVL+4lInJ
         +JkQA3VcSBGgQUudYtCOKPpaMY6V+MaKsPnwmaLxG3qZdyBFmc98RZXWhvCv2HssyC7N
         5nkRO1JIv0S5boqC3xTjTR/Zy2WbrPhXI8SQ/leQVqZApT+t2FnydSsvldv24qp3jn7S
         c+fRPJKw8OwnQCkKGAcq704oxUhihdeyYlcjh91AKN0DjbPVNxJXrs6TqmuONAidh3gS
         dOjA==
X-Gm-Message-State: AOAM530AgXZcvSHmDhjoo4qWkymRfDbWAD/6D/YZnJChWXsaRxeQuXzv
        IZbZg2PUKGswgKybYD3rkf7p+tg/6o9VWA==
X-Google-Smtp-Source: ABdhPJxUEVROX34bK5Zzpxx7fdHCdFjXlgV3NutP5az7hDRBt1ArwXFTz2RWp57Q7j9zzr36XgHCoQ==
X-Received: by 2002:a05:6e02:11ae:: with SMTP id 14mr1722371ilj.307.1619079646378;
        Thu, 22 Apr 2021 01:20:46 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id i1sm840930ilq.43.2021.04.22.01.20.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:20:46 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id e186so44711015iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:20:45 -0700 (PDT)
X-Received: by 2002:a05:6638:34a0:: with SMTP id t32mr2134909jal.10.1619079635295;
 Thu, 22 Apr 2021 01:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210209062131.2300005-1-tientzu@chromium.org>
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 22 Apr 2021 16:20:24 +0800
X-Gmail-Original-Message-ID: <CALiNf29cMK_j2NF3sbzMJLsss0v8fcvWMkQULHViQVebmdmTsQ@mail.gmail.com>
Message-ID: <CALiNf29cMK_j2NF3sbzMJLsss0v8fcvWMkQULHViQVebmdmTsQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Restricted DMA
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
        Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 here: https://lore.kernel.org/patchwork/cover/1416899/ to rebase
onto Christoph's swiotlb cleanups.
