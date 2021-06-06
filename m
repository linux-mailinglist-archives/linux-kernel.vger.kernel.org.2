Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74F39CBDA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFFAcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFAca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:32:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DEBC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:30:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j12so10943357pgh.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 17:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VDXTVjj0+nDYDx9MzuRgoWOTGmLXmo7MLzx3SNS5KE=;
        b=aF4K2RxbGJ0PQBQ7D3cYri2KfdGuuo5AdXRx8xAhRX4yF2qckKVdHSiXbRLjJUhBNt
         6Att/2kYuIt/fywVjHIL1rt1CG6AOKwaOC9p66n8Rb8dRAqp3ViFB9JhrEFf+FMB3YUN
         gWN5ixiTZQl3lqZz1E3iceKF0lq8eID6gweu7jj7+yyIQeppa5DHP87FwCMwa8r3rfDG
         HqONyrgApjzC9o6bNDVSXdEJVdXxS28TpawC7OiXRJ4+vJKpvnBIBFsIE+O9KvxcsQTF
         S3CbQ7UOzjxzAd2cYl9NXEenXB3xlv4kdt/20CUARiJ/j0/XddQzOgIA/XGKc9tI17tR
         FTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VDXTVjj0+nDYDx9MzuRgoWOTGmLXmo7MLzx3SNS5KE=;
        b=PBcA3+RwHhEWFxU3mi8gfJf0OfzCn+JxCYTY+7FD8M3KDkTIZUjC5R3MGlOP++y3IT
         hKMh0PJkiv4+uSd498Hf8Wu4s+5gon7yb6hJYOwoE2EdaOZi3VzC1hqwb3beVCRTuZdq
         HgeUkuIBqY1nIEPBqLImjoMTLmMo3q7vaKlxQDfYr1gOz4l7DxiGiKAbqVNlKvPvMhwp
         iEd1LV6sLpXoG5rxgXw5YDtUL1+wkObE9G17w2YR2A6EEq64Z7XDqzkSxl0K6IS08uYL
         vdj43NxzAfv71vxWQykoA8Bnj4r3/Z3c7cZ5cWAz63RO6Z4wYd7R7ucNNZG9QJtPSH/Q
         Uu3Q==
X-Gm-Message-State: AOAM532D7FBlcRzCXXnrQfLZykuo7Lf+mXwnWfRcWQwnH1oDIzHfledZ
        Y9DL4ncxQ7kjkXbuDzOvY0MbTc3lIZENuG0GlyLxOw==
X-Google-Smtp-Source: ABdhPJzfiCeY9tqkKmkSLOuJ3+obh7ppS3Yk4qcjz4CnNdglKlz/qX//z+ULFPvbFtaPxMN7nenRtAVDZzVBLsNhccI=
X-Received: by 2002:a63:4653:: with SMTP id v19mr11479580pgk.240.1622939441444;
 Sat, 05 Jun 2021 17:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210528004922.3980613-4-ira.weiny@intel.com> <20210604005036.4187184-1-ira.weiny@intel.com>
In-Reply-To: <20210604005036.4187184-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Jun 2021 17:30:30 -0700
Message-ID: <CAPcyv4jrdGAtaoArXEQAH5XPrGQxCraiMD54UR_HfHmu3Z1iYw@mail.gmail.com>
Subject: Re: [PATCH V3.1] cxl/mem: Map registers based on capabilities
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 5:51 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The information required to map registers based on capabilities is
> contained within the bars themselves.  This means the bar must be mapped
> to read the information needed and then unmapped to map the individual
> parts of the BAR based on capabilities.
>
> Change cxl_setup_device_regs() to return a new cxl_register_map, change
> the name to cxl_probe_device_regs().  Allocate and place
> cxl_register_maps on a list while processing all of the specified
> register blocks.
>
> After probing all the register blocks go back and map smaller registers
> blocks based on their capabilities and dispose of the cxl_register_maps.
>
> NOTE: pci_iomap() is not managed automatically via pcim_enable_device()
> so be careful to call pci_iounmap() correctly.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Link: https://lore.kernel.org/r/20210528004922.3980613-4-ira.weiny@intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> ---
> Changes for V3.1
>         Fix 0-day
>
> >> drivers/cxl/core.c:40:17: warning: variable 'register_block' set but not used [-Wunused-but-set-variable]
>       40 |   void __iomem *register_block;

Just a note for next time if you want to be friendly to "b4 am" using
maintainers. Roll the version and include the patch number in the
resend, i.e.: in this case: "[PATCH v4 3/5] cxl/mem: Map registers
based on capabilities". I was able to manually create a bundle in the
proper order on patchwork for the two "3.1" updates.
