Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814CC406570
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhIJBxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJBxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:53:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C9C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:52:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso417239pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53enOyvPBCDzS0FBZJT5PDbXmt24mufFi+BNG988Cws=;
        b=h4WE9VgbvH+xa5W1qOOfVxNRrLYv2Ucz5pfTExc0bT8sFfDFg20rlKOJqP8SNJKI2m
         z2/t3yx/88i8dVRg2mZgm2lT11Ll9aQUcl0CZLo+A9+ebA4EP14bXTqIie4F0McPHIpH
         Ht0+8XyLTU8iYp04HNYNKgYDTbXWKPgaRHvk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53enOyvPBCDzS0FBZJT5PDbXmt24mufFi+BNG988Cws=;
        b=8SUxyLTTC/00BXi5lDc7xeIV5qO7vvlIlbLh11Qs3PBNb9KMAOvdseWRtMUu64h3uh
         yiQGQl2l+yTzWruYOxEVylq4mLk7SDN8DsLKDM/KsQARNrNUeg8bsW/kCrw2DB3ARKnZ
         HIRp8XBScWBaB98STIFCucgpblSLEiCk9ch4T3Lr6bqbRL4UPg6/8X6UtiXJGtqctLQd
         0A/TsHO/nhVOd7AsJbg/fnkXwqwWpwbrOovG5MXRnj5VjUIcIt1pOhpZvGGY3kEEkVXu
         m0QnWdvIh5wJNDGdViUorsxIxBnE4p1WYjfXPC0Qamo1OsXB+gAbz78xpAbNXOd38QFQ
         J+3A==
X-Gm-Message-State: AOAM532FiyP7q8Ix04qrzkQECw0ULk10wuGKuWmmiyBra35QAci2zeXo
        XT3/WZ8FtFAcsjs3Z8b+idvYUg==
X-Google-Smtp-Source: ABdhPJz+8wiQEk9hwxDxKn1qqwRU8WKWNXbfnOpIwPCU1hjPbZuM+76wBPwNAixY7CI1Jf0x5m/LPg==
X-Received: by 2002:a17:90b:1d8d:: with SMTP id pf13mr6689237pjb.197.1631238749457;
        Thu, 09 Sep 2021 18:52:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x75sm3760057pgx.43.2021.09.09.18.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 18:52:28 -0700 (PDT)
Date:   Thu, 9 Sep 2021 18:52:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-ID: <202109091849.53C9A8AD@keescook>
References: <20210909161409.2250920-1-keescook@chromium.org>
 <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
 <202109091549.FF8E0C61E2@keescook>
 <20210909161109.14b147628de07ed7c20d84ae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909161109.14b147628de07ed7c20d84ae@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:11:09PM -0700, Andrew Morton wrote:
> On Thu, 9 Sep 2021 15:51:23 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > > That's an "error", not a warning.  Or is this thanks to the new -Werror?
> > 
> > This is a "regular" error (__bad_copy_to() uses __compiletime_error()).
> > 
> > > Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> > > older kernels will be a common thing down the ages.
> > > 
> > > If it's really an "error" on non-Werror kernels then definitely cc:stable.
> > 
> > I would expect that as only being needed if __alloc_size was backported
> > to -stable, which seems unlikely.
> 
> Ah.  Changelog didn't tell me that it's an __alloc_size thing.

Er, it's in the Subject, but I guess I could repeat it?

> What's the status of the __alloc_size() patchset, btw?

It's in -next via -mm, and all is well as far as I know:

compiler-attributes-add-__alloc_size-for-better-bounds-checking.patch
compiler-attributes-add-__alloc_size-for-better-bounds-checking-fix.patch
checkpatch-add-__alloc_size-to-known-attribute.patch
slab-clean-up-function-declarations.patch
slab-add-__alloc_size-attributes-for-better-bounds-checking.patch
mm-page_alloc-add-__alloc_size-attributes-for-better-bounds-checking.patch
percpu-add-__alloc_size-attributes-for-better-bounds-checking.patch
mm-vmalloc-add-__alloc_size-attributes-for-better-bounds-checking.patch

FWIW, I had extensively checked (and fixed) warnings from it before sending it
your way. This patch is fixing an error that just appeared from
randconfig.

-Kees

-- 
Kees Cook
