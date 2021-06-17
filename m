Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918B73ABDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFQVTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFQVTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:19:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65019C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:17:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q16so5703249qkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxVL6B5qJT+UBhqScXVRyAzCMrhZfeY881ICRdbMw1k=;
        b=k20rsH5xl0iGlLOeN8H4d0pRykJG8VXHcsrNU82IhlhQAtVYWFjljREZvWybX3GHth
         oELRteG9DNT0gd83Vy8GIxOOBKWt7K2Z0x0+xLqHywXGrW0xqmb0MaQYivnZ6W+AxpJV
         9GmJB2Gf7RmgFO9/Pr9wCviV9WmsO0xt/wG95KyNSFnK8n/jS0au26t2Fz4B3qQ8NXAA
         8A3GkidBbd954UoUR1/IhN+XuGAYjFEuDKGxHWhjPKWvodgCzvosf694jKx9ykSikjuN
         iBl0Ddi2B7MXjb/bjRShZ20TIiDH/z2OT0IWg83aBbZc9TFDZTqMty02qVYLr4FYUlje
         W2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxVL6B5qJT+UBhqScXVRyAzCMrhZfeY881ICRdbMw1k=;
        b=h0t4OupcxC8DCdikoBusfBjQGtTDiKYyan8Ohh3D5IT2UaVuExDyYMI3/qmilJBrCu
         eji3kUqSJqZHtZBbTmsGlq7Cci/qG8n+IHxab7JyPRgR0Woq/hncTxDPPjB+BS9AM4zS
         Jc2sW8rfrfZ9LXymxqx0MwLASi1AOguPLG8SjvU7yYIejJraJ0KQTDbT7TRrexK/y38I
         qD8tLI52fq7kdbqgpCmZX0XRuUdAZEJPZvbLfz/JQ+ZxTRP6tAiMXhiD4CExZ33fd7zZ
         G7wrn4LEMukvCVFw4HW7DHwei/kOQEXVQ1vFrXjbJHoIlYRUw/Ho8y4KRzTPbnj0mztj
         PZjw==
X-Gm-Message-State: AOAM531kgjMZBhMlxB5UmCmBAWKagOZY8qb1D+x3yuCoHuitnhpbbu+Z
        lvJo2NyOqhb74uWiEBMmtws=
X-Google-Smtp-Source: ABdhPJwwvv24IKYudoxiM833HHP7Ad9Zjm5f06J1+usVSzjt/kmB3Ws+SzULKhWVSTGA57+Jw/v3Cw==
X-Received: by 2002:a37:a1cf:: with SMTP id k198mr5129334qke.409.1623964664413;
        Thu, 17 Jun 2021 14:17:44 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id c11sm4024471qth.29.2021.06.17.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:17:44 -0700 (PDT)
Date:   Thu, 17 Jun 2021 14:17:43 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        tiantao6@hisilicon.com, Jonathan.Cameron@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 0/4] use bin_attribute to avoid cpumap buff overflow
Message-ID: <YMu790ZvgzYWrJXV@yury-ThinkPad>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:19:06PM +1200, Barry Song wrote:
> patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
> this function in drivers/base/topology.c, and patch #3 uses this new
> function in drivers/base/node.c.
> patch #4 adds test cases for the new API.

So, the root problem here is that some machines have so many CPUs that
their cpumask text representation may not fit into the full page in the
worst case. Is my understanding correct? Can you share an example of
such configuration?

I think that the proper solution would be to create a function like 
void *cpumap_alloc_pagebuf(bool list), so that cpumap_print_to_pagebuf()
will be always passed with enough portion of memory, and we'll just drop
the PAGE_SIZE limit in cpumap_print_to_pagebuf().

> 
> v4:
> add test cases for bitmap_print_to_buf API;
> add Reviewed-by of Jonathan Cameron for patches 1-3, thanks!
> 
> v3:
> fixed the strlen issue and patch #1,#2,#3 minor formatting issues, thanks
> to Andy Shevchenko and Jonathan Cameron.
> 
> v2:
> split the original patch #1 into two patches and use kasprintf() in
> patch #1 to simplify the code. do some minor formatting adjustments.
> 
> Barry Song (1):
>   lib: test_bitmap: add bitmap_print_to_buf test cases
> 
> Tian Tao (3):
>   lib: bitmap: introduce bitmap_print_to_buf
>   topology: use bin_attribute to avoid buff overflow
>   drivers/base/node.c: use bin_attribute to avoid buff overflow
> 
>  drivers/base/node.c     |  52 +++++++++-----
>  drivers/base/topology.c | 115 +++++++++++++++++--------------
>  include/linux/bitmap.h  |   2 +
>  include/linux/cpumask.h |  21 ++++++
>  lib/bitmap.c            |  37 +++++++++-
>  lib/test_bitmap.c       | 149 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 304 insertions(+), 72 deletions(-)
> 
> -- 
> 2.25.1
