Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F235BC19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhDLI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:27:42 -0400
Received: from verein.lst.de ([213.95.11.211]:47579 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237281AbhDLI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:27:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B930E68C4E; Mon, 12 Apr 2021 10:27:21 +0200 (CEST)
Date:   Mon, 12 Apr 2021 10:27:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: Re: [PATCH 3/7] xen/gntdev: Remove apply_to_page_range() use from
 module
Message-ID: <20210412082721.GC4372@lst.de>
References: <20210412080012.357146277@infradead.org> <20210412080611.702979288@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.702979288@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00:15AM +0200, Peter Zijlstra wrote:
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -1591,6 +1591,43 @@ int gnttab_init(void)
>  }
>  EXPORT_SYMBOL_GPL(gnttab_init);
>  
> +#include <xen/gntdev.h>
> +#include "gntdev-common.h"

Can't we keep the includes at the top of the file?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
