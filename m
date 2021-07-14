Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9783C92DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhGNVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhGNVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:16:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CC6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:14:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a2so3826094pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8m1rAnLSqUxpq8o8SiEyqSNSX9K2ZyDZ33nReCUkhE=;
        b=A+oJjT/UZMdqtW2Mj3JxT4tUrD0ct+coV00V/Q8DEX7kNIfOSqNrp8im+FCutSMp/a
         bPBVBZHQznxoOA8ig0tLeRChAMRJdd8favVUXvpTEhDKRdqpzFb7fHIcuW910ogKsB5p
         bglgE2J2Q6+gWhBEItIl4zcK99rjXrh9b4tqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8m1rAnLSqUxpq8o8SiEyqSNSX9K2ZyDZ33nReCUkhE=;
        b=clqI3jj0PsP36Brxp/jbt81suTdgARkLjcFx2oYbbEOgE1tdqqVnRJ7Ge2KzRPic/X
         5BZ+wRzBYkMXuuidpknEUYz74OmTh7tJYC8+QXqO9B5LBzARq7zoeOUn75T8S++DHb7g
         jWd7snmxHzvStFfT7z9T4BS6vxhpqS5CXRov1ST/J/p2vBQHX0R9PetjwU+/l+UWfdRK
         BjMm23ESVY20N6tH8kY41E1qlcL4U+ekdc2fbL7jOBekKD6a/9tYdJQxRaKZoq4ooxk3
         Syy3EKDPxEL4wVhAs3GwbwGwIinGi40skWXZSLiA+gcHo/CMHdmlFCDoLcYnC5n7OBol
         lTWA==
X-Gm-Message-State: AOAM530d050dLIt8wIIbEerBBgaMlqFC+MLan2mK/gBx0iHeSyQypo/Q
        BMoVn8AWx40oZVAcoasrLJpusA==
X-Google-Smtp-Source: ABdhPJxszQxAFtdi+tpp9WU+fLMtnbS+hKc0abtwYZr8cXk43pBte0QbcQNSC2gEpnagmdjDmMJr8g==
X-Received: by 2002:a05:6a00:1713:b029:332:7eca:41a1 with SMTP id h19-20020a056a001713b02903327eca41a1mr228474pfc.26.1626297245937;
        Wed, 14 Jul 2021 14:14:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm3796924pfn.219.2021.07.14.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:14:05 -0700 (PDT)
Date:   Wed, 14 Jul 2021 14:14:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     bowsingbetee <bowsingbetee@protonmail.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: page_alloc: fix page_poison=1 /
 INIT_ON_ALLOC_DEFAULT_ON interaction
Message-ID: <202107141413.78A4ED77@keescook>
References: <20210712005732.4f9bfa78@zn3>
 <20210712215816.1512739-1-slyfox@gentoo.org>
 <202107131953.BB3627156@keescook>
 <Uw6pNgiHmif9MJPCW3QYgIzcFUoL5wATgnqN4rNUrbpzsGtNvEg0CjiUnqu_LVpuf2Zs8uHUQ8Jz6fpdf30VZdAKpSH0we8NN2iNZVY2YVY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Uw6pNgiHmif9MJPCW3QYgIzcFUoL5wATgnqN4rNUrbpzsGtNvEg0CjiUnqu_LVpuf2Zs8uHUQ8Jz6fpdf30VZdAKpSH0we8NN2iNZVY2YVY=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:11:18AM +0000, bowsingbetee wrote:
> B & C variants show this message and A does not, which is what I would expect to happen.
> 
> Tested variants:
> 
> A. "page_poison=1 init_on_free=0 init_on_alloc=0 slub_debug=P"
> B. "page_poison=1 init_on_free=0 init_on_alloc=0 slub_debug=P init_on_free=1"
> C. "page_poison=1 slub_debug=P"
> 
> in common:
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> CONFIG_PAGE_POISONING=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_SLUB=y
> 
> (the slub parts don't matter, ignore them)
> 
> [...]
> 
> While both patches(Sergei's, and yours) work for me, I'll be using this one for now.
> 
> Thank you for your work!
> Cheers!

Awesome; thanks for testing it!

-Kees

-- 
Kees Cook
