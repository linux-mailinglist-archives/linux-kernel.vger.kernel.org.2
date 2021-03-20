Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499FA3429B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTBqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCTBqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:46:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A46C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:46:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o11so4858240pgs.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uQvJ/OVGn44ohP4ik8L4ZCZvo4WeHXCrQuFyrKsQHDw=;
        b=Xdpq21dUz7V9qN45GVpK0ttINSmgVso50PVIYAq2wxwT4Sa5OMn3CQXxR7sPGQmM4o
         Wx8vUCJ0dMTNHvC4WhJ6CEK7TADg7yZTvmT1fr1Ov8Px0b9S8z05ow8oScmFaVr7Z1xl
         /zYUUxGzie9IMiqFHkPcYHWd75ou415dNwkA3WR5f7/qewRsTExSnHtX0+P36IQdpBQR
         Ap3PgnVNAOGRqe79Khp7Er1fZzdfoz+0vxQJSuoYSn+/haqNNSycTYhA3lISx/RCN/wX
         hplEdwF2KCQNy2Nvm1yqQfcX0FNBrA7frf8FcyRZzQPq1knvkwGVb55MUsAld/RPgCTe
         b0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQvJ/OVGn44ohP4ik8L4ZCZvo4WeHXCrQuFyrKsQHDw=;
        b=rjBM5O0O7bhPSaVBSK7VnBe4gHd2meEdjnfAU4lzObdR1ULBOsNZK9ENGCXGobgbk/
         kOyCHUW9CBMTp0fCsLnorSzD+fyQOAaZCsqxszuz7rajZLh9iFcuacS1IuyzbkxdmYGJ
         TJ2OCQmHquBGyvmKcwCXjnIUNte8Tmjodwk6jJCHzXWKwPDUk0ySHhCKxBQEH/leswgF
         Um3DuocqnWIz/51VG+mDO3hW49p6/SFGVjrpUpkAQ+PIrl9YzGt+0IJkc0BQUtP7gnMy
         97tGbdTqfv19X0yHrbJflyS+C+bGAGg7IxQpU0iuiDYtx0CdT0S2CAHQiMtwpXhIsaJB
         S2cQ==
X-Gm-Message-State: AOAM530S4lpQP95W5TRxe4RBHaTuYzI4NKc1nVnaf6hduUQUz17YE1SG
        cT/pSE//P2TX0CLkTD3a1H5GbwMpMgso3/tT
X-Google-Smtp-Source: ABdhPJy85vWAJ0ffrRU9D1z+8S6L5Y3HLtFgLcOlzwnwwwwu0cw1eYJ/p42aWZAD/9tXd2KW53CR6A==
X-Received: by 2002:a65:6a44:: with SMTP id o4mr13646992pgu.312.1616204774010;
        Fri, 19 Mar 2021 18:46:14 -0700 (PDT)
Received: from localhost ([103.250.185.142])
        by smtp.gmail.com with ESMTPSA id p11sm6305703pjo.48.2021.03.19.18.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 18:46:13 -0700 (PDT)
Date:   Sat, 20 Mar 2021 12:46:06 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 1/6] kasan: allow an architecture to disable inline
 instrumentation
Message-ID: <20210320014606.GB77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319144058.772525-2-dja@axtens.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 01:40:53AM +1100, Daniel Axtens wrote:
> For annoying architectural reasons, it's very difficult to support inline
> instrumentation on powerpc64.

I think we can expand here and talk about how in hash mode, the vmalloc
address space is in a region of memory different than where kernel virtual
addresses are mapped. Did I recollect the reason correctly?

> 
> Add a Kconfig flag to allow an arch to disable inline. (It's a bit
> annoying to be 'backwards', but I'm not aware of any way to have
> an arch force a symbol to be 'n', rather than 'y'.)
> 
> We also disable stack instrumentation in this case as it does things that
> are functionally equivalent to inline instrumentation, namely adding
> code that touches the shadow directly without going through a C helper.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  lib/Kconfig.kasan | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..7e237dbb6df3 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -12,6 +12,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
>  config HAVE_ARCH_KASAN_VMALLOC
>  	bool
>  
> +config ARCH_DISABLE_KASAN_INLINE
> +	def_bool n
> +

Some comments on what arch's want to disable kasan inline would
be helpful and why.

Balbir Singh.
