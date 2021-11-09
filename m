Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD244A80C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbhKIICq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:02:46 -0500
Received: from verein.lst.de ([213.95.11.211]:48931 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241451AbhKIICp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:02:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D03968AA6; Tue,  9 Nov 2021 08:59:57 +0100 (CET)
Date:   Tue, 9 Nov 2021 08:59:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: refactor the i915 GVT support and move to the modern mdev API
 v2
Message-ID: <20211109075957.GC27339@lst.de>
References: <20211102070601.155501-1-hch@lst.de> <163603075885.4807.880888219859400958@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163603075885.4807.880888219859400958@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:59:18PM +0200, Joonas Lahtinen wrote:
> The minimal we should do is to eliminate the double underscore
> prefixed functions. But I would prefer to have the symbol exports by
> default so that we can enable the functionality just by loading the
> module.

I'm fine with exporting by default, but just loading won't really work
even with that:

 - there are a bunch of IS_ENABLED conditionals in the i915 (although
   they look like minor optimizations to me).
 - the enable_gvt needs to be set, although after this refactor this
   option is completely pointless and should probably be enabled
 - the enable_guc option needs to be disable for gvt to work.
