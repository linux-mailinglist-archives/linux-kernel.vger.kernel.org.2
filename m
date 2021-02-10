Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE1316DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhBJSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhBJR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:59:56 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:59:15 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l11so1277880qvt.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEPuatLoyym+J6ItA3BIfCEOLL8sQ3QwAzMr1dNPupk=;
        b=jW9PVjGrRwIiTu0DvrBNx4ykL4I0ErasGCeEaMHeyrXRbfEG9LB3dcE8vE11UBawk6
         1G1tcdRNTWBDtUg+fhfGsQMXOWfqjp3mTLwZKFq4HmTvwSr/K8tGSYW63Zm+KpQxHBXW
         u0ZOrWnXE5JBPOQyNkpBsjDIpzJF/xZBBZ9sBVx4nngGJfwe8dUE8XiCc/Io+j7LyXb3
         qrq9PeYWhfP2y1Eo2XwOk5F4UEKCmphlVy4z7L2moVXVcz43s9cOi+RdntHzTecyr9XT
         0EAPy3emAM7JVX2q3gq8vXafguG5d+qLtIeyiWB7Whu98AaOeG5oA/d4Anm2Sc/eA5pZ
         rwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEPuatLoyym+J6ItA3BIfCEOLL8sQ3QwAzMr1dNPupk=;
        b=euZrmFoFApPI2n2skX2AYuCb2kRM6f/j4GX+ojsaRoviZxlPdwRNxXyqVdfy85FNJ9
         d/MfsRig6raxlAQ7gzNiLxSboF9L+4mxrKX1Z1FVCT0h9aI2u54KS2LvdI5EmVZQFQIx
         /NF2khBasON1krjEFWVu0cvGdssfDuwbpphKoFSONMj56sTI05rvWy7s7A9tY/9Bc33p
         EGge+CLFz1z5Dnnr9t3GgxIOnnxecFe5n4gMcK+1+4juJDJuy+yLXQZdMkROaUpe0qvA
         lg0AvwOrFOm0OL9Oig429uXtNjex6o632B3UCJ+ZHABBWtuu+lJKM6sQPjxlM/ExfmN0
         56cw==
X-Gm-Message-State: AOAM532PEZq8x33GPEOezOcmMGd4bUB6pcxAp7uTJGTU3q8j8fZIJZKq
        qWOlD8vqIRBREqfdKCgfxeEddQ==
X-Google-Smtp-Source: ABdhPJxwZzRaoXxpNKuY9U9fnfERIckZW7aYN7mA/qmqVG4TxZ7Frx9umWXL+42aGA2CymOfvFagoA==
X-Received: by 2002:a0c:ed42:: with SMTP id v2mr3900087qvq.15.1612979954649;
        Wed, 10 Feb 2021 09:59:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p16sm1742656qtq.24.2021.02.10.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:59:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9tlh-006895-Mz; Wed, 10 Feb 2021 13:59:13 -0400
Date:   Wed, 10 Feb 2021 13:59:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-ppc@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 0/9] Add support for SVM atomics in Nouveau
Message-ID: <20210210175913.GO4718@ziepe.ca>
References: <20210209010722.13839-1-apopple@nvidia.com>
 <CAKMK7uGwg2-DTU7Zrco=TSkcR4yTqN1AF0hvVYEAbuj4BUYi5Q@mail.gmail.com>
 <3426910.QXTomnrpqD@nvdebian>
 <CAKMK7uHp+BzHF1=JhKjv5HYm_j0SVqsGdRqjUxVFYx4GSEPucg@mail.gmail.com>
 <57fe0deb-8bf6-d3ee-3545-11109e946528@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fe0deb-8bf6-d3ee-3545-11109e946528@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:53:27PM -0800, John Hubbard wrote:

> This direction sounds at least...possible. Using MMU notifiers instead of pins
> is definitely appealing. I'm not quite clear on the callback idea above, but
> overall it seems like taking advantage of the ZONE_DEVICE tracking of pages
> (without having to put anything additional in each struct page), could work.

It isn't the ZONE_DEVICE page that needs to be tracked.

Really what you want to do here is leave the CPU page in the VMA and
the page tables where it started and deny CPU access to the page. Then
all the proper machinery will continue to work.

IMHO "migration" is the wrong idea if the data isn't actually moving.

Jason
