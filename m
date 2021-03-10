Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9173338E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhCJJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:36:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhCJJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:35:40 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1lJvFj-00086b-0J
        for linux-kernel@vger.kernel.org; Wed, 10 Mar 2021 09:35:39 +0000
Received: by mail-ed1-f71.google.com with SMTP id n20so8129122edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftVdUr9F7AHKavJWsV/WnPi5WDLeKje7PJ4qiKh1hck=;
        b=CPLtW5Sk31Nih1NdEMUhn1bMol7NO+Cmc20gJ44xnPv0WYzFeKuDLegec3V+QH2bbc
         n/LBWl0sjgkiQ0MRiH4n0s4VeWXD0g/5PkNZhwEw3MBXQj+WUF1T3enNMEvOTtQd3jdN
         PAkvJJKr7VdFYNHuukSce4F2z1pgPBXhsbw/A0qI68g+Ey2oY2bkVJl8uPK5SlIj29gc
         xcO3jcOddTlsNwvV9PskJyyJDvNvU9JkJLsoBzdARWeDLsg5EwcMzio0Iv3OmiPKgoh7
         5v9YfPsVjTD6Bou4ePQCy0Z9j7rHaCetoUX5qWPVx+GNfCHDsuVC4f3V6YGzDcCLnU11
         1YiA==
X-Gm-Message-State: AOAM533TyLQ0YrF1EaJhCgDyrWstUuHJztaY4T64oBoHvVsZ8u40PIRR
        9896loUzEEMx76dDve0Muk9rKln/lWgWYZ+DI7bpvyZWtQe0e2HRahdVjzi9p6phe/bqf3TsIRQ
        w7vwC3f/+e+1+Kfqi9PDGn3avU53mn/80+BEVaLwkAQ==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr2231943edt.249.1615368938786;
        Wed, 10 Mar 2021 01:35:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKM4jWVMgAtlSQkiU252tjiKuhRmDMSNYvDzZOnsMhIIvOmtcr+xfyqFDOCgMHfGsUcv8k2Q==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr2231923edt.249.1615368938641;
        Wed, 10 Mar 2021 01:35:38 -0800 (PST)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id dg26sm10364101edb.88.2021.03.10.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:35:38 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:35:37 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
Message-ID: <20210310093537.7azjgcywllkda7lg@gmail.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:41PM +0100, Christoph Hellwig wrote:
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
