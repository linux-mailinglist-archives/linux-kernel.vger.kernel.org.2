Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101A3B5E28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhF1MlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhF1MlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:41:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F77C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:38:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d13so25451556ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ys+RScaibz83CdiYBfay2IdZEjpEuB17QTSkYmwaWUw=;
        b=oH+4Cd/L51GezleCLUVkNCwz00KpyQZLsFM8Dl22yq0fIQhWNX5J3Gaz4QWyCCbQeA
         qcyAC4DHJ4/vSwIRQAwct+gFD07lvNc1tOOzcDONALQNDERMomkjayzcfluYfVJba80b
         1hn1f6PLn44tKpjdge/JHmgk4FedVMlGKk408/z6oCgs8bNiWBdJ/t29WbOeY1DWF2G+
         9mWFTW5reZhs+QT16JwZmxGtNIjz+1RSfAd8qygPBcylen7Lj3IHYnZG/qN+xkRNoAr7
         +S5ExmnO2FQRqfrDi1T6/+oGuqIxYIJG5QxVKDHnjRNQy/HwMpCNNZyLXMjB8fHIRu1Z
         jlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ys+RScaibz83CdiYBfay2IdZEjpEuB17QTSkYmwaWUw=;
        b=STCZ467g2NzmUOQOudiFB/amqLJv6h/mWu7LxHNvOW2BTUGSxwlmMmmelFv0nDWlYw
         4J8usItJPvJBEu0MPmIHTg0wseyBKQ9MVHvObb6CTQS0WvPfUudyNaGBIxRllpC6My5m
         IArB1sEvmK/VtO1HGKOp8suELZf6WhJipHgbOMnmQoNBayZ7qUj4Ws4QHCwRAa4KGc/h
         sLEGzYacemgplVaoxRuWd49dOuO82hHc3z22y5nle0nhLW4fzm/zdXR5/86yOxK0pbfu
         hmUXrgwyECn5mrRvytiwehZDPSZuS6HF8L5XE2cNngk7PP6t4UBAsE6Z/qPgMQU0RSI4
         Ov0g==
X-Gm-Message-State: AOAM530W823iMZN3oVecnb113JmZK4j3PyUKpI1X8YU6aAPDFpdHmLNR
        /oLkrrDKGWTlgp3I+3LV4TOSiw==
X-Google-Smtp-Source: ABdhPJw1VYNm/iuQ8ukJtHgbIPL5tc+jj79qOV9v8hvkVcmikl3nLf5EGnU9qwjyyAShj0CTY0m/ww==
X-Received: by 2002:a2e:b1d3:: with SMTP id e19mr3906687lja.362.1624883930421;
        Mon, 28 Jun 2021 05:38:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b15sm1022167lfj.28.2021.06.28.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:38:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1982410280E; Mon, 28 Jun 2021 15:38:49 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:38:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 09/33] mm: Add folio_try_get_rcu()
Message-ID: <20210628123849.4gok3kf43wyjp2ix@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-10-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:40:54PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the equivalent of page_cache_get_speculative().  Also add
> folio_ref_try_add_rcu (the equivalent of page_cache_add_speculative)
> and folio_get_unless_zero() (the equivalent of get_page_unless_zero()).
> 
> The new kernel-doc attempts to explain from the user's point of view
> when to use folio_try_get_rcu() and when to use folio_get_unless_zero(),
> because there seems to be some confusion currently between the users of
> page_cache_get_speculative() and get_page_unless_zero().
> 
> Reimplement page_cache_add_speculative() and page_cache_get_speculative()
> as wrappers around the folio equivalents, but leave get_page_unless_zero()
> alone for now.  This commit reduces text size by 3 bytes due to slightly
> different register allocation & instruction selections.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
