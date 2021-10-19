Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABAC432B79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 03:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhJSBYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 21:24:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB1C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 18:22:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e65so15442914pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+YOaBslX4qQWuo6l9MyOOELjnCnQrK4/rjlKQ4on+uI=;
        b=PAoteaNB2U05XT9NzhUNZ8BfJ9IGdDGJbFqsLK5aGtRwHISTazk1CdeqfRIo2CsZAI
         pXL36igTTnJZd6SD+X6X31806gm5WTTOwqoTbCc33Hmk3K16e59AuaYmdasS6cLn0dlM
         yekdCRME2oRJsXVp55esvuVkOWF4smz9ZaSnycj1WIRGNT1XWurSTvuzc9gv13FmcEDR
         RB8823pD6E09XjA6Xf2Enk3MJy3q7gwQjwI83eIbAB8DPVVYsOck8j1BxPhvFnA/AAmI
         8CBbfQMmwj4wZg12thf/1n4J/IkKnY/61Ehywa+FVVl2ECG0wasuRlHwNY7T3f0pzPmc
         L/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YOaBslX4qQWuo6l9MyOOELjnCnQrK4/rjlKQ4on+uI=;
        b=XyKtMcezECbRX6OByynNkp92QeOf2cSSNc13x/Bn5MyAXLbyvE+Ju80VkoAlMFOeP8
         qeOpPS5s3XjLZAPfrpRtzzcSxCCiilj+khEpbFUb3Vc5+47kczrFcYcPu2FqRG0oTtlq
         moEUoi4r5mslXkbyvqdSB0p+zX45rm1sZluyOmJWvIcpQKgjy4inD372A70EM228E5kb
         WMKoKJk+YuVH4+JnERwARH6AfeP6IW1featxxBNnqZWYkstox5lxv7sNUR54VNk89Out
         la7bJtC2xyd+cVNcbxxpUj1JwIy1an8xxP51wvz5pGLzqHFAZ+Dmq0F2dtuEsuW9ygNQ
         Vz8w==
X-Gm-Message-State: AOAM532tKDb2B5srR2/vRgJeF2xJmr5LyFnRwfZDnSLuyiniSSFxQitw
        fBMDYp9d8qVNBOg80FFkqoE=
X-Google-Smtp-Source: ABdhPJx/gurImig6XRrgeoEO/r7wyQ5O40+HcN6GJkbcox6Gf8TSIr+7QFKlwoYAMkAlcDAZ7Yn1TQ==
X-Received: by 2002:a63:1444:: with SMTP id 4mr26015024pgu.251.1634606551172;
        Mon, 18 Oct 2021 18:22:31 -0700 (PDT)
Received: from nuc10 (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id v9sm14748903pfc.23.2021.10.18.18.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 18:22:30 -0700 (PDT)
Date:   Mon, 18 Oct 2021 18:22:28 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
Subject: Re: [PATCH] slob: add size header to all allocations
Message-ID: <YW4d1FppmaqAuPHd@nuc10>
References: <20211015005729.GD24333@magnolia>
 <20211018033841.3027515-1-rkovhaev@gmail.com>
 <20758764-8139-ab0b-a782-dc63559b43ba@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20758764-8139-ab0b-a782-dc63559b43ba@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:22:46AM +0200, Vlastimil Babka wrote:
> On 10/18/21 05:38, Rustam Kovhaev wrote:
> > Let's prepend all  allocations of (PAGE_SIZE - align_offset) and less
> > with the size header. This way kmem_cache_alloc() memory can be freed
> > with kfree() and the other way around, as long as they are less than
> > (PAGE_SIZE - align_offset).
> 
> This size limitation seems like an unnecessary gotcha. Couldn't we make
> these large allocations in slob_alloc_node() (that use slob_new_pages()
> directly) similar enough to large kmalloc() ones, so that kfree() can
> recognize them and free properly? AFAICS it might mean just adding
> __GFP_COMP to make sure there's a compound order stored, as these already
> don't seem to set PageSlab.

Thanks for the pointers, I'll send a new version.

> > The main reason for this change is to simplify SLOB a little bit, make
> > it a bit easier to debug whenever something goes wrong.
> 
> I would say the main reason is to simplify the slab API and guarantee that
> both kmem_cache_alloc() and kmalloc() can be freed by kfree().
> 
> We should also update the comments at top of slob.c to reflect the change.
> And Documentation/core-api/memory-allocation.rst (the last paragraph).

OK, thank you!

> > meminfo right after the system boot, without the patch:
> > Slab:              35500 kB
> > 
> > the same, with the patch:
> > Slab:              36396 kB
> 
> 2.5% increase, hopefully acceptable.
> 
> Thanks!
