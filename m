Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A283E8502
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhHJVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhHJVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:14:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5DC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:14:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso1099619pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1u6RP4tYgkicNkbD7E5xzCbsRTVgsebfr8s8lIzCzCg=;
        b=tXMBWTeaimS/JlofeHyuK9xWY754mFg1gybzHvOIYqz6LMRt6a+uDYUIdCgNtb2B3w
         v653MzDIfmHWIUVWeJXr0L/SaqrKJBfmPVXHuNLCUEsGS81+0oiTlPoYUIIDvMg4/q7C
         tALSiM0UMtKaJzvPk+64hCE6HVl/zcWSnogXi2SW8SltPhtjoZ2kd0MOU0rn662O7qBA
         Kst1Bw54ldFQJOP1MQxexb/npfe/vDm/hFRpQitnlDQJnE9gXIIXhOOdOStfA6JBkXNO
         8O83T8E3E5i7hGC5N8vKC8MlEhvpWy1ZEscYVwytjMH8r7vQIqTN2RB+jSqcc6DrEUGQ
         KITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1u6RP4tYgkicNkbD7E5xzCbsRTVgsebfr8s8lIzCzCg=;
        b=cXHwFpWqQPpKHeZHy6RBY7AfnMx8ya9EL9CB38NZoBIX/VhEkx1KzRf2bf2rb9gFb7
         bqGqmVBghXQvf78HqL678nnlbLRoaV6CKOsg4uOVWi8d66ksb3GgS7eBl2ov+rWXmfYg
         fIFWHLeaqJzwGL8i+eE3h9G5QAb4iDe/AXWBHpcRetAezPNACHqlxZOE7cco+VqqiBxO
         jxqFvVN1LYpn7/Q19N5rZ26F8Ob8INaDOHYRhDOMcg3Ron8SJY+Kd21Yx5SHAiYl5c+u
         q3Bgl1NNi9rlXNvqpi9JWzggvPtqegLuCIumJuCdpEusKJB96IwqhVzkrzxgw7Ayk2ak
         xmEg==
X-Gm-Message-State: AOAM533S6PLxmeH1vWXbKwOcq8YqZKokdU60eCF+Ah7UYPqW8ncbaPMA
        9Sqnzat3ZJeTESWxXcXknZQ=
X-Google-Smtp-Source: ABdhPJyEAUdOQDi/vaOTpEJ37a8gTJO4968lxzqOP812SYSlpKAlOFNrR+hUtBQgrQ9Kmq3r3jp44w==
X-Received: by 2002:a17:90b:3802:: with SMTP id mq2mr17824574pjb.19.1628630042687;
        Tue, 10 Aug 2021 14:14:02 -0700 (PDT)
Received: from localhost (g195.61-45-49.ppp.wakwak.ne.jp. [61.45.49.195])
        by smtp.gmail.com with ESMTPSA id l14sm25978852pfd.58.2021.08.10.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:14:01 -0700 (PDT)
Date:   Wed, 11 Aug 2021 06:13:59 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] openrisc: Fix compiler warnings in setup
Message-ID: <YRLsF2J9KHb9F1BV@antec>
References: <20210805030035.2994973-1-shorne@gmail.com>
 <20210809013128.GA3698029@roeck-us.net>
 <0a3de28d-17d5-ec22-0ffb-97f5ca11c127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3de28d-17d5-ec22-0ffb-97f5ca11c127@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 07:28:38PM -0700, Randy Dunlap wrote:
> On 8/8/21 6:31 PM, Guenter Roeck wrote:
> > On Thu, Aug 05, 2021 at 12:00:33PM +0900, Stafford Horne wrote:
> > > This was pointed out with the recent name change of or32_early_setup to
> > > or1k_early_setup.  Investigating the file I found a few other warnings
> > > so cleaning them up here.
> > > 
> > >      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
> > >        220 | void __init or1k_early_setup(void *fdt)
> > > 	  |             ^~~~~~~~~~~~~~~~
> > > 
> > > Fix this the missing or1k_early_setup prototype warning by adding an
> > > asm/setup.h file to define the prototype.
> > > 
> > >      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
> > >        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> > > 	  |             ^~~~~~~~~~~~~~~~~~
> > > 
> > > The function detect_unit_config is not used, just remove it.
> > > 
> > >      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> > > 
> > > Add @fdt docs to the function comment to suppress this warning.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > 
> > Puzzled. This patch gives me:
> 
> Stafford posted a v2 earlier today:
> https://lore.kernel.org/lkml/20210808135437.3640549-1-shorne@gmail.com/

Yes, thanks for pointing this out.  I found why I missed this in v1,  basically
I failed to miss this using my local build and my CI service on travis seems to
have been stopped.  I have switched to use github actions for CI.

For my local build I will need to watch more carefully.

-Stafford

> > Building openrisc:or1ksim_defconfig ... failed
> > ------------
> > Error log:
> > In file included from ./arch/openrisc/include/asm/page.h:35,
> >                   from ./include/linux/generic-radix-tree.h:39,
> >                   from lib/generic-radix-tree.c:3:
> > ./arch/openrisc/include/asm/setup.h:11:13: error:
> > 		expected '=', ',', ';', 'asm' or '__attribute__' before 'or1k_early_setup'
> >     11 | void __init or1k_early_setup(void *fdt);
> >        |             ^~~~~~~~~~~~~~~~
> > make[1]: *** [scripts/Makefile.build:272: lib/generic-radix-tree.o] Error 1
> > 
> > Bisect log attached for completeness.
> 
> That needs #include <linux/init.h>
> 
> -- 
> ~Randy
> 
