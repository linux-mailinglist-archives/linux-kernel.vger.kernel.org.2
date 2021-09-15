Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD740C6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhIONxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:53:24 -0400
Received: from verein.lst.de ([213.95.11.211]:36435 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234453AbhIONxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:53:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0A0867357; Wed, 15 Sep 2021 15:52:01 +0200 (CEST)
Date:   Wed, 15 Sep 2021 15:52:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm] mm/vmalloc: repair warn_alloc()s in
 __vmalloc_area_node()
Message-ID: <20210915135201.GB14571@lst.de>
References: <f4f3187b-9684-e426-565d-827c2a9bbb0e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f3187b-9684-e426-565d-827c2a9bbb0e@virtuozzo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:43:10PM +0300, Vasily Averin wrote:
> Commit f255935b9767 ("mm: cleanup the gfp_mask handling in
> __vmalloc_area_node") added __GFP_NOWARN to gfp_mask unconditionally
> however it disabled all output inside warn_alloc() call.
> This patch saves original gfp_mask and provides it to all warn_alloc() calls.
> 
> Fixes: f255935b9767 ("mm: cleanup the gfp_mask handling in __vmalloc_area_node")
> Cc: Christoph Hellwig <hch@lst.de>
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Looks fine, thanks.

Reviewed-by: Christoph Hellwig <hch@lst.de>
