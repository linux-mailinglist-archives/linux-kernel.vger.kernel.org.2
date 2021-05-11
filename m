Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1802B37A414
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEKJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:55:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:51794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhEKJze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:55:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBE35ADAA;
        Tue, 11 May 2021 09:54:27 +0000 (UTC)
Date:   Tue, 11 May 2021 11:54:25 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH resend v2 1/5] mm: make variable names for
 populate_vma_page_range() consistent
Message-ID: <YJpUURBQkNd74Ytx@localhost.localdomain>
References: <20210511081534.3507-1-david@redhat.com>
 <20210511081534.3507-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511081534.3507-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:15:30AM +0200, David Hildenbrand wrote:
> Let's make the variable names in the function declaration match the
> variable names used in the definition.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@sude.de>

-- 
Oscar Salvador
SUSE L3
