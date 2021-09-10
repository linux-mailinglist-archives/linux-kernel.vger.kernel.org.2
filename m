Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449A5406739
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhIJGad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhIJGaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:30:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F98C061756
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 23:29:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v123so988049pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 23:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SqoyNLPV12UI+aH0KY3hvzjuZwQ2VZlAP4igBb/D7xg=;
        b=aB535l98SeNAaY1Uh99F7nuRtdDDNPyqFS0oRlPK59Shl5turlqFkRRF2pIc7Se6Kk
         JXCs1tGQtTIYyP5AYMNY7sf1sUAKiJeDBQPXbD2wxT7ivIM8staCntTB+GC1LIbFllPa
         YVnLB4Qr5a+15SBQs1uksXr+Q9A64TPOLXCl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SqoyNLPV12UI+aH0KY3hvzjuZwQ2VZlAP4igBb/D7xg=;
        b=6O9NM1sm60c02MidBCRNwBJ2gAY8Yu+zg8MoaLYFjKNwQ1liE2nqm0EWv8cZ/hq7Vy
         nlK4+Ste1AW9Nj6+IxS25Z2S9UKN5s+Fi1jRjzVb9iaqphabPzVAs/kGgypOglK3/22i
         e7iEbZgWBp1rZzcPqsciyYZH5JbPNahkFxyXsWyml7F+f6aG5+324KHFMqUZqXbSm1gU
         I9R1+7xy++PulUzh3Eld7HU67XYFak4CgkwY0W7M9mgnaym/bI+jwIgz8UxyKvbpjL0K
         mmZ/Nxv6U/quZrjAjZ8qviXW53IVdxjB/vyrAQHgi9AUIaQim36ikzIICO3Ctk3PB/RM
         2vkg==
X-Gm-Message-State: AOAM5330kI72JXLnsvabDE4tWXvH4Cgy7tDBC8loA2qPts8SMsyFXfes
        zC/zjVlKP1Cnnb+z0ltFzmY8zQ==
X-Google-Smtp-Source: ABdhPJz4r+H2RdiVoqM5I7lfYVhiC53JkDnmzl8bnZp3A/ckLw3UuC3EUho9rSj/GkL+QQ5jkOeVFQ==
X-Received: by 2002:a63:5c51:: with SMTP id n17mr5975475pgm.376.1631255360120;
        Thu, 09 Sep 2021 23:29:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a11sm4064214pgj.75.2021.09.09.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 23:29:19 -0700 (PDT)
Date:   Thu, 9 Sep 2021 23:29:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-ID: <202109092327.C582B074C@keescook>
References: <20210909161409.2250920-1-keescook@chromium.org>
 <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
 <202109091549.FF8E0C61E2@keescook>
 <20210909161109.14b147628de07ed7c20d84ae@linux-foundation.org>
 <202109091849.53C9A8AD@keescook>
 <20210910045010.GO1935@kadam>
 <20210909224814.7460f8dfa3134742b90b34eb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909224814.7460f8dfa3134742b90b34eb@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:48:14PM -0700, Andrew Morton wrote:
> On Fri, 10 Sep 2021 07:50:10 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > This is how the email looks like to Andrew.
> > 
> > https://sylpheed.sraoss.jp/images/sylpheed2-mainwindow.png
> > 
> > Try to find the subject in that nonsense.  Same for everyone else on
> > email as well.
> > 
> > https://marc.info/?l=linux-kernel&m=163120404328790&w=2
> > 
> > I only either read the subject or the body of the commit message and
> > never both.  :P
> 
> I read the body if the subject looks relevant ;)
> 
> But that subject reads to me as "rapidio: Avoid bogus *blah* warning". 
> We have soooooo many alloc_foo functions that one's eyes glaze over
> something like "alloc_size"
> 
> Why?  Because the identifier "__alloc_size" is of great significance
> to Kees because he wrote the thing.  Everyone else just sees "*blah*".

Heh. Okay, fair enough. I will make Subject/body independent. It felt
redundant to me before, but greater verbosity is a good idea. Sorry!

-- 
Kees Cook
