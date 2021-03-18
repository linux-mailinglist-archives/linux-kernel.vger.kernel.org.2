Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1744340B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhCRRI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhCRRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:08:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:08:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k24so1855369pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ujDbuCzAN+YLNYYi8/HDfmgkpZHJOtMkPUu0MD84H14=;
        b=BFzQr8bJm/ZNyI6XHmJ4i3xuf4M+X5mAwVbg7D6tWIxiI8ZCIGyucPo90h/LfUox5/
         bABSvLMpq0WKCgE2zsxgnc4y2/ccGXTJBSc6+TzeJkEqurYKBDN9T+76qt7EGpMHk//o
         9PpZQBYHKUj3F6z3PWYRYxCOGAPDww7+p4CRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujDbuCzAN+YLNYYi8/HDfmgkpZHJOtMkPUu0MD84H14=;
        b=r/T7QI7BqDUmhM0ocxCmTXvUotLZZrH/w9o2RvlEqKmFv9N5Bj8iTgNAqdpFsGVEPD
         NEP43+5Zq0NE/zpuYngdcn8vX0VRoRhFFQb9pZKmNMkCG2ch4rXQhQ8sf0p524Ku/9/L
         HItYVjWHz4gtJ6EjDxbqZ3kGyITgmSx7EiCKxy9mI6wDSsMFeBJEsnbyVCZ2VbX5SA9C
         8tiJzYQiPYHBaKeN/f95gztnKPJfLuJ4DZfzDGeiy8gZjFusKlxdXVQ0bdVLqIv4Qt+m
         tuyVf2IMB4urWojUKpQAh5dWkChbYWVtrR2lvPcebGf+D6XfPGGWzvn0qSStLpjQ3+RK
         kpLg==
X-Gm-Message-State: AOAM533m6tmbuSrRkJ035QKthLVgjKspHw1TrtVgEi54r4K7TeD4pU4H
        3MaVt2V5rRRAvbnj344pXbRqnQ==
X-Google-Smtp-Source: ABdhPJycuac0e0voT5If8aAn21pk9Q9lKAxNTmoy4nmVnKUyybmi18zoXEcWvQWsGih0sCZ2JrRVbA==
X-Received: by 2002:a05:6a00:2da:b029:202:7800:567 with SMTP id b26-20020a056a0002dab029020278000567mr4825125pft.71.1616087311096;
        Thu, 18 Mar 2021 10:08:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8sm3004546pfk.138.2021.03.18.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:08:30 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:08:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
Message-ID: <202103181007.BD08B37D00@keescook>
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
 <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
 <6bfebf01-5f52-49bd-380b-04785c474c81@linaro.org>
 <8fd43de6-71e4-cfe7-8208-32753cf1c363@suse.cz>
 <202103172244.D5ADB06A96@keescook>
 <ea740a0a-6225-3d6c-095d-1c456e497e3a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea740a0a-6225-3d6c-095d-1c456e497e3a@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 01:56:05PM +0100, Vlastimil Babka wrote:
> I was going to suggest adding a panic_on_taint parameter... but turns out it was
> already added last year! And various memory corruption detections already use
> TAINT_BAD_PAGE, including SLUB.
> If anything's missing an add_taint() it can be added, and with the parameter you
> should get what you want.

Ah-ha! That works too. I hadn't seen that -- I wonder if I can wire some
other hardening things up to that. (e.g. refactor BUG_ON_CORRUPTION
finally.)

-- 
Kees Cook
