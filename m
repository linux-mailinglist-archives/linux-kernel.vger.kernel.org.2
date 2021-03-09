Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690B1332F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCITe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhCITeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615318439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avJtp16vLH3ysAvGNZjvdMJS5OXrs5RoA1exdXYwigY=;
        b=aJfP9A7qSpfZBJ+KzVjqad1r8IDRuW51uZ58bCQYtjO9xP85SMiex/Uaw9HDbxANowe2N7
        TYtyRu/JUgQlEFWthsDlwxkRTzNWLTl4hvw3872BaOWI3iy7B05JoTnN+0eeV29BdSbyN3
        RR7hTc+JecdrypoDd7rBB8RLv19IoF0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-UbN9ayq4N4u7P8CQ4z5QqA-1; Tue, 09 Mar 2021 14:33:57 -0500
X-MC-Unique: UbN9ayq4N4u7P8CQ4z5QqA-1
Received: by mail-pg1-f200.google.com with SMTP id t11so8242516pgr.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=avJtp16vLH3ysAvGNZjvdMJS5OXrs5RoA1exdXYwigY=;
        b=NeDsSZOnNFUiSYJ6LJ+AsHnAbR5xQOtJkZ+xkFMXQ3BWh1IcGU98amEOHBrlSC678M
         9Pw6pPboSNcUC5SiH6jZsPUkKyreJ1nVBKssRt/wXVT5KcmZhetlp4fBZxbKHLgZ79KQ
         2L7H0zfAxu1YrzbmCzLvvr5elPWa4DtucBcFG6NF5DMJTM/qcXWA23CkiGvOeoIHbToS
         PeNsZZomTL0qiYjevKRuXwqnSZ/u69C7sGczdSAeqWgIaPPBs4o3JOjp5IPjNELs1OHM
         8UxJBkxk4bs/aOh75PzZ1ysUYXlEc7MG3Jaxx7aqjkQxjSWZc9pNTEDM7fBKDfF1ZXkY
         FpWw==
X-Gm-Message-State: AOAM533WeWbEDSwNLmuC5oUuGnQs1dME4EuxGRbxopmO902s1XwjarTI
        WrB6N/pS7mxwyUTAkKkaP2vieNUYJYXbOrqnUFtvZ6ES23W5UXW3D97kr5m1ucWLdTx9OHQRqOJ
        ZvvjkXT6W8sj1LtVuRg8NP92k
X-Received: by 2002:a17:90a:d0c4:: with SMTP id y4mr6388464pjw.233.1615318436755;
        Tue, 09 Mar 2021 11:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRoheltWC3q/OlHwNvgRQikUup4a/cbSjffjIeSZP5QkLBGPEM1MUby0bF5Es4MSGuUmH/sg==
X-Received: by 2002:a17:90a:d0c4:: with SMTP id y4mr6388446pjw.233.1615318436540;
        Tue, 09 Mar 2021 11:33:56 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z3sm13835115pff.40.2021.03.09.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:33:56 -0800 (PST)
Date:   Wed, 10 Mar 2021 03:33:42 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
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
Subject: Re: [PATCH 1/9] fs: rename alloc_anon_inode to alloc_anon_inode_sb
Message-ID: <20210309193342.GA3958006@xiangao.remote.csb>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:40PM +0100, Christoph Hellwig wrote:
> Rename alloc_inode to free the name for a new variant that does not
> need boilerplate to create a super_block first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

That is a nice idea as well to avoid sb by introducing an unique
fs...

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

