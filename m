Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3D3A71A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFNWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhFNWAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:00:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EA5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:57:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h1so7377595plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f4eWepDXU0v6tcMsUDUBZcPuMz+5jSWaxzQwye2N7ig=;
        b=b4RR656fyY0crjU9zrn3CKrngTiVvuWEmhWr0uooNBimJylo5gUYNHuIPoMwFwrYC6
         I5FZnh8VxVL38fRKk/SDL9/ClIMi0yh5p58EvOfWAPhUn3K8XSSdhiyWE0xrpDral9Yq
         EjP3JYsHwIFb7VT00sFWOvOQJ9wxHfE/hreUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f4eWepDXU0v6tcMsUDUBZcPuMz+5jSWaxzQwye2N7ig=;
        b=ewJNis1ngzFdgx8ygEc7ICYelOnsc6R6MyRRKwE+noS70oQcY2UzRU93l9vy0qHqn4
         owIZQzusIEfQ6Hltf+ZjGlq9YIzuF5Zgme3ZwgSfnZKqwYqtjYzkywpGUwoqthhQV5e0
         2g4BQocHEo0eNxYk+0edmvlnIIzHeaHjicsCgVlKxraYce0tKGLBBr6uRDuiwDoOvkrc
         yUarHyh2QztiUIK5qC46mdWP8mX/cVT6C5cjyB9GaL8StgSiapgV2kyXFJJAPJIAWQur
         Z5dybtQWXo/24ijFyf36bEZIXIYz81LPronZ4MbZoMP4gkjXOK++0/XOupMLXz0o1zFu
         tO3w==
X-Gm-Message-State: AOAM532RK4A5YrrAV5xsKVRU2VUN2TLNvnlPuBxuZZN6+MUqDZm2nENL
        i+h71BmRujmKWCfVf92CYXBexA==
X-Google-Smtp-Source: ABdhPJwdGQHcQttVR153FbRHk1+iC1Ec3NVxFeWvtBgo1yaFLmQyjQrL2KwIDfqhicoyYl7WFq+8kg==
X-Received: by 2002:a17:903:3053:b029:110:d36:af61 with SMTP id u19-20020a1709033053b02901100d36af61mr1111440pla.5.1623707869474;
        Mon, 14 Jun 2021 14:57:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm7342588pfo.106.2021.06.14.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:57:47 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:57:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [RFC PATCH 0/5] pgo: Add PGO support for module profile data
Message-ID: <202106141455.45C7B198D7@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
 <202106140904.484E2337C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106140904.484E2337C@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 06:24:21AM +0300, Jarmo Tiitto wrote:
> [...]
> The patches itself are based on Kees/for-next/clang/features tree
> where I have two of my bug fix patches already in. :-)

BTW, due to the (soon to be addressed) requirements of noinstr[1],
I've removed PGO from my -next tree, and moved it into its own tree in
"for-next/clang/pgo".

-Kees

[1] https://lore.kernel.org/lkml/202106140921.5E591BD@keescook/

-- 
Kees Cook
