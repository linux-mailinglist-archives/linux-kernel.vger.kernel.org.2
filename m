Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2046035BC17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhDLI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:27:04 -0400
Received: from verein.lst.de ([213.95.11.211]:47566 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237286AbhDLI1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:27:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 62A7B68C65; Mon, 12 Apr 2021 10:26:40 +0200 (CEST)
Date:   Mon, 12 Apr 2021 10:26:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: Re: [PATCH 2/7] xen/gntdev,x86: Remove apply_to_page_range() use
 from module
Message-ID: <20210412082640.GB4372@lst.de>
References: <20210412080012.357146277@infradead.org> <20210412080611.635125063@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.635125063@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00:14AM +0200, Peter Zijlstra wrote:
> Instead of relying on apply_to_page_range() being available to
> modules, move its use into core kernel code and export it's
> application.

This doesn't exactly look great, but at least it contains the damage..

> 
> NOTE: ideally we do: use_ptemod = !auto_translate_physmap &&
> gnttab_map_avail_bits and remove this hack.

Given how much pain the !auto_translate_physmap case causes all over
the kernel I wonder what a realistic timeline might be for dropping
support for this case might be..
