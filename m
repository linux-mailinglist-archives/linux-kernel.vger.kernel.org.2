Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1A43A564
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhJYVHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhJYVHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:07:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB6AC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:04:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i5so8778526pla.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDl+0lXfWPTqvJCtIEex4xl+4pLrnoKB7rFaWtkUugI=;
        b=IBm87Inmj1ppZK8MoWS3WHbM3mnFj6HnfzmU9Jz3Q0nBXLysCvRjnllsGt5YL89GH1
         XSIUdYHMnVUCQU2aLRKOXKJyOglyg7OslW4fYfKHRGO5PZAElCHLknLXKyP8L2Q6ombV
         8aL+OnBwOe+elYKUKx2bwBtLyvJOOl5cG+45U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDl+0lXfWPTqvJCtIEex4xl+4pLrnoKB7rFaWtkUugI=;
        b=RTN1NGhHnEbLq1QCua8sOtveXi8X+tyuaudO1hcDWFey5AtgQ2yA+OUI7+CbRGeVe2
         klXy7XcH0VTDzGQh0K1vERc+xcvB9LQZDh5wETjKIt2wMgiKIw+MtJWphCUlrKkbCSqL
         yoP9bCdHysJS6UBrWWjTyYphO0eiic3ta2fYNbwBsf1Ny5abHXn+Vi6T0zooiWHv1fqq
         wNokqnp4oc4tSb3DbLAe2b08doeQ2s0qer8/feBnFdU2RAfyYUenAgF25Of8D2bJBoE4
         IZd4x5Us2TK2IVi4bCW08kso9xWFFfIMK6c+urRJZYKS1OiTd/FTWB4A3CLKlPvMn6Lx
         Omhw==
X-Gm-Message-State: AOAM532IQyeY6yQViJkvF5w5hT5/m87Pc3X9D+qDzdGsjEQfGhe9CxhK
        jZyOmm/okNSTmB80vcAx8o9DkcV6vNvOLA==
X-Google-Smtp-Source: ABdhPJwBtqoDP78rvQu08GbpajM4wjQnhb/rT2OKnoJlMUJYv9SxNpicod/64UHypFDiBP7VcAFYdQ==
X-Received: by 2002:a17:90b:1a85:: with SMTP id ng5mr34461566pjb.43.1635195888757;
        Mon, 25 Oct 2021 14:04:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d21sm21496409pfl.135.2021.10.25.14.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:04:48 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:04:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Message-ID: <202110251402.ADFA4D41BF@keescook>
References: <20211025181634.3889666-1-willy@infradead.org>
 <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXcKzKVX7NTAtvPh@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:51:40PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 25, 2021 at 12:29:46PM -0700, Kees Cook wrote:
> > On Mon, Oct 25, 2021 at 07:16:34PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Commit 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
> > > attempted to fix the problem of secretmem_users wrapping to zero and
> > > allowing suspend once again.  Prevent secretmem_users from wrapping to
> > > zero by forbidding new users if the number of users has wrapped from
> > > positive to negative.  This stops a long way short of reaching the
> > > necessary 4 billion users, so there's no need to be clever with special
> > > anti-wrap types or checking the return value from atomic_inc().
> > 
> > I still prefer refcount_t here because it provides deterministic
> > saturation, but the risk right now is so narrow ("don't hibernate"),
> > I'm not going to fight for it. I think it'd be fine to use it initialized
> > to 1, and have the removal check for == 0 as a failure state, which would
> > deterministically cover the underflow case too.
> 
> I still think that's abusing the refcount_t pattern.  refcount_t should
> be for ... reference counts.  Not these other things.

Is secretmem different? We're trying to count how many of these we have,
this is a common pattern in, for example, the network code which does
this kind of thing a lot.

It's just that for a "global" counter like here, we're not tied to a
specific object's lifetime, but usually some global state that depends
on having _any_ of the objects alive.

-- 
Kees Cook
