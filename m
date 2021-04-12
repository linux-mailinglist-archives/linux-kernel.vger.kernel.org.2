Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C024A35BC2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhDLI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:29:06 -0400
Received: from verein.lst.de ([213.95.11.211]:47634 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237354AbhDLI3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:29:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F3D068C4E; Mon, 12 Apr 2021 10:28:46 +0200 (CEST)
Date:   Mon, 12 Apr 2021 10:28:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: Re: [PATCH 7/7] mm: Unexport apply_to_page_range()
Message-ID: <20210412082845.GG4372@lst.de>
References: <20210412080012.357146277@infradead.org> <20210412080611.969415860@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.969415860@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
