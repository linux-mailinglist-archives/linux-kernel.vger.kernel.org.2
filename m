Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429EF35D1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245535AbhDLUFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhDLUFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:05:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCEC061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:05:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so9902487pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0X8UQmzynZRI2M2txUleBEJT6AR9mJ+eoj3Z51kuHU=;
        b=nBtlU4Rb7o9zyMaVMcSZGyXsI0l6Ob3HXSHGVpZvkZ3zFgFWq0/NJEElLOMw3Xlpb2
         BjuO1oEuyXqCOp9M/gjo0vbh0WW/7R40IVD8qvTRe1FAnjajizUZ2DY7mTpCNSTbpJRn
         ZXMw+N7p6I+Ytjhg6Wu8mP0bQn2Gm2/02mwlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0X8UQmzynZRI2M2txUleBEJT6AR9mJ+eoj3Z51kuHU=;
        b=DJuWFi3O19xSDLRBUN2zvfNHMmp7Oy6J/q7gxWHMZWY+5dmFDvTQUmzZS2plBUElHP
         XzH/wscuoN0aG1o5riYb7bbygYBxokCdznVHwYC4kLCqEIMdugCTgy4S4DAewYw9vK5R
         imnwl7gW2dTQAMCMa19Fs8Rl/gE2p419yHxupJ6nfJyQKGttxzb2rEAwcbnUSbC7p1q6
         LaqI0k+g2FUyy/DTkQwsx5AD6mzfzBYHbx9CArqXPNcgSoFobLGtIuKi0+kpqES2XaGW
         Oh6jShJT6kukfqdVwzBYwMPNUDeSZjosAl8z7fvLIG6E4zrGa5+5yio7QsTfLRRdN+2Z
         Q2JA==
X-Gm-Message-State: AOAM530bQY4nymJQrvya73Gr0jDkNxVP0wyL19I4SIDFQ/mbrpMNJvvX
        l3HxYV80470hH0ZyN8nWdcpLQw==
X-Google-Smtp-Source: ABdhPJwszblN5Q3JOfsPdSz5uCW7RjGtWmnvwb5YU5xE0BVn8qVibyaZZS0RNX4nGehCNkiv9jdepg==
X-Received: by 2002:a65:4985:: with SMTP id r5mr28411591pgs.65.1618257911612;
        Mon, 12 Apr 2021 13:05:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t23sm244439pju.15.2021.04.12.13.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 13:05:10 -0700 (PDT)
Date:   Mon, 12 Apr 2021 13:05:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <202104121302.57D7EF8@keescook>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.769864829@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> +struct vpr_data {
> +	int (*fn)(pte_t pte, unsigned long addr, void *data);
> +	void *data;
> +};

Eeerg. This is likely to become an attack target itself. Stored function
pointer with stored (3rd) argument.

This doesn't seem needed: only DRM uses it, and that's for error
reporting. I'd rather plumb back errors in a way to not have to add
another place in the kernel where we do func+arg stored calling.

-- 
Kees Cook
