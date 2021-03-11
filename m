Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF23374CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhCKN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:58:47 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:40477 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhCKN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:58:35 -0500
Received: by mail-pj1-f42.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so9108305pjq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IwVA9MD69i7zzeIVaDA8v+fpntKkKR+e2DISxwYyVTA=;
        b=tvu+paATl9o6NpAH07tZ2zZbzn6hny/rCAnK7ZlQMO3FRfHIj1+2eGffa7MtciNxyO
         M9gxB6FqOS9KSmKUNLCfhQJvE/ZndIFbh6eDTG563sPgrxQylOQGQihHGXSEPugw3B0e
         RPx+7MkCZHbt7v2McjSU3JqArgGFCEFRRgClt6D5IB7Q5FhyoMnhZYHced1NDAmZ6Tfe
         RdmDrnBNlmqY/7LfNxx26y32cZqTzZerd0PjJVYVM6/s5jREUsN1GSCMAnGzBy7YMJum
         Y6vENHV4XO/9aC1jqTbU0I648LQzNnEnjTssxoiLTPJubYwvI9RBB48qJw9R/BBBMIMT
         h7BQ==
X-Gm-Message-State: AOAM5328x/pMeKP5JS4JhZm9pWdjLgA6skywGC9zZsTW4tonE0Ji+2ZN
        VRk8AoGcpTq56+sEVBUqi5g=
X-Google-Smtp-Source: ABdhPJzvfdYVR0x4ac3M8dLwlUMKy1MA+9cIi1EwecUkoLt+H2+keQX279Vm+THPizElkkQVxcaEcw==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr8760472pjy.42.1615471115495;
        Thu, 11 Mar 2021 05:58:35 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d22sm2207485pfn.25.2021.03.11.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:58:34 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2D87B4024E; Thu, 11 Mar 2021 13:58:33 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:58:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lyl2019@mail.ustc.edu.cn
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] lib/test_kmod: Fix a use after free in
 register_test_dev_kmod
Message-ID: <20210311135833.GT4332@42.do-not-panic.com>
References: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
 <20210311130108.GS4332@42.do-not-panic.com>
 <17bb31cd.cc46.178217c9344.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17bb31cd.cc46.178217c9344.Coremail.lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:31:55PM +0800, lyl2019@mail.ustc.edu.cn wrote:
> 
> 
> 
> > -----原始邮件-----
> > 发件人: "Luis Chamberlain" <mcgrof@kernel.org>
> > 发送时间: 2021-03-11 21:01:08 (星期四)
> > 收件人: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > 抄送: linux-kernel@vger.kernel.org
> > 主题: Re: [PATCH] lib/test_kmod: Fix a use after free in register_test_dev_kmod
> > 
> > On Thu, Mar 11, 2021 at 12:02:46AM -0800, Lv Yunlong wrote:
> > > In register_test_dev_kmod, it calls free_test_dev_kmod() to free
> > > test_dev. But free_test_dev_kmod() can't set the original pointer
> > > test_dev to NULL, because the test_dev was passed by it's value
> > > not reference.
> > 
> > Did you actually get a crash or something? If so can you supply the
> > actual log? If this is just an observation and you think this is an
> > issue, specifying that would help during patch review.
> > 
> >   Luis
> > 
> > > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > > ---
> > >  lib/test_kmod.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> > > index 38c250fbace3..aa8a2a563d7e 100644
> > > --- a/lib/test_kmod.c
> > > +++ b/lib/test_kmod.c
> > > @@ -1124,7 +1124,6 @@ static void free_test_dev_kmod(struct kmod_test_device *test_dev)
> > >  		free_test_dev_info(test_dev);
> > >  		kmod_config_free(test_dev);
> > >  		vfree(test_dev);
> > > -		test_dev = NULL;
> > >  	}
> > >  }
> > >  
> > > @@ -1149,6 +1148,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
> > >  	if (ret) {
> > >  		pr_err("could not register misc device: %d\n", ret);
> > >  		free_test_dev_kmod(test_dev);
> > > +		test_dev = NULL;
> > >  		goto out;
> > >  	}
> > >  
> > > -- 
> > > 2.25.1
> > > 
> > > 
> 
> This problem was reported by source code analyzers developed by our Security Lab(Loccs).

This should be included in the commit log, please.

> We have confirmed this issue before submiting the patch.

How was this confirmed exactly.

  Luis
