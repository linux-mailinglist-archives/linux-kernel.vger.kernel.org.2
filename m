Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0340DECC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhIPP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbhIPP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:58:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C578C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:57:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bb10so4168972plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzYJY52UAh/68nWSTrc1cEM4dT+Du49SY61AqvqxQpU=;
        b=O58e3qgZ8dyXNRM/gKLU7fYRgs3sjT3xnnFIVfnia5H6Zxeq8Ihc+x6ga3e2J3iyYc
         /yXwrr04UadVscFde8d5CBw4piYrq7RCyQbTdlLt3r5zSLpC4XPKi1Uk8yIjlucHfagI
         5mGgFxHLryZnc7BeuYIEL8haNvClygrXclyvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzYJY52UAh/68nWSTrc1cEM4dT+Du49SY61AqvqxQpU=;
        b=j3ylvEr+AP2ZDX+MoqGzjQsJiEoxEjfLavAjzWQuEjuOta5OIy0tsumuE061+Y0OMR
         IuSuPcMbCRQzux30HPoYKAFMXmsCFChOg5OXpxL5OicwAITZeHke91vEeipbcBWWe5J6
         MfcaymDdc5GyzehqCJngCqvnNFEcixqK14AED2k1PM0qkhvn6r3pJnqWcJ3X2W3qSXEC
         lfiup+JrKEO03pqmalloc/FjTbSfpCEJHSfSzgyRZbbqcZRVBntdQ/HiyRlUqRkIWlHO
         a06eUJGaIfGF/LGaVDBqWSKnApQz7aLsWYBUOMrF1v3q1RTKLtFzhISVUK6AlQWXWE0Z
         Yx8g==
X-Gm-Message-State: AOAM533IGrwalpMLhDAPcehR3hYATnYAvKqwSGG9W8bVGFajKAxiL0zT
        VCp7Z5blIG5VoclMuXL4IzfYgw==
X-Google-Smtp-Source: ABdhPJxc4shLxxd4Y4gTNs087vJVz9P+5MpxZOASi22uTcRH3jYHi8noXC19Jr/6FVVVVN+AZ1ZuSg==
X-Received: by 2002:a17:902:c612:b0:13c:9801:a336 with SMTP id r18-20020a170902c61200b0013c9801a336mr5417273plr.27.1631807858140;
        Thu, 16 Sep 2021 08:57:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i8sm3447580pfo.117.2021.09.16.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:57:37 -0700 (PDT)
Date:   Thu, 16 Sep 2021 08:57:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
        andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/vmalloc: Don't allow VM_NO_GUARD on vmap()
Message-ID: <202109160857.8F4AAE1A19@keescook>
References: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:41:56PM +0200, Peter Zijlstra wrote:
> 
> The vmalloc guard pages are added on top of each allocation, thereby
> isolating any two allocations from one another. The top guard of the
> lower allocation is the bottom guard guard of the higher allocation
> etc.
> 
> Therefore VM_NO_GUARD is dangerous; it breaks the basic premise of
> isolating separate allocations.
> 
> There are only two in-tree users of this flag, neither of which use it
> through the exported interface. Ensure it stays this way.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Yes, please. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
