Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C539192E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhEZNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:48:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhEZNs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:48:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622036844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o16u/c8coPI8ohqxToTLSC216Jb3msCYJShNW2jzNPQ=;
        b=gdquVvf4IzJxh5H8A3GORdhnpqKAcutC5Zpz5TttR32N91mc+YSacvzCvzmYNktcwceM/3
        fqKfdU2L4m71Sk/oiCJEhoqUy9lKh+RIvkk0bPhkWnjJDHyBVoghLO1M0ZwnR+d5tAfU6Q
        eN6VlIY7GVFoLJXi4QylIQm0po2p2Kw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 188C4B275;
        Wed, 26 May 2021 13:47:24 +0000 (UTC)
Date:   Wed, 26 May 2021 15:47:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 4/4] slub: Force on no_hash_pointers when slub_debug
 is enabled
Message-ID: <YK5Rayu+nOoI2QZ4@alley>
References: <20210526025625.601023-1-swboyd@chromium.org>
 <20210526025625.601023-5-swboyd@chromium.org>
 <555eaf8b-deb2-fa49-ddef-a74645848159@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555eaf8b-deb2-fa49-ddef-a74645848159@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-05-26 12:48:47, Vlastimil Babka wrote:
> On 5/26/21 4:56 AM, Stephen Boyd wrote:
> > Obscuring the pointers that slub shows when debugging makes for some
> > confusing slub debug messages:
> > 
> >  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> > 
> > I opted for extern because I guess we don't want to advertise
> > no_hash_pointers_enable() in some sort of header file? It can be put in
> > a header file
> 
> Hm looks like the bots disagree. I suppose a declaration right above definition
> in lib/vsprintf.c would silence them, but I'll leave it to printk maintainers if
> they would prefer that way or traditionally
> include/linux/kernel.h

I slightly prefer to put it into kernel.h. I expect that some more
debugging facilities would want to enable this in the future.
But I would accept even the "ugly" declaration in vsprintf.c.

Best Regards,
Petr
