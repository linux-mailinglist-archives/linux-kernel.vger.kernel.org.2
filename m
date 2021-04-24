Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E99369DA8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhDXAK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhDXAKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:10:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88636C061574;
        Fri, 23 Apr 2021 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u8QVk0MzHlPN2Imc4naq07Rn98zlkk555SrSXp+LlQo=; b=euIM5eWlSVe/GGgxch3BXGtDm+
        TEsS00kuXxc0hGQUqffHbpQE8L6OPJhFmGfzjSt9IXsGqL4nPuC6VYJaOBVozUPFzQnRpqlftoXuX
        8RiqCuiFLs0jW63HoIfSzx6jzcfULhtyrapx3Au4uQIVCJYIMVrorrd4Myby7ieagabTOtFIi/hXF
        rCzBYe3KNU5ycDifR7W5ViOePZUWyOXBPmXRQTfVEG/KGlBFVHpsJ13ED49JF3X2yVT0vYVh6dgUI
        xqdx7olRMjB4l4nTt/H2UFjsIOkamaIAUI8naAxYqfgSdsZbHT63NoQbSDO6UaDbi+dCyvMeYpxK1
        6MAzQ4SA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1la5qU-002XGV-LO; Sat, 24 Apr 2021 00:08:59 +0000
Date:   Sat, 24 Apr 2021 01:08:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/mmzone.h: fix existing kernel-doc comments and
 link them to core-api
Message-ID: <20210424000826.GF235567@casper.infradead.org>
References: <20210423203811.1247508-1-rppt@kernel.org>
 <20210423203811.1247508-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423203811.1247508-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:38:10PM +0300, Mike Rapoport wrote:
> +++ b/Documentation/core-api/mm-api.rst
> @@ -92,3 +92,5 @@ More Memory Management Functions
>     :export:
>  
>  .. kernel-doc:: mm/page_alloc.c
> +
> +.. kernel-doc:: include/linux/mmzone.h

You didn't do this against linux-next ... I added a few other files this
cycle:

.. kernel-doc:: mm/page_alloc.c
.. kernel-doc:: mm/mempolicy.c
.. kernel-doc:: include/linux/mm_types.h
   :internal:
.. kernel-doc:: include/linux/mm.h
   :internal:

The content looks good.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
