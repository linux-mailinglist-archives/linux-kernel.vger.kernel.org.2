Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7139A3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhFCOtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbhFCOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622731669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggwAzDwYsJe761/h5KeyH0+JH3HJIdjU1YmA0yiaMkI=;
        b=UyP158C8QCG86KQwa+pUIW2sWa9RMdtiL/sH+l5C8T89F9myw2wb/mPCFgU30jgTbJ3rFd
        KiVhEfT2/XPfDf4pd+PQKDie3BU/wnhs8IrcmCVyNObb5o5sNC0W96c8nhpbesloH+xzsD
        nKK4MIjM8SjIeVRWyVBbEusDCLvniJQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-5KocJOyYM3Grv9NUmxJi6g-1; Thu, 03 Jun 2021 10:47:44 -0400
X-MC-Unique: 5KocJOyYM3Grv9NUmxJi6g-1
Received: by mail-qv1-f71.google.com with SMTP id s16-20020a0cdc100000b02902177eec9426so4594150qvk.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggwAzDwYsJe761/h5KeyH0+JH3HJIdjU1YmA0yiaMkI=;
        b=mvrgQ+gNo4iFs08RhuvPL8edCGKjqFEQAgbSu6v6W9YhMkIAmfsa4vnkeOE4sUyZOL
         FGMSm5iro4QP0jb8a2d+fYVax/XmdYJ7JfeQ7rCULqzSEvcZ6QwgVX+nLLqPEa59RrJ/
         ttND9e8T4w51QgN9Yd83PmKKFRobv6UhHzkvk+5UwMBh0EM30q2Tz4nLbwB3UMiMhPDm
         3nuBTAXrMC0RXRt0AfYke5pDR41mGsDyjKu236+aRvPMka8CF2zy0qKpJ1qIIa/2NTM+
         txbjGtsU5WGUIQcf4qlfvBnOAvb4t0xvB2g0ZXRw4l1xcngRQIiabbL/gnZpGhccPrso
         TlSA==
X-Gm-Message-State: AOAM5323Cj/JDIpOYIh94Ycim//kx7CKfMP9rkKpneP7Ewvftv3/BB7N
        0sGfBfvQgH2h8D8ii+ll4wxenWRI5P6cKCc6kPd/AlibV/AKtjKVRgQkBrQX0Dr3hJEDyXjxmzD
        63T8ihN3h6Ll1cfM6EJ0w/fae
X-Received: by 2002:a37:ae81:: with SMTP id x123mr31891336qke.251.1622731662879;
        Thu, 03 Jun 2021 07:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8G2sTC80gzexHAH3BN9zjekxO4BROz6GuR6h2LK/qUHy5QdzjC03iGstjtnqP8uH7ytX0pw==
X-Received: by 2002:a37:ae81:: with SMTP id x123mr31891297qke.251.1622731662359;
        Thu, 03 Jun 2021 07:47:42 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id j28sm2041208qkl.35.2021.06.03.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:47:41 -0700 (PDT)
Date:   Thu, 3 Jun 2021 10:47:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, jglisse@redhat.com, willy@infradead.org,
        jgg@nvidia.com, hughd@google.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 07/10] mm: Device exclusive memory access
Message-ID: <YLjrjJXMP9Y3bvej@t490s>
References: <20210524132725.12697-1-apopple@nvidia.com>
 <YLdGXSw0zdiovn4i@balbir-desktop>
 <YLeXqp/U0DgylI/u@t490s>
 <3853054.AI2YdRgKcH@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3853054.AI2YdRgKcH@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:39:32PM +1000, Alistair Popple wrote:
> Reclaim won't run on the page due to the extra references from the special 
> swap entries.

That sounds reasonable, but I didn't find the point that stops it, probably due
to my limited knowledge on the reclaim code.  Could you elaborate?

-- 
Peter Xu

