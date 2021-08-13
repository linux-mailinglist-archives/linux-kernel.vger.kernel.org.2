Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA00C3EB268
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhHMIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhHMIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:15:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F45C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:14:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t66so9929470qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=nmbUvnf/USoc9AmsYZayjj+Bsv4n/4XSVzeQZeHCY/w=;
        b=VY3rnbKfC6IyMIF2mQCvcO3/p1MrleXlgTgNxeWSBXT9iJw3CBZFN3z2XXGgMQdSbI
         TbqHQUQPUP7CY43Yx06VPYqyrcoeX6o8i3UnYo9aW/VkFIG3dcJNQ1ake9dlvnaXDbi8
         SyIoqLR1GG5fX1OKF/8NeJmGX2XBjM/XQfF3V0w25q/RUbd7NYlx0dvdN/LhjAbc2BbU
         py1wKpcYHDd8ZwuXMSQiYQljbWcfItimubLcy3OW6L9QmMoYNG0IXQwP7I9gox6ywe60
         YilRF+Ku5B+cO+nXNL2prqfMW1kLH8TIzekXuxCr2q7JdzMwExtofJOvTDb55Rr/USlZ
         wfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=nmbUvnf/USoc9AmsYZayjj+Bsv4n/4XSVzeQZeHCY/w=;
        b=ZD25x3hYLZ+xFos81hy615to72vAmLCWx0LgOl6JEn/yfeK1ZUjk/DRXrjchNf74ik
         0NC8hWqDi6titJ3qS8uT2zqCC1cjFs6w14TPKK+UoXTJ3sWvOdnOiCVmXU845JHRsYRa
         hP0i0fLXknqL3Cf79tpgddi7En4Tm73tBtxpQDEoBXdn7vq2sxkbG522Wz5KhObgd0Ae
         BUXTXE/hsktHVnCGcaBgrjJwVsv/tWzj9+hFW68t97Iz5U0BE0ekK1nQjHFGdql+jJNx
         sG4LsuRQ+Z4Wpt8MHBminBIV0jdCG289hOKD5Na3EHkJVXu4AcVwsr0DrDVz+8RZRZ9E
         v0Hw==
X-Gm-Message-State: AOAM5300qo3PrxDR6DgJkwTOZ6Dod2V+VWMGKEVlgFqFOuSMLoXeLuhO
        wgalpcXYoq3ea0CU7J7KOkE=
X-Google-Smtp-Source: ABdhPJy5IJcev/70U0W5olAYgc/Xqjg6SLl1FzSP3Q2Gzhie+jQp3XWe3d9tZt0n0JnKtppozgum3A==
X-Received: by 2002:a05:620a:1722:: with SMTP id az34mr900560qkb.115.1628842498132;
        Fri, 13 Aug 2021 01:14:58 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id q184sm505955qkd.35.2021.08.13.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:14:57 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        =?UTF-8?q?=20Valdis=20Kl=C4=93tnieks=20?= <valdis.kletnieks@vt.edu>,
        "SeongJae Park" <sjpark@amazon.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re:
Date:   Fri, 13 Aug 2021 08:14:52 +0000
Message-Id: <20210813081452.34784-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210812131921.a1c5c85213290e1729cc72a3@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 12 Aug 2021 13:19:21 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 12 Aug 2021 09:42:40 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > > +config PAGE_IDLE_FLAG
> > > +       bool "Add PG_idle and PG_young flags"
> > > +       help
> > > +         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> > > +         Accessed bit writers can set the state of the bit in the flags to let
> > > +         other PTE Accessed bit readers don't disturbed.
> > > 
> > > This needs to be converted to proper, or at least comprehensible, English....
> > 
> > Thank you for the comment.
> > 
> > How about below?
> > 
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -743,9 +743,9 @@ config PAGE_IDLE_FLAG
> >         bool "Add PG_idle and PG_young flags"
> >         select PAGE_EXTENSION if !64BIT
> >         help
> > -         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> > -         Accessed bit writers can set the state of the bit in the flags to let
> > -         other PTE Accessed bit readers don't disturbed.
> > +         This feature adds 'PG_idle' and 'PG_young' flags in 'struct page'.
> > +         PTE Accessed bit writers can save the state of the bit in the flags
> > +         to let other PTE Accessed bit readers don't get disturbed.
> 
> How about this?
> 
> --- a/mm/Kconfig~mm-idle_page_tracking-make-pg_idle-reusable-fix-fix
> +++ a/mm/Kconfig
> @@ -743,9 +743,9 @@ config PAGE_IDLE_FLAG
>  	bool "Add PG_idle and PG_young flags"
>  	select PAGE_EXTENSION if !64BIT
>  	help
> -	  This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> -	  Accessed bit writers can set the state of the bit in the flags to let
> -	  other PTE Accessed bit readers don't disturbed.
> +	  This adds PG_idle and PG_young flags to 'struct page'.  PTE Accessed
> +	  bit writers can set the state of the bit in the flags so that PTE
> +	  Accessed bit readers may avoid disturbance.
>  
>  config IDLE_PAGE_TRACKING
>  	bool "Enable idle page tracking"

So good, thank you!

> 
> Also, is there any way in which we can avoid presenting this option to
> the user?  Because most users will have real trouble understanding what
> this thing is for.  Can we simply select it when needed, as dictated by
> other, higher-level config options?

I believe this is the right way to go!  I sent a patch for removing the prompt
of this option:
https://lore.kernel.org/linux-mm/20210813081238.34705-1-sj38.park@gmail.com/


Thanks,
SeongJae Park
