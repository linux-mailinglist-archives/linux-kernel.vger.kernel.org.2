Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9162B3D9731
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhG1VBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhG1VB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:01:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DFC061798
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:01:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so5933319pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v4TsexyUVtPmnWQp8z0vQybdqGDFJ+IKH3X3D8imsE4=;
        b=hg+gKirQh4CStWcllp3dCMDGaMydMxkrfDz7dI28grfxRHealC37a8xJDfYI0FVrQZ
         2tYUG05gAJbnL7ZSiMGxXN0BbgqYaSHUyURFCYtvwZV0Mx+omFId8CJj1UovnV0ee9cA
         66wsvWC92AbI6ez9cGn13eYUvZ7XhoUJQlPzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4TsexyUVtPmnWQp8z0vQybdqGDFJ+IKH3X3D8imsE4=;
        b=ITAugWmuGOx9LeEMiskhblJMVLtEWWEFyBaFcDrt4DuB8IBpARM9BSAVdWBsQc4/i6
         MjJSL+WGrH7SYH1lrc5yBaBWsUW7Lm8EElfPwHbGp5WkhfM3DqTFQTyy632aboNbzMNc
         uLwZeniosQaAI44T4JyjSdDirOu/mHiLFVemDZyj4AzE/X2Inem08cO8G2IDH5oNmMTV
         UBpLPzdGxZtyKgVUFikdaYkQACiCdv3snxoOSOVPqr6iaRCau18zzfhC9wk6tZUvs3xI
         mzVVD1UMt+4JTkPnKpJ7Vfo2a9hxV0WmMYlnel+8w6t9cZRuNXc6bpvuvt3eQTQBs0XK
         4ZiQ==
X-Gm-Message-State: AOAM530GV1Y9F4YJz8hS7SJDhB86NW4Z8FFb/Qg4huWtPBPwIMYxo710
        69K/X/f2SSvYa8gkOjL5mjKIJA==
X-Google-Smtp-Source: ABdhPJzkF5cilzb73BCpcxICFq3XUeRAJh6fZICuqCaVMVL6bCDUAwLUBtlkfh9/lXbLB+5T11D9+w==
X-Received: by 2002:a17:902:d717:b029:12c:1653:d611 with SMTP id w23-20020a170902d717b029012c1653d611mr1508273ply.51.1627506086388;
        Wed, 28 Jul 2021 14:01:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3sm932392pfd.153.2021.07.28.14.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 14:01:25 -0700 (PDT)
Date:   Wed, 28 Jul 2021 14:01:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 19/64] ip: Use struct_group() for memcpy() regions
Message-ID: <202107281358.8E12638@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-20-keescook@chromium.org>
 <YQDxaYrHu0PeBIuX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQDxaYrHu0PeBIuX@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 07:55:53AM +0200, Greg Kroah-Hartman wrote:
> >  struct ethhdr {
> > -	unsigned char	h_dest[ETH_ALEN];	/* destination eth addr	*/
> > -	unsigned char	h_source[ETH_ALEN];	/* source ether addr	*/
> > +	union {
> > +		struct {
> > +			unsigned char h_dest[ETH_ALEN];	  /* destination eth addr */
> > +			unsigned char h_source[ETH_ALEN]; /* source ether addr	  */
> > +		};
> > +		struct {
> > +			unsigned char h_dest[ETH_ALEN];	  /* destination eth addr */
> > +			unsigned char h_source[ETH_ALEN]; /* source ether addr	  */
> > +		} addrs;
> 
> A union of the same fields in the same structure in the same way?
> 
> Ah, because struct_group() can not be used here?  Still feels odd to see
> in a userspace-visible header.

Yeah, there is some inconsistency here. I will clean this up for v2.

Is there a place we can put kernel-specific macros for use in UAPI
headers? (I need to figure out where things like __kernel_size_t get
defined...)

-- 
Kees Cook
