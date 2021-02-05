Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924443101DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhBEAwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232083AbhBEAwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612486237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6v5TiNmyjzkurZGYafla6AYhWRmxphUxOH88crjqEbY=;
        b=faEwXMmDnftVKYUGRqmu2JIOyZm1LBJt4Ht3D/zThI0QW8u/Hq5JXipB00xbi/TfJnyQdH
        z+27oxfDA6/TX3n+SydzhsqSe5FXpkp2y2dvQLt8968jlTUxOhNCIBPVJMsFc8oRYHyMf0
        QueZhkYPNgA0TqJQQ90lXdOzFWjHi50=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505--qa1zNs5NEerTiJXDWKFbA-1; Thu, 04 Feb 2021 19:50:35 -0500
X-MC-Unique: -qa1zNs5NEerTiJXDWKFbA-1
Received: by mail-qv1-f69.google.com with SMTP id dh16so3633211qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6v5TiNmyjzkurZGYafla6AYhWRmxphUxOH88crjqEbY=;
        b=sCVDVAbvF84aEEvJR0PPTf638RUCH6T09IWTbsZNXV/v+MlCOoiwjxjQX+aHPEzQF/
         1e+by2dP0+45hzv+VZcRs2vx2663xK1gsgDzp81LgZX/HPkFvt7MDxh8Eq5/MSHrsBEI
         SFmnAJfh0p/JZbSbu9J/BwvahrImjgPieIv45r+1VoiSvDv8RXFtcc/Lo7TKYZXqTYoj
         wYYmry4tPDebcn/IPtC0DA+L29yqehmU3ke1yp++TFiAb9vWTVEjacByRS0nxeXWA21j
         JsyCkeD6gvVYVr+TOsWEEKWN9qj3Lz6kmz8D9RikxK+skCNO7uq1iagZQejqqdSe3qfB
         dh+Q==
X-Gm-Message-State: AOAM531e/m7qNCdsopAaOVEhW+kuvJkUMI3FLuOOWPojBj/5Y/XCJMHs
        C1XAmtNBZan2z1r6LLSv5acZDVN0XYCjTxcz5uu7fLOkCuPObcoQka2hwdiMrHRcmoeQO8TrXlx
        5gRwvitPTZT0yz4eKrK/LJ0mZ
X-Received: by 2002:a05:6214:324:: with SMTP id j4mr2144902qvu.53.1612486235406;
        Thu, 04 Feb 2021 16:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7qrh6iNID1eoLV0V7+VhGQH6n5gRYEh7QKZNVn5dKdj3gSmdetD8tJAow+8oPOZf30i7ang==
X-Received: by 2002:a05:6214:324:: with SMTP id j4mr2144874qvu.53.1612486235137;
        Thu, 04 Feb 2021 16:50:35 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id l35sm6070844qtd.90.2021.02.04.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:50:34 -0800 (PST)
Date:   Thu, 4 Feb 2021 19:50:32 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/4] mm: Introduce page_needs_cow_for_dma() for
 deciding whether cow
Message-ID: <20210205005032.GV6468@xz-x1>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-4-peterx@redhat.com>
 <20210204232000.GG4718@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204232000.GG4718@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 07:20:00PM -0400, Jason Gunthorpe wrote:
> > +static inline bool is_cow_mapping(vm_flags_t flags)
> > +{
> 
> It feels a bit more logical to pass in a struct vm_area_struct *' here?

Agree, but only if I'm adding this as a new function.  Though it's a code
movement from internal.h to mm.h, so I avoided touching all the users of this
function that existed.

Thanks,

-- 
Peter Xu

