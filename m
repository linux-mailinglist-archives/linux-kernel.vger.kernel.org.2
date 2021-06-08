Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6859739FA28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhFHPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhFHPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o58aRI1nAkDOuKYCfrK2Zy/zY+ckaGTYEPwd2qo+nAA=;
        b=WjFyDXW5TzU4f4aG2eTBImx+7uJLrTLZ1TvMRGmw+IPRJjjlBIpvOTqYlqIFiocVD0157/
        DQ6uHmTCDldm7Yh18EON/MLLDeNDe5fuEB7hSxLq5JTRdnQJbSkzg8JNila1Pzi6bX7a26
        4W8qbKK2z5hsqQxCiMw0PdjmOhDVpdo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-bmdB9lGsOoumukZ6lBJCLQ-1; Tue, 08 Jun 2021 11:16:55 -0400
X-MC-Unique: bmdB9lGsOoumukZ6lBJCLQ-1
Received: by mail-qv1-f71.google.com with SMTP id f18-20020a0cbed20000b029021ef79a8921so13480814qvj.17
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o58aRI1nAkDOuKYCfrK2Zy/zY+ckaGTYEPwd2qo+nAA=;
        b=S+jEwk5rBCkPrpwZToAWcIY1Rqoax8xA0vxxbCG0cw9YIUXS4Uyc9QlKs+q0pyVGI2
         cAUxFda/0aJWhcZ5bMZnCM4CEnxpYB85hCQhUNPuu8a8PrIuxUQiO/yWgLsGLCV83SkW
         aqOCIHx3BfihvgDgItdx2UZg675dpOb8KIaICV957pX9LPtDx9pe63kVK79QlVz4oJo7
         RBrzNAiRdpxmbtUkhiJkG/gnNq1ktcgGqmXLQ/mdzmWGgdgC3h5LDy/ZJEg9cutjCzfH
         vUGnQAmnDHEwUYt33bFXTsMIRgRbBI8feflPdsxtl2FxtPhNqrw0FuG2xx4CPdwl79FE
         J2pg==
X-Gm-Message-State: AOAM533ghy47PN/vH6ahN9SbGdGl4B81jXpsp7lBEX4kAlTyFk7VGQ8S
        ARHKn9OfnOTECNC+D8RbJpCxLug75lHIQ77d7tNF2qHcupsILPp6AA5+DQHlWwZ1oSlt69/djXU
        PsE/JjiNB1yKIaxmtM9rgCY0l
X-Received: by 2002:a05:620a:408f:: with SMTP id f15mr21924729qko.398.1623165414858;
        Tue, 08 Jun 2021 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBLlJH23DxgLDX/p84+mzCKOsdataYBzhyEZq9wfQJJoaRz9EMetGKzWGtOqIiIcaJr3BbOg==
X-Received: by 2002:a05:620a:408f:: with SMTP id f15mr21924712qko.398.1623165414615;
        Tue, 08 Jun 2021 08:16:54 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id e20sm121010qtr.55.2021.06.08.08.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:16:53 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:16:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, hughd@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, bskeggs@redhat.com, jgg@nvidia.com,
        shakeelb@google.com, jhubbard@nvidia.com, willy@infradead.org
Subject: Re: [PATCH v10 05/10] mm: Rename migrate_pgmap_owner
Message-ID: <YL+J5NN2yRKjyEeq@t490s>
References: <20210607075855.5084-1-apopple@nvidia.com>
 <20210607075855.5084-6-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210607075855.5084-6-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 05:58:50PM +1000, Alistair Popple wrote:
> MMU notifier ranges have a migrate_pgmap_owner field which is used by
> drivers to store a pointer. This is subsequently used by the driver
> callback to filter MMU_NOTIFY_MIGRATE events. Other notifier event types
> can also benefit from this filtering, so rename the
> 'migrate_pgmap_owner' field to 'owner' and create a new notifier
> initialisation function to initialise this field.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

