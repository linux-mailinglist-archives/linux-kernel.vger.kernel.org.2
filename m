Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6648438AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJXRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhJXRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:01:48 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4046C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 09:59:27 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t2so8220367qtn.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZzV9v+7pJvz9EKj7cbiV3TsfyLtsPrvdzBHt6l5taGA=;
        b=EYp64EAXnertXUdBpDT9U0CgdT2YctRH80w0R74nJWL9Y/0ekIpX1fV1ZjL8b34I6n
         Zw90bNaEOCH0wE0qW6CiKyPTGgQiy/6a4BhTqvp1DpTvnV+lVTiaqPbMr339UMyRNFis
         tptKPLqBJ5LQ9mnKPOfQGIf8LIU7Sxtrq0hX3L++29pzze4c3YdU9rVrhGV7UOAVao81
         hkmaov6ii8+7oUtO/taKluRnsx+nrZyZbocql4MANz/o9PaRJewC6cMC2sR7VV/8Zwea
         MAyjGm/M+8On28SuVEyzXy7FdXKPtw/oWYIQvHI/5dcobLVY9PbLLAHum0zPWo2Hw0/d
         WlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZzV9v+7pJvz9EKj7cbiV3TsfyLtsPrvdzBHt6l5taGA=;
        b=WxUegPIfaWtaRcKJCFKvZNRJJJPUNtJ9QaodkmUAYDzYfrbUXtD/KkBY79oyVoapBB
         PYnsbE4svS21JRZoSba2pN1ch7we1oBv2HAAmugRsaS58epLkSkWMFFLjHSU91CBTDBk
         AJ8GQ2qeeNJYAGsvJobsqvQwxyg+8rgMtdNPAQ1/E7kBQIiHRxq/wKg2xPv4QDjS97PE
         lL64NCw9bQaR4vpIrXG6JZKj4RN3SBNVDpIyBG5wapybv9uxVsZYRthQbvKEHxUJnWF0
         ksukwJIwUM2zbK+wFTl07gXp7q5bLa18/HcK7g31hP15CJosfgG/dIdkEWzwJ2oYqNYi
         thMg==
X-Gm-Message-State: AOAM532BgMrA4+NRZCW0WA3ywcgWaRmlwP5jJHmqElLvVf7xHM362Kyo
        KeEZ/zHAO4mI3mRwPmtwGDCN6EsMIA==
X-Google-Smtp-Source: ABdhPJzMJaqe0tBgAhV2ds6pekgjv5fUqZLbGH+NyfcBg2Ff0zdCLT+GgODdOvE58VWHym5iZWoQ5A==
X-Received: by 2002:a05:622a:c7:: with SMTP id p7mr12830518qtw.356.1635094764478;
        Sun, 24 Oct 2021 09:59:24 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 12sm7779026qty.9.2021.10.24.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 09:59:23 -0700 (PDT)
Date:   Sun, 24 Oct 2021 12:59:22 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] erofs: get rid of ->lru usage
Message-ID: <YXWQ6p4Hlx6tGpPN@moria.home.lan>
References: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 05:01:20PM +0800, Gao Xiang wrote:
> Currently, ->lru is a way to arrange non-LRU pages and has some
> in-kernel users. In order to minimize noticable issues of page
> reclaim and cache thrashing under high memory presure, limited
> temporary pages were all chained with ->lru and can be reused
> during the request. However, it seems that ->lru could be removed
> when folio is landing.
> 
> Let's use page->private to chain temporary pages for now instead
> and transform EROFS formally after the topic of the folio / file
> page design is finalized.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Would it not be an option to use an array of pointers to pages, instead of a
linked list? Arrays are faster than lists, and page->private is another thing we
prefer not to use if we don't have to.

That said - this is definitely preferable to using page->lru - thank you.

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
