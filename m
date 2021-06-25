Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819543B3C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhFYFvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhFYFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624600129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfSRy3LBTClFsGu8oNyaqbl4mMdEaxbSEBNPy5g4V3Y=;
        b=RmBSlda6I1m0P/9N5Uo+QULgzV2CcovhPSyDBwTQjGo/GjV1kfE74Op/6UPI7h5+bHEQ3p
        8v4M2574V4071b7EcBL8flQ0dR2cMLny4I22HHVI0pr6GUcD20JEOmjOXMgzZYoagKCLeV
        bj/7/iUM4RJ3/SO1R0FYwLACF5ce4do=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-sGunTVXxNrCVK9Ure6jdcQ-1; Fri, 25 Jun 2021 01:48:47 -0400
X-MC-Unique: sGunTVXxNrCVK9Ure6jdcQ-1
Received: by mail-wr1-f71.google.com with SMTP id c15-20020a056000184fb0290124a352153cso2387543wri.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfSRy3LBTClFsGu8oNyaqbl4mMdEaxbSEBNPy5g4V3Y=;
        b=I444s2d4X/AV0ZFqrHad63pwdw7rUlgKU/dYcWdyYnqqGb9NowztaJsPkvgQPNkmGw
         /BQVc0etLb5V0Nmg6kr6bGZ5xBj961I/eCvlURJb7yfvUaSumdLlkgbmgZfFqCcxlMHx
         lsf0XWLQ7qiTBRrfCjsDhcKY+5sVj1EYFGAWwTlTdl6lnTO95vf5tu9z42dqreNpA+E3
         qSBn/IdlqSCSSCj5Xi5jJcaLfDZjgBzgPVTmLvdNzMeMwBftJyzIvhhCPgIh0b6RFjiG
         chWwKdDwe+EtFnepcV1OcEsXg5ZsMLNO5vOnW9uWDH5P0AJeJpXXYITzgpvcE5PLMuOX
         OSyA==
X-Gm-Message-State: AOAM531lFBxQv9vM6UliTN2PeQb/PkFd3Do8p2dQKJeCHWGbtUvA9N8Z
        x4CRLapa7zyd9GIrcdTZ914hl4zoJDfOBbX5rjsuzr7rxOpnnaimN0QMZUkPaysRBhQqNDVj6gc
        UZXg4Z9IpXdicP2KJTzhe+qYL
X-Received: by 2002:adf:f990:: with SMTP id f16mr8665200wrr.139.1624600126883;
        Thu, 24 Jun 2021 22:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC49i99qglHyKTzRuKfUjTtISrLrKFTj8sdmYEK88RDeBexaogLqWoo/ueooLbzQlf77nM9Q==
X-Received: by 2002:adf:f990:: with SMTP id f16mr8665187wrr.139.1624600126712;
        Thu, 24 Jun 2021 22:48:46 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id s62sm10733370wms.13.2021.06.24.22.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 22:48:46 -0700 (PDT)
Date:   Fri, 25 Jun 2021 01:48:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4 3/4] mm/page_reporting: Allow driver to specify
 reporting order
Message-ID: <20210625014653-mutt-send-email-mst@kernel.org>
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-4-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625014710.42954-4-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:47:09AM +0800, Gavin Shan wrote:
> The page reporting order (threshold) is sticky to @pageblock_order
> by default. The page reporting can never be triggered because the
> freeing page can't come up with a free area like that huge. The
> situation becomes worse when the system memory becomes heavily
> fragmented.
> 
> For example, the following configurations are used on ARM64 when 64KB
> base page size is enabled. In this specific case, the page reporting
> won't be triggered until the freeing page comes up with a 512MB free
> area. That's hard to be met, especially when the system memory becomes
> heavily fragmented.
> 
>    PAGE_SIZE:          64KB
>    HPAGE_SIZE:         512MB
>    pageblock_order:    13       (512MB)
>    MAX_ORDER:          14
> 
> This allows the drivers to specify the page reporting order when the
> page reporting device is registered. It falls back to @pageblock_order
> if it's not specified by the driver. The existing users (hv_balloon
> and virtio_balloon) don't specify it and @pageblock_order is still
> taken as their page reporting order. So this shouldn't introduce any
> functional changes.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  include/linux/page_reporting.h | 3 +++
>  mm/page_reporting.c            | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 3b99e0ec24f2..fe648dfa3a7c 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -18,6 +18,9 @@ struct page_reporting_dev_info {
>  
>  	/* Current state of page reporting */
>  	atomic_t state;
> +
> +	/* Minimal order of page reporting */
> +	unsigned int order;
>  };
>  
>  /* Tear-down and bring-up for page reporting devices */
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 34bf4d26c2c4..382958eef8a9 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -329,6 +329,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  		goto err_out;
>  	}
>  
> +	/*
> +	 * Update the page reporting order if it's specified by driver.
> +	 * Otherwise, it falls back to @pageblock_order.
> +	 */
> +	page_reporting_order = prdev->order ? : pageblock_order;
> +

Hmm. So on ARM achitectures with 64K pages, the command line parameter
is silently ignored?

Isn't this a problem?

>  	/* initialize state and work structures */
>  	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
>  	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
> -- 
> 2.23.0

