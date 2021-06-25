Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57DC3B3C67
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhFYGBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhFYGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624600741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4K9nQTvedmwdvXMvLbqggOtPVmYLvoAes83xgcBXlc=;
        b=Djd7MDhEejirfUuy1MyUbHNqieP6J9jvB2L3sB1f9NV0dGUMH0MPTRn4S9yw7Wd42eYjCX
        506NrOCI6ESXJn2l2vfPLyUswCkPMzZ81OAUNdQatFqVkv0uIQkVjqOe+4flZYbTlD+v48
        lxZ9YVtQpQ9FgK7FCIeQmCHnuMBYNJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-4_k3vBZENTe9BWuqYS-s2Q-1; Fri, 25 Jun 2021 01:58:56 -0400
X-MC-Unique: 4_k3vBZENTe9BWuqYS-s2Q-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so3735605wmj.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d4K9nQTvedmwdvXMvLbqggOtPVmYLvoAes83xgcBXlc=;
        b=h3NRbu8ciAsCJ3gCFzEsEBlIEp57yQcR0S7KmNixpj4juGgU6vD1dmDjN/WporIUgP
         aOYo2P3615fnDW0M2NF4UXg9k+4bTbYC0L43rSV2zFj4fTsw4cZebtj0FU3YYVF7IRJc
         dX6h6PqLi4cVzKmSPqiH5tO0rVaCzPnq+f+8W7ppq9ynpCAisX9AGjSlEEHln8Huw7wJ
         Xycd3+gT8Qd32Ch5+RIOHXDaSloVyLKajlnqxRVjE0vyTYgroFIJUz3+0c6kW7zjVpKw
         DqVMI4ywl52yvR2advY0AUw/WwxkvCCS+srm3gxesypBlKXEfidDtSK1LIsdtoOCjJXo
         Vx9w==
X-Gm-Message-State: AOAM530G0lr0SEES64a4ihCIs32S620djG9BSJM7+MKx2kzL7YNJGpEC
        I2j45LFw7JKFPDtyM2/WFKPreuQuox3fiH2s+ji+BrhgirbUikiZZ/pEM3gJhRIL1vtdvLXHzdG
        tA1HilZjadKd8zSKdXw8kFkfY
X-Received: by 2002:adf:f689:: with SMTP id v9mr8681112wrp.314.1624600735604;
        Thu, 24 Jun 2021 22:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrE/C9IiJiiBZmtHnh5vRytdM8UZc8yuEPiya4jPaIkUYlRVxGTi7ahSp4MkMavGo37f8Tqw==
X-Received: by 2002:adf:f689:: with SMTP id v9mr8681093wrp.314.1624600735412;
        Thu, 24 Jun 2021 22:58:55 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id w8sm4915282wre.70.2021.06.24.22.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 22:58:54 -0700 (PDT)
Date:   Fri, 25 Jun 2021 01:58:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v5 0/4] mm/page_reporting: Make page reporting work on
 arm64 with 64KB page size
Message-ID: <20210625015826-mutt-send-email-mst@kernel.org>
References: <20210625042150.46964-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625042150.46964-1-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:21:46PM +0800, Gavin Shan wrote:
> The page reporting threshold is currently equal to @pageblock_order, which
> is 13 and 512MB on arm64 with 64KB base page size selected. The page
> reporting won't be triggered if the freeing page can't come up with a free
> area like that huge. The condition is hard to be met, especially when the
> system memory becomes fragmented.
> 
> This series intends to solve the issue by having page reporting threshold
> as 5 (2MB) on arm64 with 64KB base page size. The patches are organized as:
> 
>    PATCH[1/4] Fix some coding style in __page_reporting_request().
>    PATCH[2/4] Represents page reporting order with variable so that it can
>               be exported as module parameter.
>    PATCH[3/4] Allows the device driver (e.g. virtio_balloon) to specify
>               the page reporting order when the device info is registered.
>    PATCH[4/4] Specifies the page reporting order to 5, corresponding to
>               2MB in size on ARM64 when 64KB base page size is used.

I sent comments on v4. They still apply I think. Want me to repeat them
here?

> Changelog
> =========
> v5:
>    * Restore @page_reporting_order to @pageblock_order when
>      device is registered in PATCH[2/4] to keep "git bisect"
>      friendly at least.                                           (Alex)
> v4:
>    * Set @page_reporting_order to MAX_ORDER. Its value is
>      specified by the driver or falls back to @pageblock_order
>      when page reporting device is registered.                    (Alex)
>    * Include "module.h" in page_reporting.c                       (Andrew)
> v3:
>    * Avoid overhead introduced by function all                    (Alex)
>    * Export page reporting order as module parameter              (Gavin)
> v2:
>    * Rewrite the patches as Alex suggested                        (Alex)
> 
> Gavin Shan (4):
>   mm/page_reporting: Fix code style in __page_reporting_request()
>   mm/page_reporting: Export reporting order as module parameter
>   mm/page_reporting: Allow driver to specify reporting
>   virtio_balloon: Specify page reporting order if needed
> 
>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>  drivers/virtio/virtio_balloon.c               | 17 ++++++++++++++
>  include/linux/page_reporting.h                |  3 +++
>  mm/page_reporting.c                           | 22 +++++++++++++++----
>  mm/page_reporting.h                           |  5 ++---
>  5 files changed, 46 insertions(+), 7 deletions(-)
> 
> -- 
> 2.23.0

