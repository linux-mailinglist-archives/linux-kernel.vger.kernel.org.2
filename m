Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4935BBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhDLINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:13:40 -0400
Received: from verein.lst.de ([213.95.11.211]:47521 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237012AbhDLINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:13:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8089C68C4E; Mon, 12 Apr 2021 10:13:17 +0200 (CEST)
Date:   Mon, 12 Apr 2021 10:13:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: Re: [PATCH 1/7] mm: Unexport apply_to_existing_page_range()
Message-ID: <20210412081317.GA4372@lst.de>
References: <20210412080012.357146277@infradead.org> <20210412080611.568192782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.568192782@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00:13AM +0200, Peter Zijlstra wrote:
> There are no modular in-tree users, remove the EXPORT.
> 
> This is an unsafe function in that it gives direct access to the
> page-tables.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
