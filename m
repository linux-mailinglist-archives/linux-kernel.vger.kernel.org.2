Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10235BC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhDLI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:28:26 -0400
Received: from verein.lst.de ([213.95.11.211]:47587 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237284AbhDLI2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:28:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 856F868C4E; Mon, 12 Apr 2021 10:28:05 +0200 (CEST)
Date:   Mon, 12 Apr 2021 10:28:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <20210412082805.GD4372@lst.de>
References: <20210412080012.357146277@infradead.org> <20210412080611.769864829@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.769864829@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> +extern int verify_page_range(struct mm_struct *mm,

No need for the extern here.

> +int verify_page_range(struct mm_struct *mm,
> +		      unsigned long addr, unsigned long size,
> +		      int (*fn)(pte_t pte, unsigned long addr, void *data),
> +		      void *data)

A kerneldoc comment would be nice for this function.

Otherwise this looks fine.
