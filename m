Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECB33935D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhCLQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:27:44 -0500
Received: from verein.lst.de ([213.95.11.211]:46215 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhCLQ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:27:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01C1168B02; Fri, 12 Mar 2021 17:27:18 +0100 (CET)
Date:   Fri, 12 Mar 2021 17:27:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] devtmpfs: actually reclaim some init memory
Message-ID: <20210312162718.GC11243@lst.de>
References: <20210312103027.2701413-1-linux@rasmusvillemoes.dk> <20210312103027.2701413-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312103027.2701413-2-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:30:27AM +0100, Rasmus Villemoes wrote:
> Currently gcc seems to inline devtmpfs_setup() into devtmpfsd(), so
> its memory footprint isn't reclaimed as intended. Mark it noinline to
> make sure it gets put in .init.text.
> 
> While here, setup_done can also be put in .init.data: After complete()
> releases the internal spinlock, the completion object is never touched
> again by that thread, and the waiting thread doesn't proceed until it
> observes ->done while holding that spinlock.
> 
> This is now the same pattern as for kthreadd_done in init/main.c:
> complete() is done in a __ref function, while the corresponding
> wait_for_completion() is in an __init function.

I'm not sure if this matters in any way, but it does look fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
