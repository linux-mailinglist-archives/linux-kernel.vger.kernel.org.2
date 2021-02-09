Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAB315097
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhBINnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhBINkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:40:15 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD84C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:39:35 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 19so7716694qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q4gBt83LBvEvfgqjMk5XxBqoQUgJu0Updm2eupI2oTY=;
        b=aQhoXa9jPalDWlVkfGxPk+c+I0Q9JZFKo47tCsmclHZEsPNYfreM817gCFAr4kOU8W
         fHBrAIQilQhVmk1iG9w5EWskZgjnukqG4cUDzLNZ6BylHXqnGvwuThK4UN4InIuRH/ze
         cvAS/4B/aBNt8AOe4VR/tiAtWA123wCajp47c9XzIXZFa0/I9e6/nmkjO6l7O80x9iCT
         kP9CrF06fB0beIFQO/9dbuqk7hvLl+4qLhMBYJj+SEwVoqE/HfXTlsjgBKUF7reYwTlf
         Ov9fDvgK+9WKyztUGrdI96zt7nHKT/h6nbpz8LPo9nETq4dWfycOqz7C26v5rJTgWElw
         YGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q4gBt83LBvEvfgqjMk5XxBqoQUgJu0Updm2eupI2oTY=;
        b=HycOYystmsemqZMTh0rIRa0bBvAYZaXwVpswcxuFN7KhomjcLZwSWvkaDULLHnPhJ1
         LtZ7r4GDMw6+Jf2vko/cvubeUIu8H3WC+jci1W52RH4puqGC0jYq8kfEYJFFZjFclX3I
         aWIQg/g2OEul1b9GvdYWZcPeaLUGEEP6w4Y1FmYdvKej/Hg9w7ZEsJle9/MPtZRTrLSX
         kAKtByYAMlaVJr3w6hG8818wa+IXZg/vHtlw5Oy6X27EhXmLZDIpyelDAh5+0cHw9164
         gRfOBfouRNfJiiYtBaHU5rSYASoi0LWD6l2ICI6834w7P1HQnpjuj/6rfyi4b+Tb17FR
         wIgQ==
X-Gm-Message-State: AOAM530ipo348VCKInUO8VzadmEKdO5eaRDwe+u3g8X/8lRAr+g6qmYk
        kfIbJidcqBUd6fEhB2lxwbCPOg==
X-Google-Smtp-Source: ABdhPJzETc8qT6BXd1BDQmX3B26rXpyj1TrCOmYb4Fqo0JHFF6LTk7HRkfK/22tofKGhVc50wAK02g==
X-Received: by 2002:a37:5a45:: with SMTP id o66mr21362019qkb.446.1612877974387;
        Tue, 09 Feb 2021 05:39:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id m21sm17197217qtq.52.2021.02.09.05.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:39:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9TEq-005RKt-Q3; Tue, 09 Feb 2021 09:39:32 -0400
Date:   Tue, 9 Feb 2021 09:39:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH 1/9] mm/migrate.c: Always allow device private pages to
 migrate
Message-ID: <20210209133932.GD4718@ziepe.ca>
References: <20210209010722.13839-1-apopple@nvidia.com>
 <20210209010722.13839-2-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209010722.13839-2-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:07:14PM +1100, Alistair Popple wrote:
> Device private pages are used to represent device memory that is not
> directly accessible from the CPU. Extra references to a device private
> page are only used to ensure the struct page itself remains valid whilst
> waiting for migration entries. Therefore extra references should not
> prevent device private page migration as this can lead to failures to
> migrate pages back to the CPU which are fatal to the user process.

This should identify the extra references in expected_count, just
disabling this protection seems unsafe, ZONE_DEVICE is not so special
that the refcount means nothing

Is this a side effect of the extra refcounts that Ralph was trying to
get rid of? I'd rather see that work finished :)

Jason
